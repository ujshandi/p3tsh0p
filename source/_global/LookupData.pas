unit LookupData;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, BaseGrid, AdvGrid, Math, StdCtrls, AdvEdit, strutils;

type
  TfrmLookup = class(TForm)
    AdvEdit1: TAdvEdit;
    procedure DBAdvStringGrid1DblClick(Sender: TObject);
    procedure DBAdvStringGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure AdvEdit1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    FSpecID, FVendorID, FProdusenID: integer;
    NamaTable: string;
    grid: TAdvStringGrid;
    procedure requeryData();
    procedure initGrid();
  public
    function Execute(aTableName: string): integer;
    function ExecuteUser(aTableName: string): string;
    function ExecuteSatX(vSpecID: integer): integer;
    function ExecuteItem(vSpecID, vVendorID, vProdusenID: integer): integer;
  end;

var
  frmLookup: TfrmLookup;

implementation

uses UConst, MySQLConnector, uMysqlClient, UConstTool, MainMenu;

{$R *.dfm}

{ TfrmLookup }

function TfrmLookup.Execute(aTableName: string): integer;
begin
  AdvEdit1.Clear;
  Result := 0;
  initGrid;

  NamaTable:= aTableName;
  if (aTableName <> 'PASIEN') AND (aTableName <> 'DOKTER') then
    requeryData();
  Self.ShowModal;
  if ModalResult = mrOk then
    Result:= grid.Ints[1, grid.Row];
  grid.Free;
end;

procedure TfrmLookup.requeryData();
var i,j: integer; header: TMysql_FieldDef;
  filter: string;
begin

  try
    Screen.Cursor:= crSQLWait;
    if NamaTable = 'SAT' then
      MySQLResult:= OpenSQL(
      'select mst_id, mst_code as ''Kode'', mst_name as ''Nama'' '+
      'from mst_master where mst_tipe = '+FormatSQLNumber(MST_TYPE_UNIT)+
      IfThen(AdvEdit1.Text <> '', ' and mst_name like '+FormatSQLString('%'+AdvEdit1.Text+'%'))+
      ' order by mst_name ')

    else if NamaTable = 'SATX' then
      MySQLResult:= OpenSQL(
      'select u.mst_id, u.mst_code as ''Kode'', u.mst_name as ''Nama'' '+
      'from mst_item_conversion c, mst_master u '+
      'where c.unit_id = u.mst_id and c.item_id = '+FormatSQLNumber(FSpecID)+
      IfThen(AdvEdit1.Text <> '', ' and u.mst_name like '+FormatSQLString('%'+AdvEdit1.Text+'%'))+
      ' order by mst_name')

    else if NamaTable = 'SPL' then
      MySQLResult:= OpenSQL(
      'select relation_id, relation_code as ''Kode'', relation_name as ''Nama'' '+
      'from mst_relation where relation_type = '+FormatSQLNumber(RELASI_TYPE_SUPPLIER)+
      IfThen(AdvEdit1.Text <> '', ' and relation_name like '+FormatSQLString('%'+AdvEdit1.Text+'%'))+
      ' order by relation_name ')

   else if NamaTable = 'ITEM' then begin
      if FSpecID <> 0 then filter:= filter + ' and p.root_id ='+FormatSQLNumber(FSpecID);
   //   if FVendorID <> 0 then filter:= filter + ' and i.vendor_id ='+FormatSQLNumber(FVendorID);
  //    if FProdusenID <> 0 then filter:= filter + ' and i.produsen_id ='+FormatSQLNumber(FProdusenID);

      MySQLResult:= OpenSQL(
      'select distinct i.item_id, barcode as ''Barcode'', item_name as ''Nama'', merk as Merk '+
      'from mst_item i, point_maping p where i.specification = p.code_id '+filter+
      IfThen(AdvEdit1.Text <> '', ' and (item_name like '+FormatSQLString('%'+AdvEdit1.Text+'%')+
      ') or (merk like '+FormatSQLString('%'+AdvEdit1.Text+'%')+' )')+
      ' order by item_name ')
   end

   else if NamaTable = 'JASA_MEDIK' then begin
      filter:= filter + ' and p.root_id = 36 ';

      MySQLResult:= OpenSQL(
      'select distinct i.item_id, barcode as ''Kode'', item_name as ''Nama'' '+
      'from mst_item i, point_maping p where i.specification = p.code_id '+filter+
      IfThen(AdvEdit1.Text <> '', ' and item_name like '+FormatSQLString('%'+AdvEdit1.Text+'%'))+
      ' order by item_name ')
   end


   else if NamaTable = 'CUST' then
      MySQLResult:= OpenSQL(
      'select relation_id, relation_code as ''Kode'', relation_name as ''Nama'',address1 as ''Alamat'' '+
      'from mst_relation where relation_type ='+FormatSQLNumber(RELASI_TYPE_CUSTOMER)+
      IfThen(AdvEdit1.Text <> '', ' and relation_name like '+FormatSQLString('%'+AdvEdit1.Text+'%'))+
      ' order by relation_name ')

   else if NamaTable = 'CUST_MEMB' then
      MySQLResult:= OpenSQL(
      'select relation_id, relation_code as ''Kode'', relation_name as ''Nama'' '+
      'from mst_relation where relation_type in('+FormatSQLNumber(RELASI_TYPE_CUSTOMER)+','+FormatSQLNumber(RELASI_TYPE_MEMBER)+')'+
      IfThen(AdvEdit1.Text <> '', ' and relation_name like '+FormatSQLString('%'+AdvEdit1.Text+'%'))+
      ' order by relation_name ')

    else if NamaTable = 'PRODUSEN' then
      MySQLResult:= OpenSQL(
      'select mst_id, mst_code as ''Kode'', mst_name as ''Nama'' '+
      'from mst_master where mst_tipe = '+FormatSQLNumber(MST_TYPE_PRODUSEN)+
      IfThen(AdvEdit1.Text <> '', ' and mst_name like '+FormatSQLString('%'+AdvEdit1.Text+'%'))+
      ' order by mst_name ')

   else if NamaTable = 'KARYAWAN' then
      MySQLResult:= OpenSQL(
      'select karyawan_id, nik as ''NIK'', nama as ''Nama'' '+
      'from mst_karyawan '+
      IfThen(AdvEdit1.Text <> '', ' where nama like '+FormatSQLString('%'+AdvEdit1.Text+'%'))+
      ' order by nama ')

    else if NamaTable = 'JNS_OBAT' then
      MySQLResult:= OpenSQL(
      'select id, Kode, Nama '+
      'from mst_kategori '+
      IfThen(AdvEdit1.Text <> '', ' where nama like '+FormatSQLString('%'+AdvEdit1.Text+'%'))+
      ' order by nama')

    else if NamaTable = 'KEMAS' then
      MySQLResult:= OpenSQL(
      'select mst_id, mst_code as ''Kode'', mst_name as ''Nama'' '+
      'from mst_master where mst_tipe = '+FormatSQLNumber(MST_TYPE_KEMASAN)+
      IfThen(AdvEdit1.Text <> '', ' and mst_name like '+FormatSQLString('%'+AdvEdit1.Text+'%'))+
      ' order by mst_name ')

    else if NamaTable = 'AKUN_DB' then
      MySQLResult:= OpenSQL(
      'select akun_id, Kode, Nama '+
      'from mst_akun where tipe = 1 order by nama')

   else if NamaTable = 'AKUN_CR' then
      MySQLResult:= OpenSQL(
      'select akun_id, Kode, Nama '+
      'from mst_akun where tipe = 2 order by nama')

   else if NamaTable = 'KASIR' then
      MySQLResult:= OpenSQL(
      'select mst_id, mst_code as ''Kode'', mst_name as ''Nama'' '+
      'from mst_master where mst_tipe = '+FormatSQLNumber(MST_TYPE_CASHIER)+
      IfThen(AdvEdit1.Text <> '', ' and mst_name like '+FormatSQLString('%'+AdvEdit1.Text+'%'))+
      ' order by mst_name ')

     else if NamaTable = 'USER' then
      MySQLResult:= OpenSQL(
      'select user_id, user_id as ''User ID'', user_name as ''Nama'' '+
      'from system_users '+//where mst_tipe = '+FormatSQLNumber(MST_TYPE_CASHIER)+
      IfThen(AdvEdit1.Text <> '', ' where user_name like '+FormatSQLString('%'+AdvEdit1.Text+'%'))+
      ' order by user_name ')

   else if NamaTable = 'SHIFT' then
      MySQLResult:= OpenSQL(
      'select mst_id, mst_code as ''Kode'', mst_name as ''Nama'' '+
      'from mst_master where mst_tipe = '+FormatSQLNumber(MST_TYPE_SHIFT)+
      IfThen(AdvEdit1.Text <> '', ' and mst_name like '+FormatSQLString('%'+AdvEdit1.Text+'%'))+
      ' order by mst_name ')

   else if NamaTable = 'PASIEN' then
      MySQLResult:= OpenSQL(
      'select pasien_id, Kode, Nama, Alamat '+
      'from mst_pasien '+
      IfThen(AdvEdit1.Text <> '', ' where nama like '+FormatSQLString('%'+AdvEdit1.Text+'%'))+
      ' order by nama')

   else if NamaTable = 'DOKTER' then
      MySQLResult:= OpenSQL(
      'select dokter_id, Kode, Nama, Alamat '+
      'from mst_dokter '+
      IfThen(AdvEdit1.Text <> '', ' where nama like '+FormatSQLString('%'+AdvEdit1.Text+'%'))+
      ' order by nama')

   else if NamaTable = 'RACIK' then

      MySQLResult:= OpenSQL(
      'select paket_id, Kode, Nama '+
      'from mst_paket '+
      IfThen(AdvEdit1.Text <> '', ' where nama like '+FormatSQLString('%'+AdvEdit1.Text+'%'))+
      ' order by nama ')

    else if NamaTable = 'BRANCH' then

      MySQLResult:= OpenSQL(
      'select branch_id, branch_code, branch_name '+
      'from mst_branch '+
      IfThen(AdvEdit1.Text <> '', ' where branch_name like '+FormatSQLString('%'+AdvEdit1.Text+'%'))+
      ' order by branch_name ')

   else if NamaTable = 'RAK' then
      MySQLResult:= OpenSQL('select rak_id, Kode, Nama from mst_rak order by Nama');

    grid.Clear;
    grid.RowCount:= IfThen(MySQLResult.RecordCount > 0, MySQLResult.RecordCount + 1, 2);
    grid.ColCount:= MySQLResult.FieldsCount+2;
    grid.FixedRows:= 1;
    for i:= 0 to MySQLResult.FieldsCount-1 do begin
      header:= MySQLResult.FieldDef(i)^;
      grid.Cells[i+1, 0]:= header.Name;
    end;

    MySQLResult.First;
    for i:= 1 to MySQLResult.RecordCount do begin
      for j:= 0 to MySQLResult.FieldsCount-1 do
        grid.Cells[j+1,i]:= MySQLResult.FieldValue(j);
      MySQLResult.MoveNext;
    end;
    MySQLResult.destroy;

    grid.AutoSizeColumns(TRUE, 4);
    grid.ColWidths[0]:= 18;
    grid.ColWidths[1]:= 0;

  finally
    Screen.Cursor:= crDefault;
  end;
end;

procedure TfrmLookup.DBAdvStringGrid1DblClick(Sender: TObject);
begin
  ModalResult:= mrOk
end;

procedure TfrmLookup.DBAdvStringGrid1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    vk_return: ModalResult := mrOk;
    vk_Escape: ModalResult := mrCancel;
  end;
end;

function TfrmLookup.ExecuteItem(vSpecID, vVendorID,
  vProdusenID: integer): integer;
begin
  AdvEdit1.Clear;
  initGrid;
  Result := 0;
  FSpecID:= vSpecID;
  FVendorID:= vVendorID;
  FProdusenID:= vProdusenID;
  NamaTable:= 'ITEM';
  requeryData();
  Self.ShowModal;
  if ModalResult = mrOk then
    Result:= grid.Ints[1, grid.Row];
  grid.Free;
end;

function TfrmLookup.ExecuteSatX(vSpecID: integer): integer;
begin
  AdvEdit1.Clear;
  initGrid;

  Result := 0;
  FSpecID:= vSpecID;
  NamaTable:= 'SATX';
  requeryData();
  Self.ShowModal;
  if ModalResult = mrOk then
    Result:= grid.Ints[1, grid.Row];
  grid.Free;  
end;

procedure TfrmLookup.FormShow(Sender: TObject);
begin
  AdvEdit1.SetFocus;
end;

procedure TfrmLookup.AdvEdit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    vk_return: requeryData();
    vk_Escape: ModalResult := mrCancel;
  end;
end;

procedure TfrmLookup.initGrid;
begin
  grid:= TAdvStringGrid.Create(Self);
  grid.Parent:= Self;
  grid.BeginUpdate;

  grid.Top := 32;
  grid.Left := 0;
  grid.Width := 523;
  grid.Height := 340;
  grid.Align   := alBottom;
  grid.ColCount:= 5;
  grid.RowCount := 2;
  grid.FixedCols:= 1;
  grid.FixedRows:= 1;
  grid.BorderStyle:= bsNone;
  grid.Options := [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goRowSelect];
  grid.TabOrder := 1;
  grid.OnDblClick := DBAdvStringGrid1DblClick;
  grid.OnKeyDown := DBAdvStringGrid1KeyDown;
  grid.Flat := True;
  grid.ColumnSize.Stretch := True;

  grid.FixedColor          := clFixedColum;
  grid.FixedFont.Color     := clFixedFont;
  grid.Font.Style          := [];
  grid.SelectionColor      := clSelection;
  grid.Color               := clGrid;
  grid.Bands.PrimaryColor  := clPrimaryBand;
  grid.Bands.SecondaryColor:= clSecondaryBand;
  grid.Font.Color          := clLabel;//clFixedFont;
  grid.SelectionTextColor  := clFixedColum;//clFixedFont;

  grid.Cells[2, 0]:= 'KODE';
  grid.Cells[3, 0]:= 'NAMA';
  grid.AutoSizeColumns(True,2);
  grid.ColWidths[0]:= 18;
  grid.ColWidths[1]:= 0;
  grid.EndUpdate;
end;

function TfrmLookup.ExecuteUser(aTableName: string): string;
begin
  AdvEdit1.Clear;
  Result := '';
  initGrid;

  NamaTable:= aTableName;
  if (aTableName <> 'PASIEN') AND (aTableName <> 'DOKTER') then
    requeryData();
  Self.ShowModal;
  if ModalResult = mrOk then
    Result:= grid.Cells[1, grid.Row];
  grid.Free;
end;

end.
