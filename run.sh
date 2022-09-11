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
