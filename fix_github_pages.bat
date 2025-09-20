@echo off
echo 🔧 Исправляем GitHub Pages...
echo.

echo 📁 Проверяем статус git...
git status

echo.
echo 📁 Добавляем все файлы...
git add .

echo.
echo 💾 Создаем коммит...
git commit -m "Force GitHub Pages deployment"

echo.
echo 🚀 Отправляем на GitHub...
git push origin main

echo.
echo ✅ Готово! Теперь:
echo 1. Перейдите в https://github.com/alexandrovechkin73-a11y/qrpay/actions
echo 2. Дождитесь завершения workflow (зеленая галочка)
echo 3. Проверьте сайт: https://alexandrovechkin73-a11y.github.io/qrpay
echo.
echo 📱 WebView в приложении должен показать красивую страницу!
pause
