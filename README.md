# ocrMyPDF

一个基于 [`ocrmypdf`](https://github.com/ocrmypdf/OCRmyPDF) 的 PDF OCR 自动化处理工具，支持中文和英文识别，适用于 macOS 系统。支持拖拽 PDF 文件或文件夹到终端自动处理，并可替换原文件。

---

## ✨ 功能特点

- 🧠 自动识别并 OCR 处理 PDF（中文简体 + 英文）
- 📁 支持拖拽文件或文件夹，自动遍历 PDF
- 🔁 可覆盖原始文件或另存为 `_ocr.pdf`
- 🚀 自动检测并使用多核 CPU 加速
- 🔧 集成进度提示与异常处理
- 🍎 优化支持 macOS（Apple Silicon）

---

## 📦 安装依赖

确保你已安装以下工具（macOS 用户建议使用 Homebrew）：

```bash
brew install ocrmypdf tesseract ghostscript
```

安装语言包：

```bash
brew install tesseract-lang  # 或
wget https://github.com/tesseract-ocr/tessdata/raw/main/chi_sim.traineddata \
     -P /opt/homebrew/share/tessdata/
```

你可以在 `/opt/homebrew/bin/ocrmypdf` 路径找到程序。

可选：创建 Python 虚拟环境

```bash
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

---

## 🚀 使用方式

**方法一：运行 Python 脚本（推荐）**

```bash
python3 ocrMyPDF.py
```

根据提示拖入 PDF 文件或文件夹：

```
📥 PDF OCR 工具已启动，可反复拖拽 PDF 路径到终端中使用
📂 拖入 PDF 文件路径（输入 Q 回车退出）：
>> '/Users/you/Documents/example.pdf'
```

**方法二：使用 run.sh 脚本快速启动**

```bash
chmod +x run.sh
./run.sh
```

---

## ⚙️ 核心参数说明

| 参数                | 含义                                 |
|---------------------|--------------------------------------|
| --force-ocr         | 无论是否存在文本层，强制重新 OCR     |
| --language          | 设置语言（此处为 "chi_sim+eng"）     |
| --image-dpi         | 图像 DPI，推荐为 300                 |
| --tesseract-oem 1   | 使用 LSTM 引擎                       |
| --deskew            | 自动校正倾斜页面                     |
| --output-type pdf   | 输出 PDF 格式                        |
| --jobs auto         | 自动并行处理（根据 CPU 核心数）      |

---

## 📁 项目结构

```
ocrMyPDF/
├── ocrMyPDF.py        # 主程序：拖拽文件或文件夹自动识别
├── run.sh             # 运行启动脚本
├── requirements.txt   # 可选依赖（如果使用虚拟环境）
└── README.md          # 当前说明文档
```

---

## 🛠️ 示例输出

```
📄 开始处理：example.pdf
✅ 已保存至：example.pdf
```

如遇以下警告：

```
DecompressionBombWarning: Image size exceeds limit...
```

建议预处理图像或使用压缩工具降低分辨率。

---

## 🧾 注意事项

- 输出为 PDF/A，部分元数据可能被清理。
- 若未能识别中文，请确认是否正确安装 `chi_sim.traineddata`。
- 文件太大可能触发 Pillow 的安全限制（默认 250MP 像素）。

---

## 📬 联系方式

如有建议或改进想法，欢迎提出 issue 或直接交流！

