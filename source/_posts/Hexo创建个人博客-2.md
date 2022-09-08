---
title: 使用Hexo搭建个人博客(2)
date: 2016-01-09
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
上一篇介绍了使用Hexo在本地搭建的过程，本篇将本地搭建的博客网站部署到服务器去，常见的服务器有:
- [GitHub](https://github.com/)
- [Heroku](https://www.heroku.com/)
- ...

本文选用使用比较多的GitHub作为目标服务器

<!--more-->

## GitHub简介
***
[GitHub](https://github.com/)是Git工具的远程库，托管各种Git库，并提供Web界面。GitHub为一个项目贡献代码非常简单：首先点击项目站点的“fork”的按钮，然后将代码检出并将修改加入到刚才分出的代码库中，最后通过内建的“pull request”机制向项目负责人申请代码合并，GitHub是软件开发人员的Facebook

## GitHub注册
***
> 已有账户的忽略此步

### 注册GitHub账号

### 建立GitHub Pages

对于[GitHub Pages](https://pages.github.com/)分两种：
* 用户&组织页：根据GitHub用户名建立的`username.github.io`的repository,如笔者的仓库名为`franktly.github.io`,此时网页使用的是该仓库的master分支
* 项目页: 比前者稍微麻烦些，需要在新的或已有的repository上新建一个gh-pages分支，具体方法见[GitHub Pages 官网](https://pages.github.com/)

这次我们选择第一种**用户&组织页**类型的GitHub Pages

### 设置GitHub SSH Key

#### 本地设置git邮箱、用户名和密码

    git config --global user.email "your_email_addr"
    git config --global user.name  "user_name"

#### 本地创建SSH Key

    ssh-keygen -t rsa -C "your_email@your_email.com"

> 首先打开用户根目录（用户根目录一般为为C:\Users\username）查看是否已经有了SSH Key的文件夹`.ssh`,若有了先备份下，

#### 添加生成的SSH Key到GitHub账户
打开在当前用户的根目录下生成的`.ssh`文件里面的ssh.pub（ssh 公钥）,拷贝其内容到[Account setting -> SSH Keys -> Add SSH Key]

#### 验证下SSH是否设置成功

    ssh -T git@github.com

第一次提示不能连接，直接输入yes即可

![SSH_SET](SSH-Key.PNG)

## GitHub部署
***
建立GitHub Pages之后，即可以将本地搭建的Hexo网站部署到GitHub上去

### 修改站点_config.yml配置文件
如下面所示：类型配置为git，仓库地址为建立的GitHub Pages仓库地址，分支为master

    deploy:
    type: git
    repo: https://github.com/username/username.github.io.git
    branch: master
    
### 执行部署命令

    $ hexo deploy

> 可以使用`-g，--generate`可选参数部署之前预先生成静态文件

在GitHub上部署完成之后，以后别人也可以通过http://username.github.io网站访问你的个人博客网站了

## 域名绑定
***

### Godaddy域名申请
如果想使用自己申请的域名来访问GitHub上部署的个人博客，可以先到[Godaddy](https://www.godaddy.com/)上申请域名,笔者申请的域名为[http://www.taolingyang.com](http://www.taolingyang.com)

Godaddy的域名申请一般分为：
1. Search Domain： 查找自己想要申请的域名，若未被别人申请才行
2. Select Extensions: 选择域名的扩展名，有.com、.net等等可以选择
3. Continue To Chart: 选择提供的相应的服务去付款，支持支付宝支付

### Godaddy域名设置
申请成功后，需要设置Godaddy的域名，将申请到的域名关联到username.github.io网址上,具体步骤如下：
1) 打开个人Godday主页查看购买的Products:

![gd-product](godaddy1.png)

2) 选择管理DNS，在DNS Records中选择Add:

![gd-add](godday2.png)

3) 在新建的Record中增加A记录类型，主机记录类型为`@`:IP地址为GitHub Page Docs中的第5项列的A记录IP地址，四个地址全部依次添加,总共添加4条IP记录:

![gd-ip1](godaddy3.png)

![gd-ip2](godaddy4.png)

4) 最后新建一条CNAME记录类型，主机记录类型为`www`,值为github pages地址,如username.github.io形式,TTL默认:

![gd-cname](goddady6.png)

### GitHub域名设置

#### GitHub Page自定义域名添加
在GitHub Page配置中的Custom domain中填入Godday申请的域名，如本人的为`www.taolingyang.com`:

![gd-domain](godaddy5.png)

> 输入完成后GitHub Page会自动Check DNS，若Check Success说明设置成功

#### Hexo CNAME文件添加
在GitHub端也相应的设置下域名，只需在本地博客的根目录下source文件夹下增加一个CNAME文件，文件内容为你申请的域名地址，如本人的是：`www.taolingyang.com`.
> 本地根目录下的source文件夹下的增加CNAME文件后，需要重新执行下`hexo deploy`命令将CNAME文件部署到GitHub服务器才能生效，成功后，一般需要等十几分钟左右才能通过新申请的域名访问你的博客
> 放到博客根目录的source文件夹下面比直接通过Git客户端将本地CNAME文件push到GitHub上好些，这样可以避免每次`hexo deploy`后，hexo自动将 CNAME文件删除掉

## DNSPod域名管理
***
为了方便国内网络访问个人博客，可以通过腾讯平台的DNSPod进行DNS域名解析管理,主要分为以下几步:

1) DNS 域名添加，打开`www.dnspod.cn`主页，登录个人账号，选择DNS- DNS管理-添加域名：

![dnspod mag](dnspod1.png)

2) DNS 域名解析服务器地址生成，DNSPod生成的服务器地址在右边的两项：

![dnspod addr](dnspod2.png)

3) 同步DNSPod域名解析服务器到Godday，将上述生成的两项DNSPod服务器地址添加到Godaddy自定义域名服务器当中:

![dnspod godaddy](dnspod3.png)

DNSPod域名设置完成后，Godaddy的域名设置被DNSPod托管：

![dnspod godaddy-records](dnspod4.png)

![dnspod display](dnspod5.png)

## 小结
****
本篇主要介绍了将本地Hexo搭建的个人博客网站部署到GitHub服务器上的方法，并且简要的介绍了在Godaddy上域名的申请方法和设置和方便国内网络使用DNSPod进行域名地址解析，至此，就可以使用域名在网络上访问自己的博客了，如果觉得博客的主题不是自己喜欢的还可以更改Hexo的默认主题，下篇将会简介Hexo中怎么使用Next主题来使Blog更好看
