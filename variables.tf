## AWS VARS ##
variable "aws-creds" {
    type = "string"
    description = "Please enter the system path to you AWS credentials file:"
}
variable "aws-key" {
    type = "string"
    default = "emea-sa-shared"
    description = "AWS key to apply to the instance"
}
# Windows security group
variable "sg" {
    type= "string"
    default = "WinRM Ports"
    description = "Security group (name) to apply to the instance"
}

## CHEF VARS ##
# Chef server URL
variable "chef-server" {
    type = "string"
    description = "Please enter the URL to your Chef server including organisation:"
}
# Client.pem path
variable "validation-key" {
    type = "string"
    description = "Please enter the path to your client.pem cert from the CURRENT directory:"
}
variable "chef-user" {
    type = "string"
    description = "Please enter your Chef Server username:"
}

## WINDOWS VARS ##
# Windows 2012 R2 AMI ID
variable "windows-ami" {
    type = "string"
    default = "ami-29eb7e5a"
    description = "AMI ID for Windows 2012 R2 image"
}
# Admin password
# *** WARNING - if you change this it needs to be updated in the win-userdata.ps1 script ***
variable "admin-password" {
    type = "string"
    default = "Ch4ng3m3"
    description = "Password for the admin user"
}
# Admin username
# *** WARNING - if you change this it needs to be updated in the win-userdata.ps1 script ***
variable "admin-user" {
    type = "string"
    default = "Administrator"
    description = "Username for the admin user"
}
