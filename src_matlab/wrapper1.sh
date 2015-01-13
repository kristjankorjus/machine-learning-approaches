#!/bin/bash

echo "Hello from wrapper 1: $SLURM_PROCID"
echo $temp
sh /storage/software/MATLAB_R2013b/bin/matlab -nodisplay -nosplash -nojvm -r "main(16:2:30, $SLURM_PROCID, 'test1_mnist', '../data/data_mnist.mat')"