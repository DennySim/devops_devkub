

all:
  vars:
    ansible_connection: ssh
    ansible_user: ubuntu
  hosts:

  %{ for k, node in nodes ~}
  worker-node-${k}:
      ansible_host: ${node}
  %{ endfor ~} 
  master-node: 
      ansible_host: ${master-node}
  children:
    kube_control_plane:
      hosts:
        master-node:
    kube_node:
      hosts:
    %{ for k, node in nodes ~}
    worker-node-${k}:
    %{ endfor ~}
    
    etcd:
      hosts:
        master-node:
    k8s_cluster:
      children:
        kube_control_plane:
        kube_node:
    calico_rr:
      hosts: {}  
    