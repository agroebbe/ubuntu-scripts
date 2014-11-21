RHIPE
-----

# see also: https://www.datadr.org/install.html

# see also: RHIPE tutorial http://xiaosutong.github.io/docs-RHIPE/#the-data

# finally a vagrant script witht lots of things: https://github.com/tesseradata/install-vagrant/blob/master/cdh5mr1-rhipe0.75/make-base-ubuntu.sh


first install-protobuf.sh

export PKG_CONFIG_PATH=/usr/local/lib # seem to be needed for protobuf the pkg config (c)

export LD_LIBRARY_PATH=/usr/local/lib

# previously installed java --> make config ok for R to use
sudo R CMD javareconf

R CMD javareconf -e # exports JAVA variables
#then
rstudio &

#in R
#-----

# seems that LD_LIBRARY_PATH is setting path wr"ongly (no /jre/ dir in path ???)
Sys.setenv(LD_LIBRARY_PATH = paste(Sys.getenv("JAVA_LD_LIBRARY_PATH"),":",Sys.getenv("LD_LIBRARY_PATH"),sep="") )
# !! sometimes sudio "R CMD javareconf -e"  is needed BEFORE starting RStudio...

Sys.getenv("LD_LIBRARY_PATH")

install.packages("rJava") # sometimes restart is need of this due to network IO

# PROTOBUF & OLD RHIPE INCOMPATIBLE WITH HADOOP 2.x
# note protobuf 2.4.1 need to be installed for RHIP 0.73
# http://grokbase.com/t/gg/rhipe/144ggz7jz1/rhipe-0-73-1-incompatible-with-protobuf-2-5
# note: this setting will do for pkg config of protobuf: 
# export PKG_CONFIG_PATH=/usr/local/lib
# install.packages("Rhipe_0.74.0.tar.gz", repos=NULL, type="source")

# NEW: install RHIPE 0.75 and then protobuf 2.5 is OK !!!
setwd("~/work")
install.packages("testthat") # dependency for Rhipe
system("wget http://ml.stat.purdue.edu/rhipebin/Rhipe_0.75.0_cdh5mr2.tar.gz")
install.packages("Rhipe_0.75.0_cdh5mr2.tar.gz", repos=NULL, type="source")

# GO FURTHER HERE:

# 
# library(Rhipe)
# rhinit()
# rhmkdir("/yourloginname/bin")
# hdfs.setwd("/yourloginname/bin")
# bashRhipeArchive("R.Pkg")
# 
# 
# library(Rhipe) 
# rhinit()
# rhoptions(zips = "/myloginname/bin/R.Pkg.tar.gz")
# rhoptions(runner = "sh ./R.Pkg/library/Rhipe/bin/RhipeMapReduce.sh")


