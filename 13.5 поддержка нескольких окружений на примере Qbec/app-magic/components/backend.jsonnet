
local p = import '../params.libsonnet';
local params = p.components.backend;
[
  {
    apiVersion: 'apps/v1',
    kind: 'Deployment',
    metadata: {
      name: 'backend',
      labels: {
        app: 'backend',
      },
    },
    spec: {
      replicas: params.replicas,
      selector: {
        matchLabels: {
          app: 'backend',
        },
      },
      template: {
        metadata: {
          labels: {
            app: 'backend',
          },
        },
        spec: {
          containers: [
            {
              name: 'backend',
              image: 'bitnami/prometheus',
            },
          ],
        },
      },
    },
  },
  {
   "apiVersion": "v1",
   "kind": "Service",
   "metadata": {
      "name": "backend",
      "labels": {
         "app": "backend"
      }
   },
   "spec": {
      "type": "ClusterIP",
      "ports": [
         {
            "targetPort": 9090,
            "port": 9090
         }
      ],
      "selector": {
         "app": "backend"
      }
    }
  },
]
