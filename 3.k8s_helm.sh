brew upgrade helm
#helm init --client-only
#helm tiller start 
sleep 10
helm version
echo "Adding helm repo"
helm repo add stable https://kubernetes-charts.storage.googleapis.com/
echo "Search table pkgs"
helm search repo stable
