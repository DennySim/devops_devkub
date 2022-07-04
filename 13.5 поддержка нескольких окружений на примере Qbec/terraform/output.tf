output "internal_ip_address_master_node" {
  value = "${yandex_compute_instance.master-node.network_interface.0.ip_address}"
}

output "external_ip_address_yandex_cloud_master_node" {
  value = "${yandex_compute_instance.master-node.network_interface.0.nat_ip_address}"
}