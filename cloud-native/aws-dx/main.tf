resource "equinix_fabric_connection" "aws_dx_1" {
  name = "${var.gw_1_name}-dx-cnx"
  type = "EVPL_VC"
  notifications {
    type   = "ALL"
    emails = var.email_for_notifications
  }
  bandwidth = 50
  a_side {
    access_point {
      type = "VD"
      virtual_device {
        type = "EDGE"
        uuid = var.avx_edge_gw_1_uuid
      }
      interface {
        type = "CLOUD"
        id   = 0
      }
    }
  }
  z_side {
    access_point {
      type               = "SP"
      authentication_key = data.aws_caller_identity.current.account_id
      seller_region      = var.aws_region
      profile {
        type = "L2_PROFILE"
        uuid = data.equinix_fabric_service_profiles.aws.id
      }
      location {
        metro_code = var.metro_code
      }
    }
  }
  lifecycle {
    ignore_changes = [redundancy, z_side]
  }
}

resource "time_sleep" "wait_10_mins" {
  create_duration = "600s"
}

resource "aws_dx_connection_confirmation" "dx_1" {
  connection_id = data.aws_dx_connection.dx_1.id
  lifecycle {
    ignore_changes = [connection_id, id]
  }
  depends_on = [time_sleep.wait_10_mins] # Default timeout is 10m. Sometimes connection confirmation can take over 10 minutes and result in timeout errors. 
  # The depends_on will add 10 more minutes to the wait time. 
  # There is no timeout attribute available for this resource

}


resource "aws_dx_private_virtual_interface" "private_vif_1" {
  for_each         = var.priv_vif_1
  connection_id    = data.aws_dx_connection.dx_1.id
  vpn_gateway_id   = var.aws_vpn_gw_id
  name             = each.value.name
  vlan             = data.aws_dx_connection.dx_1.vlan_id
  address_family   = "ipv4"
  bgp_asn          = each.value.bgp_asn
  amazon_address   = each.value.amazon_address
  customer_address = each.value.customer_address
  bgp_auth_key     = each.value.bgp_auth_key
  depends_on       = [aws_dx_connection_confirmation.dx_1]
  lifecycle {
    ignore_changes = [connection_id, vlan]
  }
}

# Create a DX connection to AWS DX (WAN underlay)
resource "aviatrix_edge_spoke_external_device_conn" "to_aws_dx_1" {
  site_id              = var.gw_1_site_id
  connection_name      = "" #needs to be blank for WAN underlay
  gw_name              = var.gw_1_name
  bgp_local_as_num     = var.gw_1_bgp_asn
  bgp_remote_as_num    = var.vgw_bgp_asn
  enable_edge_underlay = true
  bgp_md5_key          = local.bgp_md5_key
  local_lan_ip         = "10.11.1.2"
  remote_lan_ip        = "10.11.1.1"
}