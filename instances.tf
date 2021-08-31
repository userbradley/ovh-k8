resource "openstack_compute_instance_v2" "rancher-web" {
  name        = "rancher-web"
  image_id    = "6f74bc7d-66ad-4540-8da0-15a0c648746c"
  key_pair    = openstack_compute_keypair_v2.laptop.name
  flavor_name = "s1-2"
  security_groups = [openstack_networking_secgroup_v2.inbound.id]
  network {
    name = data.openstack_networking_network_v2.ovh-network.name
  }
  }

resource "openstack_compute_keypair_v2" "laptop" {
  name       = "personal-laptop"
  public_key = file("/home/stannardb/.ssh/id_rsa.pub")
}



