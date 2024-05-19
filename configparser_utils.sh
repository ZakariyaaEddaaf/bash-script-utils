#!/bin/bash

NUM_OF_ARGS=$#
INI_FILE="comm_module_config.ini"

usage()
{
    if [ "${NUM_OF_ARGS}" -ne 2 ];then
            echo "Usage: $(basename $0) <section> <key>"
            exit 1
    fi
}

parse_config_ini()
{
	local SECTION=$1
	local KEY=$2  
    while IFS=' = ' read -r name value; do
        if [[ $name == \[${SECTION}\]* ]]; then
            in_section=true
        elif [[ $in_section && $name == ${KEY} ]]; then
            echo "$value"
            return
        fi
    done < "${INI_FILE}"
}