#!/bin/bash

#SBATCH -N 5
#SBATCH --ntasks-per-node 10
#SBATCH --cpus-per-task 2
#SBATCH --mem 7000
#SBATCH -t 100:00:00
#SBATCH --mail-type=END
#SBATCH --mail-user=korjus@gmail.com

# Fixing some parameters for both of the experiments

export number_of_runs=2
export total_number_of_runs=100

# Fixing some parameters for the second experiment

export leave_out="[10:10:90]/100"


#
# Data set 1: eeg
#

export experiment_name="eeg"
export data_title="EEG"
export data_location="../data/data_eeg.mat"
export x_values="20:10:200"
export p_value=0.01

srun ./wrapper1.sh 
sh /storage/software/MATLAB_R2013b/bin/matlab -nodisplay -nosplash -nojvm -r "cd('src_matlab'); combine_results($total_number_of_runs,'$experiment_name'); exit;"
sh /storage/software/R-3.1.1/bin/R -q -e "setwd('src_r'); source('main.r'); main('$experiment_name',$p_value,'$data_title');"

export experiment_name="eeg_fix"
export fix_x=50

srun ./wrapper2.sh 
sh /storage/software/MATLAB_R2013b/bin/matlab -nodisplay -nosplash -nojvm -r "cd('src_matlab'); combine_results($total_number_of_runs,'$experiment_name'); exit;"
sh /storage/software/R-3.1.1/bin/R -q -e "setwd('src_r'); source('main2_fix_x.r'); main2_fix_x('$experiment_name',$p_value,'$data_title');"
