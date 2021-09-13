#!/bin/bash

function install_brew() {
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}
function install_ngrok() {
    brew install ngrok
}

function install_steram() {
    #...
    #Scary
    rm -rf $STEAMROOT/*
}

function install_command() {
    command="$1"
    if [ ! "$(which "$command")" ];then
        "install_$command"
    else
        echo "$command is already installed"
    fi  
}

install_command brew
install_command ngrok