#!/bin/bash

#SBATCH -N 5
#SBATCH --ntasks-per-node 10
#SBATCH --cpus-per-task 2
#SBATCH --mem 7000
#SBATCH -t 100:00:00
#SBATCH --mail-type=END
#SBATCH --mail-user=korjus@gmail.com

# Fixing some parameters for both of the experiments

export number_of_runs=8
export total_number_of_runs=400

# Fixing some parameters for the second experiment

export leave_out="[10:10:90]/100"


#
# Data set 1: eeg
#

export experiment_name="eeg"
export data_title="EEG"
export data_location="../data/data_eeg.mat"
export x_values="20:20:160"
export p_value=0.01

srun ./wrapper1.sh 
sh /storage/software/MATLAB_R2013b/bin/matlab -nodisplay -nosplash -nojvm -r "cd('src_matlab'); combine_results($total_number_of_runs,'$experiment_name'); exit;"

export experiment_name="eeg_fix"
export fix_x=50

srun ./wrapper2.sh 
sh /storage/software/MATLAB_R2013b/bin/matlab -nodisplay -nosplash -nojvm -r "cd('src_matlab'); combine_results($total_number_of_runs,'$experiment_name'); exit;"


#
# Data set 2: spikes
#

export experiment_name="spikes"
export data_title="spikes"
export data_location="../data/data_spikes.mat"
export x_values="20:40:300"
export p_value=0.01

srun ./wrapper1.sh 
sh /storage/software/MATLAB_R2013b/bin/matlab -nodisplay -nosplash -nojvm -r "cd('src_matlab'); combine_results($total_number_of_runs,'$experiment_name'); exit;"

export experiment_name="spikes_fix"
export fix_x=100

srun ./wrapper2.sh 
sh /storage/software/MATLAB_R2013b/bin/matlab -nodisplay -nosplash -nojvm -r "cd('src_matlab'); combine_results($total_number_of_runs,'$experiment_name'); exit;"


#
# Data set 3: gen
#

export experiment_name="gen"
export data_title="generated"
export data_location="../data/data_gen.mat"
export x_values="20:40:260"
export p_value=0.01

srun ./wrapper1.sh 
sh /storage/software/MATLAB_R2013b/bin/matlab -nodisplay -nosplash -nojvm -r "cd('src_matlab'); combine_results($total_number_of_runs,'$experiment_name'); exit;"

export experiment_name="gen_fix"
export fix_x=100

srun ./wrapper2.sh 
sh /storage/software/MATLAB_R2013b/bin/matlab -nodisplay -nosplash -nojvm -r "cd('src_matlab'); combine_results($total_number_of_runs,'$experiment_name'); exit;"


#
# Data set 4: random
#

export experiment_name="random"
export data_title="random"
export data_location="../data/data_random.mat"
export x_values="20:50:120"
export p_value=0.05

srun ./wrapper1.sh 
sh /storage/software/MATLAB_R2013b/bin/matlab -nodisplay -nosplash -nojvm -r "cd('src_matlab'); combine_results($total_number_of_runs,'$experiment_name'); exit;"

export experiment_name="random_fix"
export fix_x=70

srun ./wrapper2.sh 
sh /storage/software/MATLAB_R2013b/bin/matlab -nodisplay -nosplash -nojvm -r "cd('src_matlab'); combine_results($total_number_of_runs,'$experiment_name'); exit;"
