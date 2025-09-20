#!/usr/bin/env python3
"""
Простой HTTP сервер для тестирования веб-страницы QR Pay
Запустите этот скрипт и откройте http://localhost:8080 в браузере
"""

import http.server
import socketserver
import os
import webbrowser
from pathlib import Path

PORT = 8080
WEB_DIR = Path(__file__).parent / "web"

class CustomHTTPRequestHandler(http.server.SimpleHTTPRequestHandler):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, directory=str(WEB_DIR), **kwargs)
    
    def end_headers(self):
        # Добавляем CORS заголовки для WebView
        self.send_header('Access-Control-Allow-Origin', '*')
        self.send_header('Access-Control-Allow-Methods', 'GET, POST, OPTIONS')
        self.send_header('Access-Control-Allow-Headers', 'Content-Type')
        super().end_headers()

def main():
    # Проверяем, что директория web существует
    if not WEB_DIR.exists():
        print(f"Ошибка: Директория {WEB_DIR} не найдена!")
        return
    
    # Переходим в директорию web
    os.chdir(WEB_DIR)
    
    with socketserver.TCPServer(("", PORT), CustomHTTPRequestHandler) as httpd:
        print(f"🚀 Сервер запущен на http://localhost:{PORT}")
        print(f"📁 Обслуживается директория: {WEB_DIR}")
        print("🛑 Нажмите Ctrl+C для остановки сервера")
        
        try:
            # Автоматически открываем браузер
            webbrowser.open(f'http://localhost:{PORT}')
            httpd.serve_forever()
        except KeyboardInterrupt:
            print("\n🛑 Сервер остановлен")

if __name__ == "__main__":
    main()
