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
echo -n "" > log.txt
echo "************* finish backup hexo source file ************* "

