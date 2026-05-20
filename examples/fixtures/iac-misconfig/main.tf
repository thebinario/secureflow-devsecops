terraform {
  required_version = ">= 1.5.0"
}

# Intentionally insecure fixture for scanner validation only.
resource "google_compute_firewall" "allow_all_ingress" {
  name    = "secureflow-allow-all-ingress"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_storage_bucket" "public_fixture_bucket" {
  name                        = "secureflow-public-fixture-bucket"
  location                    = "US"
  uniform_bucket_level_access = false
  public_access_prevention    = "inherited"
}
