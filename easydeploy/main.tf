/**
 * Copyright 2021 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

locals {
  int_org_required_roles = [
    "roles/orgpolicy.policyAdmin",
    "roles/accesscontextmanager.policyAdmin",
    "roles/resourcemanager.organizationAdmin",
    "roles/vpcaccess.admin",
    "roles/compute.xpnAdmin",
    "roles/billing.user"
  ]
}

module "base_projects" {
  source = "../test/setup/base-projects"

  org_id          = var.org_id
  folder_id       = var.folder_id
  billing_account = var.billing_account
  region          = var.region
}

module "iam_projects" {
  source   = "../test/setup/iam-projects"

  data_ingestion_project_id        = module.base_projects.data_ingestion_project_id
  non_confidential_data_project_id = module.base_projects.non_confidential_data_project_id
  data_governance_project_id       = module.base_projects.data_governance_project_id
  confidential_data_project_id     = module.base_projects.confidential_data_project_id
  service_account_email            = google_service_account.int_ci_service_account.email
}

resource "time_sleep" "wait_90_seconds" {
  create_duration = "90s"

  depends_on = [
    module.iam_projects
  ]
}

resource "google_service_account" "int_ci_service_account" {
  project      = module.base_projects.data_ingestion_project_id
  account_id   = "tf-deployment-account"
  display_name = "tf-deployment-account"
}

resource "google_service_account_iam_member" "cloud_build_iam" {
  service_account_id = google_service_account.int_ci_service_account.name
  role               = "roles/iam.serviceAccountTokenCreator"
  member             = "user:${var.user_account}"
}

resource "google_organization_iam_member" "org_admins_group" {
  for_each = toset(local.int_org_required_roles)
  org_id   = var.org_id
  role     = each.value
  member   = "serviceAccount:${google_service_account.int_ci_service_account.email}"
}

module "template_project" {
  source = "../test/setup/template-project"

  org_id                = var.org_id
  folder_id             = var.folder_id
  billing_account       = var.billing_account
  location              = var.region
  service_account_email = google_service_account.int_ci_service_account.email
}

module "secured_data_warehouse" {
  source                           = "../"
  org_id                           = var.org_id
  data_governance_project_id       = module.base_projects.data_governance_project_id
  confidential_data_project_id     = module.base_projects.confidential_data_project_id
  non_confidential_data_project_id = module.base_projects.non_confidential_data_project_id
  data_ingestion_project_id        = module.base_projects.data_ingestion_project_id
  sdx_project_number               = module.template_project.sdx_project_number
  terraform_service_account        = google_service_account.int_ci_service_account.email
  access_context_manager_policy_id = var.access_context_manager_policy_id
  bucket_name                      = "bucket_simple_example"
  dataset_id                       = "dataset_simple_example"
  cmek_keyring_name                = "key_name_simple_example"
  pubsub_resource_location         = var.region
  location                         = var.region
  delete_contents_on_destroy       = true
  perimeter_additional_members     = ["user:${var.user_account}"]
  data_engineer_group              = var.group_email
  data_analyst_group               = var.group_email
  security_analyst_group           = var.group_email
  network_administrator_group      = var.group_email
  security_administrator_group     = var.group_email
  providers = {
    google = google.with_sa
    google-beta = google-beta.with_sa 
   }
}
