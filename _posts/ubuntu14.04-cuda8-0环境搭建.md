---
title: Ubuntu14.04+CUDA8.0环境搭建
date: 2017-07-16
categories: CUDA
tags:
- CUDA
- HPC
- Linux
---

## 前言
---

在处理3D图像数据时候，由于图像数据量大，采用传统的CPU方式进行图像算法处理，速度和性能不能满足项目要求，需要借助并行计算的架构进行处理。现在比较流行的并行计算框架有cuda，opencl，openmp等等。cuda虽然没有opencl这样的异构编程模型通用，可以同时使用在cpu,gpu,fpga,dsp等硬件平台上，但是cuda相比于opencl等并行计算框架比较成熟，且资源也比较多，gpu硬件有多核处理的优势，因此cuda必然作为数据计算加速方案的第一选择。
<!--more-->

## CUDA介绍
---

wiki上关于CUDA的解释:
```
CUDA is a parallel computing platform and application programming interface (API) model created by Nvidia. It allows software developers and software engineers to use a CUDA-enabled graphics processing unit (GPU) for general purpose processing – an approach termed GPGPU (General-Purpose computing on Graphics Processing Units). The CUDA platform is a software layer that gives direct access to the GPU's virtual instruction set and parallel computational elements, for the execution of compute kernels.
The CUDA platform is designed to work with programming languages such as C, C++, and Fortran. This accessibility makes it easier for specialists in parallel programming to use GPU resources, in contrast to prior APIs like Direct3D and OpenGL, which required advanced skills in graphics programming. Also, CUDA supports programming frameworks such as OpenACC and OpenCL. When it was first introduced by Nvidia, the name CUDA was an acronym for Compute Unified Device Architecture, but Nvidia subsequently dropped the use of the acronym.
```
> cuda主要是nvidia公司开发的在nvidia GPU硬件上进行GPGPU(通用目的的图形卡计算)的并行计算框架， 支持C/C++/Fortran等计算语言。


## CUDA安装
---

cuda支持windows,linux,macos等多种操作系统，由于本人使用的是ubuntu14.04LTS操作系统，因此这篇文章主要是在ubuntu操作系统上安装cuda8.0(截止2017.7.16,最新的cuda版本为8.0)的过程。

### 安装前准备
---

在使用CUDA在系统进行开发之前，需要满足以下几个条件:
+ 支持CUDA的GPU硬件，关于GPU支持情况可以去NV官网查看(https://developer.nvidia.com/cuda-gpus)
+ 支持CUDA运行的Linux Kernel Header和GCC等工具链
+ NVIDIA CUDA 工具包(https://developer.nvidia.com/cuda-downloads)

#### 检查GPU是否是CUDA-capable
---

shell终端输入以下命令：
```
lspci | grep -i nvidia
```
> 会返回GPU版本信息，去NV官网查看是否在支持列表中(https://developer.nvidia.com/cuda-gpus)

本人笔记本返回:
```
01:00.0 3D controller: NVIDIA Corporation GK107M [GeForce GT 750M] (rev a1)
```
> 本人电脑是GT750M型号的GPU硬件，GeForce系列Kepler架构的GPU，在支持列表中

#### 检查Linux版本是否支持CUDA
---

shell终端分别输入以下命令查看Ubuntu版本和基本软硬件信息：
```
lsb_release -a
uname -a
```
> 一般的Linux发行版均支持CUDA，通过查询系统信息确认系统操作系统版本和位数方便下载相应的软件开发包

本人笔记本返回:
```
No LSB modules are available.
Distributor ID:	Ubuntu
Description:	Ubuntu 14.04.5 LTS
Release:	14.04
Codename:	trusty

Linux franktly 3.13.0-123-generic #172-Ubuntu SMP Mon Jun 26 18:04:35 UTC 2017 x86_64 x86_64 x86_64 GNU/Linux
```
> 本人电脑是3.13 linux kernel版本，64位ubuntu14.04系统，支持CUDA8.0(CUDA8.0在ubuntu14.0上需要Kernel版本为3.13版本)


#### 检查Gcc版本
---
shell终端输入以下命令查看Gcc版本：
```
gcc --version
```
> CUDA8.0在ubuntu14.04上需要4.8.2及其以上的Gcc版本支持，若Gcc版本过低可以去<http://gcc.gnu.org/>下载比较新的

本人笔记本返回:
```
gcc (Ubuntu 4.8.4-2ubuntu1~14.04.3) 4.8.4
Copyright (C) 2013 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
```
> gcc版本是4.8.4,支持CUDA8.0

#### 检查是否安装了Kernel Header
---

shell终端输入以下命令查看Kernel版本:
```
uname -r 
```
shell终端输入以下命令安装对应Kernel版本的Kernel Header和Package Development:
```
sudo apt-get install linux-headers-$(uname -r)
```
至此，Ubuntu14.04上安装CUDA8.0的环境检查完成。

### 安装CUDA
---

CUDA提供了Package Manager和runfile两种方式进行安装，此处介绍成功率比较高简单的runfile方式安装。

#### 下载最新runfile
---

根据操作系统及位数在<https://developer.nvidia.com/cuda-downloads>选择合适的runfile安装文件下载安装。

#### 禁用nouveau
---

shell终端输入以下命令查看nouveau是否在运行：

```
lsmod | grep nouveau
```
> 若有输出表示在运行，否则表示没有运行

若在运行，则需要通过以下方式禁用nouvea，首先在`/etc/modeprobe.d`路径中创建`blacklist-nouveau.config`文件，并在文件中加入以下内容：
```
	blacklist nouveau
	option nouveau modeset=0
```
然后在shell终端输入：

```
sudo update-initramfs -u
```

再次运行`lsmode | grep nouveau`检查是否禁用成功


#### 关闭图形化界面进入字符界面安装CUDA
---

1. 重启电脑，在进入登录界面后，按下`alt+ctrl+F1`进入文本模式(text mode)，登录用户名和密码进入
2. 输入以下命令关闭图形用户界面：
```
sudo service lightdm stop
```
3. 切换到下载的runfile文件路劲，运行：
```
sudo sh cuda_XXX_linux.run
```
4. 输入以下命令重启图形用户界面：
```
sudo service lightdm start
```
> 按照安装提示一步一步的安装，选择yes or no或输入相关路径，最终安装成功会提示intalled, 否则failed。安装过程中注意以下几点:
>  + 在进行是否安装OpenGL库时候，对于多显卡系统(包含独立NV GPU显卡和集成的Intel或AMD显卡)，**最好选择NO** ，否则会出现黑屏
>  + 在提示是否进行nvidia-xconfig替换时候，需要自定义的多显卡X系统配置，**最好选择NO**

按下`alt+ctrl+F7`返回图形界面登录，若登录成功一般表示CUDA安装成功

#### 配置环境变量
---

编辑`/etc/profile`文件，添加以下两行将cuda相关工具和库加入系统路径：

```
export PATH=/usr/local/cuda-XXX/bin:$PATH(XXX为安装CUDA版本号)
export LD_LIBRARY_PATH=/usr/local/cudaXXX/lib64(根据相应的位数选择相应的lib文件)
```

为了立即生效可以在shell终端输入：

```
source /etc/profile
```

最后在shell终端输入：

```
env | grep cuda
```

查看环境变量是否设置成功


### 安装后检查
---

#### 检查NVIDIA设备驱动是否安装成功
---

在shell终端输入以下命令查看nvidia设备驱动情况：

```
cat /proc/driver/nvidia/version
```
> 若返回显示NVIDIA设备驱动版本和Gcc版本则表示安装成功

本人电脑返回：

```
NVRM version: NVIDIA UNIX x86_64 Kernel Module  375.26  Thu Dec  8 18:36:43 PST 2016
GCC version:  gcc version 4.8.4 (Ubuntu 4.8.4-2ubuntu1~14.04.3) 
```

在shell终端输入以下命令查看nvidia设备文件是否存在：

```
ls /dev | grep -i nvidia
```

本人电脑返回：

```
nvidia0
nvidiactl
nvidia-uvm
nvidia-uvm-tools
```

#### 检查CUDA Toolkit是否安装成功
---

在shell终端输入以下命令,查看cuda版本： 

```
nvcc -V
```

本人电脑返回：

```
nvcc: NVIDIA (R) Cuda compiler driver
Copyright (c) 2005-2016 NVIDIA Corporation
Built on Tue_Jan_10_13:22:03_CST_2017
Cuda compilation tools, release 8.0, V8.0.61
```
> cuda版本为8.0 


#### 检查CUDA Sample是否可以正常运行
---

在CUDA Sample的路径下(默认是安装在用户目录下的NVIDIA_CUDA_XXX_Samples文件夹下),输入：
```
make -jX(X表示系统CPU核数)
```
> 通过`cat /proc/cpuinfo | grep "processor" | sort -u | wc -l`命令查看逻辑cpu数
> 通过`cat /proc/cpuinfo | grep "physical id" | sort -u | wc -l`命令查看物理cpu数

在编译生成的`NVIDIA_CUDA_XXX_Samples/bin/x86_64/linux/release/`目录下运行其中一个sample，如设备查询sample：
```
./deviceQuery
```
> 若有查询结果打印说明sample运行正常

本人电脑运行结果为:
```
/home/franktly/NVIDIA_CUDA-8.0_Samples/bin/x86_64/linux/release/deviceQuery Starting...

 CUDA Device Query (Runtime API) version (CUDART static linking)

Detected 1 CUDA Capable device(s)

Device 0: "GeForce GT 750M"
  CUDA Driver Version / Runtime Version          8.0 / 8.0
  CUDA Capability Major/Minor version number:    3.0
  Total amount of global memory:                 4038 MBytes (4233953280 bytes)
  ( 2) Multiprocessors, (192) CUDA Cores/MP:     384 CUDA Cores
  GPU Max Clock rate:                            1085 MHz (1.09 GHz)
  Memory Clock rate:                             900 Mhz
  Memory Bus Width:                              128-bit
  L2 Cache Size:                                 262144 bytes
  Maximum Texture Dimension Size (x,y,z)         1D=(65536), 2D=(65536, 65536), 3D=(4096, 4096, 4096)
  Maximum Layered 1D Texture Size, (num) layers  1D=(16384), 2048 layers
  Maximum Layered 2D Texture Size, (num) layers  2D=(16384, 16384), 2048 layers
  Total amount of constant memory:               65536 bytes
  Total amount of shared memory per block:       49152 bytes
  Total number of registers available per block: 65536
  Warp size:                                     32
  Maximum number of threads per multiprocessor:  2048
  Maximum number of threads per block:           1024
  Max dimension size of a thread block (x,y,z): (1024, 1024, 64)
  Max dimension size of a grid size    (x,y,z): (2147483647, 65535, 65535)
  Maximum memory pitch:                          2147483647 bytes
  Texture alignment:                             512 bytes
  Concurrent copy and kernel execution:          Yes with 1 copy engine(s)
  Run time limit on kernels:                     No
  Integrated GPU sharing Host Memory:            No
  Support host page-locked memory mapping:       Yes
  Alignment requirement for Surfaces:            Yes
  Device has ECC support:                        Disabled
  Device supports Unified Addressing (UVA):      Yes
  Device PCI Domain ID / Bus ID / location ID:   0 / 1 / 0
  Compute Mode:
     < Default (multiple host threads can use ::cudaSetDevice() with device simultaneously) >

deviceQuery, CUDA Driver = CUDART, CUDA Driver Version = 8.0, CUDA Runtime Version = 8.0, NumDevs = 1, Device0 = GeForce GT 750M
Result = PASS
```
可以看到，通过以上步骤，CUDA Sample运行成功， deviceQuery检测到一个CUDA设备，并打印出其相关属性。

## 总结
---

至此CUDA8.0在Ubuntu14.04系统上安装成功，并成功运行CUDA Samples, 后续会陆续具体的介绍CUDA的使用

## 参考
---

https://developer.nvidia.com/compute/cuda/8.0/Prod2/docs/sidebar/CUDA_Installation_Guide_Linux-pdf
https://en.wikipedia.org/wiki/CUDA
https://blog.csdn.net/masa_fish/article/details/51882183
