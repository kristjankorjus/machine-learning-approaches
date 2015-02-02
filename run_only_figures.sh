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
export data_title="EEG"
export p_value=0.01

sh /storage/software/R-3.1.1/bin/R -q -e "setwd('src_r'); source('main.r'); main('$experiment_name',$p_value,'$data_title');"

export experiment_name="eeg_fix"

sh /storage/software/R-3.1.1/bin/R -q -e "setwd('src_r'); source('main2_fix_x.r'); main2_fix_x('$experiment_name',$p_value,'$data_title');"


#
# Data set 2: fmri
#

export experiment_name="fmri"
export data_title="fmri"
export p_value=0.001

sh /storage/software/R-3.1.1/bin/R -q -e "setwd('src_r'); source('main.r'); main('$experiment_name',$p_value,'$data_title');"

export experiment_name="fmri_fix"

sh /storage/software/R-3.1.1/bin/R -q -e "setwd('src_r'); source('main2_fix_x.r'); main2_fix_x('$experiment_name',$p_value,'$data_title');"


#
# Data set 3: spikes
#

export experiment_name="spikes"
export data_title="spikes"
export p_value=0.01

sh /storage/software/R-3.1.1/bin/R -q -e "setwd('src_r'); source('main.r'); main('$experiment_name',$p_value,'$data_title');"

export experiment_name="spikes_fix"

sh /storage/software/R-3.1.1/bin/R -q -e "setwd('src_r'); source('main2_fix_x.r'); main2_fix_x('$experiment_name',$p_value,'$data_title');"


#
# Data set 4: mnist
#

export experiment_name="mnist"
export data_title="MNIST"
export p_value=0.001

sh /storage/software/R-3.1.1/bin/R -q -e "setwd('src_r'); source('main.r'); main('$experiment_name',$p_value,'$data_title');"

export experiment_name="mnist_fix"

sh /storage/software/R-3.1.1/bin/R -q -e "setwd('src_r'); source('main2_fix_x.r'); main2_fix_x('$experiment_name',$p_value,'$data_title');"


#
# Data set 5: gen
#

export experiment_name="gen"
export data_title="generated"
export p_value=0.01

sh /storage/software/R-3.1.1/bin/R -q -e "setwd('src_r'); source('main.r'); main('$experiment_name',$p_value,'$data_title');"

export experiment_name="gen_fix"

sh /storage/software/R-3.1.1/bin/R -q -e "setwd('src_r'); source('main2_fix_x.r'); main2_fix_x('$experiment_name',$p_value,'$data_title');"


#
# Data set 6: random
#

export experiment_name="random"
export data_title="random"
export p_value=0.05

sh /storage/software/R-3.1.1/bin/R -q -e "setwd('src_r'); source('main.r'); main('$experiment_name',$p_value,'$data_title');"

export experiment_name="random_fix"

sh /storage/software/R-3.1.1/bin/R -q -e "setwd('src_r'); source('main2_fix_x.r'); main2_fix_x('$experiment_name',$p_value,'$data_title');"
