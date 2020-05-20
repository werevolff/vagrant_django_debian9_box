# -*- mode: ruby -*-
# vi: set ft=ruby :

##
# This function gets count of the available cpus count
def get_cpus_count()
    host = RbConfig::CONFIG['host_os']
    if host =~ /darwin/
        cpus = `sysctl -n hw.ncpu`.to_i
    elsif host =~ /linux/
        cpus = `nproc`.to_i
    else
        cpus = `wmic cpu get NumberOfCores`.split("\n")[2].to_i
    end
    return cpus
end

##
# This function gets size of the RAM
def get_memory_size(divider)
    host = RbConfig::CONFIG['host_os']
    if host =~ /darwin/
        # sysctl returns Bytes and we need to convert to MB
        mem = `sysctl -n hw.memsize`.to_i / 1024 / 1024 / divider
    elsif host =~ /linux/
        cpus = `nproc`.to_i
        mem = `grep 'MemTotal' /proc/meminfo | sed -e 's/MemTotal://' -e 's/ kB//'`.to_i / 1024 / divider
    else
        cpus = `wmic cpu get NumberOfCores`.split("\n")[2].to_i
        mem = `wmic OS get TotalVisibleMemorySize`.split("\n")[2].to_i / 1024 / divider
    end
    return mem
end

Vagrant.configure(2) do |config|
    config.vm.synced_folder ".", "/vagrant", owner: "vagrant"
    config.vagrant.plugins = ["vagrant-vbguest"]
    config.vm.provider "virtualbox" do |vb|
        # Don't boot with headless mode
        # vb.gui = true
        vb.memory = 2048
        vb.cpus = 2
        vb.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/vagrant", "1"]
    end

    config.vm.define "django_debian9", primary: true, autorestart: false do |django_debian9|
        django_debian9.vm.box = "generic/debian9"
        django_debian9.vm.network "private_network", ip: "192.168.99.100"
        django_debian9.vm.network "forwarded_port", guest: 22, host: 2222, id: "ssh"

        django_debian9.vm.provision "django_debian9", type: "shell" do |shell|
            shell.path = "provision/install_ansible.sh"
            shell.privileged = false
            shell.keep_color = true
        end

        django_debian9.vm.provision "ansible_local" do |ansible|
            ansible.inventory_path      = "./provision/hosts"
            ansible.limit               = "local"
            ansible.playbook            = "provision/vagrant.yml"
            ansible.verbose             = 'vvvv'
            ansible.config_file         = 'ansible.cfg'
        end

        django_debian9.vm.box_check_update = true
    end
end