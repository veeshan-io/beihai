# ashe

## 介绍

Beihai下的ashe环境构建机制

## 软件架构

基于`Ansible`+`AWX`实现用于各个环境的初始搭建。

## 安装教程

### Install

```sh
apt update;apt upgrade -y
apt install -y ansible git fish
chsh $USER -s /usr/bin/fish
```

> Relogin..

```sh
curl -sfL https://gitee.com/veeshan/ashe/raw/master/install.fish | fish
```

#### Uninstall

```sh
curl -sfL https://gitee.com/veeshan/ashe/raw/master/uninstall.fish | fish
```

### 初始化

```sh
git clone https://gitee.com/veeshan/ashe.git
cd ashe
chmod +x ./
```

#### 使用说明
