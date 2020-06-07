#!/bin/bash

GREEN='\033[0;32m'
NC='\033[0m' # No Color

help () {
    echo "Проект:"
    printf "  ${GREEN}./dev.sh build${NC}  - собрать проект (контейнеры) через docker-compose\n"
    printf "  ${GREEN}./dev.sh up${NC}     - поднять проект локально через docker-compose\n"
    printf "  ${GREEN}./dev.sh down${NC}   - поднять проект локально через docker-compose\n\n"

    echo "Python:"
    printf "  ${GREEN}./dev.sh pytest${NC} - запустить тесты Python\n\n"

    echo "База данных:"
    printf "  ${GREEN}./dev.sh psql${NC}   - подключиться к Postgres в интерактивном режиме\n"
    printf "  ${GREEN}./dev.sh python manage.py migrate${NC} - миграция Django\n"
    printf "  ${GREEN}./dev.sh python manage.py makemigrations${NC} - создать миграцию Django\n\n"
}

load_pg_vars () {
    pg_username=$(sed -n 's/POSTGRES_USER=\(.*\)/\1/p' < .envs/.local/.postgres)
    pg_dbname=$(sed -n 's/POSTGRES_DB=\(.*\)/\1/p' < .envs/.local/.postgres)
}

exec_command() {
    echo "Executing command: $@"
    echo "====================="
    $@
}

# если разработчик хочет собрать или поднять контейнеры, переадресуем команду docker-compose и передаем все аргументы
if [[ "$1" == "build" || "$1" == "up" || "$1" == "down" ]];then
    exec_command "docker-compose -f local.yml $@"
    if [[ $? != 0 ]]; then
        echo "Что-то пошло не так, может вы забыли собрать проект через ./dev.sh build ?"
    fi

# если разработчик хочет зайти в БД, достаем логин и имя БД и подключаемся к контейнеру в интерактивном режиме
elif [[ "$1" == "psql" ]];then
    load_pg_vars
    exec_command "docker-compose -f local.yml exec postgres psql -U $pg_username -d $pg_dbname"
    if [[ $? != 0 ]]; then
        echo "Что-то пошло не так, может вы забыли поднять проект через ./dev.sh up ?"
    fi

# если разработчик хочет помощи
elif [[ "$1" == "help" ]];then
    help

# иначе передаем команду контейнеру Django, к которому относятся все остальные операции (запуск тестов и т.п.)
else
    exec_command "docker-compose -f local.yml run --rm django $@"
fi
