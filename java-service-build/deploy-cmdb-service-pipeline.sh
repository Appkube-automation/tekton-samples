#! /bin/sh
# This script
installs all prerequisites for cmdb service deployment pipeline

echo Add all task
kubectl apply -f tasks/git-clone-task.yaml -n tekton-pipelines
kubectl apply -f tasks/build-maven-task.yaml -n tekton-pipelines
kubectl apply -f tasks/build-kaniko-task.yaml -n tekton-pipelines
kubectl apply -f tasks/aws-cli.yaml -n tekton-pipelines
kubectl apply -f tasks/helm-install-from-repo.yaml -n tekton-pipelines

echo Add some sample task runs to repo
kubectl create -f tasks/run-aws-cli.yaml -n tekton-pipelines
kubectl apply -f tasks/run-git-clone-task.yaml -n tekton-pipelines

# Add docker secret for continer push to docker hub
#todo
kubectl create -f tasks/smoke-aws-secret.yaml -n tekton-pipelines

# Add aws secret for kubectl configuration for EKS
#todo

echo Add the pipeline
kubectl apply -f pipelinerun/build-service.yaml -n tekton-pipelines


# Cleanup commands
# kubectl delete secret smoke-aws-credentials -n tekton-pipelines
