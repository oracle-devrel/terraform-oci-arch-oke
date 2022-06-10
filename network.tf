## Copyright (c) 2022 Oracle and/or its affiliates.
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

resource "oci_core_vcn" "oke_vcn" {
  count          = var.use_existing_vcn ? 0 : 1
  cidr_block     = var.vcn_cidr
  compartment_id = var.compartment_ocid
  display_name   = "oke_vcn"
  defined_tags   = var.defined_tags
}

resource "oci_core_service_gateway" "oke_sg" {
  count          = var.use_existing_vcn ? 0 : 1
  compartment_id = var.compartment_ocid
  display_name   = "oke_sg"
  vcn_id         = oci_core_vcn.oke_vcn[0].id
  services {
    service_id = lookup(data.oci_core_services.AllOCIServices[0].services[0], "id")
  }
  defined_tags = var.defined_tags
}

resource "oci_core_nat_gateway" "oke_natgw" {
  count          = var.use_existing_vcn ? 0 : 1
  compartment_id = var.compartment_ocid
  display_name   = "oke_natgw"
  vcn_id         = oci_core_vcn.oke_vcn[0].id
  defined_tags   = var.defined_tags
}

resource "oci_core_route_table" "oke_rt_via_natgw_and_sg" {
  count          = var.use_existing_vcn ? 0 : 1
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.oke_vcn[0].id
  display_name   = "oke_rt_via_natgw"
  defined_tags   = var.defined_tags

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_nat_gateway.oke_natgw[0].id
  }

  route_rules {
    destination       = lookup(data.oci_core_services.AllOCIServices[0].services[0], "cidr_block")
    destination_type  = "SERVICE_CIDR_BLOCK"
    network_entity_id = oci_core_service_gateway.oke_sg[0].id
  }
}

resource "oci_core_internet_gateway" "oke_igw" {
  count          = var.use_existing_vcn ? 0 : 1
  compartment_id = var.compartment_ocid
  display_name   = "oke_igw"
  vcn_id         = oci_core_vcn.oke_vcn[0].id
  defined_tags   = var.defined_tags
}

resource "oci_core_route_table" "oke_rt_via_igw" {
  count          = var.use_existing_vcn ? 0 : 1
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.oke_vcn[0].id
  display_name   = "oke_rt_via_igw"
  defined_tags   = var.defined_tags

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.oke_igw[0].id
  }
}

resource "oci_core_security_list" "oke_api_endpoint_subnet_sec_list" {
  count          = var.use_existing_vcn ? 0 : 1
  compartment_id = var.compartment_ocid
  display_name   = "oke_api_endpoint_subnet_sec_list"
  vcn_id         = oci_core_vcn.oke_vcn[0].id
  defined_tags   = var.defined_tags

  # egress_security_rules

  egress_security_rules {
    protocol         = "6"
    destination_type = "CIDR_BLOCK"
    destination      = var.nodepool_subnet_cidr
  }

  egress_security_rules {
    protocol         = 1
    destination_type = "CIDR_BLOCK"
    destination      = var.nodepool_subnet_cidr

    icmp_options {
      type = 3
      code = 4
    }
  }

  egress_security_rules {
    protocol         = "6"
    destination_type = "SERVICE_CIDR_BLOCK"
    destination      = lookup(data.oci_core_services.AllOCIServices[0].services[0], "cidr_block")

    tcp_options {
      min = 443
      max = 443
    }
  }

  ingress_security_rules {
    protocol = "6"
    source   = var.nodepool_subnet_cidr

    tcp_options {
      min = 6443
      max = 6443
    }
  }

  ingress_security_rules {
    protocol = "6"
    source   = var.nodepool_subnet_cidr

    tcp_options {
      min = 12250
      max = 12250
    }
  }

  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"

    tcp_options {
      min = 6443
      max = 6443
    }
  }

  ingress_security_rules {
    protocol = 1
    source   = var.nodepool_subnet_cidr

    icmp_options {
      type = 3
      code = 4
    }
  }

}

resource "oci_core_security_list" "oke_nodepool_subnet_sec_list" {
  count          = var.use_existing_vcn ? 0 : 1
  compartment_id = var.compartment_ocid
  display_name   = "oke_nodepool_subnet_sec_list"
  vcn_id         = oci_core_vcn.oke_vcn[0].id
  defined_tags   = var.defined_tags

  egress_security_rules {
    protocol         = "All"
    destination_type = "CIDR_BLOCK"
    destination      = var.nodepool_subnet_cidr
  }

  egress_security_rules {
    protocol    = 1
    destination = "0.0.0.0/0"

    icmp_options {
      type = 3
      code = 4
    }
  }

  egress_security_rules {
    protocol         = "6"
    destination_type = "SERVICE_CIDR_BLOCK"
    destination      = lookup(data.oci_core_services.AllOCIServices[0].services[0], "cidr_block")
  }

  egress_security_rules {
    protocol         = "6"
    destination_type = "CIDR_BLOCK"
    destination      = var.api_endpoint_subnet_cidr

    tcp_options {
      min = 6443
      max = 6443
    }
  }

  egress_security_rules {
    protocol         = "6"
    destination_type = "CIDR_BLOCK"
    destination      = var.api_endpoint_subnet_cidr

    tcp_options {
      min = 12250
      max = 12250
    }
  }

  egress_security_rules {
    protocol         = "6"
    destination_type = "CIDR_BLOCK"
    destination      = "0.0.0.0/0"
  }

  ingress_security_rules {
    protocol = "All"
    source   = var.nodepool_subnet_cidr
  }

  ingress_security_rules {
    protocol = "6"
    source   = var.api_endpoint_subnet_cidr
  }

  ingress_security_rules {
    protocol = 1
    source   = "0.0.0.0/0"

    icmp_options {
      type = 3
      code = 4
    }
  }

  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"

    tcp_options {
      min = 22
      max = 22
    }
  }

}

resource "oci_core_subnet" "oke_api_endpoint_subnet" {
  count                      = (var.use_existing_vcn && var.vcn_native) ? 0 : 1
  cidr_block                 = var.api_endpoint_subnet_cidr
  compartment_id             = var.compartment_ocid
  vcn_id                     = oci_core_vcn.oke_vcn[0].id
  display_name               = "oke_api_endpoint_subnet"
  security_list_ids          = [oci_core_vcn.oke_vcn[0].default_security_list_id, oci_core_security_list.oke_api_endpoint_subnet_sec_list[0].id]
  route_table_id             = var.is_api_endpoint_subnet_public ? oci_core_route_table.oke_rt_via_igw[0].id : oci_core_route_table.oke_rt_via_natgw_and_sg[0].id
  prohibit_public_ip_on_vnic = var.is_api_endpoint_subnet_public ? false : true
  defined_tags               = var.defined_tags
}

resource "oci_core_subnet" "oke_lb_subnet" {
  count          = (var.use_existing_vcn && var.vcn_native) ? 0 : 1
  cidr_block     = var.lb_subnet_cidr
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.oke_vcn[0].id
  display_name   = "oke_lb_subnet"

  security_list_ids          = [oci_core_vcn.oke_vcn[0].default_security_list_id]
  route_table_id             = var.is_lb_subnet_public ? oci_core_route_table.oke_rt_via_igw[0].id : oci_core_route_table.oke_rt_via_natgw_and_sg[0].id
  prohibit_public_ip_on_vnic = var.is_lb_subnet_public ? false : true
  defined_tags               = var.defined_tags
}

resource "oci_core_subnet" "oke_nodepool_subnet" {
  count          = (var.use_existing_vcn && var.vcn_native) ? 0 : 1
  cidr_block     = var.nodepool_subnet_cidr
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.oke_vcn[0].id
  display_name   = "oke_nodepool_subnet"

  security_list_ids          = [oci_core_vcn.oke_vcn[0].default_security_list_id, oci_core_security_list.oke_nodepool_subnet_sec_list[0].id]
  route_table_id             = var.is_nodepool_subnet_public ? oci_core_route_table.oke_rt_via_igw[0].id : oci_core_route_table.oke_rt_via_natgw_and_sg[0].id
  prohibit_public_ip_on_vnic = var.is_nodepool_subnet_public ? false : true
  defined_tags               = var.defined_tags
}



