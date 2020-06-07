#!/bin/bash

#####
# CONSTANTS
####
DEFAULT_SG_DESCRIPTION="Security Group created by Atmosphere"

function func_test_os_environment {
   if [ -z "$OS_AUTH_URL" -o -z "$OS_PASSWORD" -o -z "$OS_USERNAME" -o -z "$OS_PROJECT_NAME" ]; then
      >&2 echo "?One of OS_AUTH_URL, OS_PASSWORD, OS_USERNAME OS_PROJECT_NAME is missing"
      exit 1
   fi
}

function func_debug_msg {
   if [ -n "$DEBUG" ]; then
      >&2 echo `date +"%y%m%d %H:%M:%S %Z"`" $*"
   fi
}

# $1 = project, $2 = project domain
function func_get_project_uuid {
   project_json=`openstack project show --domain $2 $1 -f json`
   if [ $? != 0 ]; then
      >&2 echo "?Could not verify project '$1' in domain '$2'"
      exit 1
   fi
   project_uuid=`echo $project_json|jq -r '.id'`
}

