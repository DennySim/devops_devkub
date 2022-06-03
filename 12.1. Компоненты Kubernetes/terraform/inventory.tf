resource "local_file" "inventory" {
  content = <<-DOC
    # Ansible inventory containing variable values from Terraform.
    # Generated by Terraform.
    all:
      vars:
        ansible_connection: ssh
        ansible_user: ubuntu
    nodes:
      hosts:
        node01.netology.yc: 
          ansible_host: ${yandex_compute_instance.node01.network_interface.0.nat_ip_address}
     
    DOC
    
  filename = "../inventory/prod/hosts.yml"

  depends_on = [
    yandex_compute_instance.node01
  ]
}