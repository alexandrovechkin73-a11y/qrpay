# 🚀 Настройка GitHub Pages для QR Pay

## 📋 Пошаговая инструкция

### Шаг 1: Настройте GitHub Pages
1. Перейдите в настройки репозитория: `https://github.com/alexandrovechkin73-ally/qrpay/settings`
2. Перейдите в раздел **"Pages"**
3. В разделе **"Source"** выберите **"Deploy from a branch"**
4. Выберите ветку **"main"** и папку **"/docs"**
5. Нажмите **"Save"**

### Шаг 2: Отправьте изменения
```bash
git add docs/
git commit -m "Add static demo site for GitHub Pages"
git push origin main
```

### Шаг 3: Проверьте результат
Через 2-3 минуты ваше приложение будет доступно по ссылке:
**https://alexandrovechkin73-ally.github.io/qrpay/**

## ✅ Что получится

- 🌐 **Статический сайт** без проблем с правами доступа
- 🎨 **Красивая демо-страница** с инструкциями
- 📱 **Описание WebView функциональности**
- 🔗 **Ссылки на репозиторий** и тестовые страницы

## 🎯 Готово!

Теперь вы можете отправить ссылку `https://alexandrovechkin73-ally.github.io/qrpay/` любому человеку для тестирования!

## 🔧 Альтернативный способ

Если GitHub Pages не работает, можно использовать:
- **Netlify**: Перетащите папку `docs/` на netlify.com
- **Vercel**: Подключите репозиторий к vercel.com
- **GitHub Codespaces**: Запустите приложение в браузере
