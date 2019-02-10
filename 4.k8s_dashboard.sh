helm install -n k8s-dashboard stable/kubernetes-dashboard
sleep 10
export POD_NAME=$(kubectl get pods -n default -l "app=kubernetes-dashboard,release=k8s-dashboard" -o jsonpath="{.items[0].metadata.name}")
kubectl -n default port-forward $POD_NAME 8443:8443
echo "Connect dashboard https://localhost:8443"
echo "Login token is ...."
kubectl describe secrets $(kubectl get secrets | grep -i default | awk -F" " '{print $1}') | grep token | grep -v Name | grep -v Type
