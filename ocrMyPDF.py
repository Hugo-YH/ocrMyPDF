import subprocess
from pathlib import Path
import shlex
import os

def ocr_pdf(input_path: Path):
    if not input_path.exists() or input_path.suffix.lower() != ".pdf":
        print(f"❌ 跳过无效文件：{input_path}")
        return

    temp_path = input_path.with_name(input_path.stem + "_ocr.pdf")
    print(f"\n📄 开始处理：{input_path.name}")

    result = subprocess.run([
        "/opt/homebrew/bin/ocrmypdf",  # 修改为你系统中的实际路径
        "--force-ocr",
        "--language", "chi_sim+eng",
        "--image-dpi", "300",
        "--tesseract-oem", "1",
        "--deskew",
        "--output-type", "pdfa-2",   # 修改PDF类型，pdf或pdfa-2

        str(input_path),
        str(temp_path)
    ])

    if result.returncode == 0:
        os.replace(temp_path, input_path)
        print(f"✅ 已替换原始文件：{input_path.name}")
    else:
        print(f"❌ 处理失败：{input_path.name}")

def process_path(path: Path):
    if path.is_file() and path.suffix.lower() == ".pdf":
        ocr_pdf(path)
    elif path.is_dir():
        for pdf_file in path.rglob("*.pdf"):
            ocr_pdf(pdf_file)
    else:
        print(f"⚠️ 无效路径：{path}")

if __name__ == "__main__":
    print("📥 PDF OCR 工具已启动，可反复拖拽 PDF/文件夹 路径到终端中使用")
    print("👉 拖入 PDF/文件夹 后按回车，输入 q 回车可退出\n")

    while True:
        try:
            raw = input("📂 拖入 PDF/文件夹 路径（输入 q 回车退出）：\n>> ").strip()
            if raw.lower() == "q":
                print("👋 已退出 OCR 工具。")
                break
            inputs = shlex.split(raw)
            for path in inputs:
                process_path(Path(path.strip('"')))
        except KeyboardInterrupt:
            print("\n👋 已手动中止程序。")
            break