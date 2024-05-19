#!/bin/bash

RESET_COLOR="\033[0m"
RED_COLOR="\033[91m" 
GREEN_COLOR="\033[92m" 
BLUE_COLOR="\033[94m" 
MAGENTA_COLOR='\033[95m'
YELLOW_COLOR='\033[93m' 

declare _LOGGING_FILE=""
declare -i _LOGGING_TO_FILE=1 # 1 disable 0 enable
declare -i _LOGGING_VERBOSITY=1  # 0 silent mode  1 dry mode

log_info_msg() 
{
    local message=$1
    local log_message="${BLUE_COLOR}[INFO] ${message}${RESET_COLOR}"
    if [[ ${_LOGGING_VERBOSITY} -ge 0 ]]; then
        echo -e "${log_message}"
    fi
    if [[ ${_LOGGING_TO_FILE} -eq 0 ]]; then
        echo -e "${log_message}" 2>&1 | tee -a "${_LOGGING_FILE}" > /dev/null
    fi
}

log_error_msg() 
{
    local message=$1
    local log_message="${RED_COLOR}[EROR] ${message}${RESET_COLOR}"
    if [[ ${_LOGGING_VERBOSITY} -ge 1 ]]; then
        echo -e "${log_message}"
    fi
    if [[ ${_LOGGING_TO_FILE} -eq 0 ]]; then
        echo -e "${log_message}" 2>&1 | tee -a "${_LOGGING_FILE}" > /dev/null
    fi
}

log_warning_msg() 
{
    local message=$1
    local log_message="${MAGENTA_COLOR}[WARN] ${message}${RESET_COLOR}"
    if [[ ${_LOGGING_VERBOSITY} -ge 1 ]]; then
        echo -e "${log_message}"
    fi
    if [[ ${_LOGGING_TO_FILE} -eq 0 ]]; then
        echo -e "${log_message}" 2>&1 | tee -a "${_LOGGING_FILE}" > /dev/null
    fi
}

log_fail_msg() 
{
    local message=$1
    local log_message="${RED_COLOR}[FAIL] ${message}${RESET_COLOR}"
    if [[ ${_LOGGING_VERBOSITY} -ge 0 ]]; then
        echo -e "${log_message}"
    fi
    if [[ ${_LOGGING_TO_FILE} -eq 0 ]]; then
        echo -e "${log_message}" 2>&1 | tee -a "${_LOGGING_FILE}" > /dev/null
    fi
}

log_pass_msg() 
{
    local message=$1
    local log_message="${GREEN_COLOR}[PASS] ${message}${RESET_COLOR}"
    if [[ ${_LOGGING_VERBOSITY} -ge 0 ]]; then
        echo -e "${log_message}"
    fi
    if [[ ${_LOGGING_TO_FILE} -eq 0 ]]; then
        echo -e "${log_message}" 2>&1 | tee -a "${_LOGGING_FILE}" > /dev/null
    fi
}

log_success_msg()
{
    local message=$1
    local log_message="${YELLOW_COLOR}[OKAY] ${message}${RESET_COLOR}"
    if [[ ${_LOGGING_VERBOSITY} -ge 1 ]]; then
        echo -e "${log_message}"
    fi
    if [[ ${_LOGGING_TO_FILE} -eq 0 ]]; then
        echo -e "${log_message}" 2>&1 | tee -a "${_LOGGING_FILE}" > /dev/null
    fi
}

log_to_file()
{
    _LOGGING_FILE="${1}"
    if [[ -f ${_LOGGING_FILE} ]]; then
        log_error_msg "Log to file failed '${_LOGGING_FILE}' already exists"
        exit 1
    fi
    touch "${_LOGGING_FILE}"
    if [[ $? -ne 0 ]]; then
        log_error_msg "Log to file failed '${_LOGGING_FILE}' cannot be created"
        exit 1
    fi

    _LOGGING_TO_FILE=0
}

set_log_silent()
{
    _LOGGING_VERBOSITY=0
}

set_log_dry()
{
    _LOGGING_VERBOSITY=1
}

set_logging_to_file()
{
    _LOGGING_TO_FILE=0
}

unset_logging_to_file()
{
    _LOGGING_TO_FILE=1
}

log_banner_logo()
{
    clear
    #figlet -w 60 -c $1
    cat evologics_banner_logo
}