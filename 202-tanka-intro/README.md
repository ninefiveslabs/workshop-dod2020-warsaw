# 102: Tanka Intro

## Expected results

1. You can initialize tanka-based application
2. You understand how to model your environments
3. You know how to reuse your code using libraries.

## Tasks

1. Create a tanka-based application (`tk init`). Take a look around!
  * `jsonnetfile.json` and `jsonnetfile.lock.json` are used by jsonnet-bundler (jsonnet package manager)
  * `lib/` contains project-scoped libraries.
  * `vendor/` contains external dependencies, pulled via `jsonnet-bundler`.
2. Update your environments spec file `environments/default/spec.json` to point to your Kubernetes cluster.
  * Get the address using `kubectl cluster-info`.
3. Add your previously created components to the default environment
  * your "entrypoint" is the `environments/default/main.jsonnet` file.
  * Try to add them inline first, then move to `lib` directory
4. Rewrite `Service` object to use the default tanka library - `k`.