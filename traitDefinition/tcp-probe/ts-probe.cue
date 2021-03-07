#ProbeAction: {
	waitPodrtUpSeconds: *0 | int
	periodSeconds:      *10 | int
	host?:              string
	port:               int
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
				tcpSocket: {
					if parameter.readinessProbe.host != _|_ {
						host: parameter.readinessProbe.host
					}
					port: parameter.readinessProbe.port
				}
			}
			livenessProbe: {
				initialDelaySeconds: parameter.livenessProbe.waitPodrtUpSeconds
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
context: output: {
	containerName: "image"
}
