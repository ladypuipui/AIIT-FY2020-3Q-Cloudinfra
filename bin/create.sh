#!/bin/bash

MSG=`bin/resourcecheck.sh`
. ./env.config 

if [ $MSG = 1 ]; then
 echo "OK"

 else
 echo "create instance faild" >> error.log
 exit1 

fi

mkdir  ./resource/$NAME
chmod 2777 ./resource/$NAME
#cp ./config/keypair.tf ./resource/$NAME
cd ./resource/$NAME
#
#
#/usr/local/bin/terraform init && /usr/local/bin/terraform plan
#/usr/local/bin/terraform apply -auto-approve
KEYNAME=`cat ../key/$KEY/$KEY.pub`


cat <<EOS> $NAME.ks.cfg
#version=RHEL7

install
cdrom
text
cmdline
skipx

lang ja_JP.UTF-8
keyboard --vckeymap=jp106 --xlayouts=jp
timezone Asia/Tokyo --isUtc --nontp

network --activate --bootproto=dhcp --noipv6
network  --hostname=$NAME

zerombr
bootloader --append=" crashkernel=auto" --location=mbr --boot-drive=vda
clearpart --all --initlabel --drives=vda
part / --fstype=xfs --grow --size=1 --asprimary --label=root

auth --enableshadow --passalgo=sha512
user --name=puipui --groups="wheel"
sshkey --username=puipui "$KEYNAME"
rootpw --plaintext "puipui"

selinux --disabled
firewall --disabled
firstboot --disabled

reboot

%post
/usr/bin/yum -y install sudo
echo "puipui        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers.d/puipui
chmod 0440 /etc/sudoers.d/puipui
sed -i.bak "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers
echo "UseDNS no" >> /etc/ssh/sshd_config
systemctl restart sshd

%end

EOS

if [ $OS = CentOS7 ]; then
 variant=centos7.0

 else
 variant=ubuntu18.04
fi


/usr/bin/virt-install\
 --name $NAME\
 --hvm\
 --virt-type kvm\
 --ram $MEM\
 --vcpus $VCPU\
 --arch x86_64\
 --os-type linux\
 --os-variant $variant\
 --boot hd\
 --disk path=$NAME.img,size=$DISK,device=disk,bus=virtio,format=raw \
 --network bridge=br0\
 --graphics none\
 --serial pty\
 --console pty\
 --location ../../iso/$OS.iso\
 --initrd-inject $NAME.ks.cfg\
 --extra-args "inst.ks=file:$NAME.ks.cfg console=ttyS0"
