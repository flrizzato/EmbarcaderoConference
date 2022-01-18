terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "database" {
  ami = data.aws_ami.ubuntu.id
  #ami = "ami-09e67e426f25ce0d7"
  instance_type = "t2.micro"
  key_name      = "terraform_aws"
  tags = {
    Name = "Linux Database"
  }
}

data "aws_ami" "windows" {
  most_recent = true
  filter {
    name   = "name"
    values = ["Windows_Server-2019-English-Full-Base-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["801119661308"] # Canonical
}

resource "aws_instance" "windows" {
  ami               = data.aws_ami.windows.id
  instance_type     = "t2.medium"
  key_name          = "terraform_aws"
  get_password_data = true
  tags = {
    Name = "Meu servidor widnows"
  }


}

resource "aws_key_pair" "terraform_aws" {
  key_name   = "terraform_aws"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDAla+9VV5wvfx8naKkZ8fEJUNheNwWEd/xzNmM2Lor0Qn6Fj0CFhr8L+X9NO1SS2+tT5FnfJbsOCOCyb6iC/NoO7Q+nN3nQN4MtRNWYFuuAHSSOZVNcLJby33KmqwpxsBxLf/ujGUE2teipEWSk5SNLlGseeG/MCuFGgiGeDM0acvBp/rHBdu70j11Ma8wJNCKD7mwmURrd6en612n94mEaX/zMbI6oA5Gl0isXaGhU+uUgfFNquxSmzD9rzzqFSKZaDTng9q8j33rEtsXaL4z8kFSu7IDREvdnmZn8xR+FybQCpnVLJojvN58aOu52nr6ngOD3TxYrPwP+kNuGk6aC2N7EfCDOdeYzLCEH1z2joaJpH/KSzDn+0NMqyzi0Ki+PUJdWAvYHliizXkETzXdqIgRVGEDf7coyQZRrMbsXsR59/hcKKaOs6fRqhYNjQWvvCt1MoHbjog9SEFX52Oaa925DcbxSG6lQ7aHDN8WbCHrLwlZA5rFZ3R2P/D5yE8= andersondapper@MacBook-Pro-de-Anderson.local"
}

output "password" {
  value = rsadecrypt(aws_instance.windows.password_data, file("./keypair/terraform-aws"))
}

output "ip_linux" {
  value = aws_instance.database.public_ip
}