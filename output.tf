output "public-ip" {
  value = openstack_compute_instance_v2.rancher-web.access_ip_v4
}