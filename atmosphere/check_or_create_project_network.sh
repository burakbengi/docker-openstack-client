#!/bin/bash

#####
# Description: This script will check or, if necessary, create a project's network, including the following:
#              * project network
#              * project subnet
#              * attaching to a router
#              * creating a security group  
#####
DEBUG=1

# include common functions and constants
source ./common.sh

func_test_os_environment

# second argument project domain
if [ $# -ne 2 -o -z "$1" -o -z "$2" ]; then
   echo
   echo "usage: $0 <project-name> <project-domain>"
   echo
   echo "example: $0 someuser default"
   echo
   exit 1
fi
project=$1
project_domain=$2
func_debug_msg "Staring $0, project = '$project' domain = $project_domain'"

##
# verify the project (function creates $project_uuid)
##
func_get_project_uuid $project $project_domain
func_debug_msg "project_uuid = $project_uuid"

##
# verify the network and subnet; create if necessary
##
network_json=`openstack network show ${project}-net -f json`
if [ $? != 0 ]; then
   func_debug_msg "Could not verify network, creating"
   func_debug_msg "TODO: CREATE NETWORK"
fi
network_uuid=`echo $network_json|jq -r '.id'`
subnet_uuid=`echo $network_json|jq -r '.subnets'`
func_debug_msg "network_uuid = $network_uuid, subnet_uuid = $subnet_uuid"

##
# verify the security group; create if necessary
##
sg_json=`openstack security group list --project $project --project-domain $project_domain -f json`
if [ $? != 0 ]; then
   count=`echo $sg_json|jq '.|length'`
   if [ $? != 0 -o $count -gt 1 ]; then
      >&2 echo "?Found multiple security groups for same project and domain or possibly could not parse json results properly."
      exit 1
   fi
   func_debug_msg "Could not verify security group, creating"
   func_debug_msg "TODO: CREATE SECURITY GROUP"
fi
sg_uuid=`echo $sg_json|jq -r '.[0]|.ID'`
func_debug_msg "security group uuid = $sg_uuid"

func_debug_msg "Done $0"
