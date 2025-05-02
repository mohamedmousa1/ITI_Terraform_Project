resource "aws_db_instance" "rds_mysql" {
 // identifier           = "my-mysql-db"  
  allocated_storage    = 10
  db_name              = "db1"
  engine               = "mysql"      
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  username             = var.db_user
  password             = ""
  parameter_group_name = "default.mysql8.0"
 // availability_zone    = "us-east-1b"
  db_subnet_group_name = aws_db_subnet_group.rds_subnet_group.name  //"default-vpc-0bcf30e60d25973b3"
  vpc_security_group_ids = var.vpc_security_group
  publicly_accessible    = false        
  skip_final_snapshot    = true
  
  tags = {
    Name = "MyAppDB"
  }
}
resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "my-rds-subnet-group"
  subnet_ids = var.rds_subnet_ids 

 tags = {
    Name = "MyRDSSubnetGroup"
  }
}

