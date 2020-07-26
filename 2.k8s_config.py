#!/usr/bin/env python3
#Importing newly downloaded Karbon kubeconfig as kubeconfig file
import glob,os
import subprocess
from pathlib import Path
HOMEDIR  = str(Path.home())
#the latest kubeconfig file
if __name__ == "__main__":
    LatestFile = max(glob.glob(HOMEDIR+'/Downloads/*kubectl*'),key=os.path.getctime)
    subprocess.Popen('cp -p "%s" ~/.kube/config' %LatestFile,shell=True)
    subprocess.Popen('kubectl cluster-info\n',shell=True)
    subprocess.Popen('kubectl get nodes\n',shell=True)
