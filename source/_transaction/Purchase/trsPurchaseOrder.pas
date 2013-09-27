unit trsPurchaseOrder;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, BaseGrid, AdvGrid, StdCtrls, AdvEdit, ComCtrls,
  SUIImagePanel, ToolWin, ExtCtrls,uMysqlClient,
  strUtils, Math, UMaster, UTransaction, Menus,
  frmDockForm, RAWPrinter, trsReceipt;

type
  TfrmTrsPurchaseOrder = class(TDockForm)
    ToolBar1: TToolBar;
    tbtNew: TToolButton;
    tbtSave: TToolButton;
    ToolButton5: TToolButton;
    tbtDelete: TToolButton;
    suiPanel1: TsuiPanel;
    lblTransaksi: TLabel;
    dtpTransaction: TDateTimePicker;
    txtNotes: TAdvEdit;
    txtSpec: TAdvEdit;
    btnSpec: TButton;
    suiPanel3: TsuiPanel;
    grid: TAdvStringGrid;
    dtpExpr: TDateTimePicker;
    Label1: TLabel;
    dtpDely: TDateTimePicker;
    txtSubtotal: TAdvEdit;
    txtDisc1: TAdvEdit;
    txtDPP: TAdvEdit;
    txtTax: TAdvEdit;
    txtTotal: TAdvEdit;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    tbtPost: TToolButton;
    RAWPrinter1: TRAWPrinter;
    txtTerm: TAdvEdit;
    imgLogo: TImage;
    chkPpn: TCheckBox;
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
    procedure ToolButton1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure txtSpecChange(Sender: TObject);
    procedure gridRowChanging(Sender: TObject; OldRow, NewRow: Integer;
      var Allow: Boolean);
    procedure txtDisc2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CheckBox1Click(Sender: TObject);
    procedure gridSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure gridDblClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure chkPpnClick(Sender: TObject);

  private
    MstItem: TMstItem;
    Order: TTrsOrder;
    ListUnit: TStringList;
    status_delete: word;
    OldValue: string;
    procedure InitGrid;
    procedure InitForm;
    procedure SetDisableEnable;
    procedure CalculateManualPPN();
    procedure CalculateBuangPPN();
    procedure Calculate();
    procedure RemoveRow();

    procedure SavePostState(state: boolean);
    procedure SeekItem(ASearch: string);
    procedure LoadItem();
    procedure getItem(var AItemCode: string; AItemID: integer; AQty: double);

    procedure SeekVendor;
    procedure getVendor(ACode: string; AID: integer);
    procedure LoadData(ID: integer);

//    procedure editItem();

    function isValid: boolean;
    function isSaved: boolean;
    procedure PrintRaw();
    procedure printOrder(ID: integer);
    function  printHeader(value: TStringList; _buffer: TMysqlResult; hal: integer;onlyColumnHeader:boolean=false): integer;
    function  printFooter(value: TStringList; idx, insIdx: integer): integer;
  public
    procedure Execute(vPurpose, ID: integer); override;
  end;

var
  frmTrsPurchaseOrder: TfrmTrsPurchaseOrder;

implementation

uses MainMenu, UConst, Subroutines, MySQLConnector,
  LookupData, PurchaseOrderPrint,  EpsonUtils, MstItem,
  AutoStockLine, UConstTool;

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
  colCode     = 1;
  colBarcode  = 2;
  colDesc     = 3;
  colStok     = 4;
  colQty      = 5;
  colUnit     = 6;
  colHarga    = 7;
  colTotal    = 8;
  colDisc     = 9;
  colTax      =10;
  colConv     = 11;
  colItemId   = 12;
  colConvId   = 13;
  colModID    = 14;
  colID       = 15;
  colDiscIsPrc= 16;
  colDiscTmp  = 17;
  colTaxed    = 18; // needed by colHarga, menentukan udah termasuk ppn/belum
  colMasterAdaTax = 19;

{$R *.dfm}

{ TfrmTrsPurchaseOrder }

procedure TfrmTrsPurchaseOrder.Calculate;
var
  total,
  dpp, dis_tax, dis_nontax{, tax}: double;
  i: integer;
begin
  total := 0;
  for i:= 1 to grid.RowCount-1 do
    total:= total + StrFmtToFloatDef(grid.Cells[colTotal, i],0);


  for i:= 1 to grid.RowCount-1 do
      if grid.Floats[colTax, i] = 0 then
         dis_nontax:= dis_nontax + grid.Floats[colDiscTmp, i];

  dpp:= 0;
  for i:= 1 to grid.RowCount-1 do
      if (grid.Floats[colTax, i] <> 0) then
         dpp:= dpp + grid.Floats[colTotal, i];

  //txtTax.Text:= FloatToStrFmt(FormatSQLRound2(dpp * 0.1));
  txtTax.Text:= FloatToStrFmt(FormatSQLRound2(IfThen(chkPpn.Checked, total,0) * 0.1));

  txtSubtotal.Text:= FloatToStrFmt(total);
  txtDisc1.Text   := FloatToStrFmt(dis_tax + dis_nontax);
  txtTotal.Text   := FloatToStrFmt(total-dis_tax-dis_nontax + FormatSQLRound2(dpp * 0.1));
end;

procedure TfrmTrsPurchaseOrder.Execute(vPurpose, ID: integer);
begin
  inherited;
  ToolBar1.ParentColor:= false;
  ToolBar1.Color:= clWhite;

  ListUnit:= TStringList.Create;
  MstItem  := TMstItem.Create;
  status_delete:= 0;
  Order := TTrsOrder.Create;
  InitForm;
  LoadData(ID);
  Run(Self);
end;

procedure TfrmTrsPurchaseOrder.getItem(var AItemCode: string; AItemID: integer;
  AQty: double);
var
  qty, ItemCodeTmp: string; row, sameID: integer; valid: boolean;

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
  MstItem.Barcode := AItemCode;
  MstItem.ItemId  := AItemID;
  MstItem.VendorID:= txtSpec.Tag;
  row:= grid.Row;
  if MstItem.SelectInDB3 then begin
    ItemCodeTmp:= MstItem.Barcode;
    sameID:= search_same_item(MstItem.ItemId);
    if (sameID <> 0) and (row <> sameID) then begin
       AItemCode:= '';
       grid.ClearRows(grid.Row,1);
       grid.Row:= sameID;
       row:= sameID;

       grid.Cells[colQty, row]:= FloatToStrFmt(grid.Floats[colQty, row] + AQty);
       //Calculate;
    end else begin

      AItemCode:= ItemCodeTmp;
      grid.Cells[colDesc,    row]:= MstItem.ItemName;
      grid.Cells[colCode, row]:= MstItem.ItemCode;
      grid.Cells[colBarcode, row]:= MstItem.Barcode;
      grid.Ints[colItemId,   row]:= MstItem.ItemId;
      grid.Ints[colModId,    row]:= 1;
      grid.Ints[colConvId,   row]:= 0;//MstItem.FItemConversion[0].ConvId;
      grid.Cells[colUnit,    row]:= TMstMaster.getKode(MstItem.KemasanID);// MstItem.FItemConversion[0].MstMaster.MstCode;
      grid.Cells[colHarga,   row]:= FloatToStrFmt(MstItem.BuyingPrice);
//      grid.Cells[colDiscTmp, row]:= FloatToStrFmt(MstItem.FItemConversion[0].ItemDiscount);
      grid.Cells[colConv,    row]:= '1';//FloatToStrFmt(MstItem.FItemConversion[0].Conversion);
      grid.Cells[colQty,     row]:= FloatToStrFmt(AQty);
      grid.Cells[colstok,    row]:= FloatToStrFmt(round(MstItem.CurrentStock));//TMstItemConversion.GetStockDescription(MstItem.ItemId, round(MstItem.CurrentStock));

      //grid.Ints[colDiscIsPrc, row]:= MstItem.FItemConversion[0].DiscTipe;

      {if MstItem.FItemConversion[0].DiscTipe = 1 then
        grid.Cells[colDisc,   row]:= FloatToStrFmt(
         (MstItem.FItemConversion[0].ItemDiscount * 100) / MstItem.FItemConversion[0].PurchasePrice)+'%'
      else grid.Cells[colDisc, row]:= FloatToStrFmt(MstItem.FItemConversion[0].ItemDiscount);

      if (MstItem.FItemConversion[0].ItemTax <> 0) then begin
         grid.Ints[colTaxed, row]:= 1;
         grid.Ints[colMasterAdaTax, row]:= 1;
      end
      else begin
        grid.Ints[colTaxed, row]:= 0;
        grid.Ints[colMasterAdaTax, row]:= 0;
      end;}
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
end;

procedure TfrmTrsPurchaseOrder.getVendor(ACode: string; AID: integer);
var Data: TMstRelation;
begin
  Data:= TMstRelation.Create();
  Data.Reset;
  Data.RelationCode:= ACode;
  Data.RelationId := AID;

  if Data.SelectInDB then begin
    txtSpec.Tag := Data.RelationId;
    txtSpec.Text:= Data.RelationName +' ('+Data.RelationCode+')';
    txtTerm.IntValue:= Data.DueDate;

    //LoadItem;
    txtNotes.SetFocus;
    SavePostState(True);
  end
  else begin
    Inform('Supplier tidak ditemukan.');
    txtSpec.Clear;
    txtSpec.SetFocus;
  end;
  //txtSubtotal.SetFocus;
  Data.Free;
end;

procedure TfrmTrsPurchaseOrder.InitForm;
begin
  InitGrid;
  lblTransaksi.Caption:= '[Nomor Transaksi]';
  lblTransaksi.Tag:= 0;
  txtNotes.Tag:= 0;
  txtSpec.Tag:= 0;
  txtNotes.Clear;
  txtSpec.Clear;
  txtSubtotal.Clear;
  txtDisc1.Clear;
  txtDPP.Clear;
  txtTax.Clear;
  txtTotal.Clear;
  SetDisableEnable;
  dtpTransaction.Date:= ServerNow;
  dtpExpr.Date:= ServerNow;
  dtpDely.Date:= ServerNow;
  txtTerm.IntValue:= 0;
end;

procedure TfrmTrsPurchaseOrder.InitGrid;
begin
  ResetGrid(grid, 2, 20,1, 1,-1);
  grid.AutoSizeColumns(true, 5);
  grid.AutoSizeRows(true, 3);
  grid.ColWidths[colItemId]:= 0;
  grid.ColWidths[colConvId]:= 0;
  grid.ColWidths[colConv]:= 0;
  grid.ColWidths[colModID]:= 0;
  grid.ColWidths[colID]:= 0;
  grid.ColWidths[colDiscIsPrc]:= 0;
  grid.ColWidths[colDiscTmp]:= 0;
  grid.ColWidths[colTaxed]:= 0;
  grid.ColWidths[colTax]:= 0;
  grid.ColWidths[colMasterAdaTax]:= 0;

  grid.ColWidths[colNo]:= 18;
  grid.ColWidths[colcode]:= 60;
  grid.ColWidths[colBarcode]:= 90;
  grid.ColWidths[colStok   ]:= 60;
  grid.ColWidths[colQty    ]:= 45;
  grid.ColWidths[colUnit   ]:= 45;
  grid.ColWidths[colHarga  ]:= 65;
  grid.ColWidths[colTotal  ]:= 90;
  grid.ColWidths[colDisc   ]:= 70;
  grid.ColWidths[colTax    ]:= 0;//60
   
  grid.RowHeights[1]:= grid.DefaultRowHeight;
  grid.RowHeights[0]:= grid.DefaultRowHeight;
end;

function TfrmTrsPurchaseOrder.isSaved: boolean;
var i: integer;
begin
  Order.Clear;
  Order.OrderMst.OrderId     := lblTransaksi.Tag;
  Order.OrderMst.TransType   := ORDER_TYPE_NON_TAX;//IfThen(rdbTax.Checked, ORDER_TYPE_TAX, ORDER_TYPE_NON_TAX);
  Order.OrderMst.TransDate   := dtpTransaction.Date;
  Order.OrderMst.ExprDate    := dtpExpr.Date;
  Order.OrderMst.DeliveryDate:= dtpDely.Date;
  Order.OrderMst.MstRelation.RelationId:= txtSpec.Tag;
  Order.OrderMst.Notes      := txtNotes.Text;
  Order.OrderMst.Userid     := GlobalSystemUser.UserId;
  Order.OrderMst.Subtotal   := StrFmtToFloatDef(txtSubtotal.Text,0);
  Order.OrderMst.DiscDetail := StrFmtToFloatDef(txtDisc1.Text,0);
  Order.OrderMst.Tax        := StrFmtToFloatDef(txtTax.Text,0);
  Order.OrderMst.Total      := StrFmtToFloatDef(txtTotal.Text,0);
  Order.OrderMst.PayTerm    := txtTerm.IntValue;

  for i:= 1 to grid.RowCount - 1 do
    if (not IsClear(grid, colItemId, i)) and (grid.Ints[colModID, i] <> 0) {and (grid.Floats[colQty, i] <> 0)} then begin
      Order.OrderDetail_Arr.Add(
      grid.Ints[colID, i],lblTransaksi.Tag,
      grid.Ints[colItemId,i],
      grid.Ints[colConvId,i],
      ConvertToSaveConvertion(grid.Floats[colQty,i], grid.Floats[colConv,i]),
      grid.Floats[colHarga,i],
      grid.Floats[colDiscTmp, i],
      grid.Floats[colTotal,i],
      grid.Floats[colConv,i],
      grid.Floats[colTax,i],
      grid.Ints[colDiscIsPrc,i]);
    end;

  if (lblTransaksi.Tag = 0) then
    Result:= Order.InsertOnDB()
  else Result:= Order.UpdateOnDB();

  if Result then LoadData(Order.OrderMst.OrderId);
  tbtSave.Enabled:= not Result;
  tbtPost.Enabled:= Result;
end;

function TfrmTrsPurchaseOrder.isValid: boolean;

 function cek_data: boolean;
 var i: integer;
 begin
  Result:= False;
  for i:= 1 to grid.RowCount-1 do begin
    result:= not IsClear(grid, colItemId, i);
    if Result then
       Exit;
  end;

end;

begin
//  if CekInput(Result, dtpDely.Date >= dtpTransaction.Date, 'Tgl kirim < tgl PO.', dtpDely) then
  //  if CekInput(Result, trunc(dtpExpr.Date) >= trunc(dtpTransaction.Date), 'Tgl jth tempo < tgl PO.', dtpExpr) then
    if CekInput(Result,txtSpec.Tag<>0,'Supplier belum ditentukan',txtSpec) then
         CekInput(Result, cek_data, 'Tidak ada item untuk disimpan.', grid);
end;

procedure TfrmTrsPurchaseOrder.RemoveRow;
begin

  case lblTransaksi.Tag of
    0:begin
        grid.ClearRows(grid.Row, 1);
        if grid.RowCount > 2 then
        grid.RemoveRows(grid.Row, 1);
        Calculate;
      end
    else

      case status_delete of
        1: if Confirmed('Hapus Order?') then
             if TTrsOrder.DeleteTrans(lblTransaksi.Tag) then
                InitForm;
        2: if Confirmed('Hapus baris?') then
             if TTrsOrder.DeleteDetail(grid.Ints[colId, grid.Row]) then begin
                grid.ClearRows(grid.Row, 1);
                if grid.RowCount > 2 then grid.RemoveRows(grid.Row, 1);
                Calculate;
             end;
      end;
   end;
end;

procedure TfrmTrsPurchaseOrder.SeekItem(ASearch: string);
var id: integer; code: string;
begin
  if txtNotes.Tag <> 0 then exit;
  code:= '';
  id:= frmLookup.ExecuteItem(0,0,0);
  if Id > 0 then getItem(code, id, 1)
end;

procedure TfrmTrsPurchaseOrder.SeekVendor;
var id: integer;
begin
  if not btnSpec.Enabled then exit;
  id:= frmLookup.Execute('SPL');
  if Id > 0 then getVendor('', id)
end;

procedure TfrmTrsPurchaseOrder.SetDisableEnable;
begin
  tbtSave.Enabled:= (txtNotes.Tag=0) and (lblTransaksi.Tag=0);
  dtpTransaction.Enabled:= (txtNotes.Tag=0);
  dtpExpr.Enabled:= (txtNotes.Tag = 0);
  dtpDely.Enabled:= (txtNotes.Tag = 0);
  txtNotes.Enabled:= (txtNotes.Tag = 0);
  chkPpn.Enabled:= (txtNotes.Tag = 0);
  tbtDelete.Enabled:= (txtNotes.Tag = 0);
  tbtPost.Enabled:= (txtNotes.Tag = 0) and (lblTransaksi.Tag<>0);
  tbtDelete.Enabled:= (txtNotes.Tag = 0);
  btnSpec.Enabled:= (lblTransaksi.Tag = 0);
  txtTerm.Enabled:= (txtNotes.Tag = 0);
end;

procedure TfrmTrsPurchaseOrder.gridCanEditCell(Sender: TObject;
  ARow, ACol: Integer; var CanEdit: Boolean);
begin
  CanEdit:=
    (ACol in [colCode,colBarcode, colQty, colHarga, colDisc]) and (txtNotes.Tag = 0);
end;

procedure TfrmTrsPurchaseOrder.gridCellValidate(Sender: TObject;
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
      Valid:= True; //Value <> '';
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

        if ((grid.Floats[colTax, Row] <> 0) or (grid.Floats[colMasterAdaTax, Row] = 1)) then begin

        if grid.Ints[colTaxed, Row] = 1 then begin
            tmp_nilai:= FormatSQLRound2(
              (grid.Floats[colTotal, grid.Row] - grid.Floats[colDiscTmp, grid.Row]) * 0.1);
            grid.Cells[colTax, Row]:= FloatToStrFmt(tmp_nilai);
          end;
        end;

        Calculate;
        grid.Ints[colModID, Row]:= 1;
        SavePostState(True);
      end;
    end;

    colDisc:
    begin
      Valid:= True;//Value <> '';
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

procedure TfrmTrsPurchaseOrder.gridGetAlignment(Sender: TObject;
  ARow, ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  if (ACol in[colNo, colQty, colHarga, colTotal, colDisc, colStok, colTax]) then
    HAlign:= taRightJustify
end;

procedure TfrmTrsPurchaseOrder.gridGetEditorType(Sender: TObject;
  ACol, ARow: Integer; var AEditor: TEditorType);
begin
  case ACol of
    colQty, colHarga, colDisc, colTax: AEditor:= edFloat;
  end;
end;

procedure TfrmTrsPurchaseOrder.gridKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var value: string; jumlah: double; valid: boolean;
begin
  case key of
    VK_RETURN:
    begin
      if (grid.Col in [colCode,colBarcode]) and (grid.Ints[colModID, grid.Row] = 1) then begin
         value:= grid.Cells[grid.col, grid.Row];
         if oldValue <> value then
            getItem(value, 0, 1);
      end;
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

          gridCellValidate(nil, grid.Col, grid.Row, value, valid);
       end

       else if grid.Col = colTax then begin
          jumlah:= FormatSQLRound2((grid.Floats[colTotal, grid.Row] - grid.Floats[colDiscTmp, grid.Row]) * 0.1);
          grid.Cells[grid.Col, grid.Row]:= FloatToStrFmt(jumlah);
          Calculate();
       end;

    VK_ADD: getUnitList;
    vk_F2 : SeekItem(grid.Cells[colBarcode, grid.Row]);

    VK_F3: txtSpec.SetFocus;
    VK_F4:
    begin
      grid.SetFocus;
      grid.Row:= 1;
      grid.Col:= colBarcode;
    end;

//    VK_F9: editItem;
  end;
end;

procedure TfrmTrsPurchaseOrder.gridKeyPress(Sender: TObject;
  var Key: Char);
begin
  case grid.Col of
    colQty, colDisc: if key = #46 then key := #44;
  end;
end;

procedure TfrmTrsPurchaseOrder.getUnitList;
var
  i: integer;
  rect: TRect; points: TPoint;
  MenuUnit: TMenuItem; PopUnit: TPopupMenu;
begin
  if grid.Ints[colItemId, grid.Row] <= 0 then exit;
  grid.Col:= colQty;
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

procedure TfrmTrsPurchaseOrder.getUnit(Sender: TObject);
var ARow: Integer; MstUnit: TMstItemConversion;
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

    grid.Cells[colTotal, ARow]:=
      FloatToStrFmt(
      StrFmtToFloatDef(grid.Cells[colHarga, ARow],0) *
      StrFmtToFloatDef(grid.Cells[colQty, ARow],0));

//    grid.Cells[colStok, ARow]:=
//      TMstItemConversion.GetStockDescription(grid.Ints[colItemId, ARow], round(MstItem.CurrentStock));
//
//      FloatToStrFmt(
//        RoundTo(
//          StrFmtToFloatDef(grid.Cells[colStok, ARow],0) / MstUnit.Conversion, 2));
    Calculate;
  end;

  MstUnit.Free;
end;

procedure TfrmTrsPurchaseOrder.txtSpecKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case key of
    VK_F2 : SeekVendor;
    VK_TAB:
      if txtSpec.Modified then
        getVendor(txtSpec.Text,0);

    VK_F3: txtSpec.SetFocus;
    VK_F4:
    begin
      grid.SetFocus;
      grid.Row:= 1;
      grid.Col:= colBarcode;
    end;


  end;
end;

procedure TfrmTrsPurchaseOrder.txtSpecKeyPress(Sender: TObject;
  var Key: Char);
begin
//  if key <> #13 then txtSpec.Tag:= 0;
end;

procedure TfrmTrsPurchaseOrder.btnSpecClick(Sender: TObject);
begin
  SeekVendor
end;

procedure TfrmTrsPurchaseOrder.dtpExprKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (key = vk_return) and (dtpDely.Enabled) then
    dtpDely.SetFocus;
end;

procedure TfrmTrsPurchaseOrder.dtpDelyKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (key = vk_return) and (txtNotes.Enabled) then
    txtNotes.SetFocus;
end;

procedure TfrmTrsPurchaseOrder.dtpTransactionKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (key = vk_return) and (txtSpec.Enabled) then
    txtSpec.SetFocus;
end;

procedure TfrmTrsPurchaseOrder.rdbTaxClick(Sender: TObject);
begin
//  Calculate;
  SavePostState(True);
end;

procedure TfrmTrsPurchaseOrder.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TfrmTrsPurchaseOrder.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  if MstItem <> nil then MstItem.Free;
  MstItem:= nil;
  if Order <> nil then Order.Free;
  Order:= nil;
  if ListUnit <> nil then ListUnit.Free;
  ListUnit:= nil;
end;

procedure TfrmTrsPurchaseOrder.LoadData(ID: integer);
var i: integer; x: double;
begin
  if ID = 0 then exit;
  Order.Clear;
  Order.OrderMst.OrderId:= ID;
  Order.SelectInDB;
  lblTransaksi.Caption:= Order.OrderMst.TransNum;
  lblTransaksi.Tag:= Order.OrderMst.OrderId;
  txtSpec.Tag:= Order.OrderMst.MstRelation.RelationId;
  txtSpec.Text:= Order.OrderMst.MstRelation.RelationName;
  dtpTransaction.Date:= Order.OrderMst.TransDate;
  dtpExpr.Date:= Order.OrderMst.ExprDate;
  dtpDely.Date:= Order.OrderMst.DeliveryDate;
  txtNotes.Text:= Order.OrderMst.Notes;
  txtNotes.Tag:= Order.OrderMst.StatusId;

  txtSubtotal.Text:= FloatToStr(Order.OrderMst.Subtotal);
  txtDisc1.Text := FloatToStr(Order.OrderMst.DiscDetail);
  txtTax.Text := FloatToStr(Order.OrderMst.Tax);
  txtTotal.Text := FloatToStr(Order.OrderMst.Total);
  txtTerm.IntValue := Order.OrderMst.PayTerm;

  txtDPP.Text := FloatToStr(Order.OrderMst.Total - Order.OrderMst.Tax);



  InitGrid;
  for i:= 0 to Order.OrderDetail_Arr.Count-1 do begin
    grid.Ints[colNo,i+1 ] := i+1;
    grid.Ints[colItemId,  i+1]:= Order.OrderDetail_Arr[i].MstItem.ItemId;
    grid.Ints[colConvId,  i+1]:= Order.OrderDetail_Arr[i].MstItemConversion.ConvId;
    grid.Ints[colDiscIsPrc,i+1]:= Order.OrderDetail_Arr[i].DiscIsPrc;
    grid.Cells[colCode,i+1]:= Order.OrderDetail_Arr[i].MstItem.ItemCode;
    grid.Cells[colBarcode,i+1]:= Order.OrderDetail_Arr[i].MstItem.Barcode;
    grid.Cells[colDesc,   i+1]:= Order.OrderDetail_Arr[i].MstItem.ItemName;
    grid.Cells[colUnit,   i+1]:= Order.OrderDetail_Arr[i].MstItemConversion.MstMaster.MstCode;
    grid.Cells[colHarga,  i+1]:= FloatToStrFmt(Order.OrderDetail_Arr[i].Price);
    grid.Cells[colDiscTmp,i+1]:= FloatToStrFmt(Order.OrderDetail_Arr[i].Disc);
    x:= IfThen(Order.OrderDetail_Arr[i].Amount = 0 , 1, Order.OrderDetail_Arr[i].Amount);

    if Order.OrderDetail_Arr[i].DiscIsPrc = 1 then
       grid.Cells[colDisc, i+1]:= FloatToStrFmt(
       (Order.OrderDetail_Arr[i].Disc * 100) / x)+'%'
    else grid.Cells[colDisc, i+1]:= FloatToStrFmt(Order.OrderDetail_Arr[i].Disc);

    if (Order.OrderDetail_Arr[i].Tax <> 0) then
      grid.Ints[colTaxed, i+1]:= 1
    else grid.Ints[colTaxed, i+1]:= 0;

    grid.Cells[colTotal,  i+1]:= FloatToStrFmt(Order.OrderDetail_Arr[i].Amount);
    grid.Cells[colQty,    i+1]:= FloatToStrFmt(Order.OrderDetail_Arr[i].Quantity);
    grid.Cells[colConv,   i+1]:= FloatToStrFmt(Order.OrderDetail_Arr[i].Conversion);
    grid.Cells[colTax,    i+1]:= FloatToStrFmt(Order.OrderDetail_Arr[i].Tax);
    grid.Ints[colModID,   i+1]:= 0;
    grid.Ints[colID,      i+1]:= Order.OrderDetail_Arr[i].OrderDetailId;
    grid.Cells[colStok,   i+1]:= FloatToStrFmt(TMstItem.GetSaldoAkhir(Order.OrderDetail_Arr[i].MstItem.ItemId, 0, ServerNow)); //TMstItemConversion.GetStockDescription(Order.OrderDetail_Arr[i].MstItem.ItemId,
                                   //round(TMstItem.GetSaldoAkhir(Order.OrderDetail_Arr[i].MstItem.ItemId, 0, ServerNow)));
    grid.AddRow;
  end;

  //Calculate;
  DeleteRowTerakhir(grid, 2, 1);
  SetDisableEnable;
end;

procedure TfrmTrsPurchaseOrder.txtSubtotalValueValidate(Sender: TObject;
  value: String; var IsValid: Boolean);
begin
  AdvEdtFloatFmt(Sender, value);
end;

procedure TfrmTrsPurchaseOrder.tbtDeleteClick(Sender: TObject);
begin
  RemoveRow
end;

procedure TfrmTrsPurchaseOrder.tbtSaveClick(Sender: TObject);
begin
  if isValid then isSaved 
end;

procedure TfrmTrsPurchaseOrder.tbtNewClick(Sender: TObject);
var tag : integer;
begin
  tag := 300;
//  Alert(IntToStr(AktiveControl.Tag));
if not TSystemAccess.isCan(CAN_ADD,tag) then exit;
  InitForm;
  SetDisableEnable;
  txtSpec.SetFocus
end;

procedure TfrmTrsPurchaseOrder.txtDisc2KeyPress(Sender: TObject;
  var Key: Char);
begin
  IgnoreChar(Key);
end;

procedure TfrmTrsPurchaseOrder.txtDisc2Exit(Sender: TObject);
begin
  Calculate;
end;

procedure TfrmTrsPurchaseOrder.txtSpecEnter(Sender: TObject);
begin
  status_delete:= 1;
end;

procedure TfrmTrsPurchaseOrder.gridEnter(Sender: TObject);
begin
  status_delete:= 2;
end;

procedure TfrmTrsPurchaseOrder.tbtPostClick(Sender: TObject);
begin
  if TTrsOrder.PostTrans(lblTransaksi.Tag) then
    txtNotes.Tag:= 1;
  SetDisableEnable;
end;

procedure TfrmTrsPurchaseOrder.dtpTransactionChange(Sender: TObject);
begin
  SavePostState(True);
end;

procedure TfrmTrsPurchaseOrder.ToolButton1Click(Sender: TObject);
begin
                printOrder(lblTransaksi.Tag);
{  if lblTransaksi.Tag <> 0 then begin
    if GlobalSystemConfig.localSetting.PrinterAdm <> '' then begin
       if (getDefaultPrinter <> GlobalSystemConfig.localSetting.PrinterAdm) then
           setDefaultPrinter(GlobalSystemConfig.localSetting.PrinterAdm);
    end;

    try
      Application.CreateForm(TqrpPurchaseOrder, qrpPurchaseOrder);
      qrpPurchaseOrder.Execute(lblTransaksi.Tag, grid);
    finally
      qrpPurchaseOrder.Destroy;
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
  end;}
end;

procedure TfrmTrsPurchaseOrder.FormShow(Sender: TObject);
begin
  txtSpec.SetFocus
end;

procedure TfrmTrsPurchaseOrder.LoadItem;
var i: integer; item, konversi: TMysqlResult;
begin
  if txtSpec.Tag = 0 then exit;
  if not Confirmed('Load Item dari supplier '+txtSpec.Text+' ?') then exit;

  item:= OpenSQL(
  'select i.item_id, i.barcode, i.item_name, current_stock,i.item_code '+
  'from mst_item i where i.vendor_id = '+FormatSQLNumber(txtSpec.Tag)+
  ' order by barcode ');

  InitGrid;
  if item.RecordCount > 0 then begin
     item.First;
     grid.RowCount:= item.RecordCount+1;
     for i:= 1 to item.RecordCount do begin

       konversi:= OpenSQL(
      'select c.conv_id, c.conversion, c.purchase_price, u.mst_name, c.item_tax, c.item_discount, c.disc_tipe '+
      'from mst_item_conversion c, mst_master u '+
      'where c.item_id = '+FormatSQLNumber(BufferToInteger(item.FieldValue(0)))+
      ' and c.kemasan_id = u.mst_id order by c.conversion desc limit 1');

       grid.Cells[colDesc,    i]:= item.FieldValue(2);
       grid.Cells[colCode, i]:= item.FieldValue(4);
       grid.Cells[colBarcode, i]:= item.FieldValue(1);
       grid.Ints[colItemId,   i]:= BufferToInteger(item.FieldValue(0));
       grid.Ints[colConvId,   i]:= BufferToInteger(konversi.FieldValue(0));
       grid.Cells[colUnit,    i]:= konversi.FieldValue(3);
       grid.Cells[colHarga,   i]:= FloatToStrFmt(BufferToFloat(konversi.FieldValue(2)));
       grid.Cells[colConv,    i]:= FloatToStrFmt(BufferToFloat(konversi.FieldValue(1)));
       grid.Floats[colQty,    i]:= 0;
       grid.Cells[colstok,    i]:= TMstItemConversion.GetStockDescription(
         BufferToInteger(item.FieldValue(0)), round(BufferToFloat(item.FieldValue(3))));

       grid.Cells[colDiscTmp, i]:= FloatToStrFmt(BufferToFloat(konversi.FieldValue(5)));
       grid.Ints[colDiscIsPrc, i]:= BufferToInteger(konversi.FieldValue(6));

       if BufferToFloat(konversi.FieldValue(6)) = 1 then
         grid.Cells[colDisc,  i]:= FloatToStrFmt(
          (BufferToFloat(konversi.FieldValue(5)) * 100) / BufferToFloat(konversi.FieldValue(2)))+'%'
       else grid.Cells[colDisc,  i]:= FloatToStrFmt(BufferToFloat(konversi.FieldValue(5)));

       if (BufferToFloat(konversi.FieldValue(4)) <> 0) then begin
         grid.Ints[colMasterAdaTax, i]:= 1;
         grid.Ints[colTaxed, i]:= 1;
       end
       else begin
         grid.Ints[colTaxed, i]:= 0;
         grid.Ints[colMasterAdaTax, i]:= 0;
       end;

       konversi.destroy;
       item.MoveNext;
       Calculate;
     end;
     item.destroy;
     grid.Row:= 1;
     grid.Col:= colQty;
  end;
end;

procedure TfrmTrsPurchaseOrder.txtSpecChange(Sender: TObject);
var asalna_true: boolean;
begin
  asalna_true:= tbtSave.Enabled;
  if not asalna_true then
  SavePostState((Sender as TAdvEdit).Modified);
end;

procedure TfrmTrsPurchaseOrder.SavePostState(state: boolean);
begin
  tbtSave.Enabled:= state;
  if state then tbtPost.Enabled:= False; //ngahaja
end;

procedure TfrmTrsPurchaseOrder.gridRowChanging(Sender: TObject; OldRow,
  NewRow: Integer; var Allow: Boolean);
begin
  if OldRow <= grid.RowCount-1 then
  grid.RowHeights[OldRow]:= grid.DefaultRowHeight;
  grid.AutoSizeRow(NewRow);
  if grid.RowHeights[NewRow] < grid.DefaultRowHeight then
    grid.RowHeights[NewRow]:= grid.DefaultRowHeight;
end;

procedure TfrmTrsPurchaseOrder.txtDisc2KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
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
    VK_NUMPAD0 : CalculateBuangPPN;
  end;
end;

procedure TfrmTrsPurchaseOrder.CheckBox1Click(Sender: TObject);
begin
  Calculate
end;

procedure TfrmTrsPurchaseOrder.CalculateManualPPN;
var total, disc1: double;
begin
  total:= StrFmtToFloatDef(txtSubtotal.Text,0);
  disc1:= StrFmtToFloatDef(txtDisc1.Text,0);
  total:= total - disc1 ;
  txtDPP.Text:= FloatToStrFmt(total);
  txtTax.Text:= FloatToStrFmt(total * 0.1);
  txtTotal.Text:= FloatToStrFmt((total * 0.1) + total);
end;

procedure TfrmTrsPurchaseOrder.CalculateBuangPPN;
var total, disc1, disc2: double;
begin
  total:= StrFmtToFloatDef(txtSubtotal.Text,0);
  disc1:= StrFmtToFloatDef(txtDisc1.Text,0);
  total:= total - disc1 - disc2;
  txtDPP.Text:= FloatToStrFmt(0);
  txtTax.Text:= FloatToStrFmt(0);
  txtTotal.Text:= FloatToStrFmt(total);
end;

procedure TfrmTrsPurchaseOrder.PrintRaw;
var i: integer; ls: TStringList;
   cust: TMstRelation;

const
  PAPER_WIDTH  = 80;
  GARIS        =
  '----------------------------------------'+
  '----------------------------------------';

begin
  ls:= TStringList.Create;
  cust:= TMstRelation.Create();
  cust.RelationID:= txtSpec.Tag;
  cust.SelectID;

  ls.Clear;
  ls.Append(FixWidth(Bold('PURCHASE ORDER'), PAPER_WIDTH, taCenter));
  ls.Append(FixWidth('trx_number', PAPER_WIDTH, taCenter));

  ls.Append(
    FixWidth('Dikirim Ke :', (PAPER_WIDTH-50), taLeftJustify)+
    FixWidth('Kepada Yth :', 50, taLeftJustify));

  ls.Append(
    FixWidth(Bold(CompanyProfile.FCompanyName), (PAPER_WIDTH-50), taLeftJustify)+
    FixWidth(Bold(cust.RelationName), 50, taLeftJustify));

  ls.Append(
    FixWidth(CompanyProfile.FAddress, (PAPER_WIDTH-50), taLeftJustify)+
    FixWidth(cust.Address1, 50, taLeftJustify));

  ls.Append(
    FixWidth(CompanyProfile.FTelp1, (PAPER_WIDTH-50), taLeftJustify)+
    FixWidth(cust.City, 50, taLeftJustify));

  ls.Append(
    FixWidth(CompanyProfile.FCity, (PAPER_WIDTH-50), taLeftJustify));

  ls.Append(FixWidth(GARIS, PAPER_WIDTH, taCenter));
//header
  ls.Append(
    FixWidth('NO. ', 4, taRightJustify) +
    FixWidth('BARCODE', 15 , taLeftJustify)+
    FixWidth('DESKRIPSI', 40, taRightJustify)+
    FixWidth('QTY', 12, taRightJustify)+//1.234 PERTI
    FixWidth('HRG BELI', 12, taRightJustify)+
    FixWidth('DISC', 12, taRightJustify)+
    FixWidth('PPN', 12, taRightJustify)+
    FixWidth('JUMLAH', 12, taRightJustify));
//end header
  ls.Append(FixWidth(GARIS, PAPER_WIDTH, taCenter));

//item
  for i:= 1 to grid.RowCount-1 do
  if grid.Cells[colItemId, i] <> '' then begin
     ls.Append(
       FixWidth(grid.Cells[colNo,1]+' ', 4, taRightJustify)+
       FixWidth(grid.Cells[colBarcode,1], 15, taLeftJustify)+
       FixWidth(grid.Cells[colDesc,1], PAPER_WIDTH - 79, taLeftJustify)+

       FixWidth(grid.Cells[colQty,1] + ' ' +grid.Cells[colUnit,1], 12, taRightJustify)+
       FixWidth(grid.Cells[colHarga,1], 12, taRightJustify)+
       FixWidth(grid.Cells[colTotal,1], 12, taRightJustify)+
       FixWidth(grid.Cells[colDisc,1], 12, taRightJustify)+
       FixWidth(grid.Cells[colTax,1], 12, taRightJustify));
    end;
//end item
  ls.Append(FixWidth(GARIS, PAPER_WIDTH, taCenter));
  ls.Append(
    FixWidth({'Tgl Expr :'+ FormatDateTime('dd, MMMM yyyy', dtpExpr.Date)}'', PAPER_WIDTH - 30, taLeftJustify)+
    FixWidth('Subtotal :'+ txtSubtotal.Text, 30, taRightJustify));

  ls.Append(FixWidth('Discount #1 :' + txtDisc1.Text, 30, taRightJustify));
  ls.Append(FixWidth('DPP :' + txtDPP.Text, 30, taRightJustify));
  ls.Append(FixWidth('PPN :' + txtTax.Text, 30, taRightJustify));

  ls.Append(
    FixWidth('PO Harap Dilampirkan Pada Saat Pengiriman Barang', PAPER_WIDTH - 30, taLeftJustify)+
    FixWidth('Total :' + txtTotal.Text, 30, taRightJustify));

  ls.Append(FixWidth(GARIS, PAPER_WIDTH, taCenter));

  ls.Append(
    FixWidth(CompanyProfile.FCity+', '+FormatDateTime('dd, MMMM yyyy', dtpTransaction.Date), PAPER_WIDTH, taLeftJustify));

  ls.Append(
    FixWidth('Dikirim Oleh,', 30, taCenter)+
    FixWidth('Diterima Oleh,', 30, taCenter)+
    FixWidth('Dipesan Oleh,', 30, taCenter)+
    FixWidth('Disetujui Oleh,', 30, taCenter));

  ls.Append(
    FixWidth('(--------------)', 30, taCenter)+
    FixWidth('(--------------)', 30, taCenter)+
    FixWidth('(--------------)', 30, taCenter)+
    FixWidth('(--------------)', 30, taCenter));

  ls.Append(
    FixWidth('Supplier', 30, taCenter)+
    FixWidth('Kepala Gudang', 30, taCenter)+
    FixWidth('Purchasing', 30, taCenter)+
    FixWidth('Accounting', 30, taCenter));

  RAWPrinter1.PrinterName:= GlobalSystemConfig.localSetting.PrinterAdm;
  RAWPrinter1.DocumentTitle:= 'PO';
  RAWPrinter1.BeginDoc;
  RAWPrinter1.Write(ls.Text);
  RAWPrinter1.EndDoc;

  ls.Destroy;
  cust.Destroy;
end;

procedure TfrmTrsPurchaseOrder.gridSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if (ACol = colBarcode) then OldValue:= grid.Cells[ACol, ARow];

end;

{procedure TfrmTrsPurchaseOrder.editItem();
var itemID: integer; value: string; valid: boolean;
begin

  itemID:= grid.Ints[colItemID, grid.Row];

  if (itemID <> 0) and (txtNotes.Tag = 0) then begin
//    frmMstItem.Execute(itemID);

    MstItem.Reset;
    MstItem.ItemId:= itemID;

    if MstItem.SelectInDB4(grid.Ints[colConvId, grid.Row]) then begin
      grid.Cells[colDesc,    grid.Row]:= MstItem.ItemName;
      grid.Cells[colBarcode, grid.Row]:= MstItem.Barcode;
      grid.Ints[colItemId,   grid.Row]:= MstItem.ItemId;
      grid.Ints[colModId,    grid.Row]:= 1;

      grid.Cells[colHarga,   grid.Row]:= FloatToStrFmt(MstItem.BuyingPrice);
      grid.Cells[colDiscTmp, grid.Row]:= FloatToStrFmt(0);
      grid.Cells[colConv,    grid.Row]:= FloatToStrFmt(0);

//      grid.Ints[colDiscIsPrc, grid.Row]:= MstItem.FItemConversion[0].DiscTipe;



    end;

    gridCellValidate(grid, colHarga, grid.Row, value, valid);
    gridCellValidate(grid, colQty, grid.Row, value, valid);
  end;
end;        }

procedure TfrmTrsPurchaseOrder.gridDblClickCell(Sender: TObject; ARow,
  ACol: Integer);
begin
//  editItem
end;

function TfrmTrsPurchaseOrder.printFooter(value: TStringList; idx,
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

function TfrmTrsPurchaseOrder.printHeader(value: TStringList;
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
      Bold('    PURCHASE ORDER'),RAWPrinter1,value);
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

procedure TfrmTrsPurchaseOrder.printOrder(ID: integer);
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

  buffer:=  TTrsOrder.printOrder(ID);

 
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


      FixWidth('SUBTOTAL', PAPER_WIDTH - 52, taRightJustify) +
      FixWidth(' :', 2, taLeftJustify) +                          //17
      FixWidth(FormatFloat('#,##0.#0', BufferToFloat(buffer.FieldValue(7))), 25, taRightJustify));

//       ls.Append(' ');
  //      ls.Append(' ');
   ls.Append(
     FixWidth(' ', 5, taLeftJustify) +
      FixWidth(' ', 20, taCenter)+
      FixWidth('DISCOUNT', PAPER_WIDTH - 52, taRightJustify) +
      FixWidth(' :', 2, taLeftJustify) +
      FixWidth(FormatFloat('#,##0.#0', BufferToFloat(buffer.FieldValue(13))), 25, taRightJustify));


      ls.Append(
     FixWidth(' ', 5, taLeftJustify) +
      FixWidth(' ', 20, taCenter)+
      FixWidth('PPN 10%', PAPER_WIDTH - 52, taRightJustify) +
      FixWidth(' :', 2, taLeftJustify) +
      FixWidth(FormatFloat('#,##0.#0', BufferToFloat(buffer.FieldValue(14))), 25, taRightJustify));


    ls.Append(
      FixWidth(' ', 5, taLeftJustify) +
      FixWidth(' ', 20, taCenter)+
      FixWidth('TOTAL', PAPER_WIDTH - 52, taRightJustify) +
      FixWidth(' :', 2, taLeftJustify) +
      FixWidth(FormatFloat('#,##0.#0', BufferToFloat(buffer.FieldValue(6))), 25, taRightJustify));

 

    if ((insertedIdx = 0) or (halaman-1 > footer_printed)) then
    begin
      ls.Append(' ');
      ls.Append(' ');
//      ls.Append(' ');
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

procedure TfrmTrsPurchaseOrder.chkPpnClick(Sender: TObject);
begin
  inherited;
  if chkPpn.Checked then CalculateManualPPN else CalculateBuangPPN;
end;

end.
