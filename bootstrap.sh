#!/bin/bash

SSH_CONFIG_FILE="/Users/brian/.ssh/config"
BASE_DIR=$(pwd)
DATA_DIR="$BASE_DIR/.data"

# Create directory for data persistence
mkdir -p $DATA_DIR

# Configure SSH
echo -e "Include $BASE_DIR/conf/ssh.conf\n$(cat $SSH_CONFIG_FILE)" > $SSH_CONFIG_FILE
