#!/bin/bash

if [ $# -lt 1 ]; then
    echo "Usage: job_status.sh jobid"
    exit 1
fi

jobid=$1

status=`qstat | grep $jobid | tr -s ' ' | cut -d " " -f 5`
echo $status
