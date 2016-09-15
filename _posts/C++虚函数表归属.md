---
title: C++虚函数表归属
date: 2016-9-15
categories: C++
tags:
- C++
- Object Model
---

## 前言
---
之前讨论过C++对象模型里面涉及到虚函数表及虚函数表指针问题，C++类实例化对象时候，不同实例化对象有各自的虚函数表指针，但是指针指向的虚函数表对于不同的实例化对象是否都各自存一份还是属于类的呢?有必要验证下(如未特别说明均在VS2015 Win10下测试的)

<!--more-->

## 单个类不同实例化对象
---

如下面带有虚函数得类，
```
class Base
{
public:
    virtual void fun() 
    {
        std::cout << "i am base " << std::endl;
    };
};
```

实例化两个不同对象的测试：
```
void vtableOwnerTest1(void)
{
    Base b0, b1;
    std::cout << "b0 vptr addrs:" << (int*)*(int*)&b0 << std::endl;
    std::cout << "b1 vptr addrs:" << (int*)*(int*)&b1 << std::endl;
    if (*(int*)&b0 == *(int*)&b1)
    {
        std::cout << "Vtable belong to Class" << std::endl;
    }
    else
    {
        std::cout << "Vtable belong to Object" << std::endl;
    }
}
```

运行结果：

    b0 vptr addrs:0015BF3C
    b1 vptr addrs:0015BF3C
    Vtable belong to Class

>可以看到对于同一类的对同实例化对象而言，虚函数表指针的值是一致的，即虚函数表是属于类的，但是每个对象都包含一个虚函数指针，类似于这样的：


## 总结
---

本篇主要介绍了C++类对象大小的计算，并引出了对象模型内部的基本内存布局和三种对象模型，下一篇将继续介绍在各种继承情况下，继承类的内存布局变化情况




