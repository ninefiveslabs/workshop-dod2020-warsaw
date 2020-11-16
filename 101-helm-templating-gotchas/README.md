## Common and nasty problems that may arise because of text-based approach to data structure templating in Helm

In this part we'll show some common and nasty problems that may arise because of text-based approach to data structure templating in Helm.
In each folder, inspect the Helm template and perform the following commands to see what kind of error message will appear:
```
helm lint .
helm template --debug .
helm delete -n tanka-workshop tanka-workshop;  helm upgrade --dry-run -n tanka-workshop --install tanka-workshop .
helm delete -n tanka-workshop tanka-workshop;  helm upgrade -n tanka-workshop --install tanka-workshop .
```

To set the namespace permanently, use this command:
```
kubectl create ns tanka-workshop
kubectl config set-context --current --namespace=tanka-workshop
```

**Example 1_syntax_error:** YAML syntax error

A mistake in indentation causes the manifest to be a malformed YAML (mixed map and array syntax on the same level). This type of error can be caught by the `helm lint` and `helm template` commands.


**Example 2_k8s_error:** YAML, templates, Go and type conversion

In this example we'll use the simplest possible Pod manifest that includes a "version" label. The value of the label is read from the `values.yaml` file. Since we know that Kubernetes requires label values to be strings, we quote the version number and expect it to preserve the type during templating. This chart passes the `helm lint` and `helm template` tests, producing a valid YAML document. However, when we attempt to install it on our cluster, Kubernetes rejects the manifest due to invalid value type:

```
Error: unable to build kubernetes objects from release manifest:
unable to decode "": resource.metadataOnlyObject.ObjectMeta: v1.ObjectMeta.Name: Labels: ReadString: 
expects " or n, but found 1, error found in #10 byte of ...|version":1},"name":"|...,
bigger context ...|v1","kind":"Pod","metadata":{"labels":{"version":1},"name":"type-mismatch-pod"},"spec":{"containers"|...
```

To fix this, we need to explicitly quote the rendered value (preferably using the `quote` builtin templating function).

**Example 3_merges_and_ghosts:** Duplicate map keys

In this example we'll go one step further: we'll produce a valid YAML document and successfully install it onto the cluster. However, the resulting object will contain some mismatched configuration due to a mistake in indentation. This example is similar to #1, but the mistake goes unnoticed by overwriting a part of configuration on a higher level in the YAML structure. In YAML, if a key exists twice in a map, the latter value overwrites the former one.
