// Configure the Google Cloud provider

/* Can't use variables in this area, so if you wanted backended states fill this up properly
terraform {
  backend "gcs" {
    bucket  = "${var.tstate_bucket"
    prefix  = "${var.tstate_prefix"
    credentials = "${var.credentials}"
  }
}
*/

provider "google" {
  credentials = "${file(var.credentials)}"
  project     = "${var.project}"
  region      = "${var.region}"
  version = "~> 2.8"
}

