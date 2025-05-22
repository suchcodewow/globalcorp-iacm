resource "google_compute_instance" "default" {
  name         = var.vm_name
  machine_type = "n1-standard-1"
  zone         = "us-central1-a"
  project      = "ecardinalhealth-459415"
  tags         = [var.vm_owner]


  boot_disk {
    initialize_params {
      image = var.vm_type
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }
}

