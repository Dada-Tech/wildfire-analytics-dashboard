locals {
  credentials = "./keys/de-zoom-final-3c45fca759a8.json"
  project = "de-zoom-final"
  bucket_name = "wildfire-main"
}

# choose region based on your location, https://cloud.google.com/about/locations.
# montreal is northamerica-northeast1
variable "region" {
  description = "Region for GCP resources. Choose as per your location: https://cloud.google.com/about/locations"
  default = "northamerica-northeast1"
  type = string
}

# Equivalent to schema in data warehouse
variable "BQ_DATASET" {
  description = "BigQuery Dataset that raw data (from GCS) will be written to"
  type = string
  default = "historic_fires"
}