
variable "email_for_notifications" {

}

variable "aws_region" {

}

variable "metro_code" {

}

variable "controller_ip" {

}

variable "copilot_ip" {

}

variable "equinix_acc_name" {

}

variable "equinix_acc_number" {

}

variable "file_download_path" {

}

variable "aws_dx_bgp_asn" {

}

variable "bgp_md5_key" {

}

variable "gateway_1" {
  type = map(object({
    gw_name         = string # name of the edge gateway
    site_id         = string # ID of the site, eg: use-site-A
    local_as_number = string # BGP ASN for the gateway
    wan_ip_address  = string # IP address of the primary eth0 interface eg: "10.150.1.2/24
    wan_gateway_ip  = string # IP address of the CSR interface towards primary gateway
    lan_ip_address  = string # IP address of the primary eth1 interface eg: "192.168.100.1/24"
  }))
}

locals {
  gw_1_name    = values(var.gateway_1)[0].gw_name
  gw_1_site_id = values(var.gateway_1)[0].site_id
  gw_1_bgp_asn = values(var.gateway_1)[0].local_as_number
}