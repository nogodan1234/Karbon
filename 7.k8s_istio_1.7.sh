#Change to user home directory
cd ~
curl -L https://istio.io/downloadIstio | sh -
export PATH="$PATH:$PWD/istio-1.7.0/bin"
echo "Creating istio-system namespace"
kubectl create  ns istio-system
echo "Installing istio for demo profile base on your current kubeconfig file...."
istioctl install --set profile=demo
echo "Patching the service to NodePort"
kubectl patch svc istio-ingressgateway -n istio-system  -p '{"spec": {"type": "NodePort"}}'
kubectl get namespace -L istio-injection
echo "Installing  grafana,kiali,jaeger,prometheus add-on "
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.7/samples/addons/kiali.yaml
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.7/samples/addons/grafana.yaml
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.7/samples/addons/jaeger.yaml
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.7/samples/addons/prometheus.yaml

echo "Please use istioctl dashabord  prometheus/grafana/kiali to access their console" 
