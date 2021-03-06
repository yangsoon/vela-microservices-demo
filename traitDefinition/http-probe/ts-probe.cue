#ProbeConfig: {
	periodSeconds: *10 | int
	cmd: [...string]
}
parameter: {
	readinessProbe: #ProbeConfig
	livenessProbe:  #ProbeConfig
}
patch: {
	spec: template: spec: {
		// +patchKey=name
		containers: [{
			name: context.output.containerName
			readinessProbe: {
				periodSeconds: parameter.readinessProbe.periodSeconds
				exec: command: parameter.readinessProbe.cmd
			}
			livenessProbe: {
				periodSeconds: parameter.livenessProbe.periodSeconds
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
