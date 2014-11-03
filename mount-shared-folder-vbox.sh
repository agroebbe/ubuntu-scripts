#!/bin/bash
WINDOWS_FOLDER_VBOX=shared-folder-ag
sudo mount -t vboxsf -o uid=$UID,gid=$(id -g)  $WINDOWS_FOLDER_VBOX ~/host
