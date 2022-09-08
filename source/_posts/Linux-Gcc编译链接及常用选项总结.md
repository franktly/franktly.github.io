---
title: Gcc编译链接及常用选项总结
date: 2016-06-08
categories: Linux
tags:
- Linux
- Gcc
- 编译
- 链接
---

## 前言
---
GNU CC（简称Gcc）是GNU项目中符合ANSI C标准的编译系统，能够编译用C、C++和Object- C等语言编写的程序。Gcc不仅功能强大，而且可以编译如C、C++、Object C、Java等多种语言，而且Gcc又是一个交叉平台编译器，它能够在当前CPU平台上为多种不同体系结构的硬件平台开发软件。本章中的示例均采用Gcc版本为4.8.2。

<!--more-->

## Gcc编译链接流程
---

Gcc编译链接流程分为**四个步骤**:
1. 预处理(Pre-Processsing)
2. 编译(Compiling)
3. 汇编(Assembling)
4. 链接(Linking)

Gcc指令的一般格式为：

    gcc [option1] compile-files [option2] object-files

>其中目标文件可缺省，Gcc默认生成的可执行文件命名为:编译文件名.out

下面以简单的`hello world`程序为例说明Gcc编译的四个过程：
```
#include <stdio.h>
void main(int argc, char* argv[])
{
  printf("hello world");
  return;
}
```

### 预处理过程
`option1` 为`-E`,生成的目标文件为`.i`(c)或`.ii`(c++)后缀的经过预处理的编译输入文件,Gcc指令为：
    
    tly@ubuntu ~> gcc -E test.c -o test.i

生成的预编译文件内容为：
```
# 1 "test.c"
# 1 "<command-line>"
# 1 "/usr/include/stdc-predef.h" 1 3 4
# 1 "<command-line>" 2
# 1 "test.c"
# 1 "/usr/include/stdio.h" 1 3 4
# 27 "/usr/include/stdio.h" 3 4
# 1 "/usr/include/features.h" 1 3 4
# 374 "/usr/include/features.h" 3 4
# 1 "/usr/include/i386-linux-gnu/sys/cdefs.h" 1 3 4
... 省略
...
extern char *ctermid (char *__s) __attribute__ ((__nothrow__ , __leaf__));
# 913 "/usr/include/stdio.h" 3 4
extern void flockfile (FILE *__stream) __attribute__ ((__nothrow__ , __leaf__));

extern int ftrylockfile (FILE *__stream) __attribute__ ((__nothrow__ , __leaf__)) ;

extern void funlockfile (FILE *__stream) __attribute__ ((__nothrow__ , __leaf__));
# 943 "/usr/include/stdio.h" 3 4
# 2 "test.c" 2
void main(int argc, char* argv[])
{
  printf("hello world");
  return;
}  
```

>Gcc预处理过程把`<stdio.h>`的内容插入到hello.i文件中了
 
### 编译
`option1` 为`-S`,生成的目标文件为`.s`或`.S`后缀的经过编译但是没有汇编过的汇编文件,Gcc编译过程首先要检查代码的规范性、是否有语法错误等，以确定代码的实际要做的工作，在检查无误后，Gcc把代码翻译成汇编语言Gcc指令为：
    
    tly@ubuntu ~> gcc -S test.i -o test.s

生成的编译之后的汇编文件内容为：
```
        .file   "test.c"
        .section        .rodata
.LC0:
        .string "hello world"
        .text
        .globl  main
        .type   main, @function
main:
.LFB0:
        .cfi_startproc
        pushl   %ebp
        .cfi_def_cfa_offset 8
        .cfi_offset 5, -8
        movl    %esp, %ebp
        .cfi_def_cfa_register 5
        andl    $-16, %esp
        subl    $16, %esp
        movl    $.LC0, (%esp)
        call    printf
        nop
        leave
        .cfi_restore 5
        .cfi_def_cfa 4, 4
        ret
        .cfi_endproc
.LFE0:
        .size   main, .-main
        .ident  "GCC: (Ubuntu 4.8.2-19ubuntu1) 4.8.2"
        .section        .note.GNU-stack,"",@progbits
~                                                       
```

>Gcc编译过程已经将其转化为汇编语言了

### 汇编
`option1` 为`-c`，生成的目标文件为以`.o`为后缀的二进制目标代码文件，Gcc指令为：
    
    tly@ubuntu ~> gcc -c test.s -o test.o

生成的汇编之后的目标文件内容为：
```
^?ELF^A^A^A^@^@^@^@^@^@^@^@^@^A^@^C^@^A^@^@^@^@^@^@^@^@^@^@^@^X^A^@^@^@^@^@^@4^@^@^@^@^@(^@^M^@
^@U<89>å<83>äð<83>ì^PÇ^D$^@^@^@^@èüÿÿÿ<90>ÉÃhello world^@^@GCC: (Ubuntu 4.8.2-19ubuntu1) 4.8.2^@^@^@^@^T^@^@^@^@^@^@^@^AzR^@^A|^H^A^[^L^D^D<88>^A^@^@^\^@^@^@^\^@^@^@^@^@^@^@^X^@^@^@^@A^N^H<85>^BB^M^ETÅ^L^D^D^@^@^@.symtab^@.strtab^@.shstrtab^@.rel.text^@.data^@.bss^@.rodata^@.comment^@.note.GNU-stack^@.rel.eh_frame^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^_^@^@^@^A^@^@^@^F^@^@^@^@^@^@^@4^@^@^@^X^@^@^@^@^@^@^@^@^@^@^@^A^@^@^@^@^@^@^@^[^@^@^@  ^@^@^@^@^@^@^@^@^@^@^@ä^C^@^@^P^@^@^@^K^@^@^@^A^@^@^@^D^@^@^@^H^@^@^@%^@^@^@^A^@^@^@^C^@^@^@^@^@^@^@L^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^A^@^@^@^@^@^@^@+^@^@^@^H^@^@^@^C^@^@^@^@^@^@^@L^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^A^@^@^@^@^@^@^@0^@^@^@^A^@^@^@^B^@^@^@^@^@^@^@L^@^@^@^L^@^@^@^@^@^@^@^@^@^@^@^A^@^@^@^@^@^@^@8^@^@^@^A^@^@^@0^@^@^@^@^@^@^@X^@^@^@%^@^@^@^@^@^@^@^@^@^@^@^A^@^@^@^A^@^@^@A^@^@^@^A^@^@^@^@^@^@^@^@^@^@^@}^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^A^@^@^@^@^@^@^@U^@^@^@^A^@^@^@^B^@^@^@^@^@^@^@<80>^@^@^@8^@^@^@^@^@^@^@^@^@^@^@^D^@^@^@^@^@^@^@Q^@^@^@        ^@^@^@^@^@^@^@^@^@^@^@ô^C^@^@^H^@^@^@^K^@^@^@^H^@^@^@^D^@^@^@^H^@^@^@^Q^@^@^@^C^@^@^@^@^@^@^@^@^@^@^@¸^@^@^@_^@^@^@^@^@^@^@^@^@^@^@^A^@^@^@^@^@^@^@^A^@^@^@^B^@^@^@^@^@^@^@^@^@^@^@ ^C^@^@°^@^@^@^L^@^@^@       ^@^@^@^D^@^@^@^P^@^@^@  ^@^@^@^C^@^@^@^@^@^@^@^@^@^@^@Ð^C^@^@^T^@^@^@^@^@^@^@^@^@^@^@^A^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^A^@^@^@^@^@^@^@^@^@^@^@^D^@ñÿ^@^@^@^@^@^@^@^@^@^@^@^@^C^@^A^@^@^@^@^@^@^@^@^@^@^@^@^@^C^@^C^@^@^@^@^@^@^@^@^@^@^@^@^@^C^@^D^@^@^@^@^@^@^@^@^@^@^@^@^@^C^@^E^@^@^@^@^@^@^@^@^@^@^@^@^@^C^@^G^@^@^@^@^@^@^@^@^@^@^@^@^@^C^@^H^@^@^@^@^@^@^@^@^@^@^@^@^@^C^@^F^@^H^@^@^@^@^@^@^@^X^@^@^@^R^@^A^@^M^@^@^@^@^@^@^@^@^@^@^@^P^@^@^@^@test.c^@main^@printf^@^L^@^@^@^A^E^@^@^Q^@^@^@^B
^@^@ ^@^@^@^B^B^@^@
                                                
```

>Gcc汇编成的.o目标文件是乱码，不过可以通过nm命令查看其符号表：


    tly@ubuntu ~> nm test.o
    00000000 T main
             U printf


### 链接
在成功编译之后，就进入了链接阶段，这个`hello world`小程序的链接过程主要是查找包含的`stdio.h`头文件的`printf()`函数的实现（因为`stdio.h`头文件只包含函数声明)，这个函数实现是在`libc.so.6`的库文件中。在没有特别指定时，Gcc会到系统默认的搜索路径`/usr/lib`下进行查找，也就是链接到`libc.so.6`库函数中去，这样就能实现函数`printf()`了，而这也就是链接的作用。

>函数库一般分为**静态库**和**动态库**两种。
**静态库**:是指编译链接时，把库文件的代码全部加入到可执行文件中，因此生成的文件比较大，但在运行时也就不再需要库文件了。其后缀名一般为`.a`(linux)或`.lib`(windows)。
**动态库**: 与之相反，在编译链接时并没有把库文件的代码加入到可执行文件中，而是在程序执行时由*运行时链接文件加载库*，这样可以节省系统的开销。动态库一般为`.so`(linux)或`.dll`(windows)，如前面所述的libc.so.6就是动态库。
Gcc在编译时默认使用动态库

当然，也可以一次性使用`-c`选项，直接生成目标文件`test.o`,Gcc指令为:

    tly@ubuntu ~> gcc -c test.c -o test.o

完成了链接之后，Gcc就可以生成可执行文件`test`,Gcc指令为:

    tly@ubuntu ~> gcc test.o -o test

运行该可执行文件`test`：

    tly@ubuntu ~> ./test
    hello world⏎      


### Gcc编译选项分析
Gcc有超过100个的可用选项，一般主要包括以下五种类型选项：
1. 总体选项
2. 告警和出错选项
3. 优化选项
4. 体系结构相关选项

#### 总体选项
---
|    选项名      |                   选项意义                                 |
|:--------------:|:----------------------------------------------------------:|
|       -E       |    只是编译不汇编，生成汇编代码.s                            |
|       -S       |    只进行预编译生成.i，不做其他处理                          |
|       -c       |    只是编译不链接，生成目标文件.o                            |
|       -g       |    在可执行程序中包含标准调试信息                            |
|       -o file  |    把输出文件输出到file里                                   |
|       -v       |    打印出编译器内部编译各过程的命令行信息和编译器的版本        |
|       -I dir   |    在头文件的搜索路径列表中添加dir目录                       |
|       -L dir   |    在库文件的搜索路径列表中添加dir目录                       |
|       -static  |    链接静态库                                              |
|       -llibrary|    链接名为library的库文件库                                |

>对于`-I dir`选项可在头文件的搜索路径列表中添加dir目录。由于Linux中头文件都默认放到了`/usr/include/`目录下，因此，当用户希望添加放置在其他位置的头文件时，就可以通过`-I dir`选项来指定(`-L dir`类似)，这样，Gcc就会到相应的位置查找对应的目录
`<>`表示在标准路径中搜索头文件，`“ ”`表示在本目录中搜索，如果把自定义的头文件`#include<my.h>改为`#include “my.h”`，就不需要加上“-I”选项了`
`-I dir`和`-L dir`都只是指定了路径，而没有指定文件，因此不能在路径中包含文件名

> 对于`-llibrary`选项，省去了前缀`lib`,它实际上是指示Gcc去连接库文件liblibrary.so。由于在Linux下的库文件命名时有一个规定：必须以`lib`三个字母开头。因此在用`-l`选项指定链接的库文件名时可以省去`lib`三个字母。也就是说Gcc在对`-llibrary`进行处理时，会自动去链接名为`liblibrary.so`的文件

#### 告警和出错选项
---
|    选项名      |                   选项意义                                 |
|:--------------:|:----------------------------------------------------------:|
|       -ansi    |    支持符合ANSI标准的C程序                                  |
|       -pedantic|    允许发出ANSI C标准所列的全部警告信息                      |
| -pedantic-error|    允许发出ANSI C标准所列的全部错误信息                      |
|       -w       |    关闭所有告警                                            |
|       -Wall    |    允许发出Gcc提供的所有有用的报警信息                       |

修改上述的`helloworld`测试程序为：
```
#include <stdio.h>
void main(int argc, char* argv[])
{
  long long tmp; // 增加非ANSI-C类型long long 未使用的临时变量tmp
  printf("hello world");
  return 0; // 返回错误类型int
}

```

1.默认无告警和出错选项情况：

    tly@ubuntu ~> gcc -c test.c -o test.o
    test.c: In function ‘main’:
    test.c:6:3: warning: ‘return’ with a value, in function returning void [enabled by default]
       return 0;
       ^

>只识别了main的错误返回类型int


2.增加`-ansi`选项情况：

    tly@ubuntu ~> gcc -c test.c -o test.o -ansi
    test.c: In function ‘main’:
    test.c:6:3: warning: ‘return’ with a value, in function returning void [enabled by default]
       return 0;
       ^

>只识别了main的错误返回类型int

3.增加`-pedantic`选项情况：

    tly@ubuntu ~> gcc -c test.c -o test.o -pedantic
    test.c:2:6: warning: return type of ‘main’ is not ‘int’ [-Wmain]
     void main(int argc, char* argv[])
          ^
    test.c: In function ‘main’:
    test.c:4:8: warning: ISO C90 does not support ‘long long’ [-Wlong-long]
       long long tmp;
            ^
    test.c:6:3: warning: ‘return’ with a value, in function returning void [enabled by default]
       return 0;
       ^

>识别了main的错误返回类型int 和 long long 非 ISO C90 支持类型

4.增加`-pedantic-errors`选项情况：

    tly@ubuntu ~> gcc -c test.c -o test.o -pedantic-errors 
    test.c:2:6: error: return type of ‘main’ is not ‘int’ [-Wmain]
     void main(int argc, char* argv[])
          ^
    test.c: In function ‘main’:
    test.c:4:8: error: ISO C90 does not support ‘long long’ [-Wlong-long]
       long long tmp;
            ^
    test.c:6:3: error: ‘return’ with a value, in function returning void
       return 0;
       ^

>识别了main的错误返回类型int 和 long long 非 ISO C90 支持类型

5.增加`-w`选项情况：

    tly@ubuntu ~> gcc -c test.c -o test.o -w

>屏蔽了告警和出错信息

6.增加`-Wall`选项情况： 

    tly@ubuntu ~> gcc -c test.c -o test.o -Wall
    test.c:2:6: warning: return type of ‘main’ is not ‘int’ [-Wmain]
     void main(int argc, char* argv[])
          ^
    test.c: In function ‘main’:
    test.c:6:3: warning: ‘return’ with a value, in function returning void [enabled by default]
       return 0;
       ^
    test.c:4:13: warning: unused variable ‘tmp’ [-Wunused-variable]
       long long tmp;
                 ^

>识别了main的错误返回类型int 和临时变量tmp未使用的告警信息

#### 优化选项
---
|    选项名       |                   选项意义                                 |
|:---------------:|:----------------------------------------------------------:|
|       -On       |    n是一个代表优化级别的整数,典型的范围是从0变化到2或3        |


>不同的优化级别对应不同的优化处理工作。
-O 提供基础级别的优化
-O2 提供更加高级的代码优化,会占用更长的编译时间
-O3 提供最高级的代码优化
进行调试的时候，最好关闭编译优化，否则程序自动优化，执行的步骤可能有变化

#### 体系结构相关选项
---
|    选项名       |                   选项意义                                 |
|:---------------:|:----------------------------------------------------------:|
|  -mcpu=type     | 对不同的CPU使用相应的CPU指令。可选择的有i386、i486、pentium等   |
|  -mieee-fp      | 使用IEEE标准进行浮点数的比较                                 |
|  -mno-ieee-fp   | 不使用IEEE标准进行浮点数的比较                               |
|  -msoft-float   | 输出包含浮点库调用的目标代码                                 |
|  -mshort        | 把int类型作为16位处理，相当于short int                       |
|  -mrtd          | 将函数参数个数固定的函数用ret NUM返回，节省调用函数的一条指令  |
