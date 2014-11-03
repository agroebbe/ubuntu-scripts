#!/bin/bash
sudo apt-get install python-pip python-dev build-essential python-setuptools
sudo pip install --upgrade pip 
sudo pip install --upgrade virtualenv
sudo pip install setuptools --upgrade
sudo pip install csvkit --upgrade
sudo easy_install csvkit # seems that this one is needed for the command line binaries??

