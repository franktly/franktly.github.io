---
title: 让Baidu和Google收录Hexo博客
date: 2016-7-6
categories: 博客搭建
tags:
- 博客
---

# 前言
---

搭建自己的博客，然后写了几十篇文章，悲催的是发现用搜索引擎无法搜索到自己的博客网站。按照网上的方法和自己的摸索，下面以`Baidu`和`Google`搜索为例简单介绍了下怎么让搜索引擎搜到自己的博客网站（由于`hexo`博客是同时部署在`Github`和`Coding`上的，虽然百度搜索对外网`Github`有屏蔽，但仍然可以通过`Coding`搜索到）

<!--more-->



---

# 验证网站 
---

## `Google`搜索
---

1.未验证之前的`Google`搜索结果：
![g1](http://7xq8f9.com1.z0.glb.clouddn.com/pic/google1.PNG)
> 输入的网站Google无法识别

2.登陆[Google Search Console](https://www.google.com/webmasters/tools/home "google search console")，输入需要验证的网站域名：
![g2](http://7xq8f9.com1.z0.glb.clouddn.com/pic/google_site1.PNG)

3.`Search Console`会推荐使用域名提供商方式进行验证(自己的博客域名是在`GoDaddy`上购买的)：
![g3](http://7xq8f9.com1.z0.glb.clouddn.com/pic/google_site2.PNG)

还可以选择其他的验证方式：
![g3_2](http://7xq8f9.com1.z0.glb.clouddn.com/pic/google_site3.PNG)

4.确认`Accept Google Access`:
![g4](http://7xq8f9.com1.z0.glb.clouddn.com/pic/google_site4.PNG)

5.验证完成：
![g5](http://7xq8f9.com1.z0.glb.clouddn.com/pic/google_site6.PNG)

## `Baidu`搜索
---
1.未验证之前的`Baidu`搜索结果：
![g1](http://7xq8f9.com1.z0.glb.clouddn.com/pic/google1.PNG)

2.[进入百度站长](http://zhanzhang.baidu.com/site/index)的站点管理-添加网站：
![g13](http://7xq8f9.com1.z0.glb.clouddn.com/pic/google1.PNG)

3.百度站长工具会推荐一下三种方式进行网页验证，最常用第一种下载验证文件方式，由于本人尝试每次都验证失败，所以采用第三种CNAME方式
- 登陆域名解析服务器（本人是DNSPod）增加一天CNAME记录：

- 点击验证完成：


## 提交`Sitemap`
---

### 生成`Google`和`Baidu` `Sitemap`文件
---

`Sitemap`是一种文件，可以通过该文件列出您网站上的网页，从而将您网站内容的组织架构告知`Google`和`Baidu`等搜索引擎，以便更加智能的抓取你的网站信息

#### 安装`hexo sitemap`插件
---

命令行输入如下命令：

    npm install hexo-generator-sitemap // Google 
    npm install hexo-generator-baidu-sitemap // Baidu

安装过程：
![g7](http://7xq8f9.com1.z0.glb.clouddn.com/pic/google_site9.PNG)


#### 修改博客配置文件
---

在`_config.yml`全局配置文件中增加如下文本：

    # Extensions
    Plugins: 
    \- hexo-generator-sitemap
    # 自动生成sitemap
    sitemap:
      path: sitemap.xml
    baidusitemap:
      path: baidusitemap.xml

然后重新`hexo g `博客即可以在博客的`public`文件夹下生成`sitemap.xml`和`baidusitemap.xml`文件：
![g6](http://7xq8f9.com1.z0.glb.clouddn.com/pic/google_site0.PNG)

### 提交`Sitemap`文件
---

#### `Google`搜索
---

在站点地图中提交上一步生成的`sitemap.xml`文件：
![g8](http://7xq8f9.com1.z0.glb.clouddn.com/pic/google_site10.PNG)

然后提交，正常提交结果如下图所示：
![g9](http://7xq8f9.com1.z0.glb.clouddn.com/pic/google_site12.PNG)

千万要注意博客的标题中不用包含XML的实体字符如`&`、`<`、` >`等等，否则提交之后，会提示解析错误：
![g10](http://7xq8f9.com1.z0.glb.clouddn.com/pic/google_site11.PNG)

#### `Baidu`搜索
---


## 等待Google处理
---

过几天之后，Google就会处理你提交的站点，再次输入网址或相关关键字，就可以搜索到自己的博客了：
![g11](http://7xq8f9.com1.z0.glb.clouddn.com/pic/google_site_new.PNG)
> Google可以搜索到自己的站点内容

# 让Baidu收录博客
---

## 添加站点
---
1.未添加之前的Baidu搜索结果：
![g12](http://7xq8f9.com1.z0.glb.clouddn.com/pic/google1.PNG)
> 输入的网站Google无法识别

2.[进入百度站长](http://zhanzhang.baidu.com/site/index)的站点管理-添加网站：
![g13](http://7xq8f9.com1.z0.glb.clouddn.com/pic/google1.PNG)



## 验证网站 
---



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

## 提交`Sitemap`
---

### 生成`Sitemap`文件
---

有如下两种方式生成`Sitemap`文件

#### 修改博客配置文件生成
---

在`_config.yml`全局配置文件中增加下面一行命令：

        plugins: hexo-generator-sitemap

然后重新`hexo g `博客即可以在博客的`public`文件夹下生成`sitemap.xml`文件：
![g6](http://7xq8f9.com1.z0.glb.clouddn.com/pic/google_site0.PNG)

#### 命令行生成
---

命令行输入如下命令：

    npm install hexo-generator-sitemap

生成过程：
![g7](http://7xq8f9.com1.z0.glb.clouddn.com/pic/google_site9.PNG)

同样在博客的`public`文件夹下生成`sitemap.xml`文件了

### 提交`Sitemap`文件
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
> Google可以搜索到自己的站点内容

























