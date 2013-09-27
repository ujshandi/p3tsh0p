unit TrsItemUse;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, BaseGrid, AdvGrid, StdCtrls, AdvEdit, ComCtrls,
  SUIImagePanel, ToolWin, ExtCtrls,
  strUtils, Math, UMaster, UTransaction, Menus,
  frmDockForm, RAWPrinter;

type
  TfrmTrsItemUse = class(TDockForm)
    suiPanel1: TsuiPanel;
    lblTransaksi: TLabel;
    dtpTransaction: TDateTimePicker;
    txtNotes: TAdvEdit;
    suiPanel3: TsuiPanel;
    grid: TAdvStringGrid;
    txtTotal: TAdvEdit;
    Label2: TLabel;
    ToolBar1: TToolBar;
    tbtNew: TToolButton;
    tbtSave: TToolButton;
    ToolButton5: TToolButton;
    tbtDelete: TToolButton;
    ToolButton2: TToolButton;
    ToolButton1: TToolButton;
    RAWPrinter1: TRAWPrinter;
    procedure gridCanEditCell(Sender: TObject; ARow,
      ACol: Integer; var CanEdit: Boolean);
    procedure gridCellValidate(Sender: TObject; Col,
      Row: Integer; var Value: String; var Valid: Boolean);
    procedure gridGetAlignment(Sender: TObject; ARow,
      ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure gridGetEditorType(Sender: TObject; ACol,
      ARow: Integer; var AEditor: TEditorType);
    procedure gridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure gridKeyPress(Sender: TObject; var Key: Char);
    procedure txtSpecKeyPress(Sender: TObject; var Key: Char);
    procedure dtpExprKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dtpDelyKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure rdbTaxClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure getUnitList;
    procedure getUnit(Sender: TObject);
    procedure txtSubtotalValueValidate(Sender: TObject; value: String;
      var IsValid: Boolean);
    procedure tbtDeleteClick(Sender: TObject);
    procedure tbtSaveClick(Sender: TObject);
    procedure tbtNewClick(Sender: TObject);
    procedure txtDisc2KeyPress(Sender: TObject; var Key: Char);
    procedure txtDisc2Exit(Sender: TObject);
    procedure txtSpecEnter(Sender: TObject);
    procedure gridEnter(Sender: TObject);
    procedure tbtPostClick(Sender: TObject);
    procedure dtpTransactionChange(Sender: TObject);
    procedure txtSpecChange(Sender: TObject);
    procedure txtTaxKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ToolButton1Click(Sender: TObject);
    procedure gridSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
  private
    MstItem: TMstItem;
    Trx: TTrsItemUse;
    ListUnit, lsGudang: TStringList;
    status_delete: word;
    OldValue: string;
    procedure InitGrid;
    procedure ArrangeColSize;
    procedure InitForm;
    procedure SetDisableEnable;
    procedure Calculate();
    procedure RemoveRow();
    function GetOrder(): boolean;
    procedure SavePostState(state: boolean);

    procedure SeekItem(ASearch: string);
    procedure getItem(var AItemCode: string; AItemID: integer; AQty: double);

    procedure LoadData(ID: integer);

    function isValid: boolean;
    function isSaved: boolean;
    //procedure Print();
  public
    procedure Execute(vPurpose, ID: integer); override;
  end;

var
  frmTrsItemUse: TfrmTrsItemUse;

implementation

uses MainMenu, UConst, Subroutines, MySQLConnector,
  LookupData, LookupTrx, uMysqlClient, trsReturPrint, EpsonUtils,
  UConstTool, AutoStockLine;

const
  colNo       = 0;
  colCode     = 1;
  colBarcode  = 2;
  colDesc     = 3;
  colMerk     = 4;
  colQty      = 5;
  colHarga    = 6;
  colTotal    = 7;
  colItemId   = 8;
  colModID    = 9;
  colID       =  10;

{$R *.dfm}

{ TfrmTrsPurchaseOrder }

procedure TfrmTrsItemUse.ArrangeColSize;
begin
  grid.AutoSizeColumns(true, 5);
  grid.AutoSizeRows(true, 3);
  grid.ColWidths[colItemId]:= 0;
  grid.ColWidths[colModID]:= 0;
  grid.ColWidths[colID]:= 0;
end;

procedure TfrmTrsItemUse.Calculate;
var
  total: double;
  i: integer;
begin
  total := 0;
  for i:= 1 to grid.RowCount-1 do
    total:= total + StrFmtToFloatDef(grid.Cells[colTotal, i],0);

//menentukan dpp


  txtTotal.Text   := FloatToStrFmt(total);



end;

procedure TfrmTrsItemUse.Execute(vPurpose, ID: integer);
begin
  inherited;
  ToolBar1.ParentColor:= false;
  ToolBar1.Color:= clWhite;

  ListUnit:= TStringList.Create;
  lsGudang:= TStringList.Create;


  MstItem  := TMstItem.Create;
  status_delete:= 0;
  Trx := TTrsItemUse.Create;
  InitForm;
  LoadData(ID);
  Run(Self);
end;

procedure TfrmTrsItemUse.getItem(var AItemCode: string; AItemID: integer;
  AQty: double);
var
  ItemCode: string; row, sameID:integer;
  qty: string; valid: boolean;

  function search_same_item(existID: integer): integer;
  var i: integer;
  begin
    Result:= 0;
    for i:= 1 to grid.RowCount-1 do
      if (grid.Ints[colItemID, i] = existID) then begin
        Result:= i;
        exit;
      end;
  end;

begin
  MstItem.Reset;
  MstItem.Barcode:= AItemCode;
  MstItem.ItemId := AItemID;
  row:= grid.Row;
  if MstItem.SelectInDB3 then begin
     ItemCode:= MstItem.Barcode;
     sameID:= search_same_item(MstItem.ItemId);
     if (sameID <> 0) and (row <> sameID) then begin
       AItemCode:= '';
       grid.ClearRows(grid.Row,1);
       grid.Row:= sameID;
       row:= sameID;
       grid.Cells[colQty, row]:= FloatToStrFmt(grid.Floats[colQty, row] + AQty);
     end else begin

       AItemCode:= MstItem.Barcode;
       grid.Cells[colDesc,    row]:= MstItem.ItemName;
       grid.Ints[colModID,    row]:= 1;
       grid.Cells[colcode, row]:= MstItem.ItemCode;
       grid.Cells[colBarcode, row]:= MstItem.Barcode;
       grid.Cells[colMerk,    row]:=MstItem.Merk;
       grid.Ints[colItemId,   row]:= MstItem.ItemId;
       grid.Cells[colHarga,   row]:= FloatToStrFmt(MstItem.BuyingPrice);
       grid.Cells[colQty,     row]:= FloatToStrFmt(AQty);
       grid.Cells[colTotal,   row]:= FloatToStrFmt(MstItem.BuyingPrice * AQty);
     end;

     grid.Row:= row;
     grid.Col:= colQty;
     qty:= FloatToStrFmt(grid.Floats[colQty, row]);
     gridCellValidate(grid, colQty, row, qty, valid);
     Calculate;

  end
  else begin
    Inform('Item tidak ditemukan.');
    grid.Col:= colBarcode;
    grid.Row:= row;
  end;
  ArrangeColSize;
end;

procedure TfrmTrsItemUse.InitForm;
begin
  InitGrid;
  lblTransaksi.Caption:= '[Nomor Transaksi]';
  lblTransaksi.Tag:= 0;
  txtNotes.Tag:= 0;

  txtNotes.Clear;

  txtTotal.Clear;
  SetDisableEnable;
  dtpTransaction.Date:= ServerNow;

end;

procedure TfrmTrsItemUse.InitGrid;
begin
  ResetGrid(grid, 2, colId+2, 1,1, -1);
  ArrangeColSize;
end;

function TfrmTrsItemUse.isSaved: boolean;
var i: integer;
begin
  Trx.Reset;
  Trx.ItemUseID    := lblTransaksi.Tag;
  Trx.TransDate  := dtpTransaction.Date;
  Trx.Notes      := txtNotes.Text;
  Trx.Total := StrFmtToFloatDef(txtTotal.Text,0);
//  Trx.Userid     := GlobalSystemUser.UserId;
  for i:= 1 to grid.RowCount -1 do
    if (not IsClear(grid, colItemId, i)) and (grid.Ints[colModID, i] <> 0) then begin
      Trx.trsDetail.Add(grid.Ints[colID, i], lblTransaksi.Tag,
      grid.Ints[colItemId, i],grid.Floats[colQty,i],
      grid.Floats[colHarga,i],
      grid.Floats[colTotal,i]);
    end;
  if (lblTransaksi.Tag = 0) then
    Result:= Trx.InsertOnDB()
  else Result:= Trx.UpdateOnDB();

  if Result then LoadData(Trx.ItemUseID);
  tbtSave.Enabled:= not Result;   
end;

function TfrmTrsItemUse.isValid: boolean;
var i: integer; valid: boolean;
begin
  Result:= False; valid:= False;
  for i:= 1 to grid.RowCount-1 do begin
    valid:= not IsClear(grid, colItemId, i);
    if valid then Break;
  end;

     CekInput(Result, valid , 'Tidak ada item untuk disimpan.', grid)
end;

procedure TfrmTrsItemUse.RemoveRow;
begin
  case lblTransaksi.Tag of
    0:begin
        grid.ClearRows(grid.Row, 1);
        if grid.RowCount > 2 then grid.RemoveRows(grid.Row, 1);
        Calculate;
      end
    else
      case status_delete of
        1: if Confirmed('Hapus penerimaan barang?') then
             if TTrsRetur.DeleteTrans(lblTransaksi.Tag) then
                InitForm;
        2: if Confirmed('Hapus baris?') then
             if TTrsRetur.DeleteDetail(grid.Ints[colId, grid.Row]) then begin
                grid.ClearRows(grid.Row, 1);
                if grid.RowCount > 2 then grid.RemoveRows(grid.Row, 1);
                Calculate;
             end;
      end;
   end;
end;

procedure TfrmTrsItemUse.SeekItem(ASearch: string);
var id: integer; code: string;
begin
  code:= '';
  id:= frmLookup.ExecuteItem(0, 0, 0);
  if Id > 0 then getItem(code, id, 1)
end;

procedure TfrmTrsItemUse.SetDisableEnable;
begin
  tbtSave.Enabled:= (txtNotes.Tag=0) and (lblTransaksi.Tag=0);
  dtpTransaction.Enabled:= (txtNotes.Tag=0);

  txtNotes.Enabled:= (txtNotes.Tag = 0);
  tbtDelete.Enabled:= (txtNotes.Tag = 0);
  tbtDelete.Enabled:= (txtNotes.Tag = 0);
end;

procedure TfrmTrsItemUse.gridCanEditCell(Sender: TObject;
  ARow, ACol: Integer; var CanEdit: Boolean);
begin
  CanEdit:=
  (ACol in [colBarcode,colCode, colQty]) and
  (txtNotes.Tag = 0);
end;

procedure TfrmTrsItemUse.gridCellValidate(Sender: TObject;
  Col, Row: Integer; var Value: String; var Valid: Boolean);
var tmp: string; tmp_nilai: double;
begin
  case Col of
    colCode,colBarcode:
    begin
      grid.Ints[colModID, Row]:= 1;
      SavePostState(True);
    end;

    colQty, colHarga:
    begin
      Valid:= Value <> '';
      if not Valid then begin
        Inform('Inputan belum diisi.');
        grid.Col:= Col;
        grid.Row:= Row;
        exit;
      end else
      begin
        grid.Cells[colTotal, Row]:=
            FloatToStrFmt(
              StrFmtToFloatDef(grid.Cells[colQty, Row], 0) *
              StrFmtToFloatDef(grid.Cells[colHarga,Row], 0));

        tmp_nilai:= StrFmtToFloatDef(Value,0);
        tmp:= FloatToStrFmt(tmp_nilai);
        Value:= tmp;

        Calculate;
        SavePostState(True);
        ArrangeColSize;
        grid.Ints[colModID, Row]:= 1;
        SavePostState(True);
      end;
    end;


  end;
end;

procedure TfrmTrsItemUse.gridGetAlignment(Sender: TObject;
  ARow, ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  if (ACol in[colNo, colQty, colHarga, colTotal]) then
    HAlign:= taRightJustify
end;

procedure TfrmTrsItemUse.gridGetEditorType(Sender: TObject;
  ACol, ARow: Integer; var AEditor: TEditorType);
begin
  case ACol of
    colQty, colHarga: AEditor:= edFloat;
  end;
end;

procedure TfrmTrsItemUse.gridKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var value: string; jumlah: double; valid: boolean;
begin
  case key of
    VK_ADD   : getUnitList;
    VK_F2    :
    case grid.Col of
//    colFaktur: GetOrder;
      colCode,colBarcode, colDesc: SeekItem(grid.Cells[colBarcode, grid.Row]);
    end;

    VK_RETURN:
    begin
      if (grid.Col in [colCode,colBarcode]) and (grid.Ints[colModID, grid.Row] = 1) then begin
         value:= grid.Cells[grid.col, grid.Row];
         if oldValue <> value then
           getItem(value, 0, 1);
      end;
      GoNextColumn(Sender);
    end;


  end;
end;

procedure TfrmTrsItemUse.gridKeyPress(Sender: TObject;
  var Key: Char);
begin
  case grid.Col of
    colQty: if key = #46 then key := #44;
  end;
end;

procedure TfrmTrsItemUse.getUnitList;
var
  i: integer;
  rect: TRect; points: TPoint;
  MenuUnit: TMenuItem; PopUnit: TPopupMenu;
begin
  if grid.Ints[colItemId, grid.Row] <= 0 then exit;
  PopUnit:= TPopupMenu.Create(grid);
  PopUnit.Items.Clear;
  TMstItemConversionArr.getList(ListUnit, grid.Ints[colItemId, grid.Row], nil);
  for i:= 0 to ListUnit.Count-1 do begin
    MenuUnit:= TMenuItem.Create(PopUnit.Items);
    MenuUnit.Caption:= ListUnit.Values[ListUnit.Names[i]];
    MenuUnit.Tag    := StrToInt(ListUnit.Names[i]);
    MenuUnit.OnClick:= getUnit;
    PopUnit.Items.Add(MenuUnit);
  end;

  rect   := grid.CellRect(grid.Col, grid.Row);
  points := grid.ClientToScreen(Point(grid.Left, grid.Top));
  SetCursorPos((points.X + rect.Left), (points.Y + (rect.Top - 10)));
  PopUnit.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y);
  PopUnit.FreeOnRelease;
end;

procedure TfrmTrsItemUse.getUnit(Sender: TObject);
var ARow: Integer; MstUnit: TMstItemConversion;
begin
  case grid.Col of
    colQty:
    begin
      ARow:= grid.Row;
      MstUnit:=TMstItemConversion.Create;
      MstUnit.Reset;
      MstUnit.ConvId:= (Sender as TMenuItem).Tag;
      if MstUnit.SelectInDB then begin
        grid.Cells[colHarga, ARow]:= FloatToStrFmt(MstUnit.PurchasePrice);
        grid.Ints[colModID,  ARow]:= 1;

        grid.Cells[colTotal, ARow]:=
          FloatToStrFmt(
          StrFmtToFloatDef(grid.Cells[colHarga, ARow],0) *
          StrFmtToFloatDef(grid.Cells[colQty, ARow],0));
        Calculate;
      end;
      MstUnit.Free;
    end;
  end;
  ArrangeColSize;
end;

procedure TfrmTrsItemUse.txtSpecKeyPress(Sender: TObject;
  var Key: Char);
begin
//  if key <> #13 then txtSpec.Tag:= 0;
end;

procedure TfrmTrsItemUse.dtpExprKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  //if (key = vk_return) and (dtpDely.Enabled) then
   // dtpDely.SetFocus;
end;

procedure TfrmTrsItemUse.dtpDelyKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (key = vk_return) and (txtNotes.Enabled) then
    txtNotes.SetFocus;
end;

procedure TfrmTrsItemUse.rdbTaxClick(Sender: TObject);
begin
//  Calculate;
  SavePostState(True);
end;

procedure TfrmTrsItemUse.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_F4:
    begin
      grid.SetFocus;
      grid.Row:= 1;
      grid.Col:= colBarcode;
    end;
  end;
end;

procedure TfrmTrsItemUse.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  if MstItem <> nil then MstItem.Free; MstItem:= nil;
  if Trx <> nil then Trx.Free; Trx:= nil;
  if ListUnit <> nil then ListUnit.Free; listUnit:= nil;
  if lsGudang <> nil then lsGudang.Free; lsGudang:= nil;
end;

procedure TfrmTrsItemUse.LoadData(ID: integer);
var i: integer; detail: TMysqlResult; x: double;
begin
  if ID = 0 then exit;
  Trx.Reset;
  Trx.ItemUseID:= ID;
  Trx.SelectInDB;
  lblTransaksi.Caption:= Trx.TransNum;
  lblTransaksi.Tag:= Trx.ItemUseID;
  dtpTransaction.Date:= Trx.TransDate;


  txtNotes.Text:= Trx.Notes;

  txtTotal.Text := FloatToStrFmt(Trx.Total);



  InitGrid;
  // 0item_use_detail_id,1d.item_id,2d.quantity, 3d.buying_price,4d.amount,5i.item_code,6i.item_name, 7i.merk,8barcode

  detail:= Trx.SelectDetail(ID);
  detail.First;
  for i:= 1 to detail.RecordCount do begin
    grid.Ints[colNo,i ] := i;
    grid.Cells[colID,      i]:= detail.FieldValue(0);
//  grid.Cells[colFaktur,  i]:= detail.FieldValue(11);
//  grid.Cells[colFakturID,i]:= detail.FieldValue(10);
    grid.Cells[colItemId,  i]:= detail.FieldValue(1);
    grid.Cells[colcode, i]:= detail.FieldValue(5);
    grid.Cells[colBarcode, i]:= detail.FieldValue(8);
    grid.Cells[colMerk, i]:= detail.FieldValue(7);
    grid.Cells[colDesc,    i]:= detail.FieldValue(6);
    grid.Cells[colQty,     i]:= FloatToStrFmt(BufferToFloat(detail.FieldValue(2)));
    grid.Cells[colHarga,   i]:= FloatToStrFmt(BufferToFloat(detail.FieldValue(3)));
    grid.Cells[colTotal,   i]:= FloatToStrFmt(BufferToFloat(detail.FieldValue(4)));

    grid.Ints[colModID,    i]:= 0;
    detail.MoveNext;
    grid.AddRow;
  end;
  detail.destroy;
  //Calculate;
  DeleteRowTerakhir(grid, 2, 1);
  ArrangeColSize;
  SetDisableEnable;
end;

procedure TfrmTrsItemUse.txtSubtotalValueValidate(Sender: TObject;
  value: String; var IsValid: Boolean);
begin
  AdvEdtFloatFmt(Sender, value);
end;

procedure TfrmTrsItemUse.tbtDeleteClick(Sender: TObject);
begin
  RemoveRow
end;

procedure TfrmTrsItemUse.tbtSaveClick(Sender: TObject);
begin
  if isValid then isSaved 
end;

procedure TfrmTrsItemUse.tbtNewClick(Sender: TObject);
var tag : integer;
begin
  tag := 321;
//  Alert(IntToStr(AktiveControl.Tag));
if not TSystemAccess.isCan(CAN_ADD,tag) then exit;
  InitForm;
  SetDisableEnable;
end;

procedure TfrmTrsItemUse.txtDisc2KeyPress(Sender: TObject;
  var Key: Char);
begin
  if key = #46 then key := #44;
  IgnoreChar(Key);
end;

procedure TfrmTrsItemUse.txtDisc2Exit(Sender: TObject);
begin
  Calculate;
end;

procedure TfrmTrsItemUse.txtSpecEnter(Sender: TObject);
begin
  status_delete:= 1;
end;

procedure TfrmTrsItemUse.gridEnter(Sender: TObject);
begin
  status_delete:= 2;
end;

procedure TfrmTrsItemUse.tbtPostClick(Sender: TObject);
begin
  if TTrsRetur.PostTrans(lblTransaksi.Tag) then
    txtNotes.Tag:= 1;
  SetDisableEnable;
end;

procedure TfrmTrsItemUse.dtpTransactionChange(Sender: TObject);
begin
  SavePostState(True);
end;

function TfrmTrsItemUse.GetOrder(): boolean;
var i, row: integer; detail: TMysqlResult;
begin
  Result:= False;
  row:= frmLookupTrx.ExecuteReceipt('RECEIPT');
  if row = 0 then exit;

  detail:= Trx.SelectDetail(row);
  Result:= detail.RecordCount > 0;
  detail.First;
  row:= grid.Row;
  for i:= 0 to detail.RecordCount-1 do begin
  //0receipt_id, 1item_id, 2conv_id, 3quantity,
  //4price, 5amount, 6conversion, 7item_name, 8barcode, 9satuan, 10faktru
              grid.Ints[colNo,row+i ] := i+1;
//  grid.Cells[colFaktur,  row+i]:= detail.FieldValue(10);
  //grid.Cells[colFakturID,row+i]:= detail.FieldValue(0);
    grid.Cells[colItemId,  row+i]:= detail.FieldValue(1);
    grid.Cells[colcode, row+i]:= detail.FieldValue(5);
    grid.Cells[colBarcode, row+i]:= detail.FieldValue(8);
    grid.Cells[colDesc,    row+i]:= detail.FieldValue(7);
    grid.Cells[colQty,     row+i]:= FloatToStrFmt(BufferToFloat(detail.FieldValue(3)));
    grid.Cells[colHarga,   row+i]:= FloatToStrFmt(BufferToFloat(detail.FieldValue(4)));
    grid.Cells[colTotal,   row+i]:= FloatToStrFmt(BufferToFloat(detail.FieldValue(5)));
    grid.Ints[colModID,    row+i]:= 1;
    detail.MoveNext;
    grid.AddRow;
  end;
  detail.destroy;
  Calculate;
  //DeleteRowTerakhir(grid, 2, 1);
  ArrangeColSize;
end;

procedure TfrmTrsItemUse.SavePostState(state: boolean);
begin
  tbtSave.Enabled:= state;
end;

procedure TfrmTrsItemUse.txtSpecChange(Sender: TObject);
var asalna_true: boolean;
begin
  asalna_true:= tbtSave.Enabled;
  if not asalna_true then
  SavePostState((Sender as TAdvEdit).Modified);
end;

procedure TfrmTrsItemUse.txtTaxKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 case Key of
    VK_F4:
    begin
      grid.SetFocus;
      grid.Row:= 1;
      grid.Col:= colBarcode;
    end;
   

  end;

end;

procedure TfrmTrsItemUse.ToolButton1Click(Sender: TObject);
begin

  Alert(MSG_UNDER_CONSTRUCTION);exit;
  if lblTransaksi.Tag <> 0 then begin
    if GlobalSystemConfig.localSetting.PrinterAdm <> '' then begin
       if (getDefaultPrinter <> GlobalSystemConfig.localSetting.PrinterAdm) then
           setDefaultPrinter(GlobalSystemConfig.localSetting.PrinterAdm);
    end;

    try
      Application.CreateForm(TqrpRetur, qrpRetur);
      qrpRetur.Execute(lblTransaksi.Tag, grid);
    finally
      qrpRetur.Destroy;
    end;

    RAWPrinter1.PrinterName:= GlobalSystemConfig.localSetting.PrinterAdm;
    RAWPrinter1.DocumentTitle:= '';
    RAWPrinter1.BeginDoc;
    RAWPrinter1.Write(escCRLF);
    RAWPrinter1.Write(escCRLF);
    RAWPrinter1.Write(escCRLF);
    RAWPrinter1.Write(escCRLF);
    RAWPrinter1.Write(escCRLF);
    RAWPrinter1.Write(escCRLF);
    RAWPrinter1.Write(escCRLF);
    RAWPrinter1.Write(escCRLF);
    RAWPrinter1.Write(escCRLF);
    RAWPrinter1.Write(escCRLF);
    RAWPrinter1.Write(escCRLF);
    RAWPrinter1.EndDoc;
  end;
end;

procedure TfrmTrsItemUse.gridSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
  if (ACol = colBarcode) then OldValue:= grid.Cells[ACol, ARow];

end;

end.
