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



## 操作方法
### キーペア
#### コマンドで作成 
```curl -X POST http://localhost:4567/keycreate/{$name}```
#### コマンドで削除
```curl -X DELETE http://localhost:4567/keydelete/{$name}```

#### ブラウザから作成 
```http://localhost:4567/keycreate/{$name}```
#### ブラウザから削除
```http://localhost:4567/keydelete/{$name}```


### VM作成
#### コマンドで作成 
```curl -X POST -F "name={$name}" -F "key={$keyname}" -F "vcpu=1" -F "mem=1024" -F "disk=10" -F "os=CentOS7" http://localhost:4567/create/confirm```

#### ブラウザから作成 
```http://localhost:4567/create/```　へアクセスしフォームに必要な情報を入力する


### VM操作
#### コマンドで起動
```curl -X GET  http://localhost:4567/start/{$name}```
#### コマンドで停止
```curl -X GET  http://localhost:4567/stop/{$name}```
#### コマンドで強制停止
```curl -X GET  http://localhost:4567/forcestop/{$name}```
#### コマンドで削除
```curl -X DELETE  http://localhost:4567/delete/{$name}```

#### ブラウザから起動
```http://localhost:4567/start/{$name}```
#### ブラウザから停止
```http://localhost:4567/stop/{$name}```
#### ブラウザから強制停止
```http://localhost:4567/forcestop/{$name}```
#### ブラウザから削除
```http://localhost:4567/delete/{$name}```

