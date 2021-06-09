locals {
  aks_cluster_name = (
    var.aks_cluster_name == null
    ? "${var.prefix}-aks"
    : var.aks_cluster_name
  )

  ocean_cluster_id = (
    var.create_ocean
    ? spotinst_ocean_aks.cluster[0].id
    : null
  )

  ocean_controller_cluster_id = (
    var.cluster_identifier != null
    ? var.cluster_identifier
    : local.aks_cluster_name
  )

  ocean_acd_identifier = (
    var.acd_identifier != null
    ? var.acd_identifier
    : local.aks_cluster_name
  )

  public_ssh_key = (replace(
    var.public_ssh_key == ""
    ? module.ssh.public_ssh_key
    : var.public_ssh_key, "\n", "")
  )

  username = (
    var.create_aks
    ? (
      length(module.aks[0].admin_username) > 0
      ? module.aks[0].admin_username
      : module.aks[0].username
    ) : var.admin_username
  )

  agents_labels = merge(
    lookup(var.node_pools_labels, "all", {}),
    lookup(var.node_pools_labels, var.agents_pool_name, {}),
  )

  agents_tags = merge(
    lookup(var.node_pools_tags, "all", {}),
    lookup(var.node_pools_tags, var.agents_pool_name, {}),
  )

  node_pool_names = (
    [for np in toset(var.node_pools) : np.name]
  )

  node_pools = zipmap(
    local.node_pool_names,
    tolist(toset(var.node_pools))
  )
}
