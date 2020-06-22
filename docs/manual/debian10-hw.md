# 个人安装不纳入ashe标准流程中的组件

## Install SpaceVim

```sh
setup-spacevim
```


# 华为云 Debian 10 服务器标准初始化流程



## 主机创建

- 选择系统为Debian 10
- 为root设置密码，可用于急救

## 初始化环境

### 服务器改名

```sh
sed -i '$a 127.0.1.1       ecs-plane-borne' /etc/hosts
echo 'ecs-plane-borne' > /etc/hostname
cat /etc/hosts
cat /etc/hostname
```

### 更换apt源

```sh
cp -rf /etc/apt/sources.list /etc/apt/sources.list.origin
sed -i "s@deb.debian.org@repo.huaweicloud.com@g" /etc/apt/sources.list
sed -i "s@security.debian.org@repo.huaweicloud.com@g" /etc/apt/sources.list
cat /etc/apt/sources.list
```

### 安装基础软件

```sh
apt update;apt upgrade -y
apt upgrade base-files -y --allow-change-held-packages
apt autoremove -y;apt autopurge;apt autoclean
apt update;apt install -y sudo git php-cli tree fish
```

### 添加用户组

```sh
groupadd wheel
```

**重启**

## 创建个人用户

```sh
useradd -m andares
usermod -a -G wheel andares
chsh andares -s /usr/bin/fish
```

*然后上传公钥*

```sh
su - andares
mkdir .ssh
echo '{YOUR_PUBKEY}' > ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
exit
```

### 设置`sudo`及免密权限

```sh
echo 'andares ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/andares
```

### 系统基础优化及加固

**基本原则**

- root用户提供16位以上密码
- 其他用户无密码走ssh登录

#### /etc/ssh/sshd_config

- ClientAliveInterval 600
- ClientAliveCountMax 5
- MaxAuthTries 6
- MaxSessions 20
- Port xxx 换端口

## Setup personal user

**这里请使用个人用户登录**

以下是一些基本调整

```sh
git config --global http.postBuffer 524288000
git config --global user.name andares
git config --global user.email your@email.com
```

### 构建密钥

```sh
ssh-keygen # 一路回车
```

#### 安装`omf`和`Fisher`

*Fisher可视情况安装*

```sh
curl -sfL https://gitee.com/andares/installers/raw/master/fish/install-omf | fish
#curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish
```

> 启用个人batman theme执行`omf install https://github.com/andares/batman.git;omf theme batman`

### Install `koi` and `RedKoi`

```sh
omf install https://github.com/andares/redkoi
```

**安装完之后需要重新登入系统**


## Install `docker` and `docker-compose`

```sh
setup-docker
```

## Create `ashe`

```sh
sudo useradd -m ashe
sudo chsh ashe -s /usr/bin/fish
sudo usermod -a -G docker ashe
```

**以下切换到ashe执行**

### Create SSH-Key

```sh
ssh-keygen # 一路回车
```

### Install `omf`

```sh
curl -sfL https://gitee.com/andares/installers/raw/master/fish/install-omf | fish
```

## Mount data disk

如果有数据盘，则挂载到/opt下的某个目录下

### 未初始化磁盘先如下操作

[磁盘挂载后初始化](https://support.huaweicloud.com/qs-evs/evs_01_0034.html)

### 初始化好的磁盘

1. 通过`sudo lsblk`确定设备名，例如`vdb1`
1. 通过`koi mount-disk <dev> <target> <user`进行永久挂载

> Example: `koi mount-disk vdb1 /opt/data01 ashe`

**以下回到个人用户执行**

## Install `Postgres`

> 这里举例安装在`/opt/data01/postgres-12`目录下。
> 需要先放通`> TCP:25432`

```sh
setup-postgres /opt/data01/postgres-12 brillia ashe
sudo su -c "cd /opt/data01/postgres-12;docker-compose up -d" -s /usr/bin/fish ashe
```

> sudo su -c "cd /opt/data01/postgres-12;docker-compose kill" -s /usr/bin/fish ashe

## Install `K3s`

```sh
setup-k3s cn
sudo cp -f /etc/rancher/k3s/k3s.yaml /home/ashe/.kube/config
sudo chown ashe:ashe /home/ashe/.kube/config
```

看看要不要加kuboard

### Install `Helm`

```sh
setup-helm https://plane.cn-sh2.ufileos.com/softwares%2Fhelm-v3.1.2-linux-amd64.tar.gz
```

---

**以下发布机制以后完成**

## Install `pip` and `supervisord`

## Install `ansible` and `AWX`

## Create cluster for `ashe`


## 可选项

### Install `Rancher`

> 这里举例安装在`/opt/data01/rancher`目录下。
> 需要先放通`> TCP:9080`, `> TCP:9443`

> 假设上传证书到`~/tmp/cert`目录下并设置权限`chmod 640 ~/tmp/cert/*`

```sh
setup-rancher /opt/data01/rancher 9080 9443 ~/tmp/cert ashe
sudo su -c "cd /opt/data01/rancher;docker-compose up -d" -s /usr/bin/fish ashe
```

> sudo su -c "cd /opt/data01/rancher;docker-compose kill" -s /usr/bin/fish ashe
> sudo su -c "cd /opt/data01/rancher;docker-compose rm" -s /usr/bin/fish ashe
