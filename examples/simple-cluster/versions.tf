terraform {
  required_version = ">= 0.13.0"

  required_providers {
    spotinst = {
      source  = "spotinst/spotinst"
      version = ">= 1.44.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.2.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.55.0"
    }
  }
}
