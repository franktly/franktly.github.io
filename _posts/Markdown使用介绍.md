---
title: Markdown使用介绍
date: 2016-10-21
categories: Tools
tags:
- markdown
- 标记语言
--- ## 前言
***
Markdown 是一个从文本到HTML的转换工具，通过简单的易读易写的文本格式生成结构化的HTML文档，是一种用来写作的轻量级**标记语言**，它使得我们能够专心于码字，而用**标记**语法来代替常见的排版格式，Markdown可以支持导出HTML格式的网页形式，也可以很方便的导出PDF格式

<!--more-->

## Markdown 介绍
***
Markdown的目标是*易读易写*，具有以下优点：
- 兼容HTML，Markdown作为轻量级的标记语言，其初衷不是想取代HTML，而是让文档更容易读、写和随意更改，HTML是一种发布的格式，而Markdown是一种书写的格式。Markdown 的格式语法只涵盖纯文本可以涵盖的范围，不在Markdown涵盖范围之内的标签，都可以直接在文档里面用 HTML撰写，不需要额外标注这是 HTML 或是 Markdown，只要直接加标签就可以了
- 专注你的文字内容而不是排版样式，安心写作
- 轻松的导出 HTML、PDF 和本身的 .md 文件
- 纯文本内容，兼容所有的文本编辑器与字处理软件
- 随时修改你的文章版本，不必像字处理软件生成若干文件版本导致混乱
- 可读、直观、学习成本低

## Markdown 语法（[Standard][]）
*** 

### Markdown术语
#### Markdown 段落
一个 Markdown **段落**是由一个或多个连续的文本行组成，它的前后要有一个以上的空行（空行的定义是显示上看起来像是空的，便会被视为空行。比方说，若某一行只包含空格和制表符，则该行也会被视为空行）。普通段落不该用空格或制表符来缩进。
> [由一个或多个连续的文本行组]成这句话其实暗示了 Markdown 允许段落内的强迫换行（插入换行符），如果你确实想要依赖 Markdown 来插入 `<br/>` 标签的话，在插入处先按入两个以上的空格然后回车
> 需要多费点事（多加空格然后回车）来产生`<br/>`，但是简单地[每个换行都转换为 `<br/>`]的方法在 Markdown 中并不适合， Markdown 中 email 式的 区块引用 和多段落的 列表 在使用换行来排版的时候，不但更好用，还更方便阅读

### Markdown区块元素
#### 标题
Markdown支持两种标题的语法，类 Setext 和类 atx 形式:
类 Setext 形式是用底线的形式，利用 `=`（最高阶标题）和`-` （第二阶标题），例如:

    This is H1
    =============
    This is H2
    -------------
效果：

This is H1
 =============
This is H2
-------------

类 Atx 形式则是在行首插入 1 到 6 个`#`，对应到标题 1 到 6 阶，例如:

    # This is H1
    ## This is H2
    ### This is H3
    #### This is H4
    ##### This is H5
    ###### This is H6
效果：
# This is H1
## This is H2
### This is H3
#### This is H4
##### This is H5
###### This is H6


可以选择性地「闭合」类 atx 样式的标题，这纯粹只是美观用的，若是觉得这样看起来比较舒适，你就可以在行尾加上`#`，而行尾的`#` 数量也不用和开头一样（行首的井字符数量决定标题的阶数）

    # This is H1 #
    ## This is H2 ##
    ### This is H3 ###
    #### This is H4 ####
    ##### This is H5 #####
    ###### This is H6 ######
效果:
# This is H1 #
## This is H2 ##
### This is H3 ###
#### This is H4 ####
##### This is H5 #####
###### This is H6 ######


#### 引用
Markdown 标记区块引用是使用类似 email 中用`>`的引用方式，如果你还熟悉在 email 信件中的引言部分，你就知道怎么在 Markdown文件中建立一个区块引用
1) Markdown区块看起来像是你自己先断好行，然后在每行的最前面加上`>`：
```
    > This is Paragraph 1 Line 1,
    > This is Paragraph 1 Line 2,
    >
    > This is Paragraph 2 Line 1,
    > This is Paragraph 2 Line 2,
```

效果：
> This is Paragraph 1 Line 1,
> This is Paragraph 1 Line 2,
>
> This is Paragraph 2 Line 1,
> This is Paragraph 2 Line 2,

2) Markdown也允许你偷懒只在整个段落的第一行最前面加上`>`：
```
    > This is Paragraph 1 Line 1,
    This is Paragraph 1 Line 2,

    > This is Paragraph 2 Line 1,
    This is Paragraph 2 Line 2,
```

效果：
> This is Paragraph 1 Line 1,
>  This is Paragraph 1 Line 2,

> This is Paragraph 2 Line 1,
> This is Paragraph 2 Line 2,

3) Markdown区块引用可以嵌套（例如：引用内的引用），只要根据层次加上不同数量的`>`:
```
    > This is Paragrah 1 Line 1 Depth 1
    >>This is Paragraph 1 Line 2 Depth 2
    > This is Pargaraph 1 Line 3 Depth 2
    > 
    > This is Paragrah 2 Line 1 Depth 1
    >>This is Paragraph 2 Line 2 Depth 2
    > This is Pargaraph 2 Line 3 Depth 2
```

效果：
> This is Paragrah 1 Line 1 Depth 1
>>This is Paragraph 1 Line 2 Depth 2
> This is Pargaraph 1 Line 3 Depth 2
> 
> This is Paragrah 2 Line 1 Depth 1
>>This is Paragraph 2 Line 2 Depth 2
> This is Pargaraph 2 Line 3 Depth 2



4) Markdown引用的区块内也可以使用其他的Markdown语法，包括标题、列表、代码区块等：
```
    > ## This is A title
    > 1. This is List 1
    > 2. This is List 2
    > `cout << "hello world" << endl;`
```

效果：
> ## This is A title
> 1. This is List 1
> 2. This is List 2
> `cout << "hello world" << endl;`

#### 列表
Markdown支持有序和无序列表
1) 无序列表使用`*`、`+`、`-`作为列表标记
```
    - China
    - Japan
    - Korea
```

效果:
- China
- Japan
- Korea

等同于：
```
    * China
    * Japan
    * Korea
```

效果：
* China
* Japan
* Korea

也等同于：
```
    + China
    + Japan
    + Korea
```

效果：
+ China
+ Japan
+ Korea

2) 有序列表使用数字接着一个英文句点：

    1. China
    2. Japan
    3. Korea

效果：
1. China
2. Japan
3. Korea

很重要的一点是，你在列表标记上使用的数字并不会影响输出的HTML结果

1) 如果列表项目间用空行分开，在输出HTML时Markdown就会将项目内容用`<p>`标签包起来，举例来说: 
```
    - China
    - Japan
    - Korea
```

会被转换为：

```
    <ul>
```

效果：
- China
- Japan
- Korea

2) 有序列表使用数字接着一个英文句点：

```
    1. China
    2. Japan
    3. Korea
```

效果：
1. China
2. Japan
3. Korea


1) 如果列表项目间用空行分开，在输出HTML时Markdown就会将项目内容用`<p>`标签包起来，举例来说: 
```
    - China
    - Japan
    - Korea
```

会被转换为：

```
    <ul>
    <li>China</li>
    <li>Japan</li>
    <li>Korea</li>
    </ul>
```

但是这个如果有空行：
```
    - China

    - Japan

    - Korea
```

效果：
- China

- Japan

- Korea

会被转换为：

    <ul>
    <li><p>China</p></li>
    <li><p>Japan</p></li>
    <li><p>Korea</p></li>
    </ul>

2) 列表项目可以包含多个段落，每个项目下的段落都必须缩进4个空格或是1个制表符：
```
    1.  This is p1
        This is p1 and 4 space or 1 tab draw back
    2.  This is p2
        This is p2 and 4 space or 1 tab draw back
```

效果：
1.  This is p1
    This is p1 and 4 space or 1 tab draw back
2.  This is p2
    This is p2 and 4 space or 1 tab draw back

3) 如果要放代码区块的话，该区块就需要缩进两次，也就是 8 个空格或是 2 个制表符：
```
    1.  This is p1 code
            Hello World 1
    2.  This is p2
            Hello World 2
```

效果：
1.  This is p1 code
        Hello World 1
2.  This is p2
        Hello World 2

4) 如果在行首出现数字句点空白，要避免这样的状况与有序列表格式冲突，你可以在句点前面加上反斜杠转义：
```
    1988\. This is a great year
```

效果：
1988\. This is a great year

#### 代码区块
和程序相关的写作或是标签语言原始码通常会有已经排版好的代码区块，通常这些区块我们并不希望它以一般段落文件的方式去排版，而是照原来的样子显示，Markdown 会用 `<pre>` 和 `<code>` 标签来把代码区块包起来

1) 要在 Markdown 中建立代码区块很简单，只要简单地缩进 4 个空格或是 1 个制表符就可以，例如，下面的输入：

```
    This is a paragragh
    // !此处加空行
        cout << "hello world" << endl;
```

效果：

    This is a paragragh
    // !此处加空行
        cout << "hello world" << endl;

Markdown 会转换成：

    <p> This is a paragraph</p>
    <pre><code>cout << "Hello World" << endl;</code></pre>

这个每行一阶的缩进（4 个空格或是 1 个制表符），都会被移除，例如：

```
    Here is a Expample of Python:
    // !此处加空行
        def showhello:
            print("Hello World")
            print("How are you")
    This is a normal paragraph
```

效果：

    Here is a Expample of Python:
    // !此处加空行
        def showhello:
            print("Hello World")
            print("How are you")
    This is a normal paragraph


>一个代码区块会一直持续到没有缩进的那一行（或是文件结尾）。

2) 在代码区块里面，`&` 、`<` 和 `>`会自动转成 HTML 实体`&amp`、`&lt;`、`&gt;`，这样的方式让你非常容易使用 Markdown 插入范例用的 HTML 原始码，只需要复制贴上，再加上缩进就可以了，剩下的 Markdown 都会帮你处理，例如：

    <div class="footer">
      &copy; Markdown Corporation
    </div>
会被转换为：

    <pre><code>&lt;div class="footer"&gt;
        &amp;copy; Markdown Corporation
    &lt;/div&gt;
    </code></pre>
3) 代码区块中，一般的 Markdown 语法不会被转换，像是星号便只是星号，这表示你可以很容易地以 Markdown 语法撰写 Markdown 语法相关的文件

#### 分隔线
你可以在一行中用三个以上的`*`、`-`、`_`来建立一个分隔线，行内不能有其他东西。你也可以在星号或是减号中间插入空格。下面每种写法都可以建立分隔线：

    ***
    - * * *
    ----
    _ _ _ _

效果：
***
- * * *
----
_ _ _ _


### Markdown区段元素
***
#### 链接

##### 文字链接
Markdown 支持两种形式的链接语法： 行内式和参考式两种形式
不管是哪一种，链接文字都是用 [方括号] 来标记

1) 要建立一个行内式的链接，只要在方块括号后面紧接着圆括号并插入网址链接即可，如果你还想要加上链接的 title 文字，只要在网址后面，用双引号把 title 文字包起来即可，例如：

    This is [My Blog](http://www.taolingyang.com/ "frank") inline link.

效果：
    This is [My Blog](http://www.taolingyang.com/ "frank") inline link.

如果你是要链接到同样主机的资源，你可以使用相对路径：

    See my [About](/about/) page for details.

效果：
    See my [About](/about/) page for details.

2) 参考式的链接是在链接文字的括号后面再接上另一个方括号，而在第二个方括号里面要填入用以辨识链接的标记：

    This is [My Blog][id] reference link
    [id]: http://www.franktly.com/ "frank"

效果：
This is [My Blog][id] reference link
[id]: http://www.taolingyang.com/ "frank"

>链接辨别标签可以有字母、数字、空白和标点符号，但是并**不区分**大小写

**隐式链接标记**功能让你可以省略指定链接标记，这种情形下，链接标记会视为等同于链接文字，要用隐式链接标记只要在链接文字后面加上一个空的方括号
链接内容定义的形式为：

    [My Blog][]
    [My Blog]: http://www.franktly.com "frank"

效果：
[My Blog][]
[My Blog]: http://www.taolingyang.com "frank"

>链接的定义可以放在文件中的任何一个地方，我比较偏好直接放在链接出现段落的后面，你也可以把它放在文件最后面，就像是注解一样。

链接内容定义的形式为：
* 方括号（前面可以选择性地加上至多三个空格来缩进），里面输入链接文字
* 接着一个冒号
* 接着一个以上的空格或制表符
* 接着链接的网址
* 选择性地接着 title 内容，可以用单引号、双引号或是括弧包着

##### 图片链接
Markdown 使用一种和链接很相似的语法来标记图片，同样也允许两种样式： 行内式和参考式。

1) 行内式的图片语法看起来像是：

    ![Alt text](/path/to/img.jpg)
    ![Alt text](/path/to/img.jpg "Optional title")
>* 一个惊叹号 !
>* 接着一个方括号，里面放上图片的替代文字
>* 接着一个普通括号，里面放上图片的网址，最后还可以用引号包住并加上 选择性的 'title' 文字。

2) 参考式的图片语法则长得像这样：

    ![Alt text][id]
    [id]: /path/to/img.jpg "Optional title"

#### 斜体与加强
Markdown 使用星号（\*）和底线（\_）作为标记强调字词的符号，被 \* 或 \_ 包围的字词会被转成用 `<em>` 标签包围表示斜体，用两个 \* 或 \_ 包起来的话，则会被转成 `<strong>`表示变粗加强，例如:

    *Single Strong*
    **Double Strong**
    _Single Strong_
    __Double Strong__

效果：
*Single Strong*
**Double Strong**
_Single Strong_

#### 代码
1) 如果要标记一小段行内代码，你可以用反引号把它包起来（\`），例如：

    Program Begin With `main()` function

效果：
Program Begin With `main()` function

会被转换成这样：

    <p><code>Program Begin With `main()` function</code></p>

2) 如果要在代码区段内插入反引号，你可以用多个反引号来开启和结束代码区段：

    ``This is a Literal Backtick ` Here``

效果：
``This is a Literal Backtick ` Here``

### 其他
#### 反斜杠
Markdown 可以利用反斜杠来插入一些在语法中有其它意义的符号进行转义，真实的表示该符号，而不进行标签替换处理

    \* This is incluced By (\*) \*

效果：
\* This is incluced By (\*) \*

Markdown 支持以下这些符号前面加上反斜杠来帮助插入普通的符号：

    \   反斜线
    `   反引号
    -   星号
    _   底线
    {}  花括号
    []  方括号
    ()  括弧
    #   井字号
    *   加号
    +   减号
    .   英文句点
    !   惊叹号

#### 自动链接
Markdown支持以比较简短的自动链接形式来处理网址和电子邮件信箱，只要是用方括号包起来， Markdown就会自动把它转成链接。一般网址的链接文字就和链接地址一样，例如：

    <http://www.taolingyang.com>

效果：
<http://www.taolingyang.com>
被转化为：

    <a href="http://www.taolingyang.com">http://www.taolingyang.com</a>
邮址的自动链接也很类似

## Markdown 免费编辑器
***
Windows：
* [MarkdownPad][]
* [MarkPad][]
* [GitHub Atom][]

Linux:
* [ReText][]

Mac:
* [Mou][]

网页在线：
* [Markable.in][]
* [Dillinger.io][]
* [MaHua][]

高级：Sublime Text 3 + MarkdownPre + MarkdownEditing
* Sublime Text 3

## Markdown项目主页
[Markdown Project][]

## 参考
[http://www.markdown.cn](http://www.markdown.cn/)
[http://wowubuntu.com/markdown](http://wowubuntu.com/markdown/index.html)

[Standard]: http://daringfireball.net/projects/markdown/syntax
[MarkdownPad]: http://markdownpad.com/
[MarkPad]: http://markpad.fluid.impa.br/
[GitHub Atom]: https://atom.io/
[ReText]: http://www.oschina.net/p/retext
[Mou]: http://25.io/mou/
[Markable.in]: https://markable.in/
[Dillinger.io]: http://dillinger.io/
[MaHua]: http://mahua.jser.me/
[Sublime Text 3]: http://www.sublimetext.com/
[Markdown Project]: http://daringfireball.net/projects/markdown/
