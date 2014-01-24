unit UMaster;

interface

uses
  Classes, Controls, SysUtils, AutoStockLine, Subroutines,Math,
  strUtils,UPetshop,
  uMysqlClient;

type

  trMstCode = record
    FCodeId: integer;
    FCodeName: string;
    FParentId: integer;
    FParentName: string;
    FKode: string;
    FLevel: integer;
  end;

  trMstAccount = record
    AccId: integer; //<sequence
    AccType: string; //[0]
    AccCode: integer; //[0]
    AccName: string; //[0]
    DbCrType: string; //[0]
    ParentId: integer; //
    AccLevel: integer; //
    CurrentDebt: real; //
  end;

  arMstAccount = array of trMstAccount;
  TrecMstAccount = class (TObject)
    class function SelectRoot(var Account: trMstAccount; Master: integer; RealROOT: Boolean): boolean;
    class procedure Reset(var Account: trMstAccount);

  end;

  TrMstAccount_Arr = class(TObject)
    class function LoadFromDb(var AccountArr: arMstAccount; vParent: integer): boolean;
  end;

//==============================================================================
  arMstCode = array of trMstCode;
  TrMstCode_Arr = class(TObject)
    class function LoadFromDb(var rMstCode: arMstCode; vParent: integer): boolean;
    class function LoadFromRak(var rMstCode: arMstCode; vParent: integer): boolean;
    class procedure gelLats(alist: TStringList);

  end;
//==============================================================================

  TMstMaster = class(_MstMaster)
  public
    function InsertOnDB: boolean; reintroduce;
    function InsertProdusen: boolean; reintroduce;
    function UpdateOnDB: boolean; reintroduce;
    function UpdateProdusen: boolean; reintroduce;
    function SelectInDB: boolean; reintroduce;
    function SelectJenis: boolean;
    function isExistInDb(id: string; tipe: integer): boolean;
    class function getName(id: integer): string;
    class function getKode(id: integer): string;
    class function getJenis(id: integer): string;
    class function deleteMaster(id: integer): boolean;
    class function isExistInDb2(id: string; tipe: integer): boolean;
  end;
  TMstMaster_Arr = class(_MstMaster_Arr)
    procedure LoadFromDb(tipe: integer);
    class procedure GetList(vList: TStringList; vTipe: integer;withAll:boolean=false);
  end;

  TMstCode = class(_MstCode)
  public
    procedure InsertOnDB; reintroduce;
    procedure InsertRak;
    function UpdateRak: boolean; reintroduce;
    function UpdateOnDB: boolean; reintroduce;
    function SelectInDB: boolean; reintroduce;
    function SelectRak: boolean; reintroduce;
    function SelectRak2: boolean; reintroduce;
    function isExistInDb(id: string; parent: integer): boolean;
    function GetNextCode: string;
    class function getName(id: integer): string;
    class function getRakName(id: integer): string;

    class function DeleteFromDb(id: integer): boolean;
    class function DeleteRak(id: integer): boolean;
  end;

  TMstCode_Arr = class(_MstCode_Arr)
  public
    FParent: integer;
    //class procedure GetList(vList: TStringList; vIsParent: boolean = False; vParentSeq: integer=0; vWithAll: boolean=False);
    class procedure gelLats(alist: TStringList);
  end;


  TMstAkun = class(_MstAkun)
  public
    function InsertOnDB:boolean; reintroduce;
    function UpdateOnDB: boolean; reintroduce;
    function SelectInDB: boolean; reintroduce;
    function isExistInDb(id: string): boolean;
    function GetNextCode: string;
    class function getName(id: integer): string;
    class function DeleteFromDb(id: integer): boolean;
    class function LoadFromDB(): TMysqlResult;
    class procedure getList(var AList:TStringList;tipe:integer;forFilter:boolean=false);
  end;

  TPointMaping = class(_PointMaping)
  public
    procedure InsertOnDB; reintroduce;
    procedure InsertRak; reintroduce;
    function isExistInDb(code, root: integer): boolean;
    function isExistRakInDb(code, root: integer): boolean;
  end;

  TMstRelation = class(_MstRelation)
  public
    FRelationAnimal :  _MstRelationAnimal_Arr;
    FWajibDiscount : integer;
    FJenisMember : Smallint;
    FBarcode : string;
    constructor Create;
    destructor Destroy;override;
    procedure Reset;override;
    function InsertOnDB: boolean; reintroduce;
    function UpdateOnDB: boolean; reintroduce;

    function SelectInDB: boolean; reintroduce;
    function SelectID: boolean;
    function isExistInDb(id: string; tipe: integer): boolean;
    function GetNextCode(vTipe: integer): string;
    function saveAnimal():boolean;
    function loadAnimal():TMysqlResult;
    function loadService():TMysqlResult;
    function loadServiceDetail(aServiceType:integer):TMysqlResult;
    //class function Adjustment(vId: integer; vReal: double): boolean;
    class function GetName(vId: integer): string;
    //class function GetBalanceAkhir(vId: integer): double;
    class function GetSaldoAwal(vId: integer; vDate: TDate): Double;
    class function GetDiscount(vId: integer): Double;

    class function activasi(id: integer): boolean;
    class function Delete(id: integer): boolean;
    class function statusRS(id, sttID: integer): boolean;
    class procedure getListAnimal(aRelationId:integer;aList:TStringList;cekHolded:boolean=false);
    class procedure getListAnimal2(aRelationId:integer;aList:TStringList;cekHolded:boolean=false);
    class function getJenisAnimal(aRelationId,seq:integer;var jenisId:integer):string;
    class function deleteAnimal(relationId,seq:integer):boolean;
    class function isFreeService(aRelationId,aServiceType:integer):boolean;
    class function isFreeServiceText(aRelationId:integer):string;
    class procedure getListFreeService(aRelationId:integer;var aList:TStringList);
    class function getAnimalName(aRelationId:integer;Seq:integer):string;

    property WajibDiscount : integer read FWajibDiscount write FWajibDiscount;
    property JenisMember : Smallint read FJenisMember write FJenisMember;
    property Barcode : string read FBarcode write FBarcode;
  end;

  TMstDokter = class(_MstDokter)
  public
    function InsertOnDB: boolean; reintroduce;
    function UpdateOnDB: boolean; reintroduce;
    function SelectInDB: boolean; reintroduce;
    function isExistInDb(id: string): boolean;

    function GetNextCode(): string;
    class function deleteDate(id: integer): boolean;
    class function GetName(vId: integer): string;
    class function activasi(id: integer): boolean;
    class function LoadFromDB(): TMysqlResult;
  end;

  TMstPasien = class(_MstPasien)
  public
    function InsertOnDB: boolean; reintroduce;
    function UpdateOnDB: boolean; reintroduce;
    function SelectInDB: boolean; reintroduce;
    function isExistInDb(id: string): boolean;
    function GetNextCode(): string;
    class function deleteDate(id: integer): boolean;
    class function GetName(vId: integer): string;
    class function GetCardID(ID: integer): string;
    class function LoadFromDB(): TMysqlResult;
    class function countFromDB(): integer;
    class procedure UpdateCardID(ID: integer; vcard: string);
  end;


  TMstRelationArr = class(_MstRelation_Arr)
  public
    function FindOnDb: boolean;
    class function LoadFromDB: TMysqlResult;
  end;

  TMstItemConversion = class(_MstItemConversion)
  public
    function InsertOnDB: boolean; reintroduce;
    function UpdateOnDB: boolean; reintroduce;
    function SelectInDB: boolean; reintroduce;
    function SelectInDB3: boolean; reintroduce;
    function SelectInDB4: boolean; reintroduce;
    function SelectForPOS: boolean;
    function SelectForBOS: boolean;
    class procedure UpdatePrice(convId: integer; newPrice: double);
    class function GetCodeUnit(ItemId: integer): string;
    class function lookupPrice(convId, relasiId: integer): double;
    class function GetConversionId(ItemID: integer): integer;
    class function GetStockDescription(ItemID, stok: integer): string;
    class function GetStockDescriptionEnter(ItemID, stok: integer): string;
    class function GetSalesPriceDesc(ItemID: integer): string;

    class function GetUnit(ItemID: integer; UnitCode: string): TMysqlResult;

  end;

  TMstItemConversionArr = class(TObject)
  protected
    FItemConversion_Arr: array of TMstItemConversion;
    function Get(Index: integer): TMstItemConversion; reintroduce;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear; reintroduce;
    function Count: integer;
    property ItemConversion_Arr[Index: integer]: TMstItemConversion read Get; default;
    function Add: integer; reintroduce;
    function LoadFromDb(AItemId: integer; AConvType: integer=0): boolean; reintroduce;
    class procedure getList(AList: TStringList; AItemId: integer; AItems: TStrings);
    class procedure getList2(AList: TStringList; ATipe: integer);
  end;

  TMstItem = class(_MstItem)
  public
    FItemConversion: TMstItemConversionArr;
    FItemSeting: _MstItemSetting_Arr;
    FRak: _MstRakItem_Arr;

//    SellingPrice, BuyingPrice : Double;
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    function InsertOnDB: boolean; reintroduce;
    function UpdateOnDB(): boolean; reintroduce;
    function isExistInDb(id: string): boolean;
    function isExistBarcode(id: string): boolean;
    function isExistName(id: string): boolean;
    function SelectInDB: boolean; reintroduce;
    function SelectInDB2(AConvType: integer=0): boolean;
    function SelectInDB3: boolean;
    function SelectInDB4(ConvID: integer): boolean;
    function CekHarga: boolean; reintroduce;
    function SelectPOS: boolean; reintroduce;
    function SelectBOS: boolean; reintroduce;

    function SelectSetting(Jenis: integer): TMysqlResult;
    class function DeleteItem(ID: integer): boolean;
    class function activasi(id: integer): boolean;
    class function GetName(id: integer): string;
    class function GetSaldoAkhir(AItemId, AStorageID: integer; vDate: TDate): Double;
    class function GetSaldoAwal(AItemId, AStorageID: integer; vDate: TDate): Double;
    class function GetRakDesc(AItemId: integer): string;
    class function GetNextCode(Spec: integer): string;
    class function updatePriceHistory(Purpose,aItemId:integer;aPrice:double;Supplier:string;aPricePetshop:double;aPriceBreeder:double):boolean;

  end;

  TMstItemArr = class(_MstItem_Arr)
  public
    function Add: integer; reintroduce;
    function LoadFromDB(ean: integer=0): boolean;
    function LoadFromDBWithConv: boolean;
    function LoadFromStock: boolean;
    function updatePrice(purpose:integer):boolean;
    class function LoadFormOpname: TMysqlResult;
    class function LoadFormOpnameX: TMysqlResult;
    class function LoadFromDB2(): TMysqlResult;
    class function loadPriceHistory(AItemId,APurpose:integer):TMysqlResult;
    class function countFromDB2(): integer;


  end;

  TMstPaket = class(_MstPaket)
  public
    Item: _MstPaketItem_Arr;
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    function InsertOnDB: boolean; reintroduce;
    function UpdateOnDB(): boolean; reintroduce;
    function isExistInDb(id: string): boolean;
    class function DeleteItemPaket(id: integer): boolean;
    function isExistBarcode(id: string): boolean;
    function SelectInDB: boolean; reintroduce;
    class function LoadFromDB(): TMysqlResult;
    class function UpdateStock(APaketID: integer; AValue: double; ADbCrType: string): boolean;
    class function activasi(id: integer): boolean;
  end;

  TMstProduk = class(_MstProduk)
  public
    function InsertOnDB(customer: TStringList): boolean; reintroduce;
    function UpdateOnDB(customer: TStringList): boolean; reintroduce;
    function isExistInDb(id: string): boolean;
    function SelectInDB: boolean; reintroduce;
    class function LoadFromDB: TMysqlResult;
    class function LoadProdukItem(ruleID: integer): TMysqlResult;
    class function getProdukCustomer(ID, CustID: integer): string;
    class function getItemUnsetted(ruleID: integer): TMysqlResult;
    class procedure getListCustomer(var ls: TStringList; ID: integer);
    class function DeleteFromDB(ID: Integer): boolean;
    class function getProduckDesc(ID: Integer): string;
  end;

  TMstProdukRule = class(_MstProdukRule)
  public
    function InsertOnDB: boolean; reintroduce;
    function UpdateOnDB: boolean; reintroduce;
    class function LoaddFromDB(ID: integer): TMysqlResult;
    class function DeleteFromDB(ID: Integer): boolean;
  end;

  TMstProdukItem = class(_MstProdukItem)
  public
    function InsertOnDB: boolean; reintroduce;
    function DeleteOnDB: boolean; reintroduce;
    //class function LoaddFromDB(ID: integer): TMysqlResult;
  end;


   TMstBranch = class(_MstBranch)
  public
    function InsertInDb: boolean;

    function SelectInDB: boolean;
    function SelectLookup(): boolean;
    function DeleteDB: boolean;
    class function loadFromDB: TMysqlResult;
    class function getNextCode: string;
    class function getCode(ID: integer): string;
    class function getName(ID: integer): string; //getNameTrunced
    class function isExistInDB(code: string; ID: integer): boolean;
    class function activasi(id: integer): boolean;
    class procedure getList(var list: TStringList; includeSelf: boolean);


  end;
  

implementation

uses UConstTool, UConst, ADOInt, UQueryPackage, MySQLConnector;

{ TMstCode }

class function TMstCode.DeleteFromDb(id: integer): boolean;
var deleted: TMysqlResult; i: integer;
begin
  try
    BeginSQL;
    deleted:= OpenSQL(
    'select m.root_id, k.code_id, k.level, k.code_name '+
    'from point_maping m, mst_code k where m.code_id = k.code_id '+
    'and m.root_id = '+FormatSQLNumber(id));

    if deleted.RecordCount > 0 then
      for i:= 0 to deleted.RecordCount-1 do begin
        ExecSQL('delete from mst_code where code_id = '+
        FormatSQLNumber(BufferToInteger(deleted.FieldValue(0))));
        deleted.MoveNext;
      end
    else ExecSQL('delete from mst_code where code_id = '+FormatSQLNumber(id));
    deleted.destroy;

    EndSQL;
    Result:= True;
  except
    on E: Exception do begin
      Result:= False;
      UndoSQL;
      Alert('Data tidak bisa dihapus.');
    end;
  end;
end;

class function TMstCode.DeleteRak(id: integer): boolean;
var deleted: TMysqlResult; i: integer;
begin
  try
    BeginSQL;
    deleted:= OpenSQL(
    'select m.root_id, k.rak_id, k.level, k.kode '+
    'from mst_rak_maping m, mst_rak k where m.rak_id = k.rak_id '+
    'and m.root_id = '+FormatSQLNumber(id));

    if deleted.RecordCount > 0 then
      for i:= 0 to deleted.RecordCount-1 do begin
        ExecSQL('delete from mst_rak where rak_id = '+
        FormatSQLNumber(BufferToInteger(deleted.FieldValue(0))));
        deleted.MoveNext;
      end
    else ExecSQL('delete from mst_rak where rak_id = '+FormatSQLNumber(id));
    deleted.destroy;

    EndSQL;
    Result:= True;
  except
    on E: Exception do begin
      Result:= False;
      UndoSQL;
      Alert('Data tidak bisa dihapus.');
    end;
  end;
end;

class function TMstCode.getName(id: integer): string;
begin
  Result:= getStringFromSQL(
  'select code_name from mst_code where code_id = '+FormatSQLNumber(id))
end;

function TMstCode.GetNextCode(): string;
begin
  Result:= getNextIDNum('kode','mst_rak','','R.','',3);
end;

class function TMstCode.getRakName(id: integer): string;
begin
  Result:= getStringFromSQL(
  'select nama from mst_rak where rak_id = '+FormatSQLNumber(id))
end;

procedure TMstCode.InsertOnDB;
begin
  ExecSQL(
    'insert into mst_code (code_name,code_code, parent_id, urut, level) '+
    'values ('+
      FormatSQLString(FCodeName)+','+
      FormatSQLString(FKode)+','+
      FormatSQLNumber(FParentId)+','+
      FormatSQLNumber(FUrut)+','+
      FormatSQLNumber(FLevel)+')');

  FCodeId:=getIntegerFromSQL(
    'select code_id from mst_code where code_name = '+FormatSQLString(FCodeName)+
    ' and parent_id = '+FormatSQLNumber(FParentId));
end;

procedure TMstCode.InsertRak;
begin
  ExecSQL(
    'insert into mst_rak (kode, nama, parent_id, level) '+
    'values ('+
      FormatSQLString(FKode)+','+
      FormatSQLString(FCodeName)+','+
      FormatSQLNumber(FParentId)+','+
      FormatSQLNumber(FLevel)+')');
  FCodeId:=getIntegerFromSQL('select rak_id from mst_rak '+
  'where kode = '+FormatSQLString(FKode)+ ' and parent_id = '+FormatSQLNumber(FParentId));
end;

function TMstCode.isExistInDb(id: string; parent: integer): boolean;
begin
  Result:= getIntegerFromSQL
   ('select count(code_name) from mst_code where code_name = '+FormatSQLString(id)+
   ' and parent_id = '+ FormatSQLNumber(parent)) > 0;
end;

function TMstCode.SelectInDB: boolean;
var buffer: TMysqlResult;
begin
  buffer:= OpenSQL
   ('select a.code_id, a.code_name, a.parent_id, a.level, '+
      '(select if (a.parent_id = 0, ''Master Code'', '+
                  '(select b.code_name from mst_code b where b.code_id = a.parent_id) '+
       ')) as parent_name, a.urut, a.code_code '+
    'from mst_code a '+
    IfThen(FCodeId <> 0, 'where a.code_id = '+FormatSQLNumber(FCodeId))+
    IfThen(FParentId <> 0, 'where a.parent_id = '+FormatSQLNumber(FParentId))+
    ' order by a.code_name');

  result:= buffer.RecordCount > 0;
  Self.Reset;
  if Result then
    with buffer do begin
      FCodeId     := BufferToInteger(FieldValue(0));
      FCodeName   := BufferToString(FieldValue(1));
      FParentId   := BufferToInteger(FieldValue(2));
      FLevel      := BufferToInteger(FieldValue(3));
      FParentName := BufferToString(FieldValue(4));
      FUrut := BufferToInteger(FieldValue(5));
      FKode   := BufferToString(FieldValue(6));
    end;
  buffer.Destroy;
end;

function TMstCode.SelectRak: boolean;
var buffer: TMysqlResult;
begin
  buffer:= OpenSQL
   ('select a.rak_id, a.kode, a.nama, a.parent_id, a.level, '+
      '(select if (a.parent_id = 0, ''Master Rak'', '+
                  '(select b.nama from mst_rak b where b.rak_id = a.parent_id) '+
       ')) as parent_name '+
    'from mst_rak a '+
    IfThen(FCodeId <> 0, 'where a.rak_id = '+FormatSQLNumber(FCodeId))+
    IfThen(FParentId <> 0, 'where a.parent_id = '+FormatSQLNumber(FParentId))+
    ' order by a.kode');

  result:= buffer.RecordCount > 0;
  Self.Reset;
  if Result then
    with buffer do begin
      FCodeId    := BufferToInteger(FieldValue(0));
      FKode      := BufferToString(FieldValue(1));
      FCodeName  := BufferToString(FieldValue(2));
      FParentId  := BufferToInteger(FieldValue(3));
      FLevel     := BufferToInteger(FieldValue(4));
      FParentName:= BufferToString(FieldValue(5));
    end;
  buffer.Destroy;
end;

function TMstCode.SelectRak2: boolean;
var buffer: TMysqlResult;
begin
  buffer:= OpenSQL('select rak_id, nama from mst_rak a '+
  IfThen(FCodeId <> 0,
  'where rak_id = '+FormatSQLNumber(FCodeId),
  'where kode = '+FormatSQLString(FKode)));
  result:= buffer.RecordCount > 0;
  Self.Reset;
  if Result then
    with buffer do begin
      FCodeId    := BufferToInteger(FieldValue(0));
      FCodeName  := BufferToString(FieldValue(1));
    end;
  buffer.Destroy;
end;

function TMstCode.UpdateOnDB: boolean;
begin
  Result:= ExecTransaction(
    'update mst_code set '+
      'code_name = '+FormatSQLString(FCodeName)+', '+
      'code_code = '+FormatSQLString(FKode)+', '+
      'parent_id = '+FormatSQLNumber(FParentId)+', '+
      'urut = '+FormatSQLNumber(FUrut)+' '+
   //   'level = '+FormatSQLNumber(FLevel)+' '+
    'where code_id = '+FormatSQLNumber(FCodeId),false);
end;

class procedure TrMstCode_Arr.gelLats(alist: TStringList);
begin
   SQLToNameValueList(alist,
   'select code_id, '+
   'concat('+
     '(select code_name from mst_code where code_id = a.parent_id), '' - '', '+
     'code_name) as nama '+
   'from mst_code a where code_id not in (select parent_id from mst_code) '+
   'order by nama ');
end;

class function TrMstCode_Arr.LoadFromDb(var rMstCode: arMstCode;
  vParent: integer): boolean;
var i: integer; buffer: TMysqlResult;
begin
  buffer:= OpenSQL
  ('select code_id, code_name, parent_id, level,code_code from mst_code '+
   'where parent_id = '+FormatSQLNumber(vParent)+
   ' order by urut, code_name ');

  result:= buffer.RecordCount > 0;
  SetLength(rMstCode, 0);
  if Result then
    for i:= 0 to buffer.RecordCount-1 do begin
      SetLength(rMstCode, length(rMstCode)+1);
      rMstCode[i].FCodeId   := BufferToInteger(buffer.FieldValue(0));
      rMstCode[i].FCodeName := BufferToString(buffer.FieldValue(1));
      rMstCode[i].FParentId := BufferToInteger(buffer.FieldValue(2));
      rMstCode[i].FLevel    := BufferToInteger(buffer.FieldValue(3));
      rMstCode[i].FKode    := BufferToString(buffer.FieldValue(4));
      buffer.MoveNext;
    end;
  buffer.Destroy;

end;

function TMstCode.UpdateRak: boolean;
begin
  Result:= ExecTransaction(
  'update mst_rak set nama = '+FormatSQLString(FCodeName)+
  ' where rak_id = '+FormatSQLNumber(FCodeId),false);
end;

{ TMstRelation }

class function TMstRelation.activasi(id: integer): boolean;
begin
  try
    BeginSQL;
    ExecSQL(
    'update mst_relation set disabled_date = if(disabled_date is null, curdate(), null) '+
    'where relation_id = '+FormatSQLNumber(id));
    EndSQL;
    Result:= True;
  except raise;
    Inform(MSG_UNSUCCESS_UPDATE);
    UndoSQL;
    Result:= False;
  end;

end;

{class function TMstRelation.Adjustment(vId: integer; vReal: double): boolean;
var db_cr: char; vCurrent: double;
begin
  try
    BeginSQL;
    vCurrent:= getFloatFromSQL(
      'select current_debt from mst_relation where relation_id = '+FormatSQLNumber(vId));

    if (vReal - vCurrent) > 0 then db_cr:= DB_CR_TYPE_DEBIT
    else db_cr:= DB_CR_TYPE_CREDIT;

    save_debt_balance (vId, ServerNow, abs(vReal - vCurrent), db_cr);
    EndSQL;
    Result:= True;
  except
    UndoSQL;
    Result:= False;
    Inform(MSG_UNSUCCESS_UPDATE);
  end;
end;}

{class function TMstRelation.GetBalanceAkhir(vId: integer): double;
begin
  Result:= getFloatFromSQL('select ifnull(current_debt,0) from mst_relation '+
  'where relation_id = '+FormatSQLNumber(vId));
end;
}
constructor TMstRelation.Create;
begin
  FRelationAnimal := _MstRelationAnimal_Arr.Create(Self);
end;

class function TMstRelation.Delete(id: integer): boolean;
begin
   //
   try
    BeginSQL;
    ExecSQL('delete from mst_relation_animal where relation_id = '+FormatSQLNumber(id));
    ExecSQL('delete from mst_relation_service where relation_id = '+FormatSQLNumber(id));
    ExecSQL('delete from mst_relation where relation_id = '+FormatSQLNumber(id));
    EndSQL;
    Result:= True;
  except raise;
    Inform('Data tidak bisa dihapus, kemungkinan sudah ada transaksi untuk data ini');
    UndoSQL;
    Result:= False;
  end;

end;

class function TMstRelation.deleteAnimal(relationId,
  seq: integer): boolean;
begin
  Result := ExecuteSQL('delete from mst_relation_animal where relation_id ='+FormatSQLNumber(relationId)+' and seq='+FormatSQLNumber(seq));
end;

destructor TMstRelation.Destroy;
begin
  FRelationAnimal.Free;
  inherited;
end;

class function TMstRelation.getAnimalName(aRelationId,
  Seq: integer): string;
  var sql:string;
begin
  sql := 'select animal_name from mst_relation_animal where relation_id ='+
    FormatSQLNumber(aRelationId)+'  and seq = '+FormatSQLNumber(Seq);
  Result := getStringFromSQL(sql);
end;

class function TMstRelation.GetDiscount(vId: integer): Double;
begin
  Result:= getFloatFromSQL(
  'select ifnull(discount,0) from mst_relation '+
     ' where relation_id = '+FormatSQLNumber(vId));
end;

class function TMstRelation.getJenisAnimal(aRelationId, seq: integer;
  var jenisId:integer): string;
var sql:string;
begin
  sql := 'select animal_id from mst_relation_animal where relation_id = '+FormatSQLNumber(aRelationId)+
      ' and seq = '+FormatSQLNumber(seq);
  jenisId := getIntegerFromSQL(sql);
  sql := 'select animal from mst_animal where animal_id = '+FormatSQLNumber(jenisId);
  Result := getStringFromSQL(sql);
end;

class procedure TMstRelation.getListAnimal(aRelationId: integer;
  aList: TStringList;cekHolded:boolean=false);
begin
  SQLToNameValueList(aList,'select seq,animal_name from mst_relation_animal a '+
    ' where a.relation_id = '+FormatSQLNumber(aRelationId)+
    IfThen(cekHolded,' and seq not in (select animal_seq from trs_holded_mst where pasien_id = a.relation_id) ')+
    ' order by a.animal_name ');
end;

class procedure TMstRelation.getListAnimal2(aRelationId: integer;
  aList: TStringList; cekHolded: boolean);
var sql,animal_seq,tmp:string;
    i:integer;
begin
  if cekHolded then begin
     animal_seq := '';
     tmp := getStringFromSQL('select animal_seq from trs_holded_mst where pasien_id = '+FormatSQLNumber(aRelationId));
     if (tmp = '') then
       animal_seq := '-1'
     else begin
          for i:=1 to HitungChar(tmp,';') do
              animal_seq := animal_seq + EkstrakString(tmp,';',i)+',';
          animal_seq := copy(animal_seq,0,length(animal_seq)-1);
     end;
       
  end;
  sql := 'select concat(seq,'';'',a.animal_id),concat(animal_name,''('',animal,'')'') '+
   ' from mst_relation_animal a left join mst_animal m on a.animal_id = m.animal_id '+
    ' where a.relation_id = '+FormatSQLNumber(aRelationId)+
    IfThen(cekHolded,' and seq not in ('+animal_seq+') ')+
    ' order by a.animal_name ';
  SQLToNameValueList(aList,sql);

end;

class procedure TMstRelation.getListFreeService(aRelationId: integer;
  var aList: TStringList);
var sql:string;  
begin
    sql:= 'select bonus_service,bonus_jml from mst_relation_service r inner join mst_service_bonus b on b.service_type=r.service_type '+
          ' where relation_id = '+FormatSQLNumber(aRelationId)+' and r.jumlah >= b.jml_service ';
   SQLToNameValueList(aList,sql);
end;

class function TMstRelation.GetName(vId: integer): string;
begin
  Result:= getStringFromSQL
  ('select concat(relation_name, '' ('', relation_code, '')'') from mst_relation where relation_id = '+FormatSQLNumber(vId));
end;

function TMstRelation.GetNextCode(vTipe: integer): string;
var prefix: string;
begin
  case vTipe of
    RELASI_TYPE_CUSTOMER: prefix:= 'CS.';
    RELASI_TYPE_SUPPLIER: prefix:= 'SP.';//UpperCase(Copy(FRelationName, 1,1))+'.';
    RELASI_TYPE_MEMBER  : prefix:= 'MM.';
    RELASI_TYPE_SALESMAN: prefix:= 'SM.';
  end;
  Result:= getNextIDNum('relation_code','mst_relation',' and relation_type ='+FormatSQLNumber(vTipe),prefix,'',3);
end;

{class function TMstRelation.GetSaldoAwal(vId: integer;
  vDate: TDate): Double;
begin
  Result:= getFloatFromSQL
  ('select ifnull(balance,0) from fin_debt_balance where relation_id = '+FormatSQLNumber(vId)+
   ' and balance_date = ('+
     'select max(balance_date) from fin_debt_balance '+
     'where relation_id = '+FormatSQLNumber(vId)+
     ' and balance_date < '+FormatSQLDate(vDate)+')');
end;}

class function TMstRelation.GetSaldoAwal(vId: integer;
  vDate: TDate): Double;
begin
  Result:= getFloatFromSQL(
  'select ifnull(sum(balance),0) from inv_relation_balance b1 '+
  'where balance_date = ('+
     'select max(b2.balance_date) from inv_relation_balance b2 '+
     'where b2.balance_date < '+FormatSQLDate(vDate) +
     ' and b2.relation_id = '+FormatSQLNumber(vId)+')' +
  ' and b1.relation_id = '+FormatSQLNumber(vId));
end;

function TMstRelation.InsertOnDB: boolean;
begin
  FRelationCode:= GetNextCode(FRelationType);
  Result:= ExecTransaction(
    'insert into mst_relation '+
      '(relation_type, relation_code, relation_name, address1, address2, post_code, '+
       'city, phone1, phone2, contact_person, npwp,discount,wajib_discount,barcode, due_date) '+
    'values ('+
      FormatSQLNumber(FRelationType)+','+
      FormatSQLString(FRelationCode)+','+
      FormatSQLString(FRelationName)+','+
      FormatSQLString(FAddress1)+','+
      FormatSQLString(FAddress2)+','+
      FormatSQLString(FPostCode)+','+
      FormatSQLString(FCity)+','+
      FormatSQLString(FPhone1)+','+
      FormatSQLString(FPhone2)+','+
      FormatSQLString(FContactPerson)+','+
      FormatSQLString(FNPWP)+','+
      IfThen(FRelationType=RELASI_TYPE_CUSTOMER,FormatSQLNumber(FDiscount),'0')+','+
      IfThen(FRelationType=RELASI_TYPE_CUSTOMER,FormatSQLNumber(FWajibDiscount),'0')+','+
      FormatSQLString(FBarcode)+','+
      FormatSQLNumber(FDueDate)+')');
      if Result then begin
        FRelationID:= getIntegerFromSQL('select relation_id from mst_relation where relation_code ='+FormatSQLString(FRelationCode));
        Inform(MSG_SUCCESS_SAVING);
      end;
end;

function TMstRelation.isExistInDb(id: string; tipe: integer): boolean;
begin
  Result:= getIntegerFromSQL(
  'select count(*) from mst_relation where relation_code = '+FormatSQLString(id)+
  ' and relation_type = '+FormatSQLNumber(tipe)) > 0;
end;

class function TMstRelation.isFreeService(aRelationId,
  aServiceType: integer): boolean;
begin
  Result := getBooleanFromSQL('select is_free('+FormatSQLNumber(aRelationId)+','+FormatSQLNumber(aServiceType)+')');
end;

class function TMstRelation.isFreeServiceText(
  aRelationId: integer): string;
begin
  Result := getStringFromSQL('select is_free_text('+FormatSQLNumber(aRelationId)+')');
end;

function TMstRelation.loadAnimal: TMysqlResult;
var sql:string;
begin
  sql :='SELECT a.relation_id,a.seq,a.animal_name, a.animal_id, a.race, a.eat, a.age, a.sex, a.disabled '+
        ' FROM mst_relation_animal a inner join mst_relation r ON r.relation_id = a.relation_id '+
          ' WHERE r.relation_id = '+FormatSQLNumber(RelationID)+
          ' order by seq ';
  Result := OpenSQL(sql);
end;

function TMstRelation.loadService: TMysqlResult;
var sql:string;
begin
  sql :='select m.mst_id,mst_name,r.jumlah,r.total '+
      ' ,b.is_kumulatif,b.jml_service,b.bonus_service,b.bonus_jml '+
      ' from mst_master m left join mst_relation_service r on r.service_type = m.mst_id and r.relation_id = '+FormatSQLNumber(FRelationID)+
      ' left join mst_service_bonus b on b.service_type = m.mst_id '+
      ' where m.mst_tipe= '+FormatSQLNumber(MST_TYPE_SERVICE);
  Result := OpenSQL(sql);

end;

function TMstRelation.loadServiceDetail(
  aServiceType: integer): TMysqlResult;
var sql:string;
begin
  sql :='select m.trans_date,sum(d.quantity) '+
      ' from  trs_sales_mst m inner join trs_sales_detail d on d.sales_id = m.sales_id '+
      ' where m.pasien_id = '+FormatSQLNumber(FRelationID)+
          ' and d.service_type= '+FormatSQLNumber(aServiceType)+
          ' group by m.trans_date '+
          ' order by m.trans_date desc ';
  Result := OpenSQL(sql);


end;

procedure TMstRelation.Reset;
begin
  inherited;
  FRelationAnimal.Clear;
  FWajibDiscount := 0;
  FBarcode := '';
  FJenisMember := 0;
end;

function TMstRelation.saveAnimal: boolean;
var i:integer;sql:string;sudahAda :boolean;
begin
  try
    BeginSQL;
    for i:= 0 to FRelationAnimal.Count-1 do begin
      sudahAda := getIntegerFromSQL('SELECT count(*) from mst_relation_animal '+
            ' WHERE relation_id = '+FormatSQLNumber(RelationID)+
            ' and seq = '+FormatSQLNumber(i+1))>0;
      if sudahAda then
        sql :=  'UPDATE Mst_Relation_Animal SET'+
          ' Animal_Name='+FormatSQLString(FRelationAnimal[i].AnimalName)+','+
          ' Animal_ID='+FormatSQLNumber(FRelationAnimal[i].AnimalID)+','+
          ' Race='+FormatSQLString(FRelationAnimal[i].Race)+','+
          ' Eat='+FormatSQLString(FRelationAnimal[i].Eat)+','+
          ' Age='+FormatSQLString(FRelationAnimal[i].Age)+','+
          ' Sex='+FormatSQLNumber(FRelationAnimal[i].Sex)+
//          ' Disabled='+FormatSQLNumber(FDisabled)+
    ' WHERE Relation_ID='+FormatSQLNumber(RelationID)+
      ' AND Seq='+FormatSQLNumber(FRelationAnimal[i].Seq)
      else
        sql := 'INSERT INTO Mst_Relation_Animal (Relation_ID,Seq,Animal_Name,Animal_ID,Race,Eat,Age,Sex)'+
    ' VALUES ('+
      FormatSQLNumber(FRelationAnimal[i].RelationID)+','+
      FormatSQLNumber(FRelationAnimal[i].Seq)+','+
      FormatSQLString(FRelationAnimal[i].AnimalName)+','+
      FormatSQLNumber(FRelationAnimal[i].AnimalID)+','+
      FormatSQLString(FRelationAnimal[i].Race)+','+
      FormatSQLString(FRelationAnimal[i].Eat)+','+
      FormatSQLString(FRelationAnimal[i].Age)+','+
      FormatSQLNumber(FRelationAnimal[i].Sex)+')';
      ExecSQL(sql);
    end;

    EndSQL;
    Result := true;
  except
      Result := False;
      UndoSQL;
  end;
end;

function TMstRelation.SelectID: boolean;
var buffer: TMysqlResult;
begin
  buffer:= OpenSQL(
  'select relation_code, relation_name, address1, city from mst_relation '+
  'where relation_id = '+FormatSQLNumber(FRelationId));

  result:= buffer.RecordCount > 0;
  Self.Reset;
  if Result then
    with buffer do begin
      FRelationCode := BufferToString(FieldValue(0));
      FRelationName := BufferToString(FieldValue(1));
      FAddress1     := BufferToString(FieldValue(2));
      FCity         := BufferToString(FieldValue(3));
    end;
  buffer.Destroy;
end;

function TMstRelation.SelectInDB: boolean;
var buffer: TMysqlResult;
begin
  buffer:= OpenSQL(
    'select relation_id, relation_type, relation_code, relation_name, address1, address2, '+
    'post_code, city, phone1, phone2, due_date, current_debt, contact_person, npwp,discount,wajib_discount,jenis_member,barcode '+
    'from mst_relation '+
    IfThen(FRelationId <> 0,
    'where relation_id = '+FormatSQLNumber(FRelationId),
    'where ((relation_code = '+FormatSQLString(FRelationCode)+') or (barcode = '+FormatSQLString(FBarcode)+ '))'
    ));

  result:= buffer.RecordCount > 0;
  Self.Reset;
  if Result then
    with buffer do begin
      FRelationId   := BufferToInteger(FieldValue(0));
      FRelationType := BufferToInteger(FieldValue(1));
      FRelationCode := BufferToString(FieldValue(2));
      FRelationName := BufferToString(FieldValue(3));
      FAddress1     := BufferToString(FieldValue(4));
      FAddress2     := BufferToString(FieldValue(5));
      FPostCode     := BufferToString(FieldValue(6));
      FCity         := BufferToString(FieldValue(7));
      FPhone1       := BufferToString(FieldValue(8));
      FPhone2       := BufferToString(FieldValue(9));
      FDueDate      := BufferToInteger(FieldValue(10));
      FCurrentDebt  := BufferToFloat(FieldValue(11));
      FContactPerson:= BufferToString(FieldValue(12));
      FNPWP         := BufferToString(FieldValue(13));
      FDiscount     := BufferToFloat(FieldValue(14));
      FWajibDiscount := BufferToInteger(FieldValue(15));
      FJenisMember  := BufferToInteger(FieldValue(16));
      FBarcode  := BufferToString(FieldValue(17));
    end;
  buffer.Destroy;
end;

class function TMstRelation.statusRS(id, sttID: integer): boolean;
begin
  try
    BeginSQL;
    ExecSQL(
    'update mst_relation set status_id = '+FormatSQLNumber(sttID)+
    ' where relation_id = '+FormatSQLNumber(id));
    EndSQL;
    Result:= True;
  except raise;
    Inform(MSG_UNSUCCESS_UPDATE);
    UndoSQL;
    Result:= False;
  end;

end;

function TMstRelation.UpdateOnDB: boolean;
begin
  Result:= ExecTransaction(
    'update mst_relation set '+
      ' relation_type= '+FormatSQLNumber(FRelationType)+','+
      ' relation_code= '+FormatSQLString(FRelationCode)+','+
      ' relation_name= '+FormatSQLString(FRelationName)+','+
      ' address1= '+FormatSQLString(FAddress1)+','+
      ' address2= '+FormatSQLString(FAddress2)+','+
      ' post_code= '+FormatSQLString(FPostCode)+','+
      ' city= '+FormatSQLString(FCity)+','+
      ' phone1= '+FormatSQLString(FPhone1)+','+
      ' phone2= '+FormatSQLString(FPhone2)+','+
      ' npwp= '+FormatSQLString(FNPWP)+','+
      ' contact_person = '+FormatSQLString(FContactPerson)+','+
      ' barcode = '+FormatSQLString(FBarcode)+','+
      ' jenis_member = '+FormatSQLNumber(FJenisMember)+','+
      IfThen(FRelationType=RELASI_TYPE_CUSTOMER,' discount = '+FormatSQLNumber(FDiscount)+',')+
      IfThen(FRelationType=RELASI_TYPE_CUSTOMER,' wajib_discount = '+FormatSQLNumber(FWajibDiscount)+',')+
      ' due_Date= '+FormatSQLNumber(FDueDate)+
    ' where relation_id= '+FormatSQLNumber(FRelationId), False);
    if Result then
      Inform(MSG_SUCCESS_UPDATE);
end;

{ TMstRelationArr }

function TMstRelationArr.FindOnDb: boolean;
var sqL: string; buffer: TMysqlResult; i: integer;
begin
  sqL:=
   'select relation_id, relation_type, relation_code, relation_name, address1, address2, '+
   'city, post_code, phone1, phone2, contact_person, due_date, current_debt, disabled_date '+
    'from mst_relation '+
    'where relation_type = '+FormatSQLString(GlobalFilter.TipeID);

  if GlobalFilter.Name <> '' then
    sqL:= sqL + ' and relation_name like '+FormatSQLString('%'+GlobalFilter.Name+'%');
  if GlobalFilter.StatusID = 0 then
    sqL:= sqL + ' and disabled_date is null '
  else sqL:= sqL + ' and disabled_date is not null ';

  buffer:= OpenSQL(sqL + ' order by relation_name');
  result:= buffer.RecordCount > 0;
  Self.Clear;
  if Result then
    for i:= 0 to buffer.RecordCount-1 do begin
      Self.Add(
      BufferToInteger(buffer.FieldValue(0)),
      BufferToInteger(buffer.FieldValue(1)),
      BufferToString(buffer.FieldValue(2)),
      BufferToString(buffer.FieldValue(3)),
      BufferToString(buffer.FieldValue(4)),
      BufferToString(buffer.FieldValue(5)),
      BufferToString(buffer.FieldValue(6)),
      BufferToString(buffer.FieldValue(7)),
      BufferToString(buffer.FieldValue(8)),
      BufferToString(buffer.FieldValue(9)),
      BufferToString(buffer.FieldValue(10)),
      BufferToInteger(buffer.FieldValue(11)),
      BufferToFloat(buffer.FieldValue(12)),
      BufferToDateTime(buffer.FieldValue(13)), 0,'','');
      buffer.MoveNext;
    end;
  buffer.Destroy;

end;

class function TMstRelationArr.LoadFromDB: TMysqlResult;
var sqL: string;
begin
  sqL:=
   'select relation_id, relation_code as KD, relation_name as Nama, '+
   'if(address1 <> '''', '+
      'if(address2 <> '''', concat(address1, '';'', address2), address1), '+
      'address2) as alamat, city as Kota, '+
   'if(phone1 <> '''', '+
      'if(fax <> '''', concat(phone1, '';'', fax), phone1), '+
      'fax) as ''Phone/Fax'', '+
   'contact_person as ''Kontak Person'', '+
    'case when jenis_member='+FormatSQLNumber(JENIS_MEMBER_BREEDER)+' then ''Breeder'' when jenis_member='+FormatSQLNumber(JENIS_MEMBER_PETSHOP)+' then ''Sesama Petshop'' else ''Reguler'' end as ''Jenis Member'' '+
   ',current_debt as Saldo, current_point as Point '+

   'from mst_relation where relation_type = '+FormatSQLString(GlobalFilter.TipeID);

  if GlobalFilter.Name <> '' then
    sqL:= sqL + ' and relation_name like '+FormatSQLString('%'+GlobalFilter.Name+'%');
  if GlobalFilter.FString1 <> '' then
    sqL:= sqL + ' and address1 like '+FormatSQLString('%'+GlobalFilter.FString1+'%');
  if GlobalFilter.FString2 <> '' then
    sqL:= sqL + ' and city like '+FormatSQLString('%'+GlobalFilter.FString2+'%');

  if GlobalFilter.StatusID = 1 then sqL:= sqL + ' and disabled_date is null '
  else if GlobalFilter.StatusID = 2 then sqL:= sqL + ' and disabled_date is not null ';

  Result:= OpenSQL(sqL + ' order by relation_name');
end;

{ TPointMaping }

procedure TPointMaping.InsertOnDB;
begin
  if not Self.isExistInDb(FCodeId, RootId) then
    ExecSQL(
      'insert into point_maping (code_id, root_id) '+
      'values ('+
        FormatSQLNumber(FCodeId)+','+
        FormatSQLNumber(FRootId)+')');
end;

procedure TPointMaping.InsertRak;
begin
  if not Self.isExistRakInDb(FCodeId, RootId) then
    ExecSQL(
      'insert into mst_rak_maping (rak_id, root_id) '+
      'values ('+
        FormatSQLNumber(FCodeId)+','+
        FormatSQLNumber(FRootId)+')');
end;

function TPointMaping.isExistInDb(code, root: integer): boolean;
begin
  Result:= getIntegerFromSQL
    ('select count(*) from point_maping where code_id = '+FormatSQLNumber(code)+
     ' and root_id = '+FormatSQLNumber(root)) > 0;
end;

function TPointMaping.isExistRakInDb(code, root: integer): boolean;
begin
  Result:= getIntegerFromSQL
    ('select count(*) from mst_rak_maping where rak_id = '+FormatSQLNumber(code)+
     ' and root_id = '+FormatSQLNumber(root)) > 0;
end;

{ tMstItemConversion }

class function TMstItemConversion.GetCodeUnit(ItemId: integer): string;
begin
  Result:= getStringFromSQL(
  'select mst_code from mst_item_conversion c, mst_master u '+
  'where c.unit_id = u.mst_id and c.conversion = 1 and c.item_id = '+FormatSQLNumber(ItemID));
end;

class function TMstItemConversion.GetConversionId(ItemID: integer): integer;
begin
  Result:= getIntegerFromSQL(
  'select conv_id from mst_item_conversion '+
  'where item_id = '+FormatSQLNumber(ItemID)+' and conversion = 1 ');
end;

class function TMstItemConversion.GetSalesPriceDesc(
  ItemID: integer): string;
var priceList: TMysqlResult; i: integer;
begin
  Result:= '';
  priceList:= OpenSQL(
  'select sales_price, u.mst_code '+
  'from mst_item_conversion c, mst_master u '+
  'where c.unit_id = u.mst_id and c.item_id = '+FormatSQLNumber(ItemID)+
  ' order by c.conversion ');

  for i:= 0 to priceList.RecordCount-1 do
  begin
    Result:= Result + FloatToStrFmt(BufferToFloat(priceList.FieldValue(0)))+' / '+BufferToString(priceList.FieldValue(1))+#13#10;
    priceList.MoveNext;
  end;
  priceList.Destroy;

end;

class function TMstItemConversion.GetStockDescription(
  ItemID, stok: integer): string;
var unitList: TMysqlResult; i, qty_dived, qty_diver: integer;
begin
  Result:= '';
  unitList:= OpenSQL(
  'select c.conversion, u.mst_code '+
  'from mst_item_conversion c, mst_master u '+
  'where c.unit_id = u.mst_id and c.item_id = '+FormatSQLNumber(ItemID)+
  ' order by c.conversion desc ');

  for i:= 0 to unitList.RecordCount-1 do
  begin
    if stok = 0 then break;

    qty_diver:= round(BufferToFloat(unitList.FieldValue(0)));
    qty_dived:= stok div qty_diver;
    stok:= stok mod qty_diver;
    Result:= Result + FloatToStrFmt(qty_dived) +'-'+BufferToString(unitList.FieldValue(1))+' ';
    unitList.MoveNext;
  end;
  unitList.Destroy;

end;

class function TMstItemConversion.GetStockDescriptionEnter(ItemID,
  stok: integer): string;
begin

end;

class function TMstItemConversion.GetUnit(ItemID: integer;
  UnitCode: string): TMysqlResult;
begin
  Result:= OpenSQL(
  'select k.conv_id, k.conversion, s.mst_code from mst_master s, mst_item i, mst_item_conversion k '+
  'where s.mst_id = k.unit_id and k.item_id = i.item_id '+
  'and i.item_id = '+IntToStr(ItemID)+
  ' and s.mst_code = '+QuotedStr(UnitCode));
end;

function tMstItemConversion.InsertOnDB: boolean;
begin
  Result:= ExecTransaction2(
    'insert into mst_item_conversion (item_id, unit_id, '+
      'conversion, cost_price, purchase_price, sales_price, sales_price2, sales_price3, '+
      'item_tax, item_discount, disc_tipe, net_price)'+
    'values ('+
      FormatSQLNumber(FItemId)+','+
      FormatSQLNumber(FMstMaster.MstId)+','+
      FormatSQLNumber(FConversion)+','+
      FormatSQLNumber(FCostPrice)+','+
      FormatSQLNumber(FPurchasePrice)+','+
      FormatSQLNumber(FSalesPrice)+','+
      FormatSQLNumber(FSalesPrice2)+','+
      FormatSQLNumber(FSalesPrice3)+','+
      FormatSQLNumber(FItemTax)+','+
      FormatSQLNumber(FItemDiscount)+','+
      FormatSQLNumber(FDiscTipe)+','+
      FormatSQLNumber(FNetPrice)+')');

end;

class function TMstItemConversion.lookupPrice(convId,
  relasiId: integer): double;
begin
  Result:= getFloatFromSQL(
    'select ifnull(price,0) from set_price_deal '+
    'where relation_id = '+FormatSQLNumber(relasiId)+
    ' and conv_id = '+FormatSQLNumber(convId));
end;

function TMstItemConversion.SelectForBOS: boolean;
var sqL: string; buffer: TMysqlResult;
begin
  sqL:=
  'select c.conv_id, c.conversion, c.sales_price, c.purchase_price, c.sales_price2, '+
   '(select u.mst_code from mst_master u where u.mst_id = c.unit_id) as satuan '+
  'from mst_item_conversion c  '+
  'where c.conversion = 1 and c.item_id = '+FormatSQLNumber(FItemId);
  buffer:= OpenSQL(sqL);
  result:= buffer.RecordCount > 0;
  Self.Reset;
  if Result then begin
    with buffer do begin
      FConvId     := BufferToInteger(FieldValue(0));
      FConversion := BufferToFloat(FieldValue(1));
      FSalesPrice := BufferToFloat(FieldValue(2));
      FPurchasePrice := BufferToFloat(FieldValue(3));
      FSalesPrice2 := BufferToFloat(FieldValue(4));
      FMstMaster.MstCode:= FieldValue(5);
    end;
  end;
  buffer.Destroy;
end;

function TMstItemConversion.SelectForPOS: boolean;
var sqL: string; buffer: TMysqlResult;
begin
  sqL:=
    'select c.conv_id, c.conversion, c.sales_price, '+
     '(select u.mst_code from mst_master u where u.mst_id = c.unit_id) as satuan, '+
    'c.purchase_price '+
    'from mst_item_conversion c  '+
    'where c.conversion = 1 and c.item_id = '+FormatSQLNumber(FItemId);
  buffer:= OpenSQL(sqL);
  result:= buffer.RecordCount > 0;
  Self.Reset;
  if Result then begin
    with buffer do begin
      FConvId     := BufferToInteger(FieldValue(0));
      FConversion := BufferToFloat(FieldValue(1));
      FSalesPrice := BufferToFloat(FieldValue(2));
      FPurchasePrice := BufferToFloat(FieldValue(4));
      FMstMaster.MstCode:= FieldValue(3);
    end;
  end;
  buffer.Destroy;
end;

function TMstItemConversion.SelectInDB: boolean;
var sqL: string; buffer: TMysqlResult;
begin
  sqL:=
    'select u.mst_code, c.conv_id, c.unit_id, c.item_id, '+
      'c.conversion, c.cost_price, c.purchase_price, c.sales_price, c.sales_price2 '+
    'from mst_item_conversion c, mst_master u '+
    'where c.unit_id = u.mst_id '+
    IfThen(FConvId <> 0, ' and c.conv_id = '+FormatSQLNumber(FConvId))+

    IfThen(FItemId <> 0,
      IfThen(FConvId <> 0,
        ' and c.item_id = '+FormatSQLNumber(FItemId),
        ' and c.conversion = 1 and c.item_id = '+FormatSQLNumber(FItemId)
      )
    );
  buffer:= OpenSQL(sqL);
  result:= buffer.RecordCount > 0;
  Self.Reset;
  if Result then
    with buffer do begin
      FMstMaster.MstCode:= BufferToString(FieldValue(0));
      FMstMaster.MstName:= BufferToString(FieldValue(0));
      FConvId       := BufferToInteger(FieldValue(1));
      FMstMaster.MstId := BufferToInteger(FieldValue(2));
      FItemId       := BufferToInteger(FieldValue(3));
      FConversion   := BufferToFloat(FieldValue(4));
      FCostPrice    := BufferToFloat(FieldValue(5));
      FPurchasePrice:= BufferToFloat(FieldValue(6));
      FSalesPrice   := BufferToFloat(FieldValue(7));
      FSalesPrice2  := BufferToFloat(FieldValue(8));
    end;
  buffer.Destroy;

end;

function TMstItemConversion.SelectInDB3: boolean;
var sqL: string; buffer: TMysqlResult;
begin
  sqL:=
  'select c.conv_id, c.conversion, c.purchase_price, u.mst_code, c.item_tax, '+
  'c.item_discount, c.disc_tipe, c.sales_price '+
  'from mst_item_conversion c, mst_master u '+
  'where c.unit_id = u.mst_id and c.item_id = '+FormatSQLNumber(FItemId)+
  ' order by c.conversion limit 1';

  buffer:= OpenSQL(sqL);
  result:= buffer.RecordCount > 0;
  Self.Reset;
  if Result then
    with buffer do begin
      FConvId       := BufferToInteger(FieldValue(0));
      FConversion   := BufferToFloat(FieldValue(1));
      FPurchasePrice:= BufferToFloat(FieldValue(2));
      FNetPrice     := BufferToFloat(FieldValue(2));
      FSalesPrice   := BufferToFloat(FieldValue(7));
      FMstMaster.MstCode:= BufferToString(FieldValue(3));
      FMstMaster.MstName:= BufferToString(FieldValue(3));
      FItemTax      := BufferToFloat(FieldValue(4));
      FItemDiscount := BufferToFloat(FieldValue(5));
      FDiscTipe     := BufferToInteger(FieldValue(6));
    end;
  buffer.Destroy;
end;

function TMstItemConversion.SelectInDB4: boolean;
var sqL: string; buffer: TMysqlResult;
begin
  sqL:=
  'select c.conv_id, c.conversion, c.purchase_price, c.item_tax, c.item_discount, c.disc_tipe '+
  'from mst_item_conversion c '+
  'where c.conv_id = '+FormatSQLNumber(FConvID);

  buffer:= OpenSQL(sqL);
  result:= buffer.RecordCount > 0;
  Self.Reset;
  if Result then
    with buffer do begin
      FConvId       := BufferToInteger(FieldValue(0));
      FConversion   := BufferToFloat(FieldValue(1));
      FPurchasePrice:= BufferToFloat(FieldValue(2));
      FItemTax      := BufferToFloat(FieldValue(3));
      FItemDiscount := BufferToFloat(FieldValue(4));
      FDiscTipe     := BufferToInteger(FieldValue(5));
    end;
  buffer.Destroy;

end;

function tMstItemConversion.UpdateOnDB: boolean;
begin
  Result:= ExecTransaction2(
  'update mst_item_conversion set '+
  'item_id = '+FormatSQLNumber(FItemId)+','+
  'unit_id= '+FormatSQLNumber(FMstMaster.MstId)+','+
  'conversion = '+FormatSQLNumber(FConversion)+','+
  'cost_price = '+FormatSQLNumber(FCostPrice)+','+
  'purchase_price = '+FormatSQLNumber(FPurchasePrice)+','+
  'sales_price = '+FormatSQLNumber(FSalesPrice)+','+
  'sales_price2 = '+FormatSQLNumber(FSalesPrice2)+','+
  'item_tax = '+FormatSQLNumber(FItemTax)+','+
  'item_discount = '+FormatSQLNumber(FItemDiscount)+','+
  'disc_tipe = '+FormatSQLNumber(FDiscTipe)+','+
  'net_price = '+FormatSQLNumber(FNetPrice)+','+
  'sales_price3 = '+FormatSQLNumber(FSalesPrice3)+
  ' where conv_id = '+FormatSQLNumber(FConvId));
end;

class procedure TMstItemConversion.UpdatePrice(convId: integer;
  newPrice: double);
begin
  ExecSQL(
  'update mst_item_conversion set sales_price  = '+FormatSQLNumber(newPrice)+
  ' where conv_id = '+FormatSQLNumber(convId));
end;

{ TMstItemConversionArr }

function TMstItemConversionArr.Add: integer;
begin
  setLength(FItemConversion_Arr, length(FItemConversion_Arr)+1);
  Result := high(FItemConversion_Arr);
  FItemConversion_Arr[Result] := TMstItemConversion.Create;
end;

procedure TMstItemConversionArr.Clear;
var i: integer;
begin
  for i:=0 to high(FItemConversion_Arr) do FItemConversion_Arr[i].Destroy;
  setLength(FItemConversion_Arr,0);
end;

function TMstItemConversionArr.Count: integer;
begin
  Result := length(FItemConversion_Arr);
end;

constructor TMstItemConversionArr.Create;
begin
  inherited Create;
  setLength(FItemConversion_Arr,0);
end;

destructor TMstItemConversionArr.Destroy;
begin
  Self.Clear;
  inherited;
end;

function TMstItemConversionArr.Get(Index: integer): TMstItemConversion;
begin
  if (Index<0) or (Index>high(FItemConversion_Arr)) then Result := nil
  else Result := FItemConversion_Arr[Index];
end;

class procedure TMstItemConversionArr.getList(AList: TStringList;
  AItemId: integer; AItems: TStrings);
begin

  SQLToNameValueList(AList,
    'select c.conv_id, u.mst_name from mst_master u, mst_item_conversion c '+
    'where u.mst_id = c.unit_id '+
    IfThen(AItemId <> 0, 'and item_id = '+FormatSQLNumber(AItemId))+
    ' order by c.conversion');

  if AItems <> nil then
    NameValueListToValueList(AList, AItems);
    
end;

class procedure TMstItemConversionArr.getList2(AList: TStringList; ATipe: integer);
begin
  SQLToNameValueList(AList,
    'select mst_id, mst_name from mst_master '+
    'where mst_tipe = '+FormatSQLNumber(ATipe)+' order by mst_name');
end;

function TMstItemConversionArr.LoadFromDb(AItemId, AConvType: integer): boolean;
var sqL: string; buffer: TMysqlResult; i: integer;
begin
  sqL:=
    'select u.mst_name, c.conv_id, c.unit_id, c.item_id, '+
      'c.conversion, c.cost_price, c.purchase_price, c.sales_price, c.sales_price2, c.sales_price3, '+
      'c.net_price, c.item_tax, c.item_discount, c.disc_tipe '+

    'from mst_item_conversion c, mst_master u '+
    'where c.unit_id = u.mst_id and c.item_id = '+FormatSQLNumber(AItemId)+
    ' order by c.conversion';

  buffer:= OpenSQL(sqL);
  result:= buffer.RecordCount > 0;
  Self.Clear;
  if Result then
    for i:= 0 to buffer.RecordCount -1 do
      with buffer do begin
        Self.Add;
        FItemConversion_Arr[i].MstMaster.MstName:= BufferToString(FieldValue(0));
        FItemConversion_Arr[i].ConvId:= BufferToInteger(FieldValue(1));
        FItemConversion_Arr[i].MstMaster.MstId:= BufferToInteger(FieldValue(2));
        FItemConversion_Arr[i].ItemId:= BufferToInteger(FieldValue(3));
        FItemConversion_Arr[i].Conversion:= BufferToFloat(FieldValue(4));
        FItemConversion_Arr[i].CostPrice:= BufferToFloat(FieldValue(5));
        FItemConversion_Arr[i].PurchasePrice:= BufferToFloat(FieldValue(6));
        FItemConversion_Arr[i].SalesPrice:= BufferToFloat(FieldValue(7));
        FItemConversion_Arr[i].SalesPrice2:= BufferToFloat(FieldValue(8));
        FItemConversion_Arr[i].SalesPrice3:= BufferToFloat(FieldValue(9));
        FItemConversion_Arr[i].NetPrice:= BufferToFloat(FieldValue(10));
        FItemConversion_Arr[i].ItemTax:= BufferToFloat(FieldValue(11));
        FItemConversion_Arr[i].ItemDiscount:= BufferToFloat(FieldValue(12));
        FItemConversion_Arr[i].DiscTipe:= BufferToInteger(FieldValue(13));
        MoveNext;
      end;
  buffer.Destroy;
end;

{ TMstItem }

class function TMstItem.activasi(id: integer): boolean;
begin
  try
    BeginSQL;
    ExecSQL(
    'update mst_item set disabled_date = if(disabled_date is null, curdate(), null) '+
    'where item_id = '+FormatSQLNumber(id));
    EndSQL;
    Result:= True;
    Inform(MSG_SUCCESS_UPDATE);
  except raise;
    Inform(MSG_UNSUCCESS_UPDATE);
    UndoSQL;
    Result:= False;
  end;
end;

function TMstItem.CekHarga: boolean;
var sqL: string; buffer: TMysqlResult;
begin
  sqL:=
  'select i.item_id, struk_name, current_stock '+
  'from mst_item i where barcode = '+FormatSQLString(FBarcode);
  buffer:= OpenSQL(sqL);
  result:= buffer.RecordCount > 0;
  Self.Clear;
  if Result then begin
    with buffer do begin
      FItemId   := BufferToInteger(FieldValue(0));
      FStrukName := BufferToString(FieldValue(6));
      FCurrentStock := BufferToFloat(FieldValue(7));
    end;
  end;
  buffer.Destroy;
end;

procedure TMstItem.Clear;
begin
  Self.Reset;
  BuyingPrice := 0;
  SellingPrice:=0;
  FItemConversion.Clear;
  FItemSeting.Clear;
  FRak.Clear;
end;

constructor TMstItem.Create;
begin
  inherited Create;
  FItemConversion:= TMstItemConversionArr.Create;
  FItemSeting:= _MstItemSetting_Arr.Create;
  FRak:= _MstRakItem_Arr.Create;
end;

class function TMstItem.DeleteItem(ID: integer): boolean;
begin
  try
    BeginSQL;
    ExecSQL('delete from mst_item where item_id = '+IntToStr(ID));
    EndSQL;
    Result:= True;
  except
    UndoSQL;
    Result:= False;
    Alert('Data tidak bisa dihapus');
  end;
end;

destructor TMstItem.Destroy;
begin
  FRak.Free;
  FItemConversion.Free;
  FItemSeting.Free;
  inherited;
end;

class function TMstItem.GetName(id: integer): string;
begin
  Result:= getStringFromSQL('select item_name from mst_item where item_id = '+FormatSQLNumber(id));
end;

class function TMstItem.GetNextCode(Spec: integer): string;
var prefix: string;
begin
{  prefix:= getStringFromSQL(
  'select distinct c.code_code from mst_code c, point_maping p '+
  'where c.code_id = p.code_id and p.root_id = '+IntToStr(Spec)+
  ' order by level limit 1');
  Result:= getNextIDNum('item_code','mst_item','',prefix,'',4);}

  prefix:='';// getStringFromSQL(
//  'select code_code from mst_code where code_id = '+IntToStr(Spec));
  Result:= getNextIDNum('item_code','mst_item','',prefix,'',4);

end;

class function TMstItem.GetRakDesc(AItemId: integer): string;
var i: integer; rak: TMysqlResult;
begin
  Result:= '';
  rak:= OpenSQL(
  'select nama from mst_rak r, mst_rak_item i '+
  'where r.rak_id = i.rak_id and i.item_id = '+IntToStr(AItemId));
  for i:= 0 to rak.RecordCount-1 do begin
    Result:= Result + rak.FieldValue(0);
    if (i < rak.RecordCount-1) then Result:= Result + #13#10;
    rak.MoveNext;
  end;
  rak.destroy;
end;

class function TMstItem.GetSaldoAkhir(AItemId, AStorageID: integer;
  vDate: TDate): Double;
var filter1, filter2: string;
begin
  filter1:= ' and item_id = '+FormatSQLNumber(AItemId);
  filter2:= ' and b2.item_id = '+FormatSQLNumber(AItemId);

  if AStorageID <> 0 then
    filter1:= filter1 + ' and storage_id = '+FormatSQLNumber(AStorageID);
  if AStorageID <> 0 then
    filter2:= filter2 + ' and b2.storage_id = '+FormatSQLNumber(AStorageID)
  else filter2:= filter2 + ' and b2.storage_id = b1.storage_id ';

  Result:= getFloatFromSQL(
  'select ifnull(sum(balance),0) from inv_item_balance b1 '+
  'where balance_date = ('+
     'select max(b2.balance_date) from inv_item_balance b2 '+
     'where b2.balance_date <= '+FormatSQLDate(vDate) + filter2 + ')' +filter1);
end;

class function TMstItem.GetSaldoAwal(AItemId, AStorageID: integer;
  vDate: TDate): Double;
var filter1, filter2: string;
begin
  filter1:= ' and item_id = '+FormatSQLNumber(AItemId);
  filter2:= ' and b2.item_id = '+FormatSQLNumber(AItemId);
  if AStorageID <> 0 then
    filter1:= filter1 + ' and storage_id = '+FormatSQLNumber(AStorageID);
  if AStorageID <> 0 then
    filter2:= filter2 + ' and b2.storage_id = '+FormatSQLNumber(AStorageID)
  else filter2:= filter2 + ' and b2.storage_id = b1.storage_id ';

  Result:= getFloatFromSQL(
  'select ifnull(sum(balance),0) from inv_item_balance b1 '+
  'where balance_date = ('+
     'select max(b2.balance_date) from inv_item_balance b2 '+
     'where b2.balance_date < '+FormatSQLDate(vDate) + filter2 + ')' +filter1);
end;

function TMstItem.InsertOnDB: boolean;
var sqL: string; i: integer; conv: Double;
begin
  sql:=
    'insert into mst_item ('+
    'specification, item_code, barcode, struk_name, merk, avg_price, '+
    'vendor_id, produsen_id, kemasan_id, bkp, konsinyasi, item_name, '+
    'dosis, kategori, expire_date) '+
    'values ('+
      FormatSQLNumber(MstCode.CodeId)+','+
      FormatSQLString(FItemCode)+','+
      FormatSQLString(FBarcode)+','+
      FormatSQLString(FStrukName)+','+
      FormatSQLString(FMerk)+','+
      FormatSQLNumber(FAvgPrice)+','+
      IfThen(FVendorID<>0,FormatSQLNumber(FVendorID), FormatSQLNULL)+','+
      IfThen(FProdusenID<>0,FormatSQLNumber(FProdusenID), FormatSQLNULL)+','+
      IfThen(FKemasanID<>0,FormatSQLNumber(FKemasanID), FormatSQLNULL)+','+
      FormatSQLNumber(FBKP)+','+
      FormatSQLNumber(FKonsinyasi)+','+
      FormatSQLString(FItemName)+','+
      FormatSQLNumber(FDosis)+','+
      FormatSQLNumber(FKategori)+','+
    //  IfThen(FKategori<>0,FormatSQLNumber(FKategori), FormatSQLNULL)+','+
      FormatSQLDate(FExpireDate)+')';
  try
    BeginSQL;
    ExecSQL(sqL);
    FItemid:= getIntegerFromSQL('select item_id from mst_item where item_code = '+FormatSQLString(FItemCode));

    for i:= 0 to FItemConversion.Count-1 do begin
      FItemConversion[i].FItemId:= FItemid;
      FItemConversion[i].InsertOnDB;
    end;

    for i:= 0 to FItemSeting.Count-1 do begin
      conv:= getFloatFromSQL(
      'select conversion from mst_item_conversion where conv_id = '+IntToStr(FItemSeting[i].ConvID));
      ExecSQL(
      'insert into mst_item_setting (jenis_id, item_id, batas_bawah, batas_atas, conv_id, faktor, nilai, aktif) '+
      'values ('+
      FormatSQLNumber(FItemSeting[i].JenisID)+','+
      FormatSQLNumber(FItemid)+','+
      FormatSQLNumber(FItemSeting[i].BatasBawah * conv)+','+
      FormatSQLNumber(FItemSeting[i].BatasAtas * conv)+','+
      FormatSQLNumber(FItemSeting[i].ConvID)+','+
      FormatSQLNumber(FItemSeting[i].Faktor)+','+
      FormatSQLNumber(FItemSeting[i].Nilai)+','+
      FormatSQLNumber(FItemSeting[i].Aktif)+')');
    end;

    for i:= 0 to FRak.Count-1 do begin
      ExecSQL(
      'insert into mst_rak_item (rak_id, item_id) '+
      'values ('+
      FormatSQLNumber(FRak[i].RakID)+','+
      FormatSQLNumber(FItemid)+')');
    end;

    EndSQL;
    Result:= True;
  except
    UndoSQL;
    Result:= False;
    Inform(MSG_UNSUCCESS_SAVING);
  end;
end;

function TMstItem.isExistBarcode(id: string): boolean;
begin
  Result:= getIntegerFromSQL('select count(*) from mst_item where barcode = '+FormatSQLString(id))>0;
  if not Result then
  Result:= getIntegerFromSQL('select count(*) from mst_paket where barcode = '+FormatSQLString(id))>0;
end;

function TMstItem.isExistInDb(id: string): boolean;
begin
  Result:= getIntegerFromSQL('select count(*) from mst_item where item_code = '+FormatSQLString(id))>0;
  if not Result then
  Result:= getIntegerFromSQL('select count(*) from mst_paket where kode = '+FormatSQLString(id))>0;
end;

function TMstItem.isExistName(id: string): boolean;
begin
  Result:= getIntegerFromSQL('select count(*) from mst_item where item_name = '+FormatSQLString(id))>0;
end;

function TMstItem.SelectBOS: boolean;
var sqL: string; buffer, paket: TMysqlResult;
begin
  case FKonsinyasi of
    -1://belum ketauan paket ato bukan
      sqL:=
      'select item_id, item_name, barcode, struk_name, avg_price, 0 as paket '+
      'from mst_item '+
      'where barcode = '+FormatSQLString(FBarcode)+
      ' union all '+
      'select paket_id as item_id, nama as item_name, barcode, nama_struk as struk_name, harga_dasar as avg_price, 1 as paket '+
      'from mst_paket '+
      'where barcode = '+FormatSQLString(FBarcode);

     0://bukan paket
      sqL:=
      'select item_id, item_name, barcode, struk_name, avg_price, 0 as paket '+
      'from mst_item '+
      'where item_id = '+FormatSQLNumber(FItemId);

     1:// paket
      sqL:=
      'select paket_id as item_id, nama as item_name, barcode, nama_struk as struk_name, harga_dasar as avg_price, 1 as paket '+
      'from mst_paket '+
      'where paket_id = '+FormatSQLNumber(FItemId);
  end;

  buffer:= OpenSQL(sqL);
  result:= buffer.RecordCount > 0;
  Self.Reset;
  if Result then begin
    with buffer do begin
      FItemId     := BufferToInteger(FieldValue(0));
      FItemName   := BufferToString(FieldValue(1));
      FBarcode    := BufferToString(FieldValue(2));
      FStrukName  := BufferToString(FieldValue(3));
      FAvgPrice   := BufferToFloat(FieldValue(4));
      FKonsinyasi := BufferToInteger(FieldValue(5));
      FItemConversion.Clear;
      FItemConversion.Add;
      if FKonsinyasi = 0 then begin
        FItemConversion[0].ItemId:= FItemId;
        Result:= FItemConversion[0].SelectForBOS;
      end
      else begin
        paket:= OpenSQL(
        'select harga_jual, '+
        '(select mst_code from mst_master where mst_id = unit_id) as sat '+
        'from mst_paket where paket_id = '+FormatSQLNumber(FItemId));
        Result:= paket.RecordCount > 0;
        FItemConversion[0].ItemId:= FItemId;
        FItemConversion[0].ConvID:= 0;
        FItemConversion[0].Conversion:= 1;
        if Result then begin
          FItemConversion[0].MstMaster.MstCode:= paket.FieldValue(1);
          FItemConversion[0].SalesPrice:= BufferToFloat(paket.FieldValue(0));
        end;
        paket.destroy;
      end;
    end;
  end;
  buffer.Destroy;

end;

function TMstItem.SelectInDB: boolean;
var sqL: string; buffer: TMysqlResult;
begin
  sqL:=
  'select i.item_id, i.item_code, i.item_name, i.specification, c.code_name, '+
  'barcode, struk_name, current_stock, merk, avg_price,buying_price,selling_price,kemasan_id '+
  'from mst_item i left join mst_code c '+
  'on i.specification = c.code_id '+
  IfThen(FItemId <> 0, 'where item_id = '+FormatSQLNumber(FItemId), 'where barcode = '+FormatSQLString(FBarcode));

  buffer:= OpenSQL(sqL);
  result:= buffer.RecordCount > 0;
  Self.Clear;
  if Result then begin
    with buffer do begin
      FItemId   := BufferToInteger(FieldValue(0));
      FItemCode := BufferToString(FieldValue(1));
      FItemName := BufferToString(FieldValue(2));
      MstCode.CodeId := BufferToInteger(FieldValue(3));
      MstCode.CodeName := BufferToString(FieldValue(4));
      FBarcode := BufferToString(FieldValue(5));
      FStrukName := BufferToString(FieldValue(6));
      FCurrentStock := BufferToFloat(FieldValue(7));
      FMerk := BufferToString(FieldValue(8));
      FAvgPrice := BufferToFloat(FieldValue(9));
      BuyingPrice := BufferToFloat(FieldValue(10));
      SellingPrice := BufferToFloat(FieldValue(11));
      FKemasanID := BufferToInteger(FieldValue(12));
   //   FItemConversion.Clear;
   //   FItemConversion.Add;
  //    FItemConversion[0].ItemId:= FItemId;
    //  Result:= FItemConversion[0].SelectInDB;
    end;
  end;
  buffer.Destroy;
end;

function TMstItem.SelectInDB2(AConvType: integer): boolean;
var sqL: string; buffer: TMysqlResult;  i: integer;
begin
  sqL:=
  'select i.item_id, i.item_code, i.item_name, i.specification, c.code_name, '+
  'barcode, struk_name, vendor_id, merk, avg_price, produsen_id, kemasan_id, bkp, konsinyasi, dosis, kategori, expire_date '+
  ',buying_price,selling_price '+
  'from mst_item i left join mst_code c '+
  'on i.specification = c.code_id '+
      IfThen(FItemId <> 0, 'where item_id = '+FormatSQLNumber(FItemId), 'where barcode = '+FormatSQLString(FBarcode));

  buffer:= OpenSQL(sqL);
  result:= buffer.RecordCount > 0;
  Self.Clear;
  if Result then begin
    with buffer do begin
      FItemId   := BufferToInteger(FieldValue(0));
      FItemCode := BufferToString(FieldValue(1));
      FItemName := BufferToString(FieldValue(2));
      MstCode.CodeId := BufferToInteger(FieldValue(3));
      MstCode.CodeName := BufferToString(FieldValue(4));
      FBarcode   := BufferToString(FieldValue(5));
      FStrukName := BufferToString(FieldValue(6));
      FVendorID  := BufferToInteger(FieldValue(7));
      FMerk      := BufferToString(FieldValue(8));
      FAvgPrice  := BufferToFloat(FieldValue(9));
      FProdusenID:= BufferToInteger(FieldValue(10));
      FKemasanID := BufferToInteger(FieldValue(11));
      FBKP := BufferToInteger(FieldValue(12));
      FKonsinyasi := BufferToInteger(FieldValue(13));
      FDosis := BufferToFloat(FieldValue(14));
      FKategori := BufferToInteger(FieldValue(15));
      FExpireDate := BufferToDateTime(FieldValue(16));
      BuyingPrice := BufferToFloat(FieldValue(17));
      SellingPrice := BufferToFloat(FieldValue(18));
    end;
 //  Result:= FItemConversion.LoadFromDb(FItemId, AConvType);
  end;
  buffer.Destroy;

 { buffer:= OpenSQL(
  'select rak_id from mst_rak_item where item_id = '+FormatSQLNumber(FItemId));
  if buffer.RecordCount > 0 then
  for i:= 0 to buffer.RecordCount-1 do begin
    FRak.Add(BufferToInteger(buffer.FieldValue(0)),0);
    buffer.MoveNext;
  end;
  buffer.destroy;}
end;

function TMstItem.SelectInDB3: boolean;
var sqL: string; buffer: TMysqlResult;
begin
  sqL:=
  'select i.item_id, i.item_code, i.item_name, barcode, current_stock, avg_price, buying_price,kemasan_id,merk '+

  'from mst_item i '+
  IfThen(FItemId <> 0, 'where item_id = '+FormatSQLNumber(FItemId), 'where barcode = '+FormatSQLString(FBarcode));//+
//  IfThen(FVendorID <> 0, ' and vendor_id = '+FormatSQLNumber(FVendorID));

  buffer:= OpenSQL(sqL);
  result:= buffer.RecordCount > 0;
  Self.Clear;
  if Result then begin
    with buffer do begin
      FItemId   := BufferToInteger(FieldValue(0));
      FItemCode := BufferToString(FieldValue(1));
      FItemName := BufferToString(FieldValue(2));
      FBarcode := BufferToString(FieldValue(3));
      FCurrentStock := BufferToFloat(FieldValue(4));
      FAvgPrice := BufferToFloat(FieldValue(5));
      FBuyingPrice := BufferToFloat(FieldValue(6));
      FKemasanID := BufferToInteger(FieldValue(7));
      Merk := BufferToString(FieldValue(8));
   //   FItemConversion.Clear;
  //   FItemConversion.Add;
 //     FItemConversion[0].ItemId:= FItemId;
   //   Result:= FItemConversion[0].SelectInDB3;
    end;
  buffer.Destroy;
  end;

end;

function TMstItem.SelectInDB4(ConvID: integer): boolean;
var sqL: string; buffer: TMysqlResult;
begin
  sqL:=
  'select i.item_id, i.item_code, i.item_name, barcode,buying_price '+
  'from mst_item i where item_id = '+FormatSQLNumber(FItemId);

  buffer:= OpenSQL(sqL);
  result:= buffer.RecordCount > 0;
  Self.Clear;
  if Result then begin
    with buffer do begin
      FItemId   := BufferToInteger(FieldValue(0));
      FItemCode := BufferToString(FieldValue(1));
      FItemName := BufferToString(FieldValue(2));
      FBarcode := BufferToString(FieldValue(3));
      FBuyingPrice := BufferToFloat(FieldValue(4));
   //   FItemConversion.Clear;
    //  FItemConversion.Add;
     // FItemConversion[0].ConvID:= ConvID;
     // Result:= FItemConversion[0].SelectInDB4;
    end;
  buffer.Destroy;
  end;

end;

function TMstItem.SelectPOS: boolean;
var sqL: string; buffer, paket: TMysqlResult;
begin
  case FKonsinyasi of
    -1://belum ketauan paket ato bukan
      sqL:=
      'select item_id, item_name, barcode, struk_name, avg_price, 0 as paket,selling_price,0 as add_price,current_stock,discount,buying_price,-1 as animal_id,price_petshop,price_breeder '+
      'from mst_item '+
      'where ((barcode = '+FormatSQLString(FBarcode)+ ') or (item_code = '+FormatSQLString(FBarcode)+'))'+
      ' union all '+
     'select s.service_id as item_id, concat(service_name,'' '',animal) as item_name, service_code, concat(service_name,'' '',animal) as struk_name, 0 as avg_price, 1 as paket '+
      ' ,price, add_price,0 as current_stock,discount as discount,0 as buying_price,p.animal_id,price_petshop,price_breeder ' +
      'from mst_service s left join mst_service_price p on s.service_id=p.service_id '+
      ' left join mst_animal a on a.animal_id = p.animal_id '+
      'where s.service_code = '+FormatSQLString(FBarcode)+' and p.animal_id in ('+(FMerk)+')';
//      'where ((barcode = '+FormatSQLString(FBarcode)+ ') or (kode = '+FormatSQLString(FBarcode)+'))';

     0://bukan paket
      sqL:=
      'select item_id, item_name, barcode, struk_name, avg_price, 0 as paket,selling_price,0 as add_price,current_stock,discount,buying_price,-1 as animal_id,price_petshop,price_breeder '+
      'from mst_item '+
      'where item_id = '+FormatSQLNumber(FItemId);

     1:// servuice
      sqL:=
      'select s.service_id as item_id, concat(service_name,'' '',animal) as item_name, service_code, concat(service_name,'' '',animal) as struk_name, 0 as avg_price, 1 as paket '+
      ' ,price, add_price,0 as current_stock,discount as discount,0 as buying_price,p.animal_id,price_petshop,price_breeder ' +
      'from mst_service s left join mst_service_price p on s.service_id=p.service_id '+
      ' left join mst_animal a on a.animal_id = p.animal_id '+
      'where s.service_id = '+FormatSQLNumber(FItemId)+' and p.animal_id in ('+(FMerk)+')';
  end;

  buffer:= OpenSQL(sqL);
  result:= buffer.RecordCount > 0;
  Self.Reset;
  if Result then begin
    with buffer do begin
      FItemId     := BufferToInteger(FieldValue(0));
      FItemName   := BufferToString(FieldValue(1));
      FBarcode    := BufferToString(FieldValue(2));
      FStrukName  := BufferToString(FieldValue(3));
      FAvgPrice   := BufferToFloat(FieldValue(4));
      FKonsinyasi := BufferToInteger(FieldValue(5)); //is paket
      FSellingPrice := BufferToFloat(FieldValue(6));
      FAddPrice := BufferToFloat(FieldValue(7));
      FCurrentStock := BufferToFloat(FieldValue(8));
      FDiscount := BufferToFloat(FieldValue(9));
      FBuyingPrice := BufferToFloat(FieldValue(10));
      FVendorID := BufferToInteger(FieldValue(11));//animal_id
      FPricePetshop := BufferToFloat(FieldValue(12));
      FPriceBreeder := BufferToFloat(FieldValue(13));
      FItemConversion.Clear;
      FItemConversion.Add;
     { if FKonsinyasi = 0 then begin
        FItemConversion[0].ItemId:= FItemId;
        Result:= FItemConversion[0].SelectForPOS;
      end
      else begin
        paket:= OpenSQL(
        'select harga_jual, '+
        '(select mst_code from mst_master where mst_id = unit_id) as sat '+
        'from mst_paket where paket_id = '+FormatSQLNumber(FItemId));
        Result:= paket.RecordCount > 0;
        FItemConversion[0].ItemId:= FItemId;
        FItemConversion[0].ConvID:= 0;
        FItemConversion[0].Conversion:= 1;
        if Result then begin
          FItemConversion[0].MstMaster.MstCode:= paket.FieldValue(1);
          FItemConversion[0].SalesPrice:= BufferToFloat(paket.FieldValue(0));
        end;
        paket.destroy;
      end;  }
    end;
  end;
  buffer.Destroy;
end;

function TMstItem.SelectSetting(Jenis: integer): TMysqlResult;
begin
  Result:= OpenSQL(
  'select sett_id, batas_bawah, batas_atas, conv_id, faktor, nilai, aktif, '+
  '(select mst_code from mst_master m, mst_item_conversion k where m.mst_id = k.unit_id and k.conv_id = s.conv_id) as sat '+
  'from mst_item_setting s where item_id = '+IntToStr(ItemID)+
  ' and jenis_id = '+IntToStr(Jenis)+
  ' order by jenis_id, batas_bawah');
end;

function TMstItem.UpdateOnDB(): boolean;
var sqL: string; i: integer; conv: double;
begin
  sqL:=
    'update mst_item SET'+
      ' specification='+FormatSQLNumber(MstCode.CodeId)+','+
      ' item_code='+FormatSQLString(FItemCode)+','+
      ' barcode='+FormatSQLString(FBarcode)+','+
      ' struk_name='+FormatSQLString(FStrukName)+','+
      ' merk='+FormatSQLString(FMerk)+','+
      ' avg_price='+FormatSQLNumber(FAvgPrice)+','+
      ' bkp='+FormatSQLNumber(FBKP)+','+
      ' konsinyasi='+FormatSQLNumber(FKonsinyasi)+','+
      ' vendor_id ='+IfThen(FVendorID <> 0, FormatSQLNumber(FVendorID), FormatSQLNULL)+','+
      ' produsen_id ='+IfThen(FProdusenID <> 0, FormatSQLNumber(FProdusenID), FormatSQLNULL)+','+
      ' kemasan_id ='+IfThen(FKemasanID <> 0, FormatSQLNumber(FKemasanID), FormatSQLNULL)+','+
      ' kategori ='+FormatSQLNumber(FKategori)+','+//IfThen(FKategori <> 0, FormatSQLNumber(FKategori), FormatSQLNULL)+','+
      ' dosis ='+FormatSQLNumber(FDosis)+','+
      ' expire_date ='+FormatSQLDate(FExpireDate)+','+
     //  ' buying_price ='+FormatSQLNumber(BuyingPrice)+','+
      //  ' selling_price ='+FormatSQLNumber(SellingPrice)+','+
      ' item_name='+FormatSQLString(FItemName)+' '+
    'WHERE item_id='+FormatSQLNumber(FItemId);

  try
    BeginSQL;
    ExecSQL(sqL);

    for i:= 0 to FItemConversion.Count-1 do begin
      FItemConversion[i].FItemId := FItemId;
      if FItemConversion[i].FConvId = 0 then
        FItemConversion[i].InsertOnDB
      else FItemConversion[i].UpdateOnDB;
    end;

    for i:= 0 to FItemSeting.Count-1 do begin
      conv:= getFloatFromSQL(
      'select conversion from mst_item_conversion where conv_id = '+IntToStr(FItemSeting[i].ConvID));
      if FItemSeting[i].SettID = 0 then
        ExecSQL(
      'insert into mst_item_setting (jenis_id, item_id, batas_bawah, batas_atas, conv_id, faktor, nilai, aktif) '+
      'values ('+
      FormatSQLNumber(FItemSeting[i].JenisID)+','+
      FormatSQLNumber(FItemid)+','+
      FormatSQLNumber(FItemSeting[i].BatasBawah * conv)+','+
      FormatSQLNumber(FItemSeting[i].BatasAtas * conv)+','+
      FormatSQLNumber(FItemSeting[i].ConvID)+','+
      FormatSQLNumber(FItemSeting[i].Faktor)+','+
      FormatSQLNumber(FItemSeting[i].Nilai)+','+
      FormatSQLNumber(FItemSeting[i].Aktif)+')')
      else
        ExecSQL(
        'update mst_item_setting set '+
        'batas_bawah ='+FormatSQLNumber(FItemSeting[i].BatasBawah * conv)+','+
        'batas_atas ='+FormatSQLNumber(FItemSeting[i].BatasAtas * conv)+','+
        'conv_id ='+FormatSQLNumber(FItemSeting[i].ConvID)+','+
        'faktor ='+FormatSQLNumber(FItemSeting[i].Faktor)+','+
        'nilai ='+FormatSQLNumber(FItemSeting[i].Nilai)+','+
        'aktif ='+FormatSQLNumber(FItemSeting[i].Aktif)+
        ' where sett_id = '+FormatSQLNumber(FItemSeting[i].SettID));
    end;

    ExecSQL('delete from mst_rak_item where item_id = '+FormatSQLNumber(FItemID));

    for i:= 0 to FRak.Count-1 do begin
      ExecSQL(
      'insert into mst_rak_item (rak_id, item_id) '+
      'values ('+
      FormatSQLNumber(FRak[i].RakID)+','+
      FormatSQLNumber(FItemid)+')');
    end;

    EndSQL;
    Result:= True;
  except
    UndoSQL;
    Result:= False;
    Inform(MSG_UNSUCCESS_SAVING);
  end;
end;

class function TMstItem.updatePriceHistory(Purpose,aItemId:integer;aPrice:double;Supplier:string;aPricePetshop:double;aPriceBreeder:double): boolean;
var sql : string;
begin
   sql := 'update mst_item set '+
              IfThen(purpose=1,' buying_price = '+FormatSQLNumber(aPrice),
              ifThen(Purpose=2,' selling_price = '+FormatSQLNumber(aPrice)+', price_petshop = '+FormatSQLNumber(aPricePetshop)+', price_breeder = '+FormatSQLNumber(aPriceBreeder)
              ,' discount = '+FormatSQLNumber(aPrice)))+
              ' WHERE item_id = '+FormatSQLNumber(aItemId);
  ExecSQL(sql);
  if Purpose = 1 then // harga beli
    sql:= 'insert into mst_buying_price_hist(item_id,price,end_date,supplier,insert_log) '+
        ' values('+FormatSQLNumber(aItemId)+','+
          FormatSQLNumber(aPrice)+',now(),'+FormatSQLString(Supplier)+','+FormatSQLString(getSecurityLog)+')'
  else  if Purpose = 2 then 
      sql:= 'insert into mst_selling_price_hist(item_id,price,price_petshop,price_breeder,end_date,insert_log) '+
        ' values('+FormatSQLNumber(aItemId)+','+
          FormatSQLNumber(aPrice)+','+
          FormatSQLNumber(aPricePetshop)+','+
          FormatSQLNumber(aPriceBreeder)+',now(),'+FormatSQLString(getSecurityLog)+')';


  Result := ExecSQL(sql)=0;

end;

{ TMstItemArr }

function TMstItemArr.Add: integer;
begin
  setLength(FMstItem_Arr, length(FMstItem_Arr)+1);
  Result := high(FMstItem_Arr);
  FMstItem_Arr[Result] := TMstItem.Create;
end;

class function TMstItemArr.countFromDB2: integer;
var sqL, filter: string;
begin
  if GlobalFilter.StatusID = 1 then filter:= ' and i.disabled_date is null '
  else if GlobalFilter.StatusID = 2 then filter:= ' and i.disabled_date is not null ';

  if GlobalFilter.SpecID <> 0 then
    filter:= filter + ' and p.root_id ='+FormatSQLNumber(GlobalFilter.SpecID);
  if GlobalFilter.RelasiID <> 0 then
    filter:= filter + ' and i.vendor_id ='+FormatSQLNumber(GlobalFilter.RelasiID);
  if GlobalFilter.SeriesID <> 0 then
    filter:= filter + ' and i.produsen_id ='+FormatSQLNumber(GlobalFilter.SeriesID);
  if GlobalFilter.Numeric1 <> 0 then
    filter:= filter + ' and i.kemasan_id ='+FormatSQLNumber(GlobalFilter.Numeric1);
  if GlobalFilter.Name <> '' then
    filter:= filter + ' and i.item_name like '+FormatSQLString('%'+GlobalFilter.Name+'%');
  if GlobalFilter.TipeID <> '' then
    filter:= filter + ' and i.merk like '+FormatSQLString('%'+GlobalFilter.TipeID+'%');
  if GlobalFilter.FString1 <> '' then
    filter:= filter + ' and i.item_code like '+FormatSQLString('%'+GlobalFilter.FString1+'%');
  if GlobalFilter.FString2 <> '' then
    filter:= filter + ' and i.barcode like '+FormatSQLString('%'+GlobalFilter.FString2+'%');
  if GlobalFilter.Numeric2 <> 0 then
    filter:= filter +
    ' and (i.item_id = r.item_id) and (r.rak_id = rm.rak_id) and rm.root_id = '+FormatSQLNumber(GlobalFilter.Numeric2);

  sqL:=
  'select distinct count(i.item_id) '+
  'from mst_item i, mst_item_conversion k, point_maping p '+
  IfThen(GlobalFilter.Numeric2<>0, ', mst_rak_item r, mst_rak_maping rm ')+
  'where i.item_id = k.item_id and k.conversion =1 and i.specification = p.code_id '+ filter;

  result:= getIntegerFromSQL(sqL);
end;

class function TMstItemArr.LoadFormOpname: TMysqlResult;
var sqL, fil: string;
begin
  if GlobalFilter.SpecID <> 0 then
    fil:= fil + ' and p.root_id ='+FormatSQLNumber(GlobalFilter.SpecID);
  if GlobalFilter.RelasiID <> 0 then
    fil:= fil + ' and i.vendor_id ='+FormatSQLNumber(GlobalFilter.RelasiID);
  if GlobalFilter.Name <> '' then
    fil:= fil + ' and item_name like '+FormatSQLString('%'+GlobalFilter.Name+'%');
  if GlobalFilter.FString1 <> '' then
    fil:= fil + ' and i.barcode like '+FormatSQLString('%'+GlobalFilter.FString1+'%');
  if GlobalFilter.FString2 <> '' then
    fil:= fil + ' and i.item_code like '+FormatSQLString('%'+GlobalFilter.FString2+'%');

  sqL:=
  'select distinct i.item_id, i.barcode, i.item_name, i.current_stock, i.avg_price, '+
  'c.conv_id, c.conversion, u.mst_code '+
  'from mst_item i, point_maping p, mst_item_conversion c, mst_master u '+
  'where i.disabled_date is null and i.specification = p.code_id '+
  'and c.item_id = i.item_id and c.conversion = 1 and c.unit_id = u.mst_id '+
  fil + ' order by i.item_name';
  Result:= OpenSQL(sqL);
end;

class function TMstItemArr.LoadFormOpnameX: TMysqlResult;
var sqL, fil: string;
begin
  if GlobalFilter.SpecID <> 0 then
    fil:= fil + ' and i.specification ='+FormatSQLNumber(GlobalFilter.SpecID);
  if GlobalFilter.RelasiID <> 0 then
    fil:= fil + ' and i.vendor_id ='+FormatSQLNumber(GlobalFilter.RelasiID);
  if GlobalFilter.Name <> '' then
    fil:= fil + ' and item_name like '+FormatSQLString('%'+GlobalFilter.Name+'%');
  if GlobalFilter.FString1 <> '' then
    fil:= fil + ' and i.merk like '+FormatSQLString('%'+GlobalFilter.FString1+'%');
  if GlobalFilter.FString2 <> '' then
    fil:= fil + ' and i.item_code like '+FormatSQLString('%'+GlobalFilter.FString2+'%');

  sqL:=
  'select distinct i.item_id, i.barcode, i.item_name, i.current_stock, i.avg_price, '+
  '0,0, u.mst_code, buying_price,merk,item_code '+
  'from mst_item i,  mst_master u '+
  'where i.disabled_date is null '+
  'and u.mst_id = i.kemasan_id  '+
  fil + ' order by i.item_name';
  Result:= OpenSQL(sqL);
end;

function TMstItemArr.LoadFromDB(ean: integer): boolean;
var sqL, fil: string; buffer: TMysqlResult; i: integer;
begin
  if GlobalFilter.StatusID = 1 then fil:= ' and i.disabled_date is null '
  else if GlobalFilter.StatusID = 2 then fil:= ' and i.disabled_date is not null ';

  if GlobalFilter.SpecID <> 0 then
    fil:= fil + ' and p.root_id ='+FormatSQLNumber(GlobalFilter.SpecID);
  if GlobalFilter.RelasiID <> 0 then
    fil:= fil + ' and i.vendor_id ='+FormatSQLNumber(GlobalFilter.RelasiID);
  if GlobalFilter.SeriesID <> 0 then
    fil:= fil + ' and i.produsen_id ='+FormatSQLNumber(GlobalFilter.SeriesID);
  if GlobalFilter.Numeric1 <> 0 then
    fil:= fil + ' and i.kemasan_id ='+FormatSQLNumber(GlobalFilter.Numeric1);

  if GlobalFilter.Name <> '' then
    fil:= fil + ' and i.item_name like '+FormatSQLString('%'+GlobalFilter.Name+'%');

  if GlobalFilter.TipeID <> '' then
    fil:= fil + ' and i.merk like '+FormatSQLString('%'+GlobalFilter.TipeID+'%');


  if ean = -1 then  fil:= fil + ' and length(barcode) <= 13 ';

  sqL:=
    'select distinct i.item_id, i.item_code, i.barcode, i.item_name, i.struk_name, i.current_stock, i.specification '+
    'from mst_item i, point_maping p '+
    'where i.specification = p.code_id '+ fil;

  sqL:= sqL + ' order by convert(i.item_code, SIGNED), i.item_name';
  buffer:= OpenSQL(sqL);
  result:= buffer.RecordCount > 0;
  Self.Clear;
  if Result then
    for i:= 0 to buffer.RecordCount -1 do
      with buffer do begin
        Self.Add;
        Self[i].ItemId         := BufferToInteger(FieldValue(0));
        Self[i].ItemCode       := BufferToString(FieldValue(1));
        Self[i].Barcode        := BufferToString(FieldValue(2));
        Self[i].ItemName       := BufferToString(FieldValue(3));
        Self[i].StrukName      := BufferToString(FieldValue(4));
        Self[i].CurrentStock   := BufferToFloat(FieldValue(5));
        Self[i].MstCode.CodeId := BufferToInteger(FieldValue(6));
        MoveNext;
      end;
  buffer.Destroy;
end;

{ TMstMoneyAccount }

{class function TMstMoneyAccount.GetActivation: integer;
begin
  Result:= getIntegerFromSQL('select money_id from mst_money_account where is_default = -1');
end;

class function TMstMoneyAccount.GetName(id: integer): string;
begin
  Result:= getStringFromSQL('select money_name from mst_money_account where money_id = '+FormatSQLNumber(id))
end;

class function TMstMoneyAccount.GetSaldoAwal(vMoneyId: integer;
  vDate: TDate): Double;
begin
  Result:= getFloatFromSQL
  ('select ifnull(balance,0) from fin_money_balance where money_id = '+FormatSQLNumber(vMoneyId)+
   ' and balance_date = ('+
     'select max(balance_date) from fin_money_balance '+
     'where money_id = '+FormatSQLNumber(vMoneyId)+
     ' and balance_date < '+FormatSQLDate(vDate)+')');
end;

function TMstMoneyAccount.InsertOnDB: boolean;
begin
  Result:= ExecTransaction(
    'insert into mst_money_account (money_type, money_Code, money_name, '+
      'account_number, owner_name, bank_name) '+
    'values ('+
      FormatSQLString(FMoneyType)+','+
      FormatSQLString(FMoneyCode)+','+
      FormatSQLString(FMoneyName)+','+
      FormatSQLString(FAccountNumber)+','+
      FormatSQLString(FOwnerName)+','+
      FormatSQLString(FBankName)+')');

end;

function TMstMoneyAccount.isExistInDb(id: string): boolean;
begin
  Result:= getIntegerFromSQL
    ('select count(*) from mst_money_account where money_code = '+FormatSQLString(id)) > 0
end;

function TMstMoneyAccount.SelectInDB: boolean;
var buffer: TMysqlResult;
begin
  buffer:= OpenSQL(
   'select money_id, money_type, money_Code, money_name, account_number, '+
     'owner_name, bank_name, is_default '+
   'from mst_money_account '+
   IfThen(FMoneyId <> 0,
    'where money_id = '+FormatSQLNumber(FMoneyId),
    'where money_code = '+FormatSQLString(FMoneyCode)));
  result:= buffer.RecordCount > 0;
  Self.Reset;
  if Result then
    with buffer do begin
      FMoneyId   := BufferToInteger(FieldValue(0));
      FMoneyType := BufferToString(FieldValue(1));
      FMoneyCode := BufferToString(FieldValue(2));
      FMoneyName := BufferToString(FieldValue(3));
      FAccountNumber := BufferToString(FieldValue(4));
      FOwnerName := BufferToString(FieldValue(5));
      FBankName  := BufferToString(FieldValue(6));
      FIsDefault := BufferToInteger(FieldValue(7));
    end;
  buffer.Destroy;
end;

class procedure TMstMoneyAccount.SetActivation(state: boolean;
  id: integer);
begin
  ExecSQL(
  'update mst_money_account set is_default = '+BoolToStr(state)+
  ' where money_id = '+FormatSQLNumber(id))
end;

function TMstMoneyAccount.UpdateOnDB: boolean;
begin
  Result:= ExecTransaction(
    'update mst_money_account set '+
      'money_type = '+FormatSQLString(FMoneyType)+','+
      'money_Code = '+FormatSQLString(FMoneyCode)+','+
      'money_name = '+FormatSQLString(FMoneyName)+','+
      'account_number = '+FormatSQLString(FAccountNumber)+','+
      'owner_name = '+FormatSQLString(FOwnerName)+','+
      'bank_name  = '+FormatSQLString(FBankName)+' '+
    'where money_id = '+FormatSQLNumber(FMoneyId), false);
end;
 }
{ TMstMoneyAccountArr }

{class procedure TMstMoneyAccountArr.gerList(AList: TStringList);
begin
  SQLToNameValueList
    (AList, 'select money_id, money_name from mst_money_account order by is_default, money_name');
end;

function TMstMoneyAccountArr.LoadFromDB: boolean;
var buffer: TMysqlResult; i: integer;
begin
  buffer:= OpenSQL(
   'select money_id, '+
     '(select if (money_type = '+FormatSQLString(MONEY_TYPE_CASH) +', '+
     FormatSQLString(MONEY_TYPE_CASH_TEXT)+', '+FormatSQLString(MONEY_TYPE_BANK_TEXT)+')) as money_type, '+
     'money_code, money_name, account_number, '+
     'owner_name, bank_name, is_default '+
   'from mst_money_account '+
   'order by money_name');

  result:= buffer.RecordCount > 0;
  Self.Clear;
  if Result then
    for i:= 0 to buffer.RecordCount -1 do
    with buffer do begin
      Self.Add(
      BufferToInteger(FieldValue(0)),
      BufferToString(FieldValue(1)),
      BufferToString(FieldValue(2)),
      BufferToString(FieldValue(3)),
      BufferToString(FieldValue(4)),
      BufferToString(FieldValue(5)),
      BufferToString(FieldValue(6)),
      BufferToInteger(FieldValue(7)));
      buffer.MoveNext;
    end;
  buffer.Destroy;
end;
 }
{ TMstAccount }

{class function TMstAccount.getLevel(id: Integer): integer;
begin
  Result:= getIntegerFromSQL('select acc_level from mst_account where acc_id = '+FormatSQLNumber(id))
end;

class function TMstAccount.getName(id: Integer): string;
begin
  Result:= getStringFromSQL('select acc_name from mst_account where acc_id = '+FormatSQLNumber(id))
end;
 }
{function TMstAccount.InsertOnDB: boolean;
begin
  Result:= ExecTransaction(
    'insert into mst_account (acc_type, acc_code, acc_name, db_cr_type, parent_id, acc_level)'+
    ' values ('+
      FormatSQLString(FAccType)+','+
      FormatSQLNumber(FAccCode)+','+
      FormatSQLString(FAccName)+','+
      FormatSQLString(FDbCrType)+','+
      FormatSQLNumber(FParentId)+','+
      FormatSQLNumber(FAccLevel)+')');
end;

function TMstAccount.isExistInDb(id: string): boolean;
begin
  Result:= getIntegerFromSQL
   ('select count(acc_code) from mst_account where acc_code = '+FormatSQLString(id)) > 0;
end;

function TMstAccount.SelectInDB: boolean;
var buffer: TMysqlResult; filter: string;
begin
  if FAccId <> 0 then
    filter:= ' where acc_id = '+FormatSQLNumber(FAccId)
  else if FAccCode <> 0 then
    filter:= ' where acc_code = '+FormatSQLNumber(FAccCode)
  else if FParentId <> 0 then
    filter:= ' where parent_id = '+FormatSQLNumber(FParentId);

  buffer:= OpenSQL
   ('select acc_id, acc_type, acc_code, acc_name, db_cr_type, parent_id, acc_level, current_debt '+
    'from mst_account '+filter+
    ' order by acc_code');

  result:= buffer.RecordCount > 0;
  Self.Reset;
  if Result then
    with buffer do begin
      FAccId       := BufferToInteger(FieldValue(0));
      FAccType     := BufferToString(FieldValue(1));
      FAccCode     := BufferToInteger(FieldValue(2));
      FAccName     := BufferToString(FieldValue(3));
      FDbCrType    := BufferToString(FieldValue(4));
      FParentId    := BufferToInteger(FieldValue(5));
      FAccLevel    := BufferToInteger(FieldValue(6));
      FCurrentDebt := BufferToFloat(FieldValue(7));
    end;
  buffer.Destroy;
end;

function TMstAccount.UpdateOnDB: boolean;
begin
  Result:= ExecTransaction(
      'update mst_account set '+
          ' acc_type='+FormatSQLString(FAccType)+','+
          ' acc_code='+FormatSQLNumber(FAccCode)+','+
          ' acc_name='+FormatSQLString(FAccName)+','+
          ' db_cr_type='+FormatSQLString(FDbCrType)+','+
          ' parent_id='+FormatSQLNumber(FParentId)+','+
          ' acc_level='+FormatSQLNumber(FAccLevel)+
    ' WHERE acc_id='+FormatSQLNumber(FAccId), False)
end;
 }
{ TMstAccount_Arr }
  {
class procedure TMstAccount_Arr.GetList(ATarget: TStringList;
  isRoot: Boolean; AccTipe: string; AParentId: integer; RealRoot: Boolean);
var sql:string;
begin
  ATarget.Clear;
  if isRoot then
  begin
    if RealRoot then
      sql := 'SELECT acc_id, acc_name, acc_code, parent_id from mst_account '+
            ' WHERE parent_id = 0 Order By acc_code '
    else
      sql := 'SELECT acc_id, acc_name, acc_code, parent_id from mst_account '+
            ' WHERE parent_id in (SELECT acc_id FROM mst_account WHERE parent_id = 0) '+
            ' UNION '+
            ' SELECT acc_id, acc_name, acc_code, parent_id from mst_account '+
            ' WHERE parent_id = 0  Order By parent_id DESC, acc_code';
  end
  else
    sql := 'SELECT acc_id, acc_name, acc_code, parent_id from mst_account '+
            ' WHERE parent_id <> 0 '+
            IfThen(AccTipe <> '',' AND acc_type = '+FormatSQLString(AccTipe))+
            IfThen(AParentId<>0,' AND parent_id = '+FormatSQLNumber(AParentId))+
            ' Order By acc_code ';
  SQLToNameValueList(ATarget,sql);

end;
   }
class function TMstItemArr.LoadFromDB2: TMysqlResult;
var sqL, filter: string;
begin
  if GlobalFilter.StatusID = 1 then filter:= ' and i.disabled_date is null '
  else if GlobalFilter.StatusID = 2 then filter:= ' and i.disabled_date is not null ';

  if GlobalFilter.Numeric3 <> -1 then
    filter:= filter + ' and (i.kategori ='+FormatSQLNumber(GlobalFilter.Numeric3)+IfThen(GlobalFilter.Numeric3=0,' or i.kategori is null','')+')';

  if GlobalFilter.SpecID <> 0 then
    filter:= filter + ' and p.root_id ='+FormatSQLNumber(GlobalFilter.SpecID);
  if GlobalFilter.RelasiID <> 0 then
    filter:= filter + ' and i.vendor_id ='+FormatSQLNumber(GlobalFilter.RelasiID);
  if GlobalFilter.SeriesID <> 0 then
    filter:= filter + ' and i.produsen_id ='+FormatSQLNumber(GlobalFilter.SeriesID);
  if GlobalFilter.Numeric1 <> 0 then
    filter:= filter + ' and i.kemasan_id ='+FormatSQLNumber(GlobalFilter.Numeric1);
  if GlobalFilter.Name <> '' then
    filter:= filter + ' and i.item_name like '+FormatSQLString('%'+GlobalFilter.Name+'%');
  if GlobalFilter.TipeID <> '' then
    filter:= filter + ' and i.merk like '+FormatSQLString('%'+GlobalFilter.TipeID+'%');
  if GlobalFilter.FString1 <> '' then
    filter:= filter + ' and i.item_code like '+FormatSQLString('%'+GlobalFilter.FString1+'%');
  if GlobalFilter.FString2 <> '' then
    filter:= filter + ' and i.barcode like '+FormatSQLString('%'+GlobalFilter.FString2+'%');
 // if GlobalFilter.Numeric2 <> 0 then
  //  filter:= filter +
   // ' and (i.item_id = r.item_id) and (r.rak_id = rm.rak_id) and rm.root_id = '+FormatSQLNumber(GlobalFilter.Numeric2);


  filter:= filter + ' order by item_name ';
  if GlobalFilter.FOffset <> 0 then
    filter:= filter +
    ' limit '+FormatSQLNumber(GlobalFilter.FLimit)+ ', '+FormatSQLNumber(GlobalFilter.FOffset);

     // 'k.purchase_price, k.item_discount, k.item_tax, k.net_price, i.avg_price, k.cost_price, k.sales_price, k.sales_price2, '+
  sqL:=
  'select distinct i.item_id, i.item_code, i.barcode, i.item_name '+
  ', merk,struk_name,round(i.current_stock), '+
  '(select mst_code from mst_master where mst_id = i.kemasan_id limit 1) as sat '+
'  ,(select code_name from mst_code where code_id = i.specification) as jenis '+
   ',buying_price,selling_price,discount,price_petshop,price_breeder '+
    'from mst_item i,  point_maping p '+
  IfThen(GlobalFilter.Numeric2<>0, ', mst_rak_item r, mst_rak_maping rm ')+
  'where i.specification = p.code_id '+ filter;

  result:= OpenSQL(sqL);
end;

function TMstItemArr.LoadFromDBWithConv: boolean;
var sqL, fil: string; buffer: TMysqlResult; i: integer;
begin
  if GlobalFilter.StatusID = 0 then
    fil:= ' and i.disabled_date is null '
  else fil:= ' and i.disabled_date is not null ';
  if GlobalFilter.SpecID <> 0 then
    fil:= fil + ' and p.root_id ='+FormatSQLNumber(GlobalFilter.SpecID);
  if GlobalFilter.Name <> '' then
    fil:= fil + ' and item_name like '+FormatSQLString('%'+GlobalFilter.Name+'%');

  sqL:=
    'select distinct i.item_id, i.item_code, i.barcode, i.item_name, i.struk_name, i.current_stock, i.specification '+
    'from mst_item i, point_maping p, mst_item_conversion c '+
    'where i.specification = p.code_id and i.item_id = c.item_id '+ fil;

  sqL:= sqL + ' order by convert(i.item_code, SIGNED), i.item_name';
  buffer:= OpenSQL(sqL);
  result:= buffer.RecordCount > 0;
  Self.Clear;
  if Result then
    for i:= 0 to buffer.RecordCount -1 do
      with buffer do begin
        //i.item_id, i.item_code, i.item_name, i.current_stock, '+
        Self.Add;
        Self[i].ItemId         := BufferToInteger(FieldValue(0));
        Self[i].ItemCode       := BufferToString(FieldValue(1));
        Self[i].Barcode        := BufferToString(FieldValue(2));
        Self[i].ItemName       := BufferToString(FieldValue(3));
        Self[i].StrukName      := BufferToString(FieldValue(4));
        Self[i].CurrentStock   := BufferToFloat(FieldValue(5));
        Self[i].MstCode.CodeId := BufferToInteger(FieldValue(6));
        MoveNext;
      end;
  buffer.Destroy;

end;

function TMstItemArr.LoadFromStock: boolean;
var sqL, fil: string; buffer: TMysqlResult; i: integer;
begin
  if GlobalFilter.StatusID = 0 then
    fil:= '  i.disabled_date is null '
  else fil:= '  i.disabled_date is not null ';
  if GlobalFilter.SpecID <> 0 then
    fil:= fil + ' and p.root_id ='+FormatSQLNumber(GlobalFilter.SpecID);
  if GlobalFilter.RelasiID <> 0 then
    fil:= fil + ' and i.vendor_id ='+FormatSQLNumber(GlobalFilter.RelasiID);
  if GlobalFilter.Name <> '' then
    fil:= fil + ' and item_name like '+FormatSQLString('%'+GlobalFilter.Name+'%');
  if GlobalFilter.FString1 <> '' then
    fil:= fil + ' and i.merk like '+FormatSQLString('%'+GlobalFilter.FString1+'%');
  if GlobalFilter.FString2 <> '' then
    fil:= fil + ' and i.item_code like '+FormatSQLString('%'+GlobalFilter.FString2+'%');

  sqL:=
  'select distinct i.item_id, i.barcode, i.item_name, i.current_stock, i.avg_price,merk,kemasan_id, buying_price,i.item_code,i.selling_price '+
    ' from mst_item i left join point_maping p on i.specification = p.code_id '+
  'where '+ fil;

  sqL:= sqL + ' order by i.item_name';

  buffer:= OpenSQL(sqL);
  result:= buffer.RecordCount > 0;
  Self.Clear;
  if Result then
    for i:= 0 to buffer.RecordCount -1 do
      with buffer do begin
        Self.Add;
        Self[i].ItemId   := BufferToInteger(FieldValue(0));

        Self[i].Barcode  := BufferToString(FieldValue(1));
        Self[i].ItemName := BufferToString(FieldValue(2));
        Self[i].CurrentStock := BufferToFloat(FieldValue(3));
        Self[i].AvgPrice := BufferToFloat(FieldValue(4));
        Self[i].Merk := BufferToString(FieldValue(5));
        Self[i].KemasanID := BufferToInteger(FieldValue(6));
        Self[i].BuyingPrice := BufferToFloat(FieldValue(7));
        Self[i].ItemCode  := BufferToString(FieldValue(8));
        Self[i].SellingPrice := BufferToFloat(FieldValue(9));
        MoveNext;
      end;
  buffer.Destroy;
end;

class function TMstItemArr.loadPriceHistory(
  AItemId,APurpose: integer): TMysqlResult;
var sql:string;
begin
  if APurpose=1 then
    sql := 'select end_date,price,supplier from mst_buying_price_hist where item_id ='+FormatSQLNumber(AItemId)+
      ' order by end_date desc '
  else
    sql := 'select end_date,price,price_petshop,price_breeder from mst_selling_price_hist where item_id ='+FormatSQLNumber(AItemId)+
      ' order by end_date desc ';
  Result := OpenSQL(sql); 
end;

function TMstItemArr.updatePrice(purpose: integer): boolean;
var i : integer;
  sql:string;
begin
   try
     BeginSQL;
     for i:= 0 to Self.count-1 do begin
      { sql := 'update mst_item set '+
              IfThen(purpose=1,' buying_price = '+FormatSQLNumber(Self[i].BuyingPrice),
              ' selling_price = '+FormatSQLNumber(Self[i].SellingPrice))+
              ' WHERE item_id = '+FormatSQLNumber(Self[i].ItemID);

       ExecSQL(sql);}

//       if purpose = 1 then
         TMstItem.updatePriceHistory(purpose,Self[i].ItemID,IfThen(purpose=1,Self[i].BuyingPrice,Self[i].SellingPrice),'',
          Self[i].PricePetshop,Self[i].PriceBreeder);
     end;
      Inform(MSG_SUCCESS_UPDATE);
      EndSQL;
      Result := True;
    except
       UndoSQL;
       Alert(MSG_UNSUCCESS_UPDATE); 
      Result := False;
    end;
end;

{ TrMstAccount_Arr }

class function TrMstAccount_Arr.LoadFromDb(var AccountArr: arMstAccount;
  vParent: integer): boolean;
var sqL: string; i: integer; buffer: TMysqlResult;
begin
  sqL:=
    'select acc_id, acc_type, acc_code, acc_name, db_cr_type, parent_id, acc_level, current_debt '+
    'from mst_account where parent_id = '+FormatSQLNumber(vParent)+
    ' order by acc_code';
  buffer:= OpenSQL(sqL);
  result:= buffer.RecordCount > 0;
  SetLength(AccountArr,0);
  if Result then
    for i:= 0 to buffer.RecordCount-1 do begin
      SetLength(AccountArr,i+1);
      AccountArr[i].AccId       := BufferToInteger(buffer.FieldValue(0));
      AccountArr[i].AccType     := BufferToString(buffer.FieldValue(1));
      AccountArr[i].AccCode     := BufferToInteger(buffer.FieldValue(2));
      AccountArr[i].AccName     := BufferToString(buffer.FieldValue(3));
      AccountArr[i].DbCrType    := BufferToString(buffer.FieldValue(4));
      AccountArr[i].ParentId    := BufferToInteger(buffer.FieldValue(5));
      AccountArr[i].AccLevel    := BufferToInteger(buffer.FieldValue(6));
      AccountArr[i].CurrentDebt := BufferToFloat(buffer.FieldValue(7));
      buffer.MoveNext;
    end;
  buffer.Destroy;

end;

{ TrMstAccount }

class procedure TrecMstAccount.Reset(var Account: trMstAccount);
begin
  with Account do begin
  AccId:=0;
  AccType:='';
  AccCode:=0;
  AccName:='';
  DbCrType:='';
  ParentId:=0;
  AccLevel:=0;
  CurrentDebt:=0;
  end;
end;

class function TrecMstAccount.SelectRoot(var Account: trMstAccount;
  Master: integer; RealROOT: Boolean): boolean;
var SQL: string; buffer: TMysqlResult;
begin
  SQL:= 'SELECT acc_id, acc_type, acc_code, acc_name, db_cr_type, parent_id, '+
        'acc_level FROM mst_account '+
        'WHERE acc_type = (select acc_type from mst_account where acc_id = '+FormatSQLNumber(Master)+')'+
        IfThen(RealROOT,' AND parent_id = 0 ',
        ' AND parent_id in(SELECT acc_id FROM mst_account WHERE parent_id = 0)');
  buffer := OpenSQL(SQL);
  Result := buffer.RecordCount>0;
  if Result then
  begin
    Account.AccId    := BufferToInteger(buffer.FieldValue(0));
    Account.AccType  := BufferToString(buffer.FieldValue(1));
    Account.AccCode  := BufferToInteger(buffer.FieldValue(2));
    Account.AccName  := BufferToString(buffer.FieldValue(3));
    Account.DbCrType := BufferToString(buffer.FieldValue(4));
    Account.ParentId := BufferToInteger(buffer.FieldValue(5));
    Account.AccLevel := BufferToInteger(buffer.FieldValue(6));
  end;
  buffer.Destroy;

end;

class procedure TMstCode_Arr.gelLats(alist: TStringList);
begin
   SQLToNameValueList(alist,
   'select code_id, '+
   'concat('+
     '(select code_name from mst_code where code_id = a.parent_id), '' - '', '+
     'code_name) as nama '+
   'from mst_code a where code_id not in (select parent_id from mst_code) '+
   'order by nama ');
end;

{ TMstMaster }

class function TMstMaster.deleteMaster(id: integer): boolean;
begin
  try
    BeginSQL;
    ExecSQL('delete from mst_master where mst_id = '+FormatSQLNumber(id));
    EndSQL;
    Result:= True;
  except raise;
    UndoSQL;
    Alert(MSG_UNSUCCESS_DELETE);
  end;
end;

class function TMstMaster.getJenis(id: integer): string;
begin
  Result:= getStringFromSQL
   ('select nama from mst_kategori where id = '+FormatSQLNumber(id));
end;

class function TMstMaster.getKode(id: integer): string;
begin
  Result:= getStringFromSQL
   ('select mst_code from mst_master where mst_id = '+FormatSQLNumber(id));
end;

class function TMstMaster.getName(id: integer): string;
begin
  Result:= getStringFromSQL
   ('select mst_name from mst_master where mst_id = '+FormatSQLNumber(id));
end;

function TMstMaster.InsertOnDB: boolean;
begin
  Result:= ExecTransaction(
    'insert into mst_master (mst_tipe, mst_code, mst_name)'+
    'values ('+FormatSQLNumber(FMstTipe)+','+FormatSQLString(FMstCode)+','+FormatSQLString(FMstName) +')');
end;

function TMstMaster.InsertProdusen: boolean;
begin
  Result:= ExecTransaction(
    'insert into mst_master (mst_tipe, mst_code, alamat, phone, mst_name)'+
    'values ('+FormatSQLNumber(FMstTipe)+','+
    FormatSQLString(FMstCode)+','+
    FormatSQLString(FAlamat)+','+
    FormatSQLString(Fphone)+','+
    FormatSQLString(FMstName) +')');
end;

function TMstMaster.isExistInDb(id: string; tipe: integer): boolean;
begin
  Result:= getIntegerFromSQL(
  'select count(mst_code) from mst_master '+
  'where mst_code = '+FormatSQLString(id) +' and mst_tipe = '+FormatSQLNumber(tipe)) > 0;
end;

class function TMstMaster.isExistInDb2(id: string; tipe: integer): boolean;
begin
  Result:= getIntegerFromSQL(
  'select count(mst_code) from mst_master '+
  'where mst_code = '+FormatSQLString(id) +' and mst_tipe = '+FormatSQLNumber(tipe)) > 0;
end;

function TMstMaster.SelectInDB: boolean;
var buffer: TMysqlResult;
begin
  buffer:= OpenSQL
   ('select mst_id, mst_tipe, mst_code, mst_name from mst_master '+
     IfThen(FMstId <> 0,
      'where mst_id = '+FormatSQLNumber(FMstId),
      'where mst_code = '+FormatSQLString(FMstCode))+

      IfThen(MstTipe<>0,
      ' and mst_tipe = '+FormatSQLNumber(FMstTipe))
    );

  result:= buffer.RecordCount > 0;
  Self.Reset;
  if Result then
    with buffer do begin
      FMstId  := BufferToInteger(FieldValue(0));
      FMstTipe:= BufferToInteger(FieldValue(1));
      FMstCode:= BufferToString(FieldValue(2));
      FMstName:= BufferToString(FieldValue(3));
    end;
  buffer.Destroy;

end;

function TMstMaster.SelectJenis: boolean;
var buffer: TMysqlResult;
begin
  buffer:= OpenSQL(
  'select id, kode, nama from mst_kategori '+
  IfThen(FMstId <> 0,
  'where id = '+FormatSQLNumber(FMstId),
  'where kode = '+FormatSQLString(FMstCode)));

  result:= buffer.RecordCount > 0;
  Self.Reset;
  if Result then
    with buffer do begin
      FMstId  := BufferToInteger(FieldValue(0));
      FMstCode:= BufferToString(FieldValue(1));
      FMstName:= BufferToString(FieldValue(2));
    end;
  buffer.Destroy;
end;

function TMstMaster.UpdateOnDB: boolean;
begin
  Result:= ExecTransaction(
    'update mst_master set mst_name = '+FormatSQLString(FMstName)+
    ', mst_code ='+FormatSQLString(FMstCode)+
    ' where mst_id = '+FormatSQLNumber(FMstId),False);
end;

function TMstMaster.UpdateProdusen: boolean;
begin
  Result:= ExecTransaction(
    'update mst_master set mst_name = '+FormatSQLString(FMstName)+
    ', mst_code ='+FormatSQLString(FMstCode)+
    ', alamat ='+FormatSQLString(FAlamat)+
    ', phone ='+FormatSQLString(Fphone)+
    ' where mst_id = '+FormatSQLNumber(FMstId),False);
end;

{ TMstMaster_Arr }

class procedure TMstMaster_Arr.GetList(vList: TStringList; vTipe: integer;withAll:boolean);
begin
  if withAll then
  SQLToNameValueList2(vList,
   ('select mst_id, mst_name from mst_master '+
   'where mst_tipe = '+FormatSQLNumber(vTipe)+' order by mst_name'))
  else
  SQLToNameValueList(vList,
   ('select mst_id, mst_name from mst_master '+
   'where mst_tipe = '+FormatSQLNumber(vTipe)+' order by mst_name'));
end;

procedure TMstMaster_Arr.LoadFromDb(tipe: integer);
var buffer: TMysqlResult; i: integer;
begin
  buffer:= OpenSQL
   ('select mst_id, mst_tipe, mst_code, mst_name, alamat, phone '+
   'from mst_master where mst_tipe = '+FormatSQLNumber(tipe)+' order by mst_name');

  Self.Clear;
  if buffer.RecordCount > 0 then
    for i := 0 to buffer.RecordCount-1 do begin
      Self.Add(
      BufferToInteger(buffer.FieldValue(0)),
      BufferToInteger(buffer.FieldValue(1)),
      BufferToString(buffer.FieldValue(2)),
      BufferToString(buffer.FieldValue(3)),
      BufferToString(buffer.FieldValue(4)),
      BufferToString(buffer.FieldValue(5)));

      buffer.MoveNext;
    end;
  buffer.Destroy;
end;

{ TMstProduk }

class function TMstProduk.DeleteFromDB(ID: Integer): boolean;
begin
  try
    BeginSQL;
    ExecSQL('delete from mst_produk where produk_id = '+FormatSQLNumber(ID));
    EndSQL;
    Result:= True;
  except raise;
    UndoSQL;
    Result:= False;
    Alert(MSG_UNSUCCESS_DELETE);
  end;
end;

class function TMstProduk.getItemUnsetted(ruleID: integer): TMysqlResult;
var filter: string;
begin
  filter:= ' and i.disabled_date is null '+
  ' and i.item_id not in(select distinct item_id from mst_produk_item where rule_id = '+FormatSQLNumber(ruleID)+')';
  if GlobalFilter.SpecID <> 0 then
    filter:= filter + ' and p.root_id ='+FormatSQLNumber(GlobalFilter.SpecID);
  if GlobalFilter.RelasiID <> 0 then
    filter:= filter + ' and i.vendor_id ='+FormatSQLNumber(GlobalFilter.RelasiID);
  if GlobalFilter.SeriesID <> 0 then
    filter:= filter + ' and i.produsen_id ='+FormatSQLNumber(GlobalFilter.SeriesID);
  if GlobalFilter.Numeric1 <> 0 then
    filter:= filter + ' and i.kemasan_id ='+FormatSQLNumber(GlobalFilter.Numeric1);
  if GlobalFilter.TipeID <> '' then
    filter:= filter + ' and i.merk like '+FormatSQLString('%'+GlobalFilter.TipeID+'%');
  if GlobalFilter.Name <> '' then
    filter:= filter + ' and i.item_name like '+FormatSQLString('%'+GlobalFilter.Name+'%');
  if GlobalFilter.FString2 <> '' then
    filter:= filter + ' and i.item_code = '+FormatSQLString(GlobalFilter.FString2);
  if GlobalFilter.FString1 <> '' then
    filter:= filter + ' and i.barcode = '+FormatSQLString(GlobalFilter.FString1);

  Result:= OpenSQL(
  'select distinct i.item_id, i.item_name from mst_item i, point_maping p '+
  'where i.specification = p.code_id '+filter+
  ' order by item_name');
end;

class procedure TMstProduk.getListCustomer(var ls: TStringList; ID: integer);
begin
  SQLToStringList(ls,
  'select jns_customer from mst_produk_customer where produk_id = '+FormatSQLNumber(ID));
end;

class function TMstProduk.getProduckDesc(ID: Integer): string;
var i, j: integer; cust, prod: TMysqlResult; desc: TStringList; tmp_cust,berlaku: string;
begin
  Result:='';
  prod:= OpenSQL(
  'select distinct p.produk_id, p.jns_produk, p.berlaku, p.periode_awal, p.periode_akhir, '+
  'r.faktor_id, r.batas_minimal, r.nilai, r.disc_prc '+
  'from mst_produk p, mst_produk_rule r, mst_produk_item i '+
  'where p.produk_id = r.produk_id and r.rule_id = i.rule_id '+
  'and p.aktif = 1 and p.faktor = '+FormatSQLNumber(PROD_FAK_ITEM)+
  ' and i.item_id = '+FormatSQLNumber(ID)+
//  ' and (berlaku = 1 or (berlaku = 2 and curdate() >= periode_awal and curdate() <= periode_akhir)) '+
  ' order by p.jns_produk, r.faktor_id, r.batas_minimal desc');

  if prod.RecordCount>0 then begin
    desc:= TStringList.Create;

    for i:= 0 to prod.RecordCount-1 do begin
      cust:= OpenSQL(
      'select case jns_customer '+
        'when '+IntToStr(PROD_CUST_CUSTOMER)+' then ''Customer, '' '+
        'when '+IntToStr(PROD_CUST_MEMBER)+' then ''Member, '' '+
        'when '+IntToStr(PROD_CUST_UNREG)+' then ''Unregister, '' end as jns '+
      'from mst_produk_customer where produk_id = '+FormatSQLNumber(BufferToInteger(prod.FieldValue(0))));
      tmp_cust:= '';
      for j:= 1 to cust.RecordCount do begin
        tmp_cust:= tmp_cust + cust.FieldValue(0);
        cust.MoveNext;
      end; cust.destroy;
      if tmp_cust <> '' then tmp_cust:= #13#10'- berlaku untuk: ' +copy(tmp_cust, 1, length(tmp_cust)-2);

      berlaku:= IfThen(BufferToInteger(prod.FieldValue(2)) = PROD_PERIODE_PERIODIK,
      #13#10'- berlaku dari '+DateToStr(BufferToDateTime(prod.FieldValue(3)))+
      ' s/d '+DateToStr(BufferToDateTime(prod.FieldValue(4)))) + tmp_cust;

      case BufferToInteger(prod.FieldValue(1)) of
        PROD_HJUAL:
          if BufferToInteger(prod.FieldValue(5)) = FAKTOR_HRG1 then
            desc.Append('H. Jual 1: minimal pembelian '+FormatSQLNumber(BufferToFloat(prod.FieldValue(6)))+' unit'+berlaku)
          else if BufferToInteger(prod.FieldValue(5)) = FAKTOR_HRG2 then
            desc.Append('H. Jual 2: minimal pembelian '+FormatSQLNumber(BufferToFloat(prod.FieldValue(6)))+' unit'+berlaku)
          else if BufferToInteger(prod.FieldValue(5)) = FAKTOR_HRG3 then
            desc.Append('H. Jual 3: minimal pembelian '+FormatSQLNumber(BufferToFloat(prod.FieldValue(6)))+' unit'+berlaku);

        PROD_DISCOUNT:
          if BufferToInteger(prod.FieldValue(5)) = FAKTOR_KELIPATAN_QTY then
            desc.Append('Disc Rp.'+FloatToStrFmt(BufferToFloat(prod.FieldValue(7)))+ ' utk tiap pembelian klipatan '+FloatToStrFmtNull(BufferToFloat(prod.FieldValue(6)))+' unit'+berlaku)
          else if BufferToInteger(prod.FieldValue(5)) = FAKTOR_KELIPATAN_NILAI then
            desc.Append('Disc Rp.'+FloatToStrFmt(BufferToFloat(prod.FieldValue(7)))+ ' utk tiap pembelian klipatan Rp.'+FloatToStrFmtNull(BufferToFloat(prod.FieldValue(6)))+berlaku)

          else if BufferToInteger(prod.FieldValue(5)) = FAKTOR_MINIMAL_QTY then begin
            if BufferToFloat(prod.FieldValue(7)) > 0 then
               desc.Append('Disc Rp.'+FloatToStrFmt(BufferToFloat(prod.FieldValue(7)))+ ' utk tiap pembelian minimal '+FloatToStrFmtNull(BufferToFloat(prod.FieldValue(6)))+' unit'+berlaku);
            if BufferToFloat(prod.FieldValue(8)) > 0 then
               desc.Append('Disc '+FloatToStrFmt(BufferToFloat(prod.FieldValue(7)))+ '% utk tiap pembelian minimal '+FloatToStrFmtNull(BufferToFloat(prod.FieldValue(6)))+' unit'+berlaku);
          end
          else if BufferToInteger(prod.FieldValue(5)) = FAKTOR_MINIMAL_NILAI then begin
            if BufferToFloat(prod.FieldValue(7)) > 0 then
               desc.Append('Disc Rp.'+FloatToStrFmt(BufferToFloat(prod.FieldValue(7)))+ ' utk pembelian minimal Rp.'+FloatToStrFmtNull(BufferToFloat(prod.FieldValue(6)))+berlaku);
            if BufferToFloat(prod.FieldValue(8)) > 0 then
               desc.Append('Disc '+FloatToStrFmt(BufferToFloat(prod.FieldValue(7)))+ '% utk pembelian minimal Rp.'+FloatToStrFmtNull(BufferToFloat(prod.FieldValue(6)))+berlaku);
           end;

        PROD_POINT:
          if BufferToInteger(prod.FieldValue(5)) = FAKTOR_QTY then
             desc.Append('Point 1: minimal pembelian '+FloatToStrFmt(BufferToFloat(prod.FieldValue(7)))+' unit '+berlaku)
          else if BufferToInteger(prod.FieldValue(5)) = FAKTOR_VALUE then
             desc.Append('Point 1: minimal pembelian Rp.'+FloatToStrFmt(BufferToFloat(prod.FieldValue(7)))+berlaku);
      end;
      prod.MoveNext;
    end;
    Result:= desc.Text;
    desc.Destroy;
  end;

end;

class function TMstProduk.getProdukCustomer(ID,
  CustID: integer): string;
begin
  Result:= getStringFromSQL(
    'select if(count(*) > 0, ''TRUE'', ''FALSE'') as hasil '+
    'from mst_produk_customer where produk_id = '+FormatSQLNumber(ID)+
    ' and jns_customer = '+FormatSQLNumber(CustID));
end;

function TMstProduk.InsertOnDB(customer: TStringList): boolean;
var i: integer;
begin
  try
    BeginSQL;
    ExecSQL(
    'insert into mst_produk (jns_produk, berlaku, periode_awal, periode_akhir, faktor, aktif) '+
    'values ('+
      FormatSQLNumber(FJnsProduk)+','+
      FormatSQLNumber(FBerlaku)+','+
      FormatSQLDate(FPeriodeAwal)+','+
      FormatSQLDate(FPeriodeAkhir)+','+
      FormatSQLNumber(FFaktor)+','+
      FormatSQLNumber(FAktif)+')');

    FProdukID:= getLastId;

    for i:= 0 to customer.Count-1 do
      ExecSQL(
      'insert into mst_produk_customer (produk_id, jns_customer) '+
      'values ('+FormatSQLNumber(FProdukID)+','+FormatSQLString(customer.Strings[i])+')');

    EndSQL;
    Result:= True;
  except raise;
    UndoSQL;
    Result:= False;
    Alert(MSG_UNSUCCESS_SAVING);
  end;
end;

function TMstProduk.isExistInDb(id: string): boolean;
begin
  Result:= getIntegerFromSQL(
    'select count(*) from mst_produk '+
    'where jns_produk = '+FormatSQLNumber(FJnsProduk)+
    ' and berlaku = '+FormatSQLNumber(FBerlaku)+
    ' and periode_awal = '+FormatSQLDate(FPeriodeAwal)+
    ' and periode_akhir = '+FormatSQLDate(FPeriodeAkhir)+
    ' and faktor = '+FormatSQLNumber(FFaktor)+
    ' and aktif  = '+FormatSQLNumber(FAktif)) > 0;
end;

class function TMstProduk.LoadFromDB: TMysqlResult;
begin
  Result:= OpenSQL(
  'select produk_id, jns_produk, berlaku, periode_awal, '+
  'periode_akhir, faktor, aktif, '+

  'case jns_produk '+
    'when 3 then ''POINT'' '+
    'when 2 then ''DISCOUNT'' '+
    'when 1 then ''HRG JUAL'' end as v_produk, '+

  'case berlaku '+
    'when 1 then ''TDK BERBATAS'' '+
    'when 2 then ''PERIODIK'' end as v_periode, '+

  'case faktor '+
    'when 2 then ''TOTAL'' '+
    'when 1 then ''PER-ITEM'' end as v_faktor '+

  'from mst_produk ');
end;

class function TMstProduk.LoadProdukItem(ruleID: integer): TMysqlResult;
begin
  Result:= OpenSQL(
  'select p.item_id, p.prod_item_id, i.item_name from mst_produk_item p, mst_item i '+
  'where p.item_id = i.item_id and p.rule_id ='+FormatSQLNumber(ruleID)+
  ' order by item_name');
end;

function TMstProduk.SelectInDB: boolean;
var buffer: TMysqlResult;
begin
  buffer:= OpenSQL(
  'select produk_id, jns_produk, berlaku, periode_awal, '+
  'periode_akhir, faktor, aktif from mst_produk '+
  'where produk_id = '+FormatSQLNumber(FProdukID));
  Self.Reset;
  Result:= buffer.RecordCount > 0;
  if Result then begin
    FProdukID:= BufferToInteger(buffer.FieldValue(0));
    FJnsProduk:= BufferToInteger(buffer.FieldValue(1));
    FBerlaku:= BufferToInteger(buffer.FieldValue(2));
    FPeriodeAwal:= BufferToDateTime(buffer.FieldValue(3));
    FPeriodeAkhir:=BufferToDateTime(buffer.FieldValue(4));
    FFaktor:= BufferToInteger(buffer.FieldValue(5));
    FAktif:= BufferToInteger(buffer.FieldValue(6));
  end;
  buffer.destroy;
end;

function TMstProduk.UpdateOnDB(customer: TStringList): boolean;
var i: integer;
begin
  try
    BeginSQL;
    ExecSQL(
    'UPDATE Mst_Produk SET'+
          ' Jns_Produk='+FormatSQLNumber(FJnsProduk)+','+
          ' Berlaku='+FormatSQLNumber(FBerlaku)+','+
          ' Periode_Awal='+FormatSQLDate(FPeriodeAwal)+','+
          ' Periode_Akhir='+FormatSQLDate(FPeriodeAkhir)+','+
          ' Faktor='+FormatSQLNumber(FFaktor)+','+
          ' Aktif='+FormatSQLNumber(FAktif)+
    ' WHERE Produk_ID='+FormatSQLNumber(FProdukID));

    ExecSQL('delete from mst_produk_customer where produk_id = '+FormatSQLNumber(FProdukID));

    for i:= 0 to customer.Count-1 do
      ExecSQL(
      'insert into mst_produk_customer (produk_id, jns_customer) '+
      'values ('+FormatSQLNumber(FProdukID)+','+FormatSQLString(customer.Strings[i])+')');

    EndSQL;
    Result:= True;

  except raise;
    UndoSQL;
    Result:= False;
    Alert(MSG_UNSUCCESS_UPDATE);
  end;
end;

{ TMstProdukRule }

class function TMstProdukRule.DeleteFromDB(ID: Integer): boolean;
begin
  try
    BeginSQL;
    ExecSQL('delete from mst_produk_rule where rule_id = '+FormatSQLNumber(ID));
    EndSQL;
    Result:= True;
  except raise;
    UndoSQL;
    Result:= False;
    Alert(MSG_UNSUCCESS_DELETE);
  end;
end;

function TMstProdukRule.InsertOnDB: boolean;
begin
  try
    BeginSQL;
    ExecSQL(
      'insert into mst_produk_rule (produk_id, faktor_id, batas_minimal, disc_prc, nilai) values ('+
      FormatSQLNumber(FProdukID)+','+
      FormatSQLNumber(FFaktorID)+','+
      FormatSQLNumber(FBatasMinimal)+','+
      FormatSQLNumber(FDiscPrc)+','+
      FormatSQLNumber(FNilai)+')');
    EndSQL;
    Result:= True;
  except raise;
    UndoSQL;
    Result:= False;
    Alert(MSG_UNSUCCESS_SAVING);
  end;
end;

class function TMstProdukRule.LoaddFromDB(ID: integer): TMysqlResult;
begin
  Result:= OpenSQL(
  'select rule_id, faktor_id, batas_minimal, nilai, disc_prc '+
  'from mst_produk_rule where produk_id = '+FormatSQLNumber(ID)+
  ' order by faktor_id, batas_minimal, nilai');
end;

function TMstProdukRule.UpdateOnDB: boolean;
begin
  try
    BeginSQL;
    ExecSQL(
     'UPDATE Mst_Produk_Rule SET'+
          ' Produk_ID='+FormatSQLNumber(FProdukID)+','+
          ' Faktor_ID='+FormatSQLNumber(FFaktorID)+','+
          ' Batas_Minimal='+FormatSQLNumber(FBatasMinimal)+','+
          ' disc_prc ='+FormatSQLNumber(FDiscPrc)+','+
          ' Nilai='+FormatSQLNumber(FNilai)+
     ' WHERE Rule_ID='+FormatSQLNumber(FRuleID));
    EndSQL;
    Result:= True;

  except raise;
    UndoSQL;
    Result:= False;
    Alert(MSG_UNSUCCESS_UPDATE);
  end;
end;

{ TMstProdukItem }

function TMstProdukItem.DeleteOnDB: boolean;
begin
  try
    BeginSQL;
    ExecSQL('delete from mst_produk_item where prod_item_id = '+FormatSQLNumber(FProdItemID));
    EndSQL;
    Result:= True;
  except raise;
    UndoSQL;
    Result:= False;
    Alert(MSG_UNSUCCESS_DELETE);
  end;
end;

function TMstProdukItem.InsertOnDB: boolean;
begin
  try
    BeginSQL;
    ExecSQL('insert into mst_produk_item (rule_id, item_id) values ('+
      FormatSQLNumber(FRuleID)+','+FormatSQLNumber(FItemID)+')');

    FProdItemID:= getIntegerFromSQL(
    'select prod_item_id from mst_produk_item '+
    'where rule_id = '+FormatSQLNumber(FRuleID)+
    ' and item_id = '+FormatSQLNumber(FItemID));

    EndSQL;
    Result:= True;
  except raise;
    UndoSQL;
    Result:= False;
    Alert(MSG_UNSUCCESS_SAVING);
  end;
end;

{ TMstPaket }

class function TMstPaket.activasi(id: integer): boolean;
begin
  try
    BeginSQL;
    ExecSQL(
    'update mst_paket set disabled_date = if(disabled_date is null, curdate(), null) '+
    'where paket_id = '+FormatSQLNumber(id));
    EndSQL;
    Result:= True;
  except raise;
    Inform(MSG_UNSUCCESS_UPDATE);
    UndoSQL;
    Result:= False;
  end;
end;

procedure TMstPaket.Clear;
begin
  Self.Reset;
  Item.Clear;
end;

constructor TMstPaket.Create;
begin
  inherited Create;
  Item:= _MstPaketItem_Arr.Create;
end;

class function TMstPaket.DeleteItemPaket(id: integer): boolean;
begin
  try
    BeginSQL;
    ExecSQL('delete from mst_paket_item where paket_item_id = '+IntToStr(id));
    EndSQL;
    Result:= True;
  except
    UndoSQL;
    Result:= False;
    Alert('Data tidak bisa dihapus');
  end;
end;

destructor TMstPaket.Destroy;
begin
  Item.Free;
  inherited;
end;

function TMstPaket.InsertOnDB: boolean;
var i: integer; 
begin
  try
    BeginSQL;
    ExecSQL(
    'insert into mst_paket ('+
    'kode, barcode, nama, nama_struk, unit_id, gudang_id, harga_dasar, harga_jual) '+
    'values ('+
      FormatSQLString(FKode)+','+
      FormatSQLString(FBarcode)+','+
      FormatSQLString(FNama)+','+
      FormatSQLString(FNamaStruk)+','+
      IfThen(FUnitID<>0,FormatSQLNumber(FUnitID), FormatSQLNULL)+','+
      FormatSQLNumber(FGudangID)+','+
      FormatSQLNumber(FHargaDasar)+','+
      FormatSQLNumber(FHargaJual)+')');

    FPaketID:= getIntegerFromSQL('select paket_id from mst_paket where kode = '+FormatSQLString(FKode));
    for i:= 0 to Item.Count-1 do begin
      ExecSQL(
      'insert into mst_paket_item ('+
      'paket_id, item_id, conv_id, hrg_dasar, harga, discount, qty, conversion) '+
      'values ('+
        FormatSQLNumber(PaketID)+','+
        FormatSQLNumber(Item[i].ItemID)+','+
        FormatSQLNumber(Item[i].ConvID)+','+
        FormatSQLNumber(Item[i].HrgDasar)+','+
        FormatSQLNumber(Item[i].Harga)+','+
        FormatSQLNumber(Item[i].Discount)+','+
        FormatSQLNumber(Item[i].Qty)+','+
        FormatSQLNumber(Item[i].Conversion)+')');
    end;
    EndSQL;
    Result:= True;
  except
    UndoSQL;
    Result:= False;
    Inform(MSG_UNSUCCESS_SAVING);
  end;
end;

function TMstPaket.isExistBarcode(id: string): boolean;
begin
  Result:= getIntegerFromSQL('select count(*) from mst_paket where barcode = '+FormatSQLString(id))>0;
  if not Result then
  Result:= getIntegerFromSQL('select count(*) from mst_item where barcode = '+FormatSQLString(id))>0;
end;

function TMstPaket.isExistInDb(id: string): boolean;
begin
  Result:= getIntegerFromSQL('select count(*) from mst_paket where kode = '+FormatSQLString(id))>0;
  if not Result then
  Result:= getIntegerFromSQL('select count(*) from mst_item where item_code = '+FormatSQLString(id))>0;
end;

class function TMstPaket.LoadFromDB: TMysqlResult;
var sqL, filter: string;
begin
  if GlobalFilter.StatusID = 1 then filter:= ' and p.disabled_date is null '
  else if GlobalFilter.StatusID = 2 then filter:= ' and p.disabled_date is not null ';

  if GlobalFilter.SpecID <> 0 then
    filter:= filter + ' and m.root_id ='+FormatSQLNumber(GlobalFilter.SpecID);
  if GlobalFilter.RelasiID <> 0 then
    filter:= filter + ' and i.vendor_id ='+FormatSQLNumber(GlobalFilter.RelasiID);
  if GlobalFilter.SeriesID <> 0 then
    filter:= filter + ' and i.produsen_id ='+FormatSQLNumber(GlobalFilter.SeriesID);
  if GlobalFilter.Numeric1 <> 0 then
    filter:= filter + ' and i.kemasan_id ='+FormatSQLNumber(GlobalFilter.Numeric1);
  if GlobalFilter.Name <> '' then
    filter:= filter + ' and p.nama like '+FormatSQLString('%'+GlobalFilter.Name+'%');

  sqL:=
  'select distinct p.paket_id, p.kode, p.barcode, p.nama, '+
  'p.harga_dasar, p.harga_jual, p.current_stock, '+
  '(select mst_code from mst_master where mst_id = p.unit_id) as sat '+
  'from mst_paket p order by p.nama ';

  {', mst_paket_item px, mst_item i, point_maping m '+
  'where p.paket_id = px.paket_id and px.item_id = i.item_id '+
  'and i.specification = m.code_id '+ filter;                  }

  result:= OpenSQL(sqL);
end;

function TMstPaket.SelectInDB: boolean;
var //i: integer;
 buffer: TMysqlResult;
begin
  buffer:= OpenSQL(
  'select paket_id, kode, barcode, nama, nama_struk, unit_id, harga_dasar, harga_jual, gudang_id '+
  'from mst_paket '+
  IfThen(PaketID <> 0,
  'where paket_id = '+FormatSQLNumber(FPaketID),
  'where kode = '+FormatSQLString(Kode)));
  Self.Clear;
  result:= buffer.RecordCount > 0;

  if Result then
  with buffer do begin
    FPaketID   := BufferToInteger(FieldValue(0));
    FKode      := BufferToString(FieldValue(1));
    FBarcode   := BufferToString(FieldValue(2));
    FNama      := BufferToString(FieldValue(3));
    FNamaStruk := BufferToString(FieldValue(4));
    FUnitID    := BufferToInteger(FieldValue(5));
    FHargaDasar:= BufferToFloat(FieldValue(6));
    FHargaJual := BufferToFloat(FieldValue(7));
    FGudangID  := BufferToInteger(FieldValue(8));
  end;
  buffer.Destroy;

  {if Result then begin
    buffer:= OpenSQL(
    'select paket_item_id, paket_id, item_id, conv_id, qty, conversion, '+
    'round(harga * conversion) as harga, discount, '+
    'round(hrg_dasar * conversion) '+
    'from mst_paket_item where paket_id = '+FormatSQLNumber(FPaketID));

    result:= buffer.RecordCount > 0;
    if Result then
    for i:= 0 to buffer.RecordCount-1 do begin
      Item.Add(
      BufferToInteger(buffer.FieldValue(0)),
      BufferToInteger(buffer.FieldValue(1)),
      BufferToInteger(buffer.FieldValue(2)),
      BufferToInteger(buffer.FieldValue(3)),
      BufferToFloat(buffer.FieldValue(4)),
      BufferToFloat(buffer.FieldValue(5)),
      BufferToFloat(buffer.FieldValue(6)),
      BufferToFloat(buffer.FieldValue(7)),
      BufferToFloat(buffer.FieldValue(8)));
      buffer.MoveNext;
    end;
    buffer.Destroy;
  end;   }
end;

function TMstPaket.UpdateOnDB: boolean;
var i: integer;
begin
  try
    BeginSQL;
    ExecSQL(
    'update mst_paket SET'+
      ' kode='+FormatSQLString(FKode)+','+
      ' barcode='+FormatSQLString(FBarcode)+','+
      ' nama='+FormatSQLString(FNama)+','+
      ' nama_struk='+FormatSQLString(FNamaStruk)+','+
      ' harga_dasar='+FormatSQLNumber(FHargaDasar)+','+
      ' harga_jual='+FormatSQLNumber(FHargaJual)+','+
      ' gudang_id='+FormatSQLNumber(FGudangID)+','+
      ' unit_id ='+IfThen(FUnitID <> 0, FormatSQLNumber(FUnitID), FormatSQLNULL)+
    ' WHERE paket_id='+FormatSQLNumber(FPaketID));

    for i:= 0 to Item.Count-1 do begin
      if Item[i].PaketItemID = 0 then
        ExecSQL(
        'insert into mst_paket_item ('+
        'paket_id, item_id, conv_id, hrg_dasar, harga, discount, qty, conversion) '+
        'values ('+
          FormatSQLNumber(PaketID)+','+
          FormatSQLNumber(Item[i].ItemID)+','+
          FormatSQLNumber(Item[i].ConvID)+','+
          FormatSQLNumber(Item[i].HrgDasar)+','+
          FormatSQLNumber(Item[i].Harga)+','+
          FormatSQLNumber(Item[i].Discount)+','+
          FormatSQLNumber(Item[i].Qty)+','+
          FormatSQLNumber(Item[i].Conversion)+')')
      else
        ExecSQL(
        'update mst_paket_item SET'+
          ' item_id='+FormatSQLNumber(Item[i].ItemID)+','+
          ' conv_id='+FormatSQLNumber(Item[i].ConvID)+','+
          ' hrg_dasar='+FormatSQLNumber(Item[i].HrgDasar)+','+
          ' harga='+FormatSQLNumber(Item[i].Harga)+','+
          ' discount='+FormatSQLNumber(Item[i].Discount)+','+
          ' qty='+FormatSQLNumber(Item[i].Qty)+','+
          ' conversion='+FormatSQLNumber(Item[i].Conversion)+
        ' WHERE paket_item_id='+FormatSQLNumber(Item[i].PaketItemID));
    end;
    EndSQL;
    Result:= True;
  except
    UndoSQL;
    Result:= False;
    Inform(MSG_UNSUCCESS_SAVING);
  end;
end;

class function TMstPaket.UpdateStock(APaketID: integer; AValue: double;
  ADbCrType: string): boolean;
begin
  try

    save_balace_paket(APaketID, AValue, ADbCrType);
    Result:= True;
  except
  raise
  end;  
end;

class function TrMstCode_Arr.LoadFromRak(var rMstCode: arMstCode;
  vParent: integer): boolean;
var i: integer; buffer: TMysqlResult;
begin
  buffer:= OpenSQL(
  'select rak_id, kode, nama, parent_id, level from mst_rak '+
  'where parent_id = '+FormatSQLNumber(vParent)+
  ' order by kode ');

  result:= buffer.RecordCount > 0;
  SetLength(rMstCode, 0);
  if Result then
    for i:= 0 to buffer.RecordCount-1 do begin
      SetLength(rMstCode, length(rMstCode)+1);
      rMstCode[i].FCodeId   := BufferToInteger(buffer.FieldValue(0));
      rMstCode[i].FKode     := BufferToString(buffer.FieldValue(1));
      rMstCode[i].FCodeName := BufferToString(buffer.FieldValue(2));
      rMstCode[i].FParentId := BufferToInteger(buffer.FieldValue(3));
      rMstCode[i].FLevel    := BufferToInteger(buffer.FieldValue(4));
      buffer.MoveNext;
    end;
  buffer.Destroy;
end;

{ TMstDokter }

class function TMstDokter.activasi(id: integer): boolean;
begin
  try
    BeginSQL;
    ExecSQL(
    'update mst_dokter set disabled_date = if(disabled_date is null, curdate(), null) '+
    'where dokter_id = '+FormatSQLNumber(id));
    EndSQL;
    Result:= True;
  except raise;
    Inform(MSG_UNSUCCESS_UPDATE);
    UndoSQL;
    Result:= False;
  end;
end;

class function TMstDokter.deleteDate(id: integer): boolean;
begin
  try
    BeginSQL;
    ExecSQL(
    'delete from mst_dokter where dokter_id = '+FormatSQLNumber(id));
    EndSQL;
    Result:= True;
  except raise;
    Inform(MSG_UNSUCCESS_DELETE);
    UndoSQL;
    Result:= False;
  end;
end;

class function TMstDokter.GetName(vId: integer): string;
begin
  Result:= getStringFromSQL
  ('select nama from mst_dokter where dokter_id = '+FormatSQLNumber(vId));
end;

function TMstDokter.GetNextCode(): string;
var prefix: string;
begin
  prefix:= UpperCase(Copy(FNama, 1,1))+'.';
  Result:= getNextIDNum('kode','mst_dokter','',prefix,'',3);
end;

function TMstDokter.InsertOnDB: boolean;
begin
  try
    BeginSQL;
    FKode:= GetNextCode;

    ExecSQL(
    'insert into mst_dokter (kode, nama, alamat, spesialis, item_id, contact) '+
    'values ('+
      FormatSQLString(FKode)+','+
      FormatSQLString(FNama)+','+
      FormatSQLString(FAlamat)+','+
      IfThen(Fitemid <>0, FormatSQLNumber(Fitemid), FormatSQLNULL)+','+
      FormatSQLString(Fspesialis)+','+

      FormatSQLString(FKontak)+')');

    FDokterID:= getIntegerFromSQL('select dokter_id from mst_dokter where kode ='+FormatSQLString(FKode));
    EndSQL;
    Result:= True;
  except
    UndoSQL;
    Result:= False;
    Alert(MSG_UNSUCCESS_SAVING);
  end;
end;

function TMstDokter.isExistInDb(id: string): boolean;
begin
  Result:= getIntegerFromSQL(
  'select count(*) from mst_dokter where kode = '+FormatSQLString(id)) > 0;
end;

class function TMstDokter.LoadFromDB: TMysqlResult;
var sqL: string;
begin
  sqL:=
  'select dokter_id, Kode, Nama, Alamat, contact as Kontak '+
  'from mst_dokter ';

  if GlobalFilter.StatusID = 1 then sqL:= sqL + ' where disabled_date is null '
  else if GlobalFilter.StatusID = 2 then sqL:= sqL + ' where disabled_date is not null ';

  if GlobalFilter.Name <> '' then
    sqL:= sqL + ' and nama like '+FormatSQLString('%'+GlobalFilter.Name+'%');
  if GlobalFilter.FString1 <> '' then
    sqL:= sqL + ' and alamat like '+FormatSQLString('%'+GlobalFilter.FString1+'%');

  Result:= OpenSQL(sqL + ' order by nama');
end;

function TMstDokter.SelectInDB: boolean;
var buffer: TMysqlResult;
begin
  buffer:= OpenSQL(
  'select dokter_id, kode, nama, alamat, contact, spesialis, item_id '+
  'from mst_dokter '+
    IfThen(FDokterID <> 0,
    'where dokter_id = '+FormatSQLNumber(FDokterID),
    'where kode = '+FormatSQLString(FKode))
    );

  result:= buffer.RecordCount > 0;
  Self.Reset;
  if Result then
    with buffer do begin
      FDokterID := BufferToInteger(FieldValue(0));
      FKode     := BufferToString(FieldValue(1));
      FNama     := BufferToString(FieldValue(2));
      FAlamat   := BufferToString(FieldValue(3));
      FKontak   := BufferToString(FieldValue(4));
      Fspesialis   := BufferToString(FieldValue(5));
      Fitemid   := BufferToInteger(FieldValue(6));
    end;
  buffer.Destroy;

end;

function TMstDokter.UpdateOnDB: boolean;
begin
  try
    BeginSQL;
   // FKode:= GetNextCode;

    ExecSQL(
    'update mst_dokter set '+
    ' kode= '+FormatSQLString(FKode)+','+
    ' nama= '+FormatSQLString(FNama)+','+
    ' alamat= '+FormatSQLString(FAlamat)+','+
    ' spesialis= '+FormatSQLString(Fspesialis)+','+
     ' item_id = '+IfThen(Fitemid <>0, FormatSQLNumber(Fitemid), FormatSQLNULL)+','+

    ' contact= '+FormatSQLString(FKontak)+
    ' where dokter_id= '+FormatSQLNumber(FDokterID));

    EndSQL;
    Result:= True;
  except
    UndoSQL;
    Result:= False;
    Alert(MSG_UNSUCCESS_UPDATE);
  end;
end;

{ TMstPasien }

class function TMstPasien.countFromDB: integer;
var filter: string;
begin

  if GlobalFilter.Name <> '' then
    filter := ' and nama like '+FormatSQLString('%'+GlobalFilter.Name+'%');
  if GlobalFilter.FString1 <> '' then
    filter:= filter + ' and alamat like '+FormatSQLString('%'+GlobalFilter.FString1+'%');
  if GlobalFilter.FString2 <> '' then
    filter:= filter + ' and kota like '+FormatSQLString('%'+GlobalFilter.FString2+'%');

  if filter <> '' then  filter:= ' where ' + copy(filter, 5, length(filter));

  Result:= getIntegerFromSQL('select count(pasien_id) from mst_pasien '+filter);
end;

class function TMstPasien.deleteDate(id: integer): boolean;
begin
  try
    BeginSQL;
    ExecSQL(
    'delete from mst_pasien where pasien_id = '+FormatSQLNumber(id));
    EndSQL;
    Result:= True;
  except raise;
    Inform(MSG_UNSUCCESS_DELETE);
    UndoSQL;
    Result:= False;
  end;
end;

class function TMstPasien.GetCardID(ID: integer): string;
begin
  Result:= getStringFromSQL
  ('select card_id from mst_pasien where pasien_id = '+FormatSQLNumber(ID));
end;

class function TMstPasien.GetName(vId: integer): string;
begin
  Result:= getStringFromSQL
  ('select nama from mst_pasien where pasien_id = '+FormatSQLNumber(vId));
end;

function TMstPasien.GetNextCode: string;
var prefix: string;
begin
  prefix:= UpperCase(Copy(FNama, 1,1))+'';
  Result:= getNextIDNum('kode','mst_pasien','',prefix,'',8);
end;

function TMstPasien.InsertOnDB: boolean;
begin
  try
    BeginSQL;
    FKode:= GetNextCode;

    ExecSQL(
    'insert into mst_pasien (kode, nama, alamat, phone, kota, sex, tgl_lahir, card_id) '+
    'values ('+
      FormatSQLString(FKode)+','+
      FormatSQLString(FNama)+','+
      FormatSQLString(FAlamat)+','+
      FormatSQLString(FPhone)+','+
      FormatSQLString(FKota)+','+
      FormatSQLNumber(FSex)+','+
      FormatSQLDate(FTglLahir)+','+
      FormatSQLString(FCardID)+')');

    PasienID:= getIntegerFromSQL('select pasien_id from mst_pasien where kode ='+FormatSQLString(FKode));
    EndSQL;
    Result:= True;
  except
    UndoSQL;
    Result:= False;
    Alert(MSG_UNSUCCESS_SAVING);
  end;
end;

function TMstPasien.isExistInDb(id: string): boolean;
begin
  Result:= getIntegerFromSQL(
  'select count(*) from mst_pasien where kode = '+FormatSQLString(id)) > 0;
end;

class function TMstPasien.LoadFromDB: TMysqlResult;
var sqL, filter: string;
begin

  if GlobalFilter.Name <> '' then
    filter:= ' and nama like '+FormatSQLString('%'+GlobalFilter.Name+'%');
  if GlobalFilter.FString1 <> '' then
    filter:= filter + ' and alamat like '+FormatSQLString('%'+GlobalFilter.FString1+'%');
  if GlobalFilter.FString2 <> '' then
    filter:= filter + ' and kota like '+FormatSQLString('%'+GlobalFilter.FString2+'%');

  if filter <> '' then  filter:= ' where ' + copy(filter, 5, length(filter));
  filter:= filter + ' order by nama ';
  if GlobalFilter.FOffset <> 0 then
    filter:= filter +
    ' limit '+FormatSQLNumber(GlobalFilter.FLimit)+ ', '+FormatSQLNumber(GlobalFilter.FOffset);

  sqL:=
  'select pasien_id, kode, nama, alamat, phone, kota, sex, tgl_lahir, card_id '+
  'from mst_pasien '+filter;

  Result:= OpenSQL(sqL);
end;

function TMstPasien.SelectInDB: boolean;
var buffer: TMysqlResult;
begin
  buffer:= OpenSQL(
  'select pasien_id, kode, nama, alamat, phone, kota, sex, tgl_lahir, card_id '+
  'from mst_pasien '+
    IfThen(FPasienID <> 0,
    'where pasien_id = '+FormatSQLNumber(FPasienID),
    'where kode = '+FormatSQLString(FKode))
    );

  result:= buffer.RecordCount > 0;
  Self.Reset;
  if Result then
    with buffer do begin
      FPasienID:= BufferToInteger(FieldValue(0));
      FKode    := BufferToString(FieldValue(1));
      FNama    := BufferToString(FieldValue(2));
      FAlamat  := BufferToString(FieldValue(3));
      FPhone   := BufferToString(FieldValue(4));
      FKota    := BufferToString(FieldValue(5));
      FSex     := BufferToInteger(FieldValue(6));
      FTglLahir:= BufferToDateTime(FieldValue(7));
      FCardID  := BufferToString(FieldValue(8));
    end;
  buffer.Destroy;
end;

class procedure TMstPasien.UpdateCardID(ID: integer; vcard: string);
begin
  try
    ExecSQL(
    'update mst_pasien set card_id= '+FormatSQLString(vcard)+
    ' where pasien_id= '+FormatSQLNumber(ID));
  except
  end;
end;

function TMstPasien.UpdateOnDB: boolean;
begin
  try
    BeginSQL;

    ExecSQL(
    'update mst_pasien set '+
    ' kode= '+FormatSQLString(FKode)+','+
    ' nama= '+FormatSQLString(FNama)+','+
    ' alamat= '+FormatSQLString(FAlamat)+','+
    ' phone= '+FormatSQLString(FPhone)+','+
    ' kota= '+FormatSQLString(FKota)+','+
    ' sex= '+FormatSQLNumber(FSex)+','+
    ' card_id= '+FormatSQLString(FCardID)+','+
    ' tgl_lahir= '+FormatSQLDate(FTglLahir)+
    ' where pasien_id= '+FormatSQLNumber(FPasienID));
    EndSQL;
    Result:= True;
  except
    UndoSQL;
    Result:= False;
    Alert(MSG_UNSUCCESS_UPDATE);
  end;
end;

{ TMstBranch }

class function TMstBranch.activasi(id: integer): boolean;
begin

end;

function TMstBranch.DeleteDB: boolean;
begin
  try
    ExecSQL('delete from mst_branch where branch_id = '+FormatSQLNumber(FBranchID));

    Result:= true;
  except raise;
    Result:= false;
    Alert(MSG_UNSUCCESS_DELETE);
  end;

end;

class function TMstBranch.getCode(ID: integer): string;
begin

end;

class procedure TMstBranch.getList(var list: TStringList; includeSelf: boolean);
var filter: string;
begin

  if (includeSelf = false)
   then filter:= ' and (branch_id <> '+FormatSQLNumber(CompanyProfile.FCurrentBranch)+')';

  if (filter <> '')
  then filter:= ' where '+ copy(filter, 5, length(filter));

  SQLToNameValueList(list,
  'select branch_id, branch_name from mst_branch '+filter+
  ' order by branch_name');

end;

class function TMstBranch.getName(ID: integer): string;
begin

end;

class function TMstBranch.getNextCode: string;
var prefix, s: string;
begin
  s:= '';
  prefix:= getStringFromSQL(
  'select max(coalesce((branch_code), 0)) from mst_branch');

  s:= getNextID(prefix, '', 3);
  Result:= s;

end;

function TMstBranch.InsertInDb: boolean;
begin
try
    if FBranchID <> 0 then

      ExecSQL(
      'update mst_branch set '+
      'branch_name = '+FormatSQLString(FBranchName)+', '+
      'branch_code = '+FormatSQLString(FBranchCode)+', '+
      'address = '+FormatSQLString(FAddress)+', '+
      'phone1 = '+FormatSQLString(FPhone1)+', '+
      'phone2 = '+FormatSQLString(FPhone2)+', '+
      'fax = '+FormatSQLString(FFax)+', '+
      'city = '+FormatSQLString(FCity)+', '+
      'postal_code = '+FormatSQLString(FPostalCode)+','+
      'edit_log='+FormatSQLString(getSecurityLog)+
      ' where branch_id = '+FormatSQLNumber(FBranchID))

    else begin
      ExecSQL(
      'insert into mst_branch ('+
      'branch_name, branch_code, address, phone1, phone2, '+
      ' fax, city,  postal_code,insert_log) '+
      'values ('+
        FormatSQLString(FBranchName)+', '+
        FormatSQLString(FBranchCode)+', '+
        FormatSQLString(FAddress)+', '+
        FormatSQLString(FPhone1)+', '+
        FormatSQLString(FPhone2)+', '+
        FormatSQLString(FFax)+', '+
        FormatSQLString(FCity)+', '+
        FormatSQLString(FPostalCode)+','+FormatSQLString(getSecurityLog)+')');
      FBranchID:= getLastId;
    end;

    Result:= true;
  except raise;
    Result:= false;
    Alert(MSG_UNSUCCESS_SAVING);
  end;
end;

class function TMstBranch.isExistInDB(code: string; ID: integer): boolean;
begin
  Result:= getIntegerFromSQL(
  'select count(*) from mst_branch '+
  'where (branch_code = '+FormatSQLString(code)+') '+
  'and (branch_id <> '+IntToStr(ID)+')')>0;
end;

class function TMstBranch.loadFromDB: TMysqlResult;
var filter, sql: string;
begin

 // filter := ' and branch_id <> 1 ';
//  if GlobalFilter.StatusID = 1 then filter:= filter + ' and disabled_date is null '
  //else if GlobalFilter.StatusID = 2 then filter:= filter + ' and disabled_date is not null ';
  if GlobalFilter.Name <> '' then
    filter:= filter + ' and branch_name like '+FormatSQLString('%'+GlobalFilter.Name+'%');
//  if GlobalFilter.FString1 <> '' then
  //  filter:= filter + ' and address like '+FormatSQLString('%'+GlobalFilter.FString1+'%');
  if GlobalFilter.FString2 <> '' then
    filter:= filter + ' and city like '+FormatSQLString('%'+GlobalFilter.FString2+'%');

  if filter <> '' then filter:= ' where ' + copy(filter, 5, length(filter));

  sqL:=
  'select branch_id, branch_name, address,  phone1, phone2, fax, city, '+
  'postal_code, branch_code '+
  'from mst_branch '+filter+
  ' order by branch_name';

  Result:= OpenSQL(sql);

end;

function TMstBranch.SelectInDB: boolean;
var buffer: TMysqlResult;
begin
  buffer:= OpenSQL(
  'select branch_id, branch_name, address, phone1, phone2, '+
  'fax, city, postal_code, branch_code '+
  'from mst_branch '+
  IfThen(FBranchID <> 0,
  'where branch_id = '+FormatSQLNumber(FBranchID),
  'where branch_code = '+FormatSQLString(FBranchCode)));

  Result := (buffer.RecordCount>0);
  if buffer.RecordCount > 0 then begin
    FBranchID:= BufferToInteger(buffer.FieldValue(0));
    FBranchName:= BufferToString(buffer.FieldValue(1));
    FAddress:= BufferToString(buffer.FieldValue(2));
    FPhone1:= BufferToString(buffer.FieldValue(3));
    FPhone2:= BufferToString(buffer.FieldValue(4));
    FFax:= BufferToString(buffer.FieldValue(5));
    FCity:= BufferToString(buffer.FieldValue(6));
    FPostalCode:= BufferToString(buffer.FieldValue(7));
    FBranchCode:= BufferToString(buffer.FieldValue(8));
  end;
  buffer.destroy;

end;

function TMstBranch.SelectLookup: boolean;
var buffer: TMysqlResult;
begin
  buffer:= OpenSQL(
  'select branch_id, branch_name,  '+
  'branch_code '+
  'from mst_branch '+
  'where '+
   IfThen(FBranchID>0,' branch_id = '+FormatSQLNumber(FBranchID),' branch_code ='+FormatSQLString(FBranchCode)));
  Result := (buffer.RecordCount>0);
  if buffer.RecordCount > 0 then begin
    FBranchID:= BufferToInteger(buffer.FieldValue(0));
    FBranchName:= BufferToString(buffer.FieldValue(1));
    FBranchCode:= BufferToString(buffer.FieldValue(2));

  end;
  buffer.destroy;


end;

{ TMstAkun }

class function TMstAkun.DeleteFromDb(id: integer): boolean;
begin
   Result := ExecTransaction2('delete from mst_akun where akun_id ='+FormatSQLNumber(id));
end;

class procedure TMstAkun.getList(var AList: TStringList;
  tipe:integer;forFilter: boolean);
var sql:string;
begin
  sql := 'select akun_id, nama from mst_akun '+IfThen(tipe>0,' where tipe='+FormatSQLNumber(tipe),'')+
    ' order by nama';
  if forFilter then
    SQLToNameValueList(AList,sql)
  else
    SQLToNameValueList(AList,sql);
 // if forFilter then
   // AList.Insert(0,'Pilih');
end;

class function TMstAkun.getName(id: integer): string;
begin
  Result := getStringFromSQL('select nama from mst_akun where akun_id='+FormatSQLNumber(id));
end;

function TMstAkun.GetNextCode: string;
   var prefix, s: string;
begin
  s:= '';
  prefix:= getStringFromSQL( 'select max(coalesce((kode), 0)) from mst_akun');

  s:= getNextID(prefix, '', 3);
  Result:= s;

end;

function TMstAkun.InsertOnDB:boolean;
begin
   try
      ExecSQL(
      'insert into mst_akun ('+
      'nama, kode, tipe ) '+
      'values ('+
        FormatSQLString(FNama)+', '+
        FormatSQLString(FKode)+', '+
        FormatSQLNumber(FTipe)+')');
      FAkunID:= getLastId;

    Result:= true;
  except raise;
    Result:= false;
    Alert(MSG_UNSUCCESS_SAVING);
  end;
end;

function TMstAkun.isExistInDb(id: string): boolean;
begin
  Result:= getIntegerFromSQL
    ('select count(*) from mst_akun where kode = '+FormatSQLString(id)) > 0;

end;

class function TMstAkun.LoadFromDB: TMysqlResult;
var sqL: string;
begin
  sqL:=
  'select akun_id,kode,nama,case tipe when 2 then ''Credit'' else ''Debit'' end as tipe '+
  'from mst_akun ';


  Result:= OpenSQL(sqL + ' order by nama');


end;

function TMstAkun.SelectInDB: boolean;
var buffer: TMysqlResult;
begin
  buffer:= OpenSQL(
  'select akun_id, tipe, kode, nama '+
  'from mst_akun '+
  IfThen(FAkunID <> 0,
  'where akun_id = '+FormatSQLNumber(FAkunID),
  'where kode = '+FormatSQLString(FKode)));

  Result := (buffer.RecordCount>0);
  if buffer.RecordCount > 0 then begin
    FAkunID:= BufferToInteger(buffer.FieldValue(0));
    FTipe:= BufferToInteger(buffer.FieldValue(1));
    FKode:= BufferToString(buffer.FieldValue(2));
    FNama:= BufferToString(buffer.FieldValue(3));
  end;
  buffer.destroy;

end;

function TMstAkun.UpdateOnDB: boolean;
begin
   try

      ExecSQL(
      'update mst_akun set '+
      'nama = '+FormatSQLString(FNama)+', '+
      'tipe = '+FormatSQLNumber(FTipe)+', '+
      'kode = '+FormatSQLString(FKode)+
      ' where akun_id = '+FormatSQLNumber(FAkunID));


    Result:= true;
  except raise;
    Result:= false;
    Alert(MSG_UNSUCCESS_SAVING);
  end;
end;

end.
