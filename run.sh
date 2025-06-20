#!/bin/bash
set -e  # 遇到错误即退出

# ===============================================
# ocrMyPDF 环境初始化与启动脚本
# 创建 Python 虚拟环境，安装依赖，检查必要工具（Tesseract、Ghostscript）并启动 OCR 工具
# ===============================================

echo "🧱 正在创建虚拟环境 .venv ..."
python3 -m venv .venv  # 创建虚拟环境

echo "📦 正在安装依赖 tqdm 和 ocrmypdf ..."
source .venv/bin/activate  # 激活虚拟环境
pip install --upgrade pip  # 升级 pip
pip install tqdm ocrmypdf  # 安装必要的 Python 包

### ✅ 检查并安装 Tesseract（OCR 引擎）
echo "🔍 检查 tesseract 是否已安装 ..."
if ! command -v tesseract &> /dev/null
then
    echo "⚠️  未检测到 tesseract，正在尝试安装..."
    if ! command -v brew &> /dev/null
    then
        # 若未安装 Homebrew，则无法继续自动安装
        echo "❌ 未安装 Homebrew，无法自动安装 tesseract，请手动安装： https://brew.sh/"
        exit 1
    else
        brew install tesseract  # 使用 Homebrew 安装 tesseract
    fi
else
    echo "✅ tesseract 已安装"
fi

### ✅ 检查并安装 Ghostscript（PDF 支持工具）
echo "🔍 检查 ghostscript (gs) 是否已安装 ..."
if ! command -v gs &> /dev/null
then
    echo "⚠️  未检测到 ghostscript，正在尝试安装..."
    brew install ghostscript
else
    echo "✅ ghostscript 已安装"
fi

### ✅ 检查 Tesseract 中文语言包（chi_sim）
echo "🔍 检查 Tesseract 是否包含 chi_sim 中文语言包 ..."
if ! tesseract --list-langs | grep -q "chi_sim"; then
    echo "⚠️  未检测到 chi_sim，正在安装中文语言包 ..."
    brew install tesseract-lang
else
    echo "✅ chi_sim 中文语言包已安装"
fi

### ✅ 启动 OCR 工具主程序
echo "🚀 启动 OCR 工具 ..."
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"  # 获取当前脚本所在目录
python3 "$SCRIPT_DIR/ocrMyPDF.py"  # 执行主 Python 脚本
