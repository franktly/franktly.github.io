---
title: Hexo同时部署在Coding和GitHub上并DNSPod分流
date: 2016-7-6
categories: 博客搭建
tags:
- 博客
---

# 前言
---

在使用Github服务器部署的Hexo博客之后，由于国内访问GitHub的速度比较慢，且百度搜索屏蔽了Github网页的搜索，为了使和博客网站同时高质量的支持国内和国外的访问及搜索体验，即对于国内的访问可以使用国内版的代码托管Coding（GitCafe是其前身）来提供服务，对于国外的访问仍然使用Github来提供服务。对于访问同一个Godday注册的域名，可以使用第三方的域名解析服务器DNSPod来做解析分流，对于不同的路线（国内或国外）访问不同的网站服务（Coding或GitHub）

<!--more-->


# Coding服务使用
---

## 注册Coding账户
---

此步忽略

## 新建Coding项目
---
和使用GitHub做部署一样，需要新建一个与用户名同名的项目，如下所示：



# DNSPod服务使用
---


1.未验证之前的Google搜索结果：
![g1](http://7xq8f9.com1.z0.glb.clouddn.com/pic/google1.PNG)
> 输入的网站Google无法识别

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

# 等待Google处理
---

过几天之后，Google就会处理你提交的站点，再次输入网址或相关关键字，就可以搜索到自己的博客了：
![g11](http://7xq8f9.com1.z0.glb.clouddn.com/pic/google_site_new.PNG)
> Google可以搜索到自己的站点内容


























