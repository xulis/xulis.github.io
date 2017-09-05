---
layout:     post
title:      "Git服务搭建"
date:       2016-07-15
summary:	"使用ssh协议"
categories: ops
---

### 1、下载安装

[git-2.7.0](https://www.kernel.org/pub/software/scm/git/git-2.7.0.tar.gz)

```
<!-- more -->
wget https://www.kernel.org/pub/software/scm/git/git-2.7.0.tar.gz
yum install gcc 
tar xvf git-2.7.0.tar.gz;cd git-2.7.0
make configure
mkdir /usr/local/git
./configure --prefix=/usr/local/git
make install
make install
#设置环境变量
vim ~/.bash_profile
PATH=$PATH:$HOME/bin:/usr/local/git/bin/
export PATH
source ~/.bash_profile
#查看
git --version
```

### 2、配置

稍微设置一下用户信息

```
git config --global user.name "xulis2012"
git config --global user.email xulis2012@gmail.com 
```

创建git用户

```
useradd -m -r git
#设置git的登录shell为git-shell
vim /etc/passwd
git:x:500:501::/home/git:/usr/local/git/bin/git-shell
```

新建SSH-key

> 如果出于安全考虑，需要使用有密码的key，那么客户端需要使用SSH密钥密码记忆功能，比如ssh-agent等方式，如果ssh-key不需要是无密码的，则无需设置。
> 

> 默认情况下会使用SSH的默认key（一般为id_rsa），自行指定，可使用~/.ssh/config

```
su git
ssh-keygen
#这里以指定key例子
[root@@omd_host test]# 🚀 ssh-keygen
Generating public/private rsa key pair.
Enter file in which to save the key (/root/.ssh/id_rsa): /home/git/.ssh/id_git
Enter passphrase (empty for no passphrase):  #密码设置为空，如果设置了密码，客户端使用，需有记住此Key密码的功能
Enter same passphrase again:
Your identification has been saved in /tmp/id_test.
Your public key has been saved in /tmp/id_test.pub.
The key fingerprint is:
db:c8:37:24:56:08:b8:c5:d5:8e:f3:60:84:d6:fb:a0 root@i-25BDB9AF
The key's randomart image is:
+--[ RSA 2048]----+
|     o.+..       |
|    . =.o..      |
|     + ..+.      |
|    .   B..      |
|       oS*.      |
|      Eo *o      |
|        + +      |
|         . .     |
|                 |
+-----------------+
cat /home/git/.ssh/id_git.pub >> /home/git/.ssh/authorized_keys 
chmod 600 /home/git/.ssh/authorized_keys
```

 测试SSH

```
#一般出于安全考虑，服务端ssh端口会被修改，这里以2222为例，git默认使用22连接
ssh -p 2222 -i /home/git/.ssh/id_git git@localhost
#连接成功的话，就说明ssh配置是没有问题的了
```

新建裸项目

```
mkdir /opt/git/myproject
cd /opt/git/myproject
git init --bare
chown -R git:git /opt/git/myproject 
#如果目录没有写权限， git push的时候会提示:"remote: error: insufficient permission for adding an object to repository database ./objects"错误。
```

### 3、客户端配置

首先客户端需要有私钥(yue)

```
scp /home/git/.ssh/id_git username@remote_host:/keypath/
```

添加ssh配置

```
vim ~/.ssh/config
Host gitser
	HostName 192.168.1.1   #git服务器的地址
	User git
	IdentityFile /keypath/id_git  #指定使用的私钥
	IdentitiesOnly yes
```

测试

``` 
cd /tmp
git clone ssh://git@gitser:2211/opt/git/myproject ./test
cd ./test
echo '(define (doub x) (* x 2)' > te.scm
git add te.scm
git commit -m "first"
git push
```

### 结束

> 其实过程比较简单，[官方文档](http://git-scm.com/book/zh/v2)也相当详细。之所以要写出来，是因为SSH的方式，SSH的问题我折腾了挺久，大体上来说是这样的：
> 
> 默认情况下,git clone 可以指定用户和SSH端口(例如:`git clone ssh://git@hostname:2222/path/`)，证书使用的是当前用户的~/.ssh/id_rsa
> 
> 而我的需求是:首先SSH端口不用22以及用户不用ROOT都满足了；然后是我需要的是一些其他需求和解决方案，希望对有这种需求的人有帮助：
> 
> **指定Key：使用SSH的config配置**
> 
> **Key密码验证：使用ssh-agent**


