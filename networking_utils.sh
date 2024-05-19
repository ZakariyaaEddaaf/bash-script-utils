#!/bin/bash

check_internet_connection() 
{
    ping -c 1 google.com > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        log_success_msg "Internet connection is available."
        return 0  # Success
    else
        log_error_msg "No internet connection."
        return 1  # Failure
    fi
}

check_ipaddr_reachable()
{
    local ip_addr=$1
    local timeout=6  # Adjust timeout as needed
    log_info_msg "Checking ${ip_addr} in the network, please wait..."
    ping -c 1 -W ${timeout} ${ip_addr} > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        log_pass_msg "${ip_addr} is reachable."
        return 0  # Success
    else
        log_fail_msg "${ip_addr} is not reachable."
        return 1  # Failure
    fi
}

configure_network_interface()
{
    local ip_addr=$1
    local subnet_mask=$2
    local i_face=$3
    ip addr add "${ip_addr}/${subnet_mask}" dev "${i_face}" > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        log_success_msg "Added ${ip_addr}/${subnet_mask} to ${i_face} successfully."
        return 0  # Success
    else
        log_error_msg "Failed to add ${ip_addr}/${subnet_mask} to ${i_face}."
        return 1  # Failure
    fi

}

clean_network_interface()
{
    local ip_addr=$1
    local subnet_mask=$2
    local i_face=$3
    ip addr del "${ip_addr}/${subnet_mask}" dev "${i_face}" > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        log_success_msg "Delete ${ip_addr}/${subnet_mask} from ${i_face} successfully."
        return 0  # Success
    else
        log_error_msg "Failed to delete ${ip_addr}/${subnet_mask} from ${i_face}."
        return 1  # Failure
    fi

}

flush_network_interface()
{
    local i_face=$1
    ip addr flush dev "${i_face}" > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        log_success_msg "Flushed network interface ${i_face} successfully."
        return 0  # Success
    else
        log_error_msg "Failed to flush network interface ${i_face}."
        return 1  # Failure
    fi
}


