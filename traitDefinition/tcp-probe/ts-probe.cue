patch: {
	spec: template: spec: {
		// +patchKey=name
		containers: [{
			name: parameter.containerName
			readinessProbe: {
				initialDelaySeconds: parameter.readinessProbe.waitPodStartUpSeconds
				periodSeconds:       parameter.readinessProbe.periodSeconds
				tcpSocket: {
					if parameter.readinessProbe.host != _|_ {
						host: parameter.readinessProbe.host
					}
					port: parameter.readinessProbe.port
				}
			}
			livenessProbe: {
				initialDelaySeconds: parameter.livenessProbe.waitPodStartUpSeconds
				periodSeconds:       parameter.livenessProbe.periodSeconds
				tcpSocket: {
					if parameter.livenessProbe.host != _|_ {
						host: parameter.livenessProbe.host
					}
					port: parameter.livenessProbe.port
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
	host?:         string
	port:          int
}

parameter: {
	containerName:  string
	readinessProbe: #ProbeAction
	livenessProbe:  #ProbeAction
}
//context: output: {
// containerName: "image"
//}
