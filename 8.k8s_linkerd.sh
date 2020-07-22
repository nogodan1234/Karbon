echo "Check k8s version info"
kubectl version --short
sleep 3

echo "Install linkerd client cli"
curl -sL https://run.linkerd.io/install | sh
export PATH=$PATH:$HOME/.linkerd2/bin

echo "Check linkerd version"
linkerd version
echo "Server version: unavailable is normal since we didn't install control plane yet"
sleep 3

echo "Valiadte your k8s cluster"
linkerd check --pre
sleep 3

echo "Install Linkerd onto the cluster"
linkerd install | kubectl apply -f -
sleep 3

echo "Check linkerd status"
echo "Please be patient until pod is up & running"
linkerd check

echo "Start Linkerd Dashboard"
echo "Linkerd Dashboard will start automatically"
linkerd dashboard

#optional demo  svc deployment 
curl -sL https://run.linkerd.io/emojivoto.yml | kubectl apply -f - 
kubectl -n emojivoto port-forward $(kubectl -n emojivoto get po -l app=web-svc -oname | cut -d/ -f 2) 8080:80
kubectl get -n emojivoto deploy -o yaml | linkerd inject - | kubectl apply -f -
linkerd -n emojivoto check --proxy
linkerd -n emojivoto stat deploy
linkerd -n emojivoto top deploy
linkerd -n emojivoto tap deploy/web

echo "Add another ns to linkerd"
kubectl get -n ntnx-logging deploy -o yaml | linkerd inject - | kubectl apply -f -
