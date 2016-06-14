#!/bin/bash

file=$1
command=$2

full="batch_matlab.sh \"$command\""
#full="module load matlab; matlab -c $HOME/natsci.txt -nodesktop -nodisplay -nosplash -r \"$command\""
echo $full > $file
