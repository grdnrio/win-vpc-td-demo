#
# This terraform template demostrates how to deploy Windows nodes
# into a specific VPC on AWS.
#
# Author: Joe Gardiner
# Email: joe@chef.io
#

# Configure AWS provider
provider "aws" {
    region = "eu-west-1"
    shared_credentials_file = "${var.aws-creds}"
    profile = "default"
}

# How many nodes are required?
variable "num-nodes" {
    description = "Number of nodes required"
}
variable "vpc-id" {
    description = "Enter required VPC ID"
}

# Create a VPC
resource "aws_vpc" "vpc-demo" {
    cidr_block = "10.0.0.0/16"
    tags {
        Name = "vpc-deploy-demo"
    }
}


# Create production auto-scan nodes
resource "aws_instance" "windows-prod" {
    count = "${var.num-nodes}"
    instance_type = "t2.small"
    ami = "${var.windows-ami}"
        key_name = "${var.aws-key}"
    associate_public_ip_address = true
    security_groups = ["${var.win-sg}"]
    subnet_id = ["${var.vpc-demo}"]

    tags {
        Name = "prod-win-${count.index +1}"
    }

    connection {
        type = "winrm"
        user = "${var.admin-user}"
        password = "${var.admin-password}"
    }

    user_data = "${file("windows/win-userdata.ps1")}"

    provisioner "chef"  {
        environment = "production"
        run_list = ["role[client]"]
        node_name = "${var.chef-user}-prod-web-${count.index +1}"
        server_url = "${var.chef-server}"
        validation_key = "${file("${var.validation-key}")}"
        validation_client_name = "${var.chef-user}"
    }
}
