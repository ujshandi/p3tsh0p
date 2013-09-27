
-- Begin on 09/08/12 09:58:58 - apotek
XA START 'INVISI03apotek';
insert into mst_rak (kode, nama, parent_id, level) values ('R.006','Etalase I',3,3);
insert into mst_rak_maping (rak_id, root_id) values (7,7);
insert into mst_rak_maping (rak_id, root_id) values (7,3);
insert into mst_rak_maping (rak_id, root_id) values (7,1);
XA END 'INVISI03apotek';
XA PREPARE 'INVISI03apotek';
XA COMMIT 'INVISI03apotek';

-- Begin on 09/08/12 10:00:44 - apotek
XA START 'INVISI03apotek';
insert into mst_rak (kode, nama, parent_id, level) values ('R.007','Box 1',7,4);
insert into mst_rak_maping (rak_id, root_id) values (8,8);
insert into mst_rak_maping (rak_id, root_id) values (8,7);
insert into mst_rak_maping (rak_id, root_id) values (8,3);
insert into mst_rak_maping (rak_id, root_id) values (8,1);
XA END 'INVISI03apotek';
XA PREPARE 'INVISI03apotek';
XA COMMIT 'INVISI03apotek';

-- Begin on 09/08/12 14:47:12 - apotek
XA START 'INVISI03apotek';
insert into trs_shipment_mst (trans_num, tipe, trans_date, notes, gudang_asal, gudang_tujuan, user_id) values ('SA/20090800001',2,cast('2009-08-12 'as date),'',1,NULL,'adm');
insert into trs_shipment_detail (ship_id, item_id, conv_id, quantity, price_sales, price_cost, price_purchase, hrg_beli, conversion)values (last_insert_id(), 559,2231,253,0,5000,100000,5000,1);
update mst_item set avg_price = 5000 where item_id = 2231;
update mst_item_conversion set purchase_price = 100000 where conv_id = 559;
update mst_item set current_stock = current_stock + 253 where item_id = 559;
call save_to_item_balance(1, 559, cast('2009-08-12 'as date), 253, 'D');
XA END 'INVISI03apotek';
XA PREPARE 'INVISI03apotek';
XA COMMIT 'INVISI03apotek';

-- Begin on 09/08/14 11:25:56 - cashier
XA START 'INVISI03cashier';
insert into setup_racik (paket_id, qty, harga, harga_beli, harga_rata, embalase) values (1,20,500000,0,0,1000);
insert into setup_racik_detail (racik_id, item_id, harga, hrg_rata, hrg_beli, conv_id, dosis_obat, qty, total) values(1,263,5000,0,0,1935,100,100,500000);
XA END 'INVISI03cashier';
XA PREPARE 'INVISI03cashier';
XA COMMIT 'INVISI03cashier';
delete from setup_racik where racik_id = 1;

-- Begin on 09/08/19 09:35:57 - cashier
XA START 'INVISI03cashier';
insert into mst_dokter (kode, nama, alamat, spesialis, item_id, contact) values ('G.001','gfsdg','fsgdf',558,'sfdg','sfdg');
XA END 'INVISI03cashier';
XA PREPARE 'INVISI03cashier';
XA ROLLBACK 'INVISI03cashier';

-- Begin on 09/08/19 09:36:02 - cashier
XA START 'INVISI03cashier';
insert into mst_dokter (kode, nama, alamat, spesialis, item_id, contact) values ('G.001','gfsdg','fsgdf',558,'sfdg','sfdg');
XA END 'INVISI03cashier';
XA PREPARE 'INVISI03cashier';
XA ROLLBACK 'INVISI03cashier';

-- Begin on 09/08/19 09:36:05 - cashier
XA START 'INVISI03cashier';
insert into mst_dokter (kode, nama, alamat, spesialis, item_id, contact) values ('G.001','gfsdg','fsgdf',558,'sfdg','sfdg');
XA END 'INVISI03cashier';
XA PREPARE 'INVISI03cashier';
XA ROLLBACK 'INVISI03cashier';

-- Begin on 09/08/19 09:38:20 - cashier
XA START 'INVISI03cashier';
insert into mst_pasien (kode, nama, alamat, phone, kota, sex, tgl_lahir, card_id) values ('F00000001','fdsaf','adf','adfs','adsf',0,cast('2009-08-19 'as date),'adsf');
XA END 'INVISI03cashier';
XA PREPARE 'INVISI03cashier';
XA COMMIT 'INVISI03cashier';

-- Begin on 09/08/19 09:49:21 - cashier
XA START 'INVISI03cashier';
insert into setup_racik (paket_id, qty, harga, harga_beli, harga_rata, embalase) values (1,12,0,0,0,1000);
insert into setup_racik_detail (racik_id, item_id, harga, hrg_rata, hrg_beli, conv_id, dosis_obat, qty, total) values(1,263,0,0,0,1935,3,10,0);
XA END 'INVISI03cashier';
XA PREPARE 'INVISI03cashier';
XA COMMIT 'INVISI03cashier';
delete from setup_racik where racik_id = 1;

-- Begin on 09/09/10 11:10:24 - cashier
XA START 'INVISI03cashier';
insert into trs_sales_mst (trans_num, trans_type, trans_date, cashier_id, gudang_id, pasien_id, subtotal, profit, disc_mst, disc_val_mst, disc_detail, tax, total, embalase, real_amount, sisa, user_id, shift_id, cash, cara_bayar, card_id, bank, dokter_id, no_resep) values (get_new_sales_num('O200909'), 13,cast('2009-09-10 'as date),5,1,NULL,12000,3000,0,0,0,0,12000,0,12000,0,'adm',2,50000,0,'','',NULL,'');
insert into trs_sales_detail (sales_id, item_id, conv_id, quantity, price, disc, disc_val, amount, amount_profit, price_purchase, paket_id, points, hrg_beli, conversion)values ((select sales_id from trs_sales_mst y where y.trans_num = (select max(x.trans_num) from trs_sales_mst x where x.cashier_id = 5) and y.cashier_id = 5), 561,2233,4,3000,0,0,12000,3000,2250,NULL,0,2250,1);
update mst_item set current_stock = current_stock + -4 where item_id = 561;
call save_to_item_balance(1, 561, cast('2009-09-10 'as date), 4, 'C');
delete from setup_racik where racik_id = 0;
call save_to_cashier_balance(5, 0, 2, 12000, 0, 0, 0, 'D', 'adm');
XA END 'INVISI03cashier';
XA PREPARE 'INVISI03cashier';
XA COMMIT 'INVISI03cashier';
update mst_pasien set card_id= '' where pasien_id= 0;

-- Begin on 09/09/10 11:12:19 - cashier
XA START 'INVISI03cashier';
XA END 'INVISI03cashier';
XA PREPARE 'INVISI03cashier';
XA COMMIT 'INVISI03cashier';

-- Begin on 09/09/10 21:08:28 - cashier
XA START 'INVISI03cashier';
insert into trs_sales_mst (trans_num, trans_type, trans_date, cashier_id, gudang_id, pasien_id, subtotal, profit, disc_mst, disc_val_mst, disc_detail, tax, total, embalase, real_amount, sisa, user_id, shift_id, cash, cara_bayar, card_id, bank, dokter_id, no_resep) values (get_new_sales_num('O200909'), 13,cast('2009-09-10 'as date),5,1,NULL,400000,0,0,0,0,0,400000,0,400000,0,'adm',2,400000,0,'','',NULL,'');
insert into trs_sales_detail (sales_id, item_id, conv_id, quantity, price, disc, disc_val, amount, amount_profit, price_purchase, paket_id, points, hrg_beli, conversion)values ((select sales_id from trs_sales_mst y where y.trans_num = (select max(x.trans_num) from trs_sales_mst x where x.cashier_id = 5) and y.cashier_id = 5), 559,2231,4,100000,0,0,400000,0,100000,NULL,0,100000,1);
update mst_item set current_stock = current_stock + -4 where item_id = 559;
call save_to_item_balance(1, 559, cast('2009-09-10 'as date), 4, 'C');
delete from setup_racik where racik_id = 0;
call save_to_cashier_balance(5, 0, 2, 400000, 0, 0, 0, 'D', 'adm');
XA END 'INVISI03cashier';
XA PREPARE 'INVISI03cashier';
XA COMMIT 'INVISI03cashier';
update mst_pasien set card_id= '' where pasien_id= 0;
update system_config set conf_value = '-1'where conf_id = 1;
update system_config set conf_value = '-1'where conf_id = 2;
update system_config set conf_value = 'Harga Sudah Termasuk PPN'where conf_id = 12;
update system_config set conf_value = 'Terimakasih Atas Kunjungn Anda'where conf_id = 13;

-- Begin on 09/09/10 21:10:49 - cashier
XA START 'INVISI03cashier';
insert into trs_sales_mst (trans_num, trans_type, trans_date, cashier_id, gudang_id, pasien_id, subtotal, profit, disc_mst, disc_val_mst, disc_detail, tax, total, embalase, real_amount, sisa, user_id, shift_id, cash, cara_bayar, card_id, bank, dokter_id, no_resep) values (get_new_sales_num('O200909'), 13,cast('2009-09-10 'as date),5,1,NULL,6000,1500,0,0,0,0,6000,0,6000,0,'adm',2,6000,0,'','',NULL,'');
insert into trs_sales_detail (sales_id, item_id, conv_id, quantity, price, disc, disc_val, amount, amount_profit, price_purchase, paket_id, points, hrg_beli, conversion)values ((select sales_id from trs_sales_mst y where y.trans_num = (select max(x.trans_num) from trs_sales_mst x where x.cashier_id = 5) and y.cashier_id = 5), 561,2233,2,3000,0,0,6000,1500,2250,NULL,0,2250,1);
update mst_item set current_stock = current_stock + -2 where item_id = 561;
call save_to_item_balance(1, 561, cast('2009-09-10 'as date), 2, 'C');
delete from setup_racik where racik_id = 0;
call save_to_cashier_balance(5, 0, 2, 6000, 0, 0, 0, 'D', 'adm');
XA END 'INVISI03cashier';
XA PREPARE 'INVISI03cashier';
XA COMMIT 'INVISI03cashier';
update mst_pasien set card_id= '' where pasien_id= 0;
delete from setup_racik where racik_id = 0;
update system_config set conf_value = '-1'where conf_id = 1;
update system_config set conf_value = '-1'where conf_id = 2;
update system_config set conf_value = 'Harga Sudah Termasuk PPN'where conf_id = 12;
update system_config set conf_value = 'Terimakasih Atas Kunjungn Anda'where conf_id = 13;

-- Begin on 09/09/10 21:13:14 - cashier
XA START 'INVISI03cashier';
insert into trs_sales_mst (trans_num, trans_type, trans_date, cashier_id, gudang_id, pasien_id, subtotal, profit, disc_mst, disc_val_mst, disc_detail, tax, total, embalase, real_amount, sisa, user_id, shift_id, cash, cara_bayar, card_id, bank, dokter_id, no_resep) values (get_new_sales_num('O200909'), 13,cast('2009-09-10 'as date),5,1,NULL,160000,0,0,0,0,0,160000,0,160000,0,'adm',2,200000,0,'','',NULL,'');
insert into trs_sales_detail (sales_id, item_id, conv_id, quantity, price, disc, disc_val, amount, amount_profit, price_purchase, paket_id, points, hrg_beli, conversion)values ((select sales_id from trs_sales_mst y where y.trans_num = (select max(x.trans_num) from trs_sales_mst x where x.cashier_id = 5) and y.cashier_id = 5), 558,2230,2,80000,0,0,160000,0,80000,NULL,0,80000,1);
update mst_item set current_stock = current_stock + -2 where item_id = 558;
call save_to_item_balance(1, 558, cast('2009-09-10 'as date), 2, 'C');
delete from setup_racik where racik_id = 0;
call save_to_cashier_balance(5, 0, 2, 160000, 0, 0, 0, 'D', 'adm');
XA END 'INVISI03cashier';
XA PREPARE 'INVISI03cashier';
XA COMMIT 'INVISI03cashier';
update mst_pasien set card_id= '' where pasien_id= 0;
update mst_company set company_name = 'Janki Petshop', address = 'Jl. Ciputat Raya No.20 D', telp1 = '021-7663820', telp2 = '', fax = '021-7509504', city = 'Jakarta', branch = 'Jakarta', npwp = '', post_code = '', info = 'Apotek', user_id = 'Rd. Irwan Herlambang', serial_number = '915556E7-18208F7E-49960580';
update mst_company set company_name = 'Jangki Petshop', address = 'Jl. Ciputat Raya No.20 D', telp1 = '021-7663820', telp2 = '', fax = '021-7509504', city = 'Jakarta', branch = 'Bandung', npwp = '', post_code = '', info = 'Petshop', user_id = 'Rd. Irwan Herlambang', serial_number = '915556E7-18208F7E-49960580';
update mst_company set company_name = 'Jangki Petshop', address = 'Jl. Ciputat Raya No.20 D', telp1 = '021-7663820', telp2 = '', fax = '021-7509504', city = 'Jakarta', branch = 'Bandung', npwp = '', post_code = '', info = 'Petshop', user_id = 'Rd. Irwan Herlambang', serial_number = '915556E7-18208F7E-49960580';
update mst_company set company_name = 'Jangki Petshop', address = 'Jl. Ciputat Raya No.20 D', telp1 = '021-7663820', telp2 = '', fax = '021-7509504', city = 'Jakarta', branch = 'Bandung', npwp = '', post_code = '', info = 'Petshop', user_id = 'Rd. Irwan Herlambang', serial_number = '915556E7-18208F7E-49960580';
update mst_company set company_name = 'Jangki Petshop', address = 'Jl. Ciputat Raya No.20 D', telp1 = '021-7663820', telp2 = '', fax = '021-7509504', city = 'Jakarta', branch = 'Bandung', npwp = '', post_code = '', info = 'Petshop', user_id = 'Rd. Irwan Herlambang', serial_number = '49EE0BD6-42608C74-498A02B5';

-- Begin on 10/10/02 12:26:46 - petShop
XA START 'INVISI03petShop';
update mst_relation set  relation_type= 1, relation_code= 'CS.001', relation_name= 'Fredy', address1= 'Antapani', address2= '', post_code= '', city= 'Bandung', phone1= '0343', phone2= '8888', npwp= '', contact_person = 'Adrul', due_Date= 0 where relation_id= 2;
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/10/03 22:16:33 - petShop
XA START 'INVISI03petShop';
INSERT INTO Mst_Relation_Animal (Relation_ID,Seq,Animal_Name,Animal_ID,Race,Eat,Age,Sex) VALUES (2,1,'Blacki',4,'Ordo','apa aka',4,-1);
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/10/03 22:30:16 - petShop
XA START 'INVISI03petShop';
UPDATE Mst_Relation_Animal SET Animal_Name='Blacki', Animal_ID=4, Race='Ordo', Eat='apa aka', Age=4, Sex=-1 WHERE Relation_ID=2 AND Seq=1;
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/10/03 22:30:29 - petShop
XA START 'INVISI03petShop';
UPDATE Mst_Relation_Animal SET Animal_Name='Blacki', Animal_ID=4, Race='Ordo', Eat='apa aka', Age=4, Sex=-1 WHERE Relation_ID=2 AND Seq=1;
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/10/03 22:30:43 - petShop
XA START 'INVISI03petShop';

-- Begin on 10/10/03 22:40:32 - petShop
XA START 'INVISI03petShop';
UPDATE Mst_Relation_Animal SET Animal_Name='Blacki', Animal_ID=4, Race='Ordo', Eat='apa aka', Age=4, Sex=1 WHERE Relation_ID=2 AND Seq=1;
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/10/03 23:01:00 - petShop
XA START 'INVISI03petShop';
UPDATE Mst_Relation_Animal SET Animal_Name='Blacki', Animal_ID=4, Race='Ordo', Eat='apa aka', Age=4, Sex=1 WHERE Relation_ID=2 AND Seq=1;
INSERT INTO Mst_Relation_Animal (Relation_ID,Seq,Animal_Name,Animal_ID,Race,Eat,Age,Sex) VALUES (2,2,'',0,'','',0,0);
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA ROLLBACK 'INVISI03petShop';

-- Begin on 10/10/03 23:18:10 - petShop
XA START 'INVISI03petShop';
UPDATE Mst_Relation_Animal SET Animal_Name='Blacki', Animal_ID=4, Race='Ordo', Eat='apa aka', Age=4, Sex=1 WHERE Relation_ID=2 AND Seq=1;
INSERT INTO Mst_Relation_Animal (Relation_ID,Seq,Animal_Name,Animal_ID,Race,Eat,Age,Sex) VALUES (2,2,'Budug',3,'dfa','afasdf',2,0);
INSERT INTO Mst_Relation_Animal (Relation_ID,Seq,Animal_Name,Animal_ID,Race,Eat,Age,Sex) VALUES (2,3,'',0,'','',0,0);
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA ROLLBACK 'INVISI03petShop';

-- Begin on 10/10/03 23:18:16 - petShop
XA START 'INVISI03petShop';
UPDATE Mst_Relation_Animal SET Animal_Name='Blacki', Animal_ID=4, Race='Ordo', Eat='apa aka', Age=4, Sex=1 WHERE Relation_ID=2 AND Seq=1;
INSERT INTO Mst_Relation_Animal (Relation_ID,Seq,Animal_Name,Animal_ID,Race,Eat,Age,Sex) VALUES (2,2,'Budug',3,'dfa','afasdf',2,0);
INSERT INTO Mst_Relation_Animal (Relation_ID,Seq,Animal_Name,Animal_ID,Race,Eat,Age,Sex) VALUES (2,3,'',0,'','',0,0);
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA ROLLBACK 'INVISI03petShop';

-- Begin on 10/10/03 23:21:10 - petShop
XA START 'INVISI03petShop';
UPDATE Mst_Relation_Animal SET Animal_Name='Blacki', Animal_ID=4, Race='Ordo', Eat='apa aka', Age=4, Sex=1 WHERE Relation_ID=2 AND Seq=1;
INSERT INTO Mst_Relation_Animal (Relation_ID,Seq,Animal_Name,Animal_ID,Race,Eat,Age,Sex) VALUES (2,2,'gghk',3,'2','2',2,0);
INSERT INTO Mst_Relation_Animal (Relation_ID,Seq,Animal_Name,Animal_ID,Race,Eat,Age,Sex) VALUES (2,3,'',0,'','',0,0);
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA ROLLBACK 'INVISI03petShop';

-- Begin on 10/10/09 13:02:13 - petShop
XA START 'INVISI03petShop';
update mst_item SET specification=5, item_code='0001', barcode='TGHBKHKJH', struk_name='Ekabuba puppy 2 Kg', merk='Ekanuba', avg_price=0, bkp=0, konsinyasi=0, vendor_id =NULL, produsen_id =NULL, kemasan_id =26, kategori =NULL, dosis =0, expire_date =cast('2010-10-09 'as date), buying_price =cast('1899-12-30 'as date), selling_price =cast('1906-11-04 'as date), item_name='Ekabuba puppy' WHERE item_id=1;
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA ROLLBACK 'INVISI03petShop';

-- Begin on 10/10/09 13:39:08 - petShop
XA START 'INVISI03petShop';
update mst_item SET specification=5, item_code='0001', barcode='TGHBKHKJH', struk_name='Ekabuba puppy 2 Kg', merk='Ekanuba', avg_price=0, bkp=0, konsinyasi=0, vendor_id =NULL, produsen_id =NULL, kemasan_id =26, kategori =NULL, dosis =0, expire_date =cast('2010-10-09 'as date), buying_price =cast('1906-11-04 'as date), selling_price =cast('1899-12-30 'as date), item_name='Ekabuba puppy' WHERE item_id=1;
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA ROLLBACK 'INVISI03petShop';

-- Begin on 10/10/09 13:43:15 - petShop
XA START 'INVISI03petShop';
update mst_item SET specification=5, item_code='0001', barcode='TGHBKHKJH', struk_name='Ekabuba puppy 2 Kg', merk='Ekanuba', avg_price=0, bkp=0, konsinyasi=0, vendor_id =NULL, produsen_id =NULL, kemasan_id =26, kategori =NULL, dosis =0, expire_date =cast('2010-10-09 'as date), buying_price =0, selling_price =2500, item_name='Ekabuba puppy' WHERE item_id=1;
delete from mst_rak_item where item_id = 1;
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';
update mst_company set company_name = 'Jangki Petshop', address = 'Jl. Ciputat Raya No.20 D', telp1 = '021-7663820', telp2 = '', fax = '021-7509504', city = 'Jakarta', branch = 'J0001 Jakde', npwp = '', post_code = '', info = 'Petshop', user_id = 'Rd. Irwan Herlambang', current_branch=2,serial_number = '49EE0BD6-42608C74-498A02B5';

-- Begin on 10/10/09 16:30:23 - petShop
XA START 'INVISI03petShop';
insert into trs_shipment_mst (trans_num, tipe, trans_date, notes, gudang_asal, gudang_tujuan, user_id) values ('SA/20101000001',2,cast('2010-10-09 'as date),'',1,NULL,'adm');
insert into trs_shipment_detail (ship_id, item_id, conv_id, quantity, price_sales, price_cost, price_purchase, hrg_beli, conversion)values (last_insert_id(), 2,0,0,0,0,0,0,0);
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA ROLLBACK 'INVISI03petShop';

-- Begin on 10/10/09 16:32:56 - petShop
XA START 'INVISI03petShop';
insert into trs_shipment_mst (trans_num, tipe, trans_date, notes, gudang_asal, gudang_tujuan, user_id) values ('SA/20101000001',2,cast('2010-10-09 'as date),'',1,NULL,'adm');
insert into trs_shipment_detail (ship_id, item_id,  quantity, price_sales, price_cost, price_purchase, hrg_beli, conversion)values (last_insert_id(), 2,0,0,0,0,0,0);
update mst_item set avg_price = 0 where item_id = 0;
update mst_item set current_stock = current_stock + 0 where item_id = 2;
call save_to_item_balance(1, 2, cast('2010-10-09 'as date), 0, 'D');
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/10/09 16:52:11 - petShop
XA START 'INVISI03petShop';
insert into trs_shipment_mst (trans_num, tipe, trans_date, notes, gudang_asal, gudang_tujuan, user_id) values ('SA/20101000002',2,cast('2010-10-09 'as date),'',1,NULL,'adm');
insert into trs_shipment_detail (ship_id, item_id,  quantity, price_sales, price_cost, price_purchase, hrg_beli, conversion)values (last_insert_id(), 1,150,0,0,0,0,0);
update mst_item set avg_price = 0 where item_id = 0;
update mst_item set current_stock = current_stock + 150 where item_id = 1;
call save_to_item_balance(1, 1, cast('2010-10-09 'as date), 150, 'D');
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/10/09 17:42:48 - petShop
XA START 'INVISI03petShop';
insert into trs_shipment_mst (trans_num, tipe, trans_date, notes, gudang_asal, gudang_tujuan, user_id) values ('MB/20101000001',3,cast('2010-10-09 'as date),'',1,2,'adm');
insert into trs_shipment_detail (ship_id, item_id,  quantity, price_sales, price_cost, price_purchase, hrg_beli, conversion)values (last_insert_id(), 4,10,0,0,0,0,0);
update mst_item set current_stock = current_stock + -10 where item_id = 4;
call save_to_item_balance(1, 4, cast('2010-10-09 'as date), 10, 'C');
update mst_item set current_stock = current_stock + 10 where item_id = 4;
call save_to_item_balance(2, 4, cast('2010-10-09 'as date), 10, 'D');
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';
update mst_company set company_name = 'Jangki Petshop', address = 'Jl. Ciputat Raya No.20 D', telp1 = '021-7663820', telp2 = '', fax = '021-7509504', city = 'Jakarta', branch = 'J0001 Jakde', npwp = '', post_code = '', info = 'Petshop', user_id = 'Rd. Irwan Herlambang', current_branch=2,serial_number = '49EE0BD6-42608C74-498A02B5';
update mst_company set company_name = 'Jangki Petshop', address = 'Jl. Ciputat Raya No.20 D', telp1 = '021-7663820', telp2 = '', fax = '021-7509504', city = 'Jakarta', branch = 'J0001 Jakde', npwp = '', post_code = '', info = 'Petshop', user_id = 'Rd. Irwan Herlambang', current_branch=2,serial_number = 'BD6E548C-15A72929-9A672D80';

-- Begin on 10/10/26 12:23:26 - cashier
XA START 'INVISI03cashier';
XA END 'INVISI03cashier';
XA PREPARE 'INVISI03cashier';
XA COMMIT 'INVISI03cashier';

-- Begin on 10/10/26 14:46:07 - petShop
XA START 'INVISI03petShop';
update mst_item SET specification=5, item_code='0003', barcode='0003', struk_name='Apro 20 kg Beef', merk='Apro', avg_price=0, bkp=0, konsinyasi=0, vendor_id =NULL, produsen_id =NULL, kemasan_id =26, kategori =NULL, dosis =0, expire_date =cast('2010-10-26 'as date), buying_price =0, selling_price =2500, item_name='Apro 20 kg Beef' WHERE item_id=3;
delete from mst_rak_item where item_id = 3;
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/10/26 14:46:20 - petShop
XA START 'INVISI03petShop';
update mst_item SET specification=5, item_code='0008', barcode='0008', struk_name='Canine Selection 20 Kg', merk='Canine', avg_price=0, bkp=0, konsinyasi=0, vendor_id =NULL, produsen_id =NULL, kemasan_id =26, kategori =NULL, dosis =0, expire_date =cast('2010-10-26 'as date), buying_price =0, selling_price =3500, item_name='Canine Selection 20 Kg' WHERE item_id=8;
delete from mst_rak_item where item_id = 8;
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/10/26 14:46:26 - petShop
XA START 'INVISI03petShop';
update mst_item SET specification=2, item_code='0010', barcode='0010', struk_name='Cleansfer', merk='Cleansfer', avg_price=0, bkp=0, konsinyasi=0, vendor_id =NULL, produsen_id =NULL, kemasan_id =8, kategori =NULL, dosis =0, expire_date =cast('2010-10-26 'as date), buying_price =0, selling_price =6500, item_name='Cleansfer' WHERE item_id=10;
delete from mst_rak_item where item_id = 10;
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/10/26 14:46:35 - petShop
XA START 'INVISI03petShop';
update mst_item SET specification=5, item_code='0007', barcode='0007', struk_name='Dear Dog Beef 7,5 kg', merk='Dear Dog', avg_price=0, bkp=0, konsinyasi=0, vendor_id =NULL, produsen_id =NULL, kemasan_id =26, kategori =NULL, dosis =0, expire_date =cast('2010-10-26 'as date), buying_price =0, selling_price =6500, item_name='Dear Dog Beef 7,5 kg' WHERE item_id=7;
delete from mst_rak_item where item_id = 7;
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/10/26 14:46:48 - petShop
XA START 'INVISI03petShop';
update mst_item SET specification=5, item_code='0001', barcode='0001', struk_name='Ekabuba puppy 2 Kg', merk='Ekanuba', avg_price=0, bkp=0, konsinyasi=0, vendor_id =NULL, produsen_id =NULL, kemasan_id =26, kategori =NULL, dosis =0, expire_date =cast('2010-10-26 'as date), buying_price =0, selling_price =4200, item_name='Ekabuba puppy' WHERE item_id=1;
delete from mst_rak_item where item_id = 1;
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/10/26 14:50:50 - petShop
XA START 'INVISI03petShop';
update mst_item SET specification=2, item_code='0004', barcode='0004', struk_name='Serokan', merk='', avg_price=0, bkp=0, konsinyasi=0, vendor_id =NULL, produsen_id =NULL, kemasan_id =8, kategori =NULL, dosis =0, expire_date =cast('2010-10-26 'as date), buying_price =0, selling_price =6500, item_name='Serokan' WHERE item_id=4;
delete from mst_rak_item where item_id = 4;
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/10/26 14:53:01 - petShop
XA START 'INVISI03petShop';
update mst_item SET specification=5, item_code='0009', barcode='0009', struk_name='Supreme 7 Kg Mini', merk='Supreme', avg_price=0, bkp=0, konsinyasi=0, vendor_id =NULL, produsen_id =NULL, kemasan_id =26, kategori =NULL, dosis =0, expire_date =cast('2010-10-26 'as date), buying_price =0, selling_price =6500, item_name='Supreme 7 Kg Mini' WHERE item_id=9;
delete from mst_rak_item where item_id = 9;
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/10/26 14:53:13 - petShop
XA START 'INVISI03petShop';
update mst_item SET specification=4, item_code='0005', barcode='0005', struk_name='Susu Curah 3 Ltr', merk='', avg_price=0, bkp=0, konsinyasi=0, vendor_id =NULL, produsen_id =NULL, kemasan_id =17, kategori =NULL, dosis =0, expire_date =cast('2010-10-26 'as date), buying_price =0, selling_price =4650, item_name='Susu Curah' WHERE item_id=5;
delete from mst_rak_item where item_id = 5;
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/10/26 14:53:19 - petShop
XA START 'INVISI03petShop';
update mst_item SET specification=4, item_code='0002', barcode='0002', struk_name='Susu Meow 5 ltr', merk='Meow Milky', avg_price=0, bkp=0, konsinyasi=0, vendor_id =NULL, produsen_id =NULL, kemasan_id =17, kategori =NULL, dosis =0, expire_date =cast('2010-10-26 'as date), buying_price =0, selling_price =8400, item_name='Susu Meow' WHERE item_id=2;
delete from mst_rak_item where item_id = 2;
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/10/26 14:53:24 - petShop
XA START 'INVISI03petShop';
update mst_item SET specification=4, item_code='0006', barcode='0006', struk_name='Susu Milky Pet 4 Ltr', merk='Susu Milky Pet', avg_price=0, bkp=0, konsinyasi=0, vendor_id =NULL, produsen_id =NULL, kemasan_id =17, kategori =NULL, dosis =0, expire_date =cast('2010-10-26 'as date), buying_price =0, selling_price =10500, item_name='Susu Milky Pet' WHERE item_id=6;
delete from mst_rak_item where item_id = 6;
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/10/26 14:54:03 - petShop
XA START 'INVISI03petShop';
INSERT INTO mst_service_price(service_id,animal_id,price,add_price,insert_log)  VALUES(6,5,6500,0,'adm;2010-10-26 00:00:00 ');
INSERT INTO mst_service_price(service_id,animal_id,price,add_price,insert_log)  VALUES(6,4,6500,0,'adm;2010-10-26 00:00:00 ');
INSERT INTO mst_service_price(service_id,animal_id,price,add_price,insert_log)  VALUES(6,3,6500,0,'adm;2010-10-26 00:00:00 ');
INSERT INTO mst_service_price(service_id,animal_id,price,add_price,insert_log)  VALUES(6,2,6500,0,'adm;2010-10-26 00:00:00 ');
INSERT INTO mst_service_price(service_id,animal_id,price,add_price,insert_log)  VALUES(6,1,6500,0,'adm;2010-10-26 00:00:00 ');
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/10/26 14:54:29 - petShop
XA START 'INVISI03petShop';
INSERT INTO mst_service_price(service_id,animal_id,price,add_price,insert_log)  VALUES(2,5,9000,0,'adm;2010-10-26 00:00:00 ');
INSERT INTO mst_service_price(service_id,animal_id,price,add_price,insert_log)  VALUES(2,4,9000,0,'adm;2010-10-26 00:00:00 ');
INSERT INTO mst_service_price(service_id,animal_id,price,add_price,insert_log)  VALUES(2,3,8000,0,'adm;2010-10-26 00:00:00 ');
INSERT INTO mst_service_price(service_id,animal_id,price,add_price,insert_log)  VALUES(2,2,7000,0,'adm;2010-10-26 00:00:00 ');
INSERT INTO mst_service_price(service_id,animal_id,price,add_price,insert_log)  VALUES(2,1,7500,0,'adm;2010-10-26 00:00:00 ');
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/10/26 14:54:32 - petShop
XA START 'INVISI03petShop';
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/10/26 14:55:11 - petShop
XA START 'INVISI03petShop';
INSERT INTO mst_service_price(service_id,animal_id,price,add_price,insert_log)  VALUES(4,5,10000,0,'adm;2010-10-26 00:00:00 ');
INSERT INTO mst_service_price(service_id,animal_id,price,add_price,insert_log)  VALUES(4,4,9000,0,'adm;2010-10-26 00:00:00 ');
INSERT INTO mst_service_price(service_id,animal_id,price,add_price,insert_log)  VALUES(4,3,8000,0,'adm;2010-10-26 00:00:00 ');
INSERT INTO mst_service_price(service_id,animal_id,price,add_price,insert_log)  VALUES(4,2,5000,0,'adm;2010-10-26 00:00:00 ');
INSERT INTO mst_service_price(service_id,animal_id,price,add_price,insert_log)  VALUES(4,1,7000,0,'adm;2010-10-26 00:00:00 ');
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/10/26 14:55:49 - petShop
XA START 'INVISI03petShop';
INSERT INTO mst_service_price(service_id,animal_id,price,add_price,insert_log)  VALUES(7,5,50000,5000,'adm;2010-10-26 00:00:00 ');
INSERT INTO mst_service_price(service_id,animal_id,price,add_price,insert_log)  VALUES(7,4,45000,5000,'adm;2010-10-26 00:00:00 ');
INSERT INTO mst_service_price(service_id,animal_id,price,add_price,insert_log)  VALUES(7,3,40000,5000,'adm;2010-10-26 00:00:00 ');
INSERT INTO mst_service_price(service_id,animal_id,price,add_price,insert_log)  VALUES(7,2,35000,5000,'adm;2010-10-26 00:00:00 ');
INSERT INTO mst_service_price(service_id,animal_id,price,add_price,insert_log)  VALUES(7,1,40000,5000,'adm;2010-10-26 00:00:00 ');
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/10/26 16:56:29 - petShop
XA START 'INVISI03petShop';
insert into mst_service (service_code, service_name, notes,service_type,insert_log) values ('S008','Sewa Hotel + Makan','Biayannya beda denga hotel aja tanpa makan',28,'adm;2010-10-26 00:00:00 ');
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/10/26 16:57:15 - petShop
XA START 'INVISI03petShop';
INSERT INTO mst_service_price(service_id,animal_id,price,add_price,insert_log)  VALUES(8,5,55000,0,'adm;2010-10-26 00:00:00 ');
INSERT INTO mst_service_price(service_id,animal_id,price,add_price,insert_log)  VALUES(8,4,50000,0,'adm;2010-10-26 00:00:00 ');
INSERT INTO mst_service_price(service_id,animal_id,price,add_price,insert_log)  VALUES(8,3,45000,0,'adm;2010-10-26 00:00:00 ');
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/10/26 16:57:25 - petShop
XA START 'INVISI03petShop';
INSERT INTO mst_service_price(service_id,animal_id,price,add_price,insert_log)  VALUES(8,2,40000,0,'adm;2010-10-26 00:00:00 ');
INSERT INTO mst_service_price(service_id,animal_id,price,add_price,insert_log)  VALUES(8,1,45000,0,'adm;2010-10-26 00:00:00 ');
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/10/26 17:23:45 - cashier
XA START 'INVISI03cashier';
XA END 'INVISI03cashier';
XA PREPARE 'INVISI03cashier';
XA COMMIT 'INVISI03cashier';

-- Begin on 10/10/26 17:48:19 - cashier
XA START 'INVISI03cashier';
insert into inv_cashier_balance (cashier_id, shift_id, user_id, balance_date, so_awal) values (5, 0, 'adm', curdate(), 50000);
XA END 'INVISI03cashier';
XA PREPARE 'INVISI03cashier';
XA COMMIT 'INVISI03cashier';

-- Begin on 10/10/26 17:48:20 - cashier
XA START 'INVISI03cashier';
update inv_cashier_balance set so_awal = 50000 where balance_date = curdate()  and shift_id = 0 and cashier_id  = 5;
XA END 'INVISI03cashier';
XA PREPARE 'INVISI03cashier';
XA COMMIT 'INVISI03cashier';

-- Begin on 10/10/26 22:04:15 - cashier
XA START 'INVISI03cashier';
insert into trs_sales_mst (trans_num, trans_type, trans_date, cashier_id, gudang_id, pasien_id, subtotal, profit, disc_mst, disc_val_mst, disc_detail, tax, total, embalase, real_amount, sisa, user_id, shift_id, cash, cara_bayar, card_id, bank, dokter_id, no_resep) values (get_new_sales_num('O201010'), 13,cast('2010-10-26 'as date),5,1,2,58150,8150,0,0,0,0,58150,0,58150,0,'adm',0,60000,0,'','',NULL,'');
XA END 'INVISI03cashier';
XA PREPARE 'INVISI03cashier';
XA ROLLBACK 'INVISI03cashier';

-- Begin on 10/10/26 22:07:15 - cashier
XA START 'INVISI03cashier';
insert into trs_sales_mst (trans_num, trans_type, trans_date, cashier_id, gudang_id, pasien_id, subtotal, profit, disc_mst, disc_val_mst, disc_detail, tax, total, embalase, real_amount, sisa, user_id, shift_id, cash, cara_bayar, card_id, bank, dokter_id, no_resep) values (get_new_sales_num('O201010'), 13,cast('2010-10-26 'as date),5,1,2,58150,8150,0,0,0,0,58150,0,58150,0,'adm',0,60000,0,'','',NULL,'');
XA END 'INVISI03cashier';
XA PREPARE 'INVISI03cashier';
XA ROLLBACK 'INVISI03cashier';

-- Begin on 10/10/26 22:12:26 - cashier
XA START 'INVISI03cashier';
insert into trs_sales_mst (trans_num, trans_type, trans_date, cashier_id, gudang_id, pasien_id, subtotal, profit, disc_mst, disc_val_mst, disc_detail, tax, total, embalase, real_amount, sisa, user_id, shift_id, cash, cara_bayar, card_id, bank, dokter_id, no_resep) values (get_new_sales_num('201010'), 13,cast('2010-10-26 'as date),5,1,2,58150,8150,0,0,0,0,58150,0,58150,0,'adm',0,60000,0,'','',NULL,'');
XA END 'INVISI03cashier';
XA PREPARE 'INVISI03cashier';
XA ROLLBACK 'INVISI03cashier';

-- Begin on 10/10/26 22:13:32 - cashier
XA START 'INVISI03cashier';
insert into trs_sales_mst (trans_num, trans_type, trans_date, cashier_id, gudang_id, pasien_id, subtotal, profit, disc_mst, disc_val_mst, disc_detail, tax, total, embalase, real_amount, sisa, user_id, shift_id, cash, cara_bayar, card_id, bank, dokter_id, no_resep) values (get_new_sales_num('201010'), 13,cast('2010-10-26 'as date),5,1,2,58150,8150,0,0,0,0,58150,0,58150,0,'adm',0,60000,0,'','',NULL,'');

-- Begin on 10/10/26 22:15:40 - cashier
XA START 'INVISI03cashier';
insert into trs_sales_mst (trans_num, trans_type, trans_date, cashier_id, gudang_id, pasien_id, subtotal, profit, disc_mst, disc_val_mst, disc_detail, tax, total, embalase, real_amount, sisa, user_id, shift_id, cash, cara_bayar, card_id, bank, dokter_id, no_resep) values (get_new_sales_num('201010'), 13,cast('2010-10-26 'as date),5,1,2,58150,8150,0,0,0,0,58150,0,58150,0,'adm',0,60000,0,'','',NULL,'');
XA END 'INVISI03cashier';
XA PREPARE 'INVISI03cashier';
XA ROLLBACK 'INVISI03cashier';

-- Begin on 10/10/26 22:20:37 - cashier
XA START 'INVISI03cashier';
insert into trs_sales_mst (trans_num, trans_type, trans_date, cashier_id, gudang_id, pasien_id, subtotal, profit, disc_mst, disc_val_mst, disc_detail, tax, total, embalase, real_amount, sisa, user_id, shift_id, cash, cara_bayar, card_id, bank, dokter_id, no_resep) values (get_new_sales_num('201010'), 13,cast('2010-10-26 'as date),5,1,2,58150,8150,0,0,0,0,58150,0,58150,0,'adm',0,60000,0,'','',NULL,'');
insert into trs_sales_detail (sales_id, item_id, conv_id, quantity, price, disc, disc_val, amount, amount_profit, price_purchase, paket_id, points, hrg_beli, conversion)values ((select sales_id from trs_sales_mst y where y.trans_num = (select max(x.trans_num) from trs_sales_mst x where x.cashier_id = 5) and y.cashier_id = 5), 8,NULL,1,3500,0,0,3500,3500,0,NULL,0,0,1);
XA END 'INVISI03cashier';
XA PREPARE 'INVISI03cashier';
XA ROLLBACK 'INVISI03cashier';

-- Begin on 10/10/26 22:22:38 - cashier
XA START 'INVISI03cashier';
insert into trs_sales_mst (trans_num, trans_type, trans_date, cashier_id, gudang_id, pasien_id, subtotal, profit, disc_mst, disc_val_mst, disc_detail, tax, total, embalase, real_amount, sisa, user_id, shift_id, cash, cara_bayar, card_id, bank, dokter_id, no_resep) values (get_new_sales_num('201010'), 13,cast('2010-10-26 'as date),5,1,2,58150,8150,0,0,0,0,58150,0,58150,0,'adm',0,60000,0,'','',NULL,'');
insert into trs_sales_detail (sales_id, item_id,  quantity, price, disc, disc_val, amount, amount_profit, price_purchase, paket_id, points, hrg_beli, conversion)values ((select sales_id from trs_sales_mst y where y.trans_num = (select max(x.trans_num) from trs_sales_mst x where x.cashier_id = 5) and y.cashier_id = 5), 8,1,3500,0,0,3500,3500,0,NULL,0,0,1);
XA END 'INVISI03cashier';
XA PREPARE 'INVISI03cashier';
XA ROLLBACK 'INVISI03cashier';

-- Begin on 10/10/26 22:24:33 - cashier
XA START 'INVISI03cashier';
insert into trs_sales_mst (trans_num, trans_type, trans_date, cashier_id, gudang_id, pasien_id, subtotal, profit, disc_mst, disc_val_mst, disc_detail, tax, total, embalase, real_amount, sisa, user_id, shift_id, cash, cara_bayar, card_id, bank, dokter_id, no_resep) values (get_new_sales_num('201010'), 13,cast('2010-10-26 'as date),5,1,2,58150,8150,0,0,0,0,58150,0,60,58090,'adm',0,60,0,'','',NULL,'');
insert into trs_sales_detail (sales_id, item_id, quantity, price, disc, disc_val, amount, amount_profit, price_purchase, paket_id, points, hrg_beli, conversion)values ((select sales_id from trs_sales_mst y where y.trans_num = (select max(x.trans_num) from trs_sales_mst x where x.cashier_id = 5) and y.cashier_id = 5), 8,1,3500,0,0,3500,3500,0,NULL,0,0,1);
update mst_item set current_stock = current_stock + -1 where item_id = 8;
call save_to_item_balance(1, 8, cast('2010-10-26 'as date), 1, 'C');
insert into trs_sales_detail (sales_id, item_id, quantity, price, disc, disc_val, amount, amount_profit, price_purchase, paket_id, points, hrg_beli, conversion)values ((select sales_id from trs_sales_mst y where y.trans_num = (select max(x.trans_num) from trs_sales_mst x where x.cashier_id = 5) and y.cashier_id = 5), 5,1,4650,0,0,4650,4650,0,NULL,0,0,1);
update mst_item set current_stock = current_stock + -1 where item_id = 5;
call save_to_item_balance(1, 5, cast('2010-10-26 'as date), 1, 'C');
call save_to_cashier_balance(5, 0, 0, 8150, 0, 0, 0, 'D', 'adm');
XA END 'INVISI03cashier';
XA PREPARE 'INVISI03cashier';
XA COMMIT 'INVISI03cashier';
update mst_pasien set card_id= '' where pasien_id= 2;

-- Begin on 10/10/27 12:05:45 - petShop
XA START 'INVISI03petShop';
insert into trs_order_mst (trans_num, tipe, trans_date, expr_date, delivery_date, relation_id, subtotal, disc_mst, disc_detail, tax, total, user_id, notes, dpp_disc2, pay_term, status_id) values ('PO/20101000001',2,cast('2010-10-27 'as date),cast('2010-10-27 'as date),cast('2010-10-27 'as date),1,50000,0,2500,0,47500,'adm','',0,0,0);
insert into trs_order_detail (order_id, item_id, conv_id, quantity, price, disc, amount, conversion, disc_is_prc, tax)values (last_insert_id(), 6,0,20,2500,2500,50000,1,0,0);
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA ROLLBACK 'INVISI03petShop';

-- Begin on 10/10/27 12:08:59 - petShop
XA START 'INVISI03petShop';
insert into trs_order_mst (trans_num, tipe, trans_date, expr_date, delivery_date, relation_id, subtotal, disc_mst, disc_detail, tax, total, user_id, notes, dpp_disc2, pay_term, status_id) values ('PO/20101000001',2,cast('2010-10-27 'as date),cast('2010-10-27 'as date),cast('2010-10-27 'as date),1,300000,0,2500,0,297500,'adm','',0,0,0);
insert into trs_order_detail (order_id, item_id,  quantity, price, disc, amount, conversion, disc_is_prc, tax)values (last_insert_id(), 1,20,15000,2500,300000,1,0,0);
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/10/27 12:15:00 - petShop
XA START 'INVISI03petShop';
update trs_order_mst set tipe = 2,trans_date = cast('2010-10-27 'as date),expr_date = cast('2010-10-27 'as date),delivery_date = cast('2010-10-27 'as date),subtotal = 300000,disc_mst = 0,disc_detail = 2500,tax = 0,total = 297500,user_id = 'adm',dpp_disc2 = 0,pay_term = 0,notes = 'coba ' where order_id = 2;
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';
update trs_order_mst set status_id = 1 where order_id = 2;

-- Begin on 10/10/27 13:22:07 - petShop
XA START 'INVISI03petShop';
insert into trs_receipt_mst (trans_num, trans_date, tipe, expr_date, relation_id, order_id, gudang_id, subtotal, disc_detail, disc_mst, tax, biaya, materai, total, notes, dpp_disc2, user_id) values ('RC/20101000001',cast('2010-10-27 'as date),0,cast('1899-12-30 'as date),1,2,NULL,300000,2500,0,0,0,0,297500,'',0,'adm');
insert into trs_receipt_detail (receipt_id, item_id, conv_id, conv_bonus_id, quantity, qty_bonus, price, amount, disc1, disc2, disc3, conversion, conv_bonus, disc1_is_prc, disc2_is_prc, disc3_is_prc, tax)values (last_insert_id(), 1,0,0,20,0,15000,300000,2500,0,0,1,0,0,0,0,0);
update trs_order_mst set sudah_diterima = 1 where order_id = 2;
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/10/27 13:31:37 - petShop
XA START 'INVISI03petShop';
update trs_receipt_mst set status_id = 1, sisa = total where receipt_id = 1;
update mst_item set avg_price = (ifnull((440 * avg_price),0) + 300000) / (ifnull(440,0) + 20) where item_id = 1;
update mst_item set current_stock = current_stock + 20 where item_id = 1;
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA ROLLBACK 'INVISI03petShop';

-- Begin on 10/10/27 13:35:34 - petShop
XA START 'INVISI03petShop';
update trs_receipt_mst set trans_date = cast('2010-10-27 'as date),tipe = 0,expr_date = cast('1899-12-30 'as date),order_id = 2,gudang_id = 1,relation_id = 1,subtotal = 225000,disc_detail = 2500,disc_mst = 0,tax = 0,biaya = 0,materai = 0,total = 222500,dpp_disc2 = 0,notes = '',user_id = 'adm'where receipt_id = 1;
update trs_receipt_detail set item_id = 1,conv_id = 0,conv_bonus_id = NULL,quantity = 15,qty_bonus = 0,price = 15000,amount = 225000,disc1 = 2500,disc2 = 0,disc3 = 0,conversion = 1,tax = 0,disc1_is_prc = 0,disc2_is_prc = 0,disc3_is_prc = 0,conv_bonus = 0 where receipt_detail_id = 1;
update trs_order_mst set sudah_diterima = 1 where order_id = 2;
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/10/27 13:35:49 - petShop
XA START 'INVISI03petShop';
update trs_receipt_mst set status_id = 1, sisa = total where receipt_id = 1;
update mst_item set avg_price = (ifnull((440 * avg_price),0) + 225000) / (ifnull(440,0) + 15) where item_id = 1;
update mst_item set current_stock = current_stock + 15 where item_id = 1;
call save_to_item_balance(1, 1, cast('2010-10-27 'as date), 15, 'D');
call save_to_relation_balance(1, cast('2010-10-27 'as date), 222500, 'D');
update mst_relation set current_debt = current_debt + 222500 where relation_id = 1;
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/10/27 13:47:22 - petShop
XA START 'INVISI03petShop';
insert into trs_retur_mst (trans_num, trans_date, tipe, relation_id, gudang_id, subtotal, discount, tax, biaya, materai, total, notes, user_id) values ('RT/20101000001',cast('2010-10-27 'as date),0,1,NULL,225000,0,0,0,0,225000,'','adm');
insert into trs_retur_detail (retur_id, item_id, conv_id, quantity, price, amount, disc, tax, disc_is_prc, conversion, faktur_id)values (last_insert_id(), 1,0,15,15000,225000,0,0,0,1,1);
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/10/27 13:47:25 - petShop
XA START 'INVISI03petShop';
update mst_item set current_stock = current_stock + -15 where item_id = 1;
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA ROLLBACK 'INVISI03petShop';

-- Begin on 10/10/27 13:51:07 - petShop
XA START 'INVISI03petShop';
update trs_retur_mst set trans_date = cast('2010-10-27 'as date),tipe = 0,gudang_id = 1,relation_id = 1,subtotal = 15000,tax = 0,biaya = 0,materai = 0,total = 15000,discount = 0,notes = '',user_id = 'adm'where retur_id = 1;
update trs_retur_detail set item_id = 1,conv_id = 0,quantity = 1,price = 15000,amount = 15000,disc = 0,tax = 0,disc_is_prc = 0,conversion = 1,faktur_id = 1 where retur_detail_id = 1;
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/10/27 13:51:11 - petShop
XA START 'INVISI03petShop';
update mst_item set current_stock = current_stock + -1 where item_id = 1;
call save_to_item_balance(1, 1, cast('2010-10-27 'as date), 1, 'C');
update trs_receipt_mst set sisa = sisa - 15000 where receipt_id = 1;
update trs_retur_mst set status_id = 1 where retur_id = 1;
call save_to_relation_balance(1, cast('2010-10-27 'as date), 15000, 'C');
update mst_relation set current_debt = current_debt + -15000 where relation_id = 1;
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/10/28 09:05:41 - petShop
XA START 'INVISI03petShop';
insert into trs_order_mst (trans_num, tipe, trans_date, expr_date, delivery_date, relation_id, subtotal, disc_mst, disc_detail, tax, total, user_id, notes, dpp_disc2, pay_term, status_id) values ('PO/20101000003',2,cast('2010-10-28 'as date),cast('2010-10-28 'as date),cast('2010-10-28 'as date),4,525000,0,0,0,525000,'adm','tes',0,0,0);
insert into trs_order_detail (order_id, item_id,  quantity, price, disc, amount, conversion, disc_is_prc, tax)values (last_insert_id(), 1,20,5000,0,100000,1,0,0);
insert into trs_order_detail (order_id, item_id,  quantity, price, disc, amount, conversion, disc_is_prc, tax)values (last_insert_id(), 8,50,8500,0,425000,1,0,0);
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/10/28 09:06:36 - petShop
XA START 'INVISI03petShop';
update trs_order_mst set tipe = 2,trans_date = cast('2010-10-28 'as date),expr_date = cast('2010-10-28 'as date),delivery_date = cast('2010-10-28 'as date),subtotal = 530000,disc_mst = 0,disc_detail = 0,tax = 0,total = 530000,user_id = 'adm',dpp_disc2 = 0,pay_term = 0,notes = 'tes' where order_id = 4;
update trs_order_detail set item_id = 8,quantity = 50,price = 8600,disc = 0,amount = 430000,disc_is_prc = 0,tax = 0,conversion  = 1 where order_detail_id = 7;
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';
update trs_order_mst set status_id = 1 where order_id = 4;

-- Begin on 10/10/28 16:18:58 - petShop
XA START 'INVISI03petShop';
insert into trs_order_mst (trans_num, tipe, trans_date, expr_date, delivery_date, relation_id, subtotal, disc_mst, disc_detail, tax, total, user_id, notes, dpp_disc2, pay_term, status_id) values ('PO/20101000001',2,cast('2010-10-28 'as date),cast('2010-10-28 'as date),cast('2010-10-28 'as date),1,280000,0,0,0,280000,'adm','tes',0,0,0);
insert into trs_order_detail (order_id, item_id,  quantity, price, disc, amount, conversion, disc_is_prc, tax)values (last_insert_id(), 1,20,6500,0,130000,1,0,0);
insert into trs_order_detail (order_id, item_id,  quantity, price, disc, amount, conversion, disc_is_prc, tax)values (last_insert_id(), 2,25,6000,0,150000,1,0,0);
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';
update trs_order_mst set status_id = 1 where order_id = 1;

-- Begin on 10/10/28 16:19:25 - petShop
XA START 'INVISI03petShop';
insert into trs_receipt_mst (trans_num, trans_date, tipe, expr_date, relation_id, order_id, gudang_id, subtotal, disc_detail, disc_mst, tax, biaya, materai, total, notes, dpp_disc2, user_id) values ('RC/20101000001',cast('2010-10-28 'as date),0,cast('1899-12-30 'as date),1,1,1,280000,0,0,0,0,0,280000,'',0,'adm');
insert into trs_receipt_detail (receipt_id, item_id, conv_id, conv_bonus_id, quantity, qty_bonus, price, amount, disc1, disc2, disc3, conversion, conv_bonus, disc1_is_prc, disc2_is_prc, disc3_is_prc, tax)values (last_insert_id(), 1,0,0,20,0,6500,130000,0,0,0,1,0,0,0,0,0);
insert into trs_receipt_detail (receipt_id, item_id, conv_id, conv_bonus_id, quantity, qty_bonus, price, amount, disc1, disc2, disc3, conversion, conv_bonus, disc1_is_prc, disc2_is_prc, disc3_is_prc, tax)values (last_insert_id(), 2,0,0,25,0,6000,150000,0,0,0,1,0,0,0,0,0);
update trs_order_mst set sudah_diterima = 1 where order_id = 1;
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/10/28 16:19:27 - petShop
XA START 'INVISI03petShop';
update trs_receipt_mst set status_id = 1, sisa = total where receipt_id = 1;
update mst_item set buying_price = 6500, avg_price = (ifnull((0 * avg_price),0) + 130000) / (ifnull(0,0) + 20) where item_id = 1;
update mst_item set current_stock = current_stock + 20 where item_id = 1;
call save_to_item_balance(1, 1, cast('2010-10-28 'as date), 20, 'D');
update mst_item set buying_price = 6000, avg_price = (ifnull((0 * avg_price),0) + 150000) / (ifnull(0,0) + 25) where item_id = 2;
update mst_item set current_stock = current_stock + 25 where item_id = 2;
call save_to_item_balance(1, 2, cast('2010-10-28 'as date), 25, 'D');
call save_to_relation_balance(1, cast('2010-10-28 'as date), 280000, 'D');
update mst_relation set current_debt = current_debt + 280000 where relation_id = 1;
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/10/28 16:22:33 - petShop
XA START 'INVISI03petShop';
insert into trs_shipment_mst (trans_num, tipe, trans_date, notes, gudang_asal, gudang_tujuan, user_id) values ('SE/20101000001',2,cast('2010-10-28 'as date),'tes mutasi masuk',1,2,'adm');
insert into trs_shipment_detail (ship_id, item_id,  quantity, price_sales, price_cost, price_purchase, hrg_beli, conversion)values (last_insert_id(), 3,20,0,0,0,0,0);
update mst_item set current_stock = current_stock + -20 where item_id = 3;
call save_to_item_balance(1, 3, cast('2010-10-28 'as date), 20, 'C');
update mst_item set current_stock = current_stock + 20 where item_id = 3;
call save_to_item_balance(2, 3, cast('2010-10-28 'as date), 20, 'D');
insert into trs_shipment_detail (ship_id, item_id,  quantity, price_sales, price_cost, price_purchase, hrg_beli, conversion)values (last_insert_id(), 4,50,0,0,0,0,0);
update mst_item set current_stock = current_stock + -50 where item_id = 4;
call save_to_item_balance(1, 4, cast('2010-10-28 'as date), 50, 'C');
update mst_item set current_stock = current_stock + 50 where item_id = 4;
call save_to_item_balance(2, 4, cast('2010-10-28 'as date), 50, 'D');
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/10/28 16:28:23 - petShop
XA START 'INVISI03petShop';
insert into trs_shipment_mst (trans_num, tipe, trans_date, notes, gudang_asal, gudang_tujuan, user_id) values ('SE/20101000002',2,cast('2010-10-28 'as date),'',1,2,'adm');
insert into trs_shipment_detail (ship_id, item_id,  quantity, price_sales, price_cost, price_purchase, hrg_beli, conversion)values (last_insert_id(), 5,60,0,0,0,0,0);
update mst_item set current_stock = current_stock + 60 where item_id = 5;
call save_to_item_balance(1, 5, cast('2010-10-28 'as date), 60, 'D');
insert into trs_shipment_detail (ship_id, item_id,  quantity, price_sales, price_cost, price_purchase, hrg_beli, conversion)values (last_insert_id(), 6,100,0,0,0,0,0);
update mst_item set current_stock = current_stock + 100 where item_id = 6;
call save_to_item_balance(1, 6, cast('2010-10-28 'as date), 100, 'D');
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';
update system_config set conf_value = '20'where conf_id = 15;

-- Begin on 10/10/29 22:47:06 - petShop
XA START 'INVISI03petShop';
insert into mst_code (code_name,code_code, parent_id, urut, level) values ('Kandang','',1,0,2);
insert into point_maping (code_id, root_id) values (6,6);
insert into point_maping (code_id, root_id) values (6,1);
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/10/29 23:11:54 - petShop
XA START 'INVISI03petShop';
insert into mst_code (code_name,code_code, parent_id, urut, level) values ('tes','',1,0,2);
insert into point_maping (code_id, root_id) values (7,7);
insert into point_maping (code_id, root_id) values (7,1);
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/10/29 23:13:59 - petShop
XA START 'INVISI03petShop';
insert into mst_code (code_name,code_code, parent_id, urut, level) values ('tes23','',1,0,2);
insert into point_maping (code_id, root_id) values (8,8);
insert into point_maping (code_id, root_id) values (8,1);
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/10/29 23:15:26 - petShop
XA START 'INVISI03petShop';
insert into mst_code (code_name,code_code, parent_id, urut, level) values ('tes 1','',2,0,3);
insert into point_maping (code_id, root_id) values (9,9);
insert into point_maping (code_id, root_id) values (9,2);
insert into point_maping (code_id, root_id) values (9,1);
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/10/29 23:15:42 - petShop
XA START 'INVISI03petShop';
insert into mst_code (code_name,code_code, parent_id, urut, level) values ('tes 2','',2,0,3);
insert into point_maping (code_id, root_id) values (10,10);
insert into point_maping (code_id, root_id) values (10,2);
insert into point_maping (code_id, root_id) values (10,1);
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/10/29 23:15:56 - petShop
XA START 'INVISI03petShop';
insert into mst_code (code_name,code_code, parent_id, urut, level) values ('tes3','',2,0,3);
insert into point_maping (code_id, root_id) values (11,11);
insert into point_maping (code_id, root_id) values (11,2);
insert into point_maping (code_id, root_id) values (11,1);
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/10/29 23:17:21 - petShop
XA START 'INVISI03petShop';
insert into mst_code (code_name,code_code, parent_id, urut, level) values ('tes asf','',9,0,4);
insert into point_maping (code_id, root_id) values (12,12);
insert into point_maping (code_id, root_id) values (12,9);
insert into point_maping (code_id, root_id) values (12,2);
insert into point_maping (code_id, root_id) values (12,1);
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/10/29 23:19:13 - petShop
XA START 'INVISI03petShop';
insert into mst_code (code_name,code_code, parent_id, urut, level) values ('tesafdas f','',12,0,5);
insert into point_maping (code_id, root_id) values (13,13);
insert into point_maping (code_id, root_id) values (13,12);
insert into point_maping (code_id, root_id) values (13,9);
insert into point_maping (code_id, root_id) values (13,2);
insert into point_maping (code_id, root_id) values (13,1);
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/10/29 23:22:44 - petShop
XA START 'INVISI03petShop';
insert into mst_code (code_name,code_code, parent_id, urut, level) values ('tesra','',13,0,6);
insert into point_maping (code_id, root_id) values (14,14);
insert into point_maping (code_id, root_id) values (14,13);
insert into point_maping (code_id, root_id) values (14,12);
insert into point_maping (code_id, root_id) values (14,9);
insert into point_maping (code_id, root_id) values (14,2);
insert into point_maping (code_id, root_id) values (14,1);
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/10/29 23:23:09 - petShop
XA START 'INVISI03petShop';
insert into mst_code (code_name,code_code, parent_id, urut, level) values ('tesra','',14,0,7);
insert into point_maping (code_id, root_id) values (15,15);
insert into point_maping (code_id, root_id) values (15,14);
insert into point_maping (code_id, root_id) values (15,13);
insert into point_maping (code_id, root_id) values (15,12);
insert into point_maping (code_id, root_id) values (15,9);
insert into point_maping (code_id, root_id) values (15,2);
insert into point_maping (code_id, root_id) values (15,1);
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/10/29 23:25:30 - petShop
XA START 'INVISI03petShop';
insert into mst_code (code_name,code_code, parent_id, urut, level) values ('aadfasdf','',15,0,8);
insert into point_maping (code_id, root_id) values (16,16);
insert into point_maping (code_id, root_id) values (16,15);
insert into point_maping (code_id, root_id) values (16,14);
insert into point_maping (code_id, root_id) values (16,13);
insert into point_maping (code_id, root_id) values (16,12);
insert into point_maping (code_id, root_id) values (16,9);
insert into point_maping (code_id, root_id) values (16,2);
insert into point_maping (code_id, root_id) values (16,1);
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/10/30 00:00:04 - petShop
XA START 'INVISI03petShop';
update system_config set conf_value = '20'where conf_id = 15;
update mst_service_bonus set jml_service= 2,bonus_service=2,bonus_jml=1 where service_type=27;
update mst_service_bonus set jml_service= 7,bonus_service=7,bonus_jml=2 where service_type=28;
update mst_service_bonus set jml_service= 0,bonus_service=0,bonus_jml=0 where service_type=29;
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/10/30 00:00:49 - petShop
XA START 'INVISI03petShop';
update system_config set conf_value = '20'where conf_id = 15;
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA ROLLBACK 'INVISI03petShop';

-- Begin on 10/10/30 00:03:41 - petShop
XA START 'INVISI03petShop';
update system_config set conf_value = '20'where conf_id = 15;
update mst_service_bonus set jml_service= 2,bonus_service=29,bonus_jml=1 where service_type=27;
update mst_service_bonus set jml_service= 7,bonus_service=29,bonus_jml=2 where service_type=28;
update mst_service_bonus set jml_service= 0,bonus_service=29,bonus_jml=0 where service_type=29;
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/10/30 00:03:53 - petShop
XA START 'INVISI03petShop';
update system_config set conf_value = '20'where conf_id = 15;
update mst_service_bonus set jml_service= 2,bonus_service=28,bonus_jml=1 where service_type=27;
update mst_service_bonus set jml_service= 7,bonus_service=28,bonus_jml=2 where service_type=28;
update mst_service_bonus set jml_service= 0,bonus_service=28,bonus_jml=0 where service_type=29;
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/10/30 00:12:26 - petShop
XA START 'INVISI03petShop';
update system_config set conf_value = '20'where conf_id = 15;
update mst_service_bonus set jml_service= 7,bonus_service=27,bonus_jml=1 where service_type=27;
update mst_service_bonus set jml_service= 7,bonus_service=29,bonus_jml=2 where service_type=28;
update mst_service_bonus set jml_service= 0,bonus_service=27,bonus_jml=0 where service_type=29;
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/11/18 14:14:20 - petShop
XA START 'INVISI03petShop';
insert into trs_order_mst (trans_num, tipe, trans_date, expr_date, delivery_date, relation_id, subtotal, disc_mst, disc_detail, tax, total, user_id, notes, dpp_disc2, pay_term, status_id) values ('PO/20101100009',2,cast('2010-11-18 'as date),cast('2010-11-18 'as date),cast('2010-11-18 'as date),1,8450,0,0,0,8450,'adm','',0,0,0);
insert into trs_order_detail (order_id, item_id,  quantity, price, disc, amount, conversion, disc_is_prc, tax)values (last_insert_id(), 59,1,8450,0,8450,1,0,0);
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/11/18 14:46:34 - petShop
XA START 'INVISI03petShop';
insert into trs_order_mst (trans_num, tipe, trans_date, expr_date, delivery_date, relation_id, subtotal, disc_mst, disc_detail, tax, total, user_id, notes, dpp_disc2, pay_term, status_id) values ('PO/20101100013',2,cast('2010-11-18 'as date),cast('2010-11-18 'as date),cast('2010-11-18 'as date),5,15919332,0,0,0,15919332,'adm','trtr',0,0,0);
insert into trs_order_detail (order_id, item_id,  quantity, price, disc, amount, conversion, disc_is_prc, tax)values (last_insert_id(), 56,20,23000,0,460000,1,0,0);
insert into trs_order_detail (order_id, item_id,  quantity, price, disc, amount, conversion, disc_is_prc, tax)values (last_insert_id(), 45,65,229500,0,14917500,1,0,0);
insert into trs_order_detail (order_id, item_id,  quantity, price, disc, amount, conversion, disc_is_prc, tax)values (last_insert_id(), 53,1,15000,0,15000,1,0,0);
insert into trs_order_detail (order_id, item_id,  quantity, price, disc, amount, conversion, disc_is_prc, tax)values (last_insert_id(), 3,1,277000,0,277000,1,0,0);
insert into trs_order_detail (order_id, item_id,  quantity, price, disc, amount, conversion, disc_is_prc, tax)values (last_insert_id(), 50,1,214620,0,214620,1,0,0);
insert into trs_order_detail (order_id, item_id,  quantity, price, disc, amount, conversion, disc_is_prc, tax)values (last_insert_id(), 52,1,1212,0,1212,1,0,0);
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/11/18 14:55:26 - petShop
XA START 'INVISI03petShop';
update trs_order_mst set tipe = 2,trans_date = cast('2010-11-18 'as date),expr_date = cast('2010-11-18 'as date),delivery_date = cast('2010-11-18 'as date),subtotal = 16108485,disc_mst = 0,disc_detail = 0,tax = 0,total = 16108485,user_id = 'adm',dpp_disc2 = 0,pay_term = 0,notes = 'trtr' where order_id = 14;
update trs_order_detail set item_id = 3,quantity = 0,price = 277000,disc = 0,amount = 277000,disc_is_prc = 0,tax = 0,conversion  = 0 where order_detail_id = 58;
update trs_order_detail set item_id = 50,quantity = 0,price = 214620,disc = 0,amount = 214620,disc_is_prc = 0,tax = 0,conversion  = 0 where order_detail_id = 59;
update trs_order_detail set item_id = 52,quantity = 0,price = 70000,disc = 0,amount = 70000,disc_is_prc = 0,tax = 0,conversion  = 0 where order_detail_id = 60;
insert into trs_order_detail (order_id, item_id,  quantity, price, disc, amount, conversion, disc_is_prc, tax)values (last_insert_id(), 14,2,70000,0,140000,1,0,0);
insert into trs_order_detail (order_id, item_id,  quantity, price, disc, amount, conversion, disc_is_prc, tax)values (last_insert_id(), 47,1,14365,0,14365,1,0,0);
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/11/19 16:23:27 - cashier
XA START 'INVISI03cashier';
insert into trs_money_trans_mst (trans_num, trans_date, trans_type,  total, notes, insert_log) values ('UM20101100001',cast('2010-11-19 'as date),1,20000,'','adm;2010-11-19 00:00:00 ');
insert into trs_money_trans_detail (money_trans_id, description, amount, money_id)values (1,'Jajan Baso',20000,1);
XA END 'INVISI03cashier';
XA PREPARE 'INVISI03cashier';
XA COMMIT 'INVISI03cashier';

-- Begin on 10/11/19 16:23:29 - cashier
XA START 'INVISI03cashier';
insert into trs_money_trans_mst (trans_num, trans_date, trans_type,  total, notes, insert_log) values ('UM20101100002',cast('2010-11-19 'as date),1,20000,'','adm;2010-11-19 00:00:00 ');
insert into trs_money_trans_detail (money_trans_id, description, amount, money_id)values (2,'Jajan Baso',20000,1);
XA END 'INVISI03cashier';
XA PREPARE 'INVISI03cashier';
XA COMMIT 'INVISI03cashier';

-- Begin on 10/11/19 16:24:49 - cashier
XA START 'INVISI03cashier';
insert into trs_money_trans_mst (trans_num, trans_date, trans_type,  total, notes, insert_log) values ('UM20101100003',cast('2010-11-19 'as date),1,7000,'','adm;2010-11-19 00:00:00 ');
insert into trs_money_trans_detail (money_trans_id, description, amount, money_id)values (3,'maol',4500,1);
XA END 'INVISI03cashier';
XA PREPARE 'INVISI03cashier';
XA COMMIT 'INVISI03cashier';

-- Begin on 10/11/19 22:30:48 - cashier
XA START 'INVISI03cashier';
insert into trs_money_trans_mst (trans_num, trans_date, trans_type,  total, notes, insert_log) values ('UM20101100004',cast('2010-11-19 'as date),1,15000,'','adm;2010-11-19 00:00:00 ');
insert into trs_money_trans_detail (money_trans_id, description, amount, money_id)values (4,'Dari Bos',15000,1);

-- Begin on 10/11/19 22:32:06 - cashier
XA START 'INVISI03cashier';
insert into trs_money_trans_mst (trans_num, trans_date, trans_type,  total, notes, insert_log) values ('UM20101100004',cast('2010-11-19 'as date),1,625000,'','adm;2010-11-19 00:00:00 ');
insert into trs_money_trans_detail (money_trans_id, description, amount, money_id)values (5,'dari bos',25000,1);
update mst_money set saldo = saldo + 25000 where money_id = 1;
call save_to_money_balance(1, cast('2010-11-19 'as date), 25000, 'D');
XA END 'INVISI03cashier';
XA PREPARE 'INVISI03cashier';
XA ROLLBACK 'INVISI03cashier';

-- Begin on 10/11/19 22:34:19 - cashier
XA START 'INVISI03cashier';
insert into trs_money_trans_mst (trans_num, trans_date, trans_type,  total, notes, insert_log) values ('UM20101100004',cast('2010-11-19 'as date),1,1150000,'','adm;2010-11-19 00:00:00 ');
insert into trs_money_trans_detail (money_trans_id, description, amount, money_id)values (6,'dari bos',1000000,1);
update mst_money set saldo = saldo + 1000000 where money_id = 1;
call save_to_money_balance(1, cast('2010-11-19 'as date), 1000000, 'D');
insert into trs_money_trans_detail (money_trans_id, description, amount, money_id)values (6,'Nemu',150000,1);
update mst_money set saldo = saldo + 150000 where money_id = 1;
call save_to_money_balance(1, cast('2010-11-19 'as date), 150000, 'D');
XA END 'INVISI03cashier';
XA PREPARE 'INVISI03cashier';
XA COMMIT 'INVISI03cashier';

-- Begin on 10/11/19 22:45:19 - cashier
XA START 'INVISI03cashier';
insert into trs_money_trans_mst (trans_num, trans_date, trans_type,  total, notes, insert_log) values ('UM20101100005',cast('2010-11-19 'as date),1,25000,'','adm;2010-11-19 00:00:00 ');
insert into trs_money_trans_detail (money_trans_id, description, amount, money_id)values (7,'te',25000,1);
update mst_money set saldo = saldo + 25000 where money_id = 1;
call save_to_money_balance(1, '2010-11-19', 25000, 'D');
XA END 'INVISI03cashier';
XA PREPARE 'INVISI03cashier';
XA COMMIT 'INVISI03cashier';

-- Begin on 10/11/19 22:47:51 - cashier
XA START 'INVISI03cashier';
insert into trs_money_trans_mst (trans_num, trans_date, trans_type,  total, notes, insert_log) values ('UM20101100006',cast('2010-11-19 'as date),1,0,'','adm;2010-11-19 00:00:00 ');

-- Begin on 10/11/19 22:48:07 - cashier
XA START 'INVISI03cashier';
insert into trs_money_trans_mst (trans_num, trans_date, trans_type,  total, notes, insert_log) values ('UM20101100006',cast('2010-11-19 'as date),1,25000,'','adm;2010-11-19 00:00:00 ');
insert into trs_money_trans_detail (money_trans_id, description, amount, money_id)values (9,'12212121',25000,1);
update mst_money set saldo = ifnull(saldo,0) + 25000 where money_id = 1;
call save_to_money_balance(1, '2010-11-19', 25000, 'D');
XA END 'INVISI03cashier';
XA PREPARE 'INVISI03cashier';
XA COMMIT 'INVISI03cashier';

-- Begin on 10/11/19 22:49:48 - cashier
XA START 'INVISI03cashier';
insert into trs_money_trans_mst (trans_num, trans_date, trans_type,  total, notes, insert_log) values ('UM20101100001',cast('2010-11-19 'as date),1,4000,'','adm;2010-11-19 00:00:00 ');
insert into trs_money_trans_detail (money_trans_id, description, amount, money_id)values (1,'dari boz',2500,1);
update mst_money set saldo = ifnull(saldo,0) + 2500 where money_id = 1;
call save_to_money_balance(1, '2010-11-19', 2500, 'D');
insert into trs_money_trans_detail (money_trans_id, description, amount, money_id)values (1,'Me,',1500,1);
update mst_money set saldo = ifnull(saldo,0) + 1500 where money_id = 1;
call save_to_money_balance(1, '2010-11-19', 1500, 'D');
XA END 'INVISI03cashier';
XA PREPARE 'INVISI03cashier';
XA COMMIT 'INVISI03cashier';

-- Begin on 10/11/20 09:30:24 - cashier
XA START 'INVISI03cashier';
XA END 'INVISI03cashier';
XA PREPARE 'INVISI03cashier';
XA COMMIT 'INVISI03cashier';

-- Begin on 10/11/20 11:06:52 - cashier
XA START 'INVISI03cashier';
insert into trs_sales_mst (trans_num, trans_type, trans_date, cashier_id, gudang_id, pasien_id, subtotal, profit, disc_mst, disc_val_mst, disc_detail, tax, total, embalase, real_amount, sisa, user_id, shift_id, cash, cara_bayar, card_id, bank, dokter_id,dp, no_resep) values (get_new_sales_num('201011'), 13,cast('2010-11-20 'as date),5,1,NULL,390000,390000,0,0,0,0,390000,0,390000,0,'adm',0,400000,0,'','',NULL,0,'');
insert into trs_sales_detail (sales_id, item_id, quantity, price, disc, disc_val, amount, amount_profit, price_purchase, paket_id, points, hrg_beli, conversion)values ((select sales_id from trs_sales_mst y where y.trans_num = (select max(x.trans_num) from trs_sales_mst x where x.cashier_id = 5) and y.cashier_id = 5), 3,1,320000,4,0,320000,320000,0,NULL,0,0,1);
update mst_item set current_stock = current_stock + -1 where item_id = 3;
call save_to_item_balance(1, 3, cast('2010-11-20 'as date), 1, 'C');
insert into trs_sales_detail (sales_id, item_id, quantity, price, disc, disc_val, amount, amount_profit, price_purchase, paket_id, points, hrg_beli, conversion)values ((select sales_id from trs_sales_mst y where y.trans_num = (select max(x.trans_num) from trs_sales_mst x where x.cashier_id = 5) and y.cashier_id = 5), 6,1,70000,1,0,70000,70000,0,NULL,0,0,1);
update mst_item set current_stock = current_stock + -1 where item_id = 6;
call save_to_item_balance(1, 6, cast('2010-11-20 'as date), 1, 'C');
call save_to_cashier_balance(5, 0, 0, 390000, 13500, 0, 0, 'D', 'adm');
XA END 'INVISI03cashier';
XA PREPARE 'INVISI03cashier';
XA COMMIT 'INVISI03cashier';

-- Begin on 10/11/20 11:24:02 - cashier
XA START 'INVISI03cashier';
insert into trs_sales_mst (trans_num, trans_type, trans_date, cashier_id, gudang_id, pasien_id, subtotal, profit, disc_mst, disc_val_mst, disc_detail, tax, total, embalase, real_amount, sisa, user_id, shift_id, cash, cara_bayar, card_id, bank, dokter_id,dp, no_resep) values (get_new_sales_num('201011'), 13,cast('2010-11-20 'as date),5,1,NULL,57000,57000,0,0,0,0,57000,0,57000,0,'adm',0,60000,0,'','',NULL,0,'');
insert into trs_sales_detail (sales_id, item_id, quantity, price, disc, disc_val, amount, amount_profit, price_purchase, paket_id, points, hrg_beli, conversion)values ((select sales_id from trs_sales_mst y where y.trans_num = (select max(x.trans_num) from trs_sales_mst x where x.cashier_id = 5) and y.cashier_id = 5), 43,1,40000,2,0,40000,40000,34000,NULL,0,0,1);
update mst_item set current_stock = current_stock + -1 where item_id = 43;
call save_to_item_balance(1, 43, cast('2010-11-20 'as date), 1, 'C');
insert into trs_sales_detail (sales_id, item_id, quantity, price, disc, disc_val, amount, amount_profit, price_purchase, paket_id, points, hrg_beli, conversion)values ((select sales_id from trs_sales_mst y where y.trans_num = (select max(x.trans_num) from trs_sales_mst x where x.cashier_id = 5) and y.cashier_id = 5), 53,1,17000,1,0,17000,17000,15000,NULL,0,0,1);
update mst_item set current_stock = current_stock + -1 where item_id = 53;
call save_to_item_balance(1, 53, cast('2010-11-20 'as date), 1, 'C');
call save_to_cashier_balance(5, 0, 0, 57000, 970, 0, 0, 'D', 'adm');
XA END 'INVISI03cashier';
XA PREPARE 'INVISI03cashier';
XA COMMIT 'INVISI03cashier';

-- Begin on 10/11/20 11:56:12 - cashier
XA START 'INVISI03cashier';
insert into trs_sales_mst (trans_num, trans_type, trans_date, cashier_id, gudang_id, pasien_id, subtotal, profit, disc_mst, disc_val_mst, disc_detail, tax, total, embalase, real_amount, sisa, user_id, shift_id, cash, cara_bayar, card_id, bank, dokter_id,dp, no_resep) values (get_new_sales_num('201011'), 13,cast('2010-11-20 'as date),5,1,NULL,255000,255000,0,0,0,0,255000,0,255000,0,'adm',0,300000,0,'','',NULL,0,'');
insert into trs_sales_detail (sales_id, item_id, quantity, price, disc, disc_val, amount, amount_profit, price_purchase, paket_id, points, hrg_beli, conversion)values ((select sales_id from trs_sales_mst y where y.trans_num = (select max(x.trans_num) from trs_sales_mst x where x.cashier_id = 5) and y.cashier_id = 5), 7,1,255000,3,0,255000,255000,217500,NULL,0,0,1);
update mst_item set current_stock = current_stock + -1 where item_id = 7;
call save_to_item_balance(1, 7, cast('2010-11-20 'as date), 1, 'C');
call save_to_cashier_balance(5, 0, 0, 255000, 7650, 0, 0, 'D', 'adm');
XA END 'INVISI03cashier';
XA PREPARE 'INVISI03cashier';
XA COMMIT 'INVISI03cashier';
update system_config set conf_value = '-1'where conf_id = 1;
update system_config set conf_value = '-1'where conf_id = 2;
update system_config set conf_value = 'Harga Sudah Termasuk PPN'where conf_id = 12;
update system_config set conf_value = 'Terimakasih Atas Kunjungn Anda'where conf_id = 13;

-- Begin on 10/11/20 11:58:07 - cashier
XA START 'INVISI03cashier';
insert into trs_sales_mst (trans_num, trans_type, trans_date, cashier_id, gudang_id, pasien_id, subtotal, profit, disc_mst, disc_val_mst, disc_detail, tax, total, embalase, real_amount, sisa, user_id, shift_id, cash, cara_bayar, card_id, bank, dokter_id,dp, no_resep) values (get_new_sales_num('201011'), 13,cast('2010-11-20 'as date),5,1,NULL,255000,37500,0,0,0,0,255000,0,255000,0,'adm',0,300000,0,'','',NULL,0,'');
insert into trs_sales_detail (sales_id, item_id, quantity, price, disc, disc_val, amount, amount_profit, price_purchase, paket_id, points, hrg_beli, conversion)values ((select sales_id from trs_sales_mst y where y.trans_num = (select max(x.trans_num) from trs_sales_mst x where x.cashier_id = 5) and y.cashier_id = 5), 7,1,255000,3,0,255000,37500,217500,NULL,0,217500,1);
update mst_item set current_stock = current_stock + -1 where item_id = 7;
call save_to_item_balance(1, 7, cast('2010-11-20 'as date), 1, 'C');
call save_to_cashier_balance(5, 0, 0, 255000, 7650, 0, 0, 'D', 'adm');
XA END 'INVISI03cashier';
XA PREPARE 'INVISI03cashier';
XA COMMIT 'INVISI03cashier';
update system_config set conf_value = '-1'where conf_id = 1;
update system_config set conf_value = '-1'where conf_id = 2;
update system_config set conf_value = 'Harga Sudah Termasuk PPN'where conf_id = 12;
update system_config set conf_value = 'Terimakasih Atas Kunjungn Anda'where conf_id = 13;

-- Begin on 10/11/20 11:59:09 - cashier
XA START 'INVISI03cashier';
insert into trs_sales_mst (trans_num, trans_type, trans_date, cashier_id, gudang_id, pasien_id, subtotal, profit, disc_mst, disc_val_mst, disc_detail, tax, total, embalase, real_amount, sisa, user_id, shift_id, cash, cara_bayar, card_id, bank, dokter_id,dp, no_resep) values (get_new_sales_num('201011'), 13,cast('2010-11-20 'as date),5,1,NULL,135000,35300,0,0,0,0,135000,0,105000,0,'adm',0,105000,0,'','',NULL,0,'');
insert into trs_sales_detail (sales_id, item_id, quantity, price, disc, disc_val, amount, amount_profit, price_purchase, paket_id, points, hrg_beli, conversion)values ((select sales_id from trs_sales_mst y where y.trans_num = (select max(x.trans_num) from trs_sales_mst x where x.cashier_id = 5) and y.cashier_id = 5), 13,1,135000,2,0,135000,35300,99700,NULL,0,99700,1);
update mst_item set current_stock = current_stock + -1 where item_id = 13;
call save_to_item_balance(1, 13, cast('2010-11-20 'as date), 1, 'C');
call save_to_cashier_balance(5, 0, 0, 135000, 2700, 0, 0, 'D', 'adm');
XA END 'INVISI03cashier';
XA PREPARE 'INVISI03cashier';
XA COMMIT 'INVISI03cashier';

-- Begin on 10/11/20 12:01:12 - cashier
XA START 'INVISI03cashier';
insert into trs_sales_mst (trans_num, trans_type, trans_date, cashier_id, gudang_id, pasien_id, subtotal, profit, disc_mst, disc_val_mst, disc_detail, tax, total, embalase, real_amount, sisa, user_id, shift_id, cash, cara_bayar, card_id, bank, dokter_id,dp, no_resep) values (get_new_sales_num('201011'), 13,cast('2010-11-20 'as date),5,1,NULL,15000,8500,0,0,0,0,15000,0,15000,0,'adm',0,15000,0,'','',NULL,0,'');
insert into trs_sales_detail (sales_id, item_id, quantity, price, disc, disc_val, amount, amount_profit, price_purchase, paket_id, points, hrg_beli, conversion)values ((select sales_id from trs_sales_mst y where y.trans_num = (select max(x.trans_num) from trs_sales_mst x where x.cashier_id = 5) and y.cashier_id = 5), 12,1,15000,1,0,15000,8500,6500,NULL,0,6500,1);
update mst_item set current_stock = current_stock + -1 where item_id = 12;
call save_to_item_balance(1, 12, cast('2010-11-20 'as date), 1, 'C');
call save_to_cashier_balance(5, 0, 0, 15000, 150, 0, 0, 'D', 'adm');
XA END 'INVISI03cashier';
XA PREPARE 'INVISI03cashier';
XA COMMIT 'INVISI03cashier';
update system_config set conf_value = '-1'where conf_id = 1;
update system_config set conf_value = '-1'where conf_id = 2;
update system_config set conf_value = 'Harga Sudah Termasuk PPN'where conf_id = 12;
update system_config set conf_value = 'Terimakasih Atas Kunjungn Anda'where conf_id = 13;

-- Begin on 10/11/20 12:01:55 - cashier
XA START 'INVISI03cashier';
insert into trs_sales_mst (trans_num, trans_type, trans_date, cashier_id, gudang_id, pasien_id, subtotal, profit, disc_mst, disc_val_mst, disc_detail, tax, total, embalase, real_amount, sisa, user_id, shift_id, cash, cara_bayar, card_id, bank, dokter_id,dp, no_resep) values (get_new_sales_num('201011'), 13,cast('2010-11-20 'as date),5,1,NULL,235000,32500,0,0,0,0,235000,0,235000,0,'adm',0,250000,0,'','',NULL,0,'');
insert into trs_sales_detail (sales_id, item_id, quantity, price, disc, disc_val, amount, amount_profit, price_purchase, paket_id, points, hrg_beli, conversion)values ((select sales_id from trs_sales_mst y where y.trans_num = (select max(x.trans_num) from trs_sales_mst x where x.cashier_id = 5) and y.cashier_id = 5), 16,1,235000,3,0,235000,32500,202500,NULL,0,202500,1);
update mst_item set current_stock = current_stock + -1 where item_id = 16;
call save_to_item_balance(1, 16, cast('2010-11-20 'as date), 1, 'C');
call save_to_cashier_balance(5, 0, 0, 235000, 7050, 0, 0, 'D', 'adm');
XA END 'INVISI03cashier';
XA PREPARE 'INVISI03cashier';
XA COMMIT 'INVISI03cashier';

-- Begin on 10/11/20 12:03:47 - cashier
XA START 'INVISI03cashier';
insert into trs_sales_mst (trans_num, trans_type, trans_date, cashier_id, gudang_id, pasien_id, subtotal, profit, disc_mst, disc_val_mst, disc_detail, tax, total, embalase, real_amount, sisa, user_id, shift_id, cash, cara_bayar, card_id, bank, dokter_id,dp, no_resep) values (get_new_sales_num('201011'), 13,cast('2010-11-20 'as date),5,1,NULL,135000,35300,0,0,0,0,135000,0,135000,0,'adm',0,150000,0,'','',NULL,0,'');
insert into trs_sales_detail (sales_id, item_id, quantity, price, disc, disc_val, amount, amount_profit, price_purchase, paket_id, points, hrg_beli, conversion)values ((select sales_id from trs_sales_mst y where y.trans_num = (select max(x.trans_num) from trs_sales_mst x where x.cashier_id = 5) and y.cashier_id = 5), 13,1,135000,2,0,135000,35300,99700,NULL,0,99700,1);
update mst_item set current_stock = current_stock + -1 where item_id = 13;
call save_to_item_balance(1, 13, cast('2010-11-20 'as date), 1, 'C');
call save_to_cashier_balance(5, 0, 0, 135000, 2700, 0, 0, 'D', 'adm');
XA END 'INVISI03cashier';
XA PREPARE 'INVISI03cashier';
XA COMMIT 'INVISI03cashier';

-- Begin on 10/11/21 11:09:01 - cashier
XA START 'INVISI03cashier';
XA END 'INVISI03cashier';
XA PREPARE 'INVISI03cashier';
XA COMMIT 'INVISI03cashier';
insert into mst_akun (nama, kode, tipe ) values ('Biaya Gaji', '001', 1);
insert into mst_akun (nama, kode, tipe ) values ('Biaya Gaji', '001', 1);
insert into mst_akun (nama, kode, tipe ) values ('Biaya Listrik', '001', 1);
update mst_akun set nama = 'Biaya Listrik P', kode = '002' where akun_id = 2;

-- Begin on 10/11/23 14:40:20 - petShop
XA START 'INVISI03petShop';
insert into trs_money_trans_mst (trans_num, trans_date, trans_type,  total, notes, insert_log) values ('UM20101100003',cast('2010-11-23 'as date),1,154000,'','adm;2010-11-23 00:00:00 ');
insert into trs_money_trans_detail (money_trans_id, description, amount,akun_id, money_id)values (4,'bulan desember 2010',154000,2,1);
update mst_money set saldo = ifnull(saldo,0) + 154000 where money_id = 1;
call save_to_money_balance(1, '2010-11-23', 154000, 'D');
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';
insert into mst_akun (nama, kode, tipe ) values ('Biya Refreshing', '003', 1);
insert into mst_akun (nama, kode, tipe ) values ('Biya Refreshing tes', '003', 1);
insert into mst_akun (nama, kode, tipe ) values ('Biaya gono gini', '004', 1);

-- Begin on 10/11/24 09:08:43 - petShop
XA START 'INVISI03petShop';
insert into trs_item_use_mst (trans_num, trans_date, tipe,  notes, total,insert_log) values ('UK20101100001',cast('2010-11-24 'as date),0,'Coba',0,'adm;2010-11-24 00:00:00 ');
insert into trs_item_use_detail (item_use_id, item_id,quantity,buying_price,amount)values (1,0,45,229500,229500);
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA ROLLBACK 'INVISI03petShop';

-- Begin on 10/11/24 09:10:32 - petShop
XA START 'INVISI03petShop';
insert into trs_item_use_mst (trans_num, trans_date, tipe,  notes, total,insert_log) values ('UK20101100001',cast('2010-11-24 'as date),0,'Coba',0,'adm;2010-11-24 00:00:00 ');
insert into trs_item_use_detail (item_use_id, item_id,quantity,buying_price,amount)values (2,53,1,15000,15000);
update mst_item set current_stock = current_stock + -1 where item_id = 53;
call save_to_item_balance(1, 53, cast('2010-11-24 'as date), 1, 'C');
insert into trs_item_use_detail (item_use_id, item_id,quantity,buying_price,amount)values (2,45,1,229500,229500);
update mst_item set current_stock = current_stock + -1 where item_id = 45;
call save_to_item_balance(1, 45, cast('2010-11-24 'as date), 1, 'C');
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/11/24 09:10:33 - petShop
XA START 'INVISI03petShop';
update mst_item set current_stock = current_stock + -15 where item_id = 1;
call save_to_item_balance(1, 1, cast('2010-11-02 'as date), 15, 'C');
update trs_receipt_mst set sisa = sisa - 97500 where receipt_id = 1;
update trs_retur_mst set status_id = 1 where retur_id = 2;
call save_to_relation_balance(1, cast('2010-11-02 'as date), 97500, 'C');
update mst_relation set current_debt = current_debt + -97500 where relation_id = 1;
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';
insert into mst_akun (nama, kode, tipe ) values ('Modal Awal', '006', 1);
update mst_akun set nama = 'Biaya Refreshing', tipe = 2, kode = '003' where akun_id = 3;
update mst_akun set nama = 'Biaya Listrik P', tipe = 2, kode = '002' where akun_id = 2;
update mst_akun set nama = 'Biaya gono gini', tipe = 2, kode = '004' where akun_id = 5;
update mst_akun set nama = 'Biaya Gaji', tipe = 2, kode = '001' where akun_id = 1;
update mst_akun set nama = 'Akomodasi', tipe = 2, kode = '005' where akun_id = 6;

-- Begin on 10/11/25 13:10:54 - petShop
XA START 'INVISI03petShop';
UPDATE mst_service_price SET service_id = 1,animal_id =4,price =25000,add_price =0,discount =2,edit_log ='adm;2010-11-25 13:10:54 ' WHERE service_price_id =43;
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/11/25 13:10:55 - petShop
XA START 'INVISI03petShop';
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/11/25 13:19:21 - petShop
XA START 'INVISI03petShop';
UPDATE Mst_Relation_Animal SET Animal_Name='Wewey', Animal_ID=5, Race='Blasteran', Eat='Standar', Age=4, Sex=0 WHERE Relation_ID=7 AND Seq=1;
INSERT INTO Mst_Relation_Animal (Relation_ID,Seq,Animal_Name,Animal_ID,Race,Eat,Age,Sex) VALUES (7,2,'memey',5,'fgadf','daf',2,0);
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/11/25 13:19:33 - petShop
XA START 'INVISI03petShop';
delete from mst_relation_animal where relation_id =7 and seq=2;
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/11/25 13:35:57 - cashier
XA START 'INVISI03cashier';
XA END 'INVISI03cashier';
XA PREPARE 'INVISI03cashier';
XA COMMIT 'INVISI03cashier';

-- Begin on 10/11/25 13:36:30 - cashier
XA START 'INVISI03cashier';
XA END 'INVISI03cashier';
XA PREPARE 'INVISI03cashier';
XA ROLLBACK 'INVISI03cashier';

-- Begin on 10/11/25 13:38:03 - cashier
XA START 'INVISI03cashier';
XA END 'INVISI03cashier';
XA PREPARE 'INVISI03cashier';
XA COMMIT 'INVISI03cashier';

-- Begin on 10/11/26 13:05:20 - petShop
XA START 'INVISI03petShop';
update mst_relation set  relation_type= 1, relation_code= 'CS.001', relation_name= 'Fredy', address1= 'Antapani', address2= 'Ancol', post_code= '', city= 'Bandung', phone1= '0226587450', phone2= '0888954100', npwp= '', contact_person = 'Adrul', discount = 15, wajib_discount = 1, due_Date= 0 where relation_id= 2;
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/11/26 13:11:55 - cashier
XA START 'INVISI03cashier';
XA END 'INVISI03cashier';
XA PREPARE 'INVISI03cashier';
XA COMMIT 'INVISI03cashier';

-- Begin on 10/11/26 13:13:09 - cashier
XA START 'INVISI03cashier';
XA END 'INVISI03cashier';
XA PREPARE 'INVISI03cashier';
XA COMMIT 'INVISI03cashier';

-- Begin on 10/11/26 13:24:44 - cashier
XA START 'INVISI03cashier';
XA END 'INVISI03cashier';
XA PREPARE 'INVISI03cashier';
XA COMMIT 'INVISI03cashier';

-- Begin on 10/11/26 13:43:06 - cashier
XA START 'INVISI03cashier';
XA END 'INVISI03cashier';
XA PREPARE 'INVISI03cashier';
XA COMMIT 'INVISI03cashier';

-- Begin on 10/11/26 14:30:33 - cashier
XA START 'INVISI03cashier';
XA END 'INVISI03cashier';
XA PREPARE 'INVISI03cashier';
XA COMMIT 'INVISI03cashier';

-- Begin on 10/11/29 15:21:15 - petShop
XA START 'INVISI03petShop';
UPDATE Mst_Relation_Animal SET Animal_Name='Robby', Animal_ID=1, Race='Arab', Eat='Laron', Age=2, Sex=1 WHERE Relation_ID=6 AND Seq=1;
INSERT INTO Mst_Relation_Animal (Relation_ID,Seq,Animal_Name,Animal_ID,Race,Eat,Age,Sex) VALUES (6,2,'Ricky',5,'Hongkong','Susis',2,0);
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/11/29 15:21:16 - petShop
XA START 'INVISI03petShop';
UPDATE Mst_Relation_Animal SET Animal_Name='Robby', Animal_ID=1, Race='Arab', Eat='Laron', Age=2, Sex=1 WHERE Relation_ID=6 AND Seq=1;
UPDATE Mst_Relation_Animal SET Animal_Name='Ricky', Animal_ID=5, Race='Hongkong', Eat='Susis', Age=2, Sex=0 WHERE Relation_ID=6 AND Seq=2;
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/11/29 15:21:18 - petShop
XA START 'INVISI03petShop';
UPDATE Mst_Relation_Animal SET Animal_Name='Robby', Animal_ID=1, Race='Arab', Eat='Laron', Age=2, Sex=1 WHERE Relation_ID=6 AND Seq=1;
UPDATE Mst_Relation_Animal SET Animal_Name='Ricky', Animal_ID=5, Race='Hongkong', Eat='Susis', Age=2, Sex=0 WHERE Relation_ID=6 AND Seq=2;
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/11/29 16:20:11 - cashier
XA START 'INVISI03cashier';
insert into trs_sales_mst (trans_num, trans_type, trans_date, cashier_id, gudang_id, pasien_id, subtotal, profit, disc_mst, disc_val_mst, disc_detail, tax, total, embalase, real_amount, sisa, user_id, shift_id, cash, cara_bayar, card_id, bank, dokter_id,dp, no_resep) values (get_new_sales_num('201011'), 13,cast('2010-11-29 'as date),5,1,NULL,271875,54375,0,0,0,0,271875,0,271875,0,'adm',0,300000,0,'','',NULL,0,'');
insert into trs_sales_detail (sales_id, item_id, quantity, price, disc, disc_val, amount, amount_profit, price_purchase, paket_id, points, hrg_beli, conversion)values ((select sales_id from trs_sales_mst y where y.trans_num = (select max(x.trans_num) from trs_sales_mst x where x.cashier_id = 5) and y.cashier_id = 5), 7,1,271875,3,0,271875,54375,217500,NULL,0,217500,1);
update mst_item set current_stock = current_stock + -1 where item_id = 7;
call save_to_item_balance(1, 7, cast('2010-11-29 'as date), 1, 'C');
call save_to_cashier_balance(5, 0, 0, 271875, 8156.25, 0, 0, 'D', 'adm');
XA END 'INVISI03cashier';
XA PREPARE 'INVISI03cashier';
XA COMMIT 'INVISI03cashier';

-- Begin on 10/11/29 16:21:23 - cashier
XA START 'INVISI03cashier';
insert into trs_sales_mst (trans_num, trans_type, trans_date, cashier_id, gudang_id, pasien_id, subtotal, profit, disc_mst, disc_val_mst, disc_detail, tax, total, embalase, real_amount, sisa, user_id, shift_id, cash, cara_bayar, card_id, bank, dokter_id,dp, no_resep) values (get_new_sales_num('201011'), 13,cast('2010-11-29 'as date),5,1,NULL,229687.5,45938,0,0,0,0,229687.5,0,229687.5,0,'adm',0,300000,0,'','',NULL,0,'');
insert into trs_sales_detail (sales_id, item_id, quantity, price, disc, disc_val, amount, amount_profit, price_purchase, paket_id, points, hrg_beli, conversion)values ((select sales_id from trs_sales_mst y where y.trans_num = (select max(x.trans_num) from trs_sales_mst x where x.cashier_id = 5) and y.cashier_id = 5), 9,1,229687.5,3,0,229687.5,45938,183750,NULL,0,183750,1);
update mst_item set current_stock = current_stock + -1 where item_id = 9;
call save_to_item_balance(1, 9, cast('2010-11-29 'as date), 1, 'C');
call save_to_cashier_balance(5, 0, 0, 229687.5, 6890.625, 0, 0, 'D', 'adm');
XA END 'INVISI03cashier';
XA PREPARE 'INVISI03cashier';
XA COMMIT 'INVISI03cashier';

-- Begin on 10/11/29 16:22:25 - cashier
XA START 'INVISI03cashier';
insert into trs_sales_mst (trans_num, trans_type, trans_date, cashier_id, gudang_id, pasien_id, subtotal, profit, disc_mst, disc_val_mst, disc_detail, tax, total, embalase, real_amount, sisa, user_id, shift_id, cash, cara_bayar, card_id, bank, dokter_id,dp, no_resep) values (get_new_sales_num('201011'), 13,cast('2010-11-29 'as date),5,1,NULL,290000,58000,0,0,0,0,290000,0,290000,0,'adm',0,300000,0,'','',NULL,0,'');
insert into trs_sales_detail (sales_id, item_id, quantity, price, disc, disc_val, amount, amount_profit, price_purchase, paket_id, points, hrg_beli, conversion)values ((select sales_id from trs_sales_mst y where y.trans_num = (select max(x.trans_num) from trs_sales_mst x where x.cashier_id = 5) and y.cashier_id = 5), 17,1,290000,3,0,290000,58000,232000,NULL,0,232000,1);
update mst_item set current_stock = current_stock + -1 where item_id = 17;
call save_to_item_balance(1, 17, cast('2010-11-29 'as date), 1, 'C');
call save_to_cashier_balance(5, 0, 0, 290000, 8700, 0, 0, 'D', 'adm');
XA END 'INVISI03cashier';
XA PREPARE 'INVISI03cashier';
XA COMMIT 'INVISI03cashier';

-- Begin on 10/11/29 16:24:09 - cashier
XA START 'INVISI03cashier';
insert into trs_sales_mst (trans_num, trans_type, trans_date, cashier_id, gudang_id, pasien_id, subtotal, profit, disc_mst, disc_val_mst, disc_detail, tax, total, embalase, real_amount, sisa, user_id, shift_id, cash, cara_bayar, card_id, bank, dokter_id,dp, no_resep) values (get_new_sales_num('201011'), 13,cast('2010-11-29 'as date),5,1,NULL,183750,36750,0,0,0,0,183750,0,183750,0,'adm',0,200000,0,'','',NULL,0,'');
insert into trs_sales_detail (sales_id, item_id, quantity, price, disc, disc_val, amount, amount_profit, price_purchase, paket_id, points, hrg_beli, conversion)values ((select sales_id from trs_sales_mst y where y.trans_num = (select max(x.trans_num) from trs_sales_mst x where x.cashier_id = 5) and y.cashier_id = 5), 20,1,183750,2,0,183750,36750,147000,NULL,0,147000,1);
update mst_item set current_stock = current_stock + -1 where item_id = 20;
call save_to_item_balance(1, 20, cast('2010-11-29 'as date), 1, 'C');
call save_to_cashier_balance(5, 0, 0, 183750, 3675, 0, 0, 'D', 'adm');
XA END 'INVISI03cashier';
XA PREPARE 'INVISI03cashier';
XA COMMIT 'INVISI03cashier';

-- Begin on 10/11/29 16:44:04 - petShop
XA START 'INVISI03petShop';
UPDATE Mst_Relation_Animal SET Animal_Name='Wewey', Animal_ID=5, Race='Blasteran', Eat='Standar', Age=4, Sex=0 WHERE Relation_ID=7 AND Seq=1;
INSERT INTO Mst_Relation_Animal (Relation_ID,Seq,Animal_Name,Animal_ID,Race,Eat,Age,Sex) VALUES (7,2,'',6,'','',0,0);
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/11/29 16:45:20 - petShop
XA START 'INVISI03petShop';
UPDATE Mst_Relation_Animal SET Animal_Name='Wewey', Animal_ID=5, Race='Blasteran', Eat='Standar', Age=4, Sex=0 WHERE Relation_ID=7 AND Seq=1;
UPDATE Mst_Relation_Animal SET Animal_Name='', Animal_ID=6, Race='2', Eat='', Age=0, Sex=0 WHERE Relation_ID=7 AND Seq=2;
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/11/29 16:47:51 - petShop
XA START 'INVISI03petShop';
UPDATE Mst_Relation_Animal SET Animal_Name='Wewey', Animal_ID=5, Race='Blasteran', Eat='Standar', Age=4, Sex=0 WHERE Relation_ID=7 AND Seq=1;
UPDATE Mst_Relation_Animal SET Animal_Name='', Animal_ID=6, Race='31', Eat='', Age=0, Sex=0 WHERE Relation_ID=7 AND Seq=2;
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/11/29 16:47:52 - petShop
XA START 'INVISI03petShop';
UPDATE Mst_Relation_Animal SET Animal_Name='Wewey', Animal_ID=5, Race='Blasteran', Eat='Standar', Age=4, Sex=0 WHERE Relation_ID=7 AND Seq=1;
UPDATE Mst_Relation_Animal SET Animal_Name='', Animal_ID=6, Race='31', Eat='', Age=0, Sex=0 WHERE Relation_ID=7 AND Seq=2;
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/11/29 16:48:15 - petShop
XA START 'INVISI03petShop';
UPDATE Mst_Relation_Animal SET Animal_Name='Wewey', Animal_ID=5, Race='Blasteran', Eat='Standar', Age=4, Sex=0 WHERE Relation_ID=7 AND Seq=1;
UPDATE Mst_Relation_Animal SET Animal_Name='', Animal_ID=6, Race='31', Eat='fasdf', Age=0, Sex=0 WHERE Relation_ID=7 AND Seq=2;
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/11/29 16:49:57 - petShop
XA START 'INVISI03petShop';
UPDATE Mst_Relation_Animal SET Animal_Name='Wewey', Animal_ID=5, Race='Blasteran', Eat='Standar', Age=4, Sex=0 WHERE Relation_ID=7 AND Seq=1;
UPDATE Mst_Relation_Animal SET Animal_Name='', Animal_ID=6, Race='31', Eat='adsfasf', Age=0, Sex=0 WHERE Relation_ID=7 AND Seq=2;
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/11/29 16:52:49 - petShop
XA START 'INVISI03petShop';
UPDATE Mst_Relation_Animal SET Animal_Name='Wewey', Animal_ID=5, Race='Blasteran', Eat='Standar', Age=4, Sex=0 WHERE Relation_ID=7 AND Seq=1;
UPDATE Mst_Relation_Animal SET Animal_Name='', Animal_ID=6, Race='31', Eat='adsfasf', Age=0, Sex=0 WHERE Relation_ID=7 AND Seq=2;
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/11/29 16:52:53 - petShop
XA START 'INVISI03petShop';
UPDATE Mst_Relation_Animal SET Animal_Name='Wewey', Animal_ID=5, Race='Blasteran', Eat='Standar', Age=4, Sex=0 WHERE Relation_ID=7 AND Seq=1;
UPDATE Mst_Relation_Animal SET Animal_Name='wiwiy', Animal_ID=6, Race='31', Eat='adsfasf', Age=0, Sex=0 WHERE Relation_ID=7 AND Seq=2;
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/11/29 16:52:54 - petShop
XA START 'INVISI03petShop';
UPDATE Mst_Relation_Animal SET Animal_Name='Wewey', Animal_ID=5, Race='Blasteran', Eat='Standar', Age=4, Sex=0 WHERE Relation_ID=7 AND Seq=1;
UPDATE Mst_Relation_Animal SET Animal_Name='wiwiy', Animal_ID=6, Race='31', Eat='adsfasf', Age=0, Sex=0 WHERE Relation_ID=7 AND Seq=2;
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/11/29 16:54:50 - petShop
XA START 'INVISI03petShop';
UPDATE Mst_Relation_Animal SET Animal_Name='Wewey', Animal_ID=5, Race='Blasteran', Eat='Standar', Age=4, Sex=0 WHERE Relation_ID=7 AND Seq=1;
UPDATE Mst_Relation_Animal SET Animal_Name='wiwiy', Animal_ID=6, Race='31', Eat='adsfasf', Age=0, Sex=0 WHERE Relation_ID=7 AND Seq=2;
INSERT INTO Mst_Relation_Animal (Relation_ID,Seq,Animal_Name,Animal_ID,Race,Eat,Age,Sex) VALUES (7,3,'wowoy',4,'','',0,0);
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/11/30 10:58:11 - petShop
XA START 'INVISI03petShop';
update mst_relation set  relation_type= 1, relation_code= 'CS.004', relation_name= 'Sisi', address1= 'Jl. 1', address2= 'Jl. 2', post_code= '1313', city= 'Banjar', phone1= '2478550', phone2= '45648700', npwp= '', contact_person = 'teteh', discount = 7, wajib_discount = 0, due_Date= 0 where relation_id= 7;
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/11/30 10:58:17 - petShop
XA START 'INVISI03petShop';
update mst_relation set  relation_type= 1, relation_code= 'CS.004', relation_name= 'Sisi', address1= 'Jl. 1', address2= 'Jl. 2', post_code= '1313', city= 'Banjar', phone1= '2478550', phone2= '45648700', npwp= '', contact_person = 'tetehhgh', discount = 0, wajib_discount = 0, due_Date= 0 where relation_id= 7;
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/11/30 11:22:48 - petShop
XA START 'INVISI03petShop';
update system_config set conf_value = '5'where conf_id = 15;
update mst_service_bonus set jml_service= 1,bonus_service=2,bonus_jml=1 where service_type=27;
update mst_service_bonus set jml_service= 1,bonus_service=3,bonus_jml=2 where service_type=28;
update mst_service_bonus set jml_service= 1,bonus_service=28,bonus_jml=1 where service_type=29;
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/11/30 11:24:07 - petShop
XA START 'INVISI03petShop';
update system_config set conf_value = '5'where conf_id = 15;
update mst_service_bonus set jml_service= 1,bonus_service=2,bonus_jml=1 where service_type=27;
update mst_service_bonus set jml_service= 1,bonus_service=1,bonus_jml=2 where service_type=28;
update mst_service_bonus set jml_service= 1,bonus_service=0,bonus_jml=1 where service_type=29;
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/11/30 11:24:13 - petShop
XA START 'INVISI03petShop';
update system_config set conf_value = '5'where conf_id = 15;
update mst_service_bonus set jml_service= 1,bonus_service=2,bonus_jml=1 where service_type=27;
update mst_service_bonus set jml_service= 1,bonus_service=1,bonus_jml=2 where service_type=28;
update mst_service_bonus set jml_service= 1,bonus_service=1,bonus_jml=1 where service_type=29;
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/11/30 11:24:25 - petShop
XA START 'INVISI03petShop';
update system_config set conf_value = '5'where conf_id = 15;
update mst_service_bonus set jml_service= 1,bonus_service=2,bonus_jml=1 where service_type=27;
update mst_service_bonus set jml_service= 1,bonus_service=1,bonus_jml=2 where service_type=28;
update mst_service_bonus set jml_service= 1,bonus_service=5,bonus_jml=1 where service_type=29;
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/11/30 11:44:37 - cashier
XA START 'INVISI03cashier';
insert into mst_relation (relation_type, relation_code, relation_name, address1, address2, post_code, city, phone1, phone2, contact_person, npwp,discount,wajib_discount, due_date) values (1,'CS.007','Andre','','','','','','','','',5,1,0);
XA END 'INVISI03cashier';
XA PREPARE 'INVISI03cashier';
XA COMMIT 'INVISI03cashier';

-- Begin on 10/11/30 11:44:44 - cashier
XA START 'INVISI03cashier';
update mst_relation set  relation_type= 1, relation_code= 'CS.007', relation_name= 'Andre', address1= 'cimohay ', address2= '', post_code= '', city= '', phone1= '', phone2= '', npwp= '', contact_person = '', discount = 5, wajib_discount = 1, due_Date= 0 where relation_id= 10;
XA END 'INVISI03cashier';
XA PREPARE 'INVISI03cashier';
XA COMMIT 'INVISI03cashier';

-- Begin on 10/11/30 16:25:27 - petShop
XA START 'INVISI03petShop';
update mst_item set  discount = 2 WHERE item_id = 43;
update mst_item set  discount = 2 WHERE item_id = 43;
update mst_item set  discount = 2 WHERE item_id = 53;
update mst_item set  discount = 2 WHERE item_id = 53;
update mst_item set  discount = 2 WHERE item_id = 3;
update mst_item set  discount = 2 WHERE item_id = 3;
update mst_item set  discount = 2 WHERE item_id = 56;
update mst_item set  discount = 2 WHERE item_id = 56;
update mst_item set  discount = 2 WHERE item_id = 50;
update mst_item set  discount = 2 WHERE item_id = 50;
update mst_item set  discount = 2 WHERE item_id = 45;
update mst_item set  discount = 2 WHERE item_id = 45;
update mst_item set  discount = 2 WHERE item_id = 52;
update mst_item set  discount = 2 WHERE item_id = 52;
update mst_item set  discount = 2 WHERE item_id = 51;
update mst_item set  discount = 2 WHERE item_id = 51;
update mst_item set  discount = 2 WHERE item_id = 59;
update mst_item set  discount = 2 WHERE item_id = 59;
update mst_item set  discount = 2 WHERE item_id = 14;
update mst_item set  discount = 2 WHERE item_id = 14;
update mst_item set  discount = 2 WHERE item_id = 8;
update mst_item set  discount = 2 WHERE item_id = 8;
update mst_item set  discount = 2 WHERE item_id = 25;
update mst_item set  discount = 2 WHERE item_id = 25;
update mst_item set  discount = 2 WHERE item_id = 37;
update mst_item set  discount = 2 WHERE item_id = 37;
update mst_item set  discount = 2 WHERE item_id = 47;
update mst_item set  discount = 2 WHERE item_id = 47;
update mst_item set  discount = 2 WHERE item_id = 46;
update mst_item set  discount = 2 WHERE item_id = 46;
update mst_item set  discount = 2 WHERE item_id = 10;
update mst_item set  discount = 2 WHERE item_id = 10;
update mst_item set  discount = 2 WHERE item_id = 55;
update mst_item set  discount = 2 WHERE item_id = 55;
update mst_item set  discount = 2 WHERE item_id = 18;
update mst_item set  discount = 2 WHERE item_id = 18;
update mst_item set  discount = 2 WHERE item_id = 7;
update mst_item set  discount = 2 WHERE item_id = 7;
update mst_item set  discount = 2 WHERE item_id = 48;
update mst_item set  discount = 2 WHERE item_id = 48;
update mst_item set  discount = 2 WHERE item_id = 15;
update mst_item set  discount = 2 WHERE item_id = 15;
update mst_item set  discount = 2 WHERE item_id = 11;
update mst_item set  discount = 2 WHERE item_id = 11;
update mst_item set  discount = 2 WHERE item_id = 1;
update mst_item set  discount = 2 WHERE item_id = 1;
update mst_item set  discount = 2 WHERE item_id = 17;
update mst_item set  discount = 2 WHERE item_id = 17;
update mst_item set  discount = 2 WHERE item_id = 63;
update mst_item set  discount = 2 WHERE item_id = 63;
update mst_item set  discount = 2 WHERE item_id = 23;
update mst_item set  discount = 2 WHERE item_id = 23;
update mst_item set  discount = 2 WHERE item_id = 34;
update mst_item set  discount = 2 WHERE item_id = 34;
update mst_item set  discount = 2 WHERE item_id = 22;
update mst_item set  discount = 2 WHERE item_id = 22;
update mst_item set  discount = 2 WHERE item_id = 61;
update mst_item set  discount = 2 WHERE item_id = 61;
update mst_item set  discount = 2 WHERE item_id = 27;
update mst_item set  discount = 2 WHERE item_id = 27;
update mst_item set  discount = 2 WHERE item_id = 42;
update mst_item set  discount = 2 WHERE item_id = 42;
update mst_item set  discount = 2 WHERE item_id = 64;
update mst_item set  discount = 2 WHERE item_id = 64;
update mst_item set  discount = 2 WHERE item_id = 24;
update mst_item set  discount = 2 WHERE item_id = 24;
update mst_item set  discount = 2 WHERE item_id = 12;
update mst_item set  discount = 2 WHERE item_id = 12;
update mst_item set  discount = 2 WHERE item_id = 35;
update mst_item set  discount = 2 WHERE item_id = 35;
update mst_item set  discount = 2 WHERE item_id = 13;
update mst_item set  discount = 2 WHERE item_id = 13;
update mst_item set  discount = 2 WHERE item_id = 20;
update mst_item set  discount = 2 WHERE item_id = 20;
update mst_item set  discount = 2 WHERE item_id = 60;
update mst_item set  discount = 2 WHERE item_id = 60;
update mst_item set  discount = 2 WHERE item_id = 33;
update mst_item set  discount = 2 WHERE item_id = 33;
update mst_item set  discount = 2 WHERE item_id = 39;
update mst_item set  discount = 2 WHERE item_id = 39;
update mst_item set  discount = 2 WHERE item_id = 19;
update mst_item set  discount = 2 WHERE item_id = 19;
update mst_item set  discount = 2 WHERE item_id = 31;
update mst_item set  discount = 2 WHERE item_id = 31;
update mst_item set  discount = 2 WHERE item_id = 40;
update mst_item set  discount = 2 WHERE item_id = 40;
update mst_item set  discount = 2 WHERE item_id = 21;
update mst_item set  discount = 2 WHERE item_id = 21;
update mst_item set  discount = 2 WHERE item_id = 49;
update mst_item set  discount = 2 WHERE item_id = 49;
update mst_item set  discount = 2 WHERE item_id = 44;
update mst_item set  discount = 2 WHERE item_id = 44;
update mst_item set  discount = 2 WHERE item_id = 29;
update mst_item set  discount = 2 WHERE item_id = 29;
update mst_item set  discount = 2 WHERE item_id = 57;
update mst_item set  discount = 2 WHERE item_id = 57;
update mst_item set  discount = 2 WHERE item_id = 36;
update mst_item set  discount = 2 WHERE item_id = 36;
update mst_item set  discount = 2 WHERE item_id = 38;
update mst_item set  discount = 2 WHERE item_id = 38;
update mst_item set  discount = 2 WHERE item_id = 26;
update mst_item set  discount = 2 WHERE item_id = 26;
update mst_item set  discount = 2 WHERE item_id = 41;
update mst_item set  discount = 2 WHERE item_id = 41;
update mst_item set  discount = 2 WHERE item_id = 58;
update mst_item set  discount = 2 WHERE item_id = 58;
update mst_item set  discount = 2 WHERE item_id = 4;
update mst_item set  discount = 2 WHERE item_id = 4;
update mst_item set  discount = 2 WHERE item_id = 16;
update mst_item set  discount = 2 WHERE item_id = 16;
update mst_item set  discount = 2 WHERE item_id = 9;
update mst_item set  discount = 2 WHERE item_id = 9;
update mst_item set  discount = 2 WHERE item_id = 5;
update mst_item set  discount = 2 WHERE item_id = 5;
update mst_item set  discount = 2 WHERE item_id = 2;
update mst_item set  discount = 2 WHERE item_id = 2;
update mst_item set  discount = 2 WHERE item_id = 6;
update mst_item set  discount = 2 WHERE item_id = 6;
update mst_item set  discount = 2 WHERE item_id = 54;
update mst_item set  discount = 2 WHERE item_id = 54;
update mst_item set  discount = 2 WHERE item_id = 32;
update mst_item set  discount = 2 WHERE item_id = 32;
update mst_item set  discount = 2 WHERE item_id = 30;
update mst_item set  discount = 2 WHERE item_id = 30;
update mst_item set  discount = 2 WHERE item_id = 28;
update mst_item set  discount = 2 WHERE item_id = 28;
update mst_item set  discount = 2 WHERE item_id = 62;
update mst_item set  discount = 2 WHERE item_id = 62;
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/12/01 11:25:15 - cashier
XA START 'INVISI03cashier';
delete from mst_relation_animal where relation_id =11 and seq=0;
XA END 'INVISI03cashier';
XA PREPARE 'INVISI03cashier';
XA COMMIT 'INVISI03cashier';

-- Begin on 10/12/01 11:25:16 - cashier
XA START 'INVISI03cashier';
UPDATE Mst_Relation_Animal SET Animal_Name='Puddle', Animal_ID=3, Race='', Eat='', Age=0, Sex=0 WHERE Relation_ID=11 AND Seq=1;
INSERT INTO Mst_Relation_Animal (Relation_ID,Seq,Animal_Name,Animal_ID,Race,Eat,Age,Sex) VALUES (11,2,'Muddle',4,'fd','d',2,0);
XA END 'INVISI03cashier';
XA PREPARE 'INVISI03cashier';
XA COMMIT 'INVISI03cashier';

-- Begin on 10/12/01 14:44:26 - petShop
XA START 'INVISI03petShop';
update mst_service set  service_code= 'S005', service_name= 'Cukur Bulu', notes= 'Cek', service_type= 30, edit_log= 'adm;2010-12-01 14:44:26 ' where service_id= 5;
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/12/01 16:51:53 - cashier
XA START 'INVISI03cashier';
insert into trs_sales_mst (trans_num, trans_type, trans_date, cashier_id, gudang_id, pasien_id, subtotal, profit, disc_mst, disc_val_mst, disc_detail, tax, total, embalase, real_amount, sisa, user_id, shift_id, cash, cara_bayar, card_id, bank, dokter_id,dp, no_resep) values (get_new_sales_num('201012'), 13,cast('2010-12-01 'as date),5,1,7,20000,0,0,0,0,0,20000,0,20000,0,'adm',0,20000,0,'','',NULL,0,'');
insert into trs_sales_detail (sales_id, item_id, quantity, price, disc, disc_val, amount, amount_profit, price_purchase, paket_id, points, hrg_beli, conversion)values ((select sales_id from trs_sales_mst y where y.trans_num = (select max(x.trans_num) from trs_sales_mst x where x.cashier_id = 5) and y.cashier_id = 5), NULL,1,20000,0,0,20000,20000,0,5,0,0,1);
call put_customer_service(7,30,1);
call save_to_cashier_balance(5, 0, 0, 20000, 0, 0, 0, 'D', 'adm');
XA END 'INVISI03cashier';
XA PREPARE 'INVISI03cashier';
XA COMMIT 'INVISI03cashier';

-- Begin on 10/12/01 16:52:18 - cashier
XA START 'INVISI03cashier';
XA END 'INVISI03cashier';
XA PREPARE 'INVISI03cashier';
XA COMMIT 'INVISI03cashier';

-- Begin on 10/12/01 17:23:23 - cashier
XA START 'INVISI03cashier';
insert into trs_sales_mst (trans_num, trans_type, trans_date, cashier_id, gudang_id, pasien_id, subtotal, profit, disc_mst, disc_val_mst, disc_detail, tax, total, embalase, real_amount, sisa, user_id, shift_id, cash, cara_bayar, card_id, bank, dokter_id,dp, no_resep) values (get_new_sales_num('201012'), 13,cast('2010-12-01 'as date),5,1,7,10000,0,0,0,0,0,10000,0,10000,0,'adm',0,10000,0,'','',NULL,0,'');
insert into trs_sales_detail (sales_id, item_id, quantity, price, disc, disc_val, amount, amount_profit, price_purchase, paket_id, points, hrg_beli, conversion)values ((select sales_id from trs_sales_mst y where y.trans_num = (select max(x.trans_num) from trs_sales_mst x where x.cashier_id = 5) and y.cashier_id = 5), NULL,1,10000,0,0,10000,10000,0,6,0,0,1);
call put_customer_service(7,29,1);
call save_to_cashier_balance(5, 0, 0, 10000, 0, 0, 0, 'D', 'adm');
XA END 'INVISI03cashier';
XA PREPARE 'INVISI03cashier';
XA COMMIT 'INVISI03cashier';

-- Begin on 10/12/01 17:24:03 - cashier
XA START 'INVISI03cashier';
insert into trs_sales_mst (trans_num, trans_type, trans_date, cashier_id, gudang_id, pasien_id, subtotal, profit, disc_mst, disc_val_mst, disc_detail, tax, total, embalase, real_amount, sisa, user_id, shift_id, cash, cara_bayar, card_id, bank, dokter_id,dp, no_resep) values (get_new_sales_num('201012'), 13,cast('2010-12-01 'as date),5,1,2,341312.5,54950.5,0,1312.5,0,0,200000,0,200000,0,'adm',0,200000,0,'','',NULL,140000,'');
insert into trs_sales_detail (sales_id, item_id, quantity, price, disc, disc_val, amount, amount_profit, price_purchase, paket_id, points, hrg_beli, conversion)values ((select sales_id from trs_sales_mst y where y.trans_num = (select max(x.trans_num) from trs_sales_mst x where x.cashier_id = 5) and y.cashier_id = 5), 39,1,5062.5,0,0,5062.5,1013,4050,NULL,0,4050,1);
update mst_item set current_stock = current_stock + -1 where item_id = 39;
call save_to_item_balance(1, 39, cast('2010-12-01 'as date), 1, 'C');
insert into trs_sales_detail (sales_id, item_id, quantity, price, disc, disc_val, amount, amount_profit, price_purchase, paket_id, points, hrg_beli, conversion)values ((select sales_id from trs_sales_mst y where y.trans_num = (select max(x.trans_num) from trs_sales_mst x where x.cashier_id = 5) and y.cashier_id = 5), 42,1,145000,2,0,145000,29000,116000,NULL,0,116000,1);
update mst_item set current_stock = current_stock + -1 where item_id = 42;
call save_to_item_balance(1, 42, cast('2010-12-01 'as date), 1, 'C');
insert into trs_sales_detail (sales_id, item_id, quantity, price, disc, disc_val, amount, amount_profit, price_purchase, paket_id, points, hrg_beli, conversion)values ((select sales_id from trs_sales_mst y where y.trans_num = (select max(x.trans_num) from trs_sales_mst x where x.cashier_id = 5) and y.cashier_id = 5), 26,1,131250,2,0,131250,26250,105000,NULL,0,105000,1);
update mst_item set current_stock = current_stock + -1 where item_id = 26;
call save_to_item_balance(1, 26, cast('2010-12-01 'as date), 1, 'C');
insert into trs_sales_detail (sales_id, item_id, quantity, price, disc, disc_val, amount, amount_profit, price_purchase, paket_id, points, hrg_beli, conversion)values ((select sales_id from trs_sales_mst y where y.trans_num = (select max(x.trans_num) from trs_sales_mst x where x.cashier_id = 5) and y.cashier_id = 5), NULL,1,0,0,0,0,0,0,7,0,0,1);
call put_customer_service(2,28,1);
insert into trs_sales_detail (sales_id, item_id, quantity, price, disc, disc_val, amount, amount_profit, price_purchase, paket_id, points, hrg_beli, conversion)values ((select sales_id from trs_sales_mst y where y.trans_num = (select max(x.trans_num) from trs_sales_mst x where x.cashier_id = 5) and y.cashier_id = 5), NULL,1,50000,0,0,50000,50000,0,1,0,0,1);
call put_customer_service(2,27,1);
insert into trs_sales_detail (sales_id, item_id, quantity, price, disc, disc_val, amount, amount_profit, price_purchase, paket_id, points, hrg_beli, conversion)values ((select sales_id from trs_sales_mst y where y.trans_num = (select max(x.trans_num) from trs_sales_mst x where x.cashier_id = 5) and y.cashier_id = 5), NULL,1,10000,0,0,10000,10000,0,6,0,0,1);
call put_customer_service(2,29,1);
call save_to_cashier_balance(5, 0, 0, 341312.5, 6837.5, 0, 0, 'D', 'adm');
XA END 'INVISI03cashier';
XA PREPARE 'INVISI03cashier';
XA COMMIT 'INVISI03cashier';

-- Begin on 10/12/02 11:20:41 - cashier
XA START 'INVISI03cashier';
XA END 'INVISI03cashier';
XA PREPARE 'INVISI03cashier';
XA COMMIT 'INVISI03cashier';

-- Begin on 10/12/02 11:32:40 - petShop
XA START 'INVISI03petShop';
update system_config set conf_value = '5'where conf_id = 15;
update mst_service_bonus set jml_service= 1,is_kumulatif=1,bonus_service=2,bonus_jml=1 where service_type=27;
update mst_service_bonus set jml_service= 1,is_kumulatif=0,bonus_service=1,bonus_jml=2 where service_type=28;
update mst_service_bonus set jml_service= 1,is_kumulatif=0,bonus_service=5,bonus_jml=1 where service_type=29;
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/12/02 11:32:47 - petShop
XA START 'INVISI03petShop';
update system_config set conf_value = '5'where conf_id = 15;
update mst_service_bonus set jml_service= 1,is_kumulatif=1,bonus_service=2,bonus_jml=1 where service_type=27;
update mst_service_bonus set jml_service= 1,is_kumulatif=0,bonus_service=1,bonus_jml=2 where service_type=28;
update mst_service_bonus set jml_service= 1,is_kumulatif=1,bonus_service=5,bonus_jml=1 where service_type=29;
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/12/02 18:33:58 - cashier
XA START 'INVISI03cashier';
insert into trs_sales_mst (trans_num, trans_type, trans_date, cashier_id, gudang_id, pasien_id, subtotal, profit, disc_mst, disc_val_mst, disc_detail, tax, total, embalase, real_amount, sisa, user_id, shift_id, cash, cara_bayar, card_id, bank, dokter_id,dp, no_resep) values (get_new_sales_num('201012'), 13,cast('2010-12-02 'as date),5,1,7,55000,0,0,0,0,0,55000,0,55000,0,'adm',0,55000,0,'','',NULL,0,'');
insert into trs_sales_detail (sales_id, item_id, quantity, price, disc, disc_val, amount, amount_profit, price_purchase, paket_id, points, hrg_beli, conversion)values ((select sales_id from trs_sales_mst y where y.trans_num = (select max(x.trans_num) from trs_sales_mst x where x.cashier_id = 5) and y.cashier_id = 5), NULL,1,55000,0,0,55000,55000,0,4,0,0,1);
call put_customer_service(7,27,1);
XA END 'INVISI03cashier';
XA PREPARE 'INVISI03cashier';
XA ROLLBACK 'INVISI03cashier';

-- Begin on 10/12/02 18:34:52 - cashier
XA START 'INVISI03cashier';
insert into trs_sales_mst (trans_num, trans_type, trans_date, cashier_id, gudang_id, pasien_id, subtotal, profit, disc_mst, disc_val_mst, disc_detail, tax, total, embalase, real_amount, sisa, user_id, shift_id, cash, cara_bayar, card_id, bank, dokter_id,dp, no_resep) values (get_new_sales_num('201012'), 13,cast('2010-12-02 'as date),5,1,7,10000,0,0,0,0,0,10000,0,10000,0,'adm',0,10000,0,'','',NULL,0,'');
insert into trs_sales_detail (sales_id, item_id, quantity, price, disc, disc_val, amount, amount_profit, price_purchase, paket_id, points, hrg_beli, conversion)values ((select sales_id from trs_sales_mst y where y.trans_num = (select max(x.trans_num) from trs_sales_mst x where x.cashier_id = 5) and y.cashier_id = 5), NULL,1,10000,0,0,10000,10000,0,6,0,0,1);
call put_customer_service(7,29,1);
call save_to_cashier_balance(5, 0, 0, 10000, 0, 0, 0, 'D', 'adm');
XA END 'INVISI03cashier';
XA PREPARE 'INVISI03cashier';
XA COMMIT 'INVISI03cashier';

-- Begin on 10/12/05 23:54:05 - cashier
XA START 'INVISI03cashier';
XA END 'INVISI03cashier';
XA PREPARE 'INVISI03cashier';
XA COMMIT 'INVISI03cashier';

-- Begin on 10/12/05 23:54:16 - cashier
XA START 'INVISI03cashier';
XA END 'INVISI03cashier';
XA PREPARE 'INVISI03cashier';
XA COMMIT 'INVISI03cashier';

-- Begin on 10/12/05 23:55:52 - cashier
XA START 'INVISI03cashier';
XA END 'INVISI03cashier';
XA PREPARE 'INVISI03cashier';
XA COMMIT 'INVISI03cashier';

-- Begin on 10/12/05 23:56:51 - cashier
XA START 'INVISI03cashier';
XA END 'INVISI03cashier';
XA PREPARE 'INVISI03cashier';
XA COMMIT 'INVISI03cashier';

-- Begin on 10/12/08 13:01:36 - cashier
XA START 'INVISI03cashier';
XA END 'INVISI03cashier';
XA PREPARE 'INVISI03cashier';
XA COMMIT 'INVISI03cashier';

-- Begin on 10/12/11 11:44:28 - cashier
XA START 'INVISI03cashier';
XA END 'INVISI03cashier';
XA PREPARE 'INVISI03cashier';
XA ROLLBACK 'INVISI03cashier';

-- Begin on 10/12/11 11:46:13 - cashier
XA START 'INVISI03cashier';
XA END 'INVISI03cashier';
XA PREPARE 'INVISI03cashier';
XA COMMIT 'INVISI03cashier';

-- Begin on 10/12/11 11:46:26 - cashier
XA START 'INVISI03cashier';
XA END 'INVISI03cashier';
XA PREPARE 'INVISI03cashier';
XA COMMIT 'INVISI03cashier';

-- Begin on 10/12/11 12:52:10 - cashier
XA START 'INVISI03cashier';
insert into trs_sales_mst (trans_num, trans_type, trans_date, cashier_id, gudang_id, pasien_id, subtotal, profit, disc_mst, disc_val_mst, disc_detail, tax, total, embalase, real_amount, sisa, user_id, shift_id, cash, cara_bayar, card_id, bank, dokter_id,dp, no_resep) values (get_new_sales_num('201012'), 14,cast('2010-12-11 'as date),5,1,2,131250,26250,0,0,0,0,131250,0,131250,0,'adm',0,131250,0,'','',NULL,0,'');
insert into trs_sales_detail (sales_id, item_id, quantity, price, disc, disc_val, amount, amount_profit, price_purchase, paket_id, points, hrg_beli, conversion)values ((select sales_id from trs_sales_mst y where y.trans_num = (select max(x.trans_num) from trs_sales_mst x where x.cashier_id = 5) and y.cashier_id = 5), 26,1,131250,2,0,131250,26250,105000,NULL,0,105000,1);
update mst_item set current_stock = current_stock + -1 where item_id = 26;
call save_to_item_balance(1, 26, cast('2010-12-11 'as date), 1, 'C');
call save_to_cashier_balance(5, 0, 0, 131250, 2625, 0, 0, 'D', 'adm');
XA END 'INVISI03cashier';
XA PREPARE 'INVISI03cashier';
XA COMMIT 'INVISI03cashier';

-- Begin on 10/12/11 13:21:18 - cashier
XA START 'INVISI03cashier';
insert into trs_sales_mst (trans_num, trans_type, trans_date, cashier_id, gudang_id, pasien_id, subtotal, profit, disc_mst, disc_val_mst, disc_detail, tax, total, embalase, real_amount, sisa, user_id, shift_id, cash, cara_bayar, card_id, bank, dokter_id,dp, no_resep) values (get_new_sales_num('201012'), 14,cast('2010-12-11 'as date),5,1,2,145000,29000,0,0,0,0,145000,0,145000,0,'adm',0,145000,0,'','',NULL,0,'');
insert into trs_sales_detail (sales_id, item_id, quantity, price, disc, disc_val, amount, amount_profit, price_purchase, paket_id, points, hrg_beli, conversion)values ((select sales_id from trs_sales_mst y where y.trans_num = (select max(x.trans_num) from trs_sales_mst x where x.cashier_id = 5) and y.cashier_id = 5), 42,1,145000,2,0,145000,29000,116000,NULL,0,116000,1);
update mst_item set current_stock = current_stock + 1 where item_id = 42;
call save_to_item_balance(1, 42, cast('2010-12-11 'as date), 1, 'D');
call save_to_cashier_balance(5, 0, 0, 145000, 2900, 0, 0, 'D', 'adm');
XA END 'INVISI03cashier';
XA PREPARE 'INVISI03cashier';
XA COMMIT 'INVISI03cashier';

-- Begin on 10/12/11 16:25:55 - cashier
XA START 'INVISI03cashier';
XA END 'INVISI03cashier';
XA PREPARE 'INVISI03cashier';
XA COMMIT 'INVISI03cashier';

-- Begin on 10/12/11 16:26:03 - cashier
XA START 'INVISI03cashier';
XA END 'INVISI03cashier';
XA PREPARE 'INVISI03cashier';
XA COMMIT 'INVISI03cashier';

-- Begin on 10/12/11 16:31:29 - cashier
XA START 'INVISI03cashier';
XA END 'INVISI03cashier';
XA PREPARE 'INVISI03cashier';
XA COMMIT 'INVISI03cashier';

-- Begin on 10/12/11 16:31:38 - cashier
XA START 'INVISI03cashier';
XA END 'INVISI03cashier';
XA PREPARE 'INVISI03cashier';
XA COMMIT 'INVISI03cashier';

-- Begin on 10/12/15 12:29:14 - cashier
XA START 'INVISI03cashier';
update mst_relation set  relation_type= 1, relation_code= 'CS.006', relation_name= 'Anton', address1= 'Jl. Astina No. 1', address2= '', post_code= '', city= '', phone1= '', phone2= '', npwp= '', contact_person = '', discount = 10, wajib_discount = 1, due_Date= 0 where relation_id= 9;
XA END 'INVISI03cashier';
XA PREPARE 'INVISI03cashier';
XA COMMIT 'INVISI03cashier';

-- Begin on 10/12/15 12:29:30 - cashier
XA START 'INVISI03cashier';
INSERT INTO Mst_Relation_Animal (Relation_ID,Seq,Animal_Name,Animal_ID,Race,Eat,Age,Sex) VALUES (9,1,'rere',5,'','',3,0);
XA END 'INVISI03cashier';
XA PREPARE 'INVISI03cashier';
XA COMMIT 'INVISI03cashier';

-- Begin on 10/12/15 12:33:15 - cashier
XA START 'INVISI03cashier';
UPDATE Mst_Relation_Animal SET Animal_Name='Puddle', Animal_ID=3, Race='', Eat='', Age=0, Sex=0 WHERE Relation_ID=11 AND Seq=1;
UPDATE Mst_Relation_Animal SET Animal_Name='Muddle', Animal_ID=4, Race='fd', Eat='d', Age=2, Sex=0 WHERE Relation_ID=11 AND Seq=2;
INSERT INTO Mst_Relation_Animal (Relation_ID,Seq,Animal_Name,Animal_ID,Race,Eat,Age,Sex) VALUES (11,3,'Kuddle',5,'','',0,0);
XA END 'INVISI03cashier';
XA PREPARE 'INVISI03cashier';
XA COMMIT 'INVISI03cashier';

-- Begin on 10/12/15 12:33:17 - cashier
XA START 'INVISI03cashier';
UPDATE Mst_Relation_Animal SET Animal_Name='Puddle', Animal_ID=3, Race='', Eat='', Age=0, Sex=0 WHERE Relation_ID=11 AND Seq=1;
UPDATE Mst_Relation_Animal SET Animal_Name='Muddle', Animal_ID=4, Race='fd', Eat='d', Age=2, Sex=0 WHERE Relation_ID=11 AND Seq=2;
UPDATE Mst_Relation_Animal SET Animal_Name='Kuddle', Animal_ID=5, Race='', Eat='', Age=0, Sex=0 WHERE Relation_ID=11 AND Seq=3;
XA END 'INVISI03cashier';
XA PREPARE 'INVISI03cashier';
XA COMMIT 'INVISI03cashier';

-- Begin on 10/12/15 12:33:17 - cashier
XA START 'INVISI03cashier';
UPDATE Mst_Relation_Animal SET Animal_Name='Puddle', Animal_ID=3, Race='', Eat='', Age=0, Sex=0 WHERE Relation_ID=11 AND Seq=1;
UPDATE Mst_Relation_Animal SET Animal_Name='Muddle', Animal_ID=4, Race='fd', Eat='d', Age=2, Sex=0 WHERE Relation_ID=11 AND Seq=2;
UPDATE Mst_Relation_Animal SET Animal_Name='Kuddle', Animal_ID=5, Race='', Eat='', Age=0, Sex=0 WHERE Relation_ID=11 AND Seq=3;
XA END 'INVISI03cashier';
XA PREPARE 'INVISI03cashier';
XA COMMIT 'INVISI03cashier';

-- Begin on 10/12/16 11:24:43 - cashier
XA START 'INVISI03cashier';
insert into trs_sales_mst (trans_num, trans_type, trans_date, cashier_id, gudang_id, pasien_id, subtotal, profit, disc_mst, disc_val_mst, disc_detail, tax, total, embalase, real_amount, sisa, user_id, shift_id, cash, cara_bayar, card_id, bank, dokter_id,dp, no_resep) values (get_new_sales_num('201012'), 13,cast('2010-12-16 'as date),5,1,NULL,294840,14040,0,0,0,0,294840,0,294840,0,'adm',0,300000,0,'','',NULL,0,'');
insert into trs_sales_detail (sales_id, item_id, quantity, price, disc, disc_val, amount, amount_profit, price_purchase, paket_id, points, hrg_beli, conversion)values ((select sales_id from trs_sales_mst y where y.trans_num = (select max(x.trans_num) from trs_sales_mst x where x.cashier_id = 5) and y.cashier_id = 5), 11,1,294840,3,0,294840,14040,280800,NULL,0,280800,1);
update mst_item set current_stock = current_stock + -1 where item_id = 11;
call save_to_item_balance(1, 11, cast('2010-12-16 'as date), 1, 'C');
call save_to_cashier_balance(5, 0, 0, 294840, 8845.2, 0, 0, 'D', 'adm');
XA END 'INVISI03cashier';
XA PREPARE 'INVISI03cashier';
XA COMMIT 'INVISI03cashier';

-- Begin on 10/12/20 15:02:09 - petShop
XA START 'INVISI03petShop';
UPDATE Mst_Relation_Animal SET Animal_Name='Wewey', Animal_ID=5, Race='Blasteran', Eat='Standar', Age='4', Sex=0 WHERE Relation_ID=7 AND Seq=1;
UPDATE Mst_Relation_Animal SET Animal_Name='wiwiy', Animal_ID=6, Race='31', Eat='adsfasf', Age='0', Sex=0 WHERE Relation_ID=7 AND Seq=2;
UPDATE Mst_Relation_Animal SET Animal_Name='wowoy', Animal_ID=4, Race='', Eat='', Age='0', Sex=0 WHERE Relation_ID=7 AND Seq=3;
UPDATE Mst_Relation_Animal SET Animal_Name='Wuwuy', Animal_ID=2, Race='', Eat='', Age='5 tahun', Sex=1 WHERE Relation_ID=7 AND Seq=4;
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA ROLLBACK 'INVISI03petShop';

-- Begin on 10/12/20 15:02:36 - petShop
XA START 'INVISI03petShop';
UPDATE Mst_Relation_Animal SET Animal_Name='Wewey', Animal_ID=5, Race='Blasteran', Eat='Standar', Age='4', Sex=0 WHERE Relation_ID=7 AND Seq=1;
UPDATE Mst_Relation_Animal SET Animal_Name='wiwiy', Animal_ID=6, Race='31', Eat='adsfasf', Age='0', Sex=0 WHERE Relation_ID=7 AND Seq=2;
UPDATE Mst_Relation_Animal SET Animal_Name='wowoy', Animal_ID=4, Race='', Eat='', Age='0', Sex=0 WHERE Relation_ID=7 AND Seq=3;
UPDATE Mst_Relation_Animal SET Animal_Name='Wuwuy', Animal_ID=2, Race='', Eat='', Age='5 tahun', Sex=1 WHERE Relation_ID=7 AND Seq=4;
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/12/20 15:02:47 - petShop
XA START 'INVISI03petShop';
delete from mst_relation_animal where relation_id =7 and seq=0;
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/12/20 15:02:49 - petShop
XA START 'INVISI03petShop';
UPDATE Mst_Relation_Animal SET Animal_Name='Wewey', Animal_ID=5, Race='Blasteran', Eat='Standar', Age='4', Sex=0 WHERE Relation_ID=7 AND Seq=1;
UPDATE Mst_Relation_Animal SET Animal_Name='wiwiy', Animal_ID=6, Race='31', Eat='adsfasf', Age='0', Sex=0 WHERE Relation_ID=7 AND Seq=2;
UPDATE Mst_Relation_Animal SET Animal_Name='wowoy', Animal_ID=4, Race='', Eat='', Age='0', Sex=0 WHERE Relation_ID=7 AND Seq=3;
UPDATE Mst_Relation_Animal SET Animal_Name='Wuwuy', Animal_ID=2, Race='', Eat='', Age='5 tahun', Sex=1 WHERE Relation_ID=7 AND Seq=4;
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/12/20 15:02:49 - petShop
XA START 'INVISI03petShop';
UPDATE Mst_Relation_Animal SET Animal_Name='Wewey', Animal_ID=5, Race='Blasteran', Eat='Standar', Age='4', Sex=0 WHERE Relation_ID=7 AND Seq=1;
UPDATE Mst_Relation_Animal SET Animal_Name='wiwiy', Animal_ID=6, Race='31', Eat='adsfasf', Age='0', Sex=0 WHERE Relation_ID=7 AND Seq=2;
UPDATE Mst_Relation_Animal SET Animal_Name='wowoy', Animal_ID=4, Race='', Eat='', Age='0', Sex=0 WHERE Relation_ID=7 AND Seq=3;
UPDATE Mst_Relation_Animal SET Animal_Name='Wuwuy', Animal_ID=2, Race='', Eat='', Age='5 tahun', Sex=1 WHERE Relation_ID=7 AND Seq=4;
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/12/20 15:14:45 - petShop
XA START 'INVISI03petShop';
insert into trs_shipment_mst (trans_num, tipe, trans_date, notes, gudang_asal, gudang_tujuan, user_id) values ('SA/20101200002',1,cast('2010-12-20 'as date),'',1,1,'adm');
insert into trs_shipment_detail (ship_id, item_id,  quantity, price_sales, price_cost, price_purchase, hrg_beli, conversion)values (last_insert_id(), 8,-10,0,232000,232000,232000,0);
update mst_item set avg_price = 232000 where item_id = 0;
update mst_item set current_stock = current_stock + -10 where item_id = 8;
call save_to_item_balance(1, 8, cast('2010-12-20 'as date), -10, 'D');
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/12/20 15:16:38 - petShop
XA START 'INVISI03petShop';
insert into trs_shipment_mst (trans_num, tipe, trans_date, notes, gudang_asal, gudang_tujuan, user_id) values ('SA/20101200003',1,cast('2010-12-20 'as date),'',1,1,'adm');
insert into trs_shipment_detail (ship_id, item_id,  quantity, price_sales, price_cost, price_purchase, hrg_beli, conversion)values (last_insert_id(), 53,-10,0,15000,15000,15000,0);
update mst_item set avg_price = 15000 where item_id = 0;
update mst_item set current_stock = current_stock + -10 where item_id = 53;
call save_to_item_balance(1, 53, cast('2010-12-20 'as date), -10, 'D');
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/12/20 15:18:29 - petShop
XA START 'INVISI03petShop';
insert into trs_shipment_mst (trans_num, tipe, trans_date, notes, gudang_asal, gudang_tujuan, user_id) values ('SA/20101200004',1,cast('2010-12-20 'as date),'',1,1,'adm');
insert into trs_shipment_detail (ship_id, item_id,  quantity, price_sales, price_cost, price_purchase, hrg_beli, stok,quantity_ori,conversion)values (last_insert_id(), 46,-5,0,225250,225250,225250,7,2,0);
update mst_item set avg_price = 225250 where item_id = 0;
update mst_item set current_stock = current_stock + -5 where item_id = 46;
call save_to_item_balance(1, 46, cast('2010-12-20 'as date), -5, 'D');
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/12/20 15:20:27 - petShop
XA START 'INVISI03petShop';
insert into trs_shipment_mst (trans_num, tipe, trans_date, notes, gudang_asal, gudang_tujuan, user_id) values ('SA/20101200005',1,cast('2010-12-20 'as date),'',1,1,'adm');
insert into trs_shipment_detail (ship_id, item_id,  quantity, price_sales, price_cost, price_purchase, hrg_beli, stok,quantity_ori,conversion)values (last_insert_id(), 59,-1,0,8450,8450,8450,5,4,0);
update mst_item set avg_price = 8450 where item_id = 0;
update mst_item set current_stock = current_stock + -1 where item_id = 59;
call save_to_item_balance(1, 59, cast('2010-12-20 'as date), -1, 'D');
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/12/23 11:32:02 - petShop
XA START 'INVISI03petShop';
update mst_item SET specification=17, item_code='0043', barcode='465465465', struk_name='Adult Original Box', merk='AOB', avg_price=0, bkp=0, konsinyasi=0, vendor_id =NULL, produsen_id =NULL, kemasan_id =16, kategori =NULL, dosis =0, expire_date =cast('2010-12-23 'as date), buying_price =0, selling_price =0, item_name='Adult Original Box' WHERE item_id=43;
delete from mst_rak_item where item_id = 43;
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/12/23 11:32:10 - petShop
XA START 'INVISI03petShop';
update mst_item SET specification=19, item_code='0053', barcode='AFSDFSDF', struk_name='Alpo KL Chicken Puppy', merk='ACP', avg_price=0, bkp=0, konsinyasi=0, vendor_id =NULL, produsen_id =NULL, kemasan_id =17, kategori =NULL, dosis =0, expire_date =cast('2010-12-23 'as date), buying_price =0, selling_price =0, item_name='Alpo KL Chicken Puppy' WHERE item_id=53;
delete from mst_rak_item where item_id = 53;
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/12/30 09:56:41 - cashier
XA START 'INVISI03cashier';
insert into trs_sales_mst (trans_num, trans_type, trans_date, cashier_id, gudang_id, pasien_id, subtotal, profit, disc_mst, disc_val_mst, disc_detail, tax, total, embalase, real_amount, sisa, user_id, shift_id, cash, cara_bayar, card_id, bank, dokter_id,dp, no_resep) values (get_new_sales_num('201012'), 13,cast('2010-12-30 'as date),5,1,6,45000,0,0,0,0,0,45000,0,45000,0,'adm',0,50000,0,'','',NULL,0,'');
insert into trs_sales_detail (sales_id, item_id, quantity, price, disc, disc_val, amount, amount_profit, price_purchase, paket_id, points, hrg_beli, conversion)values ((select sales_id from trs_sales_mst y where y.trans_num = (select max(x.trans_num) from trs_sales_mst x where x.cashier_id = 5) and y.cashier_id = 5), NULL,1,45000,0,0,45000,45000,0,3,0,0,1);
call put_customer_service(6,27,1,0);
call save_to_cashier_balance(5, 0, 0, 45000, 0, 0, 0, 'D', 'adm');
XA END 'INVISI03cashier';
XA PREPARE 'INVISI03cashier';
XA COMMIT 'INVISI03cashier';

-- Begin on 10/12/30 09:57:25 - cashier
XA START 'INVISI03cashier';
insert into trs_sales_mst (trans_num, trans_type, trans_date, cashier_id, gudang_id, pasien_id, subtotal, profit, disc_mst, disc_val_mst, disc_detail, tax, total, embalase, real_amount, sisa, user_id, shift_id, cash, cara_bayar, card_id, bank, dokter_id,dp, no_resep) values (get_new_sales_num('201012'), 13,cast('2010-12-30 'as date),5,1,6,55000,0,0,0,0,0,55000,0,55000,0,'adm',0,60000,0,'','',NULL,0,'');
insert into trs_sales_detail (sales_id, item_id, quantity, price, disc, disc_val, amount, amount_profit, price_purchase, paket_id, points, hrg_beli, conversion)values ((select sales_id from trs_sales_mst y where y.trans_num = (select max(x.trans_num) from trs_sales_mst x where x.cashier_id = 5) and y.cashier_id = 5), NULL,1,55000,0,0,55000,55000,0,1,0,0,1);
call put_customer_service(6,27,1,0);
call save_to_cashier_balance(5, 0, 0, 55000, 0, 0, 0, 'D', 'adm');
XA END 'INVISI03cashier';
XA PREPARE 'INVISI03cashier';
XA COMMIT 'INVISI03cashier';

-- Begin on 10/12/30 09:58:18 - cashier
XA START 'INVISI03cashier';
insert into trs_sales_mst (trans_num, trans_type, trans_date, cashier_id, gudang_id, pasien_id, subtotal, profit, disc_mst, disc_val_mst, disc_detail, tax, total, embalase, real_amount, sisa, user_id, shift_id, cash, cara_bayar, card_id, bank, dokter_id,dp, no_resep) values (get_new_sales_num('201012'), 13,cast('2010-12-30 'as date),5,1,6,0,0,0,0,0,0,0,0,0,0,'adm',0,0,0,'','',NULL,0,'');
insert into trs_sales_detail (sales_id, item_id, quantity, price, disc, disc_val, amount, amount_profit, price_purchase, paket_id, points, hrg_beli, conversion)values ((select sales_id from trs_sales_mst y where y.trans_num = (select max(x.trans_num) from trs_sales_mst x where x.cashier_id = 5) and y.cashier_id = 5), NULL,1,40000,0,0,0,0,0,2,0,0,1);
call put_customer_service(6,27,1,1);
call save_to_cashier_balance(5, 0, 0, 40000, 0, 0, 0, 'D', 'adm');
XA END 'INVISI03cashier';
XA PREPARE 'INVISI03cashier';
XA COMMIT 'INVISI03cashier';

-- Begin on 10/12/30 10:00:02 - cashier
XA START 'INVISI03cashier';
insert into trs_sales_mst (trans_num, trans_type, trans_date, cashier_id, gudang_id, pasien_id, subtotal, profit, disc_mst, disc_val_mst, disc_detail, tax, total, embalase, real_amount, sisa, user_id, shift_id, cash, cara_bayar, card_id, bank, dokter_id,dp, no_resep) values (get_new_sales_num('201012'), 13,cast('2010-12-30 'as date),5,1,6,120000,0,0,0,0,0,120000,0,120000,0,'adm',0,120000,0,'','',NULL,0,'');
insert into trs_sales_detail (sales_id, item_id, quantity, price, disc, disc_val, amount, amount_profit, price_purchase, paket_id, points, hrg_beli, conversion)values ((select sales_id from trs_sales_mst y where y.trans_num = (select max(x.trans_num) from trs_sales_mst x where x.cashier_id = 5) and y.cashier_id = 5), NULL,1,75000,0,0,75000,75000,0,4,0,0,1);
call put_customer_service(6,27,1,0);
insert into trs_sales_detail (sales_id, item_id, quantity, price, disc, disc_val, amount, amount_profit, price_purchase, paket_id, points, hrg_beli, conversion)values ((select sales_id from trs_sales_mst y where y.trans_num = (select max(x.trans_num) from trs_sales_mst x where x.cashier_id = 5) and y.cashier_id = 5), NULL,1,45000,0,0,45000,45000,0,3,0,0,1);
call put_customer_service(6,27,1,0);
call save_to_cashier_balance(5, 0, 0, 120000, 0, 0, 0, 'D', 'adm');
XA END 'INVISI03cashier';
XA PREPARE 'INVISI03cashier';
XA COMMIT 'INVISI03cashier';

-- Begin on 10/12/30 10:00:32 - cashier
XA START 'INVISI03cashier';
insert into trs_sales_mst (trans_num, trans_type, trans_date, cashier_id, gudang_id, pasien_id, subtotal, profit, disc_mst, disc_val_mst, disc_detail, tax, total, embalase, real_amount, sisa, user_id, shift_id, cash, cara_bayar, card_id, bank, dokter_id,dp, no_resep) values (get_new_sales_num('201012'), 13,cast('2010-12-30 'as date),5,1,6,0,0,0,0,0,0,0,0,0,0,'adm',0,0,0,'','',NULL,0,'');
insert into trs_sales_detail (sales_id, item_id, quantity, price, disc, disc_val, amount, amount_profit, price_purchase, paket_id, points, hrg_beli, conversion)values ((select sales_id from trs_sales_mst y where y.trans_num = (select max(x.trans_num) from trs_sales_mst x where x.cashier_id = 5) and y.cashier_id = 5), NULL,1,55000,0,0,0,0,0,1,0,0,1);
call put_customer_service(6,27,1,1);
call save_to_cashier_balance(5, 0, 0, 55000, 0, 0, 0, 'D', 'adm');
XA END 'INVISI03cashier';
XA PREPARE 'INVISI03cashier';
XA COMMIT 'INVISI03cashier';

-- Begin on 10/12/30 10:43:01 - petShop
XA START 'INVISI03petShop';
UPDATE System_Users SET User_Name='Cika', Access_Level=1 WHERE User_Id='Cika';
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='Cika' AND Menu_Id=101;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='Cika' AND Menu_Id=102;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='Cika' AND Menu_Id=103;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='Cika' AND Menu_Id=104;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =-1, Can_edit =-1, Can_delete =-1, Can_view =-1, Can_print =-1 WHERE User_Id='Cika' AND Menu_Id=202;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =-1, Can_delete =-1, Can_view =-1, Can_print =-1 WHERE User_Id='Cika' AND Menu_Id=210;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =-1, Can_edit =-1, Can_delete =-1, Can_view =-1, Can_print =-1 WHERE User_Id='Cika' AND Menu_Id=212;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =-1, Can_edit =-1, Can_delete =-1, Can_view =-1, Can_print =-1 WHERE User_Id='Cika' AND Menu_Id=213;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =-1, Can_print =0 WHERE User_Id='Cika' AND Menu_Id=214;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =-1, Can_print =0 WHERE User_Id='Cika' AND Menu_Id=215;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =-1, Can_print =0 WHERE User_Id='Cika' AND Menu_Id=216;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =-1, Can_print =0 WHERE User_Id='Cika' AND Menu_Id=217;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =-1, Can_edit =-1, Can_delete =-1, Can_view =-1, Can_print =-1 WHERE User_Id='Cika' AND Menu_Id=220;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =-1, Can_edit =-1, Can_delete =-1, Can_view =-1, Can_print =-1 WHERE User_Id='Cika' AND Menu_Id=223;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =-1, Can_edit =-1, Can_delete =-1, Can_view =-1, Can_print =-1 WHERE User_Id='Cika' AND Menu_Id=300;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =-1, Can_edit =-1, Can_delete =-1, Can_view =-1, Can_print =-1 WHERE User_Id='Cika' AND Menu_Id=301;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =-1, Can_edit =-1, Can_delete =-1, Can_view =-1, Can_print =-1 WHERE User_Id='Cika' AND Menu_Id=302;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =-1, Can_edit =-1, Can_delete =-1, Can_view =-1, Can_print =-1 WHERE User_Id='Cika' AND Menu_Id=321;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =-1, Can_edit =-1, Can_delete =-1, Can_view =-1, Can_print =-1 WHERE User_Id='Cika' AND Menu_Id=322;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =-1, Can_print =0 WHERE User_Id='Cika' AND Menu_Id=323;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =-1, Can_edit =-1, Can_delete =-1, Can_view =-1, Can_print =-1 WHERE User_Id='Cika' AND Menu_Id=330;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =-1, Can_edit =-1, Can_delete =-1, Can_view =-1, Can_print =-1 WHERE User_Id='Cika' AND Menu_Id=331;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =-1, Can_edit =-1, Can_delete =-1, Can_view =-1, Can_print =-1 WHERE User_Id='Cika' AND Menu_Id=401;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='Cika' AND Menu_Id=501;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='Cika' AND Menu_Id=510;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='Cika' AND Menu_Id=530;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =-1, Can_print =0 WHERE User_Id='Cika' AND Menu_Id=1001;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =-1, Can_print =0 WHERE User_Id='Cika' AND Menu_Id=1002;
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/12/30 10:43:29 - petShop
XA START 'INVISI03petShop';
update mst_item SET specification=18, item_code='0045', barcode='0045', struk_name='Beef 10 Kg', merk='Beef jkjk', avg_price=0, bkp=0, konsinyasi=0, vendor_id =NULL, produsen_id =NULL, kemasan_id =26, kategori =NULL, dosis =0, expire_date =cast('2010-12-30 'as date), buying_price =0, selling_price =0, item_name='Beef 10 Kg' WHERE item_id=45;
delete from mst_rak_item where item_id = 45;
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/12/30 10:43:52 - petShop
XA START 'INVISI03petShop';
UPDATE System_Users SET User_Name='Cika', Access_Level=1 WHERE User_Id='Cika';
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='Cika' AND Menu_Id=101;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='Cika' AND Menu_Id=102;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='Cika' AND Menu_Id=103;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='Cika' AND Menu_Id=104;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =-1, Can_edit =-1, Can_delete =-1, Can_view =-1, Can_print =-1 WHERE User_Id='Cika' AND Menu_Id=202;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =-1, Can_view =-1, Can_print =-1 WHERE User_Id='Cika' AND Menu_Id=210;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =-1, Can_edit =-1, Can_delete =-1, Can_view =-1, Can_print =-1 WHERE User_Id='Cika' AND Menu_Id=212;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =-1, Can_edit =-1, Can_delete =-1, Can_view =-1, Can_print =-1 WHERE User_Id='Cika' AND Menu_Id=213;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =-1, Can_print =0 WHERE User_Id='Cika' AND Menu_Id=214;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =-1, Can_print =0 WHERE User_Id='Cika' AND Menu_Id=215;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =-1, Can_print =0 WHERE User_Id='Cika' AND Menu_Id=216;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =-1, Can_print =0 WHERE User_Id='Cika' AND Menu_Id=217;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =-1, Can_edit =-1, Can_delete =-1, Can_view =-1, Can_print =-1 WHERE User_Id='Cika' AND Menu_Id=220;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =-1, Can_edit =-1, Can_delete =-1, Can_view =-1, Can_print =-1 WHERE User_Id='Cika' AND Menu_Id=223;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =-1, Can_edit =-1, Can_delete =-1, Can_view =-1, Can_print =-1 WHERE User_Id='Cika' AND Menu_Id=300;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =-1, Can_edit =-1, Can_delete =-1, Can_view =-1, Can_print =-1 WHERE User_Id='Cika' AND Menu_Id=301;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =-1, Can_edit =-1, Can_delete =-1, Can_view =-1, Can_print =-1 WHERE User_Id='Cika' AND Menu_Id=302;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =-1, Can_edit =-1, Can_delete =-1, Can_view =-1, Can_print =-1 WHERE User_Id='Cika' AND Menu_Id=321;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =-1, Can_edit =-1, Can_delete =-1, Can_view =-1, Can_print =-1 WHERE User_Id='Cika' AND Menu_Id=322;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =-1, Can_print =0 WHERE User_Id='Cika' AND Menu_Id=323;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =-1, Can_edit =-1, Can_delete =-1, Can_view =-1, Can_print =-1 WHERE User_Id='Cika' AND Menu_Id=330;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =-1, Can_edit =-1, Can_delete =-1, Can_view =-1, Can_print =-1 WHERE User_Id='Cika' AND Menu_Id=331;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =-1, Can_edit =-1, Can_delete =-1, Can_view =-1, Can_print =-1 WHERE User_Id='Cika' AND Menu_Id=401;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='Cika' AND Menu_Id=501;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='Cika' AND Menu_Id=510;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='Cika' AND Menu_Id=530;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =-1, Can_print =0 WHERE User_Id='Cika' AND Menu_Id=1001;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =-1, Can_print =0 WHERE User_Id='Cika' AND Menu_Id=1002;
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/12/30 10:45:41 - petShop
XA START 'INVISI03petShop';
UPDATE System_Users SET User_Name='Cika', Access_Level=1 WHERE User_Id='Cika';
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='Cika' AND Menu_Id=101;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='Cika' AND Menu_Id=102;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='Cika' AND Menu_Id=103;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='Cika' AND Menu_Id=104;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =-1, Can_edit =-1, Can_delete =-1, Can_view =-1, Can_print =-1 WHERE User_Id='Cika' AND Menu_Id=202;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =-1, Can_delete =-1, Can_view =-1, Can_print =-1 WHERE User_Id='Cika' AND Menu_Id=210;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =-1, Can_edit =-1, Can_delete =-1, Can_view =-1, Can_print =-1 WHERE User_Id='Cika' AND Menu_Id=212;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =-1, Can_edit =-1, Can_delete =-1, Can_view =-1, Can_print =-1 WHERE User_Id='Cika' AND Menu_Id=213;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =-1, Can_print =0 WHERE User_Id='Cika' AND Menu_Id=214;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =-1, Can_print =0 WHERE User_Id='Cika' AND Menu_Id=215;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =-1, Can_print =0 WHERE User_Id='Cika' AND Menu_Id=216;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =-1, Can_print =0 WHERE User_Id='Cika' AND Menu_Id=217;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =-1, Can_edit =-1, Can_delete =-1, Can_view =-1, Can_print =-1 WHERE User_Id='Cika' AND Menu_Id=220;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =-1, Can_edit =-1, Can_delete =-1, Can_view =-1, Can_print =-1 WHERE User_Id='Cika' AND Menu_Id=223;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =-1, Can_edit =-1, Can_delete =-1, Can_view =-1, Can_print =-1 WHERE User_Id='Cika' AND Menu_Id=300;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =-1, Can_edit =-1, Can_delete =-1, Can_view =-1, Can_print =-1 WHERE User_Id='Cika' AND Menu_Id=301;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =-1, Can_edit =-1, Can_delete =-1, Can_view =-1, Can_print =-1 WHERE User_Id='Cika' AND Menu_Id=302;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =-1, Can_edit =-1, Can_delete =-1, Can_view =-1, Can_print =-1 WHERE User_Id='Cika' AND Menu_Id=321;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =-1, Can_edit =-1, Can_delete =-1, Can_view =-1, Can_print =-1 WHERE User_Id='Cika' AND Menu_Id=322;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =-1, Can_print =0 WHERE User_Id='Cika' AND Menu_Id=323;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =-1, Can_edit =-1, Can_delete =-1, Can_view =-1, Can_print =-1 WHERE User_Id='Cika' AND Menu_Id=330;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =-1, Can_edit =-1, Can_delete =-1, Can_view =-1, Can_print =-1 WHERE User_Id='Cika' AND Menu_Id=331;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =-1, Can_edit =-1, Can_delete =-1, Can_view =-1, Can_print =-1 WHERE User_Id='Cika' AND Menu_Id=401;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='Cika' AND Menu_Id=501;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='Cika' AND Menu_Id=510;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='Cika' AND Menu_Id=530;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =-1, Can_print =0 WHERE User_Id='Cika' AND Menu_Id=1001;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =-1, Can_print =0 WHERE User_Id='Cika' AND Menu_Id=1002;
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/12/30 10:46:51 - petShop
XA START 'INVISI03petShop';
UPDATE System_Users SET User_Name='Cika', Access_Level=1 WHERE User_Id='Cika';
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='Cika' AND Menu_Id=101;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='Cika' AND Menu_Id=102;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='Cika' AND Menu_Id=103;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='Cika' AND Menu_Id=104;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =-1, Can_edit =-1, Can_delete =-1, Can_view =-1, Can_print =-1 WHERE User_Id='Cika' AND Menu_Id=202;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =-1, Can_delete =-1, Can_view =-1, Can_print =-1 WHERE User_Id='Cika' AND Menu_Id=210;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =-1, Can_edit =-1, Can_delete =-1, Can_view =-1, Can_print =-1 WHERE User_Id='Cika' AND Menu_Id=212;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =-1, Can_edit =-1, Can_delete =-1, Can_view =-1, Can_print =-1 WHERE User_Id='Cika' AND Menu_Id=213;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =-1, Can_print =0 WHERE User_Id='Cika' AND Menu_Id=214;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =-1, Can_print =0 WHERE User_Id='Cika' AND Menu_Id=215;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =-1, Can_print =0 WHERE User_Id='Cika' AND Menu_Id=216;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =-1, Can_print =0 WHERE User_Id='Cika' AND Menu_Id=217;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =-1, Can_edit =-1, Can_delete =-1, Can_view =-1, Can_print =-1 WHERE User_Id='Cika' AND Menu_Id=220;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =-1, Can_edit =-1, Can_delete =-1, Can_view =-1, Can_print =-1 WHERE User_Id='Cika' AND Menu_Id=223;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =-1, Can_delete =-1, Can_view =-1, Can_print =-1 WHERE User_Id='Cika' AND Menu_Id=300;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =-1, Can_edit =-1, Can_delete =-1, Can_view =-1, Can_print =-1 WHERE User_Id='Cika' AND Menu_Id=301;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =-1, Can_edit =-1, Can_delete =-1, Can_view =-1, Can_print =-1 WHERE User_Id='Cika' AND Menu_Id=302;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =-1, Can_edit =-1, Can_delete =-1, Can_view =-1, Can_print =-1 WHERE User_Id='Cika' AND Menu_Id=321;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =-1, Can_edit =-1, Can_delete =-1, Can_view =-1, Can_print =-1 WHERE User_Id='Cika' AND Menu_Id=322;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =-1, Can_print =0 WHERE User_Id='Cika' AND Menu_Id=323;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =-1, Can_edit =-1, Can_delete =-1, Can_view =-1, Can_print =-1 WHERE User_Id='Cika' AND Menu_Id=330;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =-1, Can_edit =-1, Can_delete =-1, Can_view =-1, Can_print =-1 WHERE User_Id='Cika' AND Menu_Id=331;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =-1, Can_edit =-1, Can_delete =-1, Can_view =-1, Can_print =-1 WHERE User_Id='Cika' AND Menu_Id=401;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='Cika' AND Menu_Id=501;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='Cika' AND Menu_Id=510;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='Cika' AND Menu_Id=530;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =-1, Can_print =0 WHERE User_Id='Cika' AND Menu_Id=1001;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =-1, Can_print =0 WHERE User_Id='Cika' AND Menu_Id=1002;
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 10/12/30 10:51:03 - petShop
XA START 'INVISI03petShop';
UPDATE System_Users SET User_Name='Cika', Access_Level=1 WHERE User_Id='Cika';
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='Cika' AND Menu_Id=101;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='Cika' AND Menu_Id=102;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='Cika' AND Menu_Id=103;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='Cika' AND Menu_Id=104;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =-1, Can_edit =-1, Can_delete =-1, Can_view =-1, Can_print =-1 WHERE User_Id='Cika' AND Menu_Id=202;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =-1, Can_delete =-1, Can_view =-1, Can_print =-1 WHERE User_Id='Cika' AND Menu_Id=210;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =-1, Can_edit =-1, Can_delete =-1, Can_view =-1, Can_print =-1 WHERE User_Id='Cika' AND Menu_Id=212;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =-1, Can_edit =-1, Can_delete =-1, Can_view =-1, Can_print =-1 WHERE User_Id='Cika' AND Menu_Id=213;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =-1, Can_print =0 WHERE User_Id='Cika' AND Menu_Id=214;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =-1, Can_print =0 WHERE User_Id='Cika' AND Menu_Id=215;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =-1, Can_print =0 WHERE User_Id='Cika' AND Menu_Id=216;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =-1, Can_print =0 WHERE User_Id='Cika' AND Menu_Id=217;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =-1, Can_edit =-1, Can_delete =-1, Can_view =-1, Can_print =-1 WHERE User_Id='Cika' AND Menu_Id=220;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =-1, Can_edit =-1, Can_delete =-1, Can_view =-1, Can_print =-1 WHERE User_Id='Cika' AND Menu_Id=223;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =-1, Can_delete =-1, Can_view =-1, Can_print =-1 WHERE User_Id='Cika' AND Menu_Id=300;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =-1, Can_delete =-1, Can_view =-1, Can_print =-1 WHERE User_Id='Cika' AND Menu_Id=301;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =-1, Can_delete =-1, Can_view =-1, Can_print =-1 WHERE User_Id='Cika' AND Menu_Id=302;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =-1, Can_delete =-1, Can_view =-1, Can_print =-1 WHERE User_Id='Cika' AND Menu_Id=321;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =-1, Can_delete =-1, Can_view =-1, Can_print =-1 WHERE User_Id='Cika' AND Menu_Id=322;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =-1, Can_print =0 WHERE User_Id='Cika' AND Menu_Id=323;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =-1, Can_delete =-1, Can_view =-1, Can_print =-1 WHERE User_Id='Cika' AND Menu_Id=330;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =-1, Can_delete =-1, Can_view =-1, Can_print =-1 WHERE User_Id='Cika' AND Menu_Id=331;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =-1, Can_delete =-1, Can_view =-1, Can_print =-1 WHERE User_Id='Cika' AND Menu_Id=401;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='Cika' AND Menu_Id=501;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='Cika' AND Menu_Id=510;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='Cika' AND Menu_Id=530;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =-1, Can_print =0 WHERE User_Id='Cika' AND Menu_Id=1001;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =-1, Can_print =0 WHERE User_Id='Cika' AND Menu_Id=1002;
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 11/01/04 17:19:11 - petShop
XA START 'INVISI03petShop';
insert into trs_shipment_mst (trans_num, tipe, trans_date, notes, gudang_asal, gudang_tujuan, user_id) values ('SA/20110100001',1,cast('2011-01-04 'as date),'',1,1,'adm');
insert into trs_shipment_detail (ship_id, item_id,  quantity, price_sales, price_cost, price_purchase, hrg_beli, stok,quantity_ori,conversion)values (last_insert_id(), 256,10,0,0,0,0,0,10,0);
update mst_item set avg_price = 0 where item_id = 0;
update mst_item set current_stock = current_stock + 10 where item_id = 256;
call save_to_item_balance(1, 256, cast('2011-01-04 'as date), 10, 'D');
insert into trs_shipment_detail (ship_id, item_id,  quantity, price_sales, price_cost, price_purchase, hrg_beli, stok,quantity_ori,conversion)values (last_insert_id(), 441,20,0,650000,650000,650000,0,20,0);
update mst_item set avg_price = 650000 where item_id = 0;
update mst_item set current_stock = current_stock + 20 where item_id = 441;
call save_to_item_balance(1, 441, cast('2011-01-04 'as date), 20, 'D');
insert into trs_shipment_detail (ship_id, item_id,  quantity, price_sales, price_cost, price_purchase, hrg_beli, stok,quantity_ori,conversion)values (last_insert_id(), 536,30,0,110000,110000,110000,0,30,0);
update mst_item set avg_price = 110000 where item_id = 0;
update mst_item set current_stock = current_stock + 30 where item_id = 536;
call save_to_item_balance(1, 536, cast('2011-01-04 'as date), 30, 'D');
insert into trs_shipment_detail (ship_id, item_id,  quantity, price_sales, price_cost, price_purchase, hrg_beli, stok,quantity_ori,conversion)values (last_insert_id(), 452,10,0,27500,27500,27500,0,10,0);
update mst_item set avg_price = 27500 where item_id = 0;
update mst_item set current_stock = current_stock + 10 where item_id = 452;
call save_to_item_balance(1, 452, cast('2011-01-04 'as date), 10, 'D');
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 11/01/05 08:33:28 - petShop
XA START 'INVISI03petShop';
insert into trs_shipment_mst (trans_num, tipe, trans_date, notes, gudang_asal, gudang_tujuan, user_id) values ('SA/20110100002',1,cast('2011-01-05 'as date),'',2,2,'adm');
insert into trs_shipment_detail (ship_id, item_id,  quantity, price_sales, price_cost, price_purchase, hrg_beli, stok,quantity_ori,conversion)values (last_insert_id(), 139,2,0,68463,68463,68463,0,2,0);
update mst_item set avg_price = 68463 where item_id = 0;
update mst_item set current_stock = current_stock + 2 where item_id = 139;
call save_to_item_balance(1, 139, cast('2011-01-05 'as date), 2, 'D');
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 11/01/05 16:07:48 - cashier
XA START 'INVISI03cashier';
insert into trs_sales_mst (trans_num, trans_type, trans_date, cashier_id, gudang_id, pasien_id, subtotal, profit, disc_mst, disc_val_mst, disc_detail, tax, total, embalase, real_amount, sisa, user_id, shift_id, cash, cara_bayar, card_id, bank, dokter_id,dp, no_resep) values (get_new_sales_num('201101'), 13,cast('2011-01-05 'as date),5,1,NULL,83000,14537,0,0,0,0,83000,0,83000,0,'adm',0,85000,0,'','',NULL,0,'');
XA END 'INVISI03cashier';
XA PREPARE 'INVISI03cashier';
XA ROLLBACK 'INVISI03cashier';

-- Begin on 11/01/05 16:09:29 - cashier
XA START 'INVISI03cashier';
insert into trs_sales_mst (trans_num, trans_type, trans_date, cashier_id, gudang_id, pasien_id, subtotal, profit, disc_mst, disc_val_mst, disc_detail, tax, total, embalase, real_amount, sisa, user_id, shift_id, cash, cara_bayar, card_id, bank, dokter_id,dp, no_resep) values (get_new_sales_num('201101'), 13,cast('2011-01-05 'as date),5,1,NULL,83000,14537,0,0,0,0,83000,0,83000,0,'adm',0,85000,0,'','',NULL,0,'');
XA END 'INVISI03cashier';
XA PREPARE 'INVISI03cashier';
XA ROLLBACK 'INVISI03cashier';

-- Begin on 11/01/05 16:13:04 - petShop
XA START 'INVISI03petShop';
insert into trs_shipment_mst (trans_num, tipe, trans_date, notes, gudang_asal, gudang_tujuan, user_id) values ('SA/20110100003',1,cast('2011-01-05 'as date),'',2,2,'adm');
insert into trs_shipment_detail (ship_id, item_id,  quantity, price_sales, price_cost, price_purchase, hrg_beli, stok,quantity_ori,conversion)values (last_insert_id(), 139,-1,0,68463,68463,68463,2,1,0);
update mst_item set avg_price = 68463 where item_id = 0;
update mst_item set current_stock = current_stock + -1 where item_id = 139;
call save_to_item_balance(1, 139, cast('2011-01-05 'as date), -1, 'D');
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 11/01/05 16:15:34 - cashier
XA START 'INVISI03cashier';
insert into trs_sales_mst (trans_num, trans_type, trans_date, cashier_id, gudang_id, pasien_id, subtotal, profit, disc_mst, disc_val_mst, disc_detail, tax, total, embalase, real_amount, sisa, user_id, shift_id, cash, cara_bayar, card_id, bank, dokter_id,dp, no_resep) values (get_new_sales_num('201101'), 13,cast('2011-01-05 'as date),5,1,NULL,83000,14537,0,0,0,0,83000,0,83000,0,'adm',0,85000,0,'','',NULL,0,'');
insert into trs_sales_detail (sales_id, item_id, quantity, price, disc, disc_val, amount, amount_profit, price_purchase, paket_id, points, hrg_beli, conversion)values ((select sales_id from trs_sales_mst y where y.trans_num = (select max(x.trans_num) from trs_sales_mst x where x.cashier_id = 5) and y.cashier_id = 5), 139,1,83000,5,0,83000,14537,0,NULL,0,68463,1);
update mst_item set current_stock = current_stock + -1 where item_id = 139;
call save_to_item_balance(1, 139, cast('2011-01-05 'as date), 1, 'C');
call save_to_cashier_balance(5, 0, 0, 83000, 4150, 0, 0, 'D', 'adm');
XA END 'INVISI03cashier';
XA PREPARE 'INVISI03cashier';
XA COMMIT 'INVISI03cashier';

-- Begin on 11/01/05 16:25:27 - petShop
XA START 'INVISI03petShop';
insert into trs_shipment_mst (trans_num, tipe, trans_date, notes, gudang_asal, gudang_tujuan, user_id) values ('SA/20110100004',1,cast('2011-01-05 'as date),'',2,2,'adm');
insert into trs_shipment_detail (ship_id, item_id,  quantity, price_sales, price_cost, price_purchase, hrg_beli, stok,quantity_ori,conversion)values (last_insert_id(), 566,2,0,11666,11666,11666,0,2,0);
update mst_item set avg_price = 11666 where item_id = 0;
update mst_item set current_stock = current_stock + 2 where item_id = 566;
call save_to_item_balance(1, 566, cast('2011-01-05 'as date), 2, 'D');
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 11/01/05 16:26:05 - petShop
XA START 'INVISI03petShop';
insert into trs_shipment_mst (trans_num, tipe, trans_date, notes, gudang_asal, gudang_tujuan, user_id) values ('SA/20110100005',1,cast('2011-01-05 'as date),'',2,2,'adm');
insert into trs_shipment_detail (ship_id, item_id,  quantity, price_sales, price_cost, price_purchase, hrg_beli, stok,quantity_ori,conversion)values (last_insert_id(), 566,-1,0,11666,11666,11666,2,1,0);
update mst_item set avg_price = 11666 where item_id = 0;
update mst_item set current_stock = current_stock + -1 where item_id = 566;
call save_to_item_balance(1, 566, cast('2011-01-05 'as date), -1, 'D');
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 11/01/05 16:28:38 - petShop
XA START 'INVISI03petShop';
insert into trs_shipment_mst (trans_num, tipe, trans_date, notes, gudang_asal, gudang_tujuan, user_id) values ('SA/20110100006',1,cast('2011-01-05 'as date),'',2,2,'adm');
insert into trs_shipment_detail (ship_id, item_id,  quantity, price_sales, price_cost, price_purchase, hrg_beli, stok,quantity_ori,conversion)values (last_insert_id(), 566,4,0,11666,11666,11666,1,5,0);
update mst_item set avg_price = 11666 where item_id = 0;
update mst_item set current_stock = current_stock + 4 where item_id = 566;
call save_to_item_balance(1, 566, cast('2011-01-05 'as date), 4, 'D');
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 11/01/05 16:36:34 - petShop
XA START 'INVISI03petShop';
insert into trs_shipment_mst (trans_num, tipe, trans_date, notes, gudang_asal, gudang_tujuan, user_id) values ('SA/20110100007',1,cast('2011-01-05 'as date),'',2,2,'adm');
insert into trs_shipment_detail (ship_id, item_id,  quantity, price_sales, price_cost, price_purchase, hrg_beli, stok,quantity_ori,conversion)values (last_insert_id(), 441,-10,0,650000,650000,650000,20,10,0);
update mst_item set avg_price = 650000 where item_id = 0;
update mst_item set current_stock = current_stock + -10 where item_id = 441;
call save_to_item_balance(1, 441, cast('2011-01-05 'as date), -10, 'D');
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 11/01/05 16:39:34 - petShop
XA START 'INVISI03petShop';
insert into trs_shipment_mst (trans_num, tipe, trans_date, notes, gudang_asal, gudang_tujuan, user_id) values ('SA/20110100008',1,cast('2011-01-05 'as date),'',2,2,'adm');
insert into trs_shipment_detail (ship_id, item_id,  quantity, price_sales, price_cost, price_purchase, hrg_beli, stok,quantity_ori,conversion)values (last_insert_id(), 566,0,0,11666,11666,11666,5,4,0);
update mst_item set avg_price = 11666 where item_id = 0;
update mst_item set current_stock = current_stock + 0 where item_id = 566;
call save_to_item_balance(1, 566, cast('2011-01-05 'as date), 0, 'D');
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 11/01/05 16:58:31 - petShop
XA START 'INVISI03petShop';
insert into trs_shipment_mst (trans_num, tipe, trans_date, notes, gudang_asal, gudang_tujuan, user_id) values ('SA/20110100001',1,cast('2011-01-05 'as date),'',4,4,'adm');
insert into trs_shipment_detail (ship_id, item_id,  quantity, price_sales, price_cost, price_purchase, hrg_beli, stok,quantity_ori,conversion)values (last_insert_id(), 566,-1,0,11666,11666,11666,3,2,0);
update mst_item set avg_price = 11666 where item_id = 0;
update mst_item set current_stock = current_stock + -1 where item_id = 566;
call save_to_item_balance(1, 566, cast('2011-01-05 'as date), -1, 'D');
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 11/01/05 16:59:28 - petShop
XA START 'INVISI03petShop';
insert into trs_shipment_mst (trans_num, tipe, trans_date, notes, gudang_asal, gudang_tujuan, user_id) values ('SA/20110100002',1,cast('2011-01-05 'as date),'',4,4,'adm');
insert into trs_shipment_detail (ship_id, item_id,  quantity, price_sales, price_cost, price_purchase, hrg_beli, stok,quantity_ori,conversion)values (last_insert_id(), 440,5,0,1089087,1089087,1089087,0,5,0);
update mst_item set avg_price = 1089087 where item_id = 0;
update mst_item set current_stock = current_stock + 5 where item_id = 440;
call save_to_item_balance(1, 440, cast('2011-01-05 'as date), 5, 'D');
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 11/01/05 16:59:54 - petShop
XA START 'INVISI03petShop';
insert into trs_shipment_mst (trans_num, tipe, trans_date, notes, gudang_asal, gudang_tujuan, user_id) values ('SA/20110100003',1,cast('2011-01-06 'as date),'',4,4,'adm');
insert into trs_shipment_detail (ship_id, item_id,  quantity, price_sales, price_cost, price_purchase, hrg_beli, stok,quantity_ori,conversion)values (last_insert_id(), 440,-1,0,1089087,1089087,1089087,5,4,0);
update mst_item set avg_price = 1089087 where item_id = 0;
update mst_item set current_stock = current_stock + -1 where item_id = 440;
call save_to_item_balance(1, 440, cast('2011-01-06 'as date), -1, 'D');
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 11/01/05 17:07:50 - petShop
XA START 'INVISI03petShop';
update mst_item set disabled_date = if(disabled_date is null, curdate(), null) where item_id = 440;
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';

-- Begin on 11/01/05 17:16:32 - petShop
XA START 'INVISI03petShop';
insert into trs_shipment_mst (trans_num, tipe, trans_date, notes, gudang_asal, gudang_tujuan, user_id) values ('SA/20110100004',1,cast('2011-01-05 'as date),'',4,4,'adm');
insert into trs_shipment_detail (ship_id, item_id,  quantity, price_sales, price_cost, price_purchase, hrg_beli, stok,quantity_ori,conversion)values (last_insert_id(), 566,8,0,11666,11666,11666,2,10,0);
update mst_item set avg_price = 11666 where item_id = 0;
update mst_item set current_stock = current_stock + 8 where item_id = 566;
call save_to_item_balance(1, 566, cast('2011-01-05 'as date), 8, 'D');
XA END 'INVISI03petShop';
XA PREPARE 'INVISI03petShop';
XA COMMIT 'INVISI03petShop';
