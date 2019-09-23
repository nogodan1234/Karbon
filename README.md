# Nutanix Karbon script repo by Taeho choi

## Getting Started

These scripts are created with intention to help Nutanix Karbon Customer by installing additional Kubernetes packages 

### Prerequisites

Need to understand basic bash script syntax and Kubernetes components.
```
kubectl, master, node,secret ...
```

### How to run each script !
Just download with git clone then run the shell script with sh command from any linux base system - Mac,Centos,Ubuntu etc
```
ex) $sh k8s_metallb.sh
```

### Detail on each script

1.  nx_cluster_setup.sh. 
  ####################. 
  This script can be run one of Nutanix Prism Element CVM.  
  With given information, it will set your cluster autonomously. 
  - DHCP network creation. 
  - Static network creation for Prism Central especially. 
  - Karbon image registration - centos. 
  - Prism Element - data service ip setup. 

2. 	k8s_config.sh. 
  ####################. 
  You have to have installed kubectl cli on your laptop. 
  You have to have downloaded kubeconfig file on your ~/Download foler from Karbon UI first. 
  - https://portal.nutanix.com/#/page/docs/details?targetId=Karbon-v08:Karbon-v08. 
  This shell move the kubeconfig file to ~/.kube/config so that your kubectl can talk to new Karbon cluster. 

3.	k8s_dashboard.sh. 
  ####################. 
  This shell will install Kubernetes dashboard to your cluster. 
  You will see secret token in the end to login the dashboard. 
  Dashboard URL will be. 
  - http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/. 
  Please do not close the termial as kubectl proxy need to redirect the port to your local laptop.  

4.	k8s_helm.sh. 
  ####################. 
  This script will install helm pkg(tilerless) on your cluster. 

5.	k8s_prometheus.sh. 		
  ####################. 
  This script will install prometheus pkg via helm. 

6.	k8s_istio_knative.sh. 
  ####################. 
  This script will install Istio & Knative pkg. 

7.	k8s_kubescope.sh. 
  ####################. 
  This script will install Kubescope container for container perf check. 
  - For more detail : https://github.com/hharnisc/kubescope-cli. 

8.	k8s_linkerd.sh. 
  ####################. 
  This script will install Linkerd pkg on your cluster. 
  - For more detail : https://linkerd.io/2/getting-started/. 

		PS: Most of scripts will be running fine on other native k8s cluster. 

## Authors

* **Taeho Choi** - (https://github.com/nogodan1234)

See also the list of [contributors](https://github.com/nogodan1234/nutanix/contributors) who participated in this project.

## License

This project is licensed under the MIT License

## Acknowledgments

* Nutanix is not officially tested on these scripts nor provide supports on these.
* All responsibilies to use this scripts are on each individual.
