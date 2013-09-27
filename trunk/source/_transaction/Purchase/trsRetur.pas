unit trsRetur;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, BaseGrid, AdvGrid, StdCtrls, AdvEdit, ComCtrls, uMysqlClient,
  SUIImagePanel, ToolWin, ExtCtrls, MySQLConnector,
  strUtils, Math, UMaster, UTransaction, Menus,
  frmDockForm, RAWPrinter;

type
  TfrmTrsRetur = class(TDockForm)
    suiPanel1: TsuiPanel;
    lblTransaksi: TLabel;
    dtpTransaction: TDateTimePicker;
    txtNotes: TAdvEdit;
    txtSpec: TAdvEdit;
    btnSpec: TButton;
    suiPanel3: TsuiPanel;
    grid: TAdvStringGrid;
    txtSubtotal: TAdvEdit;
    txtTax: TAdvEdit;
    txtTotal: TAdvEdit;
    Label2: TLabel;
    txtBiaya: TAdvEdit;
    ToolBar1: TToolBar;
    tbtNew: TToolButton;
    tbtSave: TToolButton;
    ToolButton5: TToolButton;
    tbtDelete: TToolButton;
    ToolButton2: TToolButton;
    ToolButton1: TToolButton;
    tbtPost: TToolButton;
    RAWPrinter1: TRAWPrinter;
    imgLogo: TImage;
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
    procedure txtSpecKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure txtSpecKeyPress(Sender: TObject; var Key: Char);
    procedure btnSpecClick(Sender: TObject);
    procedure dtpExprKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dtpDelyKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dtpTransactionKeyDown(Sender: TObject; var Key: Word;
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
    Trx: TTrsRetur;
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
    procedure CalculateManualPPN();
    procedure CalculateBuangPPN();

    procedure SeekItem(ASearch: string);
    procedure getItem(var AItemCode: string; AItemID: integer; AQty: double);

    procedure SeekVendor;
    procedure getVendor(ACode: string; AID: integer);
    procedure LoadData(ID: integer);

    function isValid: boolean;
    function isSaved: boolean;

    procedure printOrder(ID: integer);
    function  printHeader(value: TStringList; _buffer: TMysqlResult; hal: integer;onlyColumnHeader:boolean=false): integer;
    function  printFooter(value: TStringList; idx, insIdx: integer): integer;
    //procedure Print();
  public
    procedure Execute(vPurpose, ID: integer); override;
  end;

var
  frmTrsRetur: TfrmTrsRetur;

implementation

uses MainMenu, UConst, Subroutines,
  LookupData, LookupTrx, trsReturPrint, EpsonUtils,
  UConstTool, RawPrintPrev;

const

FIXED_WIDTH  = 137;
  PAPER_WIDTH  = 134;
  GARIS        =
  '----------------------------------------'+
  '----------------------------------------'+//80
  '-------------------------------------------------';

  GARIS2       =
  '========================================'+
  '========================================'+
  '=================================================';

  
  colNo       = 0;
  //colFaktur   = 1;
  colCode     = 1;
  colBarcode  = 2;
  colDesc     = 3;
  colQty      = 4;
  colUnit     = 5;
  colHarga    = 6;
  colTotal    = 7;
  colDisc     = 8;
  colTax      = 9;
  colConv     = 10;
  colItemId   = 11;
  colConvId   = 12;
//colFakturId = 12;
  colModID    = 13;
  colID       = 14;
  colDiscIsPrc= 15;
  colDiscTmp  = 16;
  colTaxed    = 17;

{$R *.dfm}

{ TfrmTrsPurchaseOrder }

procedure TfrmTrsRetur.ArrangeColSize;
begin
  grid.AutoSizeColumns(true, 5);
  grid.AutoSizeRows(true, 3);
  grid.ColWidths[colItemId]:= 0;
  grid.ColWidths[colConvId]:= 0;
  grid.ColWidths[colConv]:= 0;
  grid.ColWidths[colModID]:= 0;
  grid.ColWidths[colID]:= 0;
//grid.ColWidths[colFakturId]:= 0;
  grid.ColWidths[colDiscIsPrc]:= 0;
  grid.ColWidths[colDiscTmp]:= 0;
  grid.ColWidths[colTaxed]:= 0;
  grid.ColWidths[colTax]:= 0;
  grid.ColWidths[colDisc]:= 0;
end;

procedure TfrmTrsRetur.Calculate;
var
  total, 
   dis_tax, dis_nontax: double;
  i: integer;
begin
  total := 0;
  for i:= 1 to grid.RowCount-1 do
    total:= total + StrFmtToFloatDef(grid.Cells[colTotal, i],0);

//menentukan dpp
  dis_tax:= 0;
  for i:= 1 to grid.RowCount-1 do
      if grid.Floats[colTax, i] <> 0 then
         dis_tax:= dis_tax + grid.Floats[colDiscTmp, i];

  dis_nontax:= 0;
  for i:= 1 to grid.RowCount-1 do
      if grid.Floats[colTax, i] = 0 then
         dis_nontax:= dis_nontax + grid.Floats[colDiscTmp, i];


  txtSubtotal.Text:= FloatToStrFmt(total);
  txtTotal.Text   := FloatToStrFmt(total-dis_tax-dis_nontax);

  if (txtTax.Tag = 1) then CalculateManualPPN;

{var total, disc, tax, addt: double;
begin
  total:= grid.ColumnSum(colTotal, 1, grid.RowCount-1);
  txtSubtotal.Text:= FloatToStrFmt(total);

  disc:= StrFmtToFloatDef(txtDisc2.Text,0);
  txtDPP.Text:= FloatToStrFmt(total - disc);
  addt:= StrFmtToFloatDef(txtMaterai.Text,0) + StrFmtToFloatDef(txtBiaya.Text,0);
  if rdbTax.Checked then tax:= (total - disc) * 0.1
  else if rdbNonTax.Checked then tax:= 0
  else tax:= 0;
  txtTax.Text:= FloatToStrFmt(tax);
  txtTotal.Text:= FloatToStrFmt(total-disc- + tax + addt);}


end;

procedure TfrmTrsRetur.Execute(vPurpose, ID: integer);
begin
  inherited;
  ToolBar1.ParentColor:= false;
  ToolBar1.Color:= clWhite;

  ListUnit:= TStringList.Create;
  lsGudang:= TStringList.Create;


  MstItem  := TMstItem.Create;
  status_delete:= 0;
  Trx := TTrsRetur.Create;
  InitForm;
  LoadData(ID);
  Run(Self);
end;

procedure TfrmTrsRetur.getItem(var AItemCode: string; AItemID: integer;
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
       grid.Cells[colCode, row]:= MstItem.ItemCode;
       grid.Cells[colBarcode, row]:= ItemCode;
       grid.Ints[colItemId,   row]:= MstItem.ItemId;
       grid.Ints[colConvId,   row]:= 0;//MstItem.FItemConversion[0].ConvId;
       grid.Cells[colUnit,    row]:= TMstMaster.getName(MstItem.KemasanID);//MstItem.FItemConversion[0].MstMaster.MstName;
       grid.Cells[colHarga,   row]:= FloatToStrFmt(MstItem.BuyingPrice);
       grid.Cells[colConv,    row]:= FloatToStrFmt(1);
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

procedure TfrmTrsRetur.getVendor(ACode: string; AID: integer);
var Data: TMstRelation;
begin
  Data:= TMstRelation.Create();
  Data.Reset;
  Data.RelationCode:= ACode;
  Data.RelationId := AID;

  if Data.SelectInDB then begin
    txtSpec.Tag := Data.RelationId;
    txtSpec.Text:= Data.RelationName +' ('+Data.RelationCode+')';
    SavePostState(True);
  end
  else begin
    Inform('Supplier tidak ditemukan.');
    txtSpec.Clear;
    txtSpec.SetFocus;
  end;
  ArrangeColSize;
  Data.Free;

end;

procedure TfrmTrsRetur.InitForm;
begin
  InitGrid;
  lblTransaksi.Caption:= '[Nomor Transaksi]';
  lblTransaksi.Tag:= 0;
  txtNotes.Tag:= 0;
  txtSpec.Tag:= 0;

  txtNotes.Clear;
  txtSpec.Clear;

  txtSubtotal.Clear;
  txtTax.Clear;
  txtBiaya.Clear;
  txtTax.Clear;
  txtTotal.Clear;
  SetDisableEnable;
  dtpTransaction.Date:= ServerNow;

end;

procedure TfrmTrsRetur.InitGrid;
begin
  ResetGrid(grid, 2, 19, 1,1, -1);
  ArrangeColSize;
end;

function TfrmTrsRetur.isSaved: boolean;
var i: integer;
begin
  Trx.Clear;
  Trx.ReturID    := lblTransaksi.Tag;
  Trx.TransDate  := dtpTransaction.Date;
  Trx.RelationId := txtSpec.Tag;
  Trx.Notes      := txtNotes.Text;
  Trx.Userid     := GlobalSystemUser.UserId;
  Trx.Subtotal   := StrFmtToFloatDef(txtSubtotal.Text,0);
  Trx.Biaya      := StrFmtToFloatDef(txtBiaya.Text,0);
  Trx.Tax        := StrFmtToFloatDef(txtTax.Text,0);
  Trx.Total      := StrFmtToFloatDef(txtTotal.Text,0);
  Trx.GudangID   := GlobalSystemConfig.localSetting.LocalGudang;
  for i:= 1 to grid.RowCount -1 do
    if (not IsClear(grid, colItemId, i)) and (grid.Ints[colModID, i] <> 0) then begin
      Trx.trsDetail.Add(
      grid.Ints[colID, i], lblTransaksi.Tag,0,
      grid.Ints[colItemId, i],
      grid.Ints[colConvId, i],
      ConvertToSaveConvertion(grid.Floats[colQty,i], grid.Floats[colConv,i]),
      grid.Floats[colHarga,i],
      grid.Floats[colTotal,i],
      grid.Floats[colConv, i], grid.Floats[colTax, i], grid.Floats[colDiscTmp, i],
      grid.Ints[colDiscIsPrc, i]);
    end;
  if (lblTransaksi.Tag = 0) then
    Result:= Trx.InsertOnDB()
  else Result:= Trx.UpdateOnDB();

  if Result then LoadData(Trx.ReturID);
  tbtSave.Enabled:= not Result;   
end;

function TfrmTrsRetur.isValid: boolean;
var i: integer; valid: boolean;
begin
  Result:= False; valid:= False;
  for i:= 1 to grid.RowCount-1 do begin
    valid:= not IsClear(grid, colItemId, i);
    if valid then Break;
  end;

     CekInput(Result, valid , 'Tidak ada item untuk disimpan.', grid)
end;

procedure TfrmTrsRetur.RemoveRow;
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

procedure TfrmTrsRetur.SeekItem(ASearch: string);
var id: integer; code: string;
begin
  code:= '';
  id:= frmLookup.ExecuteItem(0, txtSpec.Tag, 0);
  if Id > 0 then getItem(code, id, 1)
end;

procedure TfrmTrsRetur.SeekVendor;
var id: integer;
begin
  id:= frmLookup.Execute('SPL');
  if Id > 0 then getVendor('', id)
end;

procedure TfrmTrsRetur.SetDisableEnable;
begin
  tbtSave.Enabled:= (txtNotes.Tag=0) and (lblTransaksi.Tag=0);
  dtpTransaction.Enabled:= (txtNotes.Tag=0);

  txtNotes.Enabled:= (txtNotes.Tag = 0);
  tbtDelete.Enabled:= (txtNotes.Tag = 0);
  tbtPost.Enabled:= (txtNotes.Tag = 0) and (lblTransaksi.Tag<>0);
  tbtDelete.Enabled:= (txtNotes.Tag = 0);
  txtBiaya.ReadOnly:= (txtNotes.Tag <> 0);
  btnSpec.Enabled:= (txtNotes.Tag = 0);
  txtSpec.Enabled:= (txtNotes.Tag = 0);
end;

procedure TfrmTrsRetur.gridCanEditCell(Sender: TObject;
  ARow, ACol: Integer; var CanEdit: Boolean);
begin
  CanEdit:=
  (ACol in [colCode,colBarcode, colQty, colHarga]) and
  (txtNotes.Tag = 0);
end;

procedure TfrmTrsRetur.gridCellValidate(Sender: TObject;
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

        if grid.Ints[colDiscIsPrc, Row] = 1 then
        begin
          tmp:= grid.Cells[colDisc, Row];
          tmp_nilai:= StrFmtToFloatDef(Copy(tmp, 1, length(tmp)-1), 0);
          grid.Cells[colDiscTmp, Row]:=
            FloatToStrFmt(grid.Floats[colTotal, Row] * (tmp_nilai/100));
        end;

        if grid.Floats[colTax, Row] <> 0 then begin
          tmp_nilai:= FormatSQLRound2(
            (grid.Floats[colTotal, grid.Row] - grid.Floats[colDiscTmp, grid.Row]) * 0.1);
          grid.Cells[colTax, Row]:= FloatToStrFmt(tmp_nilai);
        end;

        Calculate;
        SavePostState(True);
        ArrangeColSize;
        grid.Ints[colModID, Row]:= 1;
        SavePostState(True);
      end;
    end;

    colDisc:
    begin
      Valid:= Value <> '';
      if Valid then begin
        tmp:= Copy(Value, length(Value), 1);
        if tmp = '%' then begin //status persentase
           tmp_nilai:= StrFmtToFloatDef(Copy(Value, 1, length(Value)-1), 0);
           tmp_nilai:= (grid.Floats[colTotal, Row] * (tmp_nilai/100));
           grid.Ints[colDiscIsPrc, Row]:= 1;
        end
        else begin
           tmp_nilai:= StrFmtToFloatDef(Value, 0);
           grid.Ints[colDiscIsPrc, Row]:= 0;
           Value:= FloatToStrFmt(StrToFloatDef(Value,0));
        end;
        grid.Floats[colDiscTmp, Row]:= tmp_nilai;

        if grid.Floats[colTax, Row] <> 0 then
          grid.Cells[colTax, Row]:=
            FloatToStrFmt(FormatSQLRound2(
              (StrFmtToFloatDef(grid.Cells[colTotal, Row], 0) - tmp_nilai) * 0.1));

        Calculate;
        grid.Ints[colModID, Row]:= 1;
        SavePostState(True);
      end;
    end;

  end;
end;

procedure TfrmTrsRetur.gridGetAlignment(Sender: TObject;
  ARow, ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  if (ACol in[colNo, colQty, colHarga, colTotal, colDisc, colTax]) then
    HAlign:= taRightJustify
end;

procedure TfrmTrsRetur.gridGetEditorType(Sender: TObject;
  ACol, ARow: Integer; var AEditor: TEditorType);
begin
  case ACol of
    colQty, colHarga, colDisc, colTax: AEditor:= edFloat;
  end;
end;

procedure TfrmTrsRetur.gridKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var value: string; jumlah: double; valid: boolean;
begin
  case key of
    VK_ADD   : getUnitList;
    VK_F2    :
    case grid.Col of
//    colFaktur: GetOrder;
      colCOde,colBarcode, colDesc: SeekItem(grid.Cells[grid.col, grid.Row]);
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

     VK_MULTIPLY:

       if grid.Col = colDisc then begin
          value:= FloatToStrFmt(StrFmtToFloatDef(grid.Cells[grid.Col, grid.Row],0)) + '%';
          grid.Cells[grid.Col, grid.Row]:= value;
       end

       else if grid.Col = colHarga then begin
         if grid.Ints[colTaxed, grid.Row] = 0 then begin
            grid.Ints[colTaxed, grid.Row]:= 1;
            jumlah:= grid.Floats[colHarga, grid.Row] / 1.1;
            value := FloatToStrFmt(jumlah);
            grid.Cells[grid.Col, grid.Row]:= value;
            grid.Cells[colTax, grid.Row]:= FloatToStrFmt(
                (StrFmtToFloatDef(grid.Cells[colTotal,grid.Row], 0) -
                StrFmtToFloatDef(grid.Cells[colDiscTmp, grid.Row], 0)) * 0.1);
         end
         else begin
            grid.Ints[colTaxed, grid.Row]:= 0;
            jumlah:= FormatSQLRound2(grid.Floats[colHarga, grid.Row] * 1.1);
            value := FloatToStrFmt(jumlah);
            grid.Cells[grid.Col, grid.Row]:= value;
            grid.Floats[colTax, grid.Row]:= 0;
         end;

         gridCellValidate(Sender, grid.Col, grid.Row, value, valid);
       end

       else if grid.Col = colTax then begin
          jumlah:= FormatSQLRound2((grid.Floats[colTotal, grid.Row] - grid.Floats[colDiscTmp, grid.Row]) * 0.1);
          grid.Cells[grid.Col, grid.Row]:= FloatToStrFmt(jumlah);
          Calculate();
       end;

    VK_NUMPAD0:
       if grid.Col = colTax then begin
          grid.Cells[grid.Col, grid.Row]:= '0';
          Calculate();
       end;

  end;
end;

procedure TfrmTrsRetur.gridKeyPress(Sender: TObject;
  var Key: Char);
begin
  case grid.Col of
    colQty: if key = #46 then key := #44;
  end;
end;

procedure TfrmTrsRetur.getUnitList;
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

procedure TfrmTrsRetur.getUnit(Sender: TObject);
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
        grid.Ints[colConvId, ARow]:= MstUnit.ConvId;
        grid.Cells[colUnit,  ARow]:= MstUnit.MstMaster.MstCode;
        grid.Cells[colHarga, ARow]:= FloatToStrFmt(MstUnit.PurchasePrice);
        grid.Cells[colConv,  ARow]:= FloatToStrFmt(MstUnit.Conversion);
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

procedure TfrmTrsRetur.txtSpecKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case key of
    VK_F2 : SeekVendor;
    VK_TAB:
      if txtSpec.Modified then
        getVendor(txtSpec.Text,0);
  end;
end;

procedure TfrmTrsRetur.txtSpecKeyPress(Sender: TObject;
  var Key: Char);
begin
//  if key <> #13 then txtSpec.Tag:= 0;
end;

procedure TfrmTrsRetur.btnSpecClick(Sender: TObject);
begin
  SeekVendor
end;

procedure TfrmTrsRetur.dtpExprKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  //if (key = vk_return) and (dtpDely.Enabled) then
   // dtpDely.SetFocus;
end;

procedure TfrmTrsRetur.dtpDelyKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (key = vk_return) and (txtNotes.Enabled) then
    txtNotes.SetFocus;
end;

procedure TfrmTrsRetur.dtpTransactionKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (key = vk_return) and (txtSpec.Enabled) then
    txtSpec.SetFocus;
end;

procedure TfrmTrsRetur.rdbTaxClick(Sender: TObject);
begin
//  Calculate;
  SavePostState(True);
end;

procedure TfrmTrsRetur.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_F3: txtSpec.SetFocus;
    VK_F4:
    begin
      grid.SetFocus;
      grid.Row:= 1;
      grid.Col:= colBarcode;
    end;
  end;
end;

procedure TfrmTrsRetur.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  if MstItem <> nil then MstItem.Free; MstItem:= nil;
  if Trx <> nil then Trx.Free; Trx:= nil;
  if ListUnit <> nil then ListUnit.Free; listUnit:= nil;
  if lsGudang <> nil then lsGudang.Free; lsGudang:= nil;
end;

procedure TfrmTrsRetur.LoadData(ID: integer);
var i: integer; detail: TMysqlResult; x: double;
begin
  if ID = 0 then exit;
  Trx.Clear;
  Trx.ReturID:= ID;
  Trx.SelectInDB;
  lblTransaksi.Caption:= Trx.TransNum;
  lblTransaksi.Tag:= Trx.ReturID;
  txtSpec.Tag:= Trx.RelationId;
  txtSpec.Text:= TMstRelation.GetName(Trx.RelationId);
  dtpTransaction.Date:= Trx.TransDate;


  txtNotes.Text:= Trx.Notes;
  txtNotes.Tag:= Trx.StatusId;

  txtSubtotal.Text:= FloatToStrFmt(Trx.Subtotal);
  txtBiaya.Text := FloatToStrFmt(Trx.Biaya);
  txtTax.Text := FloatToStrFmt(Trx.Tax);
  txtTotal.Text := FloatToStrFmt(Trx.Total);



  InitGrid;
  //0receipt_detail_id, 1item_id, 2conv_id, 3quantity,
  //4price, 5amount, 6conversion,
  //7item_name, 8barcode, 9satuan,
  //12disc, 13tax, 14disc_is_prc,15item_code


  detail:= Trx.SelectDetail(ID);
  detail.First;
  for i:= 1 to detail.RecordCount do begin
    grid.Ints[colNo,i ] := i;
    grid.Cells[colID,      i]:= detail.FieldValue(0);
//  grid.Cells[colFaktur,  i]:= detail.FieldValue(11);
//  grid.Cells[colFakturID,i]:= detail.FieldValue(10);
    grid.Cells[colItemId,  i]:= detail.FieldValue(1);
    grid.Cells[colConvId,  i]:= detail.FieldValue(2);
    grid.Cells[colcode, i]:= detail.FieldValue(15);
    grid.Cells[colBarcode, i]:= detail.FieldValue(8);
    grid.Cells[colDesc,    i]:= detail.FieldValue(7);
    grid.Cells[colUnit,    i]:= detail.FieldValue(9);
    grid.Cells[colQty,     i]:= FloatToStrFmt(BufferToFloat(detail.FieldValue(3)));
    grid.Cells[colHarga,   i]:= FloatToStrFmt(BufferToFloat(detail.FieldValue(4)));
    grid.Cells[colTotal,   i]:= FloatToStrFmt(BufferToFloat(detail.FieldValue(5)));
    grid.Cells[colConv,    i]:= FloatToStrFmt(BufferToFloat(detail.FieldValue(6)));
    grid.Cells[colDiscTmp, i]:= FloatToStrFmt(BufferToFloat(detail.FieldValue(12)));
    grid.Cells[colTax,     i]:= FloatToStrFmt(BufferToFloat(detail.FieldValue(13)));
    grid.Ints[colDiscIsPrc,i]:= BufferToInteger(detail.FieldValue(14));

    if (BufferToFloat(detail.FieldValue(13)) <> 0) then
      grid.Ints[colTaxed, i]:= 1
    else grid.Ints[colTaxed, i]:= 0;

    x:= IfThen(BufferToFloat(detail.FieldValue(5))=0,1,BufferToFloat(detail.FieldValue(5)));
    if BufferToInteger(detail.FieldValue(14)) = 1 then
       grid.Cells[colDisc, i]:= FloatToStrFmt(
       (BufferToFloat(detail.FieldValue(12)) * 100) / x)+'%'
    else grid.Cells[colDisc, i]:= FloatToStrFmt(BufferToFloat(detail.FieldValue(12)));

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

procedure TfrmTrsRetur.txtSubtotalValueValidate(Sender: TObject;
  value: String; var IsValid: Boolean);
begin
  AdvEdtFloatFmt(Sender, value);
end;

procedure TfrmTrsRetur.tbtDeleteClick(Sender: TObject);
begin
  RemoveRow
end;

procedure TfrmTrsRetur.tbtSaveClick(Sender: TObject);
begin
  if isValid then isSaved 
end;

procedure TfrmTrsRetur.tbtNewClick(Sender: TObject);
var tag : integer;
begin
  tag := 302;
//  Alert(IntToStr(AktiveControl.Tag));
if not TSystemAccess.isCan(CAN_ADD,tag) then exit;
  InitForm;
  SetDisableEnable;
  txtSpec.SetFocus
end;

procedure TfrmTrsRetur.txtDisc2KeyPress(Sender: TObject;
  var Key: Char);
begin
  if key = #46 then key := #44;
  IgnoreChar(Key);
end;

procedure TfrmTrsRetur.txtDisc2Exit(Sender: TObject);
begin
  Calculate;
end;

procedure TfrmTrsRetur.txtSpecEnter(Sender: TObject);
begin
  status_delete:= 1;
end;

procedure TfrmTrsRetur.gridEnter(Sender: TObject);
begin
  status_delete:= 2;
end;

procedure TfrmTrsRetur.tbtPostClick(Sender: TObject);
begin
  if TTrsRetur.PostTrans(lblTransaksi.Tag) then
    txtNotes.Tag:= 1;
  SetDisableEnable;
end;

procedure TfrmTrsRetur.dtpTransactionChange(Sender: TObject);
begin
  SavePostState(True);
end;

function TfrmTrsRetur.GetOrder(): boolean;
var i, row: integer; detail: TMysqlResult;
begin
  Result:= False;
  GlobalFilter.RelasiID:= txtSpec.Tag;
  row:= frmLookupTrx.ExecuteReceipt('RECEIPT');
  if row = 0 then exit;

  detail:= Trx.SelectFakturDetail(row);
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
    grid.Cells[colConvId,  row+i]:= detail.FieldValue(2);
    grid.Cells[colcode, row+i]:= detail.FieldValue(15);
    grid.Cells[colBarcode, row+i]:= detail.FieldValue(8);
    grid.Cells[colDesc,    row+i]:= detail.FieldValue(7);
    grid.Cells[colUnit,    row+i]:= detail.FieldValue(9);
    grid.Cells[colQty,     row+i]:= FloatToStrFmt(BufferToFloat(detail.FieldValue(3)));
    grid.Cells[colHarga,   row+i]:= FloatToStrFmt(BufferToFloat(detail.FieldValue(4)));
    grid.Cells[colTotal,   row+i]:= FloatToStrFmt(BufferToFloat(detail.FieldValue(5)));
    grid.Cells[colDisc,    row+i]:= FloatToStrFmt(BufferToFloat(detail.FieldValue(11)));
    grid.Cells[colTax,     row+i]:= FloatToStrFmt(BufferToFloat(detail.FieldValue(12)));
    grid.Ints[colDiscIsPrc,row+i]:= 0;
    grid.Cells[colConv,    row+i]:= FloatToStrFmt(BufferToFloat(detail.FieldValue(6)));
    grid.Ints[colModID,    row+i]:= 1;
    detail.MoveNext;
    grid.AddRow;
  end;
  detail.destroy;
  Calculate;
  //DeleteRowTerakhir(grid, 2, 1);
  ArrangeColSize;
end;

procedure TfrmTrsRetur.SavePostState(state: boolean);
begin
  tbtSave.Enabled:= state;
  if state then tbtPost.Enabled:= False; //ngahaja
end;

procedure TfrmTrsRetur.txtSpecChange(Sender: TObject);
var asalna_true: boolean;
begin
  asalna_true:= tbtSave.Enabled;
  if not asalna_true then
  SavePostState((Sender as TAdvEdit).Modified);
end;

procedure TfrmTrsRetur.txtTaxKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 case Key of
    VK_F3: txtSpec.SetFocus;
    VK_F4:
    begin
      grid.SetFocus;
      grid.Row:= 1;
      grid.Col:= colBarcode;
    end;
   
    VK_MULTIPLY: CalculateManualPPN;
    VK_NUMPAD0: CalculateBuangPPN;
    
  end;

end;

procedure TfrmTrsRetur.CalculateBuangPPN;
var total, disc2, addt: double;
begin
  total:= StrFmtToFloatDef(txtSubtotal.Text,0);
  total:= total - disc2;
  txtTax.Text:= FloatToStrFmt(0);
  txtTax.Tag:= 0;
  txtTotal.Text:= FloatToStrFmt(total+addt);
end;

procedure TfrmTrsRetur.CalculateManualPPN;
var total, disc2, addt: double;
begin
  total:= StrFmtToFloatDef(txtSubtotal.Text,0);
  total:= total - disc2;
  txtTax.Text:= FloatToStrFmt(total * 0.1);
  txtTax.Tag:= 1;
  txtTotal.Text:= FloatToStrFmt((total * 0.1) + total+addt);
end;

procedure TfrmTrsRetur.ToolButton1Click(Sender: TObject);
begin

//  Alert(MSG_UNDER_CONSTRUCTION);exit;
  if lblTransaksi.Tag <> 0 then begin
    if GlobalSystemConfig.localSetting.PrinterAdm <> '' then begin
       if (getDefaultPrinter <> GlobalSystemConfig.localSetting.PrinterAdm) then
           setDefaultPrinter(GlobalSystemConfig.localSetting.PrinterAdm);
    end;

    try
      printOrder(lblTransaksi.Tag);
     // Application.CreateForm(TqrpRetur, qrpRetur);
     // qrpRetur.Execute(lblTransaksi.Tag, grid);
    finally
     // qrpRetur.Destroy;
    end;

  {  RAWPrinter1.PrinterName:= GlobalSystemConfig.localSetting.PrinterAdm;
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
    RAWPrinter1.EndDoc;}
  end;
end;

procedure TfrmTrsRetur.gridSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
  if (ACol = colBarcode) then OldValue:= grid.Cells[ACol, ARow];

end;

function TfrmTrsRetur.printFooter(value: TStringList; idx,
  insIdx: integer): integer;
begin
 Result:= 1;
  value.Strings[insIdx]:=
      FixWidth(' ', 5, taLeftJustify) +
      FixWidth(GARIS2, PAPER_WIDTH-5, taCenter);

  value.Strings[insIdx+1]:=
    FixWidth(' ', 5, taLeftJustify) +
    FixWidth('Tgl Cetak : '+FormatDateTime('dd-MMM-yyyy', ServerNow)+
             ', Jam : '+FormatDateTime('hh:mm', ServerCurrDateTime), PAPER_WIDTH-18, taLeftJustify)+
    FixWidth('Halaman : '+IntToStr(idx), 13, taRightJustify);
end;

function TfrmTrsRetur.printHeader(value: TStringList;
  _buffer: TMysqlResult; hal: integer; onlyColumnHeader: boolean): integer;
var relation:TMstRelation; adaCustomer:boolean; 
begin
     Result:= 0;
  if hal > 1 then
  begin
    value.Append(' ');
    Result:= value.Count-1;

    value.Append(' ');
    value.Append(' ');
    value.Append(' ');
  end;

   {0(d.quantity), 1d.price, 2d.amount, 3i.item_name, '+
  '4t.trans_num, 5t.trans_date, 6t.total, 7t.subtotal, '+
  '8t.relation_id, 9now(), 10i.item_code,11d.disc,12retur_detail_id,13t.discount }

  //header;
   printBitmap(imgLogo.Picture.Bitmap,
      Bold('    RETUR PEMBELIAN'),RAWPrinter1,value);
 { value.Append(
    FixWidth(' ', 5, taLeftJustify)+
    FixWidth(CompanyProfile.FCompanyName, PAPER_WIDTH-5, taLeftJustify));}

if not onlyColumnHeader then begin
{    value.Append(
      FixWidth(' ', 5, taLeftJustify)+
      FixWidth(Bold('FAKTUR PENJUALAN & JASA'), PAPER_WIDTH , taCenter));
 }
      adaCustomer := BufferToInteger(_buffer.FieldValue(8))>0;
      relation := TMstRelation.Create;
      if adaCustomer then begin

        relation.RelationID :=BufferToInteger(_buffer.FieldValue(8));
        relation.SelectInDB
      end;
    value.Append(
      FixWidth(' ', 5, taLeftJustify)+
      FixWidth('Nomor Trx', 10, taLeftJustify) +
      FixWidth(': ', 2, taCenter)+
      FixWidth(BufferToString(_buffer.FieldValue(4)), 72, taLeftJustify)+
      IfThen(adaCustomer,
        FixWidth('Customer',10,taLeftJustify)+
        FixWidth(': ', 2, taCenter)+
        FixWidth(relation.RelationName,35,taLeftJustify),'')
    );

    value.Append(
        FixWidth(' ', 5, taLeftJustify)+
      FixWidth( 'Tanggal', 10, taLeftJustify) +
      FixWidth(': ', 2, taCenter)+
      FixWidth(FormatDateTime(ShortDateFormat,BufferToDateTime(_buffer.FieldValue(5))), 72, taLeftJustify)+
      IfThen(adaCustomer,
        FixWidth('Alamat',10,taLeftJustify)+
        FixWidth(': ', 2, taCenter)+
        FixWidth(relation.Address1,35,taLeftJustify),'')
      );

     if adaCustomer then begin
         value.Append(
           FixWidth(' ', 5, taLeftJustify)+
          FixWidth( 'Operator ', 10, taLeftJustify) +
          FixWidth(': ', 2, taCenter)+
          FixWidth(GlobalSystemUser.UserId, 72, taLeftJustify)+
          IfThen(adaCustomer,
            FixWidth('Telepon',10,taLeftJustify)+
            FixWidth(': ', 2, taCenter)+
            FixWidth(relation.Phone1,35,taLeftJustify),'')
          );



     end; 
               relation.Free;
  end;//;onlyColumnHeader

  value.Append(
    FixWidth(' ', 5, taLeftJustify) +
    FixWidth(GARIS, PAPER_WIDTH-5, taCenter));

  value.Append(
      FixWidth(' ', 5, taLeftJustify) +
      FixWidth('NO ', 5, taLeftJustify) +
      FixWidth('KODE', 6, taLeftJustify) +
      FixWidth('DESKRIPSI', PAPER_WIDTH - 77, taLeftJustify)+
      FixWidth('QUANTITY', 15, taRightJustify) +
      FixWidth('HARGA', 15, taRightJustify) +
      FixWidth('DISC(Rp)', 15, taRightJustify) +
      FixWidth('JUMLAH', 15, taRightJustify)); //+    FixWidth('KETERANGAN', 15, taRightJustify)

  value.Append(
    FixWidth(' ', 5, taLeftJustify) +
    FixWidth(GARIS, PAPER_WIDTH-5, taCenter));

end;

procedure TfrmTrsRetur.printOrder(ID: integer);
var i: integer; ls: TStringList;
   buffer: TMysqlResult;

   insertedIdx, rowCount, range,
   halaman, footer_printed: integer;

const
  max_row       = 40;
  title_count   = 8;
  summery_count = 6;
  footer_count  = 2;

begin
  ls:= TStringList.Create;

  buffer:=  TTrsRetur.printRetur(ID);

 
   {0(d.quantity), 1d.price, 2d.amount, 3i.item_name, '+
  '4t.trans_num, 5t.trans_date, 6t.total, 7t.subtotal, '+
  '8t.relation_id, 9now(), 10i.item_code,11d.disc,12retur_detail_id,13t.discount }
  if buffer.RecordCount > 0 then begin
    halaman:= 1;
    rowCount:= 1;
    footer_printed:= 0;
    insertedIdx:= 0;
    range:= 0;

    for i:= 1 to buffer.RecordCount do  begin
      if ((rowCount = 1) or (rowCount = max_row)) then
      begin

        insertedIdx:= printHeader(ls, buffer, halaman,(halaman>1));

        if halaman > 1
        then footer_printed:= footer_printed + printFooter(ls, halaman-1, insertedIdx);

        rowCount:= title_count;
        Inc(halaman);
      end;
      Inc(rowCount);

       ls.Append(
        FixWidth(' ', 5, taLeftJustify) +
        FixWidth(IntToStr(i), 5, taLeftJustify) +
        FixWidth(BufferToString(buffer.FieldValue(10)), 6, taLeftJustify) + //kode
        FixWidth(BufferToString(buffer.FieldValue(3)), PAPER_WIDTH - 77, taLeftJustify)+ //nama
        FixWidth(
        FormatFloat('#,##0', BufferToFloat(buffer.FieldValue(0))), 15, taRightJustify) +  //quantity
//         FixWidth(BufferToString(buffer.FieldValue(9)), 10, taRightJustify) +
        FixWidth(FormatFloat('#,##0.#0', BufferToFloat(buffer.FieldValue(1))), 15, taRightJustify) +//harga
        FixWidth(FormatFloat('#,##0.#0', BufferToFloat(buffer.FieldValue(11))), 15, taRightJustify) +//discount
        FixWidth(FormatFloat('#,##0.#0', BufferToFloat(buffer.FieldValue(2))), 15, taRightJustify));//amount
//         FixWidth(BufferToString(buffer.Fields[9].Value), 15, taLeftJustify) );

      buffer.MoveNext;
    end;

    buffer.First;

    ls.Append(
      FixWidth(' ', 5, taLeftJustify) +
      FixWidth(GARIS, PAPER_WIDTH-5, taCenter));

    ls.Append(
      FixWidth(' ', 5, taLeftJustify) +
      FixWidth(' ', 20, taCenter)+ {+
      FixWidth('DISERAHKAN', 20, taCenter) +
      FixWidth('DISETUJUI', 20, taCenter) +
      FixWidth('DICETAK :', 20, taCenter)}


      FixWidth('TOTAL', PAPER_WIDTH - 52, taRightJustify) +
      FixWidth(' :', 2, taLeftJustify) +                          //17
      FixWidth(FormatFloat('#,##0.#0', BufferToFloat(buffer.FieldValue(6))), 25, taRightJustify));

       ls.Append(' ');
        ls.Append(' ');
{   ls.Append(
     FixWidth(' ', 5, taLeftJustify) +
      FixWidth(' ', 20, taCenter)+
      FixWidth('DISCOUNT', PAPER_WIDTH - 52, taRightJustify) +
      FixWidth(' :', 2, taLeftJustify) +
      FixWidth(FormatFloat('#,##0.#0', BufferToFloat(buffer.FieldValue(13))), 25, taRightJustify));




    ls.Append(
      FixWidth(' ', 5, taLeftJustify) +
      FixWidth(' ', 20, taCenter)+
      FixWidth('TOTAL', PAPER_WIDTH - 52, taRightJustify) +
      FixWidth(' :', 2, taLeftJustify) +
      FixWidth(FormatFloat('#,##0.#0', BufferToFloat(buffer.FieldValue(6))), 25, taRightJustify));

 }

    if ((insertedIdx = 0) or (halaman-1 > footer_printed)) then
    begin
      ls.Append(' ');
      ls.Append(' ');
      ls.Append(' ');
      insertedIdx:= ls.Count-2;
      //rowCount:= ls.Count-(summery_count+footer_count);
    //  for i:= 1 to range  do ls.insert(rowCount,' ');
      printFooter(ls, halaman-1, insertedIdx);
    end;

    if (rowCount+summery_count+footer_count) < (max_row+footer_count)
    then range:= (max_row+footer_count) - (rowCount+summery_count+footer_count);

    rowCount:= ls.Count-(summery_count+footer_count);
   
   if ((halaman-1)=1) then
    for i:= 1 to range
    do ls.Insert(rowCount+1,' ');

  end;

  for i := 0 to 3 do
    ls.Append('    ');//+IntToStr(i+1));
 //chan  RAWPrinter1.PrinterName:= GlobalSystemConfig.localSetting.PrinterAdm;

//chan  RawPrintPreview.PreviewOnly('Faktur Jual', ls.Text);
try
    RAWPrinter1.PageHeight := 999999;
    RAWPrinter1.DocumentTitle := Application.Title;
    RAWPrinter1.EjectOnFinish := false;
    RAWPrinter1.CommandType := rpcEpson;
    RAWPrinter1.FontName := rfnSanserif;
    RAWPrinter1.FontPitch := rfpExpanded; //rfpCondensed;
    RAWPrinter1.LeftMargin := 0;
   // rw.PageWidth := 34;
    RAWPrinter1.PrintingMode := rpmText;
    RAWPrinter1.TopMargin := 0;
   // rawPrinter.begindoc;
   // s := #27 + 'U0' + #27'C'#1#27 + '2' + #27'l' + #0;
  //  rawPrinter.WriteToPrinter(s, length(s));
  //  rawPrinter.EndDoc;
//    RAWPrintPreview.PreviewOnly();
    RAWPrinter1.BeginDoc;
    RAWPrinter1.WriteList(ls, True);
    RAWPrinter1.EndDoc;

  finally
    //RAWPrinter1.Free;
    ls.Free;
  end;

end;

end.
