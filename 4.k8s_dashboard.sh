helm install stable/kubernetes-dashboard --set "rbac.create=true" --namespace kube-system
sleep 10
echo "Creating SA for the dashboard"
kubectl create serviceaccount dashboard -n default
echo "Creating Cluster Role Binding for the dashboard"
kubectl create clusterrolebinding dashboard-admin -n default --clusterrole=cluster-admin --serviceaccount=default:dashboard
echo "Getting the token info for Dashboard"
kubectl get secret $(kubectl get serviceaccount dashboard -o jsonpath="{.secrets[0].name}") -o jsonpath="{.data.token}" | base64 --decode | echo 
#kubectl describe secrets $(kubectl get secrets | grep -i default | awk -F" " '{print $1}') | grep token | grep -v Name | grep -v Type
#pending on 
#https://github.com/helm/charts/issues/9776
#https://github.com/kubernetes/dashboard/pull/3522
