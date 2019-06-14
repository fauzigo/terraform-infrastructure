// Configure the Google Cloud provider

/*
terraform {
  backend "gcs" {
    bucket  = "${var.tstate_bucket"
    prefix  = "${var.tstate_prefix"
    credentials = "${var.credentials}"
    #"../../la-cartelua-1be1ccf0b1b5.json"
  }
}
*/

provider "google" {
 #credentials = "${file("../../la-cartelua-1be1ccf0b1b5.json")}"
 credentials = "${file(var.credentials)}"
 #"../../la-cartelua-1be1ccf0b1b5.json"
 project     = "${var.project}"
 region      = "${var.region}"
}

