terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.8.0"
    }
  }
}

provider "google" {
  credentials = file(local.credentials)
  project     = local.project
  region      = var.region
}

# demo-bucket is the variable name, local nameof this resource
resource "google_storage_bucket" "historical-fires-bucket" {
  name          = "${local.bucket_name}_${local.project}" # has to be globally unique
  location      = var.region
  force_destroy = true

  # delete in 3 days
  lifecycle_rule {
    condition {
      age = 3 # days
    }
    action {
      type = "Delete"
    }
  }

  # removes chunked data that hasn't finished uploading even across a day. It would be unusable anyway
  lifecycle_rule {
    condition {
      age = 1
    }
    action {
      type = "AbortIncompleteMultipartUpload"
    }
  }
}

# Ref: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/bigquery_dataset
resource "google_bigquery_dataset" "dataset" {
  dataset_id = var.BQ_DATASET
  project    = local.project
  location   = var.region
}