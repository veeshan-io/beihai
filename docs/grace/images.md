# 镜像管理

部署`beihai zero`的机器同时提供了一个镜像管理环境，在上面可以方便地对镜像进行构建与上传

## 镜像构建

在`ops-repos`中建立一个存放`Dockerfile`的目录，该目录以二级结构创建。例如目录名叫images，那么目录下的就是按`images/<app>/<version>/Dockerfile`该结构存放。

在`ops-repos`中的`init.fish`中设置全局环境变量，往`$image_dockerfile_repos`列表中追加该目录（即上面的`images`目录的绝对路径）。假设`images`目录与`init.fish`平级：

```sh
set -xg image_dockerfile_repos (dirname (status -f))/images $image_dockerfile_repos
```

此时只要配置好Dockerfile提交更新至zero机，执行以下指令即可进行构建：

```sh
beihai build-image <app> <version> <image_tag>
```

_Notice: 目录选择上有提示，提示中上面演示的`app`被标识为`Major`，`version`被标识为`Minor`_

## 镜像上传

首先需要docker在本地登录，之后在`ops-repos`的`init.fish`中往全局环境变量`$image_repos_list`列表中追加你的镜像仓库地址及分组前缀，这里以华为云为例：

```sh
set -xg image_repos_list swr.cn-east-3.myhuaweicloud.com/<yourgroup> $image_repos_list
```

之后就可以在`zero`机上将本地构建好的镜像使用以下指令上传：

```sh
beihai upload-image <from_tag> <image_repos> <to_tag>
```

_Notice: `from_tag`和`image_repos`有提示_
