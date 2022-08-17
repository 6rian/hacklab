#!/bin/bash

BASE_DIR=$(pwd)
DATA_DIR="$BASE_DIR/.data"
HACKLAB_SSH_CONFIG_FILE="$BASE_DIR/conf/hacklab_ssh_config"
SYS_SSH_CONFIG_DIR="/etc/ssh/ssh_config.d"
SYS_SSH_CONFIG_FILE="/etc/ssh/ssh_config"

# # Create directory for data persistence
# mkdir -p $DATA_DIR

# echo "
#           _______  _______  _        _        _______  ______  
# |\     /|(  ___  )(  ____ \| \    /\( \      (  ___  )(  ___ \ 
# | )   ( || (   ) || (    \/|  \  / /| (      | (   ) || (   ) )
# | (___) || (___) || |      |  (_/ / | |      | (___) || (__/ / 
# |  ___  ||  ___  || |      |   _ (  | |      |  ___  ||  __ (  
# | (   ) || (   ) || |      |  ( \ \ | |      | (   ) || (  \ \ 
# | )   ( || )   ( || (____/\|  /  \ \| (____/\| )   ( || )___) )
# |/     \||/     \|(_______/|_/    \/(_______/|/     \||/ \___/ 
                                                               
#                                               by 6rian

# "

# echo "[!] Preparing to build hacklab."
# echo "[!] WARNING: Running this script will erase any existing hacklab container and create a new one."
# echo ""

# echo "[*] Update root account."
# echo -n "Set root's password: "
# read root_password
# echo -n "Confirm: "
# read root_password_2

# if [ "$root_password" != "$root_password_2" ]
# then
#   echo "[!] Passwords do not match."
#   echo -n "Please try again: "
#   read root_password_3

#   if [ "$root_password" != "$root_password_3" ]
#   then
#     echo ""
#     echo "[!!] Fatal Error: Passwords still do not match."
#     echo "Exiting..."
#     exit -1
#   fi
# fi

# echo ""
# echo "[*] Create primary user account."
# echo -n "Username: "
# read primary_username
# echo -n "Password: "
# read primary_user_password
# echo -n "Confirm: "
# read primary_user_password_2

# if [ "$primary_user_password" != "$primary_user_password_2" ]
# then
#   echo "[!] Passwords do not match."
#   echo -n "Please try again: "
#   read primary_user_password_3

#   if [ "$primary_user_password" != "$primary_user_password_3" ]
#   then
#     echo ""
#     echo "[!!] Fatal Error: Passwords still do not match."
#     echo "Exiting..."
#     exit -1
#   fi
# fi

# TODO: update primary username in conf/hacklab_ssh_config

echo ""
echo "[*] Configure SSH."
echo -n "Would you like to add the hacklab SSH config file to your system? (Y/n)"
read install_ssh_config

if [ "$install_ssh_config" = "" ] || [[ "$install_ssh_config" =~ [Y|y] ]]
then
  
  # Does the system SSH config directory exist? If not, make it.
  echo "Checking for the system SSH config directory: $SYS_SSH_CONFIG_DIR"
  if [ ! -d $SYS_SSH_CONFIG_DIR ]
  then
    echo "[!] Directory does not exist. Creating it now."
    mkdir -p $SYS_SSH_CONFIG_DIR
  fi

  # check if ssh_config.d is being included
  # if grep -qe "^Host \*" $SYS_SSH_CONFIG_FILE
  if ! grep -qe "^Include $SYS_SSH_CONFIG_DIR" $SYS_SSH_CONFIG_FILE
  then
    echo -e "\n\nInclude $SYS_SSH_CONFIG_DIR/*" >> $SYS_SSH_CONFIG_FILE
  fi

  # Create a symbolic link to the hacklab SSH config file.
  # ln -s $HACKLAB_SSH_CONFIG_FILE $SYS_SSH_CONFIG_DIR
fi