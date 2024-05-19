#!/bin/bash

is_dir_exist()
{
    local dir_path=$1
    if [ -d "${dir_path}" ]; then
        log_success_msg "Directory '${dir_path}' exists."
        return 0  # Success
    else
        log_error_msg "Directory '${dir_path}' does not exist."
        return 1  # Failure
    fi
}

is_file_exist()
{
    local file_path=$1
    if [ -e "${file_path}" ]; then
        log_success_msg "File '${file_path}' exists."
        return 0  # Success
    else
        log_error_msg "File '${file_path}' does not exist."
        return 1  # Failure
    fi
}

make_new_dir()
{
    local dir_name=$1
    if [ ! -d "${dir_name}" ]; then
        mkdir "${dir_name}"
        log_success_msg "Directory '${dir_name}' created."
        return 0  # Success
    else
        log_error_msg "Directory '${dir_name}' already exists."
        return 1  # Failure
    fi
}

make_new_file()
{
    local file_name=$1
    if [ ! -e "${file_name}" ]; then
        touch "${file_name}"
        log_success_msg "File '${file_name}' created."
        return 0  # Success
    else
        log_error_msg "File '${file_name}' already exists."
        return 1  # Failure
    fi
}

mv_file_dir() 
{
    local file_name=$1
    local dir_name=$2
    if [ -e "${file_name}" ]; then
        if [ -d "${dir_name}" ]; then
            mv "${file_name}" "${dir_name}/"
            log_success_msg "File '${file_name}' moved to directory '${dir_name}'."
            return 0  # Success
        else
            log_error_msg "Directory '${dir_name}' does not exist."
            return 1  # Failure
        fi
    else
        log_error_msg "File '${file_name}' does not exist."
        return 1  # Failure
    fi
}