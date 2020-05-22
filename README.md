# vagrant_django_debian9_box

## Инструкция по запуску:

### Зависимости:
1. VirtualBox (Проверялось на версии 6.1)
2. Vagrant (проверялось на версии 2.2.9)

**Не забудьте перезагрузить компьютер после установки VirtualBox и Vagrant**

### Подготовка Environment:
1. Скопируйте local.env в .env (В корне проекта)
2. Скопируйте local.env в django/.env
3. Скопируйте django/django/core/gunicorn_conf_example.py в django/django/core/gunicorn_conf.py

### Запуск проекта:
```bash
cd <repo_root>
vagrant up
```

Проект будет доступен по адресу: http://192.168.99.100/

### Сборка образа:
Готовую виртуальную машину можно подготовить к экспорту в другой проект, выполнив команду:
```bash
cd <repo_root>
vagrant package --output=./vagrant_django_debian9.box
```