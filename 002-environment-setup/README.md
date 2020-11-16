# Setting up the environment

## Short story
```
git clone https://github.com/ninefiveslabs/workshop-dod2020-warsaw.git
cd workshop-dod2020-warsaw/
./002-environment-setup/run-toolbox-container.sh

kind create cluster --name workshop

```

## Long story

We prepared a container image with all the tools required to run the examples.
You'll find there:

- kind (*K*ubernetes *in* *D*ocker) for running local Kubernetes clusters
- Helm
- Tanka (`tk`)
- Jsonnet interpreter and formatter (`jsonnet` and `jsonnetfmt`)
- Jsonnet bundler (Jsonnet dependency manager)
- `jq` and `yq` tools for manipulating JSON and YAML files on the CLI

The intended way to run the image is to execute it as a disposable container, mount all the required files and spawn a shell to work with the examples.

If you want to install the tools on your own, see the Dockerfile for detailed commands to run.

Disclaimer: this approach (treating a container as a VM, running a shell within it and mounting the Docker socket to work with other containers) it is not a best practice for everyday activities, but let's use it as a convenience for the sake of this training.

The steps for setting up your temporary Kubernetes cluster and getting a shell with all the necessary tools:

1. Clone the repo with workshop instructions (you are viewing it now):
```
git clone https://github.com/ninefiveslabs/workshop-dod2020-warsaw.git
```
2. Cd into the repo directory:
```
cd workshop-dod2020-warsaw/
```
3. Run the container wrapper script. It will start a disposable container with all the tools required for the workshop and get you a shell inside it:
```
./002-environment-setup/run-toolbox-container.sh
```
4. Try running the following commands to see if evertyhing is working:
```
kubectl
helm
tk
jsonnet
docker
```
5. Now it's time to spin up our temporary Kubernetes cluster:
```
kind create cluster --name workshop
```
6. In case you ever exit your container, start it again and run the following commands to restore the kubeconfig file needed by kubectl and other tools:
```
mkdir /root/.kube
kind get kubeconfig --name dod-workshop > /root/.kube/config
```
