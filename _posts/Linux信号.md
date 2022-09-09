---
title: Linux信号
date: 2016-06-14
categories: Linux
tags:
- Linux
- signal
---

## 前言
---
信号类似于硬件中断是一种“软中断”，包括信号源，信号中断处理函数和信号的安装。Linux中信号的种类比较多，本篇简要介绍和总结下Linux下的信号种类和信号的处理流程及相关的函数接口

<!--more-->

## Linux信号简介
---

### 信号定义
---

下面是摘自Wiki百科的一段信号定义：

    Signals are a limited form of inter-process communication used in Unix, Unix-like, and other POSIX-compliant operating systems. A signal is an asynchronous notification sent to a process or to a specific thread within the same process in order to notify it of an event that occurred. Signals originated in 1970s Bell Labs Unix and have been more recently specified in the POSIX standard.
    When a signal is sent, the operating system interrupts the target process' normal flow of execution to deliver the signal. Execution can be interrupted during any non-atomic instruction. If the process has previously registered a signal handler, that routine is executed. Otherwise, the default signal handler is executed.
    Embedded programs may find signals useful for interprocess communications, as the computational and memory footprint for signals is small

>这段关于信号的定义描述了信号以下几个特点：
1. 信号作用是类Unix系统之间用来进行进程间通信的，是一种异步通信方式的形式来通知一件事件的发生
2. 信号类似于硬件中断，某个进程接受到信号就会中断当前的执行流转而处理信号（当然软中断非原子操作）
3. 如果信号未安装用户自定义的信号处理函数，就会安装默认方式处理信号，否则按照用户自定义的方式来处理信号

### 信号分类
---

#### 信号划分

1.可靠性方面
信号的可靠与不可靠只与信号值有关，分为可靠和不可靠信号：
- 可靠信号
信号值小于`SIGRTMIN`的信号都是不可靠信号，信号不支持排队，信号可能丢失
- 不可靠信号
信号值位于`SIGRTMIN`和`SIGRTMAX`之间的信号都是可靠信号，信号支持排队，信号不会丢失

2.实时性方面
- 实时信号
前32个信号表示非实时信号，不支持排队，信号可能丢失与可靠性类似
- 非实时信号
后32个信号表示实时信号，支持排队，信号不会丢失与可靠性类似

#### Linux信号列表

在Ubuntu14.04LTS系统输入`kill -L`可以看到系统支持的信号列表：

    root@ubuntu /# kill -L
     1 HUP      2 INT      3 QUIT     4 ILL      5 TRAP     6 ABRT     7 BUS
     8 FPE      9 KILL    10 USR1    11 SEGV    12 USR2    13 PIPE    14 ALRM
    15 TERM    16 STKFLT  17 CHLD    18 CONT    19 STOP    20 TSTP    21 TTIN
    22 TTOU    23 URG     24 XCPU    25 XFSZ    26 VTALRM  27 PROF    28 WINCH
    29 POLL    30 PWR     31 SYS 

>只列出了编号为1~31号的传统UNIX支持的信号，是不可靠的（非实时的，而未列出的编号为32 ~ 63的信号是后来扩充的，都是可靠信号(实时信号)

信号的宏定义都是以`SIG`作为前缀的，且定义在`<signal.h>`头文件中，Linux定义的信号(1~31)如下表所示：

| Signal | Default Handler | Signal Source or Cause |
|:------------:|:--------------:|:-------------:|
| SIGHUP  |    Terminate       |         终端挂起或者控制进程终止        |
| SIGINT  |    Terminate       |       键盘中断,如CTRL+Z                |
| SIGQUIT |Terminate(core dump)|        键盘的退出键被按下               |
| SIGILL  |Terminate(core dump)|       非法指令                         |
| SIGTRAP |Terminate(core dump)|       由断点指令或其他trap指令产生       |
| SIGABRT |Terminate(core dump)|       由abort(3)发出的退出指令          |
| SIGFPE  |Terminate(core dump)|       浮点异常                         |
| SIGKILL |    Terminate       |       Kill信号(不能被捕获，不能被忽略)   |
| SIGSEGV |Terminate(core dump)|       无效的内存引用                    |
| SIGPIPE |    Terminate       |      管道破裂: 写一个没有读端口的管道     |
| SIGALRM |    Terminate       |       由alarm(2)发出的信号              |
| SIGTERM |    Terminate       |       终止信号                          |
| SIGUSR1 |    Terminate       |       用户自定义信号1                    |
| SIGUSR2 |    Terminate       |       用户自定义信号2                    |
| SIGCHLD |    Ignore          |       子进程结束信号                     |
| SIGCONT |    Continue        |       进程继续（曾被停止的进程）          |
| SIGSTOP |    Stop            |       终止进程(不能被捕获，不能被忽略)     |
| SIGTSTP |    Stop            |       控制终端（tty）上按下停止键         |
| SIGTTIN |    Stop            |       后台进程企图从控制终端读            |
| SIGTTOU |    Stop            |       后台进程企图从控制终端写            |
| SIGURG  |    Ignore          | socket上有紧急数据时向当前正在运行的进程发出此信号，报告有紧急数据到达         |
| SIGXCPU |    Terminate       | 进程执行时间超过了分配给该进程的CPU时间，系统产生该信号并发送给该进程          |
| SIGXFSZ |    Terminate       | 超过文件最大长度的限制                    |
|SIGVTALRM|    Terminate       | 虚拟时钟超时时产生该信号。类似于SIGALRM，但是它只计算该进程占有用的CPU时间                                                    |
| SIGPROF |    Terminate       | 类似于SIGVTALRM，它不仅包括该进程占用的CPU时间还抱括执行系统调用的时间                                                       |
| SIGPOLL |    Ignore          |   向进程指示发出一个异步IO事件             |
| SIGPWR  |    Terminate       |   关机                                   |
| SIGRTMIN~SIGRTMAX |Terminate |   Linux的实时信号，可以由用户自由使用（Linux线程机制使用了前3个实时信号）        |

>SIGPOLL是SystemV使用的异步IO，BSD系统用SIGIO
>两个信号可以停止进程:SIGTERM和SIGKILL
SIGTERM：进程能捕捉这个信号，根据您的需要来关闭程序。在关闭程序之前，您可以结束打开的记录文件和完成正在做的任务。在某些情况下还进程可以忽略这个SIGTERM信号
SIGKILL：进程是不能忽略的。这是一个 “我不管您在做什么，立刻停止”的信号

## 信号处理流程
---
信号处理流程包括三个基本过程：信号产生；信号在进程中注册；信号执行和注销

### 信号产生
---

#### 信号来源
---

信号来源主要包括两个方面：
1.硬件来源
按下了键盘或者其它硬件故障
2.软件来源
通过调用系统函数`kill`，`raise`，`alarm`，`setitimer`，`sigqueue`，`abort`来发送信号，软件来源还包括一些非法运算等操作

#### kill
---

1. 头文件
`<sys/types.h> & <signal.h>`

2. 函数原型
`int kill(pid_t pid, int signo)`

>作用：
>kill可以用来向任何进程或进程组发送任何信号
>参数：
>pid : 目标进程id，以下取值：
>- pid > 0 : 进程id为pid的进程
>- pid == 0 : 同一进程组的所有进程
>- pid < 0 && pid != -1 : 进程组id为-pid的所有进程
>- pid == -1 : 除发送进程本身外，所有进程id大于1的进程
>signo: 信号值，0为空信号，不发生任何信号

#### raise
---

1. 头文件
`<signal.h>`

2. 函数原型
`int raise(int signo)`

>作用：
>raise可以用来向进程本身发送信号
>参数：
>signo: 信号值，0为空信号，不发生任何信号

#### alarm
---

1. 头文件
`<unistd.h>`

2. 函数原型
`unsigned int alarm(unsigned int seconds)`

>作用：
>alarm可以用来安排内核为调用进程在指定的seconds秒后发出一个SIGALRM的信号。
>参数：
>seconds : 在指定的seconds秒后发出一个SIGALRM的信号：
>- seconds = 0 : 不再发送 SIGALRM信号,后一次设定将取消前一次的设定

>该调用返回值为上次定时调用到发送之间剩余的时间，或者因为没有前一次定时调用而返回0
>使用时，alarm只设定为发送一次信号，如果要多次发送，就要多次使用alarm调用

#### setitimer
---

1. 头文件
`<sys/time.h>`

2. 函数原型
得到定时器状态：
`int getitimer(int which, struct itimerval *value)`
设定定时器：
`int setitimer(int which, const struct itimerval *value, struct itimerval *ovalue)`

>作用：
>setitimer可以用来安排内核为调用进程在指定的value值定时时长循环发出一个SIGALRM或SIGVTALRM或SIGPROF的信号。
>参数：
>which : 三种类型定时器，它们各自有其独有的计时域，当其中任何一个到达，就发送一个相应的信号给进程，并使得计时器重新开始：
>- which == TIMER_REAL : 按实际时间计时，计时到达将给进程发送SIGALRM信号
>- which == ITIMER_VIRTUAL : 仅当进程执行时才进行计时，计时到达将发送SIGVTALRM信号
>- which == PROF : 当进程执行时和系统为该进程执行动作时都计时。与ITIMER_VIRTUAL是一对，该定时器经常用来统计进程在用户态和内核态花费的时间。计时到达将发送SIGPROF信号给进程
>value : 指明定时器的时长

#### sigqueue
---

1. 头文件
`<sys/types.h>`

2. 函数原型
`int sigqueue(pid_t pid, int sig, const union sigval val)`

>作用：
>sigqueue可以用来向指定pid进程发送带参数val的sig信号，支持信号带有参数，与函数sigaction配合使用。
>参数：
>pid : 接收目标进程pid
>sig : 发送的信号
>val : 信号传递的参数，即通常所说的4字节值

>sigqueue比kill传递了更多的附加信息，但sigqueue只能向一个进程发送信号，而不能发送信号给一个进程组

sigval定义：
```
typedef union sigval {
               int  sival_int;
               void *sival_ptr;
}sigval_t;
```

#### abort
---

1. 头文件
`<stdlib.h>`

2. 函数原型
`void abort(void)`

>作用：
>sigqueue可以用来向进程发送SIGABORT信号，默认情况下进程会异常退出，也可自定义的信号处理函数，即使SIGABORT被进程设置为阻塞信号，调用abort()后，SIGABORT仍然能被进程接收。
>参数：
>无

### 信号在进程中注册
---
进程表的表项中有一个**软中断信号域**，该域中每一位对应一个信号，内核给一个进程发送软中断信号的方法，是在**进程所在的进程表项的软中断信号域设置对应于该信号的位**

信号在进程中注册指的就是**信号值加入到进程的未决信号集**sigset_t signal（每个信号占用一位）中，并且信号所携带的信息被保留到未决信号信息链的某个sigqueue结构中。只要信号在进程的未决信号集中，表明进程已经知道这些信号的存在，但还没来得及处理，或者该信号被进程阻塞

未决信号集sigpending:
```
struct sigpending
{
        struct sigqueue *head, *tail; //未决信号信息链
        sigset_t signal; //未决信号集
};
```
一个特定信号所携带的信息sigqueue：
```
struct sigqueue{
        struct sigqueue *next;
        siginfo_t info; //信号所携带信息内容
};
```

>信号的“未决”是一种状态，指的是从信号的产生到信号被处理前的这一段时间
>信号的“阻塞”是一个开关动作，指的是阻止信号被处理，但不是阻止信号产生

实时信号和非实时信号的注册差异处理：
- 当一个实时信号发送给一个进程时，不管该信号是否已经在进程中注册，都会被再注册一次，因此，信号不会丢失，同一个实时信号可以在同一个进程的未决信号信息链中占有多个sigqueue结构
- 当一个非实时信号发送给一个进程时，如果该信号已经在进程中注册（通过sigset_t signal指示），则该信号将被丢弃，造成信号丢失，同一个非实时信号在进程的未决信号信息链中，至多占有一个sigqueue结构

### 信号执行和注销
---

内核处理一个进程收到的软中断信号是在该进程的上下文中，因此，进程必须处于运行状态。当其由于被信号唤醒或者正常调度重新获得CPU时，在其从内核空间返回到用户空间时会检测是否有信号等待处理。如果存在未决信号等待处理且该信号没有被进程阻塞，则在运行相应的信号处理函数前，进程会把信号在未决信号链中占有的结构卸掉

实时信号和非实时信号的注销差异处理：
- 对于非实时信号来说，由于在未决信号信息链中最多只占用一个sigqueue结构，因此该结构被释放后，应该把信号在进程未决信号集中删除（信号注销完毕）
- 对于实时信号来说，可能在未决信号信息链中占用多个sigqueue结构，要待该信号的所有sigqueue处理完毕后再在进程的未决信号集中删除该信号（信号注销完毕）

**内核处理一个进程收到的信号的时机是在一个进程从内核态返回用户态时**。所以，当一个进程在内核态下运行时，软中断信号并不立即起作用，要等到将返回用户态时才处理。**进程只有处理完信号才会返回用户态**，进程在用户态下不会有未处理完的信号

>处理信号的三种方式：
- Ignore 忽略信号
- Default Handler执行默认处理方式
- User Define Handler执行用户自定义安装的回调处理方式

安装信号主要用来确定信号值及进程针对该信号值的动作之间的映射关系，即进程将要处理哪个信号。对于用户自定义信号的安装，主要有signal和sigaction两个系统调用，前者不支持信号传递信息，后者支持信号传递信息且与sigqueue系统调用配合使用

#### signal
---

1. 头文件
`<signal.h>`

2. 函数原型
`void (*signal(int signum, void (*handler))(int)))(int)`

>作用：signal安装不带信息参数的信号。
>参数：
>signum : 信号值，可以为除SIGKILL及SIGSTOP外的任何一个特定有效的信号
>handler : 信号处理回调,该回调
>- SIG_IGN 忽略该信号
>- SIG_DFL 默认方式处理
>- handler 自定义方式处理

#### sigaction
---

1. 头文件
`<signal.h>`

2. 函数原型
`int sigaction(int signum,const struct sigaction *act,struct sigaction *oldact))`

>作用：sigaction安装带信息参数的信号。
>参数：
>signum : 信号值，可以为除SIGKILL及SIGSTOP外的任何一个特定有效的信号
>act : 指定对信号的处理，可以为空，进程会以缺省方式对信号处理
>- SIG_IGN 忽略该信号
>- SIG_DFL 默认方式处理
>- handler 自定义方式处理
>oldact: 该参数指向的对象用来保存返回的原来对相应信号的处理 

sigaction定义：
```
struct sigaction 
{
  union{
       __sighandler_t _sa_handler;          // 用户自定义函数
      void (*_sa_sigaction)(int,struct siginfo *, void *)； // 用户自定义函数
      }_u

  sigset_t sa_mask；
  unsigned long sa_flags；
}
```

>sigqueue发送信号时，sigqueue的第三个参数sigval联合数据结构中的数据就将拷贝到信号处理函数_sa_sigaction的第二个参数siginfo中

