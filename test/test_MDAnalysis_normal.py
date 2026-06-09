import MDAnalysis as mda

# 1. 定义你的文件路径（请根据你的真实路径微调）
prmtop_path = "/data/student/xujia/FGFR2/FGFR_projection/four_systems/FGFR2_clayton_md/extracted_systems/K659E/4j97_com_solv.prmtop"
trajectory_path = "/data/student/xujia/FGFR2/FGFR_projection/four_systems/FGFR2_clayton_md/extracted_systems/K659E/4j97_com_solv.inpcrd"

try:
    # 2. 尝试让 MDAnalysis 加载它们
    #u = mda.Universe(prmtop_path, trajectory_path)
    u = mda.Universe(prmtop_path, trajectory_path)
    print(f"Successfully！Totlally {len(u.atoms)} atoms")
    
    #3. 尝试切换到第一帧（Frame 0）并读取坐标
    u.trajectory[0]
    first_atom_pos = u.atoms[0].position
    print(f"First atom coordinate is: {first_atom_pos}")
    print("Test pass")

except Exception as e:
    print(f"Error in Reading the crd file: {e}")