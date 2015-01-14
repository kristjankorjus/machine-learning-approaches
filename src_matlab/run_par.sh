#!/bin/bash

#SBATCH -N 1
#SBATCH --ntasks-per-node 2
#SBATCH --cpus-per-task 1
#SBATCH --mem 10000
#SBATCH -t 100:00:00

export experiment_name="test_par"
export number_of_processes=2
export data_location="../data/data_mnist.mat"
export x_values="16:2:18"

srun ./wrapper1.sh 

sh /storage/software/MATLAB_R2013b/bin/matlab -nodisplay -nosplash -nojvm -r "combine_results($number_of_processes,'$experiment_name')"
