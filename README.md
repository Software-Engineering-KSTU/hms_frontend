

### Шаг4: Скачать плагины
1. Заходим в настройки Android Studio( напротив иконки Android Studio есть кнопка настройки)
2. Заходим в plugins 
3. В поиске вводим Flutter, устанавливаем
4. Потом в посике вводим Dart, устанавливаем

### Шаг 5: Склонировать проект

1. Открой Android Studio(Проекты должны быть закрыты)
2. Нажмите три точки напротив кнопки open
3. Выберити get from verisons control...
4. В url укажите ссылку https://github.com/em-kstu/hms.git
5. В Directory укажите местоположение длл проекта
6. Октройте проект(если он автоматически не откроется)
7. В терминале введите "git checkout main_frontend" для перехода на ветку фронтенда

### Шаг 6: Указать путь до dart sdk

Открыть файл lib/main.dart в android studio проекте
<img width="2024" height="96" alt="warning-dart" src="https://github.com/user-attachments/assets/c3242c18-c58e-424a-ae23-f69328bc422c" />

далее выше будет сообщение указать путь до dart sdk, который находится по следующему пути:

.../flutter/bin/cache/dart-sdk

### Шаг 7: Скачать зависимости
Необходимо ввести следующу команду в консоли проекта:

android studio terminal
flutter pub get
### Шаг 8: Запуск проекта
1. Выберите в верхней панеле "устройство" Chome (web)
2. Выбрать зеленый треугольник
<img width="383" height="206" alt="image" src="https://github.com/user-attachments/assets/a125afed-4d7d-4cbb-b40b-7ea0ae354b07" />
