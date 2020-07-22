echo "This installation is required Kubernetes cluster v1.15 or newer, as well as a compatible kubectl"
echo "This is installation for Knative v0.16.0 with Istio network layer"
#Knative
kubectl apply --filename https://github.com/knative/serving/releases/download/v0.16.0/serving-crds.yaml
kubectl apply --filename https://github.com/knative/serving/releases/download/v0.16.0/serving-core.yaml

echo "Installing networking layer components ...."
kubectl apply --filename https://github.com/knative/net-istio/releases/download/v0.16.0/release.yaml
kubectl --namespace istio-system get service istio-ingressgateway

kubectl create -f  knative_sample_svc.yaml
export IP_ADDRESS=$(kubectl get node  --output 'jsonpath={.items[0].status.addresses[0].address}'):$(kubectl get svc istio-ingressgateway --namespace istio-system   --output 'jsonpath={.spec.ports[?(@.port==80)].nodePort}')
kubectl get ksvc helloworld-go  --output=custom-columns=NAME:.metadata.name,DOMAIN:.status.domain
export HOST_URL=$(kubectl get ksvc helloworld-go  --output jsonpath='{.status.domain}')
curl -H "Host: helloworld-go.default.example.com" http://${IP_ADDRESS}
