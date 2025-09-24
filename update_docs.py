#!/usr/bin/env python3
"""
Скрипт для обновления папки docs для GitHub Pages
"""

import shutil
import os
from pathlib import Path

def update_docs():
    # Предпочитаем продовую Flutter-сборку, если она есть
    build_web_dir = Path("build/web")
    web_dir = Path("web")
    source_dir = build_web_dir if build_web_dir.exists() else web_dir
    docs_dir = Path("docs")
    
    print("🔄 Обновляем папку docs для GitHub Pages...")
    
    # Создаем папку docs если её нет
    docs_dir.mkdir(exist_ok=True)
    
    # Полностью синхронизируем содержимое source -> docs (включая подкаталоги)
    # 1) Удаляем старые файлы (кроме README.md и .well-known)
    for dest_child in docs_dir.iterdir():
        if dest_child.name in ["README.md", ".well-known"]:
            continue
        if dest_child.is_file():
            dest_child.unlink()
        elif dest_child.is_dir():
            shutil.rmtree(dest_child)

    # 2) Копируем все содержимое рекурсивно
    for root, dirs, files in os.walk(source_dir):
        rel_root = Path(root).relative_to(source_dir)
        target_root = docs_dir / rel_root
        target_root.mkdir(parents=True, exist_ok=True)
        for file_name in files:
            src_path = Path(root) / file_name
            dst_path = target_root / file_name
            shutil.copy2(src_path, dst_path)
            print(f"✅ Скопирован: {dst_path.relative_to(docs_dir)}")
    
    # 3) Копируем .well-known из корня проекта (если есть)
    well_known_src = Path(".well-known")
    if well_known_src.exists():
        well_known_dst = docs_dir / ".well-known"
        well_known_dst.mkdir(exist_ok=True)
        for file_path in well_known_src.glob("*"):
            if file_path.is_file():
                dst_path = well_known_dst / file_path.name
                shutil.copy2(file_path, dst_path)
                print(f"✅ Скопирован: .well-known/{file_path.name}")
    
    print("🎉 Обновление завершено!")
    print("💡 Теперь можно коммитить изменения для деплоя на GitHub Pages")

if __name__ == "__main__":
    update_docs()
