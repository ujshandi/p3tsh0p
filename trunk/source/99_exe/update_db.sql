-- MySQL dump 10.10
--
-- Host: localhost    Database: apotek
-- ------------------------------------------------------
-- Server version	5.0.15-nt

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `mst_company`
--

DROP TABLE IF EXISTS `mst_company`;
CREATE TABLE `mst_company` (
  `Company_Name` varchar(50) default NULL,
  `Address` varchar(50) default NULL,
  `Telp1` varchar(50) default NULL,
  `Telp2` varchar(50) default NULL,
  `Fax` varchar(50) default NULL,
  `City` varchar(50) default NULL,
  `Branch` varchar(50) default NULL,
  `Info` varchar(500) default NULL,
  `post_code` varchar(15) default NULL,
  `npwp` varchar(50) default NULL,
  `user_id` varchar(50) default NULL,
  `serial_number` varchar(255) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `mst_company`
--


/*!40000 ALTER TABLE `mst_company` DISABLE KEYS */;
LOCK TABLES `mst_company` WRITE;
INSERT INTO `mst_company` VALUES ('Raja March','Jl. Jendral Sudirman No. 186 A','0265-774830 ','081221409234','','Ciamis','Ciamis','Swalayan','','','Rd. Irwan Herlambang','768E7BDA-3D03AC53-6CF568BA');
UNLOCK TABLES;
/*!40000 ALTER TABLE `mst_company` ENABLE KEYS */;

--
-- Table structure for table `system_menu`
--

DROP TABLE IF EXISTS `system_menu`;
CREATE TABLE `system_menu` (
  `menu_id` int(4) NOT NULL,
  `menu_group` varchar(50) default NULL,
  `menu_name` varchar(50) NOT NULL,
  `form_name` varchar(50) NOT NULL,
  `form_type` smallint(6) NOT NULL,
  `submenu_name` varchar(50) default NULL,
  `image_index` int(11) default NULL,
  `shortcut` varchar(10) default NULL,
  `hide` int(2) default '0',
  `dept_id` int(1) default NULL,
  `menu_name_eng` varchar(50) default NULL,
  `image_default` varchar(20) default NULL,
  `image_sort` varchar(20) default NULL,
  `image_active` varchar(20) default NULL,
  `description` varchar(20) default NULL,
  PRIMARY KEY  (`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `system_menu`
--


/*!40000 ALTER TABLE `system_menu` DISABLE KEYS */;
LOCK TABLES `system_menu` WRITE;
INSERT INTO `system_menu` VALUES (101,NULL,'Manajemen User','frmKelolaUser',3,NULL,NULL,NULL,0,0,NULL,'user',NULL,NULL,NULL),(102,NULL,'Jenis Barang','frmMstCode',3,NULL,NULL,NULL,0,0,NULL,'sejarah',NULL,NULL,NULL),(201,'Setting','Gudang','frmReportSimple',0,NULL,NULL,NULL,-1,0,NULL,'home',NULL,NULL,NULL),(202,'Setting','Rak/Penyimpanan','frmMyPrintPreview',0,NULL,NULL,NULL,0,0,NULL,'aset',NULL,NULL,NULL),(203,'Setting','Kasir','frmReportSimple',0,NULL,NULL,NULL,0,0,NULL,'cashier',NULL,NULL,NULL),(204,'Setting','Shift Kerja','frmReportSimple',0,NULL,NULL,NULL,0,0,NULL,'shift',NULL,NULL,NULL),(205,'Item','Satuan Obat','frmMstUnit',0,NULL,NULL,NULL,0,0,NULL,'percent',NULL,NULL,NULL),(206,'Item','Produsen','frmReportSimple',0,NULL,NULL,NULL,0,0,NULL,'partner',NULL,NULL,NULL),(207,'Item','Kemasan','frmReportSimple',0,NULL,NULL,NULL,0,0,NULL,'bottle',NULL,NULL,NULL),(210,'Item','Daftar Obat','frmMstItemList',0,NULL,NULL,NULL,0,0,NULL,'capsul',NULL,NULL,NULL),(211,'Item','Daftar Racikan','frmReportSimple',0,NULL,NULL,NULL,0,0,NULL,'gelas',NULL,NULL,NULL),(212,'Item','Print Barcode','frmBarcodeList',0,NULL,NULL,NULL,-1,0,NULL,'barcode',NULL,NULL,NULL),(213,'Item','Klas Produk','frmMyPrintPreview',0,NULL,NULL,NULL,-1,0,NULL,'percent',NULL,NULL,NULL),(220,'Relasi','Daftar Supplier','frmReportSimple',0,NULL,NULL,NULL,-1,0,NULL,'sdm',NULL,NULL,NULL),(221,'Relasi','Daftar Pasien','frmReportSimple',0,NULL,NULL,NULL,0,0,NULL,'sdm',NULL,NULL,NULL),(222,'Relasi','Daftar Dokter','frmReportSimple',0,NULL,NULL,NULL,0,0,NULL,'doctor',NULL,NULL,NULL),(223,'Relasi','Daftar Member','frmReportSimple',0,NULL,NULL,NULL,-1,0,NULL,'sdm',NULL,NULL,NULL),(300,'Order','Rekap Purchase Order','frmTrsPurchaseOrderList',1,NULL,NULL,NULL,-1,0,NULL,'transaction',NULL,NULL,NULL),(301,'Order','Rekap Penerimaan','frmTrsReceiptList',1,NULL,NULL,NULL,-1,0,NULL,'transaction',NULL,NULL,NULL),(302,'Order','Rekap Retur Pembelian','frmTrsReceiptList',1,NULL,NULL,NULL,-1,0,NULL,'transaction',NULL,NULL,NULL),(321,'Inventory','Rekap Input Stok','frmTrsItemShipmentList',1,NULL,NULL,NULL,-1,0,NULL,'transaction',NULL,NULL,NULL),(322,'Inventory','Rekap Mutasi','frmTrsReceiptList',1,NULL,NULL,NULL,-1,0,NULL,'transaction',NULL,NULL,NULL),(323,'Inventory','Rekap Penyesuaian Stok','frmTrsItemShipmentList',1,NULL,NULL,NULL,0,0,NULL,'transaction',NULL,NULL,NULL),(330,'Sales','Rekap Penjualan','frmTrsSales',1,NULL,NULL,NULL,0,0,NULL,'transaction',NULL,NULL,NULL),(331,'Sales','Point of Sales','frmTrsSales',1,NULL,NULL,NULL,0,1,NULL,'cashier','',NULL,NULL),(400,'Finance','Rekap Pembayaran','frmReportSimple',1,NULL,NULL,NULL,-1,0,NULL,'transaction',NULL,NULL,NULL),(401,'Finance','Pemasukan/Pengeluaran Dana','frmReportSimple',1,NULL,NULL,NULL,-1,0,NULL,'transaction',NULL,NULL,NULL),(501,'Report','Laporan Pejualan 1','frmReportSimple',2,NULL,NULL,NULL,0,0,NULL,'attachment',NULL,NULL,NULL),(502,'Report','Laporan Penjualan 2','frmReportSimple',2,NULL,NULL,NULL,0,0,NULL,'attachment',NULL,NULL,NULL),(503,'Report','Laporan Item Movement','frmReportSimple',2,NULL,NULL,NULL,0,0,NULL,'attachment',NULL,NULL,NULL),(504,'Report','Laporan Pembelian','frmReportSimple',2,NULL,NULL,NULL,-1,0,NULL,'attachment',NULL,NULL,NULL),(510,'Report','Laporan Stok','frmReportSimple',2,NULL,NULL,NULL,0,0,NULL,'attachment',NULL,NULL,NULL),(520,'Report','Rekap Utang Dagang','frmReportSimple',2,NULL,NULL,NULL,-1,0,NULL,'attachment',NULL,NULL,NULL),(530,'Report','Laporan Laba/Rugi','frmReportSimple',2,NULL,NULL,NULL,-1,0,NULL,'attachment',NULL,NULL,NULL),(1001,NULL,'About','frmAbout',99,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL),(1002,NULL,'Preview','frmMyPrintPreview',99,NULL,NULL,NULL,0,0,NULL,NULL,NULL,NULL,NULL);
UNLOCK TABLES;
/*!40000 ALTER TABLE `system_menu` ENABLE KEYS */;

--
-- Dumping routines for database 'apotek'
--
DELIMITER ;;
/*!50003 DROP FUNCTION IF EXISTS `get_new_sales_num` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE FUNCTION `get_new_sales_num`(v_prefix VARCHAR(5)) RETURNS varchar(20)
BEGIN
  DECLARE last_number, last_code, new_code, tmp varchar(20); 
  SET tmp = CONCAT(v_prefix,'00000');
  
  SELECT ifnull(MAX(trans_num),'00000') INTO last_number FROM trs_sales_mst  WHERE trans_num  LIKE CONCAT(v_prefix, '%');
  SELECT RIGHT(last_number, 5) INTO last_code;
  SET last_code = last_code + 1;
  SELECT INSERT('00000', 6- length(last_code), length(last_code), last_code) INTO new_code;
    
  SET new_code = CONCAT(v_prefix,new_code);
  RETURN new_code;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP FUNCTION IF EXISTS `get_stock_akhir` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE FUNCTION `get_stock_akhir`(v_item_id int, v_date date) RETURNS double
BEGIN
  DECLARE v_return DOUBLE;
  select ifnull(sum(balance),0) into v_return from inv_item_balance b1 
  where balance_date = (
     select max(b2.balance_date) from inv_item_balance b2 
     where b2.balance_date <= v_date 
     and b2.storage_id = b1.storage_id
     and b2.item_id = v_item_id)
  and item_id = v_item_id;
  
RETURN v_return;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP FUNCTION IF EXISTS `get_stock_akhir_gudang` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE FUNCTION `get_stock_akhir_gudang`(v_item_id int, v_gudang_id int, v_date date) RETURNS double
BEGIN
  DECLARE v_return DOUBLE;
  select ifnull(sum(balance),0) into v_return from inv_item_balance b1 
  where balance_date = (
     select max(b2.balance_date) from inv_item_balance b2 
     where b2.balance_date <= v_date 
     and b2.storage_id = v_gudang_id
     and b2.item_id = v_item_id)
  and b1.item_id = v_item_id and b1.storage_id = v_gudang_id;
  
  RETURN v_return;
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `patch_saldo` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE PROCEDURE `patch_saldo`()
BEGIN
  declare done, v_item_id, gudang_asal, gudang_tujuan int default 0;
  declare tgl date;
  declare v_curr_stock, v_curr_stock2, qty double default 0;
 
  declare get_item cursor for
    select i.item_id, i.current_stock, get_stock_akhir(item_id, curdate()) as stok
    from mst_item i
    having i.current_stock <> stok;
  declare penjualan cursor for
    select d.quantity, t.trans_date, t.gudang_id from trs_sales_detail d, trs_sales_mst t
    where d.sales_id = t.sales_id and d.item_id = v_item_id
    order by t.trans_date, d.item_id;
  declare pembelian cursor for
    select d.quantity + qty_bonus, t.trans_date, t.gudang_id from trs_receipt_detail d, trs_receipt_mst t
    where d.receipt_id = t.receipt_id and d.item_id = v_item_id
    order by t.trans_date, d.item_id;
  declare retur_beli cursor for
    select d.quantity, t.trans_date, t.gudang_id from trs_retur_detail d, trs_retur_mst t
    where d.retur_id = t.retur_id and d.item_id = v_item_id
    order by t.trans_date, d.item_id;
  declare mutasi cursor for
    select d.quantity, t.trans_date, t.gudang_asal, t.gudang_tujuan from trs_shipment_detail d, trs_shipment_detail t
    where d.ship_id = t.ship_id and d.item_id = v_item_id
    order by t.trans_date, d.item_id;
  declare opname cursor for
    select d.quantity, t.trans_date, t.gudang_asal from trs_shipment_detail d, trs_shipment_detail t
    where d.ship_id = t.ship_id and d.item_id = v_item_id
    order by t.trans_date, d.item_id;
  delete from inv_item_balance;
  open get_item;
  REPEAT
    FETCH get_item INTO v_item_id, v_curr_stock, v_curr_stock2;
    open penjualan;
    REPEAT
      FETCH penjualan INTO qty, tgl, gudang_asal;
      call save_to_item_balance(gudang_asal, v_item_id, tgl, qty, 'C');
    UNTIL gudang_asal = 0 END REPEAT;
    close penjualan;
    open pembelian;
    REPEAT
      FETCH pembelian INTO qty, tgl, gudang_asal;
      call save_to_item_balance(gudang_asal, v_item_id, tgl, qty, 'D');
    UNTIL gudang_asal = 0 END REPEAT;
    close pembelian;
    open retur_beli;
    REPEAT
      FETCH retur_beli INTO qty, tgl, gudang_asal;
      call save_to_item_balance(gudang_asal, v_item_id, tgl, qty, 'C');
    UNTIL gudang_asal = 0 END REPEAT;
    close retur_beli;
    open mutasi;
    REPEAT
      FETCH mutasi INTO qty, tgl, gudang_asal, gudang_tujuan;
      call save_to_item_balance(gudang_asal, v_item_id, tgl, qty, 'C');
      call save_to_item_balance(gudang_tujuan, v_item_id, tgl, qty, 'D');
    UNTIL gudang_asal = 0 END REPEAT;
    close mutasi;
    open opname;
    REPEAT
      FETCH opname INTO qty, tgl, gudang_asal;
      call save_to_item_balance(gudang_asal, v_item_id, tgl, qty, 'D');
      
    UNTIL gudang_asal = 0 END REPEAT;
    close opname;
  UNTIL v_item_id = 0 END REPEAT;
  CLOSE get_item;
  
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `save_to_cashier_balance` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE PROCEDURE `save_to_cashier_balance`(
  p_cashier_id int,
  p_jenis_bayar int,
  p_shift_id int,
  p_sales double,  
  p_disc double, 
  p_retur double, 
  p_embalase double, 
  p_dbcr char(1),
  p_user varchar(20)
)
BEGIN
  DECLARE db_sales_value, cr_sales_value, db_disc_value, cr_disc_value, db_retur_value, cr_retur_value, cr_embalase, db_embalase double default 0;
  DECLARE v_sales_value, v_disc_value, v_retur_value, v_embalase double default 0;
  
  declare is_exist_balance cursor for
    select  cashier_balance_id
    from    inv_cashier_balance
    where   cashier_id = p_cashier_id
    and     shift_id = p_shift_id
    and     jenis_bayar = p_jenis_bayar
    and     user_id = p_user
    and closed is null and balance_date = curdate();
  declare get_latest_stock cursor for
    select sales_value, disc_value, retur_value, embalase from inv_cashier_balance 
    where cashier_id = p_cashier_id
    and shift_id = p_shift_id
    and jenis_bayar = p_jenis_bayar
    and user_id = p_user
    and closed is null and balance_date = 
      (select max(balance_date) from inv_cashier_balance 
      where balance_date <= curdate() and closed is null 
      and cashier_id = p_cashier_id
      and shift_id = p_shift_id
      and jenis_bayar = p_jenis_bayar
      and user_id = p_user);
 
  if (p_dbcr = 'D') then
    set db_sales_value = p_sales;
    set db_disc_value = p_disc;
    set db_retur_value = p_retur;
    set db_embalase = p_embalase;
  elseif (p_dbcr = 'C') then
    set cr_sales_value = p_sales;
    set cr_disc_value = p_disc;
    set cr_retur_value = p_retur;
    set cr_embalase = p_embalase;
  end if;
  open is_exist_balance;
    set @rows = found_rows();
    if @rows > 0 then
      update inv_cashier_balance set 
        sales_value = sales_value + (db_sales_value - cr_sales_value),
        disc_value = disc_value + (db_disc_value - cr_disc_value),
        embalase = embalase + (db_embalase - cr_embalase),
        retur_value = retur_value + (db_retur_value - cr_retur_value)
      where balance_date = curdate() 
      and cashier_id = p_cashier_id
      and shift_id = p_shift_id
      and jenis_bayar = p_jenis_bayar
      and closed is null and user_id = p_user;
    else 
      open get_latest_stock;
        set @rows = found_rows(); 
        if @rows>0 then
	  fetch get_latest_stock into v_sales_value, v_disc_value, v_retur_value, v_embalase;
	end if;
      close get_latest_stock;
      insert into inv_cashier_balance (
        cashier_id, balance_date, user_id, shift_id, sales_value, disc_value, embalase, retur_value) 
      values (p_cashier_id, curdate(), p_user, p_shift_id, 
        v_sales_value + (db_sales_value - cr_sales_value),
        v_disc_value + (db_disc_value - cr_disc_value),
        v_embalase + (db_embalase - cr_embalase),
        v_retur_value + (db_retur_value - cr_retur_value));
    end if;
  close is_exist_balance; 
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `save_to_item_balance` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE PROCEDURE `save_to_item_balance`(
  p_storageID int,
  p_itemID int,
  p_date Date,
  p_quantity double, 
  p_dbcr char(1)
)
BEGIN
  DECLARE db_quantity, cr_quantity, lates_balance double default 0;
  declare is_exist_balance cursor for
    select  item_balance_id
    from    inv_item_balance
    where   (balance_date) = (p_date)
    and     item_id = p_itemID
    and     storage_id = p_storageID;
  declare get_latest_stock cursor for
    select balance from inv_item_balance 
    where item_id = p_itemID
    and storage_id = p_storageID
    and balance_date = 
       (select max(balance_date) from inv_item_balance 
       where (balance_date) <= (p_date)
       and item_id = p_itemID
       and storage_id = p_storageID);
  if (p_dbcr = 'D') then
     set  db_quantity = (p_quantity);
  elseif (p_dbcr = 'C') then
     set  cr_quantity = (p_quantity);
  end if;
  open is_exist_balance;
    set @rows = found_rows();
    if @rows > 0 then
	
      update inv_item_balance 
        set balance = balance + (db_quantity - cr_quantity)
        where (balance_date) >= (p_date)
        and item_id = p_itemID
        and storage_id = p_storageID;
    else 
      open get_latest_stock;
        set @rows = found_rows(); 
        if @rows>0 then
	  fetch get_latest_stock into lates_balance;
	end if;
      close get_latest_stock;
      insert into inv_item_balance (item_id, balance_date, balance, storage_id)
      values (p_itemID, p_date, lates_balance + db_quantity - cr_quantity, p_storageID);
      update inv_item_balance 
        set balance = balance + (db_quantity - cr_quantity)
        where (balance_date) > (p_date)
        and item_id = p_itemID
        and storage_id = p_storageID;
      
    end if;
  close is_exist_balance; 
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
/*!50003 DROP PROCEDURE IF EXISTS `save_to_relation_balance` */;;
/*!50003 SET SESSION SQL_MODE=""*/;;
/*!50003 CREATE PROCEDURE `save_to_relation_balance`(
  p_realtion_id int,
  p_date date,
  p_value double, 
  p_dbcr char(1)
)
BEGIN
  DECLARE db_quantity, cr_quantity, lates_balance double default 0;
  declare is_exist_balance cursor for
    select  relation_balance_id
    from    inv_relation_balance
    where   (balance_date) = (p_date)
    and     relation_id = p_realtion_id;
  declare get_latest_stock cursor for
    select balance from inv_relation_balance 
    where relation_id = p_realtion_id
    and balance_date = 
       (select max(balance_date) from inv_relation_balance 
       where (balance_date) <= (p_date)
       and relation_id = p_realtion_id);
  if (p_dbcr = 'D') then
     set  db_quantity = (p_value);
  elseif (p_dbcr = 'C') then
     set  cr_quantity = (p_value);
  end if;
  open is_exist_balance;
    set @rows = found_rows();
    if @rows > 0 then
      update inv_relation_balance 
        set balance = balance + (db_quantity - cr_quantity)
        where (balance_date) >= (p_date)
        and relation_id = p_realtion_id;
    else 
      open get_latest_stock;
        set @rows = found_rows(); 
        if @rows>0 then
	  fetch get_latest_stock into lates_balance;
	end if;
      close get_latest_stock;
      insert into inv_relation_balance (relation_id, balance_date, balance)
      values (p_realtion_id, p_date, lates_balance + db_quantity - cr_quantity);
      update inv_relation_balance 
        set balance = balance + (db_quantity - cr_quantity)
        where (balance_date) > (p_date)
        and relation_id = p_realtion_id;
      
    end if;
  close is_exist_balance; 
END */;;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE*/;;
DELIMITER ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

