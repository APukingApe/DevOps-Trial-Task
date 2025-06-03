# GCP Infrastructure: Cloud SQL, Cloud Run, and HTTP Load Balancer with Terraform

This configuration project deploys a web service stack on Google Cloud Platform, the project contains of these belowed:

* Cloud SQL for PostgreSQL Database:
* Cloud Run Service:
* Global HTTP Load Balancer:

### `variables.tf` declares all configurable variables, includes
* `gcp_project_id`: (Required if no default) The GCP Project ID.
* `gcp_region`: The GCP region for deploying resources (default: asia-east1).
* `cloud_run_image`: (Important) The Docker container image to deploy to Cloud Run. Defaults to a sample "hello" image. 
* `service_name`: A prefix for naming resources .
* `db_instance_name`, `service_name_db_name`, `db_user`·: Database configuration defaults.
* `cloud_run_port`: The port your container listens on (default: 8080).

### `main.tf` is the core of proejct, define all the cloud resource used in GCP, includes
1. Cloud SQL, define the size version and settings
2. Cloud Run, define Cloud Run includes Docker, ports, IAM stratgy. 
3. HTTP Load Balancer, create a global IP address a servless endpoint group, define backend service, create URL mapping and create HTTP proxy

### `outputs.tf` use to show the value configed by Terraform
     `cloud_sql_instance_name`: Instance name of cloud SQL。
     `cloud_sql_instance_connection_name`: Cloud SQL instance connection name used to Cloud SQL Proxy.
     `cloud_sql_database_name`: Name of database
     `cloud_sql_user_name`: Username of database
     `cloud_sql_generated_password`: Password generated for database user
     `cloud_run_service_url`: URL of Cloud Run service
     `load_balancer_ip_address`: Public IP address of Load Balancer
    
## **Deployment Steps**
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
