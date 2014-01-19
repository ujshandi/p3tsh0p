unit UTransaction;

interface

uses
  Classes, Controls, SysUtils, AutoStockLine, Subroutines, Math, strUtils,
  UMaster, AdvGrid, uMysqlClient;

type

  TTrsShipment = class(TObject)
  public
    ShipmentMst: _TrsShipmentMst;
    ShipmentDetail_Arr : _TrsShipmentDetail_Arr;
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    function InsertOnDB: boolean;
    function SelectInDB: boolean;
    function GetNewNumber: string;

    class function LoadData: TMysqlResult;
    class function PrintMutasi(ID:integer):TMysqlResult;
    //function DeleteDetail(id: integer): boolean;
    //function GetCurrentId: integer;
  end;

  TTrsSales = class(TObject)
  private
    function ItungTagihanCustomer: double;
    procedure insertPaket(Idx: integer);
    procedure insertRacikan(Idx: integer);
  public
    SalesMst: _TrsSalesMst;
    SalesDetail_Arr : _TrsSalesDetail_Arr;
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    function InsertCashOnDB(holdedID: integer): boolean;
    function InsertCreditOnDB(): boolean;
    function InsertHolded(): boolean;
    function SelectHolded: boolean;
    function isExistHolded(aRelationId,aHewanSeq:integer):boolean;
    function isExistHoldedCustomer(aRelationId:integer):boolean;
    function isRealExistHoldedCustomer(aRelationId:integer):boolean;
    function DelHolded(ID: integer): boolean;

    function SelectInDB: boolean;
    function GetNewNumber: string;
    function GetNewHoldedNumber: string;
    function GetCustomer(vcashierID: integer): string;

    class function GetID(ID: integer): string;
    class function DeleteTrans(ID: integer): boolean;
    class function DeleteDetail(ID: integer): boolean;

    class function InsertSaldoAwal(Saldo: double): boolean;
    class function getSaldoAwal(): double;
    class procedure DeleteRacikan(ID: integer);
    class function countResepRacik(ID: integer): integer;
    class function PrintSales(ID:integer):TMysqlResult;
    class function PrintHolder(ID:integer):TMysqlResult;

  end;

  TTrsOrder = class(TObject)
  public
    OrderMst: _TrsOrderMst;
    OrderDetail_Arr : _TrsOrderDetail_Arr;
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    function InsertOnDB(): boolean;
    function UpdateOnDB(): boolean;
    function SelectInDB: boolean;
    function GetNewNumber: string;
    class function GetID(ID: integer): string;
    class function GetIDFromReceipt(ID: integer): TMysqlResult;
    class function GetRelationID(ID: integer): integer;
    class function GetJenisFaktur(ID: integer): integer;
    class function GetDisc2(ID: integer): double;
    class function GetTax(ID: integer): double;
    class function DeleteTrans(ID: integer): boolean;
    class function DeleteDetail(ID: integer): boolean;
    class function PostTrans(ID: integer): boolean;
    class function LoadRekap: TMysqlResult;
    class procedure updateStatusOrder(id, st: integer);
    class function printOrder(Id:integer):TMysqlResult;
  end;

  TTrsReceipt = class(_TrsReceiptMst)
  public
    trsDetail : _TrsReceiptDetail_Arr;
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    function InsertOnDB(): boolean; reintroduce;
    function UpdateOnDB(): boolean; reintroduce;
    function SelectInDB: boolean; reintroduce;
    function GetNewNumber: string;
    function SelectDetail(ID: integer): TMysqlResult;
    function SelectOrderDetail(ID: integer): TMysqlResult;
    class function GetID(ID: integer): string;
    class function DeleteTrans(ID: integer): boolean;
    class function DeleteDetail(ID: integer): boolean;
    class function PostTrans(ID: integer): boolean;
    class function LoadRekap: TMysqlResult;
    class function LoadRekapDetail: TMysqlResult;
    class function GetLastReceipt(ID: integer): TDate;
    class function DeletePostTrans(ID: integer): boolean;
    class function DeleteRowPostTrans(ID, IDdetail: integer): boolean;
    {class function GetID(ID: integer): string;}
  end;

  TTrsRetur = class(_TrsReturMst)
  public
    trsDetail : _TrsReturDetail_Arr;
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    function InsertOnDB(): boolean; reintroduce;
    function UpdateOnDB(): boolean; reintroduce;
    function SelectInDB: boolean; reintroduce;
    function GetNewNumber: string;
    function SelectDetail(ID: integer): TMysqlResult;
    function SelectFakturDetail(ID: integer): TMysqlResult;
    class function DeleteTrans(ID: integer): boolean;
    class function DeleteDetail(ID: integer): boolean;
    class function PostTrans(ID: integer): boolean;
    class function LoadRekap: TMysqlResult;
    class function printRetur(ID:integer):TMysqlResult;
  end;

  TTrsPayment = class(_TrsPaymentMst)
  public
    trsDetail : _TrsPaymentDetail_Arr;
    akunDetail: _TrsPaymentAkun_Arr;
    constructor Create;
    destructor Destroy; override;
    procedure Reset; override;
    function InsertOnDB(): boolean; reintroduce;
    function UpdateOnDB(): boolean; reintroduce;
    function SelectInDB: boolean; reintroduce;
    function InsertCharges(): boolean; reintroduce;
    function UpdateCharges(): boolean; reintroduce;
    function GetNewNumber: string;
    function SelectDetail(ID: integer): TMysqlResult;
    function SelectDetailAkun(ID: integer): TMysqlResult;
    function SelectFaktur(ID: integer): TMysqlResult;
    function SelectStruk(ID: integer): TMysqlResult;
    class function DeleteTrans(ID: integer): boolean;
    class function DeleteDetail(ID: integer): boolean;
    class function DeleteDetailAkun(ID: integer): boolean;
    class function PostTrans(ID, JNS: integer): boolean;
    class function LoadRekap: TMysqlResult;
    {class function GetID(ID: integer): string;}
  end;

  TTrsMoneyTransaction = class(_TrsMoneyTransMst)
  public
    trsDetail : _TrsMoneyTransDetail_Arr;

    constructor Create;
    destructor Destroy; override;
    procedure Reset; override;
    function InsertOnDB(): boolean; reintroduce;
    function UpdateOnDB(): boolean; reintroduce;
    function SelectInDB: boolean; reintroduce;
    function GetNewNumber: string;
    function SelectDetail(ID: integer): TMysqlResult;
    class function DeleteTrans(ID: integer): boolean;
    class function LoadRekap: TMysqlResult;
    class function getSaldoAwal(tgl:TDate;moneyId:integer):double;
  end;

  TTrsDebtAdjustment = class(_TrsDebtAdjustment)
  public
    function InsertOnDB(): boolean; reintroduce;
  end;

  TReport = class(TObject)
  public
    class function LoadRekapStock(): TMysqlResult;
    class function LoadRekapKas(): TMysqlResult;
    class function LoadRekapItem(): TMysqlResult;
    class function LoadRekapItemSpeed(): TMysqlResult;
    class function LoadRekapMoneySpeed(): TMysqlResult;
    class function LoadMutasiStock(ID: integer): TMysqlResult;
    class function LoadKartuStock(ID: integer): TMysqlResult;
    class function LoadKartuKas(ID: integer): TMysqlResult;

    class function LoadJualItem(): TMysqlResult;
    class function LoadJualDiscTotal(): double;
    class function LoadQtyJual(ID: integer): TMysqlResult;
    class function LoadQtyRetur(ID: integer): TMysqlResult;

    class function LoadBeliItem(): TMysqlResult;
    class function LoadBeliDiscTotal(): double;
    class function LoadQtyBeli(ID: integer): TMysqlResult;
    class function LoadQtyReturBl(ID: integer): TMysqlResult;
    class function LoadMutasiUtang(): TMysqlResult;
    class function LoadMutasiPiutang(): TMysqlResult;

//penjualan by date
    class function LoadTglJual(): TMysqlResult;
    class function LoadTglJualNilai(): TMysqlResult;
    class function LoadTglJualNilai2(): TMysqlResult;
    class function LoadTglJualApotek(): TMysqlResult;

    class function LoadTglJualKunjungan(): TMysqlResult;

    class function LoadTglJualNilaiBulan(): TMysqlResult;
    class function LoadTglJualNilaiBulan2(): TMysqlResult;
    class function LoadTglJualNilaiBulanApotek(): TMysqlResult;
    class function LoadTglJualBulanKunjungan(): TMysqlResult;
    class function LoadTglJualHistori(): TMysqlResult;

//item movement
    class function LoadItemMovement(): TMysqlResult;

    class function LoadItemIddle(): TMysqlResult;

//rugi/laba
    class function getPendapatanSewa(): double;
    class function getPenjualan(aTipe:integer): double;
    class function getPenjualanDisc(): double;
    class function getPenjualanRetur(): double;

    class function getPembelian(): double;
    class function getPemakaian(): double;
    class function getPembelianDisc(): double;
    class function getPembelianRetur(): double;
    class function getMutasi(): double;

    class function getAkunBiaya: TMysqlResult;
    class function getBiaya(AkunID: integer): double;

    class function LoadSalesRekap: TMysqlResult;
  end;


  TTrsItemUse = class(_TrsItemUseMst)
  public
    trsDetail : _TrsItemUseDetail_Arr;

    constructor Create;
    destructor Destroy; override;
    procedure Reset; override;
    function InsertOnDB(): boolean; reintroduce;
    function UpdateOnDB(): boolean; reintroduce;
    function SelectInDB: boolean; reintroduce;
    function GetNewNumber: string;
    function SelectDetail(ID: integer): TMysqlResult;
    class function DeleteTrans(ID: integer): boolean;
    class function LoadRekap: TMysqlResult;
  end;

implementation

uses UConstTool, UQueryPackage, UConst, EpsonUtils,
  MySQLConnector, UPetshop;

{ TTrsShipment }

procedure TTrsShipment.Clear;
begin
  ShipmentMst.Reset;
  ShipmentDetail_Arr.Clear;
end;

constructor TTrsShipment.Create;
begin
  inherited Create;
  ShipmentMst:= _TrsShipmentMst.Create;
  ShipmentDetail_Arr:= _TrsShipmentDetail_Arr.Create;
end;

destructor TTrsShipment.Destroy;
begin
  Self.Clear;
  ShipmentMst.Free;
  ShipmentDetail_Arr.Free;
  inherited;
end;

function TTrsShipment.GetNewNumber: string;
var prefix: string;

  function get_type(): string;
  begin
    Result:= GlobalSystemConfig[CONF_PREP_COMP-1].ConfValue;
    if ShipmentMst.Tipe = ITEM_TYPE_MUTASI_MASUK then
      Result:= Result + GlobalSystemConfig[CONF_PREP_INPUT-1].ConfValue
    else if ShipmentMst.Tipe = ITEM_TYPE_OPNAME then
      Result:= Result + GlobalSystemConfig[CONF_PREP_OPNAME-1].ConfValue
    else if ShipmentMst.Tipe = ITEM_TYPE_MUTASI_KELUAR then
      Result:= Result + GlobalSystemConfig[CONF_PREP_MUSTASI-1].ConfValue;
  end;

begin
  prefix := get_type+getPeriode3(ShipmentMst.Transdate);
  Result:= prefix + getNextIDNumPeriode2('trans_num ','trs_shipment_mst ',
    ' and tipe = '+FormatSQLNumber(ShipmentMst.Tipe),prefix,'','',5);
end;

function TTrsShipment.InsertOnDB: boolean;
var i: integer; sql: string;
begin

  if DEMO_VERSION then begin
    if getIntegerFromSQL('select count(*) from trs_shipment_mst') > 100 then begin
      Result:= False;
      Inform('Maaf versi demo hanya untuk 100 transaksi.');
      Exit;
    end;
  end;
  try
    BeginSQL;
    ShipmentMst.TransNum:= GetNewNumber;

    ExecSQL(
    'insert into trs_shipment_mst ('+
      'trans_num, tipe, trans_date, notes, gudang_asal, gudang_tujuan, user_id) '+
    'values ('+
      FormatSQLString(ShipmentMst.TransNum)+','+
      FormatSQLNumber(ShipmentMst.Tipe)+','+
      FormatSQLDate(ShipmentMst.Transdate)+','+
      FormatSQLString(ShipmentMst.Notes)+','+
      IfThen(ShipmentMst.GudangAsal <> 0, FormatSQLNumber(ShipmentMst.GudangAsal), FormatSQLNULL)+','+
      IfThen(ShipmentMst.GudangTujuan <> 0, FormatSQLNumber(ShipmentMst.GudangTujuan), FormatSQLNULL)+','+
      FormatSQLString(ShipmentMst.UserId)+')');

    ShipmentMst.ShipId:= getIntegerFromSQL(
      'select ship_id from trs_shipment_mst where trans_num = '+FormatSQLString(ShipmentMst.TransNum));

  //insert into detail
    for i:= 0 to ShipmentDetail_Arr.Count -1 do begin
      sql:=
      'insert into trs_shipment_detail ('+
          'ship_id, item_id,  quantity, price_sales, price_cost, '+
          'price_purchase, hrg_beli, stok,quantity_ori,conversion)'+
        'values ('+
          FormatSQLNumber(ShipmentMst.ShipId)+','+
          FormatSQLNumber(ShipmentDetail_Arr[i].MstItem.ItemId)+','+
//          FormatSQLNumber(ShipmentDetail_Arr[i].MstItemConversion.ConvId)+','+
          FormatSQLNumber(ShipmentDetail_Arr[i].Quantity)+','+
          FormatSQLNumber(ShipmentDetail_Arr[i].PriceSales)+','+
          FormatSQLNumber(ShipmentDetail_Arr[i].PriceCost)+','+
          FormatSQLNumber(ShipmentDetail_Arr[i].PricePurchase)+','+
          FormatSQLNumber(ShipmentDetail_Arr[i].HrgBeli)+','+
          FormatSQLNumber(ShipmentDetail_Arr[i].Stok)+','+
          FormatSQLNumber(ShipmentDetail_Arr[i].QuantityOri)+','+
          FormatSQLNumber(ShipmentDetail_Arr[i].Conversion)+')';

      ExecSQL(sql, False,
        'insert into trs_shipment_detail ('+
          'ship_id, item_id,  quantity, price_sales, price_cost, '+
          'price_purchase, hrg_beli, stok,quantity_ori,conversion)'+
        'values (last_insert_id(), '+
          FormatSQLNumber(ShipmentDetail_Arr[i].MstItem.ItemId)+','+
        ///  FormatSQLNumber(ShipmentDetail_Arr[i].MstItemConversion.ConvId)+','+
          FormatSQLNumber(ShipmentDetail_Arr[i].Quantity)+','+
          FormatSQLNumber(ShipmentDetail_Arr[i].PriceSales)+','+
          FormatSQLNumber(ShipmentDetail_Arr[i].PriceCost)+','+
          FormatSQLNumber(ShipmentDetail_Arr[i].PricePurchase)+','+
          FormatSQLNumber(ShipmentDetail_Arr[i].HrgBeli)+','+
          FormatSQLNumber(ShipmentDetail_Arr[i].Stok)+','+
          FormatSQLNumber(ShipmentDetail_Arr[i].QuantityOri)+','+
          FormatSQLNumber(ShipmentDetail_Arr[i].Conversion)+')');

      //catat stock balance
        if ShipmentMst.Tipe = ITEM_TYPE_OPNAME then begin

          ExecSQL('update mst_item set avg_price = '+FormatSQLNumber(ShipmentDetail_Arr[i].HrgBeli)+
          ' where item_id = '+FormatSQLNumber(ShipmentDetail_Arr[i].MstItemConversion.ConvId));

     //     ExecSQL('update mst_item_conversion set purchase_price = '+FormatSQLNumber(ShipmentDetail_Arr[i].PricePurchase)+
        //  ' where conv_id = '+FormatSQLNumber(ShipmentDetail_Arr[i].MstItem.ItemId));

      //    save_balance_opname(ShipmentMst.GudangAsal, ShipmentDetail_Arr[i].MstItem.ItemId, ShipmentMst.TransDate,
      //    ShipmentDetail_Arr[i].Quantity, 0, ShipmentDetail_Arr[i].DbCrType);
        end;

       // else         //ShipmentMst.GudangAsal
          save_balance(CENTRAL_BOARD, ShipmentDetail_Arr[i].MstItem.ItemId, ShipmentMst.TransDate,
             ShipmentDetail_Arr[i].Quantity, 0, ShipmentDetail_Arr[i].DbCrType);

//        if ShipmentMst.Tipe = ITEM_TYPE_MUTASI_MASUK then
  //        save_balance(ShipmentMst.GudangTujuan,ShipmentDetail_Arr[i].MstItem.ItemId, ShipmentMst.TransDate,
    //        ShipmentDetail_Arr[i].Quantity, 0, DB_CR_TYPE_DEBIT);
     //   if ShipmentMst.Tipe = ITEM_TYPE_MUTASI_KELUAR then
      //    save_balance(ShipmentMst.GudangTujuan,ShipmentDetail_Arr[i].MstItem.ItemId, ShipmentMst.TransDate,
       //     ShipmentDetail_Arr[i].Quantity, 0, DB_CR_TYPE_CREDIT);


       
    end;

    Result:= True;
    EndSQL;
  except
    Result:= False;
    UndoSQL;
    Inform(MSG_UNSUCCESS_SAVING);
  end;
end;

class function TTrsShipment.LoadData: TMysqlResult;
var filter: string;
begin

  if GlobalPeriode.PeriodeAwal1 <> 0 then
    filter:= filter + ' and t.trans_date '+FormatSQLOperator(GlobalPeriode.OpPeriodeAwal1)+FormatSQLDate(GlobalPeriode.PeriodeAwal1);
  if GlobalPeriode.PeriodeAkhir1 <> 0 then
    filter:= filter + ' and t.trans_date '+FormatSQLOperator(GlobalPeriode.OpPeriodeAkhir1)+FormatSQLDate(GlobalPeriode.PeriodeAkhir1);
  if GlobalFilter.TipeId <> '' then begin
    if GlobalFilter.TipeID = IntToStr(ITEM_TYPE_OPNAME) then
      filter:= filter + ' and t.tipe = '+FormatSQLString(GlobalFilter.TipeId)
    else begin
      if GlobalFilter.TipeId = '-1' then
          filter:= filter + ' and t.tipe in ('+FormatSQLNumber(ITEM_TYPE_MUTASI_MASUK)+','+FormatSQLNumber(ITEM_TYPE_MUTASI_KELUAR)+')'
      else
        filter:= filter + ' and t.tipe = '+FormatSQLString(GlobalFilter.TipeId)
    end
  end;
  if GlobalFilter.ItemId <> 0 then
    filter:= filter + ' and d.item_id = '+FormatSQLNumber(GlobalFilter.ItemId);
  if (GlobalFilter.SpecId <= 1) and (filter <> '') then
    filter:= ' where ' +Copy(filter, 5, length(filter));

  Result:= OpenSQL(
    'select distinct t.ship_id, t.trans_num as ''No Trx'', t.trans_date as ''Tgl Trx'', '+
    '(select m.branch_name from mst_branch m where m.branch_id = t.gudang_asal) as Gudang, '+
    IfThen(GlobalFilter.TipeID=IntToStr(ITEM_TYPE_MUTASI_MASUK),'(select m.branch_name from mst_branch m where m.branch_id = t.gudang_tujuan) as ''Gudang Tujuan'',')+
    't.notes as Keterangan, case when tipe = 1 then ''Stok opname'' when tipe = 2 then ''Mutasi Masuk'' else ''Mutasi Keluar'' end as Tipe '+
    'from trs_shipment_mst t '+

    IfThen(GlobalFilter.SpecId > 1,
    ', trs_shipment_detail d, point_maping p, mst_item i '+
    ' where d.ship_id = t.ship_id '+
    'and i.item_id = d.item_id and i.specification = p.code_id and p.root_id = '+
    FormatSQLNumber(GlobalFilter.SpecId))+ filter +
    ' order by t.trans_date, t.trans_num');
end;

class function TTrsShipment.PrintMutasi(ID: integer): TMysqlResult;
var sql:string;
begin
 sql := 'SELECT m.trans_num,m.trans_date,g.branch_code,g.branch_name,g2.branch_code,g2.branch_name,  i.item_code,i.item_name,d.quantity,u.mst_code,m.notes '+
        ' ,d.price_purchase,(d.quantity * d.price_purchase),m.tipe,d.price_sales '+
        ' FROM trs_shipment_mst m INNER JOIN mst_branch g ON g.branch_id = m.gudang_asal '+
        ' INNER JOIN mst_branch g2 ON g2.branch_id = m.gudang_tujuan '+
        ' INNER JOIN trs_shipment_detail d ON d.ship_id = m.ship_id '+
        ' INNER JOIN  mst_item i ON i.item_id = d.item_id '+
        '  left join mst_master u on (i.kemasan_id = u.mst_id)  WHERE m.ship_id= '+FormatSQLNumber(ID);
   Result := OpenSQL(sql);

end;

function TTrsShipment.SelectInDB: boolean;
var sqL: string; buffer: TMysqlResult; i: integer;
begin
  sqL:=
  'select ship_id, tipe, trans_num, trans_date, notes, user_id, gudang_asal, gudang_tujuan '+
  'from trs_shipment_mst '+
  'where ship_id = '+FormatSQLNumber(ShipmentMst.ShipId);
  buffer:= OpenSQL(sqL);
  ShipmentMst.Reset;
  Result:= buffer.RecordCount > 0;
  if Result then begin
    ShipmentMst.ShipId := BufferToInteger(buffer.FieldValue(0));
    ShipmentMst.Tipe  := BufferToInteger(buffer.FieldValue(1));
    ShipmentMst.TransNum   := BufferToString(buffer.FieldValue(2));
    ShipmentMst.TransDate  := BufferToDateTime(buffer.FieldValue(3));
    ShipmentMst.Notes      := BufferToString(buffer.FieldValue(4));
    ShipmentMst.UserId     := BufferToString(buffer.FieldValue(5));
    ShipmentMst.GudangAsal := BufferToInteger(buffer.FieldValue(6));
    ShipmentMst.GudangTujuan:= BufferToInteger(buffer.FieldValue(7));
  end;
  buffer.Destroy;

  buffer:= OpenSQL
    ('select d.ship_detail_id, d.item_id, 0, d.quantity as quantity, '+
       'round(d.price_sales ) as price_sales, round(d.price_purchase ) as price_purchase, '+
       'round(d.price_cost ) as price_cost, d.conversion, '+
       'u.mst_code, i.item_name, i.barcode, i.avg_price,current_stock,merk,d.stok,d.quantity_ori,i.item_code '+
     'from trs_shipment_detail d,  mst_master u, mst_item i '+
     'where i.kemasan_id = u.mst_id and d.item_id = i.item_id '+
     'and ship_id = '+FormatSQLNumber(ShipmentMst.ShipId)+
     ' order by merk,i.item_name ');

  ShipmentDetail_Arr.Clear;
  Result:= buffer.RecordCount > 0;
  for i:= 0 to buffer.RecordCount -1 do begin
    ShipmentDetail_Arr.Add(
      BufferToInteger(buffer.FieldValue(0)),
      0,
      BufferToInteger(buffer.FieldValue(1)), //item
      BufferToInteger(buffer.FieldValue(2)), //cov_id
      BufferToFloat(buffer.FieldValue(3)), //qty
      BufferToFloat(buffer.FieldValue(4)), //SALES
      BufferToFloat(buffer.FieldValue(5)), //purchase
      BufferToFloat(buffer.FieldValue(6)), //cost
      BufferToFloat(buffer.FieldValue(7)), //conv
      DB_CR_TYPE_DEBIT,0,BufferToFloat(buffer.FieldValue(14)),BufferToFloat(buffer.FieldValue(15))); //db
      ShipmentDetail_Arr[i].MstItemConversion.MstMaster.MstName:= BufferToString(buffer.FieldValue(8)); //db
      ShipmentDetail_Arr[i].MstItem.ItemName:= BufferToString(buffer.FieldValue(9)); //db
      ShipmentDetail_Arr[i].MstItem.Barcode := BufferToString(buffer.FieldValue(10)); //db
      ShipmentDetail_Arr[i].MstItem.AvgPrice := BufferToFloat(buffer.FieldValue(11)); //db
      ShipmentDetail_Arr[i].MstItem.CurrentStock := BufferToFloat(buffer.FieldValue(12)); //db
      ShipmentDetail_Arr[i].MstItem.Merk := BufferToString(buffer.FieldValue(13));
      ShipmentDetail_Arr[i].MstItem.ItemCode := BufferToString(buffer.FieldValue(16)); //db
    buffer.MoveNext;
  end;
  buffer.Destroy;
end;

{ TTrsSales }

procedure TTrsSales.Clear;
begin
  SalesMst.Reset;
  SalesDetail_Arr.Clear;
end;

class function TTrsSales.countResepRacik(ID: integer): integer;
begin
  Result:= getIntegerFromSQL(
  'select count(*) from trs_sales_detail '+
  'where paket_id is not null and sales_id = '+IntToStr(ID));
end;

constructor TTrsSales.Create;
begin
  inherited Create;
  SalesMst:= _TrsSalesMst.Create;
  SalesDetail_Arr:= _TrsSalesDetail_Arr.Create;
end;

class function TTrsSales.DeleteDetail(ID: integer): boolean;
var i: integer; sale, paket: TMysqlResult;
begin
  try
    BeginSQL;
    sale:= OpenSQL(
    'select t.trans_date, t.pasien_id, t.gudang_id, t.amount, '+
    'ifnull(d.item_id, 0), (d.quantity + d.qty_bonus) as qty, ifnull(d.paket_id, 0), '+
    'd.points, d.sales_id '+
    'from trs_sales_detail d, trs_sales_mst t '+
    'where d.sales_id = t.sales_id and d.sales_detail_id = '+FormatSQLNumber(ID));

    if sale.RecordCount > 0 then begin

     { save_to_relation_point(
      BufferToInteger(sale.FieldValue(1)),
      BufferToInteger(sale.FieldValue(7)), DB_CR_TYPE_CREDIT);

      save_to_relation_balance(
      BufferToInteger(sale.FieldValue(1)),
      BufferToDateTime(sale.FieldValue(0)),
      BufferToFloat(sale.FieldValue(3)), DB_CR_TYPE_CREDIT);
      }
      if BufferToInteger(sale.FieldValue(4)) <> 0 then
        save_balance(
          CENTRAL_BOARD,//BufferToInteger(sale.FieldValue(2)), //gudang
          BufferToInteger(sale.FieldValue(4)), //item
          BufferToDateTime(sale.FieldValue(0)), //trans date
          BufferToFloat(sale.FieldValue(5)), //quantity
          0, DB_CR_TYPE_DEBIT)
      else begin
        save_balace_paket(
          BufferToInteger(sale.FieldValue(6)), //gudang
          BufferToFloat(sale.FieldValue(5)), //quantity
          DB_CR_TYPE_DEBIT);

        paket:= OpenSQL(
        'select gudang_id, item_id, trans_date, quantity, sales_paket_id from trs_sales_paket '+
        'where sales_id = '+FormatSQLNumber(BufferToInteger(sale.FieldValue(8)))+
        ' and paket_id = '+FormatSQLNumber(BufferToInteger(sale.FieldValue(6))));

        for i:= 0 to  paket.RecordCount -1 do begin
          save_balance(
            CENTRAL_BOARD,//BufferToInteger(paket.FieldValue(0)), //gudang
            BufferToInteger(paket.FieldValue(1)), //item
            BufferToDateTime(paket.FieldValue(2)), //trans date
            BufferToFloat(paket.FieldValue(3)), 0, DB_CR_TYPE_DEBIT);

          ExecSQL(
          'delete from trs_sales_paket '+
          'where sales_paket_id = '+FormatSQLNumber(BufferToInteger(paket.FieldValue(5))));

          paket.MoveNext;
        end;
        paket.destroy;
       end;

    end;
    sale.destroy;
    ExecSQL('delete from trs_sales_detail where sales_id = '+FormatSQLNumber(ID));

    EndSQL;
    Result:= True;
  except
    UndoSQL;
    Result:= False;
    Alert('Data tidak bisa dihapus.');
  end;
end;

class procedure TTrsSales.DeleteRacikan(ID: integer);
begin
  ExecSQL('delete from setup_racik where racik_id = '+FormatSQLNumber(ID));
end;

class function TTrsSales.DeleteTrans(ID: integer): boolean;
var i: integer; sale: TMysqlResult;
begin
  try
    BeginSQL;

    sale:= OpenSQL(
    'select d.paket_id, (d.quantity + d.qty_bonus) from trs_sales_detail d, trs_sales_mst t '+
    'where d.sales_id = t.sales_id and d.paket_id is not null and t.sales_id = '+FormatSQLNumber(ID));
    for i:= 0 to sale.RecordCount-1 do begin
      save_balace_paket(
      BufferToInteger(sale.FieldValue(0)), //gudang
      BufferToFloat(sale.FieldValue(5)), //quantity
      DB_CR_TYPE_DEBIT);
      sale.MoveNext;
    end;
    sale.destroy;

    sale:= OpenSQL(
    'select t.trans_date, t.pasien_id, t.gudang_id, t.total, '+
    'd.item_id, (d.quantity + d.qty_bonus) as qty, t.points '+
    'from trs_sales_detail d, trs_sales_mst t '+
    'where d.sales_id = t.sales_id and d.item_id is not null and t.sales_id = '+FormatSQLNumber(ID)+
    ' union all '+
    'select t.trans_date, t.pasien_id, d.gudang_id, t.total, '+
    'd.item_id, d.quantity as qty, t.points '+
    'from trs_sales_paket d, trs_sales_mst t '+
    'where d.sales_id = t.sales_id and t.sales_id = '+FormatSQLNumber(ID));
    if sale.RecordCount > 0 then begin
      for i:= 0 to sale.RecordCount-1 do begin
        save_balance(
        CENTRAL_BOARD,//BufferToInteger(sale.FieldValue(2)), //gudang
        BufferToInteger(sale.FieldValue(4)), //item
        BufferToDateTime(sale.FieldValue(0)), //trans date
        BufferToFloat(sale.FieldValue(5)), //quantity
        0, DB_CR_TYPE_DEBIT);
        sale.MoveNext;
      end;

      {save_to_relation_point(
      BufferToInteger(sale.FieldValue(1)),
      BufferToInteger(sale.FieldValue(6)), DB_CR_TYPE_CREDIT);

      save_to_relation_balance(
      BufferToInteger(sale.FieldValue(1)),
      BufferToDateTime(sale.FieldValue(0)),
      BufferToFloat(sale.FieldValue(3)), DB_CR_TYPE_CREDIT);
       }
      ExecSQL('delete from trs_sales_paket where sales_id = '+FormatSQLNumber(ID));
      ExecSQL('delete from trs_sales_detail where sales_id = '+FormatSQLNumber(ID));
      ExecSQL('delete from trs_sales_mst where sales_id = '+FormatSQLNumber(ID));
      sale.destroy;
    end;

    EndSQL;
    Result:= True;
  except
    UndoSQL;
    Result:= False;
    Alert('Data tidak bisa dihapus.');
  end;
end;

function TTrsSales.DelHolded(ID: integer): boolean;
begin
  Result:= True;
  if ID <> 0 then
     ExecSQL('delete from trs_holded_mst where hold_id = '+FormatSQLNumber(ID), False);
end;

destructor TTrsSales.Destroy;
begin
  Self.Clear;
  SalesMst.Free;
  SalesDetail_Arr.Free;
  inherited;
end;

function TTrsSales.GetCustomer(vcashierID: integer): string;
var x: integer;
begin
  x:= getIntegerFromSQL('select count(*) from trs_sales_mst where trans_date = curdate()');
    //cashier_id = '+FormatSQLNumber(vcashierID));
  if x = 0 then
    Result:= 'Customer #1'
  else Result:= 'Customer #'+IntToStr(x+1);
end;

class function TTrsSales.GetID(ID: integer): string;
begin
  Result:= getStringFromSQL('select trans_num from trs_sales_mst where sales_id = '+FormatSQLNumber(ID))
end;

function TTrsSales.GetNewHoldedNumber: string;
var prefix: string;

  function get_type(): string;
  begin
    Result:=
      getStringFromSQL('select mst_code from mst_master '+
      'where mst_id = '+FormatSQLNumber(SalesMst.CashierId));
  end;

begin
  prefix := 'customer'+get_type;
  Result:= getNextIDNumPeriode('trans_num ','trs_holded_mst ',
    ' and cashier_id = '+FormatSQLNumber(SalesMst.CashierId),prefix,'','',3);
end;

function TTrsSales.GetNewNumber: string;
begin
  {Result := GlobalSystemConfig[CONF_PREP_COMP-1].ConfValue+
            GlobalSystemConfig[CONF_PREP_SALES-1].ConfValue+
            getPeriode3(SalesMst.Transdate);
   }
  //if SalesMst.NoResep <> '' then
  //  Result := PREFIX_RESEP + getPeriode3(SalesMst.Transdate)
  //else
  //PREFIX_OTC +
  Result :=  getPeriode3(SalesMst.Transdate)

end;

class function TTrsSales.getSaldoAwal: double;
begin
  Result:=
  getFloatFromSQL(
  'select so_awal from inv_cashier_balance where balance_date = curdate() '+
  'and shift_id = '+FormatSQLNumber(GlobalSystemUser.FShift)+
  ' and cashier_id  = '+FormatSQLNumber(GlobalSystemConfig.localSetting.Machine));
end;

function TTrsSales.InsertCashOnDB(holdedID: integer): boolean;
var i,service_type: integer; sql: string;
  sales_value, dis_value, retur_value, jml_tagihan: double;
begin
  if DEMO_VERSION then begin
    if getIntegerFromSQL('select count(*) from trs_sales_mst') > 100 then begin
      Result:= False;
      Inform('Maaf versi demo hanya untuk 100 transaksi.');
      Exit;
    end;
  end;

  sales_value:= 0; dis_value:= 0; retur_value:= 0;
  try
    jml_tagihan:= ItungTagihanCustomer;

    SalesMst.GudangID:= GlobalSystemConfig.localSetting.LocalGudang;
    BeginSQL;
    SalesMst.TransNum:= GetNewNumber;
    sql:=
    'insert into trs_sales_mst ('+
      'trans_num, trans_type, trans_date, cashier_id, gudang_id, pasien_id, '+
      'subtotal, profit, disc_mst, disc_val_mst, disc_detail, tax, total, embalase, '+
      'real_amount, sisa, user_id, shift_id, cash, cara_bayar, card_id, bank,animal_seq,animal_id, dokter_id,dp, no_resep) '+
    'values (get_new_sales_num('+QuotedStr(SalesMst.TransNum)+'), '+
      FormatSQLNumber(SalesMst.TransType)+','+
      FormatSQLDate(SalesMst.Transdate)+','+
      IfThen(SalesMst.CashierId <> 0, FormatSQLNumber(SalesMst.CashierId), FormatSQLNULL)+','+
     FormatSQLNumber(CENTRAL_BOARD)+','+
     // IfThen(SalesMst.GudangID <> 0, FormatSQLNumber(SalesMst.GudangID), FormatSQLNULL)+','+
      IfThen(SalesMst.PasienID <> 0, FormatSQLNumber(SalesMst.PasienID), FormatSQLNULL)+','+
      FormatSQLNumber(SalesMst.Subtotal)+','+
      FormatSQLNumber(SalesMst.Profit)+','+
      FormatSQLNumber(SalesMst.DiscMst)+','+
      FormatSQLNumber(SalesMst.DiscValMst)+','+
      FormatSQLNumber(SalesMst.DiscDetail)+','+
      FormatSQLNumber(SalesMst.Tax)+','+
      FormatSQLNumber(SalesMst.Total)+','+
      FormatSQLNumber(SalesMst.Embalase)+','+
      FormatSQLNumber(SalesMst.RealAmount)+','+
      FormatSQLNumber(jml_tagihan)+','+
      FormatSQLString(SalesMst.Userid)+','+
      FormatSQLNumber(GlobalSystemUser.FShift)+','+
      FormatSQLNumber(SalesMst.Cash)+','+
      FormatSQLNumber(SalesMst.CaraBayar)+','+
      FormatSQLString(SalesMst.CardID)+','+
      FormatSQLString(SalesMst.Bank)+','+
       FormatSQLString(SalesMst.AnimalSeq)+','+
        FormatSQLString(SalesMst.AnimalID)+','+
      IfThen(SalesMst.DokterID <> 0, FormatSQLNumber(SalesMst.DokterID), FormatSQLNULL)+','+
      FormatSQLNumber(SalesMst.Dp)+','+
      FormatSQLString(SalesMst.NoResep)+')';

    ExecSQL(sql);

    SalesMst.SalesId:= getIntegerFromSQL('select last_insert_id()');

    SalesMst.TransNum:= getStringFromSQL('select trans_num from trs_sales_mst where sales_id = '+IntToStr(SalesMst.SalesID));

  //insert into detail

    for i:= 0 to SalesDetail_Arr.Count -1 do begin
      service_type := 0;
      if SalesDetail_Arr[i].PaketID<>0 then
        service_type := TMstService.getServiceType(SalesDetail_Arr[i].PaketID);
      sql:=
        'insert into trs_sales_detail ('+
          'sales_id, item_id, quantity, price, disc, disc_val, amount, '+
          'amount_profit, price_purchase, paket_id, points, hrg_beli, conversion,service_type,is_free,animal_id)'+
        'values ('+
          FormatSQLNumber(SalesMst.SalesId)+','+
          IfThen(SalesDetail_Arr[i].MstItem.ItemID<>0,
            FormatSQLNumber(SalesDetail_Arr[i].MstItem.ItemId), FormatSQLNULL)+','+
        //  IfThen(SalesDetail_Arr[i].MstItemConversion.ConvId<>0,
          //  FormatSQLNumber(SalesDetail_Arr[i].MstItemConversion.ConvId), FormatSQLNULL)+','+
          FormatSQLNumber(SalesDetail_Arr[i].Quantity)+','+
          FormatSQLNumber(SalesDetail_Arr[i].Price)+','+
          FormatSQLNumber(SalesDetail_Arr[i].Disc)+','+
          FormatSQLNumber(SalesDetail_Arr[i].DiscVal)+','+
          FormatSQLNumber(SalesDetail_Arr[i].Amount)+','+
          FormatSQLNumber(SalesDetail_Arr[i].AmountProfit)+','+
          FormatSQLNumber(SalesDetail_Arr[i].PricePurchase)+','+
          IfThen(SalesDetail_Arr[i].PaketID<>0,
            FormatSQLNumber(SalesDetail_Arr[i].PaketID), FormatSQLNULL)+','+
          FormatSQLNumber(SalesDetail_Arr[i].Points)+','+
          FormatSQLNumber(SalesDetail_Arr[i].HrgBeli)+','+
          FormatSQLNumber(SalesDetail_Arr[i].Conversion)+','+
          IfThen(SalesDetail_Arr[i].PaketID<>0,FormatSQLNumber(SalesDetail_Arr[i].ServiceType)
            ,FormatSQLNULL)+','+
          IfThen(SalesDetail_Arr[i].PaketID<>0,FormatSQLNumber(SalesDetail_Arr[i].IsFree)
            ,FormatSQLNULL)+','+
          IfThen(SalesDetail_Arr[i].PaketID<>0,FormatSQLNumber(SalesDetail_Arr[i].AnimalID)
            ,FormatSQLNULL)+')';

      ExecSQL(sql, False,
      'insert into trs_sales_detail ('+
        'sales_id, item_id, quantity, price, disc, disc_val, amount, '+
        'amount_profit, price_purchase, paket_id, points, hrg_beli, conversion)'+
        'values ('+
         '(select sales_id from trs_sales_mst y where y.trans_num = ('+
           'select max(x.trans_num) from trs_sales_mst x where x.cashier_id = '+FormatSQLNumber(SalesMst.CashierID)+')'+
           ' and y.cashier_id = '+FormatSQLNumber(SalesMst.CashierID)+'), '+
               //last_insert_id masalah
          IfThen(SalesDetail_Arr[i].MstItem.ItemID<>0,
            FormatSQLNumber(SalesDetail_Arr[i].MstItem.ItemId), FormatSQLNULL)+','+
          //IfThen(SalesDetail_Arr[i].MstItemConversion.ConvId<>0,
            //FormatSQLNumber(SalesDetail_Arr[i].MstItemConversion.ConvId), FormatSQLNULL)+','+
          FormatSQLNumber(SalesDetail_Arr[i].Quantity)+','+
          FormatSQLNumber(SalesDetail_Arr[i].Price)+','+
          FormatSQLNumber(SalesDetail_Arr[i].Disc)+','+
          FormatSQLNumber(SalesDetail_Arr[i].DiscVal)+','+
          FormatSQLNumber(SalesDetail_Arr[i].Amount)+','+
          FormatSQLNumber(SalesDetail_Arr[i].AmountProfit)+','+
          FormatSQLNumber(SalesDetail_Arr[i].PricePurchase)+','+
          IfThen(SalesDetail_Arr[i].PaketID<>0,
            FormatSQLNumber(SalesDetail_Arr[i].PaketID), FormatSQLNULL)+','+
          FormatSQLNumber(SalesDetail_Arr[i].Points)+','+
          FormatSQLNumber(SalesDetail_Arr[i].HrgBeli)+','+
          FormatSQLNumber(SalesDetail_Arr[i].Conversion)+')');

      if SalesDetail_Arr[i].MstItem.ItemId <> 0 then
            //SalesMst.GudangID
        save_balance(CENTRAL_BOARD, SalesDetail_Arr[i].MstItem.ItemId, SalesMst.TransDate,
        SalesDetail_Arr[i].Quantity, 0, IfThen(SalesMst.TransType=SALES_TYPE_POS,DB_CR_TYPE_CREDIT,DB_CR_TYPE_DEBIT)) ;

        ///MASUKAN HISTORI JASA CUSTOMER HERE>>>>
        if (SalesDetail_Arr[i].PaketID<>0) then begin
            sql := 'call put_customer_service('+
                    FormatSQLNumber(SalesMst.PasienID)+','+
                    FormatSQLNumber(service_type)+','+
                    FormatSQLNumber(SalesDetail_Arr[i].Quantity)+','+
                    FormatSQLNumber(SalesDetail_Arr[i].IsFree)+')';
            ExecSQL(sql);        
        end;

  //    else insertRacikan(i);
 // /
   //   ExecSQL('delete from setup_racik where racik_id = '+FormatSQLNumber(SalesDetail_Arr[i].SalesDetailID));

      if SalesDetail_Arr[i].Quantity > 0 then
        sales_value:= sales_value + ((SalesDetail_Arr[i].Quantity/SalesDetail_Arr[i].Conversion) * SalesDetail_Arr[i].Price)
      else
        retur_value:= retur_value + ((SalesDetail_Arr[i].Quantity/SalesDetail_Arr[i].Conversion) * SalesDetail_Arr[i].Price);

      dis_value:= dis_value + SalesDetail_Arr[i].DiscVal +
        (SalesDetail_Arr[i].Disc * (((SalesDetail_Arr[i].Quantity/SalesDetail_Arr[i].Conversion) * SalesDetail_Arr[i].Price)/100));

    end;

    dis_value:= dis_value +
    SalesMst.DiscValMst + ((SalesMst.DiscMst/100) * SalesMst.Subtotal);

  //catat cashier balance
    save_to_cashier(SalesMst.CashierId, SalesMst.CaraBayar, sales_value, dis_value, abs(retur_value), SalesMst.Embalase, DB_CR_TYPE_DEBIT);

//    save_to_relation_point(SalesMst.PasienID, SalesMst.Points, DB_CR_TYPE_DEBIT);
//    save_to_relation_balance(SalesMst.RelationID, SalesMst.TransDate, jml_tagihan, DB_CR_TYPE_DEBIT);

    if holdedID <> 0 then
      ExecSQL('delete from trs_holded_mst where hold_id = '+FormatSQLNumber(holdedID), false);

    Result:= True;
    EndSQL;
  except
    Result:= False;
    UndoSQL;
    Inform(MSG_UNSUCCESS_SAVING);
  end;
end;

function TTrsSales.InsertCreditOnDB: boolean;
var i: integer; sql: string;
  jml_tagihan: double;
begin
  if DEMO_VERSION then begin
    if getIntegerFromSQL('select count(*) from trs_sales_mst') > 100 then begin
      Result:= False;
      Inform('Maaf versi demo hanya untuk 100 transaksi.');
      Exit;
    end;
  end;

  try
    jml_tagihan:= ItungTagihanCustomer;

    SalesMst.GudangID:= GlobalSystemConfig.localSetting.LocalGudang;
    BeginSQL;
    SalesMst.TransNum:= GetNewNumber;
    SalesMst.GudangID := CENTRAL_BOARD;
    sql:=
    'insert into trs_sales_mst ('+
      'trans_num, trans_type, trans_date, cashier_id, gudang_id, pasien_id, '+
      'subtotal, profit, disc_mst, disc_val_mst, disc_detail, tax, total, real_amount, sisa, user_id, shift_id, cash) '+
    'values (get_new_sales_num('+QuotedStr(SalesMst.TransNum)+'), '+
      FormatSQLNumber(SalesMst.TransType)+','+
      FormatSQLDate(SalesMst.Transdate)+','+
      IfThen(SalesMst.CashierId <> 0, FormatSQLNumber(SalesMst.CashierId), FormatSQLNULL)+','+
      IfThen(SalesMst.GudangID <> 0, FormatSQLNumber(SalesMst.GudangID), FormatSQLNULL)+','+
      IfThen(SalesMst.PasienID <> 0, FormatSQLNumber(SalesMst.PasienID), FormatSQLNULL)+','+
      FormatSQLNumber(SalesMst.Subtotal)+','+
      FormatSQLNumber(SalesMst.Profit)+','+
      FormatSQLNumber(SalesMst.DiscMst)+','+
      FormatSQLNumber(SalesMst.DiscValMst)+','+
      FormatSQLNumber(SalesMst.DiscDetail)+','+
      FormatSQLNumber(SalesMst.Tax)+','+
      FormatSQLNumber(SalesMst.Total)+','+
      FormatSQLNumber(SalesMst.RealAmount)+','+
      FormatSQLNumber(jml_tagihan)+','+
      FormatSQLString(SalesMst.Userid)+','+
      FormatSQLNumber(GlobalSystemUser.FShift)+','+
      FormatSQLNumber(SalesMst.Cash)+')';
    ExecSQL(sql);

    SalesMst.SalesId:= getIntegerFromSQL('select last_insert_id()');
    SalesMst.TransNum:= getStringFromSQL('select trans_num from trs_sales_mst where sales_id = '+IntToStr(SalesMst.SalesID));

  //insert into detail

    for i:= 0 to SalesDetail_Arr.Count -1 do begin
      sql:=
        'insert into trs_sales_detail ('+
          'sales_id, item_id, conv_id, quantity, price, disc, disc_val, amount, '+
          'amount_profit, price_purchase, paket_id, points, conversion, conv_bonus_id, qty_bonus, conv_bonus)'+
        'values ('+
          FormatSQLNumber(SalesMst.SalesId)+','+
          IfThen(SalesDetail_Arr[i].MstItem.ItemID<>0,
            FormatSQLNumber(SalesDetail_Arr[i].MstItem.ItemId), FormatSQLNULL)+','+
          IfThen(SalesDetail_Arr[i].MstItemConversion.ConvId<>0,
            FormatSQLNumber(SalesDetail_Arr[i].MstItemConversion.ConvId), FormatSQLNULL)+','+
          FormatSQLNumber(SalesDetail_Arr[i].Quantity)+','+
          FormatSQLNumber(SalesDetail_Arr[i].Price)+','+
          FormatSQLNumber(SalesDetail_Arr[i].Disc)+','+
          FormatSQLNumber(SalesDetail_Arr[i].DiscVal)+','+
          FormatSQLNumber(SalesDetail_Arr[i].Amount)+','+
          FormatSQLNumber(SalesDetail_Arr[i].AmountProfit)+','+
          FormatSQLNumber(SalesDetail_Arr[i].PricePurchase)+','+
          IfThen(SalesDetail_Arr[i].PaketID<>0,
            FormatSQLNumber(SalesDetail_Arr[i].PaketID), FormatSQLNULL)+','+
          FormatSQLNumber(SalesDetail_Arr[i].Points)+','+
          FormatSQLNumber(SalesDetail_Arr[i].Conversion)+','+

          IfThen(SalesDetail_Arr[i].ConvBonusID<>0,
            FormatSQLNumber(SalesDetail_Arr[i].ConvBonusID), FormatSQLNULL)+','+
          FormatSQLNumber(SalesDetail_Arr[i].QtyBonus)+','+
          FormatSQLNumber(SalesDetail_Arr[i].ConvBonus)+')';

      ExecSQL(sql, False,
      'insert into trs_sales_detail ('+
        'sales_id, item_id, conv_id, quantity, price, disc, disc_val, amount, '+
        'amount_profit, price_purchase, paket_id, points, conversion, conv_bonus_id, qty_bonus, conv_bonus)'+
        'values ('+
         '(select sales_id from trs_sales_mst y where y.trans_num = ('+
           'select max(x.trans_num) from trs_sales_mst x where x.cashier_id = '+FormatSQLNumber(SalesMst.CashierID)+')'+
           ' and y.cashier_id = '+FormatSQLNumber(SalesMst.CashierID)+'), '+
               //last_insert_id masalah
          IfThen(SalesDetail_Arr[i].MstItem.ItemID<>0,
            FormatSQLNumber(SalesDetail_Arr[i].MstItem.ItemId), FormatSQLNULL)+','+
          IfThen(SalesDetail_Arr[i].MstItemConversion.ConvId<>0,
            FormatSQLNumber(SalesDetail_Arr[i].MstItemConversion.ConvId), FormatSQLNULL)+','+
          FormatSQLNumber(SalesDetail_Arr[i].Quantity)+','+
          FormatSQLNumber(SalesDetail_Arr[i].Price)+','+
          FormatSQLNumber(SalesDetail_Arr[i].Disc)+','+
          FormatSQLNumber(SalesDetail_Arr[i].DiscVal)+','+
          FormatSQLNumber(SalesDetail_Arr[i].Amount)+','+
          FormatSQLNumber(SalesDetail_Arr[i].AmountProfit)+','+
          FormatSQLNumber(SalesDetail_Arr[i].PricePurchase)+','+
          IfThen(SalesDetail_Arr[i].PaketID<>0,
            FormatSQLNumber(SalesDetail_Arr[i].PaketID), FormatSQLNULL)+','+
          FormatSQLNumber(SalesDetail_Arr[i].Points)+','+
          FormatSQLNumber(SalesDetail_Arr[i].Conversion)+','+

          IfThen(SalesDetail_Arr[i].ConvBonusID<>0,
            FormatSQLNumber(SalesDetail_Arr[i].ConvBonusID), FormatSQLNULL)+','+
          FormatSQLNumber(SalesDetail_Arr[i].QtyBonus)+','+
          FormatSQLNumber(SalesDetail_Arr[i].ConvBonus)+')');

      if SalesDetail_Arr[i].MstItem.ItemId <> 0 then
        save_balance(CENTRAL_BOARD, SalesDetail_Arr[i].MstItem.ItemId, SalesMst.TransDate,
        (SalesDetail_Arr[i].Quantity + SalesDetail_Arr[i].QtyBonus), 0, DB_CR_TYPE_CREDIT)

      else insertPaket(i);
    end;

//    save_to_relation_point(SalesMst.RelationID, SalesMst.Points, DB_CR_TYPE_DEBIT);
//    save_to_relation_balance(SalesMst.RelationID, SalesMst.TransDate, jml_tagihan, DB_CR_TYPE_DEBIT);

    Result:= True;
    EndSQL;
  except
    Result:= False;
    UndoSQL;
    Inform(MSG_UNSUCCESS_SAVING);
  end;

end;

function TTrsSales.InsertHolded: boolean;
var i,service_type: integer;
begin

  try
    BeginSQL;
    if SalesMst.SalesId = 0 then begin
      SalesMst.TransNum:= GetNewHoldedNumber;

      ExecSQL(
      'insert into trs_holded_mst ('+
        'trans_num, trans_date, cashier_id, pasien_id, dokter_id, no_resep, embalase, '+
        'subtotal, disc_mst, disc_val_mst, tax, total, profit, points, relation_type, animal_seq,animal_id,dp,user_id) '+
      'values ('+

        FormatSQLString(SalesMst.TransNum)+','+
        FormatSQLDate(SalesMst.Transdate)+','+
        IfThen(SalesMst.CashierId <> 0, FormatSQLNumber(SalesMst.CashierId), FormatSQLNULL)+','+
        IfThen(SalesMst.PasienID <> 0, FormatSQLNumber(SalesMst.PasienID), FormatSQLNULL)+','+
        IfThen(SalesMst.DokterID <> 0, FormatSQLNumber(SalesMst.DokterID), FormatSQLNULL)+','+
        FormatSQLString(SalesMst.NoResep)+','+
        FormatSQLNumber(SalesMst.Embalase)+','+
        FormatSQLNumber(SalesMst.Subtotal)+','+
        FormatSQLNumber(SalesMst.DiscMst)+','+
        FormatSQLNumber(SalesMst.DiscValMst)+','+
        FormatSQLNumber(SalesMst.Tax)+','+
        FormatSQLNumber(SalesMst.Total)+','+
        FormatSQLNumber(SalesMst.Profit)+','+
        FormatSQLNumber(SalesMst.Points)+','+
        FormatSQLNumber(SalesMst.GudangID)+','+
        FormatSQLString(SalesMst.AnimalSeq)+','+
        FormatSQLString(SalesMst.AnimalID)+','+
        FormatSQLNumber(SalesMst.Dp)+','+
        FormatSQLString(SalesMst.Userid)+')', False);

      SalesMst.SalesId:= getIntegerFromSQL(
      'select hold_id from trs_holded_mst where trans_num = '+FormatSQLString(SalesMst.TransNum));

    //insert into detail

      for i:= 0 to SalesDetail_Arr.Count -1 do begin
        service_type := 0;
        if SalesDetail_Arr[i].PaketID<>0 then
         service_type := TMstService.getServiceType(SalesDetail_Arr[i].PaketID);
        ExecSQL(
        'insert into trs_holded_detail ('+
          'hold_id, item_id, conv_id, paket_id, quantity, price, disc, disc_val, amount, '+
          'amount_profit, price_purchase, points, hrg_beli, trx_racik_id,service_type,is_free,animal_id, conversion)'+
        'values ('+
          FormatSQLNumber(SalesMst.SalesId)+','+
          IfThen(SalesDetail_Arr[i].MstItem.ItemID<>0,
            FormatSQLNumber(SalesDetail_Arr[i].MstItem.ItemId), FormatSQLNULL)+','+
          IfThen(SalesDetail_Arr[i].MstItemConversion.ConvId<>0,
            FormatSQLNumber(SalesDetail_Arr[i].MstItemConversion.ConvId), FormatSQLNULL)+','+
          IfThen(SalesDetail_Arr[i].PaketID<>0,
            FormatSQLNumber(SalesDetail_Arr[i].PaketID), FormatSQLNULL)+','+
          FormatSQLNumber(SalesDetail_Arr[i].Quantity)+','+
          FormatSQLNumber(SalesDetail_Arr[i].Price)+','+
          FormatSQLNumber(SalesDetail_Arr[i].Disc)+','+
          FormatSQLNumber(SalesDetail_Arr[i].DiscVal)+','+
          FormatSQLNumber(SalesDetail_Arr[i].Amount)+','+
          FormatSQLNumber(SalesDetail_Arr[i].AmountProfit)+','+
          FormatSQLNumber(SalesDetail_Arr[i].PricePurchase)+','+
          FormatSQLNumber(SalesDetail_Arr[i].Points)+','+
          FormatSQLNumber(SalesDetail_Arr[i].HrgBeli)+','+
          FormatSQLNumber(SalesDetail_Arr[i].SalesDetailID)+','+
          FormatSQLNumber(SalesDetail_Arr[i].ServiceType)+','+
          FormatSQLNumber(SalesDetail_Arr[i].IsFree)+','+
          FormatSQLNumber(SalesDetail_Arr[i].AnimalID)+','+
          FormatSQLNumber(SalesDetail_Arr[i].Conversion)+')', False);
       end;
    end else begin

    ExecSQL(
      'update trs_holded_mst set '+
        'trans_date = '+FormatSQLDate(SalesMst.TransDate)+
        ', cashier_id = '+FormatSQLNumber(SalesMst.CashierId)+
        ', subtotal = '+FormatSQLNumber(SalesMst.Subtotal)+
        ', disc_mst = '+FormatSQLNumber(SalesMst.DiscMst)+
        ', disc_val_mst = '+FormatSQLNumber(SalesMst.DiscValMst)+
        ', tax = '+FormatSQLNumber(SalesMst.Tax)+
        ', total = '+FormatSQLNumber(SalesMst.Total)+
        ', points = '+FormatSQLNumber(SalesMst.Points)+
        ', relation_type = '+FormatSQLNumber(SalesMst.GudangID)+
        ', pasien_id = '+IfThen(SalesMst.PasienID <> 0, FormatSQLNumber(SalesMst.PasienID), FormatSQLNULL)+
        ', dokter_id = '+IfThen(SalesMst.DokterID <> 0, FormatSQLNumber(SalesMst.DokterID), FormatSQLNULL)+
        ', embalase = '+FormatSQLNumber(SalesMst.Embalase)+
        ', no_resep = '+FormatSQLString(SalesMst.NoResep)+
        ', animal_seq = '+FormatSQLString(SalesMst.AnimalSeq)+
        ', animal_id = '+FormatSQLString(SalesMst.AnimalID)+
        ', dp = '+FormatSQLNumber(SalesMst.Dp)+

        ', user_id = '+FormatSQLString(SalesMst.UserId)+
      ' where hold_id = '+FormatSQLNumber(SalesMst.SalesId), False);

      ExecSQL(
        'delete from trs_holded_detail where hold_id = '+FormatSQLNumber(SalesMst.SalesId), False);

      for i:= 0 to SalesDetail_Arr.Count -1 do begin
        service_type := 0;
        if SalesDetail_Arr[i].PaketID<>0 then
          service_type := TMstService.getServiceType(SalesDetail_Arr[i].PaketID);
        ExecSQL(
        'insert into trs_holded_detail ('+
          'hold_id, item_id, conv_id, paket_id, quantity, price, disc, disc_val, amount, '+
          'amount_profit, price_purchase, points, hrg_beli, trx_racik_id,service_type,is_Free,animal_id, conversion)'+
        'values ('+
          FormatSQLNumber(SalesMst.SalesId)+','+
          IfThen(SalesDetail_Arr[i].MstItem.ItemID<>0,
            FormatSQLNumber(SalesDetail_Arr[i].MstItem.ItemId), FormatSQLNULL)+','+
          IfThen(SalesDetail_Arr[i].MstItemConversion.ConvId<>0,
            FormatSQLNumber(SalesDetail_Arr[i].MstItemConversion.ConvId), FormatSQLNULL)+','+
          IfThen(SalesDetail_Arr[i].PaketID<>0,
            FormatSQLNumber(SalesDetail_Arr[i].PaketID), FormatSQLNULL)+','+
          FormatSQLNumber(SalesDetail_Arr[i].Quantity)+','+
          FormatSQLNumber(SalesDetail_Arr[i].Price)+','+
          FormatSQLNumber(SalesDetail_Arr[i].Disc)+','+
          FormatSQLNumber(SalesDetail_Arr[i].DiscVal)+','+
          FormatSQLNumber(SalesDetail_Arr[i].Amount)+','+
          FormatSQLNumber(SalesDetail_Arr[i].AmountProfit)+','+
          FormatSQLNumber(SalesDetail_Arr[i].PricePurchase)+','+
          FormatSQLNumber(SalesDetail_Arr[i].Points)+','+
          FormatSQLNumber(SalesDetail_Arr[i].HrgBeli)+','+
          FormatSQLNumber(SalesDetail_Arr[i].SalesDetailID)+','+
          FormatSQLNumber(SalesDetail_Arr[i].ServiceType)+','+
          FormatSQLNumber(SalesDetail_Arr[i].IsFree)+','+
          FormatSQLNumber(SalesDetail_Arr[i].AnimalID)+','+
          FormatSQLNumber(SalesDetail_Arr[i].Conversion)+')', False);
       end;
    end;
    Result:= True;
    EndSQL;
  except
    Result:= False;
    UndoSQL;
    Inform(MSG_UNSUCCESS_SAVING);
  end;
end;

procedure TTrsSales.insertPaket(Idx: integer);
var item_paket: TMysqlResult; i: integer;
  saved_amount, saved_profit, saved_disprc, saved_disrp, saved_qty: double;
begin
  save_balace_paket(SalesDetail_Arr[Idx].PaketID, SalesDetail_Arr[Idx].Quantity, DB_CR_TYPE_CREDIT);

  item_paket:= OpenSQL(
  'select i.item_id, (i.qty * i.conversion) as new_qty, i.conv_id, i.harga, '+
  'i.hrg_dasar, p.gudang_id '+
  'from mst_paket_item i, mst_paket p '+
  'where i.paket_id = p.paket_id and p.paket_id = '+FormatSQLNumber(SalesDetail_Arr[Idx].PaketID));

  for i:= 0 to item_paket.RecordCount-1 do begin

    //0item_id, 1new_qty, 2conv_id, 3harga, 4hrg_dasar
    saved_qty   := SalesDetail_Arr[Idx].Quantity * BufferToFloat(item_paket.FieldValue(1));
    saved_disprc:= SalesDetail_Arr[Idx].Disc;
    saved_disrp := SalesDetail_Arr[Idx].DiscVal/saved_qty;
    saved_amount:= BufferToFloat(item_paket.FieldValue(3)) * saved_qty;
    saved_amount:= (saved_amount * (saved_disprc/100)) - saved_disrp;
    saved_profit:= (saved_qty * (BufferToFloat(item_paket.FieldValue(3)) - BufferToFloat(item_paket.FieldValue(4))))
                   - saved_amount;

    save_balance(CENTRAL_BOARD,//BufferToInteger(item_paket.FieldValue(5)),
      BufferToInteger(item_paket.FieldValue(0)),
      SalesMst.TransDate, saved_qty, 0, DB_CR_TYPE_CREDIT);

    ExecSQL(
    'insert into trs_sales_paket ('+
      'sales_id, paket_id, item_id, conv_id, quantity, price, hrg_dasar, '+
      'amount_profit, disc, disc_val, gudang_id) '+
    'values('+
      '(select sales_id from trs_sales_mst y where y.trans_num = ('+
        'select max(x.trans_num) from trs_sales_mst x where x.cashier_id = '+FormatSQLNumber(SalesMst.CashierID)+')'+
      ' and y.cashier_id = '+FormatSQLNumber(SalesMst.CashierID)+'), '+
     FormatSQLNumber(SalesDetail_Arr[Idx].PaketID)+','+
     FormatSQLNumber(BufferToInteger(item_paket.FieldValue(0)))+','+
     FormatSQLNumber(BufferToInteger(item_paket.FieldValue(2)))+','+
     FormatSQLNumber(saved_qty)+','+
     FormatSQLNumber(BufferToFloat(item_paket.FieldValue(3)))+','+
     FormatSQLNumber(BufferToFloat(item_paket.FieldValue(4)))+','+
     FormatSQLNumber(saved_profit)+','+
     FormatSQLNumber(saved_disprc)+','+
     FormatSQLNumber(saved_disrp)+','+
     FormatSQLNumber(CENTRAL_BOARD)
     //FormatSQLNumber(BufferToInteger(item_paket.FieldValue(5)))
     +')');
     item_paket.MoveNext;
  end;
  item_paket.destroy;
end;

procedure TTrsSales.insertRacikan(Idx: integer);
var item_paket: TMysqlResult; i: integer;
  saved_profit, saved_qty: double;
begin

  item_paket:= OpenSQL(
  'select d.item_id, d.qty, '+
  'd.conv_id, d.harga, d.hrg_rata, d.hrg_beli, d.dosis_req, d.total '+

//  detail_id, racik_id,
  'from setup_racik r, setup_racik_detail d '+
  'where r.racik_id = d.racik_id and r.racik_id = '+FormatSQLNumber(SalesDetail_Arr[Idx].SalesDetailID));

  SalesMst.GudangID := CENTRAL_BOARD;
  for i:= 0 to item_paket.RecordCount-1 do begin

    //0item_id, 1new_qty, 2conv_id, 3harga, 4hrg_dasar
    saved_qty   := BufferToFloat(item_paket.FieldValue(1)) * SalesDetail_Arr[Idx].Quantity;

    if GlobalSystemConfig[CONF_HARGA-1].ConfValue = IntToStr(HARGA_RATA) then
      saved_profit:=
      ((BufferToFloat(item_paket.FieldValue(3)) -
        BufferToFloat(item_paket.FieldValue(4))) * saved_qty) -
        (BufferToFloat(item_paket.FieldValue(3)) * saved_qty)
    else
      saved_profit:=
        ((BufferToFloat(item_paket.FieldValue(3)) -
          BufferToFloat(item_paket.FieldValue(5))) * saved_qty) -
          (BufferToFloat(item_paket.FieldValue(3)) * saved_qty);
                              //SalesMst.GudangID                             
    save_balance(CENTRAL_BOARD,
      BufferToInteger(item_paket.FieldValue(0)),
      SalesMst.TransDate, saved_qty, 0, DB_CR_TYPE_CREDIT);

    ExecSQL(
    'insert into trs_sales_paket ('+
      'sales_id, paket_id, item_id, conv_id, quantity, price, hrg_dasar, hrg_beli, '+
      'dosis, amount_profit, disc, disc_val, gudang_id) '+
    'values('+
      '(select sales_id from trs_sales_mst y where y.trans_num = ('+
        'select max(x.trans_num) from trs_sales_mst x where x.cashier_id = '+FormatSQLNumber(SalesMst.CashierID)+')'+
      ' and y.cashier_id = '+FormatSQLNumber(SalesMst.CashierID)+'), '+
     FormatSQLNumber(SalesDetail_Arr[Idx].PaketID)+','+
     FormatSQLNumber(BufferToInteger(item_paket.FieldValue(0)))+','+
     FormatSQLNumber(BufferToInteger(item_paket.FieldValue(2)))+','+
     FormatSQLNumber(saved_qty)+','+
     FormatSQLNumber(BufferToFloat(item_paket.FieldValue(3)))+','+
     FormatSQLNumber(BufferToFloat(item_paket.FieldValue(4)))+','+
     FormatSQLNumber(BufferToFloat(item_paket.FieldValue(5)))+','+
     FormatSQLNumber(BufferToFloat(item_paket.FieldValue(6)))+','+
     FormatSQLNumber(saved_profit)+','+
     FormatSQLNumber(0)+','+
     FormatSQLNumber(0)+','+
     FormatSQLNumber(SalesMst.GudangID)+')');
     item_paket.MoveNext;
  end;
  item_paket.destroy;

end;

class function TTrsSales.InsertSaldoAwal(Saldo: double): boolean;
begin
  try
    BeginSQL;

    if getIntegerFromSQL(
      'select count(*) from inv_cashier_balance where balance_date = curdate() '+
      'and shift_id = '+FormatSQLNumber(GlobalSystemUser.FShift)+
      ' and cashier_id  = '+FormatSQLNumber(GlobalSystemConfig.localSetting.Machine)) > 0 then

      ExecSQL(
      'update inv_cashier_balance set so_awal = '+FormatSQLNumber(Saldo)+
      ' where balance_date = curdate() '+
      ' and shift_id = '+FormatSQLNumber(GlobalSystemUser.FShift)+
      ' and cashier_id  = '+FormatSQLNumber(GlobalSystemConfig.localSetting.Machine))

    else
      ExecSQL(
      'insert into inv_cashier_balance (cashier_id, shift_id, user_id, balance_date, so_awal) '+
      'values ('+
        FormatSQLNumber(GlobalSystemConfig.localSetting.Machine)+', '+
        FormatSQLNumber(GlobalSystemUser.FShift)+', '+
        FormatSQLString(GlobalSystemUser.UserId)+', curdate(), '+
        FormatSQLNumber(Saldo)+')');
    EndSQL;
    Result:= True;
  except
    UndoSQL;
    Result:= False;
    Alert('Saldo awal tidak berhasil disimpan.');
  end;

end;

function TTrsSales.isExistHolded(aRelationId, aHewanSeq: integer): boolean;
var sql:string;
begin
  sql := 'select count(*) from trs_holded_mst where pasien_id = '+FormatSQLNumber(aRelationId)+
    ' and animal_seq = '+FormatSQLNumber(aHewanSeq);
  Result := getIntegerFromSQL(sql)>0;
end;

function TTrsSales.isExistHoldedCustomer(aRelationId: integer): boolean;
var sql:string;
begin
  sql := 'select count(*) from trs_holded_mst m inner join mst_relation_animal a on m.pasien_id=a.relation_id and a.seq = m.animal_seq where m.pasien_id = '+FormatSQLNumber(aRelationId);
  sql := 'select count(*) from mst_relation_animal a '+
    ' where seq not in (select animal_seq from trs_holded_mst m where a.relation_id=m.pasien_id ) '+
  ' and a.relation_id = '+FormatSQLNumber(aRelationId);
//    ' and animal_seq not in (select seq from mst_relation_animal '+FormatSQLNumber(aHewanSeq);
  Result := getIntegerFromSQL(sql)=0;
  if Result then
    Result := getIntegerFromSQL('select count(*) from trs_holded_mst where pasien_id = '+FormatSQLNumber(aRelationId))>0;
end;

function TTrsSales.isRealExistHoldedCustomer(
  aRelationId: integer): boolean;
begin
 Result := getIntegerFromSQL('select count(*) from trs_holded_mst where pasien_id = '+FormatSQLNumber(aRelationId))>0;
end;

function TTrsSales.ItungTagihanCustomer: double;
begin
  Result:= 0;
  //hitung jumlah tagihan customer
  if SalesMst.PasienID <> 0 then begin
    if (SalesMst.Total <= SalesMst.Cash) and (SalesMst.Total>0) then
       Result:= 0
    else if (SalesMst.Total <= SalesMst.Cash) and (SalesMst.Total<0) then
       Result:= SalesMst.Total
    else if (SalesMst.Total > SalesMst.Cash) then
       Result:= SalesMst.Total - SalesMst.Cash
    else Result:= SalesMst.Total;
  end;
end;

{function TTrsSales.loadSimpleReport: boolean;
var i: integer; report_value: Double; data: TMysqlResult;
begin
  Result:= True;
  GlobalStringList.Clear;
  GlobalStringList.Append(
    FixWidth('Laporan Transaksi Harian', 30, taLeftJustify)+
    FixWidth(FormatDateTime('dd/MM/yyyy', GlobalPeriode.PeriodeAwal1), 10, taRightJustify));
  GlobalStringList.Append(FixWidth('-----------------------------------------',40, taLeftJustify));

  report_value:= getFloatFromSQL(
    'select ifnull(sum(total),0) from trs_sales_mst '+//where trans_type = '+FormatSQLNumber(SALES_TYPE_POS)+
    ' where trans_date = '+FormatSQLDate(GlobalPeriode.PeriodeAwal1));

  GlobalStringList.Append(
    FixWidth('Nilai Penjulan :', 25, taLeftJustify)+
    FixWidth(FloatToStrFmt(report_value), 15, taRightJustify));

  GlobalStringList.Append(
    FixWidth('Item Terjual :', 25, taLeftJustify));

  data:= OpenSQL(
    'select distinct i.struk_name, ifnull(sum(quantity), 0) as nilai, '+

      '(select mst_code from mst_item_conversion c, mst_master t '+
       'where c.unit_id = t.mst_id and c.item_id = i.item_id '+
       'and c.conversion = 1) as satuan '+

    'from trs_sales_mst m, trs_sales_detail d, mst_item i '+
    'where d.sales_id = m.sales_id and d.item_id = i.item_id and d.quantity > 0 '+//trans_type = '+FormatSQLNumber(SALES_TYPE_POS)+
    ' and trans_date = '+FormatSQLDate(GlobalPeriode.PeriodeAwal1)+
    ' group by i.struk_name, satuan '+
    ' order by item_name');

  for i:= 0 to data.RecordCount-1 do begin
    GlobalStringList.Append(
    FixWidth(' - ' + BufferToString(data.FieldValue(0)), 23, taLeftJustify)+
    FixWidth(FloatToStrFmt(BufferToFloat(data.FieldValue(1))), 13, taRightJustify)+
    FixWidth(' '+BufferToString(data.FieldValue(2)), 4, taLeftJustify));
    data.MoveNext;
  end;
  data.Destroy;

  GlobalStringList.Append(FixWidth(' ',40, taLeftJustify));

  report_value:= getFloatFromSQL(
    'select ifnull(sum(d.amount),0) from trs_sales_mst t, trs_sales_detail d '+
    'where d.sales_id = t.sales_id and (d.quantity < 0)'+ //trans_type = '+FormatSQLNumber(-99)+
    ' and trans_date = '+FormatSQLDate(GlobalPeriode.PeriodeAwal1));

  GlobalStringList.Append(
    FixWidth('Nilai Retur :', 25, taLeftJustify)+
    FixWidth(FloatToStrFmt(report_value), 15, taRightJustify));

  GlobalStringList.Append(FixWidth('Item Diretur :', 25, taLeftJustify));

  data:= OpenSQL(
    'select distinct i.struk_name, ifnull(sum(quantity),0) as nilai, '+

      '(select mst_code from mst_item_conversion c, mst_master t '+
       'where c.unit_id = t.mst_id and c.item_id = i.item_id '+
       'and c.conversion = 1) as satuan '+

    'from trs_sales_mst m, trs_sales_detail d, mst_item i '+
    'where d.sales_id = m.sales_id and d.item_id = i.item_id and (d.quantity < 0) '+//trans_type = '+FormatSQLNumber(-99)+
    ' and trans_date = '+FormatSQLDate(GlobalPeriode.PeriodeAwal1)+
    ' group by i.struk_name, satuan '+
    ' order by item_name');

  for i:= 0 to data.RecordCount-1 do begin
    GlobalStringList.Append(
    FixWidth(' - ' + BufferToString(data.FieldValue(0)), 23, taLeftJustify)+
    FixWidth(FloatToStrFmt(BufferToFloat(data.FieldValue(1))), 13, taRightJustify)+
    FixWidth(' '+BufferToString(data.FieldValue(2)), 4, taLeftJustify));
    data.MoveNext;
  end;
  data.Destroy;

  GlobalStringList.Append(FixWidth(' ',40, taLeftJustify));

  report_value:= getFloatFromSQL(
    'select ifnull(sum(profit),0) from trs_sales_mst '+//where trans_type = '+FormatSQLNumber(SALES_TYPE_POS)+
    ' where trans_date = '+FormatSQLDate(GlobalPeriode.PeriodeAwal1));

  GlobalStringList.Append(
    FixWidth('Nilai Profit :', 25, taLeftJustify)+
    FixWidth(FloatToStrFmt(report_value), 15, taRightJustify));

 GlobalStringList.Append(escCRLF);
 GlobalStringList.Append(escCRLF);
 GlobalStringList.Append(escCRLF);
 GlobalStringList.Append(escCRLF);
 RAWPrintPreview.PrintRawDocument('dailly report', GlobalStringList.Text);

end;   }

class function TTrsSales.PrintHolder(ID: integer): TMysqlResult;
var sql:string;
begin
 sql := 'select (d.quantity) as qty, d.price, d.amount, i.item_name, '+
  't.trans_num, t.trans_date, t.total, 0, 0, '+//(t.cash - t.total) as cash_back
  't.subtotal, t.disc_mst, t.disc_val_mst, d.hold_detail_id, '+
  't.pasien_id, t.dokter_id,0 as tipe_racikan,  0 as id_paket,  now() '+
  ',i.item_code,d.disc_val,t.dp,0 as cara_bayar,'''' as card_id, '''' as bank '+
  ' from trs_holded_mst t, trs_holded_detail d, mst_item i '+
  'where d.hold_id = t.hold_id and d.item_id = i.item_id and d.item_id is not null '+
  'and t.hold_id = '+IntToStr(ID)+
  ' union all '+
  'select (d.quantity ) as qty, d.price, d.amount, i.service_name as struk_name,  '+
  't.trans_num, t.trans_date, t.total, 0, '+
  '0, t.subtotal, t.disc_mst, t.disc_val_mst,  d.hold_detail_id, '+
  't.pasien_id, t.dokter_id, 1 as tipe_racikan, d.paket_id as id_paket, now() '+
  ' ,i.service_code,d.disc_val,t.dp,0 as cara_bayar,'''' as card_id, '''' as bank '+
  ' from trs_holded_mst t, trs_holded_detail d, mst_service i '+
  'where d.hold_id = t.hold_id and d.paket_id = i.service_id and d.paket_id is not null '+
  'and t.hold_id = '+IntToStr(ID)+
  ' order by hold_detail_id ';
   Result := OpenSQL(sql);


end;

class function TTrsSales.PrintSales(ID: integer): TMysqlResult;
var sql:string;
begin
 sql := 'select (d.quantity) as qty, d.price, d.amount, i.item_name, '+
  't.trans_num, t.trans_date, t.total, t.cash, (t.cash - t.total) as cash_back, '+
  't.subtotal, t.disc_mst, t.disc_val_mst, d.sales_detail_id, '+
  't.pasien_id, t.dokter_id,0 as tipe_racikan,  0 as id_paket,  now() '+
  ',i.item_code,d.disc_val,t.dp,t.cara_bayar,t.card_id, t.bank '+
  ' from trs_sales_mst t, trs_sales_detail d, mst_item i '+
  'where d.sales_id = t.sales_id and d.item_id = i.item_id and d.item_id is not null '+
  'and t.sales_id = '+IntToStr(ID)+
  ' union all '+
  'select (d.quantity ) as qty, d.price, d.amount, concat(i.service_name,'' '',a.animal) as struk_name,  '+
  't.trans_num, t.trans_date, t.total, t.cash, '+
  '(t.cash - t.total) as cash_back, t.subtotal, t.disc_mst, t.disc_val_mst,  d.sales_detail_id, '+
  't.pasien_id, t.dokter_id, 1 as tipe_racikan, d.paket_id as id_paket, now() '+
  ' ,i.service_code,d.disc_val,t.dp,t.cara_bayar,t.card_id, t.bank '+
  ' from trs_sales_mst t inner join trs_sales_detail d on d.sales_id = t.sales_id inner join mst_service i '+
 ' on  d.paket_id = i.service_id left join mst_animal a on a.animal_id = d.animal_id '+
  'where  d.paket_id is not null '+
  'and t.sales_id = '+IntToStr(ID)+
  ' order by sales_detail_id ';
   Result := OpenSQL(sql);
   {trs_holded_detail d inner join mst_service i on d.paket_id = i.service_id '+
  '  '+}

end;

function TTrsSales.SelectHolded: boolean;
var sqL: string; buffer: TMysqlResult; i: integer;
begin
  sqL:=
  'select '+
  'hold_id, trans_num, trans_date, user_id, cashier_id, '+
  'subtotal, disc_mst, disc_val_mst, tax, total, profit, pasien_id, relation_type, points, dokter_id, no_resep '+
  ',animal_seq,animal_id,dp '+
  'from trs_holded_mst where hold_id = '+FormatSQLNumber(SalesMst.SalesId);
  buffer:= OpenSQL(sqL);
  SalesMst.Reset;
  Result:= buffer.RecordCount > 0;
  if Result then begin
    SalesMst.SalesId    := BufferToInteger(buffer.FieldValue(0));
    SalesMst.TransNum   := BufferToString(buffer.FieldValue(1));
    SalesMst.TransDate  := BufferToDateTime(buffer.FieldValue(2));
    SalesMst.UserId     := BufferToString(buffer.FieldValue(3));
    SalesMst.CashierId  := BufferToInteger(buffer.FieldValue(4));
    SalesMst.Subtotal   := BufferToFloat(buffer.FieldValue(5));
    SalesMst.DiscMst    := BufferToFloat(buffer.FieldValue(6));
    SalesMst.DiscValMst := BufferToFloat(buffer.FieldValue(7));
    SalesMst.Tax        := BufferToFloat(buffer.FieldValue(8));
    SalesMst.Total      := BufferToFloat(buffer.FieldValue(9));
    SalesMst.profit     := BufferToFloat(buffer.FieldValue(10));
    SalesMst.PasienID := BufferToInteger(buffer.FieldValue(11));
    //SalesMst.GudangID := BufferToInteger(buffer.FieldValue(12));
    SalesMst.Points := BufferToInteger(buffer.FieldValue(13));
    SalesMst.DokterID := BufferToInteger(buffer.FieldValue(14));
    SalesMst.NoResep := BufferToString(buffer.FieldValue(15));
    SalesMst.AnimalSeq := BufferToString(buffer.FieldValue(16));
    SalesMst.AnimalID := BufferToString(buffer.FieldValue(17));
    SalesMst.Dp     := BufferToFloat(buffer.FieldValue(18));
  end;
  buffer.Destroy;

  buffer:= OpenSQL(
  'select d.hold_detail_id, d.item_id, d.conv_id, (d.quantity / d.conversion) as quantity, '+
  'd.price, d.disc, d.disc_val, d.amount, d.conversion, '+
  'd.price_purchase, d.amount_profit, '+
  'u.mst_code, i.struk_name, i.barcode, d.points, 0 as is_paket, d.hrg_beli, d.embalase, d.trx_racik_id '+
  ' ,d.service_type,d.is_free,d.animal_id '+
  'from trs_holded_detail d, mst_master u, mst_item i '+
  'where i.kemasan_id = u.mst_id and d.item_id = i.item_id '+
  'and d.item_id is not null and hold_id = '+FormatSQLNumber(SalesMst.SalesId)+
  ' union all '+
  'select d.hold_detail_id, d.paket_id as item_id, 0 as conv_id, (d.quantity / d.conversion) as quantity, '+
  'd.price, d.disc, d.disc_val, d.amount, d.conversion, '+
  'd.price_purchase, d.amount_profit, '+
  ' '''' as mst_code, '+
  'concat(i.service_name,'' '',a.animal) as struk_name, i.service_code, d.points, 1 as is_paket, d.hrg_beli, d.embalase, d.trx_racik_id '+
   ' ,d.service_type,d.is_free,d.animal_id '+
  'from trs_holded_detail d inner join mst_service i on d.paket_id = i.service_id '+
  ' left join mst_animal a on a.animal_id = d.animal_id '+
  'where  '+
  ' d.paket_id is not null and hold_id = '+FormatSQLNumber(SalesMst.SalesId)
  );
//  'where d.conv_id = c.conv_id and c.unit_id = u.mst_id and d.item_id = i.item_id '+

  SalesDetail_Arr.Clear;
  Result:= buffer.RecordCount > 0;
  for i:= 0 to buffer.RecordCount -1 do begin
    //0hold_detail_id, 1item_id, 2conv_id, 3quantity, 4price, 5disc, 6disc_val,
    //7amount, 8conversion, 9price_purchase, 10amount_profit,
    //11mst_code, 12struk_name, 13barcode, 14points, 15is_paket, 16hrg_beli,17emabalse,18racikid,19service_type,20is_free,21animal_id

    SalesDetail_Arr.Add(
      BufferToInteger(buffer.FieldValue(0)),
      BufferToInteger(buffer.FieldValue(18)), //trx_racik_id
      BufferToInteger(buffer.FieldValue(1)), //item
      BufferToInteger(buffer.FieldValue(2)), //cov_id
      BufferToFloat(buffer.FieldValue(3)), //qty
      BufferToFloat(buffer.FieldValue(4)), //SALES
      BufferToFloat(buffer.FieldValue(5)), //purchase
      BufferToFloat(buffer.FieldValue(6)), //purchase
      BufferToFloat(buffer.FieldValue(7)), //purchase
      BufferToFloat(buffer.FieldValue(8)), //cost
      BufferToFloat(buffer.FieldValue(9)), //cost
      BufferToFloat(buffer.FieldValue(10)),
      BufferToInteger(buffer.FieldValue(14)),
      BufferToInteger(buffer.FieldValue(15)),0,0,
      BufferToFloat(buffer.FieldValue(17)), //embalase
      BufferToFloat(buffer.FieldValue(16)),
      BufferToInteger(buffer.FieldValue(19)),
      BufferToInteger(buffer.FieldValue(20)),
      BufferToInteger(buffer.FieldValue(21)));
      SalesDetail_Arr[i].MstItemConversion.MstMaster.MstCode:= BufferToString(buffer.FieldValue(11));
      SalesDetail_Arr[i].MstItem.ItemName:= BufferToString(buffer.FieldValue(12));
      SalesDetail_Arr[i].MstItem.Barcode:= BufferToString(buffer.FieldValue(13));
    buffer.MoveNext;
  end;
  buffer.Destroy;
end;

function TTrsSales.SelectInDB: boolean;
var sqL: string; buffer: TMysqlResult; i: integer;
begin
  sqL:=
  'select sales_id, trans_num, trans_date, '+
  'subtotal, disc_mst, disc_val_mst, embalase, total, pasien_id, gudang_id, points, dokter_id '+
  'from trs_sales_mst '+
  'where '+IfThen(SalesMst.TransNum<>'',' trans_num = '+FormatSQLString(SalesMst.TransNum), ' sales_id = '+FormatSQLNumber(SalesMst.SalesId));
  buffer:= OpenSQL(sqL);
  SalesMst.Reset;
  Result:= buffer.RecordCount > 0;
  if Result then begin
    SalesMst.SalesId   := BufferToInteger(buffer.FieldValue(0));
    SalesMst.TransNum  := BufferToString(buffer.FieldValue(1));
    SalesMst.TransDate := BufferToDateTime(buffer.FieldValue(2));
    SalesMst.Subtotal  := BufferToFloat(buffer.FieldValue(3));
    SalesMst.DiscMst   := BufferToFloat(buffer.FieldValue(4));
    SalesMst.DiscValMst:= BufferToFloat(buffer.FieldValue(5));
    SalesMst.Tax       := BufferToFloat(buffer.FieldValue(6));
    SalesMst.Total     := BufferToFloat(buffer.FieldValue(7));
    SalesMst.PasienID:= BufferToInteger(buffer.FieldValue(8));
    SalesMst.GudangID  := BufferToInteger(buffer.FieldValue(9));
    SalesMst.Points    := BufferToInteger(buffer.FieldValue(10));
    SalesMst.DokterID  := BufferToInteger(buffer.FieldValue(11));
  end;
  buffer.Destroy;

  buffer:= OpenSQL(
  'select d.sales_detail_id, d.item_id, 0, (d.quantity / d.conversion) as quantity, '+
  'd.price, d.disc, d.disc_val, d.amount, d.conversion, '+
  'd.price_purchase, d.amount_profit, '+
  '0 as is_paket, d.conv_bonus_id, (d.qty_bonus / d.conv_bonus) as qty_bns, d.conv_bonus, '+
  'u.mst_code, i.struk_name, i.barcode, d.points, d.hrg_beli '+
   ' ,d.service_type,d.is_free,d.animal_id '+
  'from trs_sales_detail d, mst_master u, mst_item i '+
  'where i.kemasan_id = u.mst_id and d.item_id = i.item_id '+
  'and d.item_id is not null and sales_id = '+FormatSQLNumber(SalesMst.SalesId)+
   ' union all '+
  'select d.sales_detail_id, d.paket_id, 0, (d.quantity / d.conversion) as quantity, '+
  'd.price, d.disc, d.disc_val, d.amount, d.conversion, '+
  'd.price_purchase, d.amount_profit, '+
  '1 as is_paket, d.conv_bonus_id, (d.qty_bonus / d.conv_bonus) as qty_bns, d.conv_bonus, '+
  '  '''', '+
  'i.service_name as struk_name, i.service_code, d.points, d.hrg_beli '+
   ' ,d.service_type,d.is_free,d.animal_id '+
  'from trs_sales_detail d, mst_service i '+
  'where d.paket_id = i.service_id and d.paket_id is not null '+
  'and sales_id = '+FormatSQLNumber(SalesMst.SalesId)+
  ' order by sales_detail_id ');

  SalesDetail_Arr.Clear;
  Result:= buffer.RecordCount > 0;
  for i:= 0 to buffer.RecordCount -1 do begin

  //0sales_detail_id, 1paket_id, 2conv_id, 3quantity, 4price, 5disc, 6disc_val, 7amount,
  //8conversion, 9price_purchase, 10amount_profit, 11is_paket, 12conv_bonus_id,
  //13qty_bns, 14conv_bonus, 15mst_code, 16nama_struk, 17barcode, 18points ,19hrg_beli,20service_type,21is_free,22animal_id

    SalesDetail_Arr.Add(
      BufferToInteger(buffer.FieldValue(0)), 0,
      BufferToInteger(buffer.FieldValue(1)), //item
      BufferToInteger(buffer.FieldValue(2)), //cov_id
      BufferToFloat(buffer.FieldValue(3)), //qty
      BufferToFloat(buffer.FieldValue(4)), //SALES
      BufferToFloat(buffer.FieldValue(5)), //purchase
      BufferToFloat(buffer.FieldValue(6)), //purchase
      BufferToFloat(buffer.FieldValue(7)), //purchase
      BufferToFloat(buffer.FieldValue(8)), //cost
      BufferToFloat(buffer.FieldValue(9)), //cost
      BufferToInteger(buffer.FieldValue(10)),
      BufferToInteger(buffer.FieldValue(18)),
      BufferToInteger(buffer.FieldValue(11)),
      BufferToInteger(buffer.FieldValue(12)),
      BufferToFloat(buffer.FieldValue(13)),
      BufferToFloat(buffer.FieldValue(14)),
      BufferToFloat(buffer.FieldValue(19)),
      BufferToInteger(buffer.FieldValue(20)),
      BufferToInteger(buffer.FieldValue(21)),
      BufferToInteger(buffer.FieldValue(22)));
      SalesDetail_Arr[i].MstItemConversion.MstMaster.MstCode:= BufferToString(buffer.FieldValue(15));
      SalesDetail_Arr[i].MstItem.ItemName:= BufferToString(buffer.FieldValue(16));
      SalesDetail_Arr[i].MstItem.StrukName:= BufferToString(buffer.FieldValue(16));
      SalesDetail_Arr[i].MstItem.Barcode:= BufferToString(buffer.FieldValue(17));
      buffer.MoveNext;
  end;
  buffer.Destroy;
end;

{ TTrsPurchaseOrder }

procedure TTrsOrder.Clear;
begin
  OrderMst.Reset;
  OrderDetail_Arr.Clear;
end;

constructor TTrsOrder.Create;
begin
  inherited Create;
  OrderMst:= _TrsOrderMst.Create;
  OrderDetail_Arr:= _TrsOrderDetail_Arr.Create;
end;

class function TTrsOrder.DeleteDetail(ID: integer): boolean;
begin
  try
    ExecSQL('delete from trs_order_detail where order_detail_id = '+FormatSQLNumber(ID));
    Result:= True;
  except
    Result:= False;
    Alert('Data tidak bisa dihapus.');
  end;
end;

class function TTrsOrder.DeleteTrans(ID: integer): boolean;
begin
  try
    ExecSQL('delete from trs_order_mst where order_id = '+FormatSQLNumber(ID));
    Result:= True;
  except
    Result:= False;
    Alert('Data tidak bisa dihapus.');
  end;
end;

destructor TTrsOrder.Destroy;
begin
  Self.Clear;
  OrderMst.Free;
  OrderDetail_Arr.Free;
  inherited;
end;

class function TTrsOrder.GetDisc2(ID: integer): double;
begin
  Result:= getFloatFromSQL('select disc_mst from trs_order_mst where order_id = '+FormatSQLNumber(ID))
end;

class function TTrsOrder.GetID(ID: integer): string;
begin
  Result:= getStringFromSQL('select trans_num from trs_order_mst where order_id = '+FormatSQLNumber(ID))
end;

class function TTrsOrder.GetIDFromReceipt(ID: integer): TMysqlResult;
begin
  Result:= OpenSQL(
  'select order_id, tipe, trans_num, disc_mst, relation_id, dpp_disc2 '+
  'from trs_order_mst where order_id = '+FormatSQLNumber(ID));
end;

class function TTrsOrder.GetJenisFaktur(ID: integer): integer;
begin
  Result:= getIntegerFromSQL('select tipe from trs_order_mst where order_id = '+FormatSQLNumber(ID))
end;

function TTrsOrder.GetNewNumber: string;
var prefix: string;
begin
  prefix :=
    GlobalSystemConfig[CONF_PREP_COMP-1].ConfValue +
    GlobalSystemConfig[CONF_PREP_ORDER-1].ConfValue +
    getPeriode3(OrderMst.Transdate);
  Result := prefix + getNextIDNumPeriode2('trans_num ','trs_order_mst ', '', prefix, '', '',5);
end;

class function TTrsOrder.GetRelationID(ID: integer): integer;
begin
  Result:= getIntegerFromSQL('select relation_id from trs_order_mst where order_id = '+FormatSQLNumber(ID))
end;

class function TTrsOrder.GetTax(ID: integer): double;
begin
  Result:= getFloatFromSQL('select tax from trs_order_mst where order_id = '+FormatSQLNumber(ID))
end;

function TTrsOrder.InsertOnDB: boolean;
var i: integer; sql: string;
begin
  if DEMO_VERSION then begin
    if getIntegerFromSQL('select count(*) from trs_order_mst') > 100 then begin
      Result:= False;
      Inform('Maaf versi demo hanya untuk 100 transaksi.');
      Exit;
    end;
  end;

  try
    BeginSQL;
    OrderMst.TransNum:= GetNewNumber;
    sql:=
    'insert into trs_order_mst ('+
      'trans_num, tipe, trans_date, expr_date, delivery_date, relation_id, '+
      'subtotal, disc_mst, disc_detail, tax, total, user_id, notes, dpp_disc2, pay_term, status_id) '+
    'values ('+

      FormatSQLString(OrderMst.TransNum)+','+
      FormatSQLNumber(OrderMst.TransType)+','+
      FormatSQLDate(OrderMst.Transdate)+','+
      FormatSQLDate(OrderMst.ExprDate)+','+
      FormatSQLDate(OrderMst.DeliveryDate)+','+
      IfThen(OrderMst.MstRelation.RelationId <> 0,
        FormatSQLNumber(OrderMst.MstRelation.RelationId), FormatSQLNULL)+','+
      FormatSQLNumber(OrderMst.Subtotal)+','+
      FormatSQLNumber(OrderMst.DiscMst)+','+
      FormatSQLNumber(OrderMst.DiscDetail)+','+
      FormatSQLNumber(OrderMst.Tax)+','+
      FormatSQLNumber(OrderMst.Total)+','+
      FormatSQLString(OrderMst.UserId)+','+
      FormatSQLString(OrderMst.Notes)+','+
      FormatSQLNumber(OrderMst.DppDisc2)+','+
      FormatSQLNumber(OrderMst.PayTerm)+','+
      FormatSQLNumber(OrderMst.StatusId)+')';
    ExecSQL(sql);

    OrderMst.OrderId:= getIntegerFromSQL(
      'select order_id from trs_order_mst where trans_num = '+FormatSQLString(OrderMst.TransNum));

  //insert into detail
    for i:= 0 to OrderDetail_Arr.Count -1 do
      if (OrderDetail_Arr[i].MstItem.ItemID <> 0) and (OrderDetail_Arr[i].Quantity <> 0) then begin

      sql:=
      'insert into trs_order_detail ('+
        'order_id, item_id,  quantity, price, disc, amount, conversion, disc_is_prc, tax)'+
      'values ('+
          FormatSQLNumber(OrderMst.OrderId)+','+
          FormatSQLNumber(OrderDetail_Arr[i].MstItem.ItemId)+','+
//          FormatSQLNumber(OrderDetail_Arr[i].MstItemConversion.ConvId)+','+
          FormatSQLNumber(OrderDetail_Arr[i].Quantity)+','+
          FormatSQLNumber(OrderDetail_Arr[i].Price)+','+
          FormatSQLNumber(OrderDetail_Arr[i].Disc)+','+  //Rp
          FormatSQLNumber(OrderDetail_Arr[i].Amount)+','+//bfore disc
          FormatSQLNumber(OrderDetail_Arr[i].Conversion)+','+
          FormatSQLNumber(OrderDetail_Arr[i].DiscIsPrc)+','+
          FormatSQLNumber(OrderDetail_Arr[i].Tax)+')';

      ExecSQL(sql, False,
      'insert into trs_order_detail ('+
          'order_id, item_id,  quantity, price, disc, amount, conversion, disc_is_prc, tax)'+
        'values (last_insert_id(), '+
          FormatSQLNumber(OrderDetail_Arr[i].MstItem.ItemId)+','+
//          FormatSQLNumber(OrderDetail_Arr[i].MstItemConversion.ConvId)+','+
          FormatSQLNumber(OrderDetail_Arr[i].Quantity)+','+
          FormatSQLNumber(OrderDetail_Arr[i].Price)+','+
          FormatSQLNumber(OrderDetail_Arr[i].Disc)+','+
          FormatSQLNumber(OrderDetail_Arr[i].Amount)+','+//bfore disc
          FormatSQLNumber(OrderDetail_Arr[i].Conversion)+','+
          FormatSQLNumber(OrderDetail_Arr[i].DiscIsPrc)+','+
          FormatSQLNumber(OrderDetail_Arr[i].Tax)+')');
      end;

    Result:= True;
    EndSQL;
  except
    Result:= False;
    UndoSQL;
    Inform(MSG_UNSUCCESS_SAVING);
  end;
end;

class function TTrsOrder.LoadRekap: TMysqlResult;
var sqL,filter: string;
begin

  if GlobalPeriode.PeriodeAwal1 <> 0 then
    filter:= filter + ' and O.trans_date '+FormatSQLOperator(GlobalPeriode.OpPeriodeAwal1)+FormatSQLDate(GlobalPeriode.PeriodeAwal1);
  if GlobalPeriode.PeriodeAkhir1 <> 0 then
    filter:= filter + ' and O.trans_date '+FormatSQLOperator(GlobalPeriode.OpPeriodeAkhir1)+FormatSQLDate(GlobalPeriode.PeriodeAkhir1);

  if GlobalPeriode.PeriodeAwal2 <> 0 then
    filter:= filter + ' and O.delivery_date '+FormatSQLOperator(GlobalPeriode.OpPeriodeAwal2)+FormatSQLDate(GlobalPeriode.PeriodeAwal2);
  if GlobalPeriode.PeriodeAkhir2 <> 0 then
    filter:= filter + ' and O.delivery_date '+FormatSQLOperator(GlobalPeriode.OpPeriodeAkhir2)+FormatSQLDate(GlobalPeriode.PeriodeAkhir2);

  if GlobalFilter.TipeID <> '0' then
    filter:= filter + ' and O.tipe = '+FormatSQLString(GlobalFilter.TipeId);
  if GlobalFilter.SpecId > 1 then
    filter:= filter + ' and m.root_id = '+FormatSQLNumber(GlobalFilter.SpecID);
  if GlobalFilter.RelasiID <> 0 then
    filter:= filter + ' and O.relation_id = '+FormatSQLNumber(GlobalFilter.RelasiID);
  if GlobalFilter.StatusID <> -1 then
    filter:= filter + ' and O.status_id = '+FormatSQLNumber(GlobalFilter.StatusID);

  if (GlobalFilter.SpecId <= 1) and (filter <> '') then
    filter:= ' where ' +Copy(filter, 5, length(filter));

  sqL:=
    'select distinct '+
      'O.order_id, O.trans_num as ''No Trx'', O.trans_date as ''Tgl Order'', O.expr_date as ''Tgl Expr'', O.delivery_date as ''Tgl Kirim'', '+
      '(select relation_name from mst_relation r where r.relation_id= O.relation_id) as Supplier, '+
      'case when status_id = 0 then ''Un Posted'' else ''Posted'' end as Status,O.notes ''Keterangan'', '+
      'O.Subtotal, (O.disc_mst + O.disc_detail) as Discount, O.tax as Pajak, O.Total '+
    'from trs_order_mst O '+
    {    'select distinct '+
      'O.order_id, O.trans_num as ''No Trx'', O.trans_date as ''Tgl Order'', O.expr_date as ''Tgl Expr'', O.delivery_date as ''Tgl Kirim'', '+
      '(select relation_name from mst_relation r where r.relation_id= O.relation_id) as Supplier, '+
      'O.Subtotal, (O.disc_mst + O.disc_detail) as Discount, O.tax as Pajak, O.Total '+
    'from trs_order_mst O '+}

    IfThen(GlobalFilter.SpecId > 1,
    ', trs_order_detail d, mst_item i, point_maping m where d.order_id = o.order_id '+
    ' and d.item_id = i.item_id and i.specification = m.code_id ')+filter;
  Result:= OpenSQL(sqL);
end;

class function TTrsOrder.PostTrans(ID: integer): boolean;
begin
  try
    ExecSQL('update trs_order_mst set status_id = 1 where order_id = '+FormatSQLNumber(ID));
    Result:= True;
  except
    Result:= False;
    Alert('Data tidak bisa diposting.');
  end;
end;

class function TTrsOrder.printOrder(Id: integer): TMysqlResult;
var sql:string;
begin
 sql := 'select (d.quantity) as qty, d.price, d.amount, i.item_name, '+
  't.trans_num, t.trans_date, t.total, t.subtotal, '+
  't.relation_id, now(), i.item_code,d.disc,order_detail_id,t.disc_detail,t.tax '+
  ' from trs_order_mst t, trs_order_detail d, mst_item i '+
  'where d.order_id = t.order_id and d.item_id = i.item_id and d.item_id is not null '+
  'and t.order_id = '+IntToStr(ID)+
  ' order by order_detail_id ';
   Result := OpenSQL(sql);


end;

function TTrsOrder.SelectInDB: boolean;
var sqL: string; buffer: TMysqlResult; i: integer;
begin
  sqL:=
    'select '+
      'o.order_id, o.tipe, o.trans_num, o.trans_date, o.expr_date, o.delivery_date, o.user_id, '+
      'o.subtotal, o.disc_mst, o.disc_detail, o.tax, o.total, o.notes, o.relation_id, o.status_id, '+
      '(select r.relation_name from mst_relation r where r.relation_id = o.relation_id) as nama, dpp_disc2, pay_term '+
    'from trs_order_mst o '+
    'where order_id = '+FormatSQLNumber(OrderMst.OrderId);
  buffer:= OpenSQL(sqL);
  OrderMst.Reset;
  Result:= buffer.RecordCount > 0;
  if Result then begin
    OrderMst.OrderId := BufferToInteger(buffer.FieldValue(0));
    OrderMst.TransType  := BufferToInteger(buffer.FieldValue(1));
    OrderMst.TransNum   := BufferToString(buffer.FieldValue(2));
    OrderMst.TransDate  := BufferToDateTime(buffer.FieldValue(3));
    OrderMst.ExprDate  := BufferToDateTime(buffer.FieldValue(4));
    OrderMst.DeliveryDate  := BufferToDateTime(buffer.FieldValue(5));
    OrderMst.UserId     := BufferToString(buffer.FieldValue(6));
    OrderMst.Subtotal := BufferToFloat(buffer.FieldValue(7));
    OrderMst.DiscMst := BufferToFloat(buffer.FieldValue(8));
    OrderMst.DiscDetail := BufferToFloat(buffer.FieldValue(9));
    OrderMst.Tax := BufferToFloat(buffer.FieldValue(10));
    OrderMst.Total := BufferToFloat(buffer.FieldValue(11));
    OrderMst.Notes := BufferToString(buffer.FieldValue(12));
    OrderMst.MstRelation.RelationId := BufferToInteger(buffer.FieldValue(13));
    OrderMst.StatusId := BufferToInteger(buffer.FieldValue(14));
    OrderMst.MstRelation.RelationName := BufferToString(buffer.FieldValue(15));
    OrderMst.DppDisc2 := BufferToInteger(buffer.FieldValue(16));
    OrderMst.PayTerm := BufferToInteger(buffer.FieldValue(17));
  end;
  buffer.Destroy;

  buffer:= OpenSQL(
  'select d.order_detail_id, d.item_id, 0, (d.quantity / d.conversion) as quantity, '+
    'd.price, d.disc, d.amount, d.conversion, '+
    'u.mst_code, i.item_name, i.barcode, d.tax, d.disc_is_prc,i.item_code '+
 //   'i.item_tax,
  'from trs_order_detail d, mst_master u, mst_item i '+
  'where i.kemasan_id = u.mst_id and d.item_id = i.item_id '+
  'and order_id = '+FormatSQLNumber(OrderMst.OrderId)+
  ' order by d.order_detail_id');

  OrderDetail_Arr.Clear;
  Result:= buffer.RecordCount > 0;
  for i:= 0 to buffer.RecordCount -1 do begin
    OrderDetail_Arr.Add(
      BufferToInteger(buffer.FieldValue(0)),
      0,
      BufferToInteger(buffer.FieldValue(1)), //item
      BufferToInteger(buffer.FieldValue(2)), //cov_id
      BufferToFloat(buffer.FieldValue(3)), //qty
      BufferToFloat(buffer.FieldValue(4)), //SALES
      BufferToFloat(buffer.FieldValue(5)), //purchase
      BufferToFloat(buffer.FieldValue(6)), //purchase
      BufferToFloat(buffer.FieldValue(7)),
      BufferToFloat(buffer.FieldValue(11)),
      BufferToInteger(buffer.FieldValue(12)));
      OrderDetail_Arr[i].MstItemConversion.MstMaster.MstCode:= BufferToString(buffer.FieldValue(8));
      OrderDetail_Arr[i].MstItemConversion.MstMaster.MstName:= BufferToString(buffer.FieldValue(8));
      OrderDetail_Arr[i].MstItem.ItemName:= BufferToString(buffer.FieldValue(9));
      OrderDetail_Arr[i].MstItem.Barcode:= BufferToString(buffer.FieldValue(10));
      OrderDetail_Arr[i].MstItem.ItemCode:= BufferToString(buffer.FieldValue(13));
      buffer.MoveNext;
  end;
  buffer.Destroy;
end;

{ TTrsReceipt }

procedure TTrsReceipt.Clear;
begin
  inherited Reset;
  trsDetail.Clear;
end;

constructor TTrsReceipt.Create;
begin
  inherited Create;
  trsDetail:= _TrsReceiptDetail_Arr.Create;
end;

class function TTrsReceipt.DeleteDetail(ID: integer): boolean;
begin
  try
    ExecSQL('delete from trs_receipt_detail where receipt_detail_id = '+FormatSQLNumber(ID));
    Result:= True;
  except
    Result:= False;
    Alert('Data tidak bisa dihapus.');
  end;
end;

class function TTrsReceipt.DeletePostTrans(ID: integer): boolean;
var i: integer; master, detail: TMysqlResult;
begin
  try
    BeginSQL;

    master:= OpenSQL(
    'select gudang_id, trans_date, total, relation_id, order_id '+
    'from trs_receipt_mst '+
    'where receipt_id = '+FormatSQLNumber(ID));

    if master.RecordCount <> 0 then begin

      detail:= OpenSQL(
      'select distinct item_id, (quantity + qty_bonus) as sum_quantity '+
      'from trs_receipt_detail '+
      'where receipt_id = '+FormatSQLNumber(ID));

      for i:= 0 to detail.RecordCount-1 do begin
        save_balance(
         CENTRAL_BOARD,//BufferToInteger(master.FieldValue(0)),
          BufferToInteger(detail.FieldValue(0)),
          BufferToDateTime(master.FieldValue(1)),
          BufferToFloat(detail.FieldValue(1)),0, DB_CR_TYPE_CREDIT);
        detail.MoveNext;
      end;

      save_to_relation_balance(
        BufferToInteger(master.FieldValue(3)),
        BufferToDateTime(master.FieldValue(1)),
        BufferToFloat(master.FieldValue(2)), DB_CR_TYPE_CREDIT);

        TTrsOrder.updateStatusOrder(BufferToInteger(master.FieldValue(4)),0);

        ExecSQL('delete from trs_receipt_detail where receipt_id = '+FormatSQLNumber(ID));
        ExecSQL('delete from trs_receipt_mst where receipt_id = '+FormatSQLNumber(ID));

      detail.destroy;
    end;

    master.destroy;
    Result:= True;
    EndSQL;
  except
    UndoSQL;
    Result:= False;
    Alert('Data tidak bisa dihapus.');
  end;
end;

class function TTrsReceipt.DeleteRowPostTrans(ID, IDdetail: integer): boolean;
 var master, detail: TMysqlResult;
begin
  try
    BeginSQL;

    master:= OpenSQL(
    'select gudang_id, trans_date, total, relation_id, order_id '+
    'from trs_receipt_mst '+
    'where receipt_id = '+FormatSQLNumber(ID));

    detail:= OpenSQL(
    'select item_id, (quantity + qty_bonus) as sum_quantity, '+
    'amount, tax, (disc1 + disc2 + disc3) as disc '+
    'from trs_receipt_detail '+
    'where receipt_detail_id = '+FormatSQLNumber(IDdetail));

    save_balance(
      CENTRAL_BOARD,//BufferToInteger(master.FieldValue(0)),
      BufferToInteger(detail.FieldValue(0)),
      BufferToDateTime(master.FieldValue(1)),
      BufferToFloat(detail.FieldValue(1)),0, DB_CR_TYPE_CREDIT);

    save_to_relation_balance(
      BufferToInteger(master.FieldValue(3)),
      BufferToDateTime(master.FieldValue(1)),
        BufferToFloat(detail.FieldValue(2))+
        BufferToFloat(detail.FieldValue(3))-
        BufferToFloat(detail.FieldValue(4)),
      DB_CR_TYPE_CREDIT);

    ExecSQL('delete from trs_receipt_detail where receipt_detail_id = '+FormatSQLNumber(ID));
    {
    ExecSQL(
    'update trs_receipt_mst set '+

    'subtotal = subtotal - '+FormatSQLNumber(BufferToFloat(detail.FieldValue(2)))+','+
    'disc_detail = '+FormatSQLNumber(BufferToFloat(detail.FieldValue(4)))+','+
    'disc_mst = '+FormatSQLNumber(DiscMst)+','+
    'tax = '+FormatSQLNumber(Tax)+','+
    'biaya = '+FormatSQLNumber(Biaya)+','+
    'materai = '+FormatSQLNumber(Materai)+','+
    'total = '+FormatSQLNumber(Total)+','+
    'dpp_disc2 = '+FormatSQLNumber(DppDisc2)+','+
    'notes = '+FormatSQLString(Notes)+','+
    'user_id = '+FormatSQLString(UserId)+
    'where receipt_id = '+FormatSQLNumber(FReceiptID);
    ExecSQL(sql);


     }


    detail.destroy;


    master.destroy;
    Result:= True;
    EndSQL;
  except
    UndoSQL;
    Result:= False;
    Alert('Data tidak bisa dihapus.');
  end;
end;

class function TTrsReceipt.DeleteTrans(ID: integer): boolean;
var poID: integer;
begin
  try
    BeginSQL;
    poID:= getIntegerFromSQL('select order_id from trs_receipt_mst where receipt_id = '+FormatSQLNumber(ID));
    ExecSQL('delete from trs_receipt_mst where receipt_id = '+FormatSQLNumber(ID));

    TTrsOrder.updateStatusOrder(poID,0);
    EndSQL;
    Result:= True;
  except
    UndoSQL;
    Result:= False;
    Alert('Data tidak bisa dihapus.');
  end;
end;

destructor TTrsReceipt.Destroy;
begin
  trsDetail.Destroy;
  inherited;
end;

class function TTrsReceipt.GetID(ID: integer): string;
begin
  Result:= getStringFromSQL('select trans_num from trs_receipt_mst where receipt_id = '+FormatSQLNumber(ID))
end;

class function TTrsReceipt.GetLastReceipt(ID: integer): TDate;
begin
  Result:= getTDateFromSQL(
  'select max(trans_date) from trs_receipt_mst t, trs_receipt_detail d '+
  'where t.receipt_id = t.receipt_id and d.item_id = '+FormatSQLNumber(ID))
end;

function TTrsReceipt.GetNewNumber: string;
var prefix: string;
begin
  prefix := GlobalSystemConfig[CONF_PREP_COMP-1].ConfValue +
            GlobalSystemConfig[CONF_PREP_RECEIPT-1].ConfValue +
            getPeriode3(TransDate);
  Result := prefix + getNextIDNumPeriode2('trans_num ','trs_receipt_mst ', '', prefix, '', '',5);
end;

function TTrsReceipt.InsertOnDB: boolean;
var i: integer; sqL: string;
begin
  if DEMO_VERSION then begin
    if getIntegerFromSQL('select count(*) from trs_receipt_mst') > 100 then begin
      Result:= False;
      Inform('Maaf versi demo hanya untuk 100 transaksi.');
      Exit;
    end;
  end;

  try
    BeginSQL;

    TransNum:= GetNewNumber;
    sql:=
    'insert into trs_receipt_mst ('+
    'trans_num, trans_date, tipe, expr_date, relation_id, order_id, '+
    'gudang_id, subtotal, disc_detail, disc_mst, tax, biaya, materai, total, notes, dpp_disc2, user_id) '+
    'values ('+

      FormatSQLString(TransNum)+','+
      FormatSQLDate(Transdate)+','+
      FormatSQLNumber(Tipe)+','+
      FormatSQLDate(ExprDate)+','+
      IfThen(RelationId <> 0, FormatSQLNumber(RelationId), FormatSQLNULL)+','+
      IfThen(OrderId <> 0, FormatSQLNumber(OrderId), FormatSQLNULL)+','+
      FormatSQLNumber(CENTRAL_BOARD)+','+ //IfThen(GudangId <> 0, FormatSQLNumber(GudangId), FormatSQLNULL)+','+
      FormatSQLNumber(Subtotal)+','+
      FormatSQLNumber(DiscDetail)+','+
      FormatSQLNumber(DiscMst)+','+
      FormatSQLNumber(Tax)+','+
      FormatSQLNumber(Biaya)+','+
      FormatSQLNumber(Materai)+','+
      FormatSQLNumber(Total)+','+
      FormatSQLString(Notes)+','+
      FormatSQLNumber(DppDisc2)+','+
      FormatSQLString(UserId)+')';
    ExecSQL(sql);

    ReceiptId:= getIntegerFromSQL(
    'select receipt_id from trs_receipt_mst where trans_num = '+FormatSQLString(TransNum));

    for i:= 0 to trsDetail.Count-1 do
      if (trsDetail[i].ItemId <> 0) and (trsDetail[i].Quantity <> 0) then begin
        sql:=
        'insert into trs_receipt_detail ('+
          'receipt_id, item_id, conv_id, conv_bonus_id, quantity, qty_bonus, '+
          'price, amount, disc1, disc2, disc3, conversion, conv_bonus, '+
          'disc1_is_prc, disc2_is_prc, disc3_is_prc, tax)'+
        'values ('+
          FormatSQLNumber(ReceiptId)+','+
          FormatSQLNumber(trsDetail[i].ItemId)+','+
          FormatSQLNumber(trsDetail[i].ConvId)+','+
          IfThen(trsDetail[i].ConvBonusID <> 0,
            FormatSQLNumber(trsDetail[i].ConvBonusID), FormatSQLNULL)+','+
          FormatSQLNumber(trsDetail[i].Quantity)+','+
          FormatSQLNumber(trsDetail[i].QtyBonus)+','+
          FormatSQLNumber(trsDetail[i].Price)+','+
          FormatSQLNumber(trsDetail[i].Amount)+','+//bfore disc
          FormatSQLNumber(trsDetail[i].Disc1)+','+  //Rp
          FormatSQLNumber(trsDetail[i].Disc2)+','+  //Rp
          FormatSQLNumber(trsDetail[i].Disc3)+','+  //Rp
          FormatSQLNumber(trsDetail[i].Conversion)+','+
          FormatSQLNumber(trsDetail[i].ConvBonus)+','+
          FormatSQLNumber(trsDetail[i].Disc1IsPrc)+','+
          FormatSQLNumber(trsDetail[i].Disc2IsPrc)+','+
          FormatSQLNumber(trsDetail[i].Disc3IsPrc)+','+
          FormatSQLNumber(trsDetail[i].Tax)+')';

        ExecSQL(sql, False,
        'insert into trs_receipt_detail ('+
          'receipt_id, item_id, conv_id, conv_bonus_id, quantity, qty_bonus, price, '+
          'amount, disc1, disc2, disc3, conversion, conv_bonus, '+
          'disc1_is_prc, disc2_is_prc, disc3_is_prc, tax)'+
        'values (last_insert_id(), '+
          FormatSQLNumber(trsDetail[i].ItemId)+','+
          FormatSQLNumber(trsDetail[i].ConvId)+','+
          FormatSQLNumber(trsDetail[i].ConvBonusID)+','+
          FormatSQLNumber(trsDetail[i].Quantity)+','+
          FormatSQLNumber(trsDetail[i].QtyBonus)+','+
          FormatSQLNumber(trsDetail[i].Price)+','+
          FormatSQLNumber(trsDetail[i].Amount)+','+//bfore disc
          FormatSQLNumber(trsDetail[i].Disc1)+','+  //Rp
          FormatSQLNumber(trsDetail[i].Disc2)+','+  //Rp
          FormatSQLNumber(trsDetail[i].Disc3)+','+  //Rp
          FormatSQLNumber(trsDetail[i].Conversion)+','+
          FormatSQLNumber(trsDetail[i].ConvBonus)+','+
          FormatSQLNumber(trsDetail[i].Disc1IsPrc)+','+
          FormatSQLNumber(trsDetail[i].Disc2IsPrc)+','+
          FormatSQLNumber(trsDetail[i].Disc3IsPrc)+','+
          FormatSQLNumber(trsDetail[i].Tax)+')');
      end;
    TTrsOrder.updateStatusOrder(OrderId, 1);
    EndSQL;
    Result:= True;
  except
    UndoSQL;
    Result:= False;
    Inform(MSG_UNSUCCESS_SAVING);
  end;
end;

class function TTrsReceipt.LoadRekap: TMysqlResult;
var sqL,filter: string;
begin

  if GlobalPeriode.PeriodeAwal1 <> 0 then
    filter:= filter + ' and t.trans_date '+FormatSQLOperator(GlobalPeriode.OpPeriodeAwal1)+FormatSQLDate(GlobalPeriode.PeriodeAwal1);
  if GlobalPeriode.PeriodeAkhir1 <> 0 then
    filter:= filter + ' and t.trans_date '+FormatSQLOperator(GlobalPeriode.OpPeriodeAkhir1)+FormatSQLDate(GlobalPeriode.PeriodeAkhir1);

  if GlobalPeriode.PeriodeAwal2 <> 0 then
    filter:= filter + ' and t.expr_date '+FormatSQLOperator(GlobalPeriode.OpPeriodeAwal2)+FormatSQLDate(GlobalPeriode.PeriodeAwal2);
  if GlobalPeriode.PeriodeAkhir2 <> 0 then
    filter:= filter + ' and t.expr_date '+FormatSQLOperator(GlobalPeriode.OpPeriodeAkhir2)+FormatSQLDate(GlobalPeriode.PeriodeAkhir2);

  if GlobalFilter.TipeID <> '0' then
    filter:= filter + ' and t.tipe = '+FormatSQLString(GlobalFilter.TipeId);
  if GlobalFilter.SpecId > 1 then
    filter:= filter + ' and m.root_id = '+FormatSQLNumber(GlobalFilter.SpecID);
  if GlobalFilter.RelasiID <> 0 then
    filter:= filter + ' and t.relation_id = '+FormatSQLNumber(GlobalFilter.RelasiID);
  if GlobalFilter.StatusID <> -1 then
    filter:= filter + ' and t.status_id = '+FormatSQLNumber(GlobalFilter.StatusID);

  case GlobalFilter.Numeric1 of
    1: filter:= filter + ' and t.sisa > 0 ';
    2: filter:= filter + ' and t.sisa <= 0 ';
  end;


  if (GlobalFilter.SpecId <= 1) and (filter <> '') then
    filter:= ' where ' +Copy(filter, 5, length(filter));

  sqL:=
    'select distinct '+
      't.receipt_id, t.trans_num as ''No Trx'', t.trans_date as ''Tgl Terima'', t.expr_date as ''Jth Tempo'', '+
      '(select relation_name from mst_relation r where r.relation_id= t.relation_id) as Supplier, '+
      'case when tipe=0 then ''Terima PO'' else ''Pembelian Langsung'' end as ''Tipe'', '+
      'case when status_id = 0 then ''Un Posted'' else ''Posted'' end as Status,'+
      't.Subtotal, (t.disc_mst + t.disc_detail) as Discount, t.tax as Pajak, t.Materai, t. Biaya, t.Total '+
    'from trs_receipt_mst t '+

    IfThen(GlobalFilter.SpecId > 1,
    ', trs_receipt_detail d, mst_item i, point_maping m where d.receipt_id = t.receipt_id '+
    ' and d.item_id = i.item_id and i.specification = m.code_id ')+filter;
  Result:= OpenSQL(sqL);

end;

class function TTrsReceipt.LoadRekapDetail: TMysqlResult;
var filter: string;
begin
  if GlobalPeriode.PeriodeAwal1 <> 0 then
    filter:= filter + ' and t.trans_date '+FormatSQLOperator(GlobalPeriode.OpPeriodeAwal1)+FormatSQLDate(GlobalPeriode.PeriodeAwal1);
  if GlobalPeriode.PeriodeAkhir1 <> 0 then
    filter:= filter + ' and t.trans_date '+FormatSQLOperator(GlobalPeriode.OpPeriodeAkhir1)+FormatSQLDate(GlobalPeriode.PeriodeAkhir1);

  if GlobalPeriode.PeriodeAwal2 <> 0 then
    filter:= filter + ' and t.expr_date '+FormatSQLOperator(GlobalPeriode.OpPeriodeAwal2)+FormatSQLDate(GlobalPeriode.PeriodeAwal2);
  if GlobalPeriode.PeriodeAkhir2 <> 0 then
    filter:= filter + ' and t.expr_date '+FormatSQLOperator(GlobalPeriode.OpPeriodeAkhir2)+FormatSQLDate(GlobalPeriode.PeriodeAkhir2);

  if GlobalFilter.TipeID <> '0' then
    filter:= filter + ' and t.tipe = '+FormatSQLString(GlobalFilter.TipeId);
  if GlobalFilter.SpecId > 1 then
    filter:= filter + ' and m.root_id = '+FormatSQLNumber(GlobalFilter.SpecID);
  if GlobalFilter.RelasiID <> 0 then
    filter:= filter + ' and t.relation_id = '+FormatSQLNumber(GlobalFilter.RelasiID);
  if GlobalFilter.StatusID <> -1 then
    filter:= filter + ' and t.status_id = '+FormatSQLNumber(GlobalFilter.StatusID);

  case GlobalFilter.Numeric1 of
    1: filter:= filter + ' and t.sisa > 0 ';
    2: filter:= filter + ' and t.sisa <= 0 ';
  end;

  Result:= OpenSQL(
  'select t.relation_id, t.trans_date, t.receipt_id, i.barcode, i.item_name, (d.quantity/d.conversion) as quantity, d.price, d.amount, '+
  '(select u.mst_code from  mst_master u '+
  'where i.kemasan_id = u.mst_id) as satuan, '+
  '(select r.relation_name from mst_relation r '+
  'where r.relation_id = t.relation_id) as suplier '+
  'from trs_receipt_mst t, trs_receipt_detail d, mst_item i '+
  'where t.receipt_id = d.receipt_id and d.item_id = i.item_id '+filter+
  ' order by suplier, t.trans_date, i.item_name');
end;

class function TTrsReceipt.PostTrans(ID: integer): boolean;
var i: integer; detail: TMysqlResult; msg: string;
begin
  try
    BeginSQL;
    ExecSQL(
    'update trs_receipt_mst set '+
    'status_id = 1, sisa = total where receipt_id = '+FormatSQLNumber(ID));

    detail:= OpenSQL(
    'select distinct d.item_id, (d.quantity + qty_bonus) as sum_quantity, '+
    't.gudang_id, t.trans_date, t.total, t.relation_id, d.quantity, '+
    '((d.price/d.conversion) + (d.tax/d.quantity)) as harga '+
    'from trs_receipt_mst t, trs_receipt_detail d '+
    'where d.receipt_id = t.receipt_id and t.receipt_id = '+FormatSQLNumber(ID));

    detail.First;
    for i:= 0 to detail.RecordCount-1 do begin

      msg:= update_avg_price(BufferToInteger(detail.FieldValue(0)),
        BufferToFloat(detail.FieldValue(6)), BufferToFloat(detail.FieldValue(7)));

      save_balance(
       CENTRAL_BOARD,// BufferToInteger(detail.FieldValue(2)),
        BufferToInteger(detail.FieldValue(0)),
        BufferToDateTime(detail.FieldValue(3)),
        BufferToFloat(detail.FieldValue(1)),0, DB_CR_TYPE_DEBIT);
        TMstItem.updatePriceHistory(1,BufferToInteger(detail.FieldValue(0)),BufferToFloat(detail.FieldValue(7)),TMstRelation.GetName(5),0,0);
      detail.MoveNext;
    end;

    if detail.RecordCount > 0 then
      save_to_relation_balance(
        BufferToInteger(detail.FieldValue(5)),
        BufferToDateTime(detail.FieldValue(3)),
        BufferToFloat(detail.FieldValue(4)), DB_CR_TYPE_DEBIT);

    detail.destroy;
    Result:= True;
    EndSQL;
  except
    UndoSQL;
    Result:= False;
    Alert('Data tidak bisa diposting.'+#13#10+msg);
  end;
end;

function TTrsReceipt.SelectDetail(ID: integer): TMysqlResult;
begin
  Result:= OpenSQL(
  'select d.receipt_detail_id, d.item_id, d.conv_id, d.conv_bonus_id, '+
  '(d.quantity/d.conversion) as quantity, (d.qty_bonus/d.conv_bonus) as qty_bonus, '+
  'd.price, d.amount, d.disc1, d.disc2, d.disc3, d.conversion, d.conv_bonus, '+
  'i.item_name, i.barcode, '+
  '(select u.mst_code from mst_master u '+
     'where i.kemasan_id = u.mst_id) as satuan, '+
     ' '''' as sat_bonus, '+
//  '(select u.mst_code from mst_item_conversion c, mst_master u '+
  //   'where d.conv_bonus_id = c.conv_id and c.unit_id = u.mst_id) as sat_bonus, '+
  'd.tax, d.disc1_is_prc, d.disc2_is_prc, d.disc3_is_prc,i.item_code '+
  'from trs_receipt_detail d, mst_item i '+
  'where d.item_id = i.item_id '+
  'and receipt_id = '+FormatSQLNumber(ID));
end;

function TTrsReceipt.SelectInDB: boolean;
var sqL: string; buffer: TMysqlResult;
begin
  sqL:=
  'select receipt_id, tipe, trans_num, trans_date, expr_date, user_id, '+
  'subtotal, disc_mst, disc_detail, tax, total, notes, relation_id, status_id, '+
  'order_id, gudang_id, biaya, materai, dpp_disc2 '+
  'from trs_receipt_mst '+
  'where receipt_id = '+FormatSQLNumber(ReceiptId);
  buffer:= OpenSQL(sqL);
  Reset;
  Result:= buffer.RecordCount > 0;
  if Result then begin
    ReceiptId := BufferToInteger(buffer.FieldValue(0));
    Tipe  := BufferToInteger(buffer.FieldValue(1));
    TransNum   := BufferToString(buffer.FieldValue(2));
    TransDate  := BufferToDateTime(buffer.FieldValue(3));
    ExprDate  := BufferToDateTime(buffer.FieldValue(4));
    UserId     := BufferToString(buffer.FieldValue(5));
    Subtotal := BufferToFloat(buffer.FieldValue(6));
    DiscMst := BufferToFloat(buffer.FieldValue(7));
    DiscDetail := BufferToFloat(buffer.FieldValue(8));
    Tax := BufferToFloat(buffer.FieldValue(9));
    Total := BufferToFloat(buffer.FieldValue(10));
    Notes := BufferToString(buffer.FieldValue(11));
    RelationId := BufferToInteger(buffer.FieldValue(12));
    StatusId := BufferToInteger(buffer.FieldValue(13));
    OrderId := BufferToInteger(buffer.FieldValue(14));
    GudangId := BufferToInteger(buffer.FieldValue(15));
    Biaya := BufferToFloat(buffer.FieldValue(16));
    Materai := BufferToFloat(buffer.FieldValue(17));
    DppDisc2 := BufferToInteger(buffer.FieldValue(18));
  end;
  buffer.Destroy;
end;

function TTrsReceipt.SelectOrderDetail(ID: integer): TMysqlResult;
begin
  Result:= OpenSQL(
  'select d.order_detail_id, d.item_id, 0, (d.quantity / d.conversion) as quantity, '+
  'd.price, d.amount, d.disc, d.conversion, '+
  'i.item_name, i.barcode, '+
  '(select u.mst_code from  mst_master u '+
     'where i.kemasan_id = u.mst_id) as satuan, '+
  'd.tax, d.disc_is_prc,i.item_code '+
  'from trs_order_detail d, mst_item i '+
  'where d.item_id = i.item_id '+
  'and order_id = '+FormatSQLNumber(ID));
end;

function TTrsOrder.UpdateOnDB: boolean;
var i: integer; sql: string;
begin
  try
    BeginSQL;

    sql:=
    'update trs_order_mst set '+
      'tipe = '+FormatSQLNumber(OrderMst.TransType)+','+
      'trans_date = '+FormatSQLDate(OrderMst.Transdate)+','+
      'expr_date = '+FormatSQLDate(OrderMst.ExprDate)+','+
      'delivery_date = '+FormatSQLDate(OrderMst.DeliveryDate)+','+
      'subtotal = '+FormatSQLNumber(OrderMst.Subtotal)+','+
      'disc_mst = '+FormatSQLNumber(OrderMst.DiscMst)+','+
      'disc_detail = '+FormatSQLNumber(OrderMst.DiscDetail)+','+
      'tax = '+FormatSQLNumber(OrderMst.Tax)+','+
      'total = '+FormatSQLNumber(OrderMst.Total)+','+
      'user_id = '+FormatSQLString(OrderMst.UserId)+','+
      'dpp_disc2 = '+FormatSQLNumber(OrderMst.DppDisc2)+','+
      'pay_term = '+FormatSQLNumber(OrderMst.PayTerm)+','+
      'notes = '+FormatSQLString(OrderMst.Notes)+

    ' where order_id = '+FormatSQLNumber(OrderMst.OrderID);
    ExecSQL(sql);

  //insert into detail
    for i:= 0 to OrderDetail_Arr.Count -1 do begin
      if OrderDetail_Arr[i].OrderDetailID = 0 then begin
        sql:=
        'insert into trs_order_detail ('+
          'order_id, item_id,  quantity, price, disc, amount, conversion, disc_is_prc, tax)'+
        'values ('+
          FormatSQLNumber(OrderMst.OrderId)+','+
          FormatSQLNumber(OrderDetail_Arr[i].MstItem.ItemId)+','+
//          FormatSQLNumber(OrderDetail_Arr[i].MstItemConversion.ConvId)+','+
          FormatSQLNumber(OrderDetail_Arr[i].Quantity)+','+
          FormatSQLNumber(OrderDetail_Arr[i].Price)+','+
          FormatSQLNumber(OrderDetail_Arr[i].Disc)+','+  //Rp
          FormatSQLNumber(OrderDetail_Arr[i].Amount)+','+//bfore disc
          FormatSQLNumber(OrderDetail_Arr[i].Conversion)+','+
          FormatSQLNumber(OrderDetail_Arr[i].DiscIsPrc)+','+
          FormatSQLNumber(OrderDetail_Arr[i].Tax)+')';

        ExecSQL(sql, False,
        'insert into trs_order_detail ('+
            'order_id, item_id,  quantity, price, disc, amount, conversion, disc_is_prc, tax)'+
          'values (last_insert_id(), '+
            FormatSQLNumber(OrderDetail_Arr[i].MstItem.ItemId)+','+
            //FormatSQLNumber(OrderDetail_Arr[i].MstItemConversion.ConvId)+','+
            FormatSQLNumber(OrderDetail_Arr[i].Quantity)+','+
            FormatSQLNumber(OrderDetail_Arr[i].Price)+','+
            FormatSQLNumber(OrderDetail_Arr[i].Disc)+','+
            FormatSQLNumber(OrderDetail_Arr[i].Amount)+','+//bfore disc
            FormatSQLNumber(OrderDetail_Arr[i].Conversion)+','+
            FormatSQLNumber(OrderDetail_Arr[i].DiscIsPrc)+','+
            FormatSQLNumber(OrderDetail_Arr[i].Tax)+')');
      end else
        ExecSQL(
        'update trs_order_detail set '+
          'item_id = '+FormatSQLNumber(OrderDetail_Arr[i].MstItem.ItemId)+','+
      //    'conv_id = '+FormatSQLNumber(OrderDetail_Arr[i].MstItemConversion.ConvId)+','+
          'quantity = '+FormatSQLNumber(OrderDetail_Arr[i].Quantity)+','+
          'price = '+FormatSQLNumber(OrderDetail_Arr[i].Price)+','+
          'disc = '+FormatSQLNumber(OrderDetail_Arr[i].Disc)+','+  //Rp
          'amount = '+FormatSQLNumber(OrderDetail_Arr[i].Amount)+','+//bfore disc
          'disc_is_prc = '+FormatSQLNumber(OrderDetail_Arr[i].DiscIsPrc)+','+
          'tax = '+FormatSQLNumber(OrderDetail_Arr[i].Tax)+','+
          'conversion  = '+FormatSQLNumber(OrderDetail_Arr[i].Conversion)+
        ' where order_detail_id = '+FormatSQLNumber(OrderDetail_Arr[i].OrderDetailID));
    end;

//    ExecSQL(
//    'delete from trs_order_detail where order_id = '+FormatSQLNumber(OrderMst.OrderID)+
//    ' and quantity = 0 ');

    Result:= True;
    EndSQL;
  except
    Result:= False;
    UndoSQL;
    Inform(MSG_UNSUCCESS_SAVING);
  end;
end;

class procedure TTrsOrder.updateStatusOrder(id, st: integer);
begin
  ExecSQL('update trs_order_mst set sudah_diterima = '+IntToStr(st)+
  ' where order_id = '+IntToStr(id));
end;

function TTrsReceipt.UpdateOnDB: boolean;
var i: integer; sqL: string;
begin
  try
    BeginSQL;
    sql:=
    'update trs_receipt_mst set '+
    'trans_date = '+FormatSQLDate(Transdate)+','+
    'tipe = '+FormatSQLNumber(Tipe)+','+
    'expr_date = '+FormatSQLDate(ExprDate)+','+
    'order_id = '+IfThen(OrderId <> 0, FormatSQLNumber(OrderId), FormatSQLNULL)+','+
    'gudang_id = '+FormatSQLNumber(CENTRAL_BOARD)+','+// IfThen(GudangId <> 0, FormatSQLNumber(GudangId), FormatSQLNULL)+','+
    'relation_id = '+IfThen(RelationID <> 0, FormatSQLNumber(RelationID), FormatSQLNULL)+','+
    'subtotal = '+FormatSQLNumber(Subtotal)+','+
    'disc_detail = '+FormatSQLNumber(DiscDetail)+','+
    'disc_mst = '+FormatSQLNumber(DiscMst)+','+
    'tax = '+FormatSQLNumber(Tax)+','+
    'biaya = '+FormatSQLNumber(Biaya)+','+
    'materai = '+FormatSQLNumber(Materai)+','+
    'total = '+FormatSQLNumber(Total)+','+
    'dpp_disc2 = '+FormatSQLNumber(DppDisc2)+','+
    'notes = '+FormatSQLString(Notes)+','+
    'user_id = '+FormatSQLString(UserId)+
    'where receipt_id = '+FormatSQLNumber(FReceiptID);
    ExecSQL(sql);

    for i:= 0 to trsDetail.Count-1 do
      if trsDetail[i].ReceiptDetailID = 0 then begin
        sql:=
        'insert into trs_receipt_detail ('+
          'receipt_id, item_id, conv_id, conv_bonus_id, quantity, qty_bonus, '+
          'price, amount, disc1, disc2, disc3, conversion, conv_bonus, '+
          'disc1_is_prc, disc2_is_prc, disc3_is_prc, tax)'+
        'values ('+
          FormatSQLNumber(ReceiptId)+','+
          FormatSQLNumber(trsDetail[i].ItemId)+','+
          FormatSQLNumber(trsDetail[i].ConvId)+','+
          IfThen(trsDetail[i].ConvBonusID <> 0,
            FormatSQLNumber(trsDetail[i].ConvBonusID), FormatSQLNULL)+','+
          FormatSQLNumber(trsDetail[i].Quantity)+','+
          FormatSQLNumber(trsDetail[i].QtyBonus)+','+
          FormatSQLNumber(trsDetail[i].Price)+','+
          FormatSQLNumber(trsDetail[i].Amount)+','+//bfore disc
          FormatSQLNumber(trsDetail[i].Disc1)+','+  //Rp
          FormatSQLNumber(trsDetail[i].Disc2)+','+  //Rp
          FormatSQLNumber(trsDetail[i].Disc3)+','+  //Rp
          FormatSQLNumber(trsDetail[i].Conversion)+','+
          FormatSQLNumber(trsDetail[i].ConvBonus)+','+
          FormatSQLNumber(trsDetail[i].Disc1IsPrc)+','+
          FormatSQLNumber(trsDetail[i].Disc2IsPrc)+','+
          FormatSQLNumber(trsDetail[i].Disc3IsPrc)+','+
          FormatSQLNumber(trsDetail[i].Tax)+')';

        ExecSQL(sql, False,
        'insert into trs_receipt_detail ('+
          'receipt_id, item_id, conv_id, conv_bonus_id, quantity, qty_bonus, price, '+
          'amount, disc1, disc2, disc3, conversion, conv_bonus, '+
          'disc1_is_prc, disc2_is_prc, disc3_is_prc, tax)'+
        'values (last_insert_id(), '+
          FormatSQLNumber(trsDetail[i].ItemId)+','+
          FormatSQLNumber(trsDetail[i].ConvId)+','+
          FormatSQLNumber(trsDetail[i].ConvBonusID)+','+
          FormatSQLNumber(trsDetail[i].Quantity)+','+
          FormatSQLNumber(trsDetail[i].QtyBonus)+','+
          FormatSQLNumber(trsDetail[i].Price)+','+
          FormatSQLNumber(trsDetail[i].Amount)+','+//bfore disc
          FormatSQLNumber(trsDetail[i].Disc1)+','+  //Rp
          FormatSQLNumber(trsDetail[i].Disc2)+','+  //Rp
          FormatSQLNumber(trsDetail[i].Disc3)+','+  //Rp
          FormatSQLNumber(trsDetail[i].Conversion)+','+
          FormatSQLNumber(trsDetail[i].ConvBonus)+','+
          FormatSQLNumber(trsDetail[i].Disc1IsPrc)+','+
          FormatSQLNumber(trsDetail[i].Disc2IsPrc)+','+
          FormatSQLNumber(trsDetail[i].Disc3IsPrc)+','+
          FormatSQLNumber(trsDetail[i].Tax)+')');
      end
      else
        ExecSQL(
        'update trs_receipt_detail set '+
        'item_id = '+FormatSQLNumber(trsDetail[i].ItemId)+','+
        'conv_id = '+FormatSQLNumber(trsDetail[i].ConvId)+','+
        'conv_bonus_id = '+IfThen(trsDetail[i].ConvBonusID <> 0, FormatSQLNumber(trsDetail[i].ConvBonusID), FormatSQLNULL)+','+
        'quantity = '+FormatSQLNumber(trsDetail[i].Quantity)+','+
        'qty_bonus = '+FormatSQLNumber(trsDetail[i].QtyBonus)+','+
        'price = '+FormatSQLNumber(trsDetail[i].Price)+','+
        'amount = '+FormatSQLNumber(trsDetail[i].Amount)+','+//bfore disc
        'disc1 = '+FormatSQLNumber(trsDetail[i].Disc1)+','+  //Rp
        'disc2 = '+FormatSQLNumber(trsDetail[i].Disc2)+','+  //Rp
        'disc3 = '+FormatSQLNumber(trsDetail[i].Disc3)+','+  //Rp
        'conversion = '+FormatSQLNumber(trsDetail[i].Conversion)+','+
        'tax = '+FormatSQLNumber(trsDetail[i].Tax)+','+
        'disc1_is_prc = '+FormatSQLNumber(trsDetail[i].Disc1IsPrc)+','+
        'disc2_is_prc = '+FormatSQLNumber(trsDetail[i].Disc2IsPrc)+','+
        'disc3_is_prc = '+FormatSQLNumber(trsDetail[i].Disc3IsPrc)+','+
        'conv_bonus = '+FormatSQLNumber(trsDetail[i].ConvBonus)+
        ' where receipt_detail_id = '+FormatSQLNumber(trsDetail[i].ReceiptDetailID));

    TTrsOrder.updateStatusOrder(OrderId, 1);
    EndSQL;
    Result:= True;
  except
    UndoSQL;
    Result:= False;
    Inform(MSG_UNSUCCESS_SAVING);
  end;
end;

{ TTrsRetur }

procedure TTrsRetur.Clear;
begin
  inherited Reset;
  trsDetail.Clear;
end;

constructor TTrsRetur.Create;
begin
  inherited Create;
  trsDetail:= _TrsReturDetail_Arr.Create;
end;

class function TTrsRetur.DeleteDetail(ID: integer): boolean;
begin
  try
    ExecSQL('delete from trs_retur_detail where retur_detail_id = '+FormatSQLNumber(ID));
    Result:= True;
  except
    Result:= False;
    Alert('Data tidak bisa dihapus.');
  end;
end;

class function TTrsRetur.DeleteTrans(ID: integer): boolean;
//var poID: integer;
begin
  try
    BeginSQL;
    //poID:= getIntegerFromSQL('select order_id from trs_receipt_mst where receipt_id = '+FormatSQLNumber(ID));
    ExecSQL('delete from trs_retur_mst where retur_id = '+FormatSQLNumber(ID));

  //  TTrsOrder.updateStatusOrder(poID,0);
    EndSQL;
    Result:= True;
  except
    UndoSQL;
    Result:= False;
    Alert('Data tidak bisa dihapus.');
  end;
end;

destructor TTrsRetur.Destroy;
begin
  trsDetail.Destroy;
  inherited;
end;

function TTrsRetur.GetNewNumber: string;
var prefix: string;
begin
  prefix := GlobalSystemConfig[CONF_PREP_COMP-1].ConfValue +
            GlobalSystemConfig[CONF_PREP_RETUR-1].ConfValue +
            getPeriode3(TransDate);
  Result := prefix + getNextIDNumPeriode2('trans_num ','trs_retur_mst ', '', prefix, '', '',5);
end;

function TTrsRetur.InsertOnDB: boolean;
var i: integer; sqL: string;
begin
  if DEMO_VERSION then begin
    if getIntegerFromSQL('select count(*) from trs_retur_mst') > 100 then begin
      Result:= False;
      Inform('Maaf versi demo hanya untuk 100 transaksi.');
      Exit;
    end;
  end;

  try
    BeginSQL;

    TransNum:= GetNewNumber;
    sql:=
    'insert into trs_retur_mst ('+
    'trans_num, trans_date, tipe, relation_id, '+
    'gudang_id, subtotal, discount, tax, biaya, materai, total, notes, user_id) '+
    'values ('+

      FormatSQLString(TransNum)+','+
      FormatSQLDate(Transdate)+','+
      FormatSQLNumber(Tipe)+','+
      IfThen(RelationId <> 0, FormatSQLNumber(RelationId), FormatSQLNULL)+','+
      FormatSQLNumber(CENTRAL_BOARD)+','+ //IfThen(GudangId <> 0, FormatSQLNumber(GudangId), FormatSQLNULL)+','+
      FormatSQLNumber(Subtotal)+','+
      FormatSQLNumber(Discount)+','+
      FormatSQLNumber(Tax)+','+
      FormatSQLNumber(Biaya)+','+
      FormatSQLNumber(Materai)+','+
      FormatSQLNumber(Total)+','+
      FormatSQLString(Notes)+','+
      FormatSQLString(UserId)+')';
    ExecSQL(sql);

    ReturID:= getIntegerFromSQL(
    'select retur_id from trs_retur_mst where trans_num = '+FormatSQLString(TransNum));

    for i:= 0 to trsDetail.Count-1 do
      if trsDetail[i].ItemId <> 0 then begin
        sql:=
        'insert into trs_retur_detail ('+
          'retur_id, item_id, conv_id, quantity, price, amount, '+
          'disc, tax, disc_is_prc, conversion, faktur_id)'+
        'values ('+
          FormatSQLNumber(ReturID)+','+
          FormatSQLNumber(trsDetail[i].ItemId)+','+
          FormatSQLNumber(trsDetail[i].ConvId)+','+
          FormatSQLNumber(trsDetail[i].Quantity)+','+
          FormatSQLNumber(trsDetail[i].Price)+','+
          FormatSQLNumber(trsDetail[i].Amount)+','+//bfore disc
          FormatSQLNumber(trsDetail[i].Disc)+','+//bfore disc
          FormatSQLNumber(trsDetail[i].Tax)+','+//bfore disc
          FormatSQLNumber(trsDetail[i].DiscIsPrc)+','+//bfore disc
          FormatSQLNumber(trsDetail[i].Conversion)+','+
          IfThen(trsDetail[i].FakturID <> 0,
            FormatSQLNumber(trsDetail[i].FakturID), FormatSQLNULL)+')';

        ExecSQL(sql, False,
        'insert into trs_retur_detail ('+
          'retur_id, item_id, conv_id, quantity, price, amount, '+
          'disc, tax, disc_is_prc, conversion, faktur_id)'+
        'values (last_insert_id(), '+
          FormatSQLNumber(trsDetail[i].ItemId)+','+
          FormatSQLNumber(trsDetail[i].ConvId)+','+
          FormatSQLNumber(trsDetail[i].Quantity)+','+
          FormatSQLNumber(trsDetail[i].Price)+','+
          FormatSQLNumber(trsDetail[i].Amount)+','+//bfore disc
          FormatSQLNumber(trsDetail[i].Disc)+','+//bfore disc
          FormatSQLNumber(trsDetail[i].Tax)+','+//bfore disc
          FormatSQLNumber(trsDetail[i].DiscIsPrc)+','+//bfore disc
          FormatSQLNumber(trsDetail[i].Conversion)+','+
          IfThen(trsDetail[i].FakturID <> 0,
            FormatSQLNumber(trsDetail[i].FakturID), FormatSQLNULL)+')');
      end;
    EndSQL;
    Result:= True;
  except
    UndoSQL;
    Result:= False;
    Inform(MSG_UNSUCCESS_SAVING);
  end;
end;

class function TTrsRetur.LoadRekap: TMysqlResult;
var sqL,filter: string;
begin
  if GlobalPeriode.PeriodeAwal1 <> 0 then
    filter:= filter + ' and t.trans_date '+FormatSQLOperator(GlobalPeriode.OpPeriodeAwal1)+FormatSQLDate(GlobalPeriode.PeriodeAwal1);
  if GlobalPeriode.PeriodeAkhir1 <> 0 then
    filter:= filter + ' and t.trans_date '+FormatSQLOperator(GlobalPeriode.OpPeriodeAkhir1)+FormatSQLDate(GlobalPeriode.PeriodeAkhir1);

  if GlobalFilter.TipeID <> '0' then
    filter:= filter + ' and t.tipe = '+FormatSQLString(GlobalFilter.TipeId);
  if GlobalFilter.SpecId > 1 then
    filter:= filter + ' and m.root_id = '+FormatSQLNumber(GlobalFilter.SpecID);
  if GlobalFilter.RelasiID <> 0 then
    filter:= filter + ' and t.relation_id = '+FormatSQLNumber(GlobalFilter.RelasiID);
  if GlobalFilter.StatusID <> -1 then
    filter:= filter + ' and t.status_id = '+FormatSQLNumber(GlobalFilter.StatusID);

  if (GlobalFilter.SpecId <= 1) and (filter <> '') then
    filter:= ' where ' +Copy(filter, 5, length(filter));

  sqL:=
    'select distinct '+
      't.retur_id, t.trans_num as ''No Trx'', t.trans_date as ''Tgl Retur'', '+
      '(select relation_name from mst_relation r where r.relation_id= t.relation_id) as Supplier, '+
      'case when status_id = 0 then ''Un Posted'' else ''Posted'' end as Status,t.notes as ''Keterangan'','+
      't.Subtotal, t.Discount, t.tax as Pajak, t.Materai, t.Biaya, t.Total '+
    'from trs_retur_mst t '+

    IfThen(GlobalFilter.SpecId > 1,
    ', trs_retur_detail d, mst_item i, point_maping m where d.retur_id = t.retur_id '+
    ' and d.item_id = i.item_id and i.specification = m.code_id ')+filter;
  Result:= OpenSQL(sqL);
end;

class function TTrsRetur.PostTrans(ID: integer): boolean;
var i: integer; detail: TMysqlResult;
begin
  try
    BeginSQL;

    detail:= OpenSQL(
    'select distinct d.item_id, d.quantity, '+
    't.gudang_id, t.trans_date, t.total, t.relation_id, d.faktur_id '+
    'from trs_retur_mst t, trs_retur_detail d '+
    'where d.retur_id = t.retur_id and t.retur_id = '+FormatSQLNumber(ID));

    detail.First;
    for i:= 0 to detail.RecordCount-1 do begin
      save_balance(
        CENTRAL_BOARD,//BufferToInteger(detail.FieldValue(2)),
        BufferToInteger(detail.FieldValue(0)),
        BufferToDateTime(detail.FieldValue(3)),
        BufferToFloat(detail.FieldValue(1)),0, DB_CR_TYPE_CREDIT);

      ExecSQL(
      'update trs_receipt_mst set sisa = sisa - '+FormatSQLNumber(BufferToFloat(detail.FieldValue(4)))+
      ' where receipt_id = '+FormatSQLNumber(BufferToInteger(detail.FieldValue(6))));

      detail.MoveNext;
    end;

    ExecSQL('update trs_retur_mst set status_id = 1 where retur_id = '+FormatSQLNumber(ID));

    if detail.RecordCount > 0 then
      save_to_relation_balance(
        BufferToInteger(detail.FieldValue(5)),
        BufferToDateTime(detail.FieldValue(3)),
        BufferToFloat(detail.FieldValue(4)), DB_CR_TYPE_CREDIT);

    detail.destroy;
    Result:= True;
    EndSQL;
  except
    UndoSQL;
    Result:= False;
    Alert('Data tidak bisa diposting.');
  end;
end;

class function TTrsRetur.printRetur(ID: integer): TMysqlResult;
var sql:string;
begin
 sql := 'select (d.quantity) as qty, d.price, d.amount, i.item_name, '+
  't.trans_num, t.trans_date, t.total, t.subtotal, '+
  't.relation_id, now(), i.item_code,d.disc,retur_detail_id,t.discount '+
  ' from trs_retur_mst t, trs_retur_detail d, mst_item i '+
  'where d.retur_id = t.retur_id and d.item_id = i.item_id and d.item_id is not null '+
  'and t.retur_id = '+IntToStr(ID)+
  ' order by retur_detail_id ';
   Result := OpenSQL(sql);

end;

function TTrsRetur.SelectDetail(ID: integer): TMysqlResult;
var sql:string;
begin
  sql := 
  'select d.retur_detail_id, d.item_id, d.conv_id, (d.quantity/d.conversion) as quantity, '+
  'd.price, d.amount, d.conversion, '+
  'i.item_name, i.barcode, '+
  '(select u.mst_code from  mst_master u '+
     'where i.kemasan_id = u.mst_id) as satuan, '+
  'd.faktur_id, '+
  '(select r.trans_num from trs_receipt_mst r where r.receipt_id = d.faktur_id) as faktur, '+
  'd.disc, d.tax, d.disc_is_prc,i.item_code '+
  'from trs_retur_detail d, mst_item i '+
  'where d.item_id = i.item_id '+
  'and retur_id = '+FormatSQLNumber(ID);
  Result:= OpenSQL(sql);
end;

function TTrsRetur.SelectFakturDetail(ID: integer): TMysqlResult;
begin
  Result:= OpenSQL(
  'select distinct d.receipt_id, d.item_id, d.conv_id, (d.quantity / d.conversion) as quantity, '+
  'd.price, d.amount, d.conversion, '+
  'i.item_name, i.barcode, '+
  '(select u.mst_code from  mst_master u '+
     'where i.kemasan_id = u.mst_id) as satuan, '+
  '(select r.trans_num from trs_receipt_mst r where r.receipt_id = d.receipt_id) as faktur, '+
  '(disc1 + disc2 + disc3) as disc, d.tax '+
  'from trs_receipt_detail d, mst_item i '+
  'where d.item_id = i.item_id '+
  'and receipt_id = '+FormatSQLNumber(ID));
end;

function TTrsRetur.SelectInDB: boolean;
var sqL: string; buffer: TMysqlResult;
begin
  sqL:=
  'select retur_id, tipe, trans_num, trans_date, user_id, '+
  'subtotal, discount, tax, total, notes, relation_id, status_id, '+
  'gudang_id, biaya, materai '+
  'from trs_retur_mst '+
  'where retur_id = '+FormatSQLNumber(ReturID);
  buffer:= OpenSQL(sqL);
  Reset;
  Result:= buffer.RecordCount > 0;
  if Result then begin
    ReturID := BufferToInteger(buffer.FieldValue(0));
    Tipe  := BufferToInteger(buffer.FieldValue(1));
    TransNum   := BufferToString(buffer.FieldValue(2));
    TransDate  := BufferToDateTime(buffer.FieldValue(3));
    UserId     := BufferToString(buffer.FieldValue(4));
    Subtotal := BufferToFloat(buffer.FieldValue(5));
    Discount := BufferToFloat(buffer.FieldValue(6));
    Tax := BufferToFloat(buffer.FieldValue(7));
    Total := BufferToFloat(buffer.FieldValue(8));
    Notes := BufferToString(buffer.FieldValue(9));
    RelationId := BufferToInteger(buffer.FieldValue(10));
    StatusId := BufferToInteger(buffer.FieldValue(11));
    GudangId := BufferToInteger(buffer.FieldValue(12));
    Biaya := BufferToFloat(buffer.FieldValue(13));
    Materai := BufferToFloat(buffer.FieldValue(14));
  end;
  buffer.Destroy;
end;

function TTrsRetur.UpdateOnDB: boolean;
var i: integer; sqL: string;
begin
  try
  //'insert into trs_retur_mst ('+
  //  'trans_num, trans_date, tipe, relation_id, '+
  //  'gudang_id, subtotal, discount, tax, biaya, materai, total, notes, user_id) '+


    BeginSQL;
    sql:=
    'update trs_retur_mst set '+
    'trans_date = '+FormatSQLDate(Transdate)+','+
    'tipe = '+FormatSQLNumber(Tipe)+','+
    'gudang_id = '+FormatSQLNumber(CENTRAL_BOARD)+','+// IfThen(GudangId <> 0, FormatSQLNumber(GudangId), FormatSQLNULL)+','+
    'relation_id = '+IfThen(RelationID <> 0, FormatSQLNumber(RelationID), FormatSQLNULL)+','+
    'subtotal = '+FormatSQLNumber(Subtotal)+','+
    'tax = '+FormatSQLNumber(Tax)+','+
    'biaya = '+FormatSQLNumber(Biaya)+','+
    'materai = '+FormatSQLNumber(Materai)+','+
    'total = '+FormatSQLNumber(Total)+','+
    'discount = '+FormatSQLNumber(discount)+','+
    'notes = '+FormatSQLString(Notes)+','+
    'user_id = '+FormatSQLString(UserId)+
    'where retur_id = '+FormatSQLNumber(FReturID);
    ExecSQL(sql);

    for i:= 0 to trsDetail.Count-1 do
      if trsDetail[i].ReturDetailID = 0 then begin
        sql:=
        'insert into trs_retur_detail ('+
          'retur_id, item_id, conv_id, quantity, price, amount, '+
          'disc, tax, disc_is_prc, conversion, faktur_id)'+
        'values ('+
          FormatSQLNumber(ReturID)+','+
          FormatSQLNumber(trsDetail[i].ItemId)+','+
          FormatSQLNumber(trsDetail[i].ConvId)+','+
          FormatSQLNumber(trsDetail[i].Quantity)+','+
          FormatSQLNumber(trsDetail[i].Price)+','+
          FormatSQLNumber(trsDetail[i].Amount)+','+//bfore disc
          FormatSQLNumber(trsDetail[i].Disc)+','+//bfore disc
          FormatSQLNumber(trsDetail[i].Tax)+','+//bfore disc
          FormatSQLNumber(trsDetail[i].DiscIsPrc)+','+//bfore disc
          FormatSQLNumber(trsDetail[i].Conversion)+','+
          IfThen(trsDetail[i].FakturID <> 0,
            FormatSQLNumber(trsDetail[i].FakturID), FormatSQLNULL)+')';

        ExecSQL(sql, False,
        'insert into trs_retur_detail ('+
          'retur_id, item_id, conv_id, quantity, price, amount, '+
          'disc, tax, disc_is_prc, conversion, faktur_id)'+
        'values (last_insert_id(), '+
          FormatSQLNumber(trsDetail[i].ItemId)+','+
          FormatSQLNumber(trsDetail[i].ConvId)+','+
          FormatSQLNumber(trsDetail[i].Quantity)+','+
          FormatSQLNumber(trsDetail[i].Price)+','+
          FormatSQLNumber(trsDetail[i].Amount)+','+//bfore disc
          FormatSQLNumber(trsDetail[i].Disc)+','+//bfore disc
          FormatSQLNumber(trsDetail[i].Tax)+','+//bfore disc
          FormatSQLNumber(trsDetail[i].DiscIsPrc)+','+//bfore disc
          FormatSQLNumber(trsDetail[i].Conversion)+','+
          IfThen(trsDetail[i].FakturID <> 0,
            FormatSQLNumber(trsDetail[i].FakturID), FormatSQLNULL)+')');
      end
      else
        ExecSQL(
        'update trs_retur_detail set '+
        'item_id = '+FormatSQLNumber(trsDetail[i].ItemId)+','+
        'conv_id = '+FormatSQLNumber(trsDetail[i].ConvId)+','+
        'quantity = '+FormatSQLNumber(trsDetail[i].Quantity)+','+
        'price = '+FormatSQLNumber(trsDetail[i].Price)+','+
        'amount = '+FormatSQLNumber(trsDetail[i].Amount)+','+//bfore disc
        'disc = '+FormatSQLNumber(trsDetail[i].Disc)+','+  //Rp
        'tax = '+FormatSQLNumber(trsDetail[i].Tax)+','+
        'disc_is_prc = '+FormatSQLNumber(trsDetail[i].DiscIsPrc)+','+
        'conversion = '+FormatSQLNumber(trsDetail[i].Conversion)+','+
        'faktur_id = '+FormatSQLNumber(trsDetail[i].Conversion)+
        ' where retur_detail_id = '+FormatSQLNumber(trsDetail[i].ReturDetailID));
    EndSQL;
    Result:= True;
  except
    UndoSQL;
    Result:= False;
    Inform(MSG_UNSUCCESS_UPDATE);
  end;

end;

{ TTrsPayment }

procedure TTrsPayment.Reset;
begin
  inherited Reset;
  trsDetail.Clear;
  akunDetail.Clear;
end;

constructor TTrsPayment.Create;
begin
  inherited Create;
  trsDetail:= _TrsPaymentDetail_Arr.Create;
  akunDetail:= _TrsPaymentAkun_Arr.Create;
end;

class function TTrsPayment.DeleteDetail(ID: integer): boolean;
begin
  try
    BeginSQL;
    ExecSQL('delete from trs_payment_detail where pay_detail_id = '+FormatSQLNumber(ID));
    EndSQL;
    Result:= True;
  except
    UndoSQL;
    Result:= False;
    Alert('Data tidak bisa dihapus.');
  end;
end;

class function TTrsPayment.DeleteTrans(ID: integer): boolean;
begin
  try
    BeginSQL;
    ExecSQL('delete from trs_payment_mst where payment_id = '+FormatSQLNumber(ID));
    EndSQL;
    Result:= True;
  except
    UndoSQL;
    Result:= False;
    Alert('Data tidak bisa dihapus.');
  end;
end;

destructor TTrsPayment.Destroy;
begin
  trsDetail.Destroy;
  akunDetail.Destroy;
  inherited;
end;

function TTrsPayment.GetNewNumber: string;
var prefix: string;
begin
  prefix := GlobalSystemConfig[CONF_PREP_COMP-1].ConfValue +
            GlobalSystemConfig[CONF_PREP_PAYMENT-1].ConfValue +
            getPeriode3(TransDate);
  Result := prefix + getNextIDNumPeriode2('trans_num ','trs_payment_mst ', '', prefix, '', '',5);
end;

function TTrsPayment.InsertOnDB: boolean;
var i: integer; sqL: string;
begin
  if DEMO_VERSION then begin
    if getIntegerFromSQL('select count(*) from trs_payment_mst') > 100 then begin
      Result:= False;
      Inform('Maaf versi demo hanya untuk 100 transaksi.');
      Exit;
    end;
  end;

  try
    BeginSQL;

    TransNum:= GetNewNumber;
    sql:=
    'insert into trs_payment_mst ('+
    'trans_num, trans_date, tipe, relation_id, inv_id, '+
    'subtotal, discount, biaya, total, notes, user_id) '+
    'values ('+
      FormatSQLString(TransNum)+','+
      FormatSQLDate(Transdate)+','+
      FormatSQLNumber(Tipe)+','+
      IfThen(RelationId <> 0, FormatSQLNumber(RelationId), FormatSQLNULL)+','+
      IfThen(InvID <> 0, FormatSQLNumber(InvID), FormatSQLNULL)+','+
      FormatSQLNumber(Subtotal)+','+
      FormatSQLNumber(Discount)+','+
      FormatSQLNumber(Biaya)+','+
      FormatSQLNumber(Total)+','+
      FormatSQLString(Notes)+','+
      FormatSQLString(UserId)+')';
    ExecSQL(sql);

    PaymentID:= getIntegerFromSQL(
    'select payment_id from trs_payment_mst where trans_num = '+FormatSQLString(TransNum));


    for i:= 0 to trsDetail.Count-1 do
      if trsDetail[i].JenisBayar <> 0 then begin
        sql:=
        'insert into trs_payment_detail ('+
          'payment_id, jenis_bayar, amount, bank, dok_num, tgl_cair)'+
        'values ('+
          FormatSQLNumber(PaymentID)+','+
          FormatSQLNumber(trsDetail[i].JenisBayar)+','+
          FormatSQLNumber(trsDetail[i].Amount)+','+
          FormatSQLString(trsDetail[i].Bank)+','+
          FormatSQLString(trsDetail[i].DokNum)+','+
          FormatSQLDate(trsDetail[i].TglCair)+')';

        ExecSQL(sql, False,
        'insert into trs_payment_detail ('+
          'payment_id, jenis_bayar, amount, bank, dok_num, tgl_cair)'+
        'values (last_insert_id(), '+
          FormatSQLNumber(trsDetail[i].JenisBayar)+','+
          FormatSQLNumber(trsDetail[i].Amount)+','+
          FormatSQLString(trsDetail[i].Bank)+','+
          FormatSQLString(trsDetail[i].DokNum)+','+
          FormatSQLDate(trsDetail[i].TglCair)+')');
      end;
    //TTrsOrder.updateStatusOrder(OrderId, 1);
    EndSQL;
    Result:= True;
  except
    UndoSQL;
    Result:= False;
    Inform(MSG_UNSUCCESS_SAVING);
  end;
end;

class function TTrsPayment.LoadRekap: TMysqlResult;
var relasi,sqL,filter: string;
begin
  case GlobalFilter.SeriesID of
    TRANS_TYPE_PEMBAYARAN: relasi:= 'Supplier';
    TRANS_TYPE_PIUTANG   : relasi:= 'Customer';
    else  relasi:= 'Relasi';
  end;
  if GlobalPeriode.PeriodeAwal1 <> 0 then
    filter:= filter + ' and t.trans_date '+FormatSQLOperator(GlobalPeriode.OpPeriodeAwal1)+FormatSQLDate(GlobalPeriode.PeriodeAwal1);
  if GlobalPeriode.PeriodeAkhir1 <> 0 then
    filter:= filter + ' and t.trans_date '+FormatSQLOperator(GlobalPeriode.OpPeriodeAkhir1)+FormatSQLDate(GlobalPeriode.PeriodeAkhir1);
  if GlobalFilter.SeriesID <> 0 then
    filter:= filter + ' and t.tipe = '+FormatSQLNumber(GlobalFilter.SeriesID);
  if GlobalFilter.RelasiID <> 0 then
    filter:= filter + ' and t.relation_id = '+FormatSQLNumber(GlobalFilter.RelasiID);
  if GlobalFilter.StatusID <> -1 then
    filter:= filter + ' and t.status_id = '+FormatSQLNumber(GlobalFilter.StatusID);

  if (filter <> '') then filter:= ' where ' +Copy(filter, 5, length(filter));

  sqL:=
    'select distinct '+
      't.payment_id, t.trans_num as ''No Trx'', t.trans_date as ''Tgl Pembayaran'', '+
      '(select relation_name from mst_relation r where r.relation_id= t.relation_id) as '+relasi+
      ', t.Subtotal, t.Discount, t.Biaya, t.Total '+
    'from trs_payment_mst t '+filter;
  Result:= OpenSQL(sqL);
end;

class function TTrsPayment.PostTrans(ID, JNS: integer): boolean;
var detail: TMysqlResult;
begin
  try
    BeginSQL;
    detail:= OpenSQL(
    'select ifnull(subtotal + discount,0) as jumlah, trans_date, relation_id, inv_id '+
    'from trs_payment_mst  '+
    'where payment_id = '+FormatSQLNumber(ID));

    if detail.RecordCount > 0 then begin

      save_to_relation_balance(BufferToInteger(detail.FieldValue(2)),
        BufferToDateTime(detail.FieldValue(1)),
        BufferToFloat(detail.FieldValue(0)), DB_CR_TYPE_CREDIT);
      if JNS = TRANS_TYPE_PEMBAYARAN then
        ExecSQL(
        'update trs_receipt_mst set sisa = sisa - '+FormatSQLNumber(BufferToFloat(detail.FieldValue(0)))+
        ' where receipt_id = '+FormatSQLNumber(BufferToInteger(detail.FieldValue(3))))
      else ExecSQL(
        'update trs_sales_mst set sisa = sisa - '+FormatSQLNumber(BufferToFloat(detail.FieldValue(0)))+
        ' where sales_id = '+FormatSQLNumber(BufferToInteger(detail.FieldValue(3))));
    end;
    detail.destroy;

    Result:= True;
    EndSQL;
  except
    UndoSQL;
    Result:= False;
    Alert('Data tidak bisa diposting.');
  end;
end;

function TTrsPayment.SelectDetail(ID: integer): TMysqlResult;
begin
  Result:= OpenSQL(
  'select pay_detail_id, jenis_bayar, amount, bank, dok_num, tgl_cair, '+
  'case jenis_bayar '+
    'when 1 then ''TUNAI'' '+
    'when 2 then ''GIRO'' '+
    'when 3 then ''CEK'' '+
  'end as jns_bayar '+
  'from trs_payment_detail '+
  'where payment_id = '+FormatSQLNumber(ID));
end;

function TTrsPayment.SelectFaktur(ID: integer): TMysqlResult;
begin
  Result:= OpenSQL(
  'select trans_num, relation_id, sisa from trs_receipt_mst '+
  'where receipt_id = '+FormatSQLNumber(ID));
end;

function TTrsPayment.SelectInDB: boolean;
var sqL: string; buffer: TMysqlResult; 
begin
  sqL:=
  'select payment_id, tipe, trans_num, trans_date, user_id, '+
  'subtotal, discount, biaya, total, notes, relation_id, status_id, inv_id '+
  'from trs_payment_mst '+
  'where payment_id = '+FormatSQLNumber(PaymentID);
  buffer:= OpenSQL(sqL);
  Reset;
  Result:= buffer.RecordCount > 0;
  if Result then begin
    PaymentID := BufferToInteger(buffer.FieldValue(0));
    Tipe  := BufferToInteger(buffer.FieldValue(1));
    TransNum   := BufferToString(buffer.FieldValue(2));
    TransDate  := BufferToDateTime(buffer.FieldValue(3));
    UserId     := BufferToString(buffer.FieldValue(4));
    Subtotal := BufferToFloat(buffer.FieldValue(5));
    Discount := BufferToFloat(buffer.FieldValue(6));
    Biaya := BufferToFloat(buffer.FieldValue(7));
    Total := BufferToFloat(buffer.FieldValue(8));
    Notes := BufferToString(buffer.FieldValue(9));
    RelationId := BufferToInteger(buffer.FieldValue(10));
    StatusId := BufferToInteger(buffer.FieldValue(11));
    InvID := BufferToInteger(buffer.FieldValue(12));
  end;
  buffer.Destroy;
end;

function TTrsPayment.UpdateOnDB: boolean;
var i: integer; sqL: string;
begin
  try
    BeginSQL;
    sql:=
    'update trs_payment_mst set '+
    'trans_date = '+FormatSQLDate(Transdate)+','+
    'tipe = '+FormatSQLNumber(Tipe)+','+
    'inv_id = '+IfThen(InvID <> 0, FormatSQLNumber(InvID), FormatSQLNULL)+','+
    'subtotal = '+FormatSQLNumber(Subtotal)+','+
    'discount = '+FormatSQLNumber(Discount)+','+
    'biaya = '+FormatSQLNumber(Biaya)+','+
    'total = '+FormatSQLNumber(Total)+','+
    'notes = '+FormatSQLString(Notes)+','+
    'user_id = '+FormatSQLString(UserId)+
    'where payment_id = '+FormatSQLNumber(FPaymentID);
    ExecSQL(sql);

    for i:= 0 to trsDetail.Count-1 do
      if trsDetail[i].PayDetailID = 0 then begin
        sql:=
        'insert into trs_payment_detail ('+
          'payment_id, jenis_bayar, amount, bank, dok_num, tgl_cair)'+
        'values ('+
          FormatSQLNumber(PaymentID)+','+
          FormatSQLNumber(trsDetail[i].JenisBayar)+','+
          FormatSQLNumber(trsDetail[i].Amount)+','+
          FormatSQLString(trsDetail[i].Bank)+','+
          FormatSQLString(trsDetail[i].DokNum)+','+
          FormatSQLDate(trsDetail[i].TglCair)+')';

        ExecSQL(sql, False,
        'insert into trs_payment_detail ('+
          'payment_id, jenis_bayar, amount, bank, dok_num, tgl_cair)'+
        'values (last_insert_id(), '+
          FormatSQLNumber(trsDetail[i].JenisBayar)+','+
          FormatSQLNumber(trsDetail[i].Amount)+','+
          FormatSQLString(trsDetail[i].Bank)+','+
          FormatSQLString(trsDetail[i].DokNum)+','+
          FormatSQLDate(trsDetail[i].TglCair)+')');
      end
      else
        ExecSQL(
        'update trs_payment_detail set '+
        'jenis_bayar = '+FormatSQLNumber(trsDetail[i].JenisBayar)+','+
        'amount = '+FormatSQLNumber(trsDetail[i].Amount)+','+
        'bank = '+FormatSQLString(trsDetail[i].Bank)+','+
        'dok_num = '+FormatSQLString(trsDetail[i].DokNum)+','+
        'tgl_cair = '+FormatSQLDate(trsDetail[i].TglCair)+
        ' where pay_detail_id = '+FormatSQLNumber(trsDetail[i].PayDetailID));

    //TTrsOrder.updateStatusOrder(OrderId, 1);
    EndSQL;
    Result:= True;
  except
    UndoSQL;
    Result:= False;
    Inform(MSG_UNSUCCESS_SAVING);
  end;
end;

function TTrsPayment.InsertCharges: boolean;
var i: integer; sqL: string;
begin
  try
    BeginSQL;

    TransNum:= GetNewNumber;
    sql:=
    'insert into trs_payment_mst ('+
    'trans_num, trans_date, tipe, relation_id, subtotal, total, notes, status_id, user_id) '+
    'values ('+
      FormatSQLString(TransNum)+','+
      FormatSQLDate(Transdate)+','+
      FormatSQLNumber(Tipe)+','+
      IfThen(RelationId <> 0, FormatSQLNumber(RelationId), FormatSQLNULL)+','+
      FormatSQLNumber(Subtotal)+','+
      FormatSQLNumber(Total)+','+
      FormatSQLString(Notes)+', 1, '+
      FormatSQLString(UserId)+')';
    ExecSQL(sql);

    PaymentID:= getIntegerFromSQL(
    'select payment_id from trs_payment_mst where trans_num = '+FormatSQLString(TransNum));

    for i:= 0 to akunDetail.Count-1 do
      if akunDetail[i].AkunID <> 0 then begin
        sql:=
        'insert into trs_payment_akun ('+
          'payment_id, akun_id, amount)'+
        'values ('+
          FormatSQLNumber(PaymentID)+','+
          FormatSQLNumber(akunDetail[i].AkunID)+','+
          FormatSQLNumber(akunDetail[i].Amount)+')';

        ExecSQL(sql, False,
        'insert into trs_payment_akun ('+
          'payment_id, akun_id, amount)'+
        'values (last_insert_id(), '+
          FormatSQLNumber(akunDetail[i].AkunID)+','+
          FormatSQLNumber(akunDetail[i].Amount)+')');
      end;

    EndSQL;
    Result:= True;
  except
    UndoSQL;
    Result:= False;
    Inform(MSG_UNSUCCESS_SAVING);
  end;
end;

class function TTrsPayment.DeleteDetailAkun(ID: integer): boolean;
begin
  try
    BeginSQL;
    ExecSQL('delete from trs_payment_akun where pay_akun_id = '+FormatSQLNumber(ID));
    EndSQL;
    Result:= True;
  except
    UndoSQL;
    Result:= False;
    Alert('Data tidak bisa dihapus.');
  end;
end;

function TTrsPayment.SelectDetailAkun(ID: integer): TMysqlResult;
begin
  Result:= OpenSQL(
  'select d.pay_akun_id, d.amount, d.akun_id, a.kode, a.nama '+
  'from trs_payment_akun d, mst_akun a '+
  'where d.akun_id = a.akun_id and d.payment_id = '+FormatSQLNumber(ID));
end;

function TTrsPayment.UpdateCharges: boolean;
var i: integer; sqL: string;
begin
  try
    BeginSQL;
    sql:=
    'update trs_payment_mst set '+
    'trans_date = '+FormatSQLDate(Transdate)+','+
    'tipe = '+FormatSQLNumber(Tipe)+','+
    'subtotal = '+FormatSQLNumber(Subtotal)+','+
    'total = '+FormatSQLNumber(Total)+','+
    'notes = '+FormatSQLString(Notes)+','+
    'user_id = '+FormatSQLString(UserId)+
    'where payment_id = '+FormatSQLNumber(FPaymentID);
    ExecSQL(sql);

    for i:= 0 to akunDetail.Count-1 do
      if trsDetail[i].PayDetailID = 0 then begin
        sql:=
        'insert into trs_payment_akun ('+
          'payment_id, akun_id, amount)'+
        'values ('+
          FormatSQLNumber(PaymentID)+','+
          FormatSQLNumber(akunDetail[i].AkunID)+','+
          FormatSQLNumber(akunDetail[i].Amount)+')';

        ExecSQL(sql, False,
        'insert into trs_payment_akun ('+
          'payment_id, akun_id, amount)'+
        'values (last_insert_id(), '+
          FormatSQLNumber(akunDetail[i].AkunID)+','+
          FormatSQLNumber(akunDetail[i].Amount)+')')
      end
      else
        ExecSQL(
        'update trs_payment_akun set '+
        'akun_id = '+FormatSQLNumber(akunDetail[i].AkunID)+','+
        'amount = '+FormatSQLNumber(akunDetail[i].Amount)+
        ' where pay_akun_id = '+FormatSQLNumber(akunDetail[i].PayAkunID));

    EndSQL;
    Result:= True;
  except
    UndoSQL;
    Result:= False;
    Inform(MSG_UNSUCCESS_SAVING);
  end;
end;

function TTrsPayment.SelectStruk(ID: integer): TMysqlResult;
begin
  Result:= OpenSQL(
  'select trans_num, pasien_id, sisa from trs_sales_mst '+
  'where sales_id = '+FormatSQLNumber(ID));
end;

{ TReport }

class function TReport.getAkunBiaya: TMysqlResult;
begin
  Result:= OpenSQL(
  'select akun_id, nama from mst_akun where tipe = 2 order by kode');
end;

class function TReport.getBiaya(AkunID: integer): double;
var sqL, filter: string;
begin
  filter:= ' and d.akun_id = '+FormatSQLNumber(AkunID);
  if GlobalPeriode.PeriodeAwal1 <> 0 then
    filter:= filter + ' and t.trans_date '+FormatSQLOperator(GlobalPeriode.OpPeriodeAwal1)+FormatSQLDate(GlobalPeriode.PeriodeAwal1);
  if GlobalPeriode.PeriodeAkhir1 <> 0 then
    filter:= filter + ' and t.trans_date '+FormatSQLOperator(GlobalPeriode.OpPeriodeAkhir1)+FormatSQLDate(GlobalPeriode.PeriodeAkhir1);

  sqL:=
  'select ifnull(sum(d.amount),0) from trs_money_trans_mst t inner join trs_money_trans_detail d on d.money_trans_id = t.money_trans_id '+
  'where t.trans_Type = '+FormatSQLNumber(2)+filter;
  Result:= getFloatFromSQL(sqL);
end;

class function TReport.getMutasi: double;
var sqL, filter: string;
begin
  if GlobalPeriode.PeriodeAwal1 <> 0 then
    filter:= filter + ' and t.trans_date '+FormatSQLOperator(GlobalPeriode.OpPeriodeAwal1)+FormatSQLDate(GlobalPeriode.PeriodeAwal1);
  if GlobalPeriode.PeriodeAkhir1 <> 0 then
    filter:= filter + ' and t.trans_date '+FormatSQLOperator(GlobalPeriode.OpPeriodeAkhir1)+FormatSQLDate(GlobalPeriode.PeriodeAkhir1);

  sqL:= 'select ifnull(sum(d.quantity * d.price_purchase),0) from trs_shipment_mst t inner join trs_shipment_detail d on d.ship_id = t.ship_id and t.tipe = '+FormatSQLNumber(ITEM_TYPE_MUTASI_MASUK)+
  IfThen(filter <> '', ' where ' + copy(filter, 5, length(filter)));
  Result:= getFloatFromSQL(sqL);

end;

class function TReport.getPembelian: double;
var sqL, filter: string;
begin
  if GlobalPeriode.PeriodeAwal1 <> 0 then
    filter:= filter + ' and t.trans_date '+FormatSQLOperator(GlobalPeriode.OpPeriodeAwal1)+FormatSQLDate(GlobalPeriode.PeriodeAwal1);
  if GlobalPeriode.PeriodeAkhir1 <> 0 then
    filter:= filter + ' and t.trans_date '+FormatSQLOperator(GlobalPeriode.OpPeriodeAkhir1)+FormatSQLDate(GlobalPeriode.PeriodeAkhir1);

  sqL:= 'select ifnull(sum(subtotal+biaya+materai+tax),0) from trs_receipt_mst t '+
  IfThen(filter <> '', ' where ' + copy(filter, 5, length(filter)));
  Result:= getFloatFromSQL(sqL);
end;

class function TReport.getPembelianDisc: double;
var sqL, filter: string;
begin
  if GlobalPeriode.PeriodeAwal1 <> 0 then
    filter:= filter + ' and t.trans_date '+FormatSQLOperator(GlobalPeriode.OpPeriodeAwal1)+FormatSQLDate(GlobalPeriode.PeriodeAwal1);
  if GlobalPeriode.PeriodeAkhir1 <> 0 then
    filter:= filter + ' and t.trans_date '+FormatSQLOperator(GlobalPeriode.OpPeriodeAkhir1)+FormatSQLDate(GlobalPeriode.PeriodeAkhir1);

  sqL:= 'select ifnull(sum(disc_detail+disc_mst),0) from trs_receipt_mst t '+
  IfThen(filter <> '', ' where ' + copy(filter, 5, length(filter)));
  Result:= getFloatFromSQL(sqL);
end;

class function TReport.getPemakaian: double;
var sqL, filter: string;
begin
  if GlobalPeriode.PeriodeAwal1 <> 0 then
    filter:= filter + ' and t.trans_date '+FormatSQLOperator(GlobalPeriode.OpPeriodeAwal1)+FormatSQLDate(GlobalPeriode.PeriodeAwal1);
  if GlobalPeriode.PeriodeAkhir1 <> 0 then
    filter:= filter + ' and t.trans_date '+FormatSQLOperator(GlobalPeriode.OpPeriodeAkhir1)+FormatSQLDate(GlobalPeriode.PeriodeAkhir1);

  sqL:= 'select ifnull(sum(total),0) from trs_item_use_mst t '+
  IfThen(filter <> '', ' where ' + copy(filter, 5, length(filter)));
  Result:= getFloatFromSQL(sqL);
end;


class function TReport.getPembelianRetur: double;
var sqL, filter: string;
begin
  if GlobalPeriode.PeriodeAwal1 <> 0 then
    filter:= filter + ' and t.trans_date '+FormatSQLOperator(GlobalPeriode.OpPeriodeAwal1)+FormatSQLDate(GlobalPeriode.PeriodeAwal1);
  if GlobalPeriode.PeriodeAkhir1 <> 0 then
    filter:= filter + ' and t.trans_date '+FormatSQLOperator(GlobalPeriode.OpPeriodeAkhir1)+FormatSQLDate(GlobalPeriode.PeriodeAkhir1);

  sqL:= 'select ifnull(sum(total),0) from trs_retur_mst t '+
  IfThen(filter <> '', ' where ' + copy(filter, 5, length(filter)));
  Result:= getFloatFromSQL(sqL);
end;

class function TReport.getPendapatanSewa: double;
var sqL, filter: string;
begin
  if GlobalPeriode.PeriodeAwal1 <> 0 then
    filter:= ' and t.trans_date '+FormatSQLOperator(GlobalPeriode.OpPeriodeAwal1)+FormatSQLDate(GlobalPeriode.PeriodeAwal1);
  if GlobalPeriode.PeriodeAkhir1 <> 0 then
    filter:= filter + ' and t.trans_date '+FormatSQLOperator(GlobalPeriode.OpPeriodeAkhir1)+FormatSQLDate(GlobalPeriode.PeriodeAkhir1);

  sqL:=
  'select ifnull(sum(total),0) from trs_money_trans_mst t '+
  'where t.trans_type = '+FormatSQLNumber(1)+filter;
  Result:= getFloatFromSQL(sqL);
end;

class function TReport.getPenjualan(aTipe:integer): double;
var sqL, filter: string;
begin
  if GlobalPeriode.PeriodeAwal1 <> 0 then
    filter:= filter + ' and t.trans_date '+FormatSQLOperator(GlobalPeriode.OpPeriodeAwal1)+FormatSQLDate(GlobalPeriode.PeriodeAwal1);
  if GlobalPeriode.PeriodeAkhir1 <> 0 then
    filter:= filter + ' and t.trans_date '+FormatSQLOperator(GlobalPeriode.OpPeriodeAkhir1)+FormatSQLDate(GlobalPeriode.PeriodeAkhir1);
  case aTipe of
     0 : filter := filter + ' and (d.paket_id is null and (i.kategori = 0 or i.kategori is null)) '; //barang
     1 : filter := filter + ' and (d.paket_id is null and i.kategori = 1) '; //hewan
     2 : filter := filter + ' and (d.paket_id is not null ) '; //jasa
  end;
  sqL:=
  'select ifnull(sum(d.amount),0) '+
  'from trs_sales_mst t inner join trs_sales_detail d on d.sales_id = t.sales_id left join mst_item i on i.item_id = d.item_id '+
  'where t.trans_type = '+FormatSQLNumber(SALES_TYPE_POS)+' and d.quantity > 0 '+filter;
  Result:= getFloatFromSQL(sqL);
end;

class function TReport.getPenjualanDisc: double;
var sqL, filter: string; tmp: double;
begin
  if GlobalPeriode.PeriodeAwal1 <> 0 then
    filter:= filter + ' and t.trans_date '+FormatSQLOperator(GlobalPeriode.OpPeriodeAwal1)+FormatSQLDate(GlobalPeriode.PeriodeAwal1);
  if GlobalPeriode.PeriodeAkhir1 <> 0 then
    filter:= filter + ' and t.trans_date '+FormatSQLOperator(GlobalPeriode.OpPeriodeAkhir1)+FormatSQLDate(GlobalPeriode.PeriodeAkhir1);

  sqL:= //((d.quantity * d.price * disc) + disc_val)
  'select sum(disc_val_mst) '+//ifnull(sum((((d.quantity/d.conversion) * d.price * (disc/100)) + disc_val)),0) '+
  'from trs_sales_mst t, trs_sales_detail d '+
  'where d.sales_id = t.sales_id and d.quantity > 0 '+filter;
  tmp:= getFloatFromSQL(sqL);

  sqL:=
  'select ifnull(sum(((t.subtotal * (t.disc_mst/100)) + t.disc_val_mst)),0) '+
  'from trs_sales_mst t '+
  IfThen(filter <> '', ' where '+copy(filter, 5, length(filter)));

  tmp:= tmp + getFloatFromSQL(sqL);
  Result:= tmp;
end;

class function TReport.getPenjualanRetur: double;
var sqL, filter: string; 
begin
  if GlobalPeriode.PeriodeAwal1 <> 0 then
    filter:= filter + ' and t.trans_date '+FormatSQLOperator(GlobalPeriode.OpPeriodeAwal1)+FormatSQLDate(GlobalPeriode.PeriodeAwal1);
  if GlobalPeriode.PeriodeAkhir1 <> 0 then
    filter:= filter + ' and t.trans_date '+FormatSQLOperator(GlobalPeriode.OpPeriodeAkhir1)+FormatSQLDate(GlobalPeriode.PeriodeAkhir1);

  sqL:=
  'select ifnull(sum(d.amount),0) '+
  'from trs_sales_mst t, trs_sales_detail d '+
  'where d.sales_id = t.sales_id and  t.trans_type = '+FormatSQLNumber(SALES_TYPE_RETUR)+filter;//d.quantity < 0
  Result:= getFloatFromSQL(sqL);
end;

class function TReport.LoadBeliDiscTotal: double;
var fil: string;
begin
  fil:= ' where t.trans_date '+FormatSQLOperator(GlobalPeriode.OpPeriodeAwal1)+FormatSQLDate(GlobalPeriode.PeriodeAwal1);
  if GlobalFilter.StatusID <> 0 then
    fil:= fil + ' and t.relation_id ='+FormatSQLNumber(GlobalFilter.StatusID);
  if GlobalPeriode.PeriodeAkhir1 <> 0 then
    fil:= fil + ' and t.trans_date '+FormatSQLOperator(GlobalPeriode.OpPeriodeAkhir1)+FormatSQLDate(GlobalPeriode.PeriodeAkhir1);
  Result:= getFloatFromSQL('select sum(disc_mst) from trs_receipt_mst t '+fil);
end;

class function TReport.LoadBeliItem: TMysqlResult;
var sqL, fil: string;
begin
  if GlobalFilter.SpecID <> 0 then
    fil:= fil + ' and p.root_id ='+FormatSQLNumber(GlobalFilter.SpecID);
  if GlobalFilter.ItemID <> 0 then
    fil:= fil + ' and i.item_id ='+FormatSQLNumber(GlobalFilter.ItemID);
  if GlobalFilter.RelasiID <> 0 then
    fil:= fil + ' and i.vendor_id ='+FormatSQLNumber(GlobalFilter.RelasiID);
  if GlobalFilter.Numeric1 <> 0 then
    fil:= fil + ' and i.produsen_id ='+FormatSQLNumber(GlobalFilter.Numeric1);
  if GlobalFilter.StatusID <> 0 then
    fil:= fil + ' and t.relation_id ='+FormatSQLNumber(GlobalFilter.StatusID);

  if GlobalPeriode.PeriodeAwal1 <> 0 then
    fil:= fil + ' and t.trans_date '+FormatSQLOperator(GlobalPeriode.OpPeriodeAwal1)+FormatSQLDate(GlobalPeriode.PeriodeAwal1);
  if GlobalPeriode.PeriodeAkhir1 <> 0 then
    fil:= fil + ' and t.trans_date '+FormatSQLOperator(GlobalPeriode.OpPeriodeAkhir1)+FormatSQLDate(GlobalPeriode.PeriodeAkhir1);

  sqL:=
  'select distinct i.item_id, i.item_name as Nama, '+
   '(select u.mst_code from mst_item_conversion c, mst_master u  '+
    'where c.unit_id = u.mst_id and c.item_id = i.item_id and c.conversion = 1) as satuan,  '+
  'ifnull(sum(d.quantity),0) as qty '+
  'from trs_receipt_mst t, trs_receipt_detail d, mst_item i, point_maping p '+
  'where d.receipt_id = t.receipt_id and i.item_id = d.item_id '+
  'and i.specification = p.code_id '+fil+
  ' group by i.item_id  '+
  'order by qty, convert(i.barcode, SIGNED)';
  Result:= OpenSQL(sqL);
end;

class function TReport.LoadItemIddle: TMysqlResult;
var sqL, filter, filter2, order: string;
begin
  filter:= ' and p.root_id ='+FormatSQLNumber(GlobalFilter.SpecID);
  if GlobalFilter.RelasiID <> 0 then
    filter:= filter + ' and i.vendor_id ='+FormatSQLNumber(GlobalFilter.RelasiID);
  if GlobalFilter.Numeric1 <> 0 then
    filter:= filter + ' and i.produsen_id ='+FormatSQLNumber(GlobalFilter.Numeric1);

  if GlobalFilter.Name <> '' then
    filter:= filter + ' and i.item_name like '+FormatSQLString('%'+GlobalFilter.Name+'%');
  if GlobalFilter.FString1 <> '' then
    filter:= filter + ' and i.barcode = '+FormatSQLString(GlobalFilter.FString1);
  if GlobalFilter.FString2 <> '' then
    filter:= filter + ' and i.item_code = '+FormatSQLString(GlobalFilter.FString2);

  if GlobalFilter.Numeric4 <> 0 then
    filter:= filter + ' and i.kategori = '+FormatSQLNumber(GlobalFilter.Numeric4);

  filter2:= ' where t.sales_id = d.sales_id '+
  'and t.trans_date '+FormatSQLOperator(GlobalPeriode.OpPeriodeAwal1)+FormatSQLDate(GlobalPeriode.PeriodeAwal1);
  if GlobalPeriode.PeriodeAkhir1 <> 0 then
    filter2:= filter2 + ' and t.trans_date '+FormatSQLOperator(GlobalPeriode.OpPeriodeAkhir1)+FormatSQLDate(GlobalPeriode.PeriodeAkhir1);

  order:= ' order by i.item_name ';

  sqL:=
  'select distinct i.item_id, i.item_name, '+
  '(select relation_name from mst_relation where relation_id = i.vendor_id) as spl, '+
  '(select mst_name from mst_master where mst_id = i.produsen_id) as produsen, '+
  '0 as sum_qty '+

  'from point_maping p, mst_item i '+
  'where i.specification = p.code_id '+
  filter+' and i.item_id not in ('+
  'select distinct d.item_id from trs_sales_detail d, trs_sales_mst t '+filter2+') '+
  order;
  Result:= OpenSQL(sqL);

end;

class function TReport.LoadItemMovement: TMysqlResult;
var sqL, filter, having, limit, order: string;
begin
  filter:= ' where p.root_id ='+FormatSQLNumber(GlobalFilter.SpecID);
  if GlobalFilter.RelasiID <> 0 then
    filter:= filter + ' and i.vendor_id ='+FormatSQLNumber(GlobalFilter.RelasiID);
  if GlobalFilter.Numeric1 <> 0 then
    filter:= filter + ' and i.produsen_id ='+FormatSQLNumber(GlobalFilter.Numeric1);
  if GlobalFilter.Numeric4 <> 0 then
    filter:= filter + ' and i.kategori ='+FormatSQLNumber(GlobalFilter.Numeric4);

  if GlobalPeriode.PeriodeAwal1 <> 0 then
    filter:= filter + ' and t.trans_date '+FormatSQLOperator(GlobalPeriode.OpPeriodeAwal1)+FormatSQLDate(GlobalPeriode.PeriodeAwal1);
  if GlobalPeriode.PeriodeAkhir1 <> 0 then
    filter:= filter + ' and t.trans_date '+FormatSQLOperator(GlobalPeriode.OpPeriodeAkhir1)+FormatSQLDate(GlobalPeriode.PeriodeAkhir1);

  if GlobalFilter.TipeID <> '' then
    filter:= filter + ' and i.merk like '+FormatSQLString('%'+GlobalFilter.TipeID+'%');
  if GlobalFilter.Name <> '' then
    filter:= filter + ' and i.item_name like '+FormatSQLString('%'+GlobalFilter.Name+'%');
  if GlobalFilter.FString1 <> '' then
    filter:= filter + ' and i.barcode = '+FormatSQLString(GlobalFilter.FString1);
  if GlobalFilter.FString2 <> '' then
    filter:= filter + ' and i.item_code = '+FormatSQLString(GlobalFilter.FString2);
  if GlobalPeriode.RangeAwal <> -1 then
    having:= ' having (sum_qty '+FormatSQLOperator(GlobalPeriode.OpRangeAwal)+FormatSQLNumber(GlobalPeriode.RangeAwal) + ')';
  if GlobalPeriode.RangeAkhir <> 0 then begin
    Delete(having, length(having), 1);
    having:= having + ' and sum_qty '+FormatSQLOperator(GlobalPeriode.OpRangeAkhir)+FormatSQLNumber(GlobalPeriode.RangeAkhir) + ')';
  end;
  if (GlobalFilter.Numeric2 > 0) then
    limit:= ' limit '+FormatSQLNumber(GlobalFilter.Numeric2);

  if (GlobalFilter.StatusID = 0) then order:= ' order by sum_qty desc, i.item_name'
  else order:= ' order by sum_qty, i.item_name';

  sqL:=
  'select distinct i.item_id, i.item_name, '+
  '  c.code_name,merk,'+
//  '(select relation_name from mst_relation where relation_id = i.vendor_id) as spl, '+
  //'(select mst_name from mst_master where mst_id = i.produsen_id) as produsen, '+
  'ifnull(sum(t.quantity),0) as sum_qty, i.kemasan_id '+

  'from mst_item i inner join point_maping p on i.specification = p.code_id '+
  ' inner join vie_report_sales t on i.item_id = t.item_id left join mst_code c '+
  ' on i.specification = c.code_id '+
  //'where  and '+
  filter+ ' group by i.item_id ' + having + order + limit;
  Result:= OpenSQL(sqL);
end;

class function TReport.LoadJualDiscTotal: double;
var fil: string;
begin
  fil:= ' where t.trans_date '+FormatSQLOperator(GlobalPeriode.OpPeriodeAwal1)+FormatSQLDate(GlobalPeriode.PeriodeAwal1);
  if GlobalFilter.Numeric2 <> 0 then
    fil:= fil + ' and t.cashier_id ='+FormatSQLNumber(GlobalFilter.Numeric2);
  if GlobalFilter.SeriesID <> 0 then
    fil:= fil + ' and t.shift_id ='+FormatSQLNumber(GlobalFilter.SeriesID);
  if GlobalFilter.ItemID <> 0 then
    fil:= fil + ' and t.cashier_id ='+FormatSQLNumber(GlobalFilter.ItemID);
  if GlobalFilter.StatusID <> 0 then
    fil:= fil + ' and t.pasien_id ='+FormatSQLNumber(GlobalFilter.StatusID);
  if GlobalPeriode.PeriodeAkhir1 <> 0 then
    fil:= fil + ' and t.trans_date '+FormatSQLOperator(GlobalPeriode.OpPeriodeAkhir1)+FormatSQLDate(GlobalPeriode.PeriodeAkhir1);

  Result:= getFloatFromSQL(
  'select sum((t.subtotal * (t.disc_mst/100)) + t.disc_val_mst) as dis_tot '+
  'from trs_sales_mst t '+fil);
end;

class function TReport.LoadJualItem: TMysqlResult;
var sqL, fil: string;
begin
  if GlobalFilter.SpecID <> 0 then
    fil:= fil + ' and p.root_id ='+FormatSQLNumber(GlobalFilter.SpecID);
  if GlobalFilter.ItemID <> 0 then
    fil:= fil + ' and t.item_id ='+FormatSQLNumber(GlobalFilter.ItemID);
  if GlobalFilter.RelasiID <> 0 then
    fil:= fil + ' and i.vendor_id ='+FormatSQLNumber(GlobalFilter.RelasiID);
  if GlobalFilter.Numeric1 <> 0 then
    fil:= fil + ' and i.produsen_id ='+FormatSQLNumber(GlobalFilter.Numeric1);
  if GlobalFilter.Numeric2 <> 0 then
    fil:= fil + ' and t.cashier_id ='+FormatSQLNumber(GlobalFilter.Numeric2);
 if GlobalFilter.Numeric3 <> -1 then
    fil:= fil + ' and t.cara_bayar ='+FormatSQLNumber(GlobalFilter.Numeric3);
  if GlobalFilter.SeriesID <> 0 then
    fil:= fil + ' and t.shift_id ='+FormatSQLNumber(GlobalFilter.SeriesID);
  if GlobalFilter.StatusID <> 0 then
    fil:= fil + ' and t.relation_id ='+FormatSQLNumber(GlobalFilter.StatusID);
  if GlobalPeriode.PeriodeAwal1 <> 0 then
    fil:= fil + ' and t.trans_date '+FormatSQLOperator(GlobalPeriode.OpPeriodeAwal1)+FormatSQLDate(GlobalPeriode.PeriodeAwal1);
  if GlobalPeriode.PeriodeAkhir1 <> 0 then
    fil:= fil + ' and t.trans_date '+FormatSQLOperator(GlobalPeriode.OpPeriodeAkhir1)+FormatSQLDate(GlobalPeriode.PeriodeAkhir1);
  if GlobalFilter.Numeric4 <> 0 then
    fil:= fil + ' and i.kategori ='+FormatSQLNumber(GlobalFilter.Numeric4);

  sqL:=
  'select distinct i.item_id, i.item_name as Nama, '+
   '(select u.mst_code from mst_item_conversion c, mst_master u  '+
    'where c.unit_id = u.mst_id and c.item_id = i.item_id and c.conversion = 1) as satuan, '+
  'sum(amount_profit), '+
  'sum(if(t.quantity > 0, t.quantity, 0)) as qty_jual, '+
  'sum(if(t.quantity < 0, t.quantity, 0)) as qty_retur, '+
  'sum(if(t.quantity > 0, (t.amount/t.conversion), 0)) as amount_jual, '+
  'sum(if(t.quantity < 0, (t.amount/t.conversion), 0)) as amount_retur, '+
  'sum(if(t.quantity < 0, t.disc, 0)) as jml_disc '+

  'from vie_report_sales t, mst_item i, point_maping p '+
  'where t.item_id = i.item_id and i.specification = p.code_id '+fil+
  ' group by i.item_id order by Nama';
  Result:= OpenSQL(sqL);
end;

class function TReport.LoadKartuKas(ID: integer): TMysqlResult;
var sqL, fil: string;
begin

  fil:= ' and money_id ='+FormatSQLNumber(ID);
  if GlobalPeriode.PeriodeAwal1 <> 0 then
    fil:= fil + ' and t.trans_date '+FormatSQLOperator(GlobalPeriode.OpPeriodeAwal1)+FormatSQLDate(GlobalPeriode.PeriodeAwal1);
  if GlobalPeriode.PeriodeAkhir1 <> 0 then
    fil:= fil + ' and t.trans_date '+FormatSQLOperator(GlobalPeriode.OpPeriodeAkhir1)+FormatSQLDate(GlobalPeriode.PeriodeAkhir1);

  sqL:=
//  'select t.trans_date, sum(t.terima), '

  'select distinct t.trans_date, ''Penerimaan Kas'' as descr, sum(d.amount) as masuk,0 as keluar '+
  'from trs_money_trans_mst t, trs_money_trans_detail d '+
  'where d.money_trans_id = t.money_trans_id and t.trans_type = 1 '+ fil + ' group by t.trans_date' +
  ' UNION all '+
  'select distinct t.trans_date, ''Pengeluaran Kas'' as descr, 0 as masuk,sum(d.amount) as keluar '+
  'from trs_money_trans_mst t, trs_money_trans_detail d '+
  'where d.money_trans_id = t.money_trans_id and t.trans_type = 2 '+ fil + ' group by t.trans_date' +
  {' UNION all '+
  'select distinct t.trans_date, ''Jual'' as descr, sum(quantity) as qty '+
  'from vie_report_stock t '+
  'where quantity > 0 '+ fil +' group by t.trans_date' +
  ' UNION all '+
  'select distinct t.trans_date, ''Ret Beli'' as descr, sum(d.quantity) as qty '+
  'from trs_retur_mst t, trs_retur_detail d '+
  'where d.retur_id = t.retur_id '+ fil +' group by t.trans_date' +
  ' UNION all '+
  'select distinct t.trans_date, ''Opname'' as descr, sum(d.quantity) as qty '+
  'from trs_shipment_mst t, trs_shipment_detail d '+
  'where d.ship_id = t.ship_id and t.tipe ='+FormatSQLNumber(ITEM_TYPE_OPNAME)+ fil +
  ' group by t.trans_date' + }
  ' order by trans_date';
  
  Result:= OpenSQL(sqL);

end;

class function TReport.LoadKartuStock(ID: integer): TMysqlResult;
var sqL, fil: string;
begin

  fil:= ' and item_id ='+FormatSQLNumber(ID);
  if GlobalPeriode.PeriodeAwal1 <> 0 then
    fil:= fil + ' and t.trans_date '+FormatSQLOperator(GlobalPeriode.OpPeriodeAwal1)+FormatSQLDate(GlobalPeriode.PeriodeAwal1);
  if GlobalPeriode.PeriodeAkhir1 <> 0 then
    fil:= fil + ' and t.trans_date '+FormatSQLOperator(GlobalPeriode.OpPeriodeAkhir1)+FormatSQLDate(GlobalPeriode.PeriodeAkhir1);

  sqL:=
//  'select t.trans_date, sum(t.terima), '

  'select distinct t.trans_date, ''Receipt'' as descr, sum(d.quantity + qty_bonus) as qty '+
  'from trs_receipt_mst t, trs_receipt_detail d '+
  'where d.receipt_id = t.receipt_id '+ fil + ' group by t.trans_date' +
  ' UNION all '+
  'select distinct t.trans_date, ''Ret Jual'' as descr, sum(quantity) as qty '+
  'from vie_report_stock t '+
  'where quantity < 0 '+ fil +' group by t.trans_date' +
  ' UNION all '+
  'select distinct t.trans_date, ''Jual'' as descr, sum(quantity) as qty '+
  'from vie_report_stock t '+
  'where quantity > 0 '+ fil +' group by t.trans_date' +
  ' UNION all '+
  'select distinct t.trans_date, ''Ret Beli'' as descr, sum(d.quantity) as qty '+
  'from trs_retur_mst t, trs_retur_detail d '+
  'where d.retur_id = t.retur_id '+ fil +' group by t.trans_date' +
  ' UNION all '+
  'select distinct t.trans_date, ''Opname'' as descr, sum(d.quantity) as qty '+
  'from trs_shipment_mst t, trs_shipment_detail d '+
  'where d.ship_id = t.ship_id and t.tipe ='+FormatSQLNumber(ITEM_TYPE_OPNAME)+ fil +
  ' group by t.trans_date' +
  ' order by trans_date';
  
  Result:= OpenSQL(sqL);
end;

class function TReport.LoadMutasiPiutang: TMysqlResult;
var sqL, filter_trans, filter_pay: string;
begin
  filter_trans:= ' where t.pasien_id = r.pasien_id';
  if GlobalPeriode.PeriodeAwal1 <> 0 then
    filter_trans:= filter_trans + ' and t.trans_date '+FormatSQLOperator(GlobalPeriode.OpPeriodeAwal1)+FormatSQLDate(GlobalPeriode.PeriodeAwal1);
  if GlobalPeriode.PeriodeAkhir1 <> 0 then
    filter_trans:= filter_trans + ' and t.trans_date '+FormatSQLOperator(GlobalPeriode.OpPeriodeAkhir1)+FormatSQLDate(GlobalPeriode.PeriodeAkhir1);

  if GlobalFilter.Numeric1 <> 0 then
    filter_pay:= ' and t.tipe = '+FormatSQLNumber(GlobalFilter.Numeric1);

  sqL:=
  'select r.pasien_id, r.nama as ''Nama Pasien'', 0 as ''Saldo Awal'', '+
  '(select ifnull(sum(t.total),0) from trs_sales_mst t '+filter_trans+' and t.total > 0) as Pejualan, '+
  '(select abs(ifnull(sum(t.total),0)) from trs_sales_mst t '+filter_trans+' and t.total < 0) as Retur, '+
  '(select ifnull(sum(t.subtotal + t.discount),0) from trs_payment_mst t '+filter_trans+filter_pay+') as Pembayaran, '+
  '(select ifnull(sum(t.amount),0) from trs_debt_adjustment t '+filter_trans+') as Penyesuaian, '+
  '0 as ''Saldo Akhir'' '+
  'from mst_relation r where r.relation_type = '+FormatSQLNumber(RELASI_TYPE_CUSTOMER)+
  IfThen(GlobalFilter.RelasiID <> 0,
  ' and r.relation_id = '+FormatSQLNumber(GlobalFilter.RelasiID))+
  ' order by relation_name';
  Result:= OpenSQL(sqL);
end;

class function TReport.LoadMutasiStock(ID: integer): TMysqlResult;
var sqL, fil, fil_gudang, fil_gudang_asal, fil_gudang_tujuan: string;
begin
  if GlobalFilter.SeriesID <> 0 then
    fil_gudang:= ' and t.gudang_id ='+FormatSQLNumber(GlobalFilter.SeriesID);
  if GlobalFilter.SeriesID <> 0 then
    fil_gudang_tujuan:= ' and t.gudang_tujuan ='+FormatSQLNumber(GlobalFilter.SeriesID);
  if GlobalFilter.SeriesID <> 0 then
    fil_gudang_asal:= ' and t.gudang_asal ='+FormatSQLNumber(GlobalFilter.SeriesID);

  fil:= ' and item_id ='+FormatSQLNumber(ID);
  if GlobalPeriode.PeriodeAwal1 <> 0 then
    fil:= fil + ' and t.trans_date '+FormatSQLOperator(GlobalPeriode.OpPeriodeAwal1)+FormatSQLDate(GlobalPeriode.PeriodeAwal1);
  if GlobalPeriode.PeriodeAkhir1 <> 0 then
    fil:= fil + ' and t.trans_date '+FormatSQLOperator(GlobalPeriode.OpPeriodeAkhir1)+FormatSQLDate(GlobalPeriode.PeriodeAkhir1);

  sqL:=
  'select '+
  '(select ifnull(sum(d.quantity + qty_bonus),0) from trs_receipt_mst t, trs_receipt_detail d '+
  'where d.receipt_id = t.receipt_id '+ fil+fil_gudang+') as beli, '+

  '(select ifnull(sum(quantity),0) from vie_report_stock t '+
  'where quantity < 0 '+fil+fil_gudang+') as retur_dr, '+

  '(select ifnull(sum(d.quantity),0) from trs_shipment_mst t, trs_shipment_detail d '+
  'where d.ship_id = t.ship_id and t.tipe ='+FormatSQLNumber(ITEM_TYPE_MUTASI_MASUK)+fil+fil_gudang_tujuan+') as mutasi_dr, '+

//credit
 '(select ifnull(sum(quantity),0) from vie_report_stock t '+
  'where quantity > 0 '+fil + fil_gudang+') as jual, '+

  '(select ifnull(sum(d.quantity),0) from trs_retur_mst t, trs_retur_detail d '+
  'where d.retur_id = t.retur_id '+ fil + fil_gudang+') as retur_cr, '+

  '(select ifnull(sum(d.quantity),0) from trs_shipment_mst t, trs_shipment_detail d '+
  'where d.ship_id = t.ship_id and t.tipe ='+FormatSQLNumber(ITEM_TYPE_MUTASI_MASUK)+ fil + fil_gudang_asal+') as mutasi_cr, '+

//opname
 '(select ifnull(sum(d.quantity),0) from trs_shipment_mst t, trs_shipment_detail d '+
  'where d.ship_id = t.ship_id and t.tipe ='+FormatSQLNumber(ITEM_TYPE_OPNAME)+ fil + fil_gudang_asal+') as opname ';

  Result:= OpenSQL(sqL);
end;

class function TReport.LoadMutasiUtang(): TMysqlResult;
var sqL, filter_trans, filter_pay: string;
begin
  filter_trans:= ' where t.relation_id = r.relation_id';
  if GlobalFilter.Numeric1 <> 0 then
    filter_pay:= ' and t.tipe = '+FormatSQLNumber(GlobalFilter.Numeric1);
  if GlobalPeriode.PeriodeAwal1 <> 0 then
    filter_trans:= filter_trans + ' and t.trans_date '+FormatSQLOperator(GlobalPeriode.OpPeriodeAwal1)+FormatSQLDate(GlobalPeriode.PeriodeAwal1);
  if GlobalPeriode.PeriodeAkhir1 <> 0 then
    filter_trans:= filter_trans + ' and t.trans_date '+FormatSQLOperator(GlobalPeriode.OpPeriodeAkhir1)+FormatSQLDate(GlobalPeriode.PeriodeAkhir1);

  sqL:=
  'select r.relation_id, r.relation_name as ''Nama Supplier'', 0 as ''Saldo Awal'', '+
  '(select ifnull(sum(t.total),0) from trs_receipt_mst t '+filter_trans+') as Pembelian, '+
  '(select ifnull(sum(t.total),0) from trs_retur_mst t '+filter_trans+') as Retur, '+
  '(select ifnull(sum(t.subtotal + t.discount),0) from trs_payment_mst t '+filter_trans+filter_pay+') as Pembayaran, '+
  '(select ifnull(sum(t.amount),0) from trs_debt_adjustment t '+filter_trans+') as Penyesuaian, '+
  '0 as ''Saldo Akhir'' '+
  'from mst_relation r where r.relation_type = '+FormatSQLNumber(RELASI_TYPE_SUPPLIER)+
  IfThen(GlobalFilter.RelasiID <> 0,
  ' and r.relation_id = '+FormatSQLNumber(GlobalFilter.RelasiID))+
  ' order by relation_name';
  Result:= OpenSQL(sqL);
end;

class function TReport.LoadQtyBeli(ID: integer): TMysqlResult;
var sqL, fil: string;
begin
  fil:= ' and d.item_id ='+FormatSQLNumber(ID);
  if GlobalPeriode.PeriodeAwal1 <> 0 then
    fil:= fil + ' and t.trans_date '+FormatSQLOperator(GlobalPeriode.OpPeriodeAwal1)+FormatSQLDate(GlobalPeriode.PeriodeAwal1);
  if GlobalPeriode.PeriodeAkhir1 <> 0 then
    fil:= fil + ' and t.trans_date '+FormatSQLOperator(GlobalPeriode.OpPeriodeAkhir1)+FormatSQLDate(GlobalPeriode.PeriodeAkhir1);

  sqL:=
  'select ifnull(sum(d.quantity),0), ifnull(sum((d.quantity/d.conversion) * d.price),0), '+
  'ifnull(sum(disc1+disc2+disc3),0) as potongan '+
  'from trs_receipt_mst t, trs_receipt_detail d '+
  'where d.receipt_id = t.receipt_id '+fil;
  Result:= OpenSQL(sqL);
end;

class function TReport.LoadQtyJual(ID: integer): TMysqlResult;
var sqL, fil: string;
begin
  if GlobalPeriode.PeriodeAwal1 <> 0 then
    fil:= fil + ' and trans_date '+FormatSQLOperator(GlobalPeriode.OpPeriodeAwal1)+FormatSQLDate(GlobalPeriode.PeriodeAwal1);
  if GlobalPeriode.PeriodeAkhir1 <> 0 then
    fil:= fil + ' and trans_date '+FormatSQLOperator(GlobalPeriode.OpPeriodeAkhir1)+FormatSQLDate(GlobalPeriode.PeriodeAkhir1);
  if GlobalFilter.Numeric3 <> 0 then
    fil:= fil + ' and trans_type ='+FormatSQLNumber(GlobalFilter.Numeric3);
  sqL:=
  'select sum(quantity), sum(amount), sum(disc) '+
  'from vie_report_sales where quantity > 0 and item_id ='+FormatSQLNumber(ID)+fil;
  Result:= OpenSQL(sqL);
end;

class function TReport.LoadQtyRetur(ID: integer): TMysqlResult;
var sqL, fil: string;
begin
  fil:= ' and item_id ='+FormatSQLNumber(ID);
  if GlobalPeriode.PeriodeAwal1 <> 0 then
    fil:= fil + ' and trans_date '+FormatSQLOperator(GlobalPeriode.OpPeriodeAwal1)+FormatSQLDate(GlobalPeriode.PeriodeAwal1);
  if GlobalPeriode.PeriodeAkhir1 <> 0 then
    fil:= fil + ' and trans_date '+FormatSQLOperator(GlobalPeriode.OpPeriodeAkhir1)+FormatSQLDate(GlobalPeriode.PeriodeAkhir1);
  if GlobalFilter.Numeric3 <> 0 then
    fil:= fil + ' and trans_type ='+FormatSQLNumber(GlobalFilter.Numeric3);  
  sqL:=
  'select sum(quantity), sum(amount) '+
  'from vie_report_sales where quantity < 0 and item_id ='+FormatSQLNumber(ID)+fil;
  Result:= OpenSQL(sqL);
end;

class function TReport.LoadQtyReturBl(ID: integer): TMysqlResult;
var sqL, fil: string;
begin
  fil:= ' and d.item_id ='+FormatSQLNumber(ID);
  if GlobalPeriode.PeriodeAwal1 <> 0 then
    fil:= fil + ' and t.trans_date '+FormatSQLOperator(GlobalPeriode.OpPeriodeAwal1)+FormatSQLDate(GlobalPeriode.PeriodeAwal1);
  if GlobalPeriode.PeriodeAkhir1 <> 0 then
    fil:= fil + ' and t.trans_date '+FormatSQLOperator(GlobalPeriode.OpPeriodeAkhir1)+FormatSQLDate(GlobalPeriode.PeriodeAkhir1);

  sqL:=
  'select ifnull(sum(d.quantity),0), ifnull(sum((d.quantity/d.conversion) * d.price),0) '+
  'from trs_retur_mst t, trs_retur_detail d '+
  'where d.retur_id = t.retur_id '+fil;
  Result:= OpenSQL(sqL);
end;

class function TReport.LoadRekapItem: TMysqlResult;
var sqL, fil: string;
begin
  if GlobalFilter.SpecID <> 0 then
    fil:= fil + ' and p.root_id ='+FormatSQLNumber(GlobalFilter.SpecID);
  if GlobalFilter.RelasiID <> 0 then
    fil:= fil + ' and i.vendor_id ='+FormatSQLNumber(GlobalFilter.RelasiID);
  if GlobalFilter.Name <> '' then
    fil:= fil + ' and i.item_name like '+FormatSQLString('%'+GlobalFilter.Name+'%');
  if GlobalFilter.FString1 <> '' then
    fil:= fil + ' and i.barcode = '+FormatSQLString(GlobalFilter.FString1);

  sqL:=
  'select distinct i.item_id, i.item_name as Nama, '+
  '(select u.mst_code from mst_item_conversion c, mst_master u '+
   'where c.unit_id = u.mst_id and c.item_id = i.item_id and c.conversion = 1) as satuan '+
  'from mst_item i, point_maping p '+
  'where i.disabled_date is null and i.specification = p.code_id '+ fil+
  ' order by Nama';
  Result:= OpenSQL(sqL);
end;

class function TReport.LoadRekapItemSpeed: TMysqlResult;
var sqL, fil: string;
begin
  if GlobalFilter.SpecID <> 0 then
    fil:= fil + ' and p.root_id ='+FormatSQLNumber(GlobalFilter.SpecID);
  //if GlobalFilter.RelasiID <> 0 then
//    fil:= fil + ' and i.vendor_id ='+FormatSQLNumber(GlobalFilter.RelasiID);
  if GlobalFilter.Name <> '' then
    fil:= fil + ' and i.item_name like '+FormatSQLString('%'+GlobalFilter.Name+'%');
  if GlobalFilter.FString1 <> '' then
    fil:= fil + ' and i.item_code like '+FormatSQLString('%'+GlobalFilter.FString1+'%');
   if GlobalFilter.FString2 <> '' then
    fil:= fil + ' and i.merk like '+FormatSQLString('%'+GlobalFilter.FString2+'%');  

//  if GlobalPeriode.PeriodeAwal1 <> 0 then
  //  fil:= fil + ' and m.trans_date '+FormatSQLOperator(GlobalPeriode.OpPeriodeAwal1)+FormatSQLDate(GlobalPeriode.PeriodeAwal1);
//  if GlobalPeriode.PeriodeAkhir1 <> 0 then
//    fil:= fil + ' and m.trans_date '+FormatSQLOperator(GlobalPeriode.OpPeriodeAkhir1)+FormatSQLDate(GlobalPeriode.PeriodeAkhir1);

 // if GlobalFilter.SeriesID <> 0 then
  //  fil:= fil + ' and t.gudang_id ='+FormatSQLNumber(GlobalFilter.SeriesID);
 // fil := fil + ' and ';
  //if fil <> '' then
  //  fil := ' WHERE '+copy(fil,5,length(fil));
  sqL:=
  'select distinct i.item_id, i.item_name as Nama, '+
  '(select u.mst_code from  mst_master u '+
   'where i.unit_id = u.mst_id ) as satuan, '+

  'sum(if(t.qty_jual > 0, t.qty_jual, 0)) as jual, '+
  'sum(if(t.qty_jual < 0, t.qty_jual, 0)) as retur_jual, '+

  'sum(t.beli), sum(t.retur_beli), sum(t.opname), sum(t.mutasi_dr), sum(t.mutasi_cr) '+

  'from mst_item i, point_maping p, vie_mutasi_stock t '+
  'where i.disabled_date is null and i.specification = p.code_id and t.item_id = i.item_id '+ fil+
  ' group by item_id order by Nama';

  //new
  sqL :=  'select distinct item_id, item_name as Nama, '+
  'merk as Merk, '+
   ' sum(awal),sum(beli), sum(retur_beli),sum(mutasi_masuk),sum(mutasi_keluar),sum(pakai),sum(jual),sum(retur_jual),sum(opname),item_code '+
   ' FROM ('+
   //Saldo Awal
    'SELECT i.item_id, i.item_name,ifnull(balance,0) as awal,0 as beli, 0 as retur_beli, 0 as mutasi_masuk, 0 as mutasi_keluar, '+
    '0 as pakai,0 as jual, 0 as retur_jual, 0 as opname,kemasan_id,item_code,merk '+
  'from inv_item_balance b inner join mst_item i on b.item_id = i.item_id '+
     ' left join point_maping p on i.specification = p.code_id '+
  'where balance_date = (select max(balance_date) from inv_item_balance '+
  'where item_id = b.item_id and balance_date < '+FormatSQLDate(GlobalPeriode.PeriodeAwal1)+' ) '+fil+
   ' UNION ALL '+
   {'select ifnull(sum(balance),0) from inv_item_balance b1 '+
  'where balance_date = ('+
     'select max(b2.balance_date) from inv_item_balance b2 '+
     'where b2.balance_date < '+FormatSQLDate(vDate) + filter2 + ')' +filter1)}
   //PEMBELIAN
      ' SELECT i.item_id, i.item_name, 0 as awal,d.quantity as beli, 0 as retur_beli, 0 as mutasi_masuk, 0 as mutasi_keluar, '+
    '0 as pakai,0 as jual, 0 as retur_jual, 0 as opname,kemasan_id,item_code,merk '+
    ' FROM trs_receipt_mst m inner join trs_receipt_detail d on d.receipt_id = m.receipt_id '+
      ' inner join mst_item i on d.item_id = i.item_id '+
      ' left join point_maping p on i.specification = p.code_id '+
      ' WHERE status_id=1 and m.trans_date >= '+FormatSQLDate(GlobalPeriode.PeriodeAwal1)+
            ' and m.trans_date <= '+FormatSQLDate(GlobalPeriode.PeriodeAkhir1)+fil+
      ' UNION ALL '+
   //RETUR BELI
    ' SELECT i.item_id, i.item_name, 0 as awal,0 as beli, d.quantity as retur_beli, 0 as mutasi_masuk, 0 as mutasi_keluar, '+
    '0 as pakai,0 as jual, 0 as retur_jual, 0 as opname,kemasan_id ,item_code,merk '+
    ' FROM trs_retur_mst m inner join trs_retur_detail d on d.retur_id = m.retur_id '+
      ' inner join mst_item i on d.item_id = i.item_id '+
      ' left join point_maping p on i.specification = p.code_id '+
            ' WHERE status_id=1 and  m.trans_date >= '+FormatSQLDate(GlobalPeriode.PeriodeAwal1)+
            ' and m.trans_date <= '+FormatSQLDate(GlobalPeriode.PeriodeAkhir1)+fil+
      ' UNION ALL '+
   //MUTASI MASUK
   ' SELECT i.item_id, i.item_name, 0 as awal,0 as beli, 0 as retur_beli, d.quantity as mutasi_masuk, 0 as mutasi_keluar, '+
    '0 as pakai,0 as jual, 0 as retur_jual, 0 as opname,kemasan_id,item_code,merk '+
    ' FROM trs_shipment_mst m inner join trs_shipment_detail d on d.ship_id = m.ship_id '+
      ' inner join mst_item i on d.item_id = i.item_id '+
      ' left join point_maping p on i.specification = p.code_id '+
            ' WHERE tipe=2 and m.trans_date >= '+FormatSQLDate(GlobalPeriode.PeriodeAwal1)+
            ' and m.trans_date <= '+FormatSQLDate(GlobalPeriode.PeriodeAkhir1)+fil+
      ' UNION ALL '+
   //MUTSI keluar
   ' SELECT i.item_id, i.item_name, 0 as awal,0 as beli, 0 as retur_beli, 0 as mutasi_masuk, d.quantity as mutasi_keluar, '+
    ' 0 as pakai,0 as jual, 0 as retur_jual, 0 as opname,kemasan_id,item_code,merk '+
    ' FROM trs_shipment_mst m inner join trs_shipment_detail d on d.ship_id = m.ship_id '+
      ' inner join mst_item i on d.item_id = i.item_id '+
      ' left join point_maping p on i.specification = p.code_id '+
            ' WHERE  tipe=3 and m.trans_date >= '+FormatSQLDate(GlobalPeriode.PeriodeAwal1)+
            ' and m.trans_date <= '+FormatSQLDate(GlobalPeriode.PeriodeAkhir1)+fil+
      ' UNION ALL '+
       //pemakaian barang
   ' SELECT i.item_id, i.item_name, 0 as awal,0 as beli, 0 as retur_beli, 0 as mutasi_masuk, 0 as mutasi_keluar, '+
    'd.quantity as pakai,0 as jual, 0 as retur_jual, 0 as opname,kemasan_id,item_code,merk '+
    ' FROM trs_item_use_mst m inner join trs_item_use_detail d on d.item_use_id = m.item_use_id '+
      ' inner join mst_item i on d.item_id = i.item_id '+
      ' left join point_maping p on i.specification = p.code_id '+
            ' WHERE  m.trans_date >= '+FormatSQLDate(GlobalPeriode.PeriodeAwal1)+
            ' and m.trans_date <= '+FormatSQLDate(GlobalPeriode.PeriodeAkhir1)+fil+
      ' UNION ALL '+
   //jual
    ' SELECT i.item_id, i.item_name, 0 as awal,0 as beli, 0 as retur_beli, 0 as mutasi_masuk, 0 as mutasi_keluar, '+
    '0 as pakai,d.quantity as jual, 0 as retur_jual, 0 as opname,kemasan_id,item_code,merk '+
    ' FROM trs_sales_mst m inner join trs_sales_detail d on d.sales_id = m.sales_id '+
      ' inner join mst_item i on d.item_id = i.item_id '+
      ' left join point_maping p on i.specification = p.code_id '+
            ' WHERE trans_type = '+FormatSQLNumber(SALES_TYPE_POS)+' and m.trans_date >= '+FormatSQLDate(GlobalPeriode.PeriodeAwal1)+
            ' and m.trans_date <= '+FormatSQLDate(GlobalPeriode.PeriodeAkhir1)+fil+
      ' UNION ALL '+
   //retur jual
    ' SELECT i.item_id, i.item_name, 0 as awal,0 as beli, 0 as retur_beli, 0 as mutasi_masuk, 0 as mutasi_keluar, '+
    '0 as pakai,0 as jual, d.quantity as retur_jual, 0 as opname,kemasan_id,item_code,merk '+
    ' FROM trs_sales_mst m inner join trs_sales_detail d on d.sales_id = m.sales_id '+
      ' inner join mst_item i on d.item_id = i.item_id '+
      ' left join point_maping p on i.specification = p.code_id '+
            ' WHERE trans_type = '+FormatSQLNumber(SALES_TYPE_RETUR)+' and m.trans_date >= '+FormatSQLDate(GlobalPeriode.PeriodeAwal1)+
            ' and m.trans_date <= '+FormatSQLDate(GlobalPeriode.PeriodeAkhir1)+fil+
      ' UNION ALL '+
   //opname
   ' SELECT i.item_id, i.item_name, 0 as awal,0 as beli, 0 as retur_beli, 0 as mutasi_masuk, 0 as mutasi_keluar, '+
    '0 as pakai,0 as jual, 0 as retur_jual, d.quantity as opname,kemasan_id,item_code,merk '+
    ' FROM trs_shipment_mst m inner join trs_shipment_detail d on d.ship_id = m.ship_id '+
      ' inner join mst_item i on d.item_id = i.item_id '+
      ' left join point_maping p on i.specification = p.code_id '+
            ' WHERE  tipe=1 and m.trans_date >= '+FormatSQLDate(GlobalPeriode.PeriodeAwal1)+
            ' and m.trans_date <= '+FormatSQLDate(GlobalPeriode.PeriodeAkhir1)+fil+
   ') as t1  '+
   ' group by item_name, merk,item_code ';
  Result:= OpenSQL(sqL);
end;

class function TReport.LoadRekapKas: TMysqlResult;
var sqL, fil: string;
begin



  sqL:=
  'select distinct i.money_id, i.money_name,saldo '+
  'from mst_money i '+
//  'where  '+ fil+
  ' order by money_name ';
  Result:= OpenSQL(sqL);
end;

class function TReport.LoadRekapMoneySpeed: TMysqlResult;
var fil,sql:string;
begin
  if GlobalPeriode.PeriodeAwal1 <> 0 then
    fil:= fil + ' and m.trans_date '+FormatSQLOperator(GlobalPeriode.OpPeriodeAwal1)+FormatSQLDate(GlobalPeriode.PeriodeAwal1);
  if GlobalPeriode.PeriodeAkhir1 <> 0 then
    fil:= fil + ' and m.trans_date '+FormatSQLOperator(GlobalPeriode.OpPeriodeAkhir1)+FormatSQLDate(GlobalPeriode.PeriodeAkhir1);
  if fil <> '' then
    fil := ' WHERE '+copy(fil,5,length(fil));
 
  //new
  sqL :=  'select distinct money_id, money_name as Nama, '+
  '(select u.mst_code from  mst_master u '+
   'where kemasan_id = u.mst_id ) as satuan, '+
   ' sum(awal),sum(beli), sum(retur_beli),sum(mutasi_masuk),sum(mutasi_keluar),sum(jual),sum(retur_jual),sum(opname) '+
   ' FROM ('+
   //Saldo Awal
    'SELECT i.item_id, i.item_name,ifnull(balance,0) as awal,0 as beli, 0 as retur_beli, 0 as mutasi_masuk, 0 as mutasi_keluar, '+
    '0 as jual, 0 as retur_jual, 0 as opname,kemasan_id '+
  'from inv_item_balance b, mst_item i '+
  'where balance_date = (select max(balance_date) from inv_item_balance '+
  'where item_id = b.item_id and balance_date < '+FormatSQLDate(GlobalPeriode.PeriodeAwal1)+' ) '+
  'and b.item_id = i.item_id  '+
   ' UNION ALL '+
   {'select ifnull(sum(balance),0) from inv_item_balance b1 '+
  'where balance_date = ('+
     'select max(b2.balance_date) from inv_item_balance b2 '+
     'where b2.balance_date < '+FormatSQLDate(vDate) + filter2 + ')' +filter1)}
   //PEMBELIAN
      ' SELECT i.item_id, i.item_name, 0 as awal,d.quantity as beli, 0 as retur_beli, 0 as mutasi_masuk, 0 as mutasi_keluar, '+
    '0 as jual, 0 as retur_jual, 0 as opname,kemasan_id '+
    ' FROM trs_receipt_mst m inner join trs_receipt_detail d on d.receipt_id = m.receipt_id '+
      ' inner join mst_item i on d.item_id = i.item_id '+
      ' left join point_maping p on i.specification = p.code_id '+
      ' WHERE status_id=1 and m.trans_date >= '+FormatSQLDate(GlobalPeriode.PeriodeAwal1)+
            ' and m.trans_date <= '+FormatSQLDate(GlobalPeriode.PeriodeAkhir1)+fil+
      ' UNION ALL '+
   //RETUR BELI
    ' SELECT i.item_id, i.item_name, 0 as awal,0 as beli, d.quantity as retur_beli, 0 as mutasi_masuk, 0 as mutasi_keluar, '+
    '0 as jual, 0 as retur_jual, 0 as opname,kemasan_id '+
    ' FROM trs_retur_mst m inner join trs_retur_detail d on d.retur_id = m.retur_id '+
      ' inner join mst_item i on d.item_id = i.item_id '+
      ' left join point_maping p on i.specification = p.code_id '+
            ' WHERE status_id=1 and  m.trans_date >= '+FormatSQLDate(GlobalPeriode.PeriodeAwal1)+
            ' and m.trans_date <= '+FormatSQLDate(GlobalPeriode.PeriodeAkhir1)+fil+
      ' UNION ALL '+
   //MUTASI MASUK
   ' SELECT i.item_id, i.item_name, 0 as awal,0 as beli, 0 as retur_beli, d.quantity as mutasi_masuk, 0 as mutasi_keluar, '+
    '0 as jual, 0 as retur_jual, 0 as opname,kemasan_id '+
    ' FROM trs_shipment_mst m inner join trs_shipment_detail d on d.ship_id = m.ship_id '+
      ' inner join mst_item i on d.item_id = i.item_id '+
      ' left join point_maping p on i.specification = p.code_id '+
            ' WHERE tipe=2 and m.trans_date >= '+FormatSQLDate(GlobalPeriode.PeriodeAwal1)+
            ' and m.trans_date <= '+FormatSQLDate(GlobalPeriode.PeriodeAkhir1)+fil+
      ' UNION ALL '+
   //MUTSI keluar
   ' SELECT i.item_id, i.item_name, 0 as awal,0 as beli, 0 as retur_beli, 0 as mutasi_masuk, d.quantity as mutasi_keluar, '+
    '0 as jual, 0 as retur_jual, 0 as opname,kemasan_id '+
    ' FROM trs_shipment_mst m inner join trs_shipment_detail d on d.ship_id = m.ship_id '+
      ' inner join mst_item i on d.item_id = i.item_id '+
      ' left join point_maping p on i.specification = p.code_id '+
            ' WHERE  tipe=3 and m.trans_date >= '+FormatSQLDate(GlobalPeriode.PeriodeAwal1)+
            ' and m.trans_date <= '+FormatSQLDate(GlobalPeriode.PeriodeAkhir1)+fil+
      ' UNION ALL '+
   //jual
    ' SELECT i.item_id, i.item_name, 0 as awal,0 as beli, 0 as retur_beli, 0 as mutasi_masuk, 0 as mutasi_keluar, '+
    'd.quantity as jual, 0 as retur_jual, 0 as opname,kemasan_id '+
    ' FROM trs_sales_mst m inner join trs_sales_detail d on d.sales_id = m.sales_id '+
      ' inner join mst_item i on d.item_id = i.item_id '+
      ' left join point_maping p on i.specification = p.code_id '+
            ' WHERE m.trans_date >= '+FormatSQLDate(GlobalPeriode.PeriodeAwal1)+
            ' and m.trans_date <= '+FormatSQLDate(GlobalPeriode.PeriodeAkhir1)+fil+
      ' UNION ALL '+
   //retur jual
   //opname
   ' SELECT i.item_id, i.item_name, 0 as awal,0 as beli, 0 as retur_beli, 0 as mutasi_masuk, 0 as mutasi_keluar, '+
    '0 as jual, 0 as retur_jual, d.quantity as opname,kemasan_id '+
    ' FROM trs_shipment_mst m inner join trs_shipment_detail d on d.ship_id = m.ship_id '+
      ' inner join mst_item i on d.item_id = i.item_id '+
      ' left join point_maping p on i.specification = p.code_id '+
            ' WHERE  tipe=1 and m.trans_date >= '+FormatSQLDate(GlobalPeriode.PeriodeAwal1)+
            ' and m.trans_date <= '+FormatSQLDate(GlobalPeriode.PeriodeAkhir1)+fil+
   ') as t1  '+
   ' group by item_name, satuan';
  Result:= OpenSQL(sqL);

end;

class function TReport.LoadRekapStock: TMysqlResult;
var sqL, fil, stok: string;
begin
  if GlobalFilter.SeriesID <> 0 then //a.k.a. gudang  //+FormatSQLDate(GlobalPeriode.PeriodeAkhir1)+
    stok:= ' get_stock_akhir_gudang(i.item_id, '+IntToStr(GlobalFilter.SeriesID)+', curdate()) as Stok '
  else stok:= ' get_stock_akhir(i.item_id, curdate()) as Stok ';

  if GlobalFilter.SpecID <> 0 then
    fil:= fil + ' and p.root_id ='+FormatSQLNumber(GlobalFilter.SpecID);
  if GlobalFilter.Name <> '' then
    fil:= fil + ' and i.item_name like '+FormatSQLString('%'+GlobalFilter.Name+'%');
 if GlobalFilter.FString1 <> '' then
    fil:= fil + ' and i.item_code like '+FormatSQLString('%'+GlobalFilter.FString1+'%');
  if GlobalFilter.FString2 <> '' then
    fil:= fil + ' and i.merk like '+FormatSQLString('%'+GlobalFilter.FString2+'%');

  if GlobalFilter.RelasiID <> 0 then
    fil:= fil + ' and i.vendor_id ='+FormatSQLNumber(GlobalFilter.RelasiID);
  if GlobalPeriode.RangeAwal <> -1 then //a.k.a. gudang
    fil:= fil + ' having (Stok '+FormatSQLOperator(GlobalPeriode.OpRangeAwal)+FormatSQLNumber(GlobalPeriode.RangeAwal) + ')';
  if GlobalPeriode.RangeAkhir <> 0 then begin
    Delete(fil, length(fil), 1);
    fil:= fil + ' and Stok '+FormatSQLOperator(GlobalPeriode.OpRangeAkhir)+FormatSQLNumber(GlobalPeriode.RangeAkhir) + ')';
  end;

  sqL:=
  'select distinct i.item_id, i.item_code as ''Kode'', i.item_name as Nama,merk as Merk, '+stok+
  ',i.buying_price as ''Harga'', 0 as ''Nilai'' '+
  'from mst_item i, point_maping p '+
  'where i.disabled_date is null and i.specification = p.code_id '+ fil+
  ' order by item_name ';
  Result:= OpenSQL(sqL);
end;

class function TReport.LoadSalesRekap: TMysqlResult;
var sqL, fil: string;
begin
  if GlobalFilter.Numeric2 <> 0 then
    fil:= fil + ' and t.cashier_id ='+FormatSQLNumber(GlobalFilter.Numeric2);
  if GlobalFilter.Numeric1 <> -1 then
    fil:= fil + ' and t.cara_bayar ='+FormatSQLNumber(GlobalFilter.Numeric1);
  if GlobalFilter.SeriesID <> 0 then
    fil:= fil + ' and t.shift_id ='+FormatSQLNumber(GlobalFilter.SeriesID);
  if GlobalFilter.StatusID <> 0 then
    fil:= fil + ' and t.pasien_id ='+FormatSQLNumber(GlobalFilter.StatusID);
  if GlobalPeriode.PeriodeAwal1 <> 0 then
    fil:= fil + ' and t.trans_date '+FormatSQLOperator(GlobalPeriode.OpPeriodeAwal1)+FormatSQLDate(GlobalPeriode.PeriodeAwal1);
  if GlobalPeriode.PeriodeAkhir1 <> 0 then
    fil:= fil + ' and t.trans_date '+FormatSQLOperator(GlobalPeriode.OpPeriodeAkhir1)+FormatSQLDate(GlobalPeriode.PeriodeAkhir1);
  if fil <> '' then fil:= ' where ' + copy(fil, 5, length(fil));
  sqL:=
  'select sales_id, trans_date as Tgl, trans_num as ''No Trx'', '+
  '(select nama from mst_pasien r where r.pasien_id = t.pasien_id) as Pasien, '+
  'Subtotal, disc_mst as ''Discount %'',  disc_val_mst as ''Discount Rp'', t.Embalase, '+
  'Total, Profit '+
  'from trs_sales_mst t '+fil+' order by trans_date, trans_num';
  Result:= OpenSQL(sqL);
end;

class function TReport.LoadTglJual: TMysqlResult;
begin
  Result:= OpenSQL(
  'select distinct trans_date,cara_bayar from trs_sales_mst '+
  'where trans_date '+FormatSQLOperator(GlobalPeriode.OpPeriodeAwal1)+FormatSQLDate(GlobalPeriode.PeriodeAwal1)+
  IfThen(GlobalPeriode.PeriodeAkhir1 <> 0,
  ' and trans_date '+FormatSQLOperator(GlobalPeriode.OpPeriodeAkhir1)+FormatSQLDate(GlobalPeriode.PeriodeAkhir1))+
  IfThen(GlobalFilter.Numeric1 <> -1,
  ' and cara_bayar ='+FormatSQLNumber(GlobalFilter.Numeric1))+
  ' order by trans_date');
end;

class function TReport.LoadTglJualApotek: TMysqlResult;
var fil,sql: string;
begin
  fil:= ' and t.trans_date = '+FormatSQLDate(GlobalPeriode.PeriodeAwal1);
  if GlobalFilter.Numeric2 <> 0 then
    fil:= fil + ' and t.cashier_id ='+FormatSQLNumber(GlobalFilter.Numeric2);
  if GlobalFilter.SeriesID <> 0 then
    fil:= fil + ' and t.shift_id ='+FormatSQLNumber(GlobalFilter.SeriesID);
  if GlobalFilter.StatusID <> 0 then
    fil:= fil + ' and t.pasien_id ='+FormatSQLNumber(GlobalFilter.StatusID);

  if GlobalFilter.Numeric3 <> 0 then
    fil:= fil + ' and t.dokter_id ='+FormatSQLNumber(GlobalFilter.Numeric3);

   if GlobalFilter.FString1 <> '' then
    fil:= fil + ' and t.user_id ='+FormatSQLString(GlobalFilter.FString1);  
  if GlobalFilter.Numeric1 <> -1 then
    fil:= fil + ' and t.cara_bayar ='+FormatSQLNumber(GlobalFilter.Numeric1);

  sql := ' select sum(net),sum(embalase),sum(profit),sum(cust),sum(barang),sum(hewan),sum(jasa) from ( '+
    ' select sum(t.total - t.embalase+ ifnull(t.dp,0)) as net, sum(t.disc_val_mst) as embalase, sum(t.profit) as profit, count(*) as cust '+
    ', sum(d.amount) as barang, '+
    '0 as hewan, '+
  '  0  as jasa '+
      'from trs_sales_mst t inner join trs_sales_detail d on d.sales_id = t.sales_id inner join mst_item i on i.item_id = d.item_id where (i.kategori is null or i.kategori =0) and t.trans_type ='+FormatSQLNumber(SALES_TYPE_POS)+fil+
    ' union all '+
     ' select sum(t.total - t.embalase+ ifnull(t.dp,0)) as net, sum(t.disc_val_mst) as embalase, sum(t.profit) as profit, count(*) as cust '+
    ',0 as barang, '+
    ' sum(d.amount)  as hewan, '+
  '  0  as jasa '+
      'from trs_sales_mst t inner join trs_sales_detail d on d.sales_id = t.sales_id inner join mst_item i on i.item_id = d.item_id where i.kategori=1 and t.trans_type ='+FormatSQLNumber(SALES_TYPE_POS)+fil+
    ' union all '+
    ' select sum(t.total - t.embalase+ ifnull(t.dp,0)) as net, sum(t.disc_val_mst) as embalase, sum(t.profit) as profit, count(*) as cust '+
    ',0 as barang, '+
    '0 as hewan, '+
  ' sum(d.amount)  as jasa '+
      'from trs_sales_mst t inner join trs_sales_detail d on d.sales_id = t.sales_id left join mst_item i on i.item_id = d.item_id where d.paket_id is not null and t.trans_type ='+FormatSQLNumber(SALES_TYPE_POS)+fil+
    ' union all '+                                                        
'    select -1* sum(t.total - t.embalase+ ifnull(t.dp,0)) as net, -1* sum(t.disc_val_mst) as embalase, -1* sum(t.profit) as profit, count(*)  as cust '+
    ',case when d.paket_id is null and ifnull(i.kategori,0)=0 then sum(d.amount) else 0 end as barang, '+
    'case when d.paket_id is null and ifnull(i.kategori,0)=1 then sum(d.amount) else 0 end as hewan, '+
  ' case when d.item_id is null and paket_id is not null then sum(d.amount) else 0 end as jasa '+
      'from trs_sales_mst t inner join trs_sales_detail d on d.sales_id = t.sales_id left join mst_item i on i.item_id = d.item_id where t.trans_type ='+FormatSQLNumber(SALES_TYPE_RETUR)+fil+
      ' ) as t1';

    sql := ' select sum(net),sum(embalase),sum(profit),sum(cust),sum(barang),sum(hewan),sum(jasa),sum(barang_pokok),sum(hewan_pokok) from ( '+
    ' select sum(t.total - t.embalase+ ifnull(t.dp,0)) as net, sum(t.disc_val_mst) as embalase, sum(t.profit) as profit, count(*) as cust '+
    ', (select sum(d.amount) from trs_sales_mst t  inner join trs_sales_detail d on d.sales_id = t.sales_id  inner join mst_item i on i.item_id = d.item_id '+
    ' where t.trans_type ='+FormatSQLNumber(SALES_TYPE_POS)+fil+' and (i.kategori is null or i.kategori =0)) as barang, '+
    ' (select sum(d.amount) from trs_sales_mst t inner join trs_sales_detail d on d.sales_id = t.sales_id inner join mst_item i on i.item_id = d.item_id where i.kategori=1 and t.trans_type ='+FormatSQLNumber(SALES_TYPE_POS)+fil+') as hewan, '+
  '  ( select sum(d.amount) from trs_sales_mst t  inner join trs_sales_detail d on d.sales_id = t.sales_id left join mst_item i on i.item_id = d.item_id where d.paket_id is not null and t.trans_type ='+FormatSQLNumber(SALES_TYPE_POS)+fil+')  as jasa '+
      ', (select sum(d.hrg_beli * d.quantity) from trs_sales_mst t  inner join trs_sales_detail d on d.sales_id = t.sales_id  inner join mst_item i on i.item_id = d.item_id '+
    ' where t.trans_type ='+FormatSQLNumber(SALES_TYPE_POS)+fil+' and (i.kategori is null or i.kategori =0)) as barang_pokok, '+
    ' (select sum(d.hrg_beli * d.quantity) from trs_sales_mst t inner join trs_sales_detail d on d.sales_id = t.sales_id inner join mst_item i on i.item_id = d.item_id where i.kategori=1 and t.trans_type ='+FormatSQLNumber(SALES_TYPE_POS)+fil+') as hewan_pokok '+

      'from trs_sales_mst t where  t.trans_type ='+FormatSQLNumber(SALES_TYPE_POS)+fil+
    ' union all '+                                                        
'    select -1* sum(t.total - t.embalase+ ifnull(t.dp,0)) as net, -1* sum(t.disc_val_mst) as embalase, -1* sum(t.profit) as profit, count(*)  as cust '+
    ',case when d.paket_id is null and ifnull(i.kategori,0)=0 then sum(d.amount) else 0 end as barang, '+
    'case when d.paket_id is null and ifnull(i.kategori,0)=1 then sum(d.amount) else 0 end as hewan, '+
  ' case when d.item_id is null and paket_id is not null then sum(d.amount) else 0 end as jasa,0 as barang_pokok, 0 as hewan_pokok '+
      'from trs_sales_mst t inner join trs_sales_detail d on d.sales_id = t.sales_id left join mst_item i on i.item_id = d.item_id where t.trans_type ='+FormatSQLNumber(SALES_TYPE_RETUR)+fil+
      ' ) as t1';  
  Result:= OpenSQL(sql);


end;

class function TReport.LoadTglJualBulanKunjungan: TMysqlResult;
var fil: string;
begin
  fil:=
  ' where EXTRACT(YEAR_MONTH FROM t.trans_date) >= '+FormatSQLString(GlobalPeriode.YearMonth)+
  ' and EXTRACT(YEAR_MONTH FROM t.trans_date) <= '+FormatSQLString(GlobalPeriode.YearMonth2);
  if GlobalFilter.Numeric2 <> 0 then
    fil:= fil + ' and t.cashier_id ='+FormatSQLNumber(GlobalFilter.Numeric2);
  if GlobalFilter.SeriesID <> 0 then
    fil:= fil + ' and t.shift_id ='+FormatSQLNumber(GlobalFilter.SeriesID);
  if GlobalFilter.StatusID <> 0 then
    fil:= fil + ' and t.pasien_id ='+FormatSQLNumber(GlobalFilter.StatusID);
  if GlobalFilter.Numeric1 <> 0 then
    fil:= fil + ' and t.trans_type ='+FormatSQLNumber(GlobalFilter.Numeric1);

  Result:= OpenSQL(
  'select sum((t.subtotal + t.disc_detail) * (t.disc_mst/100) + t.disc_val_mst) as disc, count(*) '+
  'from trs_sales_mst t '+fil);
end;

class function TReport.LoadTglJualHistori: TMysqlResult;
var fil,sql: string;
begin
  if GlobalPeriode.PeriodeAwal1 <> 0 then
    fil:= fil + ' and t.trans_date '+FormatSQLOperator(GlobalPeriode.OpPeriodeAwal1)+FormatSQLDate(GlobalPeriode.PeriodeAwal1);
  if GlobalPeriode.PeriodeAkhir1 <> 0 then
    fil:= fil + ' and t.trans_date '+FormatSQLOperator(GlobalPeriode.OpPeriodeAkhir1)+FormatSQLDate(GlobalPeriode.PeriodeAkhir1);
  if GlobalFilter.Numeric2 <> 0 then
    fil:= fil + ' and t.cashier_id ='+FormatSQLNumber(GlobalFilter.Numeric2);
  if GlobalFilter.Numeric1 <> -1 then
    fil:= fil + ' and t.cara_bayar ='+FormatSQLNumber(GlobalFilter.Numeric1);
  if GlobalFilter.SeriesID <> 0 then
    fil:= fil + ' and t.shift_id ='+FormatSQLNumber(GlobalFilter.SeriesID);
  if GlobalFilter.StatusID <> 0 then
    fil:= fil + ' and t.pasien_id ='+FormatSQLNumber(GlobalFilter.StatusID);

  if GlobalFilter.Numeric3 <> 0 then
    fil:= fil + ' and t.dokter_id ='+FormatSQLNumber(GlobalFilter.Numeric3);

  if GlobalFilter.Name <> '' then
    fil:= fil + ' and t.trans_num ='+FormatSQLString(GlobalFilter.Name);
  if GlobalFilter.FString1 <> '' then
    fil:= fil + ' and t.user_id ='+FormatSQLString(GlobalFilter.FString1);

  if GlobalFilter.Numeric3 <> 0 then
    fil:= fil + ' and t.total <> t.real_amount ';

  sql :=  
  'select concat(t.trans_num,case when t.trans_type='+FormatSQLNumber(SALES_TYPE_RETUR)+' then ''(RETUR)'' else '''' end ) as trans_num, i.barcode, i.item_name, '+
  //'round(d.price / d.conversion) as price, (d.quantity * d.conversion) as quantity, '+
  'd.price, (d.quantity / d.conversion) as quantity, '+
  'u.mst_code, d.disc, d.disc_val, d.amount, '+
  't.trans_date, t.subtotal, t.disc_mst, t.disc_val_mst, t.embalase, (t.total+ifnull(t.dp,0)), d.sales_detail_id, (t.cash+ifnull(t.dp,0)), t.user_id,t.trans_type,t.cara_bayar '+
   ',d.hrg_beli '+
  'from trs_sales_detail d, trs_sales_mst t, mst_master u, mst_item i '+
  'where d.sales_id = t.sales_id and d.item_id is not null '+
  'and i.kemasan_id = u.mst_id and d.item_id = i.item_id '+fil+
  ' UNION all '+
  'select t.trans_num, i.service_code, i.service_name as item_name, '+
  //'round(d.price / d.conversion) as price, (d.quantity * d.conversion) as quantity, '+
  'd.price, (d.quantity / d.conversion) as quantity, '+
  ' '''', d.disc, d.disc_val, d.amount, '+
  't.trans_date, t.subtotal, t.disc_mst, t.disc_val_mst, t.embalase, (t.total+ifnull(t.dp,0)), d.sales_detail_id, (t.cash+ifnull(t.dp,0)), t.user_id,t.trans_type,t.cara_bayar '+
     ',d.hrg_beli '+
  'from trs_sales_detail d, trs_sales_mst t, mst_service i '+
  'where d.sales_id = t.sales_id  '+
  'and d.paket_id = i.service_id '+fil+
  ' order by trans_date, trans_num, sales_detail_id';
  Result:= OpenSQL(sql);
end;

class function TReport.LoadTglJualKunjungan: TMysqlResult;
var fil: string;
begin
  fil:= ' where t.trans_date = '+FormatSQLDate(GlobalPeriode.PeriodeAwal1);
  if GlobalFilter.Numeric2 <> 0 then
    fil:= fil + ' and t.cashier_id ='+FormatSQLNumber(GlobalFilter.Numeric2);
  if GlobalFilter.SeriesID <> 0 then
    fil:= fil + ' and t.shift_id ='+FormatSQLNumber(GlobalFilter.SeriesID);
  if GlobalFilter.StatusID <> 0 then
    fil:= fil + ' and t.pasien_id ='+FormatSQLNumber(GlobalFilter.StatusID);
  if GlobalFilter.Numeric1 <> 0 then
    fil:= fil + ' and t.trans_type ='+FormatSQLNumber(GlobalFilter.Numeric1);

  Result:= OpenSQL(
  'select sum((t.subtotal + t.disc_detail) * (t.disc_mst/100) + t.disc_val_mst) as disc, count(*) '+
  'from trs_sales_mst t '+fil);
end;

class function TReport.LoadTglJualNilai: TMysqlResult;
var fil: string;
begin
  fil:= ' and t.subtotal > 0 and t.trans_date = '+FormatSQLDate(GlobalPeriode.PeriodeAwal1);
  if GlobalFilter.Numeric2 <> 0 then
    fil:= fil + ' and t.cashier_id ='+FormatSQLNumber(GlobalFilter.Numeric2);
  if GlobalFilter.SeriesID <> 0 then
    fil:= fil + ' and t.shift_id ='+FormatSQLNumber(GlobalFilter.SeriesID);
  if GlobalFilter.ItemID <> 0 then
    fil:= fil + ' and t.cashier_id ='+FormatSQLNumber(GlobalFilter.ItemID);
  if GlobalFilter.StatusID <> 0 then
    fil:= fil + ' and t.pasien_id ='+FormatSQLNumber(GlobalFilter.StatusID);
  if GlobalFilter.Numeric1 <> 0 then
    fil:= fil + ' and t.trans_type ='+FormatSQLNumber(GlobalFilter.Numeric1);

  Result:= OpenSQL(
  'select sum(t.subtotal + t.disc_detail) as net, '+
  'sum((t.subtotal + t.disc_detail) * (t.disc_mst/100) + t.disc_val_mst) as disc, '+
  'sum(t.total), sum(t.real_amount), sum(t.profit), count(*) '+
  'from trs_sales_mst t '+fil);

  {Result:= OpenSQL(
  'select sum(subtotal + disc_detail) as net, '+
  'sum((subtotal + disc_detail) * (disc_mst/100) + disc_val_mst) as disc, '+
  'sum(total), sum(real_amount), sum(profit), count(*) '+
  'from trs_sales_mst t '+fil);

  'sum(d.amount), '+
  'sum(if(t.quantity > 0, t.quantity, 0)) as qty_jual, '+
  'sum(if(t.quantity < 0, t.quantity, 0)) as qty_retur, '+
  'sum(if(t.quantity > 0, (t.amount/t.conversion), 0)) as amount_jual, '+
  'sum(if(t.quantity < 0, (t.amount/t.conversion), 0)) as amount_retur, '+
  'sum(if(t.quantity < 0, t.disc, 0)) as jml_disc '+


  ((((d.quantity / d.conversion) * d.price) * (d.disc / 100)) - d.disc_val)

  //((((`d`.`quantity` / `d`.`conversion`) * `d`.`price`) * (`d`.`disc` / 100)) - `d`.`disc_val`)

   }
end;

class function TReport.LoadTglJualNilai2: TMysqlResult;
var fil: string;
begin
  fil:= ' and d.quantity > 0 and t.trans_date = '+FormatSQLDate(GlobalPeriode.PeriodeAwal1);
  if GlobalFilter.Numeric2 <> 0 then
    fil:= fil + ' and t.cashier_id ='+FormatSQLNumber(GlobalFilter.Numeric2);
  if GlobalFilter.SeriesID <> 0 then
    fil:= fil + ' and t.shift_id ='+FormatSQLNumber(GlobalFilter.SeriesID);
  if GlobalFilter.StatusID <> 0 then
    fil:= fil + ' and t.pasien_id ='+FormatSQLNumber(GlobalFilter.StatusID);
  if GlobalFilter.Numeric1 <> 0 then
    fil:= fil + ' and t.trans_type ='+FormatSQLNumber(GlobalFilter.Numeric1);

  Result:= OpenSQL(
  'select sum((d.quantity/d.conversion) * d.price) as net, '+
  'sum(((((d.quantity / d.conversion) * d.price) * (d.disc / 100)) - d.disc_val)) as disc, '+
  'sum(d.amount_profit) '+
  'from trs_sales_mst t, trs_sales_detail d where t.sales_id = d.sales_id '+fil);
end;

class function TReport.LoadTglJualNilaiBulan: TMysqlResult;
var fil: string;
begin
  fil:=
  ' where EXTRACT(YEAR_MONTH FROM t.trans_date) >= '+FormatSQLString(GlobalPeriode.YearMonth)+
  ' and EXTRACT(YEAR_MONTH FROM t.trans_date) <= '+FormatSQLString(GlobalPeriode.YearMonth2);

  if GlobalFilter.Numeric2 <> 0 then
    fil:= fil + ' and t.cashier_id ='+FormatSQLNumber(GlobalFilter.Numeric2);
  if GlobalFilter.SeriesID <> 0 then
    fil:= fil + ' and t.shift_id ='+FormatSQLNumber(GlobalFilter.SeriesID);
  if GlobalFilter.StatusID <> 0 then
    fil:= fil + ' and t.pasien_id ='+FormatSQLNumber(GlobalFilter.StatusID);
  if GlobalFilter.Numeric1 <> 0 then
    fil:= fil + ' and t.trans_type ='+FormatSQLNumber(GlobalFilter.Numeric1);

  Result:= OpenSQL(
  'select sum(subtotal + disc_detail) as net, '+
  'sum((subtotal + disc_detail) * (disc_mst/100) + disc_val_mst) as disc, '+
  'sum(total), sum(real_amount), sum(profit), count(*) '+
  'from trs_sales_mst t '+fil);
end;

class function TReport.LoadTglJualNilaiBulan2: TMysqlResult;
var fil: string;
begin
  fil:= ' and d.quantity > 0 '+
  ' and EXTRACT(YEAR_MONTH FROM t.trans_date) >= '+FormatSQLString(GlobalPeriode.YearMonth)+
  ' and EXTRACT(YEAR_MONTH FROM t.trans_date) <= '+FormatSQLString(GlobalPeriode.YearMonth2);

  if GlobalFilter.Numeric2 <> 0 then
    fil:= fil + ' and t.cashier_id ='+FormatSQLNumber(GlobalFilter.Numeric2);
  if GlobalFilter.SeriesID <> 0 then
    fil:= fil + ' and t.shift_id ='+FormatSQLNumber(GlobalFilter.SeriesID);
  if GlobalFilter.StatusID <> 0 then
    fil:= fil + ' and t.pasien_id ='+FormatSQLNumber(GlobalFilter.StatusID);
  if GlobalFilter.Numeric1 <> 0 then
    fil:= fil + ' and t.trans_type ='+FormatSQLNumber(GlobalFilter.Numeric1);

  Result:= OpenSQL(
  'select sum((d.quantity/d.conversion) * d.price) as net, '+
  'sum(((((d.quantity / d.conversion) * d.price) * (d.disc / 100)) - d.disc_val)) as disc, '+
  'sum(d.amount_profit) '+
  'from trs_sales_mst t, trs_sales_detail d where t.sales_id = d.sales_id '+fil);
end;

class function TReport.LoadTglJualNilaiBulanApotek: TMysqlResult;
var fil: string;
begin
  fil:=
  ' where EXTRACT(YEAR_MONTH FROM t.trans_date) >= '+FormatSQLString(GlobalPeriode.YearMonth)+
  ' and EXTRACT(YEAR_MONTH FROM t.trans_date) <= '+FormatSQLString(GlobalPeriode.YearMonth2);

  if GlobalFilter.Numeric2 <> 0 then
    fil:= fil + ' and t.cashier_id ='+FormatSQLNumber(GlobalFilter.Numeric2);
  if GlobalFilter.SeriesID <> 0 then
    fil:= fil + ' and t.shift_id ='+FormatSQLNumber(GlobalFilter.SeriesID);
  if GlobalFilter.StatusID <> 0 then
    fil:= fil + ' and t.pasien_id ='+FormatSQLNumber(GlobalFilter.StatusID);
  if GlobalFilter.Numeric1 <> -1 then
    fil:= fil + ' and t.cara_bayar ='+FormatSQLNumber(GlobalFilter.Numeric1);

  if GlobalFilter.Numeric3 <> 0 then
    fil:= fil + ' and t.dokter_id ='+FormatSQLNumber(GlobalFilter.Numeric3);

 if GlobalFilter.FString1 <> '' then
    fil:= fil + ' and t.user_id ='+FormatSQLString(GlobalFilter.FString1);

  Result:= OpenSQL(
  'select sum(t.total - t.embalase) as net, sum(t.disc_val_mst) as embalase, sum(t.profit) as profit, count(*) '+
  'from trs_sales_mst t '+fil);
end;

{ TTrsDebtAdjustment }

function TTrsDebtAdjustment.InsertOnDB: boolean;
begin
  try
    BeginSQL;
    ExecSQL(
    'insert into trs_debt_adjustment (trans_date, relation_id, amount, user_id) '+
    'values ('+
      FormatSQLDate(Transdate)+','+
      FormatSQLNumber(RelationId)+','+
      FormatSQLNumber(Amount)+','+
      FormatSQLString(UserId)+')');

    save_to_relation_balance(RelationId, TransDate, Amount, DB_CR_TYPE_DEBIT);

    EndSQL;
    Result:= True;
  except
    UndoSQL;
    Result:= False;
    Inform(MSG_UNSUCCESS_SAVING);
  end;
end;

{ TTrsMoneyTransaction }

constructor TTrsMoneyTransaction.Create;
begin
  inherited Create;
  trsDetail := _TrsMoneyTransDetail_Arr.Create();

end;

class function TTrsMoneyTransaction.DeleteTrans(ID: integer): boolean;
begin
   try
    BeginSQL;
    ExecSQL('delete from trs_money_transaction_detail where pay_detail_id = '+FormatSQLNumber(ID));
    EndSQL;
    Result:= True;
  except
    UndoSQL;
    Result:= False;
    Alert('Data tidak bisa dihapus.');
  end;
end;

destructor TTrsMoneyTransaction.Destroy;
begin
  trsDetail.Free;
  inherited;
end;

function TTrsMoneyTransaction.GetNewNumber: string;
var prefix: string;
begin
  prefix := IfThen(TransType=1,'UM','UK')+
            getPeriode3(TransDate);
  Result := prefix + getNextIDNumPeriode2('trans_num ','trs_money_trans_mst ', '', prefix, '', '',5);

end;

class function TTrsMoneyTransaction.getSaldoAwal(tgl: TDate;
  moneyId: integer): double;
var sql:string;
begin
  sql := 'select ifnull(balance,0) from mst_money_balance '+
    'where money_id = '+FormatSQLNumber(moneyId)+
    ' and balance_date = '+
       ' (select max(balance_date) from mst_money_balance '+
       ' where (balance_date) <= '+FormatSQLDate(tgl)+
       ' and money_id = '+FormatSQLNumber(moneyId)+')';
  Result := getFloatFromSQL(sql);
end;

function TTrsMoneyTransaction.InsertOnDB: boolean;
var i: integer; sqL: string;
begin
  if DEMO_VERSION then begin
    if getIntegerFromSQL('select count(*) from trs_money_trans_mst') > 100 then begin
      Result:= False;
      Inform('Maaf versi demo hanya untuk 100 transaksi.');
      Exit;
    end;
  end;

  try
    BeginSQL;

    TransNum:= GetNewNumber;
    sql:=
    'insert into trs_money_trans_mst ('+
    'trans_num, trans_date, trans_type, '+
    ' total, notes, insert_log) '+
    'values ('+
      FormatSQLString(TransNum)+','+
      FormatSQLDate(Transdate)+','+
      FormatSQLNumber(TransType)+','+
      FormatSQLNumber(Total)+','+
      FormatSQLString(Notes)+','+
      FormatSQLString(getSecurityLog)+')';
    ExecSQL(sql);

    MoneyTransID:= getIntegerFromSQL(
    'select money_trans_id from trs_money_trans_mst where trans_num = '+FormatSQLString(TransNum));


    for i:= 0 to trsDetail.Count-1 do  begin
        sql:=
        'insert into trs_money_trans_detail ('+
          'money_trans_id, description, amount,akun_id, money_id)'+
        'values ('+
          FormatSQLNumber(MoneyTransID)+','+
          FormatSQLString(trsDetail[i].Description)+','+
          FormatSQLNumber(trsDetail[i].Amount)+','+
          FormatSQLNumber(trsDetail[i].AkunID)+','+
          FormatSQLNumber(trsDetail[i].MoneyID)+')';
        ExecSQL(sql, False,sqL);
        save_money_balance(trsDetail[i].MoneyID,TransDate,trsDetail[i].Amount,IfThen(TransType=1,DB_CR_TYPE_DEBIT,DB_CR_TYPE_CREDIT));
    end;
    EndSQL;
    Result:= True;
  except
    UndoSQL;
    Result:= False;
    Inform(MSG_UNSUCCESS_SAVING);
  end;

end;

class function TTrsMoneyTransaction.LoadRekap: TMysqlResult;
var sqL,filter: string;
begin
  if GlobalPeriode.PeriodeAwal1 <> 0 then
    filter:= filter + ' and t.trans_date '+FormatSQLOperator(GlobalPeriode.OpPeriodeAwal1)+FormatSQLDate(GlobalPeriode.PeriodeAwal1);
  if GlobalPeriode.PeriodeAkhir1 <> 0 then
    filter:= filter + ' and t.trans_date '+FormatSQLOperator(GlobalPeriode.OpPeriodeAkhir1)+FormatSQLDate(GlobalPeriode.PeriodeAkhir1);
  if GlobalFilter.SeriesID <> 0 then
    filter:= filter + ' and t.trans_type = '+FormatSQLNumber(GlobalFilter.SeriesID);

  if (filter <> '') then filter:= ' where ' +Copy(filter, 5, length(filter));

  sqL:=
    'select distinct '+
      't.money_trans_id, t.trans_num as ''No Trx'', t.trans_date as ''Tanggal'', t.Total,t.notes as ''Keterangan'' '+
      ' ,case when trans_type = 1 then ''Penerimaan Kas'' else ''Pengeluaran Kas'' end as Tipe '+
    'from trs_money_trans_mst t '+filter;
  Result:= OpenSQL(sqL);

end;

procedure TTrsMoneyTransaction.Reset;
begin
  inherited;
  trsDetail.Clear;
end;

function TTrsMoneyTransaction.SelectDetail(ID: integer): TMysqlResult;
begin
  Result:= OpenSQL(
  'select description, amount,money_trans_detail_id, money_id,d.akun_id,a.nama  '+
  'from trs_money_trans_detail d left join mst_akun a on d.akun_id = a.akun_id '+
  'where money_trans_id = '+FormatSQLNumber(ID));
end;

function TTrsMoneyTransaction.SelectInDB: boolean;
var sqL: string; buffer: TMysqlResult; 
begin
  sqL:=
  'select money_trans_id, trans_type, trans_num, trans_date, insert_log, '+
  'total, notes '+
  'from trs_money_trans_mst '+
  'where money_trans_id = '+FormatSQLNumber(MoneyTransID);
  buffer:= OpenSQL(sqL);
  Reset;
  Result:= buffer.RecordCount > 0;
  if Result then begin
    MoneyTransID := BufferToInteger(buffer.FieldValue(0));
    TransType  := BufferToInteger(buffer.FieldValue(1));
    TransNum   := BufferToString(buffer.FieldValue(2));
    TransDate  := BufferToDateTime(buffer.FieldValue(3));
    InsertLog     := BufferToString(buffer.FieldValue(4));
    Total := BufferToFloat(buffer.FieldValue(5));
    Notes := BufferToString(buffer.FieldValue(6));
  end;
  buffer.Destroy;

end;

function TTrsMoneyTransaction.UpdateOnDB: boolean;
var i: integer; sqL: string;
begin
  try
    BeginSQL;
    sql:=
    'update trs_money_trans_mst set '+
    'trans_date = '+FormatSQLDate(Transdate)+','+
    'total = '+FormatSQLNumber(Total)+','+
    'notes = '+FormatSQLString(Notes)+','+
    'insert_log = '+FormatSQLString(getSecurityLog)+
    'where money_trans_id = '+FormatSQLNumber(FMoneyTransID);
    ExecSQL(sql);

    for i:= 0 to trsDetail.Count-1 do
      if trsDetail[i].MoneyTransDetailID = 0 then begin
        sql:=
        'insert into trs_money_trans_detail ('+
          'money_trans_id, money_id,description,akun_id, amount)'+
        'values ('+
          FormatSQLNumber(MoneyTransID)+','+
          FormatSQLNumber(trsDetail[i].MoneyID)+','+
          FormatSQLString(trsDetail[i].Description)+','+
          FormatSQLNumber(trsDetail[i].AkunID)+','+
          FormatSQLNumber(trsDetail[i].Amount)+')';

        ExecSQL(sql, False, sqL);
      end
      else
        ExecSQL(
        'update trs_money_trans_detail set '+
        'money_id = '+FormatSQLNumber(trsDetail[i].MoneyID)+','+
        'akun_id = '+FormatSQLNumber(trsDetail[i].AkunID)+','+
        'amount = '+FormatSQLNumber(trsDetail[i].Amount)+
        ' where money_trans_detail_id = '+FormatSQLNumber(trsDetail[i].MoneyTransDetailID));

    EndSQL;
    Result:= True;
  except
    UndoSQL;
    Result:= False;
    Inform(MSG_UNSUCCESS_SAVING);
  end;

end;

{ TTrsItemUse }

constructor TTrsItemUse.Create;
begin
  inherited create;
  trsDetail := _TrsItemUseDetail_Arr.Create(Self);
end;

class function TTrsItemUse.DeleteTrans(ID: integer): boolean;
begin
    Result := ExecuteSQL('delete from trs_item_use_mst where item_use_id ='+FormatSQLNumber(ID));
end;

destructor TTrsItemUse.Destroy;
begin
  trsDetail.Free;
  inherited;
end;

function TTrsItemUse.GetNewNumber: string;
   var prefix: string;
begin
  prefix := IfThen(Tipe=1,'PB','UK')+
            getPeriode3(TransDate);
  Result := prefix + getNextIDNumPeriode2('trans_num ','trs_item_use_mst ', '', prefix, '', '',5);

end;

function TTrsItemUse.InsertOnDB: boolean;
var i: integer; sqL: string;
begin
  if DEMO_VERSION then begin
    if getIntegerFromSQL('select count(*) from trs_item_use_mst') > 100 then begin
      Result:= False;
      Inform('Maaf versi demo hanya untuk 100 transaksi.');
      Exit;
    end;
  end;

  try
    BeginSQL;

    TransNum:= GetNewNumber;
    sql:=
    'insert into trs_item_use_mst ('+
    'trans_num, trans_date, tipe, '+
    ' notes, total,insert_log) '+
    'values ('+
      FormatSQLString(TransNum)+','+
      FormatSQLDate(Transdate)+','+
      FormatSQLNumber(Tipe)+','+
      FormatSQLString(Notes)+','+
      FormatSQLNumber(Total)+','+
      FormatSQLString(getSecurityLog)+')';
    ExecSQL(sql);

    ItemUseID:= getIntegerFromSQL(
    'select item_use_id from trs_item_use_mst where trans_num = '+FormatSQLString(TransNum));


    for i:= 0 to trsDetail.Count-1 do  begin
        sql:=
        'insert into trs_item_use_detail ('+
          'item_use_id, item_id,quantity,buying_price,amount)'+
        'values ('+
          FormatSQLNumber(ItemUseID)+','+
          FormatSQLNumber(trsDetail[i].ItemID)+','+
          FormatSQLNumber(trsDetail[i].Quantity)+','+
          FormatSQLNumber(trsDetail[i].buyingPrice)+','+
          FormatSQLNumber(trsDetail[i].Amount)+')';
        ExecSQL(sql, False,sqL);
        save_balance(CENTRAL_BOARD,
        trsDetail[i].ItemID,TransDate,trsDetail[i].Quantity,trsDetail[i].BuyingPrice,DB_CR_TYPE_CREDIT);
    end;
    EndSQL;
    Result:= True;
  except
    UndoSQL;
    Result:= False;
    Inform(MSG_UNSUCCESS_SAVING);
  end;

end;

class function TTrsItemUse.LoadRekap: TMysqlResult;
var sqL,filter: string;
begin
  if GlobalPeriode.PeriodeAwal1 <> 0 then
    filter:= filter + ' and t.trans_date '+FormatSQLOperator(GlobalPeriode.OpPeriodeAwal1)+FormatSQLDate(GlobalPeriode.PeriodeAwal1);
  if GlobalPeriode.PeriodeAkhir1 <> 0 then
    filter:= filter + ' and t.trans_date '+FormatSQLOperator(GlobalPeriode.OpPeriodeAkhir1)+FormatSQLDate(GlobalPeriode.PeriodeAkhir1);
//  if GlobalFilter.SeriesID <> 0 then
  //  filter:= filter + ' and t.trans_type = '+FormatSQLNumber(GlobalFilter.SeriesID);

  if (filter <> '') then filter:= ' where ' +Copy(filter, 5, length(filter));

  sqL:=
    'select distinct '+
      't.item_use_id, t.trans_num as ''No Trx'', t.trans_date as ''Tanggal'',t.notes as ''Keterangan'' '+
    'from trs_item_use_mst t '+filter;
  Result:= OpenSQL(sqL);


end;

procedure TTrsItemUse.Reset;
begin
  inherited;
  trsDetail.Clear;
end;

function TTrsItemUse.SelectDetail(ID: integer): TMysqlResult;
begin
  Result:= OpenSQL(
  'select item_use_detail_id,d.item_id,d.quantity, d.buying_price,d.amount,i.item_code,i.item_name, i.merk, i.barcode  '+
  'from trs_item_use_detail d left join mst_item i on d.item_id = i.item_id '+
  'where item_use_id = '+FormatSQLNumber(ID));

end;

function TTrsItemUse.SelectInDB: boolean;
var sqL: string; buffer: TMysqlResult; 
begin
  sqL:=
  'select item_use_id, tipe, trans_num, trans_date, insert_log, '+
  'notes,total '+
  'from trs_item_use_mst '+
  'where item_use_id = '+FormatSQLNumber(ItemUseID);
  buffer:= OpenSQL(sqL);
  Reset;
  Result:= buffer.RecordCount > 0;
  if Result then begin
    ItemUseID := BufferToInteger(buffer.FieldValue(0));
    Tipe  := BufferToInteger(buffer.FieldValue(1));
    TransNum   := BufferToString(buffer.FieldValue(2));
    TransDate  := BufferToDateTime(buffer.FieldValue(3));
    InsertLog     := BufferToString(buffer.FieldValue(4));
    Notes := BufferToString(buffer.FieldValue(5));
    Total := BufferToFloat(buffer.FieldValue(6));
  end;
  buffer.Destroy;


end;

function TTrsItemUse.UpdateOnDB: boolean;
begin

end;

end.
