# readme.md

## Introduction 

The repository contains a Terraform application for setting up an AWS infrastructure with a REST API endpoint, which is hosted on an AWS Lambda function. The Lambda function manages a Node.js application that handles customer data input. The AWS S3 bucket is used for persisting this data. AWS Athena is configured to query this customer data. A deployment script is provided to setup and deploy the application.

## Project Structure

### /terraform

The Terraform configuration files are located in this directory. The Terraform setup includes an AWS API Gateway, Lambda function, Athena table, and S3 Bucket. 

### /lambda-api-endpoint

This directory contains the Node.js application that runs on the Lambda function. It has a REST endpoint for customer data.

### /scripts

The deployment script resides in here. This script initializes and applies the Terraform configuration, introducing the changes on AWS.

### /test

The test directory contains a test file for the API endpoint.

### /sample-queries

This directory contains SQL queries as examples to query the customer data stored in the Athena table.

## Customer JSON Schema

The application expects customer data in the following JSON format:

{
  "customerName": "John Doe",
  "email": "john.doe@example.com",
  "phone": "123-456-7890",
  "address": "123 Main St",
  "city": "Anytown",
  "state": "AA",
  "zipCode": "12345"
}

This is the schema adhered to whilst storing data in the S3 bucket, also the Athena table's schema is based on this structure.

## Deployment

Execute the script `deployment-script.sh` within the `/scripts` directory to deploy the infrastructure to AWS. After successful execution, an API Gateway URL will be returned which can be used to interact with the customer API endpoint using a tool like Postman or curl.

## Queries

Refer to `sample-query.sql` within the `/sample-queries` directory to understand how to query the customer data through Athena.