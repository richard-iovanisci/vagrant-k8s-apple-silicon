IMAGE_NAME = "bento/ubuntu-20.04-arm64"
#IMAGE_VERSION = "202112.19.0"
N = 2

Vagrant.configure("2") do |config|
    config.ssh.insert_key = false

    config.vm.provider "parallels" do |v|
        v.memory = 4096
        v.cpus = 2
    end
      
    config.vm.define "k8s-master" do |master|
        master.vm.box = IMAGE_NAME
        #master.vm.box_version = IMAGE_VERSION
        master.vm.network "private_network", ip: "192.168.70.10"
        master.vm.hostname = "k8s-master"
        master.vm.provision "ansible" do |ansible|
            ansible.playbook = "kubernetes-setup/master-playbook.yml"
            ansible.extra_vars = {
                node_ip: "192.168.70.10",
            }
        end
    end

    (1..N).each do |i|
        config.vm.define "node-#{i}" do |node|
            node.vm.box = IMAGE_NAME
            #node.vm.box_version = IMAGE_VERSION
            node.vm.network "private_network", ip: "192.168.70.#{i + 10}"
            node.vm.hostname = "node-#{i}"
            node.vm.provision "ansible" do |ansible|
                ansible.playbook = "kubernetes-setup/node-playbook.yml"
                ansible.extra_vars = {
                    node_ip: "192.168.70.#{i + 10}",
                }
            end
        end
    end
end