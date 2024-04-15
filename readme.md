# Historical Wildfires in Alberta
## Overview:
This project uses open city wildfire data to story tell.
The motivation behind this project is to extract insights by looking at historical fire causes over the years.
As wildfires effect the health of the overall population, its become increasingly important to monitor and understand fires and their various causes, including human error.

## Objective:
* Extract historical wildfire data
* Transform & Load the data into a Data Lake
* Provide insights, reports to support data-driven decisions

## Tools:
1. **Infrastructure Setup:** Terraform to build Cloud Storage and BigQuery resources.
2. **Environment:** Python, Docker
3. **ETL Pipeline:**
   * Extract data: Open City historical fire data
   * Transform data: transform to Pandas Dataframe from Excel spreadsheet
   * Load the Data: into Data Lake (GCS) and Data Warehouse (BigQuery) 

4. **Orchestration:** using Mage to orchestrate the ETL pipeline
5. **Containerization & Deployment:** Dockerized the ETL pipeline for scalability
6. **Data Warehouse:** Use DBT perform consistent and stable transformations to build a historical fact table
7. **Visualization:** [Looker Studio Historical Fires Report](https://lookerstudio.google.com/reporting/c7243c72-47b9-455e-a55f-d30cb3da2305)
8. **Automation:** using Mage, and DBT to enforce data freshness

# Project Details

## Data Ingestion:


## DBT:
### Seed Data
#### Fire Weather Index
obtained from Alberta's Open City Data. It was presented as a non-text friendly pseudo-table, so the table had to be reconstructed manually:
* OCR to extract text
* LLMs to process and transform text
* formatted as CSV

https://open.alberta.ca/publications/fire-weather-index-legend

#### Fire Number to Forest Area
Maps part of the Fire Number code to forest area. Built from description of the Fire Number field name
https://open.alberta.ca/opendata/wildfire-data