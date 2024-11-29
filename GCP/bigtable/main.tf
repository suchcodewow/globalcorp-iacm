variable "googleProject" {
    type = string
    default="sales-209522"
}

resource "google_bigtable_instance" "instance" {
  name          = "catalogdb"
  project       = var.googleProject

  cluster {
    cluster_id   = "catalogdb"
    zone         = "us-central1-b"
    num_nodes    = 3
    storage_type = "HDD"
  }

  lifecycle {
    prevent_destroy = false
  }
}

resource "google_bigtable_table" "table" {
  name          = "catalogtable"
  instance_name = google_bigtable_instance.instance.name
  split_keys    = ["a", "b", "c"]
  project       = var.googleProject
  

  lifecycle {
    prevent_destroy = false
  }

  column_family {
    family = "family-first"
  }

  column_family {
    family = "family-second"
    type   = "intsum"
  }

  column_family {
    family = "family-third"
    type   = <<EOF
        {
                    "aggregateType": {
                        "max": {},
                        "inputType": {
                            "int64Type": {
                                "encoding": {
                                    "bigEndianBytes": {}
                                }
                            }
                        }
                    }
                }
        EOF
  }

  change_stream_retention = "24h0m0s"


}