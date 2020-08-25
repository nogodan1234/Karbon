#minio server 
#minio S3 server part
#docker pull minio/minio
#mkdir /data
#docker run --name minio -p 9000:9000 -v data:/data minio/minio server /data
#docker exec -it minio sh
#update credential /data/.minio.sys/config/config.json inside of container
#create S3 bucket kubedemo from minio UI

#velero client install
#install velero client 
#brew install velero

#create credential file
cat <<EOF>> minio.credentials
[default]
aws_access_key_id=minioadmin
aws_secret_access_key=$YOUR_PASSWD
EOF

#velero provision to k8s
#replace 10.134.82.197 with your S3 object server such as minio

velero install \
   --provider aws \
   --plugins velero/velero-plugin-for-aws:v1.1.0 \
   --bucket kubedemo \
   --secret-file ./minio.credentials \
   --backup-location-config region=minio,s3ForcePathStyle=true,s3Url=http://10.134.82.197:9000 \
   --use-volume-snapshots=false \
   --image velero/velero:v1.4.0 \
   --use-restic

#need to update Restic DaemonSet because the kubelet hostPath for Kubernetes clusters deployed by Karbon is different (/var/nutanix/var/lib/kubelet) to the Restic standard hostPath (/var/lib/kubelet).
kubectl -n velero patch daemonset restic -p='{"spec":{"template":{"spec":{"volumes":[{"hostPath":{"path":"/var/nutanix/var/lib/kubelet/pods","type":""},"name":"host-pods"}]}}}}'

#auto completion for velero cli
source <(velero completion bash)

#Check daemonset pod in velero ns
kubectl get pod -n velero