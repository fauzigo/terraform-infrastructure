
resource "google_compute_network" "default" {
  name       = "fauzis-network"
  #ipv4_range = "172.16.0.0/16"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "network-with-private-secondary-ip-ranges" {
  name          = "samba"
  ip_cidr_range = "172.16.0.0/19"
  region        = "${var.region}"
  network       = "${google_compute_network.default.self_link}"
  secondary_ip_range {
    range_name    = "tf-test-secondary-range-update1"
    ip_cidr_range = "192.168.10.0/24"
  }
}

resource "google_compute_firewall" "default" {
  name    = "icmp-allow-fauzi"
  network = "${google_compute_network.default.name}"
  #network = "${google_compute_subnetwork.network-with-private-secondary-ip-ranges.self_link}"

  allow {
    protocol = "icmp"
  }

  #source_tags = ["brasil"]
  target_tags = ["brasil"]
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "fauzi-openvpn" {
  name    = "fauzi-openvpn-house-access"
  network = "${google_compute_network.default.name}"
  #network = "${google_compute_subnetwork.network-with-private-secondary-ip-ranges.self_link}"

  allow {
    protocol = "udp"
    ports    = ["1194"]
  }

  target_tags = ["brasil", "proxy", "ssh-fauzi"]
  source_ranges = ["73.36.170.248/32"]
}

resource "google_compute_firewall" "fauzi-ssh" {
  name    = "fauzi-ssh-access"
  network = "${google_compute_network.default.name}"
  #network = "${google_compute_subnetwork.network-with-private-secondary-ip-ranges.self_link}"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  target_tags = ["ssh-fauzi"]
  source_ranges = ["0.0.0.0/0"]
}
