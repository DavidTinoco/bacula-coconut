#!/bin/bash
# Backup Installed Packages
# Created on 09-01-2018
# Author: David Tinoco Castillo
# Version 0.1

ssh -i /root/.ssh/copias root@10.0.0.9 'dpkg --get-selections | grep -v deinstall | cut -f1' > /copias/installedPackages/mickey`date +%Y%m%d`
ssh -i /root/.ssh/copias root@10.0.0.10 'dpkg --get-selections | grep -v deinstall | cut -f1' > /copias/installedPackages/minnie`date +%Y%m%d`
ssh -i /root/.ssh/copias root@10.0.0.6 'rpm -qa' > /copias/installedPackages/donald`date +%Y%m%d`

