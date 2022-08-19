#!/bin/bash

BASE_DIR=$(pwd)
DATA_DIR="$BASE_DIR/.data"
HACKLAB_SSH_CONFIG_FILE_NAME="hacklab_ssh_config"
HACKLAB_SSH_CONFIG_FILE_PATH="$BASE_DIR/conf/$HACKLAB_SSH_CONFIG_FILE_NAME"
SYS_SSH_CONFIG_DIR="/etc/ssh/ssh_config.d"
SYS_SSH_CONFIG_FILE="/etc/ssh/ssh_config"

# # Create directory for data persistence
# mkdir -p $DATA_DIR

echo "
          _______  _______  _        _        _______  ______  
|\     /|(  ___  )(  ____ \| \    /\( \      (  ___  )(  ___ \ 
| )   ( || (   ) || (    \/|  \  / /| (      | (   ) || (   ) )
| (___) || (___) || |      |  (_/ / | |      | (___) || (__/ / 
|  ___  ||  ___  || |      |   _ (  | |      |  ___  ||  __ (  
| (   ) || (   ) || |      |  ( \ \ | |      | (   ) || (  \ \ 
| )   ( || )   ( || (____/\|  /  \ \| (____/\| )   ( || )___) )
|/     \||/     \|(_______/|_/    \/(_______/|/     \||/ \___/ 
                                                               
                                              by 6rian

"

echo "[!] Preparing to build hacklab."
echo "[!] WARNING: Running this script will erase any existing hacklab container and create a new one."

echo -e "\n[*] Configure SSH."
echo -n "Would you like to create and add the hacklab SSH config file to your system? (Y/n): "
read install_ssh_config

if [ "$install_ssh_config" = "" ] || [[ "$install_ssh_config" =~ [Y|y] ]]
then

  echo ""
  echo "[!] Creating/overwriting the hacklab SSH config file: $HACKLAB_SSH_CONFIG_FILE_PATH."
  echo -e "Host hacklab
\tHostName localhost
\tUser root
\tPort 2222
\tDynamicForward 1337" > $HACKLAB_SSH_CONFIG_FILE_PATH

  echo "Checking for the system SSH config directory: $SYS_SSH_CONFIG_DIR"
  if [ ! -d $SYS_SSH_CONFIG_DIR ]
  then
    echo " [!] Directory does not exist. Creating it now."
    mkdir -p $SYS_SSH_CONFIG_DIR
  else
    echo "- Directory found."
  fi

  echo ""
  echo "Checking system ssh_config for inclusion of config directory."
  if ! grep -qe "^Include $SYS_SSH_CONFIG_DIR" $SYS_SSH_CONFIG_FILE
  then
    echo " [!] SSH config files are not being included. Modifying ssh_config now."
    echo -e "\n\nInclude $SYS_SSH_CONFIG_DIR/*" >> $SYS_SSH_CONFIG_FILE
  else
    echo "- Config files are being included."
  fi

  # Create a symbolic link to the hacklab SSH config file.
  echo ""
  echo "Checking for symlink to hacklab SSH config."
  SSH_CONFIG_SYMLINK="$SYS_SSH_CONFIG_DIR/$HACKLAB_SSH_CONFIG_FILE_NAME"
  if [ ! -L $SSH_CONFIG_SYMLINK ] || [ ! -e $SSH_CONFIG_SYMLINK ]
  then
    echo " [!] Symlink does not exist. Creating it now."
    ln -s $HACKLAB_SSH_CONFIG_FILE_PATH $SYS_SSH_CONFIG_DIR
  else
    echo "- Symlink already exists."
  fi
fi

# TODO: docker compose up -d
