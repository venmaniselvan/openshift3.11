#!/bin/bash

mkdir -p /etc/origin/master/
touch /etc/origin/master/htpasswd
[ ! -d openshift3.11 ] && git clone https://github.com/openshift/openshift-ansible.git -b release-3.11 --depth=1

ansible-playbook -i inventory.ini openshift-ansible/playbooks/prerequisites.yml -vvv
ansible-playbook -i inventory.ini openshift-ansible/playbooks/deploy_cluster.yml -vvv

htpasswd -b /etc/origin/master/htpasswd admin admin123
oc adm policy add-cluster-role-to-user cluster-admin admin
