local config = import "config.jsonnet";

{
  apiVersion: 'apps/v1',
  kind: 'Deployment',
  metadata: {
    name: config.name,
    labels: config.labels,
  },
  spec: {
    replicas: 3,
    selector: {
      matchLabels: config.selector,
    },
    template: {
      metadata: {
        labels: config.selector,
      },
      spec: {
        containers: [
          {
            name: 'hello-kubernetes',
            image: 'paulbouwer/hello-kubernetes:1.8',
            ports: [
              {
                containerPort: 8080,
              },
            ],
          },
        ],
      },
    },
  },
}
