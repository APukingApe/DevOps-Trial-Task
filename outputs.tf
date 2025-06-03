output "cloud_sql_instance_name" {
  value = google_sql_database_instance.default.name
}

output "cloud_sql_instance_connection_name" {
  value = google_sql_database_instance.default.connection_name
}

output "cloud_sql_database_name" {
  value = google_sql_database.default_db.name
}

output "cloud_sql_user_name" {
  value = google_sql_user.default_user.name
}

output "cloud_sql_generated_password" {
  value     = random_password.db_password.result
  sensitive = true
}

output "cloud_run_service_url" {
  value = google_cloud_run_v2_service.default.uri
}

output "load_balancer_ip_address" {
  value = google_compute_global_address.lb_ip.address
}