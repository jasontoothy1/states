#!/bin/bash

yum install -y pam-devel
yum install -y make gcc wget
wget http://google-authenticator.googlecode.com/files/libpam-google-authenticator-1.0-source.tar.bz2
tar -xvf libpam-google-authenticator-1.0-source.tar.bz2
cd $PWD/libpam-google-authenticator-1.0/
make
make install

