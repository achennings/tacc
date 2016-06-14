#!/bin/bash

if [ $# -lt 1 ]; then
    partition=normal
else
    partition=$1
fi

job_dir=${BATCHDIR}
lastjob=`squeue -u $USER -h -o "%i" -p $partition -S 'p,i' | tail -n 1`
echo $lastjob
