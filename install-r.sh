#!/bin/bash
UBUNTU_REL=$(lsb_release -a | grep Codename | cut -f2)
echo "Using quantal ubuntu release for newer R libs:"
sudo sh -c "echo '#added by AG -- $(date)' >> /etc/apt/sources.list"
sudo sh -c "echo 'deb http://cran.freestatistics.org/bin/linux/ubuntu $UBUNTU_REL/' >> /etc/apt/sources.list"
echo "Added to source.list:"
tail -n3 /etc/apt/sources.list
echo "Now installing R:"
sudo apt-get update
sudo apt-get install r-base
sudo apt-get install r-base-dev
sudo apt-get -f install
sudo apt-get install r-base
sudo apt-get install r-base-dev




