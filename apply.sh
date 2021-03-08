#!/bin/bash
echo "delete traits"
cd traitDefinition
traitsDirs=$(ls)
for trait in ${traitsDirs};do
  kubectl delete -f ${trait}/traitdef.yaml
done

echo "delete workloads"
cd ../workloadDefinition
workloadDirs=$(ls)
for workload in ${workloadDirs};do
  kubectl delete -f ${workload}/workloaddef.yaml
done

cd ..
echo "apply traits"
cd traitDefinition
traitsDirs=$(ls)
for trait in ${traitsDirs};do
  kubectl apply -f ${trait}/traitdef.yaml
done

echo "apply workloads"
cd ../workloadDefinition
workloadDirs=$(ls)
for workload in ${workloadDirs};do
  kubectl apply -f ${workload}/workloaddef.yaml
done