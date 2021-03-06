## Copyright (c) 2022, Oracle and/or its affiliates.
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

# Get list of availability domains
data "oci_identity_availability_domains" "ADs" {
  compartment_id = var.tenancy_ocid
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

# Get DB node list
data "oci_database_db_nodes" "db_nodes1" {
  compartment_id = var.compartment_ocid
  db_system_id   = oci_database_db_system.test_db_system1.id
}

## Get DB node details
data "oci_database_db_node" "db_node_details1" {
  db_node_id = data.oci_database_db_nodes.db_nodes1.db_nodes[0]["id"]
}


# Gets the OCID of the first (default) vNIC
data "oci_core_vnic" "db_node_vnic1" {
  vnic_id = data.oci_database_db_node.db_node_details1.vnic_id
}


data "oci_database_db_homes" "db_homes1" {
  compartment_id = var.compartment_ocid
  db_system_id   = oci_database_db_system.test_db_system1.id
}


data "oci_database_databases" "databases1" {
  compartment_id = var.compartment_ocid
  db_home_id     = data.oci_database_db_homes.db_homes1.db_homes[0].db_home_id
}


data "oci_database_db_system_patches" "patches1" {
  db_system_id = oci_database_db_system.test_db_system1.id
}

data "oci_database_db_system_patch_history_entries" "patches_history1" {
  db_system_id = oci_database_db_system.test_db_system1.id
}


data "oci_database_db_home_patches" "patches1" {
  db_home_id = data.oci_database_db_homes.db_homes1.db_homes[0].db_home_id
}


data "oci_database_db_home_patch_history_entries" "patches_history1" {
  db_home_id = data.oci_database_db_homes.db_homes1.db_homes[0].db_home_id
}


data "oci_database_db_versions" "test_db_versions_by_db_system_id1" {
  compartment_id = var.compartment_ocid
  db_system_id   = oci_database_db_system.test_db_system1.id
}


data "oci_database_db_system_shapes" "test_db_system_shapes1" {
  availability_domain = var.availability_domain_name == "" ? data.oci_identity_availability_domains.ADs.availability_domains[var.availability_domain_number]["name"] : var.availability_domain_name
  compartment_id      = var.compartment_ocid

  filter {
    name   = "shape"
    values = [var.db_system_shape]
  }
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
