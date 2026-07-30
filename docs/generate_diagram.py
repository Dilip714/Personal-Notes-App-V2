from diagrams import Diagram, Cluster, Edge
from diagrams.aws.compute import EC2
from diagrams.aws.network import VPC, InternetGateway, RouteTable, Endpoint
from diagrams.aws.storage import S3
from diagrams.onprem.vcs import Github
from diagrams.onprem.ci import GithubActions
from diagrams.onprem.container import Docker
from diagrams.onprem.client import Users
from diagrams.k8s.compute import Pod
from diagrams.k8s.network import Service as K8sService

with Diagram(
    "Personal Notes App - End-to-End DevOps Architecture",
    filename="architecture",
    outformat="png",
    show=False,
    direction="LR",
):
    laptop = Users("Developer Laptop")

    with Cluster("GitHub"):
        repo = Github("Repository")
        actions = GithubActions("GitHub Actions\n(CI/CD)")

    dockerhub = Docker("Docker Hub\n(image registry)")

    with Cluster("Minikube Cluster (local)"):
        pod = Pod("notes-app Pods")
        svc = K8sService("NodePort Service")

    with Cluster("AWS Region"):
        with Cluster("VPC 10.0.0.0/16"):
            igw = InternetGateway("Internet\nGateway")

            with Cluster("Public Subnet AZ1 / AZ2"):
                pub_rt = RouteTable("Public RT")

            with Cluster("Private Subnet AZ1 / AZ2"):
                ec2 = EC2("EC2 App Server\n(no public IP)")
                priv_rt = RouteTable("Private RT")

            endpoint = Endpoint("Gateway VPC\nEndpoint (S3)")

        bucket = S3("S3 Bucket\n(static assets, versioned)")

    # Dev workflow
    laptop >> Edge(label="git push") >> repo
    repo >> actions
    actions >> Edge(label="build & push image") >> dockerhub
    actions >> Edge(label="test") >> pod

    # Local k8s demo
    dockerhub >> Edge(label="docker pull") >> pod
    pod >> svc

    # AWS deployment
    dockerhub >> Edge(label="docker pull (Terraform user_data)", style="dashed") >> ec2
    igw >> pub_rt

    ec2 >> priv_rt
    priv_rt >> Edge(label="S3 route via endpoint\n(no NAT, no IGW)", color="darkgreen") >> endpoint
    endpoint >> bucket
