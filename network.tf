resource "openstack_networking_network_v2" "vpc" {
  name           = var.vpc_name
  admin_state_up = "true"
}

resource "openstack_networking_subnet_v2" "vpc" {
  name       = var.vpc_name
  network_id = openstack_networking_network_v2.vpc.id
  cidr       = "${var.ip-address}${var.ip-subnet}"
  ip_version = 4
  enable_dhcp = "true"
}

data "openstack_networking_network_v2" "ovh-network" {
  network_id = "6011fbc9-4cbf-46a4-8452-6890a340b60b"
}

resource "openstack_networking_secgroup_v2" "inbound" {
  name        = "rancher-web-inbount"
  description = "Inbound rules"
}


resource "openstack_networking_secgroup_rule_v2" "inbound_http" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  remote_ip_prefix  = var.home_ip
  port_range_min    = 80
  port_range_max    = 80
  security_group_id = openstack_networking_secgroup_v2.inbound.id
}

resource "openstack_networking_secgroup_rule_v2" "inbound_ssl" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  remote_ip_prefix  = var.home_ip
  port_range_min    = 443
  port_range_max    = 443
  security_group_id = openstack_networking_secgroup_v2.inbound.id
}

resource "openstack_networking_secgroup_rule_v2" "inbound_ssh" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  remote_ip_prefix  = var.home_ip
  port_range_min    = 22
  port_range_max    = 22
  security_group_id = openstack_networking_secgroup_v2.inbound.id
}

resource "openstack_networking_secgroup_rule_v2" "inbound_8080" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  remote_ip_prefix  = var.home_ip
  port_range_min    = 8080
  port_range_max    = 8080
  security_group_id = openstack_networking_secgroup_v2.inbound.id
}

resource "openstack_networking_secgroup_rule_v2" "icmp" {
  direction         = "ingress"
  ethertype         = "IPv4"
  remote_ip_prefix  = var.home_ip
  protocol          = "icmp"
  security_group_id = openstack_networking_secgroup_v2.inbound.id
}