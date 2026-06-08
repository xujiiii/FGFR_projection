#!/usr/bin/env bash
# Download the FGFR2 Kinase GaMD/MSM simulation systems and trajectories.
# 
# Includes 4 systems:
#   - wt_unphos (PDB: 2PSQ)
#   - wt_phos   (PDB: 2PVF)
#   - K659E     (PDB: 4J97)
#   - N549K     (PDB: 2PVF mutant)
#
# Usage on coulomb:
#   bash download_fgfr2_md.sh /data/student/yuxiz/fgfr2_md_data
#
# The target directory will hold:
#   ./raw_archives/*.tar.gz   (4 raw system compressed archives)
#   ./extracted_systems/...   (Unpacked topology and input files)

set -euo pipefail

# 1. 设定下载目的地（默认路径如果需要更改，请修改此处或在运行时传参）
DEST="${1:-/data/student/yuxiz/fgfr2_md_data}"

# 2. 设定真实的数据包下载地址（请将下面的 URL 替换为你课题数据实际所在的 Zenodo API 链接）
# 提示：如果是 Zenodo 上的记录，通常格式为 https://zenodo.org/api/records/<RECORD_ID>/files
BASE="https://zenodo.org/api/records/14988521/files" 

mkdir -p "${DEST}/raw_archives"
mkdir -p "${DEST}/extracted_systems"
cd "${DEST}"

echo "==> Downloading 4 FGFR2 System Archives (.tar.gz)"
echo "================================================="

# 遍历子宫内膜癌研究涉及的 4 个 FGFR2 核心系统
for sys_name in \
    wt_unphos \
    wt_phos \
    k659e \
    n549k ; do
    
    fname="${sys_name}.tar.gz"
    
    # 检测文件是否已经完整下载过，防止重复下载
    if [[ -s "raw_archives/${fname}" ]]; then
        echo "  [skip] raw_archives/${fname} already present."
    else
        echo "  -> Downloading: ${fname}"
        wget --no-verbose --show-progress \
             -O "raw_archives/${fname}" \
             "${BASE}/${fname}/content"
    fi
done

echo
echo "==> Unpacking System Archives (.tar.gz) -> extracted_systems/"
echo "============================================================"

# 解压模块：将 4 个系统的拓扑与输入坐标文件静默释放
for sys_name in \
    wt_unphos \
    wt_phos \
    k659e \
    n549k ; do
    
    fname="${sys_name}.tar.gz"
    target_dir="extracted_systems/${sys_name}"
    
    # 检测目标文件夹是否存在且不为空，防止重复解压覆盖你的修改
    if [[ -d "${target_dir}" && -n "$(ls -A ${target_dir} 2>/dev/null)" ]]; then
        echo "  [skip] ${target_dir}/ already populated."
    else
        echo "  -> Unpacking ${fname} into ${target_dir}..."
        mkdir -p "${target_dir}"
        
        # 使用 tar 命令静默解压到指定目标文件夹内
        tar -zxf "raw_archives/${fname}" -C "${target_dir}"
    fi
done

echo
echo "==> Verification Summary"
echo "========================"
echo "Raw downloaded archives:"
ls -lh raw_archives

echo
echo "Extracted project directories:"
ls -lh extracted_systems

echo
echo "Total disk space usage for FGFR2 data:"
du -sh "${DEST}"