## 1. VPC생성
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "minipro2"
  cidr = var.cidr-block

  azs             = var.my-azs
  private_subnets = var.vpc-private-subnet
  private_subnet_names = var.private-subnet-names
  public_subnets  = var.vpc-public_subnets
  public_subnet_names = var.public-subnet-names

  enable_dns_hostnames = true
  enable_dns_support   = true

  create_igw = true
  igw_tags = var.igw-name

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}

## 2. Security Group 생성

# 2-1. Public SG 생성
module "security-group" {
  source  = "terraform-aws-modules/security-group/aws"                                  

  name        = "mini-bastion-sg"                                  
  description = "minipro2 bastion Security Group"                                  
  vpc_id      = "${module.vpc.vpc_id}"                 
  use_name_prefix = "false"                            
  ingress_with_cidr_blocks = var.ingress-list
  egress_with_cidr_blocks = var.egress-list
}

## 2-2. Application SG 생성
module "security-group2" {
  source  = "terraform-aws-modules/security-group/aws"                                  

  name        = "mini-app-sg"                                  
  description = "minipro2 App Security Group"                                  
  vpc_id      = "${module.vpc.vpc_id}"                 
  use_name_prefix = "false"                            
  ingress_with_cidr_blocks = [
    {
      from_port   = 8080                               
      to_port     = 8080                             
      protocol    = "tcp"                            
      description = "http"                          
      cidr_blocks = "0.0.0.0/0"                      
    },
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      description = "http"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "ssh"
      security_groups = module.security-group.security_group_id
    }
  ]
  egress_with_cidr_blocks = var.egress-list
}

## 2-3. Application Load Balancer SG 생성
module "security-group3" {
  source  = "terraform-aws-modules/security-group/aws"                                  

  name        = "mini-alb-sg"                                  
  description = "minipro2 ALB Security Group"                                  
  vpc_id      = "${module.vpc.vpc_id}"                 
  use_name_prefix = "false"                            
  ingress_with_cidr_blocks = var.public-ingress-list
  egress_with_cidr_blocks = var.egress-list
}




module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "minipro-Bastion"

  ami                         = "ami-03f54df9441e9b380"
  instance_type               = "t2.micro"
  availability_zone           = element(module.vpc.azs, 0)
  subnet_id                   = element(module.vpc.private_subnets, 0)
  vpc_security_group_ids      = [module.security-group.security_group_id]
  
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}