#!/bin/bash

# 自动切换到脚本所在目录
cd "$(dirname "$0")"

# 检查虚拟环境是否存在
if [ ! -d ".venv" ]; then
    echo "🧱 正在创建虚拟环境 .venv ..."
    python3 -m venv .venv || {
        echo "❌ 无法创建虚拟环境，请检查 Python 安装。"
        exit 1
    }
fi

# 激活虚拟环境
source .venv/bin/activate

# 安装依赖
echo "📦 正在安装依赖 tqdm 和 ocrmypdf ..."
pip install --upgrade pip
pip install tqdm ocrmypdf

# 启动 OCR 工具
echo "🚀 启动 OCR 工具 ..."
python ocrMyPDF.py