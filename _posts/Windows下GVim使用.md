---
title: Windows下GVim使用
date: 2019-07-08 
categories: Tools
tags:
- Vim
- GVim
---

## 前言
***
早些时候在文章[Vim编辑器总结](/2017/07/08/Vim编辑器总结/index.html)中总结Vim的常用用法和Linux下的安装和配置，虽然大部分时间是在Visual Studio + Viemu插件方式工作，但是有时候需要在Windows下使用Vim环境，因此有必要在Windows环境配置和Linux相似的Vim编辑环境，下面把Windows下`GVim`的安装和配置使用主要是与Linux环境下的不同地方进行分析总结。

<!--more-->

## GVim安装
***
`GVim`由于需要安装一些Python依赖的插件，因此需要Windows系统先安装好Python环境，且Python和GVim都需要安装一样的位数，由于电脑是64bits，所以Python和`GVim`都安装64bits
### Python安装
1. 下载链接：[Python Windows](https://www.python.org/downloads/windows/)，注意选择最新的Python3版本安装
> 安装过程，最好将Python加入系统环境变量，方便访问

2. 安装完成后，打开终端输入`Python`查看是否安装成功最新版本：
```
    python
```

### GVim安装
1. 下载链接：[GVim-Release](https://github.com/vim/vim-win32-installer/releases)，注意选择Release版本Assets部分的最新的GVim x64版本下载安装
2. 安装完成后，打开终端查看`Vim`和`GVim`版本和相应的功能选项，关键是确认下是有支持Python选项：
Vim是Windows Console控制台版本，通过以下命令查看：
```
    vim --version
```
GVim是Windows GUI用户界面版本，通过以下命令查看：
```
    gvim --version
```

## GVim配置
***
### GVim配置文件分类与优先级
GVim有Console控制台模式和GUI用户窗口界面模式，两者可以分别配置各自的配置文件，分别为`vimrc`, `_vimrc` 或`gvimrc`, `_gvimrc`，配置的优先级如下：

    系统 vimrc 文件: "$VIM\vimrc"
    用户 vimrc 文件: "$HOME\_vimrc"
    第二用户 vimrc 文件: "$HOME\vimfiles\vimrc"
    第三用户 vimrc 文件: "$VIM\_vimrc"
    系统 gvimrc 文件: "$VIM\gvimrc"
    用户 gvimrc 文件: "$HOME\_gvimrc"
    第二用户 gvimrc 文件: "$HOME\vimfiles\gvimrc"
    第三用户 gvimrc 文件: "$VIM\_gvimrc"
    defaults 文件: "$VIMRUNTIME\defaults.vim"

> `$VIM`一般为`GVim`安装目录，`$HOME`是用户目录，类似于Linux下`~`

### GVim配置文件配置
`GVim`在安装完成后一般会在`$HOME`目录下生成一个`vimfiles`文件，该文件用来配置`GVim`的插件和主题颜色，所以常用的做法是在`$HOME`目录下建立一个`_vimrc`文件,将`GVim`的配置放在该文件夹下，一般情况可以将控制台和GUI两种分开，也可以放在一个配置文件通过Vim脚本来区分，本人采用后一种方式，脚本判断OS版本和`GVim`类型如下：
```
    " -----------------------------------------------------------------------------
    "check os type 
    " -----------------------------------------------------------------------------
    let g:windows = 0
    if(has("win32") || has("win64") || has("win95") || has("win16   "))
        let g:windows = 1
    else
        let g:windows = 0
    endif

    " -----------------------------------------------------------------------------
    "  console or GUI
    " -----------------------------------------------------------------------------
    if has("gui_running")
        let g:gui = 1
    else
        let g:gui = 0
    endif
```

>安装完`GVim`，默认情况下第一优先级**系统vimrc**文件是不存在的，只有第四优先级**第三用户vimrc文件**存在，所以通过在`$HOME`目录建立`_vimrc`方式建立第二优先级的配置文件会是最终的生效文件


### GVim插件配置

#### Vundle包管理插件安装
与Linux版本的Vundle包管理插件安装的路径不同，配置文件中Windows下为`vimfiles`，Linux下为`.vim`：
```
    if g:windows
        set rtp+=$HOME/vimfiles/bundle/Vundle.vim     " set the runtime path to include Vundle and initialize for windows
    else
        set rtp+=$HOME/.vim/bundle/Vundle.vim     " set the runtime path to include Vundle and initialize for no_windows
    endif
```

#### 其他插件安装
之前写的文章[Vim编辑器总结](/2017/07/08/Vim编辑器总结/index.html)中的各种插件基本上和Linux下安装步骤相同，只需要输入以下命令即可:

    PluginClean
    PluginList
    PluginInstall
>执行上述命令后，这些插件安装在`$HOME/.vim/bundle`目录下

但是有几个插件Windows下处理方式有些差别：
1. `TagBar`函数类变量导航插件
该插件依赖于ctags,所以Windows上也要提前安装好Windows版本的ctags，下载链接: [Universal-Ctags-Windows](https://github.com/universal-ctags/ctags-win32/releases)。注意需要下载64bit的ctags，下载完成后解压文件，最后将相应的exe文件拷贝到`GVim`的安装目录下即与`gvim.exe`或`vime.exe`同一目录下

2. `fzf`模糊查找插件
该插件需要安装Windows下的二进制文件，在打开`fzf`时候`GVim`会自动提示是否安装，直接输入`y`安装即可,无需手动安装

3. `solarized`主题插件
该插件在`GVim`的GUI用户可视化模式下需要配置，初次打开会提示无法找到该主题，解决方法为直接将该插件的下载目录($HOME/.vim/bundle/)的`solarized.vim`拷贝到`vimfiles/colors`下即可:
```
    cp $HOME/.vim/bundle/vim-colors-solarized/colors/solarized.vim  $HOME/vimfiles/colors/
```
同时，为了防止该主题影响`GVim`的Console控制台模式下的效果，在配置文件中做相应的区分处理：
```
    if ((g:windows && g:gui) || !g:windows)
        colorscheme solarized 
    endif
```

3. `markdown-preview`markdown预览插件
该插件也需要安装相应的Windows下二进制文件，与`fzf`插件自动安装不同，需要手动输入以下命令安装：
```
    :source %
    :PluginInstall
    :call mkdp#util#install()
```
4. `YouCompleteMe`自动补全插件
该插件不同平台下安装差异比较大，Windows下可以参考官方的步骤进行安装：[YCM-Windows-Install](https://github.com/ycm-core/YouCompleteMe#windows)

5. 其他显示效果
如`GVim`GUI用户可视化模式下，字体设置相对大一些：
```
    if (g:gui && g:windows)
        set guifont=Courier_New:h14:cANSI        " Set font 
    else
        set guifont=Courier_New\ 12              " Set font 
    endif
```

最终的效果
GVim GUI模式下：
![gvim-gui](gvim-gui.png)

GVim Console模式下：
![gvim-console](gvim-console.png)

## 总结
***
通过以上Windows下`GVim`的安装和配置操作，基本上Windows平台下GUI窗口用户界面模式和Console控制台模式的Vim效果和Linux下差不多了，这样不同平台下Vim的操作体验一致性也提高很多

## 参考
---

[www.vim.org](www.vim.org)

[cannot-find-color-scheme-solarized](https://stackoverflow.com/questions/8804767/e185-cannot-find-color-scheme-solarized)

[vim-win32-installer](https://github.com/vim/vim-win32-installer)

[difference-between-vims-clipboard-unnamed-and-unnamedplus-settings](https://stackoverflow.com/questions/30691466/what-is-difference-between-vims-clipboard-unnamed-and-unnamedplus-settings)
