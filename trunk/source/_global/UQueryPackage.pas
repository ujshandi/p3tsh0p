unit UQueryPackage;

interface

uses
  Classes, Controls, SysUtils, Subroutines, Math, StrUtils,
  UConstTool, uMysqlClient;


{
jumlah	harga	harga dasar ((harga*jumlah)/jumlah)
100	10	10
100	15	12.5
100	20

select round((10*100) + (15*100) + (20*100))/300
select round((12.5*200) + (20*100))/300}

{=============================>> STOCK MANAGEMET <<=============================}
//update / insert item balance WITH storage
  procedure save_to_balance_stroge (AStorageId, AItemID: integer;
    ADate: TDate; AQuantity, APrice: double; ADbCrType: string);

  function update_avg_price (AItemID: integer; AQuantity, APrice: double): string;

//update / insert item balance WITHOUT storage
//  procedure save_to_balance (AItemID: integer;
//    ADate: TDate; AQuantity, APrice: double; ADbCrType: string);


//update / insert item balance
  procedure save_balance (AStorageId, AItemID: integer;
    ADate: TDate; AQuantity, APrice: double; ADbCrType: string);

  procedure save_balance_opname (AStorageId, AItemID: integer;
    ADate: TDate; AQuantity, APrice: double; ADbCrType: string);

  procedure save_money_balance (AMoneyID: integer;
    ADate: TDate; AMount: double; ADbCrType: string);

//  procedure new_save_to_balance (AItemID: integer; AQuantity: double; ADbCrType: string);

//update / insert current balance
  procedure save_current_stock(AItemID: integer; AQuantity: double; ADbCrType: string);
  procedure save_current_money(AMoneyID: integer; Amount: double; ADbCrType: string);

  procedure update_price (AConvID: integer; ASales, APurchase, ACost: double);
  procedure update_master_price (AConvID: integer; ASales, APurchase, ACost: double);

  procedure save_to_cashier (ACashID, AJenisBayar: integer;
    ASales, ADisc, ARetur, AEmbalase: double; ADbCrType: string);

  function close_cashier_balance(): boolean;

  procedure save_to_relation_balance(ARealtionID: integer; ADate: TDate; AValue: double; ADbCrType: string);
  procedure save_current_debt(ARealtionID: integer; AValue: double; ADbCrType: string);
  procedure save_to_relation_point(ARealtionID: integer; AValue: integer; ADbCrType: string);

{=============================>> PRICE MANAGEMET <<=============================}
  function cari_setting_harga_kelipatan(AItemID, AConvID: integer; AQty: double): double;
  function cari_setting_harga_discount(var Atipe: integer; AItemID: integer; AQty: double): double;

  procedure save_balace_paket(APaketID: integer; AValue: double; ADbCrType: string);

{=============================>> PRODUK SERVICE MANAGEMET <<=============================}

{privat}
  function produk_hjual_used(v_prod_id, v_item_id: integer;
    v_new_qty: double): double;
  

  procedure produk_discount_item(v_prod_id, v_item_id, v_qty: integer;
    var v_amount, v_new_dis_persen, v_new_dis_rp: double);

  procedure produk_discount_total(v_prod_id: integer;
    var v_amount, v_new_dis_persen, v_new_dis_rp: double);

  procedure produk_point_item(var cur_point: integer;
    v_prod_id, v_item_id, v_relasi_id, v_qty, v_amount: integer);

  procedure produk_point_total(var cur_point: integer;
    v_prod_id, v_relasi_id, v_amount: integer);

  function isexist_produk(): boolean;
  function revoke_produk(AItemID: integer): double;

{public}

  function appllied_produk(AJnsCust, AItemID, ACustID: integer; AQty: double;
    var ANewHJual, ANewDisc, ANewDiscRp: double; var ACurPoint: integer): boolean;

  function appllied_produk_total(AJnsCust, ACustID: integer; AAmount: double;
    var ANewDisc, ANewDiscRp: double; var ACurPoint: integer): boolean;

implementation

uses UConst, MySQLConnector;

  procedure save_to_balance_stroge (AStorageId, AItemID: integer;
    ADate: TDate; AQuantity, APrice: double; ADbCrType: string);
  var db_quantity, cr_quantity, lates_balance: double;

    function is_exist_balance (vStorageId, vItemID: integer; vDate: TDate): boolean;
    begin
      Result:= getIntegerFromSQL(
        'select count(*) from inv_item_balance where item_id = '+FormatSQLNumber(vItemID)+
        ' and storage_id = '+FormatSQLNumber(vStorageId)+
        ' and balance_date = '+FormatSQLDate(vDate)) <> 0;
    end;

    function get_latest_stock (vStorageId, vItemID: integer; vDate: TDate): double;
    begin
      Result:= getFloatFromSQL(
        'select balance from inv_item_balance where item_id = '+FormatSQLNumber(vItemID)+
        ' and storage_id = '+FormatSQLNumber(vStorageId)+
        ' and balance_date = '+
          '(select max(balance_date) from inv_item_balance '+
          'where balance_date <= '+FormatSQLDate(vDate)+
          ' and item_id = '+FormatSQLNumber(vItemID)+
          ' and storage_id = '+FormatSQLNumber(vStorageId)+')');
    end;

    procedure update_balance(vStorageId, vItemID: integer; vDate: TDate);
    var i: integer; buffer: TMysqlResult;
    begin
      buffer:= OpenSQL(
        'select balance_date '+
        'from inv_item_balance where item_id = '+FormatSQLNumber(vItemID)+
        ' and storage_id = '+FormatSQLNumber(vStorageId)+
        ' and balance_date >= '+FormatSQLDate(vDate));

      for i:= 0 to buffer.RecordCount -1 do begin
        ExecSQL(
          'update inv_item_balance '+
          'set balance = balance + '+FormatSQLNumber(db_quantity - cr_quantity)+
          ' where balance_date = '+ FormatSQLDate(BufferToDateTime(buffer.FieldValue(0)))+
          ' and item_id = '+FormatSQLNumber(vItemID)+
          ' and storage_id = '+FormatSQLNumber(vStorageId), False);
        buffer.MoveNext;
      end;
      buffer.Destroy;
    end;

    procedure insert_balance(vBalance: double);
    var sql: string;
    begin
      ExecSQL(
      'insert into inv_item_balance (item_id, balance_date, balance, storage_id) '+
      'values ('+
        FormatSQLNumber(AItemID)+', '+
        FormatSQLDate(ADate)+', '+
        FormatSQLNumber(vbalance + db_quantity - cr_quantity)+', '+
        FormatSQLNumber(AStorageId)+')', False);
    end;
  begin

    //initialisai
    db_quantity:= 0; cr_quantity:= 0;

    //set quatity value ...
    if (ADbCrType = DB_CR_TYPE_DEBIT) then
      db_quantity := AQuantity
    else cr_quantity :=  AQuantity;

    if not is_exist_balance(AStorageId, AItemID, ADate) then begin

      //insert stock
      lates_balance:= get_latest_stock(AStorageId, AItemID, ADate);
      insert_balance(lates_balance);

      //update next stock
      update_balance(AStorageId, AItemID, ADate+1);

    end else

    //update next stock
      update_balance(AStorageId, AItemID, ADate);

    LogSQL(
      'call save_to_item_balance('+
      IntToStr(AStorageId)+', '+
      IntToStr(AItemID)+', '+
      FormatSQLDate(ADate)+', '+
      FormatSQLNumber(AQuantity)+', '+
      FormatSQLString(ADbCrType)+')');

  end;
//------------------------------------------------------------------------------

{  procedure save_to_balance (AItemID: integer;
    ADate: TDate; AQuantity, APrice: double; ADbCrType: string);
  var db_quantity, cr_quantity, lates_balance: double;

    function is_exist_balance (vItemID: integer; vDate: TDate): boolean;
    begin
      Result:= getIntegerFromSQL(
        'select count(*) from inv_item_balance where item_id = '+FormatSQLNumber(vItemID)+
        ' and balance_date = '+FormatSQLDate(vDate)) <> 0;
    end;

    function get_latest_stock (vItemID: integer; vDate: TDate): double;
    begin
      Result:= getFloatFromSQL(
        'select balance from inv_item_balance where item_id = '+FormatSQLNumber(vItemID)+
        ' and balance_date = '+
          '(select max(balance_date) from inv_item_balance '+
          'where balance_date <= '+FormatSQLDate(vDate)+
          ' and item_id = '+FormatSQLNumber(vItemID)+')');
    end;

    procedure update_balance(vItemID: integer; vDate: TDate);
    var i: integer; buffer: TMysqlResult;
    begin
      buffer:= OpenSQL(
        'select balance_date '+
        'from inv_item_balance where item_id = '+FormatSQLNumber(vItemID)+
        ' and balance_date >= '+FormatSQLDate(vDate));

      for i:= 0 to buffer.RecordCount -1 do begin
        ExecSQL(
          'update inv_item_balance '+
          'set balance = balance + '+FormatSQLNumber(db_quantity - cr_quantity)+
          ' where balance_date = '+ FormatSQLDate(BufferToDateTime(buffer.FieldValue(0)))+
          ' and item_id = '+FormatSQLNumber(vItemID));
        buffer.MoveNext;
      end;
      buffer.Destroy;
    end;

    procedure insert_balance(vBalance: double);
    begin
      ExecSQL(
        'insert into inv_item_balance (item_id, balance_date, balance) '+
        'values ('+
        FormatSQLNumber(AItemID)+', '+
        FormatSQLDate(ADate)+', '+
        FormatSQLNumber(vbalance + db_quantity - cr_quantity)+')');
    end;

  begin
    //main procedure here...

    //initialisai
    db_quantity:= 0; cr_quantity:= 0;

    //set quatity value ...
    if (ADbCrType = DB_CR_TYPE_DEBIT) then
      db_quantity := AQuantity
    else cr_quantity :=  AQuantity;

    if not is_exist_balance(AItemID, ADate) then begin

      //insert stock
      lates_balance:= get_latest_stock(AItemID, ADate);
      insert_balance(lates_balance);

      //update next stock
      update_balance(AItemID, ADate+1);
    end else

    //update next stock
      update_balance(AItemID, ADate);
  end;
  }
//------------------------------------------------------------------------------

  procedure save_balance (AStorageId, AItemID: integer;
    ADate: TDate; AQuantity, APrice: double; ADbCrType: string);
  begin
    try
      save_current_stock(AItemID, AQuantity, ADbCrType);
      if GlobalSystemConfig[CONF_INVENTORY-1].ConfValue = '-1' then begin
        if AStorageId <> 0 then
           save_to_balance_stroge(AStorageId, AItemID, ADate, AQuantity, APrice, ADbCrType)

         else
           raise Exception.Create('Gudang Belum ditentukan');

        //else save_to_balance(AItemID, ADate, AQuantity, APrice, ADbCrType);
      end;
    except raise
    end;
  end;

  procedure save_money_balance (AMoneyID: integer;
    ADate: TDate; AMount: double; ADbCrType: string);
    var sql:string;
  begin
    try
      save_current_money(AMoneyID, AMount, ADbCrType);
      sql := 'call save_to_money_balance('+
      IntToStr(AMoneyID)+', '+
      FormatSQLString(FormatDateTime('yyyy-mm-dd', ADate))+', '+
      FormatSQLNumber(AMount)+', '+
      FormatSQLString(ADbCrType)+')';
      ExecSQL(sql);
       //else save_to_balance(AItemID, ADate, AQuantity, APrice, ADbCrType);
    except raise
    end;
  end;

  procedure save_balance_opname (AStorageId, AItemID: integer;
    ADate: TDate; AQuantity, APrice: double; ADbCrType: string);
  begin
    try

      ExecSQL('update mst_item set current_stock = '+FormatSQLNumber(AQuantity)+
      ' where item_id = '+FormatSQLNumber(AItemID));

      if GlobalSystemConfig[CONF_INVENTORY-1].ConfValue = '-1' then begin
        if AStorageId <> 0 then
           save_to_balance_stroge(AStorageId, AItemID, ADate, AQuantity, APrice, ADbCrType)

         else
           raise Exception.Create('Gudang Belum ditentukan');

        //else save_to_balance(AItemID, ADate, AQuantity, APrice, ADbCrType);
      end;
    except raise
    end;
  end;

//------------------------------------------------------------------------------

  procedure save_current_stock(AItemID: integer;
    AQuantity: double; ADbCrType: string);
  var db_quantity, cr_quantity: double;
  begin
    db_quantity:= 0; cr_quantity:= 0;

    //set quatity value ...
    if (ADbCrType = DB_CR_TYPE_DEBIT) then
      db_quantity := AQuantity
    else cr_quantity :=  AQuantity;

    ExecSQL('update mst_item set current_stock = current_stock + '+FormatSQLNumber(db_quantity - cr_quantity)+
    ' where item_id = '+FormatSQLNumber(AItemID));
  end;

  procedure save_current_money(AMoneyID: integer;
    AMount: double; ADbCrType: string);
  var db_quantity, cr_quantity: double;
  begin
    db_quantity:= 0; cr_quantity:= 0;

    //set quatity value ...
    if (ADbCrType = DB_CR_TYPE_DEBIT) then
      db_quantity := Amount
    else cr_quantity :=  Amount;

    ExecSQL('update mst_money set saldo = ifnull(saldo,0) + '+FormatSQLNumber(db_quantity - cr_quantity)+
    ' where money_id = '+FormatSQLNumber(AMoneyID));
  end;


//------------------------------------------------------------------------------
  {procedure new_save_to_balance (AItemID: integer; AQuantity: double; ADbCrType: string);
  var db_quantity, cr_quantity, lates_balance: double;

    function is_exist_balance (vItemID: integer): boolean;
    begin
      Result:= getIntegerFromSQL(
        'select count(*) from inv_item_balance where item_id = '+FormatSQLNumber(vItemID)+
        ' and balance_date = curdate()') <> 0;
    end;

    function get_latest_stock (vItemID: integer): double;
    begin
      Result:= getFloatFromSQL(
        'select balance from inv_item_balance where item_id = '+FormatSQLNumber(vItemID)+
        ' and balance_date = '+
          '(select max(balance_date) from inv_item_balance '+
          'where balance_date <= curdate() '+
          ' and item_id = '+FormatSQLNumber(vItemID)+')');
    end;

    procedure update_balance(vItemID: integer);
    begin
      ExecSQL(
        'update inv_item_balance '+
        'set balance = balance + '+FormatSQLNumber(db_quantity - cr_quantity)+
        ' where balance_date = curdate() '+
        ' and item_id = '+FormatSQLNumber(vItemID));
    end;

    procedure insert_balance(vBalance: double);
    begin
      ExecSQL(
        'insert into inv_item_balance (item_id, balance_date, balance) '+
        'values ('+
        FormatSQLNumber(AItemID)+', curdate(), '+
        FormatSQLNumber(vbalance + db_quantity - cr_quantity)+')');
    end;

  begin
    //main procedure here...

    //initialisai
    db_quantity:= 0; cr_quantity:= 0;

    //set quatity value ...
    if (ADbCrType = DB_CR_TYPE_DEBIT) then
      db_quantity := AQuantity
    else cr_quantity :=  AQuantity;

  //update curret stock
    ExecSQL(
      'update mst_item '+
      'set current_stock = current_stock + '+FormatSQLNumber(db_quantity - cr_quantity)+
      ' where item_id = '+FormatSQLNumber(AItemID));

    if GlobalSystemConfig[CONF_INVENTORY-1].ConfValue = '-1' then begin
      if not is_exist_balance(AItemID) then begin
        lates_balance:= get_latest_stock(AItemID);
        insert_balance(lates_balance);
      end else
        update_balance(AItemID);
    end;

  end;
  }
//------------------------------------------------------------------------------

procedure save_to_cashier (ACashID, AJenisBayar: integer;
  ASales, ADisc, ARetur, AEmbalase: double; ADbCrType: string);
var db_sales_value, cr_sales_value,
    db_disc_value, cr_disc_value,
    db_embalase, cr_embalase,
    db_retur_value, cr_retur_value: double;

  function is_exist_balance (): boolean;
  begin
    Result:= getIntegerFromSQL(
      'select count(*) from inv_cashier_balance '+
      'where cashier_id = '+FormatSQLNumber(ACashID)+
      ' and jenis_bayar = '+FormatSQLNumber(AJenisBayar)+
      ' and shift_id = '+FormatSQLNumber(GlobalSystemUser.FShift)+
      ' and user_id = '+FormatSQLString(GlobalSystemUser.UserId)+
      ' and closed is null and balance_date = curdate()') <> 0;
  end;

  procedure update_balance();
  begin
    ExecSQL(
      'update inv_cashier_balance set '+
      'sales_value = sales_value + '+FormatSQLNumber(db_sales_value - cr_sales_value)+
      ', disc_value = disc_value + '+FormatSQLNumber(db_disc_value - cr_disc_value)+
      ', retur_value = retur_value + '+FormatSQLNumber(db_retur_value - cr_retur_value)+
      ', embalase = embalase + '+FormatSQLNumber(db_embalase - cr_embalase)+
      ' where balance_date = curdate() '+
      ' and cashier_id = '+FormatSQLNumber(ACashID)+
      ' and jenis_bayar = '+FormatSQLNumber(AJenisBayar)+
      ' and shift_id = '+FormatSQLNumber(GlobalSystemUser.FShift)+
      ' and closed is null and user_id = '+FormatSQLString(GlobalSystemUser.UserId), False);
  end;

  procedure insert_balance();
  var lastBalance: TMysqlResult;
  begin
    //cari value terakhir....
    lastBalance:= OpenSQL(
      'select sales_value, disc_value, retur_value, embalase from inv_cashier_balance '+
      'where cashier_id = '+FormatSQLNumber(ACashID)+
      ' and shift_id = '+FormatSQLNumber(GlobalSystemUser.FShift)+
      ' and user_id = '+FormatSQLString(GlobalSystemUser.UserId)+
      ' and jenis_bayar = '+FormatSQLNumber(AJenisBayar)+
      ' and closed is null and balance_date = '+
        '(select max(balance_date) from inv_cashier_balance '+
        'where balance_date <= curdate() and closed is null '+
        ' and cashier_id = '+FormatSQLNumber(ACashID)+
        ' and jenis_bayar = '+FormatSQLNumber(AJenisBayar)+
        ' and shift_id = '+FormatSQLNumber(GlobalSystemUser.FShift)+
        ' and user_id = '+FormatSQLString(GlobalSystemUser.UserId)+')');

    //insert data baru....
    if lastBalance.RecordCount > 0 then
      ExecSQL(
      'insert into inv_cashier_balance ('+
        'cashier_id, balance_date, user_id, shift_id, jenis_bayar, '+
        'sales_value, disc_value, embalase, retur_value) '+
      'values ('+
      FormatSQLNumber(ACashID)+', curdate(), '+
      FormatSQLString(GlobalSystemUser.UserId)+','+
      FormatSQLNumber(GlobalSystemUser.FShift)+','+
      FormatSQLNumber(AJenisBayar)+','+
      FormatSQLNumber(BufferToFloat(lastBalance.FieldValue(0)) + db_sales_value - cr_sales_value)+', '+
      FormatSQLNumber(BufferToFloat(lastBalance.FieldValue(1)) + db_disc_value - cr_disc_value)+', '+
      FormatSQLNumber(BufferToFloat(lastBalance.FieldValue(3)) + db_embalase - cr_embalase)+', '+
      FormatSQLNumber(BufferToFloat(lastBalance.FieldValue(2)) + db_retur_value - cr_retur_value)+')', False)
    else
      ExecSQL(
      'insert into inv_cashier_balance ('+
        'cashier_id, balance_date, user_id, shift_id, jenis_bayar, '+
        'sales_value, disc_value, embalase, retur_value) '+
      'values ('+
      FormatSQLNumber(ACashID)+', curdate(), '+
      FormatSQLString(GlobalSystemUser.UserId)+','+
      FormatSQLNumber(GlobalSystemUser.FShift)+','+
      FormatSQLNumber(AJenisBayar)+','+
      FormatSQLNumber(db_sales_value - cr_sales_value)+', '+
      FormatSQLNumber(db_disc_value - cr_disc_value)+', '+
      FormatSQLNumber(db_embalase - cr_embalase)+', '+
      FormatSQLNumber(db_retur_value - cr_retur_value)+')', False);
    lastBalance.Destroy;
  end;

begin
  //main procedure here...

  //initialisai
  db_sales_value:= 0; cr_sales_value:= 0;
  db_disc_value:= 0; cr_disc_value:= 0;
  db_retur_value:= 0; cr_retur_value:= 0;
  db_embalase:= 0; cr_embalase:= 0;

  //set quatity value ...
  if (ADbCrType = DB_CR_TYPE_DEBIT) then begin
    db_sales_value := ASales;
    db_disc_value:= ADisc;
    db_retur_value:= ARetur;
    db_embalase:= AEmbalase;
  end else
  begin
    cr_sales_value := ASales;
    cr_disc_value:= ADisc;
    cr_retur_value:= ARetur;
    cr_embalase:= AEmbalase;
  end;

  if not is_exist_balance then begin
    //lates_balance:= get_latest_stock(ACashID);
    insert_balance;
  end else
    update_balance;

  LogSQL(
   'call save_to_cashier_balance('+
   IntToStr(ACashID)+', '+
   IntToStr(AJenisBayar)+', '+
   IntToStr(GlobalSystemUser.FShift)+', '+
   FormatSQLNumber(ASales)+', '+
   FormatSQLNumber(ADisc)+', '+
   FormatSQLNumber(ARetur)+', '+
   FormatSQLNumber(AEmbalase)+', '+
   FormatSQLString(ADbCrType)+', '+
   FormatSQLString(GlobalSystemUser.UserId)+')');
end;

function close_cashier_balance(): boolean;
begin
  Result:= ExecuteSQL(
  'update inv_cashier_balance set closed = curdate() '+
  'where closed is null and cashier_id = '+FormatSQLNumber(GlobalSystemConfig.localSetting.Machine)+
//  ' and user_id = '+FormatSQLString(GlobalSystemUser.UserId)+
  ' and shift_id = '+FormatSQLNumber(GlobalSystemUser.FShift));
end;

procedure update_price (AConvID: integer; ASales, APurchase, ACost: double);
begin
  if GlobalSystemConfig[CONF_UDPATE_PRICE-1].ConfValue = '-1' then
    ExecSQL(
    'update mst_item_conversion set '+
    'cost_price = '+FormatSQLNumber(ACost)+
    ', purchase_price = '+FormatSQLNumber(APurchase)+
    ', sales_price = '+FormatSQLNumber(ASales)+
    ' where conv_id = '+FormatSQLNumber(AConvID));
end;

procedure update_master_price (AConvID: integer; ASales, APurchase, ACost: double);
begin
  if GlobalSystemConfig[CONF_UDPATE_PRICE-1].ConfValue = '-1' then
    ExecSQL(
    'update mst_item_conversion set '+
    'cost_price = '+FormatSQLNumber(ACost)+
    ', purchase_price = '+FormatSQLNumber(APurchase)+
    ', sales_price = '+FormatSQLNumber(ASales)+
    ' where conv_id = '+FormatSQLNumber(AConvID));
end;

//=============================================
procedure save_to_relation_balance(ARealtionID: integer; ADate: TDate; AValue: double; ADbCrType: string);
var db_quantity, cr_quantity, lates_balance: double;

    function is_exist_balance (): boolean;
    begin
      Result:= getIntegerFromSQL(
        'select count(*) from inv_relation_balance where relation_id = '+FormatSQLNumber(ARealtionID)+
        ' and balance_date = '+FormatSQLDate(ADate)) <> 0;
    end;

    function get_latest_stock (): double;
    begin
      Result:= getFloatFromSQL(
        'select balance from inv_relation_balance where relation_id = '+FormatSQLNumber(ARealtionID)+
        ' and balance_date = '+
          '(select max(balance_date) from inv_relation_balance '+
          'where balance_date <= '+FormatSQLDate(ADate)+
          ' and relation_id = '+FormatSQLNumber(ARealtionID)+')');
    end;

    procedure update_balance(vDate: TDate);
    var i: integer; buffer: TMysqlResult;
    begin
      buffer:= OpenSQL(
        'select balance_date '+
        'from inv_relation_balance where relation_id = '+FormatSQLNumber(ARealtionID)+
        ' and balance_date >= '+FormatSQLDate(vDate));

      for i:= 0 to buffer.RecordCount -1 do begin
        ExecSQL(
          'update inv_relation_balance '+
          'set balance = balance + '+FormatSQLNumber(db_quantity - cr_quantity)+
          ' where balance_date = '+ FormatSQLDate(BufferToDateTime(buffer.FieldValue(0)))+
          ' and relation_id = '+FormatSQLNumber(ARealtionID), False);
        buffer.MoveNext;
      end;
      buffer.Destroy;
    end;

    procedure insert_balance(vBalance: double);
    begin
      ExecSQL(
        'insert into inv_relation_balance(relation_id, balance_date, balance) '+
        'values ('+
        FormatSQLNumber(ARealtionID)+', '+
        FormatSQLDate(ADate)+', '+
        FormatSQLNumber(vbalance + db_quantity - cr_quantity)+')', False);
    end;

begin
  if ARealtionID=0 then exit;
  db_quantity:= 0; cr_quantity:= 0;

  //set quatity value ...
  if (ADbCrType = DB_CR_TYPE_DEBIT) then
    db_quantity := AValue
  else cr_quantity :=  AValue;

  if not is_exist_balance() then begin

    //insert stock
    lates_balance:= get_latest_stock();
    insert_balance(lates_balance);

    //update next stock
    update_balance(ADate+1);
  end else update_balance(ADate);

  LogSQL(
    'call save_to_relation_balance('+
    IntToStr(ARealtionID)+', '+
    FormatSQLDate(ADate)+', '+
    FormatSQLNumber(AValue)+', '+
    FormatSQLString(ADbCrType)+')');

  save_current_debt(ARealtionID, AValue, ADbCrType);
end;

procedure save_current_debt(ARealtionID: integer; AValue: double; ADbCrType: string);
var db_quantity, cr_quantity: double;
begin
  if ARealtionID=0 then exit;
  db_quantity:= 0; cr_quantity:= 0;
  if (ADbCrType = DB_CR_TYPE_DEBIT) then
    db_quantity := AValue
  else cr_quantity :=  AValue;

  ExecSQL(
  'update mst_relation '+
  'set current_debt = current_debt + '+FormatSQLNumber(db_quantity - cr_quantity)+
  ' where relation_id = '+FormatSQLNumber(ARealtionID));
end;

procedure save_to_relation_point(ARealtionID: integer; AValue: integer; ADbCrType: string);
var db_quantity, cr_quantity: integer;
begin
  if ARealtionID = 0 then exit;
  db_quantity:= 0; cr_quantity:= 0;
  if (ADbCrType = DB_CR_TYPE_DEBIT) then db_quantity := AValue
  else cr_quantity :=  AValue;

  ExecSQL(
  'update mst_relation '+
  'set current_point = current_point + '+FormatSQLNumber(db_quantity - cr_quantity)+
  ' where relation_id = '+FormatSQLNumber(ARealtionID));
end;

//update harga rata-rata
function update_avg_price (AItemID: integer; AQuantity, APrice: double): string;
var curr_stok: double;
begin
  Result:= '';
  if AQuantity = 0 then exit;

  curr_stok:= getFloatFromSQL('select current_stock from mst_item where item_id = '+FormatSQLNumber(AItemID));

  if curr_stok < 0 then begin
    {Result:=
    getStringFromSQL('select concat(''Stok '', item_name) from mst_item where item_id = '+FormatSQLNumber(AItemID))+
    ' < 0.'#13#10'Transaksi dibatalkan.'#13#10'Silahkan lakukan penyesuaian stok.';
    raise Exception.Create(Result);}
    curr_stok:= 0;
  end;

  ExecSQL('update mst_item set buying_price = '+FormatSQLNumber(APrice)+', avg_price = (ifnull(('+FormatSQLNumber(curr_stok)+' * avg_price),0) + '+
  FormatSQLNumber(AQuantity * APrice)+') / (ifnull('+FormatSQLNumber(curr_stok)+',0) + '+FormatSQLNumber(AQuantity)+')'+
  ' where item_id = '+FormatSQLNumber(AItemID));

end;

function cari_setting_harga_kelipatan(AItemID, AConvID: integer; AQty: double): double;
var setting: TMysqlResult; i, faktor: integer;
  batas_bawah, batas_atas, hasil: double;
  field_name: string;
begin
  hasil:= 0;
  setting:= OpenSQL(
  'select batas_bawah, batas_atas, faktor '+
  'from mst_item_setting where jenis_id = '+IntToStr(JNS_MULTIPLY)+' and item_id = '+IntToStr(AItemID)+' and aktif = 0 '+
  'order by batas_bawah ');
  if setting.RecordCount > 0 then
    for i := 0 to setting.RecordCount-1 do begin
      faktor     := BufferToInteger(setting.FieldValue(2));
      batas_bawah:= BufferToFloat(setting.FieldValue(0));
      batas_atas := BufferToFloat(setting.FieldValue(1));
      if (AQty >= batas_bawah) and ((AQty <= batas_atas) or (batas_atas=0)) then begin
          field_name:= 'sales_price';
          if (faktor = FAKTOR_MULTIPLY_HRG2) then field_name:= 'sales_price2'
          else if (faktor = FAKTOR_MULTIPLY_HRG3) then field_name:= 'sales_price3';

          hasil:= getFloatFromSQL('select '+field_name+' from mst_item_conversion '+
                                  'where conv_id = '+IntToStr(AConvID));// StrPas(setting.FieldValue(2)));
      end;
      setting.MoveNext;
    end;
  setting.destroy;
  Result:= hasil;
end;

procedure save_balace_paket(APaketID: integer; AValue: double; ADbCrType: string);
var db_quantity, cr_quantity: double;
begin
  if APaketID = 0 then exit;
  db_quantity:= 0; cr_quantity:= 0;
  if (ADbCrType = DB_CR_TYPE_DEBIT) then db_quantity := AValue
  else cr_quantity :=  AValue;

  ExecSQL(
  'update mst_paket '+
  'set current_stock = current_stock + '+FormatSQLNumber(db_quantity - cr_quantity)+
  ' where paket_id = '+FormatSQLNumber(APaketID));
end;

function cari_setting_harga_discount(var Atipe: integer; AItemID: integer; AQty: double): double;
var setting: TMysqlResult; i, faktor: integer;
  nilai, batas_bawah, batas_atas, hasil: double;
begin
  Atipe:= 0;
  hasil:= 0;
  setting:= OpenSQL(
  'select batas_bawah, batas_atas, faktor, nilai '+
  'from mst_item_setting where jenis_id = '+IntToStr(JNS_DISCOUNT)+' and item_id = '+IntToStr(AItemID)+' and aktif = 0 '+
  'order by batas_bawah ');
  if setting.RecordCount > 0 then
    for i := 0 to setting.RecordCount-1 do begin
      faktor     := BufferToInteger(setting.FieldValue(2));
      batas_bawah:= BufferToFloat(setting.FieldValue(0));
      batas_atas := BufferToFloat(setting.FieldValue(1));
      nilai      := BufferToFloat(setting.FieldValue(3));
      if (AQty >= batas_bawah) and ((AQty <= batas_atas) or (batas_atas=0)) then begin
          hasil:= nilai;
          Atipe:= faktor;
      end;
      setting.MoveNext;
    end;
  setting.destroy;
  Result:= hasil;
end;

function produk_hjual_used(v_prod_id, v_item_id: integer;
  v_new_qty: double): double;
var i: integer; rule: TMysqlResult;
begin
  Result:= 0;
  rule:= OpenSQL(
  'select p.rule_id, p.faktor_id, p.batas_minimal '+
  'from mst_produk_rule p, mst_produk_item i '+
  'where p.produk_id = '+FormatSQLNumber(v_prod_id)+' and i.rule_id = p.rule_id '+
  'and i.item_id = '+FormatSQLNumber(v_item_id)+
  ' order by p.batas_minimal desc');

  for i:= 1 to rule.RecordCount do begin
    if v_new_qty >= BufferToFloat(rule.FieldValue(2)) then
       Result:= getFloatFromSQL(
       'select case '+IntToStr(BufferToInteger(rule.FieldValue(1)))+
          ' when 1 then sales_price '+
          ' when 2 then sales_price2 '+
          ' when 3 then sales_price3 end as new_prc '+
       'from mst_item_conversion '+
       'where item_id = '+FormatSQLNumber(v_item_id)+' and conversion = 1')
    else
       Result:= getFloatFromSQL(
       'select sales_price from mst_item_conversion '+
       'where item_id = '+FormatSQLNumber(v_item_id)+' and conversion = 1');

    rule.MoveNext;
  end;
  rule.destroy;
end;

procedure produk_discount_item(v_prod_id, v_item_id, v_qty: integer;
  var v_amount, v_new_dis_persen, v_new_dis_rp: double);
var i: integer; rule: TMysqlResult;
begin
  v_new_dis_persen:= 0;
  v_new_dis_rp:= 0;
  rule:= OpenSQL(
  'select p.rule_id, p.faktor_id, round(p.batas_minimal), nilai, disc_prc '+
  'from mst_produk_rule p, mst_produk_item i '+
  'where p.produk_id = '+FormatSQLNumber(v_prod_id)+' and i.rule_id = p.rule_id '+
  'and i.item_id = '+FormatSQLNumber(v_item_id)+
  ' order by p.faktor_id, p.batas_minimal desc');

  for i:= 1 to rule.RecordCount do begin
    case BufferToInteger(rule.FieldValue(1)) of
      //must be 1 record
      FAKTOR_KELIPATAN_QTY:   //HANYA NILAI TDK ADA PERSENTASE
      begin
        if v_qty >= BufferToInteger(rule.FieldValue(2)) then begin
           v_new_dis_rp:= BufferToFloat(rule.FieldValue(3));
           v_new_dis_rp:= v_new_dis_rp * (v_qty div BufferToInteger(rule.FieldValue(2)));
           v_amount:= v_amount - v_new_dis_rp;
        end;
      end;

      FAKTOR_KELIPATAN_NILAI:
      begin
        if v_amount >= BufferToFloat(rule.FieldValue(2)) then begin
           v_new_dis_rp:= BufferToFloat(rule.FieldValue(3));
           v_new_dis_rp:= v_new_dis_rp * (round(v_amount) div BufferToInteger(rule.FieldValue(2)));
           v_amount:= v_amount - v_new_dis_rp;
        end;
      end;

      FAKTOR_MINIMAL_QTY:
      begin
        if v_qty >= BufferToFloat(rule.FieldValue(2)) then begin
           v_new_dis_persen:= (BufferToFloat(rule.FieldValue(4)));
           v_new_dis_rp:= (BufferToFloat(rule.FieldValue(3)));
           v_amount:= v_amount - (v_amount * (v_new_dis_persen/100));
           v_amount:= v_amount - v_new_dis_rp;
        end;
      end;

      FAKTOR_MINIMAL_NILAI:
      begin
        if v_amount >= BufferToFloat(rule.FieldValue(2)) then begin
           v_new_dis_persen:= (BufferToFloat(rule.FieldValue(4)));
           v_new_dis_rp:= (BufferToFloat(rule.FieldValue(3)));
           v_amount:= v_amount - (v_amount * (v_new_dis_persen/100));
           v_amount:= v_amount - v_new_dis_rp;
        end;
      end;
    end;
    rule.MoveNext;
  end;
  rule.destroy;
end;

procedure produk_discount_total(v_prod_id: integer;
  var v_amount, v_new_dis_persen, v_new_dis_rp: double);
var i: integer; rule: TMysqlResult;
begin
  v_new_dis_persen:= 0;
  v_new_dis_rp:= 0;
  rule:= OpenSQL(
  'select rule_id, faktor_id, batas_minimal, nilai, disc_prc '+
  'from mst_produk_rule '+
  'where produk_id = '+FormatSQLNumber(v_prod_id)+
  ' order by faktor_id, batas_minimal desc');

  for i:= 1 to rule.RecordCount do begin
    case BufferToInteger(rule.FieldValue(1)) of

      FAKTOR_KELIPATAN_NILAI:
      begin
        if v_amount >= BufferToFloat(rule.FieldValue(2)) then begin
           v_new_dis_rp:= BufferToFloat(rule.FieldValue(3));
           v_new_dis_rp:= v_new_dis_rp * (round(v_amount) div BufferToInteger(rule.FieldValue(2)));
           v_amount:= v_amount - v_new_dis_rp;
        end;
      end;

      FAKTOR_MINIMAL_NILAI:
      begin
        if v_amount >= BufferToFloat(rule.FieldValue(2)) then begin
           v_new_dis_persen:= (BufferToFloat(rule.FieldValue(4)));
           v_new_dis_rp:= (BufferToFloat(rule.FieldValue(3)));
           v_amount:= v_amount - (v_amount * (v_new_dis_persen/100));
           v_amount:= v_amount - v_new_dis_rp;
        end;
      end;
    end;

    rule.MoveNext;
  end;
  rule.destroy;
end;

procedure produk_point_item(var cur_point: integer;
  v_prod_id, v_item_id, v_relasi_id, v_qty, v_amount: integer);
var rule: TMysqlResult; tmp: integer;
begin
  //recordcount harus 1, kalo lebih ambil yg paling gede
  rule:= OpenSQL(
  'select round(p.nilai), p.faktor_id '+
  'from mst_produk_rule p, mst_produk_item i '+
  'where p.produk_id = '+FormatSQLNumber(v_prod_id)+' and i.rule_id = p.rule_id '+
  'and i.item_id = '+FormatSQLNumber(v_item_id)+
  ' order by p.faktor_id, p.batas_minimal desc limit 1');

  if rule.RecordCount > 0 then begin
    if BufferToInteger(rule.FieldValue(1)) = FAKTOR_QTY then
      tmp:= v_qty
    else tmp:= v_amount;
    if tmp >= BufferToInteger(rule.FieldValue(0)) then
       cur_point:= tmp div BufferToInteger(rule.FieldValue(0))
    else cur_point:= 0;
  end;
  rule.destroy;
end;

procedure produk_point_total(var cur_point: integer;
    v_prod_id, v_relasi_id, v_amount: integer);
var i: integer; rule: TMysqlResult;
begin
  rule:= OpenSQL('select round(nilai) from mst_produk_rule '+
  'where produk_id = '+FormatSQLNumber(v_prod_id)+
  ' order by nilai desc');

  for i:= 1 to rule.RecordCount do begin
    if v_amount >= BufferToInteger(rule.FieldValue(0)) then
       cur_point:= v_amount div BufferToInteger(rule.FieldValue(0))
     else cur_point:= 0;
    rule.MoveNext;
  end;
  rule.destroy;
end;

function isexist_produk(): boolean;
begin
  Result:= getFloatFromSQL(
  'select count(*) from mst_produk where aktif = 1 '+
  'and (berlaku = 1 or (berlaku = 2 and curdate() >= periode_awal and curdate() <= periode_akhir))') >0;
end;

function appllied_produk(AJnsCust, AItemID, ACustID: integer;
  AQty: double;
  var ANewHJual, ANewDisc, ANewDiscRp: double;
  var ACurPoint: integer): boolean;

var
  prodID, i: integer; produk: TMysqlResult;
  v_new_amount, tmp: double; //buat itung2 dalam fungsi ini

begin
  Result:= False;
  if not isexist_produk then Exit;
  ACurPoint := 0;
  ANewDisc  := 0;
  ANewDiscRp:= 0;
  ANewHJual := revoke_produk(AItemID);
  v_new_amount:= (ANewHJual * AQty);

  //v_new_amount:= (ANewHJual * AQty) - (ANewHJual * AQty * (ANewDisc/100)) - ANewDiscRp;

  produk:= OpenSQL(
  'select p.produk_id, p.jns_produk from mst_produk p, mst_produk_customer c '+
  'where p.produk_id = c.produk_id and aktif = 1 and p.faktor = '+FormatSQLNumber(PROD_FAK_ITEM)+
  ' and c.jns_customer = '+FormatSQLNumber(AJnsCust)+
  ' and (berlaku = 1 or (berlaku = 2 and curdate() >= periode_awal and curdate() <= periode_akhir)) '+
  ' order by p.jns_produk, p.faktor');

  Result:= produk.RecordCount > 0;
  if Result then
  for i:= 1 to produk.RecordCount do begin
    prodID:= BufferToInteger(produk.FieldValue(0));
    case BufferToInteger(produk.FieldValue(1)) of
      PROD_HJUAL:
      begin
        tmp:= produk_hjual_used(prodID, AItemID, AQty);
        if tmp <> 0 then ANewHJual:= tmp;
        v_new_amount:= (ANewHJual * AQty) - (ANewHJual * AQty * (ANewDisc/100)) - ANewDiscRp;
      end;

      PROD_DISCOUNT:
        produk_discount_item(prodID, AItemID, round(AQty), v_new_amount, ANewDisc, ANewDiscRp);

      PROD_POINT:
        produk_point_item(ACurPoint, prodID, AItemID, ACustID, round(AQty), round(v_new_amount));

    end;
    produk.MoveNext;
  end;

  produk.destroy;
end;

function revoke_produk(AItemID: integer): double;
begin
  Result:= getFloatFromSQL(
  'select sales_price from mst_item_conversion '+
  'where item_id = '+FormatSQLNumber(AItemID)+' and conversion = 1');
end;

function appllied_produk_total(AJnsCust, ACustID: integer; AAmount: double;
    var ANewDisc, ANewDiscRp: double; var ACurPoint: integer): boolean;
var
  prodID, i: integer; produk: TMysqlResult;
  v_new_amount: double; //buat itung2 dalam fungsi ini

begin
  Result:= False;
  if not isexist_produk then Exit;
  ACurPoint := 0;
  ANewDisc  := 0;
  ANewDiscRp:= 0;

  v_new_amount:= AAmount;

  produk:= OpenSQL(
  'select p.produk_id, p.jns_produk from mst_produk p, mst_produk_customer c '+
  'where p.produk_id = c.produk_id and aktif = 1 and p.faktor = '+FormatSQLNumber(PROD_FAK_TOTAL)+
  ' and c.jns_customer = '+FormatSQLNumber(AJnsCust)+
  ' and (berlaku = 1 or (berlaku = 2 and curdate() >= periode_awal and curdate() <= periode_akhir)) '+
  ' order by p.jns_produk, p.faktor');

  Result:= produk.RecordCount > 0;
  if Result then
  for i:= 1 to produk.RecordCount do begin
    prodID:= BufferToInteger(produk.FieldValue(0));
    case BufferToInteger(produk.FieldValue(1)) of

      PROD_DISCOUNT:
        produk_discount_total(prodID, v_new_amount, ANewDisc, ANewDiscRp);

      PROD_POINT:
        produk_point_total(ACurPoint, prodID, ACustID, round(v_new_amount));

    end;
    produk.MoveNext;
  end;

  produk.destroy;
end;

end.
