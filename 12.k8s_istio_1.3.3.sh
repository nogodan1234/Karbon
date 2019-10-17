helm repo add istio.io https://storage.googleapis.com/istio-release/releases/1.3.3/charts/
kubectl create ns istio-system
helm install istio.io/istio-init --namespace istio-system
sleep 20
helm install istio.io/istio-cni --namespace istio-system
sleep 20
helm install istio.io/istio --set grafana.enabled=true --namespace istio-system
sleep 20
kubectl patch svc istio-ingressgateway -n istio-system  -p '{"spec": {"type": "NodePort"}}'
kubectl label namespace default istio-injection=enabled
kubectl get namespace -L istio-injection
