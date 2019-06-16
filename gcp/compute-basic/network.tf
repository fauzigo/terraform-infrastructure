
resource "google_compute_network" "default" {
  name       = "${var.default-network-name}"
  #ipv4_range = "172.16.0.0/16"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "network-with-private-secondary-ip-ranges" {
  name          = "${var.subnetwork["name"]}"
  ip_cidr_range = "${var.subnetwork["cidr"]}"
  region        = "${var.region}"
  network       = "${google_compute_network.default.self_link}"
  secondary_ip_range {
    range_name    = "${var.secondary-ip-range["name"]}"
    ip_cidr_range = "${var.secondary-ip-range["cidr"]}"
  }
}

resource "google_compute_firewall" "world-icmp" {
  name    = "${var.icmp-allow-firewall-rule["name"]}"
  network = "${google_compute_network.default.name}"
  #network = "${google_compute_subnetwork.network-with-private-secondary-ip-ranges.self_link}"

  allow {
    protocol = "${var.icmp-allow-firewall-rule["protocol"]}"
  }

  #source_tags = ["brasil"]
  target_tags   = "${split(",",var.icmp-allow-firewall-rule["target-tags"])}"
  source_ranges = "${split(",",var.icmp-allow-firewall-rule["sources-ranges"])}"
}

resource "google_compute_firewall" "fauzi-openvpn" {
  name    = "${var.openvpn-allow-firewall-rule["name"]}"
  network = "${google_compute_network.default.name}"
  #network = "${google_compute_subnetwork.network-with-private-secondary-ip-ranges.self_link}"

  allow {
    protocol = "${var.openvpn-allow-firewall-rule["protocol"]}"
    ports    = "${split(",",var.openvpn-allow-firewall-rule["ports"])}" #["1194"]
  }

  target_tags   = "${split(",",var.openvpn-allow-firewall-rule["target-tags"])}"
  source_ranges = "${split(",",var.openvpn-allow-firewall-rule["sources-ranges"])}"
}

resource "google_compute_firewall" "world-ssh" {
  name    = "${var.ssh-allow-firewall-rule["name"]}"
  network = "${google_compute_network.default.name}"
  #network = "${google_compute_subnetwork.network-with-private-secondary-ip-ranges.self_link}"

  allow {
    protocol = "${var.ssh-allow-firewall-rule["protocol"]}"
    ports    = "${split(",",var.ssh-allow-firewall-rule["ports"])}" #["22"]
  }

  target_tags   = "${split(",",var.ssh-allow-firewall-rule["target-tags"])}" #["ssh-fauzi"]
  source_ranges = "${split(",",var.ssh-allow-firewall-rule["sources-ranges"])}" #["0.0.0.0/0"]
}
