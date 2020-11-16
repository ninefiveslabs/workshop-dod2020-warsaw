# DevOps Days 2020 Warsaw - Tanka workshop

This repo contains instructions for a technical workshop about the [Tanka](https://tanka.dev) tool.

To effectively take part in the workshop, all you really need is a computer with Docker installed. We will provide a container with all the tools that you might need and instructions for installation if you want to have tools installed locally.
We will be using a Kubernetes cluster created using kind, but you can use your own cluster, too.

# Prerequisites
To be able to complete the tasks in this guide, you need to have access to an internet-connected Linux machine with Docker installed. We will be using the following tools: Bash, Docker, Tanka, Helm, Kind, Kubernetes. Only Bash and Docker are required upfront, all the other tools will be downloaded, installed and configured during the workshop.

If you are working on Windows, the recommended way to set up a working environment is to use Vagrant and VirtualBox.

# Workshop agenda

0. [Setting up the environment](002-environment-setup/README.md)
1. [Helm templating gotchas](101-helm-templating-gotchas/README.md)
2. Intro to [Jsonnet](201-jsonnet-intro/README.md) and [Tanka](202-tanka-intro/README.md)
3. [Re-using and patching Helm charts in Tanka](301-tanka-helm-integration/README.md)
4. Some downsides of Jsonnet
5. Other tools that use Jsonnet

For the technical part (sections 0-3), the instructions can be found in the respective directories, numbered according to the agenda.
The slides which cover the non-workshop part can be found [here](001-slides/slides.md).
