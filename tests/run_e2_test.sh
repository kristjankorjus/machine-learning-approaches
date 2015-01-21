#!/bin/bash

#SBATCH -N 1
#SBATCH --ntasks-per-node 2
#SBATCH --cpus-per-task 2
#SBATCH --mem 10000
#SBATCH -t 100:00:00
#SBATCH --mail-type=END
#SBATCH --mail-user=korjus@gmail.com

export experiment_name="e2_test"
export number_of_runs=2
export total_number_of_runs=4
export data_location="../data/data_eyes.mat"
export fix_x=70
export p_value=0.01
export leave_out="[10, 50, 80]/100"

srun ./wrapper2.sh 

sh /storage/software/MATLAB_R2013b/bin/matlab -nodisplay -nosplash -nojvm -r "cd('src_matlab'); combine_results($total_number_of_runs,'$experiment_name'); exit;"

sh /storage/software/R-3.1.1/bin/R -q -e "setwd('src_r'); source('main2_fix_x.r'); main2_fix_x('$experiment_name',$p_value);"