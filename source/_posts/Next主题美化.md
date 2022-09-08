---
title: Next主题美化
date: 2020-09-06
categories: 博客搭建
tags:
- 博客
- Hexo
- Next
---

## 前言
***
Next主题默认配置满足基本的写作需求，有时候需要根据自定义配置让Next主题按照自己喜欢的方式呈现或增加一些额外的实用功能
<!--more-->

## Next主题版本
***
Next主题GitHub仓库经过了几次大的变更，以前的仓库由于作者不维护了或者维护的比较少或者仓库管理权限问题，导致仓库地址经常变动，最新的仓库地址为[hexo-theme-next](https://github.com/next-theme/hexo-theme-next)

> 如果需要了解各个版本和Hexo的兼容性即升级方法可以访问官方[Upgrade](https://theme-next.js.org/docs/getting-started/upgrade)

## 侧边栏设置
***
### 侧边栏一直显示

    sidebar:
      display: always
> 左边的侧边栏一直显示，`post`默认打开文章显示

### 增加侧边栏阅读进度及回顶端

    back2top:
      enable: true
      sidebar: true
      scrollpercent: true

## 增加右上角GitHub入口
***

    github_banner:
      enable: true
      permalink: https://github.com/your_github_name

## 隐藏powered By Hexo
***

     powered: false

## 添加文章版权声明
***

    creative_commons:
      post: true
    
## 显示文章字数统计
***

1.`Hexo`根目录安装插件:

    npm install hexo-symbols-count-time
2.修改`Next`配置文件:

    symbols_count_time:
      separated_meta: true
      item_text_total: true

## 增加评论系统    
***
静态博客的评论系统比较多，本文选取了[Waline](https://github.com/walinejs/waline)作为博客评论系统，`Waline`的官方教程: [Waline Org](https://waline.js.org)
常用的部署`Waline`评论系统有以下几种方式:

### Vercel + LeadCloud
该方案使用`Vercel`作为服务器，`LeadCloud`作为默认数据库配置`Waline`评论系统,主要缺点是`Vercel`服务器自带的域名国内无法访问，需要自己绑定备案的域名，且`LeadCloud`国内版也需要备案域名或国际版经常被屏蔽无法访问，所以搭建国内使用的评论系统没有备案的域名访问起来很不稳定，配置方法见[Vercel-LeadCloud快速上手](https://waline.js.org/guide/get-started.html)

### Railway + PostSQL
该方案使用`Railway`作为服务器，`PostSQL`作为数据库配置`Waline`评论系统,由于两者都是对国内比较友好的方案，所以本人选取了此方案，且`Railway`可以直接通过授权`GitHub`账户进行配置，里面也自带了`PostSQL`作为数据库存储评论系统的用户信息和评论信息，配置方式相对简单，具体方法见[Railway部署](https://waline.js.org/guide/server/railway.html)

> 更新Waline版本方法：进入到个人的GitHub 仓库中，修改`package.json`文件中的`@waline/vercel`版本号为最新版本即可

### 其他服务器+数据库独立部署
其他的方案包括使用`CloudBase`腾讯云开发部署，`Deta`部署等方式，数据库也除了默认`LeadCloud`还支持多种其他数据库，包括`MySQL`,`PostSQL`,`SQLite`及`MongoDB`等等，这些服务器和数据库组合起来独立部署相对来说操作比较复杂，具体搭建方法，也可以通过官方的指南进行部署
