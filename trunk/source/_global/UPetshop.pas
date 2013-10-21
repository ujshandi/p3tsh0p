unit UPetshop;

interface

uses
  Classes, Controls, SysUtils, AutoStockLine, Subroutines,Math,
  strUtils,  uMysqlClient;

type
  TMstServicePrice = class;
  TMstService = class(TObject)
  protected
    FServiceId    :integer;
    FServiceCode  : string;
    FServiceName: string; //[0]
    FNotes: string; //[0]
    FServiceType:integer;
  public
    function InsertOnDB: boolean;
    function UpdateOnDB: boolean;
    function SelectInDB: boolean;
    procedure Reset;
    function isExistInDb(id: string): boolean;

    function GetNextCode(): string;
    class function deleteOnDb(id: integer): boolean;
    class function GetName(vId: integer): string;
    class function activasi(id: integer): boolean;
    class function LoadFromDB(): TMysqlResult;
    class function getServiceType(id:integer):integer;
    class procedure GetList(vList: TStringList; vTipe: integer=-1);

    property ServiceId : integer read FServiceId write FServiceId;
    property ServiceCode:string read FServiceCode write FServiceCode;
    property ServiceName : string read FServiceName write FServiceName;
    property Notes : string read FNotes write FNotes;
    property ServiceType : integer read FServiceType write FServiceType;
        
  end;

  TMstCage = class(TObject)
  protected
    FCageId    :integer;
    FCageCode  : string;
    FCage: string; //[0]
    FNotes: string; //[0]
    FUsed :Smallint;
    FDisabled : smallint;
    
  public
    function InsertOnDB: boolean;
    function UpdateOnDB: boolean;
    function SelectInDB: boolean;
    procedure Reset;
    function isExistInDb(id: string): boolean;

    function GetNextCode(): string;
    class function deleteOnDb(id: integer): boolean;
    class function GetName(vId: integer): string;
    class function activasi(id: integer): boolean;
    class function LoadFromDB(): TMysqlResult;


    property CageId : integer read FCageId write FCageId;
    property CageCode:string read FCageCode write FCageCode;
    property Cage : string read FCage write FCage;
    property Notes : string read FNotes write FNotes;
    property Used : smallint read FUsed write FUsed;
    property Disabled : smallint read FDisabled write FDisabled;

  end;

  TMstServiceBonus = class(TObject)
  public
    FServiceType,FJmlService,FBonusService,FBonusJml,FIsKumulatif:integer;
    procedure reset;
    procedure UpdateOnDb;
    function SelectInDb(aServiceType:integer):boolean;
    function load:TMysqlResult;
    class function isAdaBonus(aServiceType:integer):boolean;
    class function isKumulatif(aServiceType:integer):boolean;
    class function getBonusJml(aServiceType:integer):integer;
    class function getBatasJml(aServiceType:integer):integer;
  end;


  TMstAnimal = class(TObject)
  protected
    FAnimalId    :integer;
    FAnimalCode  : string;
    FAnimal: string; //[0]
    FNotes: string; //[0]

  public
    function InsertOnDB: boolean;
    function UpdateOnDB: boolean;
    function SelectInDB: boolean;
    procedure Reset;
    function isExistInDb(id: string): boolean;


    function GetNextCode(): string;
    class function deleteOnDb(id: integer): boolean;
    class function GetName(vId: integer): string;
    class function activasi(id: integer): boolean;
    class function LoadFromDB(): TMysqlResult;
    class procedure getListCombo(AList:TStringList;forFilter:boolean=false);

    property AnimalId : integer read FAnimalId write FAnimalId;
    property AnimalCode:string read FAnimalCode write FAnimalCode;
    property Animal : string read FAnimal write FAnimal;
    property Notes : string read FNotes write FNotes;

  end;

  TMstKaryawan = class (TObject)
    FKaryawanId : integer;
    FNik : string;
    FNama : string;
    FAlamat : string;
    FJabatan : integer;
    FTglLahir : TDate;
    FTelp1 : string;
    FTelp2 : string;
    FDisabledDate : TDate;
    private

    public
      function InsertOnDB: boolean;
      function UpdateOnDB: boolean;
      function SelectInDB: boolean;
      procedure Reset;
      function isExistInDb(id: string): boolean;
      function GetNextCode(vJabatan: integer): string;

      class function deleteOnDb(id: integer): boolean;
      class function GetName(vId: integer): string;
      class function activasi(id: integer): boolean;
      class function LoadFromDB(): TMysqlResult;
      class procedure getListCombo(AList:TStringList;forFilter:boolean=false);

      property KaryawanId:integer read FKaryawanId write  FKaryawanId;
      property Nik:string read FNik write FNik;
      property Nama:string read FNama write FNama;
      property Alamat:string read FAlamat write FAlamat;
      property Jabatan:integer read FJabatan write FJabatan;
      property TglLahir:TDate read FTglLahir write FTglLahir;
      property Telp1 :string read FTelp1 write FTelp1;
      property Telp2 :string read FTelp2 write FTelp2;
      property DisabledDate :TDate read FDisabledDate write FDisabledDate;
  end;


  TMstServicePrice = class(_MstServicePrice)
  protected


  public
    FServiceArr : _MstServicePrice_Arr;
//    function InsertOnDB: boolean;
  //  function UpdateOnDB: boolean;
    //class function activasi(id: integer): boolean;
    constructor Create;
    destructor Destroy; override;
    procedure reset;override;
    function saveToDb():boolean;
    class function LoadFromDB(): TMysqlResult;
    class function LoadExcel(): TMysqlResult;


    //property ServiceId : integer read FServiceId write FServiceId;
    //property ServiceCode:string read FServiceCode write FServiceCode;
    //property ServiceName : string read FServiceName write FServiceName;
    //property Notes : string read FNotes write FNotes;

  end;

  


implementation

uses UConstTool, UConst, ADOInt, UQueryPackage, MySQLConnector;

{ TMstService }

class function TMstService.activasi(id: integer): boolean;
begin
   try
    BeginSQL;
    ExecSQL(
    'update mst_service set disabled_date = if(disabled_date is null, curdate(), null) '+
    'where service_id = '+FormatSQLNumber(id));
    EndSQL;
    Result:= True;
    Inform(MSG_SUCCESS_UPDATE);
  except raise;
    Inform(MSG_UNSUCCESS_UPDATE);
    UndoSQL;
    Result:= False;
  end;
end;

class function TMstService.deleteOnDb(id: integer): boolean;
begin
  try
    BeginSQL;
    ExecSQL(
    'delete from mst_service where service_id = '+FormatSQLNumber(id));
    EndSQL;
    Result:= True;
  except raise;
    Inform(MSG_UNSUCCESS_DELETE);
    UndoSQL;
    Result:= False;
  end;
end;

class procedure TMstService.GetList(vList: TStringList; vTipe: integer=-1);
begin
 SQLToNameValueList(vList,
   ('select service_id, service_name from mst_service '+
   IfThen(vTipe<>-1, 'where service_type = '+FormatSQLNumber(vTipe),'')+
   ' order by service_name'));
end;

class function TMstService.GetName(vId: integer): string;
begin
  Result:= getStringFromSQL
  ('select service_name from mst_service where service_id = '+FormatSQLNumber(vId));
end;

function TMstService.GetNextCode: string;
var prefix: string;
begin
  prefix:= 'S';//UpperCase(Copy(FServiceName, 1,1))+'.';
  Result:= getNextIDNum('service_code','mst_service','',prefix,'',3);
end;

class function TMstService.getServiceType(id: integer): integer;
begin
  Result := getIntegerFromSQL('select service_type from mst_service where service_id ='+FormatSQLNumber(id));
end;

function TMstService.InsertOnDB: boolean;
begin
    try
    BeginSQL;
//    FServiceCode:= GetNextCode;

    ExecSQL(
    'insert into mst_service (service_code, service_name, notes,service_type,insert_log) '+
    'values ('+
      FormatSQLString(FServiceCode)+','+
      FormatSQLString(FServiceName)+','+
      FormatSQLString(FNotes)+','+
      FormatSQLNumber(FServiceType)+','+
      FormatSQLString(getSecurityLog())+')');

    FServiceId:= getIntegerFromSQL('select service_id from mst_service where service_code ='+FormatSQLString(FServiceCode));
    EndSQL;
    Result:= True;
  except
    UndoSQL;
    Result:= False;
    Alert(MSG_UNSUCCESS_SAVING);
  end;

end;

function TMstService.isExistInDb(id: string): boolean;
begin
  Result:= getIntegerFromSQL(
  'select count(*) from mst_service where service_code = '+FormatSQLString(id)) > 0;
end;

class function TMstService.LoadFromDB: TMysqlResult;
var sqL: string;
begin
  sqL:=
  'select service_id, service_code, service_name, notes,service_type,mst_name '+
  'from mst_service s left join mst_master m on s.service_type = m.mst_id ';

 if GlobalFilter.StatusID = 1 then sqL:= sqL + ' where disabled_date is null '
  else if GlobalFilter.StatusID = 2 then sqL:= sqL + ' where disabled_date is not null ';

  if GlobalFilter.Name <> '' then
    sqL:= sqL + ' and service_name like '+FormatSQLString('%'+GlobalFilter.Name+'%');
  if GlobalFilter.FString1 <> '' then
    sqL:= sqL + ' and service_code like '+FormatSQLString('%'+GlobalFilter.FString1+'%');
//  if GlobalFilter.FString1 <> '' then
  //  sqL:= sqL + ' and alamat like '+FormatSQLString('%'+GlobalFilter.FString1+'%');

  Result:= OpenSQL(sqL + ' order by service_name');
end;

procedure TMstService.Reset;
begin
  FServiceId := 0;
  FServiceCode := '';
  FServiceName := '';
  FServiceType  :=0;
  FNotes := '';
end;

function TMstService.SelectInDB: boolean;
var buffer: TMysqlResult;
begin
  buffer:= OpenSQL(
  'select service_id,service_code,service_name,notes,service_type '+
  'from mst_service '+
    IfThen(FServiceId <> 0,
    'where service_id = '+FormatSQLNumber(FServiceId),
    'where service_code = '+FormatSQLString(FServiceCode))
    );

  result:= buffer.RecordCount > 0;
  Self.Reset;
  if Result then
    with buffer do begin
      FServiceId := BufferToInteger(FieldValue(0));
      FServiceCode     := BufferToString(FieldValue(1));
      FServiceName     := BufferToString(FieldValue(2));
      FNotes   := BufferToString(FieldValue(3));
      FServiceType := BufferToInteger(FieldValue(4));
    end;
  buffer.Destroy;
end;

function TMstService.UpdateOnDB: boolean;
begin
  try
    BeginSQL;
   // FKode:= GetNextCode;

    ExecSQL(
    'update mst_service set '+
    ' service_code= '+FormatSQLString(FServiceCode)+','+
    ' service_name= '+FormatSQLString(FServiceName)+','+
    ' notes= '+FormatSQLString(FNotes)+','+
    ' service_type= '+FormatSQLNumber(FServiceType)+','+
    ' edit_log= '+FormatSQLString(getSecurityLog)+
    ' where service_id= '+FormatSQLNumber(FServiceId));

    EndSQL;
    Result:= True;
  except
    UndoSQL;
    Result:= False;
    Alert(MSG_UNSUCCESS_UPDATE);
  end;

end;

{ TMstCage }

class function TMstCage.activasi(id: integer): boolean;
begin

end;

class function TMstCage.deleteOnDb(id: integer): boolean;
begin

end;

class function TMstCage.GetName(vId: integer): string;
begin
  Result:= getStringFromSQL
  ('select cage from mst_cage where cage_id = '+FormatSQLNumber(vId));
end;

function TMstCage.GetNextCode: string;
var prefix: string;
begin
  prefix:= 'K';//UpperCase(Copy(FServiceName, 1,1))+'.';
  Result:= getNextIDNum('cage_code','mst_cage','',prefix,'',3);

end;

function TMstCage.InsertOnDB: boolean;
begin
         try
    BeginSQL;
//    FServiceCode:= GetNextCode;

    ExecSQL(
    'insert into mst_cage (cage_code, cage, notes,disabled,insert_log) '+
    'values ('+
      FormatSQLString(FCageCode)+','+
      FormatSQLString(FCage)+','+
      FormatSQLString(FNotes)+','+
      FormatSQLNumber(FDisabled)+','+
      FormatSQLString(getSecurityLog())+')');

    FCageId:= getIntegerFromSQL('select cage_id from mst_cage where cage_code ='+FormatSQLString(FCageCode));
    EndSQL;
    Result:= True;
  except
    UndoSQL;
    Result:= False;
    Alert(MSG_UNSUCCESS_SAVING);
  end;

end;

function TMstCage.isExistInDb(id: string): boolean;
begin
  Result:= getIntegerFromSQL(
  'select count(*) from mst_cage where cage_code = '+FormatSQLString(id)) > 0;
end;

class function TMstCage.LoadFromDB: TMysqlResult;
var sqL: string;
begin
  sqL:=
  'select cage_id, cage_code, cage,used,disabled, notes '+
  'from mst_cage ';

//  if GlobalFilter.StatusID = 1 then sqL:= sqL + ' where disabled_date is null '
//  else if GlobalFilter.StatusID = 2 then sqL:= sqL + ' where disabled_date is not null ';

  if GlobalFilter.Name <> '' then
    sqL:= sqL + ' and cage like '+FormatSQLString('%'+GlobalFilter.Name+'%');
//  if GlobalFilter.FString1 <> '' then
  //  sqL:= sqL + ' and alamat like '+FormatSQLString('%'+GlobalFilter.FString1+'%');

  Result:= OpenSQL(sqL + ' order by cage');

end;

procedure TMstCage.Reset;
begin
  FCageId := 0;
  FCageCode := '';
  FCage := '';
  FNotes := '';
  FUsed := 0;
  FDisabled := 0;

end;

function TMstCage.SelectInDB: boolean;
var buffer: TMysqlResult;
begin
  buffer:= OpenSQL(
  'select cage_id,cage_code,cage,used,disabled '+
  'from mst_cage '+
    IfThen(FCageId <> 0,
    'where cage_id = '+FormatSQLNumber(FCageId),
    'where cage_code = '+FormatSQLString(FCageCode))
    );

  result:= buffer.RecordCount > 0;
  Self.Reset;
  if Result then
    with buffer do begin
      FCageId := BufferToInteger(FieldValue(0));
      FCageCode     := BufferToString(FieldValue(1));
      FCage     := BufferToString(FieldValue(2));
      FNotes   := BufferToString(FieldValue(3));
      FUsed := BufferToInteger(FieldValue(4));
      FDisabled := BufferToInteger(FieldValue(5));

    end;
  buffer.Destroy;


end;

function TMstCage.UpdateOnDB: boolean;
begin
  try
    BeginSQL;
   // FKode:= GetNextCode;

    ExecSQL(
    'update mst_cage set '+
    ' cage_code= '+FormatSQLString(FCageCode)+','+
    ' cage= '+FormatSQLString(FCage)+','+
    ' notes= '+FormatSQLString(FNotes)+','+
    ' disabled ='+FormatSQLNumber(FDisabled)+','+
    ' edit_log= '+FormatSQLString(getSecurityLog)+
    ' where cage_id= '+FormatSQLNumber(FCageId));

    EndSQL;
    Result:= True;
  except
    UndoSQL;
    Result:= False;
    Alert(MSG_UNSUCCESS_UPDATE);
  end;

end;

{ TMstAnimal }

class function TMstAnimal.activasi(id: integer): boolean;
begin

end;

class function TMstAnimal.deleteOnDb(id: integer): boolean;
begin
  try
    BeginSQL;
    ExecSQL(
    'delete from mst_animal where animal_id = '+FormatSQLNumber(id));
    EndSQL;
    Result:= True;
  except raise;
    Inform(MSG_UNSUCCESS_DELETE);
    UndoSQL;
    Result:= False;
  end;

end;

class procedure TMstAnimal.getListCombo(AList: TStringList;
  forFilter: boolean=false);
var sql:string;
begin
  sql := 'SELECT animal_id, animal FROM mst_animal ORDER BY animal ';
  SQLToNameValueList(AList,sql);
  if forFilter then
    AList.Insert(0,'-1=Semua');
end;

class function TMstAnimal.GetName(vId: integer): string;
begin
  Result := getStringFromSQL('select animal from mst_animal where animal_id ='+FormatSQLNumber(vId));
end;

function TMstAnimal.GetNextCode: string;
var prefix: string;
begin
  prefix:= 'A';//UpperCase(Copy(FServiceName, 1,1))+'.';
  Result:= getNextIDNum('animal_code','mst_animal','',prefix,'',3);


end;

function TMstAnimal.InsertOnDB: boolean;
begin
    try
    BeginSQL;
//    FServiceCode:= GetNextCode;

    ExecSQL(
    'insert into mst_animal (animal_code, animal, notes) '+
    'values ('+
      FormatSQLString(FAnimalCode)+','+
      FormatSQLString(FAnimal)+','+
      FormatSQLString(FNotes)+')');

    FAnimalId:= getIntegerFromSQL('select animal_id from mst_animal where animal_code ='+FormatSQLString(FAnimalCode));
    EndSQL;
    Result:= True;
  except
    UndoSQL;
    Result:= False;
    Alert(MSG_UNSUCCESS_SAVING);
  end;

end;

function TMstAnimal.isExistInDb(id: string): boolean;
begin
  Result:= getIntegerFromSQL(
  'select count(*) from mst_animal where animal_code = '+FormatSQLString(id)) > 0;

end;

class function TMstAnimal.LoadFromDB: TMysqlResult;
var sqL: string;
begin
  sqL:=
  'select animal_id, Animal_code, animal, notes '+
  'from mst_animal ';

//  if GlobalFilter.StatusID = 1 then sqL:= sqL + ' where disabled_date is null '
//  else if GlobalFilter.StatusID = 2 then sqL:= sqL + ' where disabled_date is not null ';

  if GlobalFilter.Name <> '' then
    sqL:= sqL + ' and animal like '+FormatSQLString('%'+GlobalFilter.Name+'%');
//  if GlobalFilter.FString1 <> '' then
  //  sqL:= sqL + ' and alamat like '+FormatSQLString('%'+GlobalFilter.FString1+'%');

  Result:= OpenSQL(sqL + ' order by animal');


end;

procedure TMstAnimal.Reset;
begin
  FAnimalId := 0;
  FAnimalCode := '';
  FAnimal := '';
  FNotes := '';

end;

function TMstAnimal.SelectInDB: boolean;
var buffer: TMysqlResult;
begin
  buffer:= OpenSQL(
  'select animal_id,animal_code,animal,notes '+
  'from mst_animal '+
    IfThen(FAnimalId <> 0,
    'where animal_id = '+FormatSQLNumber(FAnimalId),
    'where animal_code = '+FormatSQLString(FAnimalCode))
    );

  result:= buffer.RecordCount > 0;
  Self.Reset;
  if Result then
    with buffer do begin
      FAnimalId := BufferToInteger(FieldValue(0));
      FAnimalCode     := BufferToString(FieldValue(1));
      FAnimal     := BufferToString(FieldValue(2));
      FNotes   := BufferToString(FieldValue(3));

    end;
  buffer.Destroy;


end;

function TMstAnimal.UpdateOnDB: boolean;
begin
  try
    BeginSQL;
   // FKode:= GetNextCode;

    ExecSQL(
    'update mst_animal set '+
    ' animal_code= '+FormatSQLString(FAnimalCode)+','+
    ' animal= '+FormatSQLString(FAnimal)+','+
    ' notes= '+FormatSQLString(FNotes)+
    ' where animal_id= '+FormatSQLNumber(FAnimalId));

    EndSQL;
    Result:= True;
  except
    UndoSQL;
    Result:= False;
    Alert(MSG_UNSUCCESS_UPDATE);
  end;

end;

{ TMstServicePrice }


constructor TMstServicePrice.Create;
begin
  FServiceArr := _MstServicePrice_Arr.Create();
end;

destructor TMstServicePrice.Destroy;
begin
  FServiceArr.Destroy;
  inherited;
end;

class function TMstServicePrice.LoadExcel: TMysqlResult;
var sqL: string;
begin
  sqL:=
  'select s.service_name,a.animal_code,a.animal,p.price,p.discount  '+
  'from mst_service s left join mst_service_price p on s.service_id = p.service_id left join mst_animal a on a.animal_id = p.animal_id ';
  if GlobalFilter.Name <> '' then
    sqL:= sqL + ' and animal like '+FormatSQLString('%'+GlobalFilter.Name+'%');
//  if GlobalFilter.FString1 <> '' then
  //  sqL:= sqL + ' and alamat like '+FormatSQLString('%'+GlobalFilter.FString1+'%');

  Result:= OpenSQL(sqL + ' order by s.service_name');


end;

class function TMstServicePrice.LoadFromDB: TMysqlResult;
var sqL: string;
begin
  sqL:=
  'select a.animal_code,a.animal,p.service_price_id, p.service_id, a.animal_id,p.price,p.add_price,p.discount '+
  'from mst_animal a left join mst_service_price p  on a.animal_id = p.animal_id and p.service_id = '+FormatSQLNumber(GlobalFilter.Numeric1);
//  ' left join mst_service s on s.service_id = p.service_id and ';

//  if GlobalFilter.StatusID = 1 then sqL:= sqL + ' where disabled_date is null '
//  else if GlobalFilter.StatusID = 2 then sqL:= sqL + ' where disabled_date is not null ';

  if GlobalFilter.Name <> '' then
    sqL:= sqL + ' and animal like '+FormatSQLString('%'+GlobalFilter.Name+'%');
//  if GlobalFilter.FString1 <> '' then
  //  sqL:= sqL + ' and alamat like '+FormatSQLString('%'+GlobalFilter.FString1+'%');

  Result:= OpenSQL(sqL + ' order by animal');


end;

procedure TMstServicePrice.reset;
begin
  inherited;
  FServiceArr.Clear;
end;

function TMstServicePrice.saveToDb: boolean;
var i:integer;
   sql:string;
begin
  try
    BeginSQL;
    for i:= 0 to FServiceArr.Count-1 do begin
      if (FServiceArr[i].ServicePriceID=0) then
         sql := 'INSERT INTO mst_service_price(service_id,animal_id,price,add_price,discount,insert_log) '+
                ' VALUES('+FormatSQLNumber(FServiceArr[i].ServiceID)+','+
                FormatSQLNumber(FServiceArr[i].AnimalId)+','+
                FormatSQLNumber(FServiceArr[i].Price)+','+
                FormatSQLNumber(FServiceArr[i].AddPrice)+','+
                FormatSQLNumber(FServiceArr[i].Discount)+','+
                FormatSQLString(getSecurityLog)
                +')'
      else
        sql := 'UPDATE mst_service_price SET service_id = '+FormatSQLNumber(FServiceArr[i].ServiceID)+
                ',animal_id ='+FormatSQLNumber(FServiceArr[i].AnimalId)+
                ',price ='+FormatSQLNumber(FServiceArr[i].Price)+
                ',add_price ='+FormatSQLNumber(FServiceArr[i].AddPrice)+
                ',discount ='+FormatSQLNumber(FServiceArr[i].Discount)+
                ',edit_log ='+FormatSQLString(getSecurityLog)+
                ' WHERE service_price_id ='+FormatSQLNumber(FServiceArr[i].ServicePriceID);
      ExecSQL(sql);
    end;
    EndSQL;
    Result := True;

  except
    Result := False;
    UndoSQL;
  end;
end;

{ TMstServiceBonus }

class function TMstServiceBonus.getBatasJml(
  aServiceType: integer): integer;
var sql :string;
begin
  sql := 'select ifnull(jml_service,0) from mst_service_bonus where service_type = '+FormatSQLNumber(aServiceType);
  Result := getIntegerFromSQL(sql);

end;

class function TMstServiceBonus.getBonusJml(
  aServiceType: integer): integer;
var sql :string;
begin
  sql := 'select ifnull(bonus_jml,0) from mst_service_bonus where service_type = '+FormatSQLNumber(aServiceType);
  Result := getIntegerFromSQL(sql);
end;

class function TMstServiceBonus.isAdaBonus(aServiceType: integer): boolean;
var sql :string;
begin
  sql := 'select ifnull(bonus_jml,0) from mst_service_bonus where service_type = '+FormatSQLNumber(aServiceType);
  Result := getIntegerFromSQL(sql)>0;
end;

class function TMstServiceBonus.isKumulatif(
  aServiceType: integer): boolean;
var sql :string;
begin
  sql := 'select ifnull(is_kumulatif,0) from mst_service_bonus where service_type = '+FormatSQLNumber(aServiceType);
  Result := getIntegerFromSQL(sql)=1;


end;

function TMstServiceBonus.load:TMysqlResult;
var sqL: string;
begin
  sqL:=
  'select mst_name,jml_service,bonus_service,bonus_jml,service_type,is_kumulatif '+
  ' from mst_master m inner join mst_service_bonus s on s.service_type = m.mst_id ';

   Result:= OpenSQL(sqL + ' order by mst_name');


end;

procedure TMstServiceBonus.reset;
begin
  FServiceType := 0;
  FJmlService := 0;
  FBonusService := 0;
  FBonusJml := 0;
  FIsKumulatif := 0;
end;

function TMstServiceBonus.SelectInDb(aServiceType:integer): boolean;
var sql :string;
  buffer : TMysqlResult;
begin
  sql :=   'select mst_name,jml_service,bonus_service,bonus_jml,service_type,is_kumulatif '+
  ' from mst_master m inner join mst_service_bonus s on s.service_type = m.mst_id '+
    ' where service_type = '+FormatSQLNumber(aServiceType);
  buffer := OpenSQL(sql);  
  result:= buffer.RecordCount > 0;
  Self.Reset;
  if Result then
    with buffer do begin
      FJmlService := BufferToInteger(FieldValue(1));
      FBonusService     := BufferToInteger(FieldValue(2));
      FBonusJml     := BufferToInteger(FieldValue(3));
      FServiceType   := BufferToInteger(FieldValue(4));
      FIsKumulatif := BufferToInteger(FieldValue(5));
    end;
  buffer.Destroy;
    
end;

procedure TMstServiceBonus.UpdateOnDb;
var sql:string;
begin
  sql := 'update mst_service_bonus set jml_service= '+FormatSQLNumber(FJmlService)+
    ',is_kumulatif='+FormatSQLNumber(FIsKumulatif)+
    ',bonus_service='+FormatSQLNumber(FBonusService)+
    ',bonus_jml='+FormatSQLNumber(FBonusJml)+
    ' where service_type='+FormatSQLNumber(FServiceType);
  ExecSQL(sql);
end;

{ TMstKaryawan }

class function TMstKaryawan.activasi(id: integer): boolean;
begin

end;

class function TMstKaryawan.deleteOnDb(id: integer): boolean;
begin
      try
    BeginSQL;
    ExecSQL(
    'delete from mst_karyawan where karyawan_id = '+FormatSQLNumber(id));
    EndSQL;
    Result:= True;
  except raise;
    Inform(MSG_UNSUCCESS_DELETE);
    UndoSQL;
    Result:= False;
  end;

end;

class procedure TMstKaryawan.getListCombo(AList: TStringList;
  forFilter: boolean);
  var sql:string;
begin
  sql := 'SELECT karyawan_id, nama FROM mst_karyawan ORDER BY nama ';
  SQLToNameValueList(AList,sql);
  if forFilter then
    AList.Insert(0,'-1=Semua');

end;

class function TMstKaryawan.GetName(vId: integer): string;
begin

end;

function TMstKaryawan.GetNextCode(vJabatan: integer): string;
var prefix: string;
begin
   prefix := getStringFromSQL('select mst_code from mst_master where mst_id = '+FormatSQLNumber(vJabatan));
  Result:= getNextIDNum('nik','mst_karyawan',' and jabatan ='+FormatSQLNumber(vJabatan),prefix,'',3);

end;

function TMstKaryawan.InsertOnDB: boolean;
begin
      try
    BeginSQL;
//    FServiceCode:= GetNextCode;

    ExecSQL(
    'insert into mst_karyawan (nik,nama,alamat,jabatan,tgl_lahir,tlp1,tlp2) '+
    'values ('+
      FormatSQLString(FNik)+','+
      FormatSQLString(FNama)+','+
      FormatSQLString(FAlamat)+','+
      FormatSQLNumber(FJabatan)+','+
      FormatSQLDate(FTglLahir)+','+
      FormatSQLString(FTelp1)+','+
      FormatSQLString(FTelp2)+')');

    FKaryawanId:= getIntegerFromSQL('select max(karyawan_id) from mst_karyawan');
    EndSQL;
    Result:= True;
  except
    UndoSQL;
    Result:= False;
    Alert(MSG_UNSUCCESS_SAVING);
  end;

end;

function TMstKaryawan.isExistInDb(id: string): boolean;
begin
    Result:= getIntegerFromSQL(
  'select count(*) from mst_karyawan where nik = '+FormatSQLString(id)) > 0;

end;

class function TMstKaryawan.LoadFromDB: TMysqlResult;
var sqL: string;
begin
  sqL:=
  'select karyawan_id,nik, nama,k.alamat,jabatan,tgl_lahir,tlp1,tlp2,disabled_date,mst_name '+
  'from mst_karyawan k left join mst_master m on k.jabatan = m.mst_id';

//  if GlobalFilter.StatusID = 1 then sqL:= sqL + ' where disabled_date is null '
//  else if GlobalFilter.StatusID = 2 then sqL:= sqL + ' where disabled_date is not null ';

  if GlobalFilter.Name <> '' then
    sqL:= sqL + ' and nama like '+FormatSQLString('%'+GlobalFilter.Name+'%');
//  if GlobalFilter.FString1 <> '' then
  //  sqL:= sqL + ' and alamat like '+FormatSQLString('%'+GlobalFilter.FString1+'%');

  Result:= OpenSQL(sqL + ' order by nama');


end;

procedure TMstKaryawan.Reset;
begin
    FKaryawanId := 0;
    FNama := '';
    FAlamat := '';
    FJabatan :=-1;
    FTglLahir := Now;
    FTelp1 := '';
    FTelp2 := '';
    FNik := '';
    FDisabledDate := 0;
end;

function TMstKaryawan.SelectInDB: boolean;
var buffer: TMysqlResult;
begin
  buffer:= OpenSQL(
  'select karyawan_id,nama,alamat,jabatan,tgl_lahir,tlp1,tlp2,disabled_date,nik '+
  'from mst_karyawan '+
    'where karyawan_id = '+FormatSQLNumber(FKaryawanId));

  result:= buffer.RecordCount > 0;
  Self.Reset;
  if Result then
    with buffer do begin
      FKaryawanId := BufferToInteger(FieldValue(0));
      FNama     := BufferToString(FieldValue(1));
      FAlamat     := BufferToString(FieldValue(2));
      FJabatan := BufferToInteger(FieldValue(3));
      FTglLahir   := BufferToDateTime(FieldValue(4));
      FTelp1     := BufferToString(FieldValue(5));
      FTelp2     := BufferToString(FieldValue(6));
      FTglLahir   := BufferToDateTime(FieldValue(7));
      FNik := BufferToString(FieldValue(8));

    end;
  buffer.Destroy;


end;

function TMstKaryawan.UpdateOnDB: boolean;
begin
  try
    BeginSQL;
   // FKode:= GetNextCode;

    ExecSQL(
    'update mst_karyawan set '+
    ' nik= '+FormatSQLString(FNik)+','+
    ' nama= '+FormatSQLString(FNama)+','+
    ' alamat= '+FormatSQLString(FAlamat)+','+
    ' jabatan= '+FormatSQLNumber(FJabatan)+','+
    ' tgl_lahir= '+FormatSQLDate(FTglLahir)+','+
    ' tlp1= '+FormatSQLString(FTelp1)+','+
    ' tlp2= '+FormatSQLString(FTelp2)+
    ' where karyawan_id= '+FormatSQLNumber(FKaryawanId));

    EndSQL;
    Result:= True;
  except
    UndoSQL;
    Result:= False;
    Alert(MSG_UNSUCCESS_UPDATE);
  end;

end;

end.
