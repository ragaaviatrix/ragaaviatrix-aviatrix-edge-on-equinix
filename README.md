# Overview

This code will create the following:
- Aviatrix edge gateway on Equinix
- L2 connection from Equinix to the CSP and auto accept the connection
-  Edge gateway as an underlay to terminate the CSP L2 connections
- Aviatrix transit and spoke gateways
- Edge to transit attachment
- A test VM deployed in the spoke VPC to test the connection to the edge LAN interface CIDR

# Pre-requisites
- The controller security group must allow 0/0 CIDR from anywhere as we do not know the public IP of the edge gateway beforehand. Once the gateway is UP and attached to the transit, update the public IP under **Cloud Fabric** > **Edge** > **Gateways** > **Edit Edge Gateway** > **Interface Configuration** > **MGMT** > Update the **Egress CIDR** with the Public IP obtained from terraform output. After this, you can delete the 0/0 CIDR from the security group
> Note: Use the x.x.x.x/32 notation for the IP  

- Equinix API
>See the [Developer Platform](https://developer.equinix.com/docs?page=/dev-docs/fabric/overview) page on how to generate Client ID and Client Secret.

# Diagram
<img src="https://github.com/ragaaviatrix/ragaaviatrix-aviatrix-edge-on-equinix/blob/main/img/topology-edge-on-equinix.png">


### Variables
The following variables are required:




# Caveats

Equinix API is a bit unstable and can timeout like below

> Error: error waiting for network device (f0212859-60bd-444d-916f-1e1ddf4fd13f) to be created: Equinix REST API error: Message: "Internal Server Error", HTTPCode: 500, ApplicationErrors: [Code: "IC-999-99", Property: "", Message: "Internal Error", AdditionalInfo: ""] 
│ 
│   with module.equinix_virtual_devices.equinix_network_device.gateway_1,
│   on equinix-build/main.tf line 16, in resource "equinix_network_device" "gateway_1":
│   16: resource "equinix_network_device" "gateway_1" {

If this happens, re-run the code
