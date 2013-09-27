@echo off
echo restore data
echo by: lalugina 1st
echo =====================

echo starting service ....

mode %1 baud=%2
NET START SerialKeys

