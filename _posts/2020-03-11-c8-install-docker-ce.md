---
layout:     post
title:      "CentOS 8安装Docker CE"
date:       2020-03-11
summary:    "懒得写摘要了-。-"
categories: ops
---

这不是一篇中规中矩的技术博客，只是做了一个报错记录，帮助遇到这个问题的人少走弯路。

1. 按照往常的方法安装Docker-ce

```shell
yum install -y yum-utils
yum-config-manager     --add-repo     https://download.docker.com/linux/centos/docker-ce.rep
yum -y install docker-ce
```

你可能会得到类似这样的报错，提示containerd.io版本过低：

```shell
Error:
 Problem: package docker-ce-3:19.03.7-3.el7.x86_64 requires containerd.io >= 1.2.2-3, but none of the providers can be installed
  - cannot install the best candidate for the job
  - package containerd.io-1.2.10-3.2.el7.x86_64 is excluded
  - package containerd.io-1.2.13-3.1.el7.x86_64 is excluded
  - package containerd.io-1.2.2-3.3.el7.x86_64 is excluded
  - package containerd.io-1.2.2-3.el7.x86_64 is excluded
  - package containerd.io-1.2.4-3.1.el7.x86_64 is excluded
  - package containerd.io-1.2.5-3.1.el7.x86_64 is excluded
  - package containerd.io-1.2.6-3.3.el7.x86_64 is excluded
(try to add '--skip-broken' to skip uninstallable packages or '--nobest' to use not only best candidate packages)
```
2. 这时候你需要手动安装containerd的最新版本

```shell
dnf install https://download.docker.com/linux/centos/7/x86_64/stable/Packages/containerd.io-1.2.6-3.3.el7.x86_64.rpm
```

3. 再安装docekr-ce，即可

```shell
dnf install docker-ce
```

