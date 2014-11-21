#!/bin/bash

# !!!!!! more info see: http://dogdogfish.com/2014/04/26/installing-hadoop-2-4-on-ubuntu-14-04/


#HADOOP (see latest: http://apache.belnet.be/hadoop/common/hadoop-2.5.1/)
wget http://apache.belnet.be/hadoop/common/hadoop-2.5.1/hadoop-2.5.1.tar.gz
tar -xzf hadoop-2.5.1.tar.gz
ls | grep hadoop | grep -v *.gz
sudo mv hadoop-2.5.1/ /usr/local
cd /usr/local
sudo ln -s hadoop-2.5.1 hadoop
sudo addgroup hadoop
#sudo useradd -r -m -g hadoop hduser
sudo adduser --ingroup hadoop hduser
sudo adduser hduser sudo #add to group sudo
sudo chown -R hduser:hadoop /usr/local/hadoop/
ls -l /home/ | grep hadoop # see data of new user
sudo passwd hduser

#SSH
su - hduser # login as hduser and go to homefolder
sudo apt-get install ssh
ssh-keygen -t rsa -P ""  # ssh keys without passphrase
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys

# Hadoop and ipv6 don’t play nice so we’ll have to disable it – 
# to do this you’ll need to open up /etc/sysctl.conf 
# and add the following lines to the end:
echo "net.ipv6.conf.all.disable_ipv6 = 1" | sudo tee -a /etc/sysctl.conf
echo "net.ipv6.conf.default.disable_ipv6 = 1" | sudo tee -a /etc/sysctl.conf
echo "net.ipv6.conf.lo.disable_ipv6 = 1" | sudo tee -a /etc/sysctl.conf

#see ipv6 enabled through:
# cat /proc/net/if_inet6

#Fair warning – you’ll need sudo privileges to modify the file so might want to open up your file editor like this:
#sudo apt-get install gksu
#gksu gedit /etc/sysctl.conf

#TODO check if ETH1 is your interface here
sudo service networking restart 
sudo service network-manager restart
sudo ifconfig eth1 down && sudo ifconfig eth1 up # seems to trigger something...
sudo service network-manager restart
# OR RESTART PC IF NOT WORKING
# inspect if disabled:
# cat /proc/sys/net/ipv6/conf/all/disable_ipv6

# maybe use export to see already declared java home settings
YOUR_JAVA_HOME=/usr/lib/jvm/java-7-oracle/bin
su - hduser # login as hduser with a login terminal and go to its home dir
ssh localhost
echo "export HADOOP_HOME=/usr/local/hadoop" | sudo tee -a ~/.bashrc
echo "export JAVA_HOME=$YOUR_JAVA_HOME" | sudo tee -a ~/.bashrc
echo 'export PATH=$PATH:$HADOOP_HOME/bin' | sudo tee -a ~/.bashrc # single quotes to have literal!
source ~/.bashrc

#test hadoop ok:
/usr/local/hadoop/bin/hadoop version

# change config hadoop:
/usr/local/hadoop/etc/hadoop/hadoop-env.sh --> set java home
/usr/local/hadoop/etc/hadoop/core-site.xml --> set hdfs uri & data dir
/usr/local/hadoop/etc/hadoop/mapred-site.xml --> set yarn
/usr/local/hadoop/etc/hadoop/hdfs-site.xml --> set dfs replication to 1
/usr/local/hadoop/etc/hadoop/yarn-site.xml --> set 'yarn.nodemanager.aux-services' to yarn service name

# launch:
/usr/local/hadoop/bin/hadoop namenode -format # format dfs
/usr/local/hadoop/sbin/start-dfs.sh # start dfs
/usr/local/hadoop/sbin/start-yarn.sh # start yarn

# stop:
./stop-dfs.sh
./stop-yarn.sh

# another info site:
# http://www.rohitmenon.com/index.php/how-to-install-hadoop-on-ubuntulinux-mint/


# loggin happens to e.g.
# logging to /usr/local/hadoop-2.5.1/logs/hadoop-hduser-.....out

ls /usr/local/hadoop-2.5.1/logs/*

# check processes:
jps # JVM process list
ps -eaf | grep “java” # java process list

hadoop_examples_jar=$( (find $HADOOP_HOME/ | grep examples | grep -v doc | grep -v data | sort | head -n1) ) # note the inner () to have a subshell for the sort command

# see it in action:
# http://ubuntu:8088/cluster/cluster


# http://www.michael-noll.com/tutorials/running-hadoop-on-ubuntu-linux-single-node-cluster/


