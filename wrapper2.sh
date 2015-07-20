#!/bin/bash

echo "Hello from wrapper 2, SLURM_PROCID: $SLURM_PROCID"

sh /storage/software/MATLAB_R2013b/bin/matlab -nodisplay -nosplash -nojvm -r "cd('src_matlab'); main2_fix_x('$data_location', '$experiment_name', $fix_x, $leave_out, $SLURM_PROCID, $number_of_runs, $perm); exit;"