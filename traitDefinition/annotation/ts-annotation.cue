parameter: {
	annotations: [string]: string
}
patch: {
	spec: template: metadata: annotations: {
		for k, v in parameter.annotations {
			"\(k)": v
		}
	}
}
//parameter: annotations: {"a": "b"}
