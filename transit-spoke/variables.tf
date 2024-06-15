variable "aws_location" {
  description = "AWS region location"
}

variable "aws_transit_gateway_as_number" {
  description = "Transit Gateway BGP ASN for AWS"
}

variable "aws_transit_vpc_cidr" {
  description = "VPC CIDR for AWS transit"
}

variable "aws_transit_vpc_name" {
  description = "VPC name for AWS transit"
}

variable "aws_transit_gateway_name" {
  description = "Gateway name for AWS transit"
}

variable "aws_spoke_gateway_name" {
  description = "AWS spoke gateway name"
}

variable "aws_spoke_region_location" {
  description = "AWS spoke region location"
}

variable "aws_spoke_vpc_cidr" {
  description = "AWS spoke VPC CIDR"
}

variable "aws_spoke_gateway_as_number" {
  description = "AWS spoke BGP ASN"
}

variable "aws_cloud_account" {
  description = "The account name as known by the Aviatrix controller"
}

variable "cloud_type_aws" {
  description = "Cloud to deploy resource"
  default     = "aws"
}

variable "vgw_bgp_asn" {

}