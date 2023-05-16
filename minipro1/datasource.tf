data "aws_ami" "server-ami" {
  most_recent = true
  # 소유자 계정 ID
  owners = ["099720109477"]   

  filter {
    # AMI 이름
    name = "name"    
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}