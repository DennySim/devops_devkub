variable "nodes-count" {
  default = "2"
}

resource "yandex_compute_instance" "worker-node" {
  count=var.nodes-count
  zone                      = "ru-central1-a"
  hostname                  = "worker-node-${count.index}.netology.cloud"
  allow_stopping_for_update = true

  resources {
    cores  = 2
    memory = 2
    core_fraction=100
  }

  boot_disk {
    initialize_params {
      image_id    = "fd89ovh4ticpo40dkbvd"
      name        = "root-worker-node-${count.index}"
      type        = "network-nvme"
      size        = "30"
    }
  }

  network_interface {
    subnet_id = "${yandex_vpc_subnet.default.id}"
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}
