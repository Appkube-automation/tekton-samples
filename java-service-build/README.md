Kaniko needs the docker registry creds etc to push the docker image. We can pass that as a kubernetes 
secret object and kanio can use that.

To create secret for docker registry --


Get your docker registry user and password encoded in base64

echo -n USER:PASSWORD | base64
Create a config.json file with your Docker registry url and the previous generated base64 string

{
  "auths": {
    "https://index.docker.io/v1/": {
      "auth": "xxxxxxxxxxxxxxx"
    }
  }
}


You can loaclly run kaniko as docker to test that push works perfectly as follows:

docker run -ti --rm -v `pwd`:/workspace -v `pwd`/config.json:/kaniko/.docker/config.json:ro gcr.io/kaniko-project/executor:latest --dockerfile=Dockerfile --destination=yourimagename

If locally that is running - then u can create the secret in k8s as follows:

kubectl create secret generic kaniko-secret --from-file=<path to kaniko-secret.json>

The pipelinerun access this secret from the workspace as follows:
 workspaces:
  - name: dockerconfig-secret
    secret:
      secretName: kaniko-secret

