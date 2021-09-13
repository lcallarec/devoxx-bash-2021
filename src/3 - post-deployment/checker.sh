#!/usr/bin/env bash

# shellcheck source=src/is_deployed.sh
source "src/is_deployed.sh"

function get_api_version() {
    curl -s https://www.youzd.fr/api/version
}

is_deployed 10 "v3"

