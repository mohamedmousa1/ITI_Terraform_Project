variable "db_name" {
    default = "mydb"
  
}
variable "db_password" {
    default = "Abdalla#21"
  
}
variable "db_user" {
    default = "db_admin"
  
}
variable "rds_subnet_ids" {
  type = list(string)
  default = [ "default-vpc-0bcf30e60d25973b3" ]
}
variable "vpc_security_group" {
    type = list(string)
  
}