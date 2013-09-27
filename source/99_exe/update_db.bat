@echo off
echo data sincronizing
echo by: lalugina 1st
echo =====================

echo sincronizing database data ....

mysql -h invisi03 -u root -padmin apotek system_menu mst_company < update_db.sql



