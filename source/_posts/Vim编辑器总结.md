---
title: Vim编辑器总结
date: 2017-07-08 
categories: Tools
tags:
- Vim
- Linux
---

## 前言
***
最近换了工作，博客很久没跟新了。新工作与原来的领域知识相差很多，变化比较大，所以需要了解的东西比较多。之前大部分情况都是使用VS或SourceInsight阅读写代码，由于最近需要频繁在Linux远程服务器上进行代码开发，同时Windows磁盘映射的速度很慢，为了提高生产力，因此尝试这使用Linux自带的文本编辑器VIM来进行代码编辑,下面简要介绍下对VIM的基本了解和使用。

<!--more-->
## VIM入门
***

### VIM工作模式
---

VIM是纯文本的文本编辑器，纯文本的编辑常用的操作就是增删改减，在这些基本的操作过程中，需要辅助一些其他的操作，如为了定位文本需要进行鼠标移动操作命令，为了选中文本需要进行文本选中操作，为了进行文本查找、替换等操作需要文本筛选操作等等。为了方便这些操作VIM延伸出4种基本的工作模式。

#### Normal模式
---

VIM缺省模式,主要在该模式下进行文本定位移动和删除, 在其他模式下通过Esc回到Normal模式.

#### Insert模式
---

该模式在需要输入文本时候使用，正常模式下通过以下命令进入插入模式:
1. `i`(光标前插入)
2. `a`(光标后插入)
3. `c`(光标处固定长度替换插入)
4. `s`(光标处不固定长度替换插入)
5. `o`(在光标下一行行首插入)
6. `I`(行首前插入)
7. `A`(行尾后插入)
8. `C`(光标处到行尾替换插入)
9. `S`(整行替换插入)
10. `O`(在光标上一行行首插入)

#### Visual模式
---

该模式主要用于文本选定,这样可以方便后续进行块的替换、删除、复制粘贴操作,正常模式输入以下命令进入Visual模式：
1. `v`(小写):按字符选定
2. `V`(大写):按行选定
3. `Ctrl-V`(大写):按列选定

#### Command模式
---

该模式用于执行文本编辑命令，正常模式下输入以下命令然后回车(Enter)即可完成所需的命令：
1. :(冒号)一般的命令,命令包括外部命令(以！开头),内部命令(不加！)
2. /(正斜杠)正向搜索命令
3. ?(问号)反向搜索命令

在了解基本命令后通过后续不断练习来熟悉VIM操作.

### VIM练习
---

#### vimtutor
---

一开始练习，推荐Linux系统自带的vimtutor工具，直接在shell终端输入:
```
	vimtutor
```
按照vimtutor的顺序开始45min~60min的练习后，大概会了解和熟悉VIM的基本操作：
1. 上下左右移动: `k`,`j`,`h`,`l`; 移动到单词末尾:`e`; 
2. 强制退出: `:q!<Enter>`; 保存退出: `:wq<Enter>`;保存所有Buffer: `:wa<Enter>`;保存当前打开文本到新建文件: `:w + new_file_name<Enter>`; 打开文件: `:e + file_name`; 查看Buffer: `:ls`,选中某一个Buffer n: `:b N`;选中打开的Buffer前一个和后一个文件:`:bp`, `:bn`;
3. 删除光标处字符:`x` 
4. 光标前插入:`i`; 行尾插入:`A`
5. 删除命令:`d + motion`,如: 
>	`de`:删除光标至单词末尾
>	`d$`:删除光标至行尾
>	`dw`:删除光标至下一个单词首
>	`dd`:删除当前行
6. 使用数字进行一次行多次移动,删除操作,如:
>	`2k`:向上移动两行
>	`3e`:移动到光标后第3个单词末尾
>	`0`:移动到行首(不忽略空格, ^:移动到行首忽略空格)
>	`d2w(2dw)`:删除光标位置开始两个单词(d + num + motion 或者 num + d + motion)
>	`2dd(d2d)`:删除当前行和下一行共两行
7. 恢复上一次修改:`u`; 恢复当前行的所有修改:`U`; 撤销恢复:`Ctrl+R`
8. 复制黏贴: 复制:`y + motion`; 黏贴:`p`
>	`yw`:  复制到下个单词行首(不包括行首字符)
>	`yaw`: 复制当前单词(y a word for short)
>	`y$`:  复制光标至行末
9. 单个字符替换: `r`; 当前光标无长度限制覆盖式替换:`R`
10. 替换操作:`c + num + motion`,如:
>	`cw`:  替换到下个单词首(不包括首字符);
>	`caw`: 替换当前单词(y a word for short)
>	`c$`:  替换光标至行末
>	`c2e`: 替换光标至下一个单词末(包括尾字符)
11. 文件状态定位,如:
>	`Ctrl-G`:查看当前文件位置和状态
>	`G`:移动到文件首行
>	`gg`:移动到文件尾行
12. 搜索&替换,如:
>	`/`: 正向搜索 
>	`n`:匹配同向搜索结果,N:匹配反向搜索结果
>	`?`: 反向搜索 
>	`n`:匹配同向搜索结果,N:匹配反向搜索结果
>   `:s<Enter>`:替换
>	`:s/old/new<Enter>`:在一行内替换第一个old为new
>	`:s/old/new/g<Enter>`:在一行内替换所有old为new
>	`:#,#s/old/new/g<Enter>`:在两个#代表的行内替换所有old为new
>	`:%s/old/new/g<Enter>`:在整个文件内替换所有old为new
>	`:%s/old/new/gci<Enter>`:在整个文件内替换所有old为new,且需要确认(c)并且忽略大小写(i)
13. 执行外部命令,以!开头:
>	`:!pwd<Enter>`: 显示当前工作路径
>	`:!ls<Enter>`:  显示当前工作路径所有文件
14. 读取文本到当前光标位置
>	`:r !pwd<Enter>`: 读取当前工作路径文本到光标位置
>	`:r filename<Enter>`: 读取filename文件内文本到光标位置

#### VIM帮助 
---

通过Linux自带的vimtutor基本上就会使用基本的文本编辑操作了,如果需要查询更详细的可以输入如下命令:

	:help user-manual

## VIM规律与技巧
***

### 移动光标
---

VIM移动光标命令是以一定的操作单位为基本移动距离的,然后在需要的时候选择合适的操作次数,基本原则是: **先定操作单位再定操作次数**,基本的操作单位如下表所示:

| 操作单位 |  命令                       |            备注 | 
|:--------:|:---------------------------:|:-----------------------------------:|
|字符      |  `h`(左移动一个字符);`l`(右移动一个字符)  |无  | 
|单词      |  `w/W`(移动到下单词首);`b/B`(移动到上单词首);`e/E`(移动到光标所在单词首)|`W`,`B`,`E`单词是以空格和Tab区分单词的,`w`,`b`,`e`是以数字和字母外其他字符区分单词的 |
|行        |  `j`(移动到下行);`k`(移动到上行);`0`(移动到当前行首);`^`(移动到当前行首第一个非空字符);`$`(移动到当前行尾);`:n`(移动到第n行)| 无 | 
|句子      |  `)`(移动到当前句尾);`(`(移动到当前句首)| 句子边界是以`.`,`!`,`?`结尾并紧随着一个换行、空格或制表符,段落和节也视为句子边界|
|段落      |  `}`(移动到当前段尾);`{`(移动到当前段首)| 段边界是以空行为边界,段落和节也视为句子边界|
|屏        |  `H`(移动到屏幕第一行);`M`(移动到屏幕中间行);`L`(移动到屏幕最后行)|无  |
|页        |  `Ctrl-f`(向前滚动一页);`Ctrl-b`(向后滚动一页);`Ctrl-u`(向前滚动半页);`Ctrl-d`(向后滚动半页)|无  |
|文件      |  `G`(移动到文件尾);`gg`(移动到文件头);`:0`(移动到文件第一行);`:$`(移动到文件最后一行)| 无 | 

1. 移动光标到指定字符:
> `fa`:移动到当前行字符a处,`F`则表示反方向
> `2fa`:移动到当前行第二次出现字符a处,`F`则表示反方向
> `ta`:移动到当前行字符a前一处,`T`则表示反方向

2. 文本编辑确定原则后,基本的编辑格式为:
```
	num + motion
```
	>	`3j`: 向下移动三行
	>	`5G`: 移动到第5行

3. 移动光标基本单位外还有些常用命令如下:
>	`%`: 跳转到与之匹配的括号处
>	`.`: 重复执行上次命令
>	`/`.`: 跳转到最近修改位置并定位编辑点
>	`*`: 向前搜索光标所在单词
>	`#`: 向后搜索光标所在单词
>	`q/`: 显示搜索命令历史窗口
>	`q:`: 显示命令模式输入的命令历史窗口

### 编辑文本
---

#### 基本编辑文本命令
---

与移动光标类似,在进行文本增删改选中等操作过程中也需要操作单位和操作数量,这些操作单位与光标移动一样,基本原则是: **先定操作类型,后定操作单位和操作次数**, 基本操作单位和命令如表所示:

| 操作单位 |  命令  | 备注 | 
|:--------:|:----------:|:------------------------:|
|字符      |  `x`(删除光标位置所在字符);`c`(替换光标位置所在字符,并进入插入模式);`s`(替换光标位置所在字符,并进入插入模式;`r`(替换光标位置所在字符,不进入插入模式;`i`(在光标位置所在字符前插入,并进入插入模式;`a`(在光标位置所在字符后插入,并进入插入模式;    | 无 | 
|单词      |  `c(d,y,v)w/cW`(修改到下单词首);`c(d,y,v)b/c(d,y,v)B`(修改到上单词首);`c(d,y,v)e/c(d,y,v)E`(修改到光标所在单词首)|`W`,`B`,`E`单词是以空格和Tab区分单词的,`w`,`b`,`e`是以数字和字母外其他字符区分单词的 | 
|行        |  `c(d,y,v)j`(修改到下行);`c(d,y,v)k`(修改到上行);`c(d,y,v)0`(修改到当前行首);`c(d,y,v)^`(修改到当前行首第一个非空字符);`c(d,y,v)$`(修改到当前行尾);| 无  | 
|句子      |  `c(d,y,v))`(修改到当前句尾);`c(d,y,v)(`(修改到当前句首)| 句子边界是以`.`,`!`,`?`结尾并紧随着一个换行、空格或制表符,段落和节也视为句子边界|
|段落      |  `c(d,y,v)}`(修改到当前段尾);`c(d,y,v){`(修改到当前段首)| 段边界是以空行为边界,段落和节也视为句子边界|
|文件      |  `c(d,y,v)G`(修改到文件尾);`c(d,y,v)gg`(修改到文件头);`:0`(移动到文件第一行);`:$`(移动到文件最后一行)| 无  | 

文本编辑确定原则后,基本的编辑格式为:
```
	c(d,y,v) + num + motion
```
>	`caw`: 替换当前光标所在单词
>	`d2w`: 删除当前光标所在至后面一个单词

#### 列操作
---

常用的列操作命令有:
`Ctrl-V`: 进入列编辑模式,然后通过移动命令选中列进行编辑操作
`I`: 进入列编辑模式时候鼠标前插入操作
`A`: 进入列编辑模式时候鼠标后插入操作

#### 文本区域选中或编辑
---

1. 选中或编辑一个区域,不包括区域符号本身:
```
c(d,y,v) + i + region(",',),],})
```
2. 选中或编辑一个区域,包括区域符号本身:
```
c(d,y,v) + a + region(",',),],})
```

#### 文本编辑其他常用命令
---

文本编辑基本单位外还有些常用命令如下:
>	`dd`: 删除光标所在行
>	`yy`: 复制光标所在行
>	`xp`: 交换光标位置和其后的字符
>	`ddp`: 交换光标和其后的行
>	`~`: 将光标所在字符大小写翻转
>	`guw`: 将光标所在单词变为小写
>	`gUw`: 将光标所在单词变为大写
>	`guu`: 将光标所在行所有字符变为小写
>	`gUU`: 将光标所在行所有字符变为大写
>	`g~~`: 将光标所在行所有字符大小写翻转
>	`ga`: 显示光标所在字符内码
>	`>>`: 右缩进
>	`<<`: 左缩进
>	`==`: 格式化
>	`Ctrl-p`: 自动补全
>	`Ctrl-n`: 自动补全移动选中
>	`Shirf-K`: 显示光标所在当前Linux系统函数帮助界面

## VIM其他常用功能
***

### 分屏
---

#### 相关概念
---

VIM支持多窗口分屏功能,了解分屏功能之前,需了解VIM的几个概念:
1. **Buffer**
	A buffer is the in-memory text of a file:可以看做内存中的文本,还未写到磁盘上,修改均发生在内存上
2. **Window**
	A window is a viewport on a buffer: 用来显示Buffer, 同一个Buffer可以有多个Window(一个Window只显示一个Buffer)
3. **Tab**
	A tab page is a collection of windows: 包含一系列Window

#### 分屏命令
---

常用的分屏命令有:
`:split`: 创建分屏,默认是水平分屏(`:vsplit`是垂直分屏)
`Ctrl-w + (i,j,h,k)`: 上下左右切换分屏
`Ctrl-w + (I,J,H,K)`: 上下左右移动光标所在分屏
`Ctrl-w +(-) `: 增加或减少尺寸
`Ctrl-w +(_[Shift+-]) `: 屏幕高度扩展到最大
`Ctrl-w +(|[Shift+\]) `: 屏幕宽度扩展到最大

#### 切页命令
---

常用的切页命令有:
`:tabnew + file_name`: 新建一个Tab页
`:tabc`: 关闭当前Tab页
`:tabo`: 关闭所有其他Tab页
`:tabs`: 查看所有Tab页
`:tabp`: 查看前一个Tab页
`:tabn`: 查看后一个Tab页
`Ngt`: 查看第N个Tab页

> xshell及SecureCRT可以通过`Alt + N`切换Tab页

### 文本折叠
---

#### 折叠模式
---

VIM文本支持多种折叠模式,可以通过以下命令在vim中设置或写在`.vimrc`配置文件中:
```
:set foldmethod=manual|indent|expr|syntax|diff|marker
或者简写:
:set fdm=manual|indent|expr|syntax|diff|marker
```
VIM折叠包括以下几种模式说明如下表所示:

|折叠模式 | 备注 |
|:-------:|:--------------------------------------------------------:|
|manual | 手工定义折叠 |
|indent | 缩进表示折叠 |
|expr   | 表达式表示折叠 |
|syntax | 语法高亮表示折叠 |
|diff   | 对没有更改文本表示折叠 |
|marker | 用特定标识(一般默认是`{,},[,]`表示折叠)|

#### 折叠命令
---

常用的VIM折叠命令如下表所示:

|折叠命令 | 说明 |
|:----------:|:------------------------------------------:|
|zf |将选中的文本执行折叠 |
|zo |打开当前的折叠  |
|zc |关闭当前的折叠  |
|za |打开关闭折叠切换  |
|zd |删除当前的折叠  |
|zj |移动至下一个折叠  |
|zk |移动至上一个折叠  |
|zn |禁用折叠  |
|zN |启用折叠  |
|zE |删除所有的折叠  |
|zM |关闭所有及嵌套的折叠  |
|zr |打开所有的折叠  |
|zR |打开所有及嵌套的折叠  |

折叠命令实例:
>	`zf`命令将选中的文本执行折叠,支持通过移动命令组合来折叠制定行,如:
>	`zf10j`:折叠当前行后10行;
>	`5zf`: 将当前行及其后4行折叠起来,
>	`zf7G`: 将当前行至全文第7行折叠起来,
>	`zfa(`: 折叠`(`包围区域 
>	每次使用`zf`命令折叠后需要使用`:mkview`命令来保存折叠状态,该命令会在.vim下面生成view文件夹,后续重新打开该折叠后的文件可以通过`:loadview`来加载上次保存的折叠状态

可以通过以下命令查看折叠help：
```
:help folding
```
### 文本编辑宏录制
---

VIM文本编辑宏主要是解决重复编辑操作或有一定规律的编辑操作,实在 **Normal模式** 下进行的,主要步骤如下:
1. `q*`:开始录制,`*`可以为`0~9a~zA~Z`中任意字符,相当于寄存器用来存刚才录制的宏
2. 执行VIM编辑操作
3. `q`: 停止录制宏
4. `@*`: 执行录制宏,可以前面加数字表示执行多少次,如`10@a`表示重复执行10次录制在寄存器`a`中的宏,`@@`表示重复执行上次的`@*`操作

如实现数字序号递增功能: 
>	1. 在某行输入`1`,并`Esc`退回至Normal模式
>	2. 输入`qa`开始录制
>	3. 输入`yy`复制当前`1`;输入`j`跳入下行;输入`p`黏贴到下行;输入`Ctrl-a`使数字自增
>	4. 输入`q`结束录制
>	5. 输入`n@a`可以使数字递增至n

可以通过以下命令查看宏help：
```
:help recording
```


### 文本对比
---
VIM中可以通过如下命令以比较方式进行文件对比:
1. 打开两个文件进行对比:
```
vim -d file1 file2
或者:
vimdiff file1 file2
```
2. 已经打开文件file1,打开file2文件与其进行对比:
```
水平分割打开两个窗口:
diffsplit file2
或垂直分割打开两个窗口:
vert diffsplit file2
```
3. 已经打开文件file1,file2文件,分别在两个窗口输入:
```
diffthis
```
4. 其他文本比较命令:

|比较命令|  备注  |
|:-----------:|:------------------------------------------------------:|
|:vimupdate|  更改文件后,更新diff结果 |
|[c        |  跳转到上一个diff点 |
|]c        |  跳转到下一个diff点 |
|dp        |  将diff点的当前文档应用到另一个文档 (diff put)|
|do        |  将diff点的另一个文档应用到当前文档 (diff obtain)|


## VIM编译(Ubuntu)
***

VIM可以从GitHub上下载最新源码进行编译,编译过程类似于这样的:

1. 下载最新的VIM源码:
```
	git clone https://github.com/vim/vim.git
```
2. 清除VIM源码之前的编译结果:
```
	sudo make clean
	sudo make disclean
```
3. 配置编译选项:
```
	./configure --with-feature=huge --enable-rubyinterp --enable-pythoninterp --enable-python3interp --enable-perlinterp --enable-multibyte --enable-cscope --with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu/ --with-python-config-dir=/usr/lib/python3.5/config-3.5m-x86_64-linux-gnu/ --prefix=/usr/local/vim
```
	> `--with-feature=huge`: 支持最大特性
	> `--enable-rubyinterp`: 打开对ruby编写插件的支持
	> `--enable-pythoninterp`:打开对python编写插件的支持
	> `--enable-python3interp` :打开对python3编写插件的支持
	> `--enable-perlinterp` :打开对perl编写插件的支持
	> `--enable-multibyte` :打开多字节支持,可以在VIM中支持中文
	> `--enable-cscope` :打开对CSCOPE的支持
	> `--with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu/` : 指定python路径
	> `--with-python-config-dir=/usr/lib/python3.5/config-3.5m-x86_64-linux-gnu/` :指定python3的路径
	> `--prefix=/usr/local/vim` : 自定义VIM安装路径

4. 编译安装VIM:
```
	sudo make && make install
```
5. 若安装出现问题需要安装以下依赖:
```
	sudo apt-get install python-dev
	sudo apt-get install python3-dev
	sudo apt-get install libncurses5-dev
```
6. 至此,VIM已经安装到`--prefix`指定的`/usr/local/vim`路径了,可以通过`vim --version` 查看VIM的相关信息,还可以通过以下命令增加软连接来自启动新编译的VIM:
```
	ln -s /usr/bin/vim /usr/local/vim
```
7. VIM卸载方法:
```
	sudo apt-get remove --purge vim(--purge是完全删除,连同配置文件)
	sudo apt-get clean
```

## VIM配置及插件
***

### VIM配置
---

本人的VIM配置如下:
```
set nocompatible                         " Set no compatible with vi (older version) so we can use extend function of
set showcmd		                 " Show (partial) command in status line.
set showmatch		                 " Show matching brackets.
set ignorecase		                 " Do case insensitive matching
set smartcase		                 " Do smart case matching
set incsearch		                 " Incremental search
set hlsearch 		                 " High light  search
set autowrite		                 " Automatically save before commands like :next and :make
set hidden		                 " Hide buffers when they are abandoned
set number 		                         " Display nunmber lines
set relativenumber 		                 " Display  relative nunmber lines
set foldenable                           " Enable auto fold
set foldmethod=indent                    " Set fold method
set foldlevel=99                         " Set fold level
set autowrite                            " Set auto save 
set cursorline                           " Dipslay the current line boldly
"hi CursorLine cterm=NONE ctermbg=gray ctermfg=darkred gui=bold" cursor line highlight color 
hi CursorLine cterm=NONE ctermbg=darkred ctermfg=white gui=bold" cursor line highlight color 
hi CursorColumn cterm=NONE ctermbg=darkred ctermfg=red " cursor column line highlight color 

set confirm                              " Pop up confirm msg when processing unsaved files and read-only files
set autoindent                           " Set auto indent , when copying block text from outside to vim, this shoud be close in case indent problem
set smartindent                          " Set c-stlyel auto indent, when copying block text from outside to vim, this shoud be close in case indent problem
set cindent                              " Set auto indent, when copying block text from outside to vim, this shoud be close in case indent problem
set noexpandtab                          " Set no tab replaced by space
set smarttab                             " Using tab at beginning of a row and paragraph
set showmatch                            " Hightlight display matched brackets
set ruler                                " Display cursor's line number in staus bar
set nobackup                             " Not back up file when overlapping files  
set noswapfile                             " Not swap file when overlapping files  


"++++++++++++++++++++ set value config++++++++++++++++++++
set mouse=a                              " Enable mouse all
set clipboard=unnamedplus                " Sync System clipboard with Vim, 'vim --version \| grep clipboard' and 'sudo apt install vim-gtk'
set guifont=Courier_New:h10:cANSI        " Set font 
set cmdheight=1                          " Set cmd height 
set termencoding=utf-8                   " Set terminate like console encoding 
set encoding=utf-8                       " Set vim inner like buffer,msg txt, menu txt  encoding 
set fileencodings=utf-8,cp936,ucs-bom    " Set file content encoding list and when opening a file, it will open according to the detected encoding sequence
set fileencoding=utf-8                   " Set the current file content encoding when saving a file 
set expandtab                            " Set Tab expand to space
set tabstop=4                            " Set tab widths = 4
set softtabstop=4                        " Set tab indent widths  = 4
set shiftwidth=4                         " Set swap row tab indent widths  = 4
```

### VIM插件
--- 
VIM可供选择的插件很多,本人常用的插件有:
1. NerdTree
功能：文件导航,主要功能包括:
a)： 树状显示某个工程下文件,并支持文件打开,搜索,增删改查等基本操作
b)： 支持设置BookMark
c)： 支持文件预览和垂直及水平多屏方式打开
d)： 支持变更文件工程当前工作目录
帮助:
在NerdTree窗口输入`?` 或者输入:
```
:help nerdtree
```

2. Tagbar
功能：C/C++文件内容分类和快速定位 
a)： 支持文件namespace,functin,variant等类型分类及快速定位
帮助:
在Tagbar窗口输入`?` 或者输入:
```
:help tagbar
```

3. CtrlP
功能：文件快速搜索
a)： 支持文件在指定工程目录下快速搜索
b)： 支持文件在最近最常使用的文件集合中搜索
c)： 支持文件在Buffer文件集合中搜索
帮助:
```
:help ctrlp
```

4. a.vim
功能：C/C++文件头文件和源文件切换
a)： 支持头文件和源文件在不同窗口模式(水平,垂直)中进行切换
帮助:
```
`:A` switches to the header file corresponding to the current file being edited (or vise versa)
`:AS` splits and switches
`:AV` vertical splits and switches
`:AT` new tab and switches
`:AN` cycles through matches
`:IH` switches to file under cursor
`:IHS` splits and switches
`:IHV` vertical splits and switches
`:IHT` new tab and switches
`:IHN` cycles through matches
`<Leader>ih` switches to file under cursor
`<Leader>is` switches to the alternate file of file under cursor (e.g. on  <foo.h> switches to foo.cpp)
`<Leader>ihn` cycles through matches
```

5. NerdCommenter
功能：快速注释
a)： 支持不同形式(行注释、块注释)的快速注释和反注释
帮助:
```
:help nerdcommenter
```

6. Syntastic
功能：静态语法错误检查
a)： 支持静态语法检查并提示出错行和出错信息
帮助:
```
:help syntasitc
```

7. vim-surround
功能：快速`]`,`}`,`(`,`'`,`"`,`<`等封闭符号编辑
a)： 支持快速`]`,`}`,`(`,`'`,`"`,`<`等封闭符号增删修改
帮助:
```
:help surround
```

8. vim-airline
功能：状态栏显示
a)： 支持状态栏各种编辑状态显示
帮助:
```
:help airline
```

9. solarized
功能：配色
a) 支持`dark`和`light`两种配色

9. vim-fugitive
功能：vim git管理插件
a) 支持vim git快速方便管理
帮助:
```
:help fugitive
```

10. YouCompleteMe
功能：vim 自动补全功能
a) 支持vim像IDE一样自动补全,不过安装很复杂,需要`llvm+clang`编译和VIM的`python`支持
帮助:
```
:help youcompleteme
```

11. vim-markdown
功能：vim markdown语法高亮
a) 支持vim中markdown编辑语法高亮
帮助:
```
:help markdown
```

12. markdown-preview.nvim
功能：vim markdown预览
a) 支持vim中markdown预览
帮助:
```
:help markdown-preview
```

13. fzf
功能：vim模糊查找功能
a) 支持vim中文本模糊查找
b) 支持vim文件名模糊查找
c) 支持vim最近使用文件模糊查找
帮助:
```
:help fzf
```

14. indentLine
功能：vim缩进可视化
a) 支持vim缩进显示
帮助:
```
:help indentLine
```

15. vim-snippets
功能：vim代码Snippet
a) 支持vim代码Snippet
帮助:
```
:help snippets
```

16. Vundle
功能：vim 插件包管理插件
a) 通过git方式来管理VIM插件包,支持通过github或VIM插件中在线自动更新插件和本地文件插件更新
帮助:
```
`:PluginList`       - lists configured plugins
`:PluginInstall`    - installs plugins; append `!` to update or just
`:PluginUpdate`     - update plugins;
`:PluginSearch` foo - searches for foo; append `!` to refresh local cache
`:PluginClean`      - confirms removal of unused plugins; append `!` to auto-approve removal
```

VIM中插件配置如下:

```
"++++++++++++++++++++ plugin in config++++++++++++++++++++ 
filetype off                  " required
set rtp+=$HOME/.vim/bundle/Vundle.vim     " set the runtime path to include Vundle and initialize
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
" call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'


"********** How to add different plugin **********  
" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'vim-scripts/a.vim'
Plugin 'preservim/nerdcommenter'
Plugin 'preservim/nerdtree'
Plugin 'altercation/solarized'
Plugin 'preservim/tagbar'
Plugin 'vim-airline/vim-airline'
Plugin 'godlygeek/tabular'
Plugin 'preservim/vim-markdown'
Plugin 'iamcco/markdown-preview.nvim'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'
Plugin 'junegunn/fzf', {'do': {-> fzf#install()}}
Plugin 'junegunn/fzf.vim'
Plugin 'dense-analysis/ale'
Plugin 'rust-lang/rust.vim'
Plugin 'ycm-core/YouCompleteMe'
Plugin 'tmhedberg/SimpylFold' " Fold plugin for python
Plugin 'nvie/vim-flake8'      " Syntax checking for python
Plugin 'Yggdroot/indentLine'  " Display thin vertical lines at each indentation
Plugin 'SirVer/ultisnips'     " Track the engine.
Plugin 'honza/vim-snippets'   " Snippets are separated from the engine. Add this if you want them:

" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" 
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
"
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
"
" To ignore plugin indent changes, instead use:
filetype plugin on " load file type plugin 
filetype on        " file type detect on

"++++++++++++++++++++ nerdtree config++++++++++++++++++++
" :help nerdtree OR ? 
autocmd vimenter * NERDTree " open NERDTree when vim start up
let NERDTreeIgnore=['\.pyc$', '\~$', '\.so$', '\.dll$', '\.vim$', '\.swp$'] "ignore files in NERDTree
map <C-n> :NERDTreeToggle<CR>   
" ctrl-n to toggle NERDTree


"++++++++++++++++++++ nerdcommenter config++++++++++++++++++++
" :help nerdcommenter AND :help <LEADER> to see the leader is '\'
let g:NERDSpaceDelims = 1   " add space after comment delimiters by default
let g:NERDDefaultAlign = 'left'  " align line-wise comment delimiters flush left
let g:NERDAltDelims_java = 1 " use the alternative delimiters for a specific filetype by default 
let g:NERDCommentEmptyLines = 1 " If this option is turned on, then empty lines will be commented as well. Useful when commenting regions of code


"++++++++++++++++++++ tagbar config++++++++++++++++++++
" :help tagbar OR ?
" autocmd VimEnter * nested :TagbarOpen " open tagbar when vim start up
map <C-t> :TagbarToggle<CR>   
" ctrl-t to toggle tagbar
let g:tagbar_autofocus = 1 " If you set this option the cursor will move to the Tagbar window when it is
let g:rust_use_custom_ctags_defs = 1

"let g:tagbar_type_rust = {
"  \ 'ctagstype' : 'rust',
" 'ctagsbin' : '/path/to/your/universal/ctags',
"  \ 'kinds' : [
"      \ 'n:modules',
"      \ 's:structures:1',
"      \ 'i:interfaces',
"      \ 'c:implementations',
"      \ 'f:functions:1',
"      \ 'g:enumerations:1',
"      \ 't:type aliases:1:0',
"      \ 'v:constants:1:0',
"      \ 'M:macros:1',
"      \ 'm:fields:1:0',
"      \ 'e:enum variants:1:0',
"      \ 'P:methods:1',
"  \ ],
"  \ 'sro': '::',
"  \ 'kind2scope' : {
"      \ 'n': 'module',
"      \ 's': 'struct',
"      \ 'i': 'interface',
"      \ 'c': 'implementation',
"      \ 'f': 'function',
"      \ 'g': 'enum',
"      \ 't': 'typedef',
"      \ 'v': 'variable',
"      \ 'M': 'macro',
"      \ 'm': 'field',
"      \ 'e': 'enumerator',
"      \ 'P': 'method',
"  \ },
"\ }

"++++++++++++++++++++ airline config++++++++++++++++++++
map <C-a> :AirlineToggle<CR>   
" ctrl-a to toggle airline
let g:airline#extensions#tabline#enabled = 1 " enable enhanced tabline 
let g:airline#extensions#tabline#show_buffers = 1 " enable displaying buffers with a single tab. (c)


"++++++++++++++++++++ solarized config++++++++++++++++++++
syntax on
set t_Co=256
if has('gui_running')
	set background=dark                      " Set background color"
else
	set background=dark
endif

" COMMENT THIS WHEN SSH CONNECTION
colorscheme solarized 

"++++++++++++++++++++ cscope config++++++++++++++++++++
if has("cscope")
	set csprg=/usr/bin/cscope
	set csto=0
	set cst
	set nocsverb
	" add any database in current directory
	if filereadable("cscope.out")
		cs add cscope.out
		" else add database pointed to by environment
	elseif $CSCOPE_DB != ""
		cs add $CSCOPE_DB
	endif
	set csverb
    set cscopequickfix=s-,c-,d-,i-,t-,e-
endif

" Using 'CTRL-@' then a search type makes the vim window
nmap <C-@>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-@>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-@>d :cs find d <C-R>=expand("<cword>")<CR><CR>

" Using 'CTRL-spacebar' then a search type makes the vim window
" split horizontally, with search result displayed in
" the new window.
nmap <C-Space>s :scs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space>g :scs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space>c :scs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space>t :scs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space>e :scs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space>f :scs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-Space>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-Space>d :scs find d <C-R>=expand("<cword>")<CR><CR>

" Hitting CTRL-space *twice* before the search type does a vertical
" split instead of a horizontal one
nmap <C-Space><C-Space>s
	\:vert scs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space><C-Space>g
	\:vert scs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space><C-Space>c
	\:vert scs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space><C-Space>t
	\:vert scs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space><C-Space>e
	\:vert scs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space><C-Space>i
	\:vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-Space><C-Space>d
	\:vert scs find d <C-R>=expand("<cword>")<CR><CR>


"++++++++++++++++++++ markdown config++++++++++++++++++++
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_override_foldtext = 0
let g:vim_markdown_folding_level = 6
let g:vim_markdown_no_default_key_mappings = 1
let g:vim_markdown_toc_autofit = 1
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0

"++++++++++++++++++++  markdown preview  config++++++++++++++++++++
" set to 1, nvim will open the preview window after entering the markdown buffer
" default: 0
let g:mkdp_auto_start = 0

" set to 1, the nvim will auto close current preview window when change
" from markdown buffer to another buffer
" default: 1
let g:mkdp_auto_close = 1

" set to 1, the vim will refresh markdown when save the buffer or
" leave from insert mode, default 0 is auto refresh markdown as you edit or
" move the cursor
" default: 0
let g:mkdp_refresh_slow = 0

" set to 1, the MarkdownPreview command can be use for all files,
" by default it can be use in markdown file
" default: 0
let g:mkdp_command_for_global = 0

" set to 1, preview server available to others in your network
" by default, the server listens on localhost (127.0.0.1)
" default: 0
let g:mkdp_open_to_the_world = 0

" use custom IP to open preview page
" useful when you work in remote vim and preview on local browser
" more detail see: https://github.com/iamcco/markdown-preview.nvim/pull/9
" default empty
let g:mkdp_open_ip = ''

" specify browser to open preview page
" for path with space
" valid: `/path/with\ space/xxx`
" invalid: `/path/with\\ space/xxx`
" default: ''
let g:mkdp_browser = ''

" set to 1, echo preview page url in command line when open preview page
" default is 0
let g:mkdp_echo_preview_url = 0

" a custom vim function name to open preview page
" this function will receive url as param
" default is empty
let g:mkdp_browserfunc = ''

" options for markdown render
" mkit: markdown-it options for render
" katex: katex options for math
" uml: markdown-it-plantuml options
" maid: mermaid options
" disable_sync_scroll: if disable sync scroll, default 0
" sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
"   middle: mean the cursor position alway show at the middle of the preview page
"   top: mean the vim top viewport alway show at the top of the preview page
"   relative: mean the cursor position alway show at the relative positon of the preview page
" hide_yaml_meta: if hide yaml metadata, default is 1
" sequence_diagrams: js-sequence-diagrams options
" content_editable: if enable content editable for preview page, default: v:false
" disable_filename: if disable filename header for preview page, default: 0
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {},
    \ 'content_editable': v:false,
    \ 'disable_filename': 0,
    \ 'toc': {}
    \ }

" use a custom markdown style must be absolute path
" like '/Users/username/markdown.css' or expand('~/markdown.css')
let g:mkdp_markdown_css = ''

" use a custom highlight style must absolute path
" like '/Users/username/highlight.css' or expand('~/highlight.css')
let g:mkdp_highlight_css = ''

" use a custom port to start server or empty for random
let g:mkdp_port = ''

" preview page title
" ${name} will be replace with the file name
let g:mkdp_page_title = '「${name}」'

" recognized filetypes
" these filetypes will have MarkdownPreview... commands
let g:mkdp_filetypes = ['markdown']

" set default theme (dark or light)
" By default the theme is define according to the preferences of the system
let g:mkdp_theme = 'dark'

"++++++++++++++++++++ rust.vim config++++++++++++++++++++
" let g:rustfmt_autosave = 1 

"++++++++++++++++++++ YCM For Rust config++++++++++++++++++++
"install ycm step: 
" 1. add Plugin "ycm-core/YouCompleteMe" and PluginInstall/Update
" 2. cd ~
"    sudo apt install build-essential cmake python3-dev libclang1
"    sudo apt install libclang-dev -y
" 3. clangd --version 
"    sudo apt-get install clangd-12(XXVERSION)
"    sudo update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-12 100
" 4. cd ~/.vim/bundle/YouCompleteMe
"    sudo apt-get install python-dev python3-dev
" 5. cd ~ 
"    mkdir ycm_build
"    cd ycm_build
"    cmake -G "Unix Makefiles" . ~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp
"    cmake --build . --target ycm_core --config Release
" 6: cd ~
"    sudo apt-get install python-setuptools
"    cd ~/.vim/bundle/YouCompleteMe
"    git submodule update --init --recursive (if .vim/bundle/YouCompleteMe/third_party/ycmd/third_party is empty 
"    or watchdog directory is empty, MAY reExecute more than 1 time)
"    cd   ~/.vim/bundle/YouCompleteMe/third_party/ycmd/third_party/watchdog_deps/watchdog
"    sudo update-alternatives --install /usr/bin/python python /usr/bin/python2.7 1
"    sudo update-alternatives --install /usr/bin/python python /usr/bin/python3.8 2
"    update-alternatives --config python(pick python3)
"    python setup.py build --build-base=build/3 --build-lib=build/lib3
" 7. cd ~
"    sudo npm install -g --prefix third_party/tsserver typescript
" 8. rustup update
"    rustup toolchain install nightly
"    rustup default nightly
"    rustup component add rls
"    rustup component add rust-src
"    rustup component add rust-analysis
" 9. cd ~/.vim/bundle/YouCompleteMe
"    python3 ./install.py --clangd-completer --rust-completer --ts-completer
" 10. config .vim.rc about ycm as below
" clangd config
" Let clangd fully control code completion
 let g:ycm_clangd_uses_ycmd_caching = 0
 let g:ycm_clangd_binary_path = "/usr/bin/clangd"
 " ycm config
 let g:ycm_semantic_triggers={'c,cpp,python,rust,go,cs,javascript,typescript':['re!\w{2}']}
 " rust toolchain check command: rustc --print sysroot
 let g:ycm_rust_src_path='$HOME/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src'
 let g:ycm_complete_in_comments = 1
 let g:ycm_seed_identifiers_with_syntax = 1
 let g:ycm_collect_identifiers_from_tags_files = 1
" let g:ycm_goto_buffer_command='horizontal-split'
" let g:ycm_global_ycm_extra_conf='~/.vim/ycm_extra_conf.py'
set completeopt=menu,menuone " disable the function defininition preview window
set completeopt-=preview " disable windows to show up preview
let g:ycm_add_preview_to_completeopt=0
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_autoclose_preview_window_after_insertion=1
let g:ycm_key_invoke_completion='<C-x>'
map <F12> : YcmCompleter GoToDefinitionElseDeclaration<CR>
" YCM Debug command:  YcmDebugInfo;  YcmRestartServer
"++++++++++++++++++++ make config++++++++++++++++++++

" %: current complete file name including suffix file type
" %<: current file name not including suffix file type

" c/c++/shell/python file compile and run
map <F5> :call CompileAndRun() <CR>
func! CompileAndRun()
    exec "w"
    if &filetype =='c'
        exec "!gcc % -o %<"
        exec "slicent !clear"
        exec "! ./%<"
    elseif &filetype =='cpp'
        exec "!g++ % -o %<"
        exec "slicent !clear"
        exec "! ./%<"
    elseif &filetype =='sh'
        exec "slicent !clear"
        exec "! ./%"
    elseif &filetype =='python'
        exec "slicent !clear"
        exec "!python ./%"
    endif
endfunc

map <F10> :call RunGdb() <CR>
func! RunGdb()
    exec "w"
    if &filetype == 'c'
        exec "!gcc % -g -o %<"
        exec "slicent !clear"
        exec "!gdb ./%<"
    elseif &filetype == 'cpp'
        exec "!g++ % -g -o %<"
        exec "slicent !clear"
        exec "!gdb ./%<"
    endif
endfunc

"++++++++++++++++++++ leader f config++++++++++++++++++++
let g:Lf_ShortcutF= '<c-p>'
let g:Lf_ShortcutB= '<c-b>'
let g:WorkingDirectoryMode = 'AF'
let g:Lf_RootMarkers = ['.git', '.svn', '.hg', '.project', '.root']
let g:Lf_PreviewInPopup = 1
let g:Lf_WindowHeight = 0.30
let g:Lf_StlColorscheme= 'powerline'

"++++++++++++++++++++ simpyl fold config++++++++++++++++++++
let g:SimpylFold_docstring_preview=1

"++++++++++++++++++++ flake config++++++++++++++++++++
let python_highlight_all=1

"++++++++++++++++++++ indent line config++++++++++++++++++++
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
" let g:indentLine_color_term = 255 " change color 
map <F3> :IndentLinesToggle<cr> " F3 toggle indent line function

"++++++++++++++++++++ UltiSnips  config++++++++++++++++++++
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

"++++++++++++++++++++ ALE  config++++++++++++++++++++
let g:ale_linters = {
            \ 'rust': ['analyzer'],
\}
let g:ale_fixers = {
            \ 'rust': ['rustfmt', 'trim_whitespace', 'remove_trailing_lines']
\}

" Optional, configure as-you-type completions
let g:ale_completion_enabled = 1"
let g:ale_python_flake8_options = '--max-line-length=88'

"++++++++++++++++++++ autopairs config++++++++++++++++++++
let g:AutoPairsFlyMode = 1
map <F2> :AutoPairsShortcutToggle<cr> " F2 toggle indent line function

"++++++++++++++++++++ fzf config++++++++++++++++++++
"append and export MACRO in .zshrc AND .bashrc
"
" # FZF using ripgrep [support multi-files search]
" # Set custom color schemes
" # Check color schemes : https://github.com/junegunn/fzf/wiki/Color-schemes
" if type rg &> /dev/null; then
"   export FZF_DEFAULT_COMMAND='rg --files'
"   export FZF_DEFAULT_OPTS='
"   -m --height 30% --border 
"   --color fg:242,bg:236,hl:65,fg+:15,bg+:239,hl+:108
"   --color info:108,prompt:109,spinner:108,pointer:168,marker:168
"   '
" fi
"
" Echo $SHELL to check DEFAULT shell and echo $0 to check CURRENT shell
" Switch to related shell by zsh AND bash command and source .zshrc AND .bashrc
"
" Remap shortkey
nnoremap <silent> <leader>f :Files<CR>
nnoremap <silent> <leader>g :GFiles<CR>
nnoremap <silent> <leader>r :Rg<CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>l :BLines<CR>
nnoremap <silent> <leader>t :Helptags<CR>
nnoremap <silent> <leader>h :History<CR>
nnoremap <silent> <leader>h: :History:<CR>
nnoremap <silent> <leader>h/ :History/<CR>
" Set grepprg as RipGrep 
if executable("rg")
    set grepprg=rg\ --vimgrep\ --smart-case\ --hidden\ --follow
    set grepformat=%f:%l:%c:%m,%f:%l:%m
endif
"
" Exclude rg content search in file names and only search file contents
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)

"
" Rg basic Search Usage:
" Search for foo in current working directory: :grep foo.
" Search for foo in files under src/: :grep foo src.
" Search for foo in current file directory: :grep foo %:h.
" Search for foo in current file directory’s parent directory: :grep foo %:h:h (and so on).
" Search for the exact word foo (not foobar): :grep -w foo (equivalent to :grep '\bfoo\b').
" Search for foo in files matching a glob: :grep foo -g '*.rs'
"
" Quickfix Replace Usage:
" :cdo s/foo/bar/gc. And then :cfdo update
"

" ********** Brief help **********
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just
" :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
" " see :h vundle for more details or wiki for FAQ
"
``` 

本人的VIM环境整体的配置效果如图所示:
![vim-cfg](vim-display.png)
> 左边窗口是`NerdTree`，右边是`Tagbar`，下方是`fzf`

附:
比较齐全的VIM命令图解:
![vim-cmd](vim-cheatsheet.jpg)
![vim-cmd2](vim-cheatsheet2.jpg)

## 总结
***

**工欲善其事必先利其器**, 如果是在C/C++/Python等语言下做开发,VIM作为其编辑器在使用熟练情况能够一定程度上提高生产力,但是必须面对一个事实是:VIM的学习曲线很陡,需要不停的折腾.自己也是在不断的学习和了解它,不过慢慢感觉使用多了,习惯了使用它编辑,很快你就会喜欢上它。


## 参考
---

[https://en.wikipedia.org/wiki/Vim_(text_editor)](https://en.wikipedia.org/wiki/Vim_(text_editor))

[www.vim.org](www.vim.org)

[http://www.tuicool.com/articles/f6feae](http://www.tuicool.com/articles/f6feae)

[https://www.ibm.com/developerworks/cn/linux/l-cn-tip-vim/](https://www.ibm.com/developerworks/cn/linux/l-cn-tip-vim/)

[http://yannesposito.com/Scratch/en/blog/Learn-Vim-Progressively/](http://yannesposito.com/Scratch/en/blog/Learn-Vim-Progressively/)

[http://www.cnblogs.com/DillGao/p/6268165.html](http://www.cnblogs.com/DillGao/p/6268165.html)
