#!/bin/bash

sbatch -J test_par -r 00:20:00 -N 1 -n 1 -p development --wrap="matlab -c $HOME/la.txt -nodesktop -nodisplay -nosplash -r \"parpool; exit\""
