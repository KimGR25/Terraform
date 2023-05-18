module "network" {
 source      = "./module/network" 
}

module "data" {
  source      = "./module/data"
  subnet-group-ids = module.network.mini-subnet-data_ids
  rds-security-group-ids = module.network.mini-rds-sg_ids
}

module "app" {
 source      = "./module/app" 

 vpc_id = module.network.vpc_id
 bastion_security_group_ids     = module.network.mini-bastion-sg_ids
 app_security_group_ids = module.network.mini-app-sg_ids
 public_subnet_ids = module.network.mini-public_subnets_ids
 private_subnet_ids = module.network.mini-private_subnets_ids
 alb_security_group_ids = module.network.mini-alb-sg_ids
 rds_endpoint = module.data.cluster_endpoint
}