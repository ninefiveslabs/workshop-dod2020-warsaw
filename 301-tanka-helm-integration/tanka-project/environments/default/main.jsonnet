local helm = (import "github.com/grafana/jsonnet-libs/helm-util/helm.libsonnet").new(std.thisFile);

local original = helm.template("keycloak", "./keycloak", {
    namespace: "monitoring",
    values: {
      keycloak: {ingress: {enabled: true}}
    }
  });

local fix_ingress_path(path) = (if 'serviceName' in path.backend then path + {
    pathType: 'Prefix',
    backend: {
        service: {
            name: path.backend.serviceName,
            port: {
                name: path.backend.servicePort
            }
        }
    }
});
local fix_ingress_rule(rule) = ( rule + {http: {paths: std.map(fix_ingress_path, rule.http.paths) }} );
local mangle(obj) = ( if obj.kind == 'Ingress' && obj.apiVersion == 'extensions/v1beta1' then { apiVersion: 'networking.k8s.io/v1', spec: {rules: std.map(fix_ingress_rule, obj.spec.rules) }} else {} );
#local mangle(obj) = {};

{
    meta: {
        namespace: {
            apiVersion: "v1",
            kind: "Namespace",
            metadata: {
                name: "demo"
            }
    },
    keycloak: std.mapWithKey(function(key, value) value + mangle(value), original) }
}
