---
title: C++虚函数表归属
date: 2021-07-14
categories: C++
tags:
- C++
- Object Model
---

## 前言
---
之前讨论过C++对象模型里面涉及到虚函数表及虚函数表指针问题，C++类实例化对象时候，不同实例化对象有各自的虚函数表指针，但是指针指向的虚函数表对于不同的实例化对象是否都各自存一份还是属于类的呢?有必要验证下(如未特别说明均在G++9.4.0, Gcc9.4.0, Ubuntu20.04, 64bit机器环境下测试的)

<!--more-->

## 单个类实例化不同对象
---

如下面带有虚函数得`Base`类:
```
class Base
{
public:
    virtual void fun() 
    {
        std::cout << "i am base func1" << std::endl;
    };
    virtual void func2()
    {
        std::cout << "i am base func2" << std::endl;
    }
};
```

实例化两个不同对象的测试：
```
void vtableOwnerTest1(void)
{
    Base b0, b1;
    long *p1, *p2, *p3, *p4, *p5, *p6;
    p1 = (long*)*(long*)&b0;
    p2 = (long*)*(long*)&b1;
    p3 = (long*)*(long*)*(long*)&b0;
    p4 = (long*)*(long*)*(long*)&b1;
    p5 = (long*)*((long*)*(long*)&b0 + 1);
    p6 = (long*)*((long*)*(long*)&b1 + 1);
    std::cout << "b0 object addrs:" << (long*)&b0 << std::endl;
    std::cout << "b1 object addrs:" << (long*)&b1 << std::endl;
    std::cout << "b0 vptr addrs:" << p1 << std::endl;
    std::cout << "b1 vptr addrs:" << p2 << std::endl;
    std::cout << "b0 func1 addrs:" << p3 << std::endl;
    std::cout << "b1 func1 addrs:" << p4 << std::endl;
    std::cout << "b0 func2 addrs:" << p5 << std::endl;
    std::cout << "b1 func2 addrs:" << p6 << std::endl;
    if (p1 == p2)
    {
        std::cout << "vtable belong to Class" << std::endl;
    }
    else
    {
        std::cout << "vtable belong to Object" << std::endl;
    }
    if (p3 == p4)
    {
        std::cout << "b0 & b1 use the same func1 " << std::endl;
    }
    else
    {
        std::cout << "b0 & b1 use different func1" << std::endl;
    }
    if (p5 == p6)
    {
        std::cout << "b0 & b1 use the same func2 " << std::endl;
    }
    else
    {
        std::cout << "b0 & b1 use different func2" << std::endl;
    }
}
```

运行结果：

    b0 object addrs:0x7ffc33792f08
    b1 object addrs:0x7ffc33792f10
    b0 vptr addrs:0x557438cf8d48
    b1 vptr addrs:0x557438cf8d48
    b0 func1 addrs:0x557438cf6978
    b1 func1 addrs:0x557438cf6978
    b0 func2 addrs:0x557438cf69b4
    b1 func2 addrs:0x557438cf69b4
    vtable belong to Class
    b0 & b1 use the same func1 
    b0 & b1 use the same func2 

>可以看到对于同一类的对同实例化对象而言，虚函数表指针的值是一致的，即虚函数表是属于类的(每个对象均使用相同的虚函数`func1`及`func2`地址这个是必须保证的)但是每个对象都包含一个自己的虚函数表指针，关系类似于这样的：
![vtb_1](vtable-base.png)

## 继承类与基类分别实例化对象
---
如下面的子类继承自上面的`Base`类:
```
class Derive : public Base 
{
public:
    // derive only override func2
    void func2()
    {
        std::cout << "i am derive func2" << std::endl;
    }
};
```

继承类与基类实例化分别实例化对象的测试：
```
void vtableOwnerTest2(void)
{
    Base b;
    Derive d;

    long *p1, *p2, *p3, *p4, *p5, *p6;
    p1 = (long*)*(long*)&b;
    p2 = (long*)*(long*)&d;
    p3 = (long*)*(long*)*(long*)&b;
    p4 = (long*)*(long*)*(long*)&d;
    p5 = (long*)*((long*)*(long*)&b + 1);
    p6 = (long*)*((long*)*(long*)&d + 1);
    std::cout << "b object addrs:" << (long*)&b << std::endl;
    std::cout << "d object addrs:" << (long*)&d << std::endl;
    std::cout << "b vptr addrs:" << p1 << std::endl;
    std::cout << "d vptr addrs:" << p2 << std::endl;
    std::cout << "b func1 addrs:" << p3 << std::endl;
    std::cout << "d func1 addrs:" << p4 << std::endl;
    std::cout << "b func2 addrs:" << p5 << std::endl;
    std::cout << "d func2 addrs:" << p6 << std::endl;
    if (p1 == p2)
    {
        std::cout << "Derive & Base use the same vtable " << std::endl;
    }
    else
    {
        std::cout << "Derive & Base use different vtable " << std::endl;
    }
    if (p3 == p4)
    {
        std::cout << "b & d use the same func1 " << std::endl;
    }
    else
    {
        std::cout << "b & d use different func1" << std::endl;
    }
    if (p5 == p6)
    {
        std::cout << "b & d use the same func2 " << std::endl;
    }
    else
    {
        std::cout << "b & d use different func2" << std::endl;
    }
}
```

运行结果：

    b object addrs:0x7ffc33792f08
    d object addrs:0x7ffc33792f10
    b vptr addrs:0x557438cf8d48
    d vptr addrs:0x557438cf8d28
    b func1 addrs:0x557438cf6978
    d func1 addrs:0x557438cf6978
    b func2 addrs:0x557438cf69b4
    d func2 addrs:0x557438cf69f0
    Derive & Base use different vtable 
    b & d use the same func1 
    b & d use different func2

> 从运行结果可以看出子类虽然只是重写了父类的其中一个虚函数,但仍然使用自己的虚函数表,虚函数表里面的未重写的虚函数`func1`是从基类继承而来的,虚函数地址也保持一致;
重写之后的虚函数`func2`地址就变化了生成了新的函数，关系类似于这样的：
![vtb_2](vtable-derive.png)

## 总结
---

从验证结果可以看出虚函数表是属于类的，每个对象会维护自己的指向虚函数表的虚函数表指针；继承情况下，父类会有自己的虚函数表，且父类会从基类继承虚函数，重写虚函数的话，虚函数地址会变化（生成新的函数）


