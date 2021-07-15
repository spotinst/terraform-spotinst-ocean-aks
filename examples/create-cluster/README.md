# Create Cluster

This example illustrates how to create new AKS and Ocean clusters.

## Usage

To provision this example, run the following from within this directory:
- `terraform init` to get the plugins
- `terraform plan` to see the infrastructure plan
- `terraform apply` to apply the infrastructure build
- `terraform destroy` to destroy the built infrastructure

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 2.55 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | ~> 2.0 |
| <a name="requirement_spotinst"></a> [spotinst](#requirement\_spotinst) | ~> 1.53 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 2.67.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ocean-aks"></a> [ocean-aks](#module\_ocean-aks) | ../../ | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_location"></a> [location](#input\_location) | The Azure region where the Resource Group should exist | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | The prefix for the resources created in the specified Azure Resource Group | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The Resource Group name to be imported | `string` | n/a | yes |
| <a name="input_spotinst_account"></a> [spotinst\_account](#input\_spotinst\_account) | Spot account ID | `string` | n/a | yes |
| <a name="input_spotinst_token"></a> [spotinst\_token](#input\_spotinst\_token) | Spot Personal Access token | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aks_id"></a> [aks\_id](#output\_aks\_id) | n/a |
| <a name="output_host"></a> [host](#output\_host) | n/a |
| <a name="output_kubelet_identity"></a> [kubelet\_identity](#output\_kubelet\_identity) | n/a |
| <a name="output_location"></a> [location](#output\_location) | n/a |
| <a name="output_node_resource_group"></a> [node\_resource\_group](#output\_node\_resource\_group) | n/a |
| <a name="output_ocean_acd_identifier"></a> [ocean\_acd\_identifier](#output\_ocean\_acd\_identifier) | The identifier used by the Ocean AKS Connector to import the AKS cluster |
| <a name="output_ocean_cluster_id"></a> [ocean\_cluster\_id](#output\_ocean\_cluster\_id) | The ID of the Ocean cluster |
| <a name="output_ocean_cluster_name"></a> [ocean\_cluster\_name](#output\_ocean\_cluster\_name) | The name of the Ocean cluster |
| <a name="output_ocean_controller_cluster_id"></a> [ocean\_controller\_cluster\_id](#output\_ocean\_controller\_cluster\_id) | The ID of the Ocean controller |
| <a name="output_system_assigned_identity"></a> [system\_assigned\_identity](#output\_system\_assigned\_identity) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
