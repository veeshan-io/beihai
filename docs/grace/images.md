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
beihai build-image
```
