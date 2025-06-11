#for g in group*;do
#    cd $g;
#    for p in POSCAR_*;do
#	num=${p#POSCAR_}
#	dir="pos$num"
#        mkdir -p "$dir"             # 创建文件夹（已存在也不会报错）
#        cp "$p" "$dir/"          # 可选：复制文件进去
#        echo "Created folder $dir for $p"
#    done
#    cd ../;
#done
for i in {0..9};
    do
	   cp sub_multi_vasp.sh INCAR group_$i; 
	   cd group_$i;
	   bash sub_multi_vasp.sh;
	   cd ../;
    done
