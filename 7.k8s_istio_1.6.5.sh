#Change to user home directory
cd ~
curl -L https://istio.io/downloadIstio | sh -
export PATH=$PWD/bin:$PATH
echo "Installing istio for demo profile base on your current kubeconfig file...."
istioctl install --set profile=demo
echo "Label default namespace to inject Envoy sidecar"
kubectl label namespace default istio-injection=enabled
echo "Patching the service to NodePort"
kubectl patch svc istio-ingressgateway -n istio-system  -p '{"spec": {"type": "NodePort"}}'
kubectl get namespace -L istio-injection
echo "Patching grafana,kiali,jaeger service to NodePort"
kubectl patch svc grafana -n istio-system -p '{"spec": {"type": "NodePort"}}'
kubectl patch svc kiali -n istio-system -p '{"spec": {"type": "NodePort"}}'
kubectl patch svc jaeger-query  -n istio-system -p '{"spec": {"type": "NodePort"}}'