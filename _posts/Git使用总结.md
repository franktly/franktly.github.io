---
title: Git使用总结
date: 2016/1/23
categories: Git
tags:
- Git
- 版本管理
- SVN
- GitHub
---

## Git简介
***
Git 是一个免费的、分布式版本控制工具，或是一个强调了速度快的源代码管理工具
<!--more-->
### 集中式VS分布式
#### 集中式
1.  概念：
    集中式版本控制系统，版本库是集中存放在中央服务器的，而干活的时候，用的都是自己的电脑，所以要先从中央服务器取得最新的版本，然后开始干活，干完活了，再把自己的活推送给中央服务器。
    集中式代码管理的核心是服务器，所有开发者在开始新一天的工作之前必须从服务器获取代码，然后开发，最后解决冲突，提交。所有的版本信息都放在服务器上。如 果脱离了服务器，开发者基本上是不可以工作的。
2.  特点：
    - 服务器压力太大，数据库容量暴增。
    - 如果不能连接到服务器上，基本上不可以工作，看上面第二步，如果服务器不能连接上，就不能提交，还原，对比等等。
    - 不适合开源开发（开发人数非常非常多，但是Google app engine就是用svn的）。但是一般集中式管理的有非常明确的权限管理机制（例如分支访问限制），可以实现分层管理，从而很好的解决开发人数众多的问题。
    ![centralization](http://7xq8f9.com1.z0.glb.clouddn.com/pic%2Fcentralization.png)
3.  工作流程像是这样的：
    ![jzs](http://7xq8f9.com1.z0.glb.clouddn.com/pic%2Fjizhongshi.png)
4.  代表：
    SVN 

#### 分布式
1.  概念：
    分布式版本控制系统根本没有“中央服务器”，每个人的电脑上都是一个完整的版本库，这样，你工作的时候，就不需要联网了，因为版本库就在你自己的电脑上。既然每个人电脑上都有一个完整的版本库，那多个人如何协作呢？比方说你在自己电脑上改了文件A，你的同事也在他的电脑上改了文件A，这时，你们俩之间只需把各自的修改推送给对方，就可以互相看到对方的修改了
    在实际使用分布式版本控制系统的时候，其实很少在两人之间的电脑上推送版本库的修改，因为可能你们俩不在一个局域网内，两台电脑互相访问不了，也可能今天你的同事病了，他的电脑压根没有开机。因此，分布式版本控制系统通常也有一台充当“中央服务器”的电脑，但这个服务器的作用仅仅是用来方便“交换”大家的修改，没有它大家也一样干活，只是交换修改不方便而已
2. 特点：
    - 和集中式版本控制系统相比，分布式版本控制系统的安全性要高很多，因为每个人电脑里都有完整的版本库，某一个人的电脑坏掉了不要紧，随便从其他人那里复制一个就可以了。而集中式版本控制系统的中央服务器要是出了问题，所有人都没法干活了
    - 适合分布式开发，强调个体
    - 公共服务器压力和数据量都不会太大。
    - 速度快、灵活
    - 任意两个开发者之间可以很容易的解决冲突。
    ![distributed](http://7xq8f9.com1.z0.glb.clouddn.com/pic%2Fdistributed.png)
3.  工作流程像是这样的：
    ![fbs](http://7xq8f9.com1.z0.glb.clouddn.com/pic%2Ffenbushi.png)
分布式和集中式的最大区别在于开发者可以在本地提交。每个开发者机器上都有一个服务器的数据库
4.  代表：
    Git

### Git工作区&暂存区&版本库
Git分为三个区域：
1. 工作区(working directory): 本地电脑能看到的目录(即`git init`执行的文件目录)
2. 暂存区(stage index):工作区一个隐藏目录`.git`，这个不算工作区，而是Git的版本库，里面的stage（或者叫index）称为暂存区
3. 版本库(master): Git为我们自动创建的第一个分支master，以及指向master的一个指针叫`HEAD`
区域的示意图如下：
![git-three-zones](http://7xq8f9.com1.z0.glb.clouddn.com/pic%2Fgit_three_zones.png)
> `git add`命令将使工作区的目录树写到暂存区中，暂存区中的目录树被更新，同时工作区修改（或新增）的文件内容被写入到对象库中的一个新的对象中，而该对象的ID被记录在暂存区的文件索引中
>`git commit`命令使暂存区的目录树写到版本库（对象库）中，master 分支会做相应的更新。即 master 指向的目录树就是提交时暂存区的目录树
>`git checkout`或者`git checkout --<filename>`命令会用暂存区全部或指定的文件替换工作区的文件。这个操作很危险，会清除工作区中未添加到暂存区的改动；即工作区未`add`的修改被丢弃，暂存区不变
>`git reset HEAD`命令会使暂存区的目录树会被重写，被 master 分支指向的目录树所替换，但是工作区不受影响；即暂存区未`commit`的修改被丢弃，工作区不变
`git checkout HEAD`或者`git checkout HEAD <filename>`命令会用 HEAD 指向的 master 分支中的全部或者部分文件替换暂存区和以及工作区中的文件。这个命令也是极具危险性的，因为不但会清除工作区中未提交的改动，也会清除暂存区中未提交的改动；即版本库不变，工作区未`add`和暂存区未`commit`的修改被丢弃
`git rm --cached <filename>`命令会直接从暂存区删除文件，工作区则不做出改变
`git diff`比较的是工作区和暂存区的差别
`git diff --cached`比较的是暂存区和版本库的差别
`git diff HEAD`比较的是工作区和版本库的差别

## Git常用操作
***
### 本地仓库Repository管理
#### 初始化Git仓库

    git init
>仓库(repository)，你可以简单理解成一个目录，这个目录里面的所有文件都可以被Git管理起来，每个文件的修改、删除，Git都能跟踪，以便任何时刻都可以追踪历史，或者在将来某个时刻可以“还原”。

>Git就把仓库建好了，而且告诉你是一个空的仓库（empty Git repository），当前目录下多了一个.git的目录，这个目录是Git来跟踪管理版本库的

#### 添加文件到Git仓库
Step 1.  添加文件到暂存区(stage index)

    git add <filename>
>可反复多次使用，添加多个文件
每次修改，如果不add到暂存区，那就不会加入到commit中

Step 2. 提交文件到Git仓库

    git commit [-m]
>可选参数-m 后面添加提交的说明信息

#### 删除Git仓库中的文件
首先`git rm` ,然后 `git commit`：

    git rm <filename>
    git commit [-m]
>如果本地误删了，版本库中还没有删除，可以通过`git checkout -- <filename>`还原仓库中版本到工作区

#### 查看版本状态

    git status
>命令可以让我们时刻掌握工作区的状态


    git diff <filename>
>可以查看修改内容
>查看工作区和版本库里面最新版本的区别:`git diff HEAD -- <filename>`

#### 操作回退
##### 版本回退
版本回退指丢弃版本库的修改，从Git本地版本库中回退版本到本地工作区
在Git中，用HEAD表示当前版本，也就是最新的提交，上一个版本就是`HEAD^`，上上一个版本就是`HEAD^^`，当然往上100个版本写100个^比较容易数不过来，所以写成`HEAD~100`
Git的版本回退速度非常快，因为Git在内部有个指向当前版本的`HEAD`指针，当你回退版本的时候，Git仅仅是把HEAD从指向回退的目标版本：
回退版本命令

    git reset --hard <commit_id>
>`--hard`参数将版本库，暂存区和工作区的内容全部重置为某个commit_id的状态
>`git reset`默认是`git reset --mixed <commit_id>`可以让版本库重置到某个commit状态，该commit之后的commit不会保留，并重置暂存区，但是不改变工作区。即这个时候，上次提交的内容在工作区中还会存在
>`git revert`比`git reset`更加温柔一点，回滚到某次commit且该commit之后的提交记录都会保留，并且会在此基础上新建一个提交。对于已经`git push`到服务器上的内容作回滚，推荐使用`git revert`
>回退到指定的版本，commit_id可以通过`git log`命令查看
>版本号没必要写全，前几位就可以了，Git会自动去找。当然也不能只写前一两位，因为Git可能会找到多个版本号，就无法确定是哪一个了
> 回退到上一个版本：`git reset --hard HEAD^`
> 回退到上上一个版本：`git reset --hard HEAD^^`


    git log
>查看提交历史，包含提交时间，作者和commit_id，以便确定要回退到哪个版本


    git reflog
>查看命令历史，包含commit_id,命令操作信息等，以便确定要回到未来的哪个版本

##### 修改回退
修改回退指丢弃工作区或暂存区的修改，从Git本地暂存区或工作区中回退修改到本地工作区
1.  工作区修改回退
    如果想丢弃工作的修改可以输入：

        git checkout -- <filename> 
    `git checkout`其实是会用暂存区全部或指定的文件替换工作区的文件。这个操作很危险，会清除工作区中未添加到暂存区的改动，无论工作区是修改还是删除，都可以“一键还原”，操作后就回到和暂存区一模一样的状态，这里有两种情况：
    + 一种是filename自修改后还没有被放到暂存区，现在，撤销修改就回到和版本库一模一样的状态（即丢弃了工作区的修改）
    + 一种是filename已经添加到暂存区后，又作了修改，现在，撤销修改就回到添加到暂存区后的状态(即暂存区的修改仍然存在，只是工作区的修改丢弃了)
    总之，就是让这个文件回到最近一次`git commit`或`git add`时的状态。
    `git checkout -- <filename>`命令中的`--`很重要，没有`--`，就变成了“切换到另一个分支”的命令

2.  暂存区修改回退
    如果你的修改只是通过`git add`添加到了暂存区，还没有提交，想撤销掉暂存区的修改(unstage),可以输入：

        git reset HEAD <filename>
    可以把暂存区的修改撤销掉（unstage），重新把修改放回工作区,操作后，暂存区是干净的(暂存区的目录树会被重写，被master分支指向的目录树所替换，但是工作区不受影响)工作区有修改;如果再想进一步的丢弃工作区的修改可以参照上面**工作区修改回退**
    `git reset`命令既可以回退版本，也可以把暂存区的修改回退到工作区。当我们用`HEAD`时，表示最新的版本

##### 常用的各种场景回退命令操作流程
1.  修改了工作区，丢弃工作区的修改：

        modify code in filename of working dir 
        git checkout --filename
2.  修改了工作区，并add到了暂存区了，丢弃暂存区的修改：

        modify code in filename of working dir 
        git add
        git reset HEAD filename

    如果想进一步丢弃暂存区回退到工作区的修改：

        git checkout -- filenmae
    至此，工作区与版本库中一样了
3.  修改了工作区，并add到了暂存区了，又修改工作区，丢弃工作区的修改：

        modify code in filename of working dir 
        git add
        modify code in filename of workding dir again
        git checkout -- filenmae
    如果又想丢弃暂存区的修改，继续输入：

        git reset HEAD filename
    如果继续想把暂存区回退到工作区的修改也丢弃掉，继续输入：

        git checkout -- filenmae
    至此，工作区与版本库中一样了
4.  修改了工作区，并commit到仓库，撤销掉仓库的指定commit:

        modify code in filename of working dir
        git add
        git commit
        git log
        git reset --hard commit_id
    如果突然发现是误撤销，又想回到之前的状态：

        git reflog
        git reset --hard commit_id

#### 分支管理
每次提交，Git都把它们串成一条时间线，这条时间线就是一个分支。默认情况下，只有一条时间线，在Git里，这个分支叫主分支，即master分支。HEAD严格来说不是指向提交，而是指向master，master才是指向提交的，所以，HEAD指向的就是当前分支

##### 分支操作命令
创建branchname分支，并切换到该分支：

    git checkout -b <branchname>
>`git checkout`命令加上`-b`参数表示创建并切换，相当于以下两条命令：
>
    git branch <branchname>
    git checkout <branchname>
>`git branch <branchname>`：表示创建指定分支
>`git checkout <branchname>`：表示切换到指定分支

查看当前分支：

    git branch
>该命令会列出所有分支，当前分支前面会标一个*号

合并branchname分支：

    git merge <branchname>
>`git merge`命令用于合并指定分支到当前分支(当前git的工作分支，即最后一次`git checkout <branchname>`)。合并后被合并的分支和当前分支就一样了
>默认情况下，是进行“快进模式”的合并，也就是直接把master（当前分支）指向dev(被合并的分支)的当前提交，所以合并速度非常快
>Git会用Fast forward模式，但这种模式下，删除分支后，会丢掉分支信息。
如果要强制禁用FF模式，可以增加`--no-ff`参数，Git就会在merge时生成一个新的commit，这样，从分支历史上就可以看出分支信息

删除branchname分支：

    git branch -d <branchname>
>`-D`参数强行删除分支

保存当前工作现场：

    git stash

查看保存的工作现场：

    git stash list

恢复现场：

    git stash pop
>该命令会在恢复的同时把stash内容也删了，等同于下面两个命令：
>
    git stash apply 恢复现场单并不删除stash内容
    git stash drop 删除stash内容
>可以多次stash,先用`git stash list`查看，然后恢复指定的stash，用命令：
    git stash apply stash@{stash_id}



##### 常用的各种场景分支命令操作流程

1.  创建dev分支，修改提交代码后再合并到master分支：

        git branch dev
        git checkout dev 
        (or git checkout -b dev)
        modifty code in dev branch
        git add
        git commit

        git checkout master
        git merge dev 
        git branch -d dev

2.  master分支和dev分支各自都分别有各自的代码修改和新的提交,并有冲突:

        git branch dev
        git checkout dev 
        (or git checkout -b dev)
        modify code in dev branch
        git add
        git commit

        git master
        modify code in master branch 
        git add
        git commit

        git merge dev (master modify is conflict with dev modify)

    产生冲突后,手动解决后，再在当前master上提交,并删除dev分支即可：

        git add 
        git commit
        git branch -d dev   
    >使用`git log --graph`可以看到分支合并图

3.  修改dev分支时候，需要修改master分支上的bug,先保存现场，再修改bug,最后恢复现场:

        git stash

        git checkout master
        git checkout -b bug
        modify code in bug branch
        git add
        git commit

        git checkout master
        git merge bug
        git branch -d bug

        git checkout dev
        git stash pop

#### 标签管理
发布一个版本时，我们通常先在版本库中打一个标签，这样，就唯一确定了打标签时刻的版本。将来无论什么时候，取某个标签的版本，就是把那个打标签的时刻的历史版本取出来。所以，标签也是版本库的一个快照

##### 创建标签
首先切换到需要打标签的分支上,输入下面命令即可：

    git tag [-a] <tagname> [-m] [commit_id]
>`git tag <tagname>`命令默认标签是打在最新提交的commit上的,给历史提交打标签可以加上`commit_id`可选项，选择要打标签的commit id即可
>还可以创建带有说明的标签，用`-a`可选参数指定标签名，`-m`可选参数指定说明文字
>还可以通过`-s`可选参数用私钥签名一个标签
查看该分支下的所有标签：

    git tag

查看标签信息：

    git show <tagname>

##### 删除标签
创建的标签都只存储在本地，不会自动推送到远程。所以，打错的标签可以在本地安全删除:

    git tag -d <tagname>

##### 远程标签
如果要把标签推送到远程可以用：
    
    git push origin <tagname>
也可以一次性推送所有的本地标签：

    git push origin --tags
如果要删除远程的标签，要分两步：
Step 1: 先从本地删除：
    
    git tag -d <tagname>
Step 2: 从远程删除：

    git push origin :refs/tags/<tagname>

### 远程仓库管理

#### 关联本地仓库到远程仓库
1.  登陆GitHub,点击`Create a new repo`创建一个新的仓库,在本地仓库运行：

        git remote add origin git@server-name:path/repo-name.git
    >添加后，远程库的名字就是origin，这是Git默认的叫法，也可以改成别的，但是origin这个名字一看就知道是远程库

2.  推送本地库内容到新建的远程仓库
        git push -u origin master
    >由于远程库是空的，我们第一次推送master分支时，加上了`-u`参数，Git不但会把本地的master分支内容推送的远程新的master分支，还会把本地的master分支和远程的master分支关联起来，在以后的推送或者拉取时就可以简化命令
3.  以后每次修改本地代码后，就可以将本地的master分支最新修改推送栋GitHub了：
        git push origin master

#### 从远程仓库克隆到本地仓库
当你从远程仓库克隆时，实际上Git自动把本地的master分支和远程的master分支对应起来了，并且，远程仓库的默认名称是origin，克隆命令：
    
    git clone <github_addrs>
>Git支持多种协议，默认的git://使用ssh，通过ssh支持的原生git协议速度最快,但也可以使用https等其他协议，使用https除了速度慢以外，还有个最大的麻烦是每次推送都必须输入口令

#### 从远程获取最新版本到本地

    git fetch
>从远程获取最新版本到本地，不会自动merge

    git pull
>从远程获取最新版本并merge到本地, 其命令相当于：
>
    git fetch
    git merge


#### 查看远程库信息

    git remote 
>想查看更详细的信息可以加上`-v`参数

#### 使用远程仓库的一般流程
1.  可以试图用`git push origin <branchname>`推送自己的修改
2.  如果推送失败，则因为远程仓库分支比你的本地仓库更新，需要先用`git pull`试图合并
    > 如果`git pull`提示“no tracking information”，则说明本地分支和远程分支的链接关系没有创建，用命令`git branch --set-upstream <branchname> origin/<branchname>`
3.  如果合并有冲突，则解决冲突，并在本地提交
4.  没有冲突或者解决掉冲突后，再用`git push origin <branchname>`推送就能成功

## 参考
[liaoxuefeng](http://www.liaoxuefeng.com/)
[git 缓存区的理解](http://selfcontroller.iteye.com/blog/1786644)
[git reference](http://gitref.org/index.html)
[Pro Git book](https://git-scm.com/book/zh/v2)
[git-quick-start](http://git.oschina.net/wzw/git-quick-start)
[git-cheatsheet](http://7xq8f9.com1.z0.glb.clouddn.com/pic%2Fgit-cheatsheet.pdf)

