## Create Internet facing OKE Cluster with already existing cloud network infrastructure
This example creates Internet facing OKE Cluster with public LoadBalancer, public API Endpoint and private NodePool + all dependent cloud network infrastructure injected into the module. The code deployes the use-case defined [here](https://docs.oracle.com/en-us/iaas/Content/ContEng/Concepts/contengnetworkconfigexample.htm#example-publick8sapi-privateworkers-publiclb).     

<img align="center" src="https://docs.oracle.com/en-us/iaas/Content/Resources/Images/conteng-network-eg2.png"> 

### Using this example
Update terraform.tfvars with the required information.

### Deploy the cluster  
Initialize Terraform:
```
$ terraform init
```
View what Terraform plans do before actually doing it:
```
$ terraform plan
```
Use Terraform to Provision resources:
```
$ terraform apply
```
