#!/bin/bash

#SBATCH -N 5
#SBATCH --ntasks-per-node 10
#SBATCH --cpus-per-task 2
#SBATCH --mem 7000
#SBATCH -t 100:00:00
#SBATCH --mail-type=END
#SBATCH --mail-user=korjus@gmail.com

# Fixing some parameters for both of the experiments

export number_of_runs=1
export total_number_of_runs=50

# Fixing some parameters for the second experiment

export leave_out="[5:5:85]/100"


#
# Data set 1: eeg
#

export experiment_name="eeg"
export data_location="../data/data_eeg.mat"
export x_values="20:5:150"
export p_value=0.01

srun ./wrapper1.sh 
sh /storage/software/MATLAB_R2013b/bin/matlab -nodisplay -nosplash -nojvm -r "cd('src_matlab'); combine_results($total_number_of_runs,'$experiment_name'); exit;"
sh /storage/software/R-3.1.1/bin/R -q -e "setwd('src_r'); source('main.r'); main('$experiment_name',$p_value);"

export experiment_name="eeg_fix"
export fix_x=100

srun ./wrapper2.sh 
sh /storage/software/MATLAB_R2013b/bin/matlab -nodisplay -nosplash -nojvm -r "cd('src_matlab'); combine_results($total_number_of_runs,'$experiment_name'); exit;"
sh /storage/software/R-3.1.1/bin/R -q -e "setwd('src_r'); source('main2_fix_x.r'); main2_fix_x('$experiment_name',$p_value);"


#
# Data set 2: fmri
#

export experiment_name="fmri"
export data_location="../data/data_fmri.mat"
export x_values="20:5:60"
export p_value=0.001

srun ./wrapper1.sh 
sh /storage/software/MATLAB_R2013b/bin/matlab -nodisplay -nosplash -nojvm -r "cd('src_matlab'); combine_results($total_number_of_runs,'$experiment_name'); exit;"
sh /storage/software/R-3.1.1/bin/R -q -e "setwd('src_r'); source('main.r'); main('$experiment_name',$p_value);"

export experiment_name="fmri_fix"
export fix_x=50

srun ./wrapper2.sh 
sh /storage/software/MATLAB_R2013b/bin/matlab -nodisplay -nosplash -nojvm -r "cd('src_matlab'); combine_results($total_number_of_runs,'$experiment_name'); exit;"
sh /storage/software/R-3.1.1/bin/R -q -e "setwd('src_r'); source('main2_fix_x.r'); main2_fix_x('$experiment_name',$p_value);"


#
# Data set 3: spikes
#

export experiment_name="spikes"
export data_location="../data/data_spikes.mat"
export x_values="20:5:150"
export p_value=0.01

srun ./wrapper1.sh 
sh /storage/software/MATLAB_R2013b/bin/matlab -nodisplay -nosplash -nojvm -r "cd('src_matlab'); combine_results($total_number_of_runs,'$experiment_name'); exit;"
sh /storage/software/R-3.1.1/bin/R -q -e "setwd('src_r'); source('main.r'); main('$experiment_name',$p_value);"

export experiment_name="spikes_fix"
export fix_x=100

srun ./wrapper2.sh 
sh /storage/software/MATLAB_R2013b/bin/matlab -nodisplay -nosplash -nojvm -r "cd('src_matlab'); combine_results($total_number_of_runs,'$experiment_name'); exit;"
sh /storage/software/R-3.1.1/bin/R -q -e "setwd('src_r'); source('main2_fix_x.r'); main2_fix_x('$experiment_name',$p_value);"


#
# Data set 4: mnist
#

export experiment_name="mnist"
export data_location="../data/data_mnist.mat"
export x_values="20:5:50"
export p_value=0.001

srun ./wrapper1.sh 
sh /storage/software/MATLAB_R2013b/bin/matlab -nodisplay -nosplash -nojvm -r "cd('src_matlab'); combine_results($total_number_of_runs,'$experiment_name'); exit;"
sh /storage/software/R-3.1.1/bin/R -q -e "setwd('src_r'); source('main.r'); main('$experiment_name',$p_value);"

export experiment_name="mnist_fix"
export fix_x=26

srun ./wrapper2.sh 
sh /storage/software/MATLAB_R2013b/bin/matlab -nodisplay -nosplash -nojvm -r "cd('src_matlab'); combine_results($total_number_of_runs,'$experiment_name'); exit;"
sh /storage/software/R-3.1.1/bin/R -q -e "setwd('src_r'); source('main2_fix_x.r'); main2_fix_x('$experiment_name',$p_value);"


#
# Data set 5: gen
#

export experiment_name="gen"
export data_location="../data/data_gen.mat"
export x_values="20:5:100"
export p_value=0.01

srun ./wrapper1.sh 
sh /storage/software/MATLAB_R2013b/bin/matlab -nodisplay -nosplash -nojvm -r "cd('src_matlab'); combine_results($total_number_of_runs,'$experiment_name'); exit;"
sh /storage/software/R-3.1.1/bin/R -q -e "setwd('src_r'); source('main.r'); main('$experiment_name',$p_value);"

export experiment_name="gen_fix"
export fix_x=30

srun ./wrapper2.sh 
sh /storage/software/MATLAB_R2013b/bin/matlab -nodisplay -nosplash -nojvm -r "cd('src_matlab'); combine_results($total_number_of_runs,'$experiment_name'); exit;"
sh /storage/software/R-3.1.1/bin/R -q -e "setwd('src_r'); source('main2_fix_x.r'); main2_fix_x('$experiment_name',$p_value);"


#
# Data set 6: random
#

export experiment_name="random"
export data_location="../data/data_random.mat"
export x_values="20:5:100"
export p_value=0.05

srun ./wrapper1.sh 
sh /storage/software/MATLAB_R2013b/bin/matlab -nodisplay -nosplash -nojvm -r "cd('src_matlab'); combine_results($total_number_of_runs,'$experiment_name'); exit;"
sh /storage/software/R-3.1.1/bin/R -q -e "setwd('src_r'); source('main.r'); main('$experiment_name',$p_value);"

export experiment_name="random_fix"
export fix_x=30

srun ./wrapper2.sh 
sh /storage/software/MATLAB_R2013b/bin/matlab -nodisplay -nosplash -nojvm -r "cd('src_matlab'); combine_results($total_number_of_runs,'$experiment_name'); exit;"
sh /storage/software/R-3.1.1/bin/R -q -e "setwd('src_r'); source('main2_fix_x.r'); main2_fix_x('$experiment_name',$p_value);"
