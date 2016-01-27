---
title: GFM格式Markdown简介
date: 2016-1-22
categories: Markdown
tags:
- Markdown
- 标记语言
- GitHub
---

## Markdown各种扩展
Markdown除了标准的语法格式外，还有各种格式的扩展
<!--more-->
- [PHP Markdown Extra][]
    + 支持在html块元素中插入markdown语法
    + 支持为一些元素添加id或class
    + 支持将代码块用\`或者`~`包起来，这样可以避免一些二义，还可以为代码块添加id或class
    + 支持手写的表格
    + 支持脚注引用
- [Maruku][]
是基于**Ruby**开发的解释器，具有以下特点：
    + 支持原生Markdown
    + 支持所有PHP Markdown Extra的特性
    + 支持新的元数据语法，实际上就是给元素添加属性的能力
    + 支持公式格式输出
不过，该项目已经停止维护了
- [kramdown][]
同样是**Ruby**开发的解释器，kramdown吸取了Maruku几乎所有的特点，功能更为强大。其中有特点的功能有:
    + 引入EOB标记^作为块元素的分隔符
    + 手写table的语法更加强大一些，支持table中的header和footer
    + 还支持注释，以及在转化时配置一些转化选项
    + 同样支持ALD(Attribute List Definitions属性列表定义)
[GitHub Page 推荐使用kramdown解释器][]
- [RDiscount][]
同样是**Ruby**开发的解释器，不过它是基于[Discount][]的语法移植的,以语法规则需要参考Discount。其语法支持几种上面没有提到过的特性:
    + 文本居中，即输出`<center>`
    + 图片大小定义`![dust mite](http://dust.mite =150x150)`
    + 输出alpha列表：`<ol type='a'></ol>`
- [Redcarpet][]
Redcarpet是一个转化库，可以在标准Markdown的基础上，配置一些额外的功能:
    + 单词中间的_不处理
    + 转化PHP-Markdown风格的手写表格
    + 转化PHP-Markdown风格的带包含的代码块，也可禁用标准markdown的代码块语法自动link生成
    + 删除线支持：`~~good~~`
    + 高亮标签`<mark></mark>`通过`==highlighted==`输出
    + 引用标签`<q></q>`通过`"quote"`输出
    + 转化PHP-Markdown风格脚注
    + 一些二义性的约束支持
- [GitHub][]
**Github Page对于上述的基于*Ruby*的markdown都是支持的**，从[这里](https://pages.github.com/versions/)可以看到。另外，Github对于Issue、comments等，还定义了GFM([GitHub Flavored Markdown][])，其中的语法一般基本来源于上面的提到的东西。除此之外，github还支持一些额外的特性：
    + 支持把列表变成带勾选框的任务列表
    + 站内对分支、问题、用户等对象的直接引用
    + [表情](http://www.emoji-cheat-sheet.com/)

## GFM Markdown
***
GitHub 使用的是“GitHub Flavored Markdown"，简称GFM，有site-in issues,comments,pull requests等功能，它与标准的Markdown有一些区别，并增加了些新的扩展功能，区别如下：

### 单词内多下划线
标准的Markdown转换`_`成斜体，GFM忽略了单词内部的`_`，如：

    hi_great_world
    do_this_and_do_other
效果：
hi_great_world
do_this_and_do_other

> 这个特性允许代码里和名字里含有多个`_`的单词能够正确的解释，如果强调一个单词可以使用`*`

### URL自动链接
标准Markdown使用`<`URL`>`来支持自动链接；GFM会自动链接标准的URLs，如果你想链接到一个URL(而不是设置链接文本)，你可以简单的输入一个URL地址，GFM会自动转换成一个URL链接，如:

    http://www.franktly.com
效果：
http://www.franktly.com

### 删除线
GFM增加了标准Markdown中没有的删除线的语法，使用两个`~`表示，如：

    ~~wrong text.~~
效果：
~~wrong text.~~

### 栅栏式的代码块
标准的Markdown把每行的开始带有4个空格或一个Tab的文本转换为代码块；GFM除了此，还支持
栅栏式代码块，仅仅需要把你的代码你用三个\`包裹起来即可，不需要通过4个空格来区分了，如：
````
```
void hello()
{
    print("hello");
}
```
````
效果(栅栏式代码块自动加了默认的高亮)：
```
void hello()
{
    print("hello");
}
```
> 尽管栅栏式代码块并不需要在前面增加一个空行（不像缩进式代码块），GFM建议最好加上一个空行，这样方便原始的Markdown更容易阅读
> 在列表里面，你必须使用8个空格来表示一个非栅栏式的代码块

### 语法高亮
代码块通过加语法高亮更容易阅读，在栅栏式代码块基础之上，增加一个可选的语言标字符(如 ruby,C,C++,pyhon等等)，GFM通过此种方式来进行代码语法高亮，如以下Ruby代码：
````
```ruby
require 'redcarpet'
markdown = Redcarpet.new("Hello World!")
puts markdown.to_html
```
````
效果：
```ruby
require 'redcarpet'
markdown = Redcarpet.new("Hello World!")
puts markdown.to_html
```
而没加高亮是这样的(标准Markdown换行加空四格)：

    require 'redcarpet'
    markdown = Redcarpet.new("Hello World!")
    puts markdown.to_html
> GFM使用[Linguist][]来检测语言进行语法高亮，可以参阅[YAML file][]来确定哪些关键字的语言被支持

### 表格
1)GFM在标准的Markdown语法基础上增加了表格，可以通过组合一系列单词通过连字符`-`（仅在第一行上使用）分隔第一行，通过`|`来分隔表格的每一列即可，如：

    First Header | Second Header
    -------------| -------------
    Content Cell | Content Cell 
    Content Cell | Content Cell  
效果：
![table-1](http://7xq8f9.com1.z0.glb.clouddn.com/pic%2Ftable-1.PNG)
2)为了好看，可以在最后一列增加`|`:

    First Header | Second Header |
    -------------| ------------- |
    Content Cell | Content Cell  |
    Content Cell | Content Cell  | 
效果：
![table-2](http://7xq8f9.com1.z0.glb.clouddn.com/pic%2Ftable-2.PNG)
3)表头开始的破折号并不需要一定要匹配Header文本的长度(匹配的目的也是为了格式美观):

    Name | Description           |
    -------------| ------------- |
    Open   | Open Door |
    Close  | Close Door | 
效果：
![table-3](http://7xq8f9.com1.z0.glb.clouddn.com/pic%2Ftable-3.PNG)
4)通过在第一个行的`-`序列中增加`:`可以格式化文本的对齐方式，如`:`位于`-`序列左边表示文本左对齐，两边都有表示文本中间对齐，位于右边则表示右对齐，如：

    | Left Aligned | Center Aligned | Right Aligned |
    |:------------ |:--------------:| -------------:|
    | c11          | c12            | c13           |
    | c21          | c22            | c23           | 
效果：
![table-4](http://7xq8f9.com1.z0.glb.clouddn.com/pic%2Ftable-4.PNG)

### HTML
可以在GitHub的READMEs，issues和requests中使用HTML的子集，支持的标签和属性可以参考[github/markup repository](https://github.com/github/markup)

### GFM换行
标准Markdown要在一行的最后加两个空格符才表示换行，否则是不换行的；但是GFM则没有此要求

    第一行(最后无两个空格)
    第二行

### 任务列表
GFM支持将列表变为[任务列表][]，通过在列表的前面增加 `[ ]`或`[x]`(分别代码未完成和完成)，如：

    + [ ] a task list item
    + [ ] list syntax required
    + [ ] normal **formatting**,@emontions, #1232 refs
    + [ ] incomplete
    + [x] completed
看到的结果是checkboxes 列表，可以修改Markdown文本，可以Check或者Uncheck Boxes,文本会自动更新，像是这样的：
![GFM Task List](http://7xq8f9.com1.z0.glb.clouddn.com/pic%2Fgfm-tasklist.gif)
任务列表可以嵌套任务的深度,GFM建议最多嵌套1到2层，如：

    + [ ] a bigger project
      + [ ] first subtask #1
      + [ ] second subtask #2
    + [x] a small project
      + [x] first substask #3

### 引用
特定的引用会自动被链接，如：

    - SHA: a5c3785ed8d6a35868bc169f07e40e889087fd2e
    - User@SHA: jlord@a5c3785ed8d6a35868bc169f07e40e889087fd2e
    - User/Repository@SHA: jlord/sheetsee.js@a5c3785ed8d6a35868bc169f07e40e889087fd2e
    - #Num: #26
    - GH-Num: GH-26
    - User#Num: jlord#26
    - User/Repository#Num: jlord/sheetsee.js#26

### 特性
- 快速引用(`r`)
- @mentions自动生成名字和组(`@`)
- Emoji自动生成表情(`:`)
- Issue自动生成(`#`)

## 参考
[Markdown的各种扩展][]
[GitHub Flavored Markdown][]
[Markdown Basics][]
[Writing on GitHub][]


[PHP Markdown Extra]: https://michelf.ca/projects/php-markdown/extra/
[Maruku]: https://github.com/bhollis/maruku/blob/master/docs/markdown_syntax.md
[kramdown]: http://kramdown.gettalong.org/
[GitHub Page 推荐使用kramdown解释器]: https://help.github.com/articles/migrating-your-pages-site-from-maruku/
[RDiscount]: http://www.pell.portland.or.us/~orc/Code/discount/
[Discount]: http://www.pell.portland.or.us/~orc/Code/discount/
[Redcarpet]: https://github.com/vmg/redcarpet
[Linguist]: https://github.com/github/linguist
[YAML file]: https://github.com/github/linguist/blob/master/lib/linguist/languages.yml
[任务列表]: https://github.com/blog/1375%0A-task-lists-in-gfm-issues-pulls-comments

[GitHub Flavored Markdown]: https://help.github.com/articles/github-flavored-markdown/
[GitHub]: https://help.github.com/articles/writing-on-github/
[Markdown的各种扩展]: http://www.pchou.info/open-source/2014/07/07/something-about-markdown.html
[Markdown Basics]: https://help.github.com/articles/markdown-basics/
[Writing on GitHub]: https://help.github.com/articles/writing-on-github/