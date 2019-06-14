
//["us-west-1a", "us-west-1c", "us-west-1d", "us-west-1e"]
resource "random_shuffle" "az" {
  input = "${data.google_compute_zones.available.names}" 
  result_count = 1
}

// Terraform plugin for creating random ids
resource "random_id" "instance_id" {
 byte_length = 8
}

// A single Google Cloud Engine instance

resource "google_compute_instance" "default" {
 name         = "proxy-${random_id.instance_id.hex}"
 machine_type = "g1-small"
 zone         = "${random_shuffle.az.result[0]}"

 tags = ["brasil", "proxy", "ssh-fauzi"]

 boot_disk {
   initialize_params {
     image = "debian-cloud/debian-9"
   }
 }

// Make sure flask is installed on all new instances for later steps
 metadata_startup_script = "sudo apt-get update; sudo apt-get install -yq build-essential python-pip rsync jq python-pip; pip install yq"

 metadata = {
   ssh-keys = "fauzi:${file("~/.ssh/id_rsa.pub")}"
 }

 network_interface {
   #network = "default"
   #network = "${google_compute_network.default.name}"
   subnetwork = "${google_compute_subnetwork.network-with-private-secondary-ip-ranges.self_link}"

   access_config {
     // Include this section to give the VM an external ip address
   }
 }
}

