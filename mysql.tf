resource "google_sql_database_instance" "cloud_sql_instance" {
  name             = var.instance_name
  database_version = "MYSQL_5_7"
  region           = var.region

  settings {
    tier = var.instance_type
    ip_configuration {
      # voir pour la val 
      ipv4_enabled    = true
      private_network = google_compute_network.vpc.id
      
    # authorized_networks {
    #   name  = google_compute_subnetwork.subnet.name
    #   value = google_compute_subnetwork.subnet.ip_cidr_range
    # }
      
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
