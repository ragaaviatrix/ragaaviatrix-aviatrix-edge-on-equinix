output "vm_public_ip" {
  value = module.aws_bastion_prod_instance.public_ip
}