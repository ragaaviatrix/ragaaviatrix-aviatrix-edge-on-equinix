output "avx_edge_1_pub_ip" {
  value = module.equinix_virtual_devices.edge_1_pub_ip["ssh_ip_address"]
}

output "test_vm_pub_ip" {
  value = module.transit_and_spoke_aws[0].vm_public_ip
}