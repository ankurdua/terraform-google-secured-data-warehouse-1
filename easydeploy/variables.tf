variable "org_id" {
  description = "The numeric organization id"
}

variable "folder_id" {
  description = "The folder to deploy in"
}

variable "billing_account" {
  description = "The billing account id associated with the project, e.g. XXXXXX-YYYYYY-ZZZZZZ"
}

variable "user_account" {
  description = "Email address of the user deploying the blueprint"
}

variable "region" {
  description = "The region where blueprint resources will be deployed"
}

variable "access_context_manager_policy_id" {
  description = ""
}

variable "group_email" {
  description = ""
}