---
title: VS2015 GitHub插件使用
date: 2016-6-3
categories: Tools
tags:
- Visual Studio
- GitHub
---

# 前言
---

微软已经在VS2015中深度集成了GitHub，方便开发者对项目进行版本控制。
<!--more-->

# 下载和安装方法
---

## VS2015安装包安装
若没有安装VS2015，可以在安装VS2015过程中，从Customize 选项中，选择 GitHub Extension for Visual Studio：
![vs-github-install](http://7xq8f9.com1.z0.glb.clouddn.com/pic%2Finstall-the-extension.png)

## GitHub VS扩展官网下载安装
若已经安装VS2015，可以通过此路径 [https://visualstudio.github.com](https://visualstudio.github.com "vs_github")下载到扩展包进行安装

## VS2015扩展工具安装
若已经安装VS2015，也可以在VS的工具->扩展和更新工具栏中，在弹出的工具箱中搜索GitHub Extension关键字即可以直接下载安装和使用了:
![vs-tools](http://7xq8f9.com1.z0.glb.clouddn.com/pic/vs_github_2.PNG)

# 使用方法
---

分两种情景使用，直接新建带GitHub版本控制的vs solution 和把已经存在的VS solution添加到GitHub版本中。

## 新建GitHub版本控制的VS Solution
---

### 创建工程
1.创建新的VS工程，在右下角**选中Git版本控制单选框**：
！[vs_git_1](http://7xq8f9.com1.z0.glb.clouddn.com/pic%2Fvs_git_1.PNG)

2.创建完成后，会在相应的工程路径下面生成本地git控制相关的文件夹.git：
！[vs_git_2](http://7xq8f9.com1.z0.glb.clouddn.com/pic%2Fvs_git_2.PNG)

### 连接登陆Github
1.打开视图->团队资源管理器(Ctrl+\ and Ctrl+M),在GitHub扩展中选择connect或点击绿色的连接按钮，弹出了github的登陆界面：
！[vs_git_3](http://7xq8f9.com1.z0.glb.clouddn.com/pic%2Fvs_git_3.PNG)

2.登陆连接成功后，会显示这样：
！[vs_git_4](http://7xq8f9.com1.z0.glb.clouddn.com/pic%2Fvs_git_4.PNG)

### 编辑代码提交变更到本地git变更
1.编辑本地代码增加一行`std::cout << "hello vs github extention" << std::endl;`打印：
！[vs_git_5](http://7xq8f9.com1.z0.glb.clouddn.com/pic%2Fvs_git_5.PNG)
2.提交本地修改到本地git:
！[vs_git_6](http://7xq8f9.com1.z0.glb.clouddn.com/pic%2Fvs_git_6.PNG)
3.增加提交附加信息：
！[vs_git_7](http://7xq8f9.com1.z0.glb.clouddn.com/pic%2Fvs_git_7.PNG)
4.修改只是提交到本地，因此会提示同步到远程服务器：
！[vs_git_8](http://7xq8f9.com1.z0.glb.clouddn.com/pic%2Fvs_git_8.PNG)

### 同步本地git变更到GitHub远程服务器
1.同步到GitHub服务器，输入仓库的名字为"test"，因为是第一次同步，所以需要添加仓库的描述信息：
！[vs_git_10](http://7xq8f9.com1.z0.glb.clouddn.com/pic%2Fvs_git_10.PNG)

2.同步成功后，在GitHub远程服务器上就能看了：
！[vs_git_11](http://7xq8f9.com1.z0.glb.clouddn.com/pic%2Fvs_git_11.PNG)

3.VS2015 GitHub插件主页的git版本控制所有操作如下：
！[vs_git_16](http://7xq8f9.com1.z0.glb.clouddn.com/pic%2Fvs_git_16.PNG)

至此，就完成了从创建到同步本地的代码到GitHub远程服务器上，过程基本上为：
创建->编辑->提交->同步
后面每次修改代码只需要提交-推送操作即可：

### 再次编辑代码并提交和推送
1.再增加一行`std::cout << "hello world" << std::endl`并提交:
！[vs_git_12](http://7xq8f9.com1.z0.glb.clouddn.com/pic%2Fvs_git_12.PNG)

2.提交成功后，显示的本地操作记录，同时还需要进一步的同步推送操作：
！[vs_git_13](http://7xq8f9.com1.z0.glb.clouddn.com/pic%2Fvs_git_13.PNG)

3.还可以查看本次提交和上次的区别：
！[vs_git_14](http://7xq8f9.com1.z0.glb.clouddn.com/pic%2Fvs_git_14.PNG)

4.推送到GitHub远程服务器，推送成功后本地显示结果：
！[vs_git_15](http://7xq8f9.com1.z0.glb.clouddn.com/pic%2Fvs_git_15.PNG)

5.推送成功后，在GitHub远程服务器上就能看了：
！[vs_git_17](http://7xq8f9.com1.z0.glb.clouddn.com/pic%2Fvs_git_17.PNG)

## 把已经存在的VS solution添加到GitHub版本
---

### 在GitHub上先创建






