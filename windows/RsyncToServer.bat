REM @echo off

REM Without this the cwd for cygwin is wrong and the .gitignore file is not found
set CHERE_INVOKING=1

setlocal
REM This is the file that contains the password and the folder name, stored separately for each project so we can rsync to different directories on the server
REM Call it rsync.txt in each project and don't add it to the git repo
set file1=rsync.txt

REM Read password from password file

set "count=0"

setlocal disabledelayedexpansion
for /f "delims=" %%i in (%file1%) do (
    set "line=%%i"
    setlocal enabledelayedexpansion
    echo !line!
    if !count! equ 0 (
	set "password=!line!"
    ) else (
	set "folder_name=!line!"
    )
    set /a count+=1
)

setlocal disabledelayedexpansion
echo Password: %password%

setlocal enabledelayedexpansion
echo Folder name: %folder_name%

endlocal

C:\\cygwin64\\bin\\bash --login -c "sshpass -p '%password%' rsync -avz --delete-after --exclude='.git/' --filter='dir-merge,- .gitignore' --exclude-from='.gitignore' ./ mg315@frank.eecs.qmul.ac.uk:/homes/mg315/%folder_name%/"
