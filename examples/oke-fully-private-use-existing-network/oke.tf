## Copyright (c) 2022 Oracle and/or its affiliates.
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

module "oci-oke" {
  source                        = "github.com/oracle-devrel/terraform-oci-arch-oke"
  tenancy_ocid                  = var.tenancy_ocid
  compartment_ocid              = var.compartment_ocid
  oke_cluster_name              = var.oke_cluster_name
  k8s_version                   = var.k8s_version
  pool_name                     = var.pool_name
  node_shape                    = var.node_shape
  node_ocpus                    = var.node_ocpus
  node_memory                   = var.node_memory
  node_count                    = var.node_count
  use_existing_vcn              = true
  vcn_id                        = oci_core_vcn.my_vcn.id
  is_api_endpoint_subnet_public = false
  api_endpoint_subnet_id        = oci_core_subnet.my_api_endpoint_subnet.id
  is_lb_subnet_public           = false
  lb_subnet_id                  = oci_core_subnet.my_lb_subnet.id
  is_nodepool_subnet_public     = false
  nodepool_subnet_id            = oci_core_subnet.my_nodepool_subnet.id
}

