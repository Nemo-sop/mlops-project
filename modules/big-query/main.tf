# Google Cloud project ID
variable "project_id" {
  description = "The ID of the Google Cloud project"
  type        = string
}

# Define the dataset
resource "google_bigquery_dataset" "test_data" {
  dataset_id = "test_data"              
  location   = "US"                      
  project    = var.project_id            
}

# Define the BigQuery table inside the dataset with the specified schema
resource "google_bigquery_table" "transcripts" {
  table_id   = "transcripts"            
  dataset_id = google_bigquery_dataset.test_data.dataset_id 

  schema = jsonencode([
    {
      name     = "Id"
      type     = "STRING"
      mode     = "REQUIRED"               
    },
    {
      name     = "Created_at"
      type     = "DATETIME"
      mode     = "REQUIRED"               
    },
    {
      name     = "Content"
      type     = "STRING"
      mode     = "REQUIRED"              
    },
  ])

  project = var.project_id               
}
