
# 23 Degrees App

This application is used to reproduce the problem the company 23 Degrees faces with the rolling updates deployment strategy.

This project was generated with Angular CLI version 16.0.0.

## Installation
All the following commands are executed in Ubuntu 20.04 terminal.

###  Creating the front end application

1. Installing the Angular CLI: `npm install -g @angular/cli`
2. Creating the new angular application: `ng new 23_degrees_app`
3. Setting the application to run in SSR mode. In the parent directory execute: `ng add @nguniversal/express-engine`
4. Build the application: `ng build`
5. Run the application: `npm run serve:ssr`


### Creating the K3d cluster

1. installing K3d: `curl -s https://raw.githubusercontent.com/rancher/k3d/main/install.sh | bash`
2. Creating the K3d cluster: `k3d cluster create my-cluster --agents 2 --servers 1`


### Setting up Kubernetes Dashboard

1. installing the dashboard: `kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.7.0/aio/deploy/recommended.yaml`
2. Applying the admin-user.yaml: `kubectl apply -f ./_monitoring/admin-user.yaml`
3. Applying the cluster-role-binding.yaml: `kubectl apply -f ./_monitoring/cluster-roll-binding.yaml`
4. Applying the long-lived-token.yaml: `kubectl apply -f ./_monitoring/long-lived-token.yaml`
4. Creating secret token to communicate with the Kubernetes Dashboard `kubectl get secret admin-user -n kubernetes-dashboard -o jsonpath={".data.token"} | base64 -d`

### Deployment

1. Applying the app-service.yaml: `kubectl apply -f ./_kubernetes/app-service.yaml`
2. Applying the rolling-update-deployment.yaml: `kubectl apply -f ./_kubernetes/rolling-update-deployment.yaml`
3. Applying the recreate-deployment.yaml: `kubectl apply -f ./_monitoring/recreate-deployment.yaml`
4. Installing istio: `curl -sL https://istio.io/downloadIstioctl | sh -`
5. Exporting the environment variable: `export PATH=$HOME/.istioctl/bin:$PATH`
6. Installing the istio service wiht the default configuration profile: `istioctl install --set profile=default`
7. Applying the virtual-service.yaml: `kubectl apply -f ./_kubernetes/virtual-service.yaml`
8. Applying the destination-rule.yaml: `kubectl apply -f ./_kubernetes/destination-rule.yaml`


# kubectl Commands
+ Pods information: `watch kubectl get pods`