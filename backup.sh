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

