local helm = (import "github.com/grafana/jsonnet-libs/helm-util/helm.libsonnet").new(std.thisFile);

{
  keycloak: helm.template("keycloak", "./keycloak", {
    namespace: "keycloak",
    values: {
      keycloak: {ingress: {enabled: true}}
    }
  })
}
