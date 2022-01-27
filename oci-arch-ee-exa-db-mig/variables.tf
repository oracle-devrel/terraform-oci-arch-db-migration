## Copyright © 2021, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

# Variables
variable "tenancy_ocid" {}
variable "compartment_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}
variable "region" {}

variable "availability_domain_name" {
  default = ""
}
variable "availability_domain_number" {
  default = 0
}

variable "release" {
  description = "Reference Architecture Release (OCI Architecture Center)"
  default     = "1.3.2"
}

# OS Images
variable "instance_os" {
  description = "Operating system for compute instances"
  default     = "Oracle Linux"
}

variable "linux_os_version" {
  description = "Operating system version for all Linux instances"
  default     = "8"
}

variable "instance_shape" {
  default = "VM.Standard.E3.Flex"
}

variable "instance_shape_flex_ocpus" {
  default = 1
}

variable "instance_shape_flex_memory" {
  default = 10
}

variable "ssh_public_key" {
  default = ""
}

variable "use_bastion_service" {
  default = true
}

# ExaCS Infra

variable "exacs_x8_infra" {
  default = true
}

variable "exacs_infra_shape" {
  default = "Exadata.Quarter2.92"
}

variable "exacs_infra_display_name" {
  default = "exacs-infra"
}

variable "exacs_infra_compute_count" {
  default = 2
}

variable "exacs_infra_storage_count" {
  default = 3
}

variable "exacs_infra_maintenance_window_weeks_of_month" {
  default = 2 # to allow maintenance during the 2nd week of the month (from the 8th day to the 14th day of the month)
}

# ExaCS VM Cluster

variable "exacs_vm_cluster_cpu_core_count" {
  default = 4
}

variable "exacs_vm_cluster_ocpu_count" {
  default = 4.0
}

variable "exacs_vm_cluster_name" {
  default = "exacscls"
}

variable "exacs_vm_cluster_data_storage_percentage" {
  default = 80
}

variable "exacs_vm_cluster_display_name" {
  default = "exacs_cluster"
}

variable "exacs_vm_cluster_gi_version" {
  default = "19.0.0.0"
  #  default = "19.13.0.0.0"
}

variable "exacs_vm_cluster_hostname" {
  default = "exacs-q292"
}

variable "exacs_vm_cluster_license_model" {
  default = "LICENSE_INCLUDED"
}

# ExaCS Starter Database

variable "starter_db_admin_password" {
}

variable "starter_db_name" {
  default = "exadb1"
}

variable "starter_db_version" {
  default = "19.0.0.0"
}

variable "starter_db_n_character_set" {
  default = "AL16UTF16"
}

variable "starter_db_character_set" {
  default = "AL32UTF8"
}

variable "starter_db_workload" {
  default = "OLTP"
}

variable "starter_db_pdb_name" {
  default = "pdb1"
}

variable "starter_db_auto_backup_enabled" {
  default = "true"
}

variable "starter_db_auto_backup_window" {
  default = "SLOT_TWO"
}

variable "starter_db_recovery_window_in_days" {
  default = "45"
}

# Dictionary Locals
locals {
  compute_flexible_shapes = [
    "VM.Standard.E3.Flex",
    "VM.Standard.E4.Flex"
  ]
}

# Checks if is using Flexible Compute Shapes
locals {
  is_flexible_node_shape = contains(local.compute_flexible_shapes, var.instance_shape)
}
