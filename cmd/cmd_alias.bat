@if "%_echo%"=="" echo off

REM --git
@doskey gbye=git reset --hard HEAD
@doskey gs=git status
@doskey gb=git branch
@doskey gma=git commit -am $*
@doskey gmm=git commit -m $*
@doskey gc=git checkout $*
@doskey gcm=git checkout master
@doskey ga=git add
@doskey gall=git add --all
@doskey gp=git pull

REM end
echo.
echo ============================================================
echo = win-dotfiles is loaded!!
echo ============================================================
echo.
