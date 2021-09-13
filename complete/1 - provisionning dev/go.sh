#!/usr/bin/env bash
NODE_VERSION="v12.11.1"

source $(cd "$( dirname "${BASH_SOURCE[0]}")" && pwd )/src/comet.sh
source $(cd "$( dirname "${BASH_SOURCE[0]}")" && pwd )/src/log.sh
source $(cd "$( dirname "${BASH_SOURCE[0]}")" && pwd )/src/install.sh

clean_log_file

install_empty_shell_profile
load_shell_profile

install_homebrew
install_nvm
install_docker
install_vscode
install_yarn
install_psequel
install_clever_cli
install_bats
install_telnet
install_psql_cli
install_jq
install_ngrok
install_zoom
install_zeplin
install_keybase
install_slack
install_tig
install_coreutils

# SSH Key
create_ssh_key

# Runtime configuration
install_node_version "$NODE_VERSION"
default_node_version "$NODE_VERSION"

# Checks ENV VAR
is_env_var_set "MAILER_PASSWORD"

# Additionnal software
do_you_want_app iTerm iterm
do_you_want_app Mobster mobster
