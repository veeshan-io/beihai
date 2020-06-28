# Beihai

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
