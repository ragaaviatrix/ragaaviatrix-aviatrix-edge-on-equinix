
output "vm_public_ip" {
  value = module.test_vm.vm_public_ip
}

output "aws_vpn_gw_id" {
  value = aws_vpn_gateway.vpn_gw.id
}