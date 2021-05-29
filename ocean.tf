resource "spotinst_ocean_aks" "this" {
  count      = var.create_ocean ? 1 : 0
  depends_on = [module.ocean-controller]

  name                    = local.ocean_cluster_name
  controller_cluster_id   = local.ocean_controller_cluster_id
  acd_identifier          = local.ocean_acd_identifier
  aks_name                = local.ocean_cluster_name
  ssh_public_key          = local.public_ssh_key
  user_name               = local.username
  aks_resource_group_name = var.resource_group_name
}

resource "spotinst_ocean_aks_virtual_node_group" "this" {
  count = var.create_ocean ? 1 : 0

  name     = var.agents_pool_name
  ocean_id = spotinst_ocean_aks.this[count.index].id

  dynamic "label" {
    for_each = var.agents_labels

    content {
      key   = label.key
      value = label.value
    }
  }

  dynamic "taint" {
    for_each = var.agents_taints

    content {
      key    = lookup(taint.value, "key", null)
      value  = lookup(taint.value, "value", null)
      effect = lookup(taint.value, "effect", null)
    }
  }

  dynamic "resource_limits" {
    for_each = var.agents_max_count != null ? ["resource_limits"] : []

    content {
      max_instance_count = var.agents_max_count
    }
  }

  dynamic "autoscale" {
    for_each = local.ocean_headroom ? ["autoscale"] : []

    content {
      dynamic "autoscale_headroom" {
        for_each = local.ocean_headroom ? ["autoscale_headroom"] : []

        content {
          cpu_per_unit    = var.headroom_cpu_per_unit
          gpu_per_unit    = var.headroom_gpu_per_unit
          memory_per_unit = var.headroom_memory_per_unit
          num_of_units    = var.headroom_num_of_units
        }
      }
    }
  }

  launch_specification {
    os_disk {
      size_gb = var.os_disk_size_gb
      type    = var.os_disk_type
    }

    dynamic "tag" {
      for_each = var.agents_tags

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
