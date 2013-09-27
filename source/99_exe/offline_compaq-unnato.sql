
-- Begin on 09/07/11 21:15:38 - cashier
XA START 'COMPAQ-UNNATOcashier';
XA END 'COMPAQ-UNNATOcashier';
XA PREPARE 'COMPAQ-UNNATOcashier';
XA COMMIT 'COMPAQ-UNNATOcashier';
delete from setup_racik where racik_id = 0;
update system_config set conf_value = '-1'where conf_id = 1;
update system_config set conf_value = '-1'where conf_id = 2;
update system_config set conf_value = '**Harga Sudah termasuk PPn**'where conf_id = 12;
update system_config set conf_value = '**Terimakasih Atas Kunjungnnya**'where conf_id = 13;
