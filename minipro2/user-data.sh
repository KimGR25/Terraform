#!/bin/bash

rds_address=${db_address}

sudo yum update -y
sudo yum install -y libjpeg* libpng* freetype* gd-* gcc gcc-c++ gdbm-devel
sudo yum install -y httpd*
sudo yum install -y php php-common php-opcache php-cli php-gd php-curl php-mysqlnd php-mysqli

sudo systemctl enable httpd
sudo systemctl start httpd

sudo sh -c 'echo "<?php echo \"Terraform Tutorial \" . gethostname(); ?>" > /var/www/html/index.php'
sudo sh -c 'echo "<?php phpinfo(); ?>" > /var/www/html/phpinfo.php'
