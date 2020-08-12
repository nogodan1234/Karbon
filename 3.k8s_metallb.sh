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

#Remove metallb from the cluster
#kubectl delete secret memberlist -n metallb-system
#kubectl delete -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/metallb.yaml
#kubectl delete -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml
