#Change to user home directory
cd ~
curl -L https://istio.io/downloadIstio | sh -
export PATH=$PWD/bin:$PATH
echo "Installing istio for demo profile base on your current kubeconfig file...."
istioctl install --set profile=demo
echo "Label default namespace to inject Envoy sidecar for Istio"
kubectl label namespace default istio-injection=enabled
#echo "Patching the service to NodePort by assuming LB is not available"
#kubectl patch svc istio-ingressgateway -n istio-system  -p '{"spec": {"type": "NodePort"}}'
kubectl get namespace -L istio-injection
echo "Redirecting port to Grafana UI access"
kubectl -n istio-system port-forward $(kubectl -n istio-system get pod -l app=grafana -o jsonpath='{.items[0].metadata.name}') 3000:3000 &

#How to delete istio from the cluster
#istioctl manifest generate --set profile=demo | kubectl delete -f -
