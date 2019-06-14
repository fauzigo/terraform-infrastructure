
output "da_ip" {
  value = "${google_compute_instance.default.network_interface.0.access_config.0.nat_ip}"
}


output "stuff" {
  value = "${random_shuffle.az.result[0]}"
}

output "new_net" {
  value = "${google_compute_network.default.self_link}"
}
