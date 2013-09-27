unit TrsItemShipment;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Grids, BaseGrid, AdvGrid, StdCtrls, AdvEdit, ComCtrls,
  ToolWin, strUtils, Math, WinXP,
  UMaster, UTransaction, SUIImagePanel, Menus,MstCodeList, MySQLConnector, uMysqlClient,
  frmDockForm, RAWPrinter;

type
  TfrmTrsItemShipment = class(TDockForm)
    ToolBar1: TToolBar;
    tbtNew: TToolButton;
    tbtSave: TToolButton;
    ToolButton5: TToolButton;
    tbtDelete: TToolButton;
    WinXP1: TWinXP;
    suiPanel1: TsuiPanel;
    dtpTransaction: TDateTimePicker;
    lblTransaksi: TLabel;
    suiPanel3: TsuiPanel;
    grid: TAdvStringGrid;
    cmbAsal: TComboBox;
    lblGudang: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    txtVc: TAdvEdit;
    Button2: TButton;
    PopupMenu1: TPopupMenu;
    f1: TMenuItem;
    f2: TMenuItem;
    tbtPrint: TToolButton;
    txtSpec: TAdvEdit;
    txtNama: TAdvEdit;
    txtMerk: TAdvEdit;
    txtCode: TAdvEdit;
    btnLoad: TButton;
    btnSpec: TButton;
    Bevel1: TBevel;
    txtNote: TMemo;
    Label4: TLabel;
    rgbJenis: TRadioGroup;
    RAWPrinter1: TRAWPrinter;
    imgLogo: TImage;
    txtTotal: TAdvEdit;
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
    procedure dtpTransactionKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure tbtNewClick(Sender: TObject);
    procedure tbtSaveClick(Sender: TObject);
    procedure tbtDeleteClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure gridKeyPress(Sender: TObject; var Key: Char);
    procedure btnSpecClick(Sender: TObject);
    procedure txtSpecKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure getUnitList;
    procedure getUnit(Sender: TObject);
    procedure cmbAsalChange(Sender: TObject);
    procedure btnLoadClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure dtpTransactionChange(Sender: TObject);
    procedure gridGetCellColor(Sender: TObject; ARow, ACol: Integer;
      AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
    procedure tbtPrintClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure rgbJenisClick(Sender: TObject);
    procedure f2Click(Sender: TObject);
    procedure f1Click(Sender: TObject);
//    procedure gridClickCell(Sender: TObject; ARow, ACol: Integer);
  private
    MstItem : TMstItem;
    Shipment: TTrsShipment;
    ListUnit, lsGudang: TStringList;
    Purpose : integer;

    procedure InitGrid;
    procedure ArrangeColSize;
    procedure ResetForm;
    procedure InitForm(id: integer);
    procedure LoadData;
    procedure LoadDataItem;//ga kepake
    procedure LoadDataFormOpname;
    procedure getItem(AItemCode: string; AItemId,ARow:integer);
    procedure getItemTipe();
    function isValid: boolean;
    function isSaved: boolean;

    procedure ReplaceSaldo(itemID, row: integer; newKonversi: double);

    procedure printOrder(ID: integer);
    function  printHeader(value: TStringList; _buffer: TMysqlResult; hal: integer;onlyColumnHeader:boolean=false): integer;
    function  printFooter(value: TStringList; idx, insIdx: integer): integer;
  public
    procedure Execute(vPurpose, id: integer); override;

  end;

var
  frmTrsItemShipment: TfrmTrsItemShipment;

implementation

uses UConstTool, MainMenu,
  Subroutines, UConst,
  LookupData, FormOpnamePrint, AutoStockLine, EpsonUtils, RawPrintPrev,
  DraftOpnamePrint;

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

  
  colNo     = 0;
  colCode   = 1;
  colBarcode   = 2;
  colName   = 3;
  colMerk   = 4;
  colUnit   = 5;
  colStok   = 6;
  colQty    = 7; //colReal
  colRange  = 8;  //selisih


  colMarkup = 9;   //harga beli dalam opname
  colSale   =10;
  colRangeHide  = 11;  //selisih
  colAmount = 12;
  colItemId = 13;
  colModId  = 14;
  colId     = 15;

{$R *.dfm}

{ TfrmTrsItemShipment }

procedure TfrmTrsItemShipment.ArrangeColSize;
begin
  grid.AutoSizeColumns(true, 5);
  grid.ColWidths[colItemId]:= 0;
  grid.ColWidths[colModID ]:= 0;
  grid.ColWidths[colID    ]:= 0;

  if (Purpose = ITEM_TYPE_OPNAME) then begin
    grid.ColWidths[colSale]:= 0;
    grid.ColWidths[colRangeHide]:= 0;
    grid.ColWidths[colStok]:= 0;

  end
  else if (Purpose IN [ITEM_TYPE_MUTASI_MASUK,ITEM_TYPE_MUTASI_KELUAR]) then begin
//    grid.ColWidths[colSale]:= 0;
    grid.ColWidths[colRangeHide]:= 0;
    grid.ColWidths[colStok]:= 0;
    grid.ColWidths[colRange]:= 0;
  end
  else grid.ColWidths[colRangeHide]:= 0;
end;

{procedure TfrmTrsItemShipment.getConversion(AConvId, ARow: integer);
begin
  MstUnit.Reset;
  MstUnit.ConvId:= AConvId;
  if MstUnit.SelectInDB then begin
    grid.Ints[colConvId, ARow]:= MstUnit.ConvId;
    grid.Cells[colUnit,  ARow]:= MstUnit.MstMaster.MstName;
    grid.Cells[colConv,  ARow]:= FloatToStrFmt(MstUnit.Conversion);

//    if Purpose = ITEM_TYPE_OPNAME then begin
      grid.Cells[colStok, ARow]:= FloatToStrFmt(
        round(ConvertToLoadConvertion(StrFmtToFloatDef(grid.Cells[colStok, ARow],0),
        MstUnit.Conversion)));

      grid.Cells[colRange, ARow]:= FloatToStrFmt(
        StrFmtToFloatDef(grid.Cells[colQty, ARow], 0) -
        StrFmtToFloatDef(grid.Cells[colStok,ARow], 0));
  //  end;

//    grid.Col:= colQty;
  end;
  ArrangeColSize;
end;
}

procedure TfrmTrsItemShipment.getItem(AItemCode: string; AItemId,
  ARow: integer);
begin
  if cmbAsal.Tag=0 then begin
    Inform('Gudang asal belum diisi');
    Exit;
  end;
  
  MstItem.Reset;
  MstItem.ItemId := AItemId;
  MstItem.Barcode:= AItemCode;
  if MstItem.SelectInDB then begin
    grid.Ints[colNo, ARow]:= ARow;
//    if GlobalSystemConfig[CONF_INVENTORY-1].ConfValue = '-1' then
    grid.Cells[colStok,ARow ] := FloatToStrFmt(MstItem.CurrentStock);
    grid.Cells[colName,  ARow]:= MstItem.ItemName;
    grid.Cells[colcode,  ARow]:= MstItem.ItemCode;
    grid.Cells[colBarcode,  ARow]:= MstItem.Barcode;
    grid.Ints[colItemId, ARow]:= MstItem.ItemId;
    grid.Cells[colMerk,ARow ] := MstItem.Merk;
//    grid.Cells[colPrcs,ARow] := FloatToStrFmt(MstItem.BuyingPrice);
    grid.Cells[colMarkup,ARow] := FloatToStrFmt(MstItem.BuyingPrice);
    grid.Cells[colSale,ARow] := FloatToStrFmt(MstItem.SellingPrice);
    grid.Cells[colUnit,ARow] := TMstMaster.getKode(MstItem.KemasanID);
    grid.Col:= colQty;
  end
  else begin
      Alert('Item tidak ditemukan');
      grid.Row := ARow;
      grid.Cells[colBarcode,ARow] := '';
      grid.Col := colBarcode;
  end;
  ArrangeColSize;
end;

procedure TfrmTrsItemShipment.ResetForm;
begin
  InitGrid;
  lblGudang.Caption := 'Gudang :';
  dtpTransaction.Date:= ServerNow;
  txtNote.Lines.Clear;
  tbtSave.Enabled:= lblTransaksi.Tag = 0;
  dtpTransaction.Enabled:= lblTransaksi.Tag = 0;
  txtNote.Enabled:= lblTransaksi.Tag = 0;
  tbtDelete.Enabled:= lblTransaksi.Tag = 0;
  btnLoad.Enabled:= lblTransaksi.Tag = 0;
  txtSpec.Clear;
  txtSpec.Tag:= 1;

  cmbAsal.ItemIndex:= lsGudang.IndexOfName(IntToStr(GlobalSystemConfig.localSetting.LocalGudang)) ;
  cmbAsalChange(nil);
  //cmbAsal.Text:= '';
  rgbJenis.Visible := Purpose IN [ITEM_TYPE_MUTASI_MASUK,ITEM_TYPE_MUTASI_KELUAR];
  txtVc.Clear;
  txtVc.Tag:= 0;
  txtNama.Clear;
  txtCode.Clear;
  txtMerk.Clear;

  if Purpose IN [ITEM_TYPE_MUTASI_MASUK,ITEM_TYPE_MUTASI_KELUAR] then begin
     rgbJenis.ItemIndex := 0;
    rgbJenisClick(Self);
  end;
end;

procedure TfrmTrsItemShipment.InitGrid;
begin
  ResetGrid(grid, 2, 16, 1,1, grid.ColCount-1);
//  grid.Cells[colPrcs, 0]:= IfThen(Purpose = ITEM_TYPE_OPNAME, 'H.Rata2', 'Hrg Beli');
  grid.Cells[colMarkup, 0]:= 'H.Beli';//IfThen(Purpose = ITEM_TYPE_OPNAME, 'H.Beli', 'Markup %');
  grid.Cells[colAmount, 0]:= 'Jumlah';
  ArrangeColSize;
end;

function TfrmTrsItemShipment.isSaved: boolean;
var i: integer;
begin
  Shipment.Clear;
  Shipment.ShipmentMst.ShipId    := lblTransaksi.Tag;
  Shipment.ShipmentMst.Tipe := Purpose;
  Shipment.ShipmentMst.TransDate := dtpTransaction.Date;
  Shipment.ShipmentMst.Notes     := txtNote.Text;
  Shipment.ShipmentMst.Userid    := GlobalSystemUser.UserId;
  case Purpose of
    ITEM_TYPE_MUTASI_MASUK : begin

          Shipment.ShipmentMst.GudangAsal:= cmbAsal.Tag;
          Shipment.ShipmentMst.GudangTujuan:= CompanyProfile.FCurrentBranch;
    end;
    ITEM_TYPE_MUTASI_KELUAR : BEGIN


          Shipment.ShipmentMst.GudangAsal:= CompanyProfile.FCurrentBranch;
          Shipment.ShipmentMst.GudangTujuan:= cmbAsal.Tag;
        
    end;
    else begin
        Shipment.ShipmentMst.GudangAsal:= cmbAsal.Tag;
        Shipment.ShipmentMst.GudangTujuan:= cmbAsal.Tag;
    end;
  end;


  for i:= 1 to grid.RowCount - 1 do begin
    if Purpose = ITEM_TYPE_OPNAME then begin
      if (not IsClear(grid, colItemId, i)) and (grid.Ints[colModID, i] <> 0) then begin
        Shipment.ShipmentDetail_Arr.Add(0,0,
        grid.Ints[colItemId, i],0,IfThen(Purpose=1,grid.Floats[colRangeHide,i] ,grid.Floats[colQty,i]),
        grid.Floats[colSale,i],
        grid.Floats[colMarkup,i],
        grid.Floats[colMarkup,i],0,DB_CR_TYPE_DEBIT,
        grid.Floats[colMarkup,i],grid.Floats[colStok,i],grid.Floats[colQty,i]); //khusu opname diisi hrg beli
      end;
    end


    else if Purpose in [ITEM_TYPE_MUTASI_MASUK,ITEM_TYPE_MUTASI_KELUAR] then begin
      if (not IsClear(grid, colItemId, i))
      and (grid.Floats[colQty, i] <> 0) then begin

        Shipment.ShipmentDetail_Arr.Add(0,0,
        grid.Ints[colItemId, i],0,grid.Floats[colQty,i],
        grid.Floats[colSale,i], grid.Floats[colMarkup,i], grid.Floats[colMarkup,i],0,IfThen(Purpose=ITEM_TYPE_MUTASI_KELUAR, DB_CR_TYPE_CREDIT,DB_CR_TYPE_DEBIT),grid.Floats[colMarkup,i],0,0);
      end;
    end
  end;

  Result:= Shipment.InsertOnDB;
  lblTransaksi.Caption:= Shipment.ShipmentMst.TransNum;
  tbtSave.Enabled:= not Result;
  lblTransaksi.Tag:= Shipment.ShipmentMst.ShipID;
  LoadData;
  btnLoad.Enabled:= lblTransaksi.Tag = 0;
end;

function TfrmTrsItemShipment.isValid: boolean;
var i: integer; valid: boolean;
begin
  Result:= False; valid:= False;
  if (Purpose IN [ITEM_TYPE_MUTASI_MASUK,ITEM_TYPE_MUTASI_KELUAR]) then begin
    for i:= 1 to grid.RowCount-1 do begin
      valid:= not IsClear(grid, colItemId, i);
      if valid then Break;
    end;
  end
  else valid := true;

  if CekInput(Result, cmbAsal.Tag <> 0, 'Gudang asal/Tujuan belum diisi.', cmbAsal) then
     if CekInput(Result, valid , 'Tidak ada item untuk disimpan.', grid) then
//        if Purpose = ITEM_TYPE_MUTASI then begin
  //        if CekInput(Result, (cmbTujuan.Tag <> 0), 'Gudang tujuan belum diisi.', cmbTujuan) then
    //         CekInput(Result, cmbTujuan.Tag <> cmbAsal.Tag, 'Gudang tujuan <> Gudang asal.', cmbTujuan);
//        end;
end;

procedure TfrmTrsItemShipment.LoadData;
var i: integer;amount, grandTotal : Double;
begin
  Shipment.SelectInDB;
  dtpTransaction.Date := Shipment.ShipmentMst.TransDate;
  lblTransaksi.Caption:= Shipment.ShipmentMst.TransNum;
  lblTransaksi.Tag    := Shipment.ShipmentMst.ShipId;
  txtNote.Text        := Shipment.ShipmentMst.Notes;
  rgbJenis.ItemIndex  := Shipment.ShipmentMst.Tipe -2;
  cmbAsal.ItemIndex:= lsGudang.IndexOfName(IntToStr(Shipment.ShipmentMst.GudangAsal));
  if (Purpose IN [ITEM_TYPE_MUTASI_KELUAR]) then
    cmbAsal.ItemIndex:= lsGudang.IndexOfName(IntToStr(Shipment.ShipmentMst.GudangTujuan));
//  cmbTujuan.ItemIndex:= lsGudang.IndexOfName(IntToStr(Shipment.ShipmentMst.GudangTujuan));
  cmbAsalChange(nil);
  

  InitGrid;                                amount := 0;grandTotal :=0;
  for i:= 0 to Shipment.ShipmentDetail_Arr.Count-1 do begin
    grid.Ints[colNo,i+1 ] := i+1;
    grid.Ints[colItemId, i+1]:= Shipment.ShipmentDetail_Arr[i].MstItem.ItemId;
    grid.Cells[colcode,  i+1]:= Shipment.ShipmentDetail_Arr[i].MstItem.ItemCode;
    grid.Cells[colBarcode,  i+1]:= Shipment.ShipmentDetail_Arr[i].MstItem.Barcode;
    grid.Cells[colName,  i+1]:= Shipment.ShipmentDetail_Arr[i].MstItem.ItemName;
    grid.Cells[colUnit,  i+1]:=  Shipment.ShipmentDetail_Arr[i].MstItemConversion.MstMaster.MstName;
    grid.Cells[colMerk,  i+1]:= Shipment.ShipmentDetail_Arr[i].MstItem.Merk;//
    grid.Cells[colStok,   i+1]:= FloatToStrFmt(Shipment.ShipmentDetail_Arr[i].Stok);// MstItem.CurrentStock);
    grid.Cells[colSale,  i+1]:= FloatToStrFmt(Shipment.ShipmentDetail_Arr[i].PriceSales);
   // if Purpose = ITEM_TYPE_OPNAME then
     // grid.Cells[colPrcs,  i+1]:= FloatToStrFmt(Shipment.ShipmentDetail_Arr[i].MstItem.AvgPrice)
    //else
//     grid.Cells[colPrcs,  i+1]:= FloatToStrFmt(Shipment.ShipmentDetail_Arr[i].PricePurchase);
    grid.Cells[colMarkup,i+1]:= FloatToStrFmt(Shipment.ShipmentDetail_Arr[i].PricePurchase);
    if Purpose = ITEM_TYPE_OPNAME then
      grid.Cells[colQty,   i+1]:= FloatToStrFmt(Shipment.ShipmentDetail_Arr[i].QuantityOri)
    else
      grid.Cells[colQty,   i+1]:= FloatToStrFmt(Shipment.ShipmentDetail_Arr[i].Quantity);  
    grid.Cells[colRange,   i+1]:= FloatToStrFmt(Shipment.ShipmentDetail_Arr[i].Quantity);
    amount :=Shipment.ShipmentDetail_Arr[i].Quantity * Shipment.ShipmentDetail_Arr[i].PricePurchase;
    grandTotal := grandTotal + amount;
    grid.Cells[colAmount, i+1] := FloatToStrFmt(amount);
    grid.AddRow;
  end;
  DeleteRowTerakhir(grid, 2, 1);
  ArrangeColSize;

  txtTotal.Text := FloatToStrFmt(grandTotal);
  tbtSave.Enabled  := lblTransaksi.Tag = 0;
  dtpTransaction.Enabled:= lblTransaksi.Tag = 0;
  txtNote.Enabled  := lblTransaksi.Tag = 0;
  tbtDelete.Enabled:= lblTransaksi.Tag = 0;
  btnLoad.Enabled  := lblTransaksi.Tag = 0;
end;

procedure TfrmTrsItemShipment.gridCanEditCell(Sender: TObject;
  ARow, ACol: Integer; var CanEdit: Boolean);
begin
  CanEdit:=
  (((ACol in [colCode,colBarcode, colQty,  colMarkup, colSale])
  and (grid.ColWidths[ACol] <> 0) and (grid.Ints[colItemId, ARow] > 0))
  or (ACol in [colCode,colBarcode]))
  and (lblTransaksi.Tag = 0);
end;

procedure TfrmTrsItemShipment.gridCellValidate(Sender: TObject;
  Col, Row: Integer; var Value: String; var Valid: Boolean);
begin
  case Col of
    colCode,colBarcode: begin
      tbtSave.Enabled:= True;
      grid.Ints[colModID, Row]:= 1;
    end;

    colMarkup:
    begin
      Valid:= True; //Value <> '';
      if not Valid then begin
        grid.Col:= Col;
        grid.Row:= Row;
        exit;
      end;
      if Purpose <> ITEM_TYPE_OPNAME then
        grid.Floats[colSale, Row]:= grid.Floats[colMarkup, Row] +
          (grid.Floats[colMarkup, Row] * (StrToFloatDef(Value,0)/100));
          
      Value:= FloatToStrFmt(StrToFloatDef(Value,0));
      grid.Ints[colModID, Row]:= 1;
    end;

    {colPrcs:
    begin
      Valid:= True;//Value <> '';
      if not Valid then begin
        grid.Col:= Col;
        grid.Row:= Row;
        exit;
      end;
      grid.Ints[colModID, Row]:= 1;
    end;
     }
    colQty:
    begin
      Valid:=Value <> '';
      if not Valid then begin
        Inform('Inputan belum diisi.');
        grid.Col:= Col;
        grid.Row:= Row;
        exit;
      end else
      begin
        if Purpose = ITEM_TYPE_OPNAME then
          grid.Cells[colRangeHide, Row]:=   FloatToStrFmt(
              StrFmtToFloatDef(grid.Cells[colQty, Row], 0) -
              StrFmtToFloatDef(grid.Cells[colStok,Row], 0));
         if Purpose = ITEM_TYPE_MUTASI_KELUAR then begin
            if (StrFmtToFloatDef(grid.Cells[colQty, Row], 0)>StrFmtToFloatDef(grid.Cells[colStok,Row], 0)) then begin
              Alert('Jumlah tidak boleh melebihi stok yang ada');
              Value := '0';
              grid.Col:= Col;
              grid.Row:= Row;
              exit;
            end;

         end;
        Value:= FloatToStrFmt(StrToFloatDef(Value,0));
        grid.Ints[colModID, Row]:= 1;
      end;
    end;
  end;
end;

procedure TfrmTrsItemShipment.gridGetAlignment(Sender: TObject;
  ARow, ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  if (ACol in[colNo, colStok, colQty,colRange, colRangeHide,  colMarkup, colSale,colAmount]) then HAlign:= taRightJustify
end;

procedure TfrmTrsItemShipment.gridGetEditorType(Sender: TObject;
  ACol, ARow: Integer; var AEditor: TEditorType);
begin
  case ACol of
    colQty: AEditor:= edPositiveNumeric;
  {  colUnit: begin
      AEditor:= edComboList;
      TMstItemConversionArr.getList(ListUnit, grid.Ints[colItemId, ARow], grid.Combobox.Items);
    end;}
  end;
end;

procedure TfrmTrsItemShipment.gridKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var vId: Integer; value: string;
begin
  case key of
    VK_RETURN:
    begin
      if (grid.Col in [colCode,colBarcode]) and (grid.Ints[colModID, grid.Row] = 1) then begin
         value:= grid.Cells[colBarcode, grid.Row];
         getItem(value, 0, grid.Row);
      end;
      GoNextColumn(Sender);
    end;

    VK_ADD : getUnitList;

    vk_F2  :
    begin
       vId:= frmLookup.ExecuteItem(0, 0, 0);
       if vId > 0 then getItem('', vId, grid.Row);
    end;

    VK_F3  : if dtpTransaction.Enabled then dtpTransaction.SetFocus;
  end;
end;

procedure TfrmTrsItemShipment.dtpTransactionKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    vk_return : GoNextControl(Self, (Sender as TWinControl), True, True, False).SetFocus;

    VK_F4:
    begin
      grid.SetFocus;
      grid.Row:= 1;
      grid.Col:= colBarcode;
    end;
  end;
end;

procedure TfrmTrsItemShipment.tbtNewClick(Sender: TObject);
var tag : integer;
begin
  tag := IfThen(Purpose=ITEM_TYPE_OPNAME,323,322);
  if not TSystemAccess.isCan(CAN_ADD,tag) then exit;
   lblTransaksi.Tag:= 0;
  InitForm(0);
  tbtSave.Enabled:= True;
  lblTransaksi.Caption:= '[Nomor Transaksi]';
  dtpTransaction.SetFocus
end;

procedure TfrmTrsItemShipment.tbtSaveClick(Sender: TObject);
begin
  if isValid then isSaved 
end;

procedure TfrmTrsItemShipment.tbtDeleteClick(Sender: TObject);
begin

  case lblTransaksi.Tag of
    0:begin
        grid.ClearRows(grid.Row, 1);
        if grid.RowCount > 2 then
        grid.RemoveRows(grid.Row, 1);
      end
    else
      begin
        {grid.ClearRows(grid.Row, 1);
        if grid.RowCount > 2 then
          grid.RemoveRows(grid.Row, 1);

        Shipment.ShipmentMst.ShipId := txtNoTransaksi.Tag;
        Shipment.ShipmentMst.Userid := GlobalSystemUser.UserId;

        //if not Shipment.DeleteDetail(grid.Row-1) then
         // LoadData;
         }
      end;
   end;

end;

procedure TfrmTrsItemShipment.Execute(vPurpose, id: integer);
begin
  inherited;
  ToolBar1.ParentColor:= false;
  ToolBar1.Color:= clWhite;

  Purpose:= vPurpose;
  if Purpose = ITEM_TYPE_OPNAME then
    tbtPrint.DropdownMenu := PopupMenu1
  else
    tbtPrint.DropdownMenu := nil;
  InitForm(id);
//  tbt.Visible:= (Purpose = ITEM_TYPE_OPNAME);
  Run(Self);
end;

procedure TfrmTrsItemShipment.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  if MstItem <> nil then MstItem.Free;
  MstItem:= nil;
  
  if Shipment <> nil then Shipment.Free;
  Shipment:= nil;
  if ListUnit <> nil then ListUnit.Free;
  ListUnit:= nil;
end;

procedure TfrmTrsItemShipment.gridKeyPress(Sender: TObject;
  var Key: Char);
begin
  if grid.Col = colQty then
    if key = #46 then key := #44;
end;

procedure TfrmTrsItemShipment.btnSpecClick(Sender: TObject);
begin
  getItemTipe;
end;

procedure TfrmTrsItemShipment.txtSpecKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_F2: getItemTipe;
  end;
end;

procedure TfrmTrsItemShipment.getItemTipe;
var ID: integer;
begin
  ID:= frmMstCodeList.Execute(1);
  if ID <> 0 then begin
    txtSpec.Tag := ID;
    txtSpec.Text:= TMstCode.getName(ID);
  end;
end;

procedure TfrmTrsItemShipment.LoadDataItem;
var MstItemArr: TMstItemArr; i: integer;
begin
  if cmbAsal.Tag=0 then begin
    Inform('Gudang asal belum diisi');
    Exit;
  end;
  try
    Screen.Cursor:= crHourGlass;
    StartProgress;
    MstItemArr:= TMstItemArr.Create();
    InitGrid;
    GlobalFilter.Reset;
    GlobalFilter.SpecID:= txtSpec.Tag;
    GlobalFilter.RelasiID:= txtVc.Tag;
    GlobalFilter.Name:= txtNama.Text;
    GlobalFilter.FString1:= txtMerk.Text;
    GlobalFilter.FString2:= txtCode.Text;

    MstItemArr.LoadFromStock;

    if MstItemArr.Count > 0 then grid.RowCount:= MstItemArr.Count + 2;
    for i:= 0 to MstItemArr.Count-1 do begin

      ProsesProgress(i, MstItemArr.Count);
//      detail.Reset;
  //    detail.ItemId:= MstItemArr[i].ItemId;
   //   detail.SelectInDB3;

      //if GlobalSystemConfig[CONF_INVENTORY-1].ConfValue = '-1' then
      MstItemArr[i].CurrentStock:= TMstItem.GetSaldoAkhir(MstItemArr[i].ItemId, cmbAsal.Tag, dtpTransaction.Date);
      grid.Ints[colNo,      i+1]:= i+1;
      grid.Ints[colItemId,  i+1]:= MstItemArr[i].ItemId;
     // grid.Ints[colConvId,  i+1]:= detail.ConvId;
      grid.Cells[colcode,   i+1]:= MstItemArr[i].ItemCode;
      grid.Cells[colBarcode,   i+1]:= MstItemArr[i].Barcode;
      grid.Cells[colName,   i+1]:= MstItemArr[i].ItemName;
      grid.Cells[colMerk,   i+1]:= MstItemArr[i].Merk;
      grid.Cells[colUnit,   i+1]:= TMstMaster.getKode(MstItemArr[i].KemasanID);

      grid.Cells[colStok,   i+1]:= FloatToStrFmt(MstItemArr[i].CurrentStock);
 //     grid.Cells[colConv,   i+1]:= FloatToStrFmt(detail.Conversion);
      grid.Cells[colMarkup, i+1]:= FloatToStrFmt(MstItemArr[i].BuyingPrice);
      grid.Cells[colSale, i+1] := FloatToStrFmt(MstItemArr[i].SellingPrice);
//      if Purpose = ITEM_TYPE_OPNAME then
 //       grid.Cells[colPrcs,   i+1]:= FloatToStrFmt(MstItemArr[i].AvgPrice)
  //    else grid.Cells[colPrcs,   i+1]:= FloatToStrFmt(detail.PurchasePrice);
//      grid.Cells[colSale,   i+1]:= FloatToStrFmt(detail.SalesPrice);

    end;
    grid.SetFocus;
    grid.Col:= colQty;
    grid.Row:= 1;

//    detail.Free;
    MstItemArr.Free;
    ArrangeColSize;
    EndProgress;
  finally
    Screen.Cursor:= crDefault;
  end;
end;

procedure TfrmTrsItemShipment.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_F3: if dtpTransaction.Enabled then dtpTransaction.SetFocus;
    VK_F4:
    begin
      grid.SetFocus;
      grid.Row:= 1;
      grid.Col:= colBarcode;
    end;
  end;
end;

procedure TfrmTrsItemShipment.getUnit(Sender: TObject);
var ARow: Integer; MstUnit: TMstItemConversion;
begin
  ARow:= grid.Row;
  MstUnit:=TMstItemConversion.Create;
  MstUnit.Reset;
  MstUnit.ConvId:= (Sender as TMenuItem).Tag;
  if MstUnit.SelectInDB then begin
    grid.Cells[colUnit,  ARow]:= MstUnit.MstMaster.MstCode;
    ReplaceSaldo(grid.Ints[colItemId, ARow], ARow, MstUnit.Conversion);
  end;
  ArrangeColSize;
  MstUnit.Free;
end;

procedure TfrmTrsItemShipment.getUnitList;
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
  SetCursorPos((points.X + rect.Left), (points.Y + (rect.Top)) - 70);

  PopUnit.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y);
  PopUnit.FreeOnRelease;
end;

procedure TfrmTrsItemShipment.InitForm(id: integer);
begin

  ListUnit:= TStringList.Create;
  lsGudang:= TStringList.Create;
  MstItem := TMstItem.Create;
  Shipment:= TTrsShipment.Create;
  txtTotal.Clear;
//  TMstMaster_Arr.GetList(lsGudang, MST_TYPE_GUDANG);
  TMstBranch.getList(lsGudang,True);
  NameValueListToValueList(lsGudang, cmbAsal.Items);
//  NameValueListToValueList(lsGudang, cmbTujuan.Items);
  ResetForm;
  lblTransaksi.Caption:= '[Nomor Transaksi]';
  lblTransaksi.Tag:= id;
  Shipment.ShipmentMst.ShipId:= id;
  dtpTransaction.Enabled := id  = 0;
  cmbAsal.ItemIndex := lsGudang.IndexOfName(IntToStr(CompanyProfile.FCurrentBranch));
  cmbAsalChange(nil);
  cmbAsal.Enabled := Purpose in [ITEM_TYPE_MUTASI_MASUK,ITEM_TYPE_MUTASI_KELUAR];
   case Purpose of

    ITEM_TYPE_OPNAME : begin
      Self.Caption:= 'Transaksi Penyesuaian Stok';
    end;
    ITEM_TYPE_MUTASI_MASUK : begin
      Self.Caption:= 'Transaksi Mutasi Masuk Barang';

    end;

    ITEM_TYPE_MUTASI_KELUAR : begin
      Self.Caption:= 'Transaksi Mutasi Keluar Barang';

    end;
  end;
  
  if lblTransaksi.Tag <> 0 then LoadData;
  btnLoad.Enabled:= lblTransaksi.Tag = 0;
end;

procedure TfrmTrsItemShipment.cmbAsalChange(Sender: TObject);
//var i: integer;
begin
  cmbAsal.Tag:= 0;
  if cmbAsal.ItemIndex > -1 then begin
     cmbAsal.Tag:= StrToInt(lsGudang.Names[cmbAsal.ItemIndex]);
  //   for i:= 1 to grid.RowCount-1 do
//    if grid.Ints[colItemID, i] <> 0 then
   //   ReplaceSaldo(grid.Ints[colID, i], i, 0);
  end;
end;

procedure TfrmTrsItemShipment.btnLoadClick(Sender: TObject);
begin
  if (Purpose = ITEM_TYPE_OPNAME) then
    LoadDataFormOpname
  else begin
    LoadDataItem;
    grid.SetFocus;
    grid.Row:= 1;
    grid.Col:= colQty;
  end;

end;

procedure TfrmTrsItemShipment.Button2Click(Sender: TObject);
var id: integer;
begin
  id:= frmLookup.Execute('SPL');
  if Id > 0 then begin
    txtVc.Text:= TMstRelation.GetName(id);
    txtVc.Tag:= id;
  end;
end;

procedure TfrmTrsItemShipment.ReplaceSaldo(itemID, row: integer; newKonversi: double);
var saldo: double;
begin
  //satuan stock
  saldo:= TMstItem.GetSaldoAkhir(itemID, cmbAsal.Tag, dtpTransaction.Date);
  grid.Cells[colStok, row]:= FloatToStrFmt(saldo / newKonversi);
  grid.Cells[colRangeHide, row]:= FloatToStrFmt(
    StrFmtToFloatDef(grid.Cells[colQty, row], 0) -
    StrFmtToFloatDef(grid.Cells[colStok,row], 0));
end;

procedure TfrmTrsItemShipment.dtpTransactionChange(Sender: TObject);
var i: integer;
begin
  for i:= 1 to grid.RowCount-1 do
  if grid.Ints[colID, i] <> 0 then
    ReplaceSaldo(grid.Ints[colItemID, i], i, 0);

end;

{procedure TfrmTrsItemShipment.LoadDataFormOpname;
var i,j,k, row, no_urut: integer; listMaster, listChild: TStringList;
  item: TMysqlResult; header: string;
begin

  InitGrid;
  GlobalFilter.Reset;
  GlobalFilter.SpecID:= txtSpec.Tag;
  GlobalFilter.RelasiID:= txtVc.Tag;
  GlobalFilter.Name:= txtNama.Text;
  GlobalFilter.FString1:= txtBarcode.Text;
  GlobalFilter.FString2:= txtCode.Text;

  listMaster:= TStringList.Create();
  listChild:= TStringList.Create();
  GlobalStringList.Clear;
  grid.ColWidths[colBarcode]:= 100;
  grid.ColWidths[colName]:= 220;

  no_urut:= 1;

  SQLToNameValueList(listMaster,
  'select m.code_id, m.code_name from mst_code m, point_maping p '+
  'where m.code_id = p.code_id and p.root_id = '+IntToStr(txtSpec.Tag)+
  ' and m.parent_id = p.root_id order by m.code_name ');

  if listMaster.Count = 0 then
  SQLToNameValueList(listMaster,
  'select m.code_id, m.code_name from mst_code m, point_maping p '+
  'where m.code_id = p.code_id and p.root_id = '+IntToStr(txtSpec.Tag)+
  ' order by m.code_name ');

  for i:= 0 to listMaster.Count-1 do begin

    SQLToNameValueList(listChild,
    'select m.code_id, m.code_name from mst_code m, point_maping p '+
    'where m.code_id = p.code_id and p.root_id = '+listMaster.Names[i]+
    ' and m.parent_id = p.root_id order by m.code_name ');


    if listChild.Count = 0 then
    SQLToNameValueList(listChild,
    'select m.code_id, m.code_name from mst_code m, point_maping p '+
    'where m.code_id = p.code_id and p.root_id = '+listMaster.Names[i]+
    '  order by m.code_name ');
    header:= listMaster.Values[listMaster.Names[i]];

    for j:= 0 to listChild.Count-1 do begin
      GlobalFilter.SpecID:= StrToInt(listChild.Names[j]);
      item:= TMstItemArr.LoadFormOpname;

      if item.RecordCount > 0 then begin
        row:= grid.RowCount-1;
        grid.MergeCells(colBarcode, row, 2,1);
        grid.Cells[colBarcode, row]:= '['+ header +' - '+ listChild.Values[listChild.Names[j]] +']';
      end;

     //0item_id, 1barcode, 2item_name, 3current_stock, 4avg_price, 5conv_id, 6conversion, 7mst_code
      if item.RecordCount > 0 then
      for k:= 0 to item.RecordCount-1 do begin
         grid.AddRow;
         row:= grid.RowCount-1;
         grid.Ints[colNo,      row]:= no_urut;
         grid.Ints[colItemId,  row]:= BufferToInteger(item.FieldValue(0));
         grid.Ints[colConvId,  row]:= BufferToInteger(item.FieldValue(5));
         grid.Cells[colBarcode,   row]:= item.FieldValue(1);
         grid.Cells[colName,   row]:= item.FieldValue(2);
         grid.Cells[colUnit,   row]:= item.FieldValue(7);
         grid.Cells[colPrcs,   row]:= FloatToStrFmt(BufferToFloat(item.FieldValue(4)));
         grid.Floats[colConv,  row]:= BufferToFloat(item.FieldValue(6));
         grid.Cells[colStok,   row]:= FloatToStrFmt(TMstItem.GetSaldoAkhir(BufferToInteger(item.FieldValue(0)), cmbAsal.Tag, dtpTransaction.Date));
         item.MoveNext;
         Inc(no_urut);
      end;

      if item.RecordCount > 0 then begin
        grid.AddRow; grid.AddRow;
      end;
      item.destroy;
    end;
  end;
  listMaster.Free;
  listChild.Free;

  grid.AutoSizeCol(colNo);
end;   }

procedure TfrmTrsItemShipment.LoadDataFormOpname;
var row, no_urut: integer;
  item: TMysqlResult;
 // header: string; HaveHeader: boolean;

  function loads(induk: integer): TMysqlResult;
  begin
    Result:= OpenSQL('select code_id, code_name from mst_code where parent_id = '+IntToStr(induk)+
    ' order by code_name');
  end;

  procedure load_child(KlasNama: string; KlasID, induk: integer);
  var Child: TMysqlResult;
    i, k: integer;
  begin

    GlobalFilter.SpecID:= KlasID;
    item:= TMstItemArr.LoadFormOpnameX;

    if item.RecordCount > 0 then begin
       row:= grid.RowCount-1;
       grid.MergeCells(colcode, row, 3,1);
       //grid.Cells[colBarcode, row]:= IfThen(HaveHeader, '[' + header + ' - ' + KlasNama + ']', KlasNama);
       grid.Cells[colcode, row]:= KlasNama;
    end;

   //0item_id, 1barcode, 2item_name, 3current_stock, 4avg_price, 5conv_id, 6conversion, 7mst_code,8buyingprice,9merk,10item_code
    if item.RecordCount > 0 then
    for k:= 0 to item.RecordCount-1 do begin
       ProsesProgress(k, item.RecordCount);
       grid.AddRow;
       row:= grid.RowCount-1;
       grid.Ints[colNo,      row]:= no_urut;
       grid.Ints[colItemId,  row]:= BufferToInteger(item.FieldValue(0));
       grid.Cells[colcode,   row]:= item.FieldValue(10);
       grid.Cells[colBarcode,   row]:= item.FieldValue(1);
       grid.Cells[colName,   row]:= item.FieldValue(2);
       grid.Cells[colUnit,   row]:= item.FieldValue(7);
//       grid.Cells[colPrcs,   row]:= FloatToStrFmt(BufferToFloat(item.FieldValue(4)));
       grid.Cells[colMarkup, row]:= FloatToStrFmt(BufferToFloat(item.FieldValue(8)));
       grid.Cells[colStok,   row]:= FloatToStrFmt(BufferToFloat(item.FieldValue(3)));//TMstItem.GetSaldoAkhir(BufferToInteger(item.FieldValue(0)), cmbAsal.Tag, dtpTransaction.Date));
       grid.Cells[colMerk,   row]:= item.FieldValue(9);
       item.MoveNext;
       Inc(no_urut);
    end;

    if item.RecordCount > 0 then begin
      grid.AddRow; grid.AddRow;
    end;
    item.destroy;

    Child:= loads(induk);
    if Child.RecordCount > 0 then begin
      for i:= 0 to Child.RecordCount-1 do begin
        KlasID  := BufferToInteger(Child.FieldValue(0));
        KlasNama:= child.FieldValue(1);
        load_child(KlasNama, KlasID, KlasID);

        Child.MoveNext;
      end;
    end;
    Child.destroy;
  end;

begin
  try
     StartProgress;
     InitGrid;

     GlobalFilter.Reset;
     GlobalFilter.SpecID:= txtSpec.Tag;
     GlobalFilter.RelasiID:= txtVc.Tag;
     GlobalFilter.Name:= txtNama.Text;
     GlobalFilter.FString1:= txtMerk.Text;
     GlobalFilter.FString2:= txtCode.Text;

     grid.ColWidths[colBarcode]:= 100;
     grid.ColWidths[colName]:= 220;

     no_urut:= 1;
     load_child(txtSpec.Text, txtSpec.Tag, txtSpec.Tag);
     grid.AutoSizeCol(colNo);

     if grid.RowCount > 4 then grid.RemoveRows(grid.RowCount-2, 2);
  finally
  ArrangeColSize;
    EndProgress;
  end;
end;

procedure TfrmTrsItemShipment.gridGetCellColor(Sender: TObject; ARow,
  ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin
  if (Purpose = ITEM_TYPE_OPNAME) then
  if grid.IsMergedCell(ACol, ARow) then
    AFont.Style:= AFont.Style + [fsBold];
end;

procedure TfrmTrsItemShipment.tbtPrintClick(Sender: TObject);
begin
 if Purpose in [ITEM_TYPE_MUTASI_MASUK, ITEM_TYPE_MUTASI_KELUAR] then begin
    printOrder(lblTransaksi.Tag);
 end
 else begin
    GlobalPeriode.setPeriode(0, dtpTransaction.Date, dtpTransaction.Date);
    try
      Application.CreateForm(TqrpFormOpname, qrpFormOpname);
      qrpFormOpname.Executes(grid);
    finally
      qrpFormOpname.Destroy;
    end;
  end;
end;

procedure TfrmTrsItemShipment.FormShow(Sender: TObject);
begin
  if dtpTransaction.Enabled then dtpTransaction.SetFocus;
end;

procedure TfrmTrsItemShipment.rgbJenisClick(Sender: TObject);
begin
  inherited;
  lblGudang.Caption := IfThen(rgbJenis.ItemIndex=0,'Dari :','Tujuan :');
  Purpose := IfThen(rgbJenis.ItemIndex=1,ITEM_TYPE_MUTASI_KELUAR,ITEM_TYPE_MUTASI_MASUK);
end;

function TfrmTrsItemShipment.printFooter(value: TStringList; idx,
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

function TfrmTrsItemShipment.printHeader(value: TStringList;
  _buffer: TMysqlResult; hal: integer; onlyColumnHeader: boolean): integer;
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

  //header;
   printBitmap(imgLogo.Picture.Bitmap,
      Bold('          MUTASI '+IfThen(BufferToInteger(_buffer.FieldValue(13))=ITEM_TYPE_MUTASI_MASUK,'MASUK','KELUAR')),RAWPrinter1,value);

if not onlyColumnHeader then begin
    {value.Append(
      FixWidth(' ', 5, taLeftJustify)+
      FixWidth(Bold('MUTASI '+IfThen(Purpose=ITEM_TYPE_MUTASI_MASUK,'MASUK','KELUAR')), PAPER_WIDTH , taCenter));
     }

    value.Append(
      FixWidth(' ', 5, taLeftJustify)+
      FixWidth('Nomor Trx', 10, taLeftJustify) +
      FixWidth(':', 2, taCenter)+
      FixWidth(' '+BufferToString(_buffer.FieldValue(0)), 70, taLeftJustify)+
      FixWidth( 'Dari', 6, taLeftJustify) +
      FixWidth(':', 2, taCenter)+
      FixWidth(' '+BufferToString(_buffer.FieldValue(2))+'-'+BufferToString(_buffer.FieldValue(3)), 40, taLeftJustify)
      );

    value.Append(
      FixWidth(' ', 5, taLeftJustify)+
      FixWidth('Tanggal', 10, taLeftJustify) +
      FixWidth(':', 2, taCenter)+
      FixWidth(' '+FormatDateTime(ShortDateFormat,BufferToDateTime(_buffer.FieldValue(1))), 70, taLeftJustify)+
      FixWidth( 'Tujuan', 6, taLeftJustify) +
      FixWidth(':', 2, taCenter)+
      FixWidth(' '+BufferToString(_buffer.FieldValue(4))+'-'+BufferToString(_buffer.FieldValue(5)), 40, taLeftJustify));
 

 
    value.Append(
      FixWidth(' ', 5, taLeftJustify)+
      FixWidth('Keterangan', 10, taLeftJustify) +
      FixWidth(':', 2, taCenter)+
      FixWidth(' '+BufferToString(_buffer.FieldValue(10)), 54, taLeftJustify));
  end;//;onlyColumnHeader

  value.Append(
    FixWidth(' ', 5, taLeftJustify) +
    FixWidth(GARIS, PAPER_WIDTH-5, taCenter));

  value.Append(
      FixWidth(' ', 5, taLeftJustify) +
      FixWidth('NO ', 5, taLeftJustify) +
      FixWidth('KODE', 6, taLeftJustify) +
      FixWidth('NAMA BARANG', PAPER_WIDTH - 90, taLeftJustify)+
      FixWidth('QUANTITY', 15, taRightJustify) +
      FixWidth('SATUAN', 10, taRightJustify) +
      FixWidth('H.BELI', 15, taRightJustify) +
      FixWidth('H.JUAL', 15, taRightJustify) +
      FixWidth('JUMLAH', 15, taRightJustify)); //+    FixWidth('KETERANGAN', 15, taRightJustify)

  value.Append(
    FixWidth(' ', 5, taLeftJustify) +
    FixWidth(GARIS, PAPER_WIDTH-5, taCenter));
end;

procedure TfrmTrsItemShipment.printOrder(ID: integer);
var i: integer; ls: TStringList;
   buffer: TMysqlResult;

   insertedIdx, rowCount, range,
   halaman, footer_printed: integer;
   total : Double;
const
  max_row       = 39;//28;
  title_count   = 8;
  summery_count = 6;
  footer_count  = 2;

begin
  ls:= TStringList.Create;

  buffer:= TTrsShipment.PrintMutasi(ID);
 total := 0;
  {0 m.trans_num,1m.trans_date,2g.branch_code,3g.branch_name,4g2.branch_code,
  5g2.branch_name,  6i.item_code,7i.item_name,8d.quantity,9u.mst_code,10m.notes
    11d.price_purchase,12(d.quantity * d.price_purchase),13tipe,14.price_sales}
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
        FixWidth(BufferToString(buffer.FieldValue(6)), 6, taLeftJustify) + //kode
        FixWidth(BufferToString(buffer.FieldValue(7)), PAPER_WIDTH - 90, taLeftJustify)+ //nama
        FixWidth(
        FormatFloat('#,##0', BufferToFloat(buffer.FieldValue(8))), 15, taRightJustify) +  //quantity
        FixWidth(BufferToString(buffer.FieldValue(9)), 10, taRightJustify) +
        FixWidth(FormatFloat('#,##0.#0', BufferToFloat(buffer.FieldValue(11))), 15, taRightJustify) +//harga
        FixWidth(FormatFloat('#,##0.#0', BufferToFloat(buffer.FieldValue(14))), 15, taRightJustify) +//harga jual
       // FixWidth(FormatFloat('#,##0.#0', BufferToFloat(buffer.FieldValue(11))), 15, taRightJustify) +//discount
        FixWidth(FormatFloat('#,##0.#0', BufferToFloat(buffer.FieldValue(12))), 15, taRightJustify));//amount
//         FixWidth(BufferToString(buffer.Fields[9].Value), 15, taLeftJustify) );
         total := total +  BufferToFloat(buffer.FieldValue(12));
      buffer.MoveNext;
    end;

    buffer.First;

    ls.Append(
      FixWidth(' ', 5, taLeftJustify) +
      FixWidth(GARIS, PAPER_WIDTH-5, taCenter));

{    ls.Append(
      FixWidth(' ', 5, taLeftJustify) +
      FixWidth(' ', 20, taCenter)+
      FixWidth('TOTAL', PAPER_WIDTH - 52, taRightJustify) +
      FixWidth(' :', 2, taLeftJustify) +                          //17
      FixWidth(FormatFloat('#,##0.#0', BufferToFloat(buffer.FieldValue(6))), 25, taRightJustify));
 }
{   ls.Append(
     FixWidth(' ', 5, taLeftJustify) +
      FixWidth(' ', 20, taCenter)+
      FixWidth('DISCOUNT', PAPER_WIDTH - 52, taRightJustify) +
      FixWidth(' :', 2, taLeftJustify) +
      FixWidth(FormatFloat('#,##0.#0', BufferToFloat(buffer.FieldValue(13))), 25, taRightJustify));


 }

  ls.Append(
      FixWidth(' ', 5, taLeftJustify) +
      FixWidth(' ', 5, taLeftJustify) +
      FixWidth(' ', 6, taLeftJustify) +
      FixWidth(' ', PAPER_WIDTH - 75, taLeftJustify)+
      FixWidth(' ', 15, taRightJustify) +
      FixWidth(' ', 10, taRightJustify) +
      FixWidth('TOTAL :', 15, taRightJustify) +
      FixWidth(FormatFloat('#,##0.#0', total), 15, taRightJustify)); //+    FixWidth('KETERANGAN', 15, taRightJustify)

    {
    ls.Append(
      FixWidth(' ', 5, taLeftJustify) +
      FixWidth(' ', 20, taCenter)+
      FixWidth('TOTAL', PAPER_WIDTH - 52, taRightJustify) +
      FixWidth(' :', 2, taLeftJustify) +
      FixWidth(FormatFloat('#,##0.#0', total), 25, taRightJustify));
     }


    if ((insertedIdx = 0) or (halaman-1 > footer_printed)) then
    begin
      ls.Append(' ');
      ls.Append(' ');
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

  for i := 0 to 4 do
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

procedure TfrmTrsItemShipment.f2Click(Sender: TObject);
begin
  inherited;
  try
      Application.CreateForm(TqrpFormOpname, qrpFormOpname);
      qrpFormOpname.Executes(grid);
    finally
      qrpFormOpname.Destroy;
    end;
end;

procedure TfrmTrsItemShipment.f1Click(Sender: TObject);
begin
  inherited;
try
      Application.CreateForm(TqrpDraftOpname, qrpDraftOpname);
      qrpDraftOpname.Executes(grid);
    finally
      qrpDraftOpname.Destroy;
    end;
end;

end.
