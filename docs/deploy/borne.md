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

### 使用 koi 指令设置本机主机名

```sh
koi register-host <host-name> 127.0.0.1
koi name-localhost <host-name>
```

### 使用 Ansible 部署本机

需要在`ops-repos`中设置与hostname一致的borne inv，命名为`borne-<host-name>`，其内容为：


```toml
[borne]
preface         ansible_connection=local
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

### 下发密钥

## 完成部署
