## Copyright © 2021, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

output "generated_ssh_private_key" {
  value     = tls_private_key.public_private_key_pair.private_key_pem
  sensitive = true
}

output "bastion_ssh_metadata" {
  value = oci_bastion_session.ssh_via_bastion_service.*.ssh_metadata
}


#output "exacs_db_versions" {
#  value = data.oci_database_db_versions.exacs_db_versions
#}

output "exacs_infrastructure" {
  value = data.oci_database_cloud_exadata_infrastructure.exacs_infrastructure
}

output "exacs_vm_cluster" {
  value = data.oci_database_cloud_vm_cluster.exacs_vm_cluster
}

output "exacs_db_homes" {
  value = data.oci_database_db_homes.exacs_db_homes
}

output "exacs_databases" {
  value = data.oci_database_databases.exacs_databases
}
