---
title: C++构造函数拷贝构造函数及赋值拷贝函数
date: 2021-05-01
categories: C++
tags:
- C++
---

## 前言
---
在C++面试过程中，一个常考的题目就是**实现一个类似于String类功能的字符串类**，这道题目看似简单，其实如果一不小心就会踩到坑。完整的写出包括普通构造函数、拷贝构造函数及赋值拷贝函数的字符串类其实也不简单，但是能看出一个C++码字者的基本功。本篇就简单实现这个字符串类功能，并延伸对C++构造、拷贝构造和赋值拷贝函数的一些总结

<!--more-->

## 一道实现String类的C++面试题
---

题目大致为：
实现一个自定义的字符串类，类似于String类，包括一般构造函数、拷贝构造函数及赋值拷贝函数

### 标准代码实现
---

标准实现代码如下：
```
class myString
{
public:
    // 构造函数
    myString(const char* str = NULL)
    {
        if (NULL == str)
        {
            _str = new char[1];
            _str[0] = '\0';
        }
        else
        {
            _str = new char[strlen(str) + 1]; // strlen不包括\0 需要+1
            strcpy(_str, str);
        }
    }
    // 拷贝构造函数
    myString(const myString &other) // 必须为引用，否则会编译失败
    {
        if (NULL == other._str)
        {
            _str = new char[1];
            _str[0] = '\0';
        }
        else
        {
            _str = new char[strlen(other._str) + 1]; // strlen不包括\0 需要+1
            strcpy(_str, other._str);
        }
    }
    // 操作符重载
    myString& operator = (const myString &other) // 返回引用，便于链式表达
    {
        // stardard solution:

        // firstly: check self assignment
        if (this == &other)
        {
            return *this;
        }

        // secondly: delete origin memory
        delete _str;
        _str = NULL;

        // thirdly: new memory and  copy other's _str var to new memory
        _str = new char[strlen(other._str) + 1];
        strcpy(_str, other._str);

        //forth: return this pointer
        return *this;
    }
    virtual ~myString()
    {
        if (NULL != _str)
        {
            free(_str);
            _str = NULL;
        }
    }
public:
    void print(void) // for test to observe
    {
        std::cout << _str << std::endl;
    }
private:
    char *_str;
};
```

这里面有几个坑容易踩到：
1. 分配内存时候要 **考虑传入`char*`指针参数参数为空情况**且分配内存时候注意`strlen`函数的长度不包括`\0`
2. 对于构造函数、拷贝构造函数及赋值构造函数，由于我们一般不会改变入参指针或引用值，**最好前面加`const`关键字限制**
3. 对于拷贝构造函数 **一定要传递引用类型**，不然会出错，因为如果不传引用传值的话，对于参数为传值类型的函数，会执行一次参数的拷贝会调用本身的拷贝构造函数，因为实际函数体使用的是实参的副本，而同时，该函数本身又是拷贝构造函数，导致无限的递归下去，函数的堆栈空间溢出
4. 对于赋值拷贝函数 **最好传递引用类型**，虽然不会像拷贝构造函数那样无限递归，但是有函数参数对象的拷贝动作，空间和时间效率上都有所下降，同时 **应该返回对象的引用**，便于赋值拷贝运算符`=`的链式表达
5. 对于赋值拷贝函数，还需要 **考虑自赋值的情况**

### 测试用例
---


```
    myString str1;        // 一般的默认NULL参数的构造函数
    myString str2("tly"); // 一般的自定义传参的构造函数
    myString str3(str2);  // 一般的拷贝构造函数
    myString str4, str5;
    str3 = str3;         // 自赋值的赋值拷贝函数
    str5 = str4 = str3; //  赋值拷贝函数的链式表达

    str1.print();
    str2.print();
    str3.print();
    str4.print();   
    str5.print();
}
```

### 运行结果
---

        此行为空输出 
        tly
        tly
        tly
        tly   

>可以看出三个函数均能正常的工作且支持自赋值和赋值的链式表达

### 改进1：赋值拷贝函数增加代码的健壮性
---

对于拷贝构造函数，标准的实现下分为以下几步：
1. 检查自赋值
2. 释放成员指针变量指向的旧的内存空间
3. 申请函数参数传入的对象大小的内存空间给成员指针变量并拷贝
4. 返回`*this`

对于标准实现，考虑到代码的健壮性，里面有动态分配内存的情况，万一申请内存失败了咋整？如果考虑此种情况的话，实现的顺序需要稍作调整了，代码如下实现：
```
// 操作符重载
    myString& operator = (const myString &other) // 返回引用，便于链式表达
    {
        // solution 2: consider safety

        // firstly: check self assignment
        if (this == &other)
        {
            return *this;
        }

        // secondly: new memory
        char *newBuffer = NULL;
        newBuffer = new(std::nothrow) char[strlen(other._str) + 1]; // no throw bad_alloc
        if (NULL == newBuffer) // 分配失败处理
        {
            return *this;
        }

        // thirdly: copy to new buffer and then delete origin memory and assign to _str
        strcpy(newBuffer, other._str);
        delete _str;
        _str = newBuffer; // first copy to new buffer then assign to _str; on the contrary will failed!!!

        //forth: return this pointer
        return *this;
    }
```

>此处为了简化不使用`try-catch`捕捉`bad_alloc`异常，在`new`的时候使用了`std::nothrow`参数以方便分别失败时候的`NULL`判断
>为了保证对象的完整性，先申请新指针成员指向的内存，因为申请失败后可以直接返回原对象(指针成员被释放之前对象是完整的)，否则再释放对象的指针成员指向的内存


### 改进2：赋值拷贝函数使用临时对象交换内存空间实现
---

对于赋值拷贝函数，标准做法有释放和申请动态内存的操作，一种比较巧妙的方法是通过交换指针成员的指向来实现，这样可以避免手动的操作内存，代码实现如下：
```
// 操作符重载
    myString& operator = (const myString &other) // 返回引用，便于链式表达
    {
        // solution 3: swap _str's pointing memory space

        if (this != &other)
        {
            // firstly: construct a tmp object by copy construction
            myString strTemp(other); 

            // secondly: swap _str pointer's pointing memory space with strTemp object
            char *p = NULL;
            p = strTemp._str;
            strTemp._str = _str;
            _str = p;  
        }

        // thirdly:  strTemp's memory space(point to _str's origin memory space) free automatically and return this pointer
        return *this;
    }
```

>此方法主要使用了拷贝构造函数和临时局部对象在函数返回会自动释放内存的原理实现的(由于指针指向的内存交换了，实际上释放的是指针成员原来指向的内存空间)

## 三者区别

| 函数类型 | 是否有新对象产生 | 是否有深拷贝浅拷贝问题| 参数是否必须为引用| 执行时机 |
|:------------:|:--------------:|:-------------:|:-------------:|:-----------:|
| 普通构造函数  |    有       |   无，直接构造无拷贝过程   | 不必  |new或直接定义|
| 拷贝构造函数  |    有       |     有                   | 必须  |直接定义调用或函数入参对象传值或返回临时对象
| 赋值拷贝函数  |无，只是对象内成员变量拷贝|   有          | 最好是 |直接调用|


>1.这三个函数如果任意一个用户没有实现的时候，编译器在 **需要的时候**都会自动生成一个相应的函数，但是对于拷贝构造和赋值拷贝函数都是浅拷贝，如果涉及到操作指针成员最好 **自己重写两个函数**，否则在对象析构时候会对指针成员指向内存释放两次，如果被拷贝的指针成员以前指向的内存不为空还会出现内存泄漏问题
>2.这三个函数都可以存在多个，即可以参数不同可以重载多个


