import os
from ase.io import read, write
import math

def split_xyz_into_groups(xyz_file, num_groups=10):
    all_structures = read(xyz_file, index=':')
    total = len(all_structures)
    group_size = math.ceil(total / num_groups)

    for group_idx in range(num_groups):
        group_dir = f"group_{group_idx}"
        os.makedirs(group_dir, exist_ok=True)

        start = group_idx * group_size
        end = min(start + group_size, total)
        group_structures = all_structures[start:end]

        for i, atoms in enumerate(group_structures, start=1):
            output_file = os.path.join(group_dir, f"POSCAR_{i}")
            write(output_file, atoms, format='vasp', sort=True, vasp5=True, direct=True)

if __name__ == '__main__':
    xyz_file = 'D1.xyz'  # 替换为你的输入文件名
    split_xyz_into_groups(xyz_file, num_groups=10)

