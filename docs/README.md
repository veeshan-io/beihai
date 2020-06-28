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

### 安装 Beihai

> 如果这里定义了自己的扩展方案并且使用了`omf`的bundle依赖，可以直接安装自己的扩展。

```sh
omf install https://gitee.com/veeshan/beihai.git
```
