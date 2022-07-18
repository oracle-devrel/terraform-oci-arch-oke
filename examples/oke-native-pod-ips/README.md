## Create fully private OKE Cluster with native POD networking
This example creates OKE Cluster with all dependent cloud network infrastructure injected into module and natve POD networking. 

<img align="center" src="https://docs.oracle.com/en-us/iaas/Content/Resources/Images/conteng-network-eg4.png"> 

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
