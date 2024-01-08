#! /bin/bash
yum update -y
hostnamectl set-hostname jenkins-server
wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
yum upgrade
amazon-linux-extras install java-openjdk11 -y
amazon-linux-extras install epel -y
yum install jenkins -y
systemctl enable jenkins
systemctl start jenkins
yum install git -y
