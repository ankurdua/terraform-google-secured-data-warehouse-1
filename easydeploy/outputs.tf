output "dataflow_controller_service_account_email" {
  description = "The Dataflow controller service account email. See https://cloud.google.com/dataflow/docs/concepts/security-and-permissions#specifying_a_user-managed_controller_service_account."
  value       = module.secured_data_warehouse.dataflow_controller_service_account_email
}

output "storage_writer_service_account_email" {
  description = "The Storage writer service account email. Should be used to write data to the buckets the data ingestion pipeline reads from."
  value       = module.secured_data_warehouse.storage_writer_service_account_email
}

output "pubsub_writer_service_account_email" {
  description = "The PubSub writer service account email. Should be used to write data to the PubSub topics the data ingestion pipeline reads from."
  value       = module.secured_data_warehouse.pubsub_writer_service_account_email
}

output "data_ingestion_bucket_name" {
  description = "The name of the bucket created for the data ingestion pipeline."
  value       = module.secured_data_warehouse.data_ingestion_bucket_name
}

output "data_ingestion_topic_name" {
  description = "The topic created for data ingestion pipeline."
  value       = module.secured_data_warehouse.data_ingestion_topic_name
}

output "data_ingestion_bigquery_dataset" {
  description = "The bigquery dataset created for data ingestion pipeline."
  value       = module.secured_data_warehouse.data_ingestion_bigquery_dataset
}

output "cmek_data_ingestion_crypto_key" {
  description = "The Customer Managed Crypto Key for the data ingestion crypto boundary."
  value       = module.secured_data_warehouse.cmek_data_ingestion_crypto_key
}

output "cmek_bigquery_crypto_key" {
  description = "The Customer Managed Crypto Key for the BigQuery service."
  value       = module.secured_data_warehouse.cmek_bigquery_crypto_key
}

output "cmek_reidentification_crypto_key" {
  description = "The Customer Managed Crypto Key for the reidentification crypto boundary."
  value       = module.secured_data_warehouse.cmek_reidentification_crypto_key
}

output "cmek_confidential_bigquery_crypto_key" {
  description = "The Customer Managed Crypto Key for the confidential BigQuery service."
  value       = module.secured_data_warehouse.cmek_confidential_bigquery_crypto_key
}

output "data_ingestion_access_level_name" {
  description = "Data Ingestion Access Context Manager access level name."
  value       = module.secured_data_warehouse.data_ingestion_access_level_name
}

output "data_ingestion_service_perimeter_name" {
  description = "Data Ingestion VPC Service Controls service perimeter name."
  value       = module.secured_data_warehouse.data_ingestion_service_perimeter_name
}

output "data_governance_access_level_name" {
  description = "Data Governance Access Context Manager access level name."
  value       = module.secured_data_warehouse.data_governance_access_level_name
}

output "data_governance_service_perimeter_name" {
  description = "Data Governance VPC Service Controls service perimeter name."
  value       = module.secured_data_warehouse.data_governance_service_perimeter_name
}

output "confidential_data_access_level_name" {
  description = "Confidential Data Access Context Manager access level name."
  value       = module.secured_data_warehouse.confidential_access_level_name
}

output "confidential_data_service_perimeter_name" {
  description = "Confidential Data VPC Service Controls service perimeter name"
  value       = module.secured_data_warehouse.confidential_service_perimeter_name
}

output "blueprint_type" {
  description = "Type of blueprint this module represents."
  value       = module.secured_data_warehouse.blueprint_type
}