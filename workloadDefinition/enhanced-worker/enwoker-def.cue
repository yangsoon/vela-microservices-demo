parameter: {
	image:         string
	containerName: string
	replicas:      *1 | int
	annotations: [string]: string
	podShutdownGracePeriodSeconds: *30 | int
	env: [string]: string
}
output: {
	// Deployment
	apiVersion: "apps/v1"
	kind:       "Deployment"
	metadata: {
		name: context.name
	}
	spec: {
		selector: matchLabels: {
			"app": context.name
		}
		replicas: parameter.replicas
		template: {
			metadata: {
				labels: {
					"app": context.name
				}
				annotations: {
					for k, v in parameter.annotations {
						k: v
					}
				}
			}
			spec: {
				serviceAccountName:            "default"
				terminationGracePeriodSeconds: parameter.podShutdownGracePeriodSeconds
				restartPolicy:                 "Alwats"
				containers: [{
					name:  parameter.containerName
					image: parameter.image
					if parameter.env != _|_ {
						env: [
							for k, v in parameter.env {
								name:  k
								value: v
							},
						]
					}
				}]
			}
		}
	}
}

context: {
	name: "email"
}
parameter: {
	image:         "image"
	containerName: "string"
	annotations: {"sidecar.istio.io/rewriteAppHTTPProbers": "true"}
	env: {"DISABLE_PROFILER": "1"}
}