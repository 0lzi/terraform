resource "openstack_compute_keypair_v2" "resource_name" {
  name = "resource_name"
}

resource "openstack_networking_secgroup_v2" "resource_sec_group" {
  name        = "resource_sec_group"
  description = "resource_sec_group description"
}

resource "openstack_networking_secgroup_rule_v2" "resource_sec_group_rule_1" {
  direction         = "ingress"
  ethertype         = "IPv4"
  security_group_id = openstack_networking_secgroup_v2.resource_sec_group.id
}

resource "openstack_compute_instance_v2" "resource_name" {
  name            = "resource_name"
  flavor_name     = "n1.medium"
  key_pair        = "resource_name"
  security_groups = ["default", "resource_sec_group"]

  block_device {
    uuid                  = ""
    source_type           = "image"
    destination_type      = "volume"
    volume_size           = 8
    boot_index            = 0
    delete_on_termination = true
  }

  network {
    uuid = ""
  }

  network {
    uuid = ""
  }
}
