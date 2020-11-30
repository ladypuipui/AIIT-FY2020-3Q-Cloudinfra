#!/bin/bash
echo "Please enter the name you want to give to the DB name‼"
read DBNAME

curl -sS https://downloads.mariadb.com/MariaDB/mariadb_repo_setup | sudo bash
yum -y install MariaDB-server MariaDB-client MariaDB-devel
systemctl start mariadb
systemctl enable mariadb

yum -y install libguestfs libvirt libvirt-client python-virtinst qemu-kvm virt-top virt-viewer virt-who virt-install bridge-utils
systemctl start libvirtd
systemctl enable libvirtd

mysql -u root -e "CREATE DATABASE $DBNAME DEFAULT CHARACTER SET utf8;"
mysql -u root $DBNAME -e  "CREATE TABLE vmlists (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  vcpu INT UNSIGNED NOT NULL,
  mem INT UNSIGNED NOT NULL,
  disk INT UNSIGNED NOT NULL,
  ip INT UNSIGNED,
  sshkey VARCHAR(255) NOT NULL,
  os VARCHAR(255) NOT NULL,
  created_at DATETIME NOT NULL,
  updated_at DATETIME NOT NULL,
  PRIMARY KEY(id)
);
CREATE TABLE keylists (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  vmname VARCHAR(255),
  pubkey VARCHAR(3000) NOT NULL,
  created_at DATETIME NOT NULL,
  updated_at DATETIME NOT NULL,
  PRIMARY KEY(id)
);
"


cat << EOS >> database.yml
development:
  adapter: mysql2
  database: $DBNAME
  host: localhost
  username: root
  password: 
  encoding: utf8
EOS

touch error.log

bundle install

bundle exec ruby privatecloud.rb
