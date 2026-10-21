@echo off
setlocal

REM ===== EDIT THESE THREE LINES =====
set GIT_NAME=Arafath02
set GIT_EMAIL=arafathlafeer11@gmail.com
set REPO_URL=https://github.com/Arafath02/SME-KDS.git
REM ==================================

REM Always work in the folder this file sits in
cd /d "%~dp0"

REM Safety check: make sure we are in the KDS folder, not the user profile
if not exist "index.html" (
    echo ERROR: index.html not found in %cd%
    echo Put this file inside the SambaPOS-GitHub-KDS folder and run it again.
    pause
    exit /b 1
)

where git >nul 2>nul
if errorlevel 1 (
    echo ERROR: Git is not installed. Get it from https://git-scm.com
    pause
    exit /b 1
)

REM Git ignores empty folders, so add a placeholder if kds-data is empty
if not exist "kds-data" mkdir "kds-data"
if not exist "kds-data\*" echo.>"kds-data\.gitkeep"

REM First-time setup
if not exist ".git" git init
git branch -M main
git config user.name "%GIT_NAME%"
git config user.email "%GIT_EMAIL%"
git remote remove origin >nul 2>nul
git remote add origin %REPO_URL%

REM Commit everything in this folder
git add .
git commit -m "Update KDS"

REM If the repo already has content on GitHub, merge it first
git ls-remote --exit-code --heads origin main >nul 2>nul
if not errorlevel 1 git pull origin main --allow-unrelated-histories --no-edit

REM Push
git push -u origin main

echo.
echo Done. Check https://github.com/Arafath02/SME-KDS
pause
