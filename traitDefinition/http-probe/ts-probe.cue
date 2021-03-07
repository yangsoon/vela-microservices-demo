#ProbeAction: {
	waitPodrtUpSeconds: *0 | int
	periodSeconds:      *10 | int
	port:               int
	path:               string
	httpHeaders?: [string]: string
}
parameter: {
	readinessProbe: #ProbeAction
	livenessProbe:  #ProbeAction
}
patch: {
	spec: template: spec: {
		// +patchKey=name
		containers: [{
			name: context.output.containerName
			readinessProbe: {
				initialDelaySeconds: parameter.readinessProbe.waitPodrtUpSeconds
				periodSeconds:       parameter.readinessProbe.periodSeconds
				httpGet: {
					path: parameter.readinessProbe.path
					port: parameter.readinessProbe.port
					if parameter.readinessProbe.httpHeaders != _|_ {
						for k, v in parameter.readinessProbe.httpHeaders {
							name:  k
							value: v
						}
					}
				}
			}
			livenessProbe: {
				initialDelaySeconds: parameter.livenessProbe.waitPodrtUpSeconds
				periodSeconds:       parameter.livenessProbe.periodSeconds
				httpGet: {
					path: parameter.livenessProbe.path
					port: parameter.livenessProbe.port
					if parameter.livenessProbe.httpHeaders != _|_ {
						for k, v in parameter.livenessProbe.httpHeaders {
							name:  k
							value: v
						}
					}
				}
			}
		}]
	}
}
parameter: {
	readinessProbe: {
		port: 8080
		path: "/ready_health"
		httpHeaders: [{name: "cookie", value: "key"}]
	}
	livenessProbe: {
		port: 8080
		path: "/live_health"
		//     httpHeaders: [{name: "cookie", value: "key"}]
	}
}
context: output: {
	containerName: "image"
}
