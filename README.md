# AIIT-FY2020-3Q-Cloudinfra

AIIT 2020年度3Q開講科目クラウドインフラ構築特論の成果物です。

## 開発環境
```
# cat /etc/redhat-release 
CentOS Linux release 7.8.2003 (Core)

# uname -r
3.10.0-1127.19.1.el7.x86_64

# ruby -v
ruby 2.5.8p224 (2020-03-31 revision 67882) [x86_64-linux]

# libvirtd -V
libvirtd (libvirt) 4.5.0

# virsh -v
4.5.0

# virt-install --version
1.5.0
```
## 使い方
【初回】
1. ruby2.5やBundleをインストールする
1. ```setup.sh```を実行する

【2回目以降】
1.```bundle exec ruby privatecloud.rb```を実行する

## 接続方法
localhost:4567で起動するので、ブラウザアクセスはポートフォワード推奨
