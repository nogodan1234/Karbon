echo "Installing Metalb v0.9.3 from the web...."
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/metallb.yaml
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"

kubectl get pods -n metallb-system
echo "Please edit metallb ConfigMap(metallb-cm.yaml) with your ip address range"
echo "
...
addresses:
      - 192.168.1.240-192.168.1.250 => to your network
...
"
echo " Once the modification is done please create ConfigMap. You know how to do it :)  Right?"

#Or use helm com to provide values 
#helm install metallb stable/metallb --namespace kube-system \
#  --set configInline.address-pools[0].name=metallb-ip-pool \
#  --set configInline.address-pools[0].protocol=layer2 \
#  --set configInline.address-pools[0].addresses[0]=10.134.83.229-10.134.83.233