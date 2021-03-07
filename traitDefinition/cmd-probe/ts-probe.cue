#ProbeAction: {
	waitPodrtUpSeconds: *0 | int
	periodSeconds:      *10 | int
	cmd: [...string]
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
parameter: {
	readinessProbe: {cmd: ["ls"]}
	livenessProbe: {cmd: ["ls"]}
}
//context: output: {
// containerName: "image"
//}
