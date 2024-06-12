
data "local_file" "first_gw" {
  filename   = "${path.module}/${local.gw_1_name}-${local.gw_1_site_id}-cloud-init.txt"
  depends_on = [aviatrix_edge_equinix.first_gateway]
}

data "equinix_network_device" "avx_edge_gw_1" {
  uuid = equinix_network_device.gateway_1.uuid
}