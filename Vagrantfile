# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
	config.vm.box = "ubuntu/trusty64"
	config.vm.box_check_update = false
	config.vm.provision "fix-no-tty", type: "shell" do |s|
		s.privileged = false
		s.inline = "sudo sed -i '/tty/!s/mesg n/tty -s \\&\\& mesg n/' /root/.profile"
	end
	config.vm.provision :shell, path: "shell/provision.sh"
	config.vm.provision :shell, run: "always", path: "shell/start.sh"

	# Begin skeleton
	config.vm.define "skeleton" do |skeleton|
			skeleton.vm.hostname = "skeleton"

			skeleton.vm.provider "vmware_fusion" do |v|
					v.vmx["numvcpus"] = "1"
					v.vmx["memsize"] = "4048"
					v.name = "skeleton.local"
			end

			skeleton.vm.provider "virtualbox" do |v|
					v.customize [ "modifyvm", :id, "--cpus", "1" ]
					v.customize [ "modifyvm", :id, "--memory", "4048" ]
					v.name = "skeleton.local"
			end

			skeleton.vm.network "private_network", ip: "192.168.205.86"
			skeleton.vm.network "forwarded_port", guest: 22, host: 22128
			skeleton.vm.network "forwarded_port", guest: 80, host: 8086
			skeleton.vm.network "forwarded_port", guest: 8090, host: 8090
			skeleton.vm.network "forwarded_port", guest: 9292, host: 9292

			skeleton.vm.synced_folder ".", "/vagrant", owner: "root", group: "root"
			skeleton.vm.synced_folder ".", "/srv/www/skeleton.local", owner: "www-data", group: "www-data"

	end
	# End skeleton
end
