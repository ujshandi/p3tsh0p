unit AutoStockLine;

interface

uses
  Classes, Controls, SysUtils, Subroutines;

type

{ cut from here ---------------------------------------------- 
  TMstCode_Arr = class(_MstCode_Arr) end;
  TMstCode = class(_MstCode) end;
  TMstMerk_Arr = class(_MstMerk_Arr) end;
  TMstMerk = class(_MstMerk) end;
  TPointMaping_Arr = class(_PointMaping_Arr) end;
  TPointMaping = class(_PointMaping) end;
  TMstMaster_Arr = class(_MstMaster_Arr) end;
  TMstMaster = class(_MstMaster) end;
  TMstAkun_Arr = class(_MstAkun_Arr) end;
  TMstAkun = class(_MstAkun) end;
  TMstItem_Arr = class(_MstItem_Arr) end;
  TMstItem = class(_MstItem) end;
  TMstItemConversion_Arr = class(_MstItemConversion_Arr) end;
  TMstItemConversion = class(_MstItemConversion) end;
  TMstPaket_Arr = class(_MstPaket_Arr) end;
  TMstPaket = class(_MstPaket) end;
  TMstPaketItem_Arr = class(_MstPaketItem_Arr) end;
  TMstPaketItem = class(_MstPaketItem) end;
  TMstItemSetting_Arr = class(_MstItemSetting_Arr) end;
  TMstItemSetting = class(_MstItemSetting) end;
  TMstRelation_Arr = class(_MstRelation_Arr) end;
  TMstRelation = class(_MstRelation) end;
  TMstPasien_Arr = class(_MstPasien_Arr) end;
  TMstPasien = class(_MstPasien) end;
  TMstDokter_Arr = class(_MstDokter_Arr) end;
  TMstDokter = class(_MstDokter) end;
  TInvItemBalance_Arr = class(_InvItemBalance_Arr) end;
  TInvItemBalance = class(_InvItemBalance) end;
  TInvCashierBalance_Arr = class(_InvCashierBalance_Arr) end;
  TInvCashierBalance = class(_InvCashierBalance) end;
  TTrsShipmentMst_Arr = class(_TrsShipmentMst_Arr) end;
  TTrsShipmentMst = class(_TrsShipmentMst) end;
  TTrsShipmentDetail_Arr = class(_TrsShipmentDetail_Arr) end;
  TTrsShipmentDetail = class(_TrsShipmentDetail) end;
  TTrsSalesMst_Arr = class(_TrsSalesMst_Arr) end;
  TTrsSalesMst = class(_TrsSalesMst) end;
  TTrsSalesDetail_Arr = class(_TrsSalesDetail_Arr) end;
  TTrsSalesDetail = class(_TrsSalesDetail) end;
  TTrsOrderMst_Arr = class(_TrsOrderMst_Arr) end;
  TTrsOrderMst = class(_TrsOrderMst) end;
  TTrsOrderDetail_Arr = class(_TrsOrderDetail_Arr) end;
  TTrsOrderDetail = class(_TrsOrderDetail) end;
  TTrsReceiptMst_Arr = class(_TrsReceiptMst_Arr) end;
  TTrsReceiptMst = class(_TrsReceiptMst) end;
  TTrsReceiptDetail_Arr = class(_TrsReceiptDetail_Arr) end;
  TTrsReceiptDetail = class(_TrsReceiptDetail) end;
  TTrsReturMst_Arr = class(_TrsReturMst_Arr) end;
  TTrsReturMst = class(_TrsReturMst) end;
  TTrsReturDetail_Arr = class(_TrsReturDetail_Arr) end;
  TTrsReturDetail = class(_TrsReturDetail) end;
  TTrsPaymentMst_Arr = class(_TrsPaymentMst_Arr) end;
  TTrsPaymentMst = class(_TrsPaymentMst) end;
  TTrsPaymentDetail_Arr = class(_TrsPaymentDetail_Arr) end;
  TTrsPaymentDetail = class(_TrsPaymentDetail) end;
  TTrsPaymentAkun_Arr = class(_TrsPaymentAkun_Arr) end;
  TTrsPaymentAkun = class(_TrsPaymentAkun) end;
  TTrsDebtAdjustment_Arr = class(_TrsDebtAdjustment_Arr) end;
  TTrsDebtAdjustment = class(_TrsDebtAdjustment) end;
  TMstProduk_Arr = class(_MstProduk_Arr) end;
  TMstProduk = class(_MstProduk) end;
  TMstProdukRule_Arr = class(_MstProdukRule_Arr) end;
  TMstProdukRule = class(_MstProdukRule) end;
  TMstProdukItem_Arr = class(_MstProdukItem_Arr) end;
  TMstProdukItem = class(_MstProdukItem) end;
  TMstRakItem_Arr = class(_MstRakItem_Arr) end;
  TMstRakItem = class(_MstRakItem) end;
  TMstServicePrice_Arr = class(_MstServicePrice_Arr) end;
  TMstServicePrice = class(_MstServicePrice) end;
  TMstRelationAnimal_Arr = class(_MstRelationAnimal_Arr) end;
  TMstRelationAnimal = class(_MstRelationAnimal) end;
  cut until here ------------------------------------------- }

  _MstServicePrice_Arr = class;
  _MstServicePrice = class;

  _MstCode_Arr = class;
  _MstCode = class;
  //Table Name: Mst_Code
  //Fields:
  //  0. Code_ID* (integer<sequence)
  //  1. Code_Name (string[0])
  //  2. Parent_ID (integer)
  //  3. Parent_Name (string[0])
  //  4. Level (integer)
  //  5. Urut (integer)
  //  6. Kode (string[0])
  //Properties:
  //  0. CodeID* (integer)
  //  1. CodeName (string)
  //  2. ParentID (integer)
  //  3. ParentName (string)
  //  4. Level (integer)
  //  5. Urut (integer)
  //  6. Kode (string)

  _MstMerk_Arr = class;
  _MstMerk = class;
  //Table Name: Mst_Merk
  //Fields:
  //  0. Merk_ID (integer<sequence)
  //  1. Merk (string[0])
  //Properties:
  //  0. MerkID (integer)
  //  1. Merk (string)

  _PointMaping_Arr = class;
  _PointMaping = class;
  //Table Name: Point_Maping
  //Fields:
  //  0. Code_ID (integer)
  //  1. Root_ID (integer)
  //Properties:
  //  0. CodeID (integer)
  //  1. RootID (integer)

  _MstMaster_Arr = class;
  _MstMaster = class;
  //Table Name: Mst_Master
  //Fields:
  //  0. Mst_ID* (integer<sequence)
  //  1. Mst_Tipe (integer)
  //  2. Mst_Code (string[0])
  //  3. Mst_Name (string[0])
  //  4. Alamat (string[0])
  //  5. phone (string[0])
  //Properties:
  //  0. MstID* (integer)
  //  1. MstTipe (integer)
  //  2. MstCode (string)
  //  3. MstName (string)
  //  4. Alamat (string)
  //  5. phone (string)

  _MstAkun_Arr = class;
  _MstAkun = class;
  //Table Name: Mst_Akun
  //Fields:
  //  0. Akun_ID* (integer<sequence)
  //  1. Tipe (integer)
  //  2. Kode (string[0])
  //  3. Nama (string[0])
  //Properties:
  //  0. AkunID* (integer)
  //  1. Tipe (integer)
  //  2. Kode (string)
  //  3. Nama (string)

  _MstItem_Arr = class;
  _MstItem = class;
  //Table Name: Mst_Item
  //Fields:
  //  0. Item_ID* (integer<sequence)
  //  1. Item_Code (string[0])
  //  2. Barcode (string[0])
  //  3. Item_Name (string[0])
  //  4. Struk_Name (string[0])
  //  5. Merk (string[0])
  //  6. Specification (integer) Reference to: Mst_Code\Code_ID
  //  7. Vendor_ID (integer)
  //  8. Current_Stock (real)
  //  9. Avg_Price (real)
  //  10. Disabled_Date (TDate)
  //  11. Produsen_ID (integer)
  //  12. Kemasan_ID (integer)
  //  13. BKP (integer)
  //  14. Konsinyasi (integer)
  //  15. Dosis (real)
  //  16. Expire_Date (TDate)
  //  17. Kategori (integer)
  //Properties:
  //  0. ItemID* (integer)
  //  1. ItemCode (string)
  //  2. Barcode (string)
  //  3. ItemName (string)
  //  4. StrukName (string)
  //  5. Merk (string)
  //  6. MstCode (_MstCode)
  //  7. VendorID (integer)
  //  8. CurrentStock (real)
  //  9. AvgPrice (real)
  //  10. DisabledDate (TDate)
  //  11. ProdusenID (integer)
  //  12. KemasanID (integer)
  //  13. BKP (integer)
  //  14. Konsinyasi (integer)
  //  15. Dosis (real)
  //  16. ExpireDate (TDate)
  //  17. Kategori (integer)

  _MstItemConversion_Arr = class;
  _MstItemConversion = class;
  //Table Name: Mst_Item_Conversion
  //Fields:
  //  0. Conv_ID* (integer<sequence)
  //  1. Item_ID (integer)
  //  2. Unit_ID (integer) Reference to: Mst_Master\Mst_ID
  //  3. Conversion (real)
  //  4. Purchase_Price (real)
  //  5. Sales_Price (real)
  //  6. Sales_Price2 (real)
  //  7. Sales_Price3 (real)
  //  8. Cost_Price (real)
  //  9. Item_Tax (real)
  //  10. Item_Discount (real)
  //  11. Disc_Tipe (integer)
  //  12. Net_Price (real)
  //Properties:
  //  0. ConvID* (integer)
  //  1. ItemID (integer)
  //  2. MstMaster (_MstMaster)
  //  3. Conversion (real)
  //  4. PurchasePrice (real)
  //  5. SalesPrice (real)
  //  6. SalesPrice2 (real)
  //  7. SalesPrice3 (real)
  //  8. CostPrice (real)
  //  9. ItemTax (real)
  //  10. ItemDiscount (real)
  //  11. DiscTipe (integer)
  //  12. NetPrice (real)

  _MstPaket_Arr = class;
  _MstPaket = class;
  //Table Name: Mst_Paket
  //Fields:
  //  0. Paket_ID* (integer<sequence)
  //  1. Kode (string[0])
  //  2. Barcode (string[0])
  //  3. Nama (string[0])
  //  4. Nama_Struk (string[0])
  //  5. Unit_ID (integer)
  //  6. Harga_Dasar (real)
  //  7. Harga_Jual (real)
  //  8. Gudang_ID (integer)
  //  9. Disabled_Date (TDate)
  //Properties:
  //  0. PaketID* (integer)
  //  1. Kode (string)
  //  2. Barcode (string)
  //  3. Nama (string)
  //  4. NamaStruk (string)
  //  5. UnitID (integer)
  //  6. HargaDasar (real)
  //  7. HargaJual (real)
  //  8. GudangID (integer)
  //  9. DisabledDate (TDate)

  _MstPaketItem_Arr = class;
  _MstPaketItem = class;
  //Table Name: Mst_Paket_Item
  //Fields:
  //  0. Paket_Item_ID* (integer<sequence)
  //  1. Paket_ID (integer)
  //  2. Item_ID (integer)
  //  3. Conv_ID (integer)
  //  4. Qty (real)
  //  5. Conversion (real)
  //  6. Harga (real)
  //  7. Discount (real)
  //  8. Hrg_Dasar (real)
  //Properties:
  //  0. PaketItemID* (integer)
  //  1. PaketID (integer)
  //  2. ItemID (integer)
  //  3. ConvID (integer)
  //  4. Qty (real)
  //  5. Conversion (real)
  //  6. Harga (real)
  //  7. Discount (real)
  //  8. HrgDasar (real)

  _MstItemSetting_Arr = class;
  _MstItemSetting = class;
  //Table Name: Mst_Item_Setting
  //Fields:
  //  0. Sett_ID* (integer<sequence)
  //  1. Jenis_ID (integer)
  //  2. Item_ID (integer)
  //  3. Conv_ID (integer)
  //  4. Batas_Bawah (real)
  //  5. Batas_Atas (real)
  //  6. Nilai (real)
  //  7. Faktor (integer)
  //  8. Aktif (integer)
  //Properties:
  //  0. SettID* (integer)
  //  1. JenisID (integer)
  //  2. ItemID (integer)
  //  3. ConvID (integer)
  //  4. BatasBawah (real)
  //  5. BatasAtas (real)
  //  6. Nilai (real)
  //  7. Faktor (integer)
  //  8. Aktif (integer)

  _MstRelation_Arr = class;
  _MstRelation = class;
  //Table Name: Mst_Relation
  //Fields:
  //  0. Relation_ID* (integer<sequence)
  //  1. Relation_Type (integer)
  //  2. Relation_Code (string[0])
  //  3. Relation_Name (string[0])
  //  4. Address1 (string[0])
  //  5. Address2 (string[0])
  //  6. City (string[0])
  //  7. PostCode (string[0])
  //  8. Phone1 (string[0])
  //  9. Phone2 (string[0])
  //  10. Contact_Person (string[0])
  //  11. Due_Date (integer)
  //  12. Current_Debt (real)
  //  13. Disabled_Date (TDate)
  //  14. Current_Point (real)
  //  15. Fax (string[0])
  //  16. NPWP (string[0])
  //Properties:
  //  0. RelationID* (integer)
  //  1. RelationType (integer)
  //  2. RelationCode (string)
  //  3. RelationName (string)
  //  4. Address1 (string)
  //  5. Address2 (string)
  //  6. City (string)
  //  7. PostCode (string)
  //  8. Phone1 (string)
  //  9. Phone2 (string)
  //  10. ContactPerson (string)
  //  11. DueDate (integer)
  //  12. CurrentDebt (real)
  //  13. DisabledDate (TDate)
  //  14. CurrentPoint (real)
  //  15. Fax (string)
  //  16. NPWP (string)

  _MstPasien_Arr = class;
  _MstPasien = class;
  //Table Name: Mst_Pasien
  //Fields:
  //  0. Pasien_ID* (integer<sequence)
  //  1. Kode (string[0])
  //  2. Nama (string[0])
  //  3. Alamat (string[0])
  //  4. Kota (string[0])
  //  5. Phone (string[0])
  //  6. Sex (integer)
  //  7. Tgl_Lahir (TDate)
  //  8. Card_ID (string[0])
  //Properties:
  //  0. PasienID* (integer)
  //  1. Kode (string)
  //  2. Nama (string)
  //  3. Alamat (string)
  //  4. Kota (string)
  //  5. Phone (string)
  //  6. Sex (integer)
  //  7. TglLahir (TDate)
  //  8. CardID (string)

  _MstDokter_Arr = class;
  _MstDokter = class;
  //Table Name: Mst_Dokter
  //Fields:
  //  0. Dokter_ID* (integer<sequence)
  //  1. Kode (string[0])
  //  2. Nama (string[0])
  //  3. Alamat (string[0])
  //  4. klinik (string[0])
  //  5. Kontak (string[0])
  //  6. Email (string[0])
  //  7. Last_Transfer (TDate)
  //  8. item_id (integer)
  //  9. spesialis (string[0])
  //Properties:
  //  0. DokterID* (integer)
  //  1. Kode (string)
  //  2. Nama (string)
  //  3. Alamat (string)
  //  4. klinik (string)
  //  5. Kontak (string)
  //  6. Email (string)
  //  7. LastTransfer (TDate)
  //  8. itemid (integer)
  //  9. spesialis (string)

  _InvItemBalance_Arr = class;
  _InvItemBalance = class;
  //Table Name: Inv_Item_Balance
  //Fields:
  //  0. Item_Balance_ID* (integer<sequence)
  //  1. Item_ID (integer)
  //  2. Balance_Date (TDate)
  //  3. Storage_ID (integer)
  //  4. Balance (real)
  //Properties:
  //  0. ItemBalanceID* (integer)
  //  1. ItemID (integer)
  //  2. BalanceDate (TDate)
  //  3. StorageID (integer)
  //  4. Balance (real)

  _InvCashierBalance_Arr = class;
  _InvCashierBalance = class;
  //Table Name: Inv_Cashier_Balance
  //Fields:
  //  0. Cashier_Balance_ID* (integer<sequence)
  //  1. Cashier_ID (integer)
  //  2. Shift_ID (integer)
  //  3. User_ID (string[0])
  //  4. Balance_Date (TDate)
  //  5. Balance (real)
  //Properties:
  //  0. CashierBalanceID* (integer)
  //  1. CashierID (integer)
  //  2. ShiftID (integer)
  //  3. UserID (string)
  //  4. BalanceDate (TDate)
  //  5. Balance (real)

  _TrsShipmentMst_Arr = class;
  _TrsShipmentMst = class;
  //Table Name: Trs_Shipment_Mst
  //Fields:
  //  0. Ship_ID (integer<sequence)
  //  1. Tipe (integer)
  //  2. Trans_Num (string[0])
  //  3. Trans_Date (TDate)
  //  4. Gudang_Asal (integer)
  //  5. Gudang_Tujuan (integer)
  //  6. Notes (string[0])
  //  7. User_ID (string[0])
  //Properties:
  //  0. ShipID (integer)
  //  1. Tipe (integer)
  //  2. TransNum (string)
  //  3. TransDate (TDate)
  //  4. GudangAsal (integer)
  //  5. GudangTujuan (integer)
  //  6. Notes (string)
  //  7. UserID (string)

  _TrsShipmentDetail_Arr = class;
  _TrsShipmentDetail = class;
  //Table Name: Trs_Shipment_Detail
  //Fields:
  //  0. Ship_Detail_ID* (integer<sequence)
  //  1. Ship_ID (integer)
  //  2. Item_ID (integer) Reference to: Mst_Item\Item_ID
  //  3. Conv_ID (integer) Reference to: Mst_Item_Conversion\Conv_ID
  //  4. Quantity (real)
  //  5. Price_Sales (real)
  //  6. Price_Purchase (real)
  //  7. Price_Cost (real)
  //  8. Conversion (real)
  //  9. DbCrType (string[0])
  //  10. Hrg_Beli (real)
  //Properties:
  //  0. ShipDetailID* (integer)
  //  1. ShipID (integer)
  //  2. MstItem (_MstItem)
  //  3. MstItemConversion (_MstItemConversion)
  //  4. Quantity (real)
  //  5. PriceSales (real)
  //  6. PricePurchase (real)
  //  7. PriceCost (real)
  //  8. Conversion (real)
  //  9. DbCrType (string)
  //  10. HrgBeli (real)

  _TrsSalesMst_Arr = class;
  _TrsSalesMst = class;
  //Table Name: Trs_Sales_Mst
  //Fields:
  //  0. Sales_ID* (integer<sequence)
  //  1. Trans_Num (string[0])
  //  2. Trans_Type (integer)
  //  3. Trans_Date (TDate)
  //  4. Cashier_ID (integer)
  //  5. Gudang_ID (integer)
  //  6. Subtotal (real)
  //  7. Disc_Mst (real)
  //  8. Disc_Val_Mst (real)
  //  9. Tax (real)
  //  10. Total (real)
  //  11. Cash (real)
  //  12. User_ID (string[0])
  //  13. profit (real)
  //  14. Pasien_ID (integer)
  //  15. Points (integer)
  //  16. Disc_Detail (real)
  //  17. Real_Amount (real)
  //  18. Dokter_ID (integer)
  //  19. No_Resep (string[0])
  //  20. Cara_Bayar (integer)
  //  21. Card_ID (string[0])
  //  22. Bank (string[0])
  //  23. Embalase (real)
  //Properties:
  //  0. SalesID* (integer)
  //  1. TransNum (string)
  //  2. TransType (integer)
  //  3. TransDate (TDate)
  //  4. CashierID (integer)
  //  5. GudangID (integer)
  //  6. Subtotal (real)
  //  7. DiscMst (real)
  //  8. DiscValMst (real)
  //  9. Tax (real)
  //  10. Total (real)
  //  11. Cash (real)
  //  12. UserID (string)
  //  13. profit (real)
  //  14. PasienID (integer)
  //  15. Points (integer)
  //  16. DiscDetail (real)
  //  17. RealAmount (real)
  //  18. DokterID (integer)
  //  19. NoResep (string)
  //  20. CaraBayar (integer)
  //  21. CardID (string)
  //  22. Bank (string)
  //  23. Embalase (real)

  _TrsSalesDetail_Arr = class;
  _TrsSalesDetail = class;
  //Table Name: Trs_Sales_Detail
  //Fields:
  //  0. Sales_Detail_ID* (integer<sequence)
  //  1. Sales_ID (integer)
  //  2. Item_ID (integer) Reference to: Mst_Item\Item_ID
  //  3. Conv_ID (integer) Reference to: Mst_Item_Conversion\Conv_ID
  //  4. Quantity (real)
  //  5. Price (real)
  //  6. Disc (real)
  //  7. Disc_Val (real)
  //  8. Amount (real)
  //  9. Conversion (real)
  //  10. Price_Purchase (real)
  //  11. Amount_Profit (real)
  //  12. Points (integer)
  //  13. Paket_ID (integer)
  //  14. Conv_Bonus_ID (integer)
  //  15. Qty_Bonus (real)
  //  16. Conv_Bonus (real)
  //  17. Hrg_Beli (real)
  //Properties:
  //  0. SalesDetailID* (integer)
  //  1. SalesID (integer)
  //  2. MstItem (_MstItem)
  //  3. MstItemConversion (_MstItemConversion)
  //  4. Quantity (real)
  //  5. Price (real)
  //  6. Disc (real)
  //  7. DiscVal (real)
  //  8. Amount (real)
  //  9. Conversion (real)
  //  10. PricePurchase (real)
  //  11. AmountProfit (real)
  //  12. Points (integer)
  //  13. PaketID (integer)
  //  14. ConvBonusID (integer)
  //  15. QtyBonus (real)
  //  16. ConvBonus (real)
  //  17. HrgBeli (real)

  _TrsOrderMst_Arr = class;
  _TrsOrderMst = class;
  //Table Name: Trs_Order_Mst
  //Fields:
  //  0. Order_ID* (integer<sequence)
  //  1. Trans_Num (string[0])
  //  2. Trans_Type (integer)
  //  3. Trans_Date (TDate)
  //  4. Delivery_Date (TDate)
  //  5. Expr_Date (TDate)
  //  6. Relation_ID (integer) Reference to: Mst_Relation\Relation_ID
  //  7. Subtotal (real)
  //  8. Disc_Detail (real)
  //  9. Disc_Mst (real)
  //  10. Tax (real)
  //  11. Total (real)
  //  12. Notes (string[0])
  //  13. User_ID (string[0])
  //  14. Status_ID (integer)
  //  15. Dpp_Disc2 (integer)
  //  16. Pay_Term (integer)
  //Properties:
  //  0. OrderID* (integer)
  //  1. TransNum (string)
  //  2. TransType (integer)
  //  3. TransDate (TDate)
  //  4. DeliveryDate (TDate)
  //  5. ExprDate (TDate)
  //  6. MstRelation (_MstRelation)
  //  7. Subtotal (real)
  //  8. DiscDetail (real)
  //  9. DiscMst (real)
  //  10. Tax (real)
  //  11. Total (real)
  //  12. Notes (string)
  //  13. UserID (string)
  //  14. StatusID (integer)
  //  15. DppDisc2 (integer)
  //  16. PayTerm (integer)

  _TrsOrderDetail_Arr = class;
  _TrsOrderDetail = class;
  //Table Name: Trs_Order_Detail
  //Fields:
  //  0. Order_Detail_ID* (integer<sequence)
  //  1. Order_ID (integer)
  //  2. Item_ID (integer) Reference to: Mst_Item\Item_ID
  //  3. Conv_ID (integer) Reference to: Mst_Item_Conversion\Conv_ID
  //  4. Quantity (real)
  //  5. Price (real)
  //  6. Disc (real)
  //  7. Amount (real)
  //  8. Conversion (real)
  //  9. Tax (real)
  //  10. Disc_Is_Prc (integer)
  //Properties:
  //  0. OrderDetailID* (integer)
  //  1. OrderID (integer)
  //  2. MstItem (_MstItem)
  //  3. MstItemConversion (_MstItemConversion)
  //  4. Quantity (real)
  //  5. Price (real)
  //  6. Disc (real)
  //  7. Amount (real)
  //  8. Conversion (real)
  //  9. Tax (real)
  //  10. DiscIsPrc (integer)

  _TrsReceiptMst_Arr = class;
  _TrsReceiptMst = class;
  //Table Name: Trs_Receipt_Mst
  //Fields:
  //  0. Receipt_ID* (integer<sequence)
  //  1. Trans_Num (string[0])
  //  2. Tipe (integer)
  //  3. Trans_Date (TDate)
  //  4. Expr_Date (TDate)
  //  5. Relation_ID (integer)
  //  6. Order_ID (integer)
  //  7. Inv_ID (integer)
  //  8. Gudang_ID (integer)
  //  9. Subtotal (real)
  //  10. Disc_Detail (real)
  //  11. Disc_Mst (real)
  //  12. Tax (real)
  //  13. Biaya (real)
  //  14. Materai (real)
  //  15. Total (real)
  //  16. Notes (string[0])
  //  17. User_ID (string[0])
  //  18. Status_ID (integer)
  //  19. Dpp_Disc2 (integer)
  //Properties:
  //  0. ReceiptID* (integer)
  //  1. TransNum (string)
  //  2. Tipe (integer)
  //  3. TransDate (TDate)
  //  4. ExprDate (TDate)
  //  5. RelationID (integer)
  //  6. OrderID (integer)
  //  7. InvID (integer)
  //  8. GudangID (integer)
  //  9. Subtotal (real)
  //  10. DiscDetail (real)
  //  11. DiscMst (real)
  //  12. Tax (real)
  //  13. Biaya (real)
  //  14. Materai (real)
  //  15. Total (real)
  //  16. Notes (string)
  //  17. UserID (string)
  //  18. StatusID (integer)
  //  19. DppDisc2 (integer)

  _TrsReceiptDetail_Arr = class;
  _TrsReceiptDetail = class;
  //Table Name: Trs_Receipt_Detail
  //Fields:
  //  0. Receipt_Detail_ID* (integer<sequence)
  //  1. Receipt_ID (integer)
  //  2. Item_ID (integer)
  //  3. Conv_ID (integer)
  //  4. Conv_Bonus_ID (real)
  //  5. Quantity (real)
  //  6. Qty_Bonus (real)
  //  7. Price (real)
  //  8. Amount (real)
  //  9. Disc1 (real)
  //  10. Disc2 (real)
  //  11. Disc3 (real)
  //  12. Conversion (real)
  //  13. Conv_Bonus (real)
  //  14. Tax (real)
  //  15. Disc1_Is_Prc (integer)
  //  16. Disc2_Is_Prc (integer)
  //  17. Disc3_Is_Prc (integer)
  //Properties:
  //  0. ReceiptDetailID* (integer)
  //  1. ReceiptID (integer)
  //  2. ItemID (integer)
  //  3. ConvID (integer)
  //  4. ConvBonusID (real)
  //  5. Quantity (real)
  //  6. QtyBonus (real)
  //  7. Price (real)
  //  8. Amount (real)
  //  9. Disc1 (real)
  //  10. Disc2 (real)
  //  11. Disc3 (real)
  //  12. Conversion (real)
  //  13. ConvBonus (real)
  //  14. Tax (real)
  //  15. Disc1IsPrc (integer)
  //  16. Disc2IsPrc (integer)
  //  17. Disc3IsPrc (integer)

  _TrsReturMst_Arr = class;
  _TrsReturMst = class;
  //Table Name: Trs_Retur_Mst
  //Fields:
  //  0. Retur_ID* (integer<sequence)
  //  1. Trans_Num (string[0])
  //  2. Tipe (integer)
  //  3. Trans_Date (TDate)
  //  4. Relation_ID (integer)
  //  5. Inv_ID (integer)
  //  6. Gudang_ID (integer)
  //  7. Subtotal (real)
  //  8. Discount (real)
  //  9. Tax (real)
  //  10. Biaya (real)
  //  11. Materai (real)
  //  12. Total (real)
  //  13. Notes (string[0])
  //  14. User_ID (string[0])
  //  15. Status_ID (integer)
  //Properties:
  //  0. ReturID* (integer)
  //  1. TransNum (string)
  //  2. Tipe (integer)
  //  3. TransDate (TDate)
  //  4. RelationID (integer)
  //  5. InvID (integer)
  //  6. GudangID (integer)
  //  7. Subtotal (real)
  //  8. Discount (real)
  //  9. Tax (real)
  //  10. Biaya (real)
  //  11. Materai (real)
  //  12. Total (real)
  //  13. Notes (string)
  //  14. UserID (string)
  //  15. StatusID (integer)

  _TrsReturDetail_Arr = class;
  _TrsReturDetail = class;
  //Table Name: Trs_Retur_Detail
  //Fields:
  //  0. Retur_Detail_ID* (integer<sequence)
  //  1. Retur_ID (integer)
  //  2. Faktur_ID (integer)
  //  3. Item_ID (integer)
  //  4. Conv_ID (integer)
  //  5. Quantity (real)
  //  6. Price (real)
  //  7. Amount (real)
  //  8. Conversion (real)
  //  9. Tax (real)
  //  10. Disc (real)
  //  11. Disc_Is_Prc (integer)
  //Properties:
  //  0. ReturDetailID* (integer)
  //  1. ReturID (integer)
  //  2. FakturID (integer)
  //  3. ItemID (integer)
  //  4. ConvID (integer)
  //  5. Quantity (real)
  //  6. Price (real)
  //  7. Amount (real)
  //  8. Conversion (real)
  //  9. Tax (real)
  //  10. Disc (real)
  //  11. DiscIsPrc (integer)

  _TrsPaymentMst_Arr = class;
  _TrsPaymentMst = class;
  //Table Name: Trs_Payment_Mst
  //Fields:
  //  0. Payment_ID* (integer<sequence)
  //  1. Trans_Num (string[0])
  //  2. Tipe (integer)
  //  3. Trans_Date (TDate)
  //  4. Relation_ID (integer)
  //  5. Inv_ID (integer)
  //  6. Subtotal (real)
  //  7. Discount (real)
  //  8. Biaya (real)
  //  9. Total (real)
  //  10. Notes (string[0])
  //  11. User_ID (string[0])
  //  12. Status_ID (integer)
  //Properties:
  //  0. PaymentID* (integer)
  //  1. TransNum (string)
  //  2. Tipe (integer)
  //  3. TransDate (TDate)
  //  4. RelationID (integer)
  //  5. InvID (integer)
  //  6. Subtotal (real)
  //  7. Discount (real)
  //  8. Biaya (real)
  //  9. Total (real)
  //  10. Notes (string)
  //  11. UserID (string)
  //  12. StatusID (integer)

  _TrsPaymentDetail_Arr = class;
  _TrsPaymentDetail = class;
  //Table Name: Trs_Payment_Detail
  //Fields:
  //  0. Pay_Detail_ID* (integer<sequence)
  //  1. Payment_ID (integer)
  //  2. Jenis_Bayar (integer)
  //  3. Amount (real)
  //  4. Bank (string[0])
  //  5. Dok_Num (string[0])
  //  6. Tgl_Cair (TDate)
  //Properties:
  //  0. PayDetailID* (integer)
  //  1. PaymentID (integer)
  //  2. JenisBayar (integer)
  //  3. Amount (real)
  //  4. Bank (string)
  //  5. DokNum (string)
  //  6. TglCair (TDate)

  _TrsPaymentAkun_Arr = class;
  _TrsPaymentAkun = class;
  //Table Name: Trs_Payment_Akun
  //Fields:
  //  0. Pay_Akun_ID* (integer<sequence)
  //  1. Payment_ID (integer)
  //  2. Akun_ID (integer)
  //  3. Amount (real)
  //Properties:
  //  0. PayAkunID* (integer)
  //  1. PaymentID (integer)
  //  2. AkunID (integer)
  //  3. Amount (real)

  _TrsDebtAdjustment_Arr = class;
  _TrsDebtAdjustment = class;
  //Table Name: Trs_Debt_Adjustment
  //Fields:
  //  0. Adj_ID* (integer<sequence)
  //  1. Trans_Date (TDate)
  //  2. Relation_ID (integer)
  //  3. Amount (real)
  //  4. User_ID (string[0])
  //Properties:
  //  0. AdjID* (integer)
  //  1. TransDate (TDate)
  //  2. RelationID (integer)
  //  3. Amount (real)
  //  4. UserID (string)

  _MstProduk_Arr = class;
  _MstProduk = class;
  //Table Name: Mst_Produk
  //Fields:
  //  0. Produk_ID* (integer<sequence)
  //  1. Jns_Produk (integer)
  //  2. Berlaku (integer)
  //  3. Periode_Awal (TDate)
  //  4. Periode_Akhir (TDate)
  //  5. Faktor (integer)
  //  6. Aktif (integer)
  //Properties:
  //  0. ProdukID* (integer)
  //  1. JnsProduk (integer)
  //  2. Berlaku (integer)
  //  3. PeriodeAwal (TDate)
  //  4. PeriodeAkhir (TDate)
  //  5. Faktor (integer)
  //  6. Aktif (integer)

  _MstProdukRule_Arr = class;
  _MstProdukRule = class;
  //Table Name: Mst_Produk_Rule
  //Fields:
  //  0. Rule_ID* (integer<sequence)
  //  1. Produk_ID (integer)
  //  2. Faktor_ID (integer)
  //  3. Batas_Minimal (real)
  //  4. Nilai (real)
  //  5. Disc_Prc (real)
  //Properties:
  //  0. RuleID* (integer)
  //  1. ProdukID (integer)
  //  2. FaktorID (integer)
  //  3. BatasMinimal (real)
  //  4. Nilai (real)
  //  5. DiscPrc (real)

  _MstProdukItem_Arr = class;
  _MstProdukItem = class;
  //Table Name: Mst_Produk_Item
  //Fields:
  //  0. Prod_Item_ID* (integer<sequence)
  //  1. Rule_ID (integer)
  //  2. Item_ID (integer)
  //Properties:
  //  0. ProdItemID* (integer)
  //  1. RuleID (integer)
  //  2. ItemID (integer)

  _MstRakItem_Arr = class;
  _MstRakItem = class;
  //Table Name: Mst_Rak_Item
  //Fields:
  //  0. Rak_ID (integer)
  //  1. Item_ID (integer)
  //Properties:
  //  0. RakID (integer)
  //  1. ItemID (integer)

  _MstRelationAnimal_Arr = class;
  _MstRelationAnimal = class;

  _MstBranch_Arr = class;
  _MstBranch = class;

  _TrsMoneyTransMst_Arr = class;
  _TrsMoneyTransMst = class;
  _TrsMoneyTransDetail_Arr = class;
  _TrsMoneyTransDetail = class;

  _TrsItemUseDetail_Arr = class;
  _TrsItemUseDetail = class;

  _TrsItemUseMst_Arr = class;
  _TrsItemUseMst = class;


  _MstCode_Arr = class(TObject) {Strong-Container MstCode}
  private
    FOwner: TObject;
  protected
    FMstCode_Arr: array of _MstCode;
    function Get(Index: integer): _MstCode; virtual;
  public
    property Owner: TObject read FOwner;
    constructor Create(AOwner: TObject = nil);
    destructor Destroy; override;
    procedure Clear; virtual;
    function Count: integer;
    property MstCode_Arr[Index: integer]: _MstCode read Get; default;

    function Add(ACodeID: integer; ACodeName: string; AParentID: integer; AParentName: string; ALevel: integer; AUrut: integer; AKode: string): integer; virtual;
    function IndexOf(ACodeID: integer): integer; virtual;
    procedure Delete(Index: integer); virtual;
  end;

  _MstCode = class(TObject) {Strong-Basic MstCode}
  private
    FOwner: TObject;
  protected
    FCodeID: integer; //<sequence
    FCodeName: string; //[0]
    FParentID: integer; //
    FParentName: string; //[0]
    FLevel: integer; //
    FUrut: integer; //
    FKode: string; //[0]
  public
    property Owner: TObject read FOwner;
    constructor Create(AOwner: TObject = nil);
    destructor Destroy; override;
    procedure Reset; virtual;
    procedure InsertOnDB; virtual;
    procedure UpdateOnDB; virtual;
    procedure DeleteOnDB; virtual;
    property CodeID: integer  read FCodeID write FCodeID;
    property CodeName: string  read FCodeName write FCodeName;
    property ParentID: integer  read FParentID write FParentID;
    property ParentName: string  read FParentName write FParentName;
    property Level: integer  read FLevel write FLevel;
    property Urut: integer  read FUrut write FUrut;
    property Kode: string  read FKode write FKode;

    function SelectInDB(ACodeID: integer): boolean; virtual;
    class function ExistInDB(ACodeID: integer): integer; virtual;
  end;

  _MstMerk_Arr = class(TObject) {Strong-Container MstMerk}
  private
    FOwner: TObject;
  protected
    FMstMerk_Arr: array of _MstMerk;
    function Get(Index: integer): _MstMerk; virtual;
  public
    property Owner: TObject read FOwner;
    constructor Create(AOwner: TObject = nil);
    destructor Destroy; override;
    procedure Clear; virtual;
    function Count: integer;
    property MstMerk_Arr[Index: integer]: _MstMerk read Get; default;

    function Add(AMerkID: integer; AMerk: string): integer; virtual;
    procedure Delete(Index: integer); virtual;
  end;

  _MstMerk = class(TObject) {Strong-Basic MstMerk}
  private
    FOwner: TObject;
  protected
    FMerkID: integer; //<sequence
    FMerk: string; //[0]
  public
    property Owner: TObject read FOwner;
    constructor Create(AOwner: TObject = nil);
    destructor Destroy; override;
    procedure Reset; virtual;
    procedure InsertOnDB; virtual;
    procedure UpdateOnDB; virtual;
    procedure DeleteOnDB; virtual;
    property MerkID: integer  read FMerkID write FMerkID;
    property Merk: string  read FMerk write FMerk;
  end;

  _PointMaping_Arr = class(TObject) {Strong-Container PointMaping}
  private
    FOwner: TObject;
  protected
    FPointMaping_Arr: array of _PointMaping;
    function Get(Index: integer): _PointMaping; virtual;
  public
    property Owner: TObject read FOwner;
    constructor Create(AOwner: TObject = nil);
    destructor Destroy; override;
    procedure Clear; virtual;
    function Count: integer;
    property PointMaping_Arr[Index: integer]: _PointMaping read Get; default;

    function Add(ACodeID: integer; ARootID: integer): integer; virtual;
    procedure Delete(Index: integer); virtual;
  end;

  _PointMaping = class(TObject) {Strong-Basic PointMaping}
  private
    FOwner: TObject;
  protected
    FCodeID: integer; //
    FRootID: integer; //
  public
    property Owner: TObject read FOwner;
    constructor Create(AOwner: TObject = nil);
    destructor Destroy; override;
    procedure Reset; virtual;
    procedure InsertOnDB; virtual;
    procedure UpdateOnDB; virtual;
    procedure DeleteOnDB; virtual;
    property CodeID: integer  read FCodeID write FCodeID;
    property RootID: integer  read FRootID write FRootID;
  end;

  _MstMaster_Arr = class(TObject) {Strong-Container MstMaster}
  private
    FOwner: TObject;
  protected
    FMstMaster_Arr: array of _MstMaster;
    function Get(Index: integer): _MstMaster; virtual;
  public
    property Owner: TObject read FOwner;
    constructor Create(AOwner: TObject = nil);
    destructor Destroy; override;
    procedure Clear; virtual;
    function Count: integer;
    property MstMaster_Arr[Index: integer]: _MstMaster read Get; default;

    function Add(AMstID: integer; AMstTipe: integer; AMstCode: string; AMstName: string; AAlamat: string; Aphone: string): integer; virtual;
    function IndexOf(AMstID: integer): integer; virtual;
    procedure Delete(Index: integer); virtual;
  end;

  _MstMaster = class(TObject) {Strong-Basic MstMaster}
  private
    FOwner: TObject;
  protected
    FMstID: integer; //<sequence
    FMstTipe: integer; //
    FMstCode: string; //[0]
    FMstName: string; //[0]
    FAlamat: string; //[0]
    Fphone: string; //[0]
  public
    property Owner: TObject read FOwner;
    constructor Create(AOwner: TObject = nil);
    destructor Destroy; override;
    procedure Reset; virtual;
    procedure InsertOnDB; virtual;
    procedure UpdateOnDB; virtual;
    procedure DeleteOnDB; virtual;
    property MstID: integer  read FMstID write FMstID;
    property MstTipe: integer  read FMstTipe write FMstTipe;
    property MstCode: string  read FMstCode write FMstCode;
    property MstName: string  read FMstName write FMstName;
    property Alamat: string  read FAlamat write FAlamat;
    property phone: string  read Fphone write Fphone;

    function SelectInDB(AMstID: integer): boolean; virtual;
    class function ExistInDB(AMstID: integer): integer; virtual;
  end;

  _MstAkun_Arr = class(TObject) {Strong-Container MstAkun}
  private
    FOwner: TObject;
  protected
    FMstAkun_Arr: array of _MstAkun;
    function Get(Index: integer): _MstAkun; virtual;
  public
    property Owner: TObject read FOwner;
    constructor Create(AOwner: TObject = nil);
    destructor Destroy; override;
    procedure Clear; virtual;
    function Count: integer;
    property MstAkun_Arr[Index: integer]: _MstAkun read Get; default;

    function Add(AAkunID: integer; ATipe: integer; AKode: string; ANama: string): integer; virtual;
    function IndexOf(AAkunID: integer): integer; virtual;
    procedure Delete(Index: integer); virtual;
  end;

  _MstAkun = class(TObject) {Strong-Basic MstAkun}
  private
    FOwner: TObject;
  protected
    FAkunID: integer; //<sequence
    FTipe: integer; //
    FKode: string; //[0]
    FNama: string; //[0]
  public
    property Owner: TObject read FOwner;
    constructor Create(AOwner: TObject = nil);
    destructor Destroy; override;
    procedure Reset; virtual;
    procedure InsertOnDB; virtual;
    procedure UpdateOnDB; virtual;
    procedure DeleteOnDB; virtual;
    property AkunID: integer  read FAkunID write FAkunID;
    property Tipe: integer  read FTipe write FTipe;
    property Kode: string  read FKode write FKode;
    property Nama: string  read FNama write FNama;
  end;

  _MstItem_Arr = class(TObject) {Strong-Container MstItem}
  private
    FOwner: TObject;
  protected
    FMstItem_Arr: array of _MstItem;
    function Get(Index: integer): _MstItem; virtual;
  public
    property Owner: TObject read FOwner;
    constructor Create(AOwner: TObject = nil);
    destructor Destroy; override;
    procedure Clear; virtual;
    function Count: integer;
    property MstItem_Arr[Index: integer]: _MstItem read Get; default;

    function Add(AItemID: integer; AItemCode: string; ABarcode: string; AItemName: string; AStrukName: string; AMerk: string; ASpecification: integer; AVendorID: integer; ACurrentStock: real; AAvgPrice: real; ADisabledDate: TDate; AProdusenID: integer; AKemasanID: integer; ABKP: integer; AKonsinyasi: integer; ADosis: real; AExpireDate: TDate; AKategori: integer): integer; virtual;
    function IndexOf(AItemID: integer): integer; virtual;
    procedure Delete(Index: integer); virtual;
  end;

  _MstItem = class(TObject) {Strong-Basic MstItem}
  private
    FOwner: TObject;
  protected
    FItemID: integer; //<sequence
    FItemCode: string; //[0]
    FBarcode: string; //[0]
    FItemName: string; //[0]
    FStrukName: string; //[0]
    FMerk: string; //[0]
    FMstCode: _MstCode; //Specification: integer
    FVendorID: integer; //
    FCurrentStock: real; //
    FAvgPrice: real; //
    FDisabledDate: TDate; //
    FProdusenID: integer; //
    FKemasanID: integer; //
    FBKP: integer; //
    FKonsinyasi: integer; //
    FDosis: real; //
    FExpireDate: TDate; //
    FKategori: integer; //
   FSellingPrice ,FBuyingPrice ,FAddPrice,FDiscount : double;
  public
    property Owner: TObject read FOwner;
    constructor Create(AOwner: TObject = nil);
    destructor Destroy; override;
    procedure Reset; virtual;
    procedure InsertOnDB; virtual;
    procedure UpdateOnDB; virtual;
    procedure DeleteOnDB; virtual;
    property ItemID: integer  read FItemID write FItemID;
    property ItemCode: string  read FItemCode write FItemCode;
    property Barcode: string  read FBarcode write FBarcode;
    property ItemName: string  read FItemName write FItemName;
    property StrukName: string  read FStrukName write FStrukName;
    property Merk: string  read FMerk write FMerk;
    property MstCode: _MstCode  read FMstCode;
    property VendorID: integer  read FVendorID write FVendorID;
    property CurrentStock: real  read FCurrentStock write FCurrentStock;
    property AvgPrice: real  read FAvgPrice write FAvgPrice;
    property DisabledDate: TDate  read FDisabledDate write FDisabledDate;
    property ProdusenID: integer  read FProdusenID write FProdusenID;
    property KemasanID: integer  read FKemasanID write FKemasanID;
    property BKP: integer  read FBKP write FBKP;
    property Konsinyasi: integer  read FKonsinyasi write FKonsinyasi;
    property Dosis: real  read FDosis write FDosis;
    property ExpireDate: TDate  read FExpireDate write FExpireDate;
    property Kategori: integer  read FKategori write FKategori;
    property SellingPrice : double read FSellingPrice write FSellingPrice;
    property BuyingPrice : Double read FBuyingPrice write FBuyingPrice;
    property AddPrice : Double read FAddPrice write FAddPrice;
    property Discount : double read FDiscount write FDiscount; 
    function SelectInDB(AItemID: integer): boolean; virtual;
    class function ExistInDB(AItemID: integer): integer; virtual;
  end;

  _MstItemConversion_Arr = class(TObject) {Strong-Container MstItemConversion}
  private
    FOwner: TObject;
  protected
    FMstItemConversion_Arr: array of _MstItemConversion;
    function Get(Index: integer): _MstItemConversion; virtual;
  public
    property Owner: TObject read FOwner;
    constructor Create(AOwner: TObject = nil);
    destructor Destroy; override;
    procedure Clear; virtual;
    function Count: integer;
    property MstItemConversion_Arr[Index: integer]: _MstItemConversion read Get; default;

    function Add(AConvID: integer; AItemID: integer; AUnitID: integer; AConversion: real; APurchasePrice: real; ASalesPrice: real; ASalesPrice2: real; ASalesPrice3: real; ACostPrice: real; AItemTax: real; AItemDiscount: real; ADiscTipe: integer; ANetPrice: real): integer; virtual;
    function IndexOf(AConvID: integer): integer; virtual;
    procedure Delete(Index: integer); virtual;
  end;

  _MstItemConversion = class(TObject) {Strong-Basic MstItemConversion}
  private
    FOwner: TObject;
  protected
    FConvID: integer; //<sequence
    FItemID: integer; //
    FMstMaster: _MstMaster; //UnitID: integer
    FConversion: real; //
    FPurchasePrice: real; //
    FSalesPrice: real; //
    FSalesPrice2: real; //
    FSalesPrice3: real; //
    FCostPrice: real; //
    FItemTax: real; //
    FItemDiscount: real; //
    FDiscTipe: integer; //
    FNetPrice: real; //
  public
    property Owner: TObject read FOwner;
    constructor Create(AOwner: TObject = nil);
    destructor Destroy; override;
    procedure Reset; virtual;
    procedure InsertOnDB; virtual;
    procedure UpdateOnDB; virtual;
    procedure DeleteOnDB; virtual;
    property ConvID: integer  read FConvID write FConvID;
    property ItemID: integer  read FItemID write FItemID;
    property MstMaster: _MstMaster  read FMstMaster;
    property Conversion: real  read FConversion write FConversion;
    property PurchasePrice: real  read FPurchasePrice write FPurchasePrice;
    property SalesPrice: real  read FSalesPrice write FSalesPrice;
    property SalesPrice2: real  read FSalesPrice2 write FSalesPrice2;
    property SalesPrice3: real  read FSalesPrice3 write FSalesPrice3;
    property CostPrice: real  read FCostPrice write FCostPrice;
    property ItemTax: real  read FItemTax write FItemTax;
    property ItemDiscount: real  read FItemDiscount write FItemDiscount;
    property DiscTipe: integer  read FDiscTipe write FDiscTipe;
    property NetPrice: real  read FNetPrice write FNetPrice;

    function SelectInDB(AConvID: integer): boolean; virtual;
    class function ExistInDB(AConvID: integer): integer; virtual;
  end;

  _MstPaket_Arr = class(TObject) {Strong-Container MstPaket}
  private
    FOwner: TObject;
  protected
    FMstPaket_Arr: array of _MstPaket;
    function Get(Index: integer): _MstPaket; virtual;
  public
    property Owner: TObject read FOwner;
    constructor Create(AOwner: TObject = nil);
    destructor Destroy; override;
    procedure Clear; virtual;
    function Count: integer;
    property MstPaket_Arr[Index: integer]: _MstPaket read Get; default;

    function Add(APaketID: integer; AKode: string; ABarcode: string; ANama: string; ANamaStruk: string; AUnitID: integer; AHargaDasar: real; AHargaJual: real; AGudangID: integer; ADisabledDate: TDate): integer; virtual;
    function IndexOf(APaketID: integer): integer; virtual;
    procedure Delete(Index: integer); virtual;
  end;

  _MstPaket = class(TObject) {Strong-Basic MstPaket}
  private
    FOwner: TObject;
  protected
    FPaketID: integer; //<sequence
    FKode: string; //[0]
    FBarcode: string; //[0]
    FNama: string; //[0]
    FNamaStruk: string; //[0]
    FUnitID: integer; //
    FHargaDasar: real; //
    FHargaJual: real; //
    FGudangID: integer; //
    FDisabledDate: TDate; //
  public
    property Owner: TObject read FOwner;
    constructor Create(AOwner: TObject = nil);
    destructor Destroy; override;
    procedure Reset; virtual;
    procedure InsertOnDB; virtual;
    procedure UpdateOnDB; virtual;
    procedure DeleteOnDB; virtual;
    property PaketID: integer  read FPaketID write FPaketID;
    property Kode: string  read FKode write FKode;
    property Barcode: string  read FBarcode write FBarcode;
    property Nama: string  read FNama write FNama;
    property NamaStruk: string  read FNamaStruk write FNamaStruk;
    property UnitID: integer  read FUnitID write FUnitID;
    property HargaDasar: real  read FHargaDasar write FHargaDasar;
    property HargaJual: real  read FHargaJual write FHargaJual;
    property GudangID: integer  read FGudangID write FGudangID;
    property DisabledDate: TDate  read FDisabledDate write FDisabledDate;
  end;

  _MstPaketItem_Arr = class(TObject) {Strong-Container MstPaketItem}
  private
    FOwner: TObject;
  protected
    FMstPaketItem_Arr: array of _MstPaketItem;
    function Get(Index: integer): _MstPaketItem; virtual;
  public
    property Owner: TObject read FOwner;
    constructor Create(AOwner: TObject = nil);
    destructor Destroy; override;
    procedure Clear; virtual;
    function Count: integer;
    property MstPaketItem_Arr[Index: integer]: _MstPaketItem read Get; default;

    function Add(APaketItemID: integer; APaketID: integer; AItemID: integer; AConvID: integer; AQty: real; AConversion: real; AHarga: real; ADiscount: real; AHrgDasar: real): integer; virtual;
    function IndexOf(APaketItemID: integer): integer; virtual;
    procedure Delete(Index: integer); virtual;
  end;

  _MstPaketItem = class(TObject) {Strong-Basic MstPaketItem}
  private
    FOwner: TObject;
  protected
    FPaketItemID: integer; //<sequence
    FPaketID: integer; //
    FItemID: integer; //
    FConvID: integer; //
    FQty: real; //
    FConversion: real; //
    FHarga: real; //
    FDiscount: real; //
    FHrgDasar: real; //
  public
    property Owner: TObject read FOwner;
    constructor Create(AOwner: TObject = nil);
    destructor Destroy; override;
    procedure Reset; virtual;
    procedure InsertOnDB; virtual;
    procedure UpdateOnDB; virtual;
    procedure DeleteOnDB; virtual;
    property PaketItemID: integer  read FPaketItemID write FPaketItemID;
    property PaketID: integer  read FPaketID write FPaketID;
    property ItemID: integer  read FItemID write FItemID;
    property ConvID: integer  read FConvID write FConvID;
    property Qty: real  read FQty write FQty;
    property Conversion: real  read FConversion write FConversion;
    property Harga: real  read FHarga write FHarga;
    property Discount: real  read FDiscount write FDiscount;
    property HrgDasar: real  read FHrgDasar write FHrgDasar;
  end;

  _MstItemSetting_Arr = class(TObject) {Strong-Container MstItemSetting}
  private
    FOwner: TObject;
  protected
    FMstItemSetting_Arr: array of _MstItemSetting;
    function Get(Index: integer): _MstItemSetting; virtual;
  public
    property Owner: TObject read FOwner;
    constructor Create(AOwner: TObject = nil);
    destructor Destroy; override;
    procedure Clear; virtual;
    function Count: integer;
    property MstItemSetting_Arr[Index: integer]: _MstItemSetting read Get; default;

    function Add(ASettID: integer; AJenisID: integer; AItemID: integer; AConvID: integer; ABatasBawah: real; ABatasAtas: real; ANilai: real; AFaktor: integer; AAktif: integer): integer; virtual;
    function IndexOf(ASettID: integer): integer; virtual;
    procedure Delete(Index: integer); virtual;
  end;

  _MstItemSetting = class(TObject) {Strong-Basic MstItemSetting}
  private
    FOwner: TObject;
  protected
    FSettID: integer; //<sequence
    FJenisID: integer; //
    FItemID: integer; //
    FConvID: integer; //
    FBatasBawah: real; //
    FBatasAtas: real; //
    FNilai: real; //
    FFaktor: integer; //
    FAktif: integer; //
  public
    property Owner: TObject read FOwner;
    constructor Create(AOwner: TObject = nil);
    destructor Destroy; override;
    procedure Reset; virtual;
    procedure InsertOnDB; virtual;
    procedure UpdateOnDB; virtual;
    procedure DeleteOnDB; virtual;
    property SettID: integer  read FSettID write FSettID;
    property JenisID: integer  read FJenisID write FJenisID;
    property ItemID: integer  read FItemID write FItemID;
    property ConvID: integer  read FConvID write FConvID;
    property BatasBawah: real  read FBatasBawah write FBatasBawah;
    property BatasAtas: real  read FBatasAtas write FBatasAtas;
    property Nilai: real  read FNilai write FNilai;
    property Faktor: integer  read FFaktor write FFaktor;
    property Aktif: integer  read FAktif write FAktif;
  end;

  _MstRelation_Arr = class(TObject) {Strong-Container MstRelation}
  private
    FOwner: TObject;
  protected
    FMstRelation_Arr: array of _MstRelation;
    function Get(Index: integer): _MstRelation; virtual;
  public
    property Owner: TObject read FOwner;
    constructor Create(AOwner: TObject = nil);
    destructor Destroy; override;
    procedure Clear; virtual;
    function Count: integer;
    property MstRelation_Arr[Index: integer]: _MstRelation read Get; default;

    function Add(ARelationID: integer; ARelationType: integer; ARelationCode: string; ARelationName: string; AAddress1: string; AAddress2: string; ACity: string; APostCode: string; APhone1: string; APhone2: string; AContactPerson: string; ADueDate: integer; ACurrentDebt: real; ADisabledDate: TDate; ACurrentPoint: real; AFax: string; ANPWP: string): integer; virtual;
    function IndexOf(ARelationID: integer): integer; virtual;
    procedure Delete(Index: integer); virtual;
  end;

  _MstRelation = class(TObject) {Strong-Basic MstRelation}
  private
    FOwner: TObject;
  protected
    FRelationID: integer; //<sequence
    FRelationType: integer; //
    FRelationCode: string; //[0]
    FRelationName: string; //[0]
    FAddress1: string; //[0]
    FAddress2: string; //[0]
    FCity: string; //[0]
    FPostCode: string; //[0]
    FPhone1: string; //[0]
    FPhone2: string; //[0]
    FContactPerson: string; //[0]
    FDueDate: integer; //
    FCurrentDebt: real; //
    FDisabledDate: TDate; //
    FCurrentPoint: real; //
    FFax: string; //[0]
    FNPWP: string; //[0]
    FDiscount:Real;
  public
    property Owner: TObject read FOwner;
    constructor Create(AOwner: TObject = nil);
    destructor Destroy; override;
    procedure Reset; virtual;
    procedure InsertOnDB; virtual;
    procedure UpdateOnDB; virtual;
    procedure DeleteOnDB; virtual;
    property RelationID: integer  read FRelationID write FRelationID;
    property RelationType: integer  read FRelationType write FRelationType;
    property RelationCode: string  read FRelationCode write FRelationCode;
    property RelationName: string  read FRelationName write FRelationName;
    property Address1: string  read FAddress1 write FAddress1;
    property Address2: string  read FAddress2 write FAddress2;
    property City: string  read FCity write FCity;
    property PostCode: string  read FPostCode write FPostCode;
    property Phone1: string  read FPhone1 write FPhone1;
    property Phone2: string  read FPhone2 write FPhone2;
    property ContactPerson: string  read FContactPerson write FContactPerson;
    property DueDate: integer  read FDueDate write FDueDate;
    property CurrentDebt: real  read FCurrentDebt write FCurrentDebt;
    property DisabledDate: TDate  read FDisabledDate write FDisabledDate;
    property CurrentPoint: real  read FCurrentPoint write FCurrentPoint;
    property Fax: string  read FFax write FFax;
    property NPWP: string  read FNPWP write FNPWP;
    property Discount : real read FDiscount write FDiscount;

    function SelectInDB(ARelationID: integer): boolean; virtual;
    class function ExistInDB(ARelationID: integer): integer; virtual;
  end;

  _MstPasien_Arr = class(TObject) {Strong-Container MstPasien}
  private
    FOwner: TObject;
  protected
    FMstPasien_Arr: array of _MstPasien;
    function Get(Index: integer): _MstPasien; virtual;
  public
    property Owner: TObject read FOwner;
    constructor Create(AOwner: TObject = nil);
    destructor Destroy; override;
    procedure Clear; virtual;
    function Count: integer;
    property MstPasien_Arr[Index: integer]: _MstPasien read Get; default;

    function Add(APasienID: integer; AKode: string; ANama: string; AAlamat: string; AKota: string; APhone: string; ASex: integer; ATglLahir: TDate; ACardID: string): integer; virtual;
    function IndexOf(APasienID: integer): integer; virtual;
    procedure Delete(Index: integer); virtual;
  end;

  _MstPasien = class(TObject) {Strong-Basic MstPasien}
  private
    FOwner: TObject;
  protected
    FPasienID: integer; //<sequence
    FKode: string; //[0]
    FNama: string; //[0]
    FAlamat: string; //[0]
    FKota: string; //[0]
    FPhone: string; //[0]
    FSex: integer; //
    FTglLahir: TDate; //
    FCardID: string; //[0]
  public
    property Owner: TObject read FOwner;
    constructor Create(AOwner: TObject = nil);
    destructor Destroy; override;
    procedure Reset; virtual;
    procedure InsertOnDB; virtual;
    procedure UpdateOnDB; virtual;
    procedure DeleteOnDB; virtual;
    property PasienID: integer  read FPasienID write FPasienID;
    property Kode: string  read FKode write FKode;
    property Nama: string  read FNama write FNama;
    property Alamat: string  read FAlamat write FAlamat;
    property Kota: string  read FKota write FKota;
    property Phone: string  read FPhone write FPhone;
    property Sex: integer  read FSex write FSex;
    property TglLahir: TDate  read FTglLahir write FTglLahir;
    property CardID: string  read FCardID write FCardID;
  end;

  _MstDokter_Arr = class(TObject) {Strong-Container MstDokter}
  private
    FOwner: TObject;
  protected
    FMstDokter_Arr: array of _MstDokter;
    function Get(Index: integer): _MstDokter; virtual;
  public
    property Owner: TObject read FOwner;
    constructor Create(AOwner: TObject = nil);
    destructor Destroy; override;
    procedure Clear; virtual;
    function Count: integer;
    property MstDokter_Arr[Index: integer]: _MstDokter read Get; default;

    function Add(ADokterID: integer; AKode: string; ANama: string; AAlamat: string; Aklinik: string; AKontak: string; AEmail: string; ALastTransfer: TDate; Aitemid: integer; Aspesialis: string): integer; virtual;
    function IndexOf(ADokterID: integer): integer; virtual;
    procedure Delete(Index: integer); virtual;
  end;

  _MstDokter = class(TObject) {Strong-Basic MstDokter}
  private
    FOwner: TObject;
  protected
    FDokterID: integer; //<sequence
    FKode: string; //[0]
    FNama: string; //[0]
    FAlamat: string; //[0]
    Fklinik: string; //[0]
    FKontak: string; //[0]
    FEmail: string; //[0]
    FLastTransfer: TDate; //
    Fitemid: integer; //
    Fspesialis: string; //[0]
  public
    property Owner: TObject read FOwner;
    constructor Create(AOwner: TObject = nil);
    destructor Destroy; override;
    procedure Reset; virtual;
    procedure InsertOnDB; virtual;
    procedure UpdateOnDB; virtual;
    procedure DeleteOnDB; virtual;
    property DokterID: integer  read FDokterID write FDokterID;
    property Kode: string  read FKode write FKode;
    property Nama: string  read FNama write FNama;
    property Alamat: string  read FAlamat write FAlamat;
    property klinik: string  read Fklinik write Fklinik;
    property Kontak: string  read FKontak write FKontak;
    property Email: string  read FEmail write FEmail;
    property LastTransfer: TDate  read FLastTransfer write FLastTransfer;
    property itemid: integer  read Fitemid write Fitemid;
    property spesialis: string  read Fspesialis write Fspesialis;
  end;

  _InvItemBalance_Arr = class(TObject) {Strong-Container InvItemBalance}
  private
    FOwner: TObject;
  protected
    FInvItemBalance_Arr: array of _InvItemBalance;
    function Get(Index: integer): _InvItemBalance; virtual;
  public
    property Owner: TObject read FOwner;
    constructor Create(AOwner: TObject = nil);
    destructor Destroy; override;
    procedure Clear; virtual;
    function Count: integer;
    property InvItemBalance_Arr[Index: integer]: _InvItemBalance read Get; default;

    function Add(AItemBalanceID: integer; AItemID: integer; ABalanceDate: TDate; AStorageID: integer; ABalance: real): integer; virtual;
    function IndexOf(AItemBalanceID: integer): integer; virtual;
    procedure Delete(Index: integer); virtual;
  end;

  _InvItemBalance = class(TObject) {Strong-Basic InvItemBalance}
  private
    FOwner: TObject;
  protected
    FItemBalanceID: integer; //<sequence
    FItemID: integer; //
    FBalanceDate: TDate; //
    FStorageID: integer; //
    FBalance: real; //
  public
    property Owner: TObject read FOwner;
    constructor Create(AOwner: TObject = nil);
    destructor Destroy; override;
    procedure Reset; virtual;
    procedure InsertOnDB; virtual;
    procedure UpdateOnDB; virtual;
    procedure DeleteOnDB; virtual;
    property ItemBalanceID: integer  read FItemBalanceID write FItemBalanceID;
    property ItemID: integer  read FItemID write FItemID;
    property BalanceDate: TDate  read FBalanceDate write FBalanceDate;
    property StorageID: integer  read FStorageID write FStorageID;
    property Balance: real  read FBalance write FBalance;
  end;

  _InvCashierBalance_Arr = class(TObject) {Strong-Container InvCashierBalance}
  private
    FOwner: TObject;
  protected
    FInvCashierBalance_Arr: array of _InvCashierBalance;
    function Get(Index: integer): _InvCashierBalance; virtual;
  public
    property Owner: TObject read FOwner;
    constructor Create(AOwner: TObject = nil);
    destructor Destroy; override;
    procedure Clear; virtual;
    function Count: integer;
    property InvCashierBalance_Arr[Index: integer]: _InvCashierBalance read Get; default;

    function Add(ACashierBalanceID: integer; ACashierID: integer; AShiftID: integer; AUserID: string; ABalanceDate: TDate; ABalance: real): integer; virtual;
    function IndexOf(ACashierBalanceID: integer): integer; virtual;
    procedure Delete(Index: integer); virtual;
  end;

  _InvCashierBalance = class(TObject) {Strong-Basic InvCashierBalance}
  private
    FOwner: TObject;
  protected
    FCashierBalanceID: integer; //<sequence
    FCashierID: integer; //
    FShiftID: integer; //
    FUserID: string; //[0]
    FBalanceDate: TDate; //
    FBalance: real; //
  public
    property Owner: TObject read FOwner;
    constructor Create(AOwner: TObject = nil);
    destructor Destroy; override;
    procedure Reset; virtual;
    procedure InsertOnDB; virtual;
    procedure UpdateOnDB; virtual;
    procedure DeleteOnDB; virtual;
    property CashierBalanceID: integer  read FCashierBalanceID write FCashierBalanceID;
    property CashierID: integer  read FCashierID write FCashierID;
    property ShiftID: integer  read FShiftID write FShiftID;
    property UserID: string  read FUserID write FUserID;
    property BalanceDate: TDate  read FBalanceDate write FBalanceDate;
    property Balance: real  read FBalance write FBalance;
  end;

  _TrsShipmentMst_Arr = class(TObject) {Strong-Container TrsShipmentMst}
  private
    FOwner: TObject;
  protected
    FTrsShipmentMst_Arr: array of _TrsShipmentMst;
    function Get(Index: integer): _TrsShipmentMst; virtual;
  public
    property Owner: TObject read FOwner;
    constructor Create(AOwner: TObject = nil);
    destructor Destroy; override;
    procedure Clear; virtual;
    function Count: integer;
    property TrsShipmentMst_Arr[Index: integer]: _TrsShipmentMst read Get; default;

    function Add(AShipID: integer; ATipe: integer; ATransNum: string; ATransDate: TDate; AGudangAsal: integer; AGudangTujuan: integer; ANotes: string; AUserID: string): integer; virtual;
    procedure Delete(Index: integer); virtual;
  end;

  _TrsShipmentMst = class(TObject) {Strong-Basic TrsShipmentMst}
  private
    FOwner: TObject;
  protected
    FShipID: integer; //<sequence
    FTipe: integer; //
    FTransNum: string; //[0]
    FTransDate: TDate; //
    FGudangAsal: integer; //
    FGudangTujuan: integer; //
    FNotes: string; //[0]
    FUserID: string; //[0]
  public
    property Owner: TObject read FOwner;
    constructor Create(AOwner: TObject = nil);
    destructor Destroy; override;
    procedure Reset; virtual;
    procedure InsertOnDB; virtual;
    procedure UpdateOnDB; virtual;
    procedure DeleteOnDB; virtual;
    property ShipID: integer  read FShipID write FShipID;
    property Tipe: integer  read FTipe write FTipe;
    property TransNum: string  read FTransNum write FTransNum;
    property TransDate: TDate  read FTransDate write FTransDate;
    property GudangAsal: integer  read FGudangAsal write FGudangAsal;
    property GudangTujuan: integer  read FGudangTujuan write FGudangTujuan;
    property Notes: string  read FNotes write FNotes;
    property UserID: string  read FUserID write FUserID;
  end;

  _TrsShipmentDetail_Arr = class(TObject) {Strong-Container TrsShipmentDetail}
  private
    FOwner: TObject;
  protected
    FTrsShipmentDetail_Arr: array of _TrsShipmentDetail;
    function Get(Index: integer): _TrsShipmentDetail; virtual;
  public
    property Owner: TObject read FOwner;
    constructor Create(AOwner: TObject = nil);
    destructor Destroy; override;
    procedure Clear; virtual;
    function Count: integer;
    property TrsShipmentDetail_Arr[Index: integer]: _TrsShipmentDetail read Get; default;

    function Add(AShipDetailID: integer; AShipID: integer; AItemID: integer; AConvID: integer; AQuantity: real; APriceSales: real; APricePurchase: real; APriceCost: real; AConversion: real; ADbCrType: string;
    AHrgBeli: real;AStok:real;AQuantiryOri:real): integer; virtual;
    function IndexOf(AShipDetailID: integer): integer; virtual;
    procedure Delete(Index: integer); virtual;
  end;

  _TrsShipmentDetail = class(TObject) {Strong-Basic TrsShipmentDetail}
  private
    FOwner: TObject;
  protected
    FShipDetailID: integer; //<sequence
    FShipID: integer; //
    FMstItem: _MstItem; //ItemID: integer
    FMstItemConversion: _MstItemConversion; //ConvID: integer
    FQuantity: real; //
    FPriceSales: real; //
    FPricePurchase: real; //
    FPriceCost: real; //
    FConversion: real; //
    FDbCrType: string; //[0]
    FHrgBeli: real; //
    FStok:real;
    FQuantityOri:real;
  public
    property Owner: TObject read FOwner;
    constructor Create(AOwner: TObject = nil);
    destructor Destroy; override;
    procedure Reset; virtual;
    procedure InsertOnDB; virtual;
    procedure UpdateOnDB; virtual;
    procedure DeleteOnDB; virtual;
    property ShipDetailID: integer  read FShipDetailID write FShipDetailID;
    property ShipID: integer  read FShipID write FShipID;
    property MstItem: _MstItem  read FMstItem;
    property MstItemConversion: _MstItemConversion  read FMstItemConversion;
    property Quantity: real  read FQuantity write FQuantity;
    property PriceSales: real  read FPriceSales write FPriceSales;
    property PricePurchase: real  read FPricePurchase write FPricePurchase;
    property PriceCost: real  read FPriceCost write FPriceCost;
    property Conversion: real  read FConversion write FConversion;
    property DbCrType: string  read FDbCrType write FDbCrType;
    property HrgBeli: real  read FHrgBeli write FHrgBeli;
    property Stok:real read FStok write FStok;
    property QuantityOri :real read FQuantityOri write FQuantityOri;
  end;

  _TrsSalesMst_Arr = class(TObject) {Strong-Container TrsSalesMst}
  private
    FOwner: TObject;
  protected
    FTrsSalesMst_Arr: array of _TrsSalesMst;
    function Get(Index: integer): _TrsSalesMst; virtual;
  public
    property Owner: TObject read FOwner;
    constructor Create(AOwner: TObject = nil);
    destructor Destroy; override;
    procedure Clear; virtual;
    function Count: integer;
    property TrsSalesMst_Arr[Index: integer]: _TrsSalesMst read Get; default;

    function Add(ASalesID: integer; ATransNum: string; ATransType: integer; ATransDate: TDate; ACashierID: integer; AGudangID: integer; ASubtotal: real; ADiscMst: real; ADiscValMst: real; ATax: real; ATotal: real; ACash: real; AUserID: string; Aprofit: real; APasienID: integer; APoints: integer; ADiscDetail: real; ARealAmount: real; ADokterID: integer; ANoResep: string; ACaraBayar: integer; ACardID: string; ABank: string; AEmbalase: real): integer; virtual;
    function IndexOf(ASalesID: integer): integer; virtual;
    procedure Delete(Index: integer); virtual;
  end;

  _TrsSalesMst = class(TObject) {Strong-Basic TrsSalesMst}
  private
    FOwner: TObject;
  protected
    FSalesID: integer; //<sequence
    FTransNum: string; //[0]
    FTransType: integer; //
    FTransDate: TDate; //
    FCashierID: integer; //
    FGudangID: integer; //
    FSubtotal: real; //
    FDiscMst: real; //
    FDiscValMst: real; //
    FTax: real; //
    FTotal: real; //
    FCash: real; //
    FUserID: string; //[0]
    Fprofit: real; //
    FPasienID: integer; //
    FPoints: integer; //
    FDiscDetail: real; //
    FRealAmount: real; //
    FDokterID: integer; //
    FNoResep: string; //[0]
    FCaraBayar: integer; //
    FCardID: string; //[0]
    FBank: string; //[0]
    FEmbalase: real; //
    FAnimalSeq:string;
    FAnimalId:string;
    FDp : real;
  public
    property Owner: TObject read FOwner;
    constructor Create(AOwner: TObject = nil);
    destructor Destroy; override;
    procedure Reset; virtual;
    procedure InsertOnDB; virtual;
    procedure UpdateOnDB; virtual;
    procedure DeleteOnDB; virtual;
    property SalesID: integer  read FSalesID write FSalesID;
    property TransNum: string  read FTransNum write FTransNum;
    property TransType: integer  read FTransType write FTransType;
    property TransDate: TDate  read FTransDate write FTransDate;
    property CashierID: integer  read FCashierID write FCashierID;
    property GudangID: integer  read FGudangID write FGudangID;
    property Subtotal: real  read FSubtotal write FSubtotal;
    property DiscMst: real  read FDiscMst write FDiscMst;
    property DiscValMst: real  read FDiscValMst write FDiscValMst;
    property Tax: real  read FTax write FTax;
    property Total: real  read FTotal write FTotal;
    property Cash: real  read FCash write FCash;
    property UserID: string  read FUserID write FUserID;
    property profit: real  read Fprofit write Fprofit;
    property PasienID: integer  read FPasienID write FPasienID;
    property Points: integer  read FPoints write FPoints;
    property DiscDetail: real  read FDiscDetail write FDiscDetail;
    property RealAmount: real  read FRealAmount write FRealAmount;
    property DokterID: integer  read FDokterID write FDokterID;
    property NoResep: string  read FNoResep write FNoResep;
    property CaraBayar: integer  read FCaraBayar write FCaraBayar;
    property CardID: string  read FCardID write FCardID;
    property Bank: string  read FBank write FBank;
    property Embalase: real  read FEmbalase write FEmbalase;
    property AnimalSeq:string read FAnimalSeq write FAnimalSeq;
    property AnimalID:string read FAnimalID write FAnimalID;
    property Dp : real read FDp write FDp;
  end;

  _TrsSalesDetail_Arr = class(TObject) {Strong-Container TrsSalesDetail}
  private
    FOwner: TObject;
  protected
    FTrsSalesDetail_Arr: array of _TrsSalesDetail;
    function Get(Index: integer): _TrsSalesDetail; virtual;
  public
    property Owner: TObject read FOwner;
    constructor Create(AOwner: TObject = nil);
    destructor Destroy; override;
    procedure Clear; virtual;
    function Count: integer;
    property TrsSalesDetail_Arr[Index: integer]: _TrsSalesDetail read Get; default;

    function Add(ASalesDetailID: integer; ASalesID: integer; AItemID: integer; AConvID: integer; AQuantity: real; APrice: real; ADisc: real; ADiscVal: real; AAmount: real; AConversion: real; APricePurchase: real; AAmountProfit: real; APoints: integer; APaketID: integer; AConvBonusID: integer; AQtyBonus: real;
      AConvBonus: real; AHrgBeli: real;AServiceType:integer;AIsFree:integer;AAnimalID:integer): integer; virtual;
    function IndexOf(ASalesDetailID: integer): integer; virtual;
    procedure Delete(Index: integer); virtual;
  end;

  _TrsSalesDetail = class(TObject) {Strong-Basic TrsSalesDetail}
  private
    FOwner: TObject;
  protected
    FSalesDetailID: integer; //<sequence
    FSalesID: integer; //
    FMstItem: _MstItem; //ItemID: integer
    FMstItemConversion: _MstItemConversion; //ConvID: integer
    FQuantity: real; //
    FPrice: real; //
    FDisc: real; //
    FDiscVal: real; //
    FAmount: real; //
    FConversion: real; //
    FPricePurchase: real; //
    FAmountProfit: real; //
    FPoints: integer; //
    FPaketID: integer; //
    FConvBonusID: integer; //
    FQtyBonus: real; //
    FConvBonus: real; //
    FHrgBeli: real; //
    FServiceType:integer;
    FIsFree:integer;
    FAnimalID:integer;
  public
    property Owner: TObject read FOwner;
    constructor Create(AOwner: TObject = nil);
    destructor Destroy; override;
    procedure Reset; virtual;
    procedure InsertOnDB; virtual;
    procedure UpdateOnDB; virtual;
    procedure DeleteOnDB; virtual;
    property SalesDetailID: integer  read FSalesDetailID write FSalesDetailID;
    property SalesID: integer  read FSalesID write FSalesID;
    property MstItem: _MstItem  read FMstItem;
    property MstItemConversion: _MstItemConversion  read FMstItemConversion;
    property Quantity: real  read FQuantity write FQuantity;
    property Price: real  read FPrice write FPrice;
    property Disc: real  read FDisc write FDisc;
    property DiscVal: real  read FDiscVal write FDiscVal;
    property Amount: real  read FAmount write FAmount;
    property Conversion: real  read FConversion write FConversion;
    property PricePurchase: real  read FPricePurchase write FPricePurchase;
    property AmountProfit: real  read FAmountProfit write FAmountProfit;
    property Points: integer  read FPoints write FPoints;
    property PaketID: integer  read FPaketID write FPaketID;
    property ConvBonusID: integer  read FConvBonusID write FConvBonusID;
    property QtyBonus: real  read FQtyBonus write FQtyBonus;
    property ConvBonus: real  read FConvBonus write FConvBonus;
    property HrgBeli: real  read FHrgBeli write FHrgBeli;
    property AnimalID: integer  read FAnimalID write FAnimalID;
    property IsFree :integer read FIsFree write FIsFree;
    property ServiceType:integer read FServiceType write FServiceType;
  end;

  _TrsOrderMst_Arr = class(TObject) {Strong-Container TrsOrderMst}
  private
    FOwner: TObject;
  protected
    FTrsOrderMst_Arr: array of _TrsOrderMst;
    function Get(Index: integer): _TrsOrderMst; virtual;
  public
    property Owner: TObject read FOwner;
    constructor Create(AOwner: TObject = nil);
    destructor Destroy; override;
    procedure Clear; virtual;
    function Count: integer;
    property TrsOrderMst_Arr[Index: integer]: _TrsOrderMst read Get; default;

    function Add(AOrderID: integer; ATransNum: string; ATransType: integer; ATransDate: TDate; ADeliveryDate: TDate; AExprDate: TDate; ARelationID: integer; ASubtotal: real; ADiscDetail: real; ADiscMst: real; ATax: real; ATotal: real; ANotes: string; AUserID: string; AStatusID: integer; ADppDisc2: integer; APayTerm: integer): integer; virtual;
    function IndexOf(AOrderID: integer): integer; virtual;
    procedure Delete(Index: integer); virtual;
  end;

  _TrsOrderMst = class(TObject) {Strong-Basic TrsOrderMst}
  private
    FOwner: TObject;
  protected
    FOrderID: integer; //<sequence
    FTransNum: string; //[0]
    FTransType: integer; //
    FTransDate: TDate; //
    FDeliveryDate: TDate; //
    FExprDate: TDate; //
    FMstRelation: _MstRelation; //RelationID: integer
    FSubtotal: real; //
    FDiscDetail: real; //
    FDiscMst: real; //
    FTax: real; //
    FTotal: real; //
    FNotes: string; //[0]
    FUserID: string; //[0]
    FStatusID: integer; //
    FDppDisc2: integer; //
    FPayTerm: integer; //
  public
    property Owner: TObject read FOwner;
    constructor Create(AOwner: TObject = nil);
    destructor Destroy; override;
    procedure Reset; virtual;
    procedure InsertOnDB; virtual;
    procedure UpdateOnDB; virtual;
    procedure DeleteOnDB; virtual;
    property OrderID: integer  read FOrderID write FOrderID;
    property TransNum: string  read FTransNum write FTransNum;
    property TransType: integer  read FTransType write FTransType;
    property TransDate: TDate  read FTransDate write FTransDate;
    property DeliveryDate: TDate  read FDeliveryDate write FDeliveryDate;
    property ExprDate: TDate  read FExprDate write FExprDate;
    property MstRelation: _MstRelation  read FMstRelation;
    property Subtotal: real  read FSubtotal write FSubtotal;
    property DiscDetail: real  read FDiscDetail write FDiscDetail;
    property DiscMst: real  read FDiscMst write FDiscMst;
    property Tax: real  read FTax write FTax;
    property Total: real  read FTotal write FTotal;
    property Notes: string  read FNotes write FNotes;
    property UserID: string  read FUserID write FUserID;
    property StatusID: integer  read FStatusID write FStatusID;
    property DppDisc2: integer  read FDppDisc2 write FDppDisc2;
    property PayTerm: integer  read FPayTerm write FPayTerm;
  end;

  _TrsOrderDetail_Arr = class(TObject) {Strong-Container TrsOrderDetail}
  private
    FOwner: TObject;
  protected
    FTrsOrderDetail_Arr: array of _TrsOrderDetail;
    function Get(Index: integer): _TrsOrderDetail; virtual;
  public
    property Owner: TObject read FOwner;
    constructor Create(AOwner: TObject = nil);
    destructor Destroy; override;
    procedure Clear; virtual;
    function Count: integer;
    property TrsOrderDetail_Arr[Index: integer]: _TrsOrderDetail read Get; default;

    function Add(AOrderDetailID: integer; AOrderID: integer; AItemID: integer; AConvID: integer; AQuantity: real; APrice: real; ADisc: real; AAmount: real; AConversion: real; ATax: real; ADiscIsPrc: integer): integer; virtual;
    function IndexOf(AOrderDetailID: integer): integer; virtual;
    procedure Delete(Index: integer); virtual;
  end;

  _TrsOrderDetail = class(TObject) {Strong-Basic TrsOrderDetail}
  private
    FOwner: TObject;
  protected
    FOrderDetailID: integer; //<sequence
    FOrderID: integer; //
    FMstItem: _MstItem; //ItemID: integer
    FMstItemConversion: _MstItemConversion; //ConvID: integer
    FQuantity: real; //
    FPrice: real; //
    FDisc: real; //
    FAmount: real; //
    FConversion: real; //
    FTax: real; //
    FDiscIsPrc: integer; //
  public
    property Owner: TObject read FOwner;
    constructor Create(AOwner: TObject = nil);
    destructor Destroy; override;
    procedure Reset; virtual;
    procedure InsertOnDB; virtual;
    procedure UpdateOnDB; virtual;
    procedure DeleteOnDB; virtual;
    property OrderDetailID: integer  read FOrderDetailID write FOrderDetailID;
    property OrderID: integer  read FOrderID write FOrderID;
    property MstItem: _MstItem  read FMstItem;
    property MstItemConversion: _MstItemConversion  read FMstItemConversion;
    property Quantity: real  read FQuantity write FQuantity;
    property Price: real  read FPrice write FPrice;
    property Disc: real  read FDisc write FDisc;
    property Amount: real  read FAmount write FAmount;
    property Conversion: real  read FConversion write FConversion;
    property Tax: real  read FTax write FTax;
    property DiscIsPrc: integer  read FDiscIsPrc write FDiscIsPrc;
  end;

  _TrsReceiptMst_Arr = class(TObject) {Strong-Container TrsReceiptMst}
  private
    FOwner: TObject;
  protected
    FTrsReceiptMst_Arr: array of _TrsReceiptMst;
    function Get(Index: integer): _TrsReceiptMst; virtual;
  public
    property Owner: TObject read FOwner;
    constructor Create(AOwner: TObject = nil);
    destructor Destroy; override;
    procedure Clear; virtual;
    function Count: integer;
    property TrsReceiptMst_Arr[Index: integer]: _TrsReceiptMst read Get; default;

    function Add(AReceiptID: integer; ATransNum: string; ATipe: integer; ATransDate: TDate; AExprDate: TDate; ARelationID: integer; AOrderID: integer; AInvID: integer; AGudangID: integer; ASubtotal: real; ADiscDetail: real; ADiscMst: real; ATax: real; ABiaya: real; AMaterai: real; ATotal: real; ANotes: string; AUserID: string; AStatusID: integer; ADppDisc2: integer): integer; virtual;
    function IndexOf(AReceiptID: integer): integer; virtual;
    procedure Delete(Index: integer); virtual;
  end;

  _TrsReceiptMst = class(TObject) {Strong-Basic TrsReceiptMst}
  private
    FOwner: TObject;
  protected
    FReceiptID: integer; //<sequence
    FTransNum: string; //[0]
    FTipe: integer; //
    FTransDate: TDate; //
    FExprDate: TDate; //
    FRelationID: integer; //
    FOrderID: integer; //
    FInvID: integer; //
    FGudangID: integer; //
    FSubtotal: real; //
    FDiscDetail: real; //
    FDiscMst: real; //
    FTax: real; //
    FBiaya: real; //
    FMaterai: real; //
    FTotal: real; //
    FNotes: string; //[0]
    FUserID: string; //[0]
    FStatusID: integer; //
    FDppDisc2: integer; //
  public
    property Owner: TObject read FOwner;
    constructor Create(AOwner: TObject = nil);
    destructor Destroy; override;
    procedure Reset; virtual;
    procedure InsertOnDB; virtual;
    procedure UpdateOnDB; virtual;
    procedure DeleteOnDB; virtual;
    property ReceiptID: integer  read FReceiptID write FReceiptID;
    property TransNum: string  read FTransNum write FTransNum;
    property Tipe: integer  read FTipe write FTipe;
    property TransDate: TDate  read FTransDate write FTransDate;
    property ExprDate: TDate  read FExprDate write FExprDate;
    property RelationID: integer  read FRelationID write FRelationID;
    property OrderID: integer  read FOrderID write FOrderID;
    property InvID: integer  read FInvID write FInvID;
    property GudangID: integer  read FGudangID write FGudangID;
    property Subtotal: real  read FSubtotal write FSubtotal;
    property DiscDetail: real  read FDiscDetail write FDiscDetail;
    property DiscMst: real  read FDiscMst write FDiscMst;
    property Tax: real  read FTax write FTax;
    property Biaya: real  read FBiaya write FBiaya;
    property Materai: real  read FMaterai write FMaterai;
    property Total: real  read FTotal write FTotal;
    property Notes: string  read FNotes write FNotes;
    property UserID: string  read FUserID write FUserID;
    property StatusID: integer  read FStatusID write FStatusID;
    property DppDisc2: integer  read FDppDisc2 write FDppDisc2;
  end;

  _TrsReceiptDetail_Arr = class(TObject) {Strong-Container TrsReceiptDetail}
  private
    FOwner: TObject;
  protected
    FTrsReceiptDetail_Arr: array of _TrsReceiptDetail;
    function Get(Index: integer): _TrsReceiptDetail; virtual;
  public
    property Owner: TObject read FOwner;
    constructor Create(AOwner: TObject = nil);
    destructor Destroy; override;
    procedure Clear; virtual;
    function Count: integer;
    property TrsReceiptDetail_Arr[Index: integer]: _TrsReceiptDetail read Get; default;

    function Add(AReceiptDetailID: integer; AReceiptID: integer; AItemID: integer; AConvID: integer; AConvBonusID: real; AQuantity: real; AQtyBonus: real; APrice: real; AAmount: real; ADisc1: real; ADisc2: real; ADisc3: real; AConversion: real; AConvBonus: real; ATax: real; ADisc1IsPrc: integer; ADisc2IsPrc: integer; ADisc3IsPrc: integer): integer; virtual;
    function IndexOf(AReceiptDetailID: integer): integer; virtual;
    procedure Delete(Index: integer); virtual;
  end;

  _TrsReceiptDetail = class(TObject) {Strong-Basic TrsReceiptDetail}
  private
    FOwner: TObject;
  protected
    FReceiptDetailID: integer; //<sequence
    FReceiptID: integer; //
    FItemID: integer; //
    FConvID: integer; //
    FConvBonusID: real; //
    FQuantity: real; //
    FQtyBonus: real; //
    FPrice: real; //
    FAmount: real; //
    FDisc1: real; //
    FDisc2: real; //
    FDisc3: real; //
    FConversion: real; //
    FConvBonus: real; //
    FTax: real; //
    FDisc1IsPrc: integer; //
    FDisc2IsPrc: integer; //
    FDisc3IsPrc: integer; //
  public
    property Owner: TObject read FOwner;
    constructor Create(AOwner: TObject = nil);
    destructor Destroy; override;
    procedure Reset; virtual;
    procedure InsertOnDB; virtual;
    procedure UpdateOnDB; virtual;
    procedure DeleteOnDB; virtual;
    property ReceiptDetailID: integer  read FReceiptDetailID write FReceiptDetailID;
    property ReceiptID: integer  read FReceiptID write FReceiptID;
    property ItemID: integer  read FItemID write FItemID;
    property ConvID: integer  read FConvID write FConvID;
    property ConvBonusID: real  read FConvBonusID write FConvBonusID;
    property Quantity: real  read FQuantity write FQuantity;
    property QtyBonus: real  read FQtyBonus write FQtyBonus;
    property Price: real  read FPrice write FPrice;
    property Amount: real  read FAmount write FAmount;
    property Disc1: real  read FDisc1 write FDisc1;
    property Disc2: real  read FDisc2 write FDisc2;
    property Disc3: real  read FDisc3 write FDisc3;
    property Conversion: real  read FConversion write FConversion;
    property ConvBonus: real  read FConvBonus write FConvBonus;
    property Tax: real  read FTax write FTax;
    property Disc1IsPrc: integer  read FDisc1IsPrc write FDisc1IsPrc;
    property Disc2IsPrc: integer  read FDisc2IsPrc write FDisc2IsPrc;
    property Disc3IsPrc: integer  read FDisc3IsPrc write FDisc3IsPrc;
  end;

  _TrsReturMst_Arr = class(TObject) {Strong-Container TrsReturMst}
  private
    FOwner: TObject;
  protected
    FTrsReturMst_Arr: array of _TrsReturMst;
    function Get(Index: integer): _TrsReturMst; virtual;
  public
    property Owner: TObject read FOwner;
    constructor Create(AOwner: TObject = nil);
    destructor Destroy; override;
    procedure Clear; virtual;
    function Count: integer;
    property TrsReturMst_Arr[Index: integer]: _TrsReturMst read Get; default;

    function Add(AReturID: integer; ATransNum: string; ATipe: integer; ATransDate: TDate; ARelationID: integer; AInvID: integer; AGudangID: integer; ASubtotal: real; ADiscount: real; ATax: real; ABiaya: real; AMaterai: real; ATotal: real; ANotes: string; AUserID: string; AStatusID: integer): integer; virtual;
    function IndexOf(AReturID: integer): integer; virtual;
    procedure Delete(Index: integer); virtual;
  end;

  _TrsReturMst = class(TObject) {Strong-Basic TrsReturMst}
  private
    FOwner: TObject;
  protected
    FReturID: integer; //<sequence
    FTransNum: string; //[0]
    FTipe: integer; //
    FTransDate: TDate; //
    FRelationID: integer; //
    FInvID: integer; //
    FGudangID: integer; //
    FSubtotal: real; //
    FDiscount: real; //
    FTax: real; //
    FBiaya: real; //
    FMaterai: real; //
    FTotal: real; //
    FNotes: string; //[0]
    FUserID: string; //[0]
    FStatusID: integer; //
  public
    property Owner: TObject read FOwner;
    constructor Create(AOwner: TObject = nil);
    destructor Destroy; override;
    procedure Reset; virtual;
    procedure InsertOnDB; virtual;
    procedure UpdateOnDB; virtual;
    procedure DeleteOnDB; virtual;
    property ReturID: integer  read FReturID write FReturID;
    property TransNum: string  read FTransNum write FTransNum;
    property Tipe: integer  read FTipe write FTipe;
    property TransDate: TDate  read FTransDate write FTransDate;
    property RelationID: integer  read FRelationID write FRelationID;
    property InvID: integer  read FInvID write FInvID;
    property GudangID: integer  read FGudangID write FGudangID;
    property Subtotal: real  read FSubtotal write FSubtotal;
    property Discount: real  read FDiscount write FDiscount;
    property Tax: real  read FTax write FTax;
    property Biaya: real  read FBiaya write FBiaya;
    property Materai: real  read FMaterai write FMaterai;
    property Total: real  read FTotal write FTotal;
    property Notes: string  read FNotes write FNotes;
    property UserID: string  read FUserID write FUserID;
    property StatusID: integer  read FStatusID write FStatusID;
  end;

  _TrsReturDetail_Arr = class(TObject) {Strong-Container TrsReturDetail}
  private
    FOwner: TObject;
  protected
    FTrsReturDetail_Arr: array of _TrsReturDetail;
    function Get(Index: integer): _TrsReturDetail; virtual;
  public
    property Owner: TObject read FOwner;
    constructor Create(AOwner: TObject = nil);
    destructor Destroy; override;
    procedure Clear; virtual;
    function Count: integer;
    property TrsReturDetail_Arr[Index: integer]: _TrsReturDetail read Get; default;

    function Add(AReturDetailID: integer; AReturID: integer; AFakturID: integer; AItemID: integer; AConvID: integer; AQuantity: real; APrice: real; AAmount: real; AConversion: real; ATax: real; ADisc: real; ADiscIsPrc: integer): integer; virtual;
    function IndexOf(AReturDetailID: integer): integer; virtual;
    procedure Delete(Index: integer); virtual;
  end;

  _TrsReturDetail = class(TObject) {Strong-Basic TrsReturDetail}
  private
    FOwner: TObject;
  protected
    FReturDetailID: integer; //<sequence
    FReturID: integer; //
    FFakturID: integer; //
    FItemID: integer; //
    FConvID: integer; //
    FQuantity: real; //
    FPrice: real; //
    FAmount: real; //
    FConversion: real; //
    FTax: real; //
    FDisc: real; //
    FDiscIsPrc: integer; //
  public
    property Owner: TObject read FOwner;
    constructor Create(AOwner: TObject = nil);
    destructor Destroy; override;
    procedure Reset; virtual;
    procedure InsertOnDB; virtual;
    procedure UpdateOnDB; virtual;
    procedure DeleteOnDB; virtual;
    property ReturDetailID: integer  read FReturDetailID write FReturDetailID;
    property ReturID: integer  read FReturID write FReturID;
    property FakturID: integer  read FFakturID write FFakturID;
    property ItemID: integer  read FItemID write FItemID;
    property ConvID: integer  read FConvID write FConvID;
    property Quantity: real  read FQuantity write FQuantity;
    property Price: real  read FPrice write FPrice;
    property Amount: real  read FAmount write FAmount;
    property Conversion: real  read FConversion write FConversion;
    property Tax: real  read FTax write FTax;
    property Disc: real  read FDisc write FDisc;
    property DiscIsPrc: integer  read FDiscIsPrc write FDiscIsPrc;
  end;

  _TrsPaymentMst_Arr = class(TObject) {Strong-Container TrsPaymentMst}
  private
    FOwner: TObject;
  protected
    FTrsPaymentMst_Arr: array of _TrsPaymentMst;
    function Get(Index: integer): _TrsPaymentMst; virtual;
  public
    property Owner: TObject read FOwner;
    constructor Create(AOwner: TObject = nil);
    destructor Destroy; override;
    procedure Clear; virtual;
    function Count: integer;
    property TrsPaymentMst_Arr[Index: integer]: _TrsPaymentMst read Get; default;

    function Add(APaymentID: integer; ATransNum: string; ATipe: integer; ATransDate: TDate; ARelationID: integer; AInvID: integer; ASubtotal: real; ADiscount: real; ABiaya: real; ATotal: real; ANotes: string; AUserID: string; AStatusID: integer): integer; virtual;
    function IndexOf(APaymentID: integer): integer; virtual;
    procedure Delete(Index: integer); virtual;
  end;

  _TrsPaymentMst = class(TObject) {Strong-Basic TrsPaymentMst}
  private
    FOwner: TObject;
  protected
    FPaymentID: integer; //<sequence
    FTransNum: string; //[0]
    FTipe: integer; //
    FTransDate: TDate; //
    FRelationID: integer; //
    FInvID: integer; //
    FSubtotal: real; //
    FDiscount: real; //
    FBiaya: real; //
    FTotal: real; //
    FNotes: string; //[0]
    FUserID: string; //[0]
    FStatusID: integer; //
  public
    property Owner: TObject read FOwner;
    constructor Create(AOwner: TObject = nil);
    destructor Destroy; override;
    procedure Reset; virtual;
    procedure InsertOnDB; virtual;
    procedure UpdateOnDB; virtual;
    procedure DeleteOnDB; virtual;
    property PaymentID: integer  read FPaymentID write FPaymentID;
    property TransNum: string  read FTransNum write FTransNum;
    property Tipe: integer  read FTipe write FTipe;
    property TransDate: TDate  read FTransDate write FTransDate;
    property RelationID: integer  read FRelationID write FRelationID;
    property InvID: integer  read FInvID write FInvID;
    property Subtotal: real  read FSubtotal write FSubtotal;
    property Discount: real  read FDiscount write FDiscount;
    property Biaya: real  read FBiaya write FBiaya;
    property Total: real  read FTotal write FTotal;
    property Notes: string  read FNotes write FNotes;
    property UserID: string  read FUserID write FUserID;
    property StatusID: integer  read FStatusID write FStatusID;
  end;

  _TrsPaymentDetail_Arr = class(TObject) {Strong-Container TrsPaymentDetail}
  private
    FOwner: TObject;
  protected
    FTrsPaymentDetail_Arr: array of _TrsPaymentDetail;
    function Get(Index: integer): _TrsPaymentDetail; virtual;
  public
    property Owner: TObject read FOwner;
    constructor Create(AOwner: TObject = nil);
    destructor Destroy; override;
    procedure Clear; virtual;
    function Count: integer;
    property TrsPaymentDetail_Arr[Index: integer]: _TrsPaymentDetail read Get; default;

    function Add(APayDetailID: integer; APaymentID: integer; AJenisBayar: integer; AAmount: real; ABank: string; ADokNum: string; ATglCair: TDate): integer; virtual;
    function IndexOf(APayDetailID: integer): integer; virtual;
    procedure Delete(Index: integer); virtual;
  end;

  _TrsPaymentDetail = class(TObject) {Strong-Basic TrsPaymentDetail}
  private
    FOwner: TObject;
  protected
    FPayDetailID: integer; //<sequence
    FPaymentID: integer; //
    FJenisBayar: integer; //
    FAmount: real; //
    FBank: string; //[0]
    FDokNum: string; //[0]
    FTglCair: TDate; //
  public
    property Owner: TObject read FOwner;
    constructor Create(AOwner: TObject = nil);
    destructor Destroy; override;
    procedure Reset; virtual;
    procedure InsertOnDB; virtual;
    procedure UpdateOnDB; virtual;
    procedure DeleteOnDB; virtual;
    property PayDetailID: integer  read FPayDetailID write FPayDetailID;
    property PaymentID: integer  read FPaymentID write FPaymentID;
    property JenisBayar: integer  read FJenisBayar write FJenisBayar;
    property Amount: real  read FAmount write FAmount;
    property Bank: string  read FBank write FBank;
    property DokNum: string  read FDokNum write FDokNum;
    property TglCair: TDate  read FTglCair write FTglCair;
  end;

  _TrsPaymentAkun_Arr = class(TObject) {Strong-Container TrsPaymentAkun}
  private
    FOwner: TObject;
  protected
    FTrsPaymentAkun_Arr: array of _TrsPaymentAkun;
    function Get(Index: integer): _TrsPaymentAkun; virtual;
  public
    property Owner: TObject read FOwner;
    constructor Create(AOwner: TObject = nil);
    destructor Destroy; override;
    procedure Clear; virtual;
    function Count: integer;
    property TrsPaymentAkun_Arr[Index: integer]: _TrsPaymentAkun read Get; default;

    function Add(APayAkunID: integer; APaymentID: integer; AAkunID: integer; AAmount: real): integer; virtual;
    function IndexOf(APayAkunID: integer): integer; virtual;
    procedure Delete(Index: integer); virtual;
  end;

  _TrsPaymentAkun = class(TObject) {Strong-Basic TrsPaymentAkun}
  private
    FOwner: TObject;
  protected
    FPayAkunID: integer; //<sequence
    FPaymentID: integer; //
    FAkunID: integer; //
    FAmount: real; //
  public
    property Owner: TObject read FOwner;
    constructor Create(AOwner: TObject = nil);
    destructor Destroy; override;
    procedure Reset; virtual;
    procedure InsertOnDB; virtual;
    procedure UpdateOnDB; virtual;
    procedure DeleteOnDB; virtual;
    property PayAkunID: integer  read FPayAkunID write FPayAkunID;
    property PaymentID: integer  read FPaymentID write FPaymentID;
    property AkunID: integer  read FAkunID write FAkunID;
    property Amount: real  read FAmount write FAmount;
  end;

  _TrsDebtAdjustment_Arr = class(TObject) {Strong-Container TrsDebtAdjustment}
  private
    FOwner: TObject;
  protected
    FTrsDebtAdjustment_Arr: array of _TrsDebtAdjustment;
    function Get(Index: integer): _TrsDebtAdjustment; virtual;
  public
    property Owner: TObject read FOwner;
    constructor Create(AOwner: TObject = nil);
    destructor Destroy; override;
    procedure Clear; virtual;
    function Count: integer;
    property TrsDebtAdjustment_Arr[Index: integer]: _TrsDebtAdjustment read Get; default;

    function Add(AAdjID: integer; ATransDate: TDate; ARelationID: integer; AAmount: real; AUserID: string): integer; virtual;
    function IndexOf(AAdjID: integer): integer; virtual;
    procedure Delete(Index: integer); virtual;
  end;

  _TrsDebtAdjustment = class(TObject) {Strong-Basic TrsDebtAdjustment}
  private
    FOwner: TObject;
  protected
    FAdjID: integer; //<sequence
    FTransDate: TDate; //
    FRelationID: integer; //
    FAmount: real; //
    FUserID: string; //[0]
  public
    property Owner: TObject read FOwner;
    constructor Create(AOwner: TObject = nil);
    destructor Destroy; override;
    procedure Reset; virtual;
    procedure InsertOnDB; virtual;
    procedure UpdateOnDB; virtual;
    procedure DeleteOnDB; virtual;
    property AdjID: integer  read FAdjID write FAdjID;
    property TransDate: TDate  read FTransDate write FTransDate;
    property RelationID: integer  read FRelationID write FRelationID;
    property Amount: real  read FAmount write FAmount;
    property UserID: string  read FUserID write FUserID;
  end;

  _MstProduk_Arr = class(TObject) {Strong-Container MstProduk}
  private
    FOwner: TObject;
  protected
    FMstProduk_Arr: array of _MstProduk;
    function Get(Index: integer): _MstProduk; virtual;
  public
    property Owner: TObject read FOwner;
    constructor Create(AOwner: TObject = nil);
    destructor Destroy; override;
    procedure Clear; virtual;
    function Count: integer;
    property MstProduk_Arr[Index: integer]: _MstProduk read Get; default;

    function Add(AProdukID: integer; AJnsProduk: integer; ABerlaku: integer; APeriodeAwal: TDate; APeriodeAkhir: TDate; AFaktor: integer; AAktif: integer): integer; virtual;
    function IndexOf(AProdukID: integer): integer; virtual;
    procedure Delete(Index: integer); virtual;
  end;

  _MstProduk = class(TObject) {Strong-Basic MstProduk}
  private
    FOwner: TObject;
  protected
    FProdukID: integer; //<sequence
    FJnsProduk: integer; //
    FBerlaku: integer; //
    FPeriodeAwal: TDate; //
    FPeriodeAkhir: TDate; //
    FFaktor: integer; //
    FAktif: integer; //
  public
    property Owner: TObject read FOwner;
    constructor Create(AOwner: TObject = nil);
    destructor Destroy; override;
    procedure Reset; virtual;
    procedure InsertOnDB; virtual;
    procedure UpdateOnDB; virtual;
    procedure DeleteOnDB; virtual;
    property ProdukID: integer  read FProdukID write FProdukID;
    property JnsProduk: integer  read FJnsProduk write FJnsProduk;
    property Berlaku: integer  read FBerlaku write FBerlaku;
    property PeriodeAwal: TDate  read FPeriodeAwal write FPeriodeAwal;
    property PeriodeAkhir: TDate  read FPeriodeAkhir write FPeriodeAkhir;
    property Faktor: integer  read FFaktor write FFaktor;
    property Aktif: integer  read FAktif write FAktif;
  end;

  _MstProdukRule_Arr = class(TObject) {Strong-Container MstProdukRule}
  private
    FOwner: TObject;
  protected
    FMstProdukRule_Arr: array of _MstProdukRule;
    function Get(Index: integer): _MstProdukRule; virtual;
  public
    property Owner: TObject read FOwner;
    constructor Create(AOwner: TObject = nil);
    destructor Destroy; override;
    procedure Clear; virtual;
    function Count: integer;
    property MstProdukRule_Arr[Index: integer]: _MstProdukRule read Get; default;

    function Add(ARuleID: integer; AProdukID: integer; AFaktorID: integer; ABatasMinimal: real; ANilai: real; ADiscPrc: real): integer; virtual;
    function IndexOf(ARuleID: integer): integer; virtual;
    procedure Delete(Index: integer); virtual;
  end;

  _MstProdukRule = class(TObject) {Strong-Basic MstProdukRule}
  private
    FOwner: TObject;
  protected
    FRuleID: integer; //<sequence
    FProdukID: integer; //
    FFaktorID: integer; //
    FBatasMinimal: real; //
    FNilai: real; //
    FDiscPrc: real; //
  public
    property Owner: TObject read FOwner;
    constructor Create(AOwner: TObject = nil);
    destructor Destroy; override;
    procedure Reset; virtual;
    procedure InsertOnDB; virtual;
    procedure UpdateOnDB; virtual;
    procedure DeleteOnDB; virtual;
    property RuleID: integer  read FRuleID write FRuleID;
    property ProdukID: integer  read FProdukID write FProdukID;
    property FaktorID: integer  read FFaktorID write FFaktorID;
    property BatasMinimal: real  read FBatasMinimal write FBatasMinimal;
    property Nilai: real  read FNilai write FNilai;
    property DiscPrc: real  read FDiscPrc write FDiscPrc;
  end;

  _MstProdukItem_Arr = class(TObject) {Strong-Container MstProdukItem}
  private
    FOwner: TObject;
  protected
    FMstProdukItem_Arr: array of _MstProdukItem;
    function Get(Index: integer): _MstProdukItem; virtual;
  public
    property Owner: TObject read FOwner;
    constructor Create(AOwner: TObject = nil);
    destructor Destroy; override;
    procedure Clear; virtual;
    function Count: integer;
    property MstProdukItem_Arr[Index: integer]: _MstProdukItem read Get; default;

    function Add(AProdItemID: integer; ARuleID: integer; AItemID: integer): integer; virtual;
    function IndexOf(AProdItemID: integer): integer; virtual;
    procedure Delete(Index: integer); virtual;
  end;

  _MstProdukItem = class(TObject) {Strong-Basic MstProdukItem}
  private
    FOwner: TObject;
  protected
    FProdItemID: integer; //<sequence
    FRuleID: integer; //
    FItemID: integer; //
  public
    property Owner: TObject read FOwner;
    constructor Create(AOwner: TObject = nil);
    destructor Destroy; override;
    procedure Reset; virtual;
    procedure InsertOnDB; virtual;
    procedure UpdateOnDB; virtual;
    procedure DeleteOnDB; virtual;
    property ProdItemID: integer  read FProdItemID write FProdItemID;
    property RuleID: integer  read FRuleID write FRuleID;
    property ItemID: integer  read FItemID write FItemID;
  end;

  _MstRakItem_Arr = class(TObject) {Strong-Container MstRakItem}
  private
    FOwner: TObject;
  protected
    FMstRakItem_Arr: array of _MstRakItem;
    function Get(Index: integer): _MstRakItem; virtual;
  public
    property Owner: TObject read FOwner;
    constructor Create(AOwner: TObject = nil);
    destructor Destroy; override;
    procedure Clear; virtual;
    function Count: integer;
    property MstRakItem_Arr[Index: integer]: _MstRakItem read Get; default;

    function Add(ARakID: integer; AItemID: integer): integer; virtual;
    procedure Delete(Index: integer); virtual;
  end;

  _MstRakItem = class(TObject) {Strong-Basic MstRakItem}
  private
    FOwner: TObject;
  protected
    FRakID: integer; //
    FItemID: integer; //
  public
    property Owner: TObject read FOwner;
    constructor Create(AOwner: TObject = nil);
    destructor Destroy; override;
    procedure Reset; virtual;
    procedure InsertOnDB; virtual;
    procedure UpdateOnDB; virtual;
    procedure DeleteOnDB; virtual;
    property RakID: integer  read FRakID write FRakID;
    property ItemID: integer  read FItemID write FItemID;
  end;

  _MstServicePrice_Arr = class(TObject) {Strong-Container MstServicePrice}
  private
    FOwner: TObject;
  protected
    FMstServicePrice_Arr: array of _MstServicePrice;
    function Get(Index: integer): _MstServicePrice; virtual;
  public
    property Owner: TObject read FOwner;
    constructor Create(AOwner: TObject = nil);
    destructor Destroy; override;
    procedure Clear; virtual;
    function Count: integer;
    property MstServicePrice_Arr[Index: integer]: _MstServicePrice read Get; default;

    function Add(AServicePriceID: integer; AServiceID: integer; AAnimalId: integer; APrice: real; AAddPrice: real; AInsertLog: string; AEditLog: string;ADiscount:real): integer; virtual;
    procedure Delete(Index: integer); virtual;
  end;


  _MstServicePrice = class(TObject) {Strong-Basic MstServicePrice}
  private
    FOwner: TObject;
  protected
    FServicePriceID: integer; //<sequence
    FServiceID: integer; //
    FAnimalId: integer; //
    FPrice: real; //
    FAddPrice: real; //
    FInsertLog: string; //[0]
    FEditLog: string; //[0]
    FDiscount:real;
  public
    property Owner: TObject read FOwner;
    constructor Create(AOwner: TObject = nil);
    destructor Destroy; override;
    procedure Reset; virtual;
    procedure InsertOnDB; virtual;
    procedure UpdateOnDB; virtual;
    procedure DeleteOnDB; virtual;
    property ServicePriceID: integer  read FServicePriceID write FServicePriceID;
    property ServiceID: integer  read FServiceID write FServiceID;
    property AnimalId: integer  read FAnimalId write FAnimalId;
    property Price: real  read FPrice write FPrice;
    property AddPrice: real  read FAddPrice write FAddPrice;
    property InsertLog: string  read FInsertLog write FInsertLog;
    property EditLog: string  read FEditLog write FEditLog;
    property Discount:real read FDiscount write FDiscount;
  end;


  _MstRelationAnimal_Arr = class(TObject) {Strong-Container MstRelationAnimal}
  private
    FOwner: TObject;
  protected
    FMstRelationAnimal_Arr: array of _MstRelationAnimal;
    function Get(Index: integer): _MstRelationAnimal; virtual;
  public
    property Owner: TObject read FOwner;
    constructor Create(AOwner: TObject = nil);
    destructor Destroy; override;
    procedure Clear; virtual;
    function Count: integer;
    property MstRelationAnimal_Arr[Index: integer]: _MstRelationAnimal read Get; default;

    function Add(ARelationID: integer; ASeq: integer; AAnimalName: string; AAnimalID: integer; ARace: string; AEat: string; AAge: string; ASex: integer; ADisabled: integer): integer; virtual;
    function IndexOf(ARelationID: integer; ASeq: integer): integer; virtual;
    procedure Delete(Index: integer); virtual;
  end;

  _MstRelationAnimal = class(TObject) {Strong-Basic MstRelationAnimal}
  private
    FOwner: TObject;
  protected
    FRelationID: integer; //
    FSeq: integer; //
    FAnimalName: string; //[50]
    FAnimalID: integer; //
    FRace: string; //[50]
    FEat: string; //[100]
    FAge: string;//real; //
    FSex: integer; //
    FDisabled: integer; //
  public
    property Owner: TObject read FOwner;
    constructor Create(AOwner: TObject = nil);
    destructor Destroy; override;
    procedure Reset; virtual;
    procedure InsertOnDB; virtual;
    procedure UpdateOnDB; virtual;
    procedure DeleteOnDB; virtual;
    property RelationID: integer  read FRelationID write FRelationID;
    property Seq: integer  read FSeq write FSeq;
    property AnimalName: string  read FAnimalName write FAnimalName;
    property AnimalID: integer  read FAnimalID write FAnimalID;
    property Race: string  read FRace write FRace;
    property Eat: string  read FEat write FEat;
    property Age: string read FAge write FAge;
    property Sex: integer  read FSex write FSex;
    property Disabled: integer  read FDisabled write FDisabled;
  end;


  _MstBranch_Arr = class(TObject) {Strong-Container MstBranch}
  private
    FOwner: TObject;
  protected
    FMstBranch_Arr: array of _MstBranch;
    function Get(Index: integer): _MstBranch; virtual;
  public
    property Owner: TObject read FOwner;
    constructor Create(AOwner: TObject = nil);
    destructor Destroy; override;
    procedure Clear; virtual;
    function Count: integer;
    property MstBranch_Arr[Index: integer]: _MstBranch read Get; default;

    function Add(ABranchID: integer; ABranchCode: string; ABranchName: string; AAddress: string; APhone1: string; APhone2: string; AFax: string; AInsertLog: string; AEditLog: string): integer; virtual;
    function IndexOf(ABranchID: integer): integer; virtual;
    procedure Delete(Index: integer); virtual;
  end;

  _MstBranch = class(TObject) {Strong-Basic MstBranch}
  private
    FOwner: TObject;
  protected
    FBranchID: integer; //<sequence
    FBranchCode: string; //[0]
    FBranchName: string; //[0]
    FAddress: string; //[0]
    FPhone1: string; //[0]
    FPhone2: string; //[0]
    FFax: string; //[0]
    FCity:string;
    FPostalCode:string;
    FInsertLog: string; //[0]
    FEditLog: string; //[0]
  public
    property Owner: TObject read FOwner;
    constructor Create(AOwner: TObject = nil);
    destructor Destroy; override;
    procedure Reset; virtual;
    procedure InsertOnDB; virtual;
    procedure UpdateOnDB; virtual;
    procedure DeleteOnDB; virtual;
    property BranchID: integer  read FBranchID write FBranchID;
    property BranchCode: string  read FBranchCode write FBranchCode;
    property BranchName: string  read FBranchName write FBranchName;
    property Address: string  read FAddress write FAddress;
    property Phone1: string  read FPhone1 write FPhone1;
    property Phone2: string  read FPhone2 write FPhone2;
    property Fax: string  read FFax write FFax;
    property InsertLog: string  read FInsertLog write FInsertLog;
    property EditLog: string  read FEditLog write FEditLog;
    property City: string  read FCity write FCity;
    property PostalCode: string  read FPostalCode write FPostalCode;
  end;


  _TrsMoneyTransMst_Arr = class(TObject) {Strong-Container TrsMoneyTransMst}
  private
    FOwner: TObject;
  protected
    FTrsMoneyTransMst_Arr: array of _TrsMoneyTransMst;
    function Get(Index: integer): _TrsMoneyTransMst; virtual;
  public
    property Owner: TObject read FOwner;
    constructor Create(AOwner: TObject = nil);
    destructor Destroy; override;
    procedure Clear; virtual;
    function Count: integer;
    property TrsMoneyTransMst_Arr[Index: integer]: _TrsMoneyTransMst read Get; default;

    function Add(AMoneyTransID: integer; ATransNum: string; ATransDate: TDate; ANotes: string; AInsertLog: string; ATransType: integer): integer; virtual;
    function IndexOf(AMoneyTransID: integer): integer; virtual;
    procedure Delete(Index: integer); virtual;
  end;

  _TrsMoneyTransMst = class(TObject) {Strong-Basic TrsMoneyTransMst}
  private
    FOwner: TObject;
  protected
    FMoneyTransID: integer; //<sequence
    FTransNum: string; //[0]
    FTransDate: TDate; //
    FNotes: string; //[100]
    FInsertLog: string; //[50]
    FTransType: integer; //
    FTotal : double;
  public
    property Owner: TObject read FOwner;
    constructor Create(AOwner: TObject = nil);
    destructor Destroy; override;
    procedure Reset; virtual;
    procedure InsertOnDB; virtual;
    procedure UpdateOnDB; virtual;
    procedure DeleteOnDB; virtual;
    property MoneyTransID: integer  read FMoneyTransID write FMoneyTransID;
    property TransNum: string  read FTransNum write FTransNum;
    property TransDate: TDate  read FTransDate write FTransDate;
    property Notes: string  read FNotes write FNotes;
    property InsertLog: string  read FInsertLog write FInsertLog;
    property TransType: integer  read FTransType write FTransType;
    property Total : double read FTotal write FTotal;
  end;

  _TrsMoneyTransDetail_Arr = class(TObject) {Strong-Container TrsMoneyTransDetail}
  private
    FOwner: TObject;
  protected
    FTrsMoneyTransDetail_Arr: array of _TrsMoneyTransDetail;
    function Get(Index: integer): _TrsMoneyTransDetail; virtual;
  public
    property Owner: TObject read FOwner;
    constructor Create(AOwner: TObject = nil);
    destructor Destroy; override;
    procedure Clear; virtual;
    function Count: integer;
    property TrsMoneyTransDetail_Arr[Index: integer]: _TrsMoneyTransDetail read Get; default;

    function Add(AMoneyTransDetailID: integer; AMoneyTransID: integer; AMoneyID: integer; ADescription: string; AAmount: real;AAkunID:integer): integer; virtual;
    function IndexOf(AMoneyTransDetailID: integer): integer; virtual;
    procedure Delete(Index: integer); virtual;
  end;

  _TrsMoneyTransDetail = class(TObject) {Strong-Basic TrsMoneyTransDetail}
  private
    FOwner: TObject;
  protected
    FMoneyTransDetailID: integer; //<sequence
    FMoneyTransID: integer; //
    FMoneyID: integer; //
    FDescription: string; //[100]
    FAmount: real; //
    FAkunID:integer;
  public
    property Owner: TObject read FOwner;
    constructor Create(AOwner: TObject = nil);
    destructor Destroy; override;
    procedure Reset; virtual;
    procedure InsertOnDB; virtual;
    procedure UpdateOnDB; virtual;
    procedure DeleteOnDB; virtual;
    property MoneyTransDetailID: integer  read FMoneyTransDetailID write FMoneyTransDetailID;
    property MoneyTransID: integer  read FMoneyTransID write FMoneyTransID;
    property MoneyID: integer  read FMoneyID write FMoneyID;
    property Description: string  read FDescription write FDescription;
    property Amount: real  read FAmount write FAmount;
    property AkunID:integer read FAkunID write FAkunID;
  end;


   _TrsItemUseMst_Arr = class(TObject) {Strong-Container TrsItemUseMst}
  private
    FOwner: TObject;
  protected
    FTrsItemUseMst_Arr: array of _TrsItemUseMst;
    function Get(Index: integer): _TrsItemUseMst; virtual;
  public
    property Owner: TObject read FOwner;
    constructor Create(AOwner: TObject = nil);
    destructor Destroy; override;
    procedure Clear; virtual;
    function Count: integer;
    property TrsItemUseMst_Arr[Index: integer]: _TrsItemUseMst read Get; default;

    function Add(AItemUseID: integer; ATipe: integer; ATransNum: string; ATransDate: TDate; ANotes: string; AInsertLog: string): integer; virtual;
    procedure Delete(Index: integer); virtual;
  end;

  _TrsItemUseMst = class(TObject) {Strong-Basic TrsItemUseMst}
  private
    FOwner: TObject;
  protected
    FItemUseID: integer; //<sequence
    FTipe: integer; //
    FTransNum: string; //[30]
    FTransDate: TDate; //
    FNotes: string; //[100]
    FInsertLog: string; //[50]
    FTotal :double;
  public
    property Owner: TObject read FOwner;
    constructor Create(AOwner: TObject = nil);
    destructor Destroy; override;
    procedure Reset; virtual;
    procedure InsertOnDB; virtual;
    procedure UpdateOnDB; virtual;
    procedure DeleteOnDB; virtual;
    property ItemUseID: integer  read FItemUseID write FItemUseID;
    property Tipe: integer  read FTipe write FTipe;
    property TransNum: string  read FTransNum write FTransNum;
    property TransDate: TDate  read FTransDate write FTransDate;
    property Notes: string  read FNotes write FNotes;
    property InsertLog: string  read FInsertLog write FInsertLog;
    property Total:double read FTotal write FTotal;
  end;

  _TrsItemUseDetail_Arr = class(TObject) {Strong-Container TrsItemUseDetail}
  private
    FOwner: TObject;
  protected
    FTrsItemUseDetail_Arr: array of _TrsItemUseDetail;
    function Get(Index: integer): _TrsItemUseDetail; virtual;
  public
    property Owner: TObject read FOwner;
    constructor Create(AOwner: TObject = nil);
    destructor Destroy; override;
    procedure Clear; virtual;
    function Count: integer;
    property TrsItemUseDetail_Arr[Index: integer]: _TrsItemUseDetail read Get; default;

    function Add(AItemUseDetailID: integer; AItemUseID: integer; AItemID: integer; AQuantity: real; ABuyingPrice: real; AAmount: real): integer; virtual;
    procedure Delete(Index: integer); virtual;
  end;

  _TrsItemUseDetail = class(TObject) {Strong-Basic TrsItemUseDetail}
  private
    FOwner: TObject;
  protected
    FItemUseDetailID: integer; //<sequence
    FItemUseID: integer; //
    FItemID: integer; //
    FQuantity: real; //
    FBuyingPrice: real; //
    FAmount: real; //
  public
    property Owner: TObject read FOwner;
    constructor Create(AOwner: TObject = nil);
    destructor Destroy; override;
    procedure Reset; virtual;
    procedure InsertOnDB; virtual;
    procedure UpdateOnDB; virtual;
    procedure DeleteOnDB; virtual;
    property ItemUseDetailID: integer  read FItemUseDetailID write FItemUseDetailID;
    property ItemUseID: integer  read FItemUseID write FItemUseID;
    property ItemID: integer  read FItemID write FItemID;
    property Quantity: real  read FQuantity write FQuantity;
    property BuyingPrice: real  read FBuyingPrice write FBuyingPrice;
    property Amount: real  read FAmount write FAmount;
  end;


implementation

uses uMysqlClient, MySQLConnector;
{$HINTS OFF}


{ _MstCode_Arr }

constructor _MstCode_Arr.Create(AOwner: TObject);
begin
  inherited Create;
  FOwner := AOwner;
  setLength(FMstCode_Arr,0);
end;

destructor _MstCode_Arr.Destroy;
begin
  Self.Clear;
  inherited;
end;

procedure _MstCode_Arr.Clear;
var i: integer;
begin
  for i:=0 to high(FMstCode_Arr) do FMstCode_Arr[i].Destroy;
  setLength(FMstCode_Arr,0);
end;

function _MstCode_Arr.Add(ACodeID: integer; ACodeName: string; AParentID: integer; AParentName: string; ALevel: integer; AUrut: integer; AKode: string): integer;
begin
  setLength(FMstCode_Arr, length(FMstCode_Arr)+1);
  Result := high(FMstCode_Arr);
  FMstCode_Arr[Result] := _MstCode.Create(Self);
  FMstCode_Arr[Result].CodeID := ACodeID;
  FMstCode_Arr[Result].CodeName := ACodeName;
  FMstCode_Arr[Result].ParentID := AParentID;
  FMstCode_Arr[Result].ParentName := AParentName;
  FMstCode_Arr[Result].Level := ALevel;
  FMstCode_Arr[Result].Urut := AUrut;
  FMstCode_Arr[Result].Kode := AKode;
end;

function _MstCode_Arr.IndexOf(ACodeID: integer): integer;
var i: integer; found: boolean;
begin
  i := 0; found := false;
  while (i<=high(FMstCode_Arr)) and (not found) do
    if (FMstCode_Arr[i].FCodeID=ACodeID) then
      found := true
    else inc(i);
  if (found) then
    Result := i
  else
    Result := -1;
end;

procedure _MstCode_Arr.Delete(Index: integer);
var i: integer;
begin
  if (Index<0) or (Index>high(FMstCode_Arr)) then Exit;
  FMstCode_Arr[Index].Destroy;
  for i:=Index to high(FMstCode_Arr)-1 do
    FMstCode_Arr[Index] := FMstCode_Arr[Index-1];
  setLength(FMstCode_Arr,length(FMstCode_Arr)-1);
end;

function _MstCode_Arr.Count: integer;
begin
  Result := length(FMstCode_Arr);
end;

function _MstCode_Arr.Get(Index: integer): _MstCode;
begin
  if (Index<0) or (Index>high(FMstCode_Arr)) then Result := nil
  else Result := FMstCode_Arr[Index];
end;


{ _MstCode }

constructor _MstCode.Create(AOwner: TObject);
begin
  inherited Create;
  FOwner := AOwner;
end;

destructor _MstCode.Destroy;
begin
  inherited;
end;

procedure _MstCode.Reset;
begin
  FCodeID := 0;
  FCodeName := '';
  FParentID := 0;
  FParentName := '';
  FLevel := 0;
  FUrut := 0;
  FKode := '';
end;

procedure _MstCode.InsertOnDB;
begin
  try ExecSQL(
    'INSERT INTO Mst_Code (Code_Name,Parent_ID,Parent_Name,Level,Urut,Kode)'+
    ' VALUES ('+
      FormatSQLString(FCodeName)+','+
      FormatSQLNumber(FParentID)+','+
      FormatSQLString(FParentName)+','+
      FormatSQLNumber(FLevel)+','+
      FormatSQLNumber(FUrut)+','+
      FormatSQLString(FKode)+')'
  ); except raise; end;
end;

procedure _MstCode.UpdateOnDB;
begin
  try ExecSQL(
    'UPDATE Mst_Code SET'+
          ' Code_Name='+FormatSQLString(FCodeName)+','+
          ' Parent_ID='+FormatSQLNumber(FParentID)+','+
          ' Parent_Name='+FormatSQLString(FParentName)+','+
          ' Level='+FormatSQLNumber(FLevel)+','+
          ' Urut='+FormatSQLNumber(FUrut)+','+
          ' Kode='+FormatSQLString(FKode)+
    ' WHERE Code_ID='+FormatSQLNumber(FCodeID)
  ); except raise; end;
end;

procedure _MstCode.DeleteOnDB;
begin
  try ExecSQL(
    'DELETE FROM Mst_Code'+
    ' WHERE Code_ID='+FormatSQLNumber(FCodeID)
  ); except raise; end;
end;

function _MstCode.SelectInDB(ACodeID: integer): boolean;
var buffer: TMySQLResult;
begin
  buffer := OpenSQL(
    'SELECT MC.Code_ID, MC.Code_Name, MC.Parent_ID, MC.Parent_Name, MC.Level, MC.Urut, MC.Kode'+
     ' FROM Mst_Code MC'+
    ' WHERE MC.Code_ID='+FormatSQLNumber(ACodeID)
  );
  if (buffer.RecordCount<>0) then begin
    FCodeID := BufferToInteger(buffer.FieldValue(0));
    FCodeName := BufferToString(buffer.FieldValue(1));
    FParentID := BufferToInteger(buffer.FieldValue(2));
    FParentName := BufferToString(buffer.FieldValue(3));
    FLevel := BufferToInteger(buffer.FieldValue(4));
    FUrut := BufferToInteger(buffer.FieldValue(5));
    FKode := BufferToString(buffer.FieldValue(6));
  end;
  Result := (buffer.RecordCount<>0);
  buffer.Destroy;
end;

class function _MstCode.ExistInDB(ACodeID: integer): integer;
var buffer: TMySQLResult;
begin
  buffer := OpenSQL(
    'SELECT COUNT(*) FROM Mst_Code'+
    ' WHERE Code_ID='+FormatSQLNumber(ACodeID)
  );
  Result := BufferToInteger(buffer.FieldValue(0));
  buffer.Destroy;
end;

{ _MstMerk_Arr }

constructor _MstMerk_Arr.Create(AOwner: TObject);
begin
  inherited Create;
  FOwner := AOwner;
  setLength(FMstMerk_Arr,0);
end;

destructor _MstMerk_Arr.Destroy;
begin
  Self.Clear;
  inherited;
end;

procedure _MstMerk_Arr.Clear;
var i: integer;
begin
  for i:=0 to high(FMstMerk_Arr) do FMstMerk_Arr[i].Destroy;
  setLength(FMstMerk_Arr,0);
end;

function _MstMerk_Arr.Add(AMerkID: integer; AMerk: string): integer;
begin
  setLength(FMstMerk_Arr, length(FMstMerk_Arr)+1);
  Result := high(FMstMerk_Arr);
  FMstMerk_Arr[Result] := _MstMerk.Create(Self);
  FMstMerk_Arr[Result].MerkID := AMerkID;
  FMstMerk_Arr[Result].Merk := AMerk;
end;

procedure _MstMerk_Arr.Delete(Index: integer);
var i: integer;
begin
  if (Index<0) or (Index>high(FMstMerk_Arr)) then Exit;
  FMstMerk_Arr[Index].Destroy;
  for i:=Index to high(FMstMerk_Arr)-1 do
    FMstMerk_Arr[Index] := FMstMerk_Arr[Index-1];
  setLength(FMstMerk_Arr,length(FMstMerk_Arr)-1);
end;

function _MstMerk_Arr.Count: integer;
begin
  Result := length(FMstMerk_Arr);
end;

function _MstMerk_Arr.Get(Index: integer): _MstMerk;
begin
  if (Index<0) or (Index>high(FMstMerk_Arr)) then Result := nil
  else Result := FMstMerk_Arr[Index];
end;


{ _MstMerk }

constructor _MstMerk.Create(AOwner: TObject);
begin
  inherited Create;
  FOwner := AOwner;
end;

destructor _MstMerk.Destroy;
begin
  inherited;
end;

procedure _MstMerk.Reset;
begin
  FMerkID := 0;
  FMerk := '';
end;

procedure _MstMerk.InsertOnDB;
begin
  try ExecSQL(
    'INSERT INTO Mst_Merk (Merk)'+
    ' VALUES ('+
      FormatSQLString(FMerk)+')'
  ); except raise; end;
end;

procedure _MstMerk.UpdateOnDB;
begin
  try ExecSQL(
    'UPDATE Mst_Merk SET'+
          ' Merk_ID='+FormatSQLNumber(FMerkID)+','+
          ' Merk='+FormatSQLString(FMerk)+
    ''
  ); except raise; end;
end;

procedure _MstMerk.DeleteOnDB;
begin
  try ExecSQL(
    'DELETE FROM Mst_Merk'+
    ''
  ); except raise; end;
end;


{ _PointMaping_Arr }

constructor _PointMaping_Arr.Create(AOwner: TObject);
begin
  inherited Create;
  FOwner := AOwner;
  setLength(FPointMaping_Arr,0);
end;

destructor _PointMaping_Arr.Destroy;
begin
  Self.Clear;
  inherited;
end;

procedure _PointMaping_Arr.Clear;
var i: integer;
begin
  for i:=0 to high(FPointMaping_Arr) do FPointMaping_Arr[i].Destroy;
  setLength(FPointMaping_Arr,0);
end;

function _PointMaping_Arr.Add(ACodeID: integer; ARootID: integer): integer;
begin
  setLength(FPointMaping_Arr, length(FPointMaping_Arr)+1);
  Result := high(FPointMaping_Arr);
  FPointMaping_Arr[Result] := _PointMaping.Create(Self);
  FPointMaping_Arr[Result].CodeID := ACodeID;
  FPointMaping_Arr[Result].RootID := ARootID;
end;

procedure _PointMaping_Arr.Delete(Index: integer);
var i: integer;
begin
  if (Index<0) or (Index>high(FPointMaping_Arr)) then Exit;
  FPointMaping_Arr[Index].Destroy;
  for i:=Index to high(FPointMaping_Arr)-1 do
    FPointMaping_Arr[Index] := FPointMaping_Arr[Index-1];
  setLength(FPointMaping_Arr,length(FPointMaping_Arr)-1);
end;

function _PointMaping_Arr.Count: integer;
begin
  Result := length(FPointMaping_Arr);
end;

function _PointMaping_Arr.Get(Index: integer): _PointMaping;
begin
  if (Index<0) or (Index>high(FPointMaping_Arr)) then Result := nil
  else Result := FPointMaping_Arr[Index];
end;


{ _PointMaping }

constructor _PointMaping.Create(AOwner: TObject);
begin
  inherited Create;
  FOwner := AOwner;
end;

destructor _PointMaping.Destroy;
begin
  inherited;
end;

procedure _PointMaping.Reset;
begin
  FCodeID := 0;
  FRootID := 0;
end;

procedure _PointMaping.InsertOnDB;
begin
  try ExecSQL(
    'INSERT INTO Point_Maping (Code_ID,Root_ID)'+
    ' VALUES ('+
      FormatSQLNumber(FCodeID)+','+
      FormatSQLNumber(FRootID)+')'
  ); except raise; end;
end;

procedure _PointMaping.UpdateOnDB;
begin
  try ExecSQL(
    'UPDATE Point_Maping SET'+
          ' Code_ID='+FormatSQLNumber(FCodeID)+','+
          ' Root_ID='+FormatSQLNumber(FRootID)+
    ''
  ); except raise; end;
end;

procedure _PointMaping.DeleteOnDB;
begin
  try ExecSQL(
    'DELETE FROM Point_Maping'+
    ''
  ); except raise; end;
end;


{ _MstMaster_Arr }

constructor _MstMaster_Arr.Create(AOwner: TObject);
begin
  inherited Create;
  FOwner := AOwner;
  setLength(FMstMaster_Arr,0);
end;

destructor _MstMaster_Arr.Destroy;
begin
  Self.Clear;
  inherited;
end;

procedure _MstMaster_Arr.Clear;
var i: integer;
begin
  for i:=0 to high(FMstMaster_Arr) do FMstMaster_Arr[i].Destroy;
  setLength(FMstMaster_Arr,0);
end;

function _MstMaster_Arr.Add(AMstID: integer; AMstTipe: integer; AMstCode: string; AMstName: string; AAlamat: string; Aphone: string): integer;
begin
  setLength(FMstMaster_Arr, length(FMstMaster_Arr)+1);
  Result := high(FMstMaster_Arr);
  FMstMaster_Arr[Result] := _MstMaster.Create(Self);
  FMstMaster_Arr[Result].MstID := AMstID;
  FMstMaster_Arr[Result].MstTipe := AMstTipe;
  FMstMaster_Arr[Result].MstCode := AMstCode;
  FMstMaster_Arr[Result].MstName := AMstName;
  FMstMaster_Arr[Result].Alamat := AAlamat;
  FMstMaster_Arr[Result].phone := Aphone;
end;

function _MstMaster_Arr.IndexOf(AMstID: integer): integer;
var i: integer; found: boolean;
begin
  i := 0; found := false;
  while (i<=high(FMstMaster_Arr)) and (not found) do
    if (FMstMaster_Arr[i].FMstID=AMstID) then
      found := true
    else inc(i);
  if (found) then
    Result := i
  else
    Result := -1;
end;

procedure _MstMaster_Arr.Delete(Index: integer);
var i: integer;
begin
  if (Index<0) or (Index>high(FMstMaster_Arr)) then Exit;
  FMstMaster_Arr[Index].Destroy;
  for i:=Index to high(FMstMaster_Arr)-1 do
    FMstMaster_Arr[Index] := FMstMaster_Arr[Index-1];
  setLength(FMstMaster_Arr,length(FMstMaster_Arr)-1);
end;

function _MstMaster_Arr.Count: integer;
begin
  Result := length(FMstMaster_Arr);
end;

function _MstMaster_Arr.Get(Index: integer): _MstMaster;
begin
  if (Index<0) or (Index>high(FMstMaster_Arr)) then Result := nil
  else Result := FMstMaster_Arr[Index];
end;


{ _MstMaster }

constructor _MstMaster.Create(AOwner: TObject);
begin
  inherited Create;
  FOwner := AOwner;
end;

destructor _MstMaster.Destroy;
begin
  inherited;
end;

procedure _MstMaster.Reset;
begin
  FMstID := 0;
  FMstTipe := 0;
  FMstCode := '';
  FMstName := '';
  FAlamat := '';
  Fphone := '';
end;

procedure _MstMaster.InsertOnDB;
begin
  try ExecSQL(
    'INSERT INTO Mst_Master (Mst_Tipe,Mst_Code,Mst_Name,Alamat,phone)'+
    ' VALUES ('+
      FormatSQLNumber(FMstTipe)+','+
      FormatSQLString(FMstCode)+','+
      FormatSQLString(FMstName)+','+
      FormatSQLString(FAlamat)+','+
      FormatSQLString(Fphone)+')'
  ); except raise; end;
end;

procedure _MstMaster.UpdateOnDB;
begin
  try ExecSQL(
    'UPDATE Mst_Master SET'+
          ' Mst_Tipe='+FormatSQLNumber(FMstTipe)+','+
          ' Mst_Code='+FormatSQLString(FMstCode)+','+
          ' Mst_Name='+FormatSQLString(FMstName)+','+
          ' Alamat='+FormatSQLString(FAlamat)+','+
          ' phone='+FormatSQLString(Fphone)+
    ' WHERE Mst_ID='+FormatSQLNumber(FMstID)
  ); except raise; end;
end;

procedure _MstMaster.DeleteOnDB;
begin
  try ExecSQL(
    'DELETE FROM Mst_Master'+
    ' WHERE Mst_ID='+FormatSQLNumber(FMstID)
  ); except raise; end;
end;

function _MstMaster.SelectInDB(AMstID: integer): boolean;
var buffer: TMySQLResult;
begin
  buffer := OpenSQL(
    'SELECT MM.Mst_ID, MM.Mst_Tipe, MM.Mst_Code, MM.Mst_Name, MM.Alamat, MM.phone'+
     ' FROM Mst_Master MM'+
    ' WHERE MM.Mst_ID='+FormatSQLNumber(AMstID)
  );
  if (buffer.RecordCount<>0) then begin
    FMstID := BufferToInteger(buffer.FieldValue(0));
    FMstTipe := BufferToInteger(buffer.FieldValue(1));
    FMstCode := BufferToString(buffer.FieldValue(2));
    FMstName := BufferToString(buffer.FieldValue(3));
    FAlamat := BufferToString(buffer.FieldValue(4));
    Fphone := BufferToString(buffer.FieldValue(5));
  end;
  Result := (buffer.RecordCount<>0);
  buffer.Destroy;
end;

class function _MstMaster.ExistInDB(AMstID: integer): integer;
var buffer: TMySQLResult;
begin
  buffer := OpenSQL(
    'SELECT COUNT(*) FROM Mst_Master'+
    ' WHERE Mst_ID='+FormatSQLNumber(AMstID)
  );
  Result := BufferToInteger(buffer.FieldValue(0));
  buffer.Destroy;
end;

{ _MstAkun_Arr }

constructor _MstAkun_Arr.Create(AOwner: TObject);
begin
  inherited Create;
  FOwner := AOwner;
  setLength(FMstAkun_Arr,0);
end;

destructor _MstAkun_Arr.Destroy;
begin
  Self.Clear;
  inherited;
end;

procedure _MstAkun_Arr.Clear;
var i: integer;
begin
  for i:=0 to high(FMstAkun_Arr) do FMstAkun_Arr[i].Destroy;
  setLength(FMstAkun_Arr,0);
end;

function _MstAkun_Arr.Add(AAkunID: integer; ATipe: integer; AKode: string; ANama: string): integer;
begin
  setLength(FMstAkun_Arr, length(FMstAkun_Arr)+1);
  Result := high(FMstAkun_Arr);
  FMstAkun_Arr[Result] := _MstAkun.Create(Self);
  FMstAkun_Arr[Result].AkunID := AAkunID;
  FMstAkun_Arr[Result].Tipe := ATipe;
  FMstAkun_Arr[Result].Kode := AKode;
  FMstAkun_Arr[Result].Nama := ANama;
end;

function _MstAkun_Arr.IndexOf(AAkunID: integer): integer;
var i: integer; found: boolean;
begin
  i := 0; found := false;
  while (i<=high(FMstAkun_Arr)) and (not found) do
    if (FMstAkun_Arr[i].FAkunID=AAkunID) then
      found := true
    else inc(i);
  if (found) then
    Result := i
  else
    Result := -1;
end;

procedure _MstAkun_Arr.Delete(Index: integer);
var i: integer;
begin
  if (Index<0) or (Index>high(FMstAkun_Arr)) then Exit;
  FMstAkun_Arr[Index].Destroy;
  for i:=Index to high(FMstAkun_Arr)-1 do
    FMstAkun_Arr[Index] := FMstAkun_Arr[Index-1];
  setLength(FMstAkun_Arr,length(FMstAkun_Arr)-1);
end;

function _MstAkun_Arr.Count: integer;
begin
  Result := length(FMstAkun_Arr);
end;

function _MstAkun_Arr.Get(Index: integer): _MstAkun;
begin
  if (Index<0) or (Index>high(FMstAkun_Arr)) then Result := nil
  else Result := FMstAkun_Arr[Index];
end;


{ _MstAkun }

constructor _MstAkun.Create(AOwner: TObject);
begin
  inherited Create;
  FOwner := AOwner;
end;

destructor _MstAkun.Destroy;
begin
  inherited;
end;

procedure _MstAkun.Reset;
begin
  FAkunID := 0;
  FTipe := 0;
  FKode := '';
  FNama := '';
end;

procedure _MstAkun.InsertOnDB;
begin
  try ExecSQL(
    'INSERT INTO Mst_Akun (Tipe,Kode,Nama)'+
    ' VALUES ('+
      FormatSQLNumber(FTipe)+','+
      FormatSQLString(FKode)+','+
      FormatSQLString(FNama)+')'
  ); except raise; end;
end;

procedure _MstAkun.UpdateOnDB;
begin
  try ExecSQL(
    'UPDATE Mst_Akun SET'+
          ' Tipe='+FormatSQLNumber(FTipe)+','+
          ' Kode='+FormatSQLString(FKode)+','+
          ' Nama='+FormatSQLString(FNama)+
    ' WHERE Akun_ID='+FormatSQLNumber(FAkunID)
  ); except raise; end;
end;

procedure _MstAkun.DeleteOnDB;
begin
  try ExecSQL(
    'DELETE FROM Mst_Akun'+
    ' WHERE Akun_ID='+FormatSQLNumber(FAkunID)
  ); except raise; end;
end;


{ _MstItem_Arr }

constructor _MstItem_Arr.Create(AOwner: TObject);
begin
  inherited Create;
  FOwner := AOwner;
  setLength(FMstItem_Arr,0);
end;

destructor _MstItem_Arr.Destroy;
begin
  Self.Clear;
  inherited;
end;

procedure _MstItem_Arr.Clear;
var i: integer;
begin
  for i:=0 to high(FMstItem_Arr) do FMstItem_Arr[i].Destroy;
  setLength(FMstItem_Arr,0);
end;

function _MstItem_Arr.Add(AItemID: integer; AItemCode: string; ABarcode: string; AItemName: string; AStrukName: string; AMerk: string; ASpecification: integer; AVendorID: integer; ACurrentStock: real; AAvgPrice: real; ADisabledDate: TDate; AProdusenID: integer; AKemasanID: integer; ABKP: integer; AKonsinyasi: integer; ADosis: real; AExpireDate: TDate; AKategori: integer): integer;
begin
  setLength(FMstItem_Arr, length(FMstItem_Arr)+1);
  Result := high(FMstItem_Arr);
  FMstItem_Arr[Result] := _MstItem.Create(Self);
  FMstItem_Arr[Result].ItemID := AItemID;
  FMstItem_Arr[Result].ItemCode := AItemCode;
  FMstItem_Arr[Result].Barcode := ABarcode;
  FMstItem_Arr[Result].ItemName := AItemName;
  FMstItem_Arr[Result].StrukName := AStrukName;
  FMstItem_Arr[Result].Merk := AMerk;
  FMstItem_Arr[Result].MstCode.CodeID := ASpecification;
  FMstItem_Arr[Result].VendorID := AVendorID;
  FMstItem_Arr[Result].CurrentStock := ACurrentStock;
  FMstItem_Arr[Result].AvgPrice := AAvgPrice;
  FMstItem_Arr[Result].DisabledDate := ADisabledDate;
  FMstItem_Arr[Result].ProdusenID := AProdusenID;
  FMstItem_Arr[Result].KemasanID := AKemasanID;
  FMstItem_Arr[Result].BKP := ABKP;
  FMstItem_Arr[Result].Konsinyasi := AKonsinyasi;
  FMstItem_Arr[Result].Dosis := ADosis;
  FMstItem_Arr[Result].ExpireDate := AExpireDate;
  FMstItem_Arr[Result].Kategori := AKategori;
end;

function _MstItem_Arr.IndexOf(AItemID: integer): integer;
var i: integer; found: boolean;
begin
  i := 0; found := false;
  while (i<=high(FMstItem_Arr)) and (not found) do
    if (FMstItem_Arr[i].FItemID=AItemID) then
      found := true
    else inc(i);
  if (found) then
    Result := i
  else
    Result := -1;
end;

procedure _MstItem_Arr.Delete(Index: integer);
var i: integer;
begin
  if (Index<0) or (Index>high(FMstItem_Arr)) then Exit;
  FMstItem_Arr[Index].Destroy;
  for i:=Index to high(FMstItem_Arr)-1 do
    FMstItem_Arr[Index] := FMstItem_Arr[Index-1];
  setLength(FMstItem_Arr,length(FMstItem_Arr)-1);
end;

function _MstItem_Arr.Count: integer;
begin
  Result := length(FMstItem_Arr);
end;

function _MstItem_Arr.Get(Index: integer): _MstItem;
begin
  if (Index<0) or (Index>high(FMstItem_Arr)) then Result := nil
  else Result := FMstItem_Arr[Index];
end;


{ _MstItem }

constructor _MstItem.Create(AOwner: TObject);
begin
  inherited Create;
  FOwner := AOwner;
  FMstCode := _MstCode.Create(Self);
end;

destructor _MstItem.Destroy;
begin
  FMstCode.Destroy;
  inherited;
end;

procedure _MstItem.Reset;
begin
  FItemID := 0;
  FItemCode := '';
  FBarcode := '';
  FItemName := '';
  FStrukName := '';
  FMerk := '';
  FMstCode.Reset;
  FVendorID := 0;
  FCurrentStock := 0.0;
  FAvgPrice := 0.0;
  FDisabledDate := 0;
  FProdusenID := 0;
  FKemasanID := 0;
  FBKP := 0;
  FKonsinyasi := 0;
  FDosis := 0.0;
  FExpireDate := 0;
  FKategori := 0;
end;

procedure _MstItem.InsertOnDB;
begin
  try ExecSQL(
    'INSERT INTO Mst_Item (Item_Code,Barcode,Item_Name,Struk_Name,Merk,Specification,Vendor_ID,Current_Stock,Avg_Price,Disabled_Date,Produsen_ID,Kemasan_ID,BKP,Konsinyasi,Dosis,Expire_Date,Kategori)'+
    ' VALUES ('+
      FormatSQLString(FItemCode)+','+
      FormatSQLString(FBarcode)+','+
      FormatSQLString(FItemName)+','+
      FormatSQLString(FStrukName)+','+
      FormatSQLString(FMerk)+','+
      FormatSQLNumber(FMstCode.CodeID)+','+
      FormatSQLNumber(FVendorID)+','+
      FormatSQLNumber(FCurrentStock)+','+
      FormatSQLNumber(FAvgPrice)+','+
      FormatSQLDate(FDisabledDate)+','+
      FormatSQLNumber(FProdusenID)+','+
      FormatSQLNumber(FKemasanID)+','+
      FormatSQLNumber(FBKP)+','+
      FormatSQLNumber(FKonsinyasi)+','+
      FormatSQLNumber(FDosis)+','+
      FormatSQLDate(FExpireDate)+','+
      FormatSQLNumber(FKategori)+')'
  ); except raise; end;
end;

procedure _MstItem.UpdateOnDB;
begin
  try ExecSQL(
    'UPDATE Mst_Item SET'+
          ' Item_Code='+FormatSQLString(FItemCode)+','+
          ' Barcode='+FormatSQLString(FBarcode)+','+
          ' Item_Name='+FormatSQLString(FItemName)+','+
          ' Struk_Name='+FormatSQLString(FStrukName)+','+
          ' Merk='+FormatSQLString(FMerk)+','+
          ' Specification='+FormatSQLNumber(FMstCode.CodeID)+','+
          ' Vendor_ID='+FormatSQLNumber(FVendorID)+','+
          ' Current_Stock='+FormatSQLNumber(FCurrentStock)+','+
          ' Avg_Price='+FormatSQLNumber(FAvgPrice)+','+
          ' Disabled_Date='+FormatSQLDate(FDisabledDate)+','+
          ' Produsen_ID='+FormatSQLNumber(FProdusenID)+','+
          ' Kemasan_ID='+FormatSQLNumber(FKemasanID)+','+
          ' BKP='+FormatSQLNumber(FBKP)+','+
          ' Konsinyasi='+FormatSQLNumber(FKonsinyasi)+','+
          ' Dosis='+FormatSQLNumber(FDosis)+','+
          ' Expire_Date='+FormatSQLDate(FExpireDate)+','+
          ' Kategori='+FormatSQLNumber(FKategori)+
    ' WHERE Item_ID='+FormatSQLNumber(FItemID)
  ); except raise; end;
end;

procedure _MstItem.DeleteOnDB;
begin
  try ExecSQL(
    'DELETE FROM Mst_Item'+
    ' WHERE Item_ID='+FormatSQLNumber(FItemID)
  ); except raise; end;
end;

function _MstItem.SelectInDB(AItemID: integer): boolean;
var buffer: TMySQLResult;
begin
  buffer := OpenSQL(
    'SELECT MI.Item_ID, MI.Item_Code, MI.Barcode, MI.Item_Name, MI.Struk_Name, MI.Merk, MI.Vendor_ID, MI.Current_Stock, MI.Avg_Price, MI.Disabled_Date, MI.Produsen_ID, MI.Kemasan_ID, MI.BKP, MI.Konsinyasi, MI.Dosis'+
         ', MI.Expire_Date, MI.Kategori'+
         ', MC.Code_ID, MC.Code_Name, MC.Parent_ID, MC.Parent_Name, MC.Level, MC.Urut, MC.Kode'+
     ' FROM Mst_Item MI, Mst_Code MC'+
    ' WHERE MI.Item_ID='+FormatSQLNumber(AItemID)+
      ' AND MI.Specification=MC.Code_ID(+)'
  );
  if (buffer.RecordCount<>0) then begin
    FItemID := BufferToInteger(buffer.FieldValue(0));
    FItemCode := BufferToString(buffer.FieldValue(1));
    FBarcode := BufferToString(buffer.FieldValue(2));
    FItemName := BufferToString(buffer.FieldValue(3));
    FStrukName := BufferToString(buffer.FieldValue(4));
    FMerk := BufferToString(buffer.FieldValue(5));
    FVendorID := BufferToInteger(buffer.FieldValue(6));
    FCurrentStock := BufferToFloat(buffer.FieldValue(7));
    FAvgPrice := BufferToFloat(buffer.FieldValue(8));
    FDisabledDate := BufferToDateTime(buffer.FieldValue(9));
    FProdusenID := BufferToInteger(buffer.FieldValue(10));
    FKemasanID := BufferToInteger(buffer.FieldValue(11));
    FBKP := BufferToInteger(buffer.FieldValue(12));
    FKonsinyasi := BufferToInteger(buffer.FieldValue(13));
    FDosis := BufferToFloat(buffer.FieldValue(14));
    FExpireDate := BufferToDateTime(buffer.FieldValue(15));
    FKategori := BufferToInteger(buffer.FieldValue(16));
    FMstCode.CodeID := BufferToInteger(buffer.FieldValue(17));
    FMstCode.CodeName := BufferToString(buffer.FieldValue(18));
    FMstCode.ParentID := BufferToInteger(buffer.FieldValue(19));
    FMstCode.ParentName := BufferToString(buffer.FieldValue(20));
    FMstCode.Level := BufferToInteger(buffer.FieldValue(21));
    FMstCode.Urut := BufferToInteger(buffer.FieldValue(22));
    FMstCode.Kode := BufferToString(buffer.FieldValue(23));
  end;
  Result := (buffer.RecordCount<>0);
  buffer.Destroy;
end;

class function _MstItem.ExistInDB(AItemID: integer): integer;
var buffer: TMySQLResult;
begin
  buffer := OpenSQL(
    'SELECT COUNT(*) FROM Mst_Item'+
    ' WHERE Item_ID='+FormatSQLNumber(AItemID)
  );
  Result := BufferToInteger(buffer.FieldValue(0));
  buffer.Destroy;
end;

{ _MstItemConversion_Arr }

constructor _MstItemConversion_Arr.Create(AOwner: TObject);
begin
  inherited Create;
  FOwner := AOwner;
  setLength(FMstItemConversion_Arr,0);
end;

destructor _MstItemConversion_Arr.Destroy;
begin
  Self.Clear;
  inherited;
end;

procedure _MstItemConversion_Arr.Clear;
var i: integer;
begin
  for i:=0 to high(FMstItemConversion_Arr) do FMstItemConversion_Arr[i].Destroy;
  setLength(FMstItemConversion_Arr,0);
end;

function _MstItemConversion_Arr.Add(AConvID: integer; AItemID: integer; AUnitID: integer; AConversion: real; APurchasePrice: real; ASalesPrice: real; ASalesPrice2: real; ASalesPrice3: real; ACostPrice: real; AItemTax: real; AItemDiscount: real; ADiscTipe: integer; ANetPrice: real): integer;
begin
  setLength(FMstItemConversion_Arr, length(FMstItemConversion_Arr)+1);
  Result := high(FMstItemConversion_Arr);
  FMstItemConversion_Arr[Result] := _MstItemConversion.Create(Self);
  FMstItemConversion_Arr[Result].ConvID := AConvID;
  FMstItemConversion_Arr[Result].ItemID := AItemID;
  FMstItemConversion_Arr[Result].MstMaster.MstID := AUnitID;
  FMstItemConversion_Arr[Result].Conversion := AConversion;
  FMstItemConversion_Arr[Result].PurchasePrice := APurchasePrice;
  FMstItemConversion_Arr[Result].SalesPrice := ASalesPrice;
  FMstItemConversion_Arr[Result].SalesPrice2 := ASalesPrice2;
  FMstItemConversion_Arr[Result].SalesPrice3 := ASalesPrice3;
  FMstItemConversion_Arr[Result].CostPrice := ACostPrice;
  FMstItemConversion_Arr[Result].ItemTax := AItemTax;
  FMstItemConversion_Arr[Result].ItemDiscount := AItemDiscount;
  FMstItemConversion_Arr[Result].DiscTipe := ADiscTipe;
  FMstItemConversion_Arr[Result].NetPrice := ANetPrice;
end;

function _MstItemConversion_Arr.IndexOf(AConvID: integer): integer;
var i: integer; found: boolean;
begin
  i := 0; found := false;
  while (i<=high(FMstItemConversion_Arr)) and (not found) do
    if (FMstItemConversion_Arr[i].FConvID=AConvID) then
      found := true
    else inc(i);
  if (found) then
    Result := i
  else
    Result := -1;
end;

procedure _MstItemConversion_Arr.Delete(Index: integer);
var i: integer;
begin
  if (Index<0) or (Index>high(FMstItemConversion_Arr)) then Exit;
  FMstItemConversion_Arr[Index].Destroy;
  for i:=Index to high(FMstItemConversion_Arr)-1 do
    FMstItemConversion_Arr[Index] := FMstItemConversion_Arr[Index-1];
  setLength(FMstItemConversion_Arr,length(FMstItemConversion_Arr)-1);
end;

function _MstItemConversion_Arr.Count: integer;
begin
  Result := length(FMstItemConversion_Arr);
end;

function _MstItemConversion_Arr.Get(Index: integer): _MstItemConversion;
begin
  if (Index<0) or (Index>high(FMstItemConversion_Arr)) then Result := nil
  else Result := FMstItemConversion_Arr[Index];
end;


{ _MstItemConversion }

constructor _MstItemConversion.Create(AOwner: TObject);
begin
  inherited Create;
  FOwner := AOwner;
  FMstMaster := _MstMaster.Create(Self);
end;

destructor _MstItemConversion.Destroy;
begin
  FMstMaster.Destroy;
  inherited;
end;

procedure _MstItemConversion.Reset;
begin
  FConvID := 0;
  FItemID := 0;
  FMstMaster.Reset;
  FConversion := 0.0;
  FPurchasePrice := 0.0;
  FSalesPrice := 0.0;
  FSalesPrice2 := 0.0;
  FSalesPrice3 := 0.0;
  FCostPrice := 0.0;
  FItemTax := 0.0;
  FItemDiscount := 0.0;
  FDiscTipe := 0;
  FNetPrice := 0.0;
end;

procedure _MstItemConversion.InsertOnDB;
begin
  try ExecSQL(
    'INSERT INTO Mst_Item_Conversion (Item_ID,Unit_ID,Conversion,Purchase_Price,Sales_Price,Sales_Price2,Sales_Price3,Cost_Price,Item_Tax,Item_Discount,Disc_Tipe,Net_Price)'+
    ' VALUES ('+
      FormatSQLNumber(FItemID)+','+
      FormatSQLNumber(FMstMaster.MstID)+','+
      FormatSQLNumber(FConversion)+','+
      FormatSQLNumber(FPurchasePrice)+','+
      FormatSQLNumber(FSalesPrice)+','+
      FormatSQLNumber(FSalesPrice2)+','+
      FormatSQLNumber(FSalesPrice3)+','+
      FormatSQLNumber(FCostPrice)+','+
      FormatSQLNumber(FItemTax)+','+
      FormatSQLNumber(FItemDiscount)+','+
      FormatSQLNumber(FDiscTipe)+','+
      FormatSQLNumber(FNetPrice)+')'
  ); except raise; end;
end;

procedure _MstItemConversion.UpdateOnDB;
begin
  try ExecSQL(
    'UPDATE Mst_Item_Conversion SET'+
          ' Item_ID='+FormatSQLNumber(FItemID)+','+
          ' Unit_ID='+FormatSQLNumber(FMstMaster.MstID)+','+
          ' Conversion='+FormatSQLNumber(FConversion)+','+
          ' Purchase_Price='+FormatSQLNumber(FPurchasePrice)+','+
          ' Sales_Price='+FormatSQLNumber(FSalesPrice)+','+
          ' Sales_Price2='+FormatSQLNumber(FSalesPrice2)+','+
          ' Sales_Price3='+FormatSQLNumber(FSalesPrice3)+','+
          ' Cost_Price='+FormatSQLNumber(FCostPrice)+','+
          ' Item_Tax='+FormatSQLNumber(FItemTax)+','+
          ' Item_Discount='+FormatSQLNumber(FItemDiscount)+','+
          ' Disc_Tipe='+FormatSQLNumber(FDiscTipe)+','+
          ' Net_Price='+FormatSQLNumber(FNetPrice)+
    ' WHERE Conv_ID='+FormatSQLNumber(FConvID)
  ); except raise; end;
end;

procedure _MstItemConversion.DeleteOnDB;
begin
  try ExecSQL(
    'DELETE FROM Mst_Item_Conversion'+
    ' WHERE Conv_ID='+FormatSQLNumber(FConvID)
  ); except raise; end;
end;

function _MstItemConversion.SelectInDB(AConvID: integer): boolean;
var buffer: TMySQLResult;
begin
  buffer := OpenSQL(
    'SELECT MIC.Conv_ID, MIC.Item_ID, MIC.Conversion, MIC.Purchase_Price, MIC.Sales_Price, MIC.Sales_Price2, MIC.Sales_Price3, MIC.Cost_Price, MIC.Item_Tax, MIC.Item_Discount, MIC.Disc_Tipe, MIC.Net_Price'+
         ', MM.Mst_ID, MM.Mst_Tipe, MM.Mst_Code, MM.Mst_Name, MM.Alamat, MM.phone'+
     ' FROM Mst_Item_Conversion MIC, Mst_Master MM'+
    ' WHERE MIC.Conv_ID='+FormatSQLNumber(AConvID)+
      ' AND MIC.Unit_ID=MM.Mst_ID(+)'
  );
  if (buffer.RecordCount<>0) then begin
    FConvID := BufferToInteger(buffer.FieldValue(0));
    FItemID := BufferToInteger(buffer.FieldValue(1));
    FConversion := BufferToFloat(buffer.FieldValue(2));
    FPurchasePrice := BufferToFloat(buffer.FieldValue(3));
    FSalesPrice := BufferToFloat(buffer.FieldValue(4));
    FSalesPrice2 := BufferToFloat(buffer.FieldValue(5));
    FSalesPrice3 := BufferToFloat(buffer.FieldValue(6));
    FCostPrice := BufferToFloat(buffer.FieldValue(7));
    FItemTax := BufferToFloat(buffer.FieldValue(8));
    FItemDiscount := BufferToFloat(buffer.FieldValue(9));
    FDiscTipe := BufferToInteger(buffer.FieldValue(10));
    FNetPrice := BufferToFloat(buffer.FieldValue(11));
    FMstMaster.MstID := BufferToInteger(buffer.FieldValue(12));
    FMstMaster.MstTipe := BufferToInteger(buffer.FieldValue(13));
    FMstMaster.MstCode := BufferToString(buffer.FieldValue(14));
    FMstMaster.MstName := BufferToString(buffer.FieldValue(15));
    FMstMaster.Alamat := BufferToString(buffer.FieldValue(16));
    FMstMaster.phone := BufferToString(buffer.FieldValue(17));
  end;
  Result := (buffer.RecordCount<>0);
  buffer.Destroy;
end;

class function _MstItemConversion.ExistInDB(AConvID: integer): integer;
var buffer: TMySQLResult;
begin
  buffer := OpenSQL(
    'SELECT COUNT(*) FROM Mst_Item_Conversion'+
    ' WHERE Conv_ID='+FormatSQLNumber(AConvID)
  );
  Result := BufferToInteger(buffer.FieldValue(0));
  buffer.Destroy;
end;

{ _MstPaket_Arr }

constructor _MstPaket_Arr.Create(AOwner: TObject);
begin
  inherited Create;
  FOwner := AOwner;
  setLength(FMstPaket_Arr,0);
end;

destructor _MstPaket_Arr.Destroy;
begin
  Self.Clear;
  inherited;
end;

procedure _MstPaket_Arr.Clear;
var i: integer;
begin
  for i:=0 to high(FMstPaket_Arr) do FMstPaket_Arr[i].Destroy;
  setLength(FMstPaket_Arr,0);
end;

function _MstPaket_Arr.Add(APaketID: integer; AKode: string; ABarcode: string; ANama: string; ANamaStruk: string; AUnitID: integer; AHargaDasar: real; AHargaJual: real; AGudangID: integer; ADisabledDate: TDate): integer;
begin
  setLength(FMstPaket_Arr, length(FMstPaket_Arr)+1);
  Result := high(FMstPaket_Arr);
  FMstPaket_Arr[Result] := _MstPaket.Create(Self);
  FMstPaket_Arr[Result].PaketID := APaketID;
  FMstPaket_Arr[Result].Kode := AKode;
  FMstPaket_Arr[Result].Barcode := ABarcode;
  FMstPaket_Arr[Result].Nama := ANama;
  FMstPaket_Arr[Result].NamaStruk := ANamaStruk;
  FMstPaket_Arr[Result].UnitID := AUnitID;
  FMstPaket_Arr[Result].HargaDasar := AHargaDasar;
  FMstPaket_Arr[Result].HargaJual := AHargaJual;
  FMstPaket_Arr[Result].GudangID := AGudangID;
  FMstPaket_Arr[Result].DisabledDate := ADisabledDate;
end;

function _MstPaket_Arr.IndexOf(APaketID: integer): integer;
var i: integer; found: boolean;
begin
  i := 0; found := false;
  while (i<=high(FMstPaket_Arr)) and (not found) do
    if (FMstPaket_Arr[i].FPaketID=APaketID) then
      found := true
    else inc(i);
  if (found) then
    Result := i
  else
    Result := -1;
end;

procedure _MstPaket_Arr.Delete(Index: integer);
var i: integer;
begin
  if (Index<0) or (Index>high(FMstPaket_Arr)) then Exit;
  FMstPaket_Arr[Index].Destroy;
  for i:=Index to high(FMstPaket_Arr)-1 do
    FMstPaket_Arr[Index] := FMstPaket_Arr[Index-1];
  setLength(FMstPaket_Arr,length(FMstPaket_Arr)-1);
end;

function _MstPaket_Arr.Count: integer;
begin
  Result := length(FMstPaket_Arr);
end;

function _MstPaket_Arr.Get(Index: integer): _MstPaket;
begin
  if (Index<0) or (Index>high(FMstPaket_Arr)) then Result := nil
  else Result := FMstPaket_Arr[Index];
end;


{ _MstPaket }

constructor _MstPaket.Create(AOwner: TObject);
begin
  inherited Create;
  FOwner := AOwner;
end;

destructor _MstPaket.Destroy;
begin
  inherited;
end;

procedure _MstPaket.Reset;
begin
  FPaketID := 0;
  FKode := '';
  FBarcode := '';
  FNama := '';
  FNamaStruk := '';
  FUnitID := 0;
  FHargaDasar := 0.0;
  FHargaJual := 0.0;
  FGudangID := 0;
  FDisabledDate := 0;
end;

procedure _MstPaket.InsertOnDB;
begin
  try ExecSQL(
    'INSERT INTO Mst_Paket (Kode,Barcode,Nama,Nama_Struk,Unit_ID,Harga_Dasar,Harga_Jual,Gudang_ID,Disabled_Date)'+
    ' VALUES ('+
      FormatSQLString(FKode)+','+
      FormatSQLString(FBarcode)+','+
      FormatSQLString(FNama)+','+
      FormatSQLString(FNamaStruk)+','+
      FormatSQLNumber(FUnitID)+','+
      FormatSQLNumber(FHargaDasar)+','+
      FormatSQLNumber(FHargaJual)+','+
      FormatSQLNumber(FGudangID)+','+
      FormatSQLDate(FDisabledDate)+')'
  ); except raise; end;
end;

procedure _MstPaket.UpdateOnDB;
begin
  try ExecSQL(
    'UPDATE Mst_Paket SET'+
          ' Kode='+FormatSQLString(FKode)+','+
          ' Barcode='+FormatSQLString(FBarcode)+','+
          ' Nama='+FormatSQLString(FNama)+','+
          ' Nama_Struk='+FormatSQLString(FNamaStruk)+','+
          ' Unit_ID='+FormatSQLNumber(FUnitID)+','+
          ' Harga_Dasar='+FormatSQLNumber(FHargaDasar)+','+
          ' Harga_Jual='+FormatSQLNumber(FHargaJual)+','+
          ' Gudang_ID='+FormatSQLNumber(FGudangID)+','+
          ' Disabled_Date='+FormatSQLDate(FDisabledDate)+
    ' WHERE Paket_ID='+FormatSQLNumber(FPaketID)
  ); except raise; end;
end;

procedure _MstPaket.DeleteOnDB;
begin
  try ExecSQL(
    'DELETE FROM Mst_Paket'+
    ' WHERE Paket_ID='+FormatSQLNumber(FPaketID)
  ); except raise; end;
end;


{ _MstPaketItem_Arr }

constructor _MstPaketItem_Arr.Create(AOwner: TObject);
begin
  inherited Create;
  FOwner := AOwner;
  setLength(FMstPaketItem_Arr,0);
end;

destructor _MstPaketItem_Arr.Destroy;
begin
  Self.Clear;
  inherited;
end;

procedure _MstPaketItem_Arr.Clear;
var i: integer;
begin
  for i:=0 to high(FMstPaketItem_Arr) do FMstPaketItem_Arr[i].Destroy;
  setLength(FMstPaketItem_Arr,0);
end;

function _MstPaketItem_Arr.Add(APaketItemID: integer; APaketID: integer; AItemID: integer; AConvID: integer; AQty: real; AConversion: real; AHarga: real; ADiscount: real; AHrgDasar: real): integer;
begin
  setLength(FMstPaketItem_Arr, length(FMstPaketItem_Arr)+1);
  Result := high(FMstPaketItem_Arr);
  FMstPaketItem_Arr[Result] := _MstPaketItem.Create(Self);
  FMstPaketItem_Arr[Result].PaketItemID := APaketItemID;
  FMstPaketItem_Arr[Result].PaketID := APaketID;
  FMstPaketItem_Arr[Result].ItemID := AItemID;
  FMstPaketItem_Arr[Result].ConvID := AConvID;
  FMstPaketItem_Arr[Result].Qty := AQty;
  FMstPaketItem_Arr[Result].Conversion := AConversion;
  FMstPaketItem_Arr[Result].Harga := AHarga;
  FMstPaketItem_Arr[Result].Discount := ADiscount;
  FMstPaketItem_Arr[Result].HrgDasar := AHrgDasar;
end;

function _MstPaketItem_Arr.IndexOf(APaketItemID: integer): integer;
var i: integer; found: boolean;
begin
  i := 0; found := false;
  while (i<=high(FMstPaketItem_Arr)) and (not found) do
    if (FMstPaketItem_Arr[i].FPaketItemID=APaketItemID) then
      found := true
    else inc(i);
  if (found) then
    Result := i
  else
    Result := -1;
end;

procedure _MstPaketItem_Arr.Delete(Index: integer);
var i: integer;
begin
  if (Index<0) or (Index>high(FMstPaketItem_Arr)) then Exit;
  FMstPaketItem_Arr[Index].Destroy;
  for i:=Index to high(FMstPaketItem_Arr)-1 do
    FMstPaketItem_Arr[Index] := FMstPaketItem_Arr[Index-1];
  setLength(FMstPaketItem_Arr,length(FMstPaketItem_Arr)-1);
end;

function _MstPaketItem_Arr.Count: integer;
begin
  Result := length(FMstPaketItem_Arr);
end;

function _MstPaketItem_Arr.Get(Index: integer): _MstPaketItem;
begin
  if (Index<0) or (Index>high(FMstPaketItem_Arr)) then Result := nil
  else Result := FMstPaketItem_Arr[Index];
end;


{ _MstPaketItem }

constructor _MstPaketItem.Create(AOwner: TObject);
begin
  inherited Create;
  FOwner := AOwner;
end;

destructor _MstPaketItem.Destroy;
begin
  inherited;
end;

procedure _MstPaketItem.Reset;
begin
  FPaketItemID := 0;
  FPaketID := 0;
  FItemID := 0;
  FConvID := 0;
  FQty := 0.0;
  FConversion := 0.0;
  FHarga := 0.0;
  FDiscount := 0.0;
  FHrgDasar := 0.0;
end;

procedure _MstPaketItem.InsertOnDB;
begin
  try ExecSQL(
    'INSERT INTO Mst_Paket_Item (Paket_ID,Item_ID,Conv_ID,Qty,Conversion,Harga,Discount,Hrg_Dasar)'+
    ' VALUES ('+
      FormatSQLNumber(FPaketID)+','+
      FormatSQLNumber(FItemID)+','+
      FormatSQLNumber(FConvID)+','+
      FormatSQLNumber(FQty)+','+
      FormatSQLNumber(FConversion)+','+
      FormatSQLNumber(FHarga)+','+
      FormatSQLNumber(FDiscount)+','+
      FormatSQLNumber(FHrgDasar)+')'
  ); except raise; end;
end;

procedure _MstPaketItem.UpdateOnDB;
begin
  try ExecSQL(
    'UPDATE Mst_Paket_Item SET'+
          ' Paket_ID='+FormatSQLNumber(FPaketID)+','+
          ' Item_ID='+FormatSQLNumber(FItemID)+','+
          ' Conv_ID='+FormatSQLNumber(FConvID)+','+
          ' Qty='+FormatSQLNumber(FQty)+','+
          ' Conversion='+FormatSQLNumber(FConversion)+','+
          ' Harga='+FormatSQLNumber(FHarga)+','+
          ' Discount='+FormatSQLNumber(FDiscount)+','+
          ' Hrg_Dasar='+FormatSQLNumber(FHrgDasar)+
    ' WHERE Paket_Item_ID='+FormatSQLNumber(FPaketItemID)
  ); except raise; end;
end;

procedure _MstPaketItem.DeleteOnDB;
begin
  try ExecSQL(
    'DELETE FROM Mst_Paket_Item'+
    ' WHERE Paket_Item_ID='+FormatSQLNumber(FPaketItemID)
  ); except raise; end;
end;


{ _MstItemSetting_Arr }

constructor _MstItemSetting_Arr.Create(AOwner: TObject);
begin
  inherited Create;
  FOwner := AOwner;
  setLength(FMstItemSetting_Arr,0);
end;

destructor _MstItemSetting_Arr.Destroy;
begin
  Self.Clear;
  inherited;
end;

procedure _MstItemSetting_Arr.Clear;
var i: integer;
begin
  for i:=0 to high(FMstItemSetting_Arr) do FMstItemSetting_Arr[i].Destroy;
  setLength(FMstItemSetting_Arr,0);
end;

function _MstItemSetting_Arr.Add(ASettID: integer; AJenisID: integer; AItemID: integer; AConvID: integer; ABatasBawah: real; ABatasAtas: real; ANilai: real; AFaktor: integer; AAktif: integer): integer;
begin
  setLength(FMstItemSetting_Arr, length(FMstItemSetting_Arr)+1);
  Result := high(FMstItemSetting_Arr);
  FMstItemSetting_Arr[Result] := _MstItemSetting.Create(Self);
  FMstItemSetting_Arr[Result].SettID := ASettID;
  FMstItemSetting_Arr[Result].JenisID := AJenisID;
  FMstItemSetting_Arr[Result].ItemID := AItemID;
  FMstItemSetting_Arr[Result].ConvID := AConvID;
  FMstItemSetting_Arr[Result].BatasBawah := ABatasBawah;
  FMstItemSetting_Arr[Result].BatasAtas := ABatasAtas;
  FMstItemSetting_Arr[Result].Nilai := ANilai;
  FMstItemSetting_Arr[Result].Faktor := AFaktor;
  FMstItemSetting_Arr[Result].Aktif := AAktif;
end;

function _MstItemSetting_Arr.IndexOf(ASettID: integer): integer;
var i: integer; found: boolean;
begin
  i := 0; found := false;
  while (i<=high(FMstItemSetting_Arr)) and (not found) do
    if (FMstItemSetting_Arr[i].FSettID=ASettID) then
      found := true
    else inc(i);
  if (found) then
    Result := i
  else
    Result := -1;
end;

procedure _MstItemSetting_Arr.Delete(Index: integer);
var i: integer;
begin
  if (Index<0) or (Index>high(FMstItemSetting_Arr)) then Exit;
  FMstItemSetting_Arr[Index].Destroy;
  for i:=Index to high(FMstItemSetting_Arr)-1 do
    FMstItemSetting_Arr[Index] := FMstItemSetting_Arr[Index-1];
  setLength(FMstItemSetting_Arr,length(FMstItemSetting_Arr)-1);
end;

function _MstItemSetting_Arr.Count: integer;
begin
  Result := length(FMstItemSetting_Arr);
end;

function _MstItemSetting_Arr.Get(Index: integer): _MstItemSetting;
begin
  if (Index<0) or (Index>high(FMstItemSetting_Arr)) then Result := nil
  else Result := FMstItemSetting_Arr[Index];
end;


{ _MstItemSetting }

constructor _MstItemSetting.Create(AOwner: TObject);
begin
  inherited Create;
  FOwner := AOwner;
end;

destructor _MstItemSetting.Destroy;
begin
  inherited;
end;

procedure _MstItemSetting.Reset;
begin
  FSettID := 0;
  FJenisID := 0;
  FItemID := 0;
  FConvID := 0;
  FBatasBawah := 0.0;
  FBatasAtas := 0.0;
  FNilai := 0.0;
  FFaktor := 0;
  FAktif := 0;
end;

procedure _MstItemSetting.InsertOnDB;
begin
  try ExecSQL(
    'INSERT INTO Mst_Item_Setting (Jenis_ID,Item_ID,Conv_ID,Batas_Bawah,Batas_Atas,Nilai,Faktor,Aktif)'+
    ' VALUES ('+
      FormatSQLNumber(FJenisID)+','+
      FormatSQLNumber(FItemID)+','+
      FormatSQLNumber(FConvID)+','+
      FormatSQLNumber(FBatasBawah)+','+
      FormatSQLNumber(FBatasAtas)+','+
      FormatSQLNumber(FNilai)+','+
      FormatSQLNumber(FFaktor)+','+
      FormatSQLNumber(FAktif)+')'
  ); except raise; end;
end;

procedure _MstItemSetting.UpdateOnDB;
begin
  try ExecSQL(
    'UPDATE Mst_Item_Setting SET'+
          ' Jenis_ID='+FormatSQLNumber(FJenisID)+','+
          ' Item_ID='+FormatSQLNumber(FItemID)+','+
          ' Conv_ID='+FormatSQLNumber(FConvID)+','+
          ' Batas_Bawah='+FormatSQLNumber(FBatasBawah)+','+
          ' Batas_Atas='+FormatSQLNumber(FBatasAtas)+','+
          ' Nilai='+FormatSQLNumber(FNilai)+','+
          ' Faktor='+FormatSQLNumber(FFaktor)+','+
          ' Aktif='+FormatSQLNumber(FAktif)+
    ' WHERE Sett_ID='+FormatSQLNumber(FSettID)
  ); except raise; end;
end;

procedure _MstItemSetting.DeleteOnDB;
begin
  try ExecSQL(
    'DELETE FROM Mst_Item_Setting'+
    ' WHERE Sett_ID='+FormatSQLNumber(FSettID)
  ); except raise; end;
end;


{ _MstRelation_Arr }

constructor _MstRelation_Arr.Create(AOwner: TObject);
begin
  inherited Create;
  FOwner := AOwner;
  setLength(FMstRelation_Arr,0);
end;

destructor _MstRelation_Arr.Destroy;
begin
  Self.Clear;
  inherited;
end;

procedure _MstRelation_Arr.Clear;
var i: integer;
begin
  for i:=0 to high(FMstRelation_Arr) do FMstRelation_Arr[i].Destroy;
  setLength(FMstRelation_Arr,0);
end;

function _MstRelation_Arr.Add(ARelationID: integer; ARelationType: integer; ARelationCode: string; ARelationName: string; AAddress1: string; AAddress2: string; ACity: string; APostCode: string; APhone1: string; APhone2: string; AContactPerson: string; ADueDate: integer; ACurrentDebt: real; ADisabledDate: TDate; ACurrentPoint: real; AFax: string; ANPWP: string): integer;
begin
  setLength(FMstRelation_Arr, length(FMstRelation_Arr)+1);
  Result := high(FMstRelation_Arr);
  FMstRelation_Arr[Result] := _MstRelation.Create(Self);
  FMstRelation_Arr[Result].RelationID := ARelationID;
  FMstRelation_Arr[Result].RelationType := ARelationType;
  FMstRelation_Arr[Result].RelationCode := ARelationCode;
  FMstRelation_Arr[Result].RelationName := ARelationName;
  FMstRelation_Arr[Result].Address1 := AAddress1;
  FMstRelation_Arr[Result].Address2 := AAddress2;
  FMstRelation_Arr[Result].City := ACity;
  FMstRelation_Arr[Result].PostCode := APostCode;
  FMstRelation_Arr[Result].Phone1 := APhone1;
  FMstRelation_Arr[Result].Phone2 := APhone2;
  FMstRelation_Arr[Result].ContactPerson := AContactPerson;
  FMstRelation_Arr[Result].DueDate := ADueDate;
  FMstRelation_Arr[Result].CurrentDebt := ACurrentDebt;
  FMstRelation_Arr[Result].DisabledDate := ADisabledDate;
  FMstRelation_Arr[Result].CurrentPoint := ACurrentPoint;
  FMstRelation_Arr[Result].Fax := AFax;
  FMstRelation_Arr[Result].NPWP := ANPWP;
end;

function _MstRelation_Arr.IndexOf(ARelationID: integer): integer;
var i: integer; found: boolean;
begin
  i := 0; found := false;
  while (i<=high(FMstRelation_Arr)) and (not found) do
    if (FMstRelation_Arr[i].FRelationID=ARelationID) then
      found := true
    else inc(i);
  if (found) then
    Result := i
  else
    Result := -1;
end;

procedure _MstRelation_Arr.Delete(Index: integer);
var i: integer;
begin
  if (Index<0) or (Index>high(FMstRelation_Arr)) then Exit;
  FMstRelation_Arr[Index].Destroy;
  for i:=Index to high(FMstRelation_Arr)-1 do
    FMstRelation_Arr[Index] := FMstRelation_Arr[Index-1];
  setLength(FMstRelation_Arr,length(FMstRelation_Arr)-1);
end;

function _MstRelation_Arr.Count: integer;
begin
  Result := length(FMstRelation_Arr);
end;

function _MstRelation_Arr.Get(Index: integer): _MstRelation;
begin
  if (Index<0) or (Index>high(FMstRelation_Arr)) then Result := nil
  else Result := FMstRelation_Arr[Index];
end;


{ _MstRelation }

constructor _MstRelation.Create(AOwner: TObject);
begin
  inherited Create;
  FOwner := AOwner;
end;

destructor _MstRelation.Destroy;
begin
  inherited;
end;

procedure _MstRelation.Reset;
begin
  FRelationID := 0;
  FRelationType := 0;
  FRelationCode := '';
  FRelationName := '';
  FAddress1 := '';
  FAddress2 := '';
  FCity := '';
  FPostCode := '';
  FPhone1 := '';
  FPhone2 := '';
  FContactPerson := '';
  FDueDate := 0;
  FCurrentDebt := 0.0;
  FDisabledDate := 0;
  FCurrentPoint := 0.0;
  FFax := '';
  FNPWP := '';
end;

procedure _MstRelation.InsertOnDB;
begin
  try ExecSQL(
    'INSERT INTO Mst_Relation (Relation_Type,Relation_Code,Relation_Name,Address1,Address2,City,PostCode,Phone1,Phone2,Contact_Person,Due_Date,Current_Debt,Disabled_Date,Current_Point,Fax,NPWP)'+
    ' VALUES ('+
      FormatSQLNumber(FRelationType)+','+
      FormatSQLString(FRelationCode)+','+
      FormatSQLString(FRelationName)+','+
      FormatSQLString(FAddress1)+','+
      FormatSQLString(FAddress2)+','+
      FormatSQLString(FCity)+','+
      FormatSQLString(FPostCode)+','+
      FormatSQLString(FPhone1)+','+
      FormatSQLString(FPhone2)+','+
      FormatSQLString(FContactPerson)+','+
      FormatSQLNumber(FDueDate)+','+
      FormatSQLNumber(FCurrentDebt)+','+
      FormatSQLDate(FDisabledDate)+','+
      FormatSQLNumber(FCurrentPoint)+','+
      FormatSQLString(FFax)+','+
      FormatSQLString(FNPWP)+')'
  ); except raise; end;
end;

procedure _MstRelation.UpdateOnDB;
begin
  try ExecSQL(
    'UPDATE Mst_Relation SET'+
          ' Relation_Type='+FormatSQLNumber(FRelationType)+','+
          ' Relation_Code='+FormatSQLString(FRelationCode)+','+
          ' Relation_Name='+FormatSQLString(FRelationName)+','+
          ' Address1='+FormatSQLString(FAddress1)+','+
          ' Address2='+FormatSQLString(FAddress2)+','+
          ' City='+FormatSQLString(FCity)+','+
          ' PostCode='+FormatSQLString(FPostCode)+','+
          ' Phone1='+FormatSQLString(FPhone1)+','+
          ' Phone2='+FormatSQLString(FPhone2)+','+
          ' Contact_Person='+FormatSQLString(FContactPerson)+','+
          ' Due_Date='+FormatSQLNumber(FDueDate)+','+
          ' Current_Debt='+FormatSQLNumber(FCurrentDebt)+','+
          ' Disabled_Date='+FormatSQLDate(FDisabledDate)+','+
          ' Current_Point='+FormatSQLNumber(FCurrentPoint)+','+
          ' Fax='+FormatSQLString(FFax)+','+
          ' NPWP='+FormatSQLString(FNPWP)+
    ' WHERE Relation_ID='+FormatSQLNumber(FRelationID)
  ); except raise; end;
end;

procedure _MstRelation.DeleteOnDB;
begin
  try ExecSQL(
    'DELETE FROM Mst_Relation'+
    ' WHERE Relation_ID='+FormatSQLNumber(FRelationID)
  ); except raise; end;
end;

function _MstRelation.SelectInDB(ARelationID: integer): boolean;
var buffer: TMySQLResult;
begin
  buffer := OpenSQL(
    'SELECT MR.Relation_ID, MR.Relation_Type, MR.Relation_Code, MR.Relation_Name, MR.Address1, MR.Address2, MR.City, MR.PostCode, MR.Phone1, MR.Phone2, MR.Contact_Person, MR.Due_Date, MR.Current_Debt, MR.Disabled_Date'+
         ', MR.Current_Point, MR.Fax, MR.NPWP'+
     ' FROM Mst_Relation MR'+
    ' WHERE MR.Relation_ID='+FormatSQLNumber(ARelationID)
  );
  if (buffer.RecordCount<>0) then begin
    FRelationID := BufferToInteger(buffer.FieldValue(0));
    FRelationType := BufferToInteger(buffer.FieldValue(1));
    FRelationCode := BufferToString(buffer.FieldValue(2));
    FRelationName := BufferToString(buffer.FieldValue(3));
    FAddress1 := BufferToString(buffer.FieldValue(4));
    FAddress2 := BufferToString(buffer.FieldValue(5));
    FCity := BufferToString(buffer.FieldValue(6));
    FPostCode := BufferToString(buffer.FieldValue(7));
    FPhone1 := BufferToString(buffer.FieldValue(8));
    FPhone2 := BufferToString(buffer.FieldValue(9));
    FContactPerson := BufferToString(buffer.FieldValue(10));
    FDueDate := BufferToInteger(buffer.FieldValue(11));
    FCurrentDebt := BufferToFloat(buffer.FieldValue(12));
    FDisabledDate := BufferToDateTime(buffer.FieldValue(13));
    FCurrentPoint := BufferToFloat(buffer.FieldValue(14));
    FFax := BufferToString(buffer.FieldValue(15));
    FNPWP := BufferToString(buffer.FieldValue(16));
  end;
  Result := (buffer.RecordCount<>0);
  buffer.Destroy;
end;

class function _MstRelation.ExistInDB(ARelationID: integer): integer;
var buffer: TMySQLResult;
begin
  buffer := OpenSQL(
    'SELECT COUNT(*) FROM Mst_Relation'+
    ' WHERE Relation_ID='+FormatSQLNumber(ARelationID)
  );
  Result := BufferToInteger(buffer.FieldValue(0));
  buffer.Destroy;
end;

{ _MstPasien_Arr }

constructor _MstPasien_Arr.Create(AOwner: TObject);
begin
  inherited Create;
  FOwner := AOwner;
  setLength(FMstPasien_Arr,0);
end;

destructor _MstPasien_Arr.Destroy;
begin
  Self.Clear;
  inherited;
end;

procedure _MstPasien_Arr.Clear;
var i: integer;
begin
  for i:=0 to high(FMstPasien_Arr) do FMstPasien_Arr[i].Destroy;
  setLength(FMstPasien_Arr,0);
end;

function _MstPasien_Arr.Add(APasienID: integer; AKode: string; ANama: string; AAlamat: string; AKota: string; APhone: string; ASex: integer; ATglLahir: TDate; ACardID: string): integer;
begin
  setLength(FMstPasien_Arr, length(FMstPasien_Arr)+1);
  Result := high(FMstPasien_Arr);
  FMstPasien_Arr[Result] := _MstPasien.Create(Self);
  FMstPasien_Arr[Result].PasienID := APasienID;
  FMstPasien_Arr[Result].Kode := AKode;
  FMstPasien_Arr[Result].Nama := ANama;
  FMstPasien_Arr[Result].Alamat := AAlamat;
  FMstPasien_Arr[Result].Kota := AKota;
  FMstPasien_Arr[Result].Phone := APhone;
  FMstPasien_Arr[Result].Sex := ASex;
  FMstPasien_Arr[Result].TglLahir := ATglLahir;
  FMstPasien_Arr[Result].CardID := ACardID;
end;

function _MstPasien_Arr.IndexOf(APasienID: integer): integer;
var i: integer; found: boolean;
begin
  i := 0; found := false;
  while (i<=high(FMstPasien_Arr)) and (not found) do
    if (FMstPasien_Arr[i].FPasienID=APasienID) then
      found := true
    else inc(i);
  if (found) then
    Result := i
  else
    Result := -1;
end;

procedure _MstPasien_Arr.Delete(Index: integer);
var i: integer;
begin
  if (Index<0) or (Index>high(FMstPasien_Arr)) then Exit;
  FMstPasien_Arr[Index].Destroy;
  for i:=Index to high(FMstPasien_Arr)-1 do
    FMstPasien_Arr[Index] := FMstPasien_Arr[Index-1];
  setLength(FMstPasien_Arr,length(FMstPasien_Arr)-1);
end;

function _MstPasien_Arr.Count: integer;
begin
  Result := length(FMstPasien_Arr);
end;

function _MstPasien_Arr.Get(Index: integer): _MstPasien;
begin
  if (Index<0) or (Index>high(FMstPasien_Arr)) then Result := nil
  else Result := FMstPasien_Arr[Index];
end;


{ _MstPasien }

constructor _MstPasien.Create(AOwner: TObject);
begin
  inherited Create;
  FOwner := AOwner;
end;

destructor _MstPasien.Destroy;
begin
  inherited;
end;

procedure _MstPasien.Reset;
begin
  FPasienID := 0;
  FKode := '';
  FNama := '';
  FAlamat := '';
  FKota := '';
  FPhone := '';
  FSex := 0;
  FTglLahir := 0;
  FCardID := '';
end;

procedure _MstPasien.InsertOnDB;
begin
  try ExecSQL(
    'INSERT INTO Mst_Pasien (Kode,Nama,Alamat,Kota,Phone,Sex,Tgl_Lahir,Card_ID)'+
    ' VALUES ('+
      FormatSQLString(FKode)+','+
      FormatSQLString(FNama)+','+
      FormatSQLString(FAlamat)+','+
      FormatSQLString(FKota)+','+
      FormatSQLString(FPhone)+','+
      FormatSQLNumber(FSex)+','+
      FormatSQLDate(FTglLahir)+','+
      FormatSQLString(FCardID)+')'
  ); except raise; end;
end;

procedure _MstPasien.UpdateOnDB;
begin
  try ExecSQL(
    'UPDATE Mst_Pasien SET'+
          ' Kode='+FormatSQLString(FKode)+','+
          ' Nama='+FormatSQLString(FNama)+','+
          ' Alamat='+FormatSQLString(FAlamat)+','+
          ' Kota='+FormatSQLString(FKota)+','+
          ' Phone='+FormatSQLString(FPhone)+','+
          ' Sex='+FormatSQLNumber(FSex)+','+
          ' Tgl_Lahir='+FormatSQLDate(FTglLahir)+','+
          ' Card_ID='+FormatSQLString(FCardID)+
    ' WHERE Pasien_ID='+FormatSQLNumber(FPasienID)
  ); except raise; end;
end;

procedure _MstPasien.DeleteOnDB;
begin
  try ExecSQL(
    'DELETE FROM Mst_Pasien'+
    ' WHERE Pasien_ID='+FormatSQLNumber(FPasienID)
  ); except raise; end;
end;


{ _MstDokter_Arr }

constructor _MstDokter_Arr.Create(AOwner: TObject);
begin
  inherited Create;
  FOwner := AOwner;
  setLength(FMstDokter_Arr,0);
end;

destructor _MstDokter_Arr.Destroy;
begin
  Self.Clear;
  inherited;
end;

procedure _MstDokter_Arr.Clear;
var i: integer;
begin
  for i:=0 to high(FMstDokter_Arr) do FMstDokter_Arr[i].Destroy;
  setLength(FMstDokter_Arr,0);
end;

function _MstDokter_Arr.Add(ADokterID: integer; AKode: string; ANama: string; AAlamat: string; Aklinik: string; AKontak: string; AEmail: string; ALastTransfer: TDate; Aitemid: integer; Aspesialis: string): integer;
begin
  setLength(FMstDokter_Arr, length(FMstDokter_Arr)+1);
  Result := high(FMstDokter_Arr);
  FMstDokter_Arr[Result] := _MstDokter.Create(Self);
  FMstDokter_Arr[Result].DokterID := ADokterID;
  FMstDokter_Arr[Result].Kode := AKode;
  FMstDokter_Arr[Result].Nama := ANama;
  FMstDokter_Arr[Result].Alamat := AAlamat;
  FMstDokter_Arr[Result].klinik := Aklinik;
  FMstDokter_Arr[Result].Kontak := AKontak;
  FMstDokter_Arr[Result].Email := AEmail;
  FMstDokter_Arr[Result].LastTransfer := ALastTransfer;
  FMstDokter_Arr[Result].itemid := Aitemid;
  FMstDokter_Arr[Result].spesialis := Aspesialis;
end;

function _MstDokter_Arr.IndexOf(ADokterID: integer): integer;
var i: integer; found: boolean;
begin
  i := 0; found := false;
  while (i<=high(FMstDokter_Arr)) and (not found) do
    if (FMstDokter_Arr[i].FDokterID=ADokterID) then
      found := true
    else inc(i);
  if (found) then
    Result := i
  else
    Result := -1;
end;

procedure _MstDokter_Arr.Delete(Index: integer);
var i: integer;
begin
  if (Index<0) or (Index>high(FMstDokter_Arr)) then Exit;
  FMstDokter_Arr[Index].Destroy;
  for i:=Index to high(FMstDokter_Arr)-1 do
    FMstDokter_Arr[Index] := FMstDokter_Arr[Index-1];
  setLength(FMstDokter_Arr,length(FMstDokter_Arr)-1);
end;

function _MstDokter_Arr.Count: integer;
begin
  Result := length(FMstDokter_Arr);
end;

function _MstDokter_Arr.Get(Index: integer): _MstDokter;
begin
  if (Index<0) or (Index>high(FMstDokter_Arr)) then Result := nil
  else Result := FMstDokter_Arr[Index];
end;


{ _MstDokter }

constructor _MstDokter.Create(AOwner: TObject);
begin
  inherited Create;
  FOwner := AOwner;
end;

destructor _MstDokter.Destroy;
begin
  inherited;
end;

procedure _MstDokter.Reset;
begin
  FDokterID := 0;
  FKode := '';
  FNama := '';
  FAlamat := '';
  Fklinik := '';
  FKontak := '';
  FEmail := '';
  FLastTransfer := 0;
  Fitemid := 0;
  Fspesialis := '';
end;

procedure _MstDokter.InsertOnDB;
begin
  try ExecSQL(
    'INSERT INTO Mst_Dokter (Kode,Nama,Alamat,klinik,Kontak,Email,Last_Transfer,item_id,spesialis)'+
    ' VALUES ('+
      FormatSQLString(FKode)+','+
      FormatSQLString(FNama)+','+
      FormatSQLString(FAlamat)+','+
      FormatSQLString(Fklinik)+','+
      FormatSQLString(FKontak)+','+
      FormatSQLString(FEmail)+','+
      FormatSQLDate(FLastTransfer)+','+
      FormatSQLNumber(Fitemid)+','+
      FormatSQLString(Fspesialis)+')'
  ); except raise; end;
end;

procedure _MstDokter.UpdateOnDB;
begin
  try ExecSQL(
    'UPDATE Mst_Dokter SET'+
          ' Kode='+FormatSQLString(FKode)+','+
          ' Nama='+FormatSQLString(FNama)+','+
          ' Alamat='+FormatSQLString(FAlamat)+','+
          ' klinik='+FormatSQLString(Fklinik)+','+
          ' Kontak='+FormatSQLString(FKontak)+','+
          ' Email='+FormatSQLString(FEmail)+','+
          ' Last_Transfer='+FormatSQLDate(FLastTransfer)+','+
          ' item_id='+FormatSQLNumber(Fitemid)+','+
          ' spesialis='+FormatSQLString(Fspesialis)+
    ' WHERE Dokter_ID='+FormatSQLNumber(FDokterID)
  ); except raise; end;
end;

procedure _MstDokter.DeleteOnDB;
begin
  try ExecSQL(
    'DELETE FROM Mst_Dokter'+
    ' WHERE Dokter_ID='+FormatSQLNumber(FDokterID)
  ); except raise; end;
end;


{ _InvItemBalance_Arr }

constructor _InvItemBalance_Arr.Create(AOwner: TObject);
begin
  inherited Create;
  FOwner := AOwner;
  setLength(FInvItemBalance_Arr,0);
end;

destructor _InvItemBalance_Arr.Destroy;
begin
  Self.Clear;
  inherited;
end;

procedure _InvItemBalance_Arr.Clear;
var i: integer;
begin
  for i:=0 to high(FInvItemBalance_Arr) do FInvItemBalance_Arr[i].Destroy;
  setLength(FInvItemBalance_Arr,0);
end;

function _InvItemBalance_Arr.Add(AItemBalanceID: integer; AItemID: integer; ABalanceDate: TDate; AStorageID: integer; ABalance: real): integer;
begin
  setLength(FInvItemBalance_Arr, length(FInvItemBalance_Arr)+1);
  Result := high(FInvItemBalance_Arr);
  FInvItemBalance_Arr[Result] := _InvItemBalance.Create(Self);
  FInvItemBalance_Arr[Result].ItemBalanceID := AItemBalanceID;
  FInvItemBalance_Arr[Result].ItemID := AItemID;
  FInvItemBalance_Arr[Result].BalanceDate := ABalanceDate;
  FInvItemBalance_Arr[Result].StorageID := AStorageID;
  FInvItemBalance_Arr[Result].Balance := ABalance;
end;

function _InvItemBalance_Arr.IndexOf(AItemBalanceID: integer): integer;
var i: integer; found: boolean;
begin
  i := 0; found := false;
  while (i<=high(FInvItemBalance_Arr)) and (not found) do
    if (FInvItemBalance_Arr[i].FItemBalanceID=AItemBalanceID) then
      found := true
    else inc(i);
  if (found) then
    Result := i
  else
    Result := -1;
end;

procedure _InvItemBalance_Arr.Delete(Index: integer);
var i: integer;
begin
  if (Index<0) or (Index>high(FInvItemBalance_Arr)) then Exit;
  FInvItemBalance_Arr[Index].Destroy;
  for i:=Index to high(FInvItemBalance_Arr)-1 do
    FInvItemBalance_Arr[Index] := FInvItemBalance_Arr[Index-1];
  setLength(FInvItemBalance_Arr,length(FInvItemBalance_Arr)-1);
end;

function _InvItemBalance_Arr.Count: integer;
begin
  Result := length(FInvItemBalance_Arr);
end;

function _InvItemBalance_Arr.Get(Index: integer): _InvItemBalance;
begin
  if (Index<0) or (Index>high(FInvItemBalance_Arr)) then Result := nil
  else Result := FInvItemBalance_Arr[Index];
end;


{ _InvItemBalance }

constructor _InvItemBalance.Create(AOwner: TObject);
begin
  inherited Create;
  FOwner := AOwner;
end;

destructor _InvItemBalance.Destroy;
begin
  inherited;
end;

procedure _InvItemBalance.Reset;
begin
  FItemBalanceID := 0;
  FItemID := 0;
  FBalanceDate := 0;
  FStorageID := 0;
  FBalance := 0.0;
end;

procedure _InvItemBalance.InsertOnDB;
begin
  try ExecSQL(
    'INSERT INTO Inv_Item_Balance (Item_ID,Balance_Date,Storage_ID,Balance)'+
    ' VALUES ('+
      FormatSQLNumber(FItemID)+','+
      FormatSQLDate(FBalanceDate)+','+
      FormatSQLNumber(FStorageID)+','+
      FormatSQLNumber(FBalance)+')'
  ); except raise; end;
end;

procedure _InvItemBalance.UpdateOnDB;
begin
  try ExecSQL(
    'UPDATE Inv_Item_Balance SET'+
          ' Item_ID='+FormatSQLNumber(FItemID)+','+
          ' Balance_Date='+FormatSQLDate(FBalanceDate)+','+
          ' Storage_ID='+FormatSQLNumber(FStorageID)+','+
          ' Balance='+FormatSQLNumber(FBalance)+
    ' WHERE Item_Balance_ID='+FormatSQLNumber(FItemBalanceID)
  ); except raise; end;
end;

procedure _InvItemBalance.DeleteOnDB;
begin
  try ExecSQL(
    'DELETE FROM Inv_Item_Balance'+
    ' WHERE Item_Balance_ID='+FormatSQLNumber(FItemBalanceID)
  ); except raise; end;
end;


{ _InvCashierBalance_Arr }

constructor _InvCashierBalance_Arr.Create(AOwner: TObject);
begin
  inherited Create;
  FOwner := AOwner;
  setLength(FInvCashierBalance_Arr,0);
end;

destructor _InvCashierBalance_Arr.Destroy;
begin
  Self.Clear;
  inherited;
end;

procedure _InvCashierBalance_Arr.Clear;
var i: integer;
begin
  for i:=0 to high(FInvCashierBalance_Arr) do FInvCashierBalance_Arr[i].Destroy;
  setLength(FInvCashierBalance_Arr,0);
end;

function _InvCashierBalance_Arr.Add(ACashierBalanceID: integer; ACashierID: integer; AShiftID: integer; AUserID: string; ABalanceDate: TDate; ABalance: real): integer;
begin
  setLength(FInvCashierBalance_Arr, length(FInvCashierBalance_Arr)+1);
  Result := high(FInvCashierBalance_Arr);
  FInvCashierBalance_Arr[Result] := _InvCashierBalance.Create(Self);
  FInvCashierBalance_Arr[Result].CashierBalanceID := ACashierBalanceID;
  FInvCashierBalance_Arr[Result].CashierID := ACashierID;
  FInvCashierBalance_Arr[Result].ShiftID := AShiftID;
  FInvCashierBalance_Arr[Result].UserID := AUserID;
  FInvCashierBalance_Arr[Result].BalanceDate := ABalanceDate;
  FInvCashierBalance_Arr[Result].Balance := ABalance;
end;

function _InvCashierBalance_Arr.IndexOf(ACashierBalanceID: integer): integer;
var i: integer; found: boolean;
begin
  i := 0; found := false;
  while (i<=high(FInvCashierBalance_Arr)) and (not found) do
    if (FInvCashierBalance_Arr[i].FCashierBalanceID=ACashierBalanceID) then
      found := true
    else inc(i);
  if (found) then
    Result := i
  else
    Result := -1;
end;

procedure _InvCashierBalance_Arr.Delete(Index: integer);
var i: integer;
begin
  if (Index<0) or (Index>high(FInvCashierBalance_Arr)) then Exit;
  FInvCashierBalance_Arr[Index].Destroy;
  for i:=Index to high(FInvCashierBalance_Arr)-1 do
    FInvCashierBalance_Arr[Index] := FInvCashierBalance_Arr[Index-1];
  setLength(FInvCashierBalance_Arr,length(FInvCashierBalance_Arr)-1);
end;

function _InvCashierBalance_Arr.Count: integer;
begin
  Result := length(FInvCashierBalance_Arr);
end;

function _InvCashierBalance_Arr.Get(Index: integer): _InvCashierBalance;
begin
  if (Index<0) or (Index>high(FInvCashierBalance_Arr)) then Result := nil
  else Result := FInvCashierBalance_Arr[Index];
end;


{ _InvCashierBalance }

constructor _InvCashierBalance.Create(AOwner: TObject);
begin
  inherited Create;
  FOwner := AOwner;
end;

destructor _InvCashierBalance.Destroy;
begin
  inherited;
end;

procedure _InvCashierBalance.Reset;
begin
  FCashierBalanceID := 0;
  FCashierID := 0;
  FShiftID := 0;
  FUserID := '';
  FBalanceDate := 0;
  FBalance := 0.0;
end;

procedure _InvCashierBalance.InsertOnDB;
begin
  try ExecSQL(
    'INSERT INTO Inv_Cashier_Balance (Cashier_ID,Shift_ID,User_ID,Balance_Date,Balance)'+
    ' VALUES ('+
      FormatSQLNumber(FCashierID)+','+
      FormatSQLNumber(FShiftID)+','+
      FormatSQLString(FUserID)+','+
      FormatSQLDate(FBalanceDate)+','+
      FormatSQLNumber(FBalance)+')'
  ); except raise; end;
end;

procedure _InvCashierBalance.UpdateOnDB;
begin
  try ExecSQL(
    'UPDATE Inv_Cashier_Balance SET'+
          ' Cashier_ID='+FormatSQLNumber(FCashierID)+','+
          ' Shift_ID='+FormatSQLNumber(FShiftID)+','+
          ' User_ID='+FormatSQLString(FUserID)+','+
          ' Balance_Date='+FormatSQLDate(FBalanceDate)+','+
          ' Balance='+FormatSQLNumber(FBalance)+
    ' WHERE Cashier_Balance_ID='+FormatSQLNumber(FCashierBalanceID)
  ); except raise; end;
end;

procedure _InvCashierBalance.DeleteOnDB;
begin
  try ExecSQL(
    'DELETE FROM Inv_Cashier_Balance'+
    ' WHERE Cashier_Balance_ID='+FormatSQLNumber(FCashierBalanceID)
  ); except raise; end;
end;


{ _TrsShipmentMst_Arr }

constructor _TrsShipmentMst_Arr.Create(AOwner: TObject);
begin
  inherited Create;
  FOwner := AOwner;
  setLength(FTrsShipmentMst_Arr,0);
end;

destructor _TrsShipmentMst_Arr.Destroy;
begin
  Self.Clear;
  inherited;
end;

procedure _TrsShipmentMst_Arr.Clear;
var i: integer;
begin
  for i:=0 to high(FTrsShipmentMst_Arr) do FTrsShipmentMst_Arr[i].Destroy;
  setLength(FTrsShipmentMst_Arr,0);
end;

function _TrsShipmentMst_Arr.Add(AShipID: integer; ATipe: integer; ATransNum: string; ATransDate: TDate; AGudangAsal: integer; AGudangTujuan: integer; ANotes: string; AUserID: string): integer;
begin
  setLength(FTrsShipmentMst_Arr, length(FTrsShipmentMst_Arr)+1);
  Result := high(FTrsShipmentMst_Arr);
  FTrsShipmentMst_Arr[Result] := _TrsShipmentMst.Create(Self);
  FTrsShipmentMst_Arr[Result].ShipID := AShipID;
  FTrsShipmentMst_Arr[Result].Tipe := ATipe;
  FTrsShipmentMst_Arr[Result].TransNum := ATransNum;
  FTrsShipmentMst_Arr[Result].TransDate := ATransDate;
  FTrsShipmentMst_Arr[Result].GudangAsal := AGudangAsal;
  FTrsShipmentMst_Arr[Result].GudangTujuan := AGudangTujuan;
  FTrsShipmentMst_Arr[Result].Notes := ANotes;
  FTrsShipmentMst_Arr[Result].UserID := AUserID;
end;

procedure _TrsShipmentMst_Arr.Delete(Index: integer);
var i: integer;
begin
  if (Index<0) or (Index>high(FTrsShipmentMst_Arr)) then Exit;
  FTrsShipmentMst_Arr[Index].Destroy;
  for i:=Index to high(FTrsShipmentMst_Arr)-1 do
    FTrsShipmentMst_Arr[Index] := FTrsShipmentMst_Arr[Index-1];
  setLength(FTrsShipmentMst_Arr,length(FTrsShipmentMst_Arr)-1);
end;

function _TrsShipmentMst_Arr.Count: integer;
begin
  Result := length(FTrsShipmentMst_Arr);
end;

function _TrsShipmentMst_Arr.Get(Index: integer): _TrsShipmentMst;
begin
  if (Index<0) or (Index>high(FTrsShipmentMst_Arr)) then Result := nil
  else Result := FTrsShipmentMst_Arr[Index];
end;


{ _TrsShipmentMst }

constructor _TrsShipmentMst.Create(AOwner: TObject);
begin
  inherited Create;
  FOwner := AOwner;
end;

destructor _TrsShipmentMst.Destroy;
begin
  inherited;
end;

procedure _TrsShipmentMst.Reset;
begin
  FShipID := 0;
  FTipe := 0;
  FTransNum := '';
  FTransDate := 0;
  FGudangAsal := 0;
  FGudangTujuan := 0;
  FNotes := '';
  FUserID := '';
end;

procedure _TrsShipmentMst.InsertOnDB;
begin
  try ExecSQL(
    'INSERT INTO Trs_Shipment_Mst (Tipe,Trans_Num,Trans_Date,Gudang_Asal,Gudang_Tujuan,Notes,User_ID)'+
    ' VALUES ('+
      FormatSQLNumber(FTipe)+','+
      FormatSQLString(FTransNum)+','+
      FormatSQLDate(FTransDate)+','+
      FormatSQLNumber(FGudangAsal)+','+
      FormatSQLNumber(FGudangTujuan)+','+
      FormatSQLString(FNotes)+','+
      FormatSQLString(FUserID)+')'
  ); except raise; end;
end;

procedure _TrsShipmentMst.UpdateOnDB;
begin
  try ExecSQL(
    'UPDATE Trs_Shipment_Mst SET'+
          ' Ship_ID='+FormatSQLNumber(FShipID)+','+
          ' Tipe='+FormatSQLNumber(FTipe)+','+
          ' Trans_Num='+FormatSQLString(FTransNum)+','+
          ' Trans_Date='+FormatSQLDate(FTransDate)+','+
          ' Gudang_Asal='+FormatSQLNumber(FGudangAsal)+','+
          ' Gudang_Tujuan='+FormatSQLNumber(FGudangTujuan)+','+
          ' Notes='+FormatSQLString(FNotes)+','+
          ' User_ID='+FormatSQLString(FUserID)+
    ''
  ); except raise; end;
end;

procedure _TrsShipmentMst.DeleteOnDB;
begin
  try ExecSQL(
    'DELETE FROM Trs_Shipment_Mst'+
    ''
  ); except raise; end;
end;


{ _TrsShipmentDetail_Arr }

constructor _TrsShipmentDetail_Arr.Create(AOwner: TObject);
begin
  inherited Create;
  FOwner := AOwner;
  setLength(FTrsShipmentDetail_Arr,0);
end;

destructor _TrsShipmentDetail_Arr.Destroy;
begin
  Self.Clear;
  inherited;
end;

procedure _TrsShipmentDetail_Arr.Clear;
var i: integer;
begin
  for i:=0 to high(FTrsShipmentDetail_Arr) do FTrsShipmentDetail_Arr[i].Destroy;
  setLength(FTrsShipmentDetail_Arr,0);
end;

function _TrsShipmentDetail_Arr.Add(AShipDetailID: integer; AShipID: integer; AItemID: integer;
AConvID: integer; AQuantity: real; APriceSales: real; APricePurchase: real; APriceCost: real;
AConversion: real; ADbCrType: string; AHrgBeli: real;AStok:real;AQuantiryOri:real): integer;
begin
  setLength(FTrsShipmentDetail_Arr, length(FTrsShipmentDetail_Arr)+1);
  Result := high(FTrsShipmentDetail_Arr);
  FTrsShipmentDetail_Arr[Result] := _TrsShipmentDetail.Create(Self);
  FTrsShipmentDetail_Arr[Result].ShipDetailID := AShipDetailID;
  FTrsShipmentDetail_Arr[Result].ShipID := AShipID;
  FTrsShipmentDetail_Arr[Result].MstItem.ItemID := AItemID;
  FTrsShipmentDetail_Arr[Result].MstItemConversion.ConvID := AConvID;
  FTrsShipmentDetail_Arr[Result].Quantity := AQuantity;
  FTrsShipmentDetail_Arr[Result].PriceSales := APriceSales;
  FTrsShipmentDetail_Arr[Result].PricePurchase := APricePurchase;
  FTrsShipmentDetail_Arr[Result].PriceCost := APriceCost;
  FTrsShipmentDetail_Arr[Result].Conversion := AConversion;
  FTrsShipmentDetail_Arr[Result].DbCrType := ADbCrType;
  FTrsShipmentDetail_Arr[Result].HrgBeli := AHrgBeli;
  FTrsShipmentDetail_Arr[Result].Stok := AStok;
  FTrsShipmentDetail_Arr[Result].QuantityOri := AQuantiryOri;

end;

function _TrsShipmentDetail_Arr.IndexOf(AShipDetailID: integer): integer;
var i: integer; found: boolean;
begin
  i := 0; found := false;
  while (i<=high(FTrsShipmentDetail_Arr)) and (not found) do
    if (FTrsShipmentDetail_Arr[i].FShipDetailID=AShipDetailID) then
      found := true
    else inc(i);
  if (found) then
    Result := i
  else
    Result := -1;
end;

procedure _TrsShipmentDetail_Arr.Delete(Index: integer);
var i: integer;
begin
  if (Index<0) or (Index>high(FTrsShipmentDetail_Arr)) then Exit;
  FTrsShipmentDetail_Arr[Index].Destroy;
  for i:=Index to high(FTrsShipmentDetail_Arr)-1 do
    FTrsShipmentDetail_Arr[Index] := FTrsShipmentDetail_Arr[Index-1];
  setLength(FTrsShipmentDetail_Arr,length(FTrsShipmentDetail_Arr)-1);
end;

function _TrsShipmentDetail_Arr.Count: integer;
begin
  Result := length(FTrsShipmentDetail_Arr);
end;

function _TrsShipmentDetail_Arr.Get(Index: integer): _TrsShipmentDetail;
begin
  if (Index<0) or (Index>high(FTrsShipmentDetail_Arr)) then Result := nil
  else Result := FTrsShipmentDetail_Arr[Index];
end;


{ _TrsShipmentDetail }

constructor _TrsShipmentDetail.Create(AOwner: TObject);
begin
  inherited Create;
  FOwner := AOwner;
  FMstItem := _MstItem.Create(Self);
  FMstItemConversion := _MstItemConversion.Create(Self);
end;

destructor _TrsShipmentDetail.Destroy;
begin
  FMstItem.Destroy;
  FMstItemConversion.Destroy;
  inherited;
end;

procedure _TrsShipmentDetail.Reset;
begin
  FShipDetailID := 0;
  FShipID := 0;
  FMstItem.Reset;
  FMstItemConversion.Reset;
  FQuantity := 0.0;
  FPriceSales := 0.0;
  FPricePurchase := 0.0;
  FPriceCost := 0.0;
  FConversion := 0.0;
  FDbCrType := '';
  FHrgBeli := 0.0;
  FStok := 0.0;
  FQuantityOri := 0;
end;

procedure _TrsShipmentDetail.InsertOnDB;
begin
  try ExecSQL(
    'INSERT INTO Trs_Shipment_Detail (Ship_ID,Item_ID,Conv_ID,Quantity,Price_Sales,Price_Purchase,Price_Cost,Conversion,DbCrType,Hrg_Beli)'+
    ' VALUES ('+
      FormatSQLNumber(FShipID)+','+
      FormatSQLNumber(FMstItem.ItemID)+','+
      FormatSQLNumber(FMstItemConversion.ConvID)+','+
      FormatSQLNumber(FQuantity)+','+
      FormatSQLNumber(FPriceSales)+','+
      FormatSQLNumber(FPricePurchase)+','+
      FormatSQLNumber(FPriceCost)+','+
      FormatSQLNumber(FConversion)+','+
      FormatSQLString(FDbCrType)+','+
      FormatSQLNumber(FHrgBeli)+')'
  ); except raise; end;
end;

procedure _TrsShipmentDetail.UpdateOnDB;
begin
  try ExecSQL(
    'UPDATE Trs_Shipment_Detail SET'+
          ' Ship_ID='+FormatSQLNumber(FShipID)+','+
          ' Item_ID='+FormatSQLNumber(FMstItem.ItemID)+','+
          ' Conv_ID='+FormatSQLNumber(FMstItemConversion.ConvID)+','+
          ' Quantity='+FormatSQLNumber(FQuantity)+','+
          ' Price_Sales='+FormatSQLNumber(FPriceSales)+','+
          ' Price_Purchase='+FormatSQLNumber(FPricePurchase)+','+
          ' Price_Cost='+FormatSQLNumber(FPriceCost)+','+
          ' Conversion='+FormatSQLNumber(FConversion)+','+
          ' DbCrType='+FormatSQLString(FDbCrType)+','+
          ' Hrg_Beli='+FormatSQLNumber(FHrgBeli)+
    ' WHERE Ship_Detail_ID='+FormatSQLNumber(FShipDetailID)
  ); except raise; end;
end;

procedure _TrsShipmentDetail.DeleteOnDB;
begin
  try ExecSQL(
    'DELETE FROM Trs_Shipment_Detail'+
    ' WHERE Ship_Detail_ID='+FormatSQLNumber(FShipDetailID)
  ); except raise; end;
end;


{ _TrsSalesMst_Arr }

constructor _TrsSalesMst_Arr.Create(AOwner: TObject);
begin
  inherited Create;
  FOwner := AOwner;
  setLength(FTrsSalesMst_Arr,0);
end;

destructor _TrsSalesMst_Arr.Destroy;
begin
  Self.Clear;
  inherited;
end;

procedure _TrsSalesMst_Arr.Clear;
var i: integer;
begin
  for i:=0 to high(FTrsSalesMst_Arr) do FTrsSalesMst_Arr[i].Destroy;
  setLength(FTrsSalesMst_Arr,0);
end;

function _TrsSalesMst_Arr.Add(ASalesID: integer; ATransNum: string; ATransType: integer; ATransDate: TDate; ACashierID: integer; AGudangID: integer; ASubtotal: real; ADiscMst: real; ADiscValMst: real; ATax: real; ATotal: real; ACash: real; AUserID: string; Aprofit: real; APasienID: integer; APoints: integer; ADiscDetail: real; ARealAmount: real; ADokterID: integer; ANoResep: string; ACaraBayar: integer; ACardID: string; ABank: string; AEmbalase: real): integer;
begin
  setLength(FTrsSalesMst_Arr, length(FTrsSalesMst_Arr)+1);
  Result := high(FTrsSalesMst_Arr);
  FTrsSalesMst_Arr[Result] := _TrsSalesMst.Create(Self);
  FTrsSalesMst_Arr[Result].SalesID := ASalesID;
  FTrsSalesMst_Arr[Result].TransNum := ATransNum;
  FTrsSalesMst_Arr[Result].TransType := ATransType;
  FTrsSalesMst_Arr[Result].TransDate := ATransDate;
  FTrsSalesMst_Arr[Result].CashierID := ACashierID;
  FTrsSalesMst_Arr[Result].GudangID := AGudangID;
  FTrsSalesMst_Arr[Result].Subtotal := ASubtotal;
  FTrsSalesMst_Arr[Result].DiscMst := ADiscMst;
  FTrsSalesMst_Arr[Result].DiscValMst := ADiscValMst;
  FTrsSalesMst_Arr[Result].Tax := ATax;
  FTrsSalesMst_Arr[Result].Total := ATotal;
  FTrsSalesMst_Arr[Result].Cash := ACash;
  FTrsSalesMst_Arr[Result].UserID := AUserID;
  FTrsSalesMst_Arr[Result].profit := Aprofit;
  FTrsSalesMst_Arr[Result].PasienID := APasienID;
  FTrsSalesMst_Arr[Result].Points := APoints;
  FTrsSalesMst_Arr[Result].DiscDetail := ADiscDetail;
  FTrsSalesMst_Arr[Result].RealAmount := ARealAmount;
  FTrsSalesMst_Arr[Result].DokterID := ADokterID;
  FTrsSalesMst_Arr[Result].NoResep := ANoResep;
  FTrsSalesMst_Arr[Result].CaraBayar := ACaraBayar;
  FTrsSalesMst_Arr[Result].CardID := ACardID;
  FTrsSalesMst_Arr[Result].Bank := ABank;
  FTrsSalesMst_Arr[Result].Embalase := AEmbalase;
end;

function _TrsSalesMst_Arr.IndexOf(ASalesID: integer): integer;
var i: integer; found: boolean;
begin
  i := 0; found := false;
  while (i<=high(FTrsSalesMst_Arr)) and (not found) do
    if (FTrsSalesMst_Arr[i].FSalesID=ASalesID) then
      found := true
    else inc(i);
  if (found) then
    Result := i
  else
    Result := -1;
end;

procedure _TrsSalesMst_Arr.Delete(Index: integer);
var i: integer;
begin
  if (Index<0) or (Index>high(FTrsSalesMst_Arr)) then Exit;
  FTrsSalesMst_Arr[Index].Destroy;
  for i:=Index to high(FTrsSalesMst_Arr)-1 do
    FTrsSalesMst_Arr[Index] := FTrsSalesMst_Arr[Index-1];
  setLength(FTrsSalesMst_Arr,length(FTrsSalesMst_Arr)-1);
end;

function _TrsSalesMst_Arr.Count: integer;
begin
  Result := length(FTrsSalesMst_Arr);
end;

function _TrsSalesMst_Arr.Get(Index: integer): _TrsSalesMst;
begin
  if (Index<0) or (Index>high(FTrsSalesMst_Arr)) then Result := nil
  else Result := FTrsSalesMst_Arr[Index];
end;


{ _TrsSalesMst }

constructor _TrsSalesMst.Create(AOwner: TObject);
begin
  inherited Create;
  FOwner := AOwner;
end;

destructor _TrsSalesMst.Destroy;
begin
  inherited;
end;

procedure _TrsSalesMst.Reset;
begin
  FSalesID := 0;
  FTransNum := '';
  FTransType := 0;
  FTransDate := 0;
  FCashierID := 0;
  FGudangID := 0;
  FSubtotal := 0.0;
  FDiscMst := 0.0;
  FDiscValMst := 0.0;
  FTax := 0.0;
  FTotal := 0.0;
  FCash := 0.0;
  FUserID := '';
  Fprofit := 0.0;
  FPasienID := 0;
  FPoints := 0;
  FDiscDetail := 0.0;
  FRealAmount := 0.0;
  FDokterID := 0;
  FNoResep := '';
  FCaraBayar := 0;
  FCardID := '';
  FBank := '';
  FEmbalase := 0.0;
end;

procedure _TrsSalesMst.InsertOnDB;
begin
  try ExecSQL(
    'INSERT INTO Trs_Sales_Mst (Trans_Num,Trans_Type,Trans_Date,Cashier_ID,Gudang_ID,Subtotal,Disc_Mst,Disc_Val_Mst,Tax,Total,Cash,User_ID,profit,Pasien_ID,Points,Disc_Detail,Real_Amount,Dokter_ID,No_Resep,'+
    'Cara_Bayar,Card_ID,Bank,Embalase)'+
    ' VALUES ('+
      FormatSQLString(FTransNum)+','+
      FormatSQLNumber(FTransType)+','+
      FormatSQLDate(FTransDate)+','+
      FormatSQLNumber(FCashierID)+','+
      FormatSQLNumber(FGudangID)+','+
      FormatSQLNumber(FSubtotal)+','+
      FormatSQLNumber(FDiscMst)+','+
      FormatSQLNumber(FDiscValMst)+','+
      FormatSQLNumber(FTax)+','+
      FormatSQLNumber(FTotal)+','+
      FormatSQLNumber(FCash)+','+
      FormatSQLString(FUserID)+','+
      FormatSQLNumber(Fprofit)+','+
      FormatSQLNumber(FPasienID)+','+
      FormatSQLNumber(FPoints)+','+
      FormatSQLNumber(FDiscDetail)+','+
      FormatSQLNumber(FRealAmount)+','+
      FormatSQLNumber(FDokterID)+','+
      FormatSQLString(FNoResep)+','+
      FormatSQLNumber(FCaraBayar)+','+
      FormatSQLString(FCardID)+','+
      FormatSQLString(FBank)+','+
      FormatSQLNumber(FEmbalase)+')'
  ); except raise; end;
end;

procedure _TrsSalesMst.UpdateOnDB;
begin
  try ExecSQL(
    'UPDATE Trs_Sales_Mst SET'+
          ' Trans_Num='+FormatSQLString(FTransNum)+','+
          ' Trans_Type='+FormatSQLNumber(FTransType)+','+
          ' Trans_Date='+FormatSQLDate(FTransDate)+','+
          ' Cashier_ID='+FormatSQLNumber(FCashierID)+','+
          ' Gudang_ID='+FormatSQLNumber(FGudangID)+','+
          ' Subtotal='+FormatSQLNumber(FSubtotal)+','+
          ' Disc_Mst='+FormatSQLNumber(FDiscMst)+','+
          ' Disc_Val_Mst='+FormatSQLNumber(FDiscValMst)+','+
          ' Tax='+FormatSQLNumber(FTax)+','+
          ' Total='+FormatSQLNumber(FTotal)+','+
          ' Cash='+FormatSQLNumber(FCash)+','+
          ' User_ID='+FormatSQLString(FUserID)+','+
          ' profit='+FormatSQLNumber(Fprofit)+','+
          ' Pasien_ID='+FormatSQLNumber(FPasienID)+','+
          ' Points='+FormatSQLNumber(FPoints)+','+
          ' Disc_Detail='+FormatSQLNumber(FDiscDetail)+','+
          ' Real_Amount='+FormatSQLNumber(FRealAmount)+','+
          ' Dokter_ID='+FormatSQLNumber(FDokterID)+','+
          ' No_Resep='+FormatSQLString(FNoResep)+','+
          ' Cara_Bayar='+FormatSQLNumber(FCaraBayar)+','+
          ' Card_ID='+FormatSQLString(FCardID)+','+
          ' Bank='+FormatSQLString(FBank)+','+
          ' Embalase='+FormatSQLNumber(FEmbalase)+
    ' WHERE Sales_ID='+FormatSQLNumber(FSalesID)
  ); except raise; end;
end;

procedure _TrsSalesMst.DeleteOnDB;
begin
  try ExecSQL(
    'DELETE FROM Trs_Sales_Mst'+
    ' WHERE Sales_ID='+FormatSQLNumber(FSalesID)
  ); except raise; end;
end;


{ _TrsSalesDetail_Arr }

constructor _TrsSalesDetail_Arr.Create(AOwner: TObject);
begin
  inherited Create;
  FOwner := AOwner;
  setLength(FTrsSalesDetail_Arr,0);
end;

destructor _TrsSalesDetail_Arr.Destroy;
begin
  Self.Clear;
  inherited;
end;

procedure _TrsSalesDetail_Arr.Clear;
var i: integer;
begin
  for i:=0 to high(FTrsSalesDetail_Arr) do FTrsSalesDetail_Arr[i].Destroy;
  setLength(FTrsSalesDetail_Arr,0);
end;

function _TrsSalesDetail_Arr.Add(ASalesDetailID: integer; ASalesID: integer; AItemID: integer; AConvID: integer; AQuantity: real; APrice: real;
  ADisc: real; ADiscVal: real; AAmount: real; AConversion: real; APricePurchase: real; AAmountProfit: real; APoints: integer; APaketID: integer;
  AConvBonusID: integer; AQtyBonus: real; AConvBonus: real; AHrgBeli: real;
   AServiceType:integer;AIsFree:integer;AAnimalID:integer): integer;
begin
  setLength(FTrsSalesDetail_Arr, length(FTrsSalesDetail_Arr)+1);
  Result := high(FTrsSalesDetail_Arr);
  FTrsSalesDetail_Arr[Result] := _TrsSalesDetail.Create(Self);
  FTrsSalesDetail_Arr[Result].SalesDetailID := ASalesDetailID;
  FTrsSalesDetail_Arr[Result].SalesID := ASalesID;
  FTrsSalesDetail_Arr[Result].MstItem.ItemID := AItemID;
  FTrsSalesDetail_Arr[Result].MstItemConversion.ConvID := AConvID;
  FTrsSalesDetail_Arr[Result].Quantity := AQuantity;
  FTrsSalesDetail_Arr[Result].Price := APrice;
  FTrsSalesDetail_Arr[Result].Disc := ADisc;
  FTrsSalesDetail_Arr[Result].DiscVal := ADiscVal;
  FTrsSalesDetail_Arr[Result].Amount := AAmount;
  FTrsSalesDetail_Arr[Result].Conversion := AConversion;
  FTrsSalesDetail_Arr[Result].PricePurchase := APricePurchase;
  FTrsSalesDetail_Arr[Result].AmountProfit := AAmountProfit;
  FTrsSalesDetail_Arr[Result].Points := APoints;
  FTrsSalesDetail_Arr[Result].PaketID := APaketID;
  FTrsSalesDetail_Arr[Result].ConvBonusID := AConvBonusID;
  FTrsSalesDetail_Arr[Result].QtyBonus := AQtyBonus;
  FTrsSalesDetail_Arr[Result].ConvBonus := AConvBonus;
  FTrsSalesDetail_Arr[Result].HrgBeli := AHrgBeli;
  FTrsSalesDetail_Arr[Result].ServiceType := AServiceType;
  FTrsSalesDetail_Arr[Result].IsFree := AIsFree;
  FTrsSalesDetail_Arr[Result].AnimalID := AAnimalID;
end;

function _TrsSalesDetail_Arr.IndexOf(ASalesDetailID: integer): integer;
var i: integer; found: boolean;
begin
  i := 0; found := false;
  while (i<=high(FTrsSalesDetail_Arr)) and (not found) do
    if (FTrsSalesDetail_Arr[i].FSalesDetailID=ASalesDetailID) then
      found := true
    else inc(i);
  if (found) then
    Result := i
  else
    Result := -1;
end;

procedure _TrsSalesDetail_Arr.Delete(Index: integer);
var i: integer;
begin
  if (Index<0) or (Index>high(FTrsSalesDetail_Arr)) then Exit;
  FTrsSalesDetail_Arr[Index].Destroy;
  for i:=Index to high(FTrsSalesDetail_Arr)-1 do
    FTrsSalesDetail_Arr[Index] := FTrsSalesDetail_Arr[Index-1];
  setLength(FTrsSalesDetail_Arr,length(FTrsSalesDetail_Arr)-1);
end;

function _TrsSalesDetail_Arr.Count: integer;
begin
  Result := length(FTrsSalesDetail_Arr);
end;

function _TrsSalesDetail_Arr.Get(Index: integer): _TrsSalesDetail;
begin
  if (Index<0) or (Index>high(FTrsSalesDetail_Arr)) then Result := nil
  else Result := FTrsSalesDetail_Arr[Index];
end;


{ _TrsSalesDetail }

constructor _TrsSalesDetail.Create(AOwner: TObject);
begin
  inherited Create;
  FOwner := AOwner;
  FMstItem := _MstItem.Create(Self);
  FMstItemConversion := _MstItemConversion.Create(Self);
end;

destructor _TrsSalesDetail.Destroy;
begin
  FMstItem.Destroy;
  FMstItemConversion.Destroy;
  inherited;
end;

procedure _TrsSalesDetail.Reset;
begin
  FSalesDetailID := 0;
  FSalesID := 0;
  FMstItem.Reset;
  FMstItemConversion.Reset;
  FQuantity := 0.0;
  FPrice := 0.0;
  FDisc := 0.0;
  FDiscVal := 0.0;
  FAmount := 0.0;
  FConversion := 0.0;
  FPricePurchase := 0.0;
  FAmountProfit := 0.0;
  FPoints := 0;
  FPaketID := 0;
  FConvBonusID := 0;
  FQtyBonus := 0.0;
  FConvBonus := 0.0;
  FHrgBeli := 0.0;
  FIsFree := 0;
  FServiceType:= 0;
  FAnimalId:= 0;
end;

procedure _TrsSalesDetail.InsertOnDB;
begin
  try ExecSQL(
    'INSERT INTO Trs_Sales_Detail (Sales_ID,Item_ID,Conv_ID,Quantity,Price,Disc,Disc_Val,Amount,Conversion,Price_Purchase,Amount_Profit,Points,Paket_ID,Conv_Bonus_ID,Qty_Bonus,Conv_Bonus,Hrg_Beli)'+
    ' VALUES ('+
      FormatSQLNumber(FSalesID)+','+
      FormatSQLNumber(FMstItem.ItemID)+','+
      FormatSQLNumber(FMstItemConversion.ConvID)+','+
      FormatSQLNumber(FQuantity)+','+
      FormatSQLNumber(FPrice)+','+
      FormatSQLNumber(FDisc)+','+
      FormatSQLNumber(FDiscVal)+','+
      FormatSQLNumber(FAmount)+','+
      FormatSQLNumber(FConversion)+','+
      FormatSQLNumber(FPricePurchase)+','+
      FormatSQLNumber(FAmountProfit)+','+
      FormatSQLNumber(FPoints)+','+
      FormatSQLNumber(FPaketID)+','+
      FormatSQLNumber(FConvBonusID)+','+
      FormatSQLNumber(FQtyBonus)+','+
      FormatSQLNumber(FConvBonus)+','+
      FormatSQLNumber(FHrgBeli)+')'
  ); except raise; end;
end;

procedure _TrsSalesDetail.UpdateOnDB;
begin
  try ExecSQL(
    'UPDATE Trs_Sales_Detail SET'+
          ' Sales_ID='+FormatSQLNumber(FSalesID)+','+
          ' Item_ID='+FormatSQLNumber(FMstItem.ItemID)+','+
          ' Conv_ID='+FormatSQLNumber(FMstItemConversion.ConvID)+','+
          ' Quantity='+FormatSQLNumber(FQuantity)+','+
          ' Price='+FormatSQLNumber(FPrice)+','+
          ' Disc='+FormatSQLNumber(FDisc)+','+
          ' Disc_Val='+FormatSQLNumber(FDiscVal)+','+
          ' Amount='+FormatSQLNumber(FAmount)+','+
          ' Conversion='+FormatSQLNumber(FConversion)+','+
          ' Price_Purchase='+FormatSQLNumber(FPricePurchase)+','+
          ' Amount_Profit='+FormatSQLNumber(FAmountProfit)+','+
          ' Points='+FormatSQLNumber(FPoints)+','+
          ' Paket_ID='+FormatSQLNumber(FPaketID)+','+
          ' Conv_Bonus_ID='+FormatSQLNumber(FConvBonusID)+','+
          ' Qty_Bonus='+FormatSQLNumber(FQtyBonus)+','+
          ' Conv_Bonus='+FormatSQLNumber(FConvBonus)+','+
          ' Hrg_Beli='+FormatSQLNumber(FHrgBeli)+
    ' WHERE Sales_Detail_ID='+FormatSQLNumber(FSalesDetailID)
  ); except raise; end;
end;

procedure _TrsSalesDetail.DeleteOnDB;
begin
  try ExecSQL(
    'DELETE FROM Trs_Sales_Detail'+
    ' WHERE Sales_Detail_ID='+FormatSQLNumber(FSalesDetailID)
  ); except raise; end;
end;


{ _TrsOrderMst_Arr }

constructor _TrsOrderMst_Arr.Create(AOwner: TObject);
begin
  inherited Create;
  FOwner := AOwner;
  setLength(FTrsOrderMst_Arr,0);
end;

destructor _TrsOrderMst_Arr.Destroy;
begin
  Self.Clear;
  inherited;
end;

procedure _TrsOrderMst_Arr.Clear;
var i: integer;
begin
  for i:=0 to high(FTrsOrderMst_Arr) do FTrsOrderMst_Arr[i].Destroy;
  setLength(FTrsOrderMst_Arr,0);
end;

function _TrsOrderMst_Arr.Add(AOrderID: integer; ATransNum: string; ATransType: integer; ATransDate: TDate; ADeliveryDate: TDate; AExprDate: TDate; ARelationID: integer; ASubtotal: real; ADiscDetail: real; ADiscMst: real; ATax: real; ATotal: real; ANotes: string; AUserID: string; AStatusID: integer; ADppDisc2: integer; APayTerm: integer): integer;
begin
  setLength(FTrsOrderMst_Arr, length(FTrsOrderMst_Arr)+1);
  Result := high(FTrsOrderMst_Arr);
  FTrsOrderMst_Arr[Result] := _TrsOrderMst.Create(Self);
  FTrsOrderMst_Arr[Result].OrderID := AOrderID;
  FTrsOrderMst_Arr[Result].TransNum := ATransNum;
  FTrsOrderMst_Arr[Result].TransType := ATransType;
  FTrsOrderMst_Arr[Result].TransDate := ATransDate;
  FTrsOrderMst_Arr[Result].DeliveryDate := ADeliveryDate;
  FTrsOrderMst_Arr[Result].ExprDate := AExprDate;
  FTrsOrderMst_Arr[Result].MstRelation.RelationID := ARelationID;
  FTrsOrderMst_Arr[Result].Subtotal := ASubtotal;
  FTrsOrderMst_Arr[Result].DiscDetail := ADiscDetail;
  FTrsOrderMst_Arr[Result].DiscMst := ADiscMst;
  FTrsOrderMst_Arr[Result].Tax := ATax;
  FTrsOrderMst_Arr[Result].Total := ATotal;
  FTrsOrderMst_Arr[Result].Notes := ANotes;
  FTrsOrderMst_Arr[Result].UserID := AUserID;
  FTrsOrderMst_Arr[Result].StatusID := AStatusID;
  FTrsOrderMst_Arr[Result].DppDisc2 := ADppDisc2;
  FTrsOrderMst_Arr[Result].PayTerm := APayTerm;
end;

function _TrsOrderMst_Arr.IndexOf(AOrderID: integer): integer;
var i: integer; found: boolean;
begin
  i := 0; found := false;
  while (i<=high(FTrsOrderMst_Arr)) and (not found) do
    if (FTrsOrderMst_Arr[i].FOrderID=AOrderID) then
      found := true
    else inc(i);
  if (found) then
    Result := i
  else
    Result := -1;
end;

procedure _TrsOrderMst_Arr.Delete(Index: integer);
var i: integer;
begin
  if (Index<0) or (Index>high(FTrsOrderMst_Arr)) then Exit;
  FTrsOrderMst_Arr[Index].Destroy;
  for i:=Index to high(FTrsOrderMst_Arr)-1 do
    FTrsOrderMst_Arr[Index] := FTrsOrderMst_Arr[Index-1];
  setLength(FTrsOrderMst_Arr,length(FTrsOrderMst_Arr)-1);
end;

function _TrsOrderMst_Arr.Count: integer;
begin
  Result := length(FTrsOrderMst_Arr);
end;

function _TrsOrderMst_Arr.Get(Index: integer): _TrsOrderMst;
begin
  if (Index<0) or (Index>high(FTrsOrderMst_Arr)) then Result := nil
  else Result := FTrsOrderMst_Arr[Index];
end;


{ _TrsOrderMst }

constructor _TrsOrderMst.Create(AOwner: TObject);
begin
  inherited Create;
  FOwner := AOwner;
  FMstRelation := _MstRelation.Create(Self);
end;

destructor _TrsOrderMst.Destroy;
begin
  FMstRelation.Destroy;
  inherited;
end;

procedure _TrsOrderMst.Reset;
begin
  FOrderID := 0;
  FTransNum := '';
  FTransType := 0;
  FTransDate := 0;
  FDeliveryDate := 0;
  FExprDate := 0;
  FMstRelation.Reset;
  FSubtotal := 0.0;
  FDiscDetail := 0.0;
  FDiscMst := 0.0;
  FTax := 0.0;
  FTotal := 0.0;
  FNotes := '';
  FUserID := '';
  FStatusID := 0;
  FDppDisc2 := 0;
  FPayTerm := 0;
end;

procedure _TrsOrderMst.InsertOnDB;
begin
  try ExecSQL(
    'INSERT INTO Trs_Order_Mst (Trans_Num,Trans_Type,Trans_Date,Delivery_Date,Expr_Date,Relation_ID,Subtotal,Disc_Detail,Disc_Mst,Tax,Total,Notes,User_ID,Status_ID,Dpp_Disc2,Pay_Term)'+
    ' VALUES ('+
      FormatSQLString(FTransNum)+','+
      FormatSQLNumber(FTransType)+','+
      FormatSQLDate(FTransDate)+','+
      FormatSQLDate(FDeliveryDate)+','+
      FormatSQLDate(FExprDate)+','+
      FormatSQLNumber(FMstRelation.RelationID)+','+
      FormatSQLNumber(FSubtotal)+','+
      FormatSQLNumber(FDiscDetail)+','+
      FormatSQLNumber(FDiscMst)+','+
      FormatSQLNumber(FTax)+','+
      FormatSQLNumber(FTotal)+','+
      FormatSQLString(FNotes)+','+
      FormatSQLString(FUserID)+','+
      FormatSQLNumber(FStatusID)+','+
      FormatSQLNumber(FDppDisc2)+','+
      FormatSQLNumber(FPayTerm)+')'
  ); except raise; end;
end;

procedure _TrsOrderMst.UpdateOnDB;
begin
  try ExecSQL(
    'UPDATE Trs_Order_Mst SET'+
          ' Trans_Num='+FormatSQLString(FTransNum)+','+
          ' Trans_Type='+FormatSQLNumber(FTransType)+','+
          ' Trans_Date='+FormatSQLDate(FTransDate)+','+
          ' Delivery_Date='+FormatSQLDate(FDeliveryDate)+','+
          ' Expr_Date='+FormatSQLDate(FExprDate)+','+
          ' Relation_ID='+FormatSQLNumber(FMstRelation.RelationID)+','+
          ' Subtotal='+FormatSQLNumber(FSubtotal)+','+
          ' Disc_Detail='+FormatSQLNumber(FDiscDetail)+','+
          ' Disc_Mst='+FormatSQLNumber(FDiscMst)+','+
          ' Tax='+FormatSQLNumber(FTax)+','+
          ' Total='+FormatSQLNumber(FTotal)+','+
          ' Notes='+FormatSQLString(FNotes)+','+
          ' User_ID='+FormatSQLString(FUserID)+','+
          ' Status_ID='+FormatSQLNumber(FStatusID)+','+
          ' Dpp_Disc2='+FormatSQLNumber(FDppDisc2)+','+
          ' Pay_Term='+FormatSQLNumber(FPayTerm)+
    ' WHERE Order_ID='+FormatSQLNumber(FOrderID)
  ); except raise; end;
end;

procedure _TrsOrderMst.DeleteOnDB;
begin
  try ExecSQL(
    'DELETE FROM Trs_Order_Mst'+
    ' WHERE Order_ID='+FormatSQLNumber(FOrderID)
  ); except raise; end;
end;


{ _TrsOrderDetail_Arr }

constructor _TrsOrderDetail_Arr.Create(AOwner: TObject);
begin
  inherited Create;
  FOwner := AOwner;
  setLength(FTrsOrderDetail_Arr,0);
end;

destructor _TrsOrderDetail_Arr.Destroy;
begin
  Self.Clear;
  inherited;
end;

procedure _TrsOrderDetail_Arr.Clear;
var i: integer;
begin
  for i:=0 to high(FTrsOrderDetail_Arr) do FTrsOrderDetail_Arr[i].Destroy;
  setLength(FTrsOrderDetail_Arr,0);
end;

function _TrsOrderDetail_Arr.Add(AOrderDetailID: integer; AOrderID: integer; AItemID: integer; AConvID: integer; AQuantity: real; APrice: real; ADisc: real; AAmount: real; AConversion: real; ATax: real; ADiscIsPrc: integer): integer;
begin
  setLength(FTrsOrderDetail_Arr, length(FTrsOrderDetail_Arr)+1);
  Result := high(FTrsOrderDetail_Arr);
  FTrsOrderDetail_Arr[Result] := _TrsOrderDetail.Create(Self);
  FTrsOrderDetail_Arr[Result].OrderDetailID := AOrderDetailID;
  FTrsOrderDetail_Arr[Result].OrderID := AOrderID;
  FTrsOrderDetail_Arr[Result].MstItem.ItemID := AItemID;
  FTrsOrderDetail_Arr[Result].MstItemConversion.ConvID := AConvID;
  FTrsOrderDetail_Arr[Result].Quantity := AQuantity;
  FTrsOrderDetail_Arr[Result].Price := APrice;
  FTrsOrderDetail_Arr[Result].Disc := ADisc;
  FTrsOrderDetail_Arr[Result].Amount := AAmount;
  FTrsOrderDetail_Arr[Result].Conversion := AConversion;
  FTrsOrderDetail_Arr[Result].Tax := ATax;
  FTrsOrderDetail_Arr[Result].DiscIsPrc := ADiscIsPrc;
end;

function _TrsOrderDetail_Arr.IndexOf(AOrderDetailID: integer): integer;
var i: integer; found: boolean;
begin
  i := 0; found := false;
  while (i<=high(FTrsOrderDetail_Arr)) and (not found) do
    if (FTrsOrderDetail_Arr[i].FOrderDetailID=AOrderDetailID) then
      found := true
    else inc(i);
  if (found) then
    Result := i
  else
    Result := -1;
end;

procedure _TrsOrderDetail_Arr.Delete(Index: integer);
var i: integer;
begin
  if (Index<0) or (Index>high(FTrsOrderDetail_Arr)) then Exit;
  FTrsOrderDetail_Arr[Index].Destroy;
  for i:=Index to high(FTrsOrderDetail_Arr)-1 do
    FTrsOrderDetail_Arr[Index] := FTrsOrderDetail_Arr[Index-1];
  setLength(FTrsOrderDetail_Arr,length(FTrsOrderDetail_Arr)-1);
end;

function _TrsOrderDetail_Arr.Count: integer;
begin
  Result := length(FTrsOrderDetail_Arr);
end;

function _TrsOrderDetail_Arr.Get(Index: integer): _TrsOrderDetail;
begin
  if (Index<0) or (Index>high(FTrsOrderDetail_Arr)) then Result := nil
  else Result := FTrsOrderDetail_Arr[Index];
end;


{ _TrsOrderDetail }

constructor _TrsOrderDetail.Create(AOwner: TObject);
begin
  inherited Create;
  FOwner := AOwner;
  FMstItem := _MstItem.Create(Self);
  FMstItemConversion := _MstItemConversion.Create(Self);
end;

destructor _TrsOrderDetail.Destroy;
begin
  FMstItem.Destroy;
  FMstItemConversion.Destroy;
  inherited;
end;

procedure _TrsOrderDetail.Reset;
begin
  FOrderDetailID := 0;
  FOrderID := 0;
  FMstItem.Reset;
  FMstItemConversion.Reset;
  FQuantity := 0.0;
  FPrice := 0.0;
  FDisc := 0.0;
  FAmount := 0.0;
  FConversion := 0.0;
  FTax := 0.0;
  FDiscIsPrc := 0;
end;

procedure _TrsOrderDetail.InsertOnDB;
begin
  try ExecSQL(
    'INSERT INTO Trs_Order_Detail (Order_ID,Item_ID,Conv_ID,Quantity,Price,Disc,Amount,Conversion,Tax,Disc_Is_Prc)'+
    ' VALUES ('+
      FormatSQLNumber(FOrderID)+','+
      FormatSQLNumber(FMstItem.ItemID)+','+
      FormatSQLNumber(FMstItemConversion.ConvID)+','+
      FormatSQLNumber(FQuantity)+','+
      FormatSQLNumber(FPrice)+','+
      FormatSQLNumber(FDisc)+','+
      FormatSQLNumber(FAmount)+','+
      FormatSQLNumber(FConversion)+','+
      FormatSQLNumber(FTax)+','+
      FormatSQLNumber(FDiscIsPrc)+')'
  ); except raise; end;
end;

procedure _TrsOrderDetail.UpdateOnDB;
begin
  try ExecSQL(
    'UPDATE Trs_Order_Detail SET'+
          ' Order_ID='+FormatSQLNumber(FOrderID)+','+
          ' Item_ID='+FormatSQLNumber(FMstItem.ItemID)+','+
          ' Conv_ID='+FormatSQLNumber(FMstItemConversion.ConvID)+','+
          ' Quantity='+FormatSQLNumber(FQuantity)+','+
          ' Price='+FormatSQLNumber(FPrice)+','+
          ' Disc='+FormatSQLNumber(FDisc)+','+
          ' Amount='+FormatSQLNumber(FAmount)+','+
          ' Conversion='+FormatSQLNumber(FConversion)+','+
          ' Tax='+FormatSQLNumber(FTax)+','+
          ' Disc_Is_Prc='+FormatSQLNumber(FDiscIsPrc)+
    ' WHERE Order_Detail_ID='+FormatSQLNumber(FOrderDetailID)
  ); except raise; end;
end;

procedure _TrsOrderDetail.DeleteOnDB;
begin
  try ExecSQL(
    'DELETE FROM Trs_Order_Detail'+
    ' WHERE Order_Detail_ID='+FormatSQLNumber(FOrderDetailID)
  ); except raise; end;
end;


{ _TrsReceiptMst_Arr }

constructor _TrsReceiptMst_Arr.Create(AOwner: TObject);
begin
  inherited Create;
  FOwner := AOwner;
  setLength(FTrsReceiptMst_Arr,0);
end;

destructor _TrsReceiptMst_Arr.Destroy;
begin
  Self.Clear;
  inherited;
end;

procedure _TrsReceiptMst_Arr.Clear;
var i: integer;
begin
  for i:=0 to high(FTrsReceiptMst_Arr) do FTrsReceiptMst_Arr[i].Destroy;
  setLength(FTrsReceiptMst_Arr,0);
end;

function _TrsReceiptMst_Arr.Add(AReceiptID: integer; ATransNum: string; ATipe: integer; ATransDate: TDate; AExprDate: TDate; ARelationID: integer; AOrderID: integer; AInvID: integer; AGudangID: integer; ASubtotal: real; ADiscDetail: real; ADiscMst: real; ATax: real; ABiaya: real; AMaterai: real; ATotal: real; ANotes: string; AUserID: string; AStatusID: integer; ADppDisc2: integer): integer;
begin
  setLength(FTrsReceiptMst_Arr, length(FTrsReceiptMst_Arr)+1);
  Result := high(FTrsReceiptMst_Arr);
  FTrsReceiptMst_Arr[Result] := _TrsReceiptMst.Create(Self);
  FTrsReceiptMst_Arr[Result].ReceiptID := AReceiptID;
  FTrsReceiptMst_Arr[Result].TransNum := ATransNum;
  FTrsReceiptMst_Arr[Result].Tipe := ATipe;
  FTrsReceiptMst_Arr[Result].TransDate := ATransDate;
  FTrsReceiptMst_Arr[Result].ExprDate := AExprDate;
  FTrsReceiptMst_Arr[Result].RelationID := ARelationID;
  FTrsReceiptMst_Arr[Result].OrderID := AOrderID;
  FTrsReceiptMst_Arr[Result].InvID := AInvID;
  FTrsReceiptMst_Arr[Result].GudangID := AGudangID;
  FTrsReceiptMst_Arr[Result].Subtotal := ASubtotal;
  FTrsReceiptMst_Arr[Result].DiscDetail := ADiscDetail;
  FTrsReceiptMst_Arr[Result].DiscMst := ADiscMst;
  FTrsReceiptMst_Arr[Result].Tax := ATax;
  FTrsReceiptMst_Arr[Result].Biaya := ABiaya;
  FTrsReceiptMst_Arr[Result].Materai := AMaterai;
  FTrsReceiptMst_Arr[Result].Total := ATotal;
  FTrsReceiptMst_Arr[Result].Notes := ANotes;
  FTrsReceiptMst_Arr[Result].UserID := AUserID;
  FTrsReceiptMst_Arr[Result].StatusID := AStatusID;
  FTrsReceiptMst_Arr[Result].DppDisc2 := ADppDisc2;
end;

function _TrsReceiptMst_Arr.IndexOf(AReceiptID: integer): integer;
var i: integer; found: boolean;
begin
  i := 0; found := false;
  while (i<=high(FTrsReceiptMst_Arr)) and (not found) do
    if (FTrsReceiptMst_Arr[i].FReceiptID=AReceiptID) then
      found := true
    else inc(i);
  if (found) then
    Result := i
  else
    Result := -1;
end;

procedure _TrsReceiptMst_Arr.Delete(Index: integer);
var i: integer;
begin
  if (Index<0) or (Index>high(FTrsReceiptMst_Arr)) then Exit;
  FTrsReceiptMst_Arr[Index].Destroy;
  for i:=Index to high(FTrsReceiptMst_Arr)-1 do
    FTrsReceiptMst_Arr[Index] := FTrsReceiptMst_Arr[Index-1];
  setLength(FTrsReceiptMst_Arr,length(FTrsReceiptMst_Arr)-1);
end;

function _TrsReceiptMst_Arr.Count: integer;
begin
  Result := length(FTrsReceiptMst_Arr);
end;

function _TrsReceiptMst_Arr.Get(Index: integer): _TrsReceiptMst;
begin
  if (Index<0) or (Index>high(FTrsReceiptMst_Arr)) then Result := nil
  else Result := FTrsReceiptMst_Arr[Index];
end;


{ _TrsReceiptMst }

constructor _TrsReceiptMst.Create(AOwner: TObject);
begin
  inherited Create;
  FOwner := AOwner;
end;

destructor _TrsReceiptMst.Destroy;
begin
  inherited;
end;

procedure _TrsReceiptMst.Reset;
begin
  FReceiptID := 0;
  FTransNum := '';
  FTipe := 0;
  FTransDate := 0;
  FExprDate := 0;
  FRelationID := 0;
  FOrderID := 0;
  FInvID := 0;
  FGudangID := 0;
  FSubtotal := 0.0;
  FDiscDetail := 0.0;
  FDiscMst := 0.0;
  FTax := 0.0;
  FBiaya := 0.0;
  FMaterai := 0.0;
  FTotal := 0.0;
  FNotes := '';
  FUserID := '';
  FStatusID := 0;
  FDppDisc2 := 0;
end;

procedure _TrsReceiptMst.InsertOnDB;
begin
  try ExecSQL(
    'INSERT INTO Trs_Receipt_Mst (Trans_Num,Tipe,Trans_Date,Expr_Date,Relation_ID,Order_ID,Inv_ID,Gudang_ID,Subtotal,Disc_Detail,Disc_Mst,Tax,Biaya,Materai,Total,Notes,User_ID,Status_ID,Dpp_Disc2)'+
    ' VALUES ('+
      FormatSQLString(FTransNum)+','+
      FormatSQLNumber(FTipe)+','+
      FormatSQLDate(FTransDate)+','+
      FormatSQLDate(FExprDate)+','+
      FormatSQLNumber(FRelationID)+','+
      FormatSQLNumber(FOrderID)+','+
      FormatSQLNumber(FInvID)+','+
      FormatSQLNumber(FGudangID)+','+
      FormatSQLNumber(FSubtotal)+','+
      FormatSQLNumber(FDiscDetail)+','+
      FormatSQLNumber(FDiscMst)+','+
      FormatSQLNumber(FTax)+','+
      FormatSQLNumber(FBiaya)+','+
      FormatSQLNumber(FMaterai)+','+
      FormatSQLNumber(FTotal)+','+
      FormatSQLString(FNotes)+','+
      FormatSQLString(FUserID)+','+
      FormatSQLNumber(FStatusID)+','+
      FormatSQLNumber(FDppDisc2)+')'
  ); except raise; end;
end;

procedure _TrsReceiptMst.UpdateOnDB;
begin
  try ExecSQL(
    'UPDATE Trs_Receipt_Mst SET'+
          ' Trans_Num='+FormatSQLString(FTransNum)+','+
          ' Tipe='+FormatSQLNumber(FTipe)+','+
          ' Trans_Date='+FormatSQLDate(FTransDate)+','+
          ' Expr_Date='+FormatSQLDate(FExprDate)+','+
          ' Relation_ID='+FormatSQLNumber(FRelationID)+','+
          ' Order_ID='+FormatSQLNumber(FOrderID)+','+
          ' Inv_ID='+FormatSQLNumber(FInvID)+','+
          ' Gudang_ID='+FormatSQLNumber(FGudangID)+','+
          ' Subtotal='+FormatSQLNumber(FSubtotal)+','+
          ' Disc_Detail='+FormatSQLNumber(FDiscDetail)+','+
          ' Disc_Mst='+FormatSQLNumber(FDiscMst)+','+
          ' Tax='+FormatSQLNumber(FTax)+','+
          ' Biaya='+FormatSQLNumber(FBiaya)+','+
          ' Materai='+FormatSQLNumber(FMaterai)+','+
          ' Total='+FormatSQLNumber(FTotal)+','+
          ' Notes='+FormatSQLString(FNotes)+','+
          ' User_ID='+FormatSQLString(FUserID)+','+
          ' Status_ID='+FormatSQLNumber(FStatusID)+','+
          ' Dpp_Disc2='+FormatSQLNumber(FDppDisc2)+
    ' WHERE Receipt_ID='+FormatSQLNumber(FReceiptID)
  ); except raise; end;
end;

procedure _TrsReceiptMst.DeleteOnDB;
begin
  try ExecSQL(
    'DELETE FROM Trs_Receipt_Mst'+
    ' WHERE Receipt_ID='+FormatSQLNumber(FReceiptID)
  ); except raise; end;
end;


{ _TrsReceiptDetail_Arr }

constructor _TrsReceiptDetail_Arr.Create(AOwner: TObject);
begin
  inherited Create;
  FOwner := AOwner;
  setLength(FTrsReceiptDetail_Arr,0);
end;

destructor _TrsReceiptDetail_Arr.Destroy;
begin
  Self.Clear;
  inherited;
end;

procedure _TrsReceiptDetail_Arr.Clear;
var i: integer;
begin
  for i:=0 to high(FTrsReceiptDetail_Arr) do FTrsReceiptDetail_Arr[i].Destroy;
  setLength(FTrsReceiptDetail_Arr,0);
end;

function _TrsReceiptDetail_Arr.Add(AReceiptDetailID: integer; AReceiptID: integer; AItemID: integer; AConvID: integer; AConvBonusID: real; AQuantity: real; AQtyBonus: real; APrice: real; AAmount: real; ADisc1: real; ADisc2: real; ADisc3: real; AConversion: real; AConvBonus: real; ATax: real; ADisc1IsPrc: integer; ADisc2IsPrc: integer; ADisc3IsPrc: integer): integer;
begin
  setLength(FTrsReceiptDetail_Arr, length(FTrsReceiptDetail_Arr)+1);
  Result := high(FTrsReceiptDetail_Arr);
  FTrsReceiptDetail_Arr[Result] := _TrsReceiptDetail.Create(Self);
  FTrsReceiptDetail_Arr[Result].ReceiptDetailID := AReceiptDetailID;
  FTrsReceiptDetail_Arr[Result].ReceiptID := AReceiptID;
  FTrsReceiptDetail_Arr[Result].ItemID := AItemID;
  FTrsReceiptDetail_Arr[Result].ConvID := AConvID;
  FTrsReceiptDetail_Arr[Result].ConvBonusID := AConvBonusID;
  FTrsReceiptDetail_Arr[Result].Quantity := AQuantity;
  FTrsReceiptDetail_Arr[Result].QtyBonus := AQtyBonus;
  FTrsReceiptDetail_Arr[Result].Price := APrice;
  FTrsReceiptDetail_Arr[Result].Amount := AAmount;
  FTrsReceiptDetail_Arr[Result].Disc1 := ADisc1;
  FTrsReceiptDetail_Arr[Result].Disc2 := ADisc2;
  FTrsReceiptDetail_Arr[Result].Disc3 := ADisc3;
  FTrsReceiptDetail_Arr[Result].Conversion := AConversion;
  FTrsReceiptDetail_Arr[Result].ConvBonus := AConvBonus;
  FTrsReceiptDetail_Arr[Result].Tax := ATax;
  FTrsReceiptDetail_Arr[Result].Disc1IsPrc := ADisc1IsPrc;
  FTrsReceiptDetail_Arr[Result].Disc2IsPrc := ADisc2IsPrc;
  FTrsReceiptDetail_Arr[Result].Disc3IsPrc := ADisc3IsPrc;
end;

function _TrsReceiptDetail_Arr.IndexOf(AReceiptDetailID: integer): integer;
var i: integer; found: boolean;
begin
  i := 0; found := false;
  while (i<=high(FTrsReceiptDetail_Arr)) and (not found) do
    if (FTrsReceiptDetail_Arr[i].FReceiptDetailID=AReceiptDetailID) then
      found := true
    else inc(i);
  if (found) then
    Result := i
  else
    Result := -1;
end;

procedure _TrsReceiptDetail_Arr.Delete(Index: integer);
var i: integer;
begin
  if (Index<0) or (Index>high(FTrsReceiptDetail_Arr)) then Exit;
  FTrsReceiptDetail_Arr[Index].Destroy;
  for i:=Index to high(FTrsReceiptDetail_Arr)-1 do
    FTrsReceiptDetail_Arr[Index] := FTrsReceiptDetail_Arr[Index-1];
  setLength(FTrsReceiptDetail_Arr,length(FTrsReceiptDetail_Arr)-1);
end;

function _TrsReceiptDetail_Arr.Count: integer;
begin
  Result := length(FTrsReceiptDetail_Arr);
end;

function _TrsReceiptDetail_Arr.Get(Index: integer): _TrsReceiptDetail;
begin
  if (Index<0) or (Index>high(FTrsReceiptDetail_Arr)) then Result := nil
  else Result := FTrsReceiptDetail_Arr[Index];
end;


{ _TrsReceiptDetail }

constructor _TrsReceiptDetail.Create(AOwner: TObject);
begin
  inherited Create;
  FOwner := AOwner;
end;

destructor _TrsReceiptDetail.Destroy;
begin
  inherited;
end;

procedure _TrsReceiptDetail.Reset;
begin
  FReceiptDetailID := 0;
  FReceiptID := 0;
  FItemID := 0;
  FConvID := 0;
  FConvBonusID := 0.0;
  FQuantity := 0.0;
  FQtyBonus := 0.0;
  FPrice := 0.0;
  FAmount := 0.0;
  FDisc1 := 0.0;
  FDisc2 := 0.0;
  FDisc3 := 0.0;
  FConversion := 0.0;
  FConvBonus := 0.0;
  FTax := 0.0;
  FDisc1IsPrc := 0;
  FDisc2IsPrc := 0;
  FDisc3IsPrc := 0;
end;

procedure _TrsReceiptDetail.InsertOnDB;
begin
  try ExecSQL(
    'INSERT INTO Trs_Receipt_Detail (Receipt_ID,Item_ID,Conv_ID,Conv_Bonus_ID,Quantity,Qty_Bonus,Price,Amount,Disc1,Disc2,Disc3,Conversion,Conv_Bonus,Tax,Disc1_Is_Prc,Disc2_Is_Prc,Disc3_Is_Prc)'+
    ' VALUES ('+
      FormatSQLNumber(FReceiptID)+','+
      FormatSQLNumber(FItemID)+','+
      FormatSQLNumber(FConvID)+','+
      FormatSQLNumber(FConvBonusID)+','+
      FormatSQLNumber(FQuantity)+','+
      FormatSQLNumber(FQtyBonus)+','+
      FormatSQLNumber(FPrice)+','+
      FormatSQLNumber(FAmount)+','+
      FormatSQLNumber(FDisc1)+','+
      FormatSQLNumber(FDisc2)+','+
      FormatSQLNumber(FDisc3)+','+
      FormatSQLNumber(FConversion)+','+
      FormatSQLNumber(FConvBonus)+','+
      FormatSQLNumber(FTax)+','+
      FormatSQLNumber(FDisc1IsPrc)+','+
      FormatSQLNumber(FDisc2IsPrc)+','+
      FormatSQLNumber(FDisc3IsPrc)+')'
  ); except raise; end;
end;

procedure _TrsReceiptDetail.UpdateOnDB;
begin
  try ExecSQL(
    'UPDATE Trs_Receipt_Detail SET'+
          ' Receipt_ID='+FormatSQLNumber(FReceiptID)+','+
          ' Item_ID='+FormatSQLNumber(FItemID)+','+
          ' Conv_ID='+FormatSQLNumber(FConvID)+','+
          ' Conv_Bonus_ID='+FormatSQLNumber(FConvBonusID)+','+
          ' Quantity='+FormatSQLNumber(FQuantity)+','+
          ' Qty_Bonus='+FormatSQLNumber(FQtyBonus)+','+
          ' Price='+FormatSQLNumber(FPrice)+','+
          ' Amount='+FormatSQLNumber(FAmount)+','+
          ' Disc1='+FormatSQLNumber(FDisc1)+','+
          ' Disc2='+FormatSQLNumber(FDisc2)+','+
          ' Disc3='+FormatSQLNumber(FDisc3)+','+
          ' Conversion='+FormatSQLNumber(FConversion)+','+
          ' Conv_Bonus='+FormatSQLNumber(FConvBonus)+','+
          ' Tax='+FormatSQLNumber(FTax)+','+
          ' Disc1_Is_Prc='+FormatSQLNumber(FDisc1IsPrc)+','+
          ' Disc2_Is_Prc='+FormatSQLNumber(FDisc2IsPrc)+','+
          ' Disc3_Is_Prc='+FormatSQLNumber(FDisc3IsPrc)+
    ' WHERE Receipt_Detail_ID='+FormatSQLNumber(FReceiptDetailID)
  ); except raise; end;
end;

procedure _TrsReceiptDetail.DeleteOnDB;
begin
  try ExecSQL(
    'DELETE FROM Trs_Receipt_Detail'+
    ' WHERE Receipt_Detail_ID='+FormatSQLNumber(FReceiptDetailID)
  ); except raise; end;
end;


{ _TrsReturMst_Arr }

constructor _TrsReturMst_Arr.Create(AOwner: TObject);
begin
  inherited Create;
  FOwner := AOwner;
  setLength(FTrsReturMst_Arr,0);
end;

destructor _TrsReturMst_Arr.Destroy;
begin
  Self.Clear;
  inherited;
end;

procedure _TrsReturMst_Arr.Clear;
var i: integer;
begin
  for i:=0 to high(FTrsReturMst_Arr) do FTrsReturMst_Arr[i].Destroy;
  setLength(FTrsReturMst_Arr,0);
end;

function _TrsReturMst_Arr.Add(AReturID: integer; ATransNum: string; ATipe: integer; ATransDate: TDate; ARelationID: integer; AInvID: integer; AGudangID: integer; ASubtotal: real; ADiscount: real; ATax: real; ABiaya: real; AMaterai: real; ATotal: real; ANotes: string; AUserID: string; AStatusID: integer): integer;
begin
  setLength(FTrsReturMst_Arr, length(FTrsReturMst_Arr)+1);
  Result := high(FTrsReturMst_Arr);
  FTrsReturMst_Arr[Result] := _TrsReturMst.Create(Self);
  FTrsReturMst_Arr[Result].ReturID := AReturID;
  FTrsReturMst_Arr[Result].TransNum := ATransNum;
  FTrsReturMst_Arr[Result].Tipe := ATipe;
  FTrsReturMst_Arr[Result].TransDate := ATransDate;
  FTrsReturMst_Arr[Result].RelationID := ARelationID;
  FTrsReturMst_Arr[Result].InvID := AInvID;
  FTrsReturMst_Arr[Result].GudangID := AGudangID;
  FTrsReturMst_Arr[Result].Subtotal := ASubtotal;
  FTrsReturMst_Arr[Result].Discount := ADiscount;
  FTrsReturMst_Arr[Result].Tax := ATax;
  FTrsReturMst_Arr[Result].Biaya := ABiaya;
  FTrsReturMst_Arr[Result].Materai := AMaterai;
  FTrsReturMst_Arr[Result].Total := ATotal;
  FTrsReturMst_Arr[Result].Notes := ANotes;
  FTrsReturMst_Arr[Result].UserID := AUserID;
  FTrsReturMst_Arr[Result].StatusID := AStatusID;
end;

function _TrsReturMst_Arr.IndexOf(AReturID: integer): integer;
var i: integer; found: boolean;
begin
  i := 0; found := false;
  while (i<=high(FTrsReturMst_Arr)) and (not found) do
    if (FTrsReturMst_Arr[i].FReturID=AReturID) then
      found := true
    else inc(i);
  if (found) then
    Result := i
  else
    Result := -1;
end;

procedure _TrsReturMst_Arr.Delete(Index: integer);
var i: integer;
begin
  if (Index<0) or (Index>high(FTrsReturMst_Arr)) then Exit;
  FTrsReturMst_Arr[Index].Destroy;
  for i:=Index to high(FTrsReturMst_Arr)-1 do
    FTrsReturMst_Arr[Index] := FTrsReturMst_Arr[Index-1];
  setLength(FTrsReturMst_Arr,length(FTrsReturMst_Arr)-1);
end;

function _TrsReturMst_Arr.Count: integer;
begin
  Result := length(FTrsReturMst_Arr);
end;

function _TrsReturMst_Arr.Get(Index: integer): _TrsReturMst;
begin
  if (Index<0) or (Index>high(FTrsReturMst_Arr)) then Result := nil
  else Result := FTrsReturMst_Arr[Index];
end;


{ _TrsReturMst }

constructor _TrsReturMst.Create(AOwner: TObject);
begin
  inherited Create;
  FOwner := AOwner;
end;

destructor _TrsReturMst.Destroy;
begin
  inherited;
end;

procedure _TrsReturMst.Reset;
begin
  FReturID := 0;
  FTransNum := '';
  FTipe := 0;
  FTransDate := 0;
  FRelationID := 0;
  FInvID := 0;
  FGudangID := 0;
  FSubtotal := 0.0;
  FDiscount := 0.0;
  FTax := 0.0;
  FBiaya := 0.0;
  FMaterai := 0.0;
  FTotal := 0.0;
  FNotes := '';
  FUserID := '';
  FStatusID := 0;
end;

procedure _TrsReturMst.InsertOnDB;
begin
  try ExecSQL(
    'INSERT INTO Trs_Retur_Mst (Trans_Num,Tipe,Trans_Date,Relation_ID,Inv_ID,Gudang_ID,Subtotal,Discount,Tax,Biaya,Materai,Total,Notes,User_ID,Status_ID)'+
    ' VALUES ('+
      FormatSQLString(FTransNum)+','+
      FormatSQLNumber(FTipe)+','+
      FormatSQLDate(FTransDate)+','+
      FormatSQLNumber(FRelationID)+','+
      FormatSQLNumber(FInvID)+','+
      FormatSQLNumber(FGudangID)+','+
      FormatSQLNumber(FSubtotal)+','+
      FormatSQLNumber(FDiscount)+','+
      FormatSQLNumber(FTax)+','+
      FormatSQLNumber(FBiaya)+','+
      FormatSQLNumber(FMaterai)+','+
      FormatSQLNumber(FTotal)+','+
      FormatSQLString(FNotes)+','+
      FormatSQLString(FUserID)+','+
      FormatSQLNumber(FStatusID)+')'
  ); except raise; end;
end;

procedure _TrsReturMst.UpdateOnDB;
begin
  try ExecSQL(
    'UPDATE Trs_Retur_Mst SET'+
          ' Trans_Num='+FormatSQLString(FTransNum)+','+
          ' Tipe='+FormatSQLNumber(FTipe)+','+
          ' Trans_Date='+FormatSQLDate(FTransDate)+','+
          ' Relation_ID='+FormatSQLNumber(FRelationID)+','+
          ' Inv_ID='+FormatSQLNumber(FInvID)+','+
          ' Gudang_ID='+FormatSQLNumber(FGudangID)+','+
          ' Subtotal='+FormatSQLNumber(FSubtotal)+','+
          ' Discount='+FormatSQLNumber(FDiscount)+','+
          ' Tax='+FormatSQLNumber(FTax)+','+
          ' Biaya='+FormatSQLNumber(FBiaya)+','+
          ' Materai='+FormatSQLNumber(FMaterai)+','+
          ' Total='+FormatSQLNumber(FTotal)+','+
          ' Notes='+FormatSQLString(FNotes)+','+
          ' User_ID='+FormatSQLString(FUserID)+','+
          ' Status_ID='+FormatSQLNumber(FStatusID)+
    ' WHERE Retur_ID='+FormatSQLNumber(FReturID)
  ); except raise; end;
end;

procedure _TrsReturMst.DeleteOnDB;
begin
  try ExecSQL(
    'DELETE FROM Trs_Retur_Mst'+
    ' WHERE Retur_ID='+FormatSQLNumber(FReturID)
  ); except raise; end;
end;


{ _TrsReturDetail_Arr }

constructor _TrsReturDetail_Arr.Create(AOwner: TObject);
begin
  inherited Create;
  FOwner := AOwner;
  setLength(FTrsReturDetail_Arr,0);
end;

destructor _TrsReturDetail_Arr.Destroy;
begin
  Self.Clear;
  inherited;
end;

procedure _TrsReturDetail_Arr.Clear;
var i: integer;
begin
  for i:=0 to high(FTrsReturDetail_Arr) do FTrsReturDetail_Arr[i].Destroy;
  setLength(FTrsReturDetail_Arr,0);
end;

function _TrsReturDetail_Arr.Add(AReturDetailID: integer; AReturID: integer; AFakturID: integer; AItemID: integer; AConvID: integer; AQuantity: real; APrice: real; AAmount: real; AConversion: real; ATax: real; ADisc: real; ADiscIsPrc: integer): integer;
begin
  setLength(FTrsReturDetail_Arr, length(FTrsReturDetail_Arr)+1);
  Result := high(FTrsReturDetail_Arr);
  FTrsReturDetail_Arr[Result] := _TrsReturDetail.Create(Self);
  FTrsReturDetail_Arr[Result].ReturDetailID := AReturDetailID;
  FTrsReturDetail_Arr[Result].ReturID := AReturID;
  FTrsReturDetail_Arr[Result].FakturID := AFakturID;
  FTrsReturDetail_Arr[Result].ItemID := AItemID;
  FTrsReturDetail_Arr[Result].ConvID := AConvID;
  FTrsReturDetail_Arr[Result].Quantity := AQuantity;
  FTrsReturDetail_Arr[Result].Price := APrice;
  FTrsReturDetail_Arr[Result].Amount := AAmount;
  FTrsReturDetail_Arr[Result].Conversion := AConversion;
  FTrsReturDetail_Arr[Result].Tax := ATax;
  FTrsReturDetail_Arr[Result].Disc := ADisc;
  FTrsReturDetail_Arr[Result].DiscIsPrc := ADiscIsPrc;
end;

function _TrsReturDetail_Arr.IndexOf(AReturDetailID: integer): integer;
var i: integer; found: boolean;
begin
  i := 0; found := false;
  while (i<=high(FTrsReturDetail_Arr)) and (not found) do
    if (FTrsReturDetail_Arr[i].FReturDetailID=AReturDetailID) then
      found := true
    else inc(i);
  if (found) then
    Result := i
  else
    Result := -1;
end;

procedure _TrsReturDetail_Arr.Delete(Index: integer);
var i: integer;
begin
  if (Index<0) or (Index>high(FTrsReturDetail_Arr)) then Exit;
  FTrsReturDetail_Arr[Index].Destroy;
  for i:=Index to high(FTrsReturDetail_Arr)-1 do
    FTrsReturDetail_Arr[Index] := FTrsReturDetail_Arr[Index-1];
  setLength(FTrsReturDetail_Arr,length(FTrsReturDetail_Arr)-1);
end;

function _TrsReturDetail_Arr.Count: integer;
begin
  Result := length(FTrsReturDetail_Arr);
end;

function _TrsReturDetail_Arr.Get(Index: integer): _TrsReturDetail;
begin
  if (Index<0) or (Index>high(FTrsReturDetail_Arr)) then Result := nil
  else Result := FTrsReturDetail_Arr[Index];
end;


{ _TrsReturDetail }

constructor _TrsReturDetail.Create(AOwner: TObject);
begin
  inherited Create;
  FOwner := AOwner;
end;

destructor _TrsReturDetail.Destroy;
begin
  inherited;
end;

procedure _TrsReturDetail.Reset;
begin
  FReturDetailID := 0;
  FReturID := 0;
  FFakturID := 0;
  FItemID := 0;
  FConvID := 0;
  FQuantity := 0.0;
  FPrice := 0.0;
  FAmount := 0.0;
  FConversion := 0.0;
  FTax := 0.0;
  FDisc := 0.0;
  FDiscIsPrc := 0;
end;

procedure _TrsReturDetail.InsertOnDB;
begin
  try ExecSQL(
    'INSERT INTO Trs_Retur_Detail (Retur_ID,Faktur_ID,Item_ID,Conv_ID,Quantity,Price,Amount,Conversion,Tax,Disc,Disc_Is_Prc)'+
    ' VALUES ('+
      FormatSQLNumber(FReturID)+','+
      FormatSQLNumber(FFakturID)+','+
      FormatSQLNumber(FItemID)+','+
      FormatSQLNumber(FConvID)+','+
      FormatSQLNumber(FQuantity)+','+
      FormatSQLNumber(FPrice)+','+
      FormatSQLNumber(FAmount)+','+
      FormatSQLNumber(FConversion)+','+
      FormatSQLNumber(FTax)+','+
      FormatSQLNumber(FDisc)+','+
      FormatSQLNumber(FDiscIsPrc)+')'
  ); except raise; end;
end;

procedure _TrsReturDetail.UpdateOnDB;
begin
  try ExecSQL(
    'UPDATE Trs_Retur_Detail SET'+
          ' Retur_ID='+FormatSQLNumber(FReturID)+','+
          ' Faktur_ID='+FormatSQLNumber(FFakturID)+','+
          ' Item_ID='+FormatSQLNumber(FItemID)+','+
          ' Conv_ID='+FormatSQLNumber(FConvID)+','+
          ' Quantity='+FormatSQLNumber(FQuantity)+','+
          ' Price='+FormatSQLNumber(FPrice)+','+
          ' Amount='+FormatSQLNumber(FAmount)+','+
          ' Conversion='+FormatSQLNumber(FConversion)+','+
          ' Tax='+FormatSQLNumber(FTax)+','+
          ' Disc='+FormatSQLNumber(FDisc)+','+
          ' Disc_Is_Prc='+FormatSQLNumber(FDiscIsPrc)+
    ' WHERE Retur_Detail_ID='+FormatSQLNumber(FReturDetailID)
  ); except raise; end;
end;

procedure _TrsReturDetail.DeleteOnDB;
begin
  try ExecSQL(
    'DELETE FROM Trs_Retur_Detail'+
    ' WHERE Retur_Detail_ID='+FormatSQLNumber(FReturDetailID)
  ); except raise; end;
end;


{ _TrsPaymentMst_Arr }

constructor _TrsPaymentMst_Arr.Create(AOwner: TObject);
begin
  inherited Create;
  FOwner := AOwner;
  setLength(FTrsPaymentMst_Arr,0);
end;

destructor _TrsPaymentMst_Arr.Destroy;
begin
  Self.Clear;
  inherited;
end;

procedure _TrsPaymentMst_Arr.Clear;
var i: integer;
begin
  for i:=0 to high(FTrsPaymentMst_Arr) do FTrsPaymentMst_Arr[i].Destroy;
  setLength(FTrsPaymentMst_Arr,0);
end;

function _TrsPaymentMst_Arr.Add(APaymentID: integer; ATransNum: string; ATipe: integer; ATransDate: TDate; ARelationID: integer; AInvID: integer; ASubtotal: real; ADiscount: real; ABiaya: real; ATotal: real; ANotes: string; AUserID: string; AStatusID: integer): integer;
begin
  setLength(FTrsPaymentMst_Arr, length(FTrsPaymentMst_Arr)+1);
  Result := high(FTrsPaymentMst_Arr);
  FTrsPaymentMst_Arr[Result] := _TrsPaymentMst.Create(Self);
  FTrsPaymentMst_Arr[Result].PaymentID := APaymentID;
  FTrsPaymentMst_Arr[Result].TransNum := ATransNum;
  FTrsPaymentMst_Arr[Result].Tipe := ATipe;
  FTrsPaymentMst_Arr[Result].TransDate := ATransDate;
  FTrsPaymentMst_Arr[Result].RelationID := ARelationID;
  FTrsPaymentMst_Arr[Result].InvID := AInvID;
  FTrsPaymentMst_Arr[Result].Subtotal := ASubtotal;
  FTrsPaymentMst_Arr[Result].Discount := ADiscount;
  FTrsPaymentMst_Arr[Result].Biaya := ABiaya;
  FTrsPaymentMst_Arr[Result].Total := ATotal;
  FTrsPaymentMst_Arr[Result].Notes := ANotes;
  FTrsPaymentMst_Arr[Result].UserID := AUserID;
  FTrsPaymentMst_Arr[Result].StatusID := AStatusID;
end;

function _TrsPaymentMst_Arr.IndexOf(APaymentID: integer): integer;
var i: integer; found: boolean;
begin
  i := 0; found := false;
  while (i<=high(FTrsPaymentMst_Arr)) and (not found) do
    if (FTrsPaymentMst_Arr[i].FPaymentID=APaymentID) then
      found := true
    else inc(i);
  if (found) then
    Result := i
  else
    Result := -1;
end;

procedure _TrsPaymentMst_Arr.Delete(Index: integer);
var i: integer;
begin
  if (Index<0) or (Index>high(FTrsPaymentMst_Arr)) then Exit;
  FTrsPaymentMst_Arr[Index].Destroy;
  for i:=Index to high(FTrsPaymentMst_Arr)-1 do
    FTrsPaymentMst_Arr[Index] := FTrsPaymentMst_Arr[Index-1];
  setLength(FTrsPaymentMst_Arr,length(FTrsPaymentMst_Arr)-1);
end;

function _TrsPaymentMst_Arr.Count: integer;
begin
  Result := length(FTrsPaymentMst_Arr);
end;

function _TrsPaymentMst_Arr.Get(Index: integer): _TrsPaymentMst;
begin
  if (Index<0) or (Index>high(FTrsPaymentMst_Arr)) then Result := nil
  else Result := FTrsPaymentMst_Arr[Index];
end;


{ _TrsPaymentMst }

constructor _TrsPaymentMst.Create(AOwner: TObject);
begin
  inherited Create;
  FOwner := AOwner;
end;

destructor _TrsPaymentMst.Destroy;
begin
  inherited;
end;

procedure _TrsPaymentMst.Reset;
begin
  FPaymentID := 0;
  FTransNum := '';
  FTipe := 0;
  FTransDate := 0;
  FRelationID := 0;
  FInvID := 0;
  FSubtotal := 0.0;
  FDiscount := 0.0;
  FBiaya := 0.0;
  FTotal := 0.0;
  FNotes := '';
  FUserID := '';
  FStatusID := 0;
end;

procedure _TrsPaymentMst.InsertOnDB;
begin
  try ExecSQL(
    'INSERT INTO Trs_Payment_Mst (Trans_Num,Tipe,Trans_Date,Relation_ID,Inv_ID,Subtotal,Discount,Biaya,Total,Notes,User_ID,Status_ID)'+
    ' VALUES ('+
      FormatSQLString(FTransNum)+','+
      FormatSQLNumber(FTipe)+','+
      FormatSQLDate(FTransDate)+','+
      FormatSQLNumber(FRelationID)+','+
      FormatSQLNumber(FInvID)+','+
      FormatSQLNumber(FSubtotal)+','+
      FormatSQLNumber(FDiscount)+','+
      FormatSQLNumber(FBiaya)+','+
      FormatSQLNumber(FTotal)+','+
      FormatSQLString(FNotes)+','+
      FormatSQLString(FUserID)+','+
      FormatSQLNumber(FStatusID)+')'
  ); except raise; end;
end;

procedure _TrsPaymentMst.UpdateOnDB;
begin
  try ExecSQL(
    'UPDATE Trs_Payment_Mst SET'+
          ' Trans_Num='+FormatSQLString(FTransNum)+','+
          ' Tipe='+FormatSQLNumber(FTipe)+','+
          ' Trans_Date='+FormatSQLDate(FTransDate)+','+
          ' Relation_ID='+FormatSQLNumber(FRelationID)+','+
          ' Inv_ID='+FormatSQLNumber(FInvID)+','+
          ' Subtotal='+FormatSQLNumber(FSubtotal)+','+
          ' Discount='+FormatSQLNumber(FDiscount)+','+
          ' Biaya='+FormatSQLNumber(FBiaya)+','+
          ' Total='+FormatSQLNumber(FTotal)+','+
          ' Notes='+FormatSQLString(FNotes)+','+
          ' User_ID='+FormatSQLString(FUserID)+','+
          ' Status_ID='+FormatSQLNumber(FStatusID)+
    ' WHERE Payment_ID='+FormatSQLNumber(FPaymentID)
  ); except raise; end;
end;

procedure _TrsPaymentMst.DeleteOnDB;
begin
  try ExecSQL(
    'DELETE FROM Trs_Payment_Mst'+
    ' WHERE Payment_ID='+FormatSQLNumber(FPaymentID)
  ); except raise; end;
end;


{ _TrsPaymentDetail_Arr }

constructor _TrsPaymentDetail_Arr.Create(AOwner: TObject);
begin
  inherited Create;
  FOwner := AOwner;
  setLength(FTrsPaymentDetail_Arr,0);
end;

destructor _TrsPaymentDetail_Arr.Destroy;
begin
  Self.Clear;
  inherited;
end;

procedure _TrsPaymentDetail_Arr.Clear;
var i: integer;
begin
  for i:=0 to high(FTrsPaymentDetail_Arr) do FTrsPaymentDetail_Arr[i].Destroy;
  setLength(FTrsPaymentDetail_Arr,0);
end;

function _TrsPaymentDetail_Arr.Add(APayDetailID: integer; APaymentID: integer; AJenisBayar: integer; AAmount: real; ABank: string; ADokNum: string; ATglCair: TDate): integer;
begin
  setLength(FTrsPaymentDetail_Arr, length(FTrsPaymentDetail_Arr)+1);
  Result := high(FTrsPaymentDetail_Arr);
  FTrsPaymentDetail_Arr[Result] := _TrsPaymentDetail.Create(Self);
  FTrsPaymentDetail_Arr[Result].PayDetailID := APayDetailID;
  FTrsPaymentDetail_Arr[Result].PaymentID := APaymentID;
  FTrsPaymentDetail_Arr[Result].JenisBayar := AJenisBayar;
  FTrsPaymentDetail_Arr[Result].Amount := AAmount;
  FTrsPaymentDetail_Arr[Result].Bank := ABank;
  FTrsPaymentDetail_Arr[Result].DokNum := ADokNum;
  FTrsPaymentDetail_Arr[Result].TglCair := ATglCair;
end;

function _TrsPaymentDetail_Arr.IndexOf(APayDetailID: integer): integer;
var i: integer; found: boolean;
begin
  i := 0; found := false;
  while (i<=high(FTrsPaymentDetail_Arr)) and (not found) do
    if (FTrsPaymentDetail_Arr[i].FPayDetailID=APayDetailID) then
      found := true
    else inc(i);
  if (found) then
    Result := i
  else
    Result := -1;
end;

procedure _TrsPaymentDetail_Arr.Delete(Index: integer);
var i: integer;
begin
  if (Index<0) or (Index>high(FTrsPaymentDetail_Arr)) then Exit;
  FTrsPaymentDetail_Arr[Index].Destroy;
  for i:=Index to high(FTrsPaymentDetail_Arr)-1 do
    FTrsPaymentDetail_Arr[Index] := FTrsPaymentDetail_Arr[Index-1];
  setLength(FTrsPaymentDetail_Arr,length(FTrsPaymentDetail_Arr)-1);
end;

function _TrsPaymentDetail_Arr.Count: integer;
begin
  Result := length(FTrsPaymentDetail_Arr);
end;

function _TrsPaymentDetail_Arr.Get(Index: integer): _TrsPaymentDetail;
begin
  if (Index<0) or (Index>high(FTrsPaymentDetail_Arr)) then Result := nil
  else Result := FTrsPaymentDetail_Arr[Index];
end;


{ _TrsPaymentDetail }

constructor _TrsPaymentDetail.Create(AOwner: TObject);
begin
  inherited Create;
  FOwner := AOwner;
end;

destructor _TrsPaymentDetail.Destroy;
begin
  inherited;
end;

procedure _TrsPaymentDetail.Reset;
begin
  FPayDetailID := 0;
  FPaymentID := 0;
  FJenisBayar := 0;
  FAmount := 0.0;
  FBank := '';
  FDokNum := '';
  FTglCair := 0;
end;

procedure _TrsPaymentDetail.InsertOnDB;
begin
  try ExecSQL(
    'INSERT INTO Trs_Payment_Detail (Payment_ID,Jenis_Bayar,Amount,Bank,Dok_Num,Tgl_Cair)'+
    ' VALUES ('+
      FormatSQLNumber(FPaymentID)+','+
      FormatSQLNumber(FJenisBayar)+','+
      FormatSQLNumber(FAmount)+','+
      FormatSQLString(FBank)+','+
      FormatSQLString(FDokNum)+','+
      FormatSQLDate(FTglCair)+')'
  ); except raise; end;
end;

procedure _TrsPaymentDetail.UpdateOnDB;
begin
  try ExecSQL(
    'UPDATE Trs_Payment_Detail SET'+
          ' Payment_ID='+FormatSQLNumber(FPaymentID)+','+
          ' Jenis_Bayar='+FormatSQLNumber(FJenisBayar)+','+
          ' Amount='+FormatSQLNumber(FAmount)+','+
          ' Bank='+FormatSQLString(FBank)+','+
          ' Dok_Num='+FormatSQLString(FDokNum)+','+
          ' Tgl_Cair='+FormatSQLDate(FTglCair)+
    ' WHERE Pay_Detail_ID='+FormatSQLNumber(FPayDetailID)
  ); except raise; end;
end;

procedure _TrsPaymentDetail.DeleteOnDB;
begin
  try ExecSQL(
    'DELETE FROM Trs_Payment_Detail'+
    ' WHERE Pay_Detail_ID='+FormatSQLNumber(FPayDetailID)
  ); except raise; end;
end;


{ _TrsPaymentAkun_Arr }

constructor _TrsPaymentAkun_Arr.Create(AOwner: TObject);
begin
  inherited Create;
  FOwner := AOwner;
  setLength(FTrsPaymentAkun_Arr,0);
end;

destructor _TrsPaymentAkun_Arr.Destroy;
begin
  Self.Clear;
  inherited;
end;

procedure _TrsPaymentAkun_Arr.Clear;
var i: integer;
begin
  for i:=0 to high(FTrsPaymentAkun_Arr) do FTrsPaymentAkun_Arr[i].Destroy;
  setLength(FTrsPaymentAkun_Arr,0);
end;

function _TrsPaymentAkun_Arr.Add(APayAkunID: integer; APaymentID: integer; AAkunID: integer; AAmount: real): integer;
begin
  setLength(FTrsPaymentAkun_Arr, length(FTrsPaymentAkun_Arr)+1);
  Result := high(FTrsPaymentAkun_Arr);
  FTrsPaymentAkun_Arr[Result] := _TrsPaymentAkun.Create(Self);
  FTrsPaymentAkun_Arr[Result].PayAkunID := APayAkunID;
  FTrsPaymentAkun_Arr[Result].PaymentID := APaymentID;
  FTrsPaymentAkun_Arr[Result].AkunID := AAkunID;
  FTrsPaymentAkun_Arr[Result].Amount := AAmount;
end;

function _TrsPaymentAkun_Arr.IndexOf(APayAkunID: integer): integer;
var i: integer; found: boolean;
begin
  i := 0; found := false;
  while (i<=high(FTrsPaymentAkun_Arr)) and (not found) do
    if (FTrsPaymentAkun_Arr[i].FPayAkunID=APayAkunID) then
      found := true
    else inc(i);
  if (found) then
    Result := i
  else
    Result := -1;
end;

procedure _TrsPaymentAkun_Arr.Delete(Index: integer);
var i: integer;
begin
  if (Index<0) or (Index>high(FTrsPaymentAkun_Arr)) then Exit;
  FTrsPaymentAkun_Arr[Index].Destroy;
  for i:=Index to high(FTrsPaymentAkun_Arr)-1 do
    FTrsPaymentAkun_Arr[Index] := FTrsPaymentAkun_Arr[Index-1];
  setLength(FTrsPaymentAkun_Arr,length(FTrsPaymentAkun_Arr)-1);
end;

function _TrsPaymentAkun_Arr.Count: integer;
begin
  Result := length(FTrsPaymentAkun_Arr);
end;

function _TrsPaymentAkun_Arr.Get(Index: integer): _TrsPaymentAkun;
begin
  if (Index<0) or (Index>high(FTrsPaymentAkun_Arr)) then Result := nil
  else Result := FTrsPaymentAkun_Arr[Index];
end;


{ _TrsPaymentAkun }

constructor _TrsPaymentAkun.Create(AOwner: TObject);
begin
  inherited Create;
  FOwner := AOwner;
end;

destructor _TrsPaymentAkun.Destroy;
begin
  inherited;
end;

procedure _TrsPaymentAkun.Reset;
begin
  FPayAkunID := 0;
  FPaymentID := 0;
  FAkunID := 0;
  FAmount := 0.0;
end;

procedure _TrsPaymentAkun.InsertOnDB;
begin
  try ExecSQL(
    'INSERT INTO Trs_Payment_Akun (Payment_ID,Akun_ID,Amount)'+
    ' VALUES ('+
      FormatSQLNumber(FPaymentID)+','+
      FormatSQLNumber(FAkunID)+','+
      FormatSQLNumber(FAmount)+')'
  ); except raise; end;
end;

procedure _TrsPaymentAkun.UpdateOnDB;
begin
  try ExecSQL(
    'UPDATE Trs_Payment_Akun SET'+
          ' Payment_ID='+FormatSQLNumber(FPaymentID)+','+
          ' Akun_ID='+FormatSQLNumber(FAkunID)+','+
          ' Amount='+FormatSQLNumber(FAmount)+
    ' WHERE Pay_Akun_ID='+FormatSQLNumber(FPayAkunID)
  ); except raise; end;
end;

procedure _TrsPaymentAkun.DeleteOnDB;
begin
  try ExecSQL(
    'DELETE FROM Trs_Payment_Akun'+
    ' WHERE Pay_Akun_ID='+FormatSQLNumber(FPayAkunID)
  ); except raise; end;
end;


{ _TrsDebtAdjustment_Arr }

constructor _TrsDebtAdjustment_Arr.Create(AOwner: TObject);
begin
  inherited Create;
  FOwner := AOwner;
  setLength(FTrsDebtAdjustment_Arr,0);
end;

destructor _TrsDebtAdjustment_Arr.Destroy;
begin
  Self.Clear;
  inherited;
end;

procedure _TrsDebtAdjustment_Arr.Clear;
var i: integer;
begin
  for i:=0 to high(FTrsDebtAdjustment_Arr) do FTrsDebtAdjustment_Arr[i].Destroy;
  setLength(FTrsDebtAdjustment_Arr,0);
end;

function _TrsDebtAdjustment_Arr.Add(AAdjID: integer; ATransDate: TDate; ARelationID: integer; AAmount: real; AUserID: string): integer;
begin
  setLength(FTrsDebtAdjustment_Arr, length(FTrsDebtAdjustment_Arr)+1);
  Result := high(FTrsDebtAdjustment_Arr);
  FTrsDebtAdjustment_Arr[Result] := _TrsDebtAdjustment.Create(Self);
  FTrsDebtAdjustment_Arr[Result].AdjID := AAdjID;
  FTrsDebtAdjustment_Arr[Result].TransDate := ATransDate;
  FTrsDebtAdjustment_Arr[Result].RelationID := ARelationID;
  FTrsDebtAdjustment_Arr[Result].Amount := AAmount;
  FTrsDebtAdjustment_Arr[Result].UserID := AUserID;
end;

function _TrsDebtAdjustment_Arr.IndexOf(AAdjID: integer): integer;
var i: integer; found: boolean;
begin
  i := 0; found := false;
  while (i<=high(FTrsDebtAdjustment_Arr)) and (not found) do
    if (FTrsDebtAdjustment_Arr[i].FAdjID=AAdjID) then
      found := true
    else inc(i);
  if (found) then
    Result := i
  else
    Result := -1;
end;

procedure _TrsDebtAdjustment_Arr.Delete(Index: integer);
var i: integer;
begin
  if (Index<0) or (Index>high(FTrsDebtAdjustment_Arr)) then Exit;
  FTrsDebtAdjustment_Arr[Index].Destroy;
  for i:=Index to high(FTrsDebtAdjustment_Arr)-1 do
    FTrsDebtAdjustment_Arr[Index] := FTrsDebtAdjustment_Arr[Index-1];
  setLength(FTrsDebtAdjustment_Arr,length(FTrsDebtAdjustment_Arr)-1);
end;

function _TrsDebtAdjustment_Arr.Count: integer;
begin
  Result := length(FTrsDebtAdjustment_Arr);
end;

function _TrsDebtAdjustment_Arr.Get(Index: integer): _TrsDebtAdjustment;
begin
  if (Index<0) or (Index>high(FTrsDebtAdjustment_Arr)) then Result := nil
  else Result := FTrsDebtAdjustment_Arr[Index];
end;


{ _TrsDebtAdjustment }

constructor _TrsDebtAdjustment.Create(AOwner: TObject);
begin
  inherited Create;
  FOwner := AOwner;
end;

destructor _TrsDebtAdjustment.Destroy;
begin
  inherited;
end;

procedure _TrsDebtAdjustment.Reset;
begin
  FAdjID := 0;
  FTransDate := 0;
  FRelationID := 0;
  FAmount := 0.0;
  FUserID := '';
end;

procedure _TrsDebtAdjustment.InsertOnDB;
begin
  try ExecSQL(
    'INSERT INTO Trs_Debt_Adjustment (Trans_Date,Relation_ID,Amount,User_ID)'+
    ' VALUES ('+
      FormatSQLDate(FTransDate)+','+
      FormatSQLNumber(FRelationID)+','+
      FormatSQLNumber(FAmount)+','+
      FormatSQLString(FUserID)+')'
  ); except raise; end;
end;

procedure _TrsDebtAdjustment.UpdateOnDB;
begin
  try ExecSQL(
    'UPDATE Trs_Debt_Adjustment SET'+
          ' Trans_Date='+FormatSQLDate(FTransDate)+','+
          ' Relation_ID='+FormatSQLNumber(FRelationID)+','+
          ' Amount='+FormatSQLNumber(FAmount)+','+
          ' User_ID='+FormatSQLString(FUserID)+
    ' WHERE Adj_ID='+FormatSQLNumber(FAdjID)
  ); except raise; end;
end;

procedure _TrsDebtAdjustment.DeleteOnDB;
begin
  try ExecSQL(
    'DELETE FROM Trs_Debt_Adjustment'+
    ' WHERE Adj_ID='+FormatSQLNumber(FAdjID)
  ); except raise; end;
end;


{ _MstProduk_Arr }

constructor _MstProduk_Arr.Create(AOwner: TObject);
begin
  inherited Create;
  FOwner := AOwner;
  setLength(FMstProduk_Arr,0);
end;

destructor _MstProduk_Arr.Destroy;
begin
  Self.Clear;
  inherited;
end;

procedure _MstProduk_Arr.Clear;
var i: integer;
begin
  for i:=0 to high(FMstProduk_Arr) do FMstProduk_Arr[i].Destroy;
  setLength(FMstProduk_Arr,0);
end;

function _MstProduk_Arr.Add(AProdukID: integer; AJnsProduk: integer; ABerlaku: integer; APeriodeAwal: TDate; APeriodeAkhir: TDate; AFaktor: integer; AAktif: integer): integer;
begin
  setLength(FMstProduk_Arr, length(FMstProduk_Arr)+1);
  Result := high(FMstProduk_Arr);
  FMstProduk_Arr[Result] := _MstProduk.Create(Self);
  FMstProduk_Arr[Result].ProdukID := AProdukID;
  FMstProduk_Arr[Result].JnsProduk := AJnsProduk;
  FMstProduk_Arr[Result].Berlaku := ABerlaku;
  FMstProduk_Arr[Result].PeriodeAwal := APeriodeAwal;
  FMstProduk_Arr[Result].PeriodeAkhir := APeriodeAkhir;
  FMstProduk_Arr[Result].Faktor := AFaktor;
  FMstProduk_Arr[Result].Aktif := AAktif;
end;

function _MstProduk_Arr.IndexOf(AProdukID: integer): integer;
var i: integer; found: boolean;
begin
  i := 0; found := false;
  while (i<=high(FMstProduk_Arr)) and (not found) do
    if (FMstProduk_Arr[i].FProdukID=AProdukID) then
      found := true
    else inc(i);
  if (found) then
    Result := i
  else
    Result := -1;
end;

procedure _MstProduk_Arr.Delete(Index: integer);
var i: integer;
begin
  if (Index<0) or (Index>high(FMstProduk_Arr)) then Exit;
  FMstProduk_Arr[Index].Destroy;
  for i:=Index to high(FMstProduk_Arr)-1 do
    FMstProduk_Arr[Index] := FMstProduk_Arr[Index-1];
  setLength(FMstProduk_Arr,length(FMstProduk_Arr)-1);
end;

function _MstProduk_Arr.Count: integer;
begin
  Result := length(FMstProduk_Arr);
end;

function _MstProduk_Arr.Get(Index: integer): _MstProduk;
begin
  if (Index<0) or (Index>high(FMstProduk_Arr)) then Result := nil
  else Result := FMstProduk_Arr[Index];
end;


{ _MstProduk }

constructor _MstProduk.Create(AOwner: TObject);
begin
  inherited Create;
  FOwner := AOwner;
end;

destructor _MstProduk.Destroy;
begin
  inherited;
end;

procedure _MstProduk.Reset;
begin
  FProdukID := 0;
  FJnsProduk := 0;
  FBerlaku := 0;
  FPeriodeAwal := 0;
  FPeriodeAkhir := 0;
  FFaktor := 0;
  FAktif := 0;
end;

procedure _MstProduk.InsertOnDB;
begin
  try ExecSQL(
    'INSERT INTO Mst_Produk (Jns_Produk,Berlaku,Periode_Awal,Periode_Akhir,Faktor,Aktif)'+
    ' VALUES ('+
      FormatSQLNumber(FJnsProduk)+','+
      FormatSQLNumber(FBerlaku)+','+
      FormatSQLDate(FPeriodeAwal)+','+
      FormatSQLDate(FPeriodeAkhir)+','+
      FormatSQLNumber(FFaktor)+','+
      FormatSQLNumber(FAktif)+')'
  ); except raise; end;
end;

procedure _MstProduk.UpdateOnDB;
begin
  try ExecSQL(
    'UPDATE Mst_Produk SET'+
          ' Jns_Produk='+FormatSQLNumber(FJnsProduk)+','+
          ' Berlaku='+FormatSQLNumber(FBerlaku)+','+
          ' Periode_Awal='+FormatSQLDate(FPeriodeAwal)+','+
          ' Periode_Akhir='+FormatSQLDate(FPeriodeAkhir)+','+
          ' Faktor='+FormatSQLNumber(FFaktor)+','+
          ' Aktif='+FormatSQLNumber(FAktif)+
    ' WHERE Produk_ID='+FormatSQLNumber(FProdukID)
  ); except raise; end;
end;

procedure _MstProduk.DeleteOnDB;
begin
  try ExecSQL(
    'DELETE FROM Mst_Produk'+
    ' WHERE Produk_ID='+FormatSQLNumber(FProdukID)
  ); except raise; end;
end;


{ _MstProdukRule_Arr }

constructor _MstProdukRule_Arr.Create(AOwner: TObject);
begin
  inherited Create;
  FOwner := AOwner;
  setLength(FMstProdukRule_Arr,0);
end;

destructor _MstProdukRule_Arr.Destroy;
begin
  Self.Clear;
  inherited;
end;

procedure _MstProdukRule_Arr.Clear;
var i: integer;
begin
  for i:=0 to high(FMstProdukRule_Arr) do FMstProdukRule_Arr[i].Destroy;
  setLength(FMstProdukRule_Arr,0);
end;

function _MstProdukRule_Arr.Add(ARuleID: integer; AProdukID: integer; AFaktorID: integer; ABatasMinimal: real; ANilai: real; ADiscPrc: real): integer;
begin
  setLength(FMstProdukRule_Arr, length(FMstProdukRule_Arr)+1);
  Result := high(FMstProdukRule_Arr);
  FMstProdukRule_Arr[Result] := _MstProdukRule.Create(Self);
  FMstProdukRule_Arr[Result].RuleID := ARuleID;
  FMstProdukRule_Arr[Result].ProdukID := AProdukID;
  FMstProdukRule_Arr[Result].FaktorID := AFaktorID;
  FMstProdukRule_Arr[Result].BatasMinimal := ABatasMinimal;
  FMstProdukRule_Arr[Result].Nilai := ANilai;
  FMstProdukRule_Arr[Result].DiscPrc := ADiscPrc;
end;

function _MstProdukRule_Arr.IndexOf(ARuleID: integer): integer;
var i: integer; found: boolean;
begin
  i := 0; found := false;
  while (i<=high(FMstProdukRule_Arr)) and (not found) do
    if (FMstProdukRule_Arr[i].FRuleID=ARuleID) then
      found := true
    else inc(i);
  if (found) then
    Result := i
  else
    Result := -1;
end;

procedure _MstProdukRule_Arr.Delete(Index: integer);
var i: integer;
begin
  if (Index<0) or (Index>high(FMstProdukRule_Arr)) then Exit;
  FMstProdukRule_Arr[Index].Destroy;
  for i:=Index to high(FMstProdukRule_Arr)-1 do
    FMstProdukRule_Arr[Index] := FMstProdukRule_Arr[Index-1];
  setLength(FMstProdukRule_Arr,length(FMstProdukRule_Arr)-1);
end;

function _MstProdukRule_Arr.Count: integer;
begin
  Result := length(FMstProdukRule_Arr);
end;

function _MstProdukRule_Arr.Get(Index: integer): _MstProdukRule;
begin
  if (Index<0) or (Index>high(FMstProdukRule_Arr)) then Result := nil
  else Result := FMstProdukRule_Arr[Index];
end;


{ _MstProdukRule }

constructor _MstProdukRule.Create(AOwner: TObject);
begin
  inherited Create;
  FOwner := AOwner;
end;

destructor _MstProdukRule.Destroy;
begin
  inherited;
end;

procedure _MstProdukRule.Reset;
begin
  FRuleID := 0;
  FProdukID := 0;
  FFaktorID := 0;
  FBatasMinimal := 0.0;
  FNilai := 0.0;
  FDiscPrc := 0.0;
end;

procedure _MstProdukRule.InsertOnDB;
begin
  try ExecSQL(
    'INSERT INTO Mst_Produk_Rule (Produk_ID,Faktor_ID,Batas_Minimal,Nilai,Disc_Prc)'+
    ' VALUES ('+
      FormatSQLNumber(FProdukID)+','+
      FormatSQLNumber(FFaktorID)+','+
      FormatSQLNumber(FBatasMinimal)+','+
      FormatSQLNumber(FNilai)+','+
      FormatSQLNumber(FDiscPrc)+')'
  ); except raise; end;
end;

procedure _MstProdukRule.UpdateOnDB;
begin
  try ExecSQL(
    'UPDATE Mst_Produk_Rule SET'+
          ' Produk_ID='+FormatSQLNumber(FProdukID)+','+
          ' Faktor_ID='+FormatSQLNumber(FFaktorID)+','+
          ' Batas_Minimal='+FormatSQLNumber(FBatasMinimal)+','+
          ' Nilai='+FormatSQLNumber(FNilai)+','+
          ' Disc_Prc='+FormatSQLNumber(FDiscPrc)+
    ' WHERE Rule_ID='+FormatSQLNumber(FRuleID)
  ); except raise; end;
end;

procedure _MstProdukRule.DeleteOnDB;
begin
  try ExecSQL(
    'DELETE FROM Mst_Produk_Rule'+
    ' WHERE Rule_ID='+FormatSQLNumber(FRuleID)
  ); except raise; end;
end;


{ _MstProdukItem_Arr }

constructor _MstProdukItem_Arr.Create(AOwner: TObject);
begin
  inherited Create;
  FOwner := AOwner;
  setLength(FMstProdukItem_Arr,0);
end;

destructor _MstProdukItem_Arr.Destroy;
begin
  Self.Clear;
  inherited;
end;

procedure _MstProdukItem_Arr.Clear;
var i: integer;
begin
  for i:=0 to high(FMstProdukItem_Arr) do FMstProdukItem_Arr[i].Destroy;
  setLength(FMstProdukItem_Arr,0);
end;

function _MstProdukItem_Arr.Add(AProdItemID: integer; ARuleID: integer; AItemID: integer): integer;
begin
  setLength(FMstProdukItem_Arr, length(FMstProdukItem_Arr)+1);
  Result := high(FMstProdukItem_Arr);
  FMstProdukItem_Arr[Result] := _MstProdukItem.Create(Self);
  FMstProdukItem_Arr[Result].ProdItemID := AProdItemID;
  FMstProdukItem_Arr[Result].RuleID := ARuleID;
  FMstProdukItem_Arr[Result].ItemID := AItemID;
end;

function _MstProdukItem_Arr.IndexOf(AProdItemID: integer): integer;
var i: integer; found: boolean;
begin
  i := 0; found := false;
  while (i<=high(FMstProdukItem_Arr)) and (not found) do
    if (FMstProdukItem_Arr[i].FProdItemID=AProdItemID) then
      found := true
    else inc(i);
  if (found) then
    Result := i
  else
    Result := -1;
end;

procedure _MstProdukItem_Arr.Delete(Index: integer);
var i: integer;
begin
  if (Index<0) or (Index>high(FMstProdukItem_Arr)) then Exit;
  FMstProdukItem_Arr[Index].Destroy;
  for i:=Index to high(FMstProdukItem_Arr)-1 do
    FMstProdukItem_Arr[Index] := FMstProdukItem_Arr[Index-1];
  setLength(FMstProdukItem_Arr,length(FMstProdukItem_Arr)-1);
end;

function _MstProdukItem_Arr.Count: integer;
begin
  Result := length(FMstProdukItem_Arr);
end;

function _MstProdukItem_Arr.Get(Index: integer): _MstProdukItem;
begin
  if (Index<0) or (Index>high(FMstProdukItem_Arr)) then Result := nil
  else Result := FMstProdukItem_Arr[Index];
end;


{ _MstProdukItem }

constructor _MstProdukItem.Create(AOwner: TObject);
begin
  inherited Create;
  FOwner := AOwner;
end;

destructor _MstProdukItem.Destroy;
begin
  inherited;
end;

procedure _MstProdukItem.Reset;
begin
  FProdItemID := 0;
  FRuleID := 0;
  FItemID := 0;
end;

procedure _MstProdukItem.InsertOnDB;
begin
  try ExecSQL(
    'INSERT INTO Mst_Produk_Item (Rule_ID,Item_ID)'+
    ' VALUES ('+
      FormatSQLNumber(FRuleID)+','+
      FormatSQLNumber(FItemID)+')'
  ); except raise; end;
end;

procedure _MstProdukItem.UpdateOnDB;
begin
  try ExecSQL(
    'UPDATE Mst_Produk_Item SET'+
          ' Rule_ID='+FormatSQLNumber(FRuleID)+','+
          ' Item_ID='+FormatSQLNumber(FItemID)+
    ' WHERE Prod_Item_ID='+FormatSQLNumber(FProdItemID)
  ); except raise; end;
end;

procedure _MstProdukItem.DeleteOnDB;
begin
  try ExecSQL(
    'DELETE FROM Mst_Produk_Item'+
    ' WHERE Prod_Item_ID='+FormatSQLNumber(FProdItemID)
  ); except raise; end;
end;


{ _MstRakItem_Arr }

constructor _MstRakItem_Arr.Create(AOwner: TObject);
begin
  inherited Create;
  FOwner := AOwner;
  setLength(FMstRakItem_Arr,0);
end;

destructor _MstRakItem_Arr.Destroy;
begin
  Self.Clear;
  inherited;
end;

procedure _MstRakItem_Arr.Clear;
var i: integer;
begin
  for i:=0 to high(FMstRakItem_Arr) do FMstRakItem_Arr[i].Destroy;
  setLength(FMstRakItem_Arr,0);
end;

function _MstRakItem_Arr.Add(ARakID: integer; AItemID: integer): integer;
begin
  setLength(FMstRakItem_Arr, length(FMstRakItem_Arr)+1);
  Result := high(FMstRakItem_Arr);
  FMstRakItem_Arr[Result] := _MstRakItem.Create(Self);
  FMstRakItem_Arr[Result].RakID := ARakID;
  FMstRakItem_Arr[Result].ItemID := AItemID;
end;

procedure _MstRakItem_Arr.Delete(Index: integer);
var i: integer;
begin
  if (Index<0) or (Index>high(FMstRakItem_Arr)) then Exit;
  FMstRakItem_Arr[Index].Destroy;
  for i:=Index to high(FMstRakItem_Arr)-1 do
    FMstRakItem_Arr[Index] := FMstRakItem_Arr[Index-1];
  setLength(FMstRakItem_Arr,length(FMstRakItem_Arr)-1);
end;

function _MstRakItem_Arr.Count: integer;
begin
  Result := length(FMstRakItem_Arr);
end;

function _MstRakItem_Arr.Get(Index: integer): _MstRakItem;
begin
  if (Index<0) or (Index>high(FMstRakItem_Arr)) then Result := nil
  else Result := FMstRakItem_Arr[Index];
end;


{ _MstRakItem }

constructor _MstRakItem.Create(AOwner: TObject);
begin
  inherited Create;
  FOwner := AOwner;
end;

destructor _MstRakItem.Destroy;
begin
  inherited;
end;

procedure _MstRakItem.Reset;
begin
  FRakID := 0;
  FItemID := 0;
end;

procedure _MstRakItem.InsertOnDB;
begin
  try ExecSQL(
    'INSERT INTO Mst_Rak_Item (Rak_ID,Item_ID)'+
    ' VALUES ('+
      FormatSQLNumber(FRakID)+','+
      FormatSQLNumber(FItemID)+')'
  ); except raise; end;
end;

procedure _MstRakItem.UpdateOnDB;
begin
  try ExecSQL(
    'UPDATE Mst_Rak_Item SET'+
          ' Rak_ID='+FormatSQLNumber(FRakID)+','+
          ' Item_ID='+FormatSQLNumber(FItemID)+
    ''
  ); except raise; end;
end;

procedure _MstRakItem.DeleteOnDB;
begin
  try ExecSQL(
    'DELETE FROM Mst_Rak_Item'+
    ''
  ); except raise; end;
end;


{ _MstServicePrice_Arr }

constructor _MstServicePrice_Arr.Create(AOwner: TObject);
begin
  inherited Create;
  FOwner := AOwner;
  setLength(FMstServicePrice_Arr,0);
end;

destructor _MstServicePrice_Arr.Destroy;
begin
  Self.Clear;
  inherited;
end;

procedure _MstServicePrice_Arr.Clear;
var i: integer;
begin
  for i:=0 to high(FMstServicePrice_Arr) do FMstServicePrice_Arr[i].Destroy;
  setLength(FMstServicePrice_Arr,0);
end;

function _MstServicePrice_Arr.Add(AServicePriceID: integer; AServiceID: integer; AAnimalId: integer; APrice: real; AAddPrice: real; AInsertLog: string; AEditLog: string;ADiscount:real): integer;
begin
  setLength(FMstServicePrice_Arr, length(FMstServicePrice_Arr)+1);
  Result := high(FMstServicePrice_Arr);
  FMstServicePrice_Arr[Result] := _MstServicePrice.Create(Self);
  FMstServicePrice_Arr[Result].ServicePriceID := AServicePriceID;
  FMstServicePrice_Arr[Result].ServiceID := AServiceID;
  FMstServicePrice_Arr[Result].AnimalId := AAnimalId;
  FMstServicePrice_Arr[Result].Price := APrice;
  FMstServicePrice_Arr[Result].AddPrice := AAddPrice;
  FMstServicePrice_Arr[Result].InsertLog := AInsertLog;
  FMstServicePrice_Arr[Result].EditLog := AEditLog;
  FMstServicePrice_Arr[Result].Discount := ADiscount;
end;

procedure _MstServicePrice_Arr.Delete(Index: integer);
var i: integer;
begin
  if (Index<0) or (Index>high(FMstServicePrice_Arr)) then Exit;
  FMstServicePrice_Arr[Index].Destroy;
  for i:=Index to high(FMstServicePrice_Arr)-1 do
    FMstServicePrice_Arr[Index] := FMstServicePrice_Arr[Index-1];
  setLength(FMstServicePrice_Arr,length(FMstServicePrice_Arr)-1);
end;

function _MstServicePrice_Arr.Count: integer;
begin
  Result := length(FMstServicePrice_Arr);
end;

function _MstServicePrice_Arr.Get(Index: integer): _MstServicePrice;
begin
  if (Index<0) or (Index>high(FMstServicePrice_Arr)) then Result := nil
  else Result := FMstServicePrice_Arr[Index];
end;


{ _MstServicePrice }

constructor _MstServicePrice.Create(AOwner: TObject);
begin
  inherited Create;
  FOwner := AOwner;
end;

destructor _MstServicePrice.Destroy;
begin
  inherited;
end;

procedure _MstServicePrice.Reset;
begin
  FServicePriceID := 0;
  FServiceID := 0;
  FAnimalId := 0;
  FPrice := 0.0;
  FAddPrice := 0.0;
  FInsertLog := '';
  FEditLog := '';
  FDiscount := 0.0;
end;

procedure _MstServicePrice.InsertOnDB;
begin
end;

procedure _MstServicePrice.UpdateOnDB;
begin
  {try myConnection.ExecSQL(
    'UPDATE Mst_Service_Price SET'+
          ' Service_Price_ID='+FormatSQLNumber(FServicePriceID)+','+
          ' Service_ID='+FormatSQLNumber(FServiceID)+','+
          ' Animal_Id='+FormatSQLNumber(FAnimalId)+','+
          ' Price='+FormatSQLNumber(FPrice)+','+
          ' Add_Price='+FormatSQLNumber(FAddPrice)+','+
          ' Insert_Log='+FormatSQLString(FInsertLog)+','+
          ' Edit_Log='+FormatSQLString(FEditLog)+
    ''
  ); except raise; end;}
end;

procedure _MstServicePrice.DeleteOnDB;
begin
end;


{ _MstRelationAnimal_Arr }

constructor _MstRelationAnimal_Arr.Create(AOwner: TObject);
begin
  inherited Create;
  FOwner := AOwner;
  setLength(FMstRelationAnimal_Arr,0);
end;

destructor _MstRelationAnimal_Arr.Destroy;
begin
  Self.Clear;
  inherited;
end;

procedure _MstRelationAnimal_Arr.Clear;
var i: integer;
begin
  for i:=0 to high(FMstRelationAnimal_Arr) do FMstRelationAnimal_Arr[i].Destroy;
  setLength(FMstRelationAnimal_Arr,0);
end;

function _MstRelationAnimal_Arr.Add(ARelationID: integer; ASeq: integer; AAnimalName: string; AAnimalID: integer; ARace: string; AEat: string; AAge: string; ASex: integer; ADisabled: integer): integer;
begin
  setLength(FMstRelationAnimal_Arr, length(FMstRelationAnimal_Arr)+1);
  Result := high(FMstRelationAnimal_Arr);
  FMstRelationAnimal_Arr[Result] := _MstRelationAnimal.Create(Self);
  FMstRelationAnimal_Arr[Result].RelationID := ARelationID;
  FMstRelationAnimal_Arr[Result].Seq := ASeq;
  FMstRelationAnimal_Arr[Result].AnimalName := AAnimalName;
  FMstRelationAnimal_Arr[Result].AnimalID := AAnimalID;
  FMstRelationAnimal_Arr[Result].Race := ARace;
  FMstRelationAnimal_Arr[Result].Eat := AEat;
  FMstRelationAnimal_Arr[Result].Age := AAge;
  FMstRelationAnimal_Arr[Result].Sex := ASex;
  FMstRelationAnimal_Arr[Result].Disabled := ADisabled;
end;

function _MstRelationAnimal_Arr.IndexOf(ARelationID: integer; ASeq: integer): integer;
var i: integer; found: boolean;
begin
  i := 0; found := false;
  while (i<=high(FMstRelationAnimal_Arr)) and (not found) do
    if (FMstRelationAnimal_Arr[i].FRelationID=ARelationID) and
       (FMstRelationAnimal_Arr[i].FSeq=ASeq) then
      found := true
    else inc(i);
  if (found) then
    Result := i
  else
    Result := -1;
end;

procedure _MstRelationAnimal_Arr.Delete(Index: integer);
var i: integer;
begin
  if (Index<0) or (Index>high(FMstRelationAnimal_Arr)) then Exit;
  FMstRelationAnimal_Arr[Index].Destroy;
  for i:=Index to high(FMstRelationAnimal_Arr)-1 do
    FMstRelationAnimal_Arr[Index] := FMstRelationAnimal_Arr[Index-1];
  setLength(FMstRelationAnimal_Arr,length(FMstRelationAnimal_Arr)-1);
end;

function _MstRelationAnimal_Arr.Count: integer;
begin
  Result := length(FMstRelationAnimal_Arr);
end;

function _MstRelationAnimal_Arr.Get(Index: integer): _MstRelationAnimal;
begin
  if (Index<0) or (Index>high(FMstRelationAnimal_Arr)) then Result := nil
  else Result := FMstRelationAnimal_Arr[Index];
end;


{ _MstRelationAnimal }

constructor _MstRelationAnimal.Create(AOwner: TObject);
begin
  inherited Create;
  FOwner := AOwner;
end;

destructor _MstRelationAnimal.Destroy;
begin
  inherited;
end;

procedure _MstRelationAnimal.Reset;
begin
  FRelationID := 0;
  FSeq := 0;
  FAnimalName := '';
  FAnimalID := 0;
  FRace := '';
  FEat := '';
  FAge := '';
  FSex := 0;
  FDisabled := 0;
end;

procedure _MstRelationAnimal.InsertOnDB;
begin
  try ExecSQL(
    'INSERT INTO Mst_Relation_Animal (Relation_ID,Seq,Animal_Name,Animal_ID,Race,Eat,Age,Sex,Disabled)'+
    ' VALUES ('+
      FormatSQLNumber(FRelationID)+','+
      FormatSQLNumber(FSeq)+','+
      FormatSQLString(FAnimalName)+','+
      FormatSQLNumber(FAnimalID)+','+
      FormatSQLString(FRace)+','+
      FormatSQLString(FEat)+','+
      FormatSQLString(FAge)+','+
      FormatSQLNumber(FSex)+','+
      FormatSQLNumber(FDisabled)+')'
  ); except raise; end;
end;

procedure _MstRelationAnimal.UpdateOnDB;
begin
  try ExecSQL(
    'UPDATE Mst_Relation_Animal SET'+
          ' Animal_Name='+FormatSQLString(FAnimalName)+','+
          ' Animal_ID='+FormatSQLNumber(FAnimalID)+','+
          ' Race='+FormatSQLString(FRace)+','+
          ' Eat='+FormatSQLString(FEat)+','+
          ' Age='+FormatSQLString(FAge)+','+
          ' Sex='+FormatSQLNumber(FSex)+','+
          ' Disabled='+FormatSQLNumber(FDisabled)+
    ' WHERE Relation_ID='+FormatSQLNumber(FRelationID)+
      ' AND Seq='+FormatSQLNumber(FSeq)
  ); except raise; end;
end;

procedure _MstRelationAnimal.DeleteOnDB;
begin
  try ExecSQL(
    'DELETE FROM Mst_Relation_Animal'+
    ' WHERE Relation_ID='+FormatSQLNumber(FRelationID)+
      ' AND Seq='+FormatSQLNumber(FSeq)
  ); except raise; end;
end;



{ _MstBranch_Arr }

constructor _MstBranch_Arr.Create(AOwner: TObject);
begin
  inherited Create;
  FOwner := AOwner;
  setLength(FMstBranch_Arr,0);
end;

destructor _MstBranch_Arr.Destroy;
begin
  Self.Clear;
  inherited;
end;

procedure _MstBranch_Arr.Clear;
var i: integer;
begin
  for i:=0 to high(FMstBranch_Arr) do FMstBranch_Arr[i].Destroy;
  setLength(FMstBranch_Arr,0);
end;

function _MstBranch_Arr.Add(ABranchID: integer; ABranchCode: string; ABranchName: string; AAddress: string; APhone1: string; APhone2: string; AFax: string; AInsertLog: string; AEditLog: string): integer;
begin
  setLength(FMstBranch_Arr, length(FMstBranch_Arr)+1);
  Result := high(FMstBranch_Arr);
  FMstBranch_Arr[Result] := _MstBranch.Create(Self);
  FMstBranch_Arr[Result].BranchID := ABranchID;
  FMstBranch_Arr[Result].BranchCode := ABranchCode;
  FMstBranch_Arr[Result].BranchName := ABranchName;
  FMstBranch_Arr[Result].Address := AAddress;
  FMstBranch_Arr[Result].Phone1 := APhone1;
  FMstBranch_Arr[Result].Phone2 := APhone2;
  FMstBranch_Arr[Result].Fax := AFax;
  FMstBranch_Arr[Result].InsertLog := AInsertLog;
  FMstBranch_Arr[Result].EditLog := AEditLog;
end;

function _MstBranch_Arr.IndexOf(ABranchID: integer): integer;
var i: integer; found: boolean;
begin
  i := 0; found := false;
  while (i<=high(FMstBranch_Arr)) and (not found) do
    if (FMstBranch_Arr[i].FBranchID=ABranchID) then
      found := true
    else inc(i);
  if (found) then
    Result := i
  else
    Result := -1;
end;

procedure _MstBranch_Arr.Delete(Index: integer);
var i: integer;
begin
  if (Index<0) or (Index>high(FMstBranch_Arr)) then Exit;
  FMstBranch_Arr[Index].Destroy;
  for i:=Index to high(FMstBranch_Arr)-1 do
    FMstBranch_Arr[Index] := FMstBranch_Arr[Index-1];
  setLength(FMstBranch_Arr,length(FMstBranch_Arr)-1);
end;

function _MstBranch_Arr.Count: integer;
begin
  Result := length(FMstBranch_Arr);
end;

function _MstBranch_Arr.Get(Index: integer): _MstBranch;
begin
  if (Index<0) or (Index>high(FMstBranch_Arr)) then Result := nil
  else Result := FMstBranch_Arr[Index];
end;


{ _MstBranch }

constructor _MstBranch.Create(AOwner: TObject);
begin
  inherited Create;
  FOwner := AOwner;
end;

destructor _MstBranch.Destroy;
begin
  inherited;
end;

procedure _MstBranch.Reset;
begin
  FBranchID := 0;
  FBranchCode := '';
  FBranchName := '';
  FAddress := '';
  FPhone1 := '';
  FPhone2 := '';
  FFax := '';
  FInsertLog := '';
  FEditLog := '';
end;

procedure _MstBranch.InsertOnDB;
begin
  try ExecSQL(
    'INSERT INTO Mst_Branch (Branch_Code,Branch_Name,Address,Phone1,Phone2,Fax,Insert_Log,Edit_Log)'+
    ' VALUES ('+
      FormatSQLString(FBranchCode)+','+
      FormatSQLString(FBranchName)+','+
      FormatSQLString(FAddress)+','+
      FormatSQLString(FPhone1)+','+
      FormatSQLString(FPhone2)+','+
      FormatSQLString(FFax)+','+
      FormatSQLString(FInsertLog)+','+
      FormatSQLString(FEditLog)+')'
  ); except raise; end;
end;

procedure _MstBranch.UpdateOnDB;
begin
  try ExecSQL(
    'UPDATE Mst_Branch SET'+
          ' Branch_Code='+FormatSQLString(FBranchCode)+','+
          ' Branch_Name='+FormatSQLString(FBranchName)+','+
          ' Address='+FormatSQLString(FAddress)+','+
          ' Phone1='+FormatSQLString(FPhone1)+','+
          ' Phone2='+FormatSQLString(FPhone2)+','+
          ' Fax='+FormatSQLString(FFax)+','+
          ' Insert_Log='+FormatSQLString(FInsertLog)+','+
          ' Edit_Log='+FormatSQLString(FEditLog)+
    ' WHERE Branch_ID='+FormatSQLNumber(FBranchID)
  ); except raise; end;
end;

procedure _MstBranch.DeleteOnDB;
begin
  try ExecSQL(
    'DELETE FROM Mst_Branch'+
    ' WHERE Branch_ID='+FormatSQLNumber(FBranchID)
  ); except raise; end;
end;



{ _TrsMoneyTransMst_Arr }

constructor _TrsMoneyTransMst_Arr.Create(AOwner: TObject);
begin
  inherited Create;
  FOwner := AOwner;
  setLength(FTrsMoneyTransMst_Arr,0);
end;

destructor _TrsMoneyTransMst_Arr.Destroy;
begin
  Self.Clear;
  inherited;
end;

procedure _TrsMoneyTransMst_Arr.Clear;
var i: integer;
begin
  for i:=0 to high(FTrsMoneyTransMst_Arr) do FTrsMoneyTransMst_Arr[i].Destroy;
  setLength(FTrsMoneyTransMst_Arr,0);
end;

function _TrsMoneyTransMst_Arr.Add(AMoneyTransID: integer; ATransNum: string; ATransDate: TDate; ANotes: string; AInsertLog: string; ATransType: integer): integer;
begin
  setLength(FTrsMoneyTransMst_Arr, length(FTrsMoneyTransMst_Arr)+1);
  Result := high(FTrsMoneyTransMst_Arr);
  FTrsMoneyTransMst_Arr[Result] := _TrsMoneyTransMst.Create(Self);
  FTrsMoneyTransMst_Arr[Result].MoneyTransID := AMoneyTransID;
  FTrsMoneyTransMst_Arr[Result].TransNum := ATransNum;
  FTrsMoneyTransMst_Arr[Result].TransDate := ATransDate;
  FTrsMoneyTransMst_Arr[Result].Notes := ANotes;
  FTrsMoneyTransMst_Arr[Result].InsertLog := AInsertLog;
  FTrsMoneyTransMst_Arr[Result].TransType := ATransType;
end;

function _TrsMoneyTransMst_Arr.IndexOf(AMoneyTransID: integer): integer;
var i: integer; found: boolean;
begin
  i := 0; found := false;
  while (i<=high(FTrsMoneyTransMst_Arr)) and (not found) do
    if (FTrsMoneyTransMst_Arr[i].FMoneyTransID=AMoneyTransID) then
      found := true
    else inc(i);
  if (found) then
    Result := i
  else
    Result := -1;
end;

procedure _TrsMoneyTransMst_Arr.Delete(Index: integer);
var i: integer;
begin
  if (Index<0) or (Index>high(FTrsMoneyTransMst_Arr)) then Exit;
  FTrsMoneyTransMst_Arr[Index].Destroy;
  for i:=Index to high(FTrsMoneyTransMst_Arr)-1 do
    FTrsMoneyTransMst_Arr[Index] := FTrsMoneyTransMst_Arr[Index-1];
  setLength(FTrsMoneyTransMst_Arr,length(FTrsMoneyTransMst_Arr)-1);
end;

function _TrsMoneyTransMst_Arr.Count: integer;
begin
  Result := length(FTrsMoneyTransMst_Arr);
end;

function _TrsMoneyTransMst_Arr.Get(Index: integer): _TrsMoneyTransMst;
begin
  if (Index<0) or (Index>high(FTrsMoneyTransMst_Arr)) then Result := nil
  else Result := FTrsMoneyTransMst_Arr[Index];
end;


{ _TrsMoneyTransMst }

constructor _TrsMoneyTransMst.Create(AOwner: TObject);
begin
  inherited Create;
  FOwner := AOwner;
end;

destructor _TrsMoneyTransMst.Destroy;
begin
  inherited;
end;

procedure _TrsMoneyTransMst.Reset;
begin
  FMoneyTransID := 0;
  FTransNum := '';
  FTransDate := 0;
  FNotes := '';
  FInsertLog := '';
  FTransType := 0;
end;

procedure _TrsMoneyTransMst.InsertOnDB;
begin
  try ExecSQL(
    'INSERT INTO Trs_Money_Trans_Mst (TransNum,TransDate,Notes,InsertLog,TransType)'+
    ' VALUES ('+
      FormatSQLString(FTransNum)+','+
      FormatSQLDate(FTransDate)+','+
      FormatSQLString(FNotes)+','+
      FormatSQLString(FInsertLog)+','+
      FormatSQLNumber(FTransType)+')'
  ); except raise; end;
end;

procedure _TrsMoneyTransMst.UpdateOnDB;
begin
  try ExecSQL(
    'UPDATE Trs_Money_Trans_Mst SET'+
          ' TransNum='+FormatSQLString(FTransNum)+','+
          ' TransDate='+FormatSQLDate(FTransDate)+','+
          ' Notes='+FormatSQLString(FNotes)+','+
          ' InsertLog='+FormatSQLString(FInsertLog)+','+
          ' TransType='+FormatSQLNumber(FTransType)+
    ' WHERE MoneyTransID='+FormatSQLNumber(FMoneyTransID)
  ); except raise; end;
end;

procedure _TrsMoneyTransMst.DeleteOnDB;
begin
  try ExecSQL(
    'DELETE FROM Trs_Money_Trans_Mst'+
    ' WHERE MoneyTransID='+FormatSQLNumber(FMoneyTransID)
  ); except raise; end;
end;


{ _TrsMoneyTransDetail_Arr }

constructor _TrsMoneyTransDetail_Arr.Create(AOwner: TObject);
begin
  inherited Create;
  FOwner := AOwner;
  setLength(FTrsMoneyTransDetail_Arr,0);
end;

destructor _TrsMoneyTransDetail_Arr.Destroy;
begin
  Self.Clear;
  inherited;
end;

procedure _TrsMoneyTransDetail_Arr.Clear;
var i: integer;
begin
  for i:=0 to high(FTrsMoneyTransDetail_Arr) do FTrsMoneyTransDetail_Arr[i].Destroy;
  setLength(FTrsMoneyTransDetail_Arr,0);
end;

function _TrsMoneyTransDetail_Arr.Add(AMoneyTransDetailID: integer; AMoneyTransID: integer; AMoneyID: integer; ADescription: string; AAmount: real;AAkunID:integer): integer;
begin
  setLength(FTrsMoneyTransDetail_Arr, length(FTrsMoneyTransDetail_Arr)+1);
  Result := high(FTrsMoneyTransDetail_Arr);
  FTrsMoneyTransDetail_Arr[Result] := _TrsMoneyTransDetail.Create(Self);
  FTrsMoneyTransDetail_Arr[Result].MoneyTransDetailID := AMoneyTransDetailID;
  FTrsMoneyTransDetail_Arr[Result].MoneyTransID := AMoneyTransID;
  FTrsMoneyTransDetail_Arr[Result].MoneyID := AMoneyID;
  FTrsMoneyTransDetail_Arr[Result].Description := ADescription;
  FTrsMoneyTransDetail_Arr[Result].Amount := AAmount;
  FTrsMoneyTransDetail_Arr[Result].AkunID := AAkunID;
end;

function _TrsMoneyTransDetail_Arr.IndexOf(AMoneyTransDetailID: integer): integer;
var i: integer; found: boolean;
begin
  i := 0; found := false;
  while (i<=high(FTrsMoneyTransDetail_Arr)) and (not found) do
    if (FTrsMoneyTransDetail_Arr[i].FMoneyTransDetailID=AMoneyTransDetailID) then
      found := true
    else inc(i);
  if (found) then
    Result := i
  else
    Result := -1;
end;

procedure _TrsMoneyTransDetail_Arr.Delete(Index: integer);
var i: integer;
begin
  if (Index<0) or (Index>high(FTrsMoneyTransDetail_Arr)) then Exit;
  FTrsMoneyTransDetail_Arr[Index].Destroy;
  for i:=Index to high(FTrsMoneyTransDetail_Arr)-1 do
    FTrsMoneyTransDetail_Arr[Index] := FTrsMoneyTransDetail_Arr[Index-1];
  setLength(FTrsMoneyTransDetail_Arr,length(FTrsMoneyTransDetail_Arr)-1);
end;

function _TrsMoneyTransDetail_Arr.Count: integer;
begin
  Result := length(FTrsMoneyTransDetail_Arr);
end;

function _TrsMoneyTransDetail_Arr.Get(Index: integer): _TrsMoneyTransDetail;
begin
  if (Index<0) or (Index>high(FTrsMoneyTransDetail_Arr)) then Result := nil
  else Result := FTrsMoneyTransDetail_Arr[Index];
end;


{ _TrsMoneyTransDetail }

constructor _TrsMoneyTransDetail.Create(AOwner: TObject);
begin
  inherited Create;
  FOwner := AOwner;
end;

destructor _TrsMoneyTransDetail.Destroy;
begin
  inherited;
end;

procedure _TrsMoneyTransDetail.Reset;
begin
  FMoneyTransDetailID := 0;
  FMoneyTransID := 0;
  FMoneyID := 0;
  FDescription := '';
  FAmount := 0.0;
end;

procedure _TrsMoneyTransDetail.InsertOnDB;
begin
  try ExecSQL(
    'INSERT INTO TrsMoneyTransDetail (MoneyTransID,MoneyID,Description,Amount)'+
    ' VALUES ('+
      FormatSQLNumber(FMoneyTransID)+','+
      FormatSQLNumber(FMoneyID)+','+
      FormatSQLString(FDescription)+','+
      FormatSQLNumber(FAmount)+')'
  ); except raise; end;
end;

procedure _TrsMoneyTransDetail.UpdateOnDB;
begin
  try ExecSQL(
    'UPDATE TrsMoneyTransDetail SET'+
          ' MoneyTransID='+FormatSQLNumber(FMoneyTransID)+','+
          ' MoneyID='+FormatSQLNumber(FMoneyID)+','+
          ' Description='+FormatSQLString(FDescription)+','+
          ' Amount='+FormatSQLNumber(FAmount)+
    ' WHERE MoneyTransDetailID='+FormatSQLNumber(FMoneyTransDetailID)
  ); except raise; end;
end;

procedure _TrsMoneyTransDetail.DeleteOnDB;
begin
  try ExecSQL(
    'DELETE FROM TrsMoneyTransDetail'+
    ' WHERE MoneyTransDetailID='+FormatSQLNumber(FMoneyTransDetailID)
  ); except raise; end;
end;


{ _TrsItemUseMst_Arr }

constructor _TrsItemUseMst_Arr.Create(AOwner: TObject);
begin
  inherited Create;
  FOwner := AOwner;
  setLength(FTrsItemUseMst_Arr,0);
end;

destructor _TrsItemUseMst_Arr.Destroy;
begin
  Self.Clear;
  inherited;
end;

procedure _TrsItemUseMst_Arr.Clear;
var i: integer;
begin
  for i:=0 to high(FTrsItemUseMst_Arr) do FTrsItemUseMst_Arr[i].Destroy;
  setLength(FTrsItemUseMst_Arr,0);
end;

function _TrsItemUseMst_Arr.Add(AItemUseID: integer; ATipe: integer; ATransNum: string; ATransDate: TDate; ANotes: string; AInsertLog: string): integer;
begin
  setLength(FTrsItemUseMst_Arr, length(FTrsItemUseMst_Arr)+1);
  Result := high(FTrsItemUseMst_Arr);
  FTrsItemUseMst_Arr[Result] := _TrsItemUseMst.Create(Self);
  FTrsItemUseMst_Arr[Result].ItemUseID := AItemUseID;
  FTrsItemUseMst_Arr[Result].Tipe := ATipe;
  FTrsItemUseMst_Arr[Result].TransNum := ATransNum;
  FTrsItemUseMst_Arr[Result].TransDate := ATransDate;
  FTrsItemUseMst_Arr[Result].Notes := ANotes;
  FTrsItemUseMst_Arr[Result].InsertLog := AInsertLog;
end;

procedure _TrsItemUseMst_Arr.Delete(Index: integer);
var i: integer;
begin
  if (Index<0) or (Index>high(FTrsItemUseMst_Arr)) then Exit;
  FTrsItemUseMst_Arr[Index].Destroy;
  for i:=Index to high(FTrsItemUseMst_Arr)-1 do
    FTrsItemUseMst_Arr[Index] := FTrsItemUseMst_Arr[Index-1];
  setLength(FTrsItemUseMst_Arr,length(FTrsItemUseMst_Arr)-1);
end;

function _TrsItemUseMst_Arr.Count: integer;
begin
  Result := length(FTrsItemUseMst_Arr);
end;

function _TrsItemUseMst_Arr.Get(Index: integer): _TrsItemUseMst;
begin
  if (Index<0) or (Index>high(FTrsItemUseMst_Arr)) then Result := nil
  else Result := FTrsItemUseMst_Arr[Index];
end;


{ _TrsItemUseMst }

constructor _TrsItemUseMst.Create(AOwner: TObject);
begin
  inherited Create;
  FOwner := AOwner;
end;

destructor _TrsItemUseMst.Destroy;
begin
  inherited;
end;

procedure _TrsItemUseMst.Reset;
begin
  FItemUseID := 0;
  FTipe := 0;
  FTransNum := '';
  FTransDate := 0;
  FNotes := '';
  FInsertLog := '';
end;

procedure _TrsItemUseMst.InsertOnDB;
begin
  try ExecSQL(
    'INSERT INTO Trs_Item_Use_Mst (Tipe,Trans_Num,Trans_Date,Notes,Insert_Log)'+
    ' VALUES ('+
      FormatSQLNumber(FTipe)+','+
      FormatSQLString(FTransNum)+','+
      FormatSQLDate(FTransDate)+','+
      FormatSQLString(FNotes)+','+
      FormatSQLString(FInsertLog)+')'
  ); except raise; end;
end;

procedure _TrsItemUseMst.UpdateOnDB;
begin
  try ExecSQL(
    'UPDATE Trs_Item_Use_Mst SET'+
          ' Item_Use_ID='+FormatSQLNumber(FItemUseID)+','+
          ' Tipe='+FormatSQLNumber(FTipe)+','+
          ' Trans_Num='+FormatSQLString(FTransNum)+','+
          ' Trans_Date='+FormatSQLDate(FTransDate)+','+
          ' Notes='+FormatSQLString(FNotes)+','+
          ' Insert_Log='+FormatSQLString(FInsertLog)+
    ''
  ); except raise; end;
end;

procedure _TrsItemUseMst.DeleteOnDB;
begin
  try ExecSQL(
    'DELETE FROM Trs_Item_Use_Mst'+
    ''
  ); except raise; end;
end;


{ _TrsItemUseDetail_Arr }

constructor _TrsItemUseDetail_Arr.Create(AOwner: TObject);
begin
  inherited Create;
  FOwner := AOwner;
  setLength(FTrsItemUseDetail_Arr,0);
end;

destructor _TrsItemUseDetail_Arr.Destroy;
begin
  Self.Clear;
  inherited;
end;

procedure _TrsItemUseDetail_Arr.Clear;
var i: integer;
begin
  for i:=0 to high(FTrsItemUseDetail_Arr) do FTrsItemUseDetail_Arr[i].Destroy;
  setLength(FTrsItemUseDetail_Arr,0);
end;

function _TrsItemUseDetail_Arr.Add(AItemUseDetailID: integer; AItemUseID: integer; AItemID: integer; AQuantity: real; ABuyingPrice: real; AAmount: real): integer;
begin
  setLength(FTrsItemUseDetail_Arr, length(FTrsItemUseDetail_Arr)+1);
  Result := high(FTrsItemUseDetail_Arr);
  FTrsItemUseDetail_Arr[Result] := _TrsItemUseDetail.Create(Self);
  FTrsItemUseDetail_Arr[Result].ItemUseDetailID := AItemUseDetailID;
  FTrsItemUseDetail_Arr[Result].ItemUseID := AItemUseID;
  FTrsItemUseDetail_Arr[Result].ItemID := AItemID;
  FTrsItemUseDetail_Arr[Result].Quantity := AQuantity;
  FTrsItemUseDetail_Arr[Result].BuyingPrice := ABuyingPrice;
  FTrsItemUseDetail_Arr[Result].Amount := AAmount;
end;

procedure _TrsItemUseDetail_Arr.Delete(Index: integer);
var i: integer;
begin
  if (Index<0) or (Index>high(FTrsItemUseDetail_Arr)) then Exit;
  FTrsItemUseDetail_Arr[Index].Destroy;
  for i:=Index to high(FTrsItemUseDetail_Arr)-1 do
    FTrsItemUseDetail_Arr[Index] := FTrsItemUseDetail_Arr[Index-1];
  setLength(FTrsItemUseDetail_Arr,length(FTrsItemUseDetail_Arr)-1);
end;

function _TrsItemUseDetail_Arr.Count: integer;
begin
  Result := length(FTrsItemUseDetail_Arr);
end;

function _TrsItemUseDetail_Arr.Get(Index: integer): _TrsItemUseDetail;
begin
  if (Index<0) or (Index>high(FTrsItemUseDetail_Arr)) then Result := nil
  else Result := FTrsItemUseDetail_Arr[Index];
end;


{ _TrsItemUseDetail }

constructor _TrsItemUseDetail.Create(AOwner: TObject);
begin
  inherited Create;
  FOwner := AOwner;
end;

destructor _TrsItemUseDetail.Destroy;
begin
  inherited;
end;

procedure _TrsItemUseDetail.Reset;
begin
  FItemUseDetailID := 0;
  FItemUseID := 0;
  FItemID := 0;
  FQuantity := 0.0;
  FBuyingPrice := 0.0;
  FAmount := 0.0;
end;

procedure _TrsItemUseDetail.InsertOnDB;
begin
  try ExecSQL(
    'INSERT INTO Trs_Item_Use_Detail (Item_Use_ID,Item_ID,Quantity,Buying_Price,Amount)'+
    ' VALUES ('+
      FormatSQLNumber(FItemUseID)+','+
      FormatSQLNumber(FItemID)+','+
      FormatSQLNumber(FQuantity)+','+
      FormatSQLNumber(FBuyingPrice)+','+
      FormatSQLNumber(FAmount)+')'
  ); except raise; end;
end;

procedure _TrsItemUseDetail.UpdateOnDB;
begin
  try ExecSQL(
    'UPDATE Trs_Item_Use_Detail SET'+
          ' Item_Use_Detail_ID='+FormatSQLNumber(FItemUseDetailID)+','+
          ' Item_Use_ID='+FormatSQLNumber(FItemUseID)+','+
          ' Item_ID='+FormatSQLNumber(FItemID)+','+
          ' Quantity='+FormatSQLNumber(FQuantity)+','+
          ' Buying_Price='+FormatSQLNumber(FBuyingPrice)+','+
          ' Amount='+FormatSQLNumber(FAmount)+
    ''
  ); except raise; end;
end;

procedure _TrsItemUseDetail.DeleteOnDB;
begin
  try ExecSQL(
    'DELETE FROM Trs_Item_Use_Detail'+
    ''
  ); except raise; end;
end;




end.
