## Create fully private OKE Cluster without already existing cloud network infrastructure
This example creates OKE Cluster with all dependent cloud network infrastructure inside the module. The code deployes the use-case defined [here](https://docs.oracle.com/en-us/iaas/Content/ContEng/Concepts/contengnetworkconfigexample.htm#example-privatek8sapi-privateworkers-privatelb).  

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
