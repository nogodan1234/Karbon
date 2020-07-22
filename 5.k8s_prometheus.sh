#https://github.com/helm/helm/issues/3130#issuecomment-372931407
#kubectl create serviceaccount --namespace kube-system tiller
#kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller
#kubectl patch deploy --namespace kube-system tiller-deploy -p '{"spec":{"template":{"spec":{"serviceAccount":"tiller"}}}}' `
#helm install --name prometheus stable/prometheus
echo "Now Karbon is shipping prometheus as embeded service"
#echo "Patching prometheus service to Node port, Assuming you don't have LB to provide service ip"
#kubectl patch svc prometheus-k8s -n ntnx-system -p '{"spec": {"type": "NodePort"}}'
