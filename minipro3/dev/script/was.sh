#!/bin/bash

# 패키지 목록 업데이트 및 Tomcat 설치
sudo yum update -y
sudo yum install -y java-1.8.0-openjdk.x86_64
sudo wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.75/bin/apache-tomcat-9.0.75.tar.gz
sudo tar xvzf apache-tomcat-9.0.75.tar.gz
sudo mv apache-tomcat-9.0.75 /opt/tomcat
sudo /opt/tomcat/bin/startup.sh

# 로드밸런서 작동확인을 위한 간단한 웹페이지 작성
sudo sh -c 'cat << EOF > /opt/tomcat/webapps/ROOT/test.jsp
<%@ page language="java" %>
<html>
<head>
    <title>MiniProject3</title>
</head>
<body>
    <h1>MiniProject3_Tomcat <%= java.net.InetAddress.getLocalHost().getHostName() %></h1>
</body>
</html>
EOF'

sudo /opt/tomcat/bin/shutdown.sh
sudo /opt/tomcat/bin/startup.sh