terraform {
  required_providers {
    vsphere = {
      source = "hashicorp/vsphere"
      version = "1.24.3"
    }
  }
}

provider "vsphere" {
  user           = var.vsphere_user
  password       = var.vsphere_password
  vsphere_server = var.vsphere_server

  # if you have a self-signed cert
  allow_unverified_ssl = true
}


data "vsphere_datacenter" "dc" {
  name = var.vsphere_datacenter
}

data "vsphere_datastore" "datastore" {
  name          = var.vsphere_datastore
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_resource_pool" "pool" {
  name          = var.vsphere_resource_pool
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
  name          = var.vsphere_vm_portgroup
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "template" {
  name          = var.vsphere_vm_template
  datacenter_id = data.vsphere_datacenter.dc.id
}


resource "vsphere_virtual_machine" "vm" {
  name             = var.vsphere_vm_name
  resource_pool_id = data.vsphere_resource_pool.pool.id
  datastore_id     = data.vsphere_datastore.datastore.id

  num_cpus = var.vsphere_vm_cpu #2
  memory   = var.vsphere_vm_memory #1024
  guest_id = var.vsphere_vm_guest #"other3xLinux64Guest"

  network_interface {
    network_id = data.vsphere_network.network.id
  }

  disk {
    label = "disk0"
    size  = var.vsphere_vm_disksize #20
    eagerly_scrub = false
    thin_provisioned = true
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id
    linked_clone  = var.linked_clone
    timeout       = var.timeout

  }


}


/*
#No more VM module because they want to customize, and I don't want that
module "vm" {
  source  = "Terraform-VMWare-Modules/vm/vsphere"
  version = "2.1.0"
  vmtemp        = var.vsphere_vm_template
  instances     = 1
  vmname        = var.vsphere_vm_name
  vmrp          = var.vsphere_resource_pool
  network = {
    "${var.vsphere_vm_portgroup}"  = ["", ""] # To use DHCP create Empty list ["",""]
  }
  dc        = var.vsphere_datacenter
  datastore = var.vsphere_datastore
}
*/
