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

#### Hexo站点配置文件
site_config.yml
>安装完`Hexo`后可以通过`Hexo`博客目录下`package.json`文件查看安装的`Hexo`版本

#### Next主题配置文件
next_config.yml
>安装完Next后可以通过`theme/next/`目录下`package.json`文件查看安装的`Next`版本

#### 自动备份脚本
1. run.sh（运行脚本包含清除，重新部署，自动备份并提交到博客`Hexo`分支操作）
2. backup.sh(自动备份提交到博客`Hexo`分支操作)

附脚本内容：
1. run.sh
```
#!/usr/bin/bash
hexo clean
hexo d -g
sh ./backup.sh

```

2. backup.sh
```
#!/usr/bin/bash

echo "************* start backup hexo source file ************* "
cp -r source/ ~/blog_backup/franktly.github.io/
cp _config.yml ~/blog_backup/franktly.github.io/site_config.yml
cp  themes/next/_config.yml  ~/blog_backup/franktly.github.io/next_config.yml
cd ~/blog_backup/franktly.github.io
git add . 
git commit -m "update hexo source file"
git push
echo "************* finish backup hexo source file ************* "

```

#### 自动备份脚本使用方法
1. 建立备份文件夹blog_backup(首次备份需要的操作）
2. 克隆`Hexo`分支到备份文件夹(首次备份需要的操作)
```

git clone -b hexo --single-branch https://github.com/franktly/franktly.github.io.git

```
3. **在部署文章到`GitHub Page`时候执行`run.sh`脚本替代`hexo deploy`等命令(部署文章时候高频操作)**

