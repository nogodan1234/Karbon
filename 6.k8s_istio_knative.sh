kubectl apply --filename https://raw.githubusercontent.com/knative/serving/v0.2.2/third_party/istio-1.0.2/istio.yaml
kubectl label namespace default istio-injection=enabled
kubectl get pods --namespace istio-system
kubectl apply --filename https://github.com/knative/serving/releases/download/v0.2.2/release.yaml
kubectl patch svc istio-ingressgateway -n istio-system  -p '{"spec": {"type": "NodePort"}}'
kubectl patch svc knative-ingressgateway -n istio-system  -p '{"spec": {"type": "NodePort"}}'
sleep 10 
kubectl get pods --namespace knative-serving
kubectl get pods --namespace knative-build

kubectl create -f  knative_sample_svc.yaml
export IP_ADDRESS=$(kubectl get node  --output 'jsonpath={.items[0].status.addresses[0].address}'):$(kubectl get svc knative-ingressgateway --namespace istio-system   --output 'jsonpath={.spec.ports[?(@.port==80)].nodePort}')
kubectl get ksvc helloworld-go  --output=custom-columns=NAME:.metadata.name,DOMAIN:.status.domain
export HOST_URL=$(kubectl get ksvc helloworld-go  --output jsonpath='{.status.domain}')
curl -H "Host: helloworld-go.default.example.com" http://${IP_ADDRESS}
