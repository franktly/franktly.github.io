---
title: 让Baidu和Google收录Hexo博客
date: 2016-07-06
categories: 博客搭建
tags:
- 博客
- Hexo
- Next
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

1.登陆[Google Search Console](https://www.google.com/webmasters/tools/home "google search console")，输入需要验证的网站域名，默认有两种方式选择网域类型：
![gsc-login](gsc1.png)

2.`Search Console` DNS记录验证域名所有权:
![gsc-verify](gsc2.png)

3.在域名解析服务商即生成域名解析服务器的地方，而非域名提供商店上增加上一步选择的记录，本人选择的是`TXT`类型，DNSPod域名服务器：
![gsc-addrecord](gsc3.png)

4.检查网站，请求加入Google编入索引：
![gsc-check](gsc4.png)

## `Baidu`搜索
---

1.[百度站长](https://ziyuan.baidu.com/site/index)的站点管理-添加网站，输入域名结果：
![bd](bd1.png)

2.百度站长工具有三种方式进行站点验证，本人采用第三种`CNAME`方式：
![bd](bd2.png)

3.登陆域名解析服务器（本人是`DNSPod`）增加一条`CNAME`记录：
![bd](bd3.png)


# 提交`Sitemap`
---

## 生成`Google`和`Baidu` `Sitemap`文件
---

`Sitemap`是一种文件，可以通过该文件列出您网站上的网页，从而将您网站内容的组织架构告知`Google`和`Baidu`等搜索引擎，以便更加智能的抓取你的网站信息

### 安装`hexo sitemap`插件
---

命令行输入如下命令：

    npm install hexo-generator-sitemap // Google 
    npm install hexo-generator-baidu-sitemap // Baidu


### 修改博客配置文件
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
![bd](bd5.png)

## 提交`Sitemap`文件
---

### `Google`搜索
---

在站点地图中提交上一步生成的`sitemap.xml`文件：
![gcs-sitemap](gsc5.png)

> 千万要注意博客的标题中不用包含XML的实体字符如`&`、`<`、` >`等等，否则提交之后，会提示解析错误：

### `Baidu`搜索
---

百度支持三种自动提交方式：
**主动推送**、**自动推送**和**sitemap**提交，三者的搜索发现的效率和难度依次递减

>如何选择链接提交方式
1 主动推送：最为快速的提交方式，推荐您将站点当天新产出链接立即通过此方式推送给百度，以保证新链接可以及时被百度收录。
2 自动推送：最为便捷的提交方式，请将自动推送的JS代码部署在站点的每一个页面源代码中，部署代码的页面在每次被浏览时，链接会被自动推送给百度。可以与主动推送配合使用。
3 sitemap：您可以定期将网站链接放到sitemap中，然后将sitemap提交给百度。百度会周期性的抓取检查您提交的sitemap，对其中的链接进行处理，但收录速度慢于主动推送。
4 手动提交：一次性提交链接给百度，可以使用此种方式。

#### `Baidu Sitemap`

在站点地图的自动提交选项卡的`sitemap`部分中提交上一步生成的`sitemap.xml`文件的地址，点击提交即可：
![bd-sitemap](bd4.png)

#### 自动推送

一般的Hexo主题如Next的主题配置文件`_config.yml`提供了baidu Push 功能字段，直接将该字段设置为`true`即可：

    baidu_push: true

若没有该字段，则把如下的`JS`代码放在网页页面中即可：
```
<script>
(function(){
    var bp = document.createElement('script');
    var curProtocol = window.location.protocol.split(':')[0];
    if (curProtocol === 'https') {
        bp.src = 'https://zz.bdstatic.com/linksubmit/push.js';        
    }
    else {
        bp.src = 'http://push.zhanzhang.baidu.com/push.js';
    }
    var s = document.getElementsByTagName("script")[0];
    s.parentNode.insertBefore(bp, s);
})();
</script>
```

>最好把上述代码放在hexo生成的每个页面的公共部分,本博客放在`blog\themes\next\layout\_layout.swig`的`<body>`标签的最后面

#### 主动推送

需要编写主动推送代码，[**主动推送编写示例**](http://zhanzhang.baidu.com/college/courseinfo?id=267&page=2#h2_article_title8)

# 添加`robots.txt`文件
---

在博客`source`文件夹下增加robots.txt文件，内容如下所示：
```
    User-agent: *
    Allow: /
    Allow: /categories/
    Allow: /tags/
    Allow: /archives/
    Allow: /about/
    
    Disallow: /vendors/
    Disallow: /js/
    Disallow: /css/
    Disallow: /fonts/
    Disallow: /vendors/
    Disallow: /fancybox/
    
    Sitemap: http://your_domain_name/sitemap.xml
    Sitemap: http://your_domain_name/baidusitemap.xml
```

# 等待处理
---

过几天之后，Google和Baidu就会处理你提交的站点，再次输入网址或相关关键字，就可以搜索到自己的博客了
![search](google.png)

