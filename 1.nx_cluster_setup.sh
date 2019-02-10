#!/bin/bash

# Basic shell script to take an existing Nutanix cluster running the Acropolis Hypervisor (AHV) and configure the Image Service, managed network(vlan), dhcp network, potentially register some guest VMs
# All done using the Acropolis CLI (acli) or ncli

clear

# set some variables
# change these to match your environment
# note that not all options are set here - just the settings most likely to change in a your environment 

#NFS_SERVER=10.10.10.243
#NFS_EXPORT=Shared/Software

export CENTOS_IMAGE=https://cloud.centos.org/centos/7/images/CentOS-7-x86_64-GenericCloud-1809.qcow2
export DHCP_NET=dhcp
export DHCP_VLAN=2
export STATIC_NET=matrix
export STATIC_VLAN=0
export IP_CONFIG=YOUR_NETWORK_ADDRESS/SUBNETMASK
#export IP_CONFIG=192.168.1.1/24
export IP_POOL_START=192.168.1.100
export IP_POOL_END=192.168.1.200
#VLAN_IP_CONFIG=10.10.10.253/24
#DHCP_START=10.10.10.100
#DHCP_END=10.10.10.200
export DOMAIN_NAME=taeho.local
export DNS_SERVER=8.8.8.8
export WINDOWS_DISK_SIZE=40G
export CENTOS_DISK_SIZE=10G
export PRISM_CENTRAL_CPUS=8
export PRISM_CENTRAL_RAM=24G
export PRISM_CENTRAL_IP=192.168.1.100
export PE_DATA_SVC_IP=192.168.1.200
export ACS_CENTOS=http://download.nutanix.com/karbon/0.8/acs-centos7.qcow2
export ACS_UBUNTU=http://download.nutanix.com/karbon/0.8/acs-ubuntu1604.qcow2
export NEW_AOS=http://download.nutanix.com/releases/euphrates-5.10.0.2-stable/nutanix_installer_package-release-euphrates-5.10.0.2-stable.tar.gz
export NEW_AOS_META=http://download.nutanix.com/releases/euphrates-5.10.0.2-metadata/euphrates-5.10.0.2-metadata.json

echo

# create images
# sleep for 3 seconds between each image creation process
# this is because the dev platform is based on OS X - NFS seems to disconnect clients if one session finishes then another immediately starts

echo "Creating ACS images ..."
acli image.create "acs-centos" image_type=kDiskImage source_url=$ACS_CENTOS container=NutanixManagementShare;
sleep 3
acli image.create "acs-ubuntu" image_type=kDiskImage source_url=$ACS_UBUNTU container=Images;
sleep 3
#echo "Creating Windows 2012 R2 ISO_image "
#acli image.create "Windows 2012 R2" image_type=kIsoImage source_url="http://apac-file.sre-labs.nutanix.com/Repo/Mounts/NSS/Win2012_R2-3319595.iso" container=Images;
sleep 3
echo "Creating Centos7 Disk iamge "
acli image.create "Centos7" image_type=kDiskImage source_url=$CENTOS_IMAGE container=Images;
#sleep 3
echo "Creating VirtIO Driver image ..."
acli image.create "VirtIO" image_type=kIsoImage source_url="http://apac-file.sre-labs.nutanix.com/Repo/Mounts/NSS/virtio-win-0.1.126.iso" container=Images;

echo

# create network
echo "Creating dhcp network ..."
acli net.create dhcp vlan=$DHCP_VLAN 
sleep 3
echo "Creating Static network"
acli net.create $STATIC_NET vlan=$STATIC_VLAN ip_config=$IP_CONFIG 
echo "Adding DHCP pool ..."
acli net.add_dhcp_pool $STATIC_NET start=$IP_POOL_START end=$IP_POOL_END;
echo "Configuring $VLAN_NAME DNS settings ..."
acli net.update_dhcp_dns $STATIC_NET domains=$DOMAIN_NAME servers=$DNS_SERVER;

echo

# create VMs - Windows 2012
#echo "Creating Windows 2012 R2 VM ..."
#acli vm.create "Windows2012R2" num_vcpus=1 num_cores_per_vcpu=1 memory=8G;
#echo "Attaching CDROM devices ..."
#acli vm.disk_create "Windows2012R2" cdrom=true clone_from_image="Windows 2012 R2";
#acli vm.disk_create "Windows2012R2" cdrom=true clone_from_image="VirtIO";
#echo "Creating system disk ..."
#acli vm.disk_create "Windows2012R2" create_size=$WINDOWS_DISK_SIZE;
#echo "Creating network adapter ..."
#acli vm.nic_create "Windows2012R2" network=$VLAN_NAME;
#echo "Powering on Windows 2012 R2 VM ..."
#acli vm.on "Windows2012R2";

echo

# create VMs - CentOS 7
#echo "Creating CentOS 7 VM ..."
#acli vm.create "CentOS7" num_vcpus=4 num_cores_per_vcpu=1 memory=2G;
#echo "Attaching boot disk device ..."
#acli vm.disk_create "CentOS7" clone_from_image=$CENTOS_IMAGE;
#echo "Creating network adapter ..."
#acli vm.nic_create "CentOS7" network=$DHCP_NET;
#echo "Powering on CentOS 7 VM ..."
#acli vm.on "CentOS7";

echo

# create VMs - Prism Central
matrix_net_id=`acli net.list | grep -i matrix | awk -F" " '{print $2}'`
default_storage_uuid=`ncli ctr ls | grep NutanixManagement -b2 | grep -i Uuid | grep -v Storage |  awk -F" " '{print $4}'`

echo
echo "Finished!"
echo

#Prism UI passwd reset
#ncli user reset-password user-name="admin" password="ADMIN_PASSWD"
ncli cluster edit-params external-data-services-ip-address=$PE_DATA_SVC_IP
#ncli cluster add-public-key name="pub-key"

echo "########## Matrix_net_id ##########"
echo $matrix_net_id
echo "########## default_storage_uuid ############"
echo $default_storage_uuid

#Upload new AOS file for upgrade
wget $NEW_AOS
wget $NEW_AOS_META
export JSON=`ls -tlr | grep metadata.json | awk -F" " '{print $9}'`
export AOS_BUNDLE=`ls -tlr | grep stable.tar.gz | awk -F" " '{print $9}'`
ncli software upload file-path=/home/nutanix/$AOS_BUNDLE software-type=NOS meta-file-path=/home/nutanix/$JSON

