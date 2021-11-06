terraform {
  required_version = ">=0.14.5"

  required_providers {
    intersight = {
      source  = "CiscoDevNet/intersight"
      version = "=1.0.17"
    }
  }
}

provider "intersight" {
  apikey    = var.apikey
  secretkey = var.secretkey
  endpoint  = "https://www.intersight.com"
}

module "terraform-intersight-iks" {

  source = "terraform-cisco-modules/iks/intersight//"


  ip_pool = {
    use_existing        = false
    name                = "tfc_ippool"
    ip_starting_address = "100.0.0.170"
    ip_pool_size        = "20"
    ip_netmask          = "255.255.255.0"
    ip_gateway          = "100.0.0.1"
    dns_servers         = ["100.0.0.100"]
  }

  sysconfig = {
    use_existing = false
    name         = "tfc_Node_OS"
    domain_name  = "ldmkor.local"
    timezone     = "America/New_York"
    ntp_servers  = ["100.0.0.100"]
    dns_servers  = ["100.0.0.100"]
  }

  k8s_network = {
    use_existing = false
    name         = "tfc-CIDR"

    ######### Below are the default settings.  Change if needed. #########
    pod_cidr     = "100.67.0.0/16"
    service_cidr = "100.66.0.0/24"
    cni          = "Calico"
  }
  # Version policy
  version_policy = {
    use_existing = false
    name         = "1.19.5"
    version      = "1.19.5"
  }

   tr_policy = {
     use_existing = false
     create_new   = false
     # name         = "triggermesh-trusted-registry"
   }
  
   runtime_policy = {
     use_existing = false
     create_new   = false
    # name                 = "runtime"
    # http_proxy_hostname  = "t"
    # http_proxy_port      = 80
    # http_proxy_protocol  = "http"
    # http_proxy_username  = null
    # http_proxy_password  = null
    # https_proxy_hostname = "t"
    # https_proxy_port     = 8080
    # https_proxy_protocol = "https"
    # https_proxy_username = null
    # https_proxy_password = null
  }

  # Infra Config Policy Information
  infra_config_policy = {
    use_existing     = false
    name             = "tfc-vcenter"
    vc_target_name   = "100.0.0.101"
    vc_portgroups    = ["VM Network"]
    vc_datastore     = "datastore2"
    vc_cluster       = "ldmkorCluster"
    vc_resource_pool = ""
    vc_password      = var.vc_password
  }

#  addons_list = [{
#    addon_policy_name = "dashboard"
#    addon             = "kubernetes-dashboard"
#    description       = "K8s Dashboard Policy"
#    upgrade_strategy  = "AlwaysReinstall"
#    install_strategy  = "InstallOnly"
#    },
#    {
#      addon_policy_name = "monitor"
#      addon             = "ccp-monitor"
#      description       = "Grafana Policy"
#      upgrade_strategy  = "AlwaysReinstall"
#      install_strategy  = "InstallOnly"
#    }
#  ]
  instance_type = {
    use_existing = false
    name         = "tfc-small"
    cpu          = 4
    memory       = 8192
    disk_size    = 40
  }
  # Cluster information
  cluster = {
    name                = "tfc-iks-cluster"
    action              = "Delete"
    wait_for_completion = false
    worker_nodes        = 1
    load_balancers      = 1
    worker_max          = 1
    control_nodes       = 1
    ssh_user            = var.ssh_user 
    ssh_public_key      = var.ssh_key
  }
  # Organization and Tag
  organization = var.organization

}
  
