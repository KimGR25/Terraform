#!/bin/bash

check_expect=$(rpm -qa | grep expect)
if [ -z "$check_expect" ];
    then sudo yum install -y expect
fi

id=jenkins
pw=jenkins1!

sudo userdel $id
sudo adduser $id

expect << EOF
spawn sudo passwd $id

expect "New password:"
send "$pw\r";    

expect "Retype new password:"
send "$pw\r";    

expect eof
EOF

num=$(sudo grep -n "## Allow root" /etc/sudoers | cut -d: -f1 | head -1)
num=$((num+1))
data=$(sudo cat /etc/sudoers | sed -n ${num}p)
data2=$(echo ${data} | sed -e "s/root.*/${id}\tALL=(ALL)\tNOPASSWD: ALL/g")
sudo sed -i "${num}s/${data}/${data}\n${data2}/g" /etc/sudoers
sudo sed -i "s/PasswordAuthentication no/PasswordAuthentication yes/g" /etc/ssh/sshd_config
sudo service sshd restart

sudo rm /etc/localtime
sudo ln -s /usr/share/zoneinfo/Asia/Seoul /etc/localtime
date

#패키지 목록 업데이트 및 필요한 패키지 설치
sudo yum update -y
sudo amazon-linux-extras install -y epel
sudo yum install -y python3
sudo python3 -m pip install --upgrade pip
sudo python3 -m pip install awscli

sudo yum install -y git
sudo yum install -y fontconfig
sudo yum install -y java-11-amazon-corretto.x86_64
sudo yum install -y java-11-amazon-corretto-devel.x86_64

# Jenkins 설치를 위한 리포지토리 추가
sudo yum install -y wget
sudo  wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

# Jenkins 설치
sudo yum install -y jenkins

# Jenkins 서비스 시작
sudo systemctl start jenkins
sudo systemctl enable jenkins

# CodeDeploy Agent 설치
sudo yum -y install ruby
sudo yum -y install wget
cd /home/ec2-user
sudo wget https://aws-codedeploy-ap-northeast-2.s3.ap-northeast-2.amazonaws.com/latest/install

sudo chmod +x ./install
sudo ./install auto
sudo service codedeploy-agent start
sudo service codedeploy-agent status