variable "controller_ip" {
  description = "IP of the controller"
}

variable "controller_username" {
  description = "Username to login to the controller"
  default     = "admin"
}

variable "controller_password" {
  description = "Password to login to the controller"
}

variable "copilot_ip" {
  description = "Copilot IP"
}

variable "equinix_client_id" {
  description = "Equinix API client id"
}

variable "equinix_client_secret" {
  description = "Equinix API client secret"
}

variable "email_for_notifications" {
  description = "Notification emails"
  type        = list(string)
}

variable "equinix_metro_code" {
  description = "Equinix metro code eg: NY, SV etc"
  default     = "NY"
}

variable "equinix_account_name" {
  description = "Equinix account name onboarded on the controller"
}

variable "equinix_account_number" {
  description = "Equinix account number"
}

variable "enable_aws" {
  default = true
}

variable "edge_gateway_1" {
  type = map(object({
    gw_name         = string # name of the edge gateway
    site_id         = string # ID of the site, eg: use-site-A
    local_as_number = string # BGP ASN for the gateway
    wan_ip_address  = string # IP address of the primary eth0 interface eg: "10.150.1.2/24
    wan_gateway_ip  = string # IP address of the CSR interface towards primary gateway
    lan_ip_address  = string # IP address of the primary eth1 interface eg: "192.168.100.1/24"
  }))
  default = {
    "gw_1" = {
      gw_name         = "avx-edge-gw-"
      site_id         = "site-A-use1-1"
      local_as_number = "65511"
      wan_ip_address  = "10.11.1.2/24"
      wan_gateway_ip  = "10.11.1.1"
      lan_ip_address  = "192.18.11.1/24"
    }
  }
}

variable "aws_dx_bgp_asn" {
  description = "BGP ASN of AWS VGW"
  default     = "65534"
}

variable "aws_dx_bgp_md5_key" {
  description = "BGP MD5 key for the DX connection"
}

variable "aws_cloud_account" {
  description = "The account name as known by the Aviatrix controller"
}


variable "aws_location" {
  description = "AWS region location"
  default     = "us-east-1"
}

variable "aws_transit_gateway_as_number" {
  description = "Transit Gateway BGP ASN for AWS"
  default     = "64551"
}

variable "aws_transit_vpc_cidr" {
  description = "VPC CIDR for AWS transit"
  default     = "10.4.0.0/22"
}

variable "aws_transit_vpc_name" {
  description = "VPC name for AWS transit"
  default     = "transit-vpc-awsuse-1"
}

variable "aws_transit_gateway_name" {
  description = "Gateway name for AWS transit"
  default     = "transit-aws-east1"
}

variable "aws_spoke_gateway_name" {
  description = "AWS spoke gateway name"
  default     = "spoke-aws-east1"
}

variable "aws_spoke_region_location" {
  description = "AWS spoke region location"
  default     = "us-east-1"
}

variable "aws_spoke_vpc_cidr" {
  description = "AWS spoke VPC CIDR"
  default     = "10.201.0.0/24"
}

variable "aws_spoke_gateway_as_number" {
  description = "AWS spoke BGP ASN"
  default     = "64552"
}



