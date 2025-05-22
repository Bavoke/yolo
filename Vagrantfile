# Vagrantfile
Vagrant.configure("2") do |config|
  config.vm.box = "geerlingguy/ubuntu2004"
  config.vm.hostname = "yolo-app"
  config.vm.network "forwarded_port", guest: 3000, host: 3000
  config.vm.network "forwarded_port", guest: 27017, host: 27017
  config.vm.network "forwarded_port", guest: 22, host: 2222

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
    vb.cpus = 2
  end

  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "playbook.yml"
    ansible.inventory_path = "inventory.ini"
    ansible.limit = "all"
    ansible.compatibility_mode = "2.0"
  end
end"