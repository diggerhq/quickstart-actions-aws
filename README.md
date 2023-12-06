# quickstart-actions-aws

This is the repository for a sample quickstart action with digger. 

# backend
this folder will provision (most) of the backend required. 
Main.tf provisions the following resources. 

1. The Backend state bucket for terraform to store state in
2. The required DynamoDB table for Digger to store locks. 

# prod
This is a sample terraform prod code that will (if given the chance) spin up a vpc + an EC2 instance, and required security groups. 
The instance is locked down to not be accessible from outside the network. 

# .github/workflows
Contains digger-plan.yml with two different potential ways of authenticating against an AWS account. Please review the main digger documentation on details as to which scheme to use. 