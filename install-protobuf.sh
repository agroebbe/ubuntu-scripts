#!/bin/bash
wget http://protobuf.googlecode.com/files/protobuf-2.5.0.tar.gz
tar -xzf protobuf-2.5.0.tar.gz
cd protobuf-2.5.0
sudo ./configure
sudo make
sudo make check
sudo make installp
protoc --version
sudo ldconfig
protoc --version

