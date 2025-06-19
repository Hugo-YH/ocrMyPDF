#!/bin/bash
set -e  # 遇到错误即退出

echo "🧱 正在创建虚拟环境 .venv ..."
python3 -m venv .venv

echo "📦 正在安装依赖 tqdm 和 ocrmypdf ..."
source .venv/bin/activate
pip install --upgrade pip
pip install tqdm ocrmypdf

### ✅ 检查并安装 Tesseract
echo "🔍 检查 tesseract 是否已安装 ..."
if ! command -v tesseract &> /dev/null
then
    echo "⚠️  未检测到 tesseract，正在尝试安装..."
    if ! command -v brew &> /dev/null
    then
        echo "❌ 未安装 Homebrew，无法自动安装 tesseract，请手动安装： https://brew.sh/"
        exit 1
    else
        brew install tesseract
    fi
else
    echo "✅ tesseract 已安装"
fi

### ✅ 检查并安装 Ghostscript
echo "🔍 检查 ghostscript (gs) 是否已安装 ..."
if ! command -v gs &> /dev/null
then
    echo "⚠️  未检测到 ghostscript，正在尝试安装..."
    brew install ghostscript
else
    echo "✅ ghostscript 已安装"
fi

### ✅ 检查中文语言包 chi_sim 是否安装
echo "🔍 检查 Tesseract 是否包含 chi_sim 中文语言包 ..."
if ! tesseract --list-langs | grep -q "chi_sim"; then
    echo "⚠️  未检测到 chi_sim，正在安装中文语言包 ..."
    brew install tesseract-lang
else
    echo "✅ chi_sim 中文语言包已安装"
fi

### ✅ 启动 Python 脚本
echo "🚀 启动 OCR 工具 ..."
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
python3 "$SCRIPT_DIR/ocrMyPDF.py"
