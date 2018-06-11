---
layout:     post
title:      "GitHub Pages以及它的模仿者们入门"
date:       2018-06-11
summary:    "用Github Pages服务搭建静态博客"
categories: balabala
---

### 如果你想拥有自己的网络博客(部落格)
  在以前，如果想要搭建一个个人博客，人们首先会想到**WordPress**。直到今天，基于这个鬼东西创建出来的网站，依然占据着互联网江山很大的一片。它功能挺强大也很容易做定制化，不过这对于个人博客来说有点复杂，搭建和持续运行一套完整的LNMP对于大部分人来说成本也实在太高。但如果你只是想写点文章啥的，也不嫌麻烦，后来人们想到了另外一种方法来搭建博客：
  **直接特么的把全部页面生成好，搞个HTTP服务器不就得了——静态博客**

###  一大波轮子

  基于这个想法，程序员们创造了大量的静态博客生成器，比较著名的有：

* **Jekyll**  - 基于Ruby，它带的节奏。
* **Hexo**   - 不管哪方面的轮子，在npm上肯定是有的，毕竟前端人多。
* **Hugo**   - 来自满是脑残粉的Go社区，善于标榜无依赖部署。
* **GitBook** - 垂直一点，不是生成博客，而是生成文档样式的站点。

....还有[很多](https://www.staticgen.com/)

从结论上来说，做的事情主要是这样的：

1. 你写好文章(通常是Markdown格式)
2. 执行静态博客生成程序
3. 结合主题模版(一堆CSS/JS/HTML)生成网页
4. 顺便给你开个HTTP服务器
5. 然后你开着这个服务，或者把这些静态文件丢到你自己部署的HTTP服务器上(比如Ngx)就能给别人提供访问了



### 第三方服务

  但是并不是每一个人都有一台服务器挂着给别人访问，所以就有了第三方服务，它们允许你把自己生成好的网页放到它们的服务器上来提供给外界服务，还免费，良心商家！Dropbox、Github都有提供这类服务，而Copy to China的Coding.net、码云自然也模仿了Github，提供了类似的服务，鉴于我们的局域网环境，Dropbox就不说了，以GitHub为例。

这个服务叫**[GitHub Pages](https://pages.github.com/)**

用法很简单：

1. 创建Git仓库
  创建一个以名为username.github.io的仓库，其中username必须是你的用户名

2. 提交你的静态页面

   把你的静态页面提交到这个仓库里就可以了

3. 访问

   通过username.github.io访问，就能访问到你的仓库中的网页了(默认首页index.html)



别的什么码云、Coding.net的Pages服务也都是这样的，然后：

- 如果你想绑定自己的域名，只需要在仓库中提交一个文件名为"CNAME"的文件，并写入你的域名。如:

  ```shell
  echo xulin.me > CNAME
  git add CNAME
  git push
  ```

  然后设置域名解析的时候，添加CNAME纪录，指向你的username.github.io，如:

  | 纪录类型 | 主机纪录 | 记录值          |
  | -------- | -------- | --------------- |
  | CNAME    | @        | xulis.github.io |
  | CNAME    | www      | xulis.github.io |

- 在仓库设置中，可以开启博客的https

```Elixir
Settings -> Enforce HTTPS 
```

* 编写Markdown的时候，文件头需要写一些文章的信息，标题呀日期呀啥的，博客生成器会读这些信息，如：

  ```
  ---
  layout:     post
  title:      "GitHub Pages以及它的模仿者们入门"
  date:       2018-06-11
  summary:    "用Github Pages服务搭建静态博客"
  categories: balabala
  ---
  ```

### Github + Jekyll

Github Pages本身支持Jekyll，所以，如果你采用的是Jekyll的话，你不需要在自己的电脑上执行生成网页，然后提交到仓库里，你只需要把整个项目文件夹提交到仓库中，更新博客的时候，你只需要提交你写的Markdown之类的源文件即可，Github会自动处理。相反，如果你采用的是Hexo、Hugo之类的渣渣，你需要把文档放到相应目录，执行生成网页，然后提交网页到仓库中，当然，这些步骤部分工具会考虑到，帮你做简化，例如在Hexo中:

巴拉巴拉设置你的认证key之后，生成文档然后提交：

```shell
hexo g
hexo d
```

> 剧终...



