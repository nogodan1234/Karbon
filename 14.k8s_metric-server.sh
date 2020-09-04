# This is the script to install metrics-server in below git repo
# https://github.com/kubernetes-sigs/metrics-server
# The latest version as the time of writing is 0.3.7 version
# Install manifest 2 lines of difference from original template
# in argument section below 2 options are added 
#
#          - --kubelet-insecure-tls
#          - --kubelet-preferred-address-types=InternalIP

kubectl create -f metric-server_0.3.7.yaml