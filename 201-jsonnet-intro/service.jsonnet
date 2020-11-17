local config = import "config.jsonnet";

{
  apiVersion: 'v1',
  kind: 'Service',
  metadata: {
    name: config.name,
    labels: config.labels,
  },
  spec: {
    type: 'ClusterIP',
    ports: [
      {
        port: 80,
        targetPort: 8080,
      },
    ],
    selector: config.selector,
  },
}
