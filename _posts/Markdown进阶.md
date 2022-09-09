---
title: Markdown进阶
date: 2016-11-03
categories: Tools
tags:
- markdown
- 标记语言
---

## Markdown列表嵌套
Markdown列表(包括有序和无序列表）嵌套，可以通过缩进4个空格或1个Tab来实现：
<!--more-->

    - China
        + Beijing
        + Shanghai
    - Japan
        + Tokyo
    - America
        + NewYork
        + Washington
效果：
- China
    + Beijing
    + Shanghai
- Japan
    + Tokyo
- America
    + NewYork
    + Washington

## Markdown代码嵌入连续3个\`字符
Markdown要想在代码里面保留三个\`字符它的原始样子而不被转换成代码块(标准MD中没有)，可以增加4个或更多的\` 来包裹：
`````
````
```
void main()
{
    printf("Hello World!");
}
```
````
`````
效果：
````
```
void main()
{
    printf("Hello World!");
}
```
````
> 对于连续N个\`，需要N + 1 个\`来进行包裹

## Markdown首行缩进
写文章时，我们常常希望能够首行缩进，这时可以在段首加入`&ensp;`来输入一个空格.加入`&emsp;`来输入两个空格。
如：

    > No Space In Line
    > &emsp;Two Space In Line
    > &emsp;&emsp; Four Space In Line
    > &ensp;One Space In Line
    > &ensp;&ensp; Two Space In Line

效果：
![markdown-indent](markdown-ex1.png)

普通段落尽量不用空格或制表符来缩进，即使使用它们后得到的效果看似是对的

## Markdown脚注
Markdown脚注(标准MD中没有)的语法看起来是这样的：

    A[^A]
    [^A]: 注释
如：

    Markdown[^Markdown]
    [^Markdown]: Markdown 是一种轻量级的标记语言，以易读易写作为宗旨
    GFM[^GFM]
    [^GFM]: GFM全称为GitHub Flavored Markdown

效果：
![markdown-foot](markdown-ex2.png)

