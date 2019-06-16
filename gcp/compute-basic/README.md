# TL;DR

This particular module would create a single compute instance in GCP within it's own VPC and subnet

## Considerations

This module was tested using terraform

```bash
$ terraform version
Terraform v0.12.2
```

## How to

* Firstly, you need to take a look at variables.tf and make changes accordingly. You can also create your own config.tfvars somewhere else and point it at the moment of planning.

* If you decide to use a .tfvars file like I did you may want to make sure the variable type for variable. For example:

```terraform
openvpn-allow-firewall-rule = {name = "openvpn-house-access", protocol = "udp", ports = "1194", target-tags = "brasil,proxy,ssh", sources-ranges = "73.3.4.5/32"}

compute-resource = {name = "proxy", machine-type = "g1-small", tags = "brasil,proxy,ssh", image = "debian-cloud/debian-9", ssh-user = "user", ssh-key-path = "~/.ssh/id_rsa.pub"}

project = "some-project"
```

1. `terraform init` to initialize terraform

```bash
$ terraform init
```

Initializing the backend...

Initializing provider plugins...

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```

2. Create a terraform plan `terraform plan`

```bash
$ terraform plan -var-file="~/terrStuff/variables/compute-basic.tfvars" \
               -out=~/terrStuff/outputs/compute-basic/plan -state=~/terrStuff/states/compute-basic.tfstate

.
.
.
Plan: 8 to add, 0 to change, 0 to destroy.

------------------------------------------------------------------------

This plan was saved to: ~/terrStuff/outputs/compute-basic/plan

To perform exactly these actions, run the following command to apply:
    terraform apply "~/terrStuff/outputs/compute-basic/plan"
```

3. Apply the plan `terraform apply`

```bash
$ terraform apply  -state=~/terrStuff/states/compute-basic.tfstate "~/terrStuff/outputs/compute-basic/plan"

Apply complete! Resources: 8 added, 0 changed, 0 destroyed.

Outputs:

da-ip = 35.199.115.138
availability-zone = southamerica-east1-a
```


4. SSH in and finish anything if not already

```bash
$ ssh user@35.199.115.138
The authenticity of host '35.199.115.138 (35.199.115.138)' can't be established.
ECDSA key fingerprint is SHA256:8JCxS6etQjYKQKuJeDmrJw+rRgW7KoTYoQuZkT8lk/Y.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added '35.199.115.138' (ECDSA) to the list of known hosts.
Enter passphrase for key '~/.ssh/id_rsa':
Linux proxy-867a66cd14c0c716 4.9.0-9-amd64 #1 SMP Debian 4.9.168-1+deb9u2 (2019-05-13) x86_64

The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.
```
