# Настройка GitHub Pages для QR Pay

## 🚀 Автоматический деплой настроен!

Я создал GitHub Actions workflows для автоматического деплоя вашего сайта на GitHub Pages.

## 📋 Что нужно сделать:

### 1. Включить GitHub Pages в настройках репозитория:

1. Перейдите в ваш репозиторий: https://github.com/alexandrovechkin73-a11y/qrpay
2. Нажмите на вкладку **Settings**
3. Прокрутите вниз до раздела **Pages**
4. В разделе **Source** выберите **GitHub Actions**
5. Сохраните настройки

### 2. Проверить деплой:

1. Перейдите в вкладку **Actions** в вашем репозитории
2. Вы должны увидеть workflow "Deploy Static Site to GitHub Pages"
3. Дождитесь завершения (обычно 1-2 минуты)
4. Ваш сайт будет доступен по адресу: https://alexandrovechkin73-a11y.github.io/qrpay

## 🔧 Что было настроено:

### GitHub Actions Workflows:

1. **`.github/workflows/deploy-simple.yml`** - Деплой статических файлов из папки `web/`
2. **`.github/workflows/deploy-pages.yml`** - Деплой Flutter web приложения

### Обновленные файлы:

- `lib/main.dart` - URL обновлен на GitHub Pages
- `lib/screens/payment_screen.dart` - URL обновлен на GitHub Pages
- `web/index.html` - Современная веб-страница для QR Pay

## 🌐 URL вашего сайта:

**https://alexandrovechkin73-a11y.github.io/qrpay**

## 📱 Тестирование WebView:

1. Запустите Flutter приложение: `flutter run`
2. Нажмите кнопку "Открыть веб-версию" или иконку WebView
3. Приложение откроет веб-страницу через WebView

## 🔄 Автоматическое обновление:

Теперь при каждом push в ветку `main`:
1. GitHub Actions автоматически соберет и задеплоит сайт
2. Изменения появятся на GitHub Pages в течение 1-2 минут
3. WebView в приложении будет показывать актуальную версию

## 🛠️ Если что-то не работает:

1. Проверьте вкладку **Actions** - есть ли ошибки в workflow
2. Убедитесь, что GitHub Pages включен в настройках
3. Проверьте, что файл `web/index.html` существует
4. Попробуйте принудительно запустить workflow

## 📞 Поддержка:

Если возникнут проблемы, проверьте:
- Логи в GitHub Actions
- Настройки Pages в репозитории
- Правильность URL в коде приложения
