
## Overview

This code will create the following infrastructure components:

-   **Region**: Equinix - NY | AWS - us-east-1
-   **Aviatrix Edge Gateway**: Deployed on Equinix.
-   **Layer 2 (L2) Connection**: Establishes a connection from Equinix to the CSP (Cloud Service Provider) and auto-accepts the connection.
-   **Edge Gateway Underlay**: Terminates the CSP L2 connections.
-   **Aviatrix Transit and Spoke Gateways**: Deployed in the corresponding CSP.
-   **Edge to Transit Attachment**: Connects the edge to the transit.
-   **Test VM**: Deployed in the spoke VPC to test the connection to the edge LAN interface CIDR.

> **Note**: The initial release is only for AWS. Azure support will be added in the future.

## Pre-requisites

-   The **controller security group** must allow `0.0.0.0/0` CIDR for TCP port 443 from anywhere, as the public IP of the edge gateway is unknown beforehand. After the gateway is UP and attached to the transit, follow these steps to update the security settings:
    
    1.  Navigate to **Cloud Fabric** > **Edge** > **Gateways** > **Edit Edge Gateway** > **Interface Configuration** > **MGMT**.
    2.  Update the **Egress CIDR** with the Public IP obtained from the Terraform output.
-   Once the public IP is updated, remove the `0.0.0.0/0` CIDR from the security group.
    

> **Note**: Use the `x.x.x.x/32` notation for specifying the IP address.

- Equinix API
>See the [Developer Platform](https://developer.equinix.com/docs?page=/dev-docs/fabric/overview) page on how to generate Client ID and Client Secret.

# Diagram
<img src="https://github.com/ragaaviatrix/ragaaviatrix-aviatrix-edge-on-equinix/blob/main/img/topology-edge-on-equinix.png">


### Variables
The following variables are required:

key | value
:--- | :---
controller_ip | Aviatrix controller IP
copilot_ip | Aviatrix copilot IP
controller_password | Controller password
equinix_client_id | Obtained from the Equinix developer portal
equinix_client_secret | Obtained from the Equinix developer portal
email_for_notifications | eg: ["hello@avx.com"]
equinix_account_name | Equinix account name onboarded on the controller
equinix_account_number | Equinix account number
aws_dx_bgp_md5_key | BGP auth string
aws_cloud_account | AWS account name onboarded on the controller

### Outputs
This module will return the following outputs:

key | description
:---|:---
avx_edge_1_pub_ip | Public IP of the Edge gateway
test_vm_pub_ip | Public IP of the test VM

# Testing the connectivity
- Obtain the VM public IP from terraform output and use the pem key (ubuntu-keypair.pem ) created in the same directory.
- SSH to the test VM
- Ping 192.168.11.1 which is the LAN IP of the edge

>ssh ubuntu@44.201.167.124 -i ubuntu-keypair.pem 


>ubuntu@ip-10-201-0-39:~$ ping 192.18.11.1

# Caveats

Equinix API is a bit unstable and can timeout like below

> Error: error waiting for network device (f0212859-60bd-444d-916f-1e1ddf4fd13f) to be created: Equinix REST API error: Message: "Internal Server Error", HTTPCode: 500, ApplicationErrors: [Code: "IC-999-99", Property: "", Message: "Internal Error", AdditionalInfo: ""] 
│ 
│   with module.equinix_virtual_devices.equinix_network_device.gateway_1,
│   on equinix-build/main.tf line 16, in resource "equinix_network_device" "gateway_1":
│   16: resource "equinix_network_device" "gateway_1" {

If this happens, run "terraform apply" again









