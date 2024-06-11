data "equinix_fabric_service_profiles" "aws" {
  filter {
    property = "/name"
    operator = "="
    values   = ["AWS Direct Connect"]
  }
}

data "aws_dx_connection" "dx_1" {
  name       = "${var.gw_1_name}-dx-cnx"
  depends_on = [equinix_fabric_connection.aws_dx_1]
}

data "aws_caller_identity" "current" {}