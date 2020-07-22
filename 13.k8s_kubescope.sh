kubectl create -f kubescope_deployment.yaml
sleep 40
#https://github.com/hharnisc/kubescope-cli
#Please update value: ".*my-app.*" from deployment then attach the container with below command
echo "### showing "prometheus-pushgateway" container matrix real time ###"
kubectl attach -it kubescope-cli
