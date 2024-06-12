module "transit_and_spoke" {
  count  = var.enable_aws ? 1 : 0
  source = "./transit-spoke"

  providers = {
    aws = aws.useast1
  }

  aws_region_1_location                  = var.aws_region_1_location
  aws_transit_region_1_vpc_cidr          = var.aws_transit_region_1_vpc_cidr
  aws_cloud_account                      = var.aws_cloud_account
  aws_transit_region_1_vpc_name          = var.aws_transit_region_1_vpc_name
  aws_transit_region_1_gateway_name      = var.aws_transit_region_1_gateway_name
  aws_transit_region_1_gateway_as_number = var.aws_transit_region_1_gateway_as_number
  aws_region_1_spoke_1_gateway_name      = var.aws_region_1_spoke_1_gateway_name
  aws_region_1_spoke_1_region_location   = var.aws_region_1_spoke_1_region_location
  aws_region_1_spoke_1_vpc_cidr          = var.aws_region_1_spoke_1_vpc_cidr
  aws_spoke_region_1_gateway_as_number   = var.aws_spoke_region_1_gateway_as_number
  vgw_bgp_asn                            = var.aws_dx_bgp_asn
}

module "wait_module" {
  source = "./aws-wait"
  depends_on = [ module.transit_and_spoke ]
}

module "equinix_virtual_devices" {
  source                  = "./equinix-build"
  email_for_notifications = var.email_for_notifications
  metro_code              = var.equinix_metro_code
  equinix_acc_name        = var.equinix_account_name
  equinix_acc_number      = var.equinix_account_number
  aws_region              = var.aws_region_1_location
  controller_ip           = var.controller_ip
  copilot_ip              = var.copilot_ip
  gateway_1               = var.region_1_edge_gateway_1
  aws_dx_bgp_asn          = var.aws_dx_bgp_asn
  bgp_md5_key             = var.aws_dx_bgp_md5_key
  depends_on              = [module.transit_and_spoke, module.wait_module]
}

module "aws_region_1_dx" {
  count  = var.enable_aws ? 1 : 0
  source = "./cloud-native/aws-dx"
  providers = {
    aws = aws.useast1
  }
  vgw_bgp_asn             = var.aws_dx_bgp_asn
  priv_vif_1              = local.priv_vif_1
  metro_code              = var.equinix_metro_code
  aws_region              = var.aws_region_1_location
  email_for_notifications = var.email_for_notifications
  gw_1_name               = local.gw_1_name
  gw_1_bgp_asn            = local.gw_1_bgp_asn
  gw_1_site_id            = local.gw_1_site_id
  avx_edge_gw_1_uuid      = module.equinix_virtual_devices.avx_edge_1_uuid
  aws_vpn_gw_id           = module.transit_and_spoke[0].aws_vpn_gw_id
  depends_on              = [module.equinix_virtual_devices]
}

# module "edge_transit_attachments_aws" {
#   count           = var.enable_aws ? 1 : 0
#   source          = "./edge-transit-attachments/aws"
#   transit_gw_name = var.aws_transit_region_1_gateway_name
#   edge_gw_name    = local.edge_gw_name
#   depends_on      = [module.aws_region_1_dx]
# }



