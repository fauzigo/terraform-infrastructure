// Configure the Google Cloud provider

terraform {
  backend "gcs" {
    bucket  = "tf-state-prod-fauzi"
    prefix  = "terraform/state"
    credentials = "../../la-cartelua-1be1ccf0b1b5.json"
  }
}
provider "google" {
 credentials = "${file("../../la-cartelua-1be1ccf0b1b5.json")}"
 project     = "la-cartelua"
 region      = "${var.region}"
}

