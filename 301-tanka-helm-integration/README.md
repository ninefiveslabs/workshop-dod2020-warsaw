# Tanka Helm integration

In this part we will demonstrate how Tanka integrates with Helm. This integration allows to use pre-existing Helm charts and load them into Tanka.
You can then deploy them along with other Jsonnet-only resources or modify the rendered Helm manifests using Jsonnet operations.

We will use the (Keycloak chart)[https://github.com/helm/charts/tree/master/stable/keycloak] as an exaple.
First, we will render it and load the resources into Tanka.
Then we will show how to manipulate the Helm-generated resources using Jsonnet (without modifying the chart itself).
This is useful when you want to use an existing chart and you need to change it, but you don't want to maintain a separate fork of the original.

The example is based on the official [Tanka Helm documentation](https://tanka.dev/helm).
