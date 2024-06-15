locals {
  gw_1_name    = format("%s%d", values(var.edge_gateway_1)[0].gw_name, random_integer.random_suffix.result) # create a unique gateway name as multiple people can deploy in the same Equinix account
  gw_1_site_id = values(var.edge_gateway_1)[0].site_id
  gw_1_bgp_asn = values(var.edge_gateway_1)[0].local_as_number
}

resource "random_integer" "random_suffix" {
  min = 1000
  max = 9999
}

locals {
  priv_vif_1 = {
    "vif_1" = {
      name             = "vif_1_to_edge_1"
      bgp_asn          = values(var.edge_gateway_1)[0].local_as_number # edge gateway ASN
      amazon_address   = "10.11.1.1/24"
      customer_address = "10.11.1.2/24"
      bgp_auth_key     = var.aws_dx_bgp_md5_key
    },
  }
}


