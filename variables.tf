locals {
  credentials = "./keys/de-zoom-final-3c45fca759a8.json"
  project = "de-zoom-final"
  bucket_name = "wildfires"
}

# choose region based on your location, https://cloud.google.com/about/locations.
# montreal is northamerica-northeast1
variable "region" {
  description = "Region for GCP resources. Choose as per your location: https://cloud.google.com/about/locations"
  default = "northamerica-northeast1"
  type = string
}

# Equivalent to schema in data warehouse
variable "HISTORIC" {
  description = "Name of historic wildfire dataset"
  type = string
  default = "historic"
}

# Equivalent to schema in data warehouse
variable "ACTIVE" {
  description = "Name of active wildfire dataset"
  type = string
  default = "active"
}