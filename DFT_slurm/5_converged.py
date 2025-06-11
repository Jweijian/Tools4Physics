import os
import shutil
from pymatgen.io.vasp import Vasprun

def check_vasp_convergence(folder):
    vasprun_path = os.path.join(folder, "vasprun.xml")
    if os.path.exists(vasprun_path):
        try:
            vasprun = Vasprun(vasprun_path, parse_dos=False)
            return vasprun.converged
        except Exception as e:
            return f"Error reading vasprun.xml: {e}"
    else:
        return "vasprun.xml not found"

def main():
    base_path = os.getcwd()
    for root, dirs, files in os.walk(base_path):
        if root == base_path:
            continue  # 跳过根目录
        result = check_vasp_convergence(root)
        print(f"{root}: {result}")
        if result is False or isinstance(result, str):
            print(f"Deleting: {root}")
            shutil.rmtree(root)

if __name__ == "__main__":
    main()

