variable "type" {
    default = "t3.micro"
  
}
variable "ami" {
    default = "ami-005e54dee72cc1d00"
  
}
variable "subnet_id" {
    default = ""
  
}
variable "security_group" {
     type    = list(string)
     default = ["sg-08f83f0ab1ceda63c"]
  
}
variable "public_ip" {
    default = true
  
}