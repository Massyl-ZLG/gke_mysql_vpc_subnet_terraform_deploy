resource "google_sql_database_instance" "cloud_sql_instance" {
  name             = var.instance_name
  database_version = "MYSQL_5_7"
  region           = var.region

  settings {
    tier = var.instance_type
    authorized_networks {
      name = "default"
    }
    ip_configuration {
      ipv4_enabled                                  = false
      private_network                               = google_compute_network.vpc.id
      #enable_private_path_for_google_cloud_services = true
    }
    backup_configuration {
      enabled = true
    }

  }
}

resource "google_sql_database" "database" {
  name       = var.database_name
  instance   = google_sql_database_instance.cloud_sql_instance.name
  charset    = "utf8"
  collation  = "utf8_general_ci"
}


