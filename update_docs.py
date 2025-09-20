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
    
    # Копируем все файлы из web в docs
    for file_path in web_dir.glob("*"):
        if file_path.is_file():
            dest_path = docs_dir / file_path.name
            shutil.copy2(file_path, dest_path)
            print(f"✅ Скопирован: {file_path.name}")
    
    print("🎉 Обновление завершено!")
    print("💡 Теперь можно коммитить изменения для деплоя на GitHub Pages")

if __name__ == "__main__":
    update_docs()
