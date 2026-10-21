@echo
REM Pushes any changes in kds-data to GitHub (SME-KDS)
cd /d "%~dp0"

git add kds-data
git commit -m "ticket update" >nul 2>nul
git pull --rebase origin main >nul 2>nul
git push origin main

pause