#!/bin/bash

#SBATCH -N 5
#SBATCH --ntasks-per-node 10
#SBATCH --cpus-per-task 2
#SBATCH --mem 7000
#SBATCH -t 100:00:00
#SBATCH --mail-type=END
#SBATCH --mail-user=korjus@gmail.com

# Fixing some parameters for both of the experiments

export number_of_runs=20
export total_number_of_runs=1000

# Fixing some parameters for the second experiment

export leave_out="[10:20:90]/100"

#
# Data set 4: random
#

export experiment_name="random"
export data_title="random"
export data_location="../data/data_random.mat"
export x_values="40:60:100"
export p_value=0.05

srun ./wrapper1.sh 
sh /storage/software/MATLAB_R2013b/bin/matlab -nodisplay -nosplash -nojvm -r "cd('src_matlab'); combine_results($total_number_of_runs,'$experiment_name'); exit;"

export experiment_name="random_fix"
export fix_x=100

srun ./wrapper2.sh 
sh /storage/software/MATLAB_R2013b/bin/matlab -nodisplay -nosplash -nojvm -r "cd('src_matlab'); combine_results($total_number_of_runs,'$experiment_name'); exit;"
