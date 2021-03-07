#PortConfig: {
	name?:       string
	port:        int
	servicePort: int
}
parameter: {
	name: string
	podLabs: [string]: string
	ports: [...#PortConfig]
}
outputs: loadbalancer: {
	apiVersion: "v1"
	kind:       "Service"
	metadata: {
		name: parameter.name
	}
	spec: {
		type: "LoadBalancer"
		selector: {
			for k, v in parameter.podLabs {
				k: v
			}
		}
		portConfigs: [
			for config in parameter.ports {
				if config.name != _|_ {
					name: config.name
				}
				port:       config.port
				targetPort: config.servicePort
			},
		]
	}
}
parameter: {
	name: "lb"
	podLabs: {"app": "pod"}
	ports: [{name: "http", port: 80, servicePort: 8080}]
}
