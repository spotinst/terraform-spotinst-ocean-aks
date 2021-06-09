resource_group_name = "ocean-westus-dev"
aks_cluster_name    = "ocean-westus-dev-aks"

node_pools = [
  {
    name = "nodepool", // default system node pool
  },
  {
    name = "userpool",
  },
]

node_pools_labels = {
  all = {
    allpools = true
  }
  nodepool = {
    nodepool = true
  }
  userpool = {
    userpool = true
  }
}

node_pools_taints = {
  all = [
    {
      key    = "allpools"
      value  = true
      effect = "PreferNoSchedule"
    },
  ]
  nodepool = [
    {
      key    = "nodepool"
      value  = true
      effect = "PreferNoSchedule"
    },
  ]
  userpool = [
    {
      key    = "userpool"
      value  = true
      effect = "PreferNoSchedule"
    },
  ]
}

node_pools_tags = {
  all = {
    allpools = "example"
  }
  nodepool = {
    nodepool = "example"
  }
  userpool = {
    userpool = "example"
  }
}

node_pools_headrooms = {
  all = {
    cpu_per_unit    = 4
    gpu_per_unit    = 1
    memory_per_unit = 8
  }
  nodepool = {
    num_of_units = 1
  }
  userpool = {
    num_of_units = 2
  }
}
