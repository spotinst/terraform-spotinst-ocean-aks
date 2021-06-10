resource "spotinst_ocean_aks" "cluster" {
  count      = var.create_ocean ? 1 : 0
  depends_on = [module.ocean-controller]

  name                    = local.aks_cluster_name
  controller_cluster_id   = local.ocean_controller_cluster_id
  acd_identifier          = local.ocean_acd_identifier
  aks_name                = local.aks_cluster_name
  ssh_public_key          = local.public_ssh_key
  user_name               = local.username
  aks_resource_group_name = var.resource_group_name
}

data "azurerm_kubernetes_cluster_node_pool" "nodepool" {
  count      = var.create_ocean && length(local.node_pool_names) > 0 ? length(local.node_pool_names) : 0
  depends_on = [module.aks]

  resource_group_name     = var.resource_group_name
  kubernetes_cluster_name = local.aks_cluster_name
  name                    = local.node_pool_names[count.index]
}

resource "spotinst_ocean_aks_virtual_node_group" "nodepool" {
  count = var.create_ocean && length(local.node_pool_names) > 0 ? length(local.node_pool_names) : 0

  name     = local.node_pool_names[count.index]
  ocean_id = spotinst_ocean_aks.cluster.*.id[0]

  dynamic "label" {
    for_each = merge(
      data.azurerm_kubernetes_cluster_node_pool.nodepool[count.index].node_labels,
      lookup(var.node_pools_labels, "all", {}),
      lookup(var.node_pools_labels, local.node_pool_names[count.index], {}),
    )

    content {
      key   = label.key
      value = label.value
    }
  }

  dynamic "taint" {
    for_each = flatten(concat(
      data.azurerm_kubernetes_cluster_node_pool.nodepool[count.index].node_taints,
      lookup(var.node_pools_taints, "all", []),
      lookup(var.node_pools_taints, local.node_pool_names[count.index], []),
    ))

    content {
      key    = lookup(taint.value, "key", null)
      value  = lookup(taint.value, "value", null)
      effect = lookup(taint.value, "effect", null)
    }
  }

  dynamic "resource_limits" {
    for_each = data.azurerm_kubernetes_cluster_node_pool.nodepool.*.max_count[count.index] > 0 ? ["resource_limits"] : []

    content {
      max_instance_count = data.azurerm_kubernetes_cluster_node_pool.nodepool.*.max_count[count.index]
    }
  }

  dynamic "autoscale" {
    for_each = length(merge(
      lookup(var.node_pools_headrooms, "all", {}),
      lookup(var.node_pools_headrooms, local.node_pool_names[count.index], {}),
    )) > 0 ? ["autoscale"] : []

    content {
      dynamic "autoscale_headroom" {
        for_each = [
          merge(
            lookup(var.node_pools_headrooms, "all", {}),
            lookup(var.node_pools_headrooms, local.node_pool_names[count.index], {}),
          )
        ]

        content {
          cpu_per_unit    = lookup(autoscale_headroom.value, "cpu_per_unit", null)
          gpu_per_unit    = lookup(autoscale_headroom.value, "gpu_per_unit", null)
          memory_per_unit = lookup(autoscale_headroom.value, "memory_per_unit", null)
          num_of_units    = lookup(autoscale_headroom.value, "num_of_units", null)
        }
      }
    }
  }

  launch_specification {
    os_disk {
      size_gb = data.azurerm_kubernetes_cluster_node_pool.nodepool[count.index].os_disk_size_gb
      type    = var.os_disk_type # see: https://github.com/Azure/AKS/issues/580
    }

    dynamic "tag" {
      for_each = merge(
        data.azurerm_kubernetes_cluster_node_pool.nodepool[count.index].tags,
        lookup(var.node_pools_tags, "all", {}),
        lookup(var.node_pools_tags, local.node_pool_names[count.index], {}),
      )

      content {
        key   = tag.key
        value = tag.value
      }
    }
  }
}

module "ocean-controller" {
  source     = "spotinst/ocean-controller/spotinst"
  version    = "~> 0.28"
  depends_on = [module.aks]

  create_controller     = var.create_ocean
  spotinst_token        = var.spotinst_token
  spotinst_account      = var.spotinst_account
  aks_connector_enabled = var.controller_aks_connector_enabled
  base_url              = var.controller_base_url
  disable_auto_update   = var.controller_disable_auto_update
  enable_csr_approval   = var.controller_enable_csr_approval
  image_pull_policy     = var.controller_image_pull_policy
  image_pull_secrets    = var.controller_image_pull_secrets
  proxy_url             = var.controller_proxy_url
  resources_limits      = var.controller_resources_limits
  resources_requests    = var.controller_resources_requests
  tolerations           = var.controller_tolerations
  cluster_identifier    = local.ocean_controller_cluster_id
  acd_identifier        = local.ocean_acd_identifier
}
