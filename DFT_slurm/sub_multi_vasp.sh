#!/bin/bash

#--------- Please CHANGE --------
# 1.node number 2.core number 3.partition
# 4.program path and name
#--------- Start of Change ------
node=2             #node number
core=72            #all cpu core number
partition=long1 # TH_SHORT2
#program=$HOME/VASP/vasp5.3.5/vasp5.3.5_soc_neb_icc16_IMPI5.1  #program name and its path
#program="/THL7/home/wjyin2/chengguanjian/public/software/vasp.5.4.4/bin/vasp_std" #program name and its path
#program="/THL7/home/wjyin2/chengguanjian/public/software/vasp.5.4.4/bin/vasp_gam"
program=/fs1/home/wjyin/jiangweijian/bin/VASP/vasp-5.4.4-icc19.1-IMPI2019.8/vasp_std
#jobname=vasp5.4.1_${core}cores   #job name
jobname=JWJ_5.4 #job name
#--------- End of Change ------

subScript="Sub.sh"
\cat >$subScript <<EOF
#!/bin/bash
date
module purge
module add vasp/5.4.4
module add  MKL/21.3.0  MPI/Intel/IMPI/2021.3.0

for p in POSCAR_* 
            do
                i=\${p#POSCAR_}
                mkdir pos\$i;
                cp POSCAR_\$i pos\$i/POSCAR;
                cp INCAR pos\$i;
                cd pos\$i;
                (echo 102; echo 2; echo 0.04)|vaspkit;
                mpirun -n $core vasp_std | tee output.log
                cd ../;
            done
date
EOF

# Set environment
# module add Intel_compiler/16.0.3 MKL/16.0.3 MPI/Intel/IMPI/5.1.3.210
module purge
module add vasp/5.4.4

export MPICH_NO_BUFFER_ALIAS_CHECK=1

chmod +x $subScript
errcode=$?
if [ $errcode -eq 0 ]; then
  yhbatch -N $node -n $core -p $partition -J $jobname $subScript
fi
