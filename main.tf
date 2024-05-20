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

# GCB: Historic
resource "google_storage_bucket" "wf_historic" {
  name          = "${local.bucket_name}_${var.HISTORIC}_bucket" # has to be globally unique
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

# GCB: Historic
resource "google_storage_bucket" "wf_active" {
  name          = "${local.bucket_name}_${var.ACTIVE}_bucket" # has to be globally unique
  location      = var.region
  force_destroy = true

  # delete in 3 days
  lifecycle_rule {
    condition {
      age = 55 # days
    }
    action {
      type = "Delete"
    }
  }

  # removes chunked data that hasn't finished uploading even across a day. It would be unusable anyway
  lifecycle_rule {
    condition {
      age = 55
    }
    action {
      type = "AbortIncompleteMultipartUpload"
    }
  }
}

# BQ Dataset: Historic
resource "google_bigquery_dataset" "wf_historic" {
  dataset_id = "${local.bucket_name}_${var.HISTORIC}_dataset"
  project    = local.project
  location   = var.region
}

# BQ Dataset: Active
resource "google_bigquery_dataset" "wf_active" {
  dataset_id = "${local.bucket_name}_${var.ACTIVE}_dataset"
  project    = local.project
  location   = var.region
}

# BQ Dataset: staging
resource "google_bigquery_dataset" "staging" {
  dataset_id = "${local.bucket_name}_staging"
  project    = local.project
  location   = var.region
}

# BQ Dataset: prod
resource "google_bigquery_dataset" "prod" {
  dataset_id = "${local.bucket_name}_prod"
  project    = local.project
  location   = var.region
}