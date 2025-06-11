#!/bin/sh
#SBATCH -p qgpu_3090
#SBATCH --gres=gpu:1
#SBATCH --mem=20G
#SBATCH --job-name=JWJ-NaCl
module load gpumd/3.9.1
gpumd < run.in > gpumd.out

