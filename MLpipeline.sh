#!/bin/bash

#SBATCH -N 5
#SBATCH --ntasks-per-node 10
#SBATCH --cpus-per-task 1
#SBATCH --mem 10000
#SBATCH -t 100:00:00

srun ./wrapper1.sh

sh /storage/software/MATLAB_R2013b/bin/matlab -nodisplay -nosplash -nojvm -r "combine_results(50)"
