resource "yandex_compute_instance" "master-node" {
  zone                      = "ru-central1-a"
  hostname                  = "master-node.netology.cloud"
  allow_stopping_for_update = true

  resources {
    cores  = 4
    memory = 4
    core_fraction=100
  }

  boot_disk {
    initialize_params {
      image_id    = "fd89ovh4ticpo40dkbvd"
      name        = "root-master-node"
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
