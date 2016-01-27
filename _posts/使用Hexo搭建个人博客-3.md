---
title: 使用Hexo搭建个人博客(3)
date: 2016-1-10
categories: 博客搭建
tags: 
- Hexo 
- GitHub 
- Next 
- 博客 
- Node.js
- Git
---

## 前言
***
上一篇简单介绍了Hexo搭建的静态博客部署到GitHub服务器上，并关联了自己申请的域名，Hexo默认的主题是landscape,如果想选用其他的主题，可以在GitHub上搜索hexo themes,GitHub上Hexo主题Star比较多的有下面几个：
- [NexT](http://theme-next.iissnan.com/)
- [Casper](http://theme-next.iissnan.com/)
- [Uno](https://github.com/daleanthony/uno)
- [Modernist](https://github.com/orderedlist/modernist)
- [Yilia](https://github.com/litten/hexo-theme-yilia)
- [Pacman](https://github.com/A-limon/pacman)
- ...

本篇以Star最多的（也是本人使用的）Next主题为例，简要的介绍Next主题在Hexo中的使用方法

<!--more-->

## NexT简介
***
NexT是[iissnan](https://github.com/iissnan/hexo-theme-next)设计的一款简单又不失优雅的主题,正如NexT的开发宗旨：
** NexT is built for easily use with elegant appearance. First things first, always keep things simple.**

## 应用Next
***

### 下载NexT主题
在Hexo博客的目录打开Shell终端，输入下面命令即可：
    
    $ cd your_hexo_dir
    $ git clone https://github.com/iissnan/hexo-theme-next themes/next
  
### 启用NexT主题
打开Hexo博客站点配置文件，把theme 字段的值改为next

### 验证是否启用
打开Shell终端，输入：

    $ hexo server --debug

并访问[http://localhost:4000](http://localhost:4000)即可查看主题是否启用

### Next配置
NexT的官方使用手册上有比较详细的配置使用教程，见[NexT使用指南](http://theme-next.iissnan.com/)

