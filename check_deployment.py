#!/usr/bin/env python3
"""
Скрипт для проверки статуса деплоя на GitHub Pages
"""

import requests
import time
import sys

def check_github_pages():
    url = "https://alexandrovechkin73-a11y.github.io/qrpay"
    
    print("🔍 Проверяем статус GitHub Pages...")
    print(f"URL: {url}")
    
    try:
        response = requests.get(url, timeout=10)
        
        if response.status_code == 200:
            print("✅ Сайт доступен!")
            print(f"📊 Статус: {response.status_code}")
            print(f"📏 Размер: {len(response.content)} байт")
            
            # Проверяем, что это наш контент
            if "QR Pay" in response.text:
                print("✅ Контент загружен корректно!")
                return True
            else:
                print("⚠️  Контент не соответствует ожидаемому")
                return False
                
        elif response.status_code == 404:
            print("❌ Сайт не найден (404)")
            print("💡 Возможные причины:")
            print("   - GitHub Pages еще не активирован")
            print("   - Workflow еще не завершился")
            print("   - Неправильные настройки Pages")
            return False
            
        else:
            print(f"❌ Ошибка: {response.status_code}")
            return False
            
    except requests.exceptions.RequestException as e:
        print(f"❌ Ошибка подключения: {e}")
        return False

def main():
    print("🚀 QR Pay - Проверка деплоя GitHub Pages")
    print("=" * 50)
    
    # Проверяем несколько раз с интервалом
    for attempt in range(1, 4):
        print(f"\n🔄 Попытка {attempt}/3:")
        
        if check_github_pages():
            print("\n🎉 Деплой успешен!")
            sys.exit(0)
        else:
            if attempt < 3:
                print("⏳ Ждем 30 секунд перед следующей попыткой...")
                time.sleep(30)
    
    print("\n❌ Деплой не удался после 3 попыток")
    print("\n🔧 Рекомендации:")
    print("1. Проверьте настройки GitHub Pages в репозитории")
    print("2. Убедитесь, что workflow завершился успешно")
    print("3. Проверьте вкладку Actions в GitHub")
    
    sys.exit(1)

if __name__ == "__main__":
    main()
