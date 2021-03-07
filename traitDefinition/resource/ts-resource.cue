#Config: {
	cpu?:    string
	memory?: string
}
parameter: {
	containerName: string
	requests?:     #Config
	limits?:       #Config
}
patch: {
	spec: template: spec: {
		// +patchKey=name
		containers: [{
			name: parameter.containerName
			resources: {
				if parameter.requests != _|_ {
					requests: parameter.requests
				}
				if parameter.limits != _|_ {
					limits: parameter.limits
				}
			}
		}]
	}
}
//parameter: {
// containerName: "app"
// //            requests: {cpu: "1", memory: "2"}
// limits: {cpu: "1", memory: "2"}
//}
