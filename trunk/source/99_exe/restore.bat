@echo off
echo restore data
echo by: in.Visi
echo =====================


echo restoring data ....

set path=%path%;C:\xampp\mysql\bin
mysqladmin -f -h localhost -u root -padmin drop petshop
mysqladmin -h localhost -u root -padmin create petshop
mysql -h localhost -u root -padmin petshop< %1

pause





