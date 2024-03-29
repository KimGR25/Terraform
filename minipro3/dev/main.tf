module "network" {
  source = "../module/network"
}

module "cicd" {
  source = "../module/cicd"

  s3_bucket = data.terraform_remote_state.mini3_s3.outputs.mini3_s3_bucket
}

module "application" {
  source = "../module/app"

  vpc_id = module.network.vpc_id
  public_subnets_ids = module.network.mini3_public_subnets_ids[0]
  public_subnets_ids2 = module.network.mini3_public_subnets_ids
  private_subnets_ids = module.network.mini3_private_subnets_ids
  bastion_security_group_ids = module.network.mini3_bastion_sg_ids
  alb_security_group_ids = module.network.mini3_alb_sg_ids
  code_commit_url = module.cicd.mini3_codecommit_url
}