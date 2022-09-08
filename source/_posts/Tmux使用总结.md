---
title: Tmux使用总结
date: 2019-01-23
categories: Tools
tags:
- Tmux
---

## 前言
***

`Tmux`是一个终端复用器(Terminal multiplexer)类自由软件，类似于`Screen`和`Byohu`，但是比这两者功能更强大，Wiki上这样说`Tmux`：

    tmux is an open-source terminal multiplexer for Unix-like operating systems. 
    It allows multiple terminal sessions to be accessed simultaneously in a single window.
    It is useful for running more than one command-line program at the same time.
    It can also be used to detach processes from their controlling terminals, allowing remote sessions to remain active without being visible

> `Tmux`是类Unix操作系统上的开源终端复用器，其允许多个终端会话在单个窗口中同时被访问，对于同一时刻允许多个命令行的程序来说很有用。它可以从控制终端中分离出进程并且允许远程回话在无窗口不可视化情况下保持激活状态。

<!--more-->

## 基本概念
***

### 模块组成
---
`Tmux`采用`Client/Server`模型，主要包括以下几种模块组成：

| 模块  |                   简介                           |
|:-----:|:------------------------------------------------:|
|Client | 从外部终端(xterm, terminal)连接到一个Tmux Session|
|Server | Tmux 运行的基础服务，Session,Window,Pane均依赖于此|
|Session | 一个或多个Window 组成 |
|Window | 一个或多个Pane组成，连接到一个或多个Session    |
|Pane | 包含一个终端Terminal并且运行程序，出现在某个Window|

#### Tmux Clients/Server
---
`Tmux`服务器保持所有的状态在单个主进程中，该服务器运行在后台，并且管理着所有在`Tmux`中运行的程序，同时跟踪记录这些程序的输出，当用户运行一个`Tmux`命令，服务器自动启动并且在无程序运行时自动退出。
用户通过启动一个Client Attach连接到`Tmux`服务器, 这个操作接管了它运行所在的终端并且使用在`/tmp`目录下的socket文件与服务器进行交互，每个Client运行在一个终端中，这种终端Terminal可以是任意的如xterm, system console等等。

#### Tmux Pane
---
每个在`Tmux`中的终端Terminal属于一个Pane, Pane是用来显示终端内容的矩形区域，由于每个在`Tmux`中的终端Terminal仅在一个Pane中显示，Pane就代表了终端Terminal和运行其中的程序

#### Tmux Window
---
每个Pane出现在某个Window中，Window由一个或多个Pane组成，并且覆盖了整个显示区域，所以多个Pane可以同时显示，每个Pane在Window中有相应的索引 。

#### Tmux Session
---
多个Window组成了Session，如果一个Window是某个Session的一部分，那就意味着整个Window连接到该会话。Window可以同时连接到多个Session，尽管大部分只连接到一个Session，每个Window在Session亦有相应的索引，同样的Window在不同的Session中可能是不同的索引。
一个Session可以被Attach到一个或多个Client，任意的从Terminal中输入的文本被发送到Attached Sessioin的Current Window的Active Pane中。

> 程序运行在属于某个Window的Pane的终端Terminal中
> 每个Window有个名称和Active Pane
> Window可以连接到一个或多个Session
> 每个Session有多个Window，每个Window在其中有个索引
> Session被Attach到0或多个Client
> 每个Client被Attach到一个Session

### 功能特点
---
1. 可以管理多个Session，Window，Pane
2. Window，Pane可以在Session中自由移动切换
3. 分屏同时多个操作，并支持自定义快捷键
4. 带有复制黏贴缓冲区
5. 支持自定义配置

### 使用场景
---
1. 防止运行在远程服务器上的程序因为断开与客户端连接而停止或退出
2. 多个不同的终端连接到共同的远程服务器上，方便远程结对编程
3. 作为Window Manager可以在一个虚拟终端中同时进行多个程序运行

## Tmux使用
***

### 安装
---
1. Debian或Ubuntu命令安装：
```
    apt install tmux
```
2. 从Git仓库源码编译安装：
```
    git clone https://github.com/tmux/tmux.git
    cd tmux
    sh autogen.sh
    ./configure
    make && sudo make install
```

> 安装完后，查看使用`Tmux`使用手册：输入命令`man 1 tmux`或者`man tmux`或者按下`Ctrl + b + ?`快捷键

### Tmux启动与退出
---

1. 输入`tmux`命令进入`Tmux`窗口，按下Ctrl + d 或者输入`exit`退出`Tmux`窗口。

2. `Tmux`中所有快捷键都需要前缀键唤起，默认是`Ctrl + b`，可以在配置文件中更改该默认前缀键盘。

### Session使用
---
Session交互主要包括创建，连接，分离，切换，重命名，罗列，删除等操作。
> `Tmux`最大的优势就是在启动`Tmux`环境执行各种程序时，可以通过Session**分离**让`Tmux`在后台运行，一般情况下如果我们关闭一个普通的终端Session，那么这个Session中的所有程序就会被杀死，但是从`Tmux`Session后并没有关闭`Tmux`，在这个会话中运行的程序仍然在运行，可以在任何时候想要的时候Session**连接**过去。

#### 创建Session
新建一个Session，在终端输入`tmux`命令即可：

    tmux
新建一个带名称的Session：

    tmux new -s <session-name>

#### 连接Session
可以通过会话编号或名称来接入连接某个已存在的Session，若不带参数则接入到最近最常用的Session：

    tmux attach
    tmux attach -t <session-id>
    tmux attach -t <session-name>

#### 分离Session
可以通过会话编号或名称来分离Session，若不带参数则分离当前Session：

    tmux detach
    tmux detach -t <session-id>
    tmux detach -t <session-name>

#### 切换Session
可以通过会话编号或名称来切换Session：

    tmux switch -t <session-id>
    tmux switch -t <session-name>

#### 重命名Session
可以通过会话编号或名称来重命名Session，若只带一个参数表示重命名当前Session：

    tmux rename-session  <new-session-anme>
    tmux rename-session -t <old-session-id/name> <new-session-anme>

#### 罗列Session
查看Session列表：

    tmux ls
    tmux list-session

#### 删除Session
可以通过会话编号或名称来删除Session，若不带参数则删除当前Session：

    tmux kill
    tmux kill -t <session-id>
    tmux kill -t <session-name>

### Session操作快捷键
|  快捷键  |   简介                 |
|:--------:|:---------------------:|
| Ctrl-b + d| 分离当前会话|
| Ctrl-b + s| 列出当前会话|
| Ctrl-b + $| 重命名当前会话|
| Ctrl-b + (| 移动到前一个会话|
| Ctrl-b + )| 移动到后一个会话|

### Window使用
---
Window交互主要包括创建，切换，重命名，罗列，删除等操作。

#### 创建Window
新建一个Window，在终端输入`tmux`命令即可：

    tmux new-window
新建一个带名称的Window：

    tmux new-window -n <window-name>

#### 切换Window
可以通过窗口编号或名称来切换Window：

    tmux select-window -t <window-id>
    tmux select-window -t <window-name>

#### 重命名Window
可以通过窗口编号或名称来重命名Window，若只带一个参数表示重命名当前Window：

    tmux rename-window  <new-window-anme>
    tmux rename-window -t <old-window-id/name> <new-window-anme>

#### 罗列Window
查看Window列表，不带`-a`表示列出当前Session的所有Window，否则列出所有Session的所有Window：

    tmux list-window
    tmux list-window -a

#### 删除Window
可以通过窗口编号或名称来删除Window，若不带参数则删除当前Window，带表示`a`所有：

    tmux kill-window
    tmux kill-window -a
    tmux kill-window -t <window-id>
    tmux kill-window -t <window-name>

### Window操作快捷键
|  快捷键  |       简介                          |
|:--------:|:----------------------------------:|
| Ctrl-b + c| 创建新的窗口|
| Ctrl-b + p| 切换到前一个窗口|
| Ctrl-b + n| 切换到下一个窗口|
| Ctrl-b + w| 从列表中选窗口|
| Ctrl-b + 0-9| 切换到指定编号窗口|
| Ctrl-b + ,| 重命名当前窗口|
| Ctrl-b + &| 关闭当前窗口|

### Pane使用
---
Pane交互主要包括创建，切换，交换位置，调整大小，罗列，删除等操作。

#### 创建Pane
`Tmux`可以将Window分割成多个Pane,每个Pane运行不同程序，默认上下划分当前Window：

    tmux split-window
左右划分当前Window：

    tmux split-window -h

#### 切换Pane
可以通过`select-pane`命令加方向来使光标切换不同Pane，上下左右(Up,Down,Left,Right):

    tmux select-pane -U
    tmux select-pane -D
    tmux select-pane -L
    tmux select-pane -R

#### 交换Pane
可以通过`swap-pane`命令加方向来将当前Pane交换移动到不同位置，上下左右(Up,Down,Left,Right):

    tmux swap-pane -U
    tmux swap-pane -D
    tmux swap-pane -L
    tmux swap-pane -R

#### 调整Pane
可以通过窗格编号来调整Pane大小，[-UDLR]表示上下左右，[M]表示使用鼠标调整，[Z]表示目标Pane放大到整个Window大小其他Pane隐藏，连续执行则恢复原来大小和位置这样Toggle操作，[target-pane]表示目标Pane，若没有表示当前Pane，
[-x width]和 [-y height]表示调整的绝对量，[adjustment]表示调整的相对量，默认为1

    tmux resize-pane [-DLMRUZ] [-t target-pane] [-x width] [-y height] [adjustment]

#### 罗列Pane
查看Pane列表，不带`-as`表示列出当前Session当前Window的所有Pane，带`-a`表示列出所有Session所有Window所有Pane，不带`-a`带`-s`表示列出`target`指定Session的所有Pane：

    tmux list-panes [-as] [-t target]

#### 删除Pane
可以通过窗格编号或名称来删除Pane，若不带参数则删除当前Pane，带`-a`表示所有：

    tmux kill-pane 
    tmux kill-pane -a 
    tmux kill-pane -t <pane-id>
    tmux kill-pane -t <pane-name>

### Pane操作快捷键
|  快捷键  |       简介           |
|:--------:|:--------------------:|
| Ctrl-b + %| 水平分割当前窗口|
| Ctrl-b + "| 竖直分割当前窗口|
| Ctrl-b + {| 移动到当前Pane到左边|
| Ctrl-b + }| 移动到当前Pane到右边|
| Ctrl-b + Ctrl + o|  移动到当前Pane到上边|
| Ctrl-b + Alt + o |  移动到当前Pane到下边|
| Ctrl-b + Arrow| 切换Pane到指定方向|
| Ctrl-b + o| 切换到下一个Pane|
| Ctrl-b + q| 显示到Pane编号|
| Ctrl-b + q + 0-9| 切换到指定编号Pane|
| Ctrl-b + z| Toogle Zoom当前Pane|
| Ctrl-b + space| 切换Pane布局|
| Ctrl-b + !| 转换当前Pane到Window|
| Ctrl-b + x| 关闭当前Pane|



### 其他命令使用
---
如果没有Session，Window，Pane在`Tmux`中，`Tmux` Server会退出，亦可以通过以下命令Kill整个`Tmux`：

    kill-server
列出所有快捷键及相应的命令：

    tmux list-keys
列出所有命令及参数：

    tmux list-commands
列出所有Session信息：

    tmux info
重新加载当前配置：

    tmux source-file ~/.tmux.conf
当前窗格中显示时间：
    
    tmux clock-mode

### 其他命令快捷键
|   快捷键  |       简介           |
|:---------:|:--------------------:|
| Ctrl-b + :| 进入Tmux命令Mode |
| Ctrl-b + ?| 帮助 |
| Ctrl-b + t| 显示时钟 |

### 复制黏贴
---

#### 复制黏贴操作
`Tmux`复制黏贴可以将终端的文本内容包括在屏幕之外可以通过键盘来前后翻动的文本内容复制到另一个程序或文件中，达到高效复用终端显示文本的效果。
主要步骤分以下三步：

1. 进入Copy Mode
通过`Ctrl + b + [`进入Copy Mode，可以通过`q`命令提前退出Copy Mode,

2. 选中终端文本
移动光标选中文本可以使用vi模式，只需要在`Tmux`配置文件中增加：
```
    setw -g mode-keys vi
```
设置完成后，可以通过Vi的快捷键来移动光标到需要复制的首位置，然后按下`Space`空格键开始文本选中，然后移动光标到文本尾部，选中完成后，按下`Enter`键将选中的文本复制到`Tmux`的复制黏贴缓冲区。

3. 执行复制并退出Copy Mode
切换到需要黏贴的地方，通过`Ctrl + b + ]`执行Copy并退出Copy Mode

#### 复制当前Pane可视化范围所有终端文本
如果需要将Pane的可视化范围内容全部复制到一个黏贴缓冲区里，只需要待复制的Pane命令行中输入：

    tmux capture-pane
或者按下`Ctrl + b + :`进入`Tmux`命令模式输入`capture-pane`

#### 复制选中内容保存到文件
如果需要将黏贴缓冲区的内容保存到文件，只需要在命令行中输入：

    tmux save-buffer [filename]
或者按下`Ctrl + b + :`进入`Tmux`命令模式输入`save-buffer [filename]`

#### 复制黏贴其他操作
可以通过以下命令进行查看黏贴缓冲区状态

    tmux show-buffer  // 显示当前缓存区内容
    tmux list-buffers //列出所有的黏贴缓冲区
    tmux delete-buffer -b id //删除buffer_id的黏贴缓冲区

#### 复制黏贴快捷键
|   快捷键  |       简介           |
|:---------:|:--------------------:|
| Ctrl-b + [| 进入Copy Mode |
| Ctrl-b + ]| 退出Copy Mode |
| q         | 退出模式 |
| Space     | 开始选中文本|
| Esc       | 清除选中文本|
| Enter     | 复制选中文本到Buffer |


### Tmux配置
---

#### Tmux配置文件
`Tmux`配置文件`.tmux.conf`一般存在于用户的home目录下，该文件包含了一系列的按顺序执行的`Tmux`命令, 只有在`Tmux`Server 启动的时候才会运行该文件，其他情况如新建Session等不会运行该文件
一般情况下，修改配置文件后，需要运行以下命令才能使配置文件生效:

    tmux source ~/.tmux.conf
> 一些常用的`Tmux`执行命令和配置都可以在配置文件中完成，如一些`Tmux`Server启动时候需要执行的命令和常用的快捷键配置

### Tmux Plugin
---

#### 安装TPM
`Tmux`支持各种Plugin，增强其功能扩展性，其Plugin管理工具为`TPM`，全称Tmux Plugin Manager，`Tmux`之于`TPM`就如同`Vim`之于`Vundle`。

安装`TPM`以下几步骤：
1. `git clone`到`Tmux`plugins 目录：
``` 
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```
2. 更改配置文件`.tmux.conf`：
```
    # List of plugins
    set -g @plugin 'tmux-plugins/tpm'
    set -g @plugin 'tmux-plugins/tmux-sensible'
    
    # Other examples:
    # set -g @plugin 'github_username/plugin_name'
    # set -g @plugin 'github_username/plugin_name#branch'
    # set -g @plugin 'git@github.com:user/plugin'
    # set -g @plugin 'git@bitbucket.com:user/plugin'
    
    # Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
    run '~/.tmux/plugins/tpm/tpm'
```

#### 常用Plugin
安装完`Tmux`Plugin管理插件`TPM`后，可以安装其他插件，常用的插件有：

1. tmux-sensible
一些常用的大家都觉得好用的配置，正如其官方所说：`basic tmux settings everyone can agree on`，主要是方便`Tmux`配置管理。
在配置文件中添加:
```
    set -g @plugin 'tmux-plugins/tmux-ensible'
```

2. tmux-resurrect
系统重启后，恢复`Tmux`配置，亦正如其官方所说：`Persists tmux environment across system restarts`，`Tmux`在计算机系统重启后，运行的程序，工作目录Pane布局都丢失了，该插件主要目的是保存尽可能多的`Tmux`环境细节，当机器重启后，仍然能重新保持之前的状态。
在配置文件中添加:
```
    set -g @plugin 'tmux-plugins/tmux-resurrect'
```

>  快捷键为：保存环境(Ctrl + b Ctrl + s)，恢复环境(Ctrl + b Ctr + r)

#### Plugin操作
1. 安装插件
直接输入以下命令：
```
    ~/.tmux/plugins/tpm/bin/install_plugins
```
或者快捷键`Ctrl + b + I(大写)`

2. 更新插件
直接输入以下命令，带`all`参数表示更新所有Plugin：
```
    ~/.tmux/plugins/tpm/bin/update_plugins all
    ~/.tmux/plugins/tpm/bin/update_plugins plugin-name
```
或者快捷键`Ctrl + b + U(大写)`

3. 卸载插件
直接输入以下命令：
```
    ~/.tmux/plugins/tpm/bin/clean_plugins
```
或者快捷键`Ctrl + b + alt + u(小写)`


本人的`Tmux`配置如下:

    # List of plugins
    set -g @plugin 'tmux-plugins/tpm'
    set -g @plugin 'tmux-plugins/tmux-sensible'
    
    # Other plugins:
    set -g @plugin 'tmux-plugins/tmux-resurrect'
    
    # Set Vim-like Copy Mode
    setw -g mode-keys vi
    # Vim-like pane-operation remap
    # Vim-like pane resizing  
    bind -r C-k resize-pane -U
    bind -r C-j resize-pane -D
    bind -r C-h resize-pane -L
    bind -r C-l resize-pane -R
    
    # Vim-like pane switching
    bind -r k select-pane -U
    bind -r j select-pane -D
    bind -r h select-pane -L
    bind -r l select-pane -R
    
    # Reload tmux config file
    bind r source-file ~/.tmux.conf
    
    # Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
    run '~/.tmux/plugins/tpm/tpm'


附:
比较齐全的`Tmux`命令图解:
![tmux-cheatsheet1](tmux-cheatsheet1.png)
![tmux-cheatsheet2](tmux-cheatsheet2.png)


## 总结
***
`Tmux`能够在同一个虚拟终端下同时进行运行多个程序，并且支持多窗口操作。能在断网或关机情况下保持本地虚拟终端状态，对于命令行方式工作的连续性有很大的帮助，同时支持命令行下的复制黏贴操作也加快了文本复用操作。自定义配置和插件能根据个人习惯进行功能扩展和属性配置，可以说`Tmux`是和命令行文本编辑工具`Vim`配合的神器。

## 参考
---

[Tmux Wiki](https://github.com/tmux/tmux/wiki/Getting-Started)

[Tmux wikipedia](https://en.wikipedia.org/wiki/Tmux)

[Tmux使用教程](https://www.ruanyifeng.com/blog/2019/10/tmux.html)

[Tmux- The Terminal multiplexer](http://linuxaria.com/article/tmux-the-terminal-multiplexer)

