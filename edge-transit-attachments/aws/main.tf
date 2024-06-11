resource "aviatrix_edge_spoke_transit_attachment" "edge_1_attachment" {
  spoke_gw_name       = var.edge_gw_name
  transit_gw_name     = var.transit_gw_name
  edge_wan_interfaces = ["eth0"]
  enable_insane_mode  = true
}