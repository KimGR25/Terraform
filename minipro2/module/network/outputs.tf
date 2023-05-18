output "vpc_id" {
  value = aws_vpc.minipro2.id
}

output "mini-public_subnets_ids" {
  value = aws_subnet.mini-public_subnets.*.id
}
output "mini-private_subnets_ids" {
  value = aws_subnet.mini-private_subnets.*.id
}
output "mini-subnet-data_ids" {
  value = aws_subnet.mini-subnet-data.*.id
}

output "mini-bastion-sg_ids" {
  value = aws_security_group.mini-bastion-sg.*.id
}
output "mini-alb-sg_ids" {
  value = aws_security_group.mini-alb-sg.*.id
}
output "mini-app-sg_ids" {
  value = aws_security_group.mini-app-sg.*.id
}
output "mini-rds-sg_ids" {
  value = aws_security_group.mini-rds-sg.*.id
}