export PRISM_ELEMENT_VIP=
export DATA_SVC_IP=
export PE_ADMIN_PASSWD=
export PE_STORAGE_CONTAINER_NAME=SelfServiceContainer
export SECRET=`echo -n "admin:$PE_ADMIN_PASSWD" | base64`
kubectl create -f k8s_nutanix_k8s_plugin.yaml
