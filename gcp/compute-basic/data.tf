data "google_compute_zones" "available" {}

data "template_file" "metadata_startup_script" {
  template = "${file("${path.module}/files/bootstrap.sh")}"
  vars = {
    user = "${var.compute-resource["ssh-user"]}"
  }
}

