# terraform-vpc-eks
Code for deploying a VPC in AWS with 2 public and 2 private subnets deploying an EKS cluster in AWS, which will use the VPC created in the previous step. The cluster must have 2 nodes, using instance type t3a.large.
# Technology 
* Terraform
* AWS Accounts with
# Instructions
* Go to https://signin.aws.amazon.com/signin?redirect_uri=https%3A%2F%2Fportal.aws.amazon.com%2Fbilling%2Fsignup%2Fresume&client_id=signup&code_challenge_method=SHA-256&code_challenge=K4DnxJ-Q6Pyzd-oHFLicUUX6XHXhyelnXGCfXBfpJPc to sign up for aws account
* Go to https://learn.hashicorp.com/tutorials/terraform/install-cli for details on how to Install terraform 
* Clone the repository with " git clone https://github.com/OladimejiDMJ/terraform-vpc-eks.git"
* Open the variable.tf file and fill your AWS secret and access key respectively
* Change into the working directory and run the following command
1. terraform init
2. terraform plan
3. terraform apply
