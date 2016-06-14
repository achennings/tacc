#!/bin/bash

command=$1

opt="-c $HOME/la.txt -nodesktop -nodisplay -nosplash"

max_attempts=20
n_attempt=0
echo "Matlab command: $command"
echo "Attempting to launch Matlab..."
cmd="module load matlab/2015b; matlab $opt -r \"$command; exit\""
until bash -l -c "$cmd"; do
    echo "Launch attempt failed. Will try again in 30 seconds..."
    sleep 30
    let n_attempt++
    if [ $n_attempt -eq $max_attempts ]; then
	echo "Attempted to start Matlab $n_attempt times. Quitting..."
	exit 1
    fi
done
