
variable "vgw_bgp_asn" {
  description = "AWS VGW BGP ASN"
}

variable "priv_vif_1" {
  type = map(object({
    name             = string
    bgp_asn          = number
    amazon_address   = string
    customer_address = string
    bgp_auth_key     = string
  }))
}

locals {
  bgp_md5_key = values(var.priv_vif_1)[0].bgp_auth_key
}

variable "gw_1_site_id" {

}

variable "gw_1_name" {

}

variable "gw_1_bgp_asn" {

}

variable "email_for_notifications" {

}

variable "aws_region" {

}

variable "metro_code" {

}

variable "avx_edge_gw_1_uuid" {

}

variable "aws_vpn_gw_id" {

}

