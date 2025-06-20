import subprocess
from pathlib import Path
import shlex
import os

# 调用 OCRmyPDF 对 PDF 进行 OCR 识别
def ocr_pdf(input_path: Path):
    # 如果路径不存在或不是 PDF 文件，则跳过
    if not input_path.exists() or input_path.suffix.lower() != ".pdf":
        print(f"❌ 跳过无效文件：{input_path}")
        return

    # 设置临时输出路径（添加 _ocr 后缀）
    temp_path = input_path.with_name(input_path.stem + "_ocr.pdf")
    print(f"\n📄 开始处理：{input_path.name}")

    # 调用 ocrmypdf 命令行工具处理 PDF
    result = subprocess.run([
        "/opt/homebrew/bin/ocrmypdf",  # 修改为你系统中的实际路径
        "--force-ocr",                 # 强制重新 OCR，即使已有文本层
        "--language", "chi_sim+eng",  # 使用中文简体和英文语言模型
        "--image-dpi", "300",         # 指定图像 DPI
        "--tesseract-oem", "1",       # 使用 OCR 引擎模式 1（LSTM）
        "--deskew",                   # 自动校正页面倾斜
        "--output-type", "pdfa-2",    # 输出 PDF/A-2 格式

        str(input_path),
        str(temp_path)
    ])

    # 判断处理是否成功，并替换原始文件
    if result.returncode == 0:
        os.replace(temp_path, input_path)
        print(f"✅ 已替换原始文件：{input_path.name}")
    else:
        print(f"❌ 处理失败：{input_path.name}")

# 处理传入路径，支持单个 PDF 文件或包含 PDF 的文件夹
def process_path(path: Path):
    if path.is_file() and path.suffix.lower() == ".pdf":
        ocr_pdf(path)
    elif path.is_dir():
        # 遍历文件夹内所有 PDF 文件进行处理
        for pdf_file in path.rglob("*.pdf"):
            ocr_pdf(pdf_file)
    else:
        print(f"⚠️ 无效路径：{path}")

# 主程序入口，循环等待用户拖入路径
if __name__ == "__main__":
    print("📥 PDF OCR 工具已启动，可反复拖拽 PDF/文件夹 路径到终端中使用")
    print("👉 拖入 PDF/文件夹 后按回车，输入 q 回车可退出\n")

    while True:
        try:
            # 提示用户输入路径
            raw = input("📂 拖入 PDF/文件夹 路径（输入 q 回车退出）：\n>> ").strip()
            if raw.lower() == "q":
                print("👋 已退出 OCR 工具。")
                break
            # 拆分支持多个路径输入
            inputs = shlex.split(raw)
            for path in inputs:
                # 去除双引号后处理路径
                process_path(Path(path.strip('"')))
        except KeyboardInterrupt:
            print("\n👋 已手动中止程序。")
            break