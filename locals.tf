locals {
  ocean_cluster_id   = element(concat(spotinst_ocean_aks.this.*.id, [""]), 0)
  ocean_cluster_name = "${var.prefix}-aks"

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
}
