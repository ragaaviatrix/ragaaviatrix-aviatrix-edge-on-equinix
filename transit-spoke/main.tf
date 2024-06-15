module "aws_transit" {
  source  = "terraform-aviatrix-modules/mc-transit/aviatrix"
  version = "2.5.2"

  cloud           = var.cloud_type_aws
  region          = var.aws_location
  cidr            = var.aws_transit_vpc_cidr
  account         = var.aws_cloud_account
  name            = var.aws_transit_vpc_name
  gw_name         = var.aws_transit_gateway_name
  local_as_number = var.aws_transit_gateway_as_number
  ha_gw           = false
}

module "aws_spoke" {
  source  = "terraform-aviatrix-modules/mc-spoke/aviatrix"
  version = "1.6.8"

  cloud           = var.cloud_type_aws
  name            = var.aws_spoke_gateway_name
  cidr            = var.aws_spoke_vpc_cidr
  region          = var.aws_spoke_region_location
  account         = var.aws_cloud_account
  transit_gw      = var.aws_transit_gateway_name
  local_as_number = var.aws_spoke_gateway_as_number
  attached        = true
  enable_bgp      = true
  depends_on      = [module.aws_transit]
  ha_gw           = false
}

module "test_vm" {
  source = "./vm-in-spoke"

  spoke_vpc_id     = module.aws_spoke.vpc.vpc_id
  public_subnet_id = module.aws_spoke.vpc.public_subnets[0].subnet_id

  depends_on = [module.aws_spoke]
}


resource "aws_vpn_gateway" "vpn_gw" {
  amazon_side_asn = var.vgw_bgp_asn
  depends_on      = [module.aws_transit]
}

resource "aws_vpn_gateway_attachment" "vpn_attachment" {
  vpc_id         = module.aws_transit.vpc.vpc_id
  vpn_gateway_id = aws_vpn_gateway.vpn_gw.id
  depends_on     = [aws_vpn_gateway.vpn_gw]
}
