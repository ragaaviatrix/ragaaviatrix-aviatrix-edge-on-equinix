locals {
  gw_1_name    = values(var.region_1_edge_gateway_1)[0].gw_name
  gw_1_site_id = values(var.region_1_edge_gateway_1)[0].site_id
  gw_1_bgp_asn = values(var.region_1_edge_gateway_1)[0].local_as_number
}
