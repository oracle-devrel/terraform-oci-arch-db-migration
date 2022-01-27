## Copyright © 2021, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

# Get list of availability domains
data "oci_identity_availability_domains" "ADs" {
  compartment_id = var.tenancy_ocid
}

data "oci_identity_region_subscriptions" "home_region_subscriptions" {
  tenancy_id = var.tenancy_ocid

  filter {
    name   = "is_home_region"
    values = [true]
  }
}

data "template_file" "key_script" {
  template = file("./scripts/sshkey.tpl")
  vars = {
    ssh_public_key = tls_private_key.public_private_key_pair.public_key_openssh
  }
}

data "template_cloudinit_config" "cloud_init" {
  gzip          = true
  base64_encode = true

  part {
    filename     = "ainit.sh"
    content_type = "text/x-shellscript"
    content      = data.template_file.key_script.rendered
  }
}

# Get the latest Oracle Linux image
data "oci_core_images" "InstanceImageOCID" {
  compartment_id           = var.compartment_ocid
  operating_system         = var.instance_os
  operating_system_version = var.linux_os_version
  shape                    = var.instance_shape

  filter {
    name   = "display_name"
    values = ["^.*Oracle[^G]*$"]
    regex  = true
  }
}

data "oci_database_gi_versions" "gi_version" {
  compartment_id = var.compartment_ocid
  shape          = var.exacs_infra_shape
}

data "oci_database_db_versions" "exacs_db_versions" {
  compartment_id  = var.compartment_ocid
  db_system_shape = var.exacs_infra_shape
}

data "oci_database_cloud_exadata_infrastructure" "exacs_infrastructure" {
  cloud_exadata_infrastructure_id = oci_database_cloud_exadata_infrastructure.exacs_infra.id
}

data "oci_database_cloud_vm_cluster" "exacs_vm_cluster" {
  cloud_vm_cluster_id = oci_database_cloud_vm_cluster.exacs_vm_cluster.id
}


data "oci_database_db_homes" "exacs_db_homes" {
  depends_on     = [oci_database_cloud_vm_cluster.exacs_vm_cluster]
  compartment_id = var.compartment_ocid
  vm_cluster_id  = oci_database_cloud_vm_cluster.exacs_vm_cluster.id
}

data "oci_database_databases" "exacs_databases" {
  compartment_id = var.compartment_ocid
  db_home_id     = data.oci_database_db_homes.exacs_db_homes.db_homes[0].id
}
