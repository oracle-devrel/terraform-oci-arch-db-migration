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
  default     = "1.3"
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

variable "volume_display_name" {
  default = "AppVolume1"
}

variable "volume_size_in_gbs" {
  default = "100"
}

variable "volume_count" {
  default = "1"
}

variable "volume_attachment_type" {
  default = "paravirtualized"
}

variable "autonomous_database_private_endpoint" {
  default = true
}

variable "autonomous_database_cpu_core_count" {
  default = "4"
}

variable "autonomous_database_admin_password" {
}

variable "autonomous_database_db_name" {
  default = "migatp"
}

variable "autonomous_database_display_name" {
  default = "MigratedATP"
}

variable "autonomous_private_endpoint_label" {
  default = "migatppe"
}

variable "autonomous_database_db_version" {
  default = "19c"
}

variable "autonomous_database_is_auto_scaling_enabled" {
  default = "false"
}

variable "autonomous_database_data_storage_size_in_tbs" {
  default = "1"
}

variable "autonomous_database_db_workload" {
  default = "OLTP"
}

variable "autonomous_database_license_model" {
  default = "BRING_YOUR_OWN_LICENSE"
}

variable "autonomous_database_data_safe_status" {
  default = "NOT_REGISTERED"
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

