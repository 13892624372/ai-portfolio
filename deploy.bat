@echo off
echo 正在推送代码到GitHub...

cd /d "%~dp0"

git init

git add .

git commit -m "first commit"

git branch -M main

git remote add origin https://github.com/13892624372/ai-portfolio.git

git push -u origin main

echo.
echo 推送完成！请到GitHub仓库设置Pages。
pause
