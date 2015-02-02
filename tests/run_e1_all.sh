#!/bin/bash

#SBATCH -N 5
#SBATCH --ntasks-per-node 10
#SBATCH --cpus-per-task 2
#SBATCH --mem 7000
#SBATCH -t 100:00:00
#SBATCH --mail-type=END
#SBATCH --mail-user=korjus@gmail.com

export number_of_runs=2
export total_number_of_runs=100

export experiment_name="e1_eeg"
export data_location="../data/data_eeg.mat"
export x_values="20:2:150"
export p_value=0.01

srun ./wrapper1.sh 

sh /storage/software/MATLAB_R2013b/bin/matlab -nodisplay -nosplash -nojvm -r "cd('src_matlab'); combine_results($total_number_of_runs,'$experiment_name'); exit;"

sh /storage/software/R-3.1.1/bin/R -q -e "setwd('src_r'); source('main.r'); main('$experiment_name',$p_value);"


export experiment_name="e1_mnist"
export data_location="../data/data_mnist.mat"
export x_values="20:2:50"
export p_value=0.001

srun ./wrapper1.sh 

sh /storage/software/MATLAB_R2013b/bin/matlab -nodisplay -nosplash -nojvm -r "cd('src_matlab'); combine_results($total_number_of_runs,'$experiment_name'); exit;"

sh /storage/software/R-3.1.1/bin/R -q -e "setwd('src_r'); source('main.r'); main('$experiment_name',$p_value);"


export experiment_name="e1_fmri"
export data_location="../data/data_fmri.mat"
export x_values="20:2:120"
export p_value=0.01

srun ./wrapper1.sh 

sh /storage/software/MATLAB_R2013b/bin/matlab -nodisplay -nosplash -nojvm -r "cd('src_matlab'); combine_results($total_number_of_runs,'$experiment_name'); exit;"

sh /storage/software/R-3.1.1/bin/R -q -e "setwd('src_r'); source('main.r'); main('$experiment_name',$p_value);"


export experiment_name="e1_random"
export data_location="../data/data_random.mat"
export x_values="20:4:100"
export p_value=0.01

srun ./wrapper1.sh 

sh /storage/software/MATLAB_R2013b/bin/matlab -nodisplay -nosplash -nojvm -r "cd('src_matlab'); combine_results($total_number_of_runs,'$experiment_name'); exit;"

sh /storage/software/R-3.1.1/bin/R -q -e "setwd('src_r'); source('main.r'); main('$experiment_name',$p_value);"