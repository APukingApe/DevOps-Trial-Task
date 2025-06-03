
provider "google" {
  project = var.gcp_project_id
  region  = var.gcp_region
}

// --- Cloud SQL - PostgreSQL ---
resource "google_sql_database_instance" "default" {
  name             = "${var.service_name}-db-instance"
  region           = var.gcp_region
  database_version = "POSTGRES_15"
  settings {
    tier              = "db-f1-micro"
    availability_type = "REGIONAL"
    disk_size         = 10
    ip_configuration {
      ipv4_enabled = true // 
      // authorized_networks { // 
      //   name  = "allow-all-for-now"
      //   value = "0.0.0.0/0" // 
      // }
    }
  }
  deletion_protection = false // 
}

resource "google_sql_database" "default_db" {
  name     = var.service_name_db_name
  instance = google_sql_database_instance.default.name
}

resource "random_password" "db_password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "google_sql_user" "default_user" {
  name     = var.db_user
  instance = google_sql_database_instance.default.name
  password = random_password.db_password.result
}

// --- Cloud Run ---
resource "google_cloud_run_v2_service" "default" {
  name     = "${var.service_name}-run"
  location = var.gcp_region

  template {
    scaling {
      min_instance_count = 0
      max_instance_count = 2
    }
    containers {
      image = var.cloud_run_image
      ports {
        container_port = 8080 // 
      }
    }
  }
}

resource "google_cloud_run_v2_service_iam_member" "allow_public_invocations" {
  project    = google_cloud_run_v2_service.default.project
  location   = google_cloud_run_v2_service.default.location
  name       = google_cloud_run_v2_service.default.name
  role       = "roles/run.invoker"
  member     = "allUsers"
  depends_on = [google_cloud_run_v2_service.default]
}


// ---  HTTP Load Balancer ---

// IP Address
resource "google_compute_global_address" "lb_ip" {
  name = "${var.service_name}-lb-ip"
}

// Serverless 
resource "google_compute_region_network_endpoint_group" "serverless_neg" {
  name                  = "${var.service_name}-sneg"
  network_endpoint_type = "SERVERLESS"
  region                = var.gcp_region
  cloud_run {
    service = google_cloud_run_v2_service.default.name
  }
  depends_on = [google_cloud_run_v2_service_iam_member.allow_public_invocations] // Make sure CloudRun usable
}

// Backend
resource "google_compute_backend_service" "default_backend" {
  name                  = "${var.service_name}-backend"
  protocol              = "HTTP"
  port_name             = "http" // 
  load_balancing_scheme = "EXTERNAL_MANAGED"
  timeout_sec           = 30

  backend {
    group = google_compute_region_network_endpoint_group.serverless_neg.id
  }

  // CDN is usable here
  // enable_cdn = true
}

// URL Reflection
resource "google_compute_url_map" "default_url_map" {
  name            = "${var.service_name}-url-map"
  default_service = google_compute_backend_service.default_backend.id
}

//  Target HTTP proxy
resource "google_compute_target_http_proxy" "default_http_proxy" {
  name    = "${var.service_name}-http-proxy"
  url_map = google_compute_url_map.default_url_map.id
}

// Forwarding role
resource "google_compute_global_forwarding_rule" "default_forwarding_rule" {
  name                  = "${var.service_name}-forwarding-rule"
  ip_protocol           = "TCP"
  ip_address            = google_compute_global_address.lb_ip.address
  target                = google_compute_target_http_proxy.default_http_proxy.id
  port_range            = "80" // HTTP Port
  load_balancing_scheme = "EXTERNAL_MANAGED"
}