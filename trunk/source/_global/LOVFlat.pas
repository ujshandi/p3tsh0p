unit LOVFlat;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,strUtils,
  Dialogs, Grids, BaseGrid, AdvGrid, StdCtrls, AdvEdit,Math,
  ExtCtrls, WinXP;

type
  TfrmLovFlat = class(TForm)
    WinXP1: TWinXP;
    grid: TAdvStringGrid;
    procedure DBAdvStringGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBAdvStringGrid1GetAlignment(Sender: TObject; ARow,
      ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure DBAdvStringGrid1DblClick(Sender: TObject);
    procedure gridRowChanging(Sender: TObject; OldRow, NewRow: Integer;
      var Allow: Boolean);
  private
    fieldSearched, TableName: string;
    query_paket, AFilterID: integer;
    AFilterAnimals:string;
    procedure RequeryPart;
    procedure LoadResult;
  public
    function Execute(var isPaket: integer; ASearch, ATableName: string; AFilter: integer=0): integer;
    function Execute2(var isPaket,animalId: integer; ASearch, ATableName: string; AFilter: integer=0): integer;overload;
    function Execute2(var isPaket,animalId: integer; ASearch, ATableName: string; AnimalsCust: String): integer;overload;
  end;

var
  frmLovFlat: TfrmLovFlat;

implementation

uses Subroutines, UConstTool, MySQLConnector, uMysqlClient, UMaster;



{$R *.dfm}

{ TfrmLovFlat }

function TfrmLovFlat.Execute(var isPaket: integer; ASearch, ATableName: string; AFilter: integer): integer;
begin
  fieldSearched:= ASearch;
  AFilterID:= AFilter;
  query_paket:= isPaket;
  Result := 0;
  Self.Caption := 'Daftar '+ copy(aTableName, 1,1) + LowerCase( copy(aTableName, 2, length(aTableName)));
  TableName    := aTableName;

  RequeryPart;
  Self.ShowModal;
  if ModalResult = mrOk then begin
    Result:= grid.Ints[1, grid.Row];
    isPaket:= grid.Ints[grid.ColCount-1, grid.Row];
  end;
end;

procedure TfrmLovFlat.RequeryPart;
var SQL: string;
begin
//  if fieldSearched = '' then exit;
  if TableName = 'BARANG' then
    SQL:=
    'select '+
      'i.item_id, i.item_code as ''Kode'', i.barcode as ''Barcode'', '+
      'i.item_name as ''Nama Barang/Jasa'', current_stock as ''Stok'', '+
      '(select mst_code from mst_master where mst_id = i.kemasan_id) as Unit, '+
      'i.selling_price as ''Hrg Jual/Jasa'',merk as Merk,0 as paket,-1 as animal_id '+
    'from mst_item i '+
    'where i.disabled_date is null '+
    ' and (lower(item_name) like '+FormatSQLString('%'+fieldSearched+'%')+') or (lower(merk) like '+FormatSQLString('%'+fieldSearched+'%')+')'+
    ' union all '+       
    ' select '+
          'i.service_id, i.service_code as ''Kode'', '''' as ''Barcode'', '+
      ' concat(i.service_name,'' '',animal) as ''Nama Barang/Jasa'', 0 as ''Stok'', '+
      ''''' as Unit, '+
      ' price as ''Hrg Jual/Jasa'','''' as Merk,1 as paket,s.animal_id '+
    'from mst_service i inner join mst_service_price s on s.service_id = i.service_id and s.animal_id in ('+AFilterAnimals+')'+
    ' left join mst_animal a on a.animal_id = s.animal_id '+
    ' where  i.disabled_date is null and service_name like '+FormatSQLString('%'+fieldSearched+'%')   ;



  try
    Screen.Cursor := crSQLWait;
    MySQLResult:= OpenSQL(SQL);
    LoadResult;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TfrmLovFlat.DBAdvStringGrid1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    vk_return: ModalResult := mrOk;
    vk_Escape: ModalResult := mrCancel;
    vk_F2    :
    begin
      fieldSearched:= InputBox('Cari', 'Pencarian:','');
      RequeryPart; 
    end;
  end;
end;

procedure TfrmLovFlat.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = vk_Escape then
    ModalResult := mrCancel;
end;

procedure TfrmLovFlat.DBAdvStringGrid1GetAlignment(Sender: TObject; ARow,
  ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
//1item_id, 2item_code, 3barcode, 4item_name, 5current_stock, 6Undit, 7sales_price
  if TableName = 'BARANG' then
    if ACol in[5,7] then HAlign:= taRightJustify;
end;

procedure TfrmLovFlat.DBAdvStringGrid1DblClick(Sender: TObject);
begin
  ModalResult:= mrOk
end;

procedure TfrmLovFlat.LoadResult;
var i,j: integer; header: TMysql_FieldDef;
begin
  grid.Clear;

  grid.RowCount:= IfThen(MySQLResult.RecordCount > 0, MySQLResult.RecordCount + 1, 2);
  grid.ColCount:= MySQLResult.FieldsCount+1;
  grid.FixedRows:= 1;
  //grid.AutoSizeColumns(TRUE, 4);
  grid.ColWidths[0]:= 0;
  grid.ColWidths[1]:= 0;
  grid.ColWidths[2]:= 50;
  grid.ColWidths[3]:= 50;
  grid.ColWidths[4]:= 350;
  grid.ColWidths[5]:= 0;//stok dihide
//  grid.ColWidths[5]:= 60;
  grid.ColWidths[6]:= 40;
  grid.ColWidths[grid.ColCount-1]:= 0; //is paket
  grid.ColWidths[grid.ColCount-2]:= 0; //is paket
  grid.RowHeights[1]:= grid.DefaultRowHeight;

  for i:= 0 to MySQLResult.FieldsCount-1 do begin
    header:= MySQLResult.FieldDef(i)^;
    grid.Cells[i+1, 0]:= header.Name;
  end;

   //'0item_id, 1item_code, 2barcode, 3item_name, 4current_stock, '+
   // '5Unit, 6sales_price ,7bTambahan,8 isService

  for i:= 1 to MySQLResult.RecordCount do begin
    for j:= 0 to MySQLResult.FieldsCount-1 do
   // if (TableName = 'BARANG') and ((j = 4) or (j=6)) then
    if (TableName = 'BARANG') and (j in [4,6]) then
       grid.Cells[j+1,i]:= FloatToStrFmt(BufferToFloat(MySQLResult.FieldValue(j)))
//    else if (TableName = 'BARANG') and (j = 8) then
  //    grid.Cells[j+1,i]:= TMstItem.GetRakDesc(BufferToInteger(MySQLResult.FieldValue(0)))
    else grid.Cells[j+1,i]:= MySQLResult.FieldValue(j);
    MySQLResult.MoveNext;
  end;
  MySQLResult.destroy;
end;

procedure TfrmLovFlat.gridRowChanging(Sender: TObject; OldRow,
  NewRow: Integer; var Allow: Boolean);
begin
  if OldRow <= grid.RowCount-1 then
    grid.RowHeights[OldRow]:= grid.DefaultRowHeight;
  grid.AutoSizeRow(NewRow);
  if grid.RowHeights[NewRow] < grid.DefaultRowHeight then
    grid.RowHeights[NewRow]:= grid.DefaultRowHeight;
end;

function TfrmLovFlat.Execute2(var isPaket, animalId: integer; ASearch,
  ATableName: string; AFilter: integer): integer;
begin
  fieldSearched:= ASearch;
  AFilterID:= AFilter;
  query_paket:= isPaket;
  Result := 0;
  Self.Caption := 'Daftar '+ copy(aTableName, 1,1) + LowerCase( copy(aTableName, 2, length(aTableName)));
  TableName    := aTableName;

  RequeryPart;
  Self.ShowModal;
  if ModalResult = mrOk then begin
    Result:= grid.Ints[1, grid.Row];
    isPaket:= grid.Ints[grid.ColCount-2, grid.Row];
    animalId:= grid.Ints[grid.ColCount-1, grid.Row];
  end;
end;

function TfrmLovFlat.Execute2(var isPaket, animalId: integer; ASearch,
  ATableName, AnimalsCust: String): integer;
begin
  fieldSearched:= ASearch;
  AFilterAnimals:= AnimalsCust;
  query_paket:= isPaket;
  Result := 0;
  Self.Caption := 'Daftar '+ copy(aTableName, 1,1) + LowerCase( copy(aTableName, 2, length(aTableName)));
  TableName    := aTableName;

  RequeryPart;
  Self.ShowModal;
  if ModalResult = mrOk then begin
    Result:= grid.Ints[1, grid.Row];
    isPaket:= grid.Ints[grid.ColCount-2, grid.Row];
    animalId:= grid.Ints[grid.ColCount-1, grid.Row];
  end;

end;

end.
