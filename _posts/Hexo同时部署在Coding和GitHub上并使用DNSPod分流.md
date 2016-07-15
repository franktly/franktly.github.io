---
title: Hexo同时部署在Coding和GitHub上并使用DNSPod分流
date: 2016-7-5
categories: 博客搭建
tags:
- 博客
---

# 前言
---

在使用Github服务器部署的Hexo博客之后，由于国内访问GitHub的速度比较慢，且百度搜索屏蔽了Github网页的搜索，为了使和博客网站同时高质量的支持国内和国外的访问及搜索体验，即对于国内的访问可以使用国内版的代码托管Coding（GitCafe是其前身）来提供服务，对于国外的访问仍然使用Github来提供服务。对于访问同一个Godday注册的域名，可以使用第三方的域名解析服务器DNSPod来做解析分流，对于不同的路线（国内或国外）访问不同的网站服务（Coding或GitHub）

<!--more-->


# 部署Hexo博客到Coding服务器
---

## 注册Coding账户
---

此步忽略

## 新建Coding项目
---

和使用`GitHub`做部署一样，需要新建一个与用户名同名的项目`franktly`，如下所示：
![coding_1](http://7xq8f9.com1.z0.glb.clouddn.com/pic/gitcafe_1.PNG)

## 添加SSH公钥
---
和使用`GitHub`做部署一样，也需要`SSH`公钥，由于部署`GitHub`时候已经生成了，可以直接使用其公钥（见之前[**使用Hexo搭建个人博客-2**](/2016/01/09/使用Hexo搭建个人博客-2)篇），操作如下所示：
![coding_2](http://7xq8f9.com1.z0.glb.clouddn.com/pic/gitcafe_2.PNG)

添加成功提示：
![coding_3](http://7xq8f9.com1.z0.glb.clouddn.com/pic/gitcafe_3.PNG)

## 配置网站全局yml配置文件
---

修改yml配置文件的deploy部分如下图所示：

        # Deployment
        ## Docs: https://hexo.io/docs/deployment.html
        deploy:
          type: git
          repo:
            github:  https://github.com/franktly/franktly.github.io.git,master
            gitcafe: https://git.coding.net/franktly/franktly.git,gitcafe-pages
        plugins: hexo-generator-sitemap

>修改repo仓库字段，在原来github后面增加`gitcafe`（沿用原来GitCafe的）或`coding`（Coding新的）字段，后面跟着`coding`服务的git地址和分支名字，分支名字可以是`gitcafe-pages`（沿用原来GitCafe的）或`master`（Coding新的）

配置完成后，使用`hexo d -g `命令重新生成和部署静态网页:
![coding_4](http://7xq8f9.com1.z0.glb.clouddn.com/pic/gitcafe_5.PNG)

>可以看到本地编辑的博客生成的静态网页文件同时部署到`Github`和`Coding`服务上去了

每次输入`hexo d`部署时候，需要输入用户名和密码，挺麻烦的，可以通过一下方式解决:
1.在系统环境变量中增加如下环境变量

    变量名： HOME，变量值：%USERPROFILE%

2.在计算机用户目录（`C：\Users\username`）新建一个名为`_netrc`文件（若存在此步新建操作和第1步略去），然后编辑文件增加以下内容即可：

        machine github.com               // Github部署
          login your_github_user_name
          password your_github_password
        machine git.coding.net          // Coding部署
          login your_coding_user_name
          password your_coding_user_password     

## 配置Coding Page服务
---

网页文件部署到`Coding`托管成功后，最后还需要开启`Coding`的`Pages`服务功能，同时部署的分支与`yml`配置文件里面的`Coding`仓库分支要**保持一致**，如下图所示：
![coding_5](http://7xq8f9.com1.z0.glb.clouddn.com/pic/gitcafe_7.PNG)

>必须与yml配置的分支的名字保持一致

配置成功后，即可以通过`http://franktly.coding.me`或`http://franktly.coding.me/franktly`（本人的用户名是`franktly`,对于其他用户名直接替换之即可）来访问部署到`Coding`的博客了

开启`Coding Pages`服务后，可以继续添加`Coding`服务与`Godday`注册的域名`www.franktly.com`的绑定：
![coding_5_2](http://7xq8f9.com1.z0.glb.clouddn.com/pic/gitcafe_6.PNG)

>此时即使绑定了`Godday`注册的域名，但是如果直接访问该域名，仍然走的不是`Coding`部署的服务，而是之前在`Godday`配置的`Github`服务，要想同时支持一个注册域名和两种服务需要使用`DNSPod`来对于不同路径进行服务分流



# DNSPod服务配置
---

经过上述的配置之后，可以通过`Coding`给定的`.coding.me`形式的域名网址来访问`hexo`博客，就像使用`Github`给定的`.github.io`形式的来访问`hexo`博客一样。但是对于直接访问`Godday`注册的本人博客网址`www.franktly.com`仍然是使用`Github`的服务访问的，因为在`Godday`的之前`CNAME`配置中（见之前[**使用Hexo搭建个人博客-2**](/2016/01/09/使用Hexo搭建个人博客-2)篇）有一条之前配置的的从`Github`给定的域名到`Godday`注册的域名的`CNAME`记录，且`Godday`的域名解析服务器没有配置，使用的是默认的域名解析服务器，该默认的服务器按照这条来解析的

为了解决这个问题，可以通过第三方的域名解析服务器`DNSPod`来解决

## 注册DNSPod账户
---

此步忽略

## 添加域名
---
如下图所示，点击其中的添加域名按钮，输入从`Godday`注册的域名，本博客为`frantly.com`:
![coding_6](http://7xq8f9.com1.z0.glb.clouddn.com/pic/gitcafe_8.PNG)

添加域名之后，`DNSPod`会自动扫描你在`GoDaddy`域名面板添加的域名的记录，并导入到`DNSPod`后台。点击“确定“自动导入就行了

## 添加CNAME记录
---
接着点击其中的添加记录按钮，对于`Coding`和`Github`给定的格式域名分别添加国内和国外两条线路的`CNAME`记录，结果如下图所示:
![coding_7](http://7xq8f9.com1.z0.glb.clouddn.com/pic/gitcafe_9.PNG)

>记住`DNSPod`自动导入的主机记录为`@`，记录类型为`NS`的两条不可编辑的记录，后续修改`Godday`域名服务时候会用到

## 修改注册域名`Godday`的域名解析服务器
---
1.进入`Godday`的`MyProduct`页面，点击的`Domains`选项卡的`Manage DNS`按钮：
![coding_8](http://7xq8f9.com1.z0.glb.clouddn.com/pic/gitcafe_11.PNG)

2. 找到`NameServers`部分，修改域名解析服务从以前的默认变为自定义`Custom`，同时添加之前`DNSPod`自动导入的两条类型为`NS`的记录，点击保存，如下图所示：
![coding_9](http://7xq8f9.com1.z0.glb.clouddn.com/pic/gitcafe_10.PNG)

配置完成后，等几分钟，国内也可以快速使用注册的域名访问自己搭建的`hexo`博客了。

# 总结
---

至此，博客同时部署到国内的`Coding`和国外的`Github`服务器上去了，使用`DNSPod`分流技术，可以自动选择国内和国外路径，加快了`hexo`博客在国内的访问速度和用户体验









