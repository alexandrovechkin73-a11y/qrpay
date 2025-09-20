@echo off
echo 🚀 Деплой QR Pay на GitHub Pages...
echo.

echo 📁 Добавляем файлы в git...
git add .

echo 💾 Создаем коммит...
git commit -m "Fix GitHub Pages deployment - use docs folder"

echo 🚀 Отправляем на GitHub...
git push origin main

echo.
echo ✅ Готово! Подождите 1-2 минуты и проверьте:
echo 🌐 https://alexandrovechkin73-a11y.github.io/qrpay
echo.
echo 📱 Теперь WebView в приложении покажет красивую страницу!
pause
