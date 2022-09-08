---
title: fork和vfork函数区别
date: 2016-06-10
categories: Linux
tags:
- Linux
- fork
---

## 前言
---
Linux系统创建新的进程函数`fork`及`vfork`有相似地方也有不同的地方，本篇通过实例说明两者的特点和使用时候应该注意事项

<!--more-->

## fork & vfork
---

### 区别
1.相似点：
 - `fork`和`vfork`均用来创建新的进程，且都是一次调用，两次返回：两次返回的区别是子进程的返回值是0，而父进程的返回值则是新进程（子进程）的进程 id，若失败返回-1
 - `fork`和`vfork`返回后，子进程和父进程都从调用`fork`或`vfork`函数返回处开始执行

> `fork`和`vfork`函数在调用返回处分叉，对于同一代码分别各执行一次，通过返回值来区分

2.不同点：
- `fork`创建的子进程拷贝了父进程的数据段;子进程从父进程得到了数据段和堆栈段的拷贝，这些需要分配新的内存。而对于只读的代码段，通常使用共享内存的方式访问
而`vfork`创建的子进程并未拷贝父进程的数据段和代码段，在子进程调用`exec`或`exit` 之前与父进程数据是共享的
- `fork`创建的子进程和父进程的执行顺序不确定;
而`vfork`创建的子进程必须是先运行的，此时父进程是阻塞的，在子进程调用`exec`或`exit` 之前与父进程数据是共享的，在它调用`exec`或`exit`之后父进程才可能被调度运行
- `vfork`保证子进程先运行，在其调用`exec`或`exit`之后父进程才可能被调度运行。如果在
   调用这两个函数之前子进程依赖于父进程的进一步动作，则会导致死锁

>一个进程process，通常包含三个元素：
1.一个可以执行的程序；
2.和该进程相关联的全部数据（包括变量，内存空间，缓冲区等等）；
3.程序的执行上下文（execution context）

### 示例
---

#### fork函数
---
1.`fork`一般情况使用
代码:
```
#include<stdio.h>
#include <sys/types.h>
#include <unistd.h>

int main(int argc, char* argv[])
{
  pid_t pid;
  pid = fork();

  if(pid == 0)
  {
    printf("I am the child process with ID[%d]\n", getpid());
  }
  else if(pid > 0)
  {
    printf("I am the father process with ID[%d]\n", getpid());
  }
  else
  {
    printf("fork error!\n");
  }
  return 0;
}
```

运行结果：

    I am the child process with ID[4060]
    I am the father process with ID[4059]

>执行顺序不定，根据OS调度情况而定

2.`fork`拷贝数据段情况使用
增加`count`变量代码：
```
#include<stdio.h>
#include <sys/types.h>
#include <unistd.h>

int main(int argc, char* argv[])
{
  pid_t pid;
  pid = fork();
  int count  = 0;
  if(pid == 0)
  {
    count++; // add data
    printf("I am the child process with ID[%d], count = %d\n", getpid(), count);
  }
  else if(pid > 0)
  {
    count++; // add data
    printf("I am the father process with ID[%d], count = %d\n", getpid(), count);
  }
  else
  {
    printf("fork error!\n");
  }
  return 0;
}
```

运行结果：

    I am the child process with ID[4107], count = 1
    I am the father process with ID[4106], count = 1

> 由于fork之后，子进程虽然拷贝了父进程数据段(拷贝时候该数据段初始化为0)，但是都是独立的，故分别在自己的数据空间加1了

3.`fork`拷贝文件描述符情况使用
增加`FILE`变量代码：
```
#include<stdio.h>
#include <sys/types.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char* argv[])
{
  pid_t pid;
  pid = fork();
  int count  = 0;
  char buffer[256] = {0};
  char mybuffer[256] = {0};

  FILE *file = fopen("/home/tly/networkProgram/my.txt", "w+"); // add
  if(pid == 0)
  {
    count++;
    printf("I am the child process with ID[%d], count = %d\n", getpid(), count);
    strcpy(buffer, "child");

    fwrite(buffer, strlen("child")+1, 1, file);
    // "child" write in file my.txt

    strcpy(buffer, "child2");
    // "child2" write to buffer

    exit(0);
  }
  else if(pid > 0)
  {
    sleep(1); // let child process run first 
    count++;

    printf("I am the father process with ID[%d], count = %d\n", getpid(), count);

    fread(mybuffer, strlen("child")+1, 1, file);
    // read from file my.txt to mybuffer and display

    printf("father process read is %s\n", mybuffer);
    // fork's child copy parent's file description pointer and so the file contents are the same
  }
  else
  {
    printf("fork error!\n");
  }

  printf("final buffer is %s\n", buffer);
  // fork's child copy parent's buffer but default value is 0, and the two buffer are independent and final buffer is parent buffer is empty!

  return 0;
}

```

运行结果：

    I am the child process with ID[4211], count = 1
    I am the father process with ID[4210], count = 1
    father process read is child
    final buffer is 
>可以看到，`fork`的子进程由于拷贝了父进程的文件描述符指针，导致父进程和子进程操作的是同一个文件，子进程修改了my.txt文件内容，父进程由于读取的是同一个文件也感知到了这个修改
>但是数据buffer虽然是拷贝的，但是相互是独立的，所以父进程最终读取的buffer还是空的，但是此时子进程的buffer是"child2"

#### vfork函数
---
1.`vfork`一般情况即未执行`_exit(0)`情况使用
代码：
```
#include<stdio.h>
#include <sys/types.h>
#include <unistd.h>

int main(int argc, char* argv[])
{
  pid_t pid;
  pid = vfork();

  if(pid == 0)
  {
    sleep(1); // child process exec first no matter sleep or not
    printf("I am the child process with ID[%d]\n", getpid());
  }
  else if(pid > 0)
  {
    printf("I am the father process with ID[%d]\n", getpid());
  }
  else
  {
    printf("fork error!\n");
  }
  return 0;
}

```

运行结果：

    I am the child process with ID[4294]
    I am the father process with ID[4293]
    I am the child process with ID[4295]
    I am the father process with ID[4293]
    I am the child process with ID[4296]
    I am the father process with ID[4293]
    I am the child process with ID[4297]
    ...

>由于`vfork`创建子进程之后，未调用`exit()`或`exec()`函数，且子进程依赖于父进程的进一步动作，导致死锁了，两个进程在不断的打印，都无法正常的结束

2.`vfork`增加变量和执行`_exit(0)`情况使用
增加`count`变量和`_exit(0)`代码：
```
#include <stdio.h>
#include <sys/types.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char* argv[])
{
  pid_t pid;
  pid = vfork();
  int count  = 0;

  if(pid == 0)
  {
    sleep(1); // child process run first no matter sleep or not
    count++;
    printf("I am the child process with ID[%d], count = %d\n", getpid(), count);
    _exit(0); // exit without clean up 
  }
  else if(pid > 0)
  {
    count++;
    printf("I am the father process with ID[%d], count = %d\n", getpid(), count);
  }
  else
  {
    printf("fork error!\n");
  }
  return 0;
}
```

运行结果：

    I am the child process with ID[4392], count = 1
    I am the father process with ID[4391], count = 1

> 可以看到由于子进程未拷贝数据段，而是共享数据段，但由于写时拷贝技术(当需要改变共享数据段中变量的值，则拷贝父进程，在未改变共享数据段之前不拷贝父进程而是共享数据)，子进程的改变共享变量并未体现在父进程上，两者在拷贝完成后就各自数据相互独立了

3.`vfork`增加文件描述符执行`_exit(0)`情况使用
增加`FILE`变量代码和`_exit(0)`代码:
```
#include <stdio.h>
#include <sys/types.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char* argv[])
{
  pid_t pid;
  pid = vfork();
  int count  = 0;
  char buffer[256] = {0};
  char mybuffer[256] = {0};

  FILE *file = fopen("/home/tly/networkProgram/my2.txt", "w+");
  if(pid == 0)
  {
    sleep(1); // child process run first no matter sleep or not
    count++;
    printf("I am the child process with ID[%d], count = %d\n", getpid(), count);
    strcpy(buffer, "child");
    fwrite(buffer, strlen("child")+1, 1, file);// "child" write in file my.txt
    strcpy(buffer, "child2");// "child2" write to buffer
    _exit(0);
  }
  else if(pid > 0)
  {
    count++;
    printf("I am the father process with ID[%d], count = %d\n", getpid(), count);
    fread(mybuffer, strlen("child")+1, 1, file);// read from file my2.txt to mybuffer and display
    printf("father process read is %s\n", mybuffer);// vfork's child will not copy father's data space , file description and so on, so my2.txt is empty! 
  }
  else
  {
    printf("fork error!\n");
  }

  printf("final buffer is %s\n", buffer);// vfork's child and parent data space is independent  and final buffer is parent buffer is empty!
  return 0;
}

```

运行结果：

    I am the child process with ID[4392], count = 1
    I am the father process with ID[4391], count = 1
    father process read is 
    final buffer is 

> 可以看到由于子进程未拷贝文件描述符，而是共享数据段，同共享数据段表现一致


### 循环fork问题
代码：
```
#include <stdio.h>
#include <sys/types.h>
#include <unistd.h>

int main(int argc, char* argv[])
{
 int i;
 for(i = 0; i < 2; i++)
 {
     fork();
     printf("  $  ");
     printf("parent = %d, child = %d, i = %d\n", getppid(), getpid(), i);
 }
 sleep(5);
}
```

运行结果：

      $  parent = 2661, child = 4745, i = 0
      $  parent = 2661, child = 4745, i = 1
      $  parent = 4745, child = 4747, i = 1
      $  parent = 4745, child = 4746, i = 0
      $  parent = 4745, child = 4746, i = 1
      $  parent = 4746, child = 4748, i = 1

> 可以看到有正常的6次的`$`打印


若在`printf`函数中去掉`\n`，运行结果：

    $  parent = 2661, child = 4821, i = 0  $  parent = 2661, child = 4821, i = 1  $  parent = 2661, child = 4821, i = 0  $  parent = 4821, child = 4823, i = 1  $  parent = 4821, child = 4822, i = 0  $  parent = 4821, child = 4822, i = 1  $  parent = 4821, child = 4822, i = 0  $  parent = 4822, child = 4824, i = 1⏎       

>有8次的`$`打印,由于在`fork`的调用处,整个父进程空间会原模原样地复制到子进程中,包括指令,变量值,程序调用栈,环境变量,**缓冲区**。而`printf`函数属于块设备输出函数,有缓冲区存在,`printf("  $  ")`把`"  $  "`放到了缓存中,并没有真正的输出,**而在`fork`的时候,缓存被复制到了子进程空间就多了两个**
>设备有“块设备”和“字符设备”的概念，所谓块设备，就是以一块一块的数据存取的设备，字符设备是一次存取一个字符的设备。磁盘、内存、显示器都是块设备，字符设备如键盘和串口。块设备一般都有缓存，而字符设备一般都没有缓存

## 总结
1.linux在`vfork`进程中引入了**写时拷贝**技术，也就是只有进程空间的各段的内容要发生变化时，才会将父进程的内容复制一份给子进程。好处是在一般情况下，进程创建后都会马上运行一个可执行的文件，这种优化可以避免拷贝大量根本就不会被使用的数据
2.引用网上的一段理解： 
为什么会有`vfork`,因为以前的`fork`很傻,它创建一个子进程时，将会创建一个新的地址空间，并且拷贝父进程的资源，而通常在子进程中会执行exec调用，这样，前面的拷贝工作就是白费力气了，这种情况下，聪明的人就想出了`vfork`，它产生的子进程刚开始暂时与父进程共享地址空间（其实就是线程的概念了），因为这时候子进程在父进程的地址空间中运行，所以子进程不能进行写操作，并且在儿子霸占着老子的房子时候，要委屈老子一下了，让他在外面歇着（阻塞），一旦儿子执行了exec或者exit后，相当于儿子买了自己的房子了，这时候就相当于分家了
