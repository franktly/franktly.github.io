---
title: Hexo增加Google网页搜索
date: 2016-7-5
categories: Tools
tags:
- 博客搭建
---

# 前言
---

搭建自己的博客，然后写了几十篇文章，悲催的是发现用搜索引擎无法搜索到自己的博客网站。按照网上的方法和自己的摸索，下面以Google搜索为例简单介绍了下怎么让搜索引擎搜到自己博客网站的方法（由于hexo博客是部署在Github上的，百度搜索对外网Github有屏蔽，故以Google为例）

<!--more-->


# 验证网站 
---

1.未验证之前的Google搜索结果：
![g1](http://7xq8f9.com1.z0.glb.clouddn.com/pic/google1.PNG)

2.登陆[Google Search Console](https://www.google.com/webmasters/tools/home "google search console")，输入需要验证的网站域名：
![g2](http://7xq8f9.com1.z0.glb.clouddn.com/pic/google_site1.PNG)

3.Search Console会推荐使用域名提供商方式进行验证(自己的博客域名是在GoDaddy上购买的)：
![g3](http://7xq8f9.com1.z0.glb.clouddn.com/pic/google_site2.PNG)

还可以选择其他的验证方式：
![g3_2](http://7xq8f9.com1.z0.glb.clouddn.com/pic/google_site3.PNG)

4.确认Accept Google Access:
![g4](http://7xq8f9.com1.z0.glb.clouddn.com/pic/google_site4.PNG)

5.验证完成：
![g5](http://7xq8f9.com1.z0.glb.clouddn.com/pic/google_site6.PNG)

# 提交`Sitemap`
---

## 生成`Sitemap`文件
---

有如下两种方式生成`Sitemap`文件

### 修改博客配置文件生成
---

在`_config.yml`全局配置文件中增加下面一行命令：

        plugins: hexo-generator-sitemap

然后重新`hexo g `博客即可以在博客的`public`文件夹下生成`sitemap.xml`文件：
![g6](http://7xq8f9.com1.z0.glb.clouddn.com/pic/google_site0.PNG)

### 命令行生成
---

命令行输入如下命令：

    npm install hexo-generator-sitemap

生成过程：
![g7](http://7xq8f9.com1.z0.glb.clouddn.com/pic/google_site9.PNG)

同样在博客的`public`文件夹下生成`sitemap.xml`文件了

## 提交`Sitemap`文件
---

在站点地图中提交上一步生成的`sitemap.xml`文件：
![g8](http://7xq8f9.com1.z0.glb.clouddn.com/pic/google_site10.PNG)

然后提交，正常提交结果如下图所示：
![g9](http://7xq8f9.com1.z0.glb.clouddn.com/pic/google_site12.PNG)

千万要注意博客的标题中不用包含XML的实体字符如`&`、`<`、` >`等等，否则提交之后，会提示解析错误：
![g10](http://7xq8f9.com1.z0.glb.clouddn.com/pic/google_site11.PNG)

## 等待Google处理
---

过几天之后，Google就会处理你提交的站点，再次输入网址或相关关键字，就可以搜索到自己的博客了：
![g11](http://7xq8f9.com1.z0.glb.clouddn.com/pic/google_site_new.PNG)



























