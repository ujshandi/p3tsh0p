unit MstPaket;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, BaseGrid, AdvGrid, AdvEdit,
  strUtils, Math, UMaster, ComCtrls, ToolWin;

type
  TfrmMstPaket = class(TForm)
    txtCode: TAdvEdit;
    txtBarcode: TAdvEdit;
    txtName: TAdvEdit;
    txtStruk: TAdvEdit;
    txtJual: TAdvEdit;
    txtDasar: TAdvEdit;
    grid: TAdvStringGrid;
    txtUnit: TAdvEdit;
    btnKemas: TButton;
    ToolBar1: TToolBar;
    tbtNew: TToolButton;
    tbtSave: TToolButton;
    ToolButton2: TToolButton;
    ToolButton1: TToolButton;
    cmbGudang: TComboBox;
    Label1: TLabel;
    procedure gridCellValidate(Sender: TObject; Col, Row: Integer;
      var Value: String; var Valid: Boolean);
    procedure gridKeyPress(Sender: TObject; var Key: Char);
    procedure gridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure gridEnter(Sender: TObject);
    procedure txtCodeEnter(Sender: TObject);
    procedure gridCanEditCell(Sender: TObject; ARow, ACol: Integer;
      var CanEdit: Boolean);
    procedure gridGetAlignment(Sender: TObject; ARow, ACol: Integer;
      var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure gridGetEditorType(Sender: TObject; ACol, ARow: Integer;
      var AEditor: TEditorType);
    procedure gridRowChanging(Sender: TObject; OldRow, NewRow: Integer;
      var Allow: Boolean);
    procedure txtUnitKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure tbtNewClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure txtCodeChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure tbtSaveClick(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure txtDasarValueValidate(Sender: TObject; value: String;
      var IsValid: Boolean);
    procedure cmbGudangChange(Sender: TObject);
    procedure btnKemasClick(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure cmbGudangKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure txtDasarKeyPress(Sender: TObject; var Key: Char);
  private
    lookup_state: word;
    MstPaket: TMstPaket;
    lsGudang: TStringList;
    procedure itungHarga;
    procedure InitGrid;
    procedure getUnitMaster(AUnitID: integer; kode: string);
    procedure getUnit(AUnitID, ARow: integer; var kode: string);
    procedure getItem(var AItemCode: string; AItemID: integer);
    procedure lookupUnit();
    procedure ResetData;
    procedure LoadData(id: integer);
    function isSaved: boolean;
    function isValid: boolean;
  public
    procedure Execute(id: integer);
  end;

var
  frmMstPaket: TfrmMstPaket;

implementation

uses Subroutines, MySQLConnector, uMysqlClient, LookupData, 
  MainMenu, UConst;

const
  colCode  = 1;
  colNama  = 2;
  colQty   = 3;
  colSat   = 4;
  colDasar = 5;
  colHarga = 6;
  colDisc  = 7;
  colConv  = 8;
  colID    = 9;
  colItemID= 10;
  colConvID= 11;
  colModID = 12;

{$R *.dfm}

{ TfrmMstPaket }

procedure TfrmMstPaket.Execute(id: integer);
begin
  MstPaket:= TMstPaket.Create;
  lsGudang:= TStringList.Create;
  TMstMaster_Arr.GetList(lsGudang, MST_TYPE_GUDANG);
  NameValueListToValueList(lsGudang, cmbGudang.Items);
  cmbGudang.ItemHeight:= 0;
  cmbGudangChange(nil);
  ResetData;
  LoadData(id);
  Run(Self);
  MstPaket.Destroy;
  lsGudang.Destroy;
end;

procedure TfrmMstPaket.getItem(var AItemCode: string; AItemID: integer);
var row:integer; MstItem: TMstItem;
begin
  MstItem:= TMstItem.Create;
  MstItem.Barcode:= AItemCode;
  MstItem.ItemId := AItemID;

  row:= grid.Row;
  if MstItem.SelectInDB3 then begin
     AItemCode:= MstItem.Barcode;
     grid.Cells[colNama,  row]:= MstItem.ItemName;
     grid.Cells[colCode,  row]:= AItemCode;
     grid.Ints[colItemId, row]:= MstItem.ItemId;
     grid.Row:= row;
     grid.Col:= colQty;
  end
  else begin
    Inform('Item tidak ditemukan.');
    grid.Col:= colCode;
    grid.Row:= row;
  end;
  MstItem.Free;
end;

procedure TfrmMstPaket.getUnit(AUnitID, ARow: integer; var kode: string);
var MstUnit: TMysqlResult;
begin
  MstUnit:= OpenSQL(
  'select c.conv_id, i.avg_price, c.sales_price, c.conversion, u.mst_code '+
  'from mst_item_conversion c, mst_item i, mst_master u '+
  'where c.item_id = i.item_id and c.unit_id = u.mst_id '+
  'and i.item_id = '+grid.Cells[colItemID, ARow]+
  IfThen(kode <> '',
  ' and u.mst_code = '+FormatSQLString(kode), ' and u.mst_id = '+FormatSQLNumber(AUnitID))+
  ' limit 1');

  if MstUnit.RecordCount > 0 then begin
    kode:= MstUnit.FieldValue(4);
    grid.Cells[colConvId, ARow]:= MstUnit.FieldValue(0);
    grid.Cells[colSat,    ARow]:= kode;
    grid.Cells[colDasar,  ARow]:= FloatToStrFmt(BufferToFloat(MstUnit.FieldValue(1)) *
                                                BufferToFloat(MstUnit.FieldValue(3)));
    grid.Cells[colHarga,  ARow]:= FloatToStrFmt(BufferToFloat(MstUnit.FieldValue(2)));
    grid.Cells[colConv,   ARow]:= FloatToStrFmt(BufferToFloat(MstUnit.FieldValue(3)));
    grid.Col:= colDasar;
    itungHarga;
  end else begin
    Alert('Satuan tidak ada');
    grid.Col:= colSat;
    kode:= '';
  end;

  MstUnit.Free;
end;

procedure TfrmMstPaket.getUnitMaster(AUnitID: integer; kode: string);
var MstUnit: TMstMaster;
begin
  MstUnit:= TMstMaster.Create();
  MstUnit.MstID:= AUnitID;
  MstUnit.MstCode:= kode;

  if MstUnit.SelectInDB then begin
    txtUnit.Text:= UpperCase(MstUnit.MstCode);
    txtUnit.Tag := MstUnit.MstId;
    tbtSave.Enabled:= True;
  end
  else begin
    Inform('Satuan tidak ditemukan.');
    txtUnit.SetFocus
  end;
end;

procedure TfrmMstPaket.InitGrid;
begin
  grid.ExpandAll;
  grid.ClearNormalCells;
  grid.RowCount:= 2;
  grid.ColWidths[colCode]:= 95;
  grid.ColWidths[0]:= 18;
  grid.ColWidths[colQty]:= 40;
  grid.ColWidths[colSat]:= 40;
  grid.ColWidths[colDasar ]:= 60;
  grid.ColWidths[colHarga ]:= 60;
  grid.ColWidths[colDisc  ]:= 60;
  grid.ColWidths[colConv  ]:= 0;
  grid.ColWidths[colID    ]:= 0;
  grid.ColWidths[colItemID]:= 0;
  grid.ColWidths[colConvID]:= 0;
  grid.ColWidths[colModID ]:= 0;
  grid.RowHeights[1]:= grid.DefaultRowHeight;
end;

function TfrmMstPaket.isSaved: boolean;
var i: integer;
begin
  MstPaket.Clear;
  MstPaket.PaketID:= txtCode.Tag;
  MstPaket.UnitID:= txtUnit.Tag;
  MstPaket.Kode  := txtCode.Text;
  MstPaket.Barcode   := txtBarcode.Text;
  MstPaket.Nama  := txtName.Text;
  MstPaket.NamaStruk := txtStruk.Text;
  MstPaket.HargaDasar:= StrFmtToFloatDef(txtDasar.Text,0);
  MstPaket.HargaJual := StrFmtToFloatDef(txtJual.Text,0);
  MstPaket.GudangID  := cmbGudang.Tag;

  for i:= 1 to grid.RowCount-1 do
    if (grid.Ints[colItemID, i] <> 0) and (grid.Ints[colModID, i] <> 0) then
      MstPaket.Item.Add(
      grid.Ints[colID, i], txtCode.Tag,
      grid.Ints[colItemID, i],
      grid.Ints[colConvID, i],
      grid.Floats[colQty,  i],
      grid.Floats[colConv, i],

      //conversi keharga satuan terkecil : dibagi dg konversi sebelum x qty
      (grid.Floats[colHarga, i] / grid.Floats[colConv, i]) - grid.Floats[colDisc, i],
      grid.Floats[colDisc, i], //cuma info
      grid.Floats[colDasar, i] / grid.Floats[colConv, i]);

  if txtCode.Tag <> 0 then Result:= MstPaket.UpdateOnDB()
  else Result:= MstPaket.InsertOnDB;

  tbtSave.Enabled:= not Result;
  if Result then LoadData(MstPaket.PaketID);
end;

function TfrmMstPaket.isValid: boolean;
begin
  if CekInput(Result, txtBarcode.Text <> '', 'Barcode belum diisi.', txtBarcode) then
  if CekInput(Result, txtName.Text <> '', 'Nama belum diisi.', txtName) then
  if CekInput(Result, txtUnit.Tag <> 0, 'Satuan belum diisi.', txtUnit) then
//chan   if CekInput(Result, cmbGudang.Tag <> 0, 'Gudang belum diisi.', cmbGudang) then
  if CekInput(Result, ((not MstPaket.isExistInDb(txtCode.Text)) and (txtCode.Tag = 0)) or (txtCode.Tag <> 0), 'Kode Sudah ada.', txtCode) then
  CekInput(Result, ((not MstPaket.isExistBarcode(txtBarcode.Text)) and (txtCode.Tag = 0)) or (txtCode.Tag <> 0), 'Barcode Sudah ada.', txtBarcode)
end;

procedure TfrmMstPaket.itungHarga;
var hrg_dasar, hrg_jual: double;
i: integer;
begin
  hrg_dasar:= 0;
  hrg_jual:= 0;
  for i:= 1 to grid.RowCount-1 do begin
    hrg_dasar:= hrg_dasar + (grid.Floats[colDasar, i] * grid.Floats[colQty, i]);
    hrg_jual:= hrg_jual + (grid.Floats[colHarga, i] * grid.Floats[colQty, i]) - grid.Floats[colDisc, i];
  end;

 // hrg_dasar:= grid.ColumnSum(colDasar, 1, grid.RowCount-1);
  //hrg_jual :=
  //  (grid.ColumnSum(colHarga, 1, grid.RowCount-1) * grid.ColumnSum(colQty, 1, grid.RowCount-1)) -
  //  grid.ColumnSum(colDisc, 1, grid.RowCount-1);
  txtDasar.Text:= FloatToStr(hrg_dasar);
  txtJual.Text:= FloatToStr(hrg_jual);
end;

procedure TfrmMstPaket.LoadData(id: integer);
var i: integer; item: TMysqlResult;
begin
  if (id = 0) then exit;

  ToolButton1.Enabled:= False;
  MstPaket.Clear;
  MstPaket.PaketID:= id;
  MstPaket.SelectInDB;
  txtCode.Tag:= MstPaket.PaketID;
  txtUnit.Tag:= MstPaket.UnitID;
  txtCode.Text := MstPaket.Kode;
  txtBarcode.Text := MstPaket.Barcode;
  txtName.Text := MstPaket.Nama;
  txtStruk.Text:= MstPaket.NamaStruk;
  txtUnit.Text:= TMstMaster.getKode(MstPaket.UnitID);
  txtJual.Text:= FloatToStr(MstPaket.HargaJual);
  txtDasar.Text:= FloatToStr(MstPaket.HargaDasar);
  cmbGudang.ItemIndex:= lsGudang.IndexOfName(IntToStr(MstPaket.GudangID));
  InitGrid;
  grid.RowCount:= IfThen(MstPaket.Item.Count > 0, MstPaket.Item.Count+1, 2);
  for i:= 0 to MstPaket.Item.Count-1 do begin
    grid.Ints[colModID, i+1]:= 0;
    grid.Ints[colID,    i+1]:= MstPaket.Item[i].PaketItemID;
    grid.Ints[colItemID,i+1]:= MstPaket.Item[i].ItemID;
    grid.Ints[colConvID,i+1]:= MstPaket.Item[i].ConvID;
    grid.Cells[colQty,  i+1]:= FloatToStrFmt(MstPaket.Item[i].Qty);
    grid.Cells[colConv, i+1]:= FloatToStrFmt(MstPaket.Item[i].Conversion);
    grid.Cells[colDasar,i+1]:= FloatToStrFmt(MstPaket.Item[i].HrgDasar);
    grid.Cells[colHarga,i+1]:= FloatToStrFmt(MstPaket.Item[i].Harga + MstPaket.Item[i].Discount);
    grid.Cells[colDisc, i+1]:= FloatToStrFmt(MstPaket.Item[i].Discount);

    item:= OpenSQL(
    'select i.barcode, i.item_name, u.mst_code '+
    'from mst_item_conversion c, mst_item i, mst_master u '+
    'where c.item_id = i.item_id and c.unit_id = u.mst_id '+
    'and c.conv_id = '+IntToStr(MstPaket.Item[i].ConvID));
    if item.RecordCount > 0 then begin
      grid.Cells[colCode, i+1]:= item.FieldValue(0);
      grid.Cells[colNama, i+1]:= item.FieldValue(1);
      grid.Cells[colSat,  i+1]:= item.FieldValue(2);
    end;
    item.destroy;
  end;
  tbtSave.Enabled:= False;
end;

procedure TfrmMstPaket.ResetData;
begin
  ToolButton1.Enabled:= true;
  InitGrid;
  txtCode.Clear;
  txtBarcode.Clear;
  txtName.Clear;
  txtStruk.Clear;
  txtUnit.Clear;
  txtDasar.Clear;
  txtJual.Clear;
  txtUnit.Tag:= 0;
  txtCode.Tag:= 0;
  tbtSave.Enabled:= True;
end;

procedure TfrmMstPaket.lookupUnit;
var ID: integer; kode: string;
begin
  kode:= '';
  if lookup_state = 1 then begin
    ID:= frmLookup.Execute('SAT');
    if ID <> 0 then getUnitMaster(ID, kode);
  end
  else begin
    case grid.Col of
      colCode, colNama:
      begin
        ID:= frmLookup.ExecuteItem(0,0,0);
        if ID > 0 then getItem(kode, ID);
      end;

      colSat:
      begin
        id:= frmLookup.ExecuteSatX(grid.Ints[colItemID, grid.Row]);
        if id <> 0 then getUnit(ID, grid.Row, kode);
      end;
    end;
  end;
end;

procedure TfrmMstPaket.gridCellValidate(Sender: TObject; Col, Row: Integer;
  var Value: String; var Valid: Boolean);
begin
  case Col of
    colCode, colSat: grid.Ints[colModID, Row]:= 1;
    colQty, colDasar, colHarga, colDisc{, colJual}:
    begin
      grid.Ints[colModID, Row]:= 1;
      Value:= FloatToStrFmt(StrFmtToFloatDef(Value,0));
      itungHarga;
    end;
  end;
end;

procedure TfrmMstPaket.gridKeyPress(Sender: TObject; var Key: Char);
begin
  case grid.Col of
    colDasar, colHarga, {colJual,} colQty, colDisc: if key = #46 then key := #44;
  end;
end;

procedure TfrmMstPaket.gridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var value: string; jumlah: double; valid: boolean;
begin
  case key of
    VK_RETURN:
    begin
      if (grid.Col = colCode) and (grid.Ints[colModID, grid.Row] = 1) then begin
         value:= grid.Cells[colCode, grid.Row];
         getItem(value, 0);
      end

      else if (grid.Col = colSat) and (grid.Ints[colModID, grid.Row] = 1) then begin
         value:= grid.Cells[colSat, grid.Row];
         getUnit(0, grid.Row, value);
      end;
      GoNextColumn(Sender);
    end;

    VK_MULTIPLY:
     if grid.Col = colDisc then begin
        jumlah:= grid.Floats[colHarga, grid.Row];
        value:= FormatSQLNumber((StrFmtToFloatDef(grid.Cells[grid.Col, grid.Row],0)/100) * jumlah);
        grid.Cells[grid.Col, grid.Row]:= value;
        gridCellValidate(Sender, grid.Col, grid.Row, value, valid);
     end;

    vk_F2 : lookupUnit;
  end;
end;

procedure TfrmMstPaket.gridEnter(Sender: TObject);
begin
  lookup_state:= 2;
end;

procedure TfrmMstPaket.txtCodeEnter(Sender: TObject);
begin
  lookup_state:= 1;
end;

procedure TfrmMstPaket.gridCanEditCell(Sender: TObject; ARow,
  ACol: Integer; var CanEdit: Boolean);
begin
  CanEdit:=
    (ACol in [colCode, colNama]) or
    ((ACol in [colQty, colSat, colDasar, colHarga, colDisc{, colJual}]) and
    (grid.Ints[colItemID, ARow]<>0));
end;

procedure TfrmMstPaket.gridGetAlignment(Sender: TObject; ARow,
  ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  if (ACol in[colCode, colNama, colSat]) then HAlign:= taLeftJustify
  else HAlign:= taRightJustify
end;

procedure TfrmMstPaket.gridGetEditorType(Sender: TObject; ACol,
  ARow: Integer; var AEditor: TEditorType);
begin
  case ACol of
    colDasar, {colJual,} colQty, colHarga, colDisc: AEditor:= edFloat;
  end;
end;

procedure TfrmMstPaket.gridRowChanging(Sender: TObject; OldRow,
  NewRow: Integer; var Allow: Boolean);
begin
  if OldRow <= grid.RowCount-1 then
  grid.RowHeights[OldRow]:= grid.DefaultRowHeight;
  grid.AutoSizeRow(NewRow);
  if grid.RowHeights[NewRow] < grid.DefaultRowHeight then
    grid.RowHeights[NewRow]:= grid.DefaultRowHeight;
end;

procedure TfrmMstPaket.txtUnitKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    VK_F2: lookupUnit;
    VK_RETURN:
    begin
      if (Sender as TAdvEdit).Modified then
          getUnitMaster(0, txtUnit.Text);
         
      if (not (Sender as TAdvEdit).Modified) then
        GoNextControl(Self, (Sender as TWinControl), true, true, false).SetFocus;
    end;
  end;
end;

procedure TfrmMstPaket.tbtNewClick(Sender: TObject);
begin
  ResetData;
  txtCode.SetFocus;
end;

procedure TfrmMstPaket.FormShow(Sender: TObject);
begin
  txtCode.SetFocus
end;

procedure TfrmMstPaket.txtCodeChange(Sender: TObject);
var sudah_enabled: boolean;
begin
  sudah_enabled:= tbtSave.Enabled;
  if not sudah_enabled then
    tbtSave.Enabled:= (Sender as TAdvEdit).Modified;
end;

procedure TfrmMstPaket.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose:= True
end;

procedure TfrmMstPaket.tbtSaveClick(Sender: TObject);
begin
  if isValid then IsSaved 
end;

procedure TfrmMstPaket.ToolButton1Click(Sender: TObject);
begin
  if MstPaket.DeleteItemPaket(grid.Ints[colID, grid.Row]) then begin
    grid.ClearRows(grid.Row, 1);
    if grid.RowCount > 2 then
       grid.RemoveRows(grid.Row, 1);
    itungHarga;   
  end;
end;

procedure TfrmMstPaket.txtDasarValueValidate(Sender: TObject;
  value: String; var IsValid: Boolean);
begin
  AdvEdtFloatFmt(Sender, value)
end;

procedure TfrmMstPaket.cmbGudangChange(Sender: TObject);
begin
  cmbGudang.Tag:= 0;
  if cmbGudang.ItemIndex > -1 then
    cmbGudang.Tag:= StrToInt(lsGudang.Names[cmbGudang.ItemIndex]);
  tbtSave.Enabled:= True;
end;

procedure TfrmMstPaket.btnKemasClick(Sender: TObject);
var ID: integer;
begin
  ID:= frmLookup.Execute('SAT');
  if ID <> 0 then getUnitMaster(ID, '');
end;

procedure TfrmMstPaket.FormPaint(Sender: TObject);
begin
  AssigControl(Sender);
end;

procedure TfrmMstPaket.cmbGudangKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = vk_return then grid.SetFocus;
end;

procedure TfrmMstPaket.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  reAssignLastControl
end;

procedure TfrmMstPaket.txtDasarKeyPress(Sender: TObject; var Key: Char);
begin
  IgnoreChar(Key)
end;

end.
