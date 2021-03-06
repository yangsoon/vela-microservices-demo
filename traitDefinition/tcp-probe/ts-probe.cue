#HTTPHeader: {
	name:  string
	value: string
}
#ProbeAction: {
	waitPodrtUpSeconds: *0 | int
	port:               int
	path:               string
	httpHeaders?: [...#HTTPHeader]
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
				httpGet: {
					path: parameter.readinessProbe.path
					port: parameter.readinessProbe.port
					if parameter.readinessProbe.httpHeaders != _|_ {
						for httpHeader in parameter.readinessProbe.httpHeaders {
							name:  httpHeader.name
							value: httpHeader.value
						}
					}
				}
			}
			livenessProbe: {
				initialDelaySeconds: parameter.livenessProbe.waitPodrtUpSeconds
				httpGet: {
					path: parameter.livenessProbe.path
					port: parameter.livenessProbe.port
					if parameter.livenessProbe.httpHeaders != _|_ {
						for httpHeader in parameter.livenessProbe.httpHeaders {
							name:  httpHeader.name
							value: httpHeader.value
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
