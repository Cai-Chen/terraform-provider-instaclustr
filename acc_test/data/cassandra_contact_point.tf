provider "instaclustr" {
  username = "%s"
  api_key = "%s"
  api_hostname = "%s"
}
resource "instaclustr_cluster" "cassandra_contact_point" {
  cluster_name = "cassandra_contact_point"
  node_size = "t3.small-v2"
  data_centre = "US_WEST_2"
  sla_tier = "NON_PRODUCTION"
  cluster_network = "192.168.0.0/18"
  private_network_cluster = false
  pci_compliant_cluster = false
  wait_for_state = "RUNNING"
  cluster_provider = {
    name = "AWS_VPC"
  }
  rack_allocation = {
    number_of_racks = 3
    nodes_per_rack = 1
  }

  bundle {
    bundle = "APACHE_CASSANDRA"
    version = "apache-cassandra-3.11.8.ic2"
    options = {
      auth_n_authz = true
      use_private_broadcast_rpc_address = false
      client_encryption = false
      lucene_enabled = false
      continuous_backup_enabled = true
    }
  }
  bundle {
    bundle = "SPARK"
    version = "apache-spark:2.3.2.ic1"
  }

}
