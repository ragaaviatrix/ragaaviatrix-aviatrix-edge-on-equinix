variable "aws_region_1_location" {
  description = "AWS region 1 location"
  default     = "us-east-1"
}

variable "aws_transit_region_1_gateway_as_number" {
  description = "AWS Region 1 Transit Gateway BGP ASN"
}

variable "aws_transit_region_1_vpc_cidr" {
  description = "VPC cidr for AWS region 1"
  default     = "10.4.0.0/22"
}

variable "aws_transit_region_1_vpc_name" {
  description = "VPC name for AWS region 1"
  default     = "transit-vpc-awsuse1"
}

variable "aws_transit_region_1_gateway_name" {
  description = "Gateway name for AWS region 1"
  default     = "transit-aws-east1"
}

variable "aws_cloud_account" {
  description = "The account name as known by the Aviatrix controller"
}

variable "cloud_type_aws" {
  description = "Cloud to deploy resource"
  default     = "aws"
}

variable "aws_region_1_spoke_1_gateway_name" {
  description = "AWS spoke 1 region 1 gateway name"
}

variable "aws_region_1_spoke_1_region_location" {
  description = "AWS spoke 1 region 1 location"
}

variable "aws_region_1_spoke_1_vpc_cidr" {

}

variable "aws_spoke_region_1_gateway_as_number" {

}

variable "vgw_bgp_asn" {

}