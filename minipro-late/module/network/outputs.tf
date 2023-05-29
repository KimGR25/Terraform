output "vpc_id" {
  value = aws_vpc.mini3_vpc.id
}

output "mini3_public_subnets_ids" {
  value = aws_subnet.mini3_public_subnets.*.id
}
output "mini3_private_subnets_ids" {
  value = aws_subnet.mini3_private_subnets.*.id
}
output "mini3_data_subnets_ids" {
  value = aws_subnet.mini3_data_subnets.*.id
}

output "mini3_bastion_sg_ids" {
  value = aws_security_group.mini3_bastion_sg.*.id
}
output "mini3_jenkins_sg_ids" {
  value = aws_security_group.mini3_jenkins_sg.*.id
}
output "mini3_web_alb_sg_ids" {
  value = aws_security_group.mini3_web_alb_sg.*.id
}
output "mini3_web_sg_ids" {
  value = aws_security_group.mini3_web_sg.*.id
}
output "mini3_was_nlb_sg_ids" {
  value = aws_security_group.mini3_was_nlb_sg.*.id
}
output "mini3_was_sg_ids" {
  value = aws_security_group.mini3_was_sg.*.id
}
output "mini3_data_sg_ids" {
  value = aws_security_group.mini3_data_sg.*.id
}