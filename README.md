# ashe

## 介绍

Beihai下的ashe环境构建机制

## 软件架构

基于`Ansible`+`AWX`实现用于各个环境的初始搭建。

## Install

```sh
apt update;apt upgrade -y
apt install -y ansible git fish sshpass
chsh $USER -s /usr/bin/fish
sed -i "s@#host_key_checking = False@host_key_checking = False@g" /etc/ansible/ansible.cfg
```
sed "s@#host_key_checking = False@host_key_checking = False@g" /etc/ansible/ansible.cfg

> Relogin..

```sh
curl -sfL https://gitee.com/veeshan/ashe/raw/master/install.fish | fish
```

### Uninstall

```sh
curl -sfL https://gitee.com/veeshan/ashe/raw/master/uninstall.fish | fish
```

## Usage

### Update ashe

```sh
ashe-update
```

### Ping your servers

假设 inventory 在 inventories/plane/hosts.inv 下

```sh
play-common ping inventories/plane/hosts.inv plane -k
```

## Init servers

Ashe系统的初始化包括以下几部分。

### 用户部分

|用户|||
|---|---|---|
|`root`|基础环境部署|优先初始化密钥|
|`ashe`|应用级部署|在`root`之后创建并初始化密钥|
|用户帐号|运维操作人员登录|根据需求进行密钥初始化|

以下应用在zero或是具体人员操作机器上根据需要执行

```sh
# root初始化指令
play-common system-set-authorized-key inv-main/inventories/plane/hosts.inv plane -k

# ashe初始化指令
play-common system-set-authorized-key inv-main/inventories/plane/hosts.inv plane -k -e target=ashe

# 个人用户初始化指令
play-common system-set-authorized-key inv-main/inventories/plane/hosts.inv plane -k -e target=<user> -e pub_key=</path/to/key>
```

