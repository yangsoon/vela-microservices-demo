patch: {
	spec: template: spec: {
		// +patchKey=name
		containers: [{
			name: context.output.containerName
			readinessProbe: {
				initialDelaySeconds: parameter.readinessProbe.waitPodrtUpSeconds
				periodSeconds:       parameter.readinessProbe.periodSeconds
				exec: command: parameter.readinessProbe.cmd
			}
			livenessProbe: {
				initialDelaySeconds: parameter.livenessProbe.waitPodrtUpSeconds
				periodSeconds:       parameter.livenessProbe.periodSeconds
				exec: command: parameter.livenessProbe.cmd
			}
		}]
	}
}
#ProbeAction: {
	// +usage=Number of seconds after the container has started before liveness probes are initiated
	waitPodrtUpSeconds: *0 | int

	// +usage=How often (in seconds) to perform the probe
	periodSeconds: *10 | int

	// +usage=Command is the command line to execute inside the container
	cmd: [...string]
}

parameter: {
	readinessProbe: #ProbeAction
	livenessProbe:  #ProbeAction
}
//parameter: {
// readinessProbe: {cmd: ["ls"]}
// livenessProbe: {cmd: ["ls"]}
//}
//context: output: {
// containerName: "image"
//}
