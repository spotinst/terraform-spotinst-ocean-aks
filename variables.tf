// region azure/aks

variable "resource_group_name" {
  type        = string
  description = "The Resource Group name to be imported"
}

variable "aks_cluster_name" {
  type        = string
  description = "The AKS cluster name to be imported"
  default     = null
}

variable "prefix" {
  type        = string
  description = "The prefix for the resources created in the specified Azure Resource Group"
  default     = "ocean"
}

variable "client_id" {
  type        = string
  description = "The Client ID (appId) for the Service Principal used for the AKS deployment"
  default     = ""
}

variable "client_secret" {
  type        = string
  description = "The Client Secret (password) for the Service Principal used for the AKS deployment"
  default     = ""
}

variable "admin_username" {
  type        = string
  description = "The username of the local administrator to be created on the Kubernetes cluster"
  default     = "azureuser"
}

variable "agents_size" {
  type        = string
  description = "The default virtual machine size for the Kubernetes agents"
  default     = "Standard_D2s_v3"
}

variable "log_analytics_workspace_sku" {
  type        = string
  description = "The SKU (pricing level) of the Log Analytics workspace. For new subscriptions the SKU should be set to PerGB2018"
  default     = "PerGB2018"
}

variable "log_retention_in_days" {
  type        = number
  description = "The retention period for the logs in days"
  default     = 30
}

variable "agents_count" {
  type        = number
  description = "The number of Agents that should exist in the Agent Pool"
  default     = 1
}

variable "public_ssh_key" {
  type        = string
  description = "A custom ssh key to control access to the AKS cluster"
  default     = ""
}

variable "tags" {
  type        = map(string)
  description = "Any tags that should be present on the Virtual Network resources"
  default     = {}
}

variable "enable_log_analytics_workspace" {
  type        = bool
  description = "Enable the creation of azurerm_log_analytics_workspace and azurerm_log_analytics_solution"
  default     = true
}

variable "vnet_subnet_id" {
  type        = string
  description = "The ID of a Subnet where the Kubernetes Node Pool should exist. Changing this forces a new resource to be created"
  default     = null
}

variable "os_disk_size_gb" {
  type        = number
  description = "Disk size of nodes in GBs"
  default     = 50
}

variable "os_disk_type" {
  type        = string
  description = "Disk type of nodes"
  default     = "Standard_LRS"
}

variable "private_cluster_enabled" {
  type        = bool
  description = "If true cluster API server will be exposed only on internal IP address and available only in cluster vnet"
  default     = false
}

variable "enable_kube_dashboard" {
  type        = bool
  description = "Enable Kubernetes Dashboard"
  default     = false
}

variable "enable_http_application_routing" {
  type        = bool
  description = "Enable HTTP Application Routing Addon (forces recreation)"
  default     = false
}

variable "enable_azure_policy" {
  type        = bool
  description = "Enable Azure Policy Addon"
  default     = false
}

variable "sku_tier" {
  type        = string
  description = "The SKU Tier that should be used for this Kubernetes Cluster. Possible values are Free and Paid"
  default     = "Free"
}

variable "enable_role_based_access_control" {
  type        = bool
  description = "Enable Role Based Access Control"
  default     = false
}

variable "rbac_aad_managed" {
  type        = bool
  description = "Is the Azure Active Directory integration Managed, meaning that Azure will create/manage the Service Principal used for integration"
  default     = false
}

variable "rbac_aad_admin_group_object_ids" {
  type        = list(string)
  description = "Object ID of groups with admin access"
  default     = null
}

variable "rbac_aad_client_app_id" {
  type        = string
  description = "The Client ID of an Azure Active Directory Application"
  default     = null
}

variable "rbac_aad_server_app_id" {
  type        = string
  description = "The Server ID of an Azure Active Directory Application"
  default     = null
}

variable "rbac_aad_server_app_secret" {
  type        = string
  description = "The Server Secret of an Azure Active Directory Application"
  default     = null
}

variable "network_plugin" {
  type        = string
  description = "Network plugin to use for networking"
  default     = "kubenet"
}

variable "network_policy" {
  type        = string
  description = "Sets up network policy to be used with Azure CNI. Network policy allows us to control the traffic flow between pods. Currently supported values are calico and azure. Changing this forces a new resource to be created"
  default     = null
}

variable "net_profile_dns_service_ip" {
  type        = string
  description = "IP address within the Kubernetes service address range that will be used by cluster service discovery (kube-dns). Changing this forces a new resource to be created"
  default     = null
}

variable "net_profile_docker_bridge_cidr" {
  type        = string
  description = "IP address (in CIDR notation) used as the Docker bridge IP address on nodes. Changing this forces a new resource to be created"
  default     = null
}

variable "net_profile_outbound_type" {
  type        = string
  description = "The outbound (egress) routing method which should be used for this Kubernetes Cluster. Possible values are loadBalancer and userDefinedRouting. Defaults to loadBalancer"
  default     = "loadBalancer"
}

variable "net_profile_pod_cidr" {
  type        = string
  description = "The CIDR to use for pod IP addresses. This field can only be set when network_plugin is set to kubenet. Changing this forces a new resource to be created"
  default     = null
}

variable "net_profile_service_cidr" {
  type        = string
  description = "The Network Range used by the Kubernetes service. Changing this forces a new resource to be created"
  default     = null
}

variable "kubernetes_version" {
  type        = string
  description = "Specify which Kubernetes release to use. The default used is the latest Kubernetes version available in the region"
  default     = null
}

variable "orchestrator_version" {
  type        = string
  description = "Specify which Kubernetes release to use for the orchestration layer. The default used is the latest Kubernetes version available in the region"
  default     = null
}

variable "enable_auto_scaling" {
  type        = bool
  description = "Enable built-in node pool autoscaling"
  default     = false
}

variable "agents_max_count" {
  type        = number
  description = "Maximum number of nodes in a pool"
  default     = null
}

variable "agents_min_count" {
  type        = number
  description = "Minimum number of nodes in a pool"
  default     = null
}

variable "agents_pool_name" {
  type        = string
  description = "The default Azure AKS agentpool (nodepool) name"
  default     = "nodepool"
}

variable "enable_node_public_ip" {
  type        = bool
  description = "Should nodes in this Node Pool have a Public IP Address? Defaults to false"
  default     = false
}

variable "agents_availability_zones" {
  type        = list(string)
  description = "A list of Availability Zones across which the Node Pool should be spread. Changing this forces a new resource to be created"
  default     = null
}

variable "agents_labels" {
  type        = map(string)
  description = "A map of Kubernetes labels which should be applied to nodes in the Default Node Pool. Changing this forces a new resource to be created"
  default     = {}
}

variable "agents_taints" {
  type        = list(any)
  description = "List of additional `taint` objects, see: https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/pod#taint"
  default     = []
}

variable "agents_type" {
  type        = string
  description = "The type of Node Pool which should be created. Possible values are AvailabilitySet and VirtualMachineScaleSets. Defaults to VirtualMachineScaleSets"
  default     = "VirtualMachineScaleSets"
}

variable "agents_tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the Node Pool"
  default     = {}
}

variable "agents_max_pods" {
  type        = number
  description = "The maximum number of pods that can run on each agent. Changing this forces a new resource to be created"
  default     = null
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

variable "create_aks" {
  type        = bool
  description = "Controls whether AKS cluster should be created (it affects all Azure resources)"
  default     = true
}

variable "create_ocean" {
  type        = bool
  description = "Controls whether Ocean should be created (it affects all Ocean resources)"
  default     = true
}

variable "acd_identifier" {
  type        = string
  description = "A unique identifier used by the Ocean AKS Connector when importing an AKS cluster"
  default     = null
}

variable "cluster_identifier" {
  type        = string
  description = "Cluster identifier"
  default     = null
}

variable "headroom_cpu_per_unit" {
  type        = number
  description = "Configure the number of CPUs to allocate for the headroom (CPUs are denoted in millicores, where 1000 millicores = 1 vCPU)"
  default     = null
}

variable "headroom_gpu_per_unit" {
  type        = number
  description = "Configure the number of GPUs to allocate for the headroom"
  default     = null
}

variable "headroom_memory_per_unit" {
  type        = number
  description = "Configure the amount of memory (MiB) to allocate the headroom"
  default     = null
}

variable "headroom_num_of_units" {
  type        = number
  description = "The number of headroom units to maintain, where each unit has the defined CPU, memory, and GPU"
  default     = null
}

// endregion

// region spotinst/ocean-controller

variable "controller_image_pull_policy" {
  type        = string
  description = "Image pull policy (one of: Always, Never, IfNotPresent)"
  default     = "IfNotPresent"
}

variable "controller_base_url" {
  type        = string
  description = "Base URL to be used by the HTTP client"
  default     = ""
}

variable "controller_proxy_url" {
  type        = string
  description = "Proxy server URL to communicate through"
  default     = ""
}

variable "controller_enable_csr_approval" {
  type        = bool
  description = "Enable the CSR approval feature"
  default     = false
}

variable "controller_disable_auto_update" {
  type        = bool
  description = "Disable the auto-update feature"
  default     = false
}

variable "controller_image_pull_secrets" {
  type        = list(string)
  description = "List of references to secrets in the same namespace to use for pulling the image"
  default     = []
}

variable "controller_resources_limits" {
  type        = map(any)
  description = "Definition of the maximum amount of compute resources allowed"
  default     = null
  //  default = {
  //    cpu    = "0.5"
  //    memory = "512Mi"
  //  }
}

variable "controller_resources_requests" {
  type        = map(any)
  description = "Definition of the minimum amount of compute resources required"
  default     = null
  //  default = {
  //    cpu    = "0.5"
  //    memory = "512Mi"
  //  }
}

variable "controller_tolerations" {
  type        = list(any)
  description = "List of additional `toleration` objects, see: https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/pod#toleration"
  default = [
    {
      key                = "node.kubernetes.io/not-ready"
      effect             = "NoExecute"
      operator           = "Exists"
      toleration_seconds = 150
    },
    {
      key                = "node.kubernetes.io/unreachable"
      effect             = "NoExecute"
      operator           = "Exists"
      toleration_seconds = 150
    },
  ]
}

variable "controller_aks_connector_enabled" {
  type        = bool
  description = "Controls whether the Ocean AKS Connector should be deployed (requires a valid `acd_identifier`)"
  default     = true
}

// endregion
