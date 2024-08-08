locals {
  stack_env = terraform.workspace
  vpc_cidr = lookup(
    var.vpc_cidr,
    terraform.workspace,
    var.vpc_cidr[var.default_value],
  )
  cidr_public_subnet = lookup(
    var.cidr_public_subnet,
    terraform.workspace,
    var.cidr_public_subnet[var.default_value],
  )
  cidr_private_subnet = lookup(
    var.cidr_private_subnet,
    terraform.workspace,
    var.cidr_private_subnet[var.default_value],
  )
  eu_availibility_zone = lookup(
    var.eu_availibility_zone,
    terraform.workspace,
    var.eu_availibility_zone[var.default_value],
  )
  instance_type = lookup(
    var.instance_type,
    terraform.workspace,
    var.instance_type[var.default_value],
  )
  slave_instance_type = lookup(
    var.slave_instance_type,
    terraform.workspace,
    var.slave_instance_type[var.default_value],
  )
  ami_id = lookup(
    var.ami_id,
    terraform.workspace,
    var.ami_id[var.default_value],
  )
}

variable "default_value" {
  description = "This will be the default defined for each variable."
  default     = "default"
}

variable "region" {
  default = "eu-west-1"
}

variable "vpc_cidr" {
  type        = map(string)
  description = "CIDR Range for the Virtual Private Network"
  default = {
    prod    = "13.0.0.0/16"
    preprod = "12.0.0.0/16"
    default = "11.0.0.0/16"
  }
}

variable "ami_id" {
  description = "AMI ID to be used for the EC2 instance"
  default = {
    prod    = ""
    preprod = ""
    default = "ami-0932dacac40965a65"
  }
}

variable "instance_type" {
  description = "Size of the instance to be used"
  type        = map(string)
  default = {
    prod    = "t2.large"
    preprod = "t2.medium"
    default = "t2.micro"
  }
}

variable "slave_instance_type" {
  description = "Instance type for slave Jenkins Node"
  type        = map(string)
  default = {
    prod    = "t2.large"
    preprod = "t2.medium"
    default = "t2.medium"
  }
}

variable "cidr_public_subnet" {
  description = "CIDR Range for the Public Subnet"
  type        = map(list(string))
  default = {
    prod    = ["13.0.1.0/24", "13.0.2.0/24"]
    preprod = ["12.0.1.0/24", "12.0.2.0/24"]
    default = ["11.0.1.0/24", "11.0.2.0/24"]
  }
}

variable "cidr_private_subnet" {
  type        = map(list(string))
  description = "CIDR Range for the Private Subnet"
  default = {
    prod    = ["13.0.3.0/24", "13.0.4.0/24"]
    preprod = ["12.0.3.0/24", "13.0.4.0/24"]
    default = ["11.0.3.0/24", "11.0.4.0/24"]
  }
}

variable "eu_availibility_zone" {
  type = map(list(string))
  default = {
    prod    = [""]
    preprod = [""]
    default = ["eu-west-1a", "eu-west-1b"]
  }
}