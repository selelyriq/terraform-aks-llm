variable "resource_group_name" {
  type        = string
  description = "The name of the resource group to create for the remote state."
}

variable "location" {
  type        = string
  description = "The Azure region to create the remote state resources in."
}

variable "storage_account_name_prefix" {
  type        = string
  description = "The prefix for the storage account name."
}

variable "storage_container_name" {
  type        = string
  description = "The name of the storage container to create for the remote state."
}
