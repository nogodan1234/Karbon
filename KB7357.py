#########################################################################
    #   Enable CDCI admin user creation in Karbon
    #   Filename: KB7357.py
    #   Script Version: 1.0
    #   This is python script for http://portal.nutanix.com/kb/7357
#########################################################################

#########################################################################
# Disclaimer                                                            #
# This code is intended as a standalone example. Subject to licensing   #
# restrictions defined on nutanix.dev, this can be downloaded, copied   #
# and/or modified in any way you see fit.                               #
# Please be aware that all public code samples provided by Nutanix are  #
# unofficial in nature, are provided as examples only, are unsupported  #
# and will need to be heavily scrutinized and potentially modified      #
# before they can be used in a production environment. All such code    #
# samples are provided on an as-is basis, and Nutanix expressly         #
# disclaims all warranties, express or implied.                         #
# All code samples are © Nutanix, Inc., and are provided as-is under    #
# the MIT license. (https://opensource.org/licenses/MIT)                #
#########################################################################

import logging
import re,subprocess,sys
import yaml
from pathlib import Path

# Function to get the command output
def run_command(cmd):
    print("Running Command: %s"%cmd)
    p = subprocess.Popen(cmd, stdout=subprocess.PIPE,stderr=subprocess.PIPE, shell=True)
    (output, err) = p.communicate()
    #output = str(output)
    err = str(err)
    rc = p.returncode
    return (output,err,rc)

def main():

    print("Creating new serviceaccount named cdci")
    cmd1 = "kubectl create serviceaccount cdci"
    (out, err, rc) = run_command(cmd1)

    print("Creating Cluster Role Binding named cdci")
    cmd2 = "kubectl create clusterrolebinding cdci  --clusterrole=cluster-admin --serviceaccount=default:cdci"
    (out, err, rc) = run_command(cmd2)

    print("Get the secret token for newly created serviceaccount cdci")
    cmd3 = "kubectl get secrets $(kubectl get serviceaccounts cdci -o jsonpath={.secrets[].name}) -o jsonpath={.data.token} | base64 -d"
    (out, err, rc) = run_command(cmd3)
    out = out.decode("utf-8")
    print(out)

    #Get current user home directory
    home = str(Path.home())
    #Cluster config file in json format
    cluster_config = home+"/.kube/config"
    stream = open(cluster_config, 'r')
    data = yaml.safe_load(stream)
    #replacing the token with new token - permanent one
    data["users"][0]["user"]["token"] = out

    with open(cluster_config, 'w') as updated_f:
        updated_f.write(yaml.dump(data,default_flow_style=False))

if __name__ == "__main__":
    main()