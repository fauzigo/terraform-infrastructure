# TL;DR

This module is intended to create a static website hosted in GCP buckets. 

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
site_hostname = "www.example.com"
credentials   = "~/creds/creds.json"
region        = "us-central1"
project       = "the-project"
```


1. `terraform init` to initialize terraform

```bash
$ terraform init

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
$ terraform plan -var-file="~/terrStuff/variables/static-website.tfvars" 
               -out=~/terrStuff/outputs/static-website/plan -state=~/terrStuff/states/static-website.tfstate
.
.
.
Plan: 2 to add, 0 to change, 0 to destroy.

------------------------------------------------------------------------

This plan was saved to: ~/terrStuff/outputs/static-website/plan

To perform exactly these actions, run the following command to apply:
    terraform apply "~/terrStuff/outputs/static-website/plan"
```


3. Apply the plan `terraform apply`

```bash
$ terraform apply  -state=~/terrStuff/states/compute-basic.tfstate "~/terrStuff/outputs/compute-basic/plan"
terraform apply -state=~/terrStuff/states/static-website.tfstate "~/terrStuff/outputs/static-website/plan"

Apply complete! Resources: 2 added, 0 changed, 0 destroyed.

Outputs:
```


4. Upload your site fites, index.html and error.html are the most important ones as they are set on the default settings.

You may have a couple of options, either copying the files one by one (maybe on a loop or something, or using `gsutil rsync`

Copying file by file:
```bash
$ gsutil cp Desktop/index.html gs://www.example.com
Copying file://Desktop/index.html [Content-Type=text/html]...
Uploading   gs://www.example.com/index.html:       0 B/2.58 KiB
Uploading   gs://www.example.com/index.html:       2.58 KiB/2.58 KiB
```

Rsyncing
```bash
gsutil rsync Desktop/website/ gs://www.example.com
```

I would recomend going into [rsync - Synchronize content of two buckets/directories](https://cloud.google.com/storage/docs/gsutil/commands/rsync) for a better understanding of rsync, it is not complex, it just has some options you may want to consider.


## Considerations

When you upload your files after creating the bucket, you may need to set the permissions of the objetct to public, either doing them all (if that's what you want) or only the objects you want to be public.

Single files
```bash
gsutil acl ch -u AllUsers:R gs://www.example.com/index.html
```

Everyting under the bucket
```bash
gsutil iam ch allUsers:objectViewer gs://www.example.com/
```


## Possible troubleshooting

### Permission issues, verifying the domain.
```bash
google_storage_bucket.site-bucket: Creating...

Error: googleapi: Error 403: The bucket you tried to create requires domain ownership verification., forbidden
```

You may need to confirm you own the domain and can make changed to the DNS records of said domain. Depending on your registrar it might be more or less easy. Go to google's [Webmaster Central](https://www.google.com/webmasters/verification/home) for that.


### Permission issues, ownership of verification
```bash
google_storage_bucket.site-bucket: Creating...

Error: googleapi: Error 403: The bucket you tried to create is a domain name owned by another user., forbidden
```

If you verified the domain like above, you most likely verified the domain using either you gmail or G-suite account, however you may need to read the verification as the service account you are using to create resources in GCP. Just go to Webmaster Central again and add the Service Account.

