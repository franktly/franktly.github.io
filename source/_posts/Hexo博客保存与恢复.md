---
title: Hexo博客保存与恢复
date: 2016-09-02
categories: 博客搭建
tags: 
- Hexo 
- GitHub 
- 博客 
- Next
---

## 前言
***
Hexo博客由于文章和博客网站的一些配置主要在本地，因此对于电脑系统重装或更换电脑情况下需要重新搭建比较麻烦，因此有必要将文章或一些博客配置进行相应的备份，同时记录一下一些关键点，方便后续迁移博客到其他系统和电脑上。

<!--more-->

## 博客文件备份
***

前面搭建Hexo博客的文章中使用GitHub托管了通过文章源码和一些Hexo站点配置文件，主题配置文件生成的静态网站，但是文章源码和这些站点本身的配置信息并没有被保存下来，而这却是恢复和迁移网站的主要文件，因此方便，可以在原本的博客仓库新加一个分支保存这些恢复和迁移的必要信息。

如原来生成的静态网址默认是保存在your_blog_name/your_blog_name.github.io的master分支，可以在原有的基础上增加一个hexo分支保存网址原始数据,并将这个分支设置为默认分支，这样每次恢复和迁移文件时候只需要git clone即可获取迁移的文件了。

备份具体操作如下面步骤所示:

### 本地克隆检出博客的仓库

    git clone https://github.com/your_blog_name/your_blog_name.github.io.git

### 创建新的远程hexo分支

    git checkout -b  hexo
    git push origin hexo:hexo

> git checkout -b hexo 本地新建分支hexo,并切换到该分支,等同于git branch hexo; git checkout hexo； git push origin hexo:hexo 提交本地新建分支hexo到远程服务器hexo分支(origin是默认远程主机名)；
> git push origin :hexo或者 git push origin --delete hexo 删除远程分支hexo；
> git branch 可以查看当前分支；
> git branch -a 可以查看所有分支(包括远程分支)；

### 备份必要的源文件
将Hexo目录下的`_post`文件夹(包含.md结尾的博客原文), 博客的站点配置文件`_config.yml` 和Next主题配置文件`_config.yml`通过新建的hexo分支提交即可,当然还可以备份自己觉得必要的一些文件如图片，其他文本文件

    git checkout  hexo  
    back up your hexo src file
    git add .
    git commit -m . "back up my hexo src file"
    git push origin hexo:hexo
    git checkout -b hexo 切换到hexo分支;

## 博客文件恢复
***
博客文件备份后，对于重装系统或更换电脑了需要重新恢复博客搭建，包括以下一些步骤。

### 安装必要的软件
安装Hexo博客必要的软件包括git, node.js, hexo, Next等安装及运行。

#### git 安装

    sudo apt-get update
    sudo apt-get install git 
    git config --global usr.name "Your Name"
    git config --global usr.email "youremail@domain.com"
    git config --list  // 查看配置信息
    ssh-keygen -C  "youremail@domain.com" -t rsa  // 在~/.ssh下创建私钥和公钥,将公钥拷贝到github的博客仓库的Deploy Key中

#### node.js安装
官网下载二进制文件解压，设置路径安装或源码安装。

#### hexo安装和配置

    sudo apt-get update
    npm install -g hexo-cli
    hexo init your_blog_folder
    cd your_blog_folder
    npm install

#### Next安装和配置

    cd your_blog_folder
    git clone https://github.com/next-theme/hexo-theme-next themes/next

> Next主题仓库经过了几次变更，最新的仓库名称地址为: https://github.com/next-theme/hexo-theme-next
> Next主题升级方法:https://theme-next.js.org/docs/getting-started/upgrade

### 恢复博客站点和Next主题配置文件
将备份的博客站点和Next主题配置文件替换新的hexo博客和Next主题,将备份的_post文件夹替换新的文件夹。
> 注意有时候hexo或Next版本升级后配置文件格式会有一些差异，注意替换前比较一下这些差异

### 一些额外修改配置
#### 修复配置tags, categories,页面跳转问题
1) 新增加页面
    ```
    hexo new page tags/categories
    ```
2) 在新加的页面index.md里面增加以下行更改页面类型
    ```
    type: "tags" or "categories"
    ```
#### 修复local search功能
1) 安装搜索插件
    ```
    npm install hexo-generator-searchdb --save
    ```
2) 确保站点配置文件增加了以下配置
    ```
    search:
    path: search.xml
    field: post
    format: html
    limit: 10000
    ```
3) 确保主题配置文件增加了以下配置
    ```
    local_search:
        enable: true
    ```

#### Hexo Deploy权限问题
1) 安装deploy git 插件
    ```
    npm install hexo-deployer-git --save
    ```
2) 确保站点配置文件进行了git类型配置
    ```
    deploy:
    type: git
    repo:
        #github:  https://github.com/franktly/franktly.github.io.git,master
        github:  git@github.com:franktly/franktly.github.io.git,master
        #gitcafe: https://git.coding.net/franktly/franktly.git,gitcafe-pages
        gitcafe: git@git.coding.net:franktly/franktly.git,gitcafe-pages
    ```

> 确保之前的ssh私钥和公钥已经生成和配置
> 若git协议不行可以试试https协议

#### 博客图片相对路径配置问题
图片除了可以放在统一的images文件夹中，还可以放在文章自己的目录中, 即相对路径配置方法,文章的目录可以通过站点配置文件_config.yml来生成:

    post_asset_folder: true
将_config.yml文件中的配置项post_asset_folder设为true后，执行命令`$ hexo new post_name`，在`source/_posts`中会生成文章post_name.md和同名文件夹post_name。将图片资源放在post_name中，文章就可以使用相对路径引用图片资源了。

    ![image_desp](image.jpg)

#### 搜索SEO优化
搜索SEO优化方法见让[Baidu和Google收录Hexo博客](/2016/07/06/Hexo博客搜索引擎搜索优化/index.html)

## 总结
***
基本上通过以上几个步骤就可以在较短的时间内将Hexo博客迁移到一个新的系统环境上，这样不用每次重装系统或更换电脑都折腾配置和软件。

