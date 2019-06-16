
// A single Google Cloud Engine instance

resource "google_compute_instance" "default" {
  name         = "${var.compute-resource["name"]}-${random_id.instance_id.hex}"
  machine_type = "${var.compute-resource["machine-type"]}"
  zone         = "${random_shuffle.az.result[0]}"

  tags = "${split(",",var.compute-resource["tags"])}"
        #["brasil", "proxy", "ssh-fauzi"]

  boot_disk {
    initialize_params {
      image = "${var.compute-resource["image"]}"
    }
  }

  // Make sure flask is installed on all new instances for later steps
  metadata_startup_script = "${data.template_file.metadata_startup_script.rendered}"
                            #"sudo apt-get update; sudo apt-get install -yq build-essential python-pip rsync jq python-pip; pip install yq"

  metadata = {
    ssh-keys = "${var.compute-resource["ssh-user"]}:${file(var.compute-resource["ssh-key-path"])}"
    #startup-script = "${data.template_file.metadata_startup_script.rendered}"
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

