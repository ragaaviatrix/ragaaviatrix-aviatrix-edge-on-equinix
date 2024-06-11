
## Generate Private-Key Pair
resource "tls_private_key" "priv_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "key_pair" {
  key_name   = "ubuntu-keypair"
  public_key = tls_private_key.priv_key.public_key_openssh
}

resource "local_file" "local_ssh_key" {
  filename        = "${aws_key_pair.key_pair.key_name}.pem"
  content         = tls_private_key.priv_key.private_key_pem
  file_permission = "0400"
}

##################################
# Data source to get AMI details #
##################################

data "aws_ami" "ubuntu" {
  # provider    = aws.aws_usw
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["aws-marketplace"]
}


############################################
# Create AWS Spoke/Bastion Security-Group  #
############################################

module "aws_bastion_nsg" {
  source              = "terraform-aws-modules/security-group/aws"
  version             = "5.1.2"
  name                = "Test-VM-Prod-Public"
  description         = "Security Group for Bastion Host in Prod"
  vpc_id              = var.spoke_vpc_id
  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["ssh-tcp", "all-icmp"]
  egress_rules        = ["all-all"]
}


###  Bastion Host in Prod VPC ###
module "aws_bastion_prod_instance" {
  source                      = "terraform-aws-modules/ec2-instance/aws"
  version                     = "3.6.0"
  instance_type               = "t2.micro"
  name                        = "test-server"
  ami                         = data.aws_ami.ubuntu.id
  key_name                    = aws_key_pair.key_pair.key_name
  subnet_id                   = var.public_subnet_id
  vpc_security_group_ids      = [module.aws_bastion_nsg.security_group_id]
  associate_public_ip_address = true
}