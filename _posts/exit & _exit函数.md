---
title: exit & _exit函数
date: 2016-6-11
categories: Linux
tags:
- Linux
- exit
---

## 前言
---
`exit`和`_exit`都是Linux下的退出函数，exit作用是：直接使进程停止运行，清除其使用的内存空间，并销毁其在内核中的各种数据结构；而exit是_exit函数的进一步封装，执行了其他的清理工作，然后才调用_exit函数，在与输入输出或fork等函数一起使用时候会表现出一些差异

<!--more-->

## exit & _exit
---

### 定义
首先分别看看C/C++标准里面的各自使用说明
1._exit

    void _exit (int status);
    Terminate calling process
    Terminates the process normally by returning control to the host environment, but without performing any of the regular cleanup tasks for terminating processes (as function exit does).
    No object destructors, nor functions registered by atexit or at_quick_exit are called.
    Whether C streams are closed and/or flushed, and files open with tmpfile are removed depends on the particular system or library implementation.
    If status is zero or EXIT_SUCCESS, a successful termination status is returned to the host environment.
    If status is EXIT_FAILURE, an unsuccessful termination status is returned to the host environment.
    Otherwise, the status returned depends on the system and library implementation.
    Parameters:
    status
    Status code.
    If this is 0 or EXIT_SUCCESS, it indicates success.
    If it is EXIT_FAILURE, it indicates failure.

>可以看出_exit主要特点是在退出的时候，不会执行常规的cleanup清理工作，对象的析构也不会执行，通过atexit或_atquick_exit函数注册的自定义退出执行代码段函数也不会执行，对于是否C数据流是否关闭或刷新缓存区，临时打开的文件释放移除跟特定的系统或库实现有关系
对于linux系统而言，_exit需要包含头文件为`unistd.h`

2.exit

    void exit (int status);
    Terminate calling process
    Terminates the process normally, performing the regular cleanup for terminating programs.
    Normal program termination performs the following (in the same order):
    Objects associated with the current thread with thread storage duration are destroyed (C++11 only).
    Objects with static storage duration are destroyed (C++) and functions registered with atexit are called.
    All C streams (open with functions in <cstdio>) are closed (and flushed, if buffered), and all files created with tmpfile are removed.
    Control is returned to the host environment.
    Note that objects with automatic storage are not destroyed by calling exit (C++).
    If status is zero or EXIT_SUCCESS, a successful termination status is returned to the host environment.
    If status is EXIT_FAILURE, an unsuccessful termination status is returned to the host environment.
    Otherwise, the status returned depends on the system and library implementation.
    For a similar function that does not perform the cleanup described above, see quick_exit.
    Parameters:
    status
    Status code.
    If this is 0 or EXIT_SUCCESS, it indicates success.
    If it is EXIT_FAILURE, it indicates failure.

>可以看出exit主要特点是在退出的时候，与_exit不同，会执行常规的cleanup清理工作，静态存储的对象也会销毁，但是对于自动存储的对象则不会销毁，通过atexit或_atquick_exit函数注册的自定义退出执行代码段函数同样会执行，对于C数据流也会关闭或刷新缓存区，会释放临时打开的文件对于，**可见与_exit主要区别在于退出前是否执行清理工作包括对象销毁、文件移除、数据缓存关闭或刷新等操作上**
exit需要包含头文件为`stdlib.h`

对于异常退出还有个abort函数，标准库是这样简单的说明的：

    void abort (void);
    Abort current process
    Aborts the current process, producing an abnormal program termination.
    The function raises the SIGABRT signal (as if raise(SIGABRT) was called). This, if uncaught, causes the program to terminate returning a platform-dependent unsuccessful termination error code to the host environment.
    The program is terminated without destroying any object and without calling any of the functions passed to atexit or at_quick_exit.

>abort会产生SIGABRT信号，就像调用了raise(SIGABRT)一样，终止时候不会销毁任何对象也不会调用通过atexit或at_quick_exit注册的用户自定义退出代码段

### 示例
---
1.与printf等带有缓存区的I/O使用情况
示例代码：
```
#include <stdio.h>
#include <unistd.h>
void main(int argc, char* argv[])
{
 printf("I am a string with \\n end \n");
 printf("I am a string without \\n");
 _exit(0);
}
```

运行结果：
    
    I am a string with \n end 

>只有第一句带有\n会打印，因为带有行缓存的IO接口遇到\n或EOF或缓存区满会自动输出，而第二句由于_exit退出未刷新清空缓存区到输出设备，故未显示出来

若改为exit(0)，则运行结果为：

    I am a string with \n end 
    I am a string without \n⏎  

>由于exit退出会刷新清空缓存区到输出设备，故第二句也显示出来了

2.与vfork等创建新进程共享地址空间的使用情况
示例代码：
```
#include <unistd.h>
#include <stdlib.h>
#include <sys/types.h>
int global_a = 1;
int main(int argc, char* argv[])
{
  int auto_a = 1;
  pid_t pid;

  printf("before vfork\n");// need't flush, will print because of \n exit
  printf("global_a = %d, auto_a = %d\n", global_a, auto_a);

 pid = vfork();
 if(pid < 0)
 {
   printf("vfork error!\n");
 }
 else if(pid == 0)// child process
 {
  global_a++; // modify global var
  auto_a++; // modifty auto var
  exit(0); // exit child process, but _exit is better`
 }
 printf("after vfork\n");
 printf("pid = %d, global_a  = %d, auto_a = %d\n", pid, global_a, auto_a);
 exit(0);
}         
```

运行结果：

    before vfork
    global_a = 1, auto_a = 1
    after vfork
    pid = 9040, global_a  = 2, auto_a = 2

>可以看到，子进程虽然退出但是，父进程仍然有输出，虽然子进程和父进程在vfork时候共享了标准输入输出，但是子进程exit时候，可能是递减了引用计数（vfork调用时候增加了该引用计数，类似于多进程socket创建），不可能关闭父进程，所以仍有输出，由于数据是共享的，故父进程的数据被改变了
>但是在其他类unix系统中父进程可能就没输出了，原因是子进程调用了exit之后，刷新关闭了所有IO流，虽然是子进程进行的，但是与父进程共享了地址空间，所以可能影响到了父进程的输入输出，所以比较安全的做法是子进程使用_exit退出，但是它会直接将进程关闭，缓存区数据会丢失（可以通过手动调用flush刷新输出），如果想保持数据完整性，就还是要使用exit


## 总结
1.`exit`函数能保证数据的完整性，在退出之前会做些清理工作，然后再调用_exit再退出的；而_exit是直接退出程序，但是不管咋样，两者都会关闭进程打开的文件描述符，释放内存
2.在`fork`或`vfork`创建的子进程分支中，推荐使用_exit，防止标准IO的缓存区被清空两次，临时文件被意外清除或静态对象被意外销毁，推荐做法是exit在main函数退出时候只调用一次
3.关于标准IO的几种缓冲机制：
- 全缓冲
全缓冲指的是系统在填满标准IO缓冲区之后才进行实际的IO操作；对于驻留在磁盘上的文件来说通常是由标准IO库实施全缓冲
- 行缓冲
在这种情况下，标准IO在输入和输出中遇到换行符时执行IO操作；当流涉及终端的时候，通常使用的是行缓冲，如本文的printf输出
- 无缓冲
无缓冲指的是标准IO库不对字符进行缓冲存储；标准出错流stderr通常是无缓冲的