// region azure/aks

variable "resource_group_name" {
  type        = string
  description = "The Resource Group name to be imported"
}

variable "aks_cluster_name" {
  type        = string
  description = "The AKS cluster name to be imported"
}

// endregion

// region spotinst/ocean-aks

variable "spotinst_token" {
  type        = string
  description = "Spot Personal Access token"
}

variable "spotinst_account" {
  type        = string
  description = "Spot account ID"
}

// endregion
