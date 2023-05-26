module "network" {
  source = "../module/network"
}




module "application" {
  source = "../module/app"

  vpc_id = module.network.vpc_id
  public_subnets_ids = module.network.mini3_public_subnets_ids[0]
  public_subnets_ids2 = module.network.mini3_public_subnets_ids
  private_subnets_ids = module.network.mini3_private_subnets_ids
  bastion_security_group_ids = module.network.mini3_bastion_sg_ids
  jenkins_security_group_ids = module.network.mini3_jenkins_sg_ids
  web_security_group_ids = module.network.mini3_web_sg_ids
  was_security_group_ids = module.network.mini3_was_sg_ids
  web_alb_security_group_ids = module.network.mini3_web_alb_sg_ids
  was_nlb_security_group_ids = module.network.mini3_was_nlb_sg_ids
}