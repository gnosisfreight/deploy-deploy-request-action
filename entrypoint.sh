#!/bin/sh -l

. /.pscale/cli-helper-scripts/wait-for-dr-validation.sh 
wait_for_dr_validation 9 "$1" "$2" "$3" 60

command="pscale deploy-request deploy $1 $2 --org $3 -f json"

cmdout=$(eval $command)

ret=$?
if [ $ret -ne 0 ]; then
  exit $ret
fi

if [ "true" == "$4" ];then
  . /.pscale/cli-helper-scripts/wait-for-deploy-request-merged.sh
  wait_for_deploy_request_merged 15 "$1" "$2" "$3" 120
fi
