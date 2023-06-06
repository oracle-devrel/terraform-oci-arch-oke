# terraform-arch-oci-oke

These is Terraform module that deploys [Container Engine for Kubernetes (OKE)](https://docs.oracle.com/en-us/iaas/Content/ContEng/home.htm) on [Oracle Cloud Infrastructure (OCI)](https://cloud.oracle.com/en_US/cloud-infrastructure).

## About
Oracle Cloud Infrastructure Container Engine for Kubernetes is a fully-managed, scalable, and highly available service that you can use to deploy your containerized applications to the cloud. Use Container Engine for Kubernetes (sometimes abbreviated to just OKE) when your development team wants to reliably build, deploy, and manage cloud-native applications. 

## Prerequisites
1. Download and install Terraform (v1.0 or later)
2. Download and install the OCI Terraform Provider (v4.4.0 or later)
3. Export OCI credentials. (this refer to the https://github.com/oracle/terraform-provider-oci )


## What's a Module?
A Module is a canonical, reusable, best-practices definition for how to run a single piece of infrastructure, such as a database or server cluster. Each Module is created using Terraform, and includes automated tests, examples, and documentation. It is maintained both by the open source community and companies that provide commercial support.
Instead of figuring out the details of how to run a piece of infrastructure from scratch, you can reuse existing code that has been proven in production. And instead of maintaining all that infrastructure code yourself, you can leverage the work of the Module community to pick up infrastructure improvements through a version number bump.

## How to use this Module
Each Module has the following folder structure:
* [root](): This folder contains a root module.
* [examples](): This folder contains examples of how to use the module:
  - [Fully Private OKE (LB, APIEndpoint and NodePool in private subnets) + network deployed by module](examples/oke-fully-private-no-existing-network): This is an example of how to use the oci-oke module to deploy Container Engine for Kubernetes (OKE) with VCN-native support and all subnets are private and network cloud infrastrucutre elements will be deployed within the body of the module.
  - [Fully Private OKE (LB, APIEndpoint and NodePool in private subnets) + custom network injected into module](examples/oke-fully-private-use-existing-network): This is an example of how to use the oci-oke module to deploy Container Engine for Kubernetes (OKE) with VCN-native support and all subnets are private and network cloud infrastrucutre elements will be injected into the module.
  - [OKE with public LB, but APIEndpoint and NodePool in private subnets) + network deployed by module](examples/oke-public-lb-private-api-endpoint-and-worker-no-existing-network): This is an example of how to use the oci-oke module to deploy Container Engine for Kubernetes (OKE) with VCN-native support, public LB (Internet-facing) and API Endpoint + NodePool in private subnets where network cloud infrastrucutre elements will be deployed within the body of the module.
  - [OKE with public LB, but APIEndpoint and NodePool in private subnets) + custom network injected into module](examples/oke-public-lb-private-api-endpoint-and-worker-use-existing-network): This is an example of how to use the oci-oke module to deploy Container Engine for Kubernetes (OKE) with VCN-native support, public LB (Internet-facing) and API Endpoint + NodePool in private subnets where custom network cloud infrastrucutre elements will be injected into the module.
  - [OKE with public LB and public APIEndpoint, but NodePool in private subnets) + network deployed by module](examples/oke-public-lb-and-api-endpoint-private-workers-no-existing-network): This is an example of how to use the oci-oke module to deploy Container Engine for Kubernetes (OKE) with VCN-native support, public LB (Internet-facing), public API Endpoint (Internet facing), but NodePool in private subnet where network cloud infrastrucutre elements will be deployed within the body of the module.
  - [OKE with public LB and public APIEndpoint, but NodePool in private subnets) + custom network injected into module](examples/oke-public-lb-and-api-endpoint-private-workers-use-existing-network): This is an example of how to use the oci-oke module to deploy Container Engine for Kubernetes (OKE) with VCN-native support, public LB (Internet-facing), public API Endpoint (Internet-facing), but NodePool in private subnets where custom network cloud infrastrucutre elements will be injected into the module.
   - [Fully Public OKE (LB, APIEndpoint and NodePool in public subnets) + network deployed by module](examples/oke-fully-public-no-existing-network): This is an example of how to use the oci-oke module to deploy Container Engine for Kubernetes (OKE) with VCN-native support and all subnets are public and network cloud infrastrucutre elements will be deployed within the body of the module.
  - [Fully Public OKE (LB, APIEndpoint and NodePool in public subnets) + custom network injected into module](examples/oke-fully-public-use-existing-network): This is an example of how to use the oci-oke module to deploy Container Engine for Kubernetes (OKE) with VCN-native support and all subnets are public and network cloud infrastrucutre elements will be injected into the module.
  - [Private OKE with Native POD networking](examples/oke-native-pods-ips): This is an example of how to use the oci-oke module to deploy Container Engine for Kubernetes (OKE) with VCN-native support and Native POD networking.

To deploy OKE using this Module with minimal effort use this:

```hcl
module "oci-oke" {
  source                 = "github.com/oracle-devrel/terraform-oci-arch-oke"
  compartment_ocid       = ${var.compartment_ocid}
  vcn                    = ${var.vcn_id}
  api_endpoint_subnet_id = ${var.api_endpoint_subnet_id}
  lb_subnet_id           = ${var.lb_subnet_id}
  node_subnet_id         = ${var.node_subnet_id}
  ssh_public_key         = ${var.ssh_public_key}
}

```

Argument | Description
--- | ---
compartment_ocid | Compartment's OCID where OKE will be created
ssh_authorized_keys | Public SSH key to be included in the ~/.ssh/authorized_keys file for the default user on the instance
ssh_private_key | The private key to access instance
use_existing_vcn | If you want to inject already exisitng VCN then you need to set the value to TRUE.
use_existing_nsg | If you want to inject already exisitng NSG then you need to set the value to TRUE.
vcn_cidr | If use_existing_vcn is set to FALSE then you can define VCN CIDR block and then it will used to create VCN within the module.
vcn_id | If use_existing_vcn is set to TRUE then you can pass VCN OCID and module will use it to create OKE Cluster.
node_subnet_id | If use_existing_vcn is set to TRUE then you can pass NodePool Subnet OCID and module will use it to create OKE NodePool.
nodepool_subnet_cidr | If use_existing_vcn is set to FALSE then you can define NodePool CIDR block and then it will used to create NodePool within the module.
lb_subnet_id | If use_existing_vcn is set to TRUE then you can pass LoadBalancer Subnet OCID and module will use it to define service_lb_subnet_ids.
lb_subnet_cidr | If use_existing_vcn is set to FALSE then you can define LoadBalancer CIDR block and then it will used to create service_lb_subnet_ids within the module.
api_endpoint_subnet_id | If use_existing_vcn is set to TRUE then you can pass API EndPoint Subnet OCID and module will use it to define endpoint_config.
api_endpoint_subnet_cidr | If use_existing_vcn is set to FALSE then you can define API EndPoint CIDR block and then it will used to create endpoint_config within the module.
api_endpoint_nsg_ids | If use_existing_vcn is set to TRUE then you can pass API EndPoint Network Security Groups OCID and module will use it to define endpoint_config.
oci_vcn_ip_native | If you want to enable POD native networking (PODs associated with VCN/Subnet), then you need to turn the value to TRUE.
pod_subnet_id | If use_existing_vcn is set to TRUE and oci_vcn_ip_native is set to TRUE then you can pass POD Subnet OCID and module will associate it with each and every POD in OKE.
max_pods_per_node | If oci_vcn_ip_native is set to TRUE then you can define maximum value of PODs per OKE node.
oke_cluster_name | The name of the OKE Cluster.
vcn_native | if you want to use modern VCN-native mode for OKE then you need to set the value to TRUE.
is_api_endpoint_subnet_public | If vcn_native is set to TRUE then you can choose if API EndPoint will be in the public or private subnet.
is_lb_subnet_public | If vcn_native is set to TRUE then you can choose if LoadBalancer will be in the public or private subnet.
is_nodepool_subnet_public | If vcn_native is set to TRUE then you can choose if NodePool will be in the public or private subnet.
k8s_version | Version of K8S.
pool_name | Node Pool Name.
node_shape | Shape for the Node Pool members. 
node_ocpus | If node_shape is Flex then you can define OCPUS.
node_memory | If node_shape is Flex then you can define Memory.
node_linux_version | Node Oracle Linux Version.
node_count | Number of Nodes in the Pool.
pods_cidr | K8S PODs CIDR
services_cidr | K8S Services CIDR
cluster_options_add_ons_is_kubernetes_dashboard_enabled | If you want to set cluster_options_add_ons_is_kubernetes_dashboard_enabled to TRUE.
cluster_options_add_ons_is_tiller_enabled | If you want to use Tiller then you need to set the value to TRUE.
cluster_type | Default is **enhanced** may also be set to **basic**
node_pool_initial_node_labels_key | You can pass here node_pool_initial_node_labels_key.
node_pool_initial_node_labels_value | You can pass here node_pool_initial_node_labels_value.
node_eviction_node_pool_settings | If you want to setup Node Eviction Details configuration then set the value to TRUE (by default the value is equal to FALSE).
eviction_grace_duration | If node_eviction_node_pool_settings is set to TRUE then you can setup duration after which OKE will give up eviction of the pods on the node. PT0M will indicate you want to delete the node without cordon and drain. Default PT60M, Min PT0M, Max: PT60M. Format ISO 8601 e.g PT30M
is_force_delete_after_grace_duration | If node_eviction_node_pool_settings is set to TRUE then you can setup underlying compute instance to be deleted event if you cannot evict all the pods in grace period.
ssh_public_key | If you want to use your own SSH public key instead of generated onne by the module.

## Contributing
This project is open source.  Please submit your contributions by forking this repository and submitting a pull request!  Oracle appreciates any contributions that are made by the open source community.

## License
Copyright (c) 2021 Oracle and/or its affiliates.

Licensed under the Universal Permissive License (UPL), Version 1.0.

See [LICENSE](LICENSE) for more details.

ORACLE AND ITS AFFILIATES DO NOT PROVIDE ANY WARRANTY WHATSOEVER, EXPRESS OR IMPLIED, FOR ANY SOFTWARE, MATERIAL OR CONTENT OF ANY KIND CONTAINED OR PRODUCED WITHIN THIS REPOSITORY, AND IN PARTICULAR SPECIFICALLY DISCLAIM ANY AND ALL IMPLIED WARRANTIES OF TITLE, NON-INFRINGEMENT, MERCHANTABILITY, AND FITNESS FOR A PARTICULAR PURPOSE. FURTHERMORE, ORACLE AND ITS AFFILIATES DO NOT REPRESENT THAT ANY CUSTOMARY SECURITY REVIEW HAS BEEN PERFORMED WITH RESPECT TO ANY SOFTWARE, MATERIAL OR CONTENT CONTAINED OR PRODUCED WITHIN THIS REPOSITORY. IN ADDITION, AND WITHOUT LIMITING THE FOREGOING, THIRD PARTIES MAY HAVE POSTED SOFTWARE, MATERIAL OR CONTENT TO THIS REPOSITORY WITHOUT ANY REVIEW. USE AT YOUR OWN RISK.
