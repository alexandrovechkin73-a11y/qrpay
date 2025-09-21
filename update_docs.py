#!/usr/bin/env python3
"""
Скрипт для обновления папки docs для GitHub Pages
"""

import shutil
import os
from pathlib import Path

def update_docs():
    web_dir = Path("web")
    docs_dir = Path("docs")
    
    print("🔄 Обновляем папку docs для GitHub Pages...")
    
    # Создаем папку docs если её нет
    docs_dir.mkdir(exist_ok=True)
    
    # Полностью синхронизируем содержимое web -> docs (включая подкаталоги)
    # 1) Удаляем старые файлы (кроме README.md)
    for dest_child in docs_dir.iterdir():
        if dest_child.name == "README.md":
            continue
        if dest_child.is_file():
            dest_child.unlink()
        elif dest_child.is_dir():
            shutil.rmtree(dest_child)

    # 2) Копируем все содержимое рекурсивно
    for root, dirs, files in os.walk(web_dir):
        rel_root = Path(root).relative_to(web_dir)
        target_root = docs_dir / rel_root
        target_root.mkdir(parents=True, exist_ok=True)
        for file_name in files:
            src_path = Path(root) / file_name
            dst_path = target_root / file_name
            shutil.copy2(src_path, dst_path)
            print(f"✅ Скопирован: {dst_path.relative_to(docs_dir)}")
    
    print("🎉 Обновление завершено!")
    print("💡 Теперь можно коммитить изменения для деплоя на GitHub Pages")

if __name__ == "__main__":
    update_docs()
