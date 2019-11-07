#!/bin/bash

# install updates
yum update -y

# install the following base packages
yum install -y  wget git zile nano net-tools docker-1.13.1\
				bind-utils iptables-services \
				bridge-utils bash-completion \
				kexec-tools sos psacct openssl-devel \
				httpd-tools NetworkManager \
				python-cryptography python2-pip python-devel  python-passlib \
				java-1.8.0-openjdk-headless "@Development Tools"

#install epel
yum -y install epel-release

# Disable the EPEL repository globally.
sed -i -e "s/^enabled=1/enabled=0/" /etc/yum.repos.d/epel.repo

#Enable NetworkManager
systemctl | grep "NetworkManager.*running" 
if [ $? -eq 1 ]; then
	systemctl start NetworkManager
	systemctl enable NetworkManager
fi

# install the packages for Ansible
yum -y --enablerepo=epel install pyOpenSSL

yum -y --enablerepo=epel install https://releases.ansible.com/ansible/rpm/release/epel-7-x86_64/ansible-2.6.5-1.el7.ans.noarch.rpm
