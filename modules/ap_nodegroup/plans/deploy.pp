plan ap_nodegroup::deploy (
  TargetSpec        $targets,
  String            $primary_host,
  Optional[Boolean] $noop = false
){

  # Apply options with noop conditionality
  $apply_options = {
    'noop' => $noop,
  }

  apply($targets, $apply_options) {
    class { 'peadm::setup::node_manager_yaml':
      primary_host => $primary_host,
    }

    resources { 'custom_node_group':
      purge   => true,
      require => Class['peadm::setup::node_manager_yaml'],
    }

    create_resources(custom_node_group, lookup('custom_node_group', { merge => deep }))
  }
}
