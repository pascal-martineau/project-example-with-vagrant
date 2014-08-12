#!/bin/sh

msg_ok()
{
    echo -e "\033[1;32m$1\033[0m"
}

msg_fail()
{
    echo -e "\033[1;31m$1\033[0m"
}

msg_task()
{
    echo -e " "
    echo -e "\033[1;33m[  $1  ]\033[0m"
}

msg_subtask()
{
    echo -e "\033[1;33m. $1\033[0m"
}



block_ok()
{
    echo -e "\033[42m\033[1;32m   $1   \033[0m"
    echo -e "\033[42m\033[1;37m   $1   \033[0m"
    echo -e "\033[42m\033[1;32m   $1   \033[0m"
}

block_fail()
{
    echo -e "\033[41m\033[1;31m   $1   \033[0m"
    echo -e "\033[41m\033[1;30m   $1   \033[0m"
    echo -e "\033[41m\033[1;31m   $1   \033[0m"
}

block_info()
{
    echo -e "\033[44m\033[1;34m   $1   \033[0m"
    echo -e "\033[44m\033[1;30m   $1   \033[0m"
    echo -e "\033[44m\033[1;34m   $1   \033[0m"
}

block_hint()
{
    echo -e "\033[43m\033[1;33m   $1   \033[0m"
    echo -e "\033[43m\033[1;30m   $1   \033[0m"
    echo -e "\033[43m\033[1;33m   $1   \033[0m"
    sleep 3
}

