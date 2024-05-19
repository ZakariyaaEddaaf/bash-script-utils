#!/bin/bash
source "${BASH_SOURCE%/*}/logging_utils.sh"

is_a_digit()
{
    local char=$1
    if [[ $char =~ ^[0-9]$ ]]; then
        log_success_msg "The character $char is a digit."
        return 0  # Success
    else
        log_error_msg "The character $char is not a digit."
        return 1  # Failure
    fi
}

is_an_alphabet() 
{
    local char=$1
    if [[ $char =~ ^[[:alpha:]]$ ]]; then
        log_success_msg "The character $char is an alphabet."
        return 0  # Success
    else
        log_error_msg "The character $char is not an alphabet."
        return 1  # Failure
    fi
}

require_sudo_privilege() 
{
    if [[ $EUID -ne 0 ]]; then
        log_info_msg "This script requires sudo privileges."
        exit 1
    fi
}

require_confirm_proceed()
{
    log_info_msg "Would you like to proceed ? [Y/y|N/n] "
    read REPLY
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        log_info_msg "Exiting ..."
        exit 0
    fi    
}

is_args_empty()
{
    if [ "$#" -eq 0 ]; then
        log_error_msg "No arguments provided."
        exit 1
    fi  
}
