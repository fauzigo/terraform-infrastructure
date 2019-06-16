

resource "google_storage_bucket" "site-bucket" {
  name     = "${var.site_hostname}"
  location = "${var.site_location}"

  website {
    main_page_suffix = "index.html"
    not_found_page   = "error.html"
  }

  logging {
    log_bucket        = "${google_storage_bucket.site-logs.name}"
    log_object_prefix = "${var.site_logs_prefix}"
  }
}


resource "google_storage_bucket" "site-logs" {
  name     = "${replace(var.site_hostname,".","-")}-logs"
  location = "${var.site_location}"
}
