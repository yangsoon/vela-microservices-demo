patch: {
	spec: template: spec: {
		// +patchKey=name
		containers: [{
			name: parameter.containerName
			readinessProbe: {
				initialDelaySeconds: parameter.readinessProbe.waitPodStartUpSeconds
				periodSeconds:       parameter.readinessProbe.periodSeconds
				httpGet: {
					path: parameter.readinessProbe.path
					port: parameter.readinessProbe.port
					if parameter.readinessProbe.httpHeaders != _|_ {
						httpHeaders: [
							for k, v in parameter.readinessProbe.httpHeaders {
								name:  k
								value: v
							},
						]
					}
				}
			}
			livenessProbe: {
				initialDelaySeconds: parameter.livenessProbe.waitPodStartUpSeconds
				periodSeconds:       parameter.livenessProbe.periodSeconds
				httpGet: {
					path: parameter.livenessProbe.path
					port: parameter.livenessProbe.port
					if parameter.livenessProbe.httpHeaders != _|_ {
						httpHeaders: [
							for k, v in parameter.livenessProbe.httpHeaders {
								name:  k
								value: v
							},
						]
					}
				}
			}
		}]
	}
}
#ProbeAction: {
	// +usage=Number of seconds after the container has started before liveness probes are initiated
	waitPodStartUpSeconds: *0 | int

	// +usage=How often (in seconds) to perform the probe
	periodSeconds: *10 | int
	port:          int
	path:          string

	// +usage=Custom headers to set in the request. ex: Cookie: "shop_session-id=x-readiness-probe"
	httpHeaders?: [string]: string
}

parameter: {
	containerName:  string
	readinessProbe: #ProbeAction
	livenessProbe:  #ProbeAction
}
//parameter: {
// readinessProbe: {
//  port: 8080
//  path: "/ready_health"
//  httpHeaders: {"cookie": "key"}
// }
// livenessProbe: {
//  port: 8080
//  path: "/live_health"
//  //     httpHeaders: [{name: "cookie", value: "key"}]
// }
//}
//context: output: {
// containerName: "image"
//}
