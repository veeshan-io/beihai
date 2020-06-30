# Beihai

## Intro

`Beihai`环境构建机制，基于`Ansible`实现用于各个环境的初始搭建。也可以自行搭建`AWX`配合GUI界面使用。

在`Beihai`中主机实例有三种基础角色：

- `borne` 实例维护与创建节点
- `plane` 集群业务承载
- `escort` 辅助环境

## Deploy

部署流程为：


1. 创建Ops仓库定义好各个配置和模版
2. 安装borne机环境
3. 实始化本机borne
4. 下发密钥
5. 创建plane实例
6. 创建escort实例
