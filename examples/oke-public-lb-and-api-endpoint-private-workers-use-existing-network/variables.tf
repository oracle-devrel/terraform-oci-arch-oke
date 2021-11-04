## Copyright (c) 2021 Oracle and/or its affiliates.
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "private_key_path" {}
variable "compartment_ocid" {}
variable "region" {}
variable "fingerprint" {}

variable "vcn_cidr" {
  default = "192.168.0.0/16"
}

variable "nodepool_subnet_cidr" {
  default = "192.168.1.0/24"
}

variable "lb_subnet_cidr" {
  default = "192.168.2.0/24"
}

variable "api_endpoint_subnet_cidr" {
  default = "192.168.3.0/24"
}

variable "oke_cluster_name" {
  default = "My_OKE_Cluster"
}

variable "k8s_version" {
  default = "v1.20.11"
}

variable "pool_name" {
  default = "My_Node_Pool"
}

variable "node_shape" {
  default = "VM.Standard.E3.Flex"
}

variable "node_ocpus" {
  default = 1
}

variable "node_memory" {
  default = 4
}

variable "node_count" {
  default = 3
}

