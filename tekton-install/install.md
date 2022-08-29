install tekton-
```
kubectl apply --filename https://storage.googleapis.com/tekton-releases/pipeline/latest/release.yaml
```
Install tekton dashboard
kubectl apply --filename https://storage.googleapis.com/tekton-releases/dashboard/latest/tekton-dashboard-release.yaml
Get the service for tekton dashboard --
kubectl get svc tekton-dashboard -n tekton-pipelines

To access the dashboard service by having a mere port -forward -
kubectl port-forward -n tekton-pipelines --address=0.0.0.0 service/tekton-dashboard 80:9097 > /dev/null 2>&1 &
To access the dashboard from outside , create a ingress 
kubectl apply -f tekton-dashboard-ingress.yaml -n tekton-pipelines 