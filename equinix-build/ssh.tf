resource "equinix_network_acl_template" "edge-acl" {
  name        = local.edge_acl_name
  description = "edge acl template"
  inbound_rule {
    subnet      = "${var.controller_ip}/32"
    protocol    = "IP"
    src_port    = "any"
    dst_port    = "any"
    description = "Allowed inbound from the controller"
  }
  inbound_rule {
    subnet      = "${var.copilot_ip}/32"
    protocol    = "IP"
    src_port    = "any"
    dst_port    = "any"
    description = "Allowed inbound from the copilot"
  }
}

locals {
  edge_acl_name = format("%s%d", "edge-acl-template-for-access-", var.random_value) # create a unique ACL name as multiple people can deploy in the same Equinix account
}

