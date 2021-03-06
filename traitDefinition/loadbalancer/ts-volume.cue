#Map: [string]: string
parameter: {
	env: [string]:          string
	volumeMounts: [string]: string
	volumes: [...#Map]
}
patch: {
	spec: template: spec: {
		// +patchKey=name
		containers: [{
			name: context.name
			// +patchKey=name
			env: [
				for k, v in parameter.env {
					name:  k
					value: v
				},
			]
			volumeMounts: [
				for k, v in parameter.volumeMounts {
					name:      k
					mountPath: v
				},
			]
		}]

		// +patchKey=name
		volumes: [
			for volume in parameter.volumes {
				for k, v in volume {
					if k != "emptyDir" {
						"\(k)": v
					}
					if k == "emptyDir" {
						emptyDir: {}
					}
				}
			},
		]
	}
}
