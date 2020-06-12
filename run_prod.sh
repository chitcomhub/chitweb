#!/bin/bash

GREEN='\033[0;32m'
RED='\033[0;31m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

function exec_command() {
    echo "Executing command: $@"
    $@
}

function show_step() {
    printf "\n${CYAN}=============================${NC}\n"
    printf "${CYAN}$@${NC}\n"
    printf "${CYAN}=============================${NC}\n"
}

# parse last commit hash
function parse_git_hash() {
    git rev-parse HEAD 2> /dev/null | sed "s/\(.*\)/\1/"
}

function show_ok_text() {
    printf "${GREEN}$@${NC}\n"
}

function show_fail_text() {
    printf "${RED}$@${NC}\n"
}

# ------------------------ STEPS -------------------------------
printf "\nOkay, we're starting\n"

#--- 1 ---
# take the current commit hash
CURRENT_LAST_COMMIT=$(parse_git_hash)

show_step "STEP 1: pulling repo"

exec_command "git pull"

success=$?
if [[ $success -eq 0 ]];
then
    show_ok_text "STEP 1: Repository successfully pulled"
else
    show_fail_text "STEP 1: Something went wrong! I couldn't pull the repo :("
    exit 1
fi

# take the last commit hash
LAST_COMMIT=$(parse_git_hash)

if [[ $LAST_COMMIT == $CURRENT_LAST_COMMIT ]];
then
    show_ok_text "Nothing to do, already running last version $LAST_COMMIT"
    exit 0
fi

# save version info to env file
echo "CHITWEB_RUNNING_COMMIT_HASH=$LAST_COMMIT" > ./.envs/.production/.meta_info

#--- 2 ---

show_step "STEP 2: stopping containers"

exec_command "docker-compose -f production.yml down"

success=$?
if [[ $success -eq 0 ]];
then
    show_ok_text "STEP 2: containers seem stopped"
else
    show_fail_text "STEP 2: Something went wrong! I couldn't stop the containers :("
    exit 1
fi

#--- 3 ---

show_step "STEP 3: rebuilding containers"

exec_command "docker-compose -f production.yml build"

success=$?
if [[ $success -eq 0 ]];
then
    show_ok_text "STEP 3: containers are built successfully"
else
    show_fail_text "STEP 3: Something went wrong! I couldn't build the docker stuff :("
    exit 1
fi

#--- 4 ---

show_step "STEP 4: running migrations"

exec_command "docker-compose -f production.yml run --rm django python manage.py migrate"

success=$?
if [[ $success -eq 0 ]];
then
    show_ok_text "STEP 4: migration successfully finished"
else
    show_fail_text "STEP 4: Something went wrong! I couldn't migrate DB :("
    exit 1
fi

#--- 4 ---

show_step "STEP 5: running everything"

exec_command "docker-compose -f production.yml up -d"

success=$?
if [[ $success -eq 0 ]];
then
    echo -en $GREEN
    cat << "EOF"

         /\
        |==|
        |  |
        |  |
        |  |
       /____\
       |    |
       |chit|
       | web|
       |    |
      /| |  |\
     / | |  | \
    /__|_|__|__\
       /_\/_\
       ######
      ########
       ######
        ####
        ####
         ##
         ##   Читвеб хьала иккхина хьуна!
         ##
         ##
EOF
echo "       ^^^^^^ хIокху коммит чура: $LAST_COMMIT"
echo -en $NC
else
    show_fail_text "I couldn't run chitweb :("
    exit 1
fi
