---
title: OpenCascade及资源汇总
date: 2021-08-01 
categories: OpenCascade
tags:
- OpenCascade
- 3D
- Geometry
---

## 前言
***

[OpenCascade](https://www.opencascade.com/)，简称`OCCT`，是一个开源的3D几何内核开发平台库，Wiki上这样论述`OCCT`：

    Open Cascade Technology (OCCT), formerly called CAS.CADE, is an open-source software development platform for 3D CAD, CAM, CAE, etc.
    that is developed and supported by Open Cascade SAS. 
    OCCT is a full-scale B-Rep (Boundary representation) modeling toolkit. 
    OCCT is available under the LGPL-2.1-only license permitting its usage in open source and proprietary applications

> `OCCT` 前称 CAS.CADE，是一个开源的3D计算机辅助设计，辅助制造，辅助功能等的软件开发平台，由 Open Cascade SAS这家机构开发和支持。`OCCT`是一个`BRep`模型工具包，在LGPL-2.1的开源许可证下使用。

<!--more-->

## 几何内核平台
除了`OCCT`作为数不多的开源几何内核平台外，还有其他的商业几何平台，常见的应用和内核如下表所示：
|     Kernel   |       Application    |  Country   |
|:------------:|:--------------------:|:----------:|
| ShapeManager |   AutoCAD            |     USA    |
| Parasolid    |   Siemens NX         | USA,Germany|
| Parasolid    |   SolidWorks         | USA,France |
| C3D          |   KOMPAS             |   Russia   |
| ACIS         |   ArchiCAD           |   Hungary  |
| CGM          |   CATIA              |   France   |
| ACIS         |   Cimatron           |   Israel   |
| OpenCascade  |   FreeCAD            |   France   |
| ACIS         |   SpaceClaim         |     USA    |

> 几何内核平台基本上被Siemens公司的`Parasolid`和Dassault公司的`ACIS`垄断，常用的UG，SolidWorks软件都是基于这些内核开发的，而本文介绍的`OCCT`开源内核比较出名的也是开源的FreeCAD软件

## OCCT概况
### OCCT功能
`OCCT`提供了3D表面和实体建模，CAD数据交换，可视化等基本功能，主要是以C++库的形式提供，包括以下功能：
1. 基本的数据结构，包括几何模型，可视化，交互式选择及特定应用服务接口
2. 模型算法
3. Mesh数据
4. 和标准数据格式(IGES,STEP)交互

### OCCT模块
`OCCT`以C++库形式组合成模块，主要包括以下模块：
1. Foundation Classse: 其他OCCT类依赖的基本类库，包括基本类，内存分配器，OS抽象层，集合数据结构，BVH树，向量，矩阵等基本数学运算类库
2. Modeling Data: 提供表达2D/3D几何基本元素及其组合的CAD模型数据结构，集合图元包括分析曲线如直线，圆，椭圆，双曲线，抛物线，Bezier曲线，B样条曲线，偏移等；分析曲面如平面，圆柱面，圆锥面，圆环面，球面，Bezier,B样条，旋转，拉伸，偏移等，这些基本的图元模型定义及`Brep`表达实现
3. Modeling Algorithm: 提供Mesh和各种几何和拓扑相关算法，如交集，布尔运算，网格划分，倒角，修复等等
3. Visualiztion: 提供数据可视化显示的复杂机制，实现了一个紧凑的`OpenGL/OpenGL ES`渲染器，支持常用的着色模型和光线跟踪路径跟踪算法，除了`OCCT`自己提供`AIS`模块可视化显示外还支持第三方的如`VTK`库的集成显示
4. Data Exchange: 提供与主流数据格式的互操作性和依赖`Shape Healing`提高不同CAD系统的兼容性
5. Application Framework: 提供开箱即可用的开发上层应用的基本框架
模块功能如下图所示：
![occt-modular](occt-modular.png)

## OCCT资源
本人在使用`OCCT`平台时候，主要参考了以下几种资源，现在罗列如下:

### 官方资源
1. 最权威齐全的说明文档地址：[Full Online Documentation](https://dev.opencascade.org/doc/overview/html/)
> 里面包含了`OCCT`大部分的说明包括模块介绍，每个模块的具体详细部分原理和代码说明，源码和第三方库各个平台编译`OCCT`的方法，官方自带的各种例子，算法测试命令行，一些标准说明比如`Brep`格式等等，算是比较权威和齐全的说明
>

2. 开发API查询地址：[Reference Manual](https://dev.opencascade.org/doc/refman/html/index.html)
> 根据`OCCT`源代码文档注释通过`Doxygen`文档生成工具生成的文档，实时更新的文档，对查询`OCCT`各个模块，类，函数，变量，常量等各种类型的定义和使用说明很有帮助

3. 付费的E-Training: [E-Training](https://www.opencascade.com/training-programs/)
> 付费的官方培训或电子视频资源

4. 官方论坛: [Forums](https://dev.opencascade.org/forums)
> 遇到问题可以在上面进行提问，里面包含了`OCCT`实时的release和announcement信息及分模块讨论板块

5. 技术博客：[Blog](https://dev.opencascade.org/blog)
> 官方的版本发布信息及一些技术原理分享

6. 视频资源：[Youtube](https://www.youtube.com/channel/UCO6fnQhuib2WjMZwB-lxIwA)
> 需要科学上网，官方的`Youtube`视频，主要包括一些`OCCT`产品应用和部分特性讲解，相对而言技术干货比较少些

7. 源码：
[OCCT-GitHub](https://github.com/Open-Cascade-SAS/OCCT)
[pythonOCC-Github](https://github.com/tpaviot/pythonocc)

### 其他第三方资源
1. 技术博客
国内的为数不多的`OCCT`技术相关个人博客：
[eryar](http://www.cppblog.com/eryar/category/17808.html)
国外`OCCT`技术相关个人博客(可能需要科学上网)：
[Unlimited 3D](https://unlimited3d.wordpress.com/)
[OpenCascade Notes](https://opencascade.blogspot.com/)
[Manifold Geometry](http://quaoar.su/blog/)

2. 视频资源：[Quaoar's Workshop](https://www.youtube.com/c/QuaoarsWorkshop)
> 需要科学上网，俄罗斯`OCCT`资深开发者的`Youtube`频道，讲解了很多关于`OCCT`的方面的技术和教程，很详细很难得的免费视频资源


## 参考
---

[OpenCascade Technology wikipedia](https://en.wikipedia.org/wiki/Open_Cascade_Technology)

[OpenCascade Official](https://www.opencascade.com)

[OpenCascade Dev Doc](https://dev.opencascade.org/doc/overview/html)

[OpenCascade -GitHub](https://github.com/Open-Cascade-SAS/OCCT)

