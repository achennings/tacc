#!/bin/bash

cd $BATCHDIR
jobfile=parpool_cmds.txt
if [ -e $jobfile ]; then
    rm $jobfile
fi

n_node=1
n_rep=1
for i in `seq 1 $n_rep`; do
    echo "batch_matlab.sh \"test_par_job(24)\"" >> $jobfile
done

launch -s $jobfile -J test_par -r 00:20:00 -N $n_node -n $n_rep -p development
