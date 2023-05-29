#!/bin/bash

# 패키지 목록 업데이트 및 Tomcat 설치
sudo yum update -y
sudo yum install -y java-1.8.0-openjdk.x86_64
sudo wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.75/bin/apache-tomcat-9.0.75.tar.gz
sudo tar xvzf apache-tomcat-9.0.75.tar.gz
sudo mv apache-tomcat-9.0.75 /opt/tomcat
sudo /opt/tomcat/bin/startup.sh

# Tomcat에 간단한 웹페이지 전송
cd /opt/tomcat/webapps
sudo mv ROOT ROOT.bak
sudo curl -o demo.war https://dl.tmpstorage.com/download/file/22bmc95fqs
sudo /opt/tomcat/bin/shutdown.sh
sudo /opt/tomcat/bin/startup.sh