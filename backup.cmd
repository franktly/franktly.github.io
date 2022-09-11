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

