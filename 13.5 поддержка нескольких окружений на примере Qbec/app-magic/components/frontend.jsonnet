local p = import '../params.libsonnet';
local params = p.components.frontend;
[
  {
    apiVersion: 'v1',
    kind: 'ConfigMap',
    metadata: {
      name: 'frontend',
    },
    data: {
      'index.html': params.indexData,
    },
  },
  {
    apiVersion: 'apps/v1',
    kind: 'Deployment',
    metadata: {
      name: 'frontend',
      labels: {
        app: 'frontend',
      },
    },
    spec: {
      replicas: params.replicas,
      selector: {
        matchLabels: {
          app: 'frontend',
        },
      },
      template: {
        metadata: {
          labels: {
            app: 'frontend',
          },
        },
        spec: {
          containers: [
            {
              name: 'frontend',
              image: 'nginx:stable',
              volumeMounts: [
                {
                  name: 'web',
                  mountPath: '/usr/share/nginx/html',
                },
              ],
            },
          ],
          volumes: [
            {
              name: 'web',
              configMap: {
                name: 'frontend',
              },
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
      "name": "frontend",
      "labels": {
         "app": "frontend"
      }
   },
   "spec": {
      "type": "ClusterIP",
      "ports": [
         {
            "targetPort": 80,
            "port": 8000
         }
      ],
      "selector": {
         "app": "frontend"
      }
   }
}
]
