terraform {
  backend "s3" {
    bucket               = "terraform-master-slave"
    key                  = "jenkins/jenkins-env.tfstate"
    workspace_key_prefix = "client-jnk"
    region               = "eu-west-1"
  }
}

module "networking" {
  source = "./networking"

  vpc_cidr             = local.vpc_cidr
  cidr_public_subnet   = local.cidr_public_subnet
  cidr_private_subnet  = local.cidr_private_subnet
  eu_availibility_zone = local.eu_availibility_zone
  stack_env            = local.stack_env
}

module "securitygroup" {
  source = "./securitygroup"

  vpc_id    = module.networking.vpc_id
  stack_env = local.stack_env
}

module "jenkins_master" {
  source = "./jenkins_master"

  ami_id                    = local.ami_id
  instance_type             = local.instance_type
  subnet_id                 = tolist(module.networking.cidr_public_subnet)[0]
  security_group_ids        = [module.securitygroup.jenkins-8080-id, module.securitygroup.jenkins-terraform-sg-id]
  enable_public_ip_address  = true
  user_data_install_jenkins = templatefile("./jenkins-master-runner-script/jenkins-installer.sh", {})
  stack_env                 = local.stack_env
}

module "jenkins_slave" {
  source = "./jenkins_slave"

  ami_id                    = local.ami_id
  instance_type             = local.slave_instance_type
  subnet_id                 = tolist(module.networking.cidr_public_subnet)[0]
  security_group_ids        = [module.securitygroup.jenkins-8080-id, module.securitygroup.jenkins-terraform-sg-id]
  enable_public_ip_address  = true
  user_data_install_jenkins = templatefile("./jenkins-master-runner-script/jenkins-slave.sh", {})
  stack_env                 = local.stack_env

}