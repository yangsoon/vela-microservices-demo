patch: {
	spec: template: spec: {
		// +patchKey=name
		containers: [{
			name: parameter.containerName
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
	containerName: string
	volumeMounts: [...#VolumeMount]
}
//parameter: {
// volumeMounts: [{
//  name: "readis"
//  path: "/data"
//  emptyDir: {}
// }, {
//  name: "test"
//  path: "/data"
//  emptyDir: {}
// }, {
//  name: "mysql"
//  path: "/data"
// }]
//}
//context: output: {
// containername: "image"
//}
