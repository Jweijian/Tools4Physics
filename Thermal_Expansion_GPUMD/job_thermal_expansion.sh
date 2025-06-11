#!/bin/bash

# 定义温度和压力列表
temperatures=(300 500 700)
pressures=(1 5 10)

for T in "${temperatures[@]}"; do
  for P in "${pressures[@]}"; do
    folder="T${T}_P${P}"
    mkdir -p "$folder"
    cp run.in sub_gpumd.sh model.xyz nep.txt "$folder"
    sed -i "s/temperature/${T}/g" "$folder/run.in"
    sed -i "s/pressure/${P}/g" "$folder/run.in"
    cd $folder
    sbatch sub_gpumd.sh
    cd ../
  done
done

echo "所有任务文件夹已生成并配置完成。"

