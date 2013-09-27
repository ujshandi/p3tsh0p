unit trsReceipt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, BaseGrid, AdvGrid, StdCtrls, AdvEdit, ComCtrls,
  SUIImagePanel, ToolWin, ExtCtrls,
  strUtils, Math, UMaster, UTransaction, Menus,
  frmDockForm;

type
  TfrmTrsReceipt = class(TDockForm)
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
    txtSubtotal: TAdvEdit;
    txtDisc1: TAdvEdit;
    txtTax: TAdvEdit;
    txtTotal: TAdvEdit;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    tbtPost: TToolButton;
    txtOrder: TAdvEdit;
    btnOrder: TButton;
    Label2: TLabel;
    txtBiaya: TAdvEdit;
    chkBeliLangsung: TCheckBox;
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
    procedure txtNotesChange(Sender: TObject);
    procedure btnOrderClick(Sender: TObject);
    procedure gridRowChanging(Sender: TObject; OldRow, NewRow: Integer;
      var Allow: Boolean);
    procedure CheckBox1Click(Sender: TObject);
    procedure txtDisc1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure txtTaxKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure gridSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure gridDblClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure chkBeliLangsungClick(Sender: TObject);
    procedure chkPpnClick(Sender: TObject);
  private
    MstItem: TMstItem;
    Trx: TTrsReceipt;
    ListUnit, lsGudang: TStringList;
    status_delete: word;
    OldValue: string;

    procedure CalculateManualPPN();
    procedure CalculateBuangPPN();

    procedure InitGrid;
    procedure InitForm;
    procedure SetDisableEnable;
    procedure Calculate();

    procedure RemoveRow();
    function GetOrder(ID: integer): boolean;
    procedure SavePostState(state: boolean);

    procedure SeekItem(ASearch: string);
    procedure getItem(var AItemCode: string; AItemID: integer; AQty: double);

    procedure SeekVendor;
    procedure getVendor(ACode: string; AID: integer);
    procedure LoadData(ID: integer);

    procedure editItem();

    function isValid: boolean;
    function isSaved: boolean;
    //procedure Print();
  public
    procedure Execute(vPurpose, ID: integer); override;
  end;

var
  frmTrsReceipt: TfrmTrsReceipt;

implementation

uses MainMenu, UConst, Subroutines, MySQLConnector,
  LookupData, LookupTrx, uMysqlClient, MstItem, AutoStockLine, UConstTool;

const
  colNo          = 0;
  colCode        = 1;
  colBarcode     = 2;
  colDesc        = 3;
  colQty         = 4;
  colUnit        = 5;
  colBonus       = 6;
  colSatBonus    = 7;
  colHarga       = 8;
  colTotal       = 9;
  colDisc1       =10;
  colDisc2       = 11;
  colDisc3       = 12;
  colTax         = 13;
  colConv        = 14;
  colConvBonus   = 15;
  colItemId      = 16;
  colConvId      = 17;
  colConvBonusId = 18;
  colModID       = 19;
  colID          = 20;
  colDisc1Tmp    = 21;
  colDisc2Tmp    = 22;
 colDisc3Tmp    = 23;
  colDisc1IsPrc  = 24;
  colDisc2IsPrc  = 25;
  colDisc3IsPrc  = 26;
  colTaxed       = 27;
  colMasterAdaTax = 28;
                      
{$R *.dfm}

{ TfrmTrsPurchaseOrder }

procedure TfrmTrsReceipt.Calculate;
var
  addt, total,
   dis_tax, dis_nontax: double;
  i: integer;
begin
  total := grid.ColumnSum(colTotal,1, grid.RowCount-1);

//menentukan dpp
  dis_tax:= 0;
  for i:= 1 to grid.RowCount-1 do
      if grid.Floats[colTax, i] <> 0 then
         dis_tax:= dis_tax + (grid.Floats[colDisc1Tmp, i]+grid.Floats[colDisc2Tmp, i]+grid.Floats[colDisc3Tmp, i]);

  dis_nontax:= 0;
  for i:= 1 to grid.RowCount-1 do
      if grid.Floats[colTax, i] = 0 then
         dis_nontax:= dis_nontax + (grid.Floats[colDisc1Tmp, i]+grid.Floats[colDisc2Tmp, i]+grid.Floats[colDisc3Tmp, i]);





  txtSubtotal.Text:= FloatToStrFmt(total);
  txtDisc1.Text   := FloatToStrFmt(dis_tax + dis_nontax);
  txtTotal.Text   := FloatToStrFmt(total-dis_tax-dis_nontax );//+ FormatSQLRound2(dpp * 0.1) + addt);

  //if (txtTax.Tag = 1) then CalculateManualPPN;
  if (chkPpn.Checked) then CalculateManualPPN;

end;

procedure TfrmTrsReceipt.Execute(vPurpose, ID: integer);
begin
  inherited;
  ToolBar1.ParentColor:= false;
  ToolBar1.Color:= clWhite;

  ListUnit:= TStringList.Create;
  lsGudang:= TStringList.Create;

//  TMstMaster_Arr.GetList(lsGudang, MST_TYPE_GUDANG);
//  NameValueListToValueList(lsGudang, cmbGudang.Items);
 // cmbGudang.ItemIndex:= -1;
 // cmbGudangChange(nil);

  MstItem  := TMstItem.Create;
  status_delete:= 0;
  Trx := TTrsReceipt.Create;
  InitForm;
  LoadData(ID);
  Run(Self);
end;

procedure TfrmTrsReceipt.getItem(var AItemCode: string; AItemID: integer;
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
  MstItem.VendorID := txtSpec.Tag;
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

      grid.Cells[colDesc,     row]:= MstItem.ItemName;
      grid.Cells[colCode,  row]:= MstItem.ItemCode;
      grid.Cells[colBarcode,  row]:= ItemCode;
      grid.Ints[colItemId,    row]:= MstItem.ItemId;
      grid.Ints[colModId,     row]:= 1;
      grid.Ints[colConvId,    row]:= 0;//MstItem.FItemConversion[0].ConvId;
      grid.Cells[colUnit,     row]:= TMstMaster.getName(MstItem.KemasanID); //MstItem.MstName;
      grid.Cells[colHarga,    row]:= FloatToStrFmt(MstItem.BuyingPrice);
      grid.Cells[colConv,     row]:= '1';//FloatToStrFmt(MstItem.FItemConversion[0].Conversion);
      grid.Cells[colQty,      row]:= FloatToStrFmt(AQty);
      grid.Cells[colTotal,    row]:= FloatToStrFmt(MstItem.BuyingPrice * AQty);
      grid.Cells[colDisc1Tmp, row]:= '0';//FloatToStrFmt(MstItem.FItemConversion[0].ItemDiscount);

     { grid.Ints[colDisc1IsPrc, row]:= MstItem.FItemConversion[0].DiscTipe;
      if MstItem.FItemConversion[0].DiscTipe = 1 then
          grid.Cells[colDisc1,   row]:= FloatToStrFmt(
         (MstItem.FItemConversion[0].ItemDiscount * 100) / MstItem.FItemConversion[0].PurchasePrice)+'%'
      else grid.Cells[colDisc1, row]:= FloatToStrFmt(MstItem.FItemConversion[0].ItemDiscount);

      if (MstItem.FItemConversion[0].ItemTax <> 0) then begin
         grid.Ints[colTaxed, row]:= 1;
         grid.Ints[colMasterAdaTax, row]:= 1;
      end
      else begin }
        grid.Ints[colTaxed, row]:= 0;
        grid.Ints[colMasterAdaTax, row]:= 0;
//      end;

    end;
    grid.Row:= row;
    grid.Col:= colQty;
    qty:= FloatToStrFmt(grid.Floats[colQty, row]);
    gridCellValidate(grid, colQty, row, qty, valid);
    Calculate;
  end
  else begin
    //Inform('Item tidak ditemukan.');
    grid.Col:= colBarcode;
    grid.Row:= row;
  end;
end;

procedure TfrmTrsReceipt.getVendor(ACode: string; AID: integer);
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

procedure TfrmTrsReceipt.InitForm;
begin
  InitGrid;
  lblTransaksi.Caption:= '[Nomor Transaksi]';
  lblTransaksi.Tag:= 0;
  txtNotes.Tag:= 0;
  txtSpec.Tag:= 0;
  txtOrder.Tag:= 0;
  chkBeliLangsung.Enabled := True;
  chkBeliLangsungClick(nil);
  txtNotes.Clear;
  txtSpec.Clear;
  txtOrder.Clear;
  txtSubtotal.Clear;
  txtDisc1.Clear;
  txtTax.Clear;
  txtBiaya.Clear;
  txtTax.Clear;
  txtTotal.Clear;
  chkPpn.Checked := False;
  SetDisableEnable;
  dtpTransaction.Date:= ServerNow;
end;

procedure TfrmTrsReceipt.InitGrid;
begin
  ResetGrid(grid, 2, 29, 1,1,-1);
  grid.AutoSizeColumns(true, 5);
  grid.AutoSizeRows(true, 3);
  grid.ColWidths[colItemId]:= 0;
  grid.ColWidths[colConvId]:= 0;
  grid.ColWidths[colConv]:= 0;
  grid.ColWidths[colModID]:= 0;
  grid.ColWidths[colID]:= 0;
  grid.ColWidths[colConvBonus]:= 0;
  grid.ColWidths[colConvBonusId]:= 0;
  grid.ColWidths[colDisc1Tmp]:= 0;
  grid.ColWidths[colDisc2Tmp]:= 0;
  grid.ColWidths[colDisc3Tmp]:= 0;
  grid.ColWidths[colDisc1IsPrc]:= 0;
  grid.ColWidths[colDisc2IsPrc]:= 0;
  grid.ColWidths[colDisc3IsPrc]:= 0;
  grid.ColWidths[colTaxed]:= 0;
  grid.ColWidths[colMasterAdaTax]:= 0;

  grid.ColWidths[colNo]:= 18;
  grid.ColWidths[colcode]:= 60;
  grid.ColWidths[colBarcode]:= 90;
  grid.ColWidths[colQty     ]:= 45;
  grid.ColWidths[colUnit    ]:= 40;
  grid.ColWidths[colBonus   ]:= 0;//40;
  grid.ColWidths[colSatBonus]:= 0;//40;
  grid.ColWidths[colHarga   ]:= 55;
  grid.ColWidths[colTotal   ]:= 75;
  grid.ColWidths[colDisc1   ]:= 55;
  grid.ColWidths[colDisc2   ]:= 0;//55;
  grid.ColWidths[colDisc3   ]:= 0;//55;
  grid.ColWidths[colTax     ]:= 0;//65;
  grid.RowHeights[1]:= grid.DefaultRowHeight;
end;

function TfrmTrsReceipt.isSaved: boolean;
var i: integer;
begin
  Trx.Clear;

  Trx.ReceiptId  := lblTransaksi.Tag;
  Trx.TransDate  := dtpTransaction.Date;
  Trx.RelationId := txtSpec.Tag;
  Trx.OrderId    := txtOrder.Tag;
  Trx.Notes      := txtNotes.Text;
  Trx.Userid     := GlobalSystemUser.UserId;
  Trx.Subtotal   := StrFmtToFloatDef(txtSubtotal.Text,0);
  Trx.DiscDetail := StrFmtToFloatDef(txtDisc1.Text,0);
  Trx.Biaya      := StrFmtToFloatDef(txtBiaya.Text,0);
  Trx.Tax        := StrFmtToFloatDef(txtTax.Text,0);
  Trx.Total      := StrFmtToFloatDef(txtTotal.Text,0);
  Trx.Tipe       := IfThen(chkBeliLangsung.Checked,1,0);
  Trx.GudangID   := GlobalSystemConfig.localSetting.LocalGudang;

  for i:= 1 to grid.RowCount -1 do
    if (grid.Ints[colItemId, i] <> 0) and (grid.Ints[colModID, i] <> 0) then begin
      Trx.trsDetail.Add(
      grid.Ints[colID, i], lblTransaksi.Tag,
      grid.Ints[colItemId, i],
      grid.Ints[colConvId, i], grid.Ints[colConvBonusId, i],
      ConvertToSaveConvertion(grid.Floats[colQty,i], grid.Floats[colConv,i]),
      ConvertToSaveConvertion(grid.Floats[colBonus,i], grid.Floats[colConvBonus,i]),
      //ConvertToLoadConvertion(grid.Floats[colHarga,i], grid.Floats[colConv,i]),
      grid.Floats[colHarga,i], 
      grid.Floats[colTotal,i],
      grid.Floats[colDisc1Tmp, i], grid.Floats[colDisc2Tmp, i], grid.Floats[colDisc3Tmp, i],
      grid.Floats[colConv, i], grid.Ints[colConvBonus, i], grid.Floats[colTax, i],
      grid.Ints[colDisc1IsPrc, i], grid.Ints[colDisc2IsPrc, i], grid.Ints[colDisc3IsPrc, i]);
    end;

  if (lblTransaksi.Tag = 0) then Result:= Trx.InsertOnDB()
  else Result:= Trx.UpdateOnDB();

  if Result then LoadData(Trx.ReceiptId);
  tbtSave.Enabled:= not Result;
  tbtPost.Enabled:= Result;
end;

function TfrmTrsReceipt.isValid: boolean;
var i: integer; valid: boolean;
begin
  Result:= False; valid:= False;
  for i:= 1 to grid.RowCount-1 do begin
    valid:= not IsClear(grid, colItemId, i);
    if valid then Break;
  end;

     CekInput(Result, valid , 'Tidak ada item untuk disimpan.', grid)
end;

procedure TfrmTrsReceipt.RemoveRow;
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
             if TTrsReceipt.DeleteTrans(lblTransaksi.Tag) then
                InitForm;
        2: if Confirmed('Hapus baris?') then
             if TTrsReceipt.DeleteDetail(grid.Ints[colId, grid.Row]) then begin
                grid.ClearRows(grid.Row, 1);
                if grid.RowCount > 2 then grid.RemoveRows(grid.Row, 1);
                Calculate;
             end;
      end;
   end;
end;

procedure TfrmTrsReceipt.SeekItem(ASearch: string);
var id: integer; code: string;
begin
  if txtNotes.Tag <> 0 then exit;
  code:= '';
  id:= frmLookup.ExecuteItem(0, txtSpec.Tag, 0);
  if Id > 0 then getItem(code, id, 1)
end;

procedure TfrmTrsReceipt.SeekVendor;
var id: integer;
begin
  if not btnSpec.Enabled then Exit;
  id:= frmLookup.Execute('SPL');
  if Id > 0 then getVendor('', id)
end;

procedure TfrmTrsReceipt.SetDisableEnable;
begin
  tbtSave.Enabled:= (txtNotes.Tag=0) and (lblTransaksi.Tag=0);
  dtpTransaction.Enabled:= (txtNotes.Tag=0);

  txtNotes.Enabled:= (txtNotes.Tag = 0);
  tbtDelete.Enabled:= (txtNotes.Tag = 0);
  tbtPost.Enabled:= (txtNotes.Tag = 0) and (lblTransaksi.Tag<>0);
  tbtDelete.Enabled:= (txtNotes.Tag = 0);
  txtBiaya.ReadOnly:= (txtNotes.Tag <> 0);
  btnSpec.Enabled:= (txtNotes.Tag = 0);
  btnOrder.Enabled:= (txtNotes.Tag = 0);
  txtSpec.Enabled:= (lblTransaksi.Tag = 0);
  txtOrder.Enabled:= (txtNotes.Tag = 0);
end;

procedure TfrmTrsReceipt.gridCanEditCell(Sender: TObject;
  ARow, ACol: Integer; var CanEdit: Boolean);
begin
  CanEdit:=                     //colBonus,, colDisc1        colDisc2, colDisc3
  (ACol in [colCode,colBarcode, colQty,  colHarga, colDisc1]) and
  (txtNotes.Tag = 0);
end;

procedure TfrmTrsReceipt.gridCellValidate(Sender: TObject;
  Col, Row: Integer; var Value: String; var Valid: Boolean);
var tmp: string; tmp_nilai: double;
begin
  case Col of
    colCode,colBarcode, colBonus:
    begin
      grid.Ints[colModID, Row]:= 1;
      SavePostState(True);
    end;

    colQty, colHarga:
    begin
      Valid:= True;//Value <> '';
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

        if grid.Ints[colDisc1IsPrc, Row] = 1 then
        begin
           tmp:= grid.Cells[colDisc1, Row];
           tmp_nilai:= StrFmtToFloatDef(Copy(tmp, 1, length(tmp)-1), 0);
           grid.Cells[colDisc1Tmp, Row]:=
             FloatToStrFmt(grid.Floats[colTotal, Row] * (tmp_nilai/100));
        end;

        if grid.Ints[colDisc2IsPrc, Row] = 1 then
        begin
           tmp:= grid.Cells[colDisc2, Row];
           tmp_nilai:= StrFmtToFloatDef(Copy(tmp, 1, length(tmp)-1), 0);
           grid.Cells[colDisc2Tmp, Row]:=
             FloatToStrFmt(grid.Floats[colTotal, Row] * (tmp_nilai/100));
        end;

        if grid.Ints[colDisc3IsPrc, Row] = 1 then
        begin
           tmp:= grid.Cells[colDisc3, Row];
           tmp_nilai:= StrFmtToFloatDef(Copy(tmp, 1, length(tmp)-1), 0);
           grid.Cells[colDisc3Tmp, Row]:=
             FloatToStrFmt(grid.Floats[colTotal, Row] * (tmp_nilai/100));
        end;

        if ((grid.Floats[colTax, Row] <> 0) or (grid.Floats[colMasterAdaTax, Row] = 1)) then begin
           if grid.Ints[colTaxed, Row] = 1 then begin
             tmp_nilai:= FormatSQLRound2(
               (StrFmtToFloatDef(grid.Cells[colTotal,Row], 0) -
                StrFmtToFloatDef(grid.Cells[colDisc1Tmp, Row], 0) -
                StrFmtToFloatDef(grid.Cells[colDisc2Tmp, Row], 0) -
                StrFmtToFloatDef(grid.Cells[colDisc3Tmp, Row], 0)) * 0.1);

             grid.Cells[colTax, Row]:= FloatToStrFmt(tmp_nilai);
          end;
        end;

        Calculate;
        grid.Ints[colModID, Row]:= 1;
        SavePostState(True);
      end;
    end;

    colDisc1:
    begin
      tmp:= Copy(Value, length(Value), 1);
      if tmp = '%' then begin //status persentase
         tmp_nilai:= StrFmtToFloatDef(Copy(Value, 1, length(Value)-1), 0);
         tmp_nilai:= (grid.Floats[colTotal, Row] * (tmp_nilai/100));
         grid.Ints[colDisc1IsPrc, Row]:= 1;
      end
      else begin
         tmp_nilai:= StrFmtToFloatDef(Value, 0);
         grid.Ints[colDisc1IsPrc, Row]:= 0;
         Value:= FloatToStrFmt(StrToFloatDef(Value,0));
      end;
      grid.Floats[colDisc1Tmp, Row]:= tmp_nilai;

      if grid.Floats[colTax, Row] <> 0 then
        grid.Cells[colTax, Row]:= FloatToStrFmt(FormatSQLRound2((
          StrFmtToFloatDef(grid.Cells[colTotal,Row], 0) -
          tmp_nilai -
          StrFmtToFloatDef(grid.Cells[colDisc2Tmp,Row], 0) -
          StrFmtToFloatDef(grid.Cells[colDisc3Tmp,Row], 0)) * 0.1));

      Calculate;
      grid.Ints[colModID, Row]:= 1;
      SavePostState(True);
    end;

    colDisc2:
    begin
      tmp:= Copy(Value, length(Value), 1);
      if tmp = '%' then begin //status persentase
         tmp_nilai:= StrFmtToFloatDef(Copy(Value, 1, length(Value)-1), 0);
         tmp_nilai:= ((grid.Floats[colTotal, Row] - grid.Floats[colDisc1Tmp, Row]) * (tmp_nilai/100));
         grid.Ints[colDisc2IsPrc, Row]:= 1;
      end
      else begin
         tmp_nilai:= StrFmtToFloatDef(Value, 0);
         grid.Ints[colDisc2IsPrc, Row]:= 0;
         Value:= FloatToStrFmt(StrToFloatDef(Value,0));
      end;
      grid.Floats[colDisc2Tmp, Row]:= tmp_nilai;
      if grid.Floats[colTax, Row] <> 0 then
        grid.Cells[colTax, Row]:= FloatToStrFmt(FormatSQLRound2((
          StrFmtToFloatDef(grid.Cells[colTotal,Row], 0) -
          StrFmtToFloatDef(grid.Cells[colDisc1Tmp,Row], 0) -
          tmp_nilai -
          StrFmtToFloatDef(grid.Cells[colDisc3Tmp,Row], 0)) * 0.1));

      Calculate;
      grid.Ints[colModID, Row]:= 1;
      SavePostState(True);
    end;

    colDisc3:
    begin
      tmp:= Copy(Value, length(Value), 1);
      if tmp = '%' then begin //status persentase
         tmp_nilai:= StrFmtToFloatDef(Copy(Value, 1, length(Value)-1), 0);
         tmp_nilai:= ((grid.Floats[colTotal, Row] - grid.Floats[colDisc1Tmp, Row] -
                       grid.Floats[colDisc2Tmp, Row]) * (tmp_nilai/100));
         grid.Ints[colDisc3IsPrc, Row]:= 1;
      end
      else begin
         tmp_nilai:= StrFmtToFloatDef(Value, 0);
         grid.Ints[colDisc3IsPrc, Row]:= 0;
         Value:= FloatToStrFmt(StrToFloatDef(Value,0));
      end;
      grid.Floats[colDisc3Tmp, Row]:= tmp_nilai;

      if grid.Floats[colTax, Row] <> 0 then
        grid.Cells[colTax, Row]:= FloatToStrFmt(FormatSQLRound2((
          StrFmtToFloatDef(grid.Cells[colTotal,Row], 0) -
          StrFmtToFloatDef(grid.Cells[colDisc1Tmp,Row], 0) -
          StrFmtToFloatDef(grid.Cells[colDisc2Tmp,Row], 0) -
          tmp_nilai) * 0.1));

      Calculate;
      grid.Ints[colModID, Row]:= 1;
      SavePostState(True);
    end;

  end;
end;

procedure TfrmTrsReceipt.gridGetAlignment(Sender: TObject;
  ARow, ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  if (ACol in[colNo, colQty, colHarga, colBonus,colTotal, colDisc1, colDisc2, colDisc3, colTax]) then
    HAlign:= taRightJustify
end;

procedure TfrmTrsReceipt.gridGetEditorType(Sender: TObject;
  ACol, ARow: Integer; var AEditor: TEditorType);
begin
  case ACol of
    colQty, colHarga, colDisc1, colDisc2, colDisc3: AEditor:= edFloat;
  end;
end;

procedure TfrmTrsReceipt.gridKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var value: string; jumlah: double; valid: boolean;
begin
  case key of
    VK_ADD   : getUnitList;
    VK_F2    : SeekItem(grid.Cells[colBarcode, grid.Row]);

    VK_RETURN:
    begin
      if (grid.Col in [colCode,colBarcode]) and (grid.Ints[colModID, grid.Row] = 1) then begin
         value:= grid.Cells[grid.col, grid.Row];
         if oldValue <> value then
           getItem(value, 0, 1);
      end;
      //GoNextColumn(Sender);
    end;

    VK_MULTIPLY:
    begin
       case grid.Col of
         colDisc1, colDisc2, colDisc3:
         begin
           //value:= FormatSQLNumber(StrFmtToFloatDef(grid.Cells[grid.Col, grid.Row],0)) + '%';
           value:= FloatToStrFmt(StrFmtToFloatDef(grid.Cells[grid.Col, grid.Row],0)) + '%';
           grid.Cells[grid.Col, grid.Row]:= value;
         end;

         colHarga:
         begin
           if grid.Ints[colTaxed, grid.Row] = 0 then begin
             grid.Ints[colTaxed, grid.Row]:= 1;
             jumlah:= grid.Floats[colHarga, grid.Row] / 1.1;
             value := FloatToStrFmt(jumlah);
             grid.Cells[grid.Col, grid.Row]:= value;

             grid.Cells[colTax, grid.Row]:= FloatToStrFmt(
               (StrFmtToFloatDef(grid.Cells[colTotal,grid.Row], 0) -
                StrFmtToFloatDef(grid.Cells[colDisc1Tmp, grid.Row], 0) -
                StrFmtToFloatDef(grid.Cells[colDisc2Tmp, grid.Row], 0) -
                StrFmtToFloatDef(grid.Cells[colDisc3Tmp, grid.Row], 0)) * 0.1);
           end
           else begin
             grid.Ints[colTaxed, grid.Row]:= 0;
             jumlah:= grid.Floats[colHarga, grid.Row] * 1.1;
             value := FloatToStrFmt(jumlah);
             grid.Cells[grid.Col, grid.Row]:= value;
             grid.Floats[colTax, grid.Row]:= 0;
           end;
           gridCellValidate(Sender, grid.Col, grid.Row, value, valid);
         end;

         colTax:
         begin
           jumlah:= FormatSQLRound2((grid.Floats[colTotal, grid.Row] -
             grid.Floats[colDisc1Tmp, grid.Row]-
             grid.Floats[colDisc2Tmp, grid.Row]-
             grid.Floats[colDisc3Tmp, grid.Row]) * 0.1);
           grid.Cells[grid.Col, grid.Row]:= FloatToStrFmt(jumlah);
           Calculate();
         end;
       end;
    end;

    VK_NUMPAD0:
    if grid.Col = colTax then begin
       grid.Cells[grid.Col, grid.Row]:= '0';
        Calculate();
    end;

    VK_F3: txtSpec.SetFocus;
    VK_F4:
    begin
      grid.SetFocus;
      grid.Row:= 1;
      grid.Col:= colBarcode;
    end;

    VK_F9: editItem;


  end;
end;

procedure TfrmTrsReceipt.gridKeyPress(Sender: TObject;
  var Key: Char);
begin
  case grid.Col of
    colQty, colDisc1, colDisc2, colDisc3: if key = #46 then key := #44;
  end;
end;

procedure TfrmTrsReceipt.getUnitList;
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

procedure TfrmTrsReceipt.getUnit(Sender: TObject);
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
        grid.Ints[colModID, ARow]:= 1;

        grid.Cells[colTotal, ARow]:=
          FloatToStrFmt(
          StrFmtToFloatDef(grid.Cells[colHarga, ARow],0) *
          StrFmtToFloatDef(grid.Cells[colQty, ARow],0));
        Calculate;
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

procedure TfrmTrsReceipt.txtSpecKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case key of
    VK_F2 : SeekVendor;
    VK_TAB:
      if txtSpec.Modified then
        getVendor(txtSpec.Text,0);
  end;
end;

procedure TfrmTrsReceipt.txtSpecKeyPress(Sender: TObject;
  var Key: Char);
begin
//  if key <> #13 then txtSpec.Tag:= 0;
end;

procedure TfrmTrsReceipt.btnSpecClick(Sender: TObject);
begin
  SeekVendor
end;

procedure TfrmTrsReceipt.dtpExprKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  //if (key = vk_return) and (dtpDely.Enabled) then
   // dtpDely.SetFocus;
end;

procedure TfrmTrsReceipt.dtpDelyKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (key = vk_return) and (txtNotes.Enabled) then
    txtNotes.SetFocus;
end;

procedure TfrmTrsReceipt.dtpTransactionKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (key = vk_return) and (txtSpec.Enabled) then
    txtSpec.SetFocus;
end;

procedure TfrmTrsReceipt.rdbTaxClick(Sender: TObject);
begin
//  Calculate;
  SavePostState(True);
end;

procedure TfrmTrsReceipt.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  if MstItem <> nil then MstItem.Free; MstItem:= nil;
  if Trx <> nil then Trx.Free; Trx:= nil;
  if ListUnit <> nil then ListUnit.Free; listUnit:= nil;
  if lsGudang <> nil then lsGudang.Free; lsGudang:= nil;
end;

procedure TfrmTrsReceipt.LoadData(ID: integer);
var i: integer; detail: TMysqlResult;  x, x2: double;
begin
  if ID = 0 then exit;
  Trx.Clear;
  Trx.ReceiptId:= ID;
  Trx.SelectInDB;
  chkBeliLangsung.Checked := Trx.Tipe=1;
  chkBeliLangsungClick(nil);
  chkBeliLangsung.Enabled := False;
  lblTransaksi.Caption:= Trx.TransNum;
  lblTransaksi.Tag:= Trx.ReceiptId;
  txtSpec.Tag:= Trx.RelationId;
  txtSpec.Text:= TMstRelation.GetName(Trx.RelationId);
  txtOrder.Tag:= Trx.OrderId;
  txtOrder.Text:= TTrsOrder.GetID(Trx.OrderId);
  dtpTransaction.Date:= Trx.TransDate;


  txtNotes.Text:= Trx.Notes;
  txtNotes.Tag:= Trx.StatusId;

  txtSubtotal.Text:= FloatToStrFmt(Trx.Subtotal);
  txtDisc1.Text := FloatToStrFmt(Trx.DiscDetail);
  txtBiaya.Text := FloatToStrFmt(Trx.Biaya);
  txtTax.Text := FloatToStrFmt(Trx.Tax);
  txtTotal.Text := FloatToStrFmt(Trx.Total);



  InitGrid;
  //0receipt_detail_id, 1item_id, 2conv_id, 3conv_bonus_id, 4quantity, 5qty_bonus,
  //6price, 7amount, 8disc1, 9disc2, 10disc3, 11conversion, 12conv_bonus
  //13item_name, 14barcode, 15satuan, 16sat_bonus
  //17d.tax, 18disc1_is_prc, 19disc2_is_prc, 20disc3_is_prc,21item_code

  detail:= Trx.SelectDetail(ID);
  detail.First;
  for i:= 1 to detail.RecordCount do begin
    grid.Ints[colModID,   i]:= 0;
    grid.Ints[colNo,i ] := 1;
    grid.Cells[colID,      i]:= detail.FieldValue(0);
    grid.Cells[colItemId,  i]:= detail.FieldValue(1);
    grid.Cells[colConvId,  i]:= detail.FieldValue(2);
    grid.Cells[colcode, i]:= detail.FieldValue(21);
    grid.Cells[colBarcode, i]:= detail.FieldValue(14);
    grid.Cells[colDesc,    i]:= detail.FieldValue(13);
    grid.Cells[colUnit,    i]:= detail.FieldValue(15);
    grid.Cells[colSatBonus,i]:= detail.FieldValue(16);
    grid.Cells[colQty,     i]:= FloatToStrFmt(BufferToFloat(detail.FieldValue(4)));
    grid.Cells[colBonus,   i]:= FloatToStrFmt(BufferToFloat(detail.FieldValue(5)));
    grid.Cells[colHarga,   i]:= FloatToStrFmt(BufferToFloat(detail.FieldValue(6)));
    grid.Cells[colTotal,   i]:= FloatToStrFmt(BufferToFloat(detail.FieldValue(7)));
    grid.Cells[colConv,    i]:= FloatToStrFmt(BufferToFloat(detail.FieldValue(11)));
    grid.Cells[colConvBonus,i]:= FloatToStrFmt(BufferToFloat(detail.FieldValue(12)));
    grid.Cells[colConvBonusId,i]:= detail.FieldValue(3);
    grid.Cells[colTax,     i]:= FloatToStrFmt(BufferToFloat(detail.FieldValue(17)));

    grid.Cells[colDisc1Tmp, i]:= FloatToStrFmt(BufferToFloat(detail.FieldValue(8)));
    grid.Cells[colDisc2Tmp, i]:= FloatToStrFmt(BufferToFloat(detail.FieldValue(9)));
    grid.Cells[colDisc3Tmp, i]:= FloatToStrFmt(BufferToFloat(detail.FieldValue(10)));

    grid.Ints[colDisc1IsPrc, i]:= BufferToInteger(detail.FieldValue(18));
    grid.Ints[colDisc2IsPrc, i]:= BufferToInteger(detail.FieldValue(19));
    grid.Ints[colDisc3IsPrc, i]:= BufferToInteger(detail.FieldValue(20));

    x:= IfThen(BufferToFloat(detail.FieldValue(7)) = 0, 1, BufferToFloat(detail.FieldValue(7)));
  //disc #1
    if BufferToInteger(detail.FieldValue(18)) = 1 then
       grid.Cells[colDisc1, i]:= FloatToStrFmt(
       (BufferToFloat(detail.FieldValue(8)) * 100) / x)+'%'
    else grid.Cells[colDisc1, i]:= FloatToStrFmt(BufferToFloat(detail.FieldValue(8)));

    x2:= BufferToFloat(detail.FieldValue(7)) - BufferToFloat(detail.FieldValue(8));
    x:= IfThen(x2=0, 1, x2);
    //disc #2
    if BufferToInteger(detail.FieldValue(19)) = 1 then
       grid.Cells[colDisc2, i]:= FloatToStrFmt(
       (BufferToFloat(detail.FieldValue(9)) * 100) / ( {total-dis1}
        x))+'%'

    else grid.Cells[colDisc2, i]:= FloatToStrFmt(BufferToFloat(detail.FieldValue(9)));

    x2:= BufferToFloat(detail.FieldValue(7)) - BufferToFloat(detail.FieldValue(8)) - BufferToFloat(detail.FieldValue(9));
    x:= IfThen(x2=0, 1, x2);
    //disc #3
    if BufferToInteger(detail.FieldValue(20)) = 1 then
       grid.Cells[colDisc3, i]:= FloatToStrFmt(
       (BufferToFloat(detail.FieldValue(10)) * 100) / ( {total-dis1-dis2}
        x))+'%'
    else grid.Cells[colDisc3, i]:= FloatToStrFmt(BufferToFloat(detail.FieldValue(10)));

    if (BufferToFloat(detail.FieldValue(17)) <> 0) then grid.Ints[colTaxed, i]:= 1
    else grid.Ints[colTaxed, i]:= 0;

    grid.Ints[colModID,    i]:= 0;
    detail.MoveNext;
    grid.AddRow;
  end;
  detail.destroy;
//  Calculate;
  DeleteRowTerakhir(grid, 2, 1);
  SetDisableEnable;
end;

procedure TfrmTrsReceipt.txtSubtotalValueValidate(Sender: TObject;
  value: String; var IsValid: Boolean);
begin
  AdvEdtFloatFmt(Sender, value);
end;

procedure TfrmTrsReceipt.tbtDeleteClick(Sender: TObject);
begin
  RemoveRow
end;

procedure TfrmTrsReceipt.tbtSaveClick(Sender: TObject);
begin
  if isValid then isSaved 
end;

procedure TfrmTrsReceipt.tbtNewClick(Sender: TObject);
var tag : integer;
begin
  tag := 301;
//  Alert(IntToStr(AktiveControl.Tag));
if not TSystemAccess.isCan(CAN_ADD,tag) then exit;
  InitForm;
  SetDisableEnable;
  txtSpec.SetFocus
end;

procedure TfrmTrsReceipt.txtDisc2KeyPress(Sender: TObject;
  var Key: Char);
begin
  if key = #46 then key := #44;
  IgnoreChar(Key);
end;

procedure TfrmTrsReceipt.txtDisc2Exit(Sender: TObject);
begin
  Calculate;
end;

procedure TfrmTrsReceipt.txtSpecEnter(Sender: TObject);
begin
  status_delete:= 1;
end;

procedure TfrmTrsReceipt.gridEnter(Sender: TObject);
begin
  status_delete:= 2;
end;

procedure TfrmTrsReceipt.tbtPostClick(Sender: TObject);
begin
  if TTrsReceipt.PostTrans(lblTransaksi.Tag) then
    txtNotes.Tag:= 1;
  SetDisableEnable;
end;

procedure TfrmTrsReceipt.dtpTransactionChange(Sender: TObject);
begin
  SavePostState(True);
end;

procedure TfrmTrsReceipt.txtNotesChange(Sender: TObject);
var asalna_true: boolean;
begin
  asalna_true:= tbtSave.Enabled;
  if not asalna_true then
  SavePostState((Sender as TAdvEdit).Modified);
end;

procedure TfrmTrsReceipt.btnOrderClick(Sender: TObject);
var ID, relasiID: integer;  order: TMysqlResult;
begin
  GlobalFilter.Reset;
  GlobalFilter.RelasiID:= txtSpec.Tag;

  ID:= frmLookupTrx.Execute('ORDER');
  if ID <> 0 then begin
    txtOrder.Tag := ID;
    order:= TTrsOrder.GetIDFromReceipt(ID);
    if order.RecordCount > 0 then begin
      GetOrder(ID);

    //0order_id, 1tipe, 2trans_num, 3disc_mst, 4relation_id, 5dpp_disc2
      txtOrder.Text:= order.FieldValue(2);
      relasiID:= BufferToInteger(order.FieldValue(4));
      if txtSpec.Tag <> relasiID then begin
         txtSpec.Tag:= relasiID;
         txtSpec.Text:= TMstRelation.GetName(relasiID);
      end;
      SavePostState(True);
    end;
    order.destroy;  
  end;
end;

function TfrmTrsReceipt.GetOrder(ID: integer): boolean;
var i: integer; detail: TMysqlResult;
 //tax_order: double;
begin
  InitGrid;
  //0receipt_detail_id, 1item_id, 2conv_id, 3quantity,
  //4price, 5amount, 6disc1, 7conversion, 8item_name, 9barcode, 10satuan,
  //'11d.tax, 12d.disc_is_prc,13i.item_code
  detail:= Trx.SelectOrderDetail(ID);
  Result:= detail.RecordCount > 0;
  detail.First;
  for i:= 1 to detail.RecordCount do begin
    grid.Ints[colNo,i ] := i;
  //grid.Cells[colID,      i]:= detail.FieldValue(0);
    grid.Cells[colItemId,  i]:= detail.FieldValue(1);
    grid.Cells[colConvId,  i]:= detail.FieldValue(2);
    grid.Cells[colcode, i]:= detail.FieldValue(13);
    grid.Cells[colBarcode, i]:= detail.FieldValue(9);
    grid.Cells[colDesc,    i]:= detail.FieldValue(8);
    grid.Cells[colUnit,    i]:= detail.FieldValue(10);
    grid.Cells[colQty,     i]:= FloatToStrFmt(BufferToFloat(detail.FieldValue(3)));
    grid.Cells[colHarga,   i]:= FloatToStrFmt(BufferToFloat(detail.FieldValue(4)));
    grid.Cells[colTotal,   i]:= FloatToStrFmt(BufferToFloat(detail.FieldValue(5)));

      //disc #1
    if BufferToInteger(detail.FieldValue(12)) = 1 then
       grid.Cells[colDisc1, i]:= FloatToStrFmt(
       (BufferToFloat(detail.FieldValue(6)) * 100) / BufferToFloat(detail.FieldValue(5)))+'%'
    else grid.Cells[colDisc1, i]:= FloatToStrFmt(BufferToFloat(detail.FieldValue(6)));

    grid.Cells[colDisc1Tmp,   i]:= FloatToStrFmt(BufferToFloat(detail.FieldValue(6)));
    grid.Ints[colDisc1IsPrc,  i]:= BufferToInteger(detail.FieldValue(12));

    grid.Cells[colTax,        i]:= FloatToStrFmt(BufferToFloat(detail.FieldValue(11)));
    grid.Cells[colConv,       i]:= FloatToStrFmt(BufferToFloat(detail.FieldValue(7)));
    grid.Ints[colModID,       i]:= 1;
    detail.MoveNext;
    grid.AddRow;
  end;
  detail.destroy;
  Calculate;

  //tax_order:= TTrsOrder.GetTax(ID);
  //if tax_order > 0 then begin
  //   txtTax.Text:= FloatToStr(TTrsOrder.GetTax(ID));
  //   txtTotal.Text:=
  //end;


  DeleteRowTerakhir(grid, 2, 1);
end;

procedure TfrmTrsReceipt.SavePostState(state: boolean);
begin
  tbtSave.Enabled:= state;
  if state then tbtPost.Enabled:= False; //ngahaja
end;

procedure TfrmTrsReceipt.gridRowChanging(Sender: TObject; OldRow,
  NewRow: Integer; var Allow: Boolean);
begin
  if OldRow <= grid.RowCount-1 then
  grid.RowHeights[OldRow]:= grid.DefaultRowHeight;
  grid.AutoSizeRow(NewRow);
  if grid.RowHeights[NewRow] < grid.DefaultRowHeight then
    grid.RowHeights[NewRow]:= grid.DefaultRowHeight;
end;

procedure TfrmTrsReceipt.CheckBox1Click(Sender: TObject);
begin
  Calculate;
end;

procedure TfrmTrsReceipt.txtDisc1KeyDown(Sender: TObject; var Key: Word;
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

procedure TfrmTrsReceipt.CalculateBuangPPN;
var addt, total, disc1,disc2: double;
begin
  total:= StrFmtToFloatDef(txtSubtotal.Text,0);
  disc1:= StrFmtToFloatDef(txtDisc1.Text,0);
  total:= total - disc1 - disc2;
  txtTax.Text:= FloatToStrFmt(0);
  txtTax.Tag := 0;
  txtTotal.Text:= FloatToStrFmt(total+addt);
end;

procedure TfrmTrsReceipt.CalculateManualPPN;
var addt, total, disc1,disc2: double;
begin
  total:= StrFmtToFloatDef(txtSubtotal.Text,0);
  disc1:= StrFmtToFloatDef(txtDisc1.Text,0);
  total:= total - disc1 - disc2;
  txtTax.Text:= FloatToStrFmt(total * 0.1);
  txtTax.Tag := 1;

  txtTotal.Text:= FloatToStrFmt((total * 0.1) + total+addt);
end;

procedure TfrmTrsReceipt.txtTaxKeyDown(Sender: TObject; var Key: Word;
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

procedure TfrmTrsReceipt.gridSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if (ACol = colBarcode) then OldValue:= grid.Cells[ACol, ARow];

end;

procedure TfrmTrsReceipt.editItem;
var itemID: integer; value: string; valid: boolean;
begin

  itemID:= grid.Ints[colItemID, grid.Row];

  if (itemID <> 0) and (txtNotes.Tag = 0) then begin
//    frmMstItem.Execute(purpose,itemID);

    MstItem.Reset;
    MstItem.ItemId:= itemID;

    if MstItem.SelectInDB4(grid.Ints[colConvId, grid.Row]) then begin
      grid.Cells[colDesc,    grid.Row]:= MstItem.ItemName;
      grid.Cells[colcode, grid.Row]:= MstItem.ItemCode;
      grid.Cells[colBarcode, grid.Row]:= MstItem.Barcode;
      grid.Ints[colItemId,   grid.Row]:= MstItem.ItemId;
      grid.Ints[colModId,    grid.Row]:= 1;

      grid.Cells[colHarga,   grid.Row]:= FloatToStrFmt(MstItem.FItemConversion[0].PurchasePrice);
      grid.Cells[colDisc1Tmp, grid.Row]:= FloatToStrFmt(MstItem.FItemConversion[0].ItemDiscount);
      grid.Cells[colConv,    grid.Row]:= FloatToStrFmt(MstItem.FItemConversion[0].Conversion);

      grid.Ints[colDisc1IsPrc, grid.Row]:= MstItem.FItemConversion[0].DiscTipe;

      grid.Ints[colDisc1IsPrc, grid.Row]:= MstItem.FItemConversion[0].DiscTipe;
      if MstItem.FItemConversion[0].DiscTipe = 1 then
          grid.Cells[colDisc1,   grid.Row]:= FloatToStrFmt(
         (MstItem.FItemConversion[0].ItemDiscount * 100) / MstItem.FItemConversion[0].PurchasePrice)+'%'
      else grid.Cells[colDisc1, grid.Row]:= FloatToStrFmt(MstItem.FItemConversion[0].ItemDiscount);

      if (MstItem.FItemConversion[0].ItemTax <> 0) then begin
         grid.Ints[colTaxed, grid.Row]:= 1;
         grid.Ints[colMasterAdaTax, grid.Row]:= 1;
      end
      else begin
        grid.Ints[colTaxed, grid.Row]:= 0;
        grid.Ints[colMasterAdaTax, grid.Row]:= 0;
      end;

    end;

    gridCellValidate(grid, colHarga, grid.Row, value, valid);
    gridCellValidate(grid, colQty, grid.Row, value, valid);
  end;

end;

procedure TfrmTrsReceipt.gridDblClickCell(Sender: TObject; ARow,
  ACol: Integer);
begin
//  editItem

end;

procedure TfrmTrsReceipt.chkBeliLangsungClick(Sender: TObject);
var beli : boolean;
begin
  inherited;
  beli := chkBeliLangsung.Checked;
  if beli then begin
    txtOrder.Clear;
    txtOrder.Tag:=0;
    btnOrder.Enabled:= False;
  end
  else begin
    txtOrder.Clear;
    txtOrder.Tag:=0;
    btnOrder.Enabled:= True;
  end;
end;

procedure TfrmTrsReceipt.chkPpnClick(Sender: TObject);
begin
  inherited;
  if chkPpn.Checked then CalculateManualPPN else CalculateBuangPPN;
end;

end.
