# BitrixDock Simple

Минимальное локальное окружение для 1С-Битрикс: Nginx, PHP-FPM и Percona.
Это упрощённый форк [оригинального BitrixDock](https://github.com/bitrixdock/bitrixdock).
SSL завершается внешним Nginx; база данных доступна только контейнерам проекта.
Поддерживаются PHP 8.0 и новее.

```sh
cp .env_template .env
./download.sh 
docker compose up
```
