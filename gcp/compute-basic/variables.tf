variable "region" {
  default = "southamerica-east1"
}

/** Can't be used as intended but would had been great 
variable "backend-bucket" {
  description = "Where the terraform state will be backed up"
  default     = "tf-state-prod"
}

variable "backend-prefix" {
  description = "Prefix for terraform state for this particular module"
  default     = "terraform/state"
}
**/

variable "creds" {
  description = "Path to the service account JSON file"
  default     = "~/creds/creds.json"
}

variable "project" {
  description = "Project in which you wish to deploy resources in this module"
  default     = ""
}


variable "compute-resource" {
  description = "Variables for the compute resource"
  type        = "map"
  default     = {
    "name"         = "proxy"
    "machine-type" = "g1-small"
    "tags"         = ""
    "image"        = "debian-cloud/debian-9"
    "ssh-user"     = ""
    "ssh-key-path"  = "~/.ssh/id_rsa.pub"
  }
}

variable "default-network-name" {
  description = "The name for the default network to be created"
  default     = "fauzis-network"
}

variable "subnetwork" {
  description = "IP range for the subnet"
  type        = "map"
  default     = {
    "name"    = "samba"
    "cidr"    = "172.16.0.0/19"
  }
}

variable "secondary-ip-range" {
  description = "Secondary IP range for the subnet"
  type        = "map"
  default     = {
    "name"    = "tf-test-secondary-range-update1"
    "cidr"    = "192.168.10.0/24"
  }
}

variable "icmp-allow-firewall-rule" {
  description = "ICMP rewall rule"
  type        = "map"
  default     = {
    "name"           = "world-icmp-allow"
    "protocol"       = "icmp"
    "target-tags"    = "brasil"
    "sources-ranges" = "0.0.0.0/0"
  }
}

variable "openvpn-allow-firewall-rule" {
  description = "OpenVPN firewall rule"
  type        = "map"
  default     = {
    "name"           = "openvpn-house-access"
    "protocol"       = "udp"
    "ports"          = "1194"
    "target-tags"    = "brasil,proxy,ssh"
    "sources-ranges" = ""
  }
}

variable "ssh-allow-firewall-rule" {
  description = "SSH firewall rule"
  type        = "map"
  default     = {
    "name"           = "world-ssh-access"
    "protocol"       = "tcp"
    "ports"          = "22"
    "target-tags"    = "ssh"
    "sources-ranges" = "0.0.0.0/0"
  }
}

variable "ssh-key" {
  description = "SSH key to add to the compute instance on the getgo"
  default     = "~/.ssh/id_rsa.pub"
}
