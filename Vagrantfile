# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "geerlingguy/centos7"

  config.vbguest.auto_update = true
  config.ssh.insert_key = false
  
  config.vm.synced_folder "./share", "/share",:mount_options => ["dmode=777","fmode=777"]
  config.vm.synced_folder "./scripts", "/scripts", :mount_options => ["dmode=777","fmode=777"]
  config.vm.synced_folder ".", "/vagrant", disabled: true
  
  config.vm.network "forwarded_port", guest: 3300, host: 3300, auto_correct: true, protocol: "tcp"
  config.vm.network "forwarded_port", guest: 4400, host: 4400, auto_correct: true, protocol: "tcp"
  config.vm.network "forwarded_port", guest: 50000, host: 50000, auto_correct: true, protocol: "tcp"
  config.vm.network "forwarded_port", guest: 9443, host: 9443, auto_correct: true, protocol: "tcp"
  config.vm.network "forwarded_port", guest: 9080, host: 9080, auto_correct: true, protocol: "tcp"
  config.vm.network "forwarded_port", guest: 8080, host: 8080, auto_correct: true, protocol: "tcp"
  config.vm.network "forwarded_port", guest: 56000, host: 56000, auto_correct: true, protocol: "tcp"

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id,
      "--memory", "4096",
      "--cpus","2",
      "--natdnshostresolver1", "on"]
    vb.customize ["modifyvm", :id, "--accelerate3d", "on"]
    vb.customize ["modifyvm", :id, "--vram", "128"]
    vb.customize ["modifyvm", :id, "--graphicscontroller", "vboxvga"]
    vb.customize ["modifyvm", :id, '--clipboard', 'bidirectional'] 
  end

  config.vm.provision :shell, :path => "scripts/setupvbguest.sh"
  config.vm.provision :reload
  config.vm.provision :shell, :path => "scripts/env.sh"
  config.vm.provision :shell, :path => "scripts/dependencies.sh"
  config.vm.provision :shell, :path => "scripts/install-java.sh"
  config.vm.provision :shell, :path => "scripts/install-was.sh"
  config.vm.provision :shell, :path => "scripts/install-db.sh"
  config.vm.provision :shell, :path => "scripts/install-jenkins.sh"
end
