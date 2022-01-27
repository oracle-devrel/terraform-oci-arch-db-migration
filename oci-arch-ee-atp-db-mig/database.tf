## Copyright (c) 2022, Oracle and/or its affiliates.
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

module "oci-adb" {
  source                                = "github.com/oracle-devrel/terraform-oci-arch-adb"
  adb_password                          = var.autonomous_database_admin_password
  compartment_ocid                      = var.compartment_ocid
  adb_database_cpu_core_count           = var.autonomous_database_cpu_core_count
  adb_database_data_storage_size_in_tbs = var.autonomous_database_data_storage_size_in_tbs
  adb_database_db_name                  = var.autonomous_database_db_name
  adb_database_db_version               = var.autonomous_database_db_version
  adb_database_display_name             = var.autonomous_database_display_name
  adb_database_license_model            = var.autonomous_database_license_model
  adb_database_db_workload              = var.autonomous_database_db_workload
  use_existing_vcn                      = var.autonomous_database_private_endpoint
  adb_private_endpoint                  = var.autonomous_database_private_endpoint
  vcn_id                                = var.autonomous_database_private_endpoint ? oci_core_virtual_network.vcn.id : null
  adb_nsg_id                            = var.autonomous_database_private_endpoint ? oci_core_network_security_group.dbnsg.id : null
  adb_private_endpoint_label            = var.autonomous_database_private_endpoint ? var.autonomous_private_endpoint_label : null
  adb_subnet_id                         = var.autonomous_database_private_endpoint ? oci_core_subnet.subnet_2.id : null
  adb_data_safe_status                  = var.autonomous_database_data_safe_status
  is_auto_scaling_enabled               = var.autonomous_database_is_auto_scaling_enabled
  defined_tags                          = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}


