# Vagrantfile
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu:20.04"  # Base box with Docker support

  config.vm.hostname = "yolo-app"

  # Use Docker as the provider
  config.vm.provider "docker" do |d|
    d.image = "ubuntu:20.04"  # You could use ubuntu:20.04 too
    d.remains_running = true
    d.name = "yolo-app-container"
  end

  # Port forwarding (Docker maps host:container)
  config.vm.network "forwarded_port", guest: 3000, host: 3000
  config.vm.network "forwarded_port", guest: 27017, host: 27017
  config.vm.network "forwarded_port", guest: 22, host: 2222

  # Shared folder (optional)
  config.vm.synced_folder ".", "/vagrant"


  # Provision with Ansible (must be installed on host)
  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "playbook.yml"
    ansible.inventory_path = "inventory.ini"
    ansible.limit = "all"
    ansible.compatibility_mode = "2.0"
  end
end
