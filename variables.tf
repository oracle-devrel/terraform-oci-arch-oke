## Copyright (c) 2022 Oracle and/or its affiliates.
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

variable "compartment_ocid" {
  default = ""
}

variable "tenancy_ocid" {
  default = ""
}

variable "availability_domain" {
  default = ""
}

variable "use_existing_vcn" {
  default = true
}

variable "use_existing_nsg" {
  default = true
}

variable "vcn_cidr" {
  default = "10.0.0.0/16"
}

variable "vcn_id" {
  default = ""
}

variable "nodepool_subnet_id" {
  default = ""
}

variable "nodepool_subnet_cidr" {
  default = "10.0.1.0/24"
}

variable "lb_subnet_id" {
  default = ""
}

variable "lb_subnet_cidr" {
  default = "10.0.2.0/24"
}

variable "api_endpoint_subnet_id" {
  default = ""
}

variable "api_endpoint_subnet_cidr" {
  default = "10.0.3.0/24"
}

variable "api_endpoint_nsg_ids" {
  default = []
}

variable "pods_subnet_id" {
  default = ""
}

variable "pods_nsg_ids" {
  default = []
}

variable "oke_cluster_name" {
  default = "OKE_Cluster"
}

variable "vcn_native" {
  default = true
}

variable "is_api_endpoint_subnet_public" {
  default = false
}

variable "is_lb_subnet_public" {
  default = false
}

variable "is_nodepool_subnet_public" {
  default = false
}

variable "k8s_version" {
  default = "v1.23.4"
}

variable "pool_name" {
  default = "Demo_Node_Pool"
}

variable "node_shape" {
  default = "VM.Standard.E4.Flex"
}

variable "node_image_id" {
  default = ""
}

variable "node_pool_boot_volume_size_in_gbs" {
  default = 50
}

variable "node_ocpus" {
  default = 1
}

variable "node_memory" {
  default = 4
}

variable "oci_vcn_ip_native" {
  default = false
}

variable "max_pods_per_node" {
  default = 10
}

variable "pods_cidr" {
  default = "10.1.0.0/16"
}

variable "services_cidr" {
  default = "10.2.0.0/16"
}

variable "pods_subnet_cidr" {
  default = "10.0.4.0/24"
}

variable "node_linux_version" {
  default = "7.9"
}

variable "node_count" {
  default = 3
}

variable "cluster_options_add_ons_is_kubernetes_dashboard_enabled" {
  default = true
}

variable "cluster_options_add_ons_is_tiller_enabled" {
  default = true
}

variable "cluster_options_admission_controller_options_is_pod_security_policy_enabled" {
  default = false
}

variable "node_pool_initial_node_labels_key" {
  default = "key"
}

variable "node_pool_initial_node_labels_value" {
  default = "value"
}

variable "cluster_kube_config_token_version" {
  default = "2.0.0"
}

variable "ssh_public_key" {
  default = ""
}

variable "defined_tags" {
  default = {}
}

locals {
  availability_domains = var.availability_domain == "" ? data.oci_identity_availability_domains.ADs.availability_domains : data.oci_identity_availability_domains.AD.availability_domains
}
