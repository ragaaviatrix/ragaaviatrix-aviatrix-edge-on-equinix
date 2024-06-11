resource "equinix_network_file" "gw_1_file" {

  file_name        = "${local.gw_1_name}-${local.gw_1_site_id}-cloud-init.txt"
  content          = data.local_file.first_gw.content
  metro_code       = var.metro_code
  device_type_code = "AVIATRIX_EDGE"
  process_type     = "CLOUD_INIT"
  self_managed     = true
  byol             = true
  depends_on       = [aviatrix_edge_equinix.first_gateway]
  lifecycle {
    ignore_changes = [content]
  }
}

resource "equinix_network_device" "gateway_1" {

  name               = local.gw_1_name
  metro_code         = var.metro_code
  type_code          = "AVIATRIX_EDGE_10"
  self_managed       = true
  byol               = true
  package_code       = "STD"
  notifications      = var.email_for_notifications
  term_length        = 1
  account_number     = var.equinix_acc_number
  version            = "7.1"
  core_count         = 2
  cloud_init_file_id = equinix_network_file.gw_1_file.uuid
  acl_template_id    = equinix_network_acl_template.edge-acl.id

}