# variables.tf

variable "gcp_project_id" {
  description = "The GCP project ID"
  type        = string
  default     = 216064817573
}

variable "gcp_region" {
  description = "The GCP region"
  type        = string
  default     = "asia-east1-a"
}

variable "gcp_zone" {
  description = "The GCP zone for resources if needed"
  type        = string
  default     = "us-central1-a"
}

variable "service_name" {
  type    = string
  default = "my-app"
}

variable "db_instance_name" {
  description = "Name for the Cloud SQL instance."
  type        = string
  default     = "main-db-instance"
}

variable "service_name_db_name" {
  description = "Name of the database within Cloud SQL."
  type        = string
  default     = "mydatabase"
}

variable "db_user" {
  description = "Username for the database."
  type        = string
  default     = "dbuser"
}

variable "db_password" {
  description = "Password for the database user."
  type        = string
  sensitive   = true
}

variable "cloud_run_image" {
  description = "The Docker image to deploy to Cloud Run."
  type        = string
  default     = "us-docker.pkg.dev/cloudrun/container/hello"
}

variable "cloud_run_port" {
  description = "The port your Cloud Run container listens on."
  type        = number
  default     = 8080
}

variable "load_balancer_name" {
  description = "Name for the HTTP/S Load Balancer components."
  type        = string
  default     = "tempo-http-lb"
}

# variable "domain_name" {
#   type        = string
#   default     = "" 
# }


