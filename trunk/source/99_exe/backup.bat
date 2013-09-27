@echo off
echo backup
echo by: in.Visi
echo =====================


echo backuping data ....
set path=%path%;C:\Program Files\MySQL\MySQL Server 5.0\bin
mysqldump --opt -h %1 -u root -p%3 --routines %4 > %2


goto end

:error
echo file "%3" tidak ketemu
goto usage

:usage
echo penggunaan: %0 [dump-file]
echo contoh: %0 2003-12-01.sql
pause
goto end

:end


pause
