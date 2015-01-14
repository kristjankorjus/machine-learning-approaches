#!/bin/bash

#SBATCH -N 1
#SBATCH --ntasks-per-node 2
#SBATCH --cpus-per-task 1
#SBATCH --mem 10000
#SBATCH -t 100:00:00
#SBATCH --mail-type=END
#SBATCH --mail-user=korjus@gmail.com

export experiment_name="test_par"
export number_of_processes=2
export data_location="../data/data_mnist.mat"
export x_values="16:4:24"
export p_value=0.001

srun ./wrapper1.sh 

sh /storage/software/MATLAB_R2013b/bin/matlab -nodisplay -nosplash -nojvm -r "cd('src_matlab'); combine_results($number_of_processes,'$experiment_name'); exit;"

sh /storage/software/R-3.1.1/bin/R -q -e "setwd('src_r'); source('main.r'); main('$experiment_name',$p_value);"