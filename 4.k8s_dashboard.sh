#Disclaimer
#This code is intended as a standalone example. 
#Subject to licensing restrictions defined on nutanix.dev, this can be downloaded, 
#copied and/or modified in any way you see fit. 
#Please be aware that all public code samples provided by Nutanix are unofficial in nature, 
#are provided as examples only, are unsupported and will need to be heavily scrutinized and potentially modified before they can be used in a production environment. 
#All such code samples are provided on an as-is basis, and Nutanix expressly disclaims all warranties, express or implied. 
#All code samples are © Nutanix, Inc., and are provided as-is under the MIT license (https://opensource.org/licenses/MIT).

kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0/aio/deploy/recommended.yaml
sleep 10
echo "Creating SA for the dashboard"
kubectl create serviceaccount dashboard -n kubernetes-dashboard
echo "Creating Cluster Role Binding for the dashboard"
kubectl create clusterrolebinding admin-user  -n kubernetes-dashboard  --clusterrole=cluster-admin --serviceaccount=kubernetes-dashboard:admin-user
echo "Getting the token info for Dashboard"
kubectl -n kubernetes-dashboard describe secret $(kubectl -n kubernetes-dashboard get secret | grep admin-user | awk '{print $1}')
sleep 5
echo "Type kubeproxy command then you can connect the dashboard from local"
echo "kubectl proxy"
echo "open this url from your browser: http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/#/login"