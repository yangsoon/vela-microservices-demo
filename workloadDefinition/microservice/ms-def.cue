#Resource: {
	cpu:    string
	memory: string
}
parameter: {
	image:                         string
	containerName:                 string
	servicePort:                   int
	containerPort:                 int
	podShutdownGracePeriodSeconds: *30 | int
	env: [string]: string
	serviceProtocol: string
	requestResource: #Resource
	limitResource:   #Resource
}
output: {
	// Deployment
	apiVersion: "apps/v1"
	kind:       "Deployment"
	spec: {
		selector: matchLabels: {
			"app": context.name
		}
		template: {
			metadata: labels: {
				"app": context.name
			}
			spec: {
				serviceAccountName:            "default"
				terminationGracePeriodSeconds: parameter.podShutdownGracePeriodSeconds
				containers: [{
					name:  parameter.containerName
					image: parameter.image
					ports: [{
						containerPort: parameter.containerPort
					}]
					if parameter.env != _|_ {
						env: [
							for k, v in parameter.env {
								name:  k
								value: v
							},
						]
					}
					resources: {
						requests: parameter.requestResource
						limits:   parameter.limitResource
					}
				}]
			}
		}
	}
}
// Service
outputs: service: {
	apiVersion: "v1"
	kind:       "Service"
	metadata: {
		name: context.name
		labels: {
			"app": context.name
		}
	}
	spec: {
		type: "ClusterIP"
		selector: {
			"app": context.name
		}
		ports: [{
			name:       parameter.serviceProtocol
			port:       parameter.servicePort
			targetPort: parameter.containerPort
		}]
	}
}
context: {
	name: "email"
}
parameter: {
	image:         "image"
	servicePort:   8080
	containerPort: 8080
	env: {"DISABLE_PROFILER": "1"}
	serviceProtocol: "grpc"
	requestResource: {cpu: "200m", memory: "180Mi"}
	limitResource: {cpu: "300m", memory: "300Mi"}
}
