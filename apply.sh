#!/bin/bash
echo "apply traits"
cd traitDefinition
traitsDirs=$(ls)
for trait in ${traitsDirs};do
  kubectl apply -f ${trait}/traitdef.yaml
done

echo "apply workload"
cd ../workloadDefinition
workloadDirs=$(ls)
for workload in ${workloadDirs};do
  kubectl apply -f ${workload}/workloaddef.yaml
done