#!/bin/sh






# Запрос пароля у пользователя
echo "Введите пароль для распаковки архива:"
read PASSWORD


# URL файла для скачивания
URL="https://github.com/sogonov/wartseydrufti/raw/main/TotalKlipper.zip"

# Имя скачанного файла
FILENAME="TotalKlipper.zip"

# Папка для извлечения файлов
EXTRACT_DIR="klipper"


# Команда для скачивания файла
wget $URL -O $FILENAME

# Проверка успешного скачивания
if [ $? -eq 0 ]; then
    echo "Файл успешно скачан."

    # Создание папки для извлечения
    mkdir -p $EXTRACT_DIR

    # Распаковка архива с паролем в указанную папку
    7z x -p"$PASSWORD" -o"$EXTRACT_DIR" "$FILENAME"

    # Проверка успешной распаковки
    if [ $? -eq 0 ]; then
        echo "Архив успешно распакован в папку $EXTRACT_DIR."

        # Удаление архива
        rm -f $FILENAME
        if [ $? -eq 0 ]; then
            echo "Архив успешно удален."
        else
            echo "Ошибка при удалении архива."
        fi
    else
        echo "Ошибка при распаковке архива."
    fi
else
    echo "Ошибка при скачивании файла."
fi


# Путь к файлу udev правил
UDEV_RULES_FILE="/etc/udev/rules.d/99-usb.rules"

# Содержимое udev правил
UDEV_RULES_CONTENT='SUBSYSTEM=="usb", ATTR{idVendor}=="9588", ATTR{idProduct}=="9899", MODE="0666", GROUP="plugdev"'



# Создание файла udev правил
echo $UDEV_RULES_CONTENT | sudo tee $UDEV_RULES_FILE > /dev/null

# Проверка успешного создания файла udev правил
if [ $? -eq 0 ]; then
	echo "Файл udev правил успешно создан в $UDEV_RULES_FILE."
else
	echo "Ошибка при создании файла udev правил."
fi

# Перезагрузка правил udev и активация изменений
sudo udevadm control --reload-rules && sudo udevadm trigger
# Проверка успешного выполнения команд
if [ $? -eq 0 ]; then
    echo "Правила udev успешно перезагружены и изменения активированы."
else
    echo "Ошибка при перезагрузке правил udev или активации изменений."
fi














