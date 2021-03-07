#!/bin/bash
echo "delete traits"
cd traitDefinition
traitsDirs=$(ls)
for trait in ${traitsDirs};do
  kubectl delete -f ${trait}/traitdef.yaml
done

echo "delete workload"
cd ../workloadDefinition
workloadDirs=$(ls)
for workload in ${workloadDirs};do
  kubectl delete -f ${workload}/workloaddef.yaml
done