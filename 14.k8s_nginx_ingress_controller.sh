kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/static/provider/baremetal/deploy.yaml

echo "Testing with ngix pod"
kubectl run nginx --image nginx
echo "Expose test pod to loadbalancer service"
kubectl expose pod nginx --port 80 --type LoadBalancer
