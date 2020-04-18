# ashe

## 介绍

Beihai下的ashe环境构建机制

## 软件架构

基于`Ansible`+`AWX`实现用于各个环境的初始搭建。

## Install

```sh
apt update;apt upgrade -y
apt install -y ansible git fish
chsh $USER -s /usr/bin/fish
```

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

## Init servers

ansible all -m authorized_key -a "user=root key='{{ lookup('file', '/root/.ssh/id_rsa.pub')}}' path='/root/.ssh/authorized_keys' manage_dir=no" --ask-pass -c paramiko

看能不能配合koi进行主动拉取统一密钥的方式。不行好像还是要推的。

公钥放到inv的变量中
服务器列表在uranus/servers中，支持指定密码
通用密码在uranus/ashe中
整理一下安全组，并在安全组中设置ssh白名单限制，分两种，全禁和白名单
