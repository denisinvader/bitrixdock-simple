# BitrixDock Simple

Минимальное локальное окружение для 1С-Битрикс: Nginx, PHP-FPM и Percona.
Это упрощённый форк [оригинального BitrixDock](https://github.com/bitrixdock/bitrixdock).
SSL завершается внешним Nginx; база данных доступна только контейнерам проекта.
Поддерживаются PHP 8.0 и новее.

## Требования

- Docker Engine / Docker Desktop с Docker Compose v2
- `curl` для загрузки установщика Битрикса

## Быстрый старт

```sh
cp .env_template .env
make bitrix-setup
docker compose up -d
```

Откройте `http://127.0.0.1:8080` и завершите установку Битрикс. В мастере
укажите сервер БД `db` и значения `MYSQL_*` из `.env`.

`download.sh` делает только одно: скачивает `bitrixsetup.php` в `www/`. Можно
выполнить его напрямую и передать другой каталог сайта:

```sh
./download.sh ./www
```

## Несколько проектов

Docker Compose автоматически изолирует сеть и именованный volume по имени
каталога проекта. Для второй копии достаточно выбрать свободный HTTP-порт:

```sh
HTTP_PORT=8081 docker compose up -d
```

Если запускаете несколько стеков из одного каталога, задайте также имя проекта:

```sh
COMPOSE_PROJECT_NAME=shop2 HTTP_PORT=8081 docker compose up -d
```

Параметры HTTP:

```dotenv
HTTP_BIND_ADDRESS=127.0.0.1
HTTP_PORT=8080
```

По умолчанию порт слушается только на loopback-интерфейсе, чтобы внешний Nginx
мог проксировать к нему HTTP и завершать TLS. Для доступа из локальной сети
укажите `HTTP_BIND_ADDRESS=0.0.0.0`.

Nginx передаёт исходный `Host`, включая порт, в PHP — Bitrix не теряет
нестандартный порт при редиректах.

## Команды

```sh
make up                 # запустить
make down               # остановить и удалить контейнеры
make console-php        # shell от www-data
make console-mysql      # MySQL shell
make bitrix-setup       # скачать bitrixsetup.php
make bitrix-restore     # скачать restore.php
```

## Настройка

Все параметры лежат в `.env`; файл локальный и не попадает в Git. Минимально
полезные значения: `SITE_PATH`, `HTTP_BIND_ADDRESS`, `HTTP_PORT`, `PHP_VERSION`
и `MYSQL_*`. Доступны PHP-сборки `php80`–`php85`; стандартная — `php82`.

Дополнительные сервисы (Mailpit, Adminer, Redis, push-сервер, workspace) не
входят в базовый стек. Их стоит подключать отдельными Compose-файлами под
конкретную задачу, чтобы базовое окружение оставалось переносимым.
