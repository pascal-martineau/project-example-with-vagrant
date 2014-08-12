# -*- mode: ruby -*-
# vi: set ft=ruby :


Vagrant.configure("2") do |config|

    #
    # Web application server configuration
    #
    config.vm.define "webapp" do |webapp|

        webapp.vm.box = "vbox4.3-debian7"
        webapp.vm.box_url = "file:///Volumes/media/Boxes/vbox4.3-debian7.box"

        webapp.vm.provider :virtualbox do |v|
            v.name = "PROJECT_NAME"
            v.memory = 1024
        end

        webapp.vm.network "private_network", ip: "192.168.50.22"

        webapp.vm.network :forwarded_port, guest: 22, host: 2222, id: "ssh", auto_correct: false
        webapp.vm.network :forwarded_port, guest: 80, host: 8080 #http-apache
        webapp.vm.network :forwarded_port, guest: 81, host: 8081 #http-nginx
        webapp.vm.network :forwarded_port, guest: 3306, host: 33066 #mysql
        webapp.vm.network :forwarded_port, guest: 9000, host: 9090 #xdebug
        webapp.vm.network :forwarded_port, guest: 8025, host: 8025 #mailcatcher

        webapp.vm.provision :shell, :path => "webapp-server/conf/shell/install.sh"
        webapp.vm.synced_folder "./webapp-server/src/", "/home/vagrant/src" #web-data

    end

end


