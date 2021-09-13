#!/usr/bin/env bash

function is_deployed() {
    retry="$1"
    expected_version="$2"

    for i in $(seq 1 "$retry");do
        current_version=$(get_current_version)
        if [ "$current_version" = "$expected_version" ];then
            exit 0
        fi
        echo "check # $i"
    done
    exit 2
}


