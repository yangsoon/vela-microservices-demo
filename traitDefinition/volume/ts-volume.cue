#EmptyDirConfig: {
	medium?:    string
	sizeLimit?: string
}
#VolumeMount: {
	name:      string
	path:      string
	emptyDir?: #EmptyDirConfig
}
parameter: {
	volumeMounts: [...#VolumeMount]
}
patch: {
	spec: template: spec: {
		// +patchKey=name
		containers: [{
			name: context.output.containername
			// +patchKey=name
			volumeMounts: [
				for volumeMount in parameter.volumeMounts {
					name:      volumeMount.name
					mountPath: volumeMount.path
				},
			]
		}]

		// +patchKey=name
		volumes: [
			for volumeMount in parameter.volumeMounts {
				name: volumeMount.name
				if volumeMount.emptyDir != _|_ {
					emptyDir: volumeMount.emptyDir
				}
			},
		]
	}
}
parameter: {
	volumeMounts: [{
		name: "readis"
		path: "/data"
		emptyDir: {}
	}, {
		name: "test"
		path: "/data"
		emptyDir: {}
	}, {
		name: "mysql"
		path: "/data"
	}]
}
context: output: {
	containername: "image"
}
