module "vpc" {
     source = "./moduals/vpc"
      cidr = "10.0.0.0/16"

  
}
module "public_subnet" {
    source = "./moduals/public_subnet"
    vpc_id = module.vpc.vpc_id
  
  
}
module "private_subnet" {
    source = "./moduals/private_subnet"
    vpc_id = module.vpc.vpc_id
    subnet_tag = "subnet1"
    aws_subnet_cidr = "10.0.3.0/24"
    zone = "us-east-1a"
  
}
module "private_subnet2" {
    source = "./moduals/private_subnet"
    vpc_id = module.vpc.vpc_id
    subnet_tag = "subnet2"
    aws_subnet_cidr = "10.0.2.0/24"
    zone = "us-east-1b"
  
}
module "security_group_rds" {
    vpc_id = module.vpc.vpc_id
    source = "./moduals/security_group"
    port = ["3306"]
    type = ["tcp"]
    tag = "rds"
  
}
module "security_group" {
   vpc_id = module.vpc.vpc_id
    source = "./moduals/security_group"
    port = ["80","443","22"]
    type = ["tcp","tcp","tcp"]
    tag = "ec2"
   
  
}
module "ec2" {
    source = "./moduals/ec2"
    ami = "ami-0c02fb55956c7d316"
    subnet_id = module.public_subnet.subnet_id
    security_group = [module.security_group.security_group_id]
  
}
module "ec2" {
    source = "./moduals/ec2"
    ami = "ami-0c02fb55956c7d316"
    subnet_id = module.private_subnet2.subnet_id
    security_group = [module.security_group.security_group_id]
  
}
module "RDS"{
  source = "./moduals/rds"
  db_name = "mysql"
  db_password = "mysql"
  rds_subnet_ids = [module.private_subnet.subnet_id,module.private_subnet2.subnet_id]
  vpc_security_group = [module.security_group_rds.security_group_id]

}

