// Configure the Google Cloud provider

// Can't use variables in this block :(
#terraform {
#  backend "gcs" {
#    bucket      = "tf-state-prod"
#    prefix      = "terraform/state"
#    credentials = "~/creds/creds.json"
#  }
#}

provider "google" {
  credentials = "${file(var.creds)}"
  project     = "${var.project}"
  region      = "${var.region}"
  version     = "~> 2.8"
}

provider "random" {
  version = "~> 2.1"
}

provider "template" {
  version = "~> 2.1"
}
