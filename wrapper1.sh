#!/bin/bash

echo "Hello from wrapper 1: $SLURM_PROCID"
sh /storage/software/MATLAB_R2013b/bin/matlab -nodisplay -nosplash -nojvm -r "main(20:4:140, $SLURM_PROCID)"