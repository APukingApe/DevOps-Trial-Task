# outputs.tf

output "cloud_sql_instance_name" {
  description = "The name of the created Cloud SQL instance."
  value = google_sql_database_instance.default.name
}

output "cloud_sql_instance_connection_name" {
  description = "The connection name of the Cloud SQL instance"
  value = google_sql_database_instance.default.connection_name
}

output "cloud_sql_database_name" {
  description = "The name of the database created."
  value = google_sql_database.default_db.name
}

output "cloud_sql_user_name" {
  description = "The username for the Cloud SQL database."
  value = google_sql_user.default_user.name
}

output "cloud_sql_generated_password" {
  description = "The auto-generated password for the Cloud SQL user."
  value = random_password.db_password.result
  sensitive = true
}

output "cloud_run_service_url" {
  description = "The URL of the deployed Cloud Run service."
  value = google_cloud_run_v2_service.default.uri
}

output "load_balancer_ip_address" {
description = "The IP address of the Load Balancer."
  value = google_compute_global_address.lb_ip.address
}
