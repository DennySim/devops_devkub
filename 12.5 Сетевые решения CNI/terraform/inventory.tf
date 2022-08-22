resource "null_resource" "wait" {
  provisioner "local-exec" {
    command = "sleep 50"
  }

  depends_on = [
    yandex_compute_instance.worker-node[0]
  ]
}

resource "local_file" "inventory" {

 content = templatefile("${path.module}/inventory.tpl", 
 { 
    nodes-count=var.nodes-count, 
    master-node=yandex_compute_instance.master-node.network_interface.0.nat_ip_address,
    nodes =  {
      for i in range(var.nodes-count): i =>
      yandex_compute_instance.worker-node[i].network_interface.0.nat_ip_address
    }
  }
)
  
  filename = "../inventory/prod/hosts.yml"
  depends_on = [
    null_resource.wait
  ]
}