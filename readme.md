# Wildfires - Past and Present Insights
### [View Live Project](https://lookerstudio.google.com/reporting/0ab14a2a-c5bc-4737-86a3-3e65f73ee9f9)
###### Last Checked: 2024-05-20

## Project Overview:
This project leverages wildfire data to story-tell.
Its core aim is to deliver valuable insights by analyzing both historical and ongoing wildfire incidents.
In the era of climate change, there's a growing urgency to monitor and comprehend these occurrences and their wide range of causes, including human error.

As a resident of a town that underwent a town-wide fire evacuation, observing that data as an anomaly in this dashboard was enlightening.
During the project's inception, my town was also under a fire-watch warning, with some residents already evacuating.
It was reassuring to note that the fire encroaching upon my family's hometown was now under control according to the latest daily data.
Ensuring the accuracy and currency of this project remained imperative throughout its development.

## Objective:
* Extract historical and active wildfire data
* Transform & Load the data into a Data Lake
* Provide insights and reports which support data-driven decisions and provide insight into wildfires.

###### Visualization 1 - Active Wildfires
![wf-active.png](readme_images%2Fwf-active.png)
###### Visualization 2 - Historic Wildfires
![wf-historic.png](readme_images%2Fwf-historic.png)

## Data Sources:
#### Historical Wildfires:
[Alberta Historical Wildfire Data](https://open.alberta.ca/opendata/wildfire-data)

#### Active Wildfires:
[Natural Resources Canada](https://cwfis.cfs.nrcan.gc.ca/datamart/metadata/activefires)

## Architecture:
![pipeline-architecture.jpg](readme_images/pipeline-architecture.jpg)
1. Open City Data, Canada Active Wildfire data
2. Dockerized Mage orchestrator
3. Orchestration: Python ETL Pipeline in Mage
4. Automated Infrastructure as code: Terraform
5. Data Lake: Google Cloud Storage Bucket
6. Data Warehouse: BigQuery
7. Data transformations & Model building: DBT Cloud
8. Reporting & Visualization

## Tools:
1. **Infrastructure Setup:** Terraform to build Cloud Storage and BigQuery resources.
2. **Environment:** Python, Docker
3. **ETL Pipeline:**
   * Extract data: Open City historical fire data
   * Transform data: transform to Pandas Dataframe from various sources (Excel & CSV)
   * Load the Data: into Data Lake (GCS) and Data Warehouse (BigQuery) 

4. **Orchestration:** using Mage to orchestrate the ETL pipeline. Running daily for active Wildfires only
5. **Containerization & Deployment:** Dockerized the ETL pipeline for scalability
6. **Data Warehouse:** Use DBT perform consistent and stable transformations to build a historical fact table
7. **Visualization:** I made a Looker Studio Historical Fires Report
8. **Automation:** using Mage, and DBT to enforce data freshness

# Project Details

## Data Ingestion:
Simple pipeline of an API loader
Loading into Data Warehouse and Data Lake
  
```Mage```: Orchestration
* Historic: A simple column name transformation was used because the data was messy
  * Column name erroneously named ``` "`" ``` which is an illegal character in BigQuery.
  * Upon further investigation and referring to the data dictionary, this column should be named ```"true_cause"```
###### Historic Wildfires  
![mage-historic.png](readme_images%2Fmage-historic.png)
###### Active Wildfires
![mage-active.png](readme_images%2Fmage-active.png)
###### Active Wildfires Scheduling
![mage-pipeline-active.png](readme_images%2Fmage-pipeline-active.png)
## Data Warehouse
```BigQuery``` first inspection
![data-warehouse.png](readme_images%2Fdata-warehouse.png)

## DBT:
Building a model using seed data and wildfire data to a final fact table for historical fire data.  
DBT applies scalable, scheduled and testable transformations to the data, and jobs to ensure the data is fresh.

```DBT Model```
![dbt.png](readme_images%2Fdbt.png)

### Seed Data
#### Historic: Fire Weather Index
Obtained from Alberta's Open City Data. It was presented as a non-text friendly pseudo-table, so the table had to be reconstructed manually:
* OCR to extract text
* LLMs to process and transform text
* formatted as CSV
* Ultimately ended up not using this, but documentation of steps is important
https://open.alberta.ca/publications/fire-weather-index-legend

#### Historic: Fire Number to Forest Area
Constructed a separate table of Fire Number data based on text descriptions found in the data dictionary.  
This will be inner-joined with the main table to provide detailed wildfire location names.
![fire-number-data-dictionary.png](readme_images%2Ffire-number-data-dictionary.png)

#### Active: Wildfires Stage of Control
Built a table from the stage of control described below to increase interpretability if the data.
![active-wildfires-data-dictionary.png](readme_images%2Factive-wildfires-data-dictionary.png)

## Visualization
Using LookerStudio to have an interactive dashboard with the following filters.
* ##### Historic fires by year
  * A lot of fires happen each year. which means too many data points to interpret a single graph
* ##### Historic fires by class size of fire
  * Users would be further break down historic fires
* ##### Active fires by min hectares
  * Users might want to filter out smaller fires
* ##### Active fires by stage of control
  * The current concern might be to quickly drill down to out of control fires

# Instructions
## 0. Preparation
clone the project
```
giit clone git@github.com:Dada-Tech/wildfires-pipeline.git
```
## 1. Google Cloud
* Create an account
* Generate Credentials for service account
  * Roles: BigQuery Admin, Storage Admin, Storage Object Admin, Actions Viewer 
* Save the key to the /keys, it will be referenced later

## 2. Dev Environment
* **gcloud** for CLI operations
* **docker**: for container orchestration
* **terraform** for GCP setup

## 3. Terraform
Variables are stored and used from previous steps here in the ```variables.tf``` file
* credentials: Service account json credentials
* project: GCP project name
* bucket_name: GCS bucket name
* BQ_DATASET: BQ dataset name
* region: GCP data region

## 4. Mage
A simple Dockerfile is used to build a mage container.
Ensure your key is saved to ./keys because that will be a local volume mount

```docker compose up -d```

## 5. DBT
* Create a dbt account for Cloud use
* Connect to your repo
* Automate via Job creation or CI/CD