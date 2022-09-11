# Hexo 博客站点配置和文章源码备份Hexo分支说明
***

## 备份站点源文件目录说明
***

#### source
`source`目录包括发表的Post文章源信息，图片和其他页面及CNAME域名配置和网页SEO优化robots文件
1. 404页面
2. `_post`文章源文本和源图片
3. `about`页面
4. `categories`页面
5. `tags`页面
6. CNAME自定义域名记录
7. SEO网站优化robots文件
8. `avatar.gif`Site头像

#### Hexo站点配置文件
site_config.yml
>安装完`Hexo`后可以通过`Hexo`博客根目录下`package.json`文件查看安装的`Hexo`版本

#### Next主题配置文件
next_config.yml
>安装完Next后可以通过`theme/next/`主题目录下`package.json`文件查看安装的`Next`版本

#### 自动备份脚本
1. run.sh 和 run.cmd（Linux版本和Windows版本运行脚本包含清除，重新部署，自动备份并提交到博客`Hexo`分支操作）
2. backup.sh 和 backup.cmd(Linux版本和Windows版本自动备份提交到博客`Hexo`分支操作)

附脚本内容：
1. run.sh
```
#!/usr/bin/bash

# hexo clean
hexo clean

# hexo deploy and try 5 times if deployed failed
for time in {1..5}
do
    hexo d -g >> log.txt
    if grep -R "fatal" log.txt
    then
        echo "hexo deploy failed and try again [$time]"
        echo -n "" > log.txt
    else
        break
    fi
done

# backup hexo source file
sh ./backup.sh
```

2. run.cmd
```
@ECHO OFF
setlocal enabledelayedexpansion

rem hexo clean
call hexo clean

rem hexo deploy and try trytime if deployed failed
set trytime=5
set thres=1

:deploy
call hexo d -g >> log.txt
findstr /m "fatal" log.txt 
if %errorlevel%==0 (
    if %trytime% LSS %thres% (
        echo "hexo deploy try %trytime% failed and exit"
        goto end
    )
    echo "hexo deploy failed and try again [%trytime%]"
    set /a trytime-=1
    break>log.txt
    goto deploy
)

rem backup hexo source file
call "%~dp0backup.cmd%" 

:end
pause
```

3. backup.sh
```
#!/usr/bin/bash

echo "************* start backup hexo source file ************* "
cp -fr source/ ../blog_backup/franktly.github.io/
cp -f _config.yml ../blog_backup/franktly.github.io/site_config.yml
cp -f themes/next/_config.yml  ../blog_backup/franktly.github.io/next_config.yml
cp -f themes/next/source/images/avatar.gif ../blog_backup/franktly.github.io/avatar.gif
cd ../blog_backup/franktly.github.io
git add . 
git commit -m "update hexo source file from linux"

# git push and try 5 if deployed failed
for time in {1..5}
do
    git push >> ../../blog/log.txt
    if grep -R "fatal" ../../blog/log.txt
    then
        echo "git push failed and try again [$time]"
        echo -n "" > ../../blog/log.txt
    else
        break
    fi
done

cd ..\..\blog
echo "************* finish backup hexo source file ************* "
```

4. backup.cmd
```
@ECHO OFF
setlocal enabledelayedexpansion

ECHO "************* start backup hexo source file ************* "
xcopy /E /y source\ ..\blog_backup\franktly.github.io\
copy /y _config.yml ..\blog_backup\franktly.github.io\site_config.yml
copy /y themes\next\_config.yml  ..\blog_backup\franktly.github.io\next_config.yml
copy /y themes\next\source\images\avatar.gif ..\blog_backup\franktly.github.io\avatar.gif
cd ..\blog_backup\franktly.github.io
call git add . 
call git commit -m "update hexo source file from windows"

rem git push and try trytime if deployed failed
set trytime=5
set thres=1
:push
call git push >> ..\..\blog\log.txt
findstr /m "fatal" ..\..\blog\log.txt 
if %errorlevel%==0 (
    if %trytime% LSS %thres% (
        echo "git push try %trytime% failed and exit"
        goto end
    )
    echo "git push failed and try again [%trytime%]"
    set /a trytime-=1
    break>..\..\blog\log.txt
    goto push
)

:end
cd ..\..\blog
ECHO "************* finish backup hexo source file ************* "

```

#### 自动备份方法
1. 建立备份文件夹blog_backup(首次备份需要的操作）
2. 克隆`Hexo`分支到备份文件夹(首次备份需要的操作)
```

git clone -b hexo --single-branch https://github.com/franktly/franktly.github.io.git

```
3. 将`run.sh`或`run.cmd`和`backup.sh`或`backup.cmd`脚本拷贝到`Hexo`博客根目录(首次备份需要的操作)
4. **在部署文章到`GitHub Page`时候执行`run.sh`脚本替代`hexo deploy`等命令(部署文章时候高频操作)**

