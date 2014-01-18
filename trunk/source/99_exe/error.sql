
10/09/08 22:27:33 - apotek
>Message: Table 'petshop.mst_item_conversion' doesn't exist
>Dump: select distinct i.item_id, i.item_code, i.barcode, i.item_name, k.purchase_price, k.item_discount, k.item_tax, k.net_price, i.avg_price, k.cost_price, k.sales_price, k.sales_price2, round(i.current_stock), (select mst_code from mst_master where mst_id = k.unit_id limit 1) as sat, k.disc_tipe, dosis, expire_date from mst_item i, mst_item_conversion k, point_maping p where i.item_id = k.item_id and k.conversion =1 and i.specification = p.code_id  and i.disabled_date is null  and p.root_id =1 order by item_name  limit 0, 100

10/09/08 23:00:19 - petShop
>Message: Table 'petshop.mst_item_conversion' doesn't exist
>Dump: select distinct i.item_id, i.item_code, i.barcode, i.item_name, k.purchase_price, k.item_discount, k.item_tax, k.net_price, i.avg_price, k.cost_price, k.sales_price, k.sales_price2, round(i.current_stock), (select mst_code from mst_master where mst_id = k.unit_id limit 1) as sat, k.disc_tipe, dosis, expire_date from mst_item i, mst_item_conversion k, point_maping p where i.item_id = k.item_id and k.conversion =1 and i.specification = p.code_id  and i.disabled_date is null  and p.root_id =1 order by item_name  limit 0, 100

10/09/08 23:14:09 - petShop
>Message: Table 'petshop.mst_item_conversion' doesn't exist
>Dump: select distinct i.item_id, i.item_code, i.barcode, i.item_name, k.purchase_price, k.item_discount, k.item_tax, k.net_price, i.avg_price, k.cost_price, k.sales_price, k.sales_price2, round(i.current_stock), (select mst_code from mst_master where mst_id = k.unit_id limit 1) as sat, k.disc_tipe, dosis, expire_date from mst_item i, mst_item_conversion k, point_maping p where i.item_id = k.item_id and k.conversion =1 and i.specification = p.code_id  and i.disabled_date is null  and p.root_id =1 order by item_name  limit 0, 100

10/09/13 16:21:04 - petShop
>Message: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'OVER (ORDER BY item_name)) AS row, i.item_id, i.item_code, i.bar
>Dump: SELECT distinct item_id, item_code, barcode, item_name, merk, tag_perform, tag_status, (select relation_name from mst_relation where relation_id = vendor_id) as vendor, divisi, dept, kteb FROM (SELECT (ROW_NUMBER() OVER (ORDER BY item_name)) AS row, i.item_id, i.item_code, i.barcode, i.item_name, i.merk, i.tag_perform, i.tag_status, v.vendor_id, (select (code_code+' '+code_name) from mst_code where code_id = (select parent_id   from mst_code where code_id = c.parent_id) ) as divisi, (select (code_code+' '+code_name)  from mst_code where code_id = c.parent_id) as dept,  (select (code_code+' '+code_name) from mst_code where code_id = i.specification) as kteb from mst_item i left outer join mst_item_vendor v on (i.item_id = v.item_id and v.aktif = 1) left outer join mst_code c on i.specification = c.code_id where     i.item_name like '%%%%') AS t_item where ((row >=0) and (row <=100))

10/09/13 16:22:08 - petShop
>Message: Table 'petshop.mst_item_conversion' doesn't exist
>Dump: select distinct i.item_id, i.item_code, i.barcode, i.item_name, k.purchase_price, k.item_discount, k.item_tax, k.net_price, i.avg_price, k.cost_price, k.sales_price, k.sales_price2, round(i.current_stock), (select mst_code from mst_master where mst_id = k.unit_id limit 1) as sat, k.disc_tipe, dosis, expire_date from mst_item i, mst_item_conversion k, point_maping p where i.item_id = k.item_id and k.conversion =1 and i.specification = p.code_id  and i.disabled_date is null  and p.root_id =1 order by item_name  limit 0, 100

10/09/13 16:26:51 - petShop
>Message: Unknown column 'k.unit_id' in 'where clause'
>Dump: select distinct i.item_id, i.item_code, i.barcode, i.item_name, round(i.current_stock), (select mst_code from mst_master where mst_id = k.unit_id limit 1) as sat, k.disc_tipe, dosis, expire_date from mst_item i,  point_maping p where i.specification = p.code_id  and i.disabled_date is null  and p.root_id =1 order by item_name 

10/09/14 09:18:45 - petShop
>Message: Unknown column 'k.unit_id' in 'where clause'
>Dump: select distinct i.item_id, i.item_code, i.barcode, i.item_name, round(i.current_stock), (select mst_code from mst_master where mst_id = k.unit_id limit 1) as sat, k.disc_tipe, dosis, expire_date from mst_item i,  point_maping p where i.specification = p.code_id  and i.disabled_date is null  and p.root_id =1 order by item_name 

10/09/14 09:19:19 - petShop
>Message: Unknown column 'k.disc_tipe' in 'field list'
>Dump: select distinct i.item_id, i.item_code, i.barcode, i.item_name, round(i.current_stock), (select mst_code from mst_master where mst_id = i.unit_id limit 1) as sat, k.disc_tipe, dosis, expire_date from mst_item i,  point_maping p where i.specification = p.code_id  and i.disabled_date is null  and p.root_id =1 order by item_name 

10/09/14 09:20:57 - petShop
>Message: Table 'petshop.mst_item_conversion' doesn't exist
>Dump: select u.mst_name, c.conv_id, c.unit_id, c.item_id, c.conversion, c.cost_price, c.purchase_price, c.sales_price, c.sales_price2, c.sales_price3, c.net_price, c.item_tax, c.item_discount, c.disc_tipe from mst_item_conversion c, mst_master u where c.unit_id = u.mst_id and c.item_id = 328 order by c.conversion

10/09/23 09:35:45 - petShop
>Message: Table 'petshop.mst_item_conversion' doesn't exist
>Dump: select c.conv_id, c.conversion, c.purchase_price, u.mst_code, c.item_tax, c.item_discount, c.disc_tipe, c.sales_price from mst_item_conversion c, mst_master u where c.unit_id = u.mst_id and c.item_id = 256 order by c.conversion limit 1

10/09/27 09:29:24 - petShop
>Message: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near ';2010-09-27 00:00:00 )' at line 1
>Dump: insert into mst_service (service_code, service_name, notes,insert_log) values ('M.001','Mandi sehat','',adm;2010-09-27 00:00:00 )

10/09/27 09:31:40 - petShop
>Message: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'where service_id= 1' at line 1
>Dump: update mst_service set  serice_code= 'D.001', service_name= 'Mandi sehat', notes= '', edit_log= 'adm;2010-09-27 00:00:00 ', where service_id= 1

10/09/27 09:34:53 - petShop
>Message: Unknown column 'serice_code' in 'field list'
>Dump: update mst_service set  serice_code= 'D.001', service_name= 'Dry Grooming f', notes= 'mandi sehat', edit_log= 'adm;2010-09-27 00:00:00 ' where service_id= 1

10/09/27 19:06:24 - petShop
>Message: Unknown column 'anima' in 'field list'
>Dump: select animal_id,animal_code,anima,notes from mst_animal where animal_id = 1

10/09/28 10:08:01 - petShop
>Message: Unknown column 'p.additional_price' in 'field list'
>Dump: select a.animal_code,a.animal,p.service_price_id, p.service_id, p.animal_id,p.price,p.additional_price from mst_animal a left join mst_service_price p  on a.animal_id = p.animal_id  order by animal

10/09/28 20:27:49 - petShop
>Message: Cannot add or update a child row: a foreign key constraint fails (`petshop/mst_service_price`, CONSTRAINT `fk_service_price_animal` FOREIGN KEY (`animal_id`) REFERENCES `mst_animal` (`animal_id`))
>Dump: INSERT INTO mst_service_price(service_id,animal_id,price,add_price,insert_log)  VALUES(2,0,1000,500,'adm;2010-09-28 00:00:00 ')

10/09/28 20:28:05 - petShop
>Message: Cannot add or update a child row: a foreign key constraint fails (`petshop/mst_service_price`, CONSTRAINT `fk_service_price_animal` FOREIGN KEY (`animal_id`) REFERENCES `mst_animal` (`animal_id`))
>Dump: INSERT INTO mst_service_price(service_id,animal_id,price,add_price,insert_log)  VALUES(2,0,1000,500,'adm;2010-09-28 00:00:00 ')

10/10/01 09:50:12 - petShop
>Message: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near ' merk,struk_name,round(i.current_stock), (select mst_code from m
>Dump: select distinct i.item_id, i.item_code, i.barcode, i.item_name, , merk,struk_name,round(i.current_stock), (select mst_code from mst_master where mst_id = i.kemasan_id limit 1) as sat, from mst_item i,  point_maping p where i.specification = p.code_id  and i.disabled_date is null  and p.root_id =1 order by item_name 

10/10/01 09:51:05 - petShop
>Message: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'from mst_item i,  point_maping p where i.specification = p.code_
>Dump: select distinct i.item_id, i.item_code, i.barcode, i.item_name , merk,struk_name,round(i.current_stock), (select mst_code from mst_master where mst_id = i.kemasan_id limit 1) as sat, from mst_item i,  point_maping p where i.specification = p.code_id  and i.disabled_date is null  and p.root_id =1 order by item_name 

10/10/02 13:08:54 - petShop
>Message: Table 'petshop.mst_animall' doesn't exist
>Dump: SELECT animal_id, animal_name FROM mst_animall ORDER BY animal_name 

10/10/02 13:09:30 - petShop
>Message: Unknown column 'animal_name' in 'field list'
>Dump: SELECT animal_id, animal_name FROM mst_animal ORDER BY animal_name 

10/10/02 13:09:50 - petShop
>Message: Unknown column 'animal_name' in 'order clause'
>Dump: SELECT animal_id, animal FROM mst_animal ORDER BY animal_name 

10/10/03 23:01:00 - petShop
>Message: Cannot add or update a child row: a foreign key constraint fails (`petshop/mst_relation_animal`, CONSTRAINT `fk_relation_animal_animal` FOREIGN KEY (`animal_id`) REFERENCES `mst_animal` (`animal_id`)
>Dump: INSERT INTO Mst_Relation_Animal (Relation_ID,Seq,Animal_Name,Animal_ID,Race,Eat,Age,Sex) VALUES (2,2,'',0,'','',0,0)

10/10/03 23:18:10 - petShop
>Message: Cannot add or update a child row: a foreign key constraint fails (`petshop/mst_relation_animal`, CONSTRAINT `fk_relation_animal_animal` FOREIGN KEY (`animal_id`) REFERENCES `mst_animal` (`animal_id`)
>Dump: INSERT INTO Mst_Relation_Animal (Relation_ID,Seq,Animal_Name,Animal_ID,Race,Eat,Age,Sex) VALUES (2,3,'',0,'','',0,0)

10/10/03 23:18:16 - petShop
>Message: Cannot add or update a child row: a foreign key constraint fails (`petshop/mst_relation_animal`, CONSTRAINT `fk_relation_animal_animal` FOREIGN KEY (`animal_id`) REFERENCES `mst_animal` (`animal_id`)
>Dump: INSERT INTO Mst_Relation_Animal (Relation_ID,Seq,Animal_Name,Animal_ID,Race,Eat,Age,Sex) VALUES (2,3,'',0,'','',0,0)

10/10/03 23:21:10 - petShop
>Message: Cannot add or update a child row: a foreign key constraint fails (`petshop/mst_relation_animal`, CONSTRAINT `fk_relation_animal_animal` FOREIGN KEY (`animal_id`) REFERENCES `mst_animal` (`animal_id`)
>Dump: INSERT INTO Mst_Relation_Animal (Relation_ID,Seq,Animal_Name,Animal_ID,Race,Eat,Age,Sex) VALUES (2,3,'',0,'','',0,0)

10/10/04 20:48:33 - petShop
>Message: Unknown column 'buying_price' in 'field list'
>Dump: select distinct i.item_id, i.item_code, i.barcode, i.item_name , merk,struk_name,round(i.current_stock), (select mst_code from mst_master where mst_id = i.kemasan_id limit 1) as sat   ,(select code_name from mst_code where code_id = i.specification) as jenis ,buying_price,selling_price from mst_item i,  point_maping p where i.specification = p.code_id  and i.disabled_date is null  and p.root_id =1 order by item_name 

10/10/05 19:45:49 - petShop
>Message: Column count doesn't match value count at row 1
>Dump: insert into mst_branch (branch_name, nickname, branch_code, address, phone1, phone2,  fax, city,  post_code,insert_log) values ('Jangki Jaksel', 'J001', 'Cinere', '22323`', '03493904', '094304034', 'JakSEL', '232','adm;2010-10-05 00:00:00 ')

10/10/05 19:47:32 - petShop
>Message: Unknown column 'post_code' in 'field list'
>Dump: insert into mst_branch (branch_name, branch_code, address, phone1, phone2,  fax, city,  post_code,insert_log) values ('J-jaksel', 'J001', 'Jl.Cinere', '3434', '344', '343', 'Bandung', 'kdfk','adm;2010-10-05 00:00:00 ')

10/10/05 19:48:06 - petShop
>Message: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'where branch_id = 1' at line 1
>Dump: select branch_id, branch_name, address, phone1, phone2, fax, city, postal_code, branch_codefrom mst_branch where branch_id = 1

10/10/05 19:49:27 - petShop
>Message: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'edit_log='adm;2010-10-05 00:00:00 ' where branch_id = 2' at line
>Dump: update mst_branch set branch_name = 'Jakde', branch_code = 'J0001', address = 'Cinere', phone1 = '0210202', phone2 = '021094343', fax = '02020202', city = 'Jakata Selatan', postal_code = '2323',,edit_log='adm;2010-10-05 00:00:00 ' where branch_id = 2

10/10/09 13:02:13 - petShop
>Message: Data truncated for column 'buying_price' at row 1
>Dump: update mst_item SET specification=5, item_code='0001', barcode='TGHBKHKJH', struk_name='Ekabuba puppy 2 Kg', merk='Ekanuba', avg_price=0, bkp=0, konsinyasi=0, vendor_id =NULL, produsen_id =NULL, kemasan_id =26, kategori =NULL, dosis =0, expire_date =cast('2010-10-09 'as date), buying_price =cast('1899-12-30 'as date), selling_price =cast('1906-11-04 'as date), item_name='Ekabuba puppy' WHERE item_id=1

10/10/09 13:39:08 - petShop
>Message: Data truncated for column 'buying_price' at row 1
>Dump: update mst_item SET specification=5, item_code='0001', barcode='TGHBKHKJH', struk_name='Ekabuba puppy 2 Kg', merk='Ekanuba', avg_price=0, bkp=0, konsinyasi=0, vendor_id =NULL, produsen_id =NULL, kemasan_id =26, kategori =NULL, dosis =0, expire_date =cast('2010-10-09 'as date), buying_price =cast('1906-11-04 'as date), selling_price =cast('1899-12-30 'as date), item_name='Ekabuba puppy' WHERE item_id=1

10/10/09 15:36:32 - petShop
>Message: Table 'petshop.mst_item_conversion' doesn't exist
>Dump: select distinct i.item_id, i.barcode, i.item_name, i.current_stock, i.avg_price, c.conv_id, c.conversion, u.mst_code, purchase_price from mst_item i, mst_item_conversion c, mst_master u where i.disabled_date is null and c.item_id = i.item_id and c.conversion = 1 and c.unit_id = u.mst_id  and i.specification =1 order by i.item_name

10/10/09 15:45:49 - petShop
>Message: Table 'petshop.mst_item_conversion' doesn't exist
>Dump: select distinct i.item_id, i.barcode, i.item_name, i.current_stock, i.avg_price, 0,0, u.mst_code, purchase_price from mst_item i, mst_item_conversion c, mst_master u where i.disabled_date is null and c.item_id = i.item_id and c.conversion = 1 and c.unit_id = u.mst_id  and i.specification =5 order by i.item_name

10/10/09 16:12:21 - petShop
>Message: Table 'petshop.mst_item_conversion' doesn't exist
>Dump: select u.mst_code, c.conv_id, c.unit_id, c.item_id, c.conversion, c.cost_price, c.purchase_price, c.sales_price, c.sales_price2 from mst_item_conversion c, mst_master u where c.unit_id = u.mst_id  and c.conversion = 1 and c.item_id = 1

10/10/09 16:30:10 - petShop
>Message: Unknown column 'purchase_price' in 'field list'
>Dump: select distinct i.item_id, i.barcode, i.item_name, i.current_stock, i.avg_price, 0,0, u.mst_code, purchase_price from mst_item i,  mst_master u where i.disabled_date is null and u.mst_id = i.unit_id   and i.specification =5 order by i.item_name

10/10/09 16:30:23 - petShop
>Message: Unknown column 'conv_id' in 'field list'
>Dump: insert into trs_shipment_detail (ship_id, item_id, conv_id, quantity, price_sales, price_cost, price_purchase, hrg_beli, conversion)values (1,2,0,0,0,0,0,0,0)

10/10/09 16:30:31 - petShop
>Message: Unknown column 'purchase_price' in 'field list'
>Dump: select distinct i.item_id, i.barcode, i.item_name, i.current_stock, i.avg_price, 0,0, u.mst_code, purchase_price from mst_item i,  mst_master u where i.disabled_date is null and u.mst_id = i.unit_id   and i.specification =1 order by i.item_name

10/10/09 16:34:35 - petShop
>Message: FUNCTION petshop.get_stock_akhir does not exist
>Dump: select distinct i.item_id, i.Barcode, i.item_name as Nama,  get_stock_akhir(i.item_id, curdate()) as Stok from mst_item i, point_maping p where i.disabled_date is null and i.specification = p.code_id  and p.root_id =1 order by item_name 

10/10/09 16:50:36 - petShop
>Message: Table 'petshop.mst_item_conversion' doesn't exist
>Dump: select d.ship_detail_id, d.item_id, d.conv_id, (d.quantity / d.conversion) as quantity, round(d.price_sales * d.conversion) as price_sales, round(d.price_purchase * d.conversion) as price_purchase, round(d.price_cost * d.conversion) as price_cost, d.conversion, u.mst_name, i.item_name, i.barcode, i.avg_price from trs_shipment_detail d, mst_item_conversion c, mst_master u, mst_item i where d.conv_id = c.conv_id and c.unit_id = u.mst_id and d.item_id = i.item_id and ship_id = 2

10/10/09 16:51:29 - petShop
>Message: Table 'petshop.mst_item_conversion' doesn't exist
>Dump: select d.ship_detail_id, d.item_id, d.conv_id, (d.quantity / d.conversion) as quantity, round(d.price_sales * d.conversion) as price_sales, round(d.price_purchase * d.conversion) as price_purchase, round(d.price_cost * d.conversion) as price_cost, d.conversion, u.mst_name, i.item_name, i.barcode, i.avg_price from trs_shipment_detail d, mst_item_conversion c, mst_master u, mst_item i where d.conv_id = c.conv_id and c.unit_id = u.mst_id and d.item_id = i.item_id and ship_id = 2

10/10/09 16:51:48 - petShop
>Message: Table 'petshop.mst_item_conversion' doesn't exist
>Dump: select d.ship_detail_id, d.item_id, d.conv_id, (d.quantity / d.conversion) as quantity, round(d.price_sales * d.conversion) as price_sales, round(d.price_purchase * d.conversion) as price_purchase, round(d.price_cost * d.conversion) as price_cost, d.conversion, u.mst_name, i.item_name, i.barcode, i.avg_price from trs_shipment_detail d, mst_item_conversion c, mst_master u, mst_item i where d.conv_id = c.conv_id and c.unit_id = u.mst_id and d.item_id = i.item_id and ship_id = 2

10/10/09 16:51:54 - petShop
>Message: Unknown column 'purchase_price' in 'field list'
>Dump: select distinct i.item_id, i.barcode, i.item_name, i.current_stock, i.avg_price, 0,0, u.mst_code, purchase_price from mst_item i,  mst_master u where i.disabled_date is null and u.mst_id = i.unit_id   and i.specification =1 order by i.item_name

10/10/09 16:51:56 - petShop
>Message: Unknown column 'purchase_price' in 'field list'
>Dump: select distinct i.item_id, i.barcode, i.item_name, i.current_stock, i.avg_price, 0,0, u.mst_code, purchase_price from mst_item i,  mst_master u where i.disabled_date is null and u.mst_id = i.unit_id   and i.specification =5 order by i.item_name

10/10/09 16:52:18 - petShop
>Message: Unknown column 'purchase_price' in 'field list'
>Dump: select distinct i.item_id, i.barcode, i.item_name, i.current_stock, i.avg_price, 0,0, u.mst_code, purchase_price from mst_item i,  mst_master u where i.disabled_date is null and u.mst_id = i.unit_id   and i.specification =5 order by i.item_name

10/10/09 16:52:35 - petShop
>Message: Unknown column 'purchase_price' in 'field list'
>Dump: select distinct i.item_id, i.barcode, i.item_name, i.current_stock, i.avg_price, 0,0, u.mst_code, purchase_price from mst_item i,  mst_master u where i.disabled_date is null and u.mst_id = i.unit_id   and i.specification =1 order by i.item_name

10/10/09 16:55:34 - petShop
>Message: Table 'petshop.mst_item_conversion' doesn't exist
>Dump: select d.ship_detail_id, d.item_id, d.conv_id, (d.quantity / d.conversion) as quantity, round(d.price_sales * d.conversion) as price_sales, round(d.price_purchase * d.conversion) as price_purchase, round(d.price_cost * d.conversion) as price_cost, d.conversion, u.mst_name, i.item_name, i.barcode, i.avg_price from trs_shipment_detail d, mst_item_conversion c, mst_master u, mst_item i where d.conv_id = c.conv_id and c.unit_id = u.mst_id and d.item_id = i.item_id and ship_id = 2

10/10/09 16:55:40 - petShop
>Message: Table 'petshop.mst_item_conversion' doesn't exist
>Dump: select distinct i.item_id, i.item_name as Nama, (select u.mst_code from mst_item_conversion c, mst_master u where c.unit_id = u.mst_id and c.item_id = i.item_id and c.conversion = 1) as satuan, sum(if(t.qty_jual > 0, t.qty_jual, 0)) as jual, sum(if(t.qty_jual < 0, t.qty_jual, 0)) as retur_jual, sum(t.beli), sum(t.retur_beli), sum(t.opname), sum(t.mutasi_dr), sum(t.mutasi_cr) from mst_item i, point_maping p, vie_mutasi_stock t where i.disabled_date is null and i.specification = p.code_id and t.item_id = i.item_id  and p.root_id =1 and t.trans_date >= cast('2010-10-09 'as date) and t.trans_date <=cast('2010-10-31 'as date) group by item_id order by Nama

10/10/09 16:56:22 - petShop
>Message: Table 'petshop.mst_item_conversion' doesn't exist
>Dump: select d.ship_detail_id, d.item_id, d.conv_id, (d.quantity / d.conversion) as quantity, round(d.price_sales * d.conversion) as price_sales, round(d.price_purchase * d.conversion) as price_purchase, round(d.price_cost * d.conversion) as price_cost, d.conversion, u.mst_name, i.item_name, i.barcode, i.avg_price from trs_shipment_detail d, mst_item_conversion c, mst_master u, mst_item i where d.conv_id = c.conv_id and c.unit_id = u.mst_id and d.item_id = i.item_id and ship_id = 3

10/10/09 16:56:41 - petShop
>Message: Table 'petshop.mst_item_conversion' doesn't exist
>Dump: select d.ship_detail_id, d.item_id, d.conv_id, (d.quantity / d.conversion) as quantity, round(d.price_sales * d.conversion) as price_sales, round(d.price_purchase * d.conversion) as price_purchase, round(d.price_cost * d.conversion) as price_cost, d.conversion, u.mst_name, i.item_name, i.barcode, i.avg_price from trs_shipment_detail d, mst_item_conversion c, mst_master u, mst_item i where d.conv_id = c.conv_id and c.unit_id = u.mst_id and d.item_id = i.item_id and ship_id = 3

10/10/09 16:58:53 - petShop
>Message: Table 'petshop.mst_item_conversion' doesn't exist
>Dump: select d.ship_detail_id, d.item_id, d.conv_id, (d.quantity / d.conversion) as quantity, round(d.price_sales * d.conversion) as price_sales, round(d.price_purchase * d.conversion) as price_purchase, round(d.price_cost * d.conversion) as price_cost, d.conversion, u.mst_name, i.item_name, i.barcode, i.avg_price from trs_shipment_detail d, mst_item_conversion c, mst_master u, mst_item i where d.conv_id = c.conv_id and c.unit_id = u.mst_id and d.item_id = i.item_id and ship_id = 2

10/10/09 16:59:15 - petShop
>Message: Unknown column 'purchase_price' in 'field list'
>Dump: select distinct i.item_id, i.barcode, i.item_name, i.current_stock, i.avg_price, 0,0, u.mst_code, purchase_price from mst_item i,  mst_master u where i.disabled_date is null and u.mst_id = i.unit_id   and i.specification =1 order by i.item_name

10/10/09 17:05:23 - petShop
>Message: Table 'petshop.mst_item_conversion' doesn't exist
>Dump: select distinct i.item_id, i.item_name as Nama, (select u.mst_code from mst_item_conversion c, mst_master u where c.unit_id = u.mst_id and c.item_id = i.item_id and c.conversion = 1) as satuan, sum(if(t.qty_jual > 0, t.qty_jual, 0)) as jual, sum(if(t.qty_jual < 0, t.qty_jual, 0)) as retur_jual, sum(t.beli), sum(t.retur_beli), sum(t.opname), sum(t.mutasi_dr), sum(t.mutasi_cr) from mst_item i, point_maping p, vie_mutasi_stock t where i.disabled_date is null and i.specification = p.code_id and t.item_id = i.item_id  and p.root_id =1 and t.trans_date >= cast('2010-10-09 'as date) and t.trans_date <=cast('2010-10-31 'as date) group by item_id order by Nama

10/10/09 17:14:34 - petShop
>Message: Table 'petshop.mst_item_conversion' doesn't exist
>Dump: select distinct i.item_id, i.item_name as Nama, (select u.mst_code from mst_item_conversion c, mst_master u where c.unit_id = u.mst_id and c.item_id = i.item_id and c.conversion = 1) as satuan, sum(if(t.qty_jual > 0, t.qty_jual, 0)) as jual, sum(if(t.qty_jual < 0, t.qty_jual, 0)) as retur_jual, sum(t.beli), sum(t.retur_beli), sum(t.opname), sum(t.mutasi_dr), sum(t.mutasi_cr) from mst_item i, point_maping p, vie_mutasi_stock t where i.disabled_date is null and i.specification = p.code_id and t.item_id = i.item_id  and p.root_id =1 and t.trans_date >= cast('2010-10-09 'as date) and t.trans_date <=cast('2010-10-31 'as date) group by item_id order by Nama

10/10/09 17:15:14 - petShop
>Message: Unknown column 'purchase_price' in 'field list'
>Dump: select distinct i.item_id, i.barcode, i.item_name, i.current_stock, i.avg_price, 0,0, u.mst_code, purchase_price from mst_item i,  mst_master u where i.disabled_date is null and u.mst_id = i.unit_id   and i.specification =1 order by i.item_name

10/10/09 17:15:19 - petShop
>Message: Unknown column 'purchase_price' in 'field list'
>Dump: select distinct i.item_id, i.barcode, i.item_name, i.current_stock, i.avg_price, 0,0, u.mst_code, purchase_price from mst_item i,  mst_master u where i.disabled_date is null and u.mst_id = i.unit_id   and i.specification =5 order by i.item_name

10/10/09 17:15:30 - petShop
>Message: Unknown column 'purchase_price' in 'field list'
>Dump: select distinct i.item_id, i.barcode, i.item_name, i.current_stock, i.avg_price, 0,0, u.mst_code, purchase_price from mst_item i,  mst_master u where i.disabled_date is null and u.mst_id = i.unit_id   and i.specification =1 order by i.item_name

10/10/09 17:15:58 - petShop
>Message: Unknown column 'purchase_price' in 'field list'
>Dump: select distinct i.item_id, i.barcode, i.item_name, i.current_stock, i.avg_price, 0,0, u.mst_code, purchase_price from mst_item i,  mst_master u where i.disabled_date is null and u.mst_id = i.unit_id   and i.specification =1 order by i.item_name

10/10/09 17:17:43 - petShop
>Message: Unknown column 'purchase_price' in 'field list'
>Dump: select distinct i.item_id, i.barcode, i.item_name, i.current_stock, i.avg_price, 0,0, u.mst_code, purchase_price from mst_item i,  mst_master u where i.disabled_date is null and u.mst_id = i.unit_id   and i.specification =1 order by i.item_name

10/10/09 17:19:40 - petShop
>Message: Table 'petshop.mst_item_conversion' doesn't exist
>Dump: select d.ship_detail_id, d.item_id, d.conv_id, (d.quantity / d.conversion) as quantity, round(d.price_sales * d.conversion) as price_sales, round(d.price_purchase * d.conversion) as price_purchase, round(d.price_cost * d.conversion) as price_cost, d.conversion, u.mst_name, i.item_name, i.barcode, i.avg_price from trs_shipment_detail d, mst_item_conversion c, mst_master u, mst_item i where d.conv_id = c.conv_id and c.unit_id = u.mst_id and d.item_id = i.item_id and ship_id = 4

10/10/09 17:20:12 - petShop
>Message: Table 'petshop.mst_item_conversion' doesn't exist
>Dump: select distinct i.item_id, i.item_name as Nama, (select u.mst_code from mst_item_conversion c, mst_master u where c.unit_id = u.mst_id and c.item_id = i.item_id and c.conversion = 1) as satuan, sum(if(t.qty_jual > 0, t.qty_jual, 0)) as jual, sum(if(t.qty_jual < 0, t.qty_jual, 0)) as retur_jual, sum(t.beli), sum(t.retur_beli), sum(t.opname), sum(t.mutasi_dr), sum(t.mutasi_cr) from mst_item i, point_maping p, vie_mutasi_stock t where i.disabled_date is null and i.specification = p.code_id and t.item_id = i.item_id  and p.root_id =1 and t.trans_date >= cast('2010-10-09 'as date) and t.trans_date <=cast('2010-10-31 'as date) group by item_id order by Nama

10/10/09 17:20:51 - petShop
>Message: Unknown column 'm.item_id' in 'on clause'
>Dump: select distinct item_id, item_name as Nama, (select u.mst_code from  mst_master u where i.unit_id = u.mst_id ) as satuan,  sum(beli), sum(retur_beli),sum(mutasi_masuk),sum(mutasi_keluar),sum(jual),sum(retur_jual),sum(opname)  FROM ( SELECT i.item_id, i.item_name, 0 as beli, 0 as retur_beli, 0 as mutasi_masuk, 0 as mutasi_keluar, 0 as jual, 0 as retur_jual, d.quantity as opname  FROM trs_shipment_mst m inner join trs_shipment_detail d on d.ship_id = m.item_id  inner join mst_item i on d.item_id = i.item_id ) as t1  

10/10/09 17:43:23 - petShop
>Message: Table 'petshop.mst_item_conversion' doesn't exist
>Dump: select d.ship_detail_id, d.item_id, d.conv_id, (d.quantity / d.conversion) as quantity, round(d.price_sales * d.conversion) as price_sales, round(d.price_purchase * d.conversion) as price_purchase, round(d.price_cost * d.conversion) as price_cost, d.conversion, u.mst_name, i.item_name, i.barcode, i.avg_price from trs_shipment_detail d, mst_item_conversion c, mst_master u, mst_item i where d.conv_id = c.conv_id and c.unit_id = u.mst_id and d.item_id = i.item_id and ship_id = 5

10/10/09 17:59:25 - petShop
>Message: Table 'petshop.mst_item_conversion' doesn't exist
>Dump: select d.ship_detail_id, d.item_id, d.conv_id, (d.quantity / d.conversion) as quantity, round(d.price_sales * d.conversion) as price_sales, round(d.price_purchase * d.conversion) as price_purchase, round(d.price_cost * d.conversion) as price_cost, d.conversion, u.mst_name, i.item_name, i.barcode, i.avg_price from trs_shipment_detail d, mst_item_conversion c, mst_master u, mst_item i where d.conv_id = c.conv_id and c.unit_id = u.mst_id and d.item_id = i.item_id and ship_id = 5

10/10/09 18:01:44 - petShop
>Message: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near ') as price_cost, d.conversion, u.mst_name, i.item_name, i.barcod
>Dump: select d.ship_detail_id, d.item_id, d.conv_id, d.quantity as quantity, round(d.price_sales ) as price_sales, round(d.price_purchase ) as price_purchase, round(d.price_cost *) as price_cost, d.conversion, u.mst_name, i.item_name, i.barcode, i.avg_price from trs_shipment_detail d,  mst_master u, mst_item i where i.kemasan_id = u.mst_id and d.item_id = i.item_id and ship_id = 5

10/10/17 15:32:28 - cashier
>Message: Unknown column 'c.unit_id' in 'where clause'
>Dump: select i.item_id, i.item_code as 'Kode', i.barcode as 'Barcode', i.item_name as 'Nama Barang', current_stock as 'Stok', (select mst_code from mst_master where mst_id = c.unit_id) as Unit, c.sales_price as 'Hrg Jual', ' ' as Rak, 0 as is_paket from mst_item i where i.disabled_date is null  and item_name like '%a%'

10/10/17 15:32:54 - cashier
>Message: Unknown column 'c.sales_price' in 'field list'
>Dump: select i.item_id, i.item_code as 'Kode', i.barcode as 'Barcode', i.item_name as 'Nama Barang', current_stock as 'Stok', (select mst_code from mst_master where mst_id = i.kemasan_id) as Unit, c.sales_price as 'Hrg Jual', ' ' as Rak, 0 as is_paket from mst_item i where i.disabled_date is null  and item_name like '%%'

10/10/17 15:33:29 - cashier
>Message: Unknown column 'i.sales_price' in 'field list'
>Dump: select i.item_id, i.item_code as 'Kode', i.barcode as 'Barcode', i.item_name as 'Nama Barang', current_stock as 'Stok', (select mst_code from mst_master where mst_id = i.kemasan_id) as Unit, i.sales_price as 'Hrg Jual' from mst_item i where i.disabled_date is null  and item_name like '%%'

10/10/17 15:35:03 - cashier
>Message: Table 'petshop.mst_item_conversion' doesn't exist
>Dump: select c.conv_id, c.conversion, c.sales_price, (select u.mst_code from mst_master u where u.mst_id = c.unit_id) as satuan, c.purchase_price from mst_item_conversion c  where c.conversion = 1 and c.item_id = 3

10/10/17 16:16:57 - cashier
>Message: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'select i.service_id, i.service_code as 'Kode', '' as 'Barcode', 
>Dump: select i.item_id, i.item_code as 'Kode', i.barcode as 'Barcode', i.item_name as 'Nama Barang/Jasa', current_stock as 'Stok', (select mst_code from mst_master where mst_id = i.kemasan_id) as Unit, i.selling_price as 'Hrg Jual' from mst_item i where i.disabled_date is null  and item_name like '%%' select i.service_id, i.service_code as 'Kode', '' as 'Barcode', i.service_name as 'Nama Barang/Jasa', 0 as 'Stok', '' as Unit,  0 as 'Hrg Jual' from mst_service i where  service_name like '%%'

10/10/21 19:02:52 - cashier
>Message: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'service_id = 5' at line 1
>Dump: select service_id as item_id, service_name as item_name, '', service_name as struk_name, 0 as avg_price, 1 as paket  ,price, add_price from mst_service s left join mst_service_price p on s.service_idwhere service_id = 5

10/10/21 19:03:44 - cashier
>Message: Column 'service_id' in field list is ambiguous
>Dump: select service_id as item_id, service_name as item_name, '', service_name as struk_name, 0 as avg_price, 1 as paket  ,price, add_price from mst_service s left join mst_service_price p on s.service_id where service_id = 6

10/10/21 19:04:08 - cashier
>Message: Column 'service_id' in field list is ambiguous
>Dump: select service_id as item_id, service_name as item_name, '', service_name as struk_name, 0 as avg_price, 1 as paket  ,price, add_price from mst_service s left join mst_service_price p on s.service_id where s.service_id = 6

10/10/21 19:57:03 - cashier
>Message: Unknown column 'selling_price' in 'field list'
>Dump: select item_id, item_name, barcode, struk_name, avg_price, 0 as paket from mst_item where ((barcode = 'S005') or (item_code = 'S005')) union all select paket_id as item_id, nama as item_name, barcode, nama_struk as struk_name, harga_dasar as avg_price, 1 as paket ,selling_price from mst_paket where ((barcode = 'S005') or (kode = 'S005'))

10/10/26 08:02:20 - petShop
>Message: Table 'petshop.mst_item_conversion' doesn't exist
>Dump: select c.conv_id, c.conversion, c.purchase_price, u.mst_code, c.item_tax, c.item_discount, c.disc_tipe, c.sales_price from mst_item_conversion c, mst_master u where c.unit_id = u.mst_id and c.item_id = 2 order by c.conversion limit 1

10/10/26 08:05:28 - petShop
>Message: Table 'petshop.mst_item_conversion' doesn't exist
>Dump: select c.conv_id, c.conversion, c.purchase_price, u.mst_code, c.item_tax, c.item_discount, c.disc_tipe, c.sales_price from mst_item_conversion c, mst_master u where c.unit_id = u.mst_id and c.item_id = 7 order by c.conversion limit 1

10/10/26 08:05:55 - petShop
>Message: Table 'petshop.mst_item_conversion' doesn't exist
>Dump: select c.conv_id, c.conversion, c.purchase_price, u.mst_code, c.item_tax, c.item_discount, c.disc_tipe, c.sales_price from mst_item_conversion c, mst_master u where c.unit_id = u.mst_id and c.item_id = 3 order by c.conversion limit 1

10/10/26 08:06:15 - petShop
>Message: Table 'petshop.trs_receipt_mst' doesn't exist
>Dump: select distinct O.receipt_id, O.trans_num as 'No Trx', O.trans_date as 'Tgl Terima', O.expr_date as 'Tgl Expr', (select relation_name from mst_relation r where r.relation_id= O.relation_id) as Supplier, O.Subtotal, (O.disc_mst + O.disc_detail) as Discount, O.tax as Pajak, O.Biaya, O.Materai, O.Total from trs_receipt_mst O where O.status_id = 1 and O.trans_date >= cast('2010-10-01 'as date) and O.trans_date <=cast('2010-10-31 'as date) and O.relation_id = 4 order by O.trans_date, O.trans_num

10/10/26 08:07:52 - petShop
>Message: Table 'petshop.mst_item_conversion' doesn't exist
>Dump: select c.conv_id, c.conversion, c.purchase_price, u.mst_code, c.item_tax, c.item_discount, c.disc_tipe, c.sales_price from mst_item_conversion c, mst_master u where c.unit_id = u.mst_id and c.item_id = 8 order by c.conversion limit 1

10/10/26 12:24:01 - cashier
>Message: Table 'petshop.mst_item_conversion' doesn't exist
>Dump: select d.hold_detail_id, d.item_id, d.conv_id, (d.quantity / d.conversion) as quantity, d.price, d.disc, d.disc_val, d.amount, d.conversion, d.price_purchase, d.amount_profit, u.mst_code, i.struk_name, i.barcode, d.points, 0 as is_paket, d.hrg_beli, d.embalase, d.trx_racik_id from trs_holded_detail d, mst_item_conversion c, mst_master u, mst_item i where d.conv_id = c.conv_id and c.unit_id = u.mst_id and d.item_id = i.item_id and d.item_id is not null and hold_id = 1 union all select d.hold_detail_id, d.paket_id as item_id, 0 as conv_id, (d.quantity / d.conversion) as quantity, d.price, d.disc, d.disc_val, d.amount, d.conversion, d.price_purchase, d.amount_profit, (select mst_code from mst_master where mst_id = i.unit_id) as mst_code, i.nama_struk as struk_name, i.barcode, d.points, 1 as is_paket, d.hrg_beli, d.embalase, d.trx_racik_id from trs_holded_detail d, mst_paket i where d.paket_id = i.paket_id and d.paket_id is not null and hold_id = 1

10/10/26 12:28:33 - cashier
>Message: Table 'petshop.mst_pasien' doesn't exist
>Dump: select nama from mst_pasien where pasien_id = 2

10/10/26 12:29:47 - cashier
>Message: Table 'petshop.mst_dokter' doesn't exist
>Dump: select nama from mst_dokter where dokter_id = 0

10/10/26 16:48:07 - cashier
>Message: Unknown column 'selling_price' in 'field list'
>Dump: select item_id, item_name, barcode, struk_name, avg_price, 0 as paket from mst_item where ((barcode = 'S007') or (item_code = 'S007')) union all select paket_id as item_id, nama as item_name, barcode, nama_struk as struk_name, harga_dasar as avg_price, 1 as paket ,selling_price from mst_paket where ((barcode = 'S007') or (kode = 'S007'))

10/10/26 17:29:34 - cashier
>Message: Unknown column 'i.unit_id' in 'where clause'
>Dump: select d.hold_detail_id, d.item_id, d.conv_id, (d.quantity / d.conversion) as quantity, d.price, d.disc, d.disc_val, d.amount, d.conversion, d.price_purchase, d.amount_profit, u.mst_code, i.struk_name, i.barcode, d.points, 0 as is_paket, d.hrg_beli, d.embalase, d.trx_racik_id from trs_holded_detail d, mst_master u, mst_item i where i.kemasan_id = u.mst_id and d.item_id = i.item_id and d.item_id is not null and hold_id = 2 union all select d.hold_detail_id, d.paket_id as item_id, 0 as conv_id, (d.quantity / d.conversion) as quantity, d.price, d.disc, d.disc_val, d.amount, d.conversion, d.price_purchase, d.amount_profit, (select mst_code from mst_master where mst_id = i.unit_id) as mst_code, i.nama_struk as struk_name, i.barcode, d.points, 1 as is_paket, d.hrg_beli, d.embalase, d.trx_racik_id from trs_holded_detail d, mst_service i where d.paket_id = i.service_id and d.paket_id is not null and hold_id = 2

10/10/26 17:30:06 - cashier
>Message: Unknown column 'i.nama_struk' in 'field list'
>Dump: select d.hold_detail_id, d.item_id, d.conv_id, (d.quantity / d.conversion) as quantity, d.price, d.disc, d.disc_val, d.amount, d.conversion, d.price_purchase, d.amount_profit, u.mst_code, i.struk_name, i.barcode, d.points, 0 as is_paket, d.hrg_beli, d.embalase, d.trx_racik_id from trs_holded_detail d, mst_master u, mst_item i where i.kemasan_id = u.mst_id and d.item_id = i.item_id and d.item_id is not null and hold_id = 2 union all select d.hold_detail_id, d.paket_id as item_id, 0 as conv_id, (d.quantity / d.conversion) as quantity, d.price, d.disc, d.disc_val, d.amount, d.conversion, d.price_purchase, d.amount_profit,  '' as mst_code, i.nama_struk as struk_name, i.barcode, d.points, 1 as is_paket, d.hrg_beli, d.embalase, d.trx_racik_id from trs_holded_detail d, mst_service i where d.paket_id = i.service_id and d.paket_id is not null and hold_id = 2

10/10/26 17:37:27 - cashier
>Message: Unknown column 'selling_price' in 'field list'
>Dump: select item_id, item_name, barcode, struk_name, avg_price, 0 as paket from mst_item where ((barcode = '0005') or (item_code = '0005')) union all select paket_id as item_id, nama as item_name, barcode, nama_struk as struk_name, harga_dasar as avg_price, 1 as paket ,selling_price from mst_paket where ((barcode = '0005') or (kode = '0005'))

10/10/26 17:41:11 - cashier
>Message: The used SELECT statements have a different number of columns
>Dump: select item_id, item_name, barcode, struk_name, avg_price, 0 as paket from mst_item where ((barcode = '0008') or (item_code = '0008')) union all select s.service_id as item_id, service_name as item_name, service_code, service_name as struk_name, 0 as avg_price, 1 as paket  ,price, add_price from mst_service s left join mst_service_price p on s.service_id=p.service_id where s.service_code = '0008' and animal_id = 0

10/10/26 17:41:43 - cashier
>Message: The used SELECT statements have a different number of columns
>Dump: select item_id, item_name, barcode, struk_name, avg_price, 0 as paket,0 as add_price from mst_item where ((barcode = '0008') or (item_code = '0008')) union all select s.service_id as item_id, service_name as item_name, service_code, service_name as struk_name, 0 as avg_price, 1 as paket  ,price, add_price from mst_service s left join mst_service_price p on s.service_id=p.service_id where s.service_code = '0008' and animal_id = 0

10/10/26 21:21:21 - cashier
>Message: Table 'petshop.mst_item_conversion' doesn't exist
>Dump: select sales_price, u.mst_code from mst_item_conversion c, mst_master u where c.unit_id = u.mst_id and c.item_id = 8 order by c.conversion 

10/10/26 22:04:15 - cashier
>Message: FUNCTION petshop.get_new_sales_num does not exist
>Dump: insert into trs_sales_mst (trans_num, trans_type, trans_date, cashier_id, gudang_id, pasien_id, subtotal, profit, disc_mst, disc_val_mst, disc_detail, tax, total, embalase, real_amount, sisa, user_id, shift_id, cash, cara_bayar, card_id, bank, dokter_id, no_resep) values (get_new_sales_num('O201010'), 13,cast('2010-10-26 'as date),5,1,2,58150,8150,0,0,0,0,58150,0,58150,0,'adm',0,60000,0,'','',NULL,'')

10/10/26 22:07:15 - cashier
>Message: Data too long for column 'v_prefix' at row 1
>Dump: insert into trs_sales_mst (trans_num, trans_type, trans_date, cashier_id, gudang_id, pasien_id, subtotal, profit, disc_mst, disc_val_mst, disc_detail, tax, total, embalase, real_amount, sisa, user_id, shift_id, cash, cara_bayar, card_id, bank, dokter_id, no_resep) values (get_new_sales_num('O201010'), 13,cast('2010-10-26 'as date),5,1,2,58150,8150,0,0,0,0,58150,0,58150,0,'adm',0,60000,0,'','',NULL,'')

10/10/26 22:12:26 - cashier
>Message: Data too long for column 'v_prefix' at row 1
>Dump: insert into trs_sales_mst (trans_num, trans_type, trans_date, cashier_id, gudang_id, pasien_id, subtotal, profit, disc_mst, disc_val_mst, disc_detail, tax, total, embalase, real_amount, sisa, user_id, shift_id, cash, cara_bayar, card_id, bank, dokter_id, no_resep) values (get_new_sales_num('201010'), 13,cast('2010-10-26 'as date),5,1,2,58150,8150,0,0,0,0,58150,0,58150,0,'adm',0,60000,0,'','',NULL,'')

10/10/26 22:13:32 - cashier
>Message: FUNCTION petshop.get_new_sales_num does not exist
>Dump: insert into trs_sales_mst (trans_num, trans_type, trans_date, cashier_id, gudang_id, pasien_id, subtotal, profit, disc_mst, disc_val_mst, disc_detail, tax, total, embalase, real_amount, sisa, user_id, shift_id, cash, cara_bayar, card_id, bank, dokter_id, no_resep) values (get_new_sales_num('201010'), 13,cast('2010-10-26 'as date),5,1,2,58150,8150,0,0,0,0,58150,0,58150,0,'adm',0,60000,0,'','',NULL,'')

10/10/26 22:15:40 - cashier
>Message: Cannot add or update a child row: a foreign key constraint fails (`petshop/trs_sales_mst`, CONSTRAINT `FK_trs_sales_mst3` FOREIGN KEY (`shift_id`) REFERENCES `mst_master` (`mst_id`) ON DELETE NO ACTI
>Dump: insert into trs_sales_mst (trans_num, trans_type, trans_date, cashier_id, gudang_id, pasien_id, subtotal, profit, disc_mst, disc_val_mst, disc_detail, tax, total, embalase, real_amount, sisa, user_id, shift_id, cash, cara_bayar, card_id, bank, dokter_id, no_resep) values (get_new_sales_num('201010'), 13,cast('2010-10-26 'as date),5,1,2,58150,8150,0,0,0,0,58150,0,58150,0,'adm',0,60000,0,'','',NULL,'')

10/10/26 22:20:37 - cashier
>Message: Unknown column 'conv_id' in 'field list'
>Dump: insert into trs_sales_detail (sales_id, item_id, conv_id, quantity, price, disc, disc_val, amount, amount_profit, price_purchase, paket_id, points, hrg_beli, conversion)values (1,8,NULL,1,3500,0,0,3500,3500,0,NULL,0,0,1)

10/10/26 22:22:38 - cashier
>Message: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near '0 as conv_id,quantity, price, disc, disc_val, amount, amount_pro
>Dump: insert into trs_sales_detail (sales_id, item_id, 0 as conv_id,quantity, price, disc, disc_val, amount, amount_profit, price_purchase, paket_id, points, hrg_beli, conversion)values (2,8,1,3500,0,0,3500,3500,0,NULL,0,0,1)

10/10/26 22:24:33 - cashier
>Message: Table 'petshop.mst_pasien' doesn't exist
>Dump: update mst_pasien set card_id= '' where pasien_id= 2

10/10/26 23:12:41 - petShop
>Message: Table 'petshop.mst_item_conversion' doesn't exist
>Dump: select t.trans_num, i.barcode, i.item_name, d.price, (d.quantity / d.conversion) as quantity, u.mst_code, d.disc, d.disc_val, d.amount, t.trans_date, t.subtotal, t.disc_mst, t.disc_val_mst, t.embalase, t.total, d.sales_detail_id, t.cash, t.user_id from trs_sales_detail d, trs_sales_mst t, mst_item_conversion c, mst_master u, mst_item i where d.sales_id = t.sales_id and d.conv_id = c.conv_id and d.item_id is not null and c.unit_id = u.mst_id and d.item_id = i.item_id  and t.trans_date >= cast('2010-10-26 'as date) and t.trans_date <=cast('2010-10-26 'as date) UNION all select t.trans_num, i.barcode, i.nama as item_name, d.price, (d.quantity / d.conversion) as quantity, u.mst_code, d.disc, d.disc_val, d.amount, t.trans_date, t.subtotal, t.disc_mst, t.disc_val_mst, t.embalase, t.total, d.sales_detail_id, t.cash, t.user_id from trs_sales_detail d, trs_sales_mst t, mst_master u, mst_paket i where d.sales_id = t.sales_id and i.unit_id = u.mst_id and d.paket_id is not null and d.paket_id = i.paket_id  and t.trans_date >= cast('2010-10-26 'as date) and t.trans_date <=cast('2010-10-26 'as date) order by trans_date, trans_num, sales_detail_id

10/10/27 11:26:49 - petShop
>Message: Table 'petshop.trs_receipt_mst' doesn't exist
>Dump: select distinct t.receipt_id, t.trans_num as 'No Trx', t.trans_date as 'Tgl Terima', t.expr_date as 'Jth Tempo', (select relation_name from mst_relation r where r.relation_id= t.relation_id) as Supplier, t.Subtotal, (t.disc_mst + t.disc_detail) as Discount, t.tax as Pajak, t.Materai, t. Biaya, t.Total from trs_receipt_mst t  where  t.trans_date >= cast('2010-10-01 'as date) and t.trans_date <=cast('2010-10-31 'as date)

10/10/27 11:26:56 - petShop
>Message: Table 'petshop.trs_receipt_mst' doesn't exist
>Dump: select distinct t.receipt_id, t.trans_num as 'No Trx', t.trans_date as 'Tgl Terima', t.expr_date as 'Jth Tempo', (select relation_name from mst_relation r where r.relation_id= t.relation_id) as Supplier, t.Subtotal, (t.disc_mst + t.disc_detail) as Discount, t.tax as Pajak, t.Materai, t. Biaya, t.Total from trs_receipt_mst t  where  t.trans_date >= cast('2010-10-01 'as date) and t.trans_date <=cast('2010-10-31 'as date)

10/10/27 11:31:58 - petShop
>Message: Table 'petshop.mst_item_conversion' doesn't exist
>Dump: select c.conv_id, c.conversion, c.purchase_price, u.mst_code, c.item_tax, c.item_discount, c.disc_tipe, c.sales_price from mst_item_conversion c, mst_master u where c.unit_id = u.mst_id and c.item_id = 1 order by c.conversion limit 1

10/10/27 11:37:30 - petShop
>Message: Table 'petshop.mst_item_conversion' doesn't exist
>Dump: select c.conversion, u.mst_code from mst_item_conversion c, mst_master u where c.unit_id = u.mst_id and c.item_id = 7 order by c.conversion desc 

10/10/27 11:37:51 - petShop
>Message: Table 'petshop.mst_item_conversion' doesn't exist
>Dump: select c.conv_id, c.conversion, c.purchase_price, c.item_tax, c.item_discount, c.disc_tipe from mst_item_conversion c where c.conv_id = 0

10/10/27 11:40:24 - petShop
>Message: Table 'petshop.mst_item_conversion' doesn't exist
>Dump: select c.conv_id, c.conversion, c.purchase_price, c.item_tax, c.item_discount, c.disc_tipe from mst_item_conversion c where c.conv_id = 0

10/10/27 12:05:45 - petShop
>Message: Unknown column 'conv_id' in 'field list'
>Dump: insert into trs_order_detail (order_id, item_id, conv_id, quantity, price, disc, amount, conversion, disc_is_prc, tax)values (1,6,0,20,2500,2500,50000,1,0,0)

10/10/27 12:08:59 - petShop
>Message: Table 'petshop.mst_item_conversion' doesn't exist
>Dump: select c.conversion, u.mst_code from mst_item_conversion c, mst_master u where c.unit_id = u.mst_id and c.item_id = 1 order by c.conversion desc 

10/10/27 12:09:09 - petShop
>Message: Table 'petshop.mst_item_conversion' doesn't exist
>Dump: select c.conversion, u.mst_code from mst_item_conversion c, mst_master u where c.unit_id = u.mst_id and c.item_id = 1 order by c.conversion desc 

10/10/27 13:17:37 - petShop
>Message: Table 'petshop.mst_item_conversion' doesn't exist
>Dump: select d.order_detail_id, d.item_id, d.conv_id, (d.quantity / d.conversion) as quantity, d.price, d.amount, d.disc, d.conversion, i.item_name, i.barcode, (select u.mst_code from mst_item_conversion c, mst_master u where d.conv_id = c.conv_id and c.unit_id = u.mst_id) as satuan, d.tax, d.disc_is_prc from trs_order_detail d, mst_item i where d.item_id = i.item_id and order_id = 2

10/10/27 13:22:07 - petShop
>Message: Table 'petshop.mst_item_conversion' doesn't exist
>Dump: select d.receipt_detail_id, d.item_id, d.conv_id, d.conv_bonus_id, (d.quantity/d.conversion) as quantity, (d.qty_bonus/d.conv_bonus) as qty_bonus, d.price, d.amount, d.disc1, d.disc2, d.disc3, d.conversion, d.conv_bonus, i.item_name, i.barcode, (select u.mst_code from mst_item_conversion c, mst_master u where d.conv_id = c.conv_id and c.unit_id = u.mst_id) as satuan, (select u.mst_code from mst_item_conversion c, mst_master u where d.conv_bonus_id = c.conv_id and c.unit_id = u.mst_id) as sat_bonus, d.tax, d.disc1_is_prc, d.disc2_is_prc, d.disc3_is_prc from trs_receipt_detail d, mst_item i where d.item_id = i.item_id and receipt_id = 1

10/10/27 13:28:21 - petShop
>Message: Table 'petshop.mst_item_conversion' doesn't exist
>Dump: select d.receipt_detail_id, d.item_id, d.conv_id, d.conv_bonus_id, (d.quantity/d.conversion) as quantity, (d.qty_bonus/d.conv_bonus) as qty_bonus, d.price, d.amount, d.disc1, d.disc2, d.disc3, d.conversion, d.conv_bonus, i.item_name, i.barcode, (select u.mst_code from mst_item_conversion c, mst_master u where d.conv_id = c.conv_id and c.unit_id = u.mst_id) as satuan, (select u.mst_code from mst_item_conversion c, mst_master u where d.conv_bonus_id = c.conv_id and c.unit_id = u.mst_id) as sat_bonus, d.tax, d.disc1_is_prc, d.disc2_is_prc, d.disc3_is_prc from trs_receipt_detail d, mst_item i where d.item_id = i.item_id and receipt_id = 1

10/10/27 13:28:28 - petShop
>Message: Table 'petshop.mst_item_conversion' doesn't exist
>Dump: select d.receipt_detail_id, d.item_id, d.conv_id, d.conv_bonus_id, (d.quantity/d.conversion) as quantity, (d.qty_bonus/d.conv_bonus) as qty_bonus, d.price, d.amount, d.disc1, d.disc2, d.disc3, d.conversion, d.conv_bonus, i.item_name, i.barcode, (select u.mst_code from mst_item_conversion c, mst_master u where d.conv_id = c.conv_id and c.unit_id = u.mst_id) as satuan, (select u.mst_code from mst_item_conversion c, mst_master u where d.conv_bonus_id = c.conv_id and c.unit_id = u.mst_id) as sat_bonus, d.tax, d.disc1_is_prc, d.disc2_is_prc, d.disc3_is_prc from trs_receipt_detail d, mst_item i where d.item_id = i.item_id and receipt_id = 1

10/10/27 13:40:29 - petShop
>Message: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'SELECT i.item_id, i.item_name, 0 as beli, 0 as retur_beli, 0 as 
>Dump: select distinct item_id, item_name as Nama, (select u.mst_code from  mst_master u where kemasan_id = u.mst_id ) as satuan,  sum(beli), sum(retur_beli),sum(mutasi_masuk),sum(mutasi_keluar),sum(jual),sum(retur_jual),sum(opname)  FROM ( SELECT i.item_id, i.item_name, d.quantity as beli, 0 as retur_beli, 0 as mutasi_masuk, 0 as mutasi_keluar, 0 as jual, 0 as retur_jual, 0 as opname,kemasan_id  FROM trs_receipt_mst m inner join trs_receipt_detail d on d.receipt_id = m.receipt_id  inner join mst_item i on d.item_id = i.item_id  SELECT i.item_id, i.item_name, 0 as beli, 0 as retur_beli, 0 as mutasi_masuk, 0 as mutasi_keluar, 0 as jual, 0 as retur_jual, d.quantity as opname,kemasan_id  FROM trs_shipment_mst m inner join trs_shipment_detail d on d.ship_id = m.ship_id  inner join mst_item i on d.item_id = i.item_id ) as t1   group by item_id,item_name, satuan

10/10/27 13:46:03 - petShop
>Message: Table 'petshop.mst_item_conversion' doesn't exist
>Dump: select distinct d.receipt_id, d.item_id, d.conv_id, (d.quantity / d.conversion) as quantity, d.price, d.amount, d.conversion, i.item_name, i.barcode, (select u.mst_code from mst_item_conversion c, mst_master u where d.conv_id = c.conv_id and c.unit_id = u.mst_id) as satuan, (select r.trans_num from trs_receipt_mst r where r.receipt_id = d.receipt_id) as faktur, (disc1 + disc2 + disc3) as disc, d.tax from trs_receipt_detail d, mst_item i where d.item_id = i.item_id and receipt_id = 1

10/10/27 13:58:42 - petShop
>Message: Unknown column 'p.root_id' in 'where clause'
>Dump: select distinct item_id, item_name as Nama, (select u.mst_code from  mst_master u where kemasan_id = u.mst_id ) as satuan,  sum(beli), sum(retur_beli),sum(mutasi_masuk),sum(mutasi_keluar),sum(jual),sum(retur_jual),sum(opname)  FROM ( SELECT i.item_id, i.item_name, d.quantity as beli, 0 as retur_beli, 0 as mutasi_masuk, 0 as mutasi_keluar, 0 as jual, 0 as retur_jual, 0 as opname,kemasan_id  FROM trs_receipt_mst m inner join trs_receipt_detail d on d.receipt_id = m.receipt_id  inner join mst_item i on d.item_id = i.item_id  WHERE  p.root_id =1 and t.trans_date >= cast('2010-10-27 'as date) and t.trans_date <=cast('2010-10-31 'as date) UNION ALL  SELECT i.item_id, i.item_name, 0 as beli, d.quantity as retur_beli, 0 as mutasi_masuk, 0 as mutasi_keluar, 0 as jual, 0 as retur_jual, 0 as opname,kemasan_id  FROM trs_retur_mst m inner join trs_retur_detail d on d.retur_id = m.retur_id  inner join mst_item i on d.item_id = i.item_id  WHERE  p.root_id =1 and t.trans_date >= cast('2010-10-27 'as date) and t.trans_date <=cast('2010-10-31 'as date) UNION ALL  SELECT i.item_id, i.item_name, 0 as beli, 0 as retur_beli, 0 as mutasi_masuk, 0 as mutasi_keluar, d.quantity as jual, 0 as retur_jual, 0 as opname,kemasan_id  FROM trs_sales_mst m inner join trs_sales_detail d on d.sales_id = m.sales_id  inner join mst_item i on d.item_id = i.item_id  WHERE  p.root_id =1 and t.trans_date >= cast('2010-10-27 'as date) and t.trans_date <=cast('2010-10-31 'as date) UNION ALL  SELECT i.item_id, i.item_name, 0 as beli, 0 as retur_beli, 0 as mutasi_masuk, 0 as mutasi_keluar, 0 as jual, 0 as retur_jual, d.quantity as opname,kemasan_id  FROM trs_shipment_mst m inner join trs_shipment_detail d on d.ship_id = m.ship_id  inner join mst_item i on d.item_id = i.item_id  WHERE  p.root_id =1 and t.trans_date >= cast('2010-10-27 'as date) and t.trans_date <=cast('2010-10-31 'as date)) as t1   group by item_id,item_name, satuan

10/10/27 14:04:51 - petShop
>Message: Unknown column 't.trans_date' in 'where clause'
>Dump: select distinct item_id, item_name as Nama, (select u.mst_code from  mst_master u where kemasan_id = u.mst_id ) as satuan,  sum(beli), sum(retur_beli),sum(mutasi_masuk),sum(mutasi_keluar),sum(jual),sum(retur_jual),sum(opname)  FROM ( SELECT i.item_id, i.item_name, d.quantity as beli, 0 as retur_beli, 0 as mutasi_masuk, 0 as mutasi_keluar, 0 as jual, 0 as retur_jual, 0 as opname,kemasan_id  FROM trs_receipt_mst m inner join trs_receipt_detail d on d.receipt_id = m.receipt_id  inner join mst_item i on d.item_id = i.item_id  left join point_maping p on i.specification = p.code_id  WHERE  p.root_id =1 and t.trans_date >= cast('2010-10-27 'as date) and t.trans_date <=cast('2010-10-31 'as date) UNION ALL  SELECT i.item_id, i.item_name, 0 as beli, d.quantity as retur_beli, 0 as mutasi_masuk, 0 as mutasi_keluar, 0 as jual, 0 as retur_jual, 0 as opname,kemasan_id  FROM trs_retur_mst m inner join trs_retur_detail d on d.retur_id = m.retur_id  inner join mst_item i on d.item_id = i.item_id  left join point_maping p on i.specification = p.code_id  WHERE  p.root_id =1 and t.trans_date >= cast('2010-10-27 'as date) and t.trans_date <=cast('2010-10-31 'as date) UNION ALL  SELECT i.item_id, i.item_name, 0 as beli, 0 as retur_beli, 0 as mutasi_masuk, 0 as mutasi_keluar, d.quantity as jual, 0 as retur_jual, 0 as opname,kemasan_id  FROM trs_sales_mst m inner join trs_sales_detail d on d.sales_id = m.sales_id  inner join mst_item i on d.item_id = i.item_id  left join point_maping p on i.specification = p.code_id  WHERE  p.root_id =1 and t.trans_date >= cast('2010-10-27 'as date) and t.trans_date <=cast('2010-10-31 'as date) UNION ALL  SELECT i.item_id, i.item_name, 0 as beli, 0 as retur_beli, 0 as mutasi_masuk, 0 as mutasi_keluar, 0 as jual, 0 as retur_jual, d.quantity as opname,kemasan_id  FROM trs_shipment_mst m inner join trs_shipment_detail d on d.ship_id = m.ship_id  inner join mst_item i on d.item_id = i.item_id  left join point_maping p on i.specification = p.code_id  WHERE  p.root_id =1 and t.trans_date >= cast('2010-10-27 'as date) and t.trans_date <=cast('2010-10-31 'as date)) as t1   group by item_id,item_name, satuan

10/10/27 14:26:19 - petShop
>Message: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'd.quantity as beli, 0 as retur_beli, 0 as mutasi_masuk, 0 as mut
>Dump: select distinct item_id, item_name as Nama, (select u.mst_code from  mst_master u where kemasan_id = u.mst_id ) as satuan,  sum(awal),sum(beli), sum(retur_beli),sum(mutasi_masuk),sum(mutasi_keluar),sum(jual),sum(retur_jual),sum(opname)  FROM (SELECT i.item_id, i.item_name,coalesce(balance,0) as awal,,d.quantity as beli, 0 as retur_beli, 0 as mutasi_masuk, 0 as mutasi_keluar, 0 as jual, 0 as retur_jual, 0 as opname,kemasan_id from inv_item_balance b, mst_item i where balance_date = (select max(balance_date) from inv_item_balance where item_id = b.item_id and balance_date < cast('2010-10-27 'as date) ) and b.item_id = i.item_id   SELECT i.item_id, i.item_name, 0 as awal,d.quantity as beli, 0 as retur_beli, 0 as mutasi_masuk, 0 as mutasi_keluar, 0 as jual, 0 as retur_jual, 0 as opname,kemasan_id  FROM trs_receipt_mst m inner join trs_receipt_detail d on d.receipt_id = m.receipt_id  inner join mst_item i on d.item_id = i.item_id  left join point_maping p on i.specification = p.code_id  WHERE m.trans_date >= cast('2010-10-27 'as date) m.trans_date <= cast('1899-12-30 'as date) and p.root_id =1 UNION ALL  SELECT i.item_id, i.item_name, 0 as awal,0 as beli, d.quantity as retur_beli, 0 as mutasi_masuk, 0 as mutasi_keluar, 0 as jual, 0 as retur_jual, 0 as opname,kemasan_id  FROM trs_retur_mst m inner join trs_retur_detail d on d.retur_id = m.retur_id  inner join mst_item i on d.item_id = i.item_id  left join point_maping p on i.specification = p.code_id  WHERE m.trans_date >= cast('2010-10-27 'as date) m.trans_date <= cast('1899-12-30 'as date) and p.root_id =1 UNION ALL  SELECT i.item_id, i.item_name, 0 as awal,0 as beli, 0 as retur_beli, 0 as mutasi_masuk, 0 as mutasi_keluar, d.quantity as jual, 0 as retur_jual, 0 as opname,kemasan_id  FROM trs_sales_mst m inner join trs_sales_detail d on d.sales_id = m.sales_id  inner join mst_item i on d.item_id = i.item_id  left join point_maping p on i.specification = p.code_id  WHERE m.trans_date >= cast('2010-10-27 'as date) m.trans_date <= cast('1899-12-30 'as date) and p.root_id =1 UNION ALL  SELECT i.item_id, i.item_name, 0 as awal,0 as beli, 0 as retur_beli, 0 as mutasi_masuk, 0 as mutasi_keluar, 0 as jual, 0 as retur_jual, d.quantity as opname,kemasan_id  FROM trs_shipment_mst m inner join trs_shipment_detail d on d.ship_id = m.ship_id  inner join mst_item i on d.item_id = i.item_id  left join point_maping p on i.specification = p.code_id  WHERE m.trans_date >= cast('2010-10-27 'as date) m.trans_date <= cast('1899-12-30 'as date) and p.root_id =1) as t1   group by item_id,item_name, satuan

10/10/27 14:26:51 - petShop
>Message: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'd.quantity as beli, 0 as retur_beli, 0 as mutasi_masuk, 0 as mut
>Dump: select distinct item_id, item_name as Nama, (select u.mst_code from  mst_master u where kemasan_id = u.mst_id ) as satuan,  sum(awal),sum(beli), sum(retur_beli),sum(mutasi_masuk),sum(mutasi_keluar),sum(jual),sum(retur_jual),sum(opname)  FROM (SELECT i.item_id, i.item_name,ifnull(balance,0) as awal,,d.quantity as beli, 0 as retur_beli, 0 as mutasi_masuk, 0 as mutasi_keluar, 0 as jual, 0 as retur_jual, 0 as opname,kemasan_id from inv_item_balance b, mst_item i where balance_date = (select max(balance_date) from inv_item_balance where item_id = b.item_id and balance_date < cast('2010-10-27 'as date) ) and b.item_id = i.item_id   SELECT i.item_id, i.item_name, 0 as awal,d.quantity as beli, 0 as retur_beli, 0 as mutasi_masuk, 0 as mutasi_keluar, 0 as jual, 0 as retur_jual, 0 as opname,kemasan_id  FROM trs_receipt_mst m inner join trs_receipt_detail d on d.receipt_id = m.receipt_id  inner join mst_item i on d.item_id = i.item_id  left join point_maping p on i.specification = p.code_id  WHERE m.trans_date >= cast('2010-10-27 'as date) m.trans_date <= cast('1899-12-30 'as date) and p.root_id =1 UNION ALL  SELECT i.item_id, i.item_name, 0 as awal,0 as beli, d.quantity as retur_beli, 0 as mutasi_masuk, 0 as mutasi_keluar, 0 as jual, 0 as retur_jual, 0 as opname,kemasan_id  FROM trs_retur_mst m inner join trs_retur_detail d on d.retur_id = m.retur_id  inner join mst_item i on d.item_id = i.item_id  left join point_maping p on i.specification = p.code_id  WHERE m.trans_date >= cast('2010-10-27 'as date) m.trans_date <= cast('1899-12-30 'as date) and p.root_id =1 UNION ALL  SELECT i.item_id, i.item_name, 0 as awal,0 as beli, 0 as retur_beli, 0 as mutasi_masuk, 0 as mutasi_keluar, d.quantity as jual, 0 as retur_jual, 0 as opname,kemasan_id  FROM trs_sales_mst m inner join trs_sales_detail d on d.sales_id = m.sales_id  inner join mst_item i on d.item_id = i.item_id  left join point_maping p on i.specification = p.code_id  WHERE m.trans_date >= cast('2010-10-27 'as date) m.trans_date <= cast('1899-12-30 'as date) and p.root_id =1 UNION ALL  SELECT i.item_id, i.item_name, 0 as awal,0 as beli, 0 as retur_beli, 0 as mutasi_masuk, 0 as mutasi_keluar, 0 as jual, 0 as retur_jual, d.quantity as opname,kemasan_id  FROM trs_shipment_mst m inner join trs_shipment_detail d on d.ship_id = m.ship_id  inner join mst_item i on d.item_id = i.item_id  left join point_maping p on i.specification = p.code_id  WHERE m.trans_date >= cast('2010-10-27 'as date) m.trans_date <= cast('1899-12-30 'as date) and p.root_id =1) as t1   group by item_id,item_name, satuan

10/10/27 14:27:13 - petShop
>Message: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'SELECT i.item_id, i.item_name, 0 as awal,d.quantity as beli, 0 a
>Dump: select distinct item_id, item_name as Nama, (select u.mst_code from  mst_master u where kemasan_id = u.mst_id ) as satuan,  sum(awal),sum(beli), sum(retur_beli),sum(mutasi_masuk),sum(mutasi_keluar),sum(jual),sum(retur_jual),sum(opname)  FROM (SELECT i.item_id, i.item_name,ifnull(balance,0) as awal,0 as beli, 0 as retur_beli, 0 as mutasi_masuk, 0 as mutasi_keluar, 0 as jual, 0 as retur_jual, 0 as opname,kemasan_id from inv_item_balance b, mst_item i where balance_date = (select max(balance_date) from inv_item_balance where item_id = b.item_id and balance_date < cast('2010-10-27 'as date) ) and b.item_id = i.item_id   SELECT i.item_id, i.item_name, 0 as awal,d.quantity as beli, 0 as retur_beli, 0 as mutasi_masuk, 0 as mutasi_keluar, 0 as jual, 0 as retur_jual, 0 as opname,kemasan_id  FROM trs_receipt_mst m inner join trs_receipt_detail d on d.receipt_id = m.receipt_id  inner join mst_item i on d.item_id = i.item_id  left join point_maping p on i.specification = p.code_id  WHERE m.trans_date >= cast('2010-10-27 'as date) m.trans_date <= cast('1899-12-30 'as date) and p.root_id =1 UNION ALL  SELECT i.item_id, i.item_name, 0 as awal,0 as beli, d.quantity as retur_beli, 0 as mutasi_masuk, 0 as mutasi_keluar, 0 as jual, 0 as retur_jual, 0 as opname,kemasan_id  FROM trs_retur_mst m inner join trs_retur_detail d on d.retur_id = m.retur_id  inner join mst_item i on d.item_id = i.item_id  left join point_maping p on i.specification = p.code_id  WHERE m.trans_date >= cast('2010-10-27 'as date) m.trans_date <= cast('1899-12-30 'as date) and p.root_id =1 UNION ALL  SELECT i.item_id, i.item_name, 0 as awal,0 as beli, 0 as retur_beli, 0 as mutasi_masuk, 0 as mutasi_keluar, d.quantity as jual, 0 as retur_jual, 0 as opname,kemasan_id  FROM trs_sales_mst m inner join trs_sales_detail d on d.sales_id = m.sales_id  inner join mst_item i on d.item_id = i.item_id  left join point_maping p on i.specification = p.code_id  WHERE m.trans_date >= cast('2010-10-27 'as date) m.trans_date <= cast('1899-12-30 'as date) and p.root_id =1 UNION ALL  SELECT i.item_id, i.item_name, 0 as awal,0 as beli, 0 as retur_beli, 0 as mutasi_masuk, 0 as mutasi_keluar, 0 as jual, 0 as retur_jual, d.quantity as opname,kemasan_id  FROM trs_shipment_mst m inner join trs_shipment_detail d on d.ship_id = m.ship_id  inner join mst_item i on d.item_id = i.item_id  left join point_maping p on i.specification = p.code_id  WHERE m.trans_date >= cast('2010-10-27 'as date) m.trans_date <= cast('1899-12-30 'as date) and p.root_id =1) as t1   group by item_id,item_name, satuan

10/10/27 14:28:29 - petShop
>Message: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'm.trans_date <= cast('1899-12-30 'as date) and p.root_id =1 UNIO
>Dump: select distinct item_id, item_name as Nama, (select u.mst_code from  mst_master u where kemasan_id = u.mst_id ) as satuan,  sum(awal),sum(beli), sum(retur_beli),sum(mutasi_masuk),sum(mutasi_keluar),sum(jual),sum(retur_jual),sum(opname)  FROM (SELECT i.item_id, i.item_name,ifnull(balance,0) as awal,0 as beli, 0 as retur_beli, 0 as mutasi_masuk, 0 as mutasi_keluar, 0 as jual, 0 as retur_jual, 0 as opname,kemasan_id from inv_item_balance b, mst_item i where balance_date = (select max(balance_date) from inv_item_balance where item_id = b.item_id and balance_date < cast('2010-10-27 'as date) ) and b.item_id = i.item_id   UNION ALL  SELECT i.item_id, i.item_name, 0 as awal,d.quantity as beli, 0 as retur_beli, 0 as mutasi_masuk, 0 as mutasi_keluar, 0 as jual, 0 as retur_jual, 0 as opname,kemasan_id  FROM trs_receipt_mst m inner join trs_receipt_detail d on d.receipt_id = m.receipt_id  inner join mst_item i on d.item_id = i.item_id  left join point_maping p on i.specification = p.code_id  WHERE m.trans_date >= cast('2010-10-27 'as date) m.trans_date <= cast('1899-12-30 'as date) and p.root_id =1 UNION ALL  SELECT i.item_id, i.item_name, 0 as awal,0 as beli, d.quantity as retur_beli, 0 as mutasi_masuk, 0 as mutasi_keluar, 0 as jual, 0 as retur_jual, 0 as opname,kemasan_id  FROM trs_retur_mst m inner join trs_retur_detail d on d.retur_id = m.retur_id  inner join mst_item i on d.item_id = i.item_id  left join point_maping p on i.specification = p.code_id  WHERE m.trans_date >= cast('2010-10-27 'as date) m.trans_date <= cast('1899-12-30 'as date) and p.root_id =1 UNION ALL  SELECT i.item_id, i.item_name, 0 as awal,0 as beli, 0 as retur_beli, 0 as mutasi_masuk, 0 as mutasi_keluar, d.quantity as jual, 0 as retur_jual, 0 as opname,kemasan_id  FROM trs_sales_mst m inner join trs_sales_detail d on d.sales_id = m.sales_id  inner join mst_item i on d.item_id = i.item_id  left join point_maping p on i.specification = p.code_id  WHERE m.trans_date >= cast('2010-10-27 'as date) m.trans_date <= cast('1899-12-30 'as date) and p.root_id =1 UNION ALL  SELECT i.item_id, i.item_name, 0 as awal,0 as beli, 0 as retur_beli, 0 as mutasi_masuk, 0 as mutasi_keluar, 0 as jual, 0 as retur_jual, d.quantity as opname,kemasan_id  FROM trs_shipment_mst m inner join trs_shipment_detail d on d.ship_id = m.ship_id  inner join mst_item i on d.item_id = i.item_id  left join point_maping p on i.specification = p.code_id  WHERE m.trans_date >= cast('2010-10-27 'as date) m.trans_date <= cast('1899-12-30 'as date) and p.root_id =1) as t1   group by item_id,item_name, satuan

10/10/27 17:07:06 - cashier
>Message: Unknown column 'd.conv_id' in 'field list'
>Dump: select d.sales_detail_id, d.item_id, d.conv_id, (d.quantity / d.conversion) as quantity, d.price, d.disc, d.disc_val, d.amount, d.conversion, d.price_purchase, d.amount_profit, 0 as is_paket, d.conv_bonus_id, (d.qty_bonus / d.conv_bonus) as qty_bns, d.conv_bonus, u.mst_code, i.struk_name, i.barcode, d.points, d.hrg_beli from trs_sales_detail d, mst_master u, mst_item i where i.kemasan_id = u.mst_id and d.item_id = i.item_id and d.item_id is not null and sales_id = 3 union all select d.sales_detail_id, d.paket_id, d.conv_id, (d.quantity / d.conversion) as quantity, d.price, d.disc, d.disc_val, d.amount, d.conversion, d.price_purchase, d.amount_profit, 1 as is_paket, d.conv_bonus_id, (d.qty_bonus / d.conv_bonus) as qty_bns, d.conv_bonus, (select mst_code from mst_master where mst_id = i.unit_id) as mst_code, i.nama_struk as struk_name, i.barcode, d.points, d.hrg_beli from trs_sales_detail d, mst_service i where d.service_id = i.service_id and d.service_id is not null and sales_id = 3 order by sales_detail_id 

10/10/27 17:09:28 - cashier
>Message: Unknown column 'i.nama_struk' in 'field list'
>Dump: select d.sales_detail_id, d.item_id, 0, (d.quantity / d.conversion) as quantity, d.price, d.disc, d.disc_val, d.amount, d.conversion, d.price_purchase, d.amount_profit, 0 as is_paket, d.conv_bonus_id, (d.qty_bonus / d.conv_bonus) as qty_bns, d.conv_bonus, u.mst_code, i.struk_name, i.barcode, d.points, d.hrg_beli from trs_sales_detail d, mst_master u, mst_item i where i.kemasan_id = u.mst_id and d.item_id = i.item_id and d.item_id is not null and sales_id = 3 union all select d.sales_detail_id, d.paket_id, 0, (d.quantity / d.conversion) as quantity, d.price, d.disc, d.disc_val, d.amount, d.conversion, d.price_purchase, d.amount_profit, 1 as is_paket, d.conv_bonus_id, (d.qty_bonus / d.conv_bonus) as qty_bns, d.conv_bonus,   '', i.nama_struk as struk_name, i.barcode, d.points, d.hrg_beli from trs_sales_detail d, mst_service i where d.service_id = i.service_id and d.service_id is not null and sales_id = 3 order by sales_detail_id 

10/10/27 17:10:11 - cashier
>Message: Unknown column 'd.service_id' in 'where clause'
>Dump: select d.sales_detail_id, d.item_id, 0, (d.quantity / d.conversion) as quantity, d.price, d.disc, d.disc_val, d.amount, d.conversion, d.price_purchase, d.amount_profit, 0 as is_paket, d.conv_bonus_id, (d.qty_bonus / d.conv_bonus) as qty_bns, d.conv_bonus, u.mst_code, i.struk_name, i.barcode, d.points, d.hrg_beli from trs_sales_detail d, mst_master u, mst_item i where i.kemasan_id = u.mst_id and d.item_id = i.item_id and d.item_id is not null and sales_id = 3 union all select d.sales_detail_id, d.paket_id, 0, (d.quantity / d.conversion) as quantity, d.price, d.disc, d.disc_val, d.amount, d.conversion, d.price_purchase, d.amount_profit, 1 as is_paket, d.conv_bonus_id, (d.qty_bonus / d.conv_bonus) as qty_bns, d.conv_bonus,   '', i.service_name as struk_name, i.service_code, d.points, d.hrg_beli from trs_sales_detail d, mst_service i where d.service_id = i.service_id and d.service_id is not null and sales_id = 3 order by sales_detail_id 

10/10/27 17:10:51 - cashier
>Message: Unknown column 'd.service_id' in 'where clause'
>Dump: select d.sales_detail_id, d.item_id, 0, (d.quantity / d.conversion) as quantity, d.price, d.disc, d.disc_val, d.amount, d.conversion, d.price_purchase, d.amount_profit, 0 as is_paket, d.conv_bonus_id, (d.qty_bonus / d.conv_bonus) as qty_bns, d.conv_bonus, u.mst_code, i.struk_name, i.barcode, d.points, d.hrg_beli from trs_sales_detail d, mst_master u, mst_item i where i.kemasan_id = u.mst_id and d.item_id = i.item_id and d.item_id is not null and sales_id = 3 union all select d.sales_detail_id, d.paket_id, 0, (d.quantity / d.conversion) as quantity, d.price, d.disc, d.disc_val, d.amount, d.conversion, d.price_purchase, d.amount_profit, 1 as is_paket, d.conv_bonus_id, (d.qty_bonus / d.conv_bonus) as qty_bns, d.conv_bonus,   '', i.service_name as struk_name, i.service_code, d.points, d.hrg_beli from trs_sales_detail d, mst_service i where d.service_id = i.service_id and d.paket_id is not null and sales_id = 3 order by sales_detail_id 

10/10/28 09:28:03 - petShop
>Message: Table 'petshop.mst_item_conversion' doesn't exist
>Dump: select t.relation_id, t.trans_date, t.receipt_id, i.barcode, i.item_name, (d.quantity/d.conversion) as quantity, d.price, d.amount, (select u.mst_code from mst_item_conversion c, mst_master u where d.conv_id = c.conv_id and c.unit_id = u.mst_id) as satuan, (select r.relation_name from mst_relation r where r.relation_id = t.relation_id) as suplier from trs_receipt_mst t, trs_receipt_detail d, mst_item i where t.receipt_id = d.receipt_id and d.item_id = i.item_id  and t.trans_date >= cast('2010-10-01 'as date) and t.trans_date <=cast('2010-10-31 'as date) order by suplier, t.trans_date, i.item_name

10/10/28 09:37:38 - petShop
>Message: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'case when tipe=0 then 'Terima PO' else 'Pembelian Langsung' end,
>Dump: select distinct t.receipt_id, t.trans_num as 'No Trx', t.trans_date as 'Tgl Terima', t.expr_date as 'Jth Tempo', (select relation_name from mst_relation r where r.relation_id= t.relation_id) as Supplier, ,case when tipe=0 then 'Terima PO' else 'Pembelian Langsung' end, t.Subtotal, (t.disc_mst + t.disc_detail) as Discount, t.tax as Pajak, t.Materai, t. Biaya, t.Total from trs_receipt_mst t  where  t.trans_date >= cast('2010-10-01 'as date) and t.trans_date <=cast('2010-10-31 'as date)

10/10/28 12:14:45 - petShop
>Message: Unknown column 'd.quantityas' in 'field list'
>Dump: select distinct item_id, item_name as Nama, (select u.mst_code from  mst_master u where kemasan_id = u.mst_id ) as satuan,  sum(awal),sum(beli), sum(retur_beli),sum(mutasi_masuk),sum(mutasi_keluar),sum(jual),sum(retur_jual),sum(opname)  FROM (SELECT i.item_id, i.item_name,ifnull(balance,0) as awal,0 as beli, 0 as retur_beli, 0 as mutasi_masuk, 0 as mutasi_keluar, 0 as jual, 0 as retur_jual, 0 as opname,kemasan_id from inv_item_balance b, mst_item i where balance_date = (select max(balance_date) from inv_item_balance where item_id = b.item_id and balance_date < cast('2010-10-01 'as date) ) and b.item_id = i.item_id   UNION ALL  SELECT i.item_id, i.item_name, 0 as awal,d.quantity as beli, 0 as retur_beli, 0 as mutasi_masuk, 0 as mutasi_keluar, 0 as jual, 0 as retur_jual, 0 as opname,kemasan_id  FROM trs_receipt_mst m inner join trs_receipt_detail d on d.receipt_id = m.receipt_id  inner join mst_item i on d.item_id = i.item_id  left join point_maping p on i.specification = p.code_id  WHERE status_id=1 and m.trans_date >= cast('2010-10-01 'as date) and m.trans_date <= cast('2010-10-28 'as date) and p.root_id =1 UNION ALL  SELECT i.item_id, i.item_name, 0 as awal,0 as beli, d.quantity as retur_beli, 0 as mutasi_masuk, 0 as mutasi_keluar, 0 as jual, 0 as retur_jual, 0 as opname,kemasan_id  FROM trs_retur_mst m inner join trs_retur_detail d on d.retur_id = m.retur_id  inner join mst_item i on d.item_id = i.item_id  left join point_maping p on i.specification = p.code_id  WHERE status_id=1 and  m.trans_date >= cast('2010-10-01 'as date) and m.trans_date <= cast('2010-10-28 'as date) and p.root_id =1 UNION ALL  SELECT i.item_id, i.item_name, 0 as awal,0 as beli, 0 as retur_beli, d.quantityas mutasi_masuk, 0 as mutasi_keluar, 0 as jual, 0 as retur_jual, 0 as opname,kemasan_id  FROM trs_shipment_mst m inner join trs_shipment_detail d on d.ship_id = m.ship_id  inner join mst_item i on d.item_id = i.item_id  left join point_maping p on i.specification = p.code_id  WHERE status_id =1 and tipe=2 and m.trans_date >= cast('2010-10-01 'as date) and m.trans_date <= cast('2010-10-28 'as date) and p.root_id =1 UNION ALL  SELECT i.item_id, i.item_name, 0 as awal,0 as beli, 0 as retur_beli, 0 as mutasi_masuk, d.quantity as mutasi_keluar, 0 as jual, 0 as retur_jual, 0 as opname,kemasan_id  FROM trs_shipment_mst m inner join trs_shipment_detail d on d.ship_id = m.ship_id  inner join mst_item i on d.item_id = i.item_id  left join point_maping p on i.specification = p.code_id  WHERE status_id =1 and tipe=3 and m.trans_date >= cast('2010-10-01 'as date) and m.trans_date <= cast('2010-10-28 'as date) and p.root_id =1 UNION ALL  SELECT i.item_id, i.item_name, 0 as awal,0 as beli, 0 as retur_beli, 0 as mutasi_masuk, 0 as mutasi_keluar, d.quantity as jual, 0 as retur_jual, 0 as opname,kemasan_id  FROM trs_sales_mst m inner join trs_sales_detail d on d.sales_id = m.sales_id  inner join mst_item i on d.item_id = i.item_id  left join point_maping p on i.specification = p.code_id  WHERE m.trans_date >= cast('2010-10-01 'as date) and m.trans_date <= cast('2010-10-28 'as date) and p.root_id =1 UNION ALL  SELECT i.item_id, i.item_name, 0 as awal,0 as beli, 0 as retur_beli, 0 as mutasi_masuk, 0 as mutasi_keluar, 0 as jual, 0 as retur_jual, d.quantity as opname,kemasan_id  FROM trs_shipment_mst m inner join trs_shipment_detail d on d.ship_id = m.ship_id  inner join mst_item i on d.item_id = i.item_id  left join point_maping p on i.specification = p.code_id  WHERE status_id =1 and tipe=1 and m.trans_date >= cast('2010-10-01 'as date) and m.trans_date <= cast('2010-10-28 'as date) and p.root_id =1) as t1   group by item_id,item_name, satuan

10/10/28 12:15:04 - petShop
>Message: Unknown column 'status_id' in 'where clause'
>Dump: select distinct item_id, item_name as Nama, (select u.mst_code from  mst_master u where kemasan_id = u.mst_id ) as satuan,  sum(awal),sum(beli), sum(retur_beli),sum(mutasi_masuk),sum(mutasi_keluar),sum(jual),sum(retur_jual),sum(opname)  FROM (SELECT i.item_id, i.item_name,ifnull(balance,0) as awal,0 as beli, 0 as retur_beli, 0 as mutasi_masuk, 0 as mutasi_keluar, 0 as jual, 0 as retur_jual, 0 as opname,kemasan_id from inv_item_balance b, mst_item i where balance_date = (select max(balance_date) from inv_item_balance where item_id = b.item_id and balance_date < cast('2010-10-01 'as date) ) and b.item_id = i.item_id   UNION ALL  SELECT i.item_id, i.item_name, 0 as awal,d.quantity as beli, 0 as retur_beli, 0 as mutasi_masuk, 0 as mutasi_keluar, 0 as jual, 0 as retur_jual, 0 as opname,kemasan_id  FROM trs_receipt_mst m inner join trs_receipt_detail d on d.receipt_id = m.receipt_id  inner join mst_item i on d.item_id = i.item_id  left join point_maping p on i.specification = p.code_id  WHERE status_id=1 and m.trans_date >= cast('2010-10-01 'as date) and m.trans_date <= cast('2010-10-28 'as date) and p.root_id =1 UNION ALL  SELECT i.item_id, i.item_name, 0 as awal,0 as beli, d.quantity as retur_beli, 0 as mutasi_masuk, 0 as mutasi_keluar, 0 as jual, 0 as retur_jual, 0 as opname,kemasan_id  FROM trs_retur_mst m inner join trs_retur_detail d on d.retur_id = m.retur_id  inner join mst_item i on d.item_id = i.item_id  left join point_maping p on i.specification = p.code_id  WHERE status_id=1 and  m.trans_date >= cast('2010-10-01 'as date) and m.trans_date <= cast('2010-10-28 'as date) and p.root_id =1 UNION ALL  SELECT i.item_id, i.item_name, 0 as awal,0 as beli, 0 as retur_beli, d.quantity as mutasi_masuk, 0 as mutasi_keluar, 0 as jual, 0 as retur_jual, 0 as opname,kemasan_id  FROM trs_shipment_mst m inner join trs_shipment_detail d on d.ship_id = m.ship_id  inner join mst_item i on d.item_id = i.item_id  left join point_maping p on i.specification = p.code_id  WHERE status_id =1 and tipe=2 and m.trans_date >= cast('2010-10-01 'as date) and m.trans_date <= cast('2010-10-28 'as date) and p.root_id =1 UNION ALL  SELECT i.item_id, i.item_name, 0 as awal,0 as beli, 0 as retur_beli, 0 as mutasi_masuk, d.quantity as mutasi_keluar, 0 as jual, 0 as retur_jual, 0 as opname,kemasan_id  FROM trs_shipment_mst m inner join trs_shipment_detail d on d.ship_id = m.ship_id  inner join mst_item i on d.item_id = i.item_id  left join point_maping p on i.specification = p.code_id  WHERE status_id =1 and tipe=3 and m.trans_date >= cast('2010-10-01 'as date) and m.trans_date <= cast('2010-10-28 'as date) and p.root_id =1 UNION ALL  SELECT i.item_id, i.item_name, 0 as awal,0 as beli, 0 as retur_beli, 0 as mutasi_masuk, 0 as mutasi_keluar, d.quantity as jual, 0 as retur_jual, 0 as opname,kemasan_id  FROM trs_sales_mst m inner join trs_sales_detail d on d.sales_id = m.sales_id  inner join mst_item i on d.item_id = i.item_id  left join point_maping p on i.specification = p.code_id  WHERE m.trans_date >= cast('2010-10-01 'as date) and m.trans_date <= cast('2010-10-28 'as date) and p.root_id =1 UNION ALL  SELECT i.item_id, i.item_name, 0 as awal,0 as beli, 0 as retur_beli, 0 as mutasi_masuk, 0 as mutasi_keluar, 0 as jual, 0 as retur_jual, d.quantity as opname,kemasan_id  FROM trs_shipment_mst m inner join trs_shipment_detail d on d.ship_id = m.ship_id  inner join mst_item i on d.item_id = i.item_id  left join point_maping p on i.specification = p.code_id  WHERE status_id =1 and tipe=1 and m.trans_date >= cast('2010-10-01 'as date) and m.trans_date <= cast('2010-10-28 'as date) and p.root_id =1) as t1   group by item_id,item_name, satuan

10/11/09 09:38:38 - petShop
>Message: Cannot delete or update a parent row: a foreign key constraint fails (`petshop/system_access`, CONSTRAINT `system_access_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `system_users` (`user_id`) ON DELET
>Dump: DELETE FROM System_Users WHERE User_Id='Wina'

10/11/09 09:40:38 - petShop
>Message: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near ';  DELETE FROM System_Users WHERE User_Id='Wina'' at line 1
>Dump: delete from system_access where user_id = 'Wina';  DELETE FROM System_Users WHERE User_Id='Wina'

10/11/09 18:29:14 - petShop
>Message: Out of range value adjusted for column 'p_user_id' at row 1
>Dump: select is_can (1,'lundz',210)

10/11/15 18:28:56 - petShop
>Message: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near ') or (merk like '%%' ) order by item_name' at line 1
>Dump: select distinct i.item_id, barcode as 'Kode', item_name as 'Nama', merk as Merk from mst_item i, point_maping p where i.specification = p.code_id ) or (merk like '%%' ) order by item_name 

10/11/19 22:32:15 - cashier
>Message: Unknown column 'storage_id' in 'where clause'
>Dump: call save_to_money_balance(1, cast('2010-11-19 'as date), 25000, 'D')

10/11/20 09:47:08 - petShop
>Message: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near ' t.Total from trs_money_trans_mst t  where  t.trans_date >= cast
>Dump: select distinct t.money_trans_id, t.trans_num as 'No Trx', t.trans_date as 'Tanggal', , t.Total from trs_money_trans_mst t  where  t.trans_date >= cast('2010-11-01 'as date) and t.trans_date <=cast('2010-11-30 'as date)

10/11/20 09:59:04 - petShop
>Message: Unknown column 'inset_log' in 'field list'
>Dump: select money_trans_id, trans_type, trans_num, trans_date, inset_log, total, notes from trs_money_trans_mst where money_trans_id = 1

10/11/20 12:01:55 - cashier
>Message: Table 'petshop.mst_pasien' doesn't exist
>Dump: select pasien_id, kode, nama, alamat, phone, kota, sex, tgl_lahir, card_id from mst_pasien where kode = ''

10/11/21 11:17:54 - cashier
>Message: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'animal_ame, total as Jumlah from trs_holded_mst t left join mst_
>Dump: select hold_id, trans_num as 'No.Trans',trans_date as 'Tgl.Trans', relation_name as Customer,,animal_ame, total as Jumlah from trs_holded_mst t left join mst_relation r on t.pasien_id = r.relation_id  left join mst_relation_animal a on r.relation_id = a.relation_id and t.animal_seq = a.seq  order by trans_num

10/11/21 11:18:23 - cashier
>Message: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'animal_name, total as Jumlah from trs_holded_mst t left join mst
>Dump: select hold_id, trans_num as 'No.Trans',trans_date as 'Tgl.Trans', relation_name as Customer,,animal_name, total as Jumlah from trs_holded_mst t left join mst_relation r on t.pasien_id = r.relation_id  left join mst_relation_animal a on r.relation_id = a.relation_id and t.animal_seq = a.seq  order by trans_num

10/11/22 14:03:44 - cashier
>Message: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near ' dokter_id = NULL,, embalase = 0, no_resep = '', animal_seq = 1,
>Dump: update trs_holded_mst set trans_date = cast('2010-11-22 'as date), cashier_id = 5, subtotal = 55000, disc_mst = 0, disc_val_mst = 0, tax = 0, total = 55000, points = 0, relation_type = 1, pasien_id = 7,, dokter_id = NULL,, embalase = 0, no_resep = '', animal_seq = 1, animal_id = 5, user_id = 'adm' where hold_id = 5

10/11/23 14:40:24 - petShop
>Message: Column 'akun_id' in field list is ambiguous
>Dump: select description, amount,money_trans_detail_id, money_id,akun_id,a.nama  from trs_money_trans_detail d left join mst_akun a on d.akun_id = a.akun_id where money_trans_id = 4

10/11/23 14:44:26 - petShop
>Message: Column 'akun_id' in field list is ambiguous
>Dump: select description, amount,money_trans_detail_id, money_id,akun_id,a.nama  from trs_money_trans_detail d left join mst_akun a on d.akun_id = a.akun_id where money_trans_id = 4

10/11/24 09:08:43 - petShop
>Message: Cannot add or update a child row: a foreign key constraint fails (`petshop/trs_item_use_detail`, CONSTRAINT `fk_trs_item_use_detail_item` FOREIGN KEY (`item_id`) REFERENCES `mst_item` (`item_id`))
>Dump: insert into trs_item_use_detail (item_use_id, item_id,quantity,buying_price,amount)values (1,0,45,229500,229500)

10/11/24 09:51:14 - petShop
>Message: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near ''Credit' else 'Debit' end from mst_akun  order by nama' at line 
>Dump: select akun_id,kode,nama,case tipe when 2 'Credit' else 'Debit' end from mst_akun  order by nama

10/11/24 10:04:17 - petShop
>Message: Unknown column 't.tipe' in 'where clause'
>Dump: select ifnull(sum(d.amount),0) from trs_money_trans_mst t, trs_money_trans_detail d where t.tipe = 2 and d.akun_id = 1 and t.trans_date >= cast('2010-11-24 'as date) and t.trans_date <=cast('2010-11-30 'as date)

10/11/24 10:08:30 - petShop
>Message: Unknown column 'amount' in 'field list'
>Dump: select ifnull(sum(amount),0) from trs_money_trans_mst t where t.trans_type = 1 and t.trans_date >= cast('2010-11-01 'as date) and t.trans_date <=cast('2010-11-24 'as date)

10/11/24 10:08:45 - petShop
>Message: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'on d.money_trans_id = t.money_trans_id where t.trans_Type = 2 an
>Dump: select ifnull(sum(d.amount),0) from trs_money_trans_mst t, trs_money_trans_detail d on d.money_trans_id = t.money_trans_id where t.trans_Type = 2 and d.akun_id = 1 and t.trans_date >= cast('2010-11-01 'as date) and t.trans_date <=cast('2010-11-24 'as date)

10/11/24 11:16:41 - petShop
>Message: Unknown column 'satuan' in 'group statement'
>Dump: select distinct item_id, item_name as Nama, merk as Merk,  sum(awal),sum(beli), sum(retur_beli),sum(mutasi_masuk),sum(mutasi_keluar),sum(jual),sum(pakai),sum(retur_jual),sum(opname),item_code  FROM (SELECT i.item_id, i.item_name,ifnull(balance,0) as awal,0 as beli, 0 as retur_beli, 0 as mutasi_masuk, 0 as mutasi_keluar, 0 as pakai,0 as jual, 0 as retur_jual, 0 as opname,kemasan_id,item_code,merk from inv_item_balance b, mst_item i where balance_date = (select max(balance_date) from inv_item_balance where item_id = b.item_id and balance_date < cast('2010-11-01 'as date) ) and b.item_id = i.item_id   UNION ALL  SELECT i.item_id, i.item_name, 0 as awal,d.quantity as beli, 0 as retur_beli, 0 as mutasi_masuk, 0 as mutasi_keluar, 0 as pakai,0 as jual, 0 as retur_jual, 0 as opname,kemasan_id,item_code,merk  FROM trs_receipt_mst m inner join trs_receipt_detail d on d.receipt_id = m.receipt_id  inner join mst_item i on d.item_id = i.item_id  left join point_maping p on i.specification = p.code_id  WHERE status_id=1 and m.trans_date >= cast('2010-11-01 'as date) and m.trans_date <= cast('2010-11-24 'as date) and p.root_id =1 and i.merk like '%B%' UNION ALL  SELECT i.item_id, i.item_name, 0 as awal,0 as beli, d.quantity as retur_beli, 0 as mutasi_masuk, 0 as mutasi_keluar, 0 as pakai,0 as jual, 0 as retur_jual, 0 as opname,kemasan_id ,item_code,merk  FROM trs_retur_mst m inner join trs_retur_detail d on d.retur_id = m.retur_id  inner join mst_item i on d.item_id = i.item_id  left join point_maping p on i.specification = p.code_id  WHERE status_id=1 and  m.trans_date >= cast('2010-11-01 'as date) and m.trans_date <= cast('2010-11-24 'as date) and p.root_id =1 and i.merk like '%B%' UNION ALL  SELECT i.item_id, i.item_name, 0 as awal,0 as beli, 0 as retur_beli, d.quantity as mutasi_masuk, 0 as mutasi_keluar, 0 as pakai,0 as jual, 0 as retur_jual, 0 as opname,kemasan_id,item_code,merk  FROM trs_shipment_mst m inner join trs_shipment_detail d on d.ship_id = m.ship_id  inner join mst_item i on d.item_id = i.item_id  left join point_maping p on i.specification = p.code_id  WHERE tipe=2 and m.trans_date >= cast('2010-11-01 'as date) and m.trans_date <= cast('2010-11-24 'as date) and p.root_id =1 and i.merk like '%B%' UNION ALL  SELECT i.item_id, i.item_name, 0 as awal,0 as beli, 0 as retur_beli, 0 as mutasi_masuk, d.quantity as mutasi_keluar,  0 as pakai,0 as jual, 0 as retur_jual, 0 as opname,kemasan_id,item_code,merk  FROM trs_shipment_mst m inner join trs_shipment_detail d on d.ship_id = m.ship_id  inner join mst_item i on d.item_id = i.item_id  left join point_maping p on i.specification = p.code_id  WHERE  tipe=3 and m.trans_date >= cast('2010-11-01 'as date) and m.trans_date <= cast('2010-11-24 'as date) and p.root_id =1 and i.merk like '%B%' UNION ALL  SELECT i.item_id, i.item_name, 0 as awal,0 as beli, 0 as retur_beli, 0 as mutasi_masuk, 0 as mutasi_keluar, d.quantity as pakai,0 as jual, 0 as retur_jual, 0 as opname,kemasan_id,item_code,merk  FROM trs_item_use_mst m inner join trs_item_use_detail d on d.item_use_id = m.item_use_id  inner join mst_item i on d.item_id = i.item_id  left join point_maping p on i.specification = p.code_id  WHERE  m.trans_date >= cast('2010-11-01 'as date) and m.trans_date <= cast('2010-11-24 'as date) and p.root_id =1 and i.merk like '%B%' UNION ALL  SELECT i.item_id, i.item_name, 0 as awal,0 as beli, 0 as retur_beli, 0 as mutasi_masuk, 0 as mutasi_keluar, 0 as pakai,d.quantity as jual, 0 as retur_jual, 0 as opname,kemasan_id,item_code,merk  FROM trs_sales_mst m inner join trs_sales_detail d on d.sales_id = m.sales_id  inner join mst_item i on d.item_id = i.item_id  left join point_maping p on i.specification = p.code_id  WHERE m.trans_date >= cast('2010-11-01 'as date) and m.trans_date <= cast('2010-11-24 'as date) and p.root_id =1 and i.merk like '%B%' UNION ALL  SELECT i.item_id, i.item_name, 0 as awal,0 as beli, 0 as retur_beli, 0 as mutasi_masuk, 0 as mutasi_keluar, 0 as pakai,0 as jual, 0 as retur_jual, d.quantity as opname,kemasan_id,item_code,merk  FROM trs_shipment_mst m inner join trs_shipment_detail d on d.ship_id = m.ship_id  inner join mst_item i on d.item_id = i.item_id  left join point_maping p on i.specification = p.code_id  WHERE  tipe=1 and m.trans_date >= cast('2010-11-01 'as date) and m.trans_date <= cast('2010-11-24 'as date) and p.root_id =1 and i.merk like '%B%') as t1   group by item_name, satuan,item_code 

10/11/24 11:50:19 - petShop
>Message: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'and i.disabled_date is null  and p.root_id =1 and i.merk like '%
>Dump: select distinct i.item_id, i.barcode, i.item_name, i.current_stock, i.avg_price,merk,kemasan_id, buying_price  from mst_item i left join point_maping p on i.specification = p.code_id where  and i.disabled_date is null  and p.root_id =1 and i.merk like '%bb%' order by i.item_name

10/11/25 13:36:30 - cashier
>Message: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near ' dokter_id = NULL,, embalase = 0, no_resep = '', animal_seq = 0,
>Dump: update trs_holded_mst set trans_date = cast('2010-11-25 'as date), cashier_id = 5, subtotal = 271775, disc_mst = 0, disc_val_mst = 200, tax = 0, total = 271575, points = 0, relation_type = 1, pasien_id = NULL,, dokter_id = NULL,, embalase = 0, no_resep = '', animal_seq = 0, animal_id = 0, user_id = 'adm' where hold_id = 2

10/11/25 13:58:27 - petShop
>Message: Cannot add or update a child row: a foreign key constraint fails (`petshop/trs_money_trans_detail`, CONSTRAINT `fk_money_trans_detail_mst` FOREIGN KEY (`money_trans_id`) REFERENCES `trs_money_trans_m
>Dump: insert into trs_money_trans_detail (money_trans_id, money_id,description,akun_id, amount)values (0,1,'inject modal awal',7,100000000)

10/11/25 13:58:36 - petShop
>Message: Cannot add or update a child row: a foreign key constraint fails (`petshop/trs_money_trans_detail`, CONSTRAINT `fk_money_trans_detail_mst` FOREIGN KEY (`money_trans_id`) REFERENCES `trs_money_trans_m
>Dump: insert into trs_money_trans_detail (money_trans_id, money_id,description,akun_id, amount)values (0,1,'inject modal awal',7,100000000)

10/11/26 10:44:56 - cashier
>Message: Can't connect to MySQL server on '192.168.1.3' (0)
>Dump: select count(*) from trs_sales_mst where trans_date = curdate()

10/11/26 14:47:17 - cashier
>Message: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near '.service_code,d.disc_val  from trs_sales_mst t, trs_sales_detail
>Dump: select (d.quantity) as qty, d.price, d.amount, i.item_name, t.trans_num, t.trans_date, t.total, t.cash, (t.cash - t.total) as cash_back, t.subtotal, t.disc_mst, t.disc_val_mst, d.sales_detail_id, t.pasien_id, t.dokter_id,0 as tipe_racikan,  0 as id_paket, t.no_resep, now() ,i.item_code,d.disc_val  from trs_sales_mst t, trs_sales_detail d, mst_item i where d.sales_id = t.sales_id and d.item_id = i.item_id and d.item_id is not null and t.sales_id = 1 union all select (d.quantity ) as qty, d.price, d.amount, i.service_name as struk_name,  t.trans_num, t.trans_date, t.total, t.cash, (t.cash - t.total) as cash_back, t.subtotal, t.disc_mst, t.disc_val_mst,  d.sales_detail_id, t.pasien_id, t.dokter_id, 1 as tipe_racikan, d.paket_id as id_paket, t.no_resep, now()  i.service_code,d.disc_val  from trs_sales_mst t, trs_sales_detail d, mst_service i where d.sales_id = t.sales_id and d.paket_id = i.service_id and d.paket_id is not null and t.sales_id = 1 order by sales_detail_id 

10/12/01 15:49:41 - cashier
>Message: Unknown column 'addres1' in 'field list'
>Dump: select relation_id, relation_code as 'Kode', relation_name as 'Nama',address1 as 'Alamat' from mst_relation where relation_type =1 order by relation_name 

10/12/02 18:33:58 - cashier
>Message: Unknown column 'p_sevice_type' in 'where clause'
>Dump: call put_customer_service(7,27,1)

10/12/03 13:13:20 - cashier
>Message: Unknown column 'p.animal_id' in 'on clause'
>Dump: select i.item_id, i.item_code as 'Kode', i.barcode as 'Barcode', i.item_name as 'Nama Barang/Jasa', current_stock as 'Stok', (select mst_code from mst_master where mst_id = i.kemasan_id) as Unit, i.selling_price as 'Hrg Jual/Jasa',merk as Merk,0 as paket from mst_item i where i.disabled_date is null  and (lower(item_name) like '%%') or (lower(merk) like '%%') union all  select i.service_id, i.service_code as 'Kode', '' as 'Barcode',  concat(i.service_name,' ',animal) as 'Nama Barang/Jasa', 0 as 'Stok', '' as Unit,  price as 'Hrg Jual/Jasa','' as Merk,1 as paket from mst_service i left join mst_service_price s on s.service_id = i.service_id  left join mst_animal a on a.animal_id = p.animal_id  where  service_name like '%%'

10/12/03 13:23:49 - cashier
>Message: Column 'animal_id' in where clause is ambiguous
>Dump: select s.service_id as item_id, concat(service_name,' ',animal) as item_name, service_code, service_name as struk_name, 0 as avg_price, 1 as paket  ,price, add_price,0 as current_stock,discount as discount,0 as buying_price from mst_service s left join mst_service_price p on s.service_id=p.service_id  left join mst_animal a on a.animal_id = p.animal_id where s.service_id = 4 and animal_id = 7

10/12/08 14:18:07 - cashier
>Message: Unknown column 'bonus_jumlah' in 'field list'
>Dump: select bonus_service,bonus_jumlah from mst_relation_service r inner join mst_service_bonus b on b.service_type=r.service_type  where relation_id = 2 and r.jumlah >= b.jml_service 

10/12/11 11:19:53 - cashier
>Message: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'conversion)values (14,NULL,NULL,2,1,60000,10,0,60000,60000,0,0,0
>Dump: insert into trs_holded_detail (hold_id, item_id, conv_id, paket_id, quantity, price, disc, disc_val, amount, amount_profit, price_purchase, points, hrg_beli, trx_racik_id,service_type,is_Free,animal_id conversion)values (14,NULL,NULL,2,1,60000,10,0,60000,60000,0,0,0,0,0,0,0,1)

10/12/11 11:20:07 - cashier
>Message: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'conversion)values (14,5,NULL,NULL,1,157500,3,7875,149625,-375,15
>Dump: insert into trs_holded_detail (hold_id, item_id, conv_id, paket_id, quantity, price, disc, disc_val, amount, amount_profit, price_purchase, points, hrg_beli, trx_racik_id,service_type,is_Free,animal_id conversion)values (14,5,NULL,NULL,1,157500,3,7875,149625,-375,150000,0,150000,0,0,0,0,1)

10/12/11 11:20:19 - cashier
>Message: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'conversion)values (14,NULL,NULL,2,1,60000,10,0,60000,60000,0,0,0
>Dump: insert into trs_holded_detail (hold_id, item_id, conv_id, paket_id, quantity, price, disc, disc_val, amount, amount_profit, price_purchase, points, hrg_beli, trx_racik_id,service_type,is_Free,animal_id conversion)values (14,NULL,NULL,2,1,60000,10,0,60000,60000,0,0,0,0,0,0,0,1)

10/12/11 11:44:46 - cashier
>Message: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'conversion)values (14,NULL,NULL,2,1,60000,10,0,60000,60000,0,0,0
>Dump: insert into trs_holded_detail (hold_id, item_id, conv_id, paket_id, quantity, price, disc, disc_val, amount, amount_profit, price_purchase, points, hrg_beli, trx_racik_id,service_type,is_Free,animal_id conversion)values (14,NULL,NULL,2,1,60000,10,0,60000,60000,0,0,0,0,0,0,0,1)

10/12/11 13:28:24 - petShop
>Message: Unknown column 'p.root_id' in 'where clause'
>Dump: select distinct item_id, item_name as Nama, merk as Merk,  sum(awal),sum(beli), sum(retur_beli),sum(mutasi_masuk),sum(mutasi_keluar),sum(pakai),sum(jual),sum(retur_jual),sum(opname),item_code  FROM (SELECT i.item_id, i.item_name,ifnull(balance,0) as awal,0 as beli, 0 as retur_beli, 0 as mutasi_masuk, 0 as mutasi_keluar, 0 as pakai,0 as jual, 0 as retur_jual, 0 as opname,kemasan_id,item_code,merk from inv_item_balance b, mst_item i where balance_date = (select max(balance_date) from inv_item_balance where item_id = b.item_id and balance_date < cast('2010-12-01 'as date) )  and p.root_id =1 and i.item_code like '%0042%'and b.item_id = i.item_id   UNION ALL  SELECT i.item_id, i.item_name, 0 as awal,d.quantity as beli, 0 as retur_beli, 0 as mutasi_masuk, 0 as mutasi_keluar, 0 as pakai,0 as jual, 0 as retur_jual, 0 as opname,kemasan_id,item_code,merk  FROM trs_receipt_mst m inner join trs_receipt_detail d on d.receipt_id = m.receipt_id  inner join mst_item i on d.item_id = i.item_id  left join point_maping p on i.specification = p.code_id  WHERE status_id=1 and m.trans_date >= cast('2010-12-01 'as date) and m.trans_date <= cast('2010-12-11 'as date) and p.root_id =1 and i.item_code like '%0042%' UNION ALL  SELECT i.item_id, i.item_name, 0 as awal,0 as beli, d.quantity as retur_beli, 0 as mutasi_masuk, 0 as mutasi_keluar, 0 as pakai,0 as jual, 0 as retur_jual, 0 as opname,kemasan_id ,item_code,merk  FROM trs_retur_mst m inner join trs_retur_detail d on d.retur_id = m.retur_id  inner join mst_item i on d.item_id = i.item_id  left join point_maping p on i.specification = p.code_id  WHERE status_id=1 and  m.trans_date >= cast('2010-12-01 'as date) and m.trans_date <= cast('2010-12-11 'as date) and p.root_id =1 and i.item_code like '%0042%' UNION ALL  SELECT i.item_id, i.item_name, 0 as awal,0 as beli, 0 as retur_beli, d.quantity as mutasi_masuk, 0 as mutasi_keluar, 0 as pakai,0 as jual, 0 as retur_jual, 0 as opname,kemasan_id,item_code,merk  FROM trs_shipment_mst m inner join trs_shipment_detail d on d.ship_id = m.ship_id  inner join mst_item i on d.item_id = i.item_id  left join point_maping p on i.specification = p.code_id  WHERE tipe=2 and m.trans_date >= cast('2010-12-01 'as date) and m.trans_date <= cast('2010-12-11 'as date) and p.root_id =1 and i.item_code like '%0042%' UNION ALL  SELECT i.item_id, i.item_name, 0 as awal,0 as beli, 0 as retur_beli, 0 as mutasi_masuk, d.quantity as mutasi_keluar,  0 as pakai,0 as jual, 0 as retur_jual, 0 as opname,kemasan_id,item_code,merk  FROM trs_shipment_mst m inner join trs_shipment_detail d on d.ship_id = m.ship_id  inner join mst_item i on d.item_id = i.item_id  left join point_maping p on i.specification = p.code_id  WHERE  tipe=3 and m.trans_date >= cast('2010-12-01 'as date) and m.trans_date <= cast('2010-12-11 'as date) and p.root_id =1 and i.item_code like '%0042%' UNION ALL  SELECT i.item_id, i.item_name, 0 as awal,0 as beli, 0 as retur_beli, 0 as mutasi_masuk, 0 as mutasi_keluar, d.quantity as pakai,0 as jual, 0 as retur_jual, 0 as opname,kemasan_id,item_code,merk  FROM trs_item_use_mst m inner join trs_item_use_detail d on d.item_use_id = m.item_use_id  inner join mst_item i on d.item_id = i.item_id  left join point_maping p on i.specification = p.code_id  WHERE  m.trans_date >= cast('2010-12-01 'as date) and m.trans_date <= cast('2010-12-11 'as date) and p.root_id =1 and i.item_code like '%0042%' UNION ALL  SELECT i.item_id, i.item_name, 0 as awal,0 as beli, 0 as retur_beli, 0 as mutasi_masuk, 0 as mutasi_keluar, 0 as pakai,d.quantity as jual, 0 as retur_jual, 0 as opname,kemasan_id,item_code,merk  FROM trs_sales_mst m inner join trs_sales_detail d on d.sales_id = m.sales_id  inner join mst_item i on d.item_id = i.item_id  left join point_maping p on i.specification = p.code_id  WHERE trans_type = 13 and m.trans_date >= cast('2010-12-01 'as date) and m.trans_date <= cast('2010-12-11 'as date) and p.root_id =1 and i.item_code like '%0042%' UNION ALL  SELECT i.item_id, i.item_name, 0 as awal,0 as beli, 0 as retur_beli, 0 as mutasi_masuk, 0 as mutasi_keluar, 0 as pakai,0 as jual, d.quantity as retur_jual, 0 as opname,kemasan_id,item_code,merk  FROM trs_sales_mst m inner join trs_sales_detail d on d.sales_id = m.sales_id  inner join mst_item i on d.item_id = i.item_id  left join point_maping p on i.specification = p.code_id  WHERE trans_type = 14 and m.trans_date >= cast('2010-12-01 'as date) and m.trans_date <= cast('2010-12-11 'as date) and p.root_id =1 and i.item_code like '%0042%' UNION ALL  SELECT i.item_id, i.item_name, 0 as awal,0 as beli, 0 as retur_beli, 0 as mutasi_masuk, 0 as mutasi_keluar, 0 as pakai,0 as jual, 0 as retur_jual, d.quantity as opname,kemasan_id,item_code,merk  FROM trs_shipment_mst m inner join trs_shipment_detail d on d.ship_id = m.ship_id  inner join mst_item i on d.item_id = i.item_id  left join point_maping p on i.specification = p.code_id  WHERE  tipe=1 and m.trans_date >= cast('2010-12-01 'as date) and m.trans_date <= cast('2010-12-11 'as date) and p.root_id =1 and i.item_code like '%0042%') as t1   group by item_name, merk,item_code 

10/12/20 14:55:14 - petShop
>Message: Data truncated for column 'age' at row 1
>Dump: UPDATE Mst_Relation_Animal SET Animal_Name='Wewey', Animal_ID=5, Race='Blasteran', Eat='Standar', Age='4 bulan', Sex=0 WHERE Relation_ID=7 AND Seq=1

10/12/20 14:55:30 - petShop
>Message: Data truncated for column 'age' at row 1
>Dump: UPDATE Mst_Relation_Animal SET Animal_Name='Wewey', Animal_ID=5, Race='Blasteran', Eat='Standar', Age='4 bulan', Sex=0 WHERE Relation_ID=7 AND Seq=1

10/12/20 14:55:47 - petShop
>Message: Data truncated for column 'age' at row 1
>Dump: UPDATE Mst_Relation_Animal SET Animal_Name='Wewey', Animal_ID=5, Race='Blasteran', Eat='Standar', Age='4 bulan', Sex=0 WHERE Relation_ID=7 AND Seq=1

10/12/20 14:55:50 - petShop
>Message: Data truncated for column 'age' at row 1
>Dump: UPDATE Mst_Relation_Animal SET Animal_Name='Wewey', Animal_ID=5, Race='Blasteran', Eat='Standar', Age='4 bulan', Sex=0 WHERE Relation_ID=7 AND Seq=1

10/12/20 14:55:54 - petShop
>Message: Data truncated for column 'age' at row 1
>Dump: UPDATE Mst_Relation_Animal SET Animal_Name='Wewey', Animal_ID=5, Race='Blasteran', Eat='Standar', Age='4 bulan', Sex=0 WHERE Relation_ID=7 AND Seq=1

10/12/20 14:56:28 - petShop
>Message: Data truncated for column 'age' at row 1
>Dump: UPDATE Mst_Relation_Animal SET Animal_Name='Wewey', Animal_ID=5, Race='Blasteran', Eat='Standar', Age='4 bulan', Sex=0 WHERE Relation_ID=7 AND Seq=1

10/12/20 14:56:32 - petShop
>Message: Data truncated for column 'age' at row 1
>Dump: UPDATE Mst_Relation_Animal SET Animal_Name='Wewey', Animal_ID=5, Race='Blasteran', Eat='Standar', Age='4 bulan', Sex=0 WHERE Relation_ID=7 AND Seq=1

10/12/20 14:56:34 - petShop
>Message: Data truncated for column 'age' at row 1
>Dump: UPDATE Mst_Relation_Animal SET Animal_Name='Wewey', Animal_ID=5, Race='Blasteran', Eat='Standar', Age='4 bulan', Sex=0 WHERE Relation_ID=7 AND Seq=1

10/12/20 14:56:52 - petShop
>Message: Data truncated for column 'age' at row 1
>Dump: UPDATE Mst_Relation_Animal SET Animal_Name='Wuwuy', Animal_ID=2, Race='', Eat='', Age='1 tahun', Sex=1 WHERE Relation_ID=7 AND Seq=4

10/12/20 14:58:28 - petShop
>Message: Data truncated for column 'age' at row 1
>Dump: INSERT INTO Mst_Relation_Animal (Relation_ID,Seq,Animal_Name,Animal_ID,Race,Eat,Age,Sex) VALUES (12,1,'gogon',5,'rx','whiskas','1 tahun',1)

10/12/20 14:58:51 - petShop
>Message: Data truncated for column 'age' at row 1
>Dump: INSERT INTO Mst_Relation_Animal (Relation_ID,Seq,Animal_Name,Animal_ID,Race,Eat,Age,Sex) VALUES (12,1,'gogon',5,'','','1 tahun',1)

10/12/20 14:58:52 - petShop
>Message: Data truncated for column 'age' at row 1
>Dump: INSERT INTO Mst_Relation_Animal (Relation_ID,Seq,Animal_Name,Animal_ID,Race,Eat,Age,Sex) VALUES (12,1,'gogon',5,'','','1 tahun',1)

10/12/20 14:59:38 - petShop
>Message: Data truncated for column 'age' at row 1
>Dump: INSERT INTO Mst_Relation_Animal (Relation_ID,Seq,Animal_Name,Animal_ID,Race,Eat,Age,Sex) VALUES (12,1,'gogon',5,'','','1 tahun',1)

10/12/20 14:59:38 - petShop
>Message: Data truncated for column 'age' at row 1
>Dump: INSERT INTO Mst_Relation_Animal (Relation_ID,Seq,Animal_Name,Animal_ID,Race,Eat,Age,Sex) VALUES (12,1,'gogon',5,'','','1 tahun',1)

10/12/20 14:59:38 - petShop
>Message: Data truncated for column 'age' at row 1
>Dump: INSERT INTO Mst_Relation_Animal (Relation_ID,Seq,Animal_Name,Animal_ID,Race,Eat,Age,Sex) VALUES (12,1,'gogon',5,'','','1 tahun',1)

10/12/20 14:59:39 - petShop
>Message: Data truncated for column 'age' at row 1
>Dump: INSERT INTO Mst_Relation_Animal (Relation_ID,Seq,Animal_Name,Animal_ID,Race,Eat,Age,Sex) VALUES (12,1,'gogon',5,'','','1 tahun',1)

10/12/20 14:59:40 - petShop
>Message: Data truncated for column 'age' at row 1
>Dump: INSERT INTO Mst_Relation_Animal (Relation_ID,Seq,Animal_Name,Animal_ID,Race,Eat,Age,Sex) VALUES (12,1,'gogon',5,'','','1 tahun',1)

10/12/20 14:59:42 - petShop
>Message: Data truncated for column 'age' at row 1
>Dump: INSERT INTO Mst_Relation_Animal (Relation_ID,Seq,Animal_Name,Animal_ID,Race,Eat,Age,Sex) VALUES (12,1,'gogon',5,'','','1 tahun',1)

10/12/20 15:02:09 - petShop
>Message: Data truncated for column 'age' at row 1
>Dump: UPDATE Mst_Relation_Animal SET Animal_Name='Wuwuy', Animal_ID=2, Race='', Eat='', Age='5 tahun', Sex=1 WHERE Relation_ID=7 AND Seq=4

10/12/21 15:59:23 - cashier
>Message: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near '1' at line 1
>Dump: select animal from mst_animal where animal_id 1

10/12/22 14:52:28 - cashier
>Message: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'as 'Nawa Hewan' total as Jumlah ,r.relation_id,t.animal_seq,'' f
>Dump: select hold_id, trans_num as 'No.Trans',trans_date as 'Tgl.Trans', relation_name as Customer, '', as 'Nawa Hewan' total as Jumlah ,r.relation_id,t.animal_seq,'' from trs_holded_mst t left join mst_relation r on t.pasien_id = r.relation_id  left join mst_relation_animal a on r.relation_id = a.relation_id and t.animal_seq = a.seq  order by trans_num

10/12/22 14:53:42 - cashier
>Message: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near ';1;)' at line 1
>Dump: select item_id, item_name, barcode, struk_name, avg_price, 0 as paket,selling_price,0 as add_price,current_stock,discount,buying_price,-1 as animal_id from mst_item where ((barcode = '0011') or (item_code = '0011')) union all select s.service_id as item_id, concat(service_name,' ',animal) as item_name, service_code, concat(service_name,' ',animal) as struk_name, 0 as avg_price, 1 as paket  ,price, add_price,0 as current_stock,discount as discount,0 as buying_price,p.animal_id from mst_service s left join mst_service_price p on s.service_id=p.service_id  left join mst_animal a on a.animal_id = p.animal_id where s.service_code = '0011' and p.animal_id in (2;1;)

10/12/22 14:57:02 - cashier
>Message: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near ';1;)' at line 1
>Dump: select item_id, item_name, barcode, struk_name, avg_price, 0 as paket,selling_price,0 as add_price,current_stock,discount,buying_price,-1 as animal_id from mst_item where ((barcode = '0011') or (item_code = '0011')) union all select s.service_id as item_id, concat(service_name,' ',animal) as item_name, service_code, concat(service_name,' ',animal) as struk_name, 0 as avg_price, 1 as paket  ,price, add_price,0 as current_stock,discount as discount,0 as buying_price,p.animal_id from mst_service s left join mst_service_price p on s.service_id=p.service_id  left join mst_animal a on a.animal_id = p.animal_id where s.service_code = '0011' and p.animal_id in (2;1;)

11/01/05 16:07:48 - cashier
>Message: Data too long for column 'v_prefix' at row 1
>Dump: insert into trs_sales_mst (trans_num, trans_type, trans_date, cashier_id, gudang_id, pasien_id, subtotal, profit, disc_mst, disc_val_mst, disc_detail, tax, total, embalase, real_amount, sisa, user_id, shift_id, cash, cara_bayar, card_id, bank, dokter_id,dp, no_resep) values (get_new_sales_num('201101'), 13,cast('2011-01-05 'as date),5,1,NULL,83000,14537,0,0,0,0,83000,0,83000,0,'adm',0,85000,0,'','',NULL,0,'')

11/01/05 16:09:29 - cashier
>Message: Data too long for column 'v_prefix' at row 1
>Dump: insert into trs_sales_mst (trans_num, trans_type, trans_date, cashier_id, gudang_id, pasien_id, subtotal, profit, disc_mst, disc_val_mst, disc_detail, tax, total, embalase, real_amount, sisa, user_id, shift_id, cash, cara_bayar, card_id, bank, dokter_id,dp, no_resep) values (get_new_sales_num('201101'), 13,cast('2011-01-05 'as date),5,1,NULL,83000,14537,0,0,0,0,83000,0,83000,0,'adm',0,85000,0,'','',NULL,0,'')

11/01/30 09:14:31 - petShop
>Message: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'innerj join mst_item i on i.item_id = d.item_id where (i.kategor
>Dump:  select sum(net),sum(embalase),sum(profit),sum(cust),sum(barang),sum(hewan),sum(jasa) from (  select sum(t.total - t.embalase+ ifnull(t.dp,0)) as net, sum(t.disc_val_mst) as embalase, sum(t.profit) as profit, count(*) as cust , sum(d.amount) as barang, 0 as hewan,   0  as jasa from trs_sales_mst t inner join trs_sales_detail d on d.sales_id = t.sales_id innerj join mst_item i on i.item_id = d.item_id where (i.kategori is null or i.kategori =0) and t.trans_type =13 and t.trans_date = cast('2011-01-30 'as date) and t.cara_bayar =0 union all  select sum(t.total - t.embalase+ ifnull(t.dp,0)) as net, sum(t.disc_val_mst) as embalase, sum(t.profit) as profit, count(*) as cust ,0 as barang,  sum(d.amount)  as hewan,   0  as jasa from trs_sales_mst t inner join trs_sales_detail d on d.sales_id = t.sales_id inner join mst_item i on i.item_id = d.item_id where i.kategori=1 and t.trans_type =13 and t.trans_date = cast('2011-01-30 'as date) and t.cara_bayar =0 union all  select sum(t.total - t.embalase+ ifnull(t.dp,0)) as net, sum(t.disc_val_mst) as embalase, sum(t.profit) as profit, count(*) as cust ,0 as barang, 0 as hewan,  sum(d.amount)  as jasa from trs_sales_mst t inner join trs_sales_detail d on d.sales_id = t.sales_id left join mst_item i on i.item_id = d.item_id where d.paket_id is not null and t.trans_type =13 and t.trans_date = cast('2011-01-30 'as date) and t.cara_bayar =0 union all     select -1* sum(t.total - t.embalase+ ifnull(t.dp,0)) as net, -1* sum(t.disc_val_mst) as embalase, -1* sum(t.profit) as profit, count(*)  as cust ,case when d.paket_id is null and ifnull(i.kategori,0)=0 then sum(d.amount) else 0 end as barang, case when d.paket_id is null and ifnull(i.kategori,0)=1 then sum(d.amount) else 0 end as hewan,  case when d.item_id is null and paket_id is not null then sum(d.amount) else 0 end as jasa from trs_sales_mst t inner join trs_sales_detail d on d.sales_id = t.sales_id left join mst_item i on i.item_id = d.item_id where t.trans_type =14 and t.trans_date = cast('2011-01-30 'as date) and t.cara_bayar =0 ) as t1

11/01/30 09:31:55 - petShop
>Message: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near ''adm\' and su.Passwd = password('')' at line 1
>Dump: SELECT SU.User_Id, SU.User_Name, SU.Passwd, SU.Access_Level, SU.Disabled_Date  FROM System_Users SU WHERE SU.User_Id = 'adm\' and su.Passwd = password('')

11/02/06 17:39:52 - cashier
>Message: Unknown column 'i.disabled_date' in 'where clause'
>Dump: select i.item_id, i.item_code as 'Kode', i.barcode as 'Barcode', i.item_name as 'Nama Barang/Jasa', current_stock as 'Stok', (select mst_code from mst_master where mst_id = i.kemasan_id) as Unit, i.selling_price as 'Hrg Jual/Jasa',merk as Merk,0 as paket,-1 as animal_id from mst_item i where i.disabled_date is null  and (lower(item_name) like '%%') or (lower(merk) like '%%') union all  select i.service_id, i.service_code as 'Kode', '' as 'Barcode',  concat(i.service_name,' ',animal) as 'Nama Barang/Jasa', 0 as 'Stok', '' as Unit,  price as 'Hrg Jual/Jasa','' as Merk,1 as paket,s.animal_id from mst_service i inner join mst_service_price s on s.service_id = i.service_id and s.animal_id in (-1) left join mst_animal a on a.animal_id = s.animal_id  where  i.disabled_date is null and service_name like '%%'

11/02/06 20:02:56 - petShop
>Message: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near ';truncate table trs_sales_mst; truncate table trs_retur_mst; tru
>Dump: truncate table trs_shipment_mst;truncate table trs_sales_mst; truncate table trs_retur_mst; truncate table trs_receipt_mst; truncate table trs_payment_mst; truncate table trs_order_mst; truncate table trs_money_trans_mst; truncate table trs_item_use_mst; truncate table trs_holded_mst; truncate table mst_relation_service; truncate table mst_money_balance; truncate table inv_relation_balance; truncate table inv_item_balance; truncate table inv_cashier_balance; update mst_item set current_stock = 0; update mst_relation_service set jumlah = 0, total =0;

11/02/06 20:09:55 - petShop
>Message: XAER_RMFAIL: The command cannot be executed when global transaction is in the  ACTIVE state
>Dump: truncate table trs_shipment_mst

11/02/06 20:10:58 - petShop
>Message: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near ''invisi00\')' at line 1
>Dump: SELECT SU.User_Id, SU.User_Name, SU.Passwd, SU.Access_Level, SU.Disabled_Date  FROM System_Users SU WHERE SU.User_Id = 'adm' and su.Passwd = password('invisi00\')

11/02/06 20:11:02 - petShop
>Message: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near ''invisi00\')' at line 1
>Dump: SELECT SU.User_Id, SU.User_Name, SU.Passwd, SU.Access_Level, SU.Disabled_Date  FROM System_Users SU WHERE SU.User_Id = 'adm' and su.Passwd = password('invisi00\')

11/02/06 20:11:14 - petShop
>Message: XAER_RMFAIL: The command cannot be executed when global transaction is in the  ACTIVE state
>Dump: truncate table trs_shipment_mst

11/02/06 20:16:33 - petShop
>Message: XAER_RMFAIL: The command cannot be executed when global transaction is in the  ACTIVE state
>Dump: truncate table trs_shipment_mst

11/02/06 20:18:02 - petShop
>Message: XAER_RMFAIL: The command cannot be executed when global transaction is in the  ACTIVE state


11/02/06 20:23:51 - petShop
>Message: XAER_RMFAIL: The command cannot be executed when global transaction is in the  ACTIVE state
>Dump: truncate table trs_shipment_mst

11/02/26 09:49:52 - petShop
>Message: FUNCTION t.sales_id does not exist
>Dump:  select sum(net),sum(embalase),sum(profit),sum(cust),sum(barang),sum(hewan),sum(jasa) from (  select sum(t.total - t.embalase+ ifnull(t.dp,0)) as net, sum(t.disc_val_mst) as embalase, sum(t.profit) as profit, count(*) as cust , (select sum(d.amount) from trs_sales_detail d inner join mst_item i on i.item_id = d.item_id where d.sales_id = t.sales_id (i.kategori is null or i.kategori =0)) as barang, 0 as hewan,   0  as jasa from trs_sales_mst t  where t.trans_type =13 and t.trans_date = cast('2011-02-08 'as date) and t.cara_bayar =0 union all  select sum(t.total - t.embalase+ ifnull(t.dp,0)) as net, sum(t.disc_val_mst) as embalase, sum(t.profit) as profit, count(*) as cust ,0 as barang,  sum(d.amount)  as hewan,   0  as jasa from trs_sales_mst t inner join trs_sales_detail d on d.sales_id = t.sales_id inner join mst_item i on i.item_id = d.item_id where i.kategori=1 and t.trans_type =13 and t.trans_date = cast('2011-02-08 'as date) and t.cara_bayar =0 union all  select sum(t.total - t.embalase+ ifnull(t.dp,0)) as net, sum(t.disc_val_mst) as embalase, sum(t.profit) as profit, count(*) as cust ,0 as barang, 0 as hewan,  sum(d.amount)  as jasa from trs_sales_mst t inner join trs_sales_detail d on d.sales_id = t.sales_id left join mst_item i on i.item_id = d.item_id where d.paket_id is not null and t.trans_type =13 and t.trans_date = cast('2011-02-08 'as date) and t.cara_bayar =0 union all     select -1* sum(t.total - t.embalase+ ifnull(t.dp,0)) as net, -1* sum(t.disc_val_mst) as embalase, -1* sum(t.profit) as profit, count(*)  as cust ,case when d.paket_id is null and ifnull(i.kategori,0)=0 then sum(d.amount) else 0 end as barang, case when d.paket_id is null and ifnull(i.kategori,0)=1 then sum(d.amount) else 0 end as hewan,  case when d.item_id is null and paket_id is not null then sum(d.amount) else 0 end as jasa from trs_sales_mst t inner join trs_sales_detail d on d.sales_id = t.sales_id left join mst_item i on i.item_id = d.item_id where t.trans_type =14 and t.trans_date = cast('2011-02-08 'as date) and t.cara_bayar =0 ) as t1

11/02/26 09:59:40 - petShop
>Message: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'select (sum(d.amount) from trs_sales_mst t inner join trs_sales_
>Dump:  select sum(net),sum(embalase),sum(profit),sum(cust),sum(barang),sum(hewan),sum(jasa) from (  select sum(t.total - t.embalase+ ifnull(t.dp,0)) as net, sum(t.disc_val_mst) as embalase, sum(t.profit) as profit, count(*) as cust , (select sum(d.amount) from trs_sales_mst t  inner join trs_sales_detail d on d.sales_id = t.sales_id  inner join mst_item i on i.item_id = d.item_id  where t.trans_type =13 and t.trans_date = cast('2011-02-08 'as date) and t.cara_bayar =0 and (i.kategori is null or i.kategori =0)) as barang, 0 as hewan,   0  as jasa from trs_sales_mst t  where t.trans_type =13 and t.trans_date = cast('2011-02-08 'as date) and t.cara_bayar =0 union all  select sum(t.total - t.embalase+ ifnull(t.dp,0)) as net, sum(t.disc_val_mst) as embalase, sum(t.profit) as profit, count(*) as cust ,0 as barang,  (select sum(d.amount) from trs_sales_mst t inner join trs_sales_detail d on d.sales_id = t.sales_id inner join mst_item i on i.item_id = d.item_id where i.kategori=1 and t.trans_type =13 and t.trans_date = cast('2011-02-08 'as date) and t.cara_bayar =0) as hewan,   0  as jasa from trs_sales_mst t inner join trs_sales_detail d on d.sales_id = t.sales_id inner join mst_item i on i.item_id = d.item_id where i.kategori=1 and t.trans_type =13 and t.trans_date = cast('2011-02-08 'as date) and t.cara_bayar =0 union all  select sum(t.total - t.embalase+ ifnull(t.dp,0)) as net, sum(t.disc_val_mst) as embalase, sum(t.profit) as profit, count(*) as cust ,0 as barang, 0 as hewan,  select (sum(d.amount) from trs_sales_mst t inner join trs_sales_detail d on d.sales_id = t.sales_id inner join mst_item i on i.item_id = d.item_id where i.kategori=1 and t.trans_type =13 and t.trans_date = cast('2011-02-08 'as date) and t.cara_bayar =0)  as jasa from trs_sales_mst t inner join trs_sales_detail d on d.sales_id = t.sales_id left join mst_item i on i.item_id = d.item_id where d.paket_id is not null and t.trans_type =13 and t.trans_date = cast('2011-02-08 'as date) and t.cara_bayar =0 union all     select -1* sum(t.total - t.embalase+ ifnull(t.dp,0)) as net, -1* sum(t.disc_val_mst) as embalase, -1* sum(t.profit) as profit, count(*)  as cust ,case when d.paket_id is null and ifnull(i.kategori,0)=0 then sum(d.amount) else 0 end as barang, case when d.paket_id is null and ifnull(i.kategori,0)=1 then sum(d.amount) else 0 end as hewan,  case when d.item_id is null and paket_id is not null then sum(d.amount) else 0 end as jasa from trs_sales_mst t inner join trs_sales_detail d on d.sales_id = t.sales_id left join mst_item i on i.item_id = d.item_id where t.trans_type =14 and t.trans_date = cast('2011-02-08 'as date) and t.cara_bayar =0 ) as t1

11/02/26 10:02:13 - petShop
>Message: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'select (sum(d.amount) from trs_sales_mst t inner join trs_sales_
>Dump:  select sum(net),sum(embalase),sum(profit),sum(cust),sum(barang),sum(hewan),sum(jasa) from (  select sum(t.total - t.embalase+ ifnull(t.dp,0)) as net, sum(t.disc_val_mst) as embalase, sum(t.profit) as profit, count(*) as cust , (select sum(d.amount) from trs_sales_mst t  inner join trs_sales_detail d on d.sales_id = t.sales_id  inner join mst_item i on i.item_id = d.item_id  where t.trans_type =13 and t.trans_date = cast('2011-02-08 'as date) and t.cara_bayar =0 and (i.kategori is null or i.kategori =0)) as barang, 0 as hewan,   0  as jasa from trs_sales_mst t  where t.trans_type =13 and t.trans_date = cast('2011-02-08 'as date) and t.cara_bayar =0 union all  select sum(t.total - t.embalase+ ifnull(t.dp,0)) as net, sum(t.disc_val_mst) as embalase, sum(t.profit) as profit, count(*) as cust ,0 as barang,  (select sum(d.amount) from trs_sales_mst t inner join trs_sales_detail d on d.sales_id = t.sales_id inner join mst_item i on i.item_id = d.item_id where i.kategori=1 and t.trans_type =13 and t.trans_date = cast('2011-02-08 'as date) and t.cara_bayar =0) as hewan,   0  as jasa from trs_sales_mst t where t.trans_type =13 and t.trans_date = cast('2011-02-08 'as date) and t.cara_bayar =0 union all  select sum(t.total - t.embalase+ ifnull(t.dp,0)) as net, sum(t.disc_val_mst) as embalase, sum(t.profit) as profit, count(*) as cust ,0 as barang, 0 as hewan,  select (sum(d.amount) from trs_sales_mst t inner join trs_sales_detail d on d.sales_id = t.sales_id inner join mst_item i on i.item_id = d.item_id where i.kategori=1 and t.trans_type =13 and t.trans_date = cast('2011-02-08 'as date) and t.cara_bayar =0)  as jasa from trs_sales_mst t  t.trans_type =13 and t.trans_date = cast('2011-02-08 'as date) and t.cara_bayar =0 union all     select -1* sum(t.total - t.embalase+ ifnull(t.dp,0)) as net, -1* sum(t.disc_val_mst) as embalase, -1* sum(t.profit) as profit, count(*)  as cust ,case when d.paket_id is null and ifnull(i.kategori,0)=0 then sum(d.amount) else 0 end as barang, case when d.paket_id is null and ifnull(i.kategori,0)=1 then sum(d.amount) else 0 end as hewan,  case when d.item_id is null and paket_id is not null then sum(d.amount) else 0 end as jasa from trs_sales_mst t inner join trs_sales_detail d on d.sales_id = t.sales_id left join mst_item i on i.item_id = d.item_id where t.trans_type =14 and t.trans_date = cast('2011-02-08 'as date) and t.cara_bayar =0 ) as t1

11/02/26 10:03:13 - petShop
>Message: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 't.trans_type =13 and t.trans_date = cast('2011-02-08 'as date) a
>Dump:  select sum(net),sum(embalase),sum(profit),sum(cust),sum(barang),sum(hewan),sum(jasa) from (  select sum(t.total - t.embalase+ ifnull(t.dp,0)) as net, sum(t.disc_val_mst) as embalase, sum(t.profit) as profit, count(*) as cust , (select sum(d.amount) from trs_sales_mst t  inner join trs_sales_detail d on d.sales_id = t.sales_id  inner join mst_item i on i.item_id = d.item_id  where t.trans_type =13 and t.trans_date = cast('2011-02-08 'as date) and t.cara_bayar =0 and (i.kategori is null or i.kategori =0)) as barang, 0 as hewan,   0  as jasa from trs_sales_mst t  where t.trans_type =13 and t.trans_date = cast('2011-02-08 'as date) and t.cara_bayar =0 union all  select sum(t.total - t.embalase+ ifnull(t.dp,0)) as net, sum(t.disc_val_mst) as embalase, sum(t.profit) as profit, count(*) as cust ,0 as barang,  (select sum(d.amount) from trs_sales_mst t inner join trs_sales_detail d on d.sales_id = t.sales_id inner join mst_item i on i.item_id = d.item_id where i.kategori=1 and t.trans_type =13 and t.trans_date = cast('2011-02-08 'as date) and t.cara_bayar =0) as hewan,   0  as jasa from trs_sales_mst t where t.trans_type =13 and t.trans_date = cast('2011-02-08 'as date) and t.cara_bayar =0 union all  select sum(t.total - t.embalase+ ifnull(t.dp,0)) as net, sum(t.disc_val_mst) as embalase, sum(t.profit) as profit, count(*) as cust ,0 as barang, 0 as hewan,   ( select sum(d.amount) from trs_sales_mst t inner join trs_sales_detail d on d.sales_id = t.sales_id inner join mst_item i on i.item_id = d.item_id where i.kategori=1 and t.trans_type =13 and t.trans_date = cast('2011-02-08 'as date) and t.cara_bayar =0)  as jasa from trs_sales_mst t  t.trans_type =13 and t.trans_date = cast('2011-02-08 'as date) and t.cara_bayar =0 union all     select -1* sum(t.total - t.embalase+ ifnull(t.dp,0)) as net, -1* sum(t.disc_val_mst) as embalase, -1* sum(t.profit) as profit, count(*)  as cust ,case when d.paket_id is null and ifnull(i.kategori,0)=0 then sum(d.amount) else 0 end as barang, case when d.paket_id is null and ifnull(i.kategori,0)=1 then sum(d.amount) else 0 end as hewan,  case when d.item_id is null and paket_id is not null then sum(d.amount) else 0 end as jasa from trs_sales_mst t inner join trs_sales_detail d on d.sales_id = t.sales_id left join mst_item i on i.item_id = d.item_id where t.trans_type =14 and t.trans_date = cast('2011-02-08 'as date) and t.cara_bayar =0 ) as t1

11/02/26 10:42:12 - petShop
>Message: Unknown column 'disc_detail' in 'field list'
>Dump: select ifnull(sum(disc_detail+disc_mst),0) from trs_item_use_mst t  where  t.trans_date >= cast('2011-02-01 'as date) and t.trans_date <=cast('2011-02-26 'as date)

12/08/26 16:31:33 - petShop
>Message: Table 'petshop.mst_company' doesn't exist
>Dump: select company_name, address, telp1, telp2, fax, city, branch, info, user_id, serial_number,current_branch from mst_company

12/08/26 16:34:03 - petShop
>Message: Table 'petshop.mst_company' doesn't exist
>Dump: select company_name, address, telp1, telp2, fax, city, branch, info, user_id, serial_number,current_branch from mst_company

12/08/26 16:35:53 - petShop
>Message: Table 'petshop.mst_company' doesn't exist
>Dump: select company_name, address, telp1, telp2, fax, city, branch, info, user_id, serial_number,current_branch from mst_company

13/09/20 15:14:56 - petShop
>Message: Table 'petshop.vie_report_sales' doesn't exist
>Dump: select distinct i.item_id, i.item_name, (select relation_name from mst_relation where relation_id = i.vendor_id) as spl, (select mst_name from mst_master where mst_id = i.produsen_id) as produsen, ifnull(sum(t.quantity),0) as sum_qty from point_maping p, mst_item i, vie_report_sales t where i.item_id = t.item_id and i.specification = p.code_id  and p.root_id =1 and t.trans_date >= cast('2013-09-20 'as date) and t.trans_date <=cast('2013-09-20 'as date) group by i.item_id  order by sum_qty desc, i.item_name

13/09/20 16:21:58 - petShop
>Message: Table 'petshop.mst_item_conversion' doesn't exist
>Dump: select mst_code from mst_item_conversion c, mst_master u where c.unit_id = u.mst_id and c.conversion = 1 and c.item_id = 486

13/09/23 14:53:25 - petShop
>Message: Table 'petshop.mst_item_conversion' doesn't exist
>Dump: select mst_code from mst_item_conversion c, mst_master u where c.unit_id = u.mst_id and c.conversion = 1 and c.item_id = 486

14/01/18 14:02:39 - petShop
>Message: Unknown column 'nik' in 'field list'
>Dump: select karyawan_id,nik, nama,k.alamat,jabatan,tgl_lahir,tlp1,tlp2,disabled_date,mst_name from mst_karyawan k left join mst_master m on k.jabatan = m.mst_id order by nama

14/01/18 14:17:54 - petShop
>Message: Unknown column 'nik' in 'field list'
>Dump: SELECT MAX(nik) FROM mst_karyawan WHERE  jabatan =0

14/01/18 14:50:37 - petShop
>Message: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near '2013-10-04 'as date),'asfd','asfd')' at line 1
>Dump: insert into mst_karyawan (nik,nama,alamat,jabatan,tgl_lahir,tlp1,tlp2) values ('002','larasa','asdf\',32,cast('2013-10-04 'as date),'asfd','asfd')

14/01/18 14:50:49 - petShop
>Message: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near '2013-10-04 'as date),'asfd','asfd')' at line 1
>Dump: insert into mst_karyawan (nik,nama,alamat,jabatan,tgl_lahir,tlp1,tlp2) values ('002','larasa','asdf\',32,cast('2013-10-04 'as date),'asfd','asfd')

14/01/18 17:42:09 - petShop
>Message: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'a inner join mst_karyawan k on a.karyawan_id = k.karyawan_id  in
>Dump: select a.absen_id,a.karyawan_id,a.tanggal,a.status_absen,a.keterangan,k.nama ,m.mst_namefrom trs_absensi a inner join mst_karyawan k on a.karyawan_id = k.karyawan_id  inner join mst_master m on m.mst_id = a.mst_id  order by k.nama

14/01/18 17:43:04 - petShop
>Message: Table 'petshop.trs_absensi' doesn't exist
>Dump: select a.absen_id,a.karyawan_id,a.tanggal,a.status_absen,a.keterangan,k.nama ,m.mst_name from trs_absensi a inner join mst_karyawan k on a.karyawan_id = k.karyawan_id  inner join mst_master m on m.mst_id = a.mst_id  order by k.nama

14/01/18 17:43:56 - petShop
>Message: Unknown column 'a.mst_id' in 'on clause'
>Dump: select a.absen_id,a.karyawan_id,a.tanggal,a.status_absen,a.keterangan,k.nama ,m.mst_name from trs_absen a inner join mst_karyawan k on a.karyawan_id = k.karyawan_id  inner join mst_master m on m.mst_id = a.mst_id  order by k.nama

14/01/18 17:47:22 - petShop
>Message: Cannot add or update a child row: a foreign key constraint fails (`petshop`.`trs_absen`, CONSTRAINT `fk_absen_karyawan` FOREIGN KEY (`karyawan_id`) REFERENCES `mst_karyawan` (`karyawan_id`) ON DELETE
>Dump: insert into trs_absen(karyawan_id,tanggal, status_absen,keterangan) values (0,cast('2014-01-18 'as date),36,'')

14/01/18 17:47:28 - petShop
>Message: Cannot add or update a child row: a foreign key constraint fails (`petshop`.`trs_absen`, CONSTRAINT `fk_absen_karyawan` FOREIGN KEY (`karyawan_id`) REFERENCES `mst_karyawan` (`karyawan_id`) ON DELETE
>Dump: insert into trs_absen(karyawan_id,tanggal, status_absen,keterangan) values (0,cast('2014-01-18 'as date),36,'')

14/01/18 17:54:26 - petShop
>Message: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'when karyawan_id=2' at line 1
>Dump: select nama from mst_karyawan when karyawan_id=2

14/01/18 18:00:28 - petShop
>Message: Unknown column 'k.status_absen' in 'where clause'
>Dump: select a.absen_id,a.karyawan_id,a.tanggal,a.status_absen,a.keterangan,k.nama ,m.mst_name from trs_absen a inner join mst_karyawan k on a.karyawan_id = k.karyawan_id  inner join mst_master m on m.mst_id = a.status_absen  where  k.status_absen = 37 order by k.nama
