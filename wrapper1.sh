#!/bin/bash

echo "Hello from wrapper 1, SLURM_PROCID: $SLURM_PROCID"

sh /storage/software/MATLAB_R2013b/bin/matlab -nodisplay -nosplash -nojvm -r "cd('src_matlab'); main('$data_location', '$experiment_name', $x_values, $SLURM_PROCID, $number_of_runs); exit;"