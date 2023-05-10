# Install k3d
curl -s https://raw.githubusercontent.com/rancher/k3d/main/install.sh | bash


# Create local Kubernetes cluster
k3d cluster create my-cluster


# Cluster information
kubectl cluster-info