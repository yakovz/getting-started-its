variable "vsphere_user" {
  type = string
  description = "the username for vsphere"
}
variable "vsphere_password" {
  type = string
  description = "The password for vsphere"
}
variable "vsphere_server" {
  type = string
  description = "the hostname or ip address of your vcenter server"
}

variable "vsphere_datacenter" {
  type = string
  description = "the name of the datacenter"
}

variable "vsphere_datastore" {
  type = string
  description = "the name of the datastore"
}

variable "vsphere_vm_template" {
  type = string
  description = "the name of the vm template"
}

variable "vsphere_vm_name" {
  type = string
  description = "the name of the vm"
}

variable "vsphere_resource_pool" {
  type = string
  description = "the name of the resourcepool"
}

variable "vsphere_vm_portgroup" {
  type = string
  description = "the name of the portgroup"
}

variable "vsphere_vm_gateway" {
  type = string
  description = "the ip address of they gateway"
}

variable "vsphere_vm_cpu" {
  type = int
  description = "the number of vCpus"
}

variable "vsphere_vm_memory" {
  type = int
  description = "the amount of memory in MB"
}

variable "vsphere_vm_guest" {
  type = string
  description = "the name of the os type "
}

variable "vsphere_vm_disksize" {
  type = int
  description = "the size of the disk in GB"
}