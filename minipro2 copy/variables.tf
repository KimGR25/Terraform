variable "cidr-block" {
  description = "cidr-block value"
  type = string
  default = "10.0.0.0/16"
}

variable "my-azs" {
  description = "azs value"
  type = list(string)
  default = [ "ap-northeast-2a", "ap-northeast-2b" ]
}

variable "vpc-public_subnets" {
  description = "vpc-public-subnet"
  type = list(string)
  default = [ "10.0.1.0/24", "10.0.2.0/24" ]
}

variable "public-subnet-names" {
  description = "public-subnet-names"
  type = list(string)
  default = [ "mini-public1", "mini-public2" ]
}

variable "vpc-private-subnet" {
  description = "vpc-private-subnet"
  type = list(string)
  default = [ "10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24","10.0.104.0/24" ]
}

variable "private-subnet-names" {
  description = "private-subnet-names"
  type = list(string)
  default = [ "mini-private1", "mini-private2", "mini-private3", "mini-private4" ]
}

variable "igw-name" {
  description = "Internet Gate Way Name"
  type = map(string)
  default = {
    Name = "mini-igw"
  }
}

variable "ingress-list" {
  description = "public ingress-list"
  type = list(map(string))
  default = [
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
      cidr_blocks = "0.0.0.0/0"
    }
  ]
}

variable "egress-list" {
  description = "engress-list"
  type = list(map(string))
  default = [
    {
      from_port   = 0                                
      to_port     = 0                                
      protocol    = "-1"                             
      description = "all"                            
      cidr_blocks = "0.0.0.0/0"                      
    }
  ]
}
