kubectl apply -f https://raw.githubusercontent.com/google/metallb/v0.7.3/manifests/metallb.yaml
kubectl get pods -n metallb-system
echo "Please edit metallb ConfigMap(metallb-cm.yaml) with your ip address range"
echo "
...
addresses:
      - 192.168.1.240/28 => to your network
...
"
echo " Once the modification is done please create ConfigMap. You know how to do it :)  Right?"
