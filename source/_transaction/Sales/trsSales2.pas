unit trsSales2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, BaseGrid, AdvGrid, StdCtrls, AdvEdit, ComCtrls,
  SUIImagePanel, ToolWin, ExtCtrls,
  strUtils, Math, UMaster, UTransaction, Menus,
  frmDockForm, RAWPrinter;

type
  TfrmTrsSales2 = class(TDockForm)
    ToolBar1: TToolBar;
    tbtNew: TToolButton;
    tbtSave: TToolButton;
    ToolButton5: TToolButton;
    tbtDelete: TToolButton;
    suiPanel1: TsuiPanel;
    lblTransaksi: TLabel;
    dtpTransaction: TDateTimePicker;
    txtSpec: TAdvEdit;
    btnSpec: TButton;
    suiPanel3: TsuiPanel;
    grid: TAdvStringGrid;
    txtSubtotal: TAdvEdit;
    txtTax: TAdvEdit;
    txtTotal: TAdvEdit;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    txtDisc: TAdvEdit;
    Label2: TLabel;
    txtDiscRp: TAdvEdit;
    RAWPrinter1: TRAWPrinter;
    txtResep: TAdvEdit;
    txtPasien: TAdvEdit;
    txtDokter: TAdvEdit;
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
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure getUnitList;
    procedure getUnit(Sender: TObject);
    procedure txtSubtotalValueValidate(Sender: TObject; value: String;
      var IsValid: Boolean);
    procedure tbtDeleteClick(Sender: TObject);
    procedure tbtSaveClick(Sender: TObject);
    procedure tbtNewClick(Sender: TObject);
    procedure txtDiscKeyPress(Sender: TObject; var Key: Char);
    procedure txtSpecEnter(Sender: TObject);
    procedure gridEnter(Sender: TObject);
    procedure dtpTransactionChange(Sender: TObject);
    procedure txtNotesChange(Sender: TObject);
    procedure gridRowChanging(Sender: TObject; OldRow, NewRow: Integer;
      var Allow: Boolean);
    procedure txtDisc1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure txtTaxKeyPress(Sender: TObject; var Key: Char);
    procedure txtDiscExit(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure gridSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
  private
    MstItem: TMstItem;
    Sales: TTrsSales;
    ListUnit: TStringList;
    status_delete: word;
    OldValue: string;

    procedure InitGrid;
    procedure InitForm;
    procedure SetDisableEnable;
    procedure Calculate(xRow: integer);
    procedure RemoveRow();
    procedure SavePostState(state: boolean);

//    procedure SeekItem(ASearch: string);
//    procedure getItem(var AItemCode: string; AItemID, isPaket: integer; AQty: double);

    procedure SeekVendor;
    procedure getVendor(ACode: string; AID: integer);
    procedure LoadData(ID: integer);
    procedure PrintFaktur();
    procedure PrintFakturBig();
    function isValid: boolean;
    function isSaved: boolean;
  public
    procedure Execute(vPurpose, ID: integer); override;
  end;

var
  frmTrsSales2: TfrmTrsSales2;

implementation

uses MainMenu, UConst, Subroutines, MySQLConnector,
  LookupData, uMysqlClient, UQueryPackage, EpsonUtils,
  AutoStockLine;

const
  colNo          = 0;
  colBarcode     = 1;
  colDesc        = 2;
  colQty         = 3;
  colUnit        = 4;
  colBonus       = 5;
  colSatBonus    = 6;
  colHarga       = 7;
  colDisc        = 8;  //disc %
  colDiscRp      = 9;  //disc rp
  colTotal       = 10;
  colConv        = 11;
  colConvBonus   = 12;
  colItemId      = 13;
  colConvId      = 14;
  colConvBonusId = 15;
  colModID       = 17;
  colID          = 18;
  colDasar       = 19;
  colProfit      = 20;
  colPoint       = 21;
  colIsPaket     = 22;

{$R *.dfm}

{ TfrmTrsPurchaseOrder }

procedure TfrmTrsSales2.Calculate(xRow: integer);
var total, disDetRp, disDetPrc,
  disTotal, disTotalVal, tax: double;
begin
  total := grid.Floats[colQty,  xRow] * grid.Floats[colHarga, xRow];

  disDetRp := grid.Floats[colDiscRp, xrow];
  disDetPrc:= grid.Floats[colDisc, xrow];
  disDetPrc:= total * (disDetPrc/100);

  total:= total - disDetRp - disDetPrc;
  grid.Cells[colTotal, xrow]:= FloatToStrFmt(total);

//langsung dikaIikan
  grid.Floats[colProfit, xRow]:= total -
    (grid.Floats[colQty, xRow] * grid.Floats[colDasar, xRow]);

//header
  total:= grid.ColumnSum(colTotal, 1, grid.RowCount-1);

  txtSubtotal.Text:= FloatToStrFmt(total, True);

//recalculate after ApplliedProdukTotal
  total:= StrFmtToFloatDef(txtSubtotal.Text,0, True); //%
  txtSubtotal.Text:= FloatToStrFmt(total, True);
  disTotalVal:= StrFmtToFloatDef(txtDiscRp.Text,0); //rp
  disTotal:= StrFmtToFloatDef(txtDisc.Text,0); //%
  disTotal:= (disTotal/100) * total;
  total:= total - disTotal - disTotalVal;

  tax:= StrFmtToFloatDef(txtTax.Text,0);
  tax:= (tax/100) * (total);
  total:= total + tax;
  txtTotal.Text:= FloatToStrFmt(total, true);

end;

procedure TfrmTrsSales2.Execute(vPurpose, ID: integer);
begin
  inherited;
  ToolBar1.ParentColor:= false;
  ToolBar1.Color:= clWhite;
  ListUnit:= TStringList.Create;

  MstItem  := TMstItem.Create;
  status_delete:= 0;
  Sales := TTrsSales.Create;
  InitForm;
  LoadData(ID);
  Run(Self);
end;

{procedure TfrmTrsSales2.getItem(var AItemCode: string; AItemID, isPaket: integer;
  AQty: double);
var ItemCode: string; sameID, row:integer;

  function search_same_item(existID, isPaket: integer): integer;
  var i: integer;
  begin
    Result:= 0;
    for i:= 1 to grid.RowCount-1 do
      if (grid.Ints[colItemID, i] = existID) and (grid.Ints[colIsPaket, i] = isPaket) then begin
        Result:= i;
        exit;
      end;
  end;

begin
  MstItem.Reset;
  MstItem.Barcode:= AItemCode;
  MstItem.ItemId := AItemID;
  MstItem.VendorID := txtSpec.Tag;
  MstItem.Konsinyasi := isPaket;
  row:= grid.Row;
  if MstItem.SelectBOS then begin
     ItemCode:= MstItem.Barcode;
     sameID:= search_same_item(MstItem.ItemId, MstItem.Konsinyasi);
     if (sameID <> 0) and (row <> sameID) then begin
        AItemCode:= '';
        grid.ClearRows(grid.Row,1);
        grid.Row:= sameID;
        row:= sameID;
        grid.Cells[colQty, row]:= FloatToStrFmt(grid.Floats[colQty, row] + AQty);
        Calculate(row);
     end else begin

       AItemCode:= MstItem.Barcode;
       grid.Cells[colDesc,    row]:= MstItem.StrukName;
       grid.Cells[colBarcode, row]:= ItemCode;
       grid.Ints[colItemId,   row]:= MstItem.ItemId;
       grid.Ints[colIsPaket,  row]:= MstItem.Konsinyasi;
       grid.Ints[colConvId,   row]:= MstItem.FItemConversion[0].ConvId;
       grid.Cells[colUnit,    row]:= MstItem.FItemConversion[0].MstMaster.MstCode;
       grid.Cells[colHarga,   row]:= FloatToStrFmt(MstItem.FItemConversion[0].SalesPrice);
       {if CheckBox1.Checked = false then
       case cmbHarga.ItemIndex of
         0: grid.Cells[colHarga, row]:= FloatToStrFmt(MstItem.FItemConversion[0].PurchasePrice);
         1: grid.Cells[colHarga, row]:= FloatToStrFmt(MstItem.FItemConversion[0].SalesPrice);
         2: grid.Cells[colHarga, row]:= FloatToStrFmt(MstItem.FItemConversion[0].SalesPrice2);
       end;}
{       grid.Cells[colConv,    row]:= FloatToStrFmt(MstItem.FItemConversion[0].Conversion);
       grid.Cells[colDasar,   row]:= FloatToStrFmt(MstItem.AvgPrice);
       grid.Cells[colQty,     row]:= FloatToStrFmt(AQty);
       grid.Ints[colModID,    row]:= 1;
       grid.Cells[colTotal,   row]:= FloatToStrFmt(MstItem.FItemConversion[0].PurchasePrice * AQty);
       grid.Row:= row;
       grid.Col:= colQty;
       Calculate(row);
     end;
  end
  else begin
    Inform('Item tidak ditemukan.');
    grid.Col:= colBarcode;
    grid.Row:= row;
  end;
end;
}
procedure TfrmTrsSales2.getVendor(ACode: string; AID: integer);
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
  Data.Free;
end;

procedure TfrmTrsSales2.InitForm;
begin
  InitGrid;
  lblTransaksi.Caption:= '[Nomor Transaksi]';

  lblTransaksi.Tag:= 0;
  txtSpec.Tag:= 0;
  txtSpec.Clear;
  txtSubtotal.Clear;
  txtDisc.Clear;
  txtTax.Clear;
  txtTax.Clear;
  txtTotal.Clear;
  SetDisableEnable;
  dtpTransaction.Date:= ServerNow;
end;

procedure TfrmTrsSales2.InitGrid;
begin
  ResetGrid(grid, 2, 23, 1,1,-1);
  grid.AutoSizeColumns(true, 5);
  grid.AutoSizeRows(true, 3);
  grid.ColWidths[colItemId]:= 0;
  grid.ColWidths[colConvId]:= 0;
  grid.ColWidths[colConv]:= 0;
  grid.ColWidths[colModID]:= 0;
  grid.ColWidths[colID]:= 0;
  grid.ColWidths[colConvBonus]:= 0;
  grid.ColWidths[colConvBonusId]:= 0;

  grid.ColWidths[colDasar]:= 0;
  grid.ColWidths[colProfit]:= 0;
  grid.ColWidths[colPoint]:= 0;
  grid.ColWidths[colIsPaket]:= 0;
  
  grid.ColWidths[colNo]:= 18;
  grid.ColWidths[colBarcode]:= 90;
  grid.ColWidths[colQty     ]:= 45;
  grid.ColWidths[colUnit    ]:= 40;
  grid.ColWidths[colBonus   ]:= 0;
  grid.ColWidths[colSatBonus]:= 0;
  grid.ColWidths[colHarga   ]:= 55;
  grid.ColWidths[colTotal   ]:= 75;
  grid.ColWidths[colDisc    ]:= 55;
  grid.ColWidths[colDiscRp  ]:= 55;
  grid.RowHeights[1]:= grid.DefaultRowHeight;
end;

function TfrmTrsSales2.isSaved: boolean;
//var i: integer; DiscDetail: double;
begin
  {Sales.Clear;
  Sales.SalesMst.SalesId   := lblTransaksi.Tag;
  Sales.SalesMst.TransDate := ServerNow;
  Sales.SalesMst.TransType := SALES_TYPE_BOS;
  Sales.SalesMst.Subtotal  := StrFmtToFloatDef(txtSubtotal.Text,0, True);
  Sales.SalesMst.DiscMst   := StrFmtToFloatDef(txtDisc.Text,0);
  Sales.SalesMst.DiscValMst:= StrFmtToFloatDef(txtDiscRp.Text,0);
  Sales.SalesMst.Tax       := StrFmtToFloatDef(txtTax.Text,0);
  Sales.SalesMst.Total     := StrFmtToFloatDef(txtTotal.Text,0, True);
  Sales.SalesMst.RealAmount:= 0;
  Sales.SalesMst.CashierId := GlobalSystemConfig.localSetting.Machine;
  Sales.SalesMst.Cash      := 0;
  Sales.SalesMst.UserId    := GlobalSystemUser.UserId;

  Sales.SalesMst.PasienID:= txtSpec.Tag;
  Sales.SalesMst.GudangID  := GlobalSystemConfig.localSetting.LocalGudang;;
  Sales.SalesMst.profit    := grid.ColumnSum(colProfit, 1, grid.RowCount-1);
  Sales.SalesMst.profit    :=
  (Sales.SalesMst.profit - Sales.SalesMst.DiscValMst) -
  (Sales.SalesMst.Subtotal * (Sales.SalesMst.DiscMst /100));

  DiscDetail:= 0;
  for i:= 1 to grid.RowCount - 1 do
    if not IsClear(grid, colItemId, i) then begin
      Sales.SalesDetail_Arr.Add(0, lblTransaksi.Tag,
      IfThen(grid.Ints[colIsPaket,i]=0, grid.Ints[colItemId, i], 0),
      IfThen(grid.Ints[colIsPaket,i]=0, grid.Ints[colConvId, i], 0),
      ConvertToSaveConvertion(grid.Floats[colQty,i], grid.Floats[colConv,i]),
      //ConvertToLoadConvertion(grid.Floats[colHarga,i], grid.Floats[colConv,i]),
      grid.Floats[colHarga,i],
      grid.Floats[colDisc, i], grid.Floats[colDiscRp, i],
      grid.Floats[colTotal,i], grid.Floats[colConv, i],
      grid.Floats[colDasar, i], grid.Floats[colProfit, i],
      grid.Ints[colPoint, i],
      IfThen(grid.Ints[colIsPaket,i]=1, grid.Ints[colItemId, i], 0),
      grid.Ints[colConvBonusId,i],
      ConvertToSaveConvertion(grid.Floats[colBonus,i], grid.Floats[colConvBonus,i]),
      grid.Floats[colConv, i]);
      DiscDetail:= DiscDetail + grid.Floats[colDiscRp, i] +
      ((grid.Floats[colDisc, i] /100) * (grid.Floats[colQty,i] * grid.Floats[colHarga,i]));
    end;

  Sales.SalesMst.DiscDetail:= DiscDetail;

  if (lblTransaksi.Tag = 0) then
    Result:= Sales.InsertCreditOnDB()
  else Result:= false;

  if Result then LoadData(Sales.SalesMst.SalesID);
  tbtSave.Enabled:= not Result;

  lblTransaksi.Caption:= Sales.SalesMst.TransNum;
  lblTransaksi.Tag := Sales.SalesMst.SalesId; }
  Result:= False;
end;

function TfrmTrsSales2.isValid: boolean;
var i: integer; valid: boolean;
begin

  Result:= False; valid:= False;
  for i:= 1 to grid.RowCount-1 do begin
    valid:= not IsClear(grid, colItemId, i);
    if valid then Break;
  end;
  CekInput(Result, valid , 'Tidak ada item untuk disimpan.', grid)
end;

procedure TfrmTrsSales2.RemoveRow;
begin
  case lblTransaksi.Tag of
    0:begin
        grid.ClearRows(grid.Row, 1);
        if grid.RowCount > 2 then
        grid.RemoveRows(grid.Row, 1);
      end
    else
      case status_delete of
        1: if Confirmed('Hapus penerimaan barang?') then
             if TTrsSales.DeleteTrans(lblTransaksi.Tag) then
                InitForm;
        2: if Confirmed('Hapus baris?') then
             if TTrsSales.DeleteDetail(grid.Ints[colId, grid.Row]) then begin
                grid.ClearRows(grid.Row, 1);
                if grid.RowCount > 2 then
                   grid.RemoveRows(grid.Row, 1);
             end;
      end;
   end;
end;

{procedure TfrmTrsSales2.SeekItem(ASearch: string);
var id: integer; code: string;
begin
  if lblTransaksi.Tag <> 0 then exit;
  code:= '';
  id:= frmLookup.ExecuteItem(0, txtSpec.Tag, 0);
  if Id > 0 then getItem(code, id, 0, 1)
end;
 }
procedure TfrmTrsSales2.SeekVendor;
var id: integer;
begin
  if not btnSpec.Enabled then Exit;
  id:= frmLookup.Execute('CUST');
  if Id > 0 then getVendor('', id)
end;

procedure TfrmTrsSales2.SetDisableEnable;
begin
  tbtSave.Enabled:= (lblTransaksi.Tag=0);
  dtpTransaction.Enabled:= (lblTransaksi.Tag=0);
  tbtDelete.Enabled:= (lblTransaksi.Tag = 0);
  tbtDelete.Enabled:= (lblTransaksi.Tag = 0);
  txtDisc.ReadOnly:= (lblTransaksi.Tag <> 0);
  btnSpec.Enabled:= (lblTransaksi.Tag = 0);
  txtSpec.Enabled:= (lblTransaksi.Tag = 0);
end;

procedure TfrmTrsSales2.gridCanEditCell(Sender: TObject;
  ARow, ACol: Integer; var CanEdit: Boolean);
begin
{  CanEdit:=
  (ACol in [colBarcode, colQty, colBonus, colHarga, colDisc, colDiscRp]) and
  (lblTransaksi.Tag = 0);}
end;

procedure TfrmTrsSales2.gridCellValidate(Sender: TObject;
  Col, Row: Integer; var Value: String; var Valid: Boolean);
var tmp_nilai: double;
begin
  case Col of
    colBarcode:
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
        grid.Cells[colTotal, Row]:= FloatToStrFmt(
          StrFmtToFloatDef(grid.Cells[colQty, Row], 0) *
          StrFmtToFloatDef(grid.Cells[colHarga,Row], 0));

        Calculate(Row);
        Value:= FloatToStrFmt(StrToFloatDef(Value,0));
        grid.Ints[colModID, Row]:= 1;
        SavePostState(True);
      end;
    end;

    colDisc, colDiscRp:
    begin
      tmp_nilai:= StrFmtToFloatDef(Value,0);
      Calculate(Row);
      Value:= FloatToStrFmt(tmp_nilai);
      grid.Ints[colModID, Row]:= 1;
      SavePostState(True);
    end;
  end;
end;

procedure TfrmTrsSales2.gridGetAlignment(Sender: TObject;
  ARow, ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  if (ACol in[colNo, colQty, colHarga, colBonus,colTotal, colDisc, colDiscRp]) then
    HAlign:= taRightJustify
end;

procedure TfrmTrsSales2.gridGetEditorType(Sender: TObject;
  ACol, ARow: Integer; var AEditor: TEditorType);
begin
  case ACol of
    colQty, colHarga, colDisc, colDiscRp: AEditor:= edFloat;
  end;
end;

procedure TfrmTrsSales2.gridKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
//var value: string; //jumlah: double; valid: boolean;
begin
{  case key of
    VK_ADD   : getUnitList;
    VK_F2    : SeekItem(grid.Cells[colBarcode, grid.Row]);

    VK_RETURN:
    begin
      if (grid.Col = colBarcode) and (grid.Ints[colModID, grid.Row] = 1) then begin
         value:= grid.Cells[colBarcode, grid.Row];
         if oldValue <> value then
            getItem(value, 0, -1, 1);
      end;
      GoNextColumn(Sender);
    end;

    VK_F3: txtSpec.SetFocus;
    VK_F4:
    begin
      grid.SetFocus;
      grid.Row:= 1;
      grid.Col:= colBarcode;
    end;

    VK_F5: txtDisc.SetFocus;
  end;}
end;

procedure TfrmTrsSales2.gridKeyPress(Sender: TObject;
  var Key: Char);
begin
  case grid.Col of
    colQty, colDisc, colDiscRp: if key = #46 then key := #44;
  end;
end;

procedure TfrmTrsSales2.getUnitList;
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

procedure TfrmTrsSales2.getUnit(Sender: TObject);
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
        grid.Cells[colConv,  ARow]:= FloatToStrFmt(MstUnit.Conversion);
        grid.Ints[colConvId, ARow]:= MstUnit.ConvId;
        grid.Cells[colUnit,  ARow]:= MstUnit.MstMaster.MstCode;
        grid.Ints[colModID,  ARow]:= 1;
        {if CheckBox1.Checked = false then
        case cmbHarga.ItemIndex of
           0: grid.Cells[colHarga, ARow]:= FloatToStrFmt(MstUnit.PurchasePrice);
           1: grid.Cells[colHarga, ARow]:= FloatToStrFmt(MstUnit.SalesPrice);
           2: grid.Cells[colHarga, ARow]:= FloatToStrFmt(MstUnit.SalesPrice2);
         end;
         }
        grid.Cells[colTotal, ARow]:=
          FloatToStrFmt(
          StrFmtToFloatDef(grid.Cells[colHarga, ARow],0) *
          StrFmtToFloatDef(grid.Cells[colQty, ARow],0));
        Calculate(ARow);
      end;
      MstUnit.Free;
    end;

    colBonus:
    begin
      ARow:= grid.Row;
      MstUnit:=TMstItemConversion.Create;
      MstUnit.Reset;
      MstUnit.ConvId:= (Sender as TMenuItem).Tag;
      if MstUnit.SelectInDB then begin
        grid.Ints[colConvBonusId, ARow]:= MstUnit.ConvId;
        grid.Cells[colSatBonus,  ARow]:= MstUnit.MstMaster.MstCode;
        grid.Cells[colConvBonus,  ARow]:= FloatToStrFmt(MstUnit.Conversion);
      end;
      MstUnit.Free;
    end;
  end;
end;

procedure TfrmTrsSales2.txtSpecKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case key of
    VK_F2 : SeekVendor;
    VK_TAB:
      if txtSpec.Modified then
        getVendor(txtSpec.Text,0);
  end;
end;

procedure TfrmTrsSales2.txtSpecKeyPress(Sender: TObject;
  var Key: Char);
begin
//  if key <> #13 then txtSpec.Tag:= 0;
end;

procedure TfrmTrsSales2.btnSpecClick(Sender: TObject);
begin
  SeekVendor
end;

procedure TfrmTrsSales2.dtpExprKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  //if (key = vk_return) and (dtpDely.Enabled) then
   // dtpDely.SetFocus;
end;

procedure TfrmTrsSales2.dtpDelyKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (key = vk_return) and (lblTransaksi.Enabled) then
    txtSpec.SetFocus;
end;

procedure TfrmTrsSales2.dtpTransactionKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (key = vk_return) and (txtSpec.Enabled) then
    txtSpec.SetFocus;
end;

procedure TfrmTrsSales2.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  if MstItem <> nil then MstItem.Free; MstItem:= nil;
  if Sales <> nil then Sales.Free; Sales:= nil;
  if ListUnit <> nil then ListUnit.Free; listUnit:= nil;
end;

procedure TfrmTrsSales2.LoadData(ID: integer);
var i: integer;
begin
  if ID = 0 then exit;

  Sales.Clear;
  Sales.SalesMst.SalesID:= ID;
  Sales.SelectInDB;
  lblTransaksi.Caption:= Sales.SalesMst.TransNum;
  lblTransaksi.Tag:= Sales.SalesMst.SalesID;
  txtSpec.Tag:= Sales.SalesMst.PasienID;
  txtSpec.Text:= TMstRelation.GetName(Sales.SalesMst.PasienID);
  dtpTransaction.Date:= Sales.SalesMst.TransDate;

  txtSubtotal.Text:= FloatToStrFmt(Sales.SalesMst.Subtotal);
  txtDisc.Text    := FloatToStrFmt(Sales.SalesMst.DiscMst);
  txtDiscRp.Text  := FloatToStrFmt(Sales.SalesMst.DiscValMst);
  txtTax.Text     := FloatToStrFmt(Sales.SalesMst.Embalase);
  txtTotal.Text   := FloatToStrFmt(Sales.SalesMst.Total);
  txtResep.Text   := Sales.SalesMst.NoResep;
  txtDokter.Text  := TMstDokter.GetName(Sales.SalesMst.DokterID);
  txtPasien.Text  := TMstPasien.GetName(Sales.SalesMst.PasienID);

  InitGrid;
  for i:= 0 to Sales.SalesDetail_Arr.Count-1 do begin
    grid.Ints[colID,      i+1]:= Sales.SalesDetail_Arr[i].SalesDetailID;
    grid.Ints[colModID,   i+1]:= 0;
    grid.Ints[colItemId,  i+1]:= Sales.SalesDetail_Arr[i].MstItem.ItemID;
    grid.Ints[colConvId,  i+1]:= Sales.SalesDetail_Arr[i].MstItemConversion.ConvID;
    grid.Ints[colConvBonusId,i+1]:= Sales.SalesDetail_Arr[i].ConvBonusID;
    grid.Ints[colIsPaket,  i+1]:= Sales.SalesDetail_Arr[i].PaketID;
    grid.Ints[colPoint,    i+1]:= Sales.SalesDetail_Arr[i].Points;

    grid.Cells[colBarcode, i+1]:= Sales.SalesDetail_Arr[i].MstItem.Barcode;
    grid.Cells[colDesc,    i+1]:= Sales.SalesDetail_Arr[i].MstItem.ItemName;
    grid.Cells[colUnit,    i+1]:= Sales.SalesDetail_Arr[i].MstItemConversion.MstMaster.MstCode;
    grid.Cells[colSatBonus,i+1]:= '';//detail.FieldValue(16);
    grid.Cells[colQty,     i+1]:= FloatToStrFmt(Sales.SalesDetail_Arr[i].Quantity);
    grid.Cells[colBonus,   i+1]:= FloatToStrFmt(Sales.SalesDetail_Arr[i].QtyBonus);
    grid.Cells[colHarga,   i+1]:= FloatToStrFmt(Sales.SalesDetail_Arr[i].Price);
    grid.Cells[colTotal,   i+1]:= FloatToStrFmt(Sales.SalesDetail_Arr[i].Amount);
    grid.Cells[colConv,    i+1]:= FloatToStrFmt(Sales.SalesDetail_Arr[i].Conversion);
    grid.Cells[colConvBonus,i+1]:= FloatToStrFmt(Sales.SalesDetail_Arr[i].ConvBonus);

    grid.Floats[colDisc,   i+1]:= Sales.SalesDetail_Arr[i].Disc;
    grid.Floats[colDiscRp, i+1]:= Sales.SalesDetail_Arr[i].DiscVal;
    grid.Floats[colDasar,  i+1]:= Sales.SalesDetail_Arr[i].PricePurchase;
    grid.Floats[colProfit, i+1]:= Sales.SalesDetail_Arr[i].AmountProfit;
    grid.AddRow;
  end;
  DeleteRowTerakhir(grid, 2, 1);
  SetDisableEnable;
end;

procedure TfrmTrsSales2.txtSubtotalValueValidate(Sender: TObject;
  value: String; var IsValid: Boolean);
begin
  AdvEdtFloatFmt(Sender, value);
end;

procedure TfrmTrsSales2.tbtDeleteClick(Sender: TObject);
begin
  RemoveRow
end;

procedure TfrmTrsSales2.tbtSaveClick(Sender: TObject);
begin
  if isValid then isSaved 
end;

procedure TfrmTrsSales2.tbtNewClick(Sender: TObject);
begin
  InitForm;
  SetDisableEnable;
  txtSpec.SetFocus
end;

procedure TfrmTrsSales2.txtDiscKeyPress(Sender: TObject;
  var Key: Char);
begin
  if key = #46 then key := #44;
  IgnoreChar(Key);
end;

procedure TfrmTrsSales2.txtSpecEnter(Sender: TObject);
begin
  status_delete:= 1;
end;

procedure TfrmTrsSales2.gridEnter(Sender: TObject);
begin
  status_delete:= 2;
end;

procedure TfrmTrsSales2.dtpTransactionChange(Sender: TObject);
begin
  SavePostState(True);
end;

procedure TfrmTrsSales2.txtNotesChange(Sender: TObject);
var asalna_true: boolean;
begin
  asalna_true:= tbtSave.Enabled;
  if not asalna_true then
  SavePostState((Sender as TAdvEdit).Modified);
end;

procedure TfrmTrsSales2.SavePostState(state: boolean);
begin
  tbtSave.Enabled:= state;
end;

procedure TfrmTrsSales2.gridRowChanging(Sender: TObject; OldRow,
  NewRow: Integer; var Allow: Boolean);
begin
  if OldRow <= grid.RowCount-1 then
  grid.RowHeights[OldRow]:= grid.DefaultRowHeight;
  grid.AutoSizeRow(NewRow);
  if grid.RowHeights[NewRow] < grid.DefaultRowHeight then
    grid.RowHeights[NewRow]:= grid.DefaultRowHeight;
end;

procedure TfrmTrsSales2.txtDisc1KeyDown(Sender: TObject; var Key: Word;
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
    VK_F5: txtDisc.SetFocus;

  end;  
end;

procedure TfrmTrsSales2.txtTaxKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #46 then key := #44;
  IgnoreChar(Key);
end;

procedure TfrmTrsSales2.txtDiscExit(Sender: TObject);
begin
  Calculate(1);
end;

procedure TfrmTrsSales2.PrintFaktur;
//var i, x, jmlPoint: integer; data: TMysqlResult;
begin
{
  data:= OpenSQL(
  'select (d.quantity / d.conversion) as qty, round(d.price * d.conversion) as price, '+
  'd.amount, i.struk_name, d.disc, d.disc_val, '+
  't.trans_num, t.trans_date, t.total, t.cash, (t.cash - t.total) as cash_back, '+
  't.subtotal, t.disc_mst, t.disc_val_mst, t.tax, t.points, d.sales_detail_id, '+
  '(select mst_code from mst_master u, mst_item_conversion c '+
   'where c.unit_id = u.mst_id and c.conv_id = d.conv_id) as sat '+
  'from trs_sales_mst t, trs_sales_detail d, mst_item i '+
  'where d.sales_id = t.sales_id and d.item_id = i.item_id and d.item_id is not null '+
  'and t.sales_id = '+formatsqlnumber(lblTransaksi.Tag)+
  ' union '+
  'select (d.quantity / d.conversion) as qty, round(d.price * d.conversion) as price, '+
  'd.amount, i.nama_struk as struk_name, d.disc, d.disc_val, '+
  't.trans_num, t.trans_date, t.total, t.cash, (t.cash - t.total) as cash_back, '+
  't.subtotal, t.disc_mst, t.disc_val_mst, t.tax, t.points, d.sales_detail_id, '+
  '(select mst_code from mst_master u where u.mst_id = i.unit_id) as sat '+
  'from trs_sales_mst t, trs_sales_detail d, mst_paket i '+
  'where d.sales_id = t.sales_id and d.paket_id = i.paket_id and d.paket_id is not null '+
  'and t.sales_id = '+formatsqlnumber(lblTransaksi.Tag)+
   ' order by sales_detail_id');

  GlobalStringList.Clear;
  GlobalStringList.Append(FixWidth(CompanyProfile.FCompanyName, 40, taCenter));
  GlobalStringList.Append(FixWidth(CompanyProfile.FAddress, 40, taCenter));
  GlobalStringList.Append(FixWidth(CompanyProfile.FTelp1, 40, taCenter));
  GlobalStringList.Append(FixWidth(CompanyProfile.FCity, 40, taCenter));
  GlobalStringList.Append(FixWidth(' ', 40, taCenter));

  GlobalStringList.Append(
    FixWidth(BufferToString(data.FieldValue(6)) , 30, taLeftJustify) +
    FixWidth(FormatDateTime('dd/MM/yyyy', BufferToDateTime(data.FieldValue(7))), 10, taRightJustify));

  GlobalStringList.Append(
    FixWidth('Kasir : '+GlobalSystemUser.UserId, 30, taLeftJustify));

  GlobalStringList.Append(FixWidth('-----------------------------------------',40, taLeftJustify));

  for i := 0 to data.RecordCount-1 do begin
    with GlobalStringList do begin
      Append(FixWidth(BufferToString(data.FieldValue(3)),40, taLeftJustify));

    //kasus normal
      if((BufferToFloat(data.FieldValue(4)) = 0) and (BufferToFloat(data.FieldValue(5)) = 0)) then
        Append(
          FixWidth(
            FormatFloat('#,##0.##', BufferToFloat(data.FieldValue(0)))+' '+
            data.FieldValue(17), 12, taRightJustify)+
          FixWidth(' X ', 3, taLeftJustify) +
          FixWidth(FormatFloat('#,##0', BufferToFloat(data.FieldValue(1))), 12, taRightJustify)+
          FixWidth(FormatFloat('#,##0', BufferToFloat(data.FieldValue(2))), 13, taRightJustify))

    //kasus ada 1 discont
      else if((BufferToFloat(data.FieldValue(4)) <> 0) or (BufferToFloat(data.FieldValue(5)) <> 0)) then
        Append(
          FixWidth(
            FormatFloat('#,##0.##', BufferToFloat(data.FieldValue(0)))+' '+
              data.FieldValue(17), 9, taRightJustify)+
          FixWidth(' X', 2, taLeftJustify) +
          FixWidth(FormatFloat('#,##0', BufferToFloat(data.FieldValue(1))), 9, taRightJustify)+
          IfThen(BufferToFloat(data.FieldValue(4)) <> 0,
          FixWidth(' -'+FormatFloat('#,##0.##', BufferToFloat(data.FieldValue(4)))+'%', 9, taRightJustify))+
          IfThen(BufferToFloat(data.FieldValue(5)) <> 0,
          FixWidth(' -'+FormatFloat('#,##0.##', BufferToFloat(data.FieldValue(5))), 9, taRightJustify))+
          FixWidth(FormatFloat('#,##0', BufferToFloat(data.FieldValue(2))), 10, taRightJustify))

    //kasus ada 2 discont
      else if((BufferToFloat(data.FieldValue(4)) <> 0) and (BufferToFloat(data.FieldValue(5)) <> 0)) then begin
        Append(
          FixWidth(
            FormatFloat('#,##0.##', BufferToFloat(data.FieldValue(0)))+' '+
              data.FieldValue(17), 10, taRightJustify) +
          FixWidth(' X ', 3, taLeftJustify) +
          FixWidth(FormatFloat('#,##0', BufferToFloat(data.FieldValue(1))), 9, taRightJustify)+
          IfThen(BufferToFloat(data.FieldValue(4)) <> 0,
          FixWidth(' -'+FormatFloat('#,##0.##', BufferToFloat(data.FieldValue(4)))+'%', 8, taRightJustify))+
          IfThen(BufferToFloat(data.FieldValue(5)) <> 0,
          FixWidth(' -'+FormatFloat('#,##0.##', BufferToFloat(data.FieldValue(5))), 10, taRightJustify)));
        Append(FixWidth(FormatFloat('#,##0', BufferToFloat(data.FieldValue(2))), 40, taRightJustify));
      end;
      
    end;
    data.MoveNext;
  end;
  data.First;

  //0qty, 1price, 2amount, 3struk_name, 4disc, 5disc_val,
  //6trans_num, 7trans_date, 8total, 9cash, 10cash_back,
  //11subtotal, 12disc_mst, 13disc_val_mst, 14tax

  GlobalStringList.Append(FixWidth('-----------------------------------------',40, taLeftJustify));
  GlobalStringList.Append(
    FixWidth('Subtotal', 14, taLeftJustify) +
    FixWidth(':', 2, taLeftJustify) +
    FixWidth(FormatFloat('#,##0', BufferToFloat(data.FieldValue(11))) ,24, taRightJustify));

  if (BufferToFloat(data.FieldValue(12)) > 0) then
  GlobalStringList.Append(
    FixWidth('Discount %', 14, taLeftJustify) +
    FixWidth(':', 2, taLeftJustify) +
    FixWidth(FormatFloat('#,##0', BufferToFloat(data.FieldValue(12))), 24, taRightJustify));

  if (BufferToFloat(data.FieldValue(13)) > 0) then
  GlobalStringList.Append(
    FixWidth('Discount Rp', 14, taLeftJustify) +
    FixWidth(':', 2, taLeftJustify) +
    FixWidth(FormatFloat('#,##0', BufferToFloat(data.FieldValue(13))), 24, taRightJustify));

  if (BufferToFloat(data.FieldValue(14)) > 0) then
  GlobalStringList.Append(
    FixWidth('PPN %', 14, taLeftJustify) +
    FixWidth(':', 2, taLeftJustify) +
    FixWidth(FormatFloat('#,##0', BufferToFloat(data.FieldValue(14))), 24, taRightJustify));

  GlobalStringList.Append(
    FixWidth('Grand Total', 14, taLeftJustify) +
    FixWidth(':', 2, taLeftJustify) +
    FixWidth(FormatFloat('#,##0', BufferToFloat(data.FieldValue(8))), 24, taRightJustify));

  GlobalStringList.Append(
    FixWidth('Tunai', 14, taLeftJustify) +
    FixWidth(':', 2, taLeftJustify) +
    FixWidth(FormatFloat('#,##0', BufferToFloat(data.FieldValue(9))), 24, taRightJustify));

  GlobalStringList.Append(
    FixWidth('Kembali', 14, taLeftJustify) +
    FixWidth(':', 2, taLeftJustify) +
    FixWidth(FormatFloat('#,##0', BufferToFloat(data.FieldValue(10))),24, taRightJustify));

  data.destroy;
  GlobalStringList.Append('');

  if GlobalSystemConfig[CONF_FOOTER1-1].ConfValue <> '' then
    GlobalStringList.Append(FixWidth(GlobalSystemConfig[CONF_FOOTER1-1].ConfValue, 40, taCenter));
  if GlobalSystemConfig[CONF_FOOTER2-1].ConfValue <> '' then
    GlobalStringList.Append(FixWidth(GlobalSystemConfig[CONF_FOOTER2-1].ConfValue, 40, taCenter));

  x:= GlobalSystemConfig.localSetting.MarginBottom;
  for i:= 1 to x do
    GlobalStringList.Append(' ');

  jmlPoint:= BufferToInteger(data.FieldValue(10));

  if jmlPoint <> 0 then begin
    GlobalStringList.Append(escCRLF);
    if txtSpec.Tag <> 0 then begin
       GlobalStringList.Append(
       FixWidth('CUSTOMER', 10, taLeftJustify) +
         FixWidth(':', 2, taLeftJustify) +
         FixWidth(TMstRelation.GetName(txtSpec.Tag),28, taLeftJustify));
    end;
    GlobalStringList.Append(
      FixWidth('Jml Point', 10, taLeftJustify) +
      FixWidth(':', 2, taLeftJustify) +
      FixWidth(FloatToStrFmt(jmlPoint),28, taLeftJustify));

    GlobalStringList.Append(FixWidth('**catatan**',40, taCenter));
  end;

  try
  //printing struk...
    RAWPrintPreview.PrintRawDocument(Application.Title, GlobalStringList.Text);

     GlobalStringList.Clear;
  //cutting paper...
    if (GlobalSystemConfig.localSetting.CutterCode <> '') then
  ///    SendEscapeCode();
      GlobalStringList.Append(GlobalSystemConfig.localSetting.CutterCode);
    
    RAWPrintPreview.PrintRawDocument('', GlobalStringList.Text);

    except raise;
      Inform('Printer tidak terpasang.');
  end;
  }
end;

procedure TfrmTrsSales2.ToolButton1Click(Sender: TObject);
begin
  PrintFaktur;
  PrintFakturBig;
end;

procedure TfrmTrsSales2.PrintFakturBig;
//var i, page, curr_page, range: integer; ls: TStringList; sum: double;

{const
  PAPER_WIDTH  = 80;
  ROW_PER_PAGE = 29;
  ROW_FOOTER   = 5;
  GARIS        =
  '----------------------------------------'+
  '----------------------------------------';
 }
begin
{
  page:= 0;
  curr_page:= 0;

  ls:= TStringList.Create;

  ls.Clear;
  ls.Append(FixWidth(CompanyProfile.FCompanyName, (PAPER_WIDTH), taLeftJustify));

  ls.Append(FixWidth(CompanyProfile.FAddress, PAPER_WIDTH, taLeftJustify));
  ls.Append(FixWidth(CompanyProfile.FCity+' '+CompanyProfile.FPostCode, PAPER_WIDTH, taLeftJustify));
  ls.Append(FixWidth('Phone/Fax: '+
    CompanyProfile.FTelp1+IfThen(CompanyProfile.FFax<>'', '/')+CompanyProfile.FFax, PAPER_WIDTH, taLeftJustify));
  ls.Append(FixWidth(GARIS, PAPER_WIDTH, taCenter));

//data register
  ls.Append(
    FixWidth('No CM', 7, taLeftJustify)+
    FixWidth(':', 2, taLeftJustify)+
    FixWidth(txtMedrek.Text, PAPER_WIDTH - (9 + 29), taLeftJustify)+

    FixWidth('No TRX', 7, taLeftJustify)+
    FixWidth(':', 2, taLeftJustify)+
    FixWidth(lblTrx.Caption, 20, taRightJustify));

  ls.Append(
    FixWidth('Status', 7, taLeftJustify)+
    FixWidth(':', 2, taLeftJustify)+
    FixWidth(txtJenis.Text, PAPER_WIDTH - (9 + 29), taLeftJustify)+

    FixWidth('TGL', 7, taLeftJustify)+
    FixWidth(':', 2, taLeftJustify)+
    FixWidth(FormatDateTime('dd/MM/yyyy', ServerNow), 20, taRightJustify));

  ls.Append(
    FixWidth('Nama', 7, taLeftJustify)+
    FixWidth(':', 2, taLeftJustify)+
    FixWidth(txtNama.Text, PAPER_WIDTH - (9 + 29), taLeftJustify)+

    FixWidth('POLI', 7, taLeftJustify)+
    FixWidth(':', 2, taLeftJustify)+
    FixWidth(txtPoly.Text, 20, taRightJustify));

  ls.Append(
    FixWidth('Alamat', 7, taLeftJustify)+
    FixWidth(':', 2, taLeftJustify)+
    FixWidth(txtAlamat.Text, PAPER_WIDTH - 9, taLeftJustify));
//end data register

//header
  ls.Append(FixWidth(GARIS, PAPER_WIDTH, taCenter));
  ls.Append(
    FixWidth('No', 3, taRightJustify) + FixWidth(' ', 1, taRightJustify)+ //4
    FixWidth('Uraian', (PAPER_WIDTH - 5 - 12) , taLeftJustify)+ FixWidth(' ', 1, taLeftJustify)+
    FixWidth('Subtotal', 12, taRightJustify));
  ls.Append(FixWidth(GARIS, PAPER_WIDTH, taCenter));
//end header

//item
  sum:= 0;
  for i:= 0 to asgDaftar.RowCount-1 do
  if asgDaftar.Cells[1, i] <> '' then begin
    if (asgDaftar.Ints[colTipe, i] = TRANS_TINDAK) then begin
      ls.Append(
      FixWidth(IntToStr(i), 3, taRightJustify)+FixWidth(' ', 1, taRightJustify)+
      FixWidth(asgDaftar.Cells[colTindak, i], (PAPER_WIDTH - 5 - 12), taLeftJustify)+FixWidth(' ', 1, taRightJustify)+
      FixWidth(asgDaftar.Cells[colBA, i], 12, taRightJustify));
      sum:= sum + asgDaftar.Floats[colBA, i];
    end;

  //print at new form
    if (i < asgDaftar.RowCount-1) then page:= (i) div ROW_PER_PAGE;
    if page <> curr_page then begin
      ls.Append(#10);
      ls.Append(#10);
      curr_page:= page;
    end;
  end;
  ls.Append(FixWidth(GARIS, PAPER_WIDTH, taCenter));
//end item

  ls.Append(
    FixWidth(' ', 4, taRightJustify)+
    FixWidth('Total :', (PAPER_WIDTH - 5 - 12), taLeftJustify)+
    FixWidth(FloatToStrFmt(sum), 12, taRightJustify));

//set the footer position must be at the end of the page
  if ((ls.Count + ROW_FOOTER - (page*2)) <= ROW_PER_PAGE) then
    range:= ROW_PER_PAGE - (ls.Count + ROW_FOOTER - (page*2))
  else range:= ROW_PER_PAGE - ((ls.Count + ROW_FOOTER - (page*2)) mod ROW_PER_PAGE);

  for i:= 1 to range do ls.Append(' ');

//set the footer value
  ls.Append(
     FixWidth(CompanyProfile.FCity+'. '+
     FormatDateTime('dd MMM yyyy', ServerNow), PAPER_WIDTH, taRightJustify));
  ls.Append(' ');
  ls.Append(' ');

  ls.Append(FixWidth('( '+GlobalSystemUser.UserName+' )    ', PAPER_WIDTH, taRightJustify));
  ls.Append(FixWidth('KASIR       ', PAPER_WIDTH, taRightJustify));

//prepare for new printing
  ls.Append(#10);
  ls.Append(#10);
  RAWPrinter1.PrinterName:= GlobalSystemConfig.localSetting.PrinterStruk;
  RAWPrinter1.DocumentTitle:= 'Bill Tindakan';
  RAWPrinter1.BeginDoc;
  RAWPrinter1.WriteStr(ls.Text);
  RAWPrinter1.EndDoc;
                 }
{  if GlobalSystemConfig.localSetting.PrinterAdm <> '' then begin
     if (getDefaultPrinter <> GlobalSystemConfig.localSetting.PrinterAdm) then
         setDefaultPrinter(GlobalSystemConfig.localSetting.PrinterAdm);
  end;}
  {
  try
      Application.CreateForm(TqrpSalesStrukBig, qrpSalesStrukBig);
      qrpSalesStrukBig.Executes(lblTransaksi.Tag);
      RAWPrinter1.PrinterName:= GlobalSystemConfig.localSetting.PrinterAdm;
      RAWPrinter1.DocumentTitle:= '';
      RAWPrinter1.BeginDoc;
      RAWPrinter1.WriteStr(escCRLF);
      RAWPrinter1.WriteStr(escCRLF);
      RAWPrinter1.WriteStr(escCRLF);
      RAWPrinter1.WriteStr(escCRLF);
      RAWPrinter1.WriteStr(escCRLF);
      RAWPrinter1.WriteStr(escCRLF);
      RAWPrinter1.WriteStr(escCRLF);
      RAWPrinter1.WriteStr(escCRLF);
      RAWPrinter1.WriteStr(escCRLF);
      RAWPrinter1.WriteStr(escCRLF);
      RAWPrinter1.WriteStr(escCRLF);
      RAWPrinter1.EndDoc;
   finally
     qrpSalesStrukBig.Destroy;
   end;
   }
end;

procedure TfrmTrsSales2.gridSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if (ACol = colBarcode) then OldValue:= grid.Cells[ACol, ARow];
end;

end.
