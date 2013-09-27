
-- Begin on 10/09/23 08:36:38 - petShop
XA START 'RAMBOpetShop';
insert into mst_relation (relation_type, relation_code, relation_name, address1, address2, post_code, city, phone1, phone2, contact_person, npwp, due_date) values (2,'P.001','PD. Jaya lah selalu','Jl. Kemurnian Hati','','34343','Bandung','022-23232','-232','Andre','',0);
XA END 'RAMBOpetShop';
XA PREPARE 'RAMBOpetShop';
XA COMMIT 'RAMBOpetShop';

-- Begin on 10/09/27 09:29:24 - petShop
XA START 'RAMBOpetShop';
insert into mst_service (service_code, service_name, notes,insert_log) values ('M.001','Mandi sehat','',adm;2010-09-27 00:00:00 );

-- Begin on 10/09/27 09:30:15 - petShop
XA START 'RAMBOpetShop';
insert into mst_service (service_code, service_name, notes,insert_log) values ('D.001','Dry Grooming','','adm;2010-09-27 00:00:00 ');
XA END 'RAMBOpetShop';
XA PREPARE 'RAMBOpetShop';
XA COMMIT 'RAMBOpetShop';

-- Begin on 10/09/27 09:31:40 - petShop
XA START 'RAMBOpetShop';
update mst_service set  serice_code= 'D.001', service_name= 'Mandi sehat', notes= '', edit_log= 'adm;2010-09-27 00:00:00 ', where service_id= 1;
XA END 'RAMBOpetShop';
XA PREPARE 'RAMBOpetShop';
XA ROLLBACK 'RAMBOpetShop';

-- Begin on 10/09/27 09:34:53 - petShop
XA START 'RAMBOpetShop';
update mst_service set  serice_code= 'D.001', service_name= 'Dry Grooming f', notes= 'mandi sehat', edit_log= 'adm;2010-09-27 00:00:00 ' where service_id= 1;
XA END 'RAMBOpetShop';
XA PREPARE 'RAMBOpetShop';
XA ROLLBACK 'RAMBOpetShop';

-- Begin on 10/09/27 09:38:14 - petShop
XA START 'RAMBOpetShop';
update mst_service set  service_code= 'D.001', service_name= 'Dry Grooming', notes= 'mandi Sehat', edit_log= 'adm;2010-09-27 00:00:00 ' where service_id= 1;
XA END 'RAMBOpetShop';
XA PREPARE 'RAMBOpetShop';
XA COMMIT 'RAMBOpetShop';

-- Begin on 10/09/27 09:46:50 - petShop
XA START 'RAMBOpetShop';
delete from mst_service where service_id = 1;
XA END 'RAMBOpetShop';
XA PREPARE 'RAMBOpetShop';
XA COMMIT 'RAMBOpetShop';

-- Begin on 10/09/27 19:06:24 - petShop
XA START 'RAMBOpetShop';
insert into mst_animal (animal_code, animal, notes) values ('A001','Kucing','dan sejenisnya');
XA END 'RAMBOpetShop';
XA PREPARE 'RAMBOpetShop';
XA COMMIT 'RAMBOpetShop';

-- Begin on 10/09/27 19:09:58 - petShop
XA START 'RAMBOpetShop';
update mst_animal set  animal_code= 'A001', animal= 'Kucing', notes= 'dan sejenisnya lah' where animal_id= 1;
XA END 'RAMBOpetShop';
XA PREPARE 'RAMBOpetShop';
XA COMMIT 'RAMBOpetShop';

-- Begin on 10/09/27 19:10:09 - petShop
XA START 'RAMBOpetShop';
insert into mst_animal (animal_code, animal, notes) values ('A002','bagong','');
XA END 'RAMBOpetShop';
XA PREPARE 'RAMBOpetShop';
XA COMMIT 'RAMBOpetShop';

-- Begin on 10/09/27 19:10:17 - petShop
XA START 'RAMBOpetShop';
delete from mst_service where service_id = 2;
XA END 'RAMBOpetShop';
XA PREPARE 'RAMBOpetShop';
XA COMMIT 'RAMBOpetShop';

-- Begin on 10/09/27 19:11:04 - petShop
XA START 'RAMBOpetShop';
delete from mst_animal where animal_id = 2;
XA END 'RAMBOpetShop';
XA PREPARE 'RAMBOpetShop';
XA COMMIT 'RAMBOpetShop';

-- Begin on 10/09/28 07:40:00 - petShop
XA START 'RAMBOpetShop';
insert into mst_animal (animal_code, animal, notes) values ('A002','Kelinci','');
XA END 'RAMBOpetShop';
XA PREPARE 'RAMBOpetShop';
XA COMMIT 'RAMBOpetShop';

-- Begin on 10/09/28 07:40:13 - petShop
XA START 'RAMBOpetShop';
insert into mst_animal (animal_code, animal, notes) values ('A003','Anjing Small','');
XA END 'RAMBOpetShop';
XA PREPARE 'RAMBOpetShop';
XA COMMIT 'RAMBOpetShop';

-- Begin on 10/09/28 07:40:19 - petShop
XA START 'RAMBOpetShop';
insert into mst_animal (animal_code, animal, notes) values ('A004','Anjing Medium','');
XA END 'RAMBOpetShop';
XA PREPARE 'RAMBOpetShop';
XA COMMIT 'RAMBOpetShop';

-- Begin on 10/09/28 07:40:38 - petShop
XA START 'RAMBOpetShop';
insert into mst_animal (animal_code, animal, notes) values ('A005','Anjing Big','');
XA END 'RAMBOpetShop';
XA PREPARE 'RAMBOpetShop';
XA COMMIT 'RAMBOpetShop';

-- Begin on 10/09/28 07:53:46 - petShop
XA START 'RAMBOpetShop';
insert into mst_service (service_code, service_name, notes,insert_log) values ('S001','Mandi Sehat','Dry Powder','adm;2010-09-28 00:00:00 ');
XA END 'RAMBOpetShop';
XA PREPARE 'RAMBOpetShop';
XA COMMIT 'RAMBOpetShop';

-- Begin on 10/09/28 07:53:57 - petShop
XA START 'RAMBOpetShop';
insert into mst_service (service_code, service_name, notes,insert_log) values ('S002','Mandi Flea & Tick','','adm;2010-09-28 00:00:00 ');
XA END 'RAMBOpetShop';
XA PREPARE 'RAMBOpetShop';
XA COMMIT 'RAMBOpetShop';

-- Begin on 10/09/28 07:54:07 - petShop
XA START 'RAMBOpetShop';
insert into mst_service (service_code, service_name, notes,insert_log) values ('S003','Mandi Medicated','','adm;2010-09-28 00:00:00 ');
XA END 'RAMBOpetShop';
XA PREPARE 'RAMBOpetShop';
XA COMMIT 'RAMBOpetShop';

-- Begin on 10/09/28 07:54:14 - petShop
XA START 'RAMBOpetShop';
insert into mst_service (service_code, service_name, notes,insert_log) values ('S004','Mandi Komplit','','adm;2010-09-28 00:00:00 ');
XA END 'RAMBOpetShop';
XA PREPARE 'RAMBOpetShop';
XA COMMIT 'RAMBOpetShop';

-- Begin on 10/09/28 07:54:19 - petShop
XA START 'RAMBOpetShop';
insert into mst_service (service_code, service_name, notes,insert_log) values ('S005','Cukur Bulu','','adm;2010-09-28 00:00:00 ');
XA END 'RAMBOpetShop';
XA PREPARE 'RAMBOpetShop';
XA COMMIT 'RAMBOpetShop';

-- Begin on 10/09/28 07:54:33 - petShop
XA START 'RAMBOpetShop';
insert into mst_service (service_code, service_name, notes,insert_log) values ('S006','Gunting Kuku','','adm;2010-09-28 00:00:00 ');
XA END 'RAMBOpetShop';
XA PREPARE 'RAMBOpetShop';
XA COMMIT 'RAMBOpetShop';

-- Begin on 10/09/28 07:54:47 - petShop
XA START 'RAMBOpetShop';
update mst_service set  service_code= 'S006', service_name= 'Gunting Kuku & Bersih Telinga', notes= '', edit_log= 'adm;2010-09-28 00:00:00 ' where service_id= 6;
XA END 'RAMBOpetShop';
XA PREPARE 'RAMBOpetShop';
XA COMMIT 'RAMBOpetShop';

-- Begin on 10/09/28 07:54:57 - petShop
XA START 'RAMBOpetShop';
insert into mst_service (service_code, service_name, notes,insert_log) values ('S007','Sewa Hotel','','adm;2010-09-28 00:00:00 ');
XA END 'RAMBOpetShop';
XA PREPARE 'RAMBOpetShop';
XA COMMIT 'RAMBOpetShop';

-- Begin on 10/09/28 20:27:49 - petShop
XA START 'RAMBOpetShop';
INSERT INTO mst_service_price(service_id,animal_id,price,add_price,insert_log)  VALUES(2,0,1000,500,'adm;2010-09-28 00:00:00 ');
XA END 'RAMBOpetShop';
XA PREPARE 'RAMBOpetShop';
XA ROLLBACK 'RAMBOpetShop';

-- Begin on 10/09/28 20:28:05 - petShop
XA START 'RAMBOpetShop';
INSERT INTO mst_service_price(service_id,animal_id,price,add_price,insert_log)  VALUES(2,0,1000,500,'adm;2010-09-28 00:00:00 ');
XA END 'RAMBOpetShop';
XA PREPARE 'RAMBOpetShop';
XA ROLLBACK 'RAMBOpetShop';

-- Begin on 10/09/28 20:29:32 - petShop
XA START 'RAMBOpetShop';
INSERT INTO mst_service_price(service_id,animal_id,price,add_price,insert_log)  VALUES(5,5,10000,0,'adm;2010-09-28 00:00:00 ');
INSERT INTO mst_service_price(service_id,animal_id,price,add_price,insert_log)  VALUES(5,4,10000,0,'adm;2010-09-28 00:00:00 ');
INSERT INTO mst_service_price(service_id,animal_id,price,add_price,insert_log)  VALUES(5,3,10000,0,'adm;2010-09-28 00:00:00 ');
INSERT INTO mst_service_price(service_id,animal_id,price,add_price,insert_log)  VALUES(5,2,10000,0,'adm;2010-09-28 00:00:00 ');
INSERT INTO mst_service_price(service_id,animal_id,price,add_price,insert_log)  VALUES(5,1,10000,0,'adm;2010-09-28 00:00:00 ');
XA END 'RAMBOpetShop';
XA PREPARE 'RAMBOpetShop';
XA COMMIT 'RAMBOpetShop';

-- Begin on 10/09/28 20:29:43 - petShop
XA START 'RAMBOpetShop';
UPDATE mst_service_price SET service_id = 5,animal_id =5,price =10000,add_price =500,edit_log ='adm;2010-09-28 00:00:00 ' WHERE service_price_id =1;
XA END 'RAMBOpetShop';
XA PREPARE 'RAMBOpetShop';
XA COMMIT 'RAMBOpetShop';

-- Begin on 10/09/28 20:36:38 - petShop
XA START 'RAMBOpetShop';
INSERT INTO mst_service_price(service_id,animal_id,price,add_price,insert_log)  VALUES(1,5,25000,0,'adm;2010-09-28 00:00:00 ');
XA END 'RAMBOpetShop';
XA PREPARE 'RAMBOpetShop';
XA COMMIT 'RAMBOpetShop';

-- Begin on 10/09/30 08:15:35 - petShop
XA START 'RAMBOpetShop';
insert into mst_relation (relation_type, relation_code, relation_name, address1, address2, post_code, city, phone1, phone2, contact_person, npwp, due_date) values (2,'SP.001','Kuncoro','gadsfd','dfas','3443','bandung','dfasd','3rae','asdfsd','',0);
XA END 'RAMBOpetShop';
XA PREPARE 'RAMBOpetShop';
XA COMMIT 'RAMBOpetShop';

-- Begin on 10/09/30 08:18:06 - petShop
XA START 'RAMBOpetShop';
insert into mst_relation (relation_type, relation_code, relation_name, address1, address2, post_code, city, phone1, phone2, contact_person, npwp, due_date) values (1,'CS.001','Fredy','Antapani','','','Bandung','0343','8888','','',0);
XA END 'RAMBOpetShop';
XA PREPARE 'RAMBOpetShop';
XA COMMIT 'RAMBOpetShop';

-- Begin on 10/09/30 08:18:22 - petShop
XA START 'RAMBOpetShop';
update mst_relation set  relation_type= 1, relation_code= 'CS.001', relation_name= 'Fredy', address1= 'Antapani', address2= '', post_code= '', city= 'Bandung', phone1= '0343', phone2= '8888', npwp= '', contact_person = 'Adrul', due_Date= 0 where relation_id= 2;
XA END 'RAMBOpetShop';
XA PREPARE 'RAMBOpetShop';
XA COMMIT 'RAMBOpetShop';

-- Begin on 10/09/30 09:37:14 - petShop
XA START 'RAMBOpetShop';
delete from mst_code where code_id = 2;
delete from mst_code where code_id = 2;
delete from mst_code where code_id = 2;
delete from mst_code where code_id = 2;
delete from mst_code where code_id = 2;
delete from mst_code where code_id = 2;
XA END 'RAMBOpetShop';
XA PREPARE 'RAMBOpetShop';
XA COMMIT 'RAMBOpetShop';

-- Begin on 10/09/30 09:37:19 - petShop
XA START 'RAMBOpetShop';
delete from mst_code where code_id = 3;
delete from mst_code where code_id = 3;
delete from mst_code where code_id = 3;
delete from mst_code where code_id = 3;
XA END 'RAMBOpetShop';
XA PREPARE 'RAMBOpetShop';
XA COMMIT 'RAMBOpetShop';

-- Begin on 10/09/30 09:37:25 - petShop
XA START 'RAMBOpetShop';
delete from mst_code where code_id = 11;
XA END 'RAMBOpetShop';
XA PREPARE 'RAMBOpetShop';
XA COMMIT 'RAMBOpetShop';

-- Begin on 10/09/30 09:37:30 - petShop
XA START 'RAMBOpetShop';
delete from mst_code where code_id = 5;
XA END 'RAMBOpetShop';
XA PREPARE 'RAMBOpetShop';
XA COMMIT 'RAMBOpetShop';

-- Begin on 10/09/30 09:37:35 - petShop
XA START 'RAMBOpetShop';
delete from mst_code where code_id = 6;
XA END 'RAMBOpetShop';
XA PREPARE 'RAMBOpetShop';
XA COMMIT 'RAMBOpetShop';

-- Begin on 10/09/30 09:37:38 - petShop
XA START 'RAMBOpetShop';
delete from mst_code where code_id = 10;
XA END 'RAMBOpetShop';
XA PREPARE 'RAMBOpetShop';
XA COMMIT 'RAMBOpetShop';

-- Begin on 10/09/30 09:37:42 - petShop
XA START 'RAMBOpetShop';
delete from mst_code where code_id = 25;
XA END 'RAMBOpetShop';
XA PREPARE 'RAMBOpetShop';
XA COMMIT 'RAMBOpetShop';

-- Begin on 10/09/30 09:37:45 - petShop
XA START 'RAMBOpetShop';
delete from mst_code where code_id = 33;
XA END 'RAMBOpetShop';
XA PREPARE 'RAMBOpetShop';
XA COMMIT 'RAMBOpetShop';

-- Begin on 10/09/30 09:37:48 - petShop
XA START 'RAMBOpetShop';
delete from mst_code where code_id = 4;
XA END 'RAMBOpetShop';
XA PREPARE 'RAMBOpetShop';
XA COMMIT 'RAMBOpetShop';

-- Begin on 10/09/30 09:37:52 - petShop
XA START 'RAMBOpetShop';
delete from mst_code where code_id = 36;
XA END 'RAMBOpetShop';
XA PREPARE 'RAMBOpetShop';
XA COMMIT 'RAMBOpetShop';

-- Begin on 10/09/30 09:37:57 - petShop
XA START 'RAMBOpetShop';
delete from mst_code where code_id = 1;
delete from mst_code where code_id = 1;
delete from mst_code where code_id = 1;
delete from mst_code where code_id = 1;
delete from mst_code where code_id = 1;
delete from mst_code where code_id = 1;
delete from mst_code where code_id = 1;
delete from mst_code where code_id = 1;
delete from mst_code where code_id = 1;
XA END 'RAMBOpetShop';
XA PREPARE 'RAMBOpetShop';
XA COMMIT 'RAMBOpetShop';

-- Begin on 10/09/30 09:42:33 - petShop
XA START 'RAMBOpetShop';
insert into mst_code (code_name,code_code, parent_id, urut, level) values ('Accessoris','',1,0,2);
insert into point_maping (code_id, root_id) values (2,2);
insert into point_maping (code_id, root_id) values (2,1);
XA END 'RAMBOpetShop';
XA PREPARE 'RAMBOpetShop';
XA COMMIT 'RAMBOpetShop';

-- Begin on 10/09/30 09:58:01 - petShop
XA START 'RAMBOpetShop';
insert into mst_code (code_name,code_code, parent_id, urut, level) values ('Susu','',2,0,3);
insert into point_maping (code_id, root_id) values (3,3);
insert into point_maping (code_id, root_id) values (3,2);
insert into point_maping (code_id, root_id) values (3,1);
XA END 'RAMBOpetShop';
XA PREPARE 'RAMBOpetShop';
XA COMMIT 'RAMBOpetShop';

-- Begin on 10/09/30 09:58:09 - petShop
XA START 'RAMBOpetShop';
delete from mst_code where code_id = 3;
XA END 'RAMBOpetShop';
XA PREPARE 'RAMBOpetShop';
XA COMMIT 'RAMBOpetShop';

-- Begin on 10/09/30 09:58:14 - petShop
XA START 'RAMBOpetShop';
insert into mst_code (code_name,code_code, parent_id, urut, level) values ('Susu','',1,0,2);
insert into point_maping (code_id, root_id) values (4,4);
insert into point_maping (code_id, root_id) values (4,1);
XA END 'RAMBOpetShop';
XA PREPARE 'RAMBOpetShop';
XA COMMIT 'RAMBOpetShop';

-- Begin on 10/09/30 09:58:25 - petShop
XA START 'RAMBOpetShop';
insert into mst_code (code_name,code_code, parent_id, urut, level) values ('Dog Food','',1,0,2);
insert into point_maping (code_id, root_id) values (5,5);
insert into point_maping (code_id, root_id) values (5,1);
XA END 'RAMBOpetShop';
XA PREPARE 'RAMBOpetShop';
XA COMMIT 'RAMBOpetShop';

-- Begin on 10/10/01 08:41:43 - petShop
XA START 'RAMBOpetShop';
update mst_item SET specification=2, item_code='132.132.1', barcode='132.132.1', struk_name='Absolute', merk='', avg_price=0, bkp=0, konsinyasi=0, vendor_id =NULL, produsen_id =NULL, kemasan_id =NULL, kategori =1, dosis =0, expire_date =cast('2010-10-01 'as date), item_name='Absolute' WHERE item_id=551;
delete from mst_rak_item where item_id = 551;
XA END 'RAMBOpetShop';
XA PREPARE 'RAMBOpetShop';
XA COMMIT 'RAMBOpetShop';

-- Begin on 10/10/01 09:29:37 - petShop
XA START 'RAMBOpetShop';
update mst_item SET specification=2, item_code='3.3.2', barcode='3.3.2', struk_name='Adalat 10', merk='', avg_price=0, bkp=0, konsinyasi=0, vendor_id =NULL, produsen_id =NULL, kemasan_id =26, kategori =2, dosis =0, expire_date =cast('2010-10-01 'as date), item_name='Adalat 10' WHERE item_id=3;
delete from mst_rak_item where item_id = 3;
XA END 'RAMBOpetShop';
XA PREPARE 'RAMBOpetShop';
XA COMMIT 'RAMBOpetShop';

-- Begin on 10/10/01 09:38:00 - petShop
XA START 'RAMBOpetShop';
insert into mst_item (specification, item_code, barcode, struk_name, merk, avg_price, vendor_id, produsen_id, kemasan_id, bkp, konsinyasi, item_name, dosis, kategori, expire_date) values (5,'0001','0001','Ekabuba puppy 2 Kg','Ekanuba',0,NULL,NULL,26,0,0,'Ekabuba puppy',0,NULL,cast('2010-10-01 'as date));
XA END 'RAMBOpetShop';
XA PREPARE 'RAMBOpetShop';
XA COMMIT 'RAMBOpetShop';

-- Begin on 10/10/01 09:38:27 - petShop
XA START 'RAMBOpetShop';
update mst_item SET specification=5, item_code='0001', barcode='TGHBKHKJH', struk_name='Ekabuba puppy 2 Kg', merk='Ekanuba', avg_price=0, bkp=0, konsinyasi=0, vendor_id =NULL, produsen_id =NULL, kemasan_id =NULL, kategori =NULL, dosis =0, expire_date =cast('2010-10-01 'as date), item_name='Ekabuba puppy' WHERE item_id=1;
delete from mst_rak_item where item_id = 1;
XA END 'RAMBOpetShop';
XA PREPARE 'RAMBOpetShop';
XA COMMIT 'RAMBOpetShop';

-- Begin on 10/10/01 09:40:42 - petShop
XA START 'RAMBOpetShop';
update mst_item SET specification=5, item_code='0001', barcode='TGHBKHKJH', struk_name='Ekabuba puppy 2 Kg', merk='Ekanuba', avg_price=0, bkp=0, konsinyasi=0, vendor_id =NULL, produsen_id =NULL, kemasan_id =26, kategori =NULL, dosis =0, expire_date =cast('2010-10-01 'as date), item_name='Ekabuba puppy' WHERE item_id=1;
delete from mst_rak_item where item_id = 1;
XA END 'RAMBOpetShop';
XA PREPARE 'RAMBOpetShop';
XA COMMIT 'RAMBOpetShop';

-- Begin on 10/10/04 19:47:41 - petShop
XA START 'RAMBOpetShop';
update mst_service set  service_code= 'S005', service_name= 'Cukur Bulu', notes= 'tes', service_type= 0, edit_log= 'adm;2010-10-04 00:00:00 ' where service_id= 5;
XA END 'RAMBOpetShop';
XA PREPARE 'RAMBOpetShop';
XA COMMIT 'RAMBOpetShop';

-- Begin on 10/10/04 19:49:37 - petShop
XA START 'RAMBOpetShop';
update mst_service set  service_code= 'S002', service_name= 'Mandi Flea & Tick', notes= ' ', service_type= 27, edit_log= 'adm;2010-10-04 00:00:00 ' where service_id= 2;
XA END 'RAMBOpetShop';
XA PREPARE 'RAMBOpetShop';
XA COMMIT 'RAMBOpetShop';

-- Begin on 10/10/04 19:50:57 - petShop
XA START 'RAMBOpetShop';
update mst_service set  service_code= 'S007', service_name= 'Sewa Hotel', notes= '', service_type= 28, edit_log= 'adm;2010-10-04 00:00:00 ' where service_id= 7;
XA END 'RAMBOpetShop';
XA PREPARE 'RAMBOpetShop';
XA COMMIT 'RAMBOpetShop';
insert into mst_branch (branch_name, nickname, branch_code, address, phone1, phone2,  fax, city,  post_code,insert_log) values ('Jangki Jaksel', 'J001', 'Cinere', '22323`', '03493904', '094304034', 'JakSEL', '232','adm;2010-10-05 00:00:00 ');
insert into mst_branch (branch_name, branch_code, address, phone1, phone2,  fax, city,  post_code,insert_log) values ('J-jaksel', 'J001', 'Jl.Cinere', '3434', '344', '343', 'Bandung', 'kdfk','adm;2010-10-05 00:00:00 ');
insert into mst_branch (branch_name, branch_code, address, phone1, phone2,  fax, city,  postal_code,insert_log) values ('kdkfk', 'J001', 'kdaskjfas', '2323', '2323', 'gfdsf', 'dfasdf', '32','adm;2010-10-05 00:00:00 ');
insert into mst_branch (branch_name, branch_code, address, phone1, phone2,  fax, city,  postal_code,insert_log) values ('Jakde', 'J0001', 'Cinere', '0210202', '021094343', 'fasdfds', 'Jakata Selatan', '2323','adm;2010-10-05 00:00:00 ');
update mst_branch set branch_name = 'Jakde', branch_code = 'J0001', address = 'Cinere', phone1 = '0210202', phone2 = '021094343', fax = '02020202', city = 'Jakata Selatan', postal_code = '2323',,edit_log='adm;2010-10-05 00:00:00 ' where branch_id = 2;
update mst_branch set branch_name = 'Jakde', branch_code = 'J0001', address = 'Cinere', phone1 = '0210202', phone2 = '021094343', fax = '0213435435', city = 'Jakata Selatan', postal_code = '2323',edit_log='adm;2010-10-05 00:00:00 ' where branch_id = 2;

-- Begin on 10/10/31 08:06:06 - cashier
XA START 'RAMBOcashier';
insert into mst_relation (relation_type, relation_code, relation_name, address1, address2, post_code, city, phone1, phone2, contact_person, npwp, due_date) values (1,'CS.003','Mulyati','Nata endah','','','','','','','',0);
XA END 'RAMBOcashier';
XA PREPARE 'RAMBOcashier';
XA COMMIT 'RAMBOcashier';

-- Begin on 10/10/31 08:06:38 - cashier
XA START 'RAMBOcashier';
update mst_relation set  relation_type= 1, relation_code= 'CS.003', relation_name= 'Mulyati', address1= 'Nata endah', address2= '', post_code= '', city= '', phone1= '', phone2= '', npwp= '', contact_person = '', due_Date= 0 where relation_id= 5;
XA END 'RAMBOcashier';
XA PREPARE 'RAMBOcashier';
XA COMMIT 'RAMBOcashier';

-- Begin on 10/10/31 08:06:40 - cashier
XA START 'RAMBOcashier';
INSERT INTO Mst_Relation_Animal (Relation_ID,Seq,Animal_Name,Animal_ID,Race,Eat,Age,Sex) VALUES (5,1,'atut',1,'Kampung','Asin urut',2,1);
XA END 'RAMBOcashier';
XA PREPARE 'RAMBOcashier';
XA COMMIT 'RAMBOcashier';

-- Begin on 10/10/31 08:06:42 - cashier
XA START 'RAMBOcashier';
UPDATE Mst_Relation_Animal SET Animal_Name='atut', Animal_ID=1, Race='Kampung', Eat='Asin urut', Age=2, Sex=1 WHERE Relation_ID=5 AND Seq=1;
XA END 'RAMBOcashier';
XA PREPARE 'RAMBOcashier';
XA COMMIT 'RAMBOcashier';

-- Begin on 10/10/31 08:06:42 - cashier
XA START 'RAMBOcashier';
UPDATE Mst_Relation_Animal SET Animal_Name='atut', Animal_ID=1, Race='Kampung', Eat='Asin urut', Age=2, Sex=1 WHERE Relation_ID=5 AND Seq=1;
XA END 'RAMBOcashier';
XA PREPARE 'RAMBOcashier';
XA COMMIT 'RAMBOcashier';

-- Begin on 10/10/31 08:06:42 - cashier
XA START 'RAMBOcashier';
UPDATE Mst_Relation_Animal SET Animal_Name='atut', Animal_ID=1, Race='Kampung', Eat='Asin urut', Age=2, Sex=1 WHERE Relation_ID=5 AND Seq=1;
XA END 'RAMBOcashier';
XA PREPARE 'RAMBOcashier';
XA COMMIT 'RAMBOcashier';

-- Begin on 10/10/31 08:06:42 - cashier
XA START 'RAMBOcashier';
UPDATE Mst_Relation_Animal SET Animal_Name='atut', Animal_ID=1, Race='Kampung', Eat='Asin urut', Age=2, Sex=1 WHERE Relation_ID=5 AND Seq=1;
XA END 'RAMBOcashier';
XA PREPARE 'RAMBOcashier';
XA COMMIT 'RAMBOcashier';

-- Begin on 10/10/31 08:06:45 - cashier
XA START 'RAMBOcashier';
UPDATE Mst_Relation_Animal SET Animal_Name='atut', Animal_ID=1, Race='Kampung', Eat='Asin urut', Age=2, Sex=1 WHERE Relation_ID=5 AND Seq=1;
XA END 'RAMBOcashier';
XA PREPARE 'RAMBOcashier';
XA COMMIT 'RAMBOcashier';

-- Begin on 10/10/31 08:06:45 - cashier
XA START 'RAMBOcashier';
UPDATE Mst_Relation_Animal SET Animal_Name='atut', Animal_ID=1, Race='Kampung', Eat='Asin urut', Age=2, Sex=1 WHERE Relation_ID=5 AND Seq=1;
XA END 'RAMBOcashier';
XA PREPARE 'RAMBOcashier';
XA COMMIT 'RAMBOcashier';

-- Begin on 10/10/31 08:06:45 - cashier
XA START 'RAMBOcashier';
UPDATE Mst_Relation_Animal SET Animal_Name='atut', Animal_ID=1, Race='Kampung', Eat='Asin urut', Age=2, Sex=1 WHERE Relation_ID=5 AND Seq=1;
XA END 'RAMBOcashier';
XA PREPARE 'RAMBOcashier';
XA COMMIT 'RAMBOcashier';

-- Begin on 10/10/31 08:06:47 - cashier
XA START 'RAMBOcashier';
UPDATE Mst_Relation_Animal SET Animal_Name='atut', Animal_ID=1, Race='Kampung', Eat='Asin urut', Age=2, Sex=1 WHERE Relation_ID=5 AND Seq=1;
XA END 'RAMBOcashier';
XA PREPARE 'RAMBOcashier';
XA COMMIT 'RAMBOcashier';

-- Begin on 10/10/31 08:06:55 - cashier
XA START 'RAMBOcashier';
UPDATE Mst_Relation_Animal SET Animal_Name='atut', Animal_ID=1, Race='Kampung', Eat='Asin urut', Age=2, Sex=1 WHERE Relation_ID=5 AND Seq=1;
XA END 'RAMBOcashier';
XA PREPARE 'RAMBOcashier';
XA COMMIT 'RAMBOcashier';

-- Begin on 10/10/31 08:06:55 - cashier
XA START 'RAMBOcashier';
UPDATE Mst_Relation_Animal SET Animal_Name='atut', Animal_ID=1, Race='Kampung', Eat='Asin urut', Age=2, Sex=1 WHERE Relation_ID=5 AND Seq=1;
XA END 'RAMBOcashier';
XA PREPARE 'RAMBOcashier';
XA COMMIT 'RAMBOcashier';

-- Begin on 10/10/31 08:06:56 - cashier
XA START 'RAMBOcashier';
UPDATE Mst_Relation_Animal SET Animal_Name='atut', Animal_ID=1, Race='Kampung', Eat='Asin urut', Age=2, Sex=1 WHERE Relation_ID=5 AND Seq=1;
XA END 'RAMBOcashier';
XA PREPARE 'RAMBOcashier';
XA COMMIT 'RAMBOcashier';

-- Begin on 10/10/31 08:06:56 - cashier
XA START 'RAMBOcashier';
UPDATE Mst_Relation_Animal SET Animal_Name='atut', Animal_ID=1, Race='Kampung', Eat='Asin urut', Age=2, Sex=1 WHERE Relation_ID=5 AND Seq=1;
XA END 'RAMBOcashier';
XA PREPARE 'RAMBOcashier';
XA COMMIT 'RAMBOcashier';

-- Begin on 10/10/31 08:06:57 - cashier
XA START 'RAMBOcashier';
UPDATE Mst_Relation_Animal SET Animal_Name='atut', Animal_ID=1, Race='Kampung', Eat='Asin urut', Age=2, Sex=1 WHERE Relation_ID=5 AND Seq=1;
XA END 'RAMBOcashier';
XA PREPARE 'RAMBOcashier';
XA COMMIT 'RAMBOcashier';

-- Begin on 10/10/31 08:06:57 - cashier
XA START 'RAMBOcashier';
UPDATE Mst_Relation_Animal SET Animal_Name='atut', Animal_ID=1, Race='Kampung', Eat='Asin urut', Age=2, Sex=1 WHERE Relation_ID=5 AND Seq=1;
XA END 'RAMBOcashier';
XA PREPARE 'RAMBOcashier';
XA COMMIT 'RAMBOcashier';

-- Begin on 10/10/31 08:06:57 - cashier
XA START 'RAMBOcashier';
UPDATE Mst_Relation_Animal SET Animal_Name='atut', Animal_ID=1, Race='Kampung', Eat='Asin urut', Age=2, Sex=1 WHERE Relation_ID=5 AND Seq=1;
XA END 'RAMBOcashier';
XA PREPARE 'RAMBOcashier';
XA COMMIT 'RAMBOcashier';

-- Begin on 10/10/31 08:06:57 - cashier
XA START 'RAMBOcashier';
UPDATE Mst_Relation_Animal SET Animal_Name='atut', Animal_ID=1, Race='Kampung', Eat='Asin urut', Age=2, Sex=1 WHERE Relation_ID=5 AND Seq=1;
XA END 'RAMBOcashier';
XA PREPARE 'RAMBOcashier';
XA COMMIT 'RAMBOcashier';

-- Begin on 10/10/31 08:06:57 - cashier
XA START 'RAMBOcashier';
UPDATE Mst_Relation_Animal SET Animal_Name='atut', Animal_ID=1, Race='Kampung', Eat='Asin urut', Age=2, Sex=1 WHERE Relation_ID=5 AND Seq=1;
XA END 'RAMBOcashier';
XA PREPARE 'RAMBOcashier';
XA COMMIT 'RAMBOcashier';

-- Begin on 10/10/31 08:06:58 - cashier
XA START 'RAMBOcashier';
UPDATE Mst_Relation_Animal SET Animal_Name='atut', Animal_ID=1, Race='Kampung', Eat='Asin urut', Age=2, Sex=1 WHERE Relation_ID=5 AND Seq=1;
XA END 'RAMBOcashier';
XA PREPARE 'RAMBOcashier';
XA COMMIT 'RAMBOcashier';

-- Begin on 10/10/31 08:06:58 - cashier
XA START 'RAMBOcashier';
UPDATE Mst_Relation_Animal SET Animal_Name='atut', Animal_ID=1, Race='Kampung', Eat='Asin urut', Age=2, Sex=1 WHERE Relation_ID=5 AND Seq=1;
XA END 'RAMBOcashier';
XA PREPARE 'RAMBOcashier';
XA COMMIT 'RAMBOcashier';

-- Begin on 10/10/31 08:06:59 - cashier
XA START 'RAMBOcashier';
UPDATE Mst_Relation_Animal SET Animal_Name='atut', Animal_ID=1, Race='Kampung', Eat='Asin urut', Age=2, Sex=1 WHERE Relation_ID=5 AND Seq=1;
XA END 'RAMBOcashier';
XA PREPARE 'RAMBOcashier';
XA COMMIT 'RAMBOcashier';

-- Begin on 10/10/31 08:07:00 - cashier
XA START 'RAMBOcashier';
UPDATE Mst_Relation_Animal SET Animal_Name='atut', Animal_ID=1, Race='Kampung', Eat='Asin urut', Age=2, Sex=1 WHERE Relation_ID=5 AND Seq=1;
XA END 'RAMBOcashier';
XA PREPARE 'RAMBOcashier';
XA COMMIT 'RAMBOcashier';

-- Begin on 10/10/31 08:07:00 - cashier
XA START 'RAMBOcashier';
UPDATE Mst_Relation_Animal SET Animal_Name='atut', Animal_ID=1, Race='Kampung', Eat='Asin urut', Age=2, Sex=1 WHERE Relation_ID=5 AND Seq=1;
XA END 'RAMBOcashier';
XA PREPARE 'RAMBOcashier';
XA COMMIT 'RAMBOcashier';

-- Begin on 10/10/31 08:07:00 - cashier
XA START 'RAMBOcashier';
UPDATE Mst_Relation_Animal SET Animal_Name='atut', Animal_ID=1, Race='Kampung', Eat='Asin urut', Age=2, Sex=1 WHERE Relation_ID=5 AND Seq=1;
XA END 'RAMBOcashier';
XA PREPARE 'RAMBOcashier';
XA COMMIT 'RAMBOcashier';

-- Begin on 10/10/31 08:07:01 - cashier
XA START 'RAMBOcashier';
UPDATE Mst_Relation_Animal SET Animal_Name='atut', Animal_ID=1, Race='Kampung', Eat='Asin urut', Age=2, Sex=1 WHERE Relation_ID=5 AND Seq=1;
XA END 'RAMBOcashier';
XA PREPARE 'RAMBOcashier';
XA COMMIT 'RAMBOcashier';

-- Begin on 10/10/31 08:07:01 - cashier
XA START 'RAMBOcashier';
UPDATE Mst_Relation_Animal SET Animal_Name='atut', Animal_ID=1, Race='Kampung', Eat='Asin urut', Age=2, Sex=1 WHERE Relation_ID=5 AND Seq=1;
XA END 'RAMBOcashier';
XA PREPARE 'RAMBOcashier';
XA COMMIT 'RAMBOcashier';

-- Begin on 10/10/31 08:19:23 - petShop
XA START 'RAMBOpetShop';
insert into trs_order_mst (trans_num, tipe, trans_date, expr_date, delivery_date, relation_id, subtotal, disc_mst, disc_detail, tax, total, user_id, notes, dpp_disc2, pay_term, status_id) values ('PO/20101000002',2,cast('2010-10-31 'as date),cast('2010-10-31 'as date),cast('2010-10-31 'as date),1,81000,0,0,0,81000,'adm','',0,0,0);
insert into trs_order_detail (order_id, item_id,  quantity, price, disc, amount, conversion, disc_is_prc, tax)values (last_insert_id(), 7,9,9000,0,81000,1,0,0);
XA END 'RAMBOpetShop';
XA PREPARE 'RAMBOpetShop';
XA COMMIT 'RAMBOpetShop';
update trs_order_mst set status_id = 1 where order_id = 2;

-- Begin on 10/10/31 08:20:35 - petShop
XA START 'RAMBOpetShop';
insert into trs_receipt_mst (trans_num, trans_date, tipe, expr_date, relation_id, order_id, gudang_id, subtotal, disc_detail, disc_mst, tax, biaya, materai, total, notes, dpp_disc2, user_id) values ('RC/20101000002',cast('2010-10-31 'as date),0,cast('1899-12-30 'as date),1,2,1,85500,0,0,0,0,0,85500,'',0,'adm');
insert into trs_receipt_detail (receipt_id, item_id, conv_id, conv_bonus_id, quantity, qty_bonus, price, amount, disc1, disc2, disc3, conversion, conv_bonus, disc1_is_prc, disc2_is_prc, disc3_is_prc, tax)values (last_insert_id(), 7,0,0,9,0,9500,85500,0,0,0,1,0,0,0,0,0);
update trs_order_mst set sudah_diterima = 1 where order_id = 2;
XA END 'RAMBOpetShop';
XA PREPARE 'RAMBOpetShop';
XA COMMIT 'RAMBOpetShop';

-- Begin on 10/10/31 08:20:36 - petShop
XA START 'RAMBOpetShop';
update trs_receipt_mst set status_id = 1, sisa = total where receipt_id = 2;
update mst_item set buying_price = 9500, avg_price = (ifnull((0 * avg_price),0) + 85500) / (ifnull(0,0) + 9) where item_id = 7;
update mst_item set current_stock = current_stock + 9 where item_id = 7;
call save_to_item_balance(1, 7, cast('2010-10-31 'as date), 9, 'D');
call save_to_relation_balance(1, cast('2010-10-31 'as date), 85500, 'D');
update mst_relation set current_debt = current_debt + 85500 where relation_id = 1;
XA END 'RAMBOpetShop';
XA PREPARE 'RAMBOpetShop';
XA COMMIT 'RAMBOpetShop';

-- Begin on 10/11/09 09:36:45 - petShop
XA START 'RAMBOpetShop';
update mst_item set  discount = 10 WHERE item_id = 43;
update mst_item set  discount = 10 WHERE item_id = 43;
update mst_item set  discount = 10 WHERE item_id = 53;
update mst_item set  discount = 10 WHERE item_id = 53;
update mst_item set  discount = 5 WHERE item_id = 3;
update mst_item set  discount = 5 WHERE item_id = 3;
XA END 'RAMBOpetShop';
XA PREPARE 'RAMBOpetShop';
XA COMMIT 'RAMBOpetShop';
DELETE FROM System_Users WHERE User_Id='Wina';
delete from system_access where user_id = 'Wina';  DELETE FROM System_Users WHERE User_Id='Wina';
Delete from system_access where user_id = 'Welinda';
 DELETE FROM System_Users WHERE User_Id='Welinda';

-- Begin on 10/11/09 09:43:26 - petShop
XA START 'RAMBOpetShop';
UPDATE System_Users SET User_Name='lundz', Access_Level=1 WHERE User_Id='lundz';
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0 WHERE User_Id='lundz' AND Menu_Id=101;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0 WHERE User_Id='lundz' AND Menu_Id=102;
INSERT INTO System_Access (User_Id,Menu_Id,Access_List,Outlook_Panel,Outlook_Button,Usage_Count, can_acces) VALUES ('lundz',103,0,'','',0,0);
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0 WHERE User_Id='lundz' AND Menu_Id=202;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0 WHERE User_Id='lundz' AND Menu_Id=210;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0 WHERE User_Id='lundz' AND Menu_Id=212;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0 WHERE User_Id='lundz' AND Menu_Id=213;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0 WHERE User_Id='lundz' AND Menu_Id=214;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0 WHERE User_Id='lundz' AND Menu_Id=215;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0 WHERE User_Id='lundz' AND Menu_Id=216;
INSERT INTO System_Access (User_Id,Menu_Id,Access_List,Outlook_Panel,Outlook_Button,Usage_Count, can_acces) VALUES ('lundz',217,0,'','',0,0);
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0 WHERE User_Id='lundz' AND Menu_Id=220;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0 WHERE User_Id='lundz' AND Menu_Id=223;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0 WHERE User_Id='lundz' AND Menu_Id=300;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0 WHERE User_Id='lundz' AND Menu_Id=301;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0 WHERE User_Id='lundz' AND Menu_Id=302;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0 WHERE User_Id='lundz' AND Menu_Id=322;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0 WHERE User_Id='lundz' AND Menu_Id=323;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0 WHERE User_Id='lundz' AND Menu_Id=330;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0 WHERE User_Id='lundz' AND Menu_Id=331;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0 WHERE User_Id='lundz' AND Menu_Id=501;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0 WHERE User_Id='lundz' AND Menu_Id=510;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0 WHERE User_Id='lundz' AND Menu_Id=1001;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0 WHERE User_Id='lundz' AND Menu_Id=1002;
XA END 'RAMBOpetShop';
XA PREPARE 'RAMBOpetShop';
XA COMMIT 'RAMBOpetShop';

-- Begin on 10/11/09 09:53:49 - petShop
XA START 'RAMBOpetShop';
UPDATE System_Users SET User_Name='lundz', Access_Level=1 WHERE User_Id='lundz';
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='lundz' AND Menu_Id=101;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='lundz' AND Menu_Id=102;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='lundz' AND Menu_Id=103;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =-1, Can_edit =-1, Can_delete =-1, Can_view =-1, Can_print =-1 WHERE User_Id='lundz' AND Menu_Id=202;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='lundz' AND Menu_Id=210;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='lundz' AND Menu_Id=212;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='lundz' AND Menu_Id=213;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='lundz' AND Menu_Id=214;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='lundz' AND Menu_Id=215;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='lundz' AND Menu_Id=216;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='lundz' AND Menu_Id=217;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='lundz' AND Menu_Id=220;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='lundz' AND Menu_Id=223;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='lundz' AND Menu_Id=300;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='lundz' AND Menu_Id=301;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='lundz' AND Menu_Id=302;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='lundz' AND Menu_Id=322;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='lundz' AND Menu_Id=323;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='lundz' AND Menu_Id=330;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='lundz' AND Menu_Id=331;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='lundz' AND Menu_Id=501;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='lundz' AND Menu_Id=510;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='lundz' AND Menu_Id=1001;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='lundz' AND Menu_Id=1002;
XA END 'RAMBOpetShop';
XA PREPARE 'RAMBOpetShop';
XA COMMIT 'RAMBOpetShop';

-- Begin on 10/11/09 09:53:57 - petShop
XA START 'RAMBOpetShop';
UPDATE System_Users SET User_Name='lundz', Access_Level=1 WHERE User_Id='lundz';
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='lundz' AND Menu_Id=101;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='lundz' AND Menu_Id=102;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='lundz' AND Menu_Id=103;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =-1, Can_edit =-1, Can_delete =-1, Can_view =-1, Can_print =-1 WHERE User_Id='lundz' AND Menu_Id=202;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =-1, Can_edit =-1, Can_delete =-1, Can_view =-1, Can_print =-1 WHERE User_Id='lundz' AND Menu_Id=210;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='lundz' AND Menu_Id=212;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='lundz' AND Menu_Id=213;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='lundz' AND Menu_Id=214;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='lundz' AND Menu_Id=215;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='lundz' AND Menu_Id=216;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='lundz' AND Menu_Id=217;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='lundz' AND Menu_Id=220;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='lundz' AND Menu_Id=223;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='lundz' AND Menu_Id=300;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='lundz' AND Menu_Id=301;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='lundz' AND Menu_Id=302;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='lundz' AND Menu_Id=322;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='lundz' AND Menu_Id=323;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='lundz' AND Menu_Id=330;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='lundz' AND Menu_Id=331;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='lundz' AND Menu_Id=501;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='lundz' AND Menu_Id=510;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='lundz' AND Menu_Id=1001;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='lundz' AND Menu_Id=1002;
XA END 'RAMBOpetShop';
XA PREPARE 'RAMBOpetShop';
XA COMMIT 'RAMBOpetShop';
UPDATE System_Users SET Passwd= password('1') WHERE User_Id='lundz';

-- Begin on 10/11/09 18:42:38 - petShop
XA START 'RAMBOpetShop';
UPDATE System_Users SET User_Name='lundz', Access_Level=1 WHERE User_Id='lundz';
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='lundz' AND Menu_Id=101;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='lundz' AND Menu_Id=102;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='lundz' AND Menu_Id=103;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =-1, Can_edit =-1, Can_delete =-1, Can_view =-1, Can_print =-1 WHERE User_Id='lundz' AND Menu_Id=202;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =-1, Can_delete =-1, Can_view =-1, Can_print =-1 WHERE User_Id='lundz' AND Menu_Id=210;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='lundz' AND Menu_Id=212;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='lundz' AND Menu_Id=213;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='lundz' AND Menu_Id=214;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='lundz' AND Menu_Id=215;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='lundz' AND Menu_Id=216;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='lundz' AND Menu_Id=217;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='lundz' AND Menu_Id=220;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='lundz' AND Menu_Id=223;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='lundz' AND Menu_Id=300;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='lundz' AND Menu_Id=301;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='lundz' AND Menu_Id=302;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='lundz' AND Menu_Id=322;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='lundz' AND Menu_Id=323;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='lundz' AND Menu_Id=330;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='lundz' AND Menu_Id=331;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='lundz' AND Menu_Id=501;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='lundz' AND Menu_Id=510;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='lundz' AND Menu_Id=1001;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='lundz' AND Menu_Id=1002;
XA END 'RAMBOpetShop';
XA PREPARE 'RAMBOpetShop';
XA COMMIT 'RAMBOpetShop';

-- Begin on 10/11/09 18:47:14 - petShop
XA START 'RAMBOpetShop';
XA END 'RAMBOpetShop';
XA PREPARE 'RAMBOpetShop';
XA COMMIT 'RAMBOpetShop';

-- Begin on 10/11/09 18:48:18 - petShop
XA START 'RAMBOpetShop';
UPDATE System_Users SET User_Name='lundz', Access_Level=1 WHERE User_Id='lundz';
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='lundz' AND Menu_Id=101;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='lundz' AND Menu_Id=102;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='lundz' AND Menu_Id=103;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =-1, Can_edit =-1, Can_delete =-1, Can_view =-1, Can_print =-1 WHERE User_Id='lundz' AND Menu_Id=202;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =-1, Can_delete =-1, Can_view =-1, Can_print =-1 WHERE User_Id='lundz' AND Menu_Id=210;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='lundz' AND Menu_Id=212;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='lundz' AND Menu_Id=213;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =-1, Can_print =0 WHERE User_Id='lundz' AND Menu_Id=214;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =-1, Can_delete =0, Can_view =-1, Can_print =0 WHERE User_Id='lundz' AND Menu_Id=215;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =-1, Can_print =0 WHERE User_Id='lundz' AND Menu_Id=216;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =-1, Can_print =0 WHERE User_Id='lundz' AND Menu_Id=217;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='lundz' AND Menu_Id=220;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='lundz' AND Menu_Id=223;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='lundz' AND Menu_Id=300;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='lundz' AND Menu_Id=301;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='lundz' AND Menu_Id=302;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='lundz' AND Menu_Id=322;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='lundz' AND Menu_Id=323;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='lundz' AND Menu_Id=330;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='lundz' AND Menu_Id=331;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='lundz' AND Menu_Id=501;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='lundz' AND Menu_Id=510;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='lundz' AND Menu_Id=1001;
UPDATE System_Access SET Access_List=0, Outlook_Panel='', Outlook_Button='', Usage_Count=0, Can_Acces =0, Can_Add =0, Can_edit =0, Can_delete =0, Can_view =0, Can_print =0 WHERE User_Id='lundz' AND Menu_Id=1002;
XA END 'RAMBOpetShop';
XA PREPARE 'RAMBOpetShop';
XA COMMIT 'RAMBOpetShop';

-- Begin on 10/11/16 07:15:26 - petShop
XA START 'RAMBOpetShop';
insert into trs_retur_mst (trans_num, trans_date, tipe, relation_id, gudang_id, subtotal, discount, tax, biaya, materai, total, notes, user_id) values ('RT/20101100005',cast('2010-11-16 'as date),0,1,1,278000,0,0,0,0,278000,'','adm');
insert into trs_retur_detail (retur_id, item_id, conv_id, quantity, price, amount, disc, tax, disc_is_prc, conversion, faktur_id)values (last_insert_id(), 56,0,2,23000,46000,0,0,0,1,NULL);
insert into trs_retur_detail (retur_id, item_id, conv_id, quantity, price, amount, disc, tax, disc_is_prc, conversion, faktur_id)values (last_insert_id(), 8,0,1,232000,232000,0,0,0,1,NULL);
XA END 'RAMBOpetShop';
XA PREPARE 'RAMBOpetShop';
XA COMMIT 'RAMBOpetShop';

-- Begin on 11/01/30 08:24:42 - cashier
XA START 'RAMBOcashier';
insert into trs_sales_mst (trans_num, trans_type, trans_date, cashier_id, gudang_id, pasien_id, subtotal, profit, disc_mst, disc_val_mst, disc_detail, tax, total, embalase, real_amount, sisa, user_id, shift_id, cash, cara_bayar, card_id, bank,animal_seq,animal_id, dokter_id,dp, no_resep) values (get_new_sales_num('201101'), 13,cast('2011-01-30 'as date),5,1,NULL,95000,23750,0,0,0,0,95000,0,95000,0,'adm',0,95000,1,'3432','bca','','',NULL,0,'');
insert into trs_sales_detail (sales_id, item_id, quantity, price, disc, disc_val, amount, amount_profit, price_purchase, paket_id, points, hrg_beli, conversion)values ((select sales_id from trs_sales_mst y where y.trans_num = (select max(x.trans_num) from trs_sales_mst x where x.cashier_id = 5) and y.cashier_id = 5), 10,1,95000,5,0,95000,23750,0,NULL,0,71250,1);
update mst_item set current_stock = current_stock + -1 where item_id = 10;
call save_to_item_balance(1, 10, cast('2011-01-30 'as date), 1, 'C');
call save_to_cashier_balance(5, 1, 0, 95000, 4750, 0, 0, 'D', 'adm');
XA END 'RAMBOcashier';
XA PREPARE 'RAMBOcashier';
XA COMMIT 'RAMBOcashier';

-- Begin on 11/01/30 08:25:11 - cashier
XA START 'RAMBOcashier';
insert into trs_sales_mst (trans_num, trans_type, trans_date, cashier_id, gudang_id, pasien_id, subtotal, profit, disc_mst, disc_val_mst, disc_detail, tax, total, embalase, real_amount, sisa, user_id, shift_id, cash, cara_bayar, card_id, bank,animal_seq,animal_id, dokter_id,dp, no_resep) values (get_new_sales_num('201101'), 13,cast('2011-01-30 'as date),5,1,NULL,5000,920,0,0,0,0,5000,0,5000,0,'adm',0,10000,0,'','','','',NULL,0,'');
insert into trs_sales_detail (sales_id, item_id, quantity, price, disc, disc_val, amount, amount_profit, price_purchase, paket_id, points, hrg_beli, conversion)values ((select sales_id from trs_sales_mst y where y.trans_num = (select max(x.trans_num) from trs_sales_mst x where x.cashier_id = 5) and y.cashier_id = 5), 18,1,5000,5,0,5000,920,0,NULL,0,4080,1);
update mst_item set current_stock = current_stock + -1 where item_id = 18;
call save_to_item_balance(1, 18, cast('2011-01-30 'as date), 1, 'C');
call save_to_cashier_balance(5, 0, 0, 5000, 250, 0, 0, 'D', 'adm');
XA END 'RAMBOcashier';
XA PREPARE 'RAMBOcashier';
XA COMMIT 'RAMBOcashier';

-- Begin on 11/01/30 08:31:35 - cashier
XA START 'RAMBOcashier';
insert into trs_sales_mst (trans_num, trans_type, trans_date, cashier_id, gudang_id, pasien_id, subtotal, profit, disc_mst, disc_val_mst, disc_detail, tax, total, embalase, real_amount, sisa, user_id, shift_id, cash, cara_bayar, card_id, bank,animal_seq,animal_id, dokter_id,dp, no_resep) values (get_new_sales_num('201101'), 13,cast('2011-01-30 'as date),5,1,11,248000,14175,0,0,0,0,248000,0,248000,0,'adm',0,248000,1,'41004009472748686','bca','1;','',NULL,0,'');
insert into trs_sales_detail (sales_id, item_id, quantity, price, disc, disc_val, amount, amount_profit, price_purchase, paket_id, points, hrg_beli, conversion)values ((select sales_id from trs_sales_mst y where y.trans_num = (select max(x.trans_num) from trs_sales_mst x where x.cashier_id = 5) and y.cashier_id = 5), 28,1,25000,5,0,25000,4175,0,NULL,0,20825,1);
update mst_item set current_stock = current_stock + -1 where item_id = 28;
call save_to_item_balance(1, 28, cast('2011-01-30 'as date), 1, 'C');
insert into trs_sales_detail (sales_id, item_id, quantity, price, disc, disc_val, amount, amount_profit, price_purchase, paket_id, points, hrg_beli, conversion)values ((select sales_id from trs_sales_mst y where y.trans_num = (select max(x.trans_num) from trs_sales_mst x where x.cashier_id = 5) and y.cashier_id = 5), 294,1,73000,5,0,73000,10000,0,NULL,0,63000,1);
update mst_item set current_stock = current_stock + -1 where item_id = 294;
call save_to_item_balance(1, 294, cast('2011-01-30 'as date), 1, 'C');
insert into trs_sales_detail (sales_id, item_id, quantity, price, disc, disc_val, amount, amount_profit, price_purchase, paket_id, points, hrg_beli, conversion)values ((select sales_id from trs_sales_mst y where y.trans_num = (select max(x.trans_num) from trs_sales_mst x where x.cashier_id = 5) and y.cashier_id = 5), NULL,1,100000,0,0,100000,100000,0,4,0,0,1);
call put_customer_service(11,27,1,0);
insert into trs_sales_detail (sales_id, item_id, quantity, price, disc, disc_val, amount, amount_profit, price_purchase, paket_id, points, hrg_beli, conversion)values ((select sales_id from trs_sales_mst y where y.trans_num = (select max(x.trans_num) from trs_sales_mst x where x.cashier_id = 5) and y.cashier_id = 5), NULL,1,50000,0,0,50000,50000,0,14,0,0,1);
call put_customer_service(11,29,1,0);
call save_to_cashier_balance(5, 1, 0, 248000, 4900, 0, 0, 'D', 'adm');
XA END 'RAMBOcashier';
XA PREPARE 'RAMBOcashier';
XA COMMIT 'RAMBOcashier';

-- Begin on 11/01/30 08:36:01 - petShop
XA START 'RAMBOpetShop';
insert into mst_item (specification, item_code, barcode, struk_name, merk, avg_price, vendor_id, produsen_id, kemasan_id, bkp, konsinyasi, item_name, dosis, kategori, expire_date) values (19,'0578','0578','','',0,NULL,NULL,NULL,0,0,'kelinci lembang',0,1,cast('2011-01-30 'as date));
XA END 'RAMBOpetShop';
XA PREPARE 'RAMBOpetShop';
XA COMMIT 'RAMBOpetShop';

-- Begin on 11/01/30 08:38:03 - petShop
XA START 'RAMBOpetShop';
update mst_item SET specification=19, item_code='0578', barcode='0578', struk_name='kelinci lembang', merk='', avg_price=0, bkp=0, konsinyasi=0, vendor_id =NULL, produsen_id =NULL, kemasan_id =NULL, kategori =1, dosis =0, expire_date =cast('2011-01-30 'as date), buying_price =0, selling_price =0, item_name='kelinci' WHERE item_id=578;
delete from mst_rak_item where item_id = 578;
XA END 'RAMBOpetShop';
XA PREPARE 'RAMBOpetShop';
XA COMMIT 'RAMBOpetShop';

-- Begin on 11/01/30 08:39:37 - petShop
XA START 'RAMBOpetShop';
update mst_item set  selling_price = 50000 WHERE item_id = 578;
insert into mst_selling_price_hist(item_id,price,end_date,insert_log)  values(578,50000,now(),'jangki;2011-01-30 08:39:37 ');
XA END 'RAMBOpetShop';
XA PREPARE 'RAMBOpetShop';
XA COMMIT 'RAMBOpetShop';

-- Begin on 11/01/30 08:40:58 - cashier
XA START 'RAMBOcashier';
insert into trs_sales_mst (trans_num, trans_type, trans_date, cashier_id, gudang_id, pasien_id, subtotal, profit, disc_mst, disc_val_mst, disc_detail, tax, total, embalase, real_amount, sisa, user_id, shift_id, cash, cara_bayar, card_id, bank,animal_seq,animal_id, dokter_id,dp, no_resep) values (get_new_sales_num('201101'), 13,cast('2011-01-30 'as date),5,1,NULL,50000,50000,0,0,0,0,50000,0,50000,0,'adm',0,100000,0,'','','','',NULL,0,'');
insert into trs_sales_detail (sales_id, item_id, quantity, price, disc, disc_val, amount, amount_profit, price_purchase, paket_id, points, hrg_beli, conversion)values ((select sales_id from trs_sales_mst y where y.trans_num = (select max(x.trans_num) from trs_sales_mst x where x.cashier_id = 5) and y.cashier_id = 5), 578,1,50000,0,0,50000,50000,0,NULL,0,0,1);
update mst_item set current_stock = current_stock + -1 where item_id = 578;
call save_to_item_balance(1, 578, cast('2011-01-30 'as date), 1, 'C');
call save_to_cashier_balance(5, 0, 0, 50000, 0, 0, 0, 'D', 'adm');
XA END 'RAMBOcashier';
XA PREPARE 'RAMBOcashier';
XA COMMIT 'RAMBOcashier';

-- Begin on 11/01/30 08:46:32 - cashier
XA START 'RAMBOcashier';
insert into trs_sales_mst (trans_num, trans_type, trans_date, cashier_id, gudang_id, pasien_id, subtotal, profit, disc_mst, disc_val_mst, disc_detail, tax, total, embalase, real_amount, sisa, user_id, shift_id, cash, cara_bayar, card_id, bank,animal_seq,animal_id, dokter_id,dp, no_resep) values (get_new_sales_num('201101'), 13,cast('2011-01-30 'as date),5,1,NULL,50000,50000,0,0,0,0,50000,0,50000,0,'adm',0,50000,1,'6yu','uuuu','','',NULL,0,'');
insert into trs_sales_detail (sales_id, item_id, quantity, price, disc, disc_val, amount, amount_profit, price_purchase, paket_id, points, hrg_beli, conversion)values ((select sales_id from trs_sales_mst y where y.trans_num = (select max(x.trans_num) from trs_sales_mst x where x.cashier_id = 5) and y.cashier_id = 5), 578,1,50000,0,0,50000,50000,0,NULL,0,0,1);
update mst_item set current_stock = current_stock + -1 where item_id = 578;
call save_to_item_balance(1, 578, cast('2011-01-30 'as date), 1, 'C');
call save_to_cashier_balance(5, 1, 0, 50000, 0, 0, 0, 'D', 'adm');
XA END 'RAMBOcashier';
XA PREPARE 'RAMBOcashier';
XA COMMIT 'RAMBOcashier';

-- Begin on 11/01/30 09:23:03 - cashier
XA START 'RAMBOcashier';
insert into trs_sales_mst (trans_num, trans_type, trans_date, cashier_id, gudang_id, pasien_id, subtotal, profit, disc_mst, disc_val_mst, disc_detail, tax, total, embalase, real_amount, sisa, user_id, shift_id, cash, cara_bayar, card_id, bank,animal_seq,animal_id, dokter_id,dp, no_resep) values (get_new_sales_num('201101'), 13,cast('2011-01-30 'as date),5,1,NULL,225000,45000,0,0,0,0,225000,0,225000,0,'adm',0,250000,0,'','','','',NULL,0,'');
insert into trs_sales_detail (sales_id, item_id, quantity, price, disc, disc_val, amount, amount_profit, price_purchase, paket_id, points, hrg_beli, conversion)values ((select sales_id from trs_sales_mst y where y.trans_num = (select max(x.trans_num) from trs_sales_mst x where x.cashier_id = 5) and y.cashier_id = 5), 5,1,225000,5,0,225000,45000,0,NULL,0,180000,1);
update mst_item set current_stock = current_stock + -1 where item_id = 5;
call save_to_item_balance(1, 5, cast('2011-01-30 'as date), 1, 'C');
call save_to_cashier_balance(5, 0, 0, 225000, 11250, 0, 0, 'D', 'adm');
XA END 'RAMBOcashier';
XA PREPARE 'RAMBOcashier';
XA COMMIT 'RAMBOcashier';
