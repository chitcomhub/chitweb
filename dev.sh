#!/bin/bash

GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

function help () {
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

function load_pg_vars () {
    pg_username=$(sed -n 's/POSTGRES_USER=\(.*\)/\1/p' < .envs/.local/.postgres)
    pg_dbname=$(sed -n 's/POSTGRES_DB=\(.*\)/\1/p' < .envs/.local/.postgres)
}

function exec_command() {
    printf "${CYAN}Executing command: $@"
    printf "${NC}\n=====================\n"
    $@
}

# parse last commit hash
function parse_git_hash() {
    git rev-parse HEAD 2> /dev/null | sed "s/\(.*\)/\1/"
}

# если разработчик хочет собрать или поднять контейнеры, переадресуем команду docker-compose и передаем все аргументы
if [[ "$1" == "build" || "$1" == "up" || "$1" == "down" ]];then
    # сразу сохраним хеш текущего последнего коммита
    CURRENT_LAST_COMMIT=$(parse_git_hash)
    # и сохраняем в env файл
    echo "CHITWEB_RUNNING_COMMIT_HASH=$CURRENT_LAST_COMMIT" > ./.envs/.local/.meta_info
    echo "Current commit saved to env file as $CURRENT_LAST_COMMIT"
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
elif [[ "$1" == "help" || "$1" == "--help" ]];then
    help

# иначе передаем команду контейнеру Django, к которому относятся все остальные операции (запуск тестов и т.п.)
else
    exec_command "docker-compose -f local.yml run --rm django $@"
fi
