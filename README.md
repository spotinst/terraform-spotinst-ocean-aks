# Spot Ocean AKS Terraform Module

A Terraform module to create a [Azure Kubernetes Service (AKS)](https://azure.microsoft.com/en-in/services/kubernetes-service/) cluster with [Spot Ocean](https://spot.io/products/ocean). The module will install the Ocean Controller into the cluster.

## Table of Contents

- [Usage](#usage)
- [Prerequisites](#prerequisites)
- [Examples](#examples)
- [Resources](#resources)
- [Requirements](#requirements)
- [Providers](#providers)
- [Inputs](#inputs)
- [Outputs](#outputs)
- [Documentation](#documentation)
- [Getting Help](#getting-help)
- [Community](#community)
- [Contributing](#contributing)
- [License](#license)

## Prerequisites

For `kubectl` to connect and interface properly with your [Azure Kubernetes Service (AKS)](https://azure.microsoft.com/en-in/services/kubernetes-service/) cluster, you have to install the `az` CLI.

- [az](https://docs.microsoft.com/en-us/cli/azure)
- [kubectl](https://kubernetes.io/docs/setup/production-environment/turnkey/gce/#installing-the-kubernetes-command-line-tools-on-your-workstation)

## Usage

```hcl
module "ocean-aks" {
  source = "spotinst/ocean-aks/spotinst"

  # Credentials.
  spotinst_token   = var.spotinst_token
  spotinst_account = var.spotinst_account

  # Configuration.
  resource_group_name = var.resource_group_name
  prefix              = var.prefix
}
```

## Examples

- [Create Cluster](https://github.com/spotinst/terraform-spotinst-ocean-aks/tree/main/examples/create-cluster)
- [Import Cluster](https://github.com/spotinst/terraform-spotinst-ocean-aks/tree/main/examples/import-cluster)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 2.55 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | ~> 2.0 |
| <a name="requirement_spotinst"></a> [spotinst](#requirement\_spotinst) | ~> 1.44 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 2.60.0 |
| <a name="provider_spotinst"></a> [spotinst](#provider\_spotinst) | 1.44.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aks"></a> [aks](#module\_aks) | ./modules/aks | n/a |
| <a name="module_ocean-controller"></a> [ocean-controller](#module\_ocean-controller) | spotinst/ocean-controller/spotinst | ~> 0.28 |
| <a name="module_ssh"></a> [ssh](#module\_ssh) | ./modules/ssh | n/a |

## Resources

| Name | Type |
|------|------|
| [spotinst_ocean_aks.cluster](https://registry.terraform.io/providers/spotinst/spotinst/latest/docs/resources/ocean_aks) | resource |
| [spotinst_ocean_aks_virtual_node_group.nodepool](https://registry.terraform.io/providers/spotinst/spotinst/latest/docs/resources/ocean_aks_virtual_node_group) | resource |
| [azurerm_kubernetes_cluster_node_pool.nodepool](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/kubernetes_cluster_node_pool) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acd_identifier"></a> [acd\_identifier](#input\_acd\_identifier) | A unique identifier used by the Ocean AKS Connector when importing an AKS cluster | `string` | `null` | no |
| <a name="input_admin_username"></a> [admin\_username](#input\_admin\_username) | The username of the local administrator to be created on the Kubernetes cluster | `string` | `"azureuser"` | no |
| <a name="input_agents_availability_zones"></a> [agents\_availability\_zones](#input\_agents\_availability\_zones) | A list of Availability Zones across which the Node Pool should be spread. Changing this forces a new resource to be created | `list(string)` | `null` | no |
| <a name="input_agents_count"></a> [agents\_count](#input\_agents\_count) | The number of Agents that should exist in the Agent Pool. Please set `agents_count` `null` while `enable_auto_scaling` is `true` to avoid possible `agents_count` changes | `number` | `1` | no |
| <a name="input_agents_max_count"></a> [agents\_max\_count](#input\_agents\_max\_count) | Maximum number of nodes in a pool | `number` | `null` | no |
| <a name="input_agents_max_pods"></a> [agents\_max\_pods](#input\_agents\_max\_pods) | The maximum number of pods that can run on each agent. Changing this forces a new resource to be created | `number` | `null` | no |
| <a name="input_agents_min_count"></a> [agents\_min\_count](#input\_agents\_min\_count) | Minimum number of nodes in a pool | `number` | `null` | no |
| <a name="input_agents_pool_name"></a> [agents\_pool\_name](#input\_agents\_pool\_name) | The default Azure AKS agentpool (nodepool) name | `string` | `"nodepool"` | no |
| <a name="input_agents_size"></a> [agents\_size](#input\_agents\_size) | The default virtual machine size for the Kubernetes agents | `string` | `"Standard_D2s_v3"` | no |
| <a name="input_agents_type"></a> [agents\_type](#input\_agents\_type) | The type of Node Pool which should be created. Possible values are AvailabilitySet and VirtualMachineScaleSets. Defaults to VirtualMachineScaleSets | `string` | `"VirtualMachineScaleSets"` | no |
| <a name="input_aks_cluster_name"></a> [aks\_cluster\_name](#input\_aks\_cluster\_name) | The name for the AKS resources created in the specified Azure Resource Group. This variable overwrites the 'prefix' var (The 'prefix' var will still be applied to the dns\_prefix if it is set) | `string` | `null` | no |
| <a name="input_client_id"></a> [client\_id](#input\_client\_id) | The Client ID (appId) for the Service Principal used for the AKS deployment | `string` | `""` | no |
| <a name="input_client_secret"></a> [client\_secret](#input\_client\_secret) | The Client Secret (password) for the Service Principal used for the AKS deployment | `string` | `""` | no |
| <a name="input_cluster_identifier"></a> [cluster\_identifier](#input\_cluster\_identifier) | Cluster identifier | `string` | `null` | no |
| <a name="input_cluster_log_analytics_workspace_name"></a> [cluster\_log\_analytics\_workspace\_name](#input\_cluster\_log\_analytics\_workspace\_name) | The name of the Analytics workspace | `string` | `null` | no |
| <a name="input_controller_aks_connector_enabled"></a> [controller\_aks\_connector\_enabled](#input\_controller\_aks\_connector\_enabled) | Controls whether the Ocean AKS Connector should be deployed (requires a valid `acd_identifier`) | `bool` | `true` | no |
| <a name="input_controller_base_url"></a> [controller\_base\_url](#input\_controller\_base\_url) | Base URL to be used by the HTTP client | `string` | `""` | no |
| <a name="input_controller_disable_auto_update"></a> [controller\_disable\_auto\_update](#input\_controller\_disable\_auto\_update) | Disable the auto-update feature | `bool` | `false` | no |
| <a name="input_controller_enable_csr_approval"></a> [controller\_enable\_csr\_approval](#input\_controller\_enable\_csr\_approval) | Enable the CSR approval feature | `bool` | `false` | no |
| <a name="input_controller_image_pull_policy"></a> [controller\_image\_pull\_policy](#input\_controller\_image\_pull\_policy) | Image pull policy (one of: Always, Never, IfNotPresent) | `string` | `"IfNotPresent"` | no |
| <a name="input_controller_image_pull_secrets"></a> [controller\_image\_pull\_secrets](#input\_controller\_image\_pull\_secrets) | List of references to secrets in the same namespace to use for pulling the image | `list(string)` | `[]` | no |
| <a name="input_controller_proxy_url"></a> [controller\_proxy\_url](#input\_controller\_proxy\_url) | Proxy server URL to communicate through | `string` | `""` | no |
| <a name="input_controller_resources_limits"></a> [controller\_resources\_limits](#input\_controller\_resources\_limits) | Definition of the maximum amount of compute resources allowed | `map(any)` | `null` | no |
| <a name="input_controller_resources_requests"></a> [controller\_resources\_requests](#input\_controller\_resources\_requests) | Definition of the minimum amount of compute resources required | `map(any)` | `null` | no |
| <a name="input_controller_tolerations"></a> [controller\_tolerations](#input\_controller\_tolerations) | List of additional `toleration` objects, see: https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/pod#toleration | `list(any)` | <pre>[<br>  {<br>    "effect": "NoExecute",<br>    "key": "node.kubernetes.io/not-ready",<br>    "operator": "Exists",<br>    "toleration_seconds": 150<br>  },<br>  {<br>    "effect": "NoExecute",<br>    "key": "node.kubernetes.io/unreachable",<br>    "operator": "Exists",<br>    "toleration_seconds": 150<br>  }<br>]</pre> | no |
| <a name="input_create_aks"></a> [create\_aks](#input\_create\_aks) | Controls whether AKS cluster should be created (it affects all Azure resources) | `bool` | `true` | no |
| <a name="input_create_ocean"></a> [create\_ocean](#input\_create\_ocean) | Controls whether Ocean should be created (it affects all Ocean resources) | `bool` | `true` | no |
| <a name="input_enable_auto_scaling"></a> [enable\_auto\_scaling](#input\_enable\_auto\_scaling) | Enable AKS node pool autoscaling | `bool` | `false` | no |
| <a name="input_enable_azure_policy"></a> [enable\_azure\_policy](#input\_enable\_azure\_policy) | Enable Azure Policy Addon | `bool` | `false` | no |
| <a name="input_enable_http_application_routing"></a> [enable\_http\_application\_routing](#input\_enable\_http\_application\_routing) | Enable HTTP Application Routing Addon (forces recreation) | `bool` | `false` | no |
| <a name="input_enable_kube_dashboard"></a> [enable\_kube\_dashboard](#input\_enable\_kube\_dashboard) | Enable Kubernetes Dashboard | `bool` | `false` | no |
| <a name="input_enable_log_analytics_workspace"></a> [enable\_log\_analytics\_workspace](#input\_enable\_log\_analytics\_workspace) | Enable the creation of azurerm\_log\_analytics\_workspace and azurerm\_log\_analytics\_solution or not | `bool` | `true` | no |
| <a name="input_enable_node_public_ip"></a> [enable\_node\_public\_ip](#input\_enable\_node\_public\_ip) | Should nodes in this Node Pool have a Public IP Address? Defaults to false | `bool` | `false` | no |
| <a name="input_enable_role_based_access_control"></a> [enable\_role\_based\_access\_control](#input\_enable\_role\_based\_access\_control) | Enable Role Based Access Control | `bool` | `false` | no |
| <a name="input_identity_type"></a> [identity\_type](#input\_identity\_type) | The type of identity used for the managed cluster. Conflict with `client_id` and `client_secret`. Possible values are `SystemAssigned` and `UserAssigned`. If `UserAssigned` is set, a `user_assigned_identity_id` must be set as well | `string` | `"SystemAssigned"` | no |
| <a name="input_kubernetes_version"></a> [kubernetes\_version](#input\_kubernetes\_version) | Specify which Kubernetes release to use. The default used is the latest Kubernetes version available in the region | `string` | `null` | no |
| <a name="input_log_analytics_workspace_sku"></a> [log\_analytics\_workspace\_sku](#input\_log\_analytics\_workspace\_sku) | The SKU (pricing level) of the Log Analytics workspace. For new subscriptions the SKU should be set to PerGB2018 | `string` | `"PerGB2018"` | no |
| <a name="input_log_retention_in_days"></a> [log\_retention\_in\_days](#input\_log\_retention\_in\_days) | The retention period for the logs in days | `number` | `30` | no |
| <a name="input_net_profile_dns_service_ip"></a> [net\_profile\_dns\_service\_ip](#input\_net\_profile\_dns\_service\_ip) | IP address within the Kubernetes service address range that will be used by cluster service discovery (kube-dns). Changing this forces a new resource to be created | `string` | `null` | no |
| <a name="input_net_profile_docker_bridge_cidr"></a> [net\_profile\_docker\_bridge\_cidr](#input\_net\_profile\_docker\_bridge\_cidr) | IP address (in CIDR notation) used as the Docker bridge IP address on nodes. Changing this forces a new resource to be created | `string` | `null` | no |
| <a name="input_net_profile_outbound_type"></a> [net\_profile\_outbound\_type](#input\_net\_profile\_outbound\_type) | The outbound (egress) routing method which should be used for this Kubernetes Cluster. Possible values are loadBalancer and userDefinedRouting. Defaults to loadBalancer | `string` | `"loadBalancer"` | no |
| <a name="input_net_profile_pod_cidr"></a> [net\_profile\_pod\_cidr](#input\_net\_profile\_pod\_cidr) | The CIDR to use for pod IP addresses. This field can only be set when network\_plugin is set to kubenet. Changing this forces a new resource to be created | `string` | `null` | no |
| <a name="input_net_profile_service_cidr"></a> [net\_profile\_service\_cidr](#input\_net\_profile\_service\_cidr) | The Network Range used by the Kubernetes service. Changing this forces a new resource to be created | `string` | `null` | no |
| <a name="input_network_plugin"></a> [network\_plugin](#input\_network\_plugin) | Network plugin to use for networking | `string` | `"kubenet"` | no |
| <a name="input_network_policy"></a> [network\_policy](#input\_network\_policy) | Sets up network policy to be used with Azure CNI. Network policy allows us to control the traffic flow between pods. Currently supported values are calico and azure. Changing this forces a new resource to be created | `string` | `null` | no |
| <a name="input_node_pools"></a> [node\_pools](#input\_node\_pools) | List of maps containing node pools to be imported as Ocean Virtual Node Groups | `list(map(string))` | <pre>[<br>  {<br>    "name": "nodepool"<br>  }<br>]</pre> | no |
| <a name="input_node_pools_headrooms"></a> [node\_pools\_headrooms](#input\_node\_pools\_headrooms) | Map of maps containing headroom configuration by node pool name | `map(map(string))` | <pre>{<br>  "all": {},<br>  "nodepool": {}<br>}</pre> | no |
| <a name="input_node_pools_labels"></a> [node\_pools\_labels](#input\_node\_pools\_labels) | Map of maps containing node labels by node pool name | `map(map(string))` | <pre>{<br>  "all": {},<br>  "nodepool": {}<br>}</pre> | no |
| <a name="input_node_pools_tags"></a> [node\_pools\_tags](#input\_node\_pools\_tags) | Map of maps containing node tags by node pool name | `map(map(string))` | <pre>{<br>  "all": {},<br>  "nodepool": {}<br>}</pre> | no |
| <a name="input_node_pools_taints"></a> [node\_pools\_taints](#input\_node\_pools\_taints) | Map of lists containing node taints by node pool name | `map(list(object({ key = string, value = string, effect = string })))` | <pre>{<br>  "all": [],<br>  "nodepool": []<br>}</pre> | no |
| <a name="input_orchestrator_version"></a> [orchestrator\_version](#input\_orchestrator\_version) | Specify which Kubernetes release to use for the orchestration layer. The default used is the latest Kubernetes version available in the region | `string` | `null` | no |
| <a name="input_os_disk_size_gb"></a> [os\_disk\_size\_gb](#input\_os\_disk\_size\_gb) | Disk size of nodes in GBs | `number` | `50` | no |
| <a name="input_os_disk_type"></a> [os\_disk\_type](#input\_os\_disk\_type) | Disk type of nodes | `string` | `"Standard_LRS"` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | The prefix for the resources created in the specified Azure Resource Group | `string` | `"ocean"` | no |
| <a name="input_private_cluster_enabled"></a> [private\_cluster\_enabled](#input\_private\_cluster\_enabled) | If true cluster API server will be exposed only on internal IP address and available only in cluster vnet | `bool` | `false` | no |
| <a name="input_public_ssh_key"></a> [public\_ssh\_key](#input\_public\_ssh\_key) | A custom ssh key to control access to the AKS cluster | `string` | `""` | no |
| <a name="input_rbac_aad_admin_group_object_ids"></a> [rbac\_aad\_admin\_group\_object\_ids](#input\_rbac\_aad\_admin\_group\_object\_ids) | Object ID of groups with admin access | `list(string)` | `null` | no |
| <a name="input_rbac_aad_client_app_id"></a> [rbac\_aad\_client\_app\_id](#input\_rbac\_aad\_client\_app\_id) | The Client ID of an Azure Active Directory Application | `string` | `null` | no |
| <a name="input_rbac_aad_managed"></a> [rbac\_aad\_managed](#input\_rbac\_aad\_managed) | Is the Azure Active Directory integration Managed, meaning that Azure will create/manage the Service Principal used for integration | `bool` | `false` | no |
| <a name="input_rbac_aad_server_app_id"></a> [rbac\_aad\_server\_app\_id](#input\_rbac\_aad\_server\_app\_id) | The Server ID of an Azure Active Directory Application | `string` | `null` | no |
| <a name="input_rbac_aad_server_app_secret"></a> [rbac\_aad\_server\_app\_secret](#input\_rbac\_aad\_server\_app\_secret) | The Server Secret of an Azure Active Directory Application | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The resource group name to be imported | `string` | n/a | yes |
| <a name="input_sku_tier"></a> [sku\_tier](#input\_sku\_tier) | The SKU Tier that should be used for this Kubernetes Cluster. Possible values are Free and Paid | `string` | `"Free"` | no |
| <a name="input_spotinst_account"></a> [spotinst\_account](#input\_spotinst\_account) | Spot account ID | `string` | n/a | yes |
| <a name="input_spotinst_token"></a> [spotinst\_token](#input\_spotinst\_token) | Spot Personal Access token | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Any tags that should be present on the Virtual Network resources | `map(string)` | `{}` | no |
| <a name="input_user_assigned_identity_id"></a> [user\_assigned\_identity\_id](#input\_user\_assigned\_identity\_id) | The ID of a user assigned identity | `string` | `null` | no |
| <a name="input_vnet_subnet_id"></a> [vnet\_subnet\_id](#input\_vnet\_subnet\_id) | The ID of a Subnet where the Kubernetes Node Pool should exist. Changing this forces a new resource to be created | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_admin_client_certificate"></a> [admin\_client\_certificate](#output\_admin\_client\_certificate) | n/a |
| <a name="output_admin_client_key"></a> [admin\_client\_key](#output\_admin\_client\_key) | n/a |
| <a name="output_admin_cluster_ca_certificate"></a> [admin\_cluster\_ca\_certificate](#output\_admin\_cluster\_ca\_certificate) | n/a |
| <a name="output_admin_host"></a> [admin\_host](#output\_admin\_host) | n/a |
| <a name="output_admin_password"></a> [admin\_password](#output\_admin\_password) | n/a |
| <a name="output_admin_username"></a> [admin\_username](#output\_admin\_username) | n/a |
| <a name="output_aks_id"></a> [aks\_id](#output\_aks\_id) | n/a |
| <a name="output_client_certificate"></a> [client\_certificate](#output\_client\_certificate) | n/a |
| <a name="output_client_key"></a> [client\_key](#output\_client\_key) | n/a |
| <a name="output_cluster_ca_certificate"></a> [cluster\_ca\_certificate](#output\_cluster\_ca\_certificate) | n/a |
| <a name="output_host"></a> [host](#output\_host) | n/a |
| <a name="output_http_application_routing_zone_name"></a> [http\_application\_routing\_zone\_name](#output\_http\_application\_routing\_zone\_name) | n/a |
| <a name="output_kube_config_raw"></a> [kube\_config\_raw](#output\_kube\_config\_raw) | n/a |
| <a name="output_kubelet_identity"></a> [kubelet\_identity](#output\_kubelet\_identity) | n/a |
| <a name="output_location"></a> [location](#output\_location) | n/a |
| <a name="output_node_resource_group"></a> [node\_resource\_group](#output\_node\_resource\_group) | n/a |
| <a name="output_ocean_acd_identifier"></a> [ocean\_acd\_identifier](#output\_ocean\_acd\_identifier) | The identifier used by the Ocean AKS Connector to import the AKS cluster |
| <a name="output_ocean_cluster_id"></a> [ocean\_cluster\_id](#output\_ocean\_cluster\_id) | The ID of the Ocean cluster |
| <a name="output_ocean_cluster_name"></a> [ocean\_cluster\_name](#output\_ocean\_cluster\_name) | The name of the Ocean cluster |
| <a name="output_ocean_controller_cluster_id"></a> [ocean\_controller\_cluster\_id](#output\_ocean\_controller\_cluster\_id) | The ID of the Ocean controller |
| <a name="output_password"></a> [password](#output\_password) | n/a |
| <a name="output_system_assigned_identity"></a> [system\_assigned\_identity](#output\_system\_assigned\_identity) | n/a |
| <a name="output_username"></a> [username](#output\_username) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Documentation

If you're new to [Spot](https://spot.io/) and want to get started, please checkout our [Getting Started](https://docs.spot.io/connect-your-cloud-provider/) guide, available on the [Spot Documentation](https://docs.spot.io/) website.

## Getting Help

We use GitHub issues for tracking bugs and feature requests. Please use these community resources for getting help:

- Ask a question on [Stack Overflow](https://stackoverflow.com/) and tag it with [terraform-spotinst](https://stackoverflow.com/questions/tagged/terraform-spotinst/).
- Join our [Spot](https://spot.io/) community on [Slack](http://slack.spot.io/).
- Open an issue.

## Community

- [Slack](http://slack.spot.io/)
- [Twitter](https://twitter.com/spot_hq/)

## Contributing

Please see the [contribution guidelines](CONTRIBUTING.md).

## License

Code is licensed under the [Apache License 2.0](LICENSE).
