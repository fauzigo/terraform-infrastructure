
//["us-west-1a", "us-west-1c", "us-west-1d", "us-west-1e"]
resource "random_shuffle" "az" {
  input = "${data.google_compute_zones.available.names}" 
  result_count = 1
}

// Terraform plugin for creating random ids
resource "random_id" "instance_id" {
  byte_length = 8
}

