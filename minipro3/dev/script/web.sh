#!/bin/bash

# 패키지 목록 업데이트 및 Nginx 설치
sudo yum update -y
sudo yum -y install httpd

sudo systemctl start httpd
sudo systemctl enable httpd

sudo sh -c 'echo "LB DNS: ${dns_address}" > /etc/httpd/conf/instance_info.txt'
# 로드밸런서가 정상작동하는지 확인하기 위한 간단한 웹페이지 생성
cd /var/www/html
sudo sh -c 'echo "MiniProject3 $(hostname -f)" > /var/www/html/index.html'


# was 서버와 연동을 위한 작업
sudo sed -i '/Include conf.modules.d\/\*.conf/a LoadModule proxy_connect_module modules\/mod_proxy_connect.so\nLoadModule proxy_module modules\/mod_proxy.so\nLoadModule proxy_http_module modules\/mod_proxy_http.so' /etc/httpd/conf/httpd.conf

sudo sh -c 'cat <<EOF >> /etc/httpd/conf/httpd.conf

<VirtualHost *:80>
    ProxyRequests On
    ProxyPreserveHost On

    <Proxy *>
        Require all granted
        SetEnv force-proxy-request-1.0.1
        SetEnv proxy-nokeepalive 1
        SetEnv proxy-initial-not-pooled 1
    </Proxy>

    ProxyPass "/servlet/" "http://${dns_address}:8080/" ttl=60
    ProxyPassMatch "^/.*\.(jsp|do)$" "http://${dns_address}:8080/"

    Timeout 120
</VirtualHost>

EOF'
sudo systemctl restart httpd
