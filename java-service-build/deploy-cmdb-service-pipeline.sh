#! /bin/sh
# This script installs all prerequisites for cmdb service deployment pipeline

# Add all task
kubectl -f tasks/git-clone-task.yaml -n tekton-pipelines
kubectl -f tasks/build-maven-task.yaml -n tekton-pipelines
kubectl -f tasks/build-kaniko-task.yaml -n tekton-pipelines
kubectl -f tasks/aws-cli.yaml -n tekton-pipelines
kubectl -f tasks/helm-install-from-repo.yaml -n tekton-pipelines

# Add some sample task runs to repo
kubectl -f tasks/run-aws-cli.yaml -n tekton-pipelines
kubectl -f tasks/run-git-clone-task.yaml -n tekton-pipelines

# Add docker secret for continer push to docker hub
#todo

# Add aws secret for kubectl configuration for EKS
#todo
