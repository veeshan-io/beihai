# Beihai

## Intro

Beihai环境构建机制，基于`Ansible`实现用于各个环境的初始搭建。也可以自行搭建`AWX`配合GUI界面使用。

## Borne Install

`borne`是指最初的零号机，事实上只需要一个linux服务器+一个帐户即可以。这里基于`Debian 10`演示基础环境安装：

```sh
apt update;apt upgrade -y
apt install -y ansible git fish sshpass
chsh $USER -s /usr/bin/fish
```

**去掉 know_hosts 检测**

```sh
sed -i "s@#host_key_checking = False@host_key_checking = False@g" /etc/ansible/ansible.cfg
```

> 根据需要上传ssh pub key

### 安装 OMF

Beihai本身为一个`omf`插件，需要先安装omf

```sh
curl -sfL https://gitee.com/andares/installers/raw/master/fish/install-omf | fish

# 原版安装脚本
# curl -L https://get.oh-my.fish | fish
```

```sh
curl -sfL https://gitee.com/veeshan/beihai/raw/master/install.fish | fish
```

## Plane install

### Uninstall

```sh
curl -sfL https://gitee.com/veeshan/beihai/raw/master/uninstall.fish | fish
```

## Usage

> 操作所在机器必须先`ssh-keygen`生成密钥用于下发。

### Update beihai

```sh
beihai-update
```

### Ping your servers

假设 inventory 在 inv-main/inventories/development/hosts.inv 下

```sh
play-book ping inv-main/inventories/development/hosts.inv -k
```

### Set authorized key

首先利用密码登录并给各服务器传送密钥。

```sh
play-book root-sshkey inv-main/inventories/development/hosts.inv -k
```

### Update servers

```sh
play-book makeup-all inv-main/inventories/development/hosts.inv
```

### User control

通过非inventory配置创建个人用户

```sh
# 建议通过`-l`参数控制操作范围
play-book user-set inv-main/inventories/development/hosts.inv -l plane  -e target=newuser

# 完整参数
play-book user-set inv-main/inventories/development/hosts.inv -l plane  -e target=newuser \
  -e target_password=123123 \
  -e target_groups=wheel \
  -e pub_key=xxxxxx
```

通过非inventory配置关闭个人用户

```sh
play-book user-ban inv-main/inventories/development/hosts.inv -k -e target=banuser -e pub_key=pubkey
```

## Make inventory
