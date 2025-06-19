# 🧾 ocrMyPDF

一个基于 [ocrmypdf](https://github.com/ocrmypdf/OCRmyPDF) 的命令行工具，可对已有 PDF 文件执行 OCR（光学字符识别）处理，使其可被搜索和检索。

## 📌 项目特点

- 支持中文与英文混合 OCR（使用 `chi_sim+eng` 语言包）
- 自动跳过非 PDF 文件和已含文本的 PDF
- 可拖拽 PDF 路径至终端使用
- 处理完成后自动替换原文件

## 🛠️ 环境要求

- Python 3.7+
- 推荐操作系统：macOS（默认路径适配 Homebrew 安装）
- 安装依赖工具：
  - [`ocrmypdf`](https://pypi.org/project/ocrmypdf/)
  - `tesseract`（推荐通过 brew 安装并配置语言包）

## 📦 安装依赖

```bash
pip install --upgrade ocrmypdf
brew install tesseract
brew install ocrmypdf

# 安装中文语言包
brew install tesseract-lang
