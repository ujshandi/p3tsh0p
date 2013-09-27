
-- Begin on 09/06/27 15:38:24 - apotek
XA START 'JABORATORIUMapotek';
insert into mst_item (specification, item_code, barcode, struk_name, merk, avg_price, vendor_id, produsen_id, kemasan_id, bkp, konsinyasi, item_name, dosis, kategori, expire_date) values (3,'88','88','BODREK','',1,NULL,205,145,1,0,'BODREK',5,1,cast('2009-06-27 'as date));
insert into mst_item_conversion (item_id, unit_id, conversion, cost_price, purchase_price, sales_price, sales_price2, sales_price3, item_tax, item_discount, disc_tipe, net_price)values (1,30,1,0,1,1.1,1.1,0,10,0,0,1.1);
XA END 'JABORATORIUMapotek';
XA PREPARE 'JABORATORIUMapotek';
XA COMMIT 'JABORATORIUMapotek';
insert into setup_racik (racik_id) values ( NULL);
insert into setup_racik (racik_id) values ( NULL);

-- Begin on 09/06/27 19:37:19 - cashier
XA START 'JABORATORIUMcashier';
insert into setup_racik (paket_id, qty, total, embalase) values (5,2,3.3,7);
XA END 'JABORATORIUMcashier';
XA PREPARE 'JABORATORIUMcashier';
XA ROLLBACK 'JABORATORIUMcashier';

-- Begin on 09/06/27 20:20:12 - cashier
XA START 'JABORATORIUMcashier';
insert into setup_racik (paket_id, qty, harga, embalase) values (1,20,1.1,500);
insert into setup_racik_detail (racik_id, item_id, harga, hrg_rata, hrg_beli, unit_id, dosis, qty, total) values(4,1,1.1,1,1,1,30,0.03,1.1);
XA END 'JABORATORIUMcashier';
XA PREPARE 'JABORATORIUMcashier';
XA ROLLBACK 'JABORATORIUMcashier';

-- Begin on 09/06/27 20:31:48 - cashier
XA START 'JABORATORIUMcashier';
insert into setup_racik (paket_id, qty, harga, harga_beli, harga_rata, embalase) values (1,20,1.1,6.67,6.67,2000);
insert into setup_racik_detail (racik_id, item_id, harga, hrg_rata, hrg_beli, conv_id, dosis, qty, total) values(5,1,1.1,1,1,1,30,6.67,1.1);
XA END 'JABORATORIUMcashier';
XA PREPARE 'JABORATORIUMcashier';
XA ROLLBACK 'JABORATORIUMcashier';

-- Begin on 09/06/27 20:38:16 - cashier
XA START 'JABORATORIUMcashier';
insert into setup_racik (paket_id, qty, harga, harga_beli, harga_rata, embalase) values (1,20,66.7,6.67,6.67,5000);
insert into setup_racik_detail (racik_id, item_id, harga, hrg_rata, hrg_beli, conv_id, dosis_obat, qty, total) values(6,1,10,1,1,1,30,6.67,66.7);
XA END 'JABORATORIUMcashier';
XA PREPARE 'JABORATORIUMcashier';
XA COMMIT 'JABORATORIUMcashier';

-- Begin on 09/06/27 20:43:58 - cashier
XA START 'JABORATORIUMcashier';
insert into setup_racik (paket_id, qty, harga, harga_beli, harga_rata, embalase) values (1,20,7.34,6.67,6.67,5000);
insert into setup_racik_detail (racik_id, item_id, harga, hrg_rata, hrg_beli, conv_id, dosis_obat, qty, total) values(7,1,1.1,1,1,1,30,6.67,7.34);
XA END 'JABORATORIUMcashier';
XA PREPARE 'JABORATORIUMcashier';
XA COMMIT 'JABORATORIUMcashier';

-- Begin on 09/06/27 20:48:13 - cashier
XA START 'JABORATORIUMcashier';
insert into setup_racik (paket_id, qty, harga, harga_beli, harga_rata, embalase) values (1,20,7.34,6.67,6.67,1000);
insert into setup_racik_detail (racik_id, item_id, harga, hrg_rata, hrg_beli, conv_id, dosis_obat, qty, total) values(1,1,1.1,1,1,1,30,6.67,7.34);
XA END 'JABORATORIUMcashier';
XA PREPARE 'JABORATORIUMcashier';
XA COMMIT 'JABORATORIUMcashier';

-- Begin on 09/06/27 20:49:06 - cashier
XA START 'JABORATORIUMcashier';
insert into trs_sales_mst (trans_num, trans_type, trans_date, cashier_id, gudang_id, pasien_id, subtotal, profit, disc_mst, disc_val_mst, disc_detail, tax, total, real_amount, sisa, user_id, shift_id, cash, cara_bayar, card_id, bank, dokter_id, no_resep) values (get_new_sales_num('RJ/SS/200906'), 13,cast('2009-06-27 'as date),5,9,NULL,146.8,7,0,0,0,0,146.8,146.8,0,'adm',2,5000,0,'','',NULL,'');
XA END 'JABORATORIUMcashier';
XA PREPARE 'JABORATORIUMcashier';
XA ROLLBACK 'JABORATORIUMcashier';

-- Begin on 09/06/27 22:27:26 - cashier
XA START 'JABORATORIUMcashier';
insert into setup_racik (paket_id, qty, harga, harga_beli, harga_rata, embalase) values (1,20,33350,6.67,6.67,10000);
insert into setup_racik_detail (racik_id, item_id, harga, hrg_rata, hrg_beli, conv_id, dosis_obat, qty, total) values(2,1,5000,1,1,1,30,6.67,33350);
XA END 'JABORATORIUMcashier';
XA PREPARE 'JABORATORIUMcashier';
XA COMMIT 'JABORATORIUMcashier';

-- Begin on 09/06/27 22:28:55 - cashier
XA START 'JABORATORIUMcashier';
insert into trs_sales_mst (trans_num, trans_type, trans_date, cashier_id, gudang_id, pasien_id, subtotal, profit, disc_mst, disc_val_mst, disc_detail, tax, total, embalase, real_amount, sisa, user_id, shift_id, cash, cara_bayar, card_id, bank, dokter_id, no_resep) values (get_new_sales_num('RJ/SS/200906'), 13,cast('2009-06-27 'as date),5,9,NULL,33350,33343,0,0,0,0,43350,10000,43350,0,'adm',2,50000,0,'','',NULL,'');
XA END 'JABORATORIUMcashier';
XA PREPARE 'JABORATORIUMcashier';
XA ROLLBACK 'JABORATORIUMcashier';

-- Begin on 09/06/27 22:30:59 - cashier
XA START 'JABORATORIUMcashier';
insert into trs_sales_mst (trans_num, trans_type, trans_date, cashier_id, gudang_id, pasien_id, subtotal, profit, disc_mst, disc_val_mst, disc_detail, tax, total, embalase, real_amount, sisa, user_id, shift_id, cash, cara_bayar, card_id, bank, dokter_id, no_resep) values (get_new_sales_num('RJ/SS/200906'), 13,cast('2009-06-27 'as date),5,9,NULL,33350,33343,0,0,0,0,43350,10000,43350,0,'adm',2,50000,0,'','',NULL,'');
insert into trs_sales_detail (sales_id, item_id, conv_id, quantity, price, disc, disc_val, amount, amount_profit, price_purchase, paket_id, points, conversion)values ((select sales_id from trs_sales_mst y where y.trans_num = (select max(x.trans_num) from trs_sales_mst x where x.cashier_id = 5) and y.cashier_id = 5), NULL,NULL,1,33350,0,0,33350,33343,7,1,0,1);
XA END 'JABORATORIUMcashier';
XA PREPARE 'JABORATORIUMcashier';
XA ROLLBACK 'JABORATORIUMcashier';

-- Begin on 09/06/27 22:35:40 - cashier
XA START 'JABORATORIUMcashier';
insert into setup_racik (paket_id, qty, harga, harga_beli, harga_rata, embalase) values (1,20,33350,6.67,6.67,1000);
insert into setup_racik_detail (racik_id, item_id, harga, hrg_rata, hrg_beli, conv_id, dosis_obat, qty, total) values(1,1,5000,1,1,1,30,6.67,33350);
XA END 'JABORATORIUMcashier';
XA PREPARE 'JABORATORIUMcashier';
XA COMMIT 'JABORATORIUMcashier';

-- Begin on 09/06/27 22:36:06 - cashier
XA START 'JABORATORIUMcashier';
insert into trs_sales_mst (trans_num, trans_type, trans_date, cashier_id, gudang_id, pasien_id, subtotal, profit, disc_mst, disc_val_mst, disc_detail, tax, total, embalase, real_amount, sisa, user_id, shift_id, cash, cara_bayar, card_id, bank, dokter_id, no_resep) values (get_new_sales_num('RJ/SS/200906'), 13,cast('2009-06-27 'as date),5,9,NULL,33350,33343,0,0,0,0,34350,1000,34350,0,'adm',2,50000,0,'','',NULL,'');
insert into trs_sales_detail (sales_id, item_id, conv_id, quantity, price, disc, disc_val, amount, amount_profit, price_purchase, paket_id, points, conversion)values ((select sales_id from trs_sales_mst y where y.trans_num = (select max(x.trans_num) from trs_sales_mst x where x.cashier_id = 5) and y.cashier_id = 5), NULL,NULL,1,33350,0,0,33350,33343,7,1,0,1);
update mst_item set current_stock = current_stock + -6.67 where item_id = 1;
call save_to_item_balance(9, 1, cast('2009-06-27 'as date), 6.67, 'C');
insert into trs_sales_paket (sales_id, paket_id, item_id, conv_id, quantity, price, hrg_dasar, hrg_beli, dosis, amount_profit, disc, disc_val, gudang_id) values((select sales_id from trs_sales_mst y where y.trans_num = (select max(x.trans_num) from trs_sales_mst x where x.cashier_id = 5) and y.cashier_id = 5), 1,1,1,6.67,5000,1,1,-6.67,0,0,9);
XA END 'JABORATORIUMcashier';
XA PREPARE 'JABORATORIUMcashier';
XA ROLLBACK 'JABORATORIUMcashier';

-- Begin on 09/06/27 22:45:01 - cashier
XA START 'JABORATORIUMcashier';
insert into setup_racik (paket_id, qty, harga, harga_beli, harga_rata, embalase) values (1,20,33350,6.67,6.67,10000);
insert into setup_racik_detail (racik_id, item_id, harga, hrg_rata, hrg_beli, conv_id, dosis_obat, qty, total) values(2,1,5000,1,1,1,30,6.67,33350);
XA END 'JABORATORIUMcashier';
XA PREPARE 'JABORATORIUMcashier';
XA COMMIT 'JABORATORIUMcashier';

-- Begin on 09/06/27 22:45:11 - cashier
XA START 'JABORATORIUMcashier';
insert into trs_sales_mst (trans_num, trans_type, trans_date, cashier_id, gudang_id, pasien_id, subtotal, profit, disc_mst, disc_val_mst, disc_detail, tax, total, embalase, real_amount, sisa, user_id, shift_id, cash, cara_bayar, card_id, bank, dokter_id, no_resep) values (get_new_sales_num('RJ/SS/200906'), 13,cast('2009-06-27 'as date),5,9,NULL,33350,33343,0,0,0,0,43350,10000,43350,0,'adm',2,50000,0,'','',NULL,'');
insert into trs_sales_detail (sales_id, item_id, conv_id, quantity, price, disc, disc_val, amount, amount_profit, price_purchase, paket_id, points, conversion)values ((select sales_id from trs_sales_mst y where y.trans_num = (select max(x.trans_num) from trs_sales_mst x where x.cashier_id = 5) and y.cashier_id = 5), NULL,NULL,1,33350,0,0,33350,33343,7,1,0,1);
update mst_item set current_stock = current_stock + -6.67 where item_id = 1;
call save_to_item_balance(9, 1, cast('2009-06-27 'as date), 6.67, 'C');
insert into trs_sales_paket (sales_id, paket_id, item_id, conv_id, quantity, price, hrg_dasar, hrg_beli, dosis, amount_profit, disc, disc_val, gudang_id) values((select sales_id from trs_sales_mst y where y.trans_num = (select max(x.trans_num) from trs_sales_mst x where x.cashier_id = 5) and y.cashier_id = 5), 1,1,1,6.67,5000,1,1,0,-6.67,0,0,9);
delete from setup_racik where racik_id = 2;
call save_to_cashier_balance(5, 0, 2, 33350, 0, 0, 10000, 'D', 'adm');
XA END 'JABORATORIUMcashier';
XA PREPARE 'JABORATORIUMcashier';
XA COMMIT 'JABORATORIUMcashier';

-- Begin on 09/06/27 22:46:15 - cashier
XA START 'JABORATORIUMcashier';
insert into setup_racik (paket_id, qty, harga, harga_beli, harga_rata, embalase) values (7,20,20000,100,100,5000);
insert into setup_racik_detail (racik_id, item_id, harga, hrg_rata, hrg_beli, conv_id, dosis_obat, qty, total) values(3,1,200,1,1,1,10,100,20000);
XA END 'JABORATORIUMcashier';
XA PREPARE 'JABORATORIUMcashier';
XA COMMIT 'JABORATORIUMcashier';

-- Begin on 09/06/27 22:46:54 - cashier
XA START 'JABORATORIUMcashier';
insert into trs_sales_mst (trans_num, trans_type, trans_date, cashier_id, gudang_id, pasien_id, subtotal, profit, disc_mst, disc_val_mst, disc_detail, tax, total, embalase, real_amount, sisa, user_id, shift_id, cash, cara_bayar, card_id, bank, dokter_id, no_resep) values (get_new_sales_num('RJ/SS/200906'), 13,cast('2009-06-27 'as date),5,9,NULL,20000,19900,0,0,0,0,25000,5000,25000,0,'adm',2,50000,1,'','25000',NULL,'');
insert into trs_sales_detail (sales_id, item_id, conv_id, quantity, price, disc, disc_val, amount, amount_profit, price_purchase, paket_id, points, conversion)values ((select sales_id from trs_sales_mst y where y.trans_num = (select max(x.trans_num) from trs_sales_mst x where x.cashier_id = 5) and y.cashier_id = 5), NULL,NULL,1,20000,0,0,20000,19900,100,7,0,1);
update mst_item set current_stock = current_stock + -100 where item_id = 1;
call save_to_item_balance(9, 1, cast('2009-06-27 'as date), 100, 'C');
insert into trs_sales_paket (sales_id, paket_id, item_id, conv_id, quantity, price, hrg_dasar, hrg_beli, dosis, amount_profit, disc, disc_val, gudang_id) values((select sales_id from trs_sales_mst y where y.trans_num = (select max(x.trans_num) from trs_sales_mst x where x.cashier_id = 5) and y.cashier_id = 5), 7,1,1,100,200,1,1,0,-100,0,0,9);
delete from setup_racik where racik_id = 3;
call save_to_cashier_balance(5, 1, 2, 20000, 0, 0, 5000, 'D', 'adm');
XA END 'JABORATORIUMcashier';
XA PREPARE 'JABORATORIUMcashier';
XA COMMIT 'JABORATORIUMcashier';

-- Begin on 09/06/29 20:54:21 - apotek
XA START 'JABORATORIUMapotek';
insert into mst_code (code_name, parent_id, urut, level) values ('BAHAN BAKU ',1,0,2);
insert into point_maping (code_id, root_id) values (4,4);
insert into point_maping (code_id, root_id) values (4,1);
XA END 'JABORATORIUMapotek';
XA PREPARE 'JABORATORIUMapotek';
XA COMMIT 'JABORATORIUMapotek';

-- Begin on 09/06/29 20:55:27 - apotek
XA START 'JABORATORIUMapotek';
insert into mst_code (code_name, parent_id, urut, level) values ('MAKANAN',1,0,2);
insert into point_maping (code_id, root_id) values (5,5);
insert into point_maping (code_id, root_id) values (5,1);
XA END 'JABORATORIUMapotek';
XA PREPARE 'JABORATORIUMapotek';
XA COMMIT 'JABORATORIUMapotek';

-- Begin on 09/06/29 20:55:32 - apotek
XA START 'JABORATORIUMapotek';
insert into mst_code (code_name, parent_id, urut, level) values ('MINUMAN',1,0,2);
insert into point_maping (code_id, root_id) values (6,6);
insert into point_maping (code_id, root_id) values (6,1);
XA END 'JABORATORIUMapotek';
XA PREPARE 'JABORATORIUMapotek';
XA COMMIT 'JABORATORIUMapotek';

-- Begin on 09/06/29 20:55:40 - apotek
XA START 'JABORATORIUMapotek';
insert into mst_code (code_name, parent_id, urut, level) values ('SUPPLEMEN',1,0,2);
insert into point_maping (code_id, root_id) values (7,7);
insert into point_maping (code_id, root_id) values (7,1);
XA END 'JABORATORIUMapotek';
XA PREPARE 'JABORATORIUMapotek';
XA COMMIT 'JABORATORIUMapotek';

-- Begin on 09/06/29 20:59:16 - apotek
XA START 'JABORATORIUMapotek';
insert into mst_code (code_name, parent_id, urut, level) values ('OPTIK',3,2,3);
insert into point_maping (code_id, root_id) values (8,8);
insert into point_maping (code_id, root_id) values (8,3);
insert into point_maping (code_id, root_id) values (8,1);
XA END 'JABORATORIUMapotek';
XA PREPARE 'JABORATORIUMapotek';
XA COMMIT 'JABORATORIUMapotek';

-- Begin on 09/06/29 20:59:23 - apotek
XA START 'JABORATORIUMapotek';
delete from mst_code where code_id = 8;
XA END 'JABORATORIUMapotek';
XA PREPARE 'JABORATORIUMapotek';
XA COMMIT 'JABORATORIUMapotek';

-- Begin on 09/06/29 20:59:31 - apotek
XA START 'JABORATORIUMapotek';
insert into mst_code (code_name, parent_id, urut, level) values ('OPTIK',1,0,2);
insert into point_maping (code_id, root_id) values (9,9);
insert into point_maping (code_id, root_id) values (9,1);
XA END 'JABORATORIUMapotek';
XA PREPARE 'JABORATORIUMapotek';
XA COMMIT 'JABORATORIUMapotek';

-- Begin on 09/06/29 20:59:50 - apotek
XA START 'JABORATORIUMapotek';
insert into mst_code (code_name, parent_id, urut, level) values ('KOSMETIK',1,0,2);
insert into point_maping (code_id, root_id) values (10,10);
insert into point_maping (code_id, root_id) values (10,1);
XA END 'JABORATORIUMapotek';
XA PREPARE 'JABORATORIUMapotek';
XA COMMIT 'JABORATORIUMapotek';

-- Begin on 09/06/29 21:00:05 - apotek
XA START 'JABORATORIUMapotek';
insert into mst_code (code_name, parent_id, urut, level) values ('JAMU',1,0,2);
insert into point_maping (code_id, root_id) values (11,11);
insert into point_maping (code_id, root_id) values (11,1);
XA END 'JABORATORIUMapotek';
XA PREPARE 'JABORATORIUMapotek';
XA COMMIT 'JABORATORIUMapotek';

-- Begin on 09/06/29 21:02:59 - apotek
XA START 'JABORATORIUMapotek';
insert into mst_code (code_name, parent_id, urut, level) values ('ALAT KB',3,2,3);
insert into point_maping (code_id, root_id) values (12,12);
insert into point_maping (code_id, root_id) values (12,3);
insert into point_maping (code_id, root_id) values (12,1);
XA END 'JABORATORIUMapotek';
XA PREPARE 'JABORATORIUMapotek';
XA COMMIT 'JABORATORIUMapotek';

-- Begin on 09/06/29 21:04:11 - apotek
XA START 'JABORATORIUMapotek';
insert into mst_code (code_name, parent_id, urut, level) values ('ANTI BIOTIK',2,1,3);
insert into point_maping (code_id, root_id) values (13,13);
insert into point_maping (code_id, root_id) values (13,2);
insert into point_maping (code_id, root_id) values (13,1);
XA END 'JABORATORIUMapotek';
XA PREPARE 'JABORATORIUMapotek';
XA COMMIT 'JABORATORIUMapotek';

-- Begin on 09/06/29 21:04:18 - apotek
XA START 'JABORATORIUMapotek';
insert into mst_code (code_name, parent_id, urut, level) values ('NARKOTIKA',2,1,3);
insert into point_maping (code_id, root_id) values (14,14);
insert into point_maping (code_id, root_id) values (14,2);
insert into point_maping (code_id, root_id) values (14,1);
XA END 'JABORATORIUMapotek';
XA PREPARE 'JABORATORIUMapotek';
XA COMMIT 'JABORATORIUMapotek';

-- Begin on 09/06/29 21:04:49 - apotek
XA START 'JABORATORIUMapotek';
insert into mst_code (code_name, parent_id, urut, level) values ('BEBAS',2,1,3);
insert into point_maping (code_id, root_id) values (15,15);
insert into point_maping (code_id, root_id) values (15,2);
insert into point_maping (code_id, root_id) values (15,1);
XA END 'JABORATORIUMapotek';
XA PREPARE 'JABORATORIUMapotek';
XA COMMIT 'JABORATORIUMapotek';

-- Begin on 09/06/29 21:04:56 - apotek
XA START 'JABORATORIUMapotek';
insert into mst_code (code_name, parent_id, urut, level) values ('BEBAS TERBATAS',2,1,3);
insert into point_maping (code_id, root_id) values (16,16);
insert into point_maping (code_id, root_id) values (16,2);
insert into point_maping (code_id, root_id) values (16,1);
XA END 'JABORATORIUMapotek';
XA PREPARE 'JABORATORIUMapotek';
XA COMMIT 'JABORATORIUMapotek';

-- Begin on 09/06/29 21:05:27 - apotek
XA START 'JABORATORIUMapotek';
insert into mst_code (code_name, parent_id, urut, level) values ('OBAT GIGI',2,1,3);
insert into point_maping (code_id, root_id) values (17,17);
insert into point_maping (code_id, root_id) values (17,2);
insert into point_maping (code_id, root_id) values (17,1);
XA END 'JABORATORIUMapotek';
XA PREPARE 'JABORATORIUMapotek';
XA COMMIT 'JABORATORIUMapotek';

-- Begin on 09/06/29 21:05:36 - apotek
XA START 'JABORATORIUMapotek';
insert into mst_code (code_name, parent_id, urut, level) values ('OBAT KERAS',2,1,3);
insert into point_maping (code_id, root_id) values (18,18);
insert into point_maping (code_id, root_id) values (18,2);
insert into point_maping (code_id, root_id) values (18,1);
XA END 'JABORATORIUMapotek';
XA PREPARE 'JABORATORIUMapotek';
XA COMMIT 'JABORATORIUMapotek';

-- Begin on 09/06/29 21:05:40 - apotek
XA START 'JABORATORIUMapotek';
insert into mst_code (code_name, parent_id, urut, level) values ('OBAT KB',2,1,3);
insert into point_maping (code_id, root_id) values (19,19);
insert into point_maping (code_id, root_id) values (19,2);
insert into point_maping (code_id, root_id) values (19,1);
XA END 'JABORATORIUMapotek';
XA PREPARE 'JABORATORIUMapotek';
XA COMMIT 'JABORATORIUMapotek';

-- Begin on 09/06/29 21:07:23 - apotek
XA START 'JABORATORIUMapotek';
insert into mst_code (code_name, parent_id, urut, level) values ('PERALATAN KEDOKTERAN',3,2,3);
insert into point_maping (code_id, root_id) values (20,20);
insert into point_maping (code_id, root_id) values (20,3);
insert into point_maping (code_id, root_id) values (20,1);
XA END 'JABORATORIUMapotek';
XA PREPARE 'JABORATORIUMapotek';
XA COMMIT 'JABORATORIUMapotek';

-- Begin on 09/06/29 21:07:45 - apotek
XA START 'JABORATORIUMapotek';
insert into mst_code (code_name, parent_id, urut, level) values ('PERLENGKAPAN BAYI',3,2,3);
insert into point_maping (code_id, root_id) values (21,21);
insert into point_maping (code_id, root_id) values (21,3);
insert into point_maping (code_id, root_id) values (21,1);
XA END 'JABORATORIUMapotek';
XA PREPARE 'JABORATORIUMapotek';
XA COMMIT 'JABORATORIUMapotek';

-- Begin on 09/06/29 21:08:24 - apotek
XA START 'JABORATORIUMapotek';
insert into mst_code (code_name, parent_id, urut, level) values ('ANMAAK',2,1,3);
insert into point_maping (code_id, root_id) values (22,22);
insert into point_maping (code_id, root_id) values (22,2);
insert into point_maping (code_id, root_id) values (22,1);
XA END 'JABORATORIUMapotek';
XA PREPARE 'JABORATORIUMapotek';
XA COMMIT 'JABORATORIUMapotek';

-- Begin on 09/06/29 21:08:44 - apotek
XA START 'JABORATORIUMapotek';
update mst_code set code_name = 'OBAT BEBAS', parent_id = 2, urut = 1 where code_id = 15;
XA END 'JABORATORIUMapotek';
XA PREPARE 'JABORATORIUMapotek';
XA COMMIT 'JABORATORIUMapotek';

-- Begin on 09/06/29 21:08:52 - apotek
XA START 'JABORATORIUMapotek';
update mst_code set code_name = 'OBAT BEBAS TERBATAS', parent_id = 2, urut = 1 where code_id = 16;
XA END 'JABORATORIUMapotek';
XA PREPARE 'JABORATORIUMapotek';
XA COMMIT 'JABORATORIUMapotek';

-- Begin on 09/06/29 21:09:50 - apotek
XA START 'JABORATORIUMapotek';
insert into mst_code (code_name, parent_id, urut, level) values ('PSIKOTROPIK',14,1,4);
insert into point_maping (code_id, root_id) values (23,23);
insert into point_maping (code_id, root_id) values (23,14);
insert into point_maping (code_id, root_id) values (23,2);
insert into point_maping (code_id, root_id) values (23,1);
XA END 'JABORATORIUMapotek';
XA PREPARE 'JABORATORIUMapotek';
XA COMMIT 'JABORATORIUMapotek';

-- Begin on 09/06/29 21:10:24 - apotek
XA START 'JABORATORIUMapotek';
insert into mst_code (code_name, parent_id, urut, level) values ('ANTI SERANGGA',1,0,2);
insert into point_maping (code_id, root_id) values (24,24);
insert into point_maping (code_id, root_id) values (24,1);
XA END 'JABORATORIUMapotek';
XA PREPARE 'JABORATORIUMapotek';
XA COMMIT 'JABORATORIUMapotek';

-- Begin on 09/06/29 21:11:59 - apotek
XA START 'JABORATORIUMapotek';
insert into mst_code (code_name, parent_id, urut, level) values ('DIAGNOSTIC TEST/LABORATORIUM',1,0,2);
insert into point_maping (code_id, root_id) values (25,25);
insert into point_maping (code_id, root_id) values (25,1);
XA END 'JABORATORIUMapotek';
XA PREPARE 'JABORATORIUMapotek';
XA COMMIT 'JABORATORIUMapotek';

-- Begin on 09/06/29 21:12:17 - apotek
XA START 'JABORATORIUMapotek';
insert into mst_code (code_name, parent_id, urut, level) values ('ENTHERAL / PARENTHERAL FOOD',1,0,2);
insert into point_maping (code_id, root_id) values (26,26);
insert into point_maping (code_id, root_id) values (26,1);
XA END 'JABORATORIUMapotek';
XA PREPARE 'JABORATORIUMapotek';
XA COMMIT 'JABORATORIUMapotek';

-- Begin on 09/06/29 21:12:34 - apotek
XA START 'JABORATORIUMapotek';
insert into mst_code (code_name, parent_id, urut, level) values ('INPRES PROGRAM',1,0,2);
insert into point_maping (code_id, root_id) values (27,27);
insert into point_maping (code_id, root_id) values (27,1);
XA END 'JABORATORIUMapotek';
XA PREPARE 'JABORATORIUMapotek';
XA COMMIT 'JABORATORIUMapotek';

-- Begin on 09/06/29 21:12:46 - apotek
XA START 'JABORATORIUMapotek';
insert into mst_code (code_name, parent_id, urut, level) values ('KESOS/PDPSE',1,0,2);
insert into point_maping (code_id, root_id) values (28,28);
insert into point_maping (code_id, root_id) values (28,1);
XA END 'JABORATORIUMapotek';
XA PREPARE 'JABORATORIUMapotek';
XA COMMIT 'JABORATORIUMapotek';

-- Begin on 09/06/29 21:13:07 - apotek
XA START 'JABORATORIUMapotek';
insert into mst_code (code_name, parent_id, urut, level) values ('PKD',1,0,2);
insert into point_maping (code_id, root_id) values (29,29);
insert into point_maping (code_id, root_id) values (29,1);
XA END 'JABORATORIUMapotek';
XA PREPARE 'JABORATORIUMapotek';
XA COMMIT 'JABORATORIUMapotek';

-- Begin on 09/06/29 21:13:17 - apotek
XA START 'JABORATORIUMapotek';
insert into mst_code (code_name, parent_id, urut, level) values ('X''RAY UNIT',1,0,2);
insert into point_maping (code_id, root_id) values (30,30);
insert into point_maping (code_id, root_id) values (30,1);
XA END 'JABORATORIUMapotek';
XA PREPARE 'JABORATORIUMapotek';
XA COMMIT 'JABORATORIUMapotek';

-- Begin on 09/06/29 21:14:22 - apotek
XA START 'JABORATORIUMapotek';
insert into mst_code (code_name, parent_id, urut, level) values ('AVL SPARE PART',1,0,2);
insert into point_maping (code_id, root_id) values (31,31);
insert into point_maping (code_id, root_id) values (31,1);
XA END 'JABORATORIUMapotek';
XA PREPARE 'JABORATORIUMapotek';
XA COMMIT 'JABORATORIUMapotek';

-- Begin on 09/06/29 21:14:32 - apotek
XA START 'JABORATORIUMapotek';
insert into mst_code (code_name, parent_id, urut, level) values ('AVL UNIT',1,0,2);
insert into point_maping (code_id, root_id) values (32,32);
insert into point_maping (code_id, root_id) values (32,1);
XA END 'JABORATORIUMapotek';
XA PREPARE 'JABORATORIUMapotek';
XA COMMIT 'JABORATORIUMapotek';

-- Begin on 09/06/29 21:18:04 - apotek
XA START 'JABORATORIUMapotek';
update mst_code set code_name = 'FITOFARMAKA', parent_id = 0, urut = 0 where code_id = 1;
XA END 'JABORATORIUMapotek';
XA PREPARE 'JABORATORIUMapotek';
XA COMMIT 'JABORATORIUMapotek';

-- Begin on 09/06/29 21:18:18 - apotek
XA START 'JABORATORIUMapotek';
update mst_code set code_name = 'JENIS ITEM', parent_id = 0, urut = 0 where code_id = 1;
XA END 'JABORATORIUMapotek';
XA PREPARE 'JABORATORIUMapotek';
XA COMMIT 'JABORATORIUMapotek';

-- Begin on 09/06/29 21:18:23 - apotek
XA START 'JABORATORIUMapotek';
insert into mst_code (code_name, parent_id, urut, level) values ('FITOFARMAKA',1,0,2);
insert into point_maping (code_id, root_id) values (33,33);
insert into point_maping (code_id, root_id) values (33,1);
XA END 'JABORATORIUMapotek';
XA PREPARE 'JABORATORIUMapotek';
XA COMMIT 'JABORATORIUMapotek';

-- Begin on 09/06/29 21:23:40 - apotek
XA START 'JABORATORIUMapotek';
insert into mst_code (code_name, parent_id, urut, level) values ('MAKANAN BAYI',1,0,2);
insert into point_maping (code_id, root_id) values (34,34);
insert into point_maping (code_id, root_id) values (34,1);
XA END 'JABORATORIUMapotek';
XA PREPARE 'JABORATORIUMapotek';
XA COMMIT 'JABORATORIUMapotek';

-- Begin on 09/07/01 14:57:46 - apotek
XA START 'JABORATORIUMapotek';
insert into mst_master (mst_tipe, mst_code, mst_name)values (1,'PCS','PCS');
XA END 'JABORATORIUMapotek';
XA PREPARE 'JABORATORIUMapotek';
XA COMMIT 'JABORATORIUMapotek';

-- Begin on 09/07/01 15:04:35 - apotek
XA START 'JABORATORIUMapotek';
insert into mst_item (specification, item_code, barcode, struk_name, merk, avg_price, vendor_id, produsen_id, kemasan_id, bkp, konsinyasi, item_name, dosis, kategori, expire_date) values (2,'99','99','BODREX','',8000,NULL,NULL,NULL,1,0,'BODREX',1,3,cast('2009-06-27 'as date));
insert into mst_item_conversion (item_id, unit_id, conversion, cost_price, purchase_price, sales_price, sales_price2, sales_price3, item_tax, item_discount, disc_tipe, net_price)values (1,8,1,10,5000,5500,5000,0,0,0,0,5000);
XA END 'JABORATORIUMapotek';
XA PREPARE 'JABORATORIUMapotek';
XA COMMIT 'JABORATORIUMapotek';

-- Begin on 09/07/01 15:06:44 - cashier
XA START 'JABORATORIUMcashier';
insert into setup_racik (paket_id, qty, harga, harga_beli, harga_rata, embalase) values (1,20,38500,35000,56000,10000);
insert into setup_racik_detail (racik_id, item_id, harga, hrg_rata, hrg_beli, conv_id, dosis_obat, qty, total) values(2,1,5500,8000,5000,1,30,7,38500);
XA END 'JABORATORIUMcashier';
XA PREPARE 'JABORATORIUMcashier';
XA COMMIT 'JABORATORIUMcashier';

-- Begin on 09/07/01 15:07:35 - cashier
XA START 'JABORATORIUMcashier';
insert into trs_sales_mst (trans_num, trans_type, trans_date, cashier_id, gudang_id, pasien_id, subtotal, profit, disc_mst, disc_val_mst, disc_detail, tax, total, embalase, real_amount, sisa, user_id, shift_id, cash, cara_bayar, card_id, bank, dokter_id, no_resep) values (get_new_sales_num('RJ/SS/200907'), 13,cast('2009-07-01 'as date),5,9,NULL,49500,-22500,0,0,0,0,59500,10000,59500,0,'adm',2,59500,1,'0214552','BCA',NULL,'');
XA END 'JABORATORIUMcashier';
XA PREPARE 'JABORATORIUMcashier';
XA ROLLBACK 'JABORATORIUMcashier';
update system_config set conf_value = '-1'where conf_id = 1;
update system_config set conf_value = '-1'where conf_id = 2;
update system_config set conf_value = '**Harga Sudah termasuk PPn**'where conf_id = 12;
update system_config set conf_value = '**Terimakasih Atas Kunjungnnya**'where conf_id = 13;
delete from setup_racik_detail where detail_id = 0;

-- Begin on 09/07/01 15:32:53 - cashier
XA START 'JABORATORIUMcashier';
insert into setup_racik (paket_id, qty, harga, harga_beli, harga_rata, embalase) values (1,20,38500,35000,56000,1000);
insert into setup_racik_detail (racik_id, item_id, harga, hrg_rata, hrg_beli, conv_id, dosis_obat, qty, total) values(1,1,5500,8000,5000,1,30,7,38500);
XA END 'JABORATORIUMcashier';
XA PREPARE 'JABORATORIUMcashier';
XA COMMIT 'JABORATORIUMcashier';

-- Begin on 09/07/01 15:34:06 - cashier
XA START 'JABORATORIUMcashier';
insert into trs_sales_mst (trans_num, trans_type, trans_date, cashier_id, gudang_id, pasien_id, subtotal, profit, disc_mst, disc_val_mst, disc_detail, tax, total, embalase, real_amount, sisa, user_id, shift_id, cash, cara_bayar, card_id, bank, dokter_id, no_resep) values (get_new_sales_num('RJ/SS/200907'), 13,cast('2009-07-01 'as date),5,1,14740,44000,-20000,0,0,0,0,45000,1000,45000,0,'adm',2,45000,1,'12455','BAC',2148,'85622');
insert into trs_sales_detail (sales_id, item_id, conv_id, quantity, price, disc, disc_val, amount, amount_profit, price_purchase, paket_id, points, hrg_beli, conversion)values ((select sales_id from trs_sales_mst y where y.trans_num = (select max(x.trans_num) from trs_sales_mst x where x.cashier_id = 5) and y.cashier_id = 5), NULL,NULL,1,38500,0,0,38500,-17500,56000,1,0,35000,1);
update mst_item set current_stock = current_stock + -7 where item_id = 1;
call save_to_item_balance(1, 1, cast('2009-07-01 'as date), 7, 'C');
insert into trs_sales_paket (sales_id, paket_id, item_id, conv_id, quantity, price, hrg_dasar, hrg_beli, dosis, amount_profit, disc, disc_val, gudang_id) values((select sales_id from trs_sales_mst y where y.trans_num = (select max(x.trans_num) from trs_sales_mst x where x.cashier_id = 5) and y.cashier_id = 5), 1,1,1,7,5500,8000,5000,0,-56000,0,0,1);
delete from setup_racik where racik_id = 1;
insert into trs_sales_detail (sales_id, item_id, conv_id, quantity, price, disc, disc_val, amount, amount_profit, price_purchase, paket_id, points, hrg_beli, conversion)values ((select sales_id from trs_sales_mst y where y.trans_num = (select max(x.trans_num) from trs_sales_mst x where x.cashier_id = 5) and y.cashier_id = 5), 1,1,1,5500,0,0,5500,-2500,8000,NULL,0,5000,1);
update mst_item set current_stock = current_stock + -1 where item_id = 1;
call save_to_item_balance(1, 1, cast('2009-07-01 'as date), 1, 'C');
delete from setup_racik where racik_id = 0;
call save_to_cashier_balance(5, 1, 2, 44000, 0, 0, 1000, 'D', 'adm');
XA END 'JABORATORIUMcashier';
XA PREPARE 'JABORATORIUMcashier';
XA COMMIT 'JABORATORIUMcashier';
update mst_pasien set card_id= '12455' where pasien_id= 14740;

-- Begin on 09/07/08 18:16:13 - apotek
XA START 'JABORATORIUMapotek';
insert into mst_item (specification, item_code, barcode, struk_name, merk, avg_price, vendor_id, produsen_id, kemasan_id, bkp, konsinyasi, item_name, dosis, kategori, expire_date) values (2,'77','77','PARAMEX','',4400,NULL,NULL,NULL,1,0,'PARAMEX',10,NULL,cast('2009-07-08 'as date));
insert into mst_item_conversion (item_id, unit_id, conversion, cost_price, purchase_price, sales_price, sales_price2, sales_price3, item_tax, item_discount, disc_tipe, net_price)values (2,8,1,13.64,4000,5000,4400,0,10,0,0,4400);
XA END 'JABORATORIUMapotek';
XA PREPARE 'JABORATORIUMapotek';
XA COMMIT 'JABORATORIUMapotek';

-- Begin on 09/07/08 18:16:40 - cashier
XA START 'JABORATORIUMcashier';
insert into inv_cashier_balance (cashier_id, shift_id, user_id, balance_date, so_awal) values (5, 2, 'adm', curdate(), 500000);
XA END 'JABORATORIUMcashier';
XA PREPARE 'JABORATORIUMcashier';
XA COMMIT 'JABORATORIUMcashier';

-- Begin on 09/07/08 18:17:42 - cashier
XA START 'JABORATORIUMcashier';
insert into setup_racik (paket_id, qty, harga, harga_beli, harga_rata, embalase) values (1,10,34965,29970,41292,10000);
insert into setup_racik_detail (racik_id, item_id, harga, hrg_rata, hrg_beli, conv_id, dosis_obat, qty, total) values(1,1,5500,8000,5000,1,15,3.33,18315);
insert into setup_racik_detail (racik_id, item_id, harga, hrg_rata, hrg_beli, conv_id, dosis_obat, qty, total) values(1,2,5000,4400,4000,2,15,3.33,16650);
XA END 'JABORATORIUMcashier';
XA PREPARE 'JABORATORIUMcashier';
XA COMMIT 'JABORATORIUMcashier';

-- Begin on 09/07/08 18:17:57 - cashier
XA START 'JABORATORIUMcashier';
insert into trs_sales_mst (trans_num, trans_type, trans_date, cashier_id, gudang_id, pasien_id, subtotal, profit, disc_mst, disc_val_mst, disc_detail, tax, total, embalase, real_amount, sisa, user_id, shift_id, cash, cara_bayar, card_id, bank, dokter_id, no_resep) values (get_new_sales_num('RJ/SS/200907'), 13,cast('2009-07-08 'as date),5,1,NULL,40465,-8827,0,0,0,0,50465,10000,50465,0,'adm',2,60000,0,'','',NULL,'');
insert into trs_sales_detail (sales_id, item_id, conv_id, quantity, price, disc, disc_val, amount, amount_profit, price_purchase, paket_id, points, hrg_beli, conversion)values ((select sales_id from trs_sales_mst y where y.trans_num = (select max(x.trans_num) from trs_sales_mst x where x.cashier_id = 5) and y.cashier_id = 5), 1,1,1,5500,0,0,5500,-2500,8000,NULL,0,5000,1);
update mst_item set current_stock = current_stock + -1 where item_id = 1;
call save_to_item_balance(1, 1, cast('2009-07-08 'as date), 1, 'C');
delete from setup_racik where racik_id = 0;
insert into trs_sales_detail (sales_id, item_id, conv_id, quantity, price, disc, disc_val, amount, amount_profit, price_purchase, paket_id, points, hrg_beli, conversion)values ((select sales_id from trs_sales_mst y where y.trans_num = (select max(x.trans_num) from trs_sales_mst x where x.cashier_id = 5) and y.cashier_id = 5), NULL,NULL,1,34965,0,0,34965,-6327,41292,1,0,29970,1);
update mst_item set current_stock = current_stock + -3.33 where item_id = 1;
call save_to_item_balance(1, 1, cast('2009-07-08 'as date), 3.33, 'C');
insert into trs_sales_paket (sales_id, paket_id, item_id, conv_id, quantity, price, hrg_dasar, hrg_beli, dosis, amount_profit, disc, disc_val, gudang_id) values((select sales_id from trs_sales_mst y where y.trans_num = (select max(x.trans_num) from trs_sales_mst x where x.cashier_id = 5) and y.cashier_id = 5), 1,1,1,3.33,5500,8000,5000,0,-26640,0,0,1);
update mst_item set current_stock = current_stock + -3.33 where item_id = 2;
call save_to_item_balance(1, 2, cast('2009-07-08 'as date), 3.33, 'C');
insert into trs_sales_paket (sales_id, paket_id, item_id, conv_id, quantity, price, hrg_dasar, hrg_beli, dosis, amount_profit, disc, disc_val, gudang_id) values((select sales_id from trs_sales_mst y where y.trans_num = (select max(x.trans_num) from trs_sales_mst x where x.cashier_id = 5) and y.cashier_id = 5), 1,2,2,3.33,5000,4400,4000,0,-14652,0,0,1);
delete from setup_racik where racik_id = 1;
call save_to_cashier_balance(5, 0, 2, 40465, 0, 0, 10000, 'D', 'adm');
XA END 'JABORATORIUMcashier';
XA PREPARE 'JABORATORIUMcashier';
XA COMMIT 'JABORATORIUMcashier';
update mst_pasien set card_id= '' where pasien_id= 0;

-- Begin on 09/07/08 18:23:11 - apotek
XA START 'JABORATORIUMapotek';
insert into trs_shipment_mst (trans_num, tipe, trans_date, notes, gudang_asal, gudang_tujuan, user_id) values ('RJ/SA/20090700001',2,cast('2009-07-08 'as date),'',1,NULL,'adm');
insert into trs_shipment_detail (ship_id, item_id, conv_id, quantity, price_sales, price_cost, price_purchase, hrg_beli, conversion)values (last_insert_id(), 1,1,9.33,0,5000,8000,5000,1);
XA END 'JABORATORIUMapotek';
XA PREPARE 'JABORATORIUMapotek';
XA ROLLBACK 'JABORATORIUMapotek';

-- Begin on 09/07/08 18:24:08 - apotek
XA START 'JABORATORIUMapotek';
insert into trs_shipment_mst (trans_num, tipe, trans_date, notes, gudang_asal, gudang_tujuan, user_id) values ('RJ/SA/20090700001',2,cast('2009-07-08 'as date),'',1,NULL,'adm');
insert into trs_shipment_detail (ship_id, item_id, conv_id, quantity, price_sales, price_cost, price_purchase, hrg_beli, conversion)values (last_insert_id(), 1,1,9.33,0,5000,8000,5000,1);
update mst_item set avg_price = 5000 where item_id = 1;
update mst_item_conversion set purchase_price = 8000 where conv_id = 1;
update mst_item set current_stock = current_stock + 9.33 where item_id = 1;
call save_to_item_balance(1, 1, cast('2009-07-08 'as date), 9.33, 'D');
insert into trs_shipment_detail (ship_id, item_id, conv_id, quantity, price_sales, price_cost, price_purchase, hrg_beli, conversion)values (last_insert_id(), 2,2,8.33,0,4000,4400,4000,1);
update mst_item set avg_price = 4000 where item_id = 2;
update mst_item_conversion set purchase_price = 4400 where conv_id = 2;
update mst_item set current_stock = current_stock + 8.33 where item_id = 2;
call save_to_item_balance(1, 2, cast('2009-07-08 'as date), 8.33, 'D');
XA END 'JABORATORIUMapotek';
XA PREPARE 'JABORATORIUMapotek';
XA COMMIT 'JABORATORIUMapotek';

-- Begin on 09/07/10 09:25:28 - apotek
XA START 'JABORATORIUMapotek';
INSERT INTO System_Users (User_Id, User_Name, Passwd, Access_Level)  VALUES ('dudu','dudu','', 1);
INSERT INTO System_Access (User_Id,Menu_Id,Access_List,Outlook_Panel,Outlook_Button,Usage_Count, can_acces) VALUES ('dudu',101,0,'','',0,0);
INSERT INTO System_Access (User_Id,Menu_Id,Access_List,Outlook_Panel,Outlook_Button,Usage_Count, can_acces) VALUES ('dudu',102,0,'','',0,0);
INSERT INTO System_Access (User_Id,Menu_Id,Access_List,Outlook_Panel,Outlook_Button,Usage_Count, can_acces) VALUES ('dudu',201,0,'','',0,0);
INSERT INTO System_Access (User_Id,Menu_Id,Access_List,Outlook_Panel,Outlook_Button,Usage_Count, can_acces) VALUES ('dudu',202,0,'','',0,-1);
INSERT INTO System_Access (User_Id,Menu_Id,Access_List,Outlook_Panel,Outlook_Button,Usage_Count, can_acces) VALUES ('dudu',203,0,'','',0,0);
INSERT INTO System_Access (User_Id,Menu_Id,Access_List,Outlook_Panel,Outlook_Button,Usage_Count, can_acces) VALUES ('dudu',204,0,'','',0,0);
INSERT INTO System_Access (User_Id,Menu_Id,Access_List,Outlook_Panel,Outlook_Button,Usage_Count, can_acces) VALUES ('dudu',205,0,'','',0,0);
INSERT INTO System_Access (User_Id,Menu_Id,Access_List,Outlook_Panel,Outlook_Button,Usage_Count, can_acces) VALUES ('dudu',206,0,'','',0,0);
INSERT INTO System_Access (User_Id,Menu_Id,Access_List,Outlook_Panel,Outlook_Button,Usage_Count, can_acces) VALUES ('dudu',207,0,'','',0,0);
INSERT INTO System_Access (User_Id,Menu_Id,Access_List,Outlook_Panel,Outlook_Button,Usage_Count, can_acces) VALUES ('dudu',210,0,'','',0,0);
INSERT INTO System_Access (User_Id,Menu_Id,Access_List,Outlook_Panel,Outlook_Button,Usage_Count, can_acces) VALUES ('dudu',211,0,'','',0,0);
INSERT INTO System_Access (User_Id,Menu_Id,Access_List,Outlook_Panel,Outlook_Button,Usage_Count, can_acces) VALUES ('dudu',212,0,'','',0,0);
INSERT INTO System_Access (User_Id,Menu_Id,Access_List,Outlook_Panel,Outlook_Button,Usage_Count, can_acces) VALUES ('dudu',213,0,'','',0,0);
INSERT INTO System_Access (User_Id,Menu_Id,Access_List,Outlook_Panel,Outlook_Button,Usage_Count, can_acces) VALUES ('dudu',220,0,'','',0,0);
INSERT INTO System_Access (User_Id,Menu_Id,Access_List,Outlook_Panel,Outlook_Button,Usage_Count, can_acces) VALUES ('dudu',221,0,'','',0,0);
INSERT INTO System_Access (User_Id,Menu_Id,Access_List,Outlook_Panel,Outlook_Button,Usage_Count, can_acces) VALUES ('dudu',222,0,'','',0,0);
INSERT INTO System_Access (User_Id,Menu_Id,Access_List,Outlook_Panel,Outlook_Button,Usage_Count, can_acces) VALUES ('dudu',223,0,'','',0,0);
INSERT INTO System_Access (User_Id,Menu_Id,Access_List,Outlook_Panel,Outlook_Button,Usage_Count, can_acces) VALUES ('dudu',300,0,'','',0,0);
INSERT INTO System_Access (User_Id,Menu_Id,Access_List,Outlook_Panel,Outlook_Button,Usage_Count, can_acces) VALUES ('dudu',301,0,'','',0,0);
INSERT INTO System_Access (User_Id,Menu_Id,Access_List,Outlook_Panel,Outlook_Button,Usage_Count, can_acces) VALUES ('dudu',302,0,'','',0,0);
INSERT INTO System_Access (User_Id,Menu_Id,Access_List,Outlook_Panel,Outlook_Button,Usage_Count, can_acces) VALUES ('dudu',321,0,'','',0,0);
INSERT INTO System_Access (User_Id,Menu_Id,Access_List,Outlook_Panel,Outlook_Button,Usage_Count, can_acces) VALUES ('dudu',322,0,'','',0,0);
INSERT INTO System_Access (User_Id,Menu_Id,Access_List,Outlook_Panel,Outlook_Button,Usage_Count, can_acces) VALUES ('dudu',323,0,'','',0,0);
INSERT INTO System_Access (User_Id,Menu_Id,Access_List,Outlook_Panel,Outlook_Button,Usage_Count, can_acces) VALUES ('dudu',330,0,'','',0,0);
INSERT INTO System_Access (User_Id,Menu_Id,Access_List,Outlook_Panel,Outlook_Button,Usage_Count, can_acces) VALUES ('dudu',331,0,'','',0,0);
INSERT INTO System_Access (User_Id,Menu_Id,Access_List,Outlook_Panel,Outlook_Button,Usage_Count, can_acces) VALUES ('dudu',400,0,'','',0,0);
INSERT INTO System_Access (User_Id,Menu_Id,Access_List,Outlook_Panel,Outlook_Button,Usage_Count, can_acces) VALUES ('dudu',401,0,'','',0,0);
INSERT INTO System_Access (User_Id,Menu_Id,Access_List,Outlook_Panel,Outlook_Button,Usage_Count, can_acces) VALUES ('dudu',501,0,'','',0,0);
INSERT INTO System_Access (User_Id,Menu_Id,Access_List,Outlook_Panel,Outlook_Button,Usage_Count, can_acces) VALUES ('dudu',502,0,'','',0,0);
INSERT INTO System_Access (User_Id,Menu_Id,Access_List,Outlook_Panel,Outlook_Button,Usage_Count, can_acces) VALUES ('dudu',503,0,'','',0,0);
INSERT INTO System_Access (User_Id,Menu_Id,Access_List,Outlook_Panel,Outlook_Button,Usage_Count, can_acces) VALUES ('dudu',504,0,'','',0,0);
INSERT INTO System_Access (User_Id,Menu_Id,Access_List,Outlook_Panel,Outlook_Button,Usage_Count, can_acces) VALUES ('dudu',510,0,'','',0,0);
INSERT INTO System_Access (User_Id,Menu_Id,Access_List,Outlook_Panel,Outlook_Button,Usage_Count, can_acces) VALUES ('dudu',520,0,'','',0,0);
INSERT INTO System_Access (User_Id,Menu_Id,Access_List,Outlook_Panel,Outlook_Button,Usage_Count, can_acces) VALUES ('dudu',530,0,'','',0,0);
INSERT INTO System_Access (User_Id,Menu_Id,Access_List,Outlook_Panel,Outlook_Button,Usage_Count, can_acces) VALUES ('dudu',1001,0,'','',0,0);
INSERT INTO System_Access (User_Id,Menu_Id,Access_List,Outlook_Panel,Outlook_Button,Usage_Count, can_acces) VALUES ('dudu',1002,0,'','',0,0);
XA END 'JABORATORIUMapotek';
XA PREPARE 'JABORATORIUMapotek';
XA COMMIT 'JABORATORIUMapotek';
update system_config set conf_value = '-1'where conf_id = 1;
update system_config set conf_value = '-1'where conf_id = 2;
update system_config set conf_value = '**Harga Sudah termasuk PPn**'where conf_id = 12;
update system_config set conf_value = '**Terimakasih Atas Kunjungnnya**'where conf_id = 13;
update system_config set conf_value = '-1'where conf_id = 1;
update system_config set conf_value = '-1'where conf_id = 2;
update system_config set conf_value = '**Harga Sudah termasuk PPn**'where conf_id = 12;
update system_config set conf_value = '**Terimakasih Atas Kunjungnnya**'where conf_id = 13;
update system_config set conf_value = '-1'where conf_id = 1;
update system_config set conf_value = '-1'where conf_id = 2;
update system_config set conf_value = '**Harga Sudah termasuk PPn**'where conf_id = 12;
update system_config set conf_value = '**Terimakasih Atas Kunjungnnya**'where conf_id = 13;

-- Begin on 09/07/10 14:01:41 - cashier
XA START 'JABORATORIUMcashier';
insert into trs_sales_mst (trans_num, trans_type, trans_date, cashier_id, gudang_id, pasien_id, subtotal, profit, disc_mst, disc_val_mst, disc_detail, tax, total, embalase, real_amount, sisa, user_id, shift_id, cash, cara_bayar, card_id, bank, dokter_id, no_resep) values (get_new_sales_num('RJ/SS/200907'), 13,cast('2009-07-10 'as date),5,1,NULL,0,0,0,0,0,0,0,0,0,0,'adm',2,0,0,'','',NULL,'');
insert into trs_sales_detail (sales_id, item_id, conv_id, quantity, price, disc, disc_val, amount, amount_profit, price_purchase, paket_id, points, hrg_beli, conversion)values ((select sales_id from trs_sales_mst y where y.trans_num = (select max(x.trans_num) from trs_sales_mst x where x.cashier_id = 5) and y.cashier_id = 5), 1,1,1,5500,0,0,5500,0,5000,NULL,0,8000,1);
update mst_item set current_stock = current_stock + -1 where item_id = 1;
call save_to_item_balance(1, 1, cast('2009-07-10 'as date), 1, 'C');
delete from setup_racik where racik_id = 0;
call save_to_cashier_balance(5, 0, 2, 5500, 0, 0, 0, 'D', 'adm');
XA END 'JABORATORIUMcashier';
XA PREPARE 'JABORATORIUMcashier';
XA COMMIT 'JABORATORIUMcashier';
update mst_pasien set card_id= '' where pasien_id= 0;
update system_config set conf_value = '-1'where conf_id = 1;
update system_config set conf_value = '-1'where conf_id = 2;
update system_config set conf_value = '**Harga Sudah termasuk PPn**'where conf_id = 12;
update system_config set conf_value = '**Terimakasih Atas Kunjungnnya**'where conf_id = 13;

-- Begin on 09/07/10 17:53:08 - cashier
XA START 'JABORATORIUMcashier';
insert into trs_sales_mst (trans_num, trans_type, trans_date, cashier_id, gudang_id, pasien_id, subtotal, profit, disc_mst, disc_val_mst, disc_detail, tax, total, embalase, real_amount, sisa, user_id, shift_id, cash, cara_bayar, card_id, bank, dokter_id, no_resep) values (get_new_sales_num('RJ/SS/200907'), 13,cast('2009-07-10 'as date),5,1,NULL,5500,500,0,0,0,0,5500,0,5500,0,'adm',2,6000,0,'','',NULL,'');
insert into trs_sales_detail (sales_id, item_id, conv_id, quantity, price, disc, disc_val, amount, amount_profit, price_purchase, paket_id, points, hrg_beli, conversion)values ((select sales_id from trs_sales_mst y where y.trans_num = (select max(x.trans_num) from trs_sales_mst x where x.cashier_id = 5) and y.cashier_id = 5), 1,1,1,5500,0,0,5500,500,5000,NULL,0,8000,1);
update mst_item set current_stock = current_stock + -1 where item_id = 1;
call save_to_item_balance(1, 1, cast('2009-07-10 'as date), 1, 'C');
delete from setup_racik where racik_id = 0;
call save_to_cashier_balance(5, 0, 2, 5500, 0, 0, 0, 'D', 'adm');
XA END 'JABORATORIUMcashier';
XA PREPARE 'JABORATORIUMcashier';
XA COMMIT 'JABORATORIUMcashier';
update mst_pasien set card_id= '' where pasien_id= 0;
