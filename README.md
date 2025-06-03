# GCP Infrastructure: Cloud SQL, Cloud Run, and HTTP Load Balancer with Terraform

This configuration project deploys a web service stack on Google Cloud Platform, the project contains of these belowed:

* Cloud SQL for PostgreSQL Database:
* Cloud Run Service:
* Global HTTP Load Balancer:

This file declares all configurable variables. Some important ones include:

variables.tf declares all configurable variables, includes
· gcp_project_id: (Required if no default) The GCP Project ID.
· gcp_region: The GCP region for deploying resources (default: asia-east1).
· cloud_run_image: (Important) The Docker container image to deploy to Cloud Run. Defaults to a sample "hello" image. 
· service_name: A prefix for naming resources .
· db_instance_name, service_name_db_name, db_user: Database configuration defaults.
· cloud_run_port: The port your container listens on (default: 8080).

Deployment Steps
1. Authenticate with GCP
   Easiest way is to use Application Default Credentials:
   ```gcloud auth application-default login```
2. Initialize Terraform:
   Navigate to the folder in command line and
   ```terraform init```
3. Review the Execution Plan
   Use this bash command to see what Terraform would create
   ```terraform plan```
4. Apply the Configuration:
   If the plan looks good
   ```terraform apply```
