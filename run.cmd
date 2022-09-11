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
