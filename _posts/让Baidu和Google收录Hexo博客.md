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
![g6](http://7xq8f9.com1.z0.glb.clouddn.com/pic/bd_1.PNG)

2.[进入百度站长](http://zhanzhang.baidu.com/site/index)的站点管理-添加网站，输入域名结果：
![g7](http://7xq8f9.com1.z0.glb.clouddn.com/pic%2Fbd_site_1.PNG)

3.百度站长工具有三种方式进行站点验证，最常用第一种下载验证文件方式，由于本人尝试每次都验证失败，所以采用第三种`CNAME`方式：
![g8](http://7xq8f9.com1.z0.glb.clouddn.com/pic%2Fbd_site_3.PNG)

- 登陆域名解析服务器（本人是`DNSPod`）增加一条`CNAME`记录：
![g9](http://7xq8f9.com1.z0.glb.clouddn.com/pic%2Fbd_site_5.PNG)
- 点击验证完成：
![g10](http://7xq8f9.com1.z0.glb.clouddn.com/pic%2Fbd_site_4.PNG)


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
![g11](http://7xq8f9.com1.z0.glb.clouddn.com/pic%2Fbd_site_6.PNG)

## 提交`Sitemap`文件
---

### `Google`搜索
---

在站点地图中提交上一步生成的`sitemap.xml`文件：
![g12](http://7xq8f9.com1.z0.glb.clouddn.com/pic/google_site10.PNG)

然后提交，正常提交结果如下图所示：
![g13](http://7xq8f9.com1.z0.glb.clouddn.com/pic/google_site12.PNG)

千万要注意博客的标题中不用包含XML的实体字符如`&`、`<`、` >`等等，否则提交之后，会提示解析错误：
![g14](http://7xq8f9.com1.z0.glb.clouddn.com/pic/google_site11.PNG)

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
![g15](http://7xq8f9.com1.z0.glb.clouddn.com/pic%2Fbd_site_8.PNG)

#### 自动推送

把如下的`JS`代码放在网页页面中即可：
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

# 等待处理
---

过几天之后，Google和Baidu就会处理你提交的站点，再次输入网址或相关关键字，就可以搜索到自己的博客了

Google可以搜索到自己的站点内容:
![g11](http://7xq8f9.com1.z0.glb.clouddn.com/pic/google_site_new.PNG)

Baidu也可以搜索到自己的站点内容:
![g11](http://7xq8f9.com1.z0.glb.clouddn.com/pic/google_site_new.PNG)







