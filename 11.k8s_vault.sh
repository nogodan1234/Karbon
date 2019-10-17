git clone https://github.com/hashicorp/vault-helm.git
cd vault-helm
git checkout v0.1.2
helm install --name vault ./
sleep 20
kubectl port-forward vault-0 8200:8200
