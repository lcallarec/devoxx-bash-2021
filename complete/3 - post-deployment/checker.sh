#!/usr/bin/env bash

# shellcheck source=src/is_deployed.sh
source "src/is_deployed.sh"

function get_current_version() {
    curl -s https://www.youzd.fr
}

is_deployed 10 "abcd"

