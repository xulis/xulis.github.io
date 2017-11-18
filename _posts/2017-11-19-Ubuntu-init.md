---
layout:     post
title:      "Ubuntu 17.04配置"
date:       2017-11-19
summary:    "Ubuntu 17.04配置"
categories: ops
---


### #!/bin/开场

  昨天把电脑上的Ubuntu 17.04升级到了17.10，然后发现GNOME 3虽然发展了那么久，依然不是我的菜，从以前喜欢GNOME 2，到现在还是比较喜欢Unity。于是又重新装回了17.04，顺便下一篇文章记录下环境初始化的一些配置，顺便说下，Ubuntu 如果不崩溃，还真××好用。

  个人觉得，如果配置得当，对于IT人的日常(日常软件：终端、编辑器，没了....)，Ubuntu比Windows好很多，比大Mac稍差些。

### 1. 升级更新

1. 设置更新源为国内镜像源。

   *Software Updater  -> settings  ->  Ubuntu software -> Download from -> Other -> China -> (Aliyun 、sohu or ustc)*

2. Update

3. 更新Update Language Support

4. 更新驱动(若需要)

###2.删除不需要的软件 

```shell
#amazon
sudo rm -rf /usr/share/applications/ubuntu-amazon-default.desktop
echo 'Hidden=true' \
| cat /usr/share/applications/ubuntu-amazon-default.desktop 2>/dev/null \
- > ~/.local/share/applications/ubuntu-amazon-default.desktop
#打开仓库删除thunderbird、deja-dup 之类不用的软件，看个人使用情况。
###顺便设置个UTC时间
sudo  timedatectl set-local-rtc true  --adjust-system-clock
```

### 3.软件安装

- **Docky**

  可以直接在仓库中搜索docky，安装，然后在设置系统自带的docky自动隐藏。

  (*All Settings -> Appearance -> Behavior -> Auto-hide the Launcher (ON)*)

  ![docky](http://olq9z1vkh.bkt.clouddn.com/docky.png)

  ​

- **Unity Tweak Tool**

  不像曾经的Gnome2，图形管理器本身就自带了很多自定义的地方，而在unity中，我们可以通过**Unity Tweak Tool**来做一些自定义设置，大部分已经满足需求，包括：窗口行为、主题字体等等。对于不用像以前那样弄个立体桌面在里面养鱼来说，一般需求都能满足，主要是更改主题、设置字体等。

  ![unity-tweak-tool](http://olq9z1vkh.bkt.clouddn.com/unity-tweak-tool.png)

- **Oh my zsh**

  **Oh My Zsh**是ZSH的一份配置，实现比Bash更人性化的终端操作，对于整天要对着终端敲命令的人来说这东西相比较于Bash可以提高不少效率。

```shell
sudo apt-get install zsh
#切换默认的shell为zsh
chsh -s $(which zsh)
#重启机器或注销
#check
echo $SHELL
#need git
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/\
oh-my-zsh/master/tools/install.sh)"
```


- **Guake Terminal**

  这是一个下拉式的终端，按一下F12就会从窗口顶部弹出来，很酷也很方便。可直接在软件仓库中搜索安装。

  之后打开**Startup Applications**添加guake使其开机启动。

  ![guake](http://olq9z1vkh.bkt.clouddn.com/guake_oh_my_zsh.png)

  ​

- **stardict**

  这是Linux平台下的一款非常好用的字典。在仓库中可直接搜索安装。中文名以前叫"星际译王"，由于版权问题，字典本身不带字典，需要自己去网络中下载拷贝进去。个人使用较多的是“郎道英语词典”、“高级汉语词典”和“高级汉语大词典”。下载后(自行百度...)解压拷贝到字典目录中即可：` cp -ar * //usr/share/stardict/dic`

- **Sogou输入法**

  [Sogou](https://pinyin.sogou.com/linux/?r=pinyin)

  ```
  sudo dpkg -i sogoupinyin_2.2.0.0102_amd64.deb
  #通常会提示缺少依赖而安装失败，然后执行下面一句自动安装缺失依赖
  sudo apt-get install -f
  sudo dpkg -i sogoupinyin_2.2.0.0102_amd64.deb
  ```

  安装成功后，设置输入方式为fcitx：*Language Support -> Keyboard input method system: fcitx*

  重启系统或者注销。然后设置fcitx添加搜狗输入法：fcitx configuration -> + -> 不勾选Only Show Current Language -> 搜索sogou然后添加。添加成功后，控制板右上角-设置输入法选择-搜狗输入法。fcitx有一个非常好用的功能，就是按快捷键`Ctrl + ;`可以显示输入历史，直接按数字即可使用历史输入。

  ![sogou](http://olq9z1vkh.bkt.clouddn.com/Sogou.png)


- **Chrome浏览器**

  虽然发现自带的Firefox也挺好用的，但已经习惯谷歌的插件了，所以还是装个谷歌浏览器吧。安装[Chrome](http://www.google.cn/chrome/browser/desktop/index.html)有一个技巧，就是使用--proxy参数，用于在首次安装SwitchyOmega扩展

  ```shell
  sudo dpkg -i ~/Downloads/google-chrome-stable_current_amd64.deb
  sudo apt-get install -f 
  #到此安装完成了，下面是以走代理的方式启动，然后就可以安装插件了。
  google-chrome --proxy-server="socks5://127.0.0.1:10086"
  ```

  *Add SS*

  为系统添加一个开机启动的SS客户端，这是题外话了🔧

  ```shell
  sudo vim /etc/systemd/system/ss.service
  #--内容--
  [Unit]
  Description=ss
  [Service]
  Type=Simple
  ExecStart=/usr/local/bin/shadowsocks-local -b 127.0.0.1 -k <password> -l <local port> -p <server port> -s <SERVERIP>
  [Install]
  WantedBy=multi-user.target
  #--end--
  sudo systemctl daemon-reload
  sudo systemctl start ss
  sudo systemctl enable ss
  sudo ss -tunlp | grep <local port>
  ```

- **编辑器**

  IT狗用的最多的软件恐怕就是编辑器了。Linux下面选择还是挺多的，比如：

  - VIM

     `sudo apt-get install -y vim` 

  - VS Code

    [VS Code官网](https://code.visualstudio.com/) 

    `sudo dpkg -i ~/Downloads/code_1.18.1-1510857349_amd64.deb`

  - Emacs

    [Emacs项目主页](http://www.gnu.org/software/emacs/)

    使用Emacs的话，将Capslk键改为Ctrl键会好很多，笔者现在都习惯用Capslk代替Ctrl了，修改方法：

    ```shell
    sudo vim /etc/default/keyboard
    #--修改为--
    XKBOPTIONS="ctrl:nocaps"
    #然后执行
    sudo dpkg-reconfigure keyboard-configuration
    #重启系统后，Capslk键盘就变成Ctrl键了。
    ```

  - Sublime

    [Sublime官网](http://www.sublimetext.com/)

    ```shell
    wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg \
    | sudo apt-key add -
    sudo apt-get install apt-transport-https
    echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
    sudo apt-get update
    sudo apt-get install sublime-text
    ```

    还有什么ATOM之类的妖艳贱货就不说了。

- **其他**

  ​

  - DockerCE  [链接](https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/)　
  - Virtual Machine Manager　*拟机管理*
  - Typora *超棒的Markdown编辑器*
  - VLC  *支持多一些的播放器*
  - Pycharm ce *仓库里还有Pyharm CE*

  ​

### 主题和字体

* **Moka**

  ```shell
  sudo add-apt-repository ppa:moka/daily
  sudo apt-get update
  sudo apt-get install moka-icon-theme faba-icon-theme 
  ```

  Tweak -> 中选择Moka主题

* **Fonts**

  * Monaco
  * Source Code Pro
  * Inconsolata-LGC
  * 浪漫雅圆
  * AnonyMous Pro
  * [FireCode](https://github.com/tonsky/FiraCode)  -> *这个字体纯粹~~装逼~~用的*
  * [Powerline fonts](https://github.com/powerline/fonts)


### Clean

```shell
 sudo apt-get clean
 sudo apt autoremove
```

![ole](http://olq9z1vkh.bkt.clouddn.com/image/ole.png)

###引用和感谢

>  首先感谢Canonical创造了[Ubuntu](https://www.ubuntu.com/) ，感谢Aliyun、中科大、网易等国内镜像站。
>
>  以及每一个Linux平台软件开发者。
>
>  最后，感谢每一位读者。

