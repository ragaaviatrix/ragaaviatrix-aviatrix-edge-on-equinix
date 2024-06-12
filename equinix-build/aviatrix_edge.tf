resource "aviatrix_edge_equinix" "first_gateway" {
  for_each               = var.gateway_1
  account_name           = var.equinix_acc_name
  gw_name                = each.value.gw_name
  site_id                = each.value.site_id
  ztp_file_download_path = path.module #var.file_download_path

  local_as_number = each.value.local_as_number
  interfaces {
    name       = "eth0"
    type       = "WAN"
    ip_address = each.value.wan_ip_address
    gateway_ip = each.value.wan_gateway_ip
  }

  interfaces {
    name       = "eth1"
    type       = "LAN"
    ip_address = each.value.lan_ip_address
  }

  lifecycle {
    ignore_changes = [interfaces, management_egress_ip_prefix_list]
  }
}