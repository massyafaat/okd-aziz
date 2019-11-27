#!/bin/bash

ssh kub-m1.azizpunya.com mkdir -p /etc/origin/master/
ssh kub-m2.azizpunya.com mkdir -p /etc/origin/master/
ssh kub-m3.azizpunya.com mkdir -p /etc/origin/master/
touch /etc/origin/master/htpasswd
ssh kub-m1.azizpunya.com touch /etc/origin/master/htpasswd
ssh kub-m2.azizpunya.com touch /etc/origin/master/htpasswd
ssh kub-m3.azizpunya.com touch /etc/origin/master/htpasswd

## Default variables to use
[ ! -d openshift-ansible ] && git clone https://github.com/openshift/openshift-ansible.git -b release-3.11 --depth=1

ansible-playbook -i inventory.ini openshift-ansible/playbooks/prerequisites.yml
ansible-playbook -i inventory.ini openshift-ansible/playbooks/deploy_cluster.yml

ssh kub-m1.azizpunya.com htpasswd -b /etc/origin/master/htpasswd admin admin123
ssh kub-m2.azizpunya.com htpasswd -b /etc/origin/master/htpasswd admin admin123
ssh kub-m3.azizpunya.com htpasswd -b /etc/origin/master/htpasswd admin admin123
ssh kub-m1.azizpunya.com oc adm policy add-cluster-role-to-user cluster-admin admin