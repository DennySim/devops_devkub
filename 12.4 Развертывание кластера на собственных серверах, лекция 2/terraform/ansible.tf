resource "null_resource" "wait30" {
  provisioner "local-exec" {
    command = "sleep 30"
  }

  depends_on = [
    local_file.inventory
  ]
}

resource "null_resource" "cluster" {
  provisioner "local-exec" {
    command = "ANSIBLE_FORCE_COLOR=1 ansible-playbook -i ../inventory/prod/hosts.yml --become --become-user=root /opt/kubespray/cluster.yml"
  }

  depends_on = [
    null_resource.wait30
  ]
}
