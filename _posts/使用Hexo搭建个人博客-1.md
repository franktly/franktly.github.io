---
title: 使用Hexo搭建个人博客(1)
date: 2016-1-5
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

写个人Blog大部分情况下是在使用现有的网站提供的博客系统，使用比较多的有sina博客、网易博客、CSDN等，如果想DIY个人的博客，可以选择静态网站的方式，使用的比较多的静态博客框架有:
- [Jekyll](http://jekyll.bootcss.com/):  
Jekyll是一种基于Ruby开发的、适用于博客的静态网站生成引擎。使用一个模板目录作为网站布局的基础框架，提供了模板、变量、插件等功能，最终生成一个完整的静态Web站点。即只要安装Jekyll的规范和结构，不需写html，便可生成网站
- [Octopress](http://octopress.org/):
Octopress是一款基于Ruby开发的静态化、本地化的博客系统。其最大的优势就是静态化，不依赖脚本程序，没有MysqL等数据库，因此它可在一些性能差的服务器或者虚拟空间上运行，同等条件下打开页面的速度会比较快 
- [Hexo](https://hexo.io/):
Hexo是一款基于node.js开发的博客程序，拥有简单的服务器，可用作简单的动态博客使用。也有生成器，生成的静态文件可以一键部署到Github Pages上，也可以部署到任意静态文件服务器上。它相当简约，并且可使用Markdown来编写文章
考虑到简单易用，生成效率问题，选用Hexo作为搭建个人博客的框架

<!--more-->

## Hexo简介
***
Hexo是一个快速、简单且高效的博客框架,使用Markown(或其他渲染引擎)解析文章，可以高效的利用各种主题插件生成自定义的静态页面，使用Hexo时候，一般是在本地编辑文章，转化为生成HTML文件，然后上传到部署的服务器上

## Hexo安装
***
### 安装Hexo前需要的准备

- Node.js: 
[Node.js下载地址]（https://nodejs.org/en/）
笔者安装的是Window版本的node-v5.3.0-x64.msi，安装完成后，在cmd输入`node -v`可以查看安装的版本和是否正确
- Git：
[git下载地址]（http://git-scm.com/download/）
笔者安装的是Windows版本的git version 1.9.5.msysgit.0,安装完成后，`git --version`可以查看安装的版本和是否正确

### 安装Hexo

使用npm（npm是node.js的模块管理和发布工具,安装node的时候会自动安装此工具）安装Hexo，shell中输入下面命令：

    $ npm install -g hexo-cli

安装完成后，shell中输入`hexo -v`或`hexo version`查看安装的版本

> `-g`: 表示全局安装，未带此参数表示本地安装
- 全局安装：模块将被安装到**全局目录**中，全局目录可以通过`npm config set prefix "目录路径"`来设置，通过`npm config get prefix` 来获取
- 本地安装：模块将被安装到**当前命令行所在目录中**
一般采用全局安装方式统一安装到一个目录中去，方便管理、结构清晰、可以重复利用

## Hexo本地建站
***
### 初始化Blog网站框架

在本地电脑上建立一个Blog目录，并在shell中进行下面命令，初始化框架:

    $ hexo init <your blog folder>
    $ cd folder
    $ npm install
    
> 或者直接进入Blog目录中，执行`hexo init`和`npm install`

### 修改Blog网站配置

初始化完成后，该Blog目录就会出现下面几个文件夹：

    |—— _config.yml
    |—— package.json
    |—— scanffolds
    |—— source
    |    |—— _posts
    |—— themes
    
> - _config.yml:
整个站点的**配置**信息：可以配置网站的title、author、language、目录、文章、日期、分页、扩展（主题名称、部署）信息
- package.json: 应用程序信息
- scanffolds: 模板文件夹,创建新文章时,Hexo会根据此建立文件
- source: 资源文件夹,存放用户资源
- themes: 主题文件夹，Hexo会根据此来生成静态页面，默认是官方的*landscape*主题

### 写Blog文章
执行下面的命令创建一篇新的文章:

    $ hexo new [layout] <title>

建立的文章后，在/source/_post里会出现该title的文章，之后的文章均保持在此目录

> 可选参数：文章布局layout，默认是post,可以修改_config.yml中的default_layout来修改默认布局
> 文章的默认布局有3种： post、page、draft，分别对应不同的路径：

Layout |    Path       
  --   |     --       
 post  | source/_posts  
 page  | source         
 draft | source/_drafts 
 
> 将草稿发布,执行下面publish命令， 将草稿移动到source/_post文件夹下：
> `$ hexo publish [layout] <title>`
> 草稿默认不会显示在页面中，执行时候加上--draft参数或render_drafts参数设置为true来预览草稿

### 生成网站

写完文章后，在cmd中执行下面命令生成静态文件，生成网站：

    $ hexo generate
 
生成网站后，会在Blog的根目录下生成一个pulic临时文件，存放生成的网站结果，可以通过`hexo clean`命令清除生成结果，然后再执行`hexo generate`重新生成

### 启动Hexo服务器

**Hexo3.0之后的版本把服务器独立成了单独的模块，必须先安装hexo-sever才能使用**:

    $ npm install hexo-server --save

> `--save`:安装的同时将信息写入package.json中项目路径中如果有package.json文件时，使用`npm install`方法就可以根据dependencies配置安装所有的依赖包，这样代码提交到github时，就不用提交node_modules这个文件夹了

安装hexo-server后，执行下面命令启动服务器,启动服务器之后，Hexo会自动监视文件变动并自动更新，无需重启服务器：

    $ hexo server

> 如果想更改服务器的端口(默认是4000)，或启动时遇到EADDRINUSE 错误可以加-p选项指定其他端口:
> `$ hexo server -p 3000`
> 服务器默认运行在0.0.0.0，可以覆盖默认的IP:  
> `$ hexo server -i 192.168.0.1`

启动服务之后，本地的Blog网站系统搭建完成，可以在输入以下网址查看Blog的搭建效果：http://localhost:4000 或 http://127.0.0.1:4000

### 小结
***
这样一个本地的Blog网站建立完成，每次需要写Blog时候，只需要`hexo new` (hexo n for short)一篇文章，再使用markdown编辑文章，然后`hexo generarte`(hexo g for short)即可，但是这样Blog只能在本地的机器上访问，要想让别人也可以通过网址访问，需要将Blog deploy部署到服务器上，具体方法见下篇
















