resource "google_sql_database_instance" "cloud_sql_instance" {
  name             = var.instance_name
  database_version = "MYSQL_5_7"
  region           = var.region

  settings {
    tier = var.instance_type

    backup_configuration {
      enabled = true
    }

    network    = google_compute_network.vpc.name
    subnetwork = google_compute_subnetwork.subnet.name

    # ip_configuration {
    #   ipv4_enabled    = true
    #   private_network = google_compute_network.vpc.self_link

    #   # Configure the private IP address of the Cloud SQL instance to use
    #   # a specific IP address within the subnet range.
    #   # This assumes that the subnet range is 10.10.0.0/24 and the IP address
    #   # we want to use for the Cloud SQL instance is 10.10.0.2.
    #   private_network_ip = "10.10.0.2"
    # }
  }
}

resource "google_sql_database" "database" {
  name       = var.database_name
  instance   = google_sql_database_instance.cloud_sql_instance.name
  charset    = "utf8"
  collation  = "utf8_general_ci"
}

# resource "google_compute_network" "vpc" {
#   name                    = "${var.project_id}-vpc"
#   auto_create_subnetworks = false
# }

# resource "google_compute_subnetwork" "subnet" {
#   name          = "${var.project_id}-subnet"
#   region        = var.region
#   network       = google_compute_network.vpc.self_link
#   ip_cidr_range = "10.10.0.0/24"
# }
