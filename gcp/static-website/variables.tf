
variable "project" {
  description = "project in which to deploy your resources"
  default     = ""
}

variable "region" {
  description = "Region for your resources, if applicable"
  default     = "us-central-1"
}

variable "credentials" {
  description = "json file with credentials for a service account"
  default     = "../../creds.json"
}

variable "site_hostname" {
  description = "The Hostname to use"
  default     = "www.example.com"
}

variable "site_location" {
  description = "Greographical Location"
  default     = "US"
}

variable "site_logs_prefix" {
  description = "Logs prefix"
  default     = "logs"
}

variable "tstate_bucket" {
  description = "Bucket to store terraform states"
  default     = ""
}

variable "tstate_prefix" {
  description = "Prefix for terraform state files"
  default     = ""
}

