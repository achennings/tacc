#!/bin/bash

cd $BATCHDIR
jobfile=matlab_cmds.txt
if [ -e $jobfile ]; then
    rm $jobfile
fi

n_node=1
n_rep=$((n_node*24))
for i in `seq 1 $n_rep`; do
    echo "batch_matlab.sh \"disp(cantor())\"" >> $jobfile
done

launch -s $jobfile -J test_matlab -r 00:05:00 -N $n_node -n 4 -p development
