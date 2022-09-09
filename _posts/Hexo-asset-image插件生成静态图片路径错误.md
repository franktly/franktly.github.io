---
title: Hexo-asset-image插件生成静态图片路径错误
date: 2019-09-09
categories: 博客搭建
tags:
- Hexo
- 博客
- Next
---

## 前言
***
之前都在是Linux环境下搭建Hexo博客，用`Hexo new page [page name]` 来新建文章，执行该命令时候，会同时生成一个文章名称相同文件夹，该文件夹用来存放与此篇博客相关的资源文件，常用的如图片等，在博客里面引用图片使用的是相对路径，这样方便每篇博客文章和相应的图片资源一起分类管理。但是切换到Windows环境下搭建Hexo博客写文章，用同样的方式却无法加载出图片。

<!--more-->

## 问题描述
---
之前写的博客[Hexo博客保存与恢复](/2016/09/02/Hexo博客保存与恢复/index.html)文章中**博客图片相对路径配置问题**章节内总结了使用相对路径法存博客图片资源，分以下两步骤：
首先安装`Hexo-asset-image`插件：
    
    npm install hexo-asset-image --save
然后，修改站点配置文件_config.yml:

    post_asset_folder: true

此方法在Linux环境下工作正常，但是切换到Windows环境下写Hexo博客，出现如下无法加载出图片现象：
![load-picture-error](load-picture-error.png)

## 问题分析
---
1. 在`Hexo s -g`本地生成部署或`Hexo d -g`服务器生成部署时候，都显示如下生成图片绝对路径的打印：
![hexo-gen-abs-path](hexo-gen-abs-path.png)

2.打开浏览器开发者模式，调试发现生成的绝对路径错误：
![web-debug1](web-debug1.png)
![web-debug2](web-debug2.png)

## 问题解决
---
1. 打开`hexo-asset-image`文件源代码处：
```
    cd blog_root_dir
    cd node_modules/hexo-asset-image/
    vim index.js
```

2. 在`index.js`文件58行左右，修改如下，注释掉错误的两行，增加正确的绝对图片路径两行代码如下：
```
            // $(this).attr('src', config.root + link + src);
            // console.info&&console.info("update link as:-->"+config.root + link + src);
             $(this).attr('src', data.permalink+ src);
             console.info&&console.info("update link as:-->"+data.permalink+ src);
 
```

## 參考

[xcodebuild-hexo-asset-image](https://github.com/xcodebuild/hexo-asset-image)

[hexo-asset-image-for-hexo5](https://www.npmjs.com/package/hexo-asset-image-for-hexo5)

[Hexo-asset-image踩坑](https://www.4k8k.xyz/article/qq_42009500/118788129)

[asset-folders](https://hexo.io/docs/asset-folders.html)


