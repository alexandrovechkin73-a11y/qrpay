#!/usr/bin/env python3
import requests

def check_site():
    url = "https://alexandrovechkin73-a11y.github.io/qrpay"
    
    try:
        response = requests.get(url, timeout=10)
        print(f"Status: {response.status_code}")
        
        if "QR Pay" in response.text and "Аренда павербанка" in response.text:
            print("✅ Правильный контент загружен!")
            print("🎉 WebView теперь будет показывать кастомную страницу")
        else:
            print("❌ Неправильный контент")
            print("Содержимое:")
            print(response.text[:500] + "...")
            
    except Exception as e:
        print(f"Ошибка: {e}")

if __name__ == "__main__":
    check_site()
