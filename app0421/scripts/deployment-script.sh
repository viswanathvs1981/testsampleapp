#!/bin/bash

# Initialize Terraform
terraform init

# Format Terraform configuration files
terraform fmt

# Validate the Terraform configuration
terraform validate

# Create an execution plan
terraform plan -out=tfplan

# Apply the changes
terraform apply tfplan

# Output deployment information
echo "API Gateway URL: $(terraform output api_gateway_url)"

# Clean up the generated plan file
rm tfplan