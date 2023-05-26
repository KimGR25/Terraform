#!/bin/bash

#패키지 목록 업데이트 및 필요한 패키지 설치
sudo yum update -y
sudo amazon-linux-extras install -y epel
sudo yum install -y python3
sudo python3 -m pip install --upgrade pip
sudo python3 -m pip install awscli

sudo yum install -y git
sudo yum install -y java-1.8.0-openjdk.x86_64
sudo yum install -y java-1.8.0-openjdk-devel

# Jenkins 설치를 위한 리포지토리 추가
sudo yum install -y wget
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

# Jenkins 설치
sudo wget https://get.jenkins.io/redhat-stable/jenkins-2.60.3-1.1.noarch.rpm
sudo yum install -y jenkins-2.60.3-1.1.noarch.rpm

# Jenkins 서비스 시작
sudo systemctl start jenkins
sudo systemctl enable jenkins