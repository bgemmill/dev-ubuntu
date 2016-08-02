#! /bin/bash

# add a user to run commands with
USER_NAME=${USER_NAME:=docker}
USER_PASS=${USER_PASS:=docker}
USER_GROUPS=${USER_GROUPS:=audio,sudo}
USER_ID=${USER_ID:=1000}

# create that user
useradd -m $USER_NAME -u $USER_ID -G $USER_GROUPS > /dev/null 2>&1
chpasswd <<< "$USER_NAME:$USER_PASS"
chown $USER_NAME /home/$USER_NAME
touch /home/$USER_NAME/.Xauthority; chown $USER_NAME /home/$USER_NAME/.Xauthority # gksu needs this file, even if empty

# run command as user
gosu $USER_NAME "$@"

# run command as root
#"$@"
