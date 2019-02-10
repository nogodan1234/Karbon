export KUBECONFIG=` ls -tlr ~/Downloads/kubectl* | tail -1 | awk -F' ' '{print $9}' `
cp $KUBECONFIG ~/.kube/lab.config
cp ~/.kube/lab.config ~/.kube/config
kubectl cluster-info
kubectl get nodes
