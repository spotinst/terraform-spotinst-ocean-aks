locals {
  ocean_cluster_name = (
    var.aks_cluster_name == null
    ? "${var.prefix}-aks"
    : var.aks_cluster_name
  )

  ocean_cluster_id = (
    var.create_ocean
    ? spotinst_ocean_aks.this[0].id
    : null
  )

  ocean_controller_cluster_id = (
    var.cluster_identifier != null
    ? var.cluster_identifier
    : local.ocean_cluster_name
  )

  ocean_acd_identifier = (
    var.acd_identifier != null
    ? var.acd_identifier
    : local.ocean_cluster_name
  )

  ocean_headroom = (
    var.headroom_cpu_per_unit != null ||
    var.headroom_gpu_per_unit != null ||
    var.headroom_memory_per_unit != null ||
    var.headroom_num_of_units != null
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
}
