helm repo add istio.io https://storage.googleapis.com/istio-release/releases/1.3.3/charts/
helm install istio.io/istio-init
sleep 20
helm install istio.io/istio-cni
sleep 20
helm install istio.io/istio
sleep 20
kubectl patch svc istio-ingressgateway   -p '{"spec": {"type": "NodePort"}}'
kubectl label namespace default istio-injection=enabled
sleep 20
echo "Check which namespace is enabled for Istio injection"
kubectl get namespace -L istio-injection
