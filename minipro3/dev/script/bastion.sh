#!/bin/bash

# Password 인증 및 Root 사용자 접속을 허용하고 Password설정
sudo sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_configsudo
sudo sed -i 's/^#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
sudo systemctl restart sshd
sudo echo 'minipro3' | passwd --stdin root

# 패키지 목록 업데이트 및 필요한 패키지 설치
sudo yum update -y
sudo yum install -y git
sudo yum install -y docker
sudo systemctl start docker
sudo systemctl enable docker

sudo mkdir -p ~/minipro3

sudo sh -c 'cat <<EOF > ~/minipro3/Dockerfile

FROM tgagor/centos-stream
MAINTAINER MINIPRO3
RUN yum -y install httpd
COPY index.html /var/www/html/
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
EXPOSE 80

EOF'

sudo sh -c 'cat <<EOF > ~/minipro3/index.html
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
    .red-box {
        background-color: red;
        width: 200px;
        height: 200px;
        text-align: center;
        line-height: 200px;
        color: white;
        font-size: 24px;
    }
</style>
</head>
<body>
    <h1>Host Name: <span id="hostname"></span></h1>
    <div class="red-box">This is Red Server</div>

    <script>
        // 호스트 이름 가져오기
        var hostname = window.location.hostname;
        document.getElementById("hostname").innerText = hostname;
    </script>
</body>
</html>

EOF'

sudo sh -c 'cat <<EOF > ~/minipro3/buildspec.yml
version: 0.2
phases:
  pre_build:
    commands:
      - echo Logging in to Amazon ECR...
      - aws ecr get-login-password --region ap-northeast-2 | docker login --username AWS --password-stdin ${ecr_url2}
  build:
    commands:
      - echo Build started on `date`
      - echo Building the Docker image...
      - docker build -t service:1 .
      - docker tag service:1 ${ecr_url}:latest
  post_build:
    commands:
      - echo Build completed on `date`
      - echo Pushing the Docker image...
      - docker push ${ecr_url}:latest
      - printf '[{"name":"mini3-service","imageUri":"${ecr_url}:latest"}]' > imagedefinitions.json

artifacts:
  files: imagedefinitions.json

EOF'

sudo sh -c 'cat <<EOF > ~/.netrc
machine git-codecommit.ap-northeast-2.amazonaws.com
login terraform.user01-at-687038611946
password WZZse0XiEuiAvKAmsGWg7OvSKB9wCF3vCld660cXAPw=

EOF'

sudo su -
cd ~/minipro3
sudo git clone ${commit_url}
sudo mv Dockerfile mini3-Codecommit-Repository/
sudo mv index.html mini3-Codecommit-Repository/
sudo mv buildspec.yml mini3-Codecommit-Repository/

