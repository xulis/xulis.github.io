---
layout:     post
title:      "Docker中使用systemd"
date:       2016-07-14
summary:    docker中使用systemd
categories: ops
---

> 注：以下操作针对**CentOS 7.2**以上操作系统,建议CentOS/RHEL7.1以下不要模仿

  我们知道，Docker运行一个容器起来的时候，只是为你提供特定的文件系统层和进程隔离，它给你一个VM的感觉却并不是VM，所以你可能偶尔会想要像在物理机那样使用`systemctl start|status|stop`来管理服务进程，然后你通常会看到

*#*Failed to get D-Bus connection: Operation not permitted**
<!-- more -->

这个错误。
原因很简单:

1. 你需要启动systemd进程
2. 你需要特权

所以你如果想要一个可以使用Systemd的容器，你可以尝试这样启动容器:

```
#cat /etc/redhat-release 
CentOS Linux release 7.2.1511 (Core) 
#docker run -tdi --privileged centos init
```

在容器中，你可以使用systemd管理服务进程了:

```
yum install -y vsftpd
systemctl start vsftpd
systemctl status vsftpd
```

引用:
> http://developerblog.redhat.com/2014/05/05/running-systemd-within-docker-container/
