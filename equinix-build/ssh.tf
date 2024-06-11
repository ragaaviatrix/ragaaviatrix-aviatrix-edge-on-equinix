resource "equinix_network_acl_template" "edge-acl" {
  name        = "edge-acl-template-for-access"
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