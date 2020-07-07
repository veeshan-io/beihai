# Make Borne

`borne`首先需要通过脚本创建，事实上只需要一个linux服务器+一个帐户即可以。这里基于`Debian 10`演示基础环境安装：

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

## 安装 OMF

Beihai本身为一个`omf`插件，需要先安装omf

```sh
curl -sfL https://gitee.com/andares/installers/raw/master/fish/install-omf | fish

# 原版安装脚本
# curl -L https://get.oh-my.fish | fish
```

## 安装 Beihai

> 如果这里定义了自己的扩展方案并且使用了`omf`的bundle依赖，可以直接安装自己的扩展。

```sh
omf install https://github.com/veeshan-io/beihai.git
```

## 基于自己的 ops-repos 安装 Beihai

这里定义了一个概念`ops-repos`，每个项目需要有自己的ops专用仓库来与`beihai`结合实现部署。

在实际操作中需要创建自己的部署配置文件，这一般作为ops配置托管在一个独立的git仓库中。最佳实践方案是将此ops配置也做成一个omf插件，在项目根下添加文件`bundle`给出内容`package https://github.com/veeshan-io/beihai.git`

之后直接用omf安装自己的ops库即可

```sh
omf install https://yourgit.com/yourproject/opsconf.git
```

> 关于如何创建 ops 库及其样版之后再做补充

## 部署本机

部署本机需要先给本机定义一个名称即`<host-name>`。这里假设为`borne 0号机`，命名为`zero`

### 使用 koi 指令设置本机主机名

```sh
koi register-host <zero> 127.0.0.1
koi name-localhost <zero>
```

### 使用 Ansible 部署本机

需要在`ops-repos`中设置与hostname一致的borne inv，命名为`borne-zero.inv`，其内容为：

```toml
[borne]
zero          ansible_connection=local
```

可在`host_vars`中对该主机名中的参数进行配置。

这样命名好之后，`beihai`提供了`borne`指令用于构建本机：

```sh
borne
```

### 创建本机密钥

```sh
ssh-keygen -t rsa -P "" -f ~/.ssh/id_rsa
```

## 部署远程

### 集群安全策略

`beihai`建议的安全方案如下：

- 为集群机创建通用密码以方便部署
- 为ssh商品设置独立的对外安全组和对内安全组
- 仅在需要部署的时候开启对外ssh安全组进行部署
- 部署完后移除对外ssh安全组
- 内部平时操作采用跳板机实现
- 当平时不使用时，也可以移除对内ssh安全组，在服务器外利用云服务禁止ssh登录

### 下发密钥

```sh
play <your-inv> issue-key -- -k
```

### ping 一下

```sh
play <your-inv> ping
```

### 创建 plane 和 escort

## 远程部署 Borne

## 完成部署
