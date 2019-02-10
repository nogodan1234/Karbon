<html>
<body lang=EN-US style='tab-interval:.5in'>

<div class=WordSection1>

<p class=MsoNormal># Karbon<o:p></o:p></p>

<p class=MsoNormal>This repo is sharing some useful scripts for Nutanix Karbon
Cluster<o:p></o:p></p>

<p class=MsoNormal><o:p>&nbsp;</o:p></p>

<p class=MsoNormal>1.nx_cluster_setup.sh <o:p></o:p></p>

<p class=MsoNormal>####################<o:p></o:p></p>

<p class=MsoNormal>This script can be run one of Nutanix Prism Element CVM.<o:p></o:p></p>

<p class=MsoNormal>With given information, it will set your cluster
autonomously <o:p></o:p></p>

<p class=MsoNormal>- DHCP network creation<o:p></o:p></p>

<p class=MsoNormal>- Static network creation for Prism Central especially<o:p></o:p></p>

<p class=MsoNormal>- Karbon image registration - ubuntu,centos<o:p></o:p></p>

<p class=MsoNormal>- Prism Element - data service ip setup<o:p></o:p></p>

<p class=MsoNormal><o:p>&nbsp;</o:p></p>

<p class=MsoNormal>2.k8s_config.sh<o:p></o:p></p>

<p class=MsoNormal>####################<o:p></o:p></p>

<p class=MsoNormal>You have to have installed kubectl cli<span
style='mso-spacerun:yes'>  </span>on your laptop <o:p></o:p></p>

<p class=MsoNormal>You have to have downloaded kubeconfig file on your
~/Download foler from Karbon UI first<o:p></o:p></p>

<p class=MsoNormal>-
https://portal.nutanix.com/#/page/docs/details?targetId=Karbon-v08:Karbon-v08<o:p></o:p></p>

<p class=MsoNormal>This shell move the kubeconfig file to ~/.kube/config so
that your kubectl can talk to new Karbon cluster<o:p></o:p></p>

<p class=MsoNormal><o:p>&nbsp;</o:p></p>

<p class=MsoNormal>3.k8s_dashboard.sh<o:p></o:p></p>

<p class=MsoNormal>####################<o:p></o:p></p>

<p class=MsoNormal>This shell will install Kubernetes dashboard to your cluster<o:p></o:p></p>

<p class=MsoNormal>You will see secret token in the end to login the dashboard<o:p></o:p></p>

<p class=MsoNormal>Dashboard URL will be<o:p></o:p></p>

<p class=MsoNormal>- http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/<o:p></o:p></p>

<p class=MsoNormal>Please do not close the termial as kubectl proxy need to
redirect the port to your local laptop<o:p></o:p></p>

<p class=MsoNormal><o:p>&nbsp;</o:p></p>

<p class=MsoNormal>4.k8s_helm.sh<o:p></o:p></p>

<p class=MsoNormal>####################<o:p></o:p></p>

<p class=MsoNormal>This script will install helm pkg(tilerless)<span
style='mso-spacerun:yes'>  </span>on your cluster<o:p></o:p></p>

<p class=MsoNormal><o:p>&nbsp;</o:p></p>

<p class=MsoNormal>5.k8s_prometheus.sh<o:p></o:p></p>

<p class=MsoNormal>####################<o:p></o:p></p>

<p class=MsoNormal>This script will install prometheus pkg via helm <o:p></o:p></p>

<p class=MsoNormal><o:p>&nbsp;</o:p></p>

<p class=MsoNormal>6.k8s_istio_knative.sh<o:p></o:p></p>

<p class=MsoNormal>####################<o:p></o:p></p>

<p class=MsoNormal>This script will install Istio &amp; Knative pkg<o:p></o:p></p>

<p class=MsoNormal><o:p>&nbsp;</o:p></p>

<p class=MsoNormal>7.k8s_kubescope.sh<o:p></o:p></p>

<p class=MsoNormal>####################<o:p></o:p></p>

<p class=MsoNormal>This script will install Kubescope container for container
perf check<o:p></o:p></p>

<p class=MsoNormal>- For more detail :
https://github.com/hharnisc/kubescope-cli<o:p></o:p></p>

<p class=MsoNormal><o:p>&nbsp;</o:p></p>

<p class=MsoNormal>8.k8s_linkerd.sh<o:p></o:p></p>

<p class=MsoNormal>####################<o:p></o:p></p>

<p class=MsoNormal>This script will install Linkerd pkg on your cluster<o:p></o:p></p>

<p class=MsoNormal>- For more detail : https://linkerd.io/2/getting-started/<o:p></o:p></p>

<p class=MsoNormal><o:p>&nbsp;</o:p></p>

<p class=MsoNormal>PS: Most of scripts will be running fine on other native k8s
cluster</p>

</div>

</body>

</html>
