unit trsSales;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, BaseGrid, AdvGrid, SUIImagePanel, ComCtrls, ToolWin,
  ExtCtrls, StdCtrls, AdvEdit,
  strUtils, Math, UMaster, UTransaction, WinXP, Menus,
  frmDockForm, RAWPrinter;

type
  TfrmTrsSales = class(TDockForm)
    ToolBar1: TToolBar;
    tbtHold: TToolButton;
    tbtRecall: TToolButton;
    suiPanel2: TsuiPanel;
    asgSales: TAdvStringGrid;
    Panel1: TPanel;
    ToolButton6: TToolButton;
    tbtReport: TToolButton;
    tbtOption: TToolButton;
    tbtLogOff: TToolButton;
    tbtExit: TToolButton;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    tbtOpen: TToolButton;
    ToolButton13: TToolButton;
    suiPanel3: TsuiPanel;
    lblTransaksi: TLabel;
    lblQty: TLabel;
    lblCustomer: TLabel;
    lblTotal: TLabel;
    lblCasierUser: TLabel;
    Panel2: TPanel;
    txtEntry: TEdit;
    Image1: TImage;
    imgCashierRight: TImage;
    lblSubTotal: TLabel;
    Bevel1: TBevel;
    Label1: TLabel;
    Bevel2: TBevel;
    lblDiscRp: TLabel;
    Label3: TLabel;
    lblDisc: TLabel;
    lblTax: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    Bevel5: TBevel;
    lblGrangTotal: TLabel;
    Label9: TLabel;
    lblPoint: TLabel;
    lblMember: TLabel;
    RAWPrinter1: TRAWPrinter;
    procedure txtSubtotalValueValidate(Sender: TObject; value: String;
      var IsValid: Boolean);
    procedure txtSubtotalEnter(Sender: TObject);
    procedure asgSalesKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure txtEntryKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure tbtHoldClick(Sender: TObject);
    procedure tbtRecallClick(Sender: TObject);
    procedure asgSalesGetAlignment(Sender: TObject; ARow, ACol: Integer;
      var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure asgSalesRowChanging(Sender: TObject; OldRow, NewRow: Integer;
      var Allow: Boolean);
    procedure tbtNewClick(Sender: TObject);
    procedure tbtExitClick(Sender: TObject);
    procedure tbtLogOffClick(Sender: TObject);
    procedure tbtOpenClick(Sender: TObject);
    procedure ToolButton13Click(Sender: TObject);
    procedure tbtReportClick(Sender: TObject);
    procedure tbtOptionClick(Sender: TObject);
    procedure asgSalesGetCellBorder(Sender: TObject; ARow, ACol: Integer;
      APen: TPen; var Borders: TCellBorders);
    procedure FormShow(Sender: TObject);
    procedure txtEntryKeyPress(Sender: TObject; var Key: Char);
    procedure asgSalesClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure lblCasierUserClick(Sender: TObject);
  private
    MstItem: TMstItem;
    Sales: TTrsSales;
    lsEscapeCode: TStringList;
    tunai: double;
    registered: boolean;
    JENIS_CUSTOMER, RELASI_ID, CURRENT_POINT: INTEGER;
    procedure RequeryTaxDisc;
    procedure Calculate(xrow: integer);
    procedure ChangeQty();
    procedure ChangeHarga();
    procedure RemoveRow();
    procedure IncreaseQty();
    procedure DecreaseQty();
    procedure RowMoveUp(var Key: Word; Shift: TShiftState);
    procedure RowMoveDown(var Key: Word; Shift: TShiftState);
    procedure SeekItem;
    procedure EndTransaction;
    procedure DiscountPercent;
    procedure DiscountRupiah;
    procedure DiscountTax;
//    procedure ResettingHarga(xRow: integer);
    procedure ApplliedProdukItem(xRow: integer);
    procedure ApplliedProdukItem2(xRow: integer); //jika barang udah ada, customer baru dimasukan
    procedure ApplliedProdukTotal;

    procedure InitGrid;
    procedure InitForm; reintroduce;
    procedure SetDisableEnable;
    procedure getItem(AItemCode: string; AItemID, isPaket: integer; AQty: double);

    function ekstraksEntry(input: string): string;
    function isValid: boolean;
    function SaveHolded(): boolean;
    function LoadHolded(id:integer): boolean;
    function jumlahkanPoint: integer;
    procedure ReadRegLocalMachine();
    procedure RePrintLastTrans();
    procedure showInfo;
//    procedure ChangeUnits;
    procedure ChangeCustomerTipe;

    procedure HoldedTrx;
    procedure RecallHolded;

  public
    function isSaved(Cash: double): boolean;
    procedure Print();
//    procedure Print2();

    procedure Execute(id: integer=0); override;
  end;

var
  frmTrsSales: TfrmTrsSales;

implementation

uses j_idol, Subroutines, UConst, UConstTool, LOVFlat,
  InputBox1, InputBoxTotal, InputBoxTax, MainMenu, trsSalesHoldedList,
  EpsonUtils, InfoSales, InfoPrice,
  MySQLConnector, uMysqlClient, Option, InputBoxCustomer,
  ChangePassword, InputBoxPilihHarga, UQueryPackage;

const
  colNo        = 0;
  colBarcode   = 1;
  colDesc      = 2;
  colQty       = 3;
  colUnit      = 4;
  colHarga     = 5;
  colDisc      = 6;
  colDiscRp    = 7;
  colTotal     = 8;
  colConv      = 9;
  colItemId    = 10;
  colConvId    = 11;
  colHrgBeli   = 12;
  colProfit    = 13;
  colPoint     = 14;
  colLast      = 15;
  colIsPaket   = 16;
  colDontModif = 17;

  //colNamePrinted = 14;

{$R *.dfm}

{ TfrmTrsSales }

function TfrmTrsSales.ekstraksEntry(input: string): string;
var qty: double; barcode: string;
begin
  barcode:= input;
  qty:= 1;
  if Pos('*', input) <> 0 then begin
    barcode:= EkstrakString(input,'*',2);
    qty:= StrToFloatDef(EkstrakString(input,'*',1),0);
  end;
  //belum tau paket/bukan
  getItem(barcode, 0, -1, qty);
end;

procedure TfrmTrsSales.getItem(AItemCode: string; AItemID, isPaket: integer; AQty: double);
var vRow, sameID: integer;

  function search_same_item(existID, isPaket: integer): integer;
  var i: integer;
  begin
    Result:= 0;
    for i:= 1 to asgSales.RowCount-1 do
      if (asgSales.Ints[colItemID, i] = existID) and (asgSales.Ints[colIsPaket, i] = isPaket) then begin
        Result:= i;
        exit;
      end;
  end;

begin

  MstItem.Reset;
  MstItem.Barcode:= AItemCode;
  MstItem.ItemId := AItemID;
  MstItem.Konsinyasi := isPaket;

  if MstItem.SelectPOS then begin
    sameID:= search_same_item(MstItem.ItemId, MstItem.Konsinyasi);
    if sameID <> 0 then begin
       asgSales.Row:= sameID;
       vRow:= sameID;

       asgSales.Cells[colQty, vRow]:= FloatToStrFmt(asgSales.Floats[colQty, vRow] + AQty);
       Calculate(vRow);
    end else begin

      if asgSales.Ints[colItemID, asgSales.RowCount-1] <> 0 then
        asgSales.AddRow;

      vRow:= asgSales.RowCount-1;
      asgSales.Cells[colDesc,    vRow]:= MstItem.StrukName;
      asgSales.Cells[colBarcode, vRow]:= MstItem.Barcode;
      asgSales.Ints[colItemId,   vRow]:= MstItem.ItemId;
      asgSales.Ints[colIsPaket,  vRow]:= MstItem.Konsinyasi;
      asgSales.Ints[colConvId,   vRow]:= MstItem.FItemConversion[0].ConvId;
      asgSales.Cells[colUnit,    vRow]:= MstItem.FItemConversion[0].MstMaster.MstCode;
      asgSales.Cells[colHarga,   vRow]:= FloatToStrFmt(MstItem.FItemConversion[0].SalesPrice);
      asgSales.Cells[colConv,    vRow]:= FloatToStrFmt(MstItem.FItemConversion[0].Conversion);
      asgSales.Cells[colQty,     vRow]:= FloatToStrFmt(AQty);
      asgSales.Floats[colHrgBeli,vRow]:= MstItem.AvgPrice; //harga dasar

      asgSales.Row:= vRow;
      txtEntry.Tag:= MstItem.ItemId;
      //ResettingHarga(vRow);
      ApplliedProdukItem(vRow);
      Calculate(vRow);

    end;

    if AItemID <> 0 then txtEntry.Text:= MstItem.Barcode;
    txtEntry.SelectAll;

  end else begin
    txtEntry.SelectAll;
    //Windows.Beep(500, 100);
    Inform('Item tidak ditemukan.');
  end;

end;

procedure TfrmTrsSales.InitForm;
begin
  tunai:= 0;
  InitGrid;
  lblTransaksi.Caption:= '[Nomor Transaksi]';
  lblQty.Caption:= '[No Item]';

  lblCustomer.Caption:= Sales.GetCustomer(lblCasierUser.Tag);
  lblTransaksi.Tag:= 0;
  lblCustomer.Tag := 0;
  lblSubTotal.Caption:= '0';
  lblGrangTotal.Caption:= '0';
  RequeryTaxDisc;
  txtEntry.Clear;
  txtEntry.Tag:= 0;
  lblTotal.Caption:= '0';
  lblMember.Caption:='';
  lblPoint.Caption:='';

  RELASI_ID:= 0;
  CURRENT_POINT:= 0;
  lblPoint.Tag:= 0;
  JENIS_CUSTOMER:= PROD_CUST_UNREG;
end;

procedure TfrmTrsSales.InitGrid;
begin
  ResetGrid(asgSales, 2, 18, 1,1);

  asgSales.MergeCells(colQty, 0,2,1);
  asgSales.AutoSizeColumns(true, 5);

  asgSales.ColWidths[colItemId]:= 0;
  asgSales.ColWidths[colConvId]:= 0;
  asgSales.ColWidths[colConv]:= 0;
  asgSales.ColWidths[colHrgBeli]:= 0;
  asgSales.ColWidths[colProfit]:= 0;
  asgSales.ColWidths[colPoint]:= 0;
  asgSales.ColWidths[colLast]:= 0;
  asgSales.ColWidths[colIsPaket]:= 0;
  asgSales.ColWidths[colDontModif]:= 0;
  asgSales.ColWidths[0]:= 0;

  asgSales.ColWidths[colBarcode]:= 115;
  asgSales.ColWidths[colQty   ]:= 40;
  asgSales.ColWidths[colUnit  ]:= 50;
  asgSales.ColWidths[colHarga ]:= 60;
  asgSales.ColWidths[colDisc  ]:= 50;
  asgSales.ColWidths[colDiscRp]:= 60;
  asgSales.ColWidths[colTotal ]:= 80;

  if not screenLessThen1024X768 then begin
    asgSales.ColWidths[colLast]:= 20;
    asgSales.ColWidths[colQty   ]:= 50;
    asgSales.ColWidths[colHarga ]:= 75;
    asgSales.ColWidths[colDisc  ]:= 70;
    asgSales.ColWidths[colDiscRp]:= 75;
    asgSales.ColWidths[colTotal ]:= 100;
  end;

  asgSales.RowHeights[1]:= asgSales.DefaultRowHeight;
end;

function TfrmTrsSales.isSaved(Cash: double): boolean;
var i: integer; DiscDetail: double;
begin
  Sales.Clear;
  Sales.SalesMst.SalesId   := lblTransaksi.Tag;
  Sales.SalesMst.TransDate := ServerNow;
  Sales.SalesMst.TransType := SALES_TYPE_POS;
  Sales.SalesMst.Subtotal  := StrFmtToFloatDef(lblSubTotal.Caption,0, True);
  Sales.SalesMst.DiscMst   := StrFmtToFloatDef(lblDisc.Caption,0);
  Sales.SalesMst.DiscValMst:= StrFmtToFloatDef(lblDiscRp.Caption,0);
  Sales.SalesMst.Tax:= StrFmtToFloatDef(lblTax.Caption,0);
  Sales.SalesMst.Total     := StrFmtToFloatDef(lblGrangTotal.Caption,0, True);
  Sales.SalesMst.RealAmount:= Sales.SalesMst.Total;

 //-1000 900
  //RealAmount: jumlah pendapatan
  if (Sales.SalesMst.Total >= Cash) then
      Sales.SalesMst.RealAmount:= Cash
  else Sales.SalesMst.RealAmount:= Sales.SalesMst.Total;

  //untuk kasus retur
  if (Sales.SalesMst.Total < 0) then begin
    if (Sales.SalesMst.Total + Cash) > 0 then
       Cash:= Sales.SalesMst.Total
    else Cash:= 0;
  end;

  Sales.SalesMst.CashierId := lblCasierUser.Tag;
  Sales.SalesMst.Cash      := Cash;
  Sales.SalesMst.UserId    := GlobalSystemUser.UserId;
  Sales.SalesMst.Points    := jumlahkanPoint;
  Sales.SalesMst.RelationID:= RELASI_ID;
  Sales.SalesMst.profit    := asgSales.ColumnSum(colProfit, 1, asgSales.RowCount-1);
  Sales.SalesMst.profit    :=
  (Sales.SalesMst.profit - Sales.SalesMst.DiscValMst) -
  (Sales.SalesMst.Subtotal * (Sales.SalesMst.DiscMst /100));

  DiscDetail:= 0;
  for i:= 1 to asgSales.RowCount - 1 do
    if not IsClear(asgSales, colItemId, i) then begin
      Sales.SalesDetail_Arr.Add(0, lblTransaksi.Tag,
      IfThen(asgSales.Ints[colIsPaket,i]=0, asgSales.Ints[colItemId, i], 0),
      IfThen(asgSales.Ints[colIsPaket,i]=0, asgSales.Ints[colConvId, i], 0),
      ConvertToSaveConvertion(asgSales.Floats[colQty,i], asgSales.Floats[colConv,i]),
      //ConvertToLoadConvertion(asgSales.Floats[colHarga,i], asgSales.Floats[colConv,i]),
      asgSales.Floats[colHarga,i],
      asgSales.Floats[colDisc, i], asgSales.Floats[colDiscRp, i],
      asgSales.Floats[colTotal,i], asgSales.Floats[colConv, i],
      asgSales.Floats[colHrgBeli, i], asgSales.Floats[colProfit, i],
      asgSales.Ints[colPoint, i],
      IfThen(asgSales.Ints[colIsPaket,i]=1, asgSales.Ints[colItemId, i], 0),0,0,0);
      DiscDetail:= DiscDetail + asgSales.Floats[colDiscRp, i] +
      ((asgSales.Floats[colDisc, i] /100) * (asgSales.Floats[colQty,i]*asgSales.Floats[colHarga,i]));
    end;

  Sales.SalesMst.DiscDetail:= DiscDetail;

  if (lblTransaksi.Tag = 0) then
    Result:= Sales.InsertCashOnDB(lblCustomer.Tag)
  else Result:= false;

  lblTransaksi.Caption:= Sales.SalesMst.TransNum;
  lblTransaksi.Tag := Sales.SalesMst.SalesId;

  if Result then begin
    tunai:= Cash;
    if GlobalSystemConfig.localSetting.PrintStruk = 0 then Exit;
    try
    //kicking cash drawer...
 //     SendEscapeCode(GlobalSystemConfig.localSetting.DrawerCode);

   //priting cash drawer...
      Self.Print;
    except raise;
      Inform('Priter tidak terpasang.');
    end;
  end;
end;

function TfrmTrsSales.isValid: boolean;
var i: integer;
begin
  Result:= False;
  for i:= 1 to asgSales.RowCount-1 do begin
    Result:= not IsClear(asgSales, colItemId, i);
    if Result then Exit
  end;
  Inform('Tidak ada item untuk disimpan.');
end;

procedure TfrmTrsSales.Print;
var i, x, jmlPoint: integer; 
begin

  if GlobalSystemConfig.localSetting.PrintStruk = 0 then Exit;
  GlobalStringList.Clear;
  RAWPrinter1.PrinterName:= GlobalSystemConfig.localSetting.PrinterStruk;

//open drawer first
  if (GlobalSystemConfig.localSetting.DrawerCode <> '') then
    GlobalStringList.Append(GlobalSystemConfig.localSetting.DrawerCode);

 {
  GlobalStringList.Append(FixWidth(CompanyProfile.FCompanyName, 40, taCenter));
  GlobalStringList.Append(FixWidth(CompanyProfile.FAddress, 40, taCenter));
  GlobalStringList.Append(FixWidth(CompanyProfile.FTelp1, 40, taCenter));
  GlobalStringList.Append(FixWidth(CompanyProfile.FCity, 40, taCenter));
  GlobalStringList.Append(FixWidth(' ', 40, taCenter));
 }

  GlobalStringList.Append(
    FixWidth(lblTransaksi.Caption, 30, taLeftJustify) +
    FixWidth(FormatDateTime('dd/MM/yyyy', ServerNow), 10, taRightJustify));

  GlobalStringList.Append(
    FixWidth('Kasir : '+GlobalSystemUser.UserId, 30, taLeftJustify));

  GlobalStringList.Append(FixWidth('-----------------------------------------',40, taLeftJustify));

  for i := 1 to asgSales.RowCount-1 do
  if not IsClear(asgSales, colItemId, i) then
    with GlobalStringList do begin
      Append(FixWidth(asgSales.Cells[colDesc, i],40, taLeftJustify));

    //kasus normal
      if (asgSales.Cells[colDisc, i] = '0') and (asgSales.Cells[colDiscRp, i] = '0') then
        Append(
          FixWidth(asgSales.Cells[colQty, i]+' '+asgSales.Cells[colUnit, i], 12, taRightJustify) +
          FixWidth(' X ', 3, taLeftJustify) +
          FixWidth(asgSales.Cells[colHarga, i], 12, taRightJustify)+
          FixWidth(asgSales.Cells[colTotal, i], 13, taRightJustify))

    //kasus ada 1 discont
      else if (asgSales.Cells[colDisc, i] <> '0') or (asgSales.Cells[colDiscRp, i] <> '0') then
        Append(
          FixWidth(asgSales.Cells[colQty, i]+' '+asgSales.Cells[colUnit, i], 9, taRightJustify) +
          FixWidth(' X', 2, taLeftJustify) +
          FixWidth(asgSales.Cells[colHarga, i], 9, taRightJustify)+
          IfThen(asgSales.Cells[colDisc, i]<> '0',
          FixWidth(' -'+asgSales.Cells[colDisc, i]+'%', 9, taRightJustify))+
          IfThen(asgSales.Cells[colDiscRp, i]<> '0',
          FixWidth(' -'+asgSales.Cells[colDiscRp, i], 9, taRightJustify))+
          FixWidth(asgSales.Cells[colTotal, i], 11, taRightJustify))

    //kasus ada 2 discont
      else if (asgSales.Cells[colDisc, i] <> '0') and (asgSales.Cells[colDiscRp, i] <> '0') then begin
        Append(
          FixWidth(asgSales.Cells[colQty, i]+' '+asgSales.Cells[colUnit, i], 10, taRightJustify) +
          FixWidth(' X ', 3, taLeftJustify) +
          FixWidth(asgSales.Cells[colHarga, i], 9, taRightJustify)+
          IfThen(asgSales.Cells[colDisc, i]<> '0',
          FixWidth(' -'+asgSales.Cells[colDisc, i]+'%', 8, taRightJustify))+
          IfThen(asgSales.Cells[colDiscRp, i]<> '0',
          FixWidth(' -'+asgSales.Cells[colDiscRp, i], 10, taRightJustify)));
        Append(FixWidth(asgSales.Cells[colTotal, i], 40, taRightJustify));
      end;
    end;

  GlobalStringList.Append(FixWidth('-----------------------------------------',40, taLeftJustify));
  GlobalStringList.Append(
    FixWidth('Subtotal', 14, taLeftJustify) +
    FixWidth(':', 2, taLeftJustify) +
    FixWidth(lblSubTotal.Caption ,24, taRightJustify));

  if (StrFmtToFloatDef(lblDisc.Caption,0) > 0) then
  GlobalStringList.Append(
    FixWidth('Discount %', 14, taLeftJustify) +
    FixWidth(':', 2, taLeftJustify) +
    FixWidth(lblDisc.Caption ,24, taRightJustify));

  if (StrFmtToFloatDef(lblDiscRp.Caption,0) > 0) then
  GlobalStringList.Append(
    FixWidth('Discount Rp', 14, taLeftJustify) +
    FixWidth(':', 2, taLeftJustify) +
    FixWidth(lblDiscRp.Caption ,24, taRightJustify));

  if (StrFmtToFloatDef(lblTax.Caption,0) > 0) then
  GlobalStringList.Append(
    FixWidth('PPN %', 14, taLeftJustify) +
    FixWidth(':', 2, taLeftJustify) +
    FixWidth(lblTax.Caption ,24, taRightJustify));

  if (StrFmtToFloatDef(lblTax.Caption,0) > 0) or
     (StrFmtToFloatDef(lblDiscRp.Caption,0) > 0) or
     (StrFmtToFloatDef(lblDisc.Caption,0) > 0) then
  GlobalStringList.Append(
    FixWidth('Grand Total', 14, taLeftJustify) +
    FixWidth(':', 2, taLeftJustify) +
    FixWidth(lblGrangTotal.Caption ,24, taRightJustify));

  GlobalStringList.Append(
    FixWidth('Tunai', 14, taLeftJustify) +
    FixWidth(':', 2, taLeftJustify) +
    FixWidth(FloatToStrFmt(tunai) ,24, taRightJustify));

  GlobalStringList.Append(
    FixWidth('Kembali', 14, taLeftJustify) +
    FixWidth(':', 2, taLeftJustify) +
    FixWidth(FloatToStrFmt(tunai - StrFmtToFloatDef(lblGrangTotal.Caption,0)),24, taRightJustify));

 // GlobalStringList.Append('');

  //if jmlPoint <> 0 then begin
  GlobalStringList.Append(escCRLF);

  if RELASI_ID <> 0 then begin
     GlobalStringList.Append('');
     case JENIS_CUSTOMER of
       PROD_CUST_CUSTOMER:
          GlobalStringList.Append(
            FixWidth('CUSTOMER', 10, taLeftJustify) +
            FixWidth(':', 2, taLeftJustify) +
            FixWidth(TMstRelation.GetName(RELASI_ID),28, taLeftJustify));

       PROD_CUST_MEMBER:
           GlobalStringList.Append(
            FixWidth('MEMBER', 10, taLeftJustify) +
            FixWidth(':', 2, taLeftJustify) +
            FixWidth(TMstRelation.GetName(RELASI_ID),28, taLeftJustify));
      end;
  end;

  jmlPoint:= jumlahkanPoint;
  if (jmlPoint <> 0) and (RELASI_ID <> 0) then begin

    GlobalStringList.Append(
      FixWidth('Jml Point', 10, taLeftJustify) +
      FixWidth(':', 2, taLeftJustify) +
      FixWidth(FloatToStrFmt(jmlPoint),28, taLeftJustify));
    GlobalStringList.Append(FixWidth('**catatan**',40, taCenter));
  end;

  if GlobalSystemConfig[CONF_FOOTER1-1].ConfValue <> '' then
    GlobalStringList.Append(FixWidth(GlobalSystemConfig[CONF_FOOTER1-1].ConfValue, 40, taCenter));

  if GlobalSystemConfig[CONF_FOOTER2-1].ConfValue <> '' then
    GlobalStringList.Append(FixWidth(GlobalSystemConfig[CONF_FOOTER2-1].ConfValue, 40, taCenter));

  x:= GlobalSystemConfig.localSetting.MarginBottom;
  for i:= 1 to x do
    GlobalStringList.Append(' ');

  try
  //printing struk...

    //cutting paper...
    if (GlobalSystemConfig.localSetting.CutterCode <> '') and (GlobalSystemConfig.localSetting.AutoCutter = 1) then
      GlobalStringList.Append(GlobalSystemConfig.localSetting.CutterCode);

    RAWPrinter1.DocumentTitle:= 'Struk';
    RAWPrinter1.BeginDoc;
    RAWPrinter1.WriteStr(GlobalStringList.Text);
//
  GlobalStringList.Append(FixWidth(CompanyProfile.FCompanyName, 40, taCenter));
  GlobalStringList.Append(FixWidth(CompanyProfile.FAddress, 40, taCenter));
  GlobalStringList.Append(FixWidth(CompanyProfile.FTelp1, 40, taCenter));
  GlobalStringList.Append(FixWidth(CompanyProfile.FCity, 40, taCenter));
  GlobalStringList.Append(FixWidth(' ', 40, taCenter));
//
    RAWPrinter1.EndDoc;
  
    except raise;
      Inform('Printer tidak terpasang.');
  end;
end;

procedure TfrmTrsSales.SetDisableEnable;
begin

end;

procedure TfrmTrsSales.txtSubtotalValueValidate(Sender: TObject;
  value: String; var IsValid: Boolean);
begin
  AdvEdtFloatFmt(Sender, value, (Sender as TAdvEdit).Tag=-1);
end;

procedure TfrmTrsSales.txtSubtotalEnter(Sender: TObject);
begin
  txtEntry.SetFocus
end;

procedure TfrmTrsSales.asgSalesKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  case Key of
    VK_UP:
    begin
      if (asgSales.Row = 1) and (Sender <> nil) then begin
        txtEntry.Text:= asgSales.Cells[colBarcode, asgSales.Row];
        txtEntry.Tag:= asgSales.Ints[colItemId, asgSales.Row];
      end

      else if (asgSales.Row > 1) and (Sender <> nil) then begin
        txtEntry.Text:= asgSales.Cells[colBarcode, asgSales.Row-1];
        txtEntry.Tag:= asgSales.Ints[colItemId, asgSales.Row-1];
      end
      else if (asgSales.Row = 1) and (Sender = nil) then begin
        txtEntry.Text:= asgSales.Cells[colBarcode, 1];
        txtEntry.Tag:= asgSales.Ints[colItemId, 1];
      end
      else if (asgSales.Row > 1) and (Sender = nil) then begin
        txtEntry.Text:= asgSales.Cells[colBarcode, asgSales.Row];
        txtEntry.Tag:= asgSales.Ints[colItemId, asgSales.Row];
      end;
      txtEntry.SelectAll;
    end;

    VK_DOWN:
    begin
      if (asgSales.Row = asgSales.RowCount-1) and (Sender <> nil) then begin
        txtEntry.Text:= asgSales.Cells[colBarcode, asgSales.RowCount-1];
        txtEntry.Tag:= asgSales.Ints[colItemId, asgSales.RowCount-1];
      end
      else if (asgSales.Row < asgSales.RowCount-1) and (Sender <> nil) then begin
        txtEntry.Text:= asgSales.Cells[colBarcode, asgSales.Row+1];
        txtEntry.Tag:= asgSales.Ints[colItemId, asgSales.Row+1];
      end
      else if (asgSales.Row = asgSales.RowCount-1) and (Sender = nil) then begin
        txtEntry.Text:= asgSales.Cells[colBarcode, asgSales.RowCount+1];
        txtEntry.Tag:= asgSales.Ints[colItemId, asgSales.RowCount+1];
      end
      else if (asgSales.Row < asgSales.RowCount-1) and (Sender = nil) then begin
        txtEntry.Text:= asgSales.Cells[colBarcode, asgSales.RowCount-1];
        txtEntry.Tag:= asgSales.Ints[colItemId, asgSales.RowCount-1];
      end;
      txtEntry.SelectAll;
    end
    else txtEntry.SetFocus;
  end;
end;

procedure TfrmTrsSales.Calculate(xrow: integer);
var total, disDetRp, disDetPrc,
  disTotal, disTotalVal, tax: double;
begin
  total := asgSales.Floats[colQty,  xRow] * asgSales.Floats[colHarga, xRow];
  //profit:= asgSales.Floats[colQty,  xRow] * asgSales.Floats[colHrgBeli, xRow];

  disDetRp := asgSales.Floats[colDiscRp, xrow];
  disDetPrc:= asgSales.Floats[colDisc, xrow];
  disDetPrc:= total * (disDetPrc/100);

  total:= total - disDetRp - disDetPrc;
  asgSales.Cells[colTotal, xrow]:= FloatToStrFmt(total);

  //profit:= (hrgjual - hrgbeli) / hrgjual;
//  profit:= (profit - total - disDetRp - disDetPrc) / total;

//langsung dikaIikan
  asgSales.Floats[colProfit, xRow]:= total -
    (asgSales.Floats[colQty, xRow] * asgSales.Floats[colHrgBeli, xRow]);
       
//header
  total:= asgSales.ColumnSum(colTotal, 1, asgSales.RowCount-1);

  lblSubTotal.Caption:= FloatToStrFmt(total, True);
  ApplliedProdukTotal;

//recalculate after ApplliedProdukTotal
  total:= StrFmtToFloatDef(lblSubTotal.Caption,0, True); //%
  lblSubTotal.Caption:= FloatToStrFmt(total, True);
  disTotalVal:= StrFmtToFloatDef(lblDiscRp.Caption,0); //rp
  disTotal:= StrFmtToFloatDef(lblDisc.Caption,0); //%
  disTotal:= (disTotal/100) * total;
  total:= total - disTotal - disTotalVal;

  tax:= StrFmtToFloatDef(lblTax.Caption,0);
  tax:= (tax/100) * (total);
  total:= total + tax;
  lblGrangTotal.Caption:= FloatToStrFmt(total, true);
  lblQty.Caption:= IntToStr(asgSales.RowCount-1) + ' Item';
  lblTotal.Caption:= lblGrangTotal.Caption;
end;

procedure TfrmTrsSales.ChangeQty();
var Qty: double;
begin
  Qty:= asgSales.Floats[colQty, asgSales.Row];
  if frmInputBox1.Execute(Qty, 'Quantity', false) then
     asgSales.Cells[colQty, asgSales.Row]:= FloatToStrFmt(Qty);
  //ResettingHarga(asgSales.Row);
  ApplliedProdukItem(asgSales.Row);
  Calculate(asgSales.Row);
end;

procedure TfrmTrsSales.RequeryTaxDisc;
begin
  lblDisc.Caption  := FloatToStrFmt(StrFmtToFloatDef(GlobalSystemConfig[CONF_DISC_PROMO-1].ConfValue,0));
  lblDiscRp.Caption:= FloatToStrFmt(StrFmtToFloatDef(GlobalSystemConfig[CONF_DISC_VAL_PROMO-1].ConfValue,0));
  lblTax.Caption   := FloatToStrFmt(StrFmtToFloatDef(GlobalSystemConfig[CONF_PPn-1].ConfValue,0));
end;

procedure TfrmTrsSales.Execute(id: integer);
begin
  inherited;
  MstItem := TMstItem.Create;
  Sales   := TTrsSales.Create;
  lsEscapeCode:= TStringList.Create;

  GlobalSystemConfig.loadFromDB();
  lsEscapeCode.Text:= GlobalSystemConfig.localSetting.DrawerCode;
  GlobalSystemConfig.localSetting.DrawerCode:= ExtractEsccode(lsEscapeCode);

  lsEscapeCode.Text:= GlobalSystemConfig.localSetting.CutterCode;
  GlobalSystemConfig.localSetting.CutterCode:= ExtractEsccode(lsEscapeCode);

  lsEscapeCode.Free;

  lblCasierUser.Caption:= 'Kasir : '+GlobalSystemUser.UserName;
  InitForm;
  ReadRegLocalMachine;

  lblTransaksi.Tag:= 0;
  SetDisableEnable;
  registered:= frmOption.ProcessRights;
  imgCashierRight.Picture.Bitmap.Handle:= LoadBitmap(ImageDll, 'cashier_big');
  Run(Self);
end;

procedure TfrmTrsSales.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if MstItem <> nil then MstItem.Free;
  MstItem:= nil;
  if Sales <> nil then Sales.Free;
  Sales:= nil;

 // if lsEscapeCode <> nil then lsEscapeCode.Free;
 // lsEscapeCode:= nil;
end;

procedure TfrmTrsSales.txtEntryKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  txtEntry.ReadOnly:= false;
  if not registered then begin
    Inform('Silahkan lakukan registrasi.');
    exit;
  end;

  if (Shift = [ssAlt]) and (key = Ord('A')) then ChangeCustomerTipe
  else if (Shift = [ssAlt]) and (key = Ord('H')) then HoldedTrx
  else if (Shift = [ssAlt]) and (key = Ord('C')) then RecallHolded
  else if (Shift = [ssAlt]) and (key = Ord('R')) then tbtReport.Click
  else if (Shift = [ssAlt]) and (key = Ord('T')) then tbtOption.Click
  else if (Shift = [ssAlt]) and (key = Ord('O')) then tbtOpen.Click
  else if (Shift = [ssAlt]) and (key = Ord('L')) then tbtLogOff.Click
  else if (Shift = [ssAlt]) and (key = Ord('X')) then tbtExit.Click

  else
  case Key of
    VK_RETURN, VK_CONTROL:
    begin

      ekstraksEntry(txtEntry.Text);
      txtEntry.SelectAll;
    end;
    VK_DELETE: if txtEntry.Tag <> 0 then RemoveRow;
    VK_SUBTRACT: if txtEntry.Tag <> 0 then DecreaseQty;
    VK_ADD : if txtEntry.Tag <> 0 then IncreaseQty;
    VK_UP  : if txtEntry.Tag <> 0 then RowMoveUp(Key, Shift);
    VK_DOWN: if txtEntry.Tag <> 0 then RowMoveDown(Key, Shift);
    vk_F1  : showInfo;
    vk_F2  : SeekItem;
    vk_F3  : if txtEntry.Tag <> 0 then EndTransaction;
    vk_F5  : if txtEntry.Tag <> 0 then DiscountRupiah;
    vk_F6  : if txtEntry.Tag <> 0 then DiscountPercent;
    vk_F7  : if txtEntry.Tag <> 0 then DiscountTax;
    vk_F8  : frmInfoPrice.Execute;
    vk_F9  : RePrintLastTrans;
    vk_F10 : if txtEntry.Tag <> 0 then ChangeHarga;
    vk_F11 :
    begin
       Sales.DelHolded(lblCustomer.Tag);
       InitForm;

    end;
    vk_F12 : if txtEntry.Tag <> 0 then ChangeQty;

  end;
end;

procedure TfrmTrsSales.tbtHoldClick(Sender: TObject);
begin
  HoldedTrx
end;

function TfrmTrsSales.SaveHolded: boolean;
var i: integer;
begin
  Sales.Clear;
  Sales.SalesMst.SalesId   := lblCustomer.Tag;
  Sales.SalesMst.TransDate := ServerNow;
  Sales.SalesMst.Subtotal  := StrFmtToFloatDef(lblSubTotal.Caption,0, true);
  Sales.SalesMst.profit    := asgSales.ColumnSum(colProfit, 1, asgSales.RowCount-1);
  Sales.SalesMst.DiscMst   := StrFmtToFloatDef(lblDisc.Caption,0, true);
  Sales.SalesMst.DiscValMst:= StrFmtToFloatDef(lblDiscRp.Caption,0, true);
  Sales.SalesMst.Tax:= StrFmtToFloatDef(lblTax.Caption,0);
  Sales.SalesMst.Total     := StrFmtToFloatDef(lblGrangTotal.Caption,0, true);
  Sales.SalesMst.CashierId := lblCasierUser.Tag;
  Sales.SalesMst.UserId    := GlobalSystemUser.UserId;
  Sales.SalesMst.Points    := lblPoint.Tag;
  Sales.SalesMst.RelationID:= RELASI_ID;
  Sales.SalesMst.GudangID  := JENIS_CUSTOMER;  //tmp JENIS_CUSTOMER

  for i:= 1 to asgSales.RowCount - 1 do
    if not IsClear(asgSales, colItemId, i) then begin
      Sales.SalesDetail_Arr.Add(0, lblCustomer.Tag,
      IfThen(asgSales.Ints[colIsPaket,i]=0, asgSales.Ints[colItemId, i], 0),
      IfThen(asgSales.Ints[colIsPaket,i]=0, asgSales.Ints[colConvId, i], 0),
      ConvertToSaveConvertion(asgSales.Floats[colQty,i], asgSales.Floats[colConv,i]),
      asgSales.Floats[colHarga,i],
      asgSales.Floats[colDisc, i], asgSales.Floats[colDiscRp, i],
      asgSales.Floats[colTotal,i], asgSales.Floats[colConv, i],
      asgSales.Floats[colHrgBeli, i], asgSales.Floats[colProfit, i],
      asgSales.Ints[colPoint, i],
      IfThen(asgSales.Ints[colIsPaket,i]=1, asgSales.Ints[colItemId, i],0),0,0,0);
    end;

  Result:= Sales.InsertHolded;
  if Result then InitForm;
end;

function TfrmTrsSales.LoadHolded(id: integer): boolean;
var i: integer; cust: string;
begin
  InitForm;
  Sales.Clear;
  Sales.SalesMst.SalesId:= id;
  Result:= Sales.SelectHolded;
  lblCustomer.Tag:= Sales.SalesMst.SalesId;
  for i:= 0 to Sales.SalesDetail_Arr.Count-1 do begin
    asgSales.Ints[colNo, i+1]:= i+1;
    asgSales.Cells[colBarcode,  i+1]:= Sales.SalesDetail_Arr[i].MstItem.Barcode;
    asgSales.Cells[colDesc,     i+1]:= Sales.SalesDetail_Arr[i].MstItem.ItemName;
    asgSales.Cells[colUnit,     i+1]:= Sales.SalesDetail_Arr[i].MstItemConversion.MstMaster.MstCode;
    asgSales.Cells[colQty,      i+1]:= FloatToStrFmt(Sales.SalesDetail_Arr[i].Quantity);
    asgSales.Cells[colHarga,    i+1]:= FloatToStrFmt(Sales.SalesDetail_Arr[i].Price);
    asgSales.Cells[colDisc,     i+1]:= FloatToStrFmt(Sales.SalesDetail_Arr[i].Disc);
    asgSales.Cells[colDiscRp,   i+1]:= FloatToStrFmt(Sales.SalesDetail_Arr[i].DiscVal);
    asgSales.Cells[colTotal,    i+1]:= FloatToStrFmt(Sales.SalesDetail_Arr[i].Amount);
    asgSales.Floats[colConv,    i+1]:= Sales.SalesDetail_Arr[i].Conversion;
    asgSales.Floats[colHrgBeli, i+1]:= Sales.SalesDetail_Arr[i].PricePurchase;
    asgSales.Floats[colProfit,  i+1]:= Sales.SalesDetail_Arr[i].AmountProfit;
    asgSales.Ints[colConvID,    i+1]:= Sales.SalesDetail_Arr[i].MstItemConversion.ConvId;
    asgSales.Ints[colItemID,    i+1]:= Sales.SalesDetail_Arr[i].MstItem.ItemId;
    asgSales.Ints[colIsPaket,   i+1]:= Sales.SalesDetail_Arr[i].PaketID; //numpang is paket
    asgSales.Ints[colPoint,     i+1]:= Sales.SalesDetail_Arr[i].Points; //numpang is paket

    Calculate(i+1);
    asgSales.AddRow;
  end;
  DeleteRowTerakhir(asgSales, 2, 1);

  RELASI_ID:= Sales.SalesMst.RelationID;
  JENIS_CUSTOMER:= Sales.SalesMst.GudangID;

  if not Result then Exit;
  //hasil : customer-A #3 dari customerA001
  cust:= copy(Sales.SalesMst.TransNum, 1, 8);
    lblCustomer.Caption:= cust;

  cust:= copy(Sales.SalesMst.TransNum,
    9, length(Sales.SalesMst.TransNum) - 11);

  lblCustomer.Caption:= lblCustomer.Caption + '-' +cust+ ' #';

  cust:= copy(Sales.SalesMst.TransNum, length(Sales.SalesMst.TransNum)-2, 3);

  lblCustomer.Caption:= lblCustomer.Caption + IntToStr(StrToIntDef(cust, 1));

  if JENIS_CUSTOMER = PROD_CUST_CUSTOMER then
     lblMember.Caption:= 'Customer:'+#13#10+TMstRelation.GetName(RELASI_ID)
  else if JENIS_CUSTOMER = PROD_CUST_MEMBER then
     lblMember.Caption:= 'Member:'+#13#10+TMstRelation.GetName(RELASI_ID)
  else if JENIS_CUSTOMER = PROD_CUST_UNREG then
     lblMember.Caption:= 'UnReg:'+#13#10+TMstRelation.GetName(RELASI_ID);
  lblPoint.Tag:= Sales.SalesMst.Points;
  lblPoint.Caption:= FloatToStrFmt(jumlahkanPoint)+' Point';
  asgSalesClickCell(asgSales, 1, 1);
end;

procedure TfrmTrsSales.tbtRecallClick(Sender: TObject);
begin
  RecallHolded
end;

procedure TfrmTrsSales.asgSalesGetAlignment(Sender: TObject; ARow,
  ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  if ACol in[colNo, colQty, colHarga, colDisc, colDiscRp, colTotal] then HAlign:= taRightJustify;
end;

procedure TfrmTrsSales.asgSalesRowChanging(Sender: TObject; OldRow,
  NewRow: Integer; var Allow: Boolean);
//var i: Integer;
begin
{  for i:= 0 to asgSales.ColCount-4 do begin
    asgSales.FontSizes[i, NewRow]:= 16;
    asgSales.RowHeights[NewRow]:= 36;
    asgSales.FontSizes[i, OldRow]:= 12;
    asgSales.RowHeights[OldRow]:= 26;
    ArrangeColSize;
  end;}

  if OldRow <= asgSales.RowCount-1 then
  asgSales.RowHeights[OldRow]:= asgSales.DefaultRowHeight;
  asgSales.AutoSizeRow(NewRow);
  if asgSales.RowHeights[NewRow] < asgSales.DefaultRowHeight then
    asgSales.RowHeights[NewRow]:= asgSales.DefaultRowHeight;
end;

procedure TfrmTrsSales.tbtNewClick(Sender: TObject);
begin
  InitForm;
  txtEntry.SetFocus
end;

procedure TfrmTrsSales.ReadRegLocalMachine;
begin
  lblCasierUser.Tag:= GlobalSystemConfig.localSetting.Machine;
end;

procedure TfrmTrsSales.tbtExitClick(Sender: TObject);
begin
  frmMainMenu.FileExit1Click(nil);
end;

procedure TfrmTrsSales.tbtLogOffClick(Sender: TObject);
begin
  frmMainMenu.FileLogoff1Click(nil);
  InitForm;
  lblCasierUser.Caption:= 'Kasir : '+GlobalSystemUser.UserName;
end;

procedure TfrmTrsSales.RemoveRow;
begin
  if Confirmed('Hapus item entry?') then begin
     asgSales.ClearRows(asgSales.Row, 1);
     if asgSales.RowCount > 2 then
        asgSales.RemoveRows(asgSales.Row, 1);
     Calculate(asgSales.Row);
     txtEntry.Clear;
  end;
end;

procedure TfrmTrsSales.DecreaseQty;
begin
  txtEntry.ReadOnly:= true;
  asgSales.Cells[colQty, asgSales.Row]:= FloatToStrFmt(asgSales.Floats[colQty, asgSales.Row] - 1);
  //ResettingHarga(asgSales.Row);
  ApplliedProdukItem(asgSales.Row);
  Calculate(asgSales.Row);
  exit;
end;

procedure TfrmTrsSales.IncreaseQty;
begin
  txtEntry.ReadOnly:= true;
  asgSales.Cells[colQty, asgSales.Row]:= FloatToStrFmt(asgSales.Floats[colQty, asgSales.Row] + 1);
  ApplliedProdukItem(asgSales.Row);
  Calculate(asgSales.Row);
  exit;
end;

procedure TfrmTrsSales.RowMoveDown(var Key: Word; Shift: TShiftState);
begin
  if asgSales.Row < asgSales.RowCount-1 then
     asgSales.Row:= asgSales.Row+1;
  asgSales.SetFocus;
  asgSalesKeyDown(nil, Key, Shift);
end;

procedure TfrmTrsSales.RowMoveUp(var Key: Word; Shift: TShiftState);
begin
  asgSales.Row:= asgSales.Row-1;
  asgSales.SetFocus;
  asgSalesKeyDown(nil, Key, Shift);
end;

procedure TfrmTrsSales.SeekItem;
var id, isPaket: integer;
begin
  isPaket:= -1; //
  id:= frmLovFlat.Execute(isPaket, txtEntry.Text, 'BARANG');
  //udah tau paket/bukan: paket=1; bukan=0
  if Id > 0 then getItem('', id, isPaket, 1)
end;

procedure TfrmTrsSales.EndTransaction;
var input: Double;
begin
  input:= StrFmtToFloatDef(lblGrangTotal.Caption,0, true);
  if isValid then
    if frmInputBoxTotal.Execute(input) then InitForm;
end;

procedure TfrmTrsSales.DiscountPercent;
var input: Double;
begin
  if asgSales.Floats[colDiscRp, asgSales.Row] <> 0 then begin
     Inform('Item sudah didiscount.');
     Exit;
  end;

  input:= asgSales.Floats[colDiscRp, asgSales.Row];
  if frmInputBox1.Execute(input, 'Discount Persen', false) then begin
     asgSales.Cells[colDisc, asgSales.Row]:= FloatToStrFmt(input);
     Calculate(asgSales.Row);
  end;
end;

procedure TfrmTrsSales.DiscountRupiah;
var input: Double;
begin
  if asgSales.Floats[colDisc, asgSales.Row] <> 0 then begin
     Inform('Item sudah didiscount.');
     Exit;
  end;
  input:= asgSales.Floats[colDiscRp, asgSales.Row];
  if frmInputBox1.Execute(input, 'Discount Rupiah', false) then begin
     if Confirmed('Kalikan dengan item') then
        input := input * asgSales.Ints[colQty, asgSales.Row];
     asgSales.Cells[colDiscRp, asgSales.Row]:= FloatToStrFmt(input);
     Calculate(asgSales.Row);
  end;
end;

procedure TfrmTrsSales.DiscountTax;
begin
{  if frmInputBoxTax.Execute then begin
     RequeryTaxDisc;
     Calculate(asgSales.Row);
  end;}
end;

procedure TfrmTrsSales.tbtOpenClick(Sender: TObject);
begin
  try
    if (GlobalSystemConfig.localSetting.DrawerCode <> '') then begin
      RAWPrinter1.PrinterName:= GlobalSystemConfig.localSetting.PrinterStruk;
      RAWPrinter1.DocumentTitle:= '';
      RAWPrinter1.BeginDoc;
      RAWPrinter1.WriteStr(GlobalSystemConfig.localSetting.DrawerCode);
      RAWPrinter1.EndDoc;
    end;
  except raise;
  end;
end;

procedure TfrmTrsSales.RePrintLastTrans;
var i, x, jmlPoint: integer; data: TMysqlResult;
begin
  if GlobalSystemConfig.localSetting.PrintStruk = 0 then Exit;

  data:= OpenSQL(
  'select (d.quantity / d.conversion) as qty, d.price, '+
  'd.amount, i.struk_name, d.disc, d.disc_val, '+
  't.trans_num, t.trans_date, t.total, t.cash, (t.cash - t.total) as cash_back, '+
  't.subtotal, t.disc_mst, t.disc_val_mst, t.tax, t.points, d.sales_detail_id, '+
  '(select mst_code from mst_master u, mst_item_conversion c '+
   'where c.unit_id = u.mst_id and c.conv_id = d.conv_id) as sat '+
  'from trs_sales_mst t, trs_sales_detail d, mst_item i '+
  'where d.sales_id = t.sales_id and d.item_id = i.item_id and d.item_id is not null '+
  'and t.sales_id = '+
   '(select max(sales_id) from trs_sales_mst where cashier_id = '+formatsqlnumber(lblCasierUser.Tag)+') '+
  ' union all '+
  'select (d.quantity / d.conversion) as qty, d.price, '+
  'd.amount, i.nama_struk as struk_name, d.disc, d.disc_val, '+
  't.trans_num, t.trans_date, t.total, t.cash, (t.cash - t.total) as cash_back, '+
  't.subtotal, t.disc_mst, t.disc_val_mst, t.tax, t.points, d.sales_detail_id, '+
  '(select mst_code from mst_master u where u.mst_id = i.unit_id) as sat '+

  'from trs_sales_mst t, trs_sales_detail d, mst_paket i '+
  'where d.sales_id = t.sales_id and d.paket_id = i.paket_id and d.paket_id is not null '+
  'and t.sales_id = '+
   '(select max(sales_id) from trs_sales_mst where cashier_id = '+formatsqlnumber(lblCasierUser.Tag)+
   ' order by sales_detail_id)');

  GlobalStringList.Clear;
  {
  GlobalStringList.Append(FixWidth(CompanyProfile.FCompanyName, 40, taCenter));
  GlobalStringList.Append(FixWidth(CompanyProfile.FAddress, 40, taCenter));
  GlobalStringList.Append(FixWidth(CompanyProfile.FTelp1, 40, taCenter));
  GlobalStringList.Append(FixWidth(CompanyProfile.FCity, 40, taCenter));
  GlobalStringList.Append(FixWidth(' ', 40, taCenter));
  }

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

  if (BufferToFloat(data.FieldValue(12)) > 0) or
     (BufferToFloat(data.FieldValue(13)) > 0) or
     (BufferToFloat(data.FieldValue(14)) > 0) then
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
    if RELASI_ID <> 0 then begin
      case JENIS_CUSTOMER of
        PROD_CUST_CUSTOMER:
          GlobalStringList.Append(
            FixWidth('CUSTOMER', 10, taLeftJustify) +
            FixWidth(':', 2, taLeftJustify) +
            FixWidth(TMstRelation.GetName(RELASI_ID),28, taLeftJustify));

        PROD_CUST_MEMBER:
           GlobalStringList.Append(
            FixWidth('MEMBER', 10, taLeftJustify) +
            FixWidth(':', 2, taLeftJustify) +
            FixWidth(TMstRelation.GetName(RELASI_ID),28, taLeftJustify));
      end;
    end;
    GlobalStringList.Append(
      FixWidth('Jml Point', 10, taLeftJustify) +
      FixWidth(':', 2, taLeftJustify) +
      FixWidth(FloatToStrFmt(jmlPoint),28, taLeftJustify));

    GlobalStringList.Append(FixWidth('**catatan**',40, taCenter));
  end;

  try
  //printing struk...
    if (GlobalSystemConfig.localSetting.CutterCode <> '') and (GlobalSystemConfig.localSetting.AutoCutter = 1) then
      GlobalStringList.Append(GlobalSystemConfig.localSetting.CutterCode);

    RAWPrinter1.DocumentTitle:= 'Struk';
    RAWPrinter1.BeginDoc;
    RAWPrinter1.WriteStr(GlobalStringList.Text);

//
  GlobalStringList.Append(FixWidth(CompanyProfile.FCompanyName, 40, taCenter));
  GlobalStringList.Append(FixWidth(CompanyProfile.FAddress, 40, taCenter));
  GlobalStringList.Append(FixWidth(CompanyProfile.FTelp1, 40, taCenter));
  GlobalStringList.Append(FixWidth(CompanyProfile.FCity, 40, taCenter));
  GlobalStringList.Append(FixWidth(' ', 40, taCenter));
//

    RAWPrinter1.EndDoc;
    except raise;
      Inform('Printer tidak terpasang.');
  end;
end;

procedure TfrmTrsSales.showInfo;
begin
  Inform(
   'F1  : Tampilkan batuan'#13#10+
   'F2  : Cari item berdasarkan nama'#13#10+
   'F3  : Total transaksi'#13#10+
   'F5  : Discount (%) item dengan persentasi'#13#10+
   'F6  : Discount (Rp) item dengan rupiah'#13#10+
   'F7  : Discount total dan PPN'#13#10+
   'F8  : Cek Harga'#13#10+
   'F9  : Reprint'#13#10+
//   'F10 : Ganti satuan beli'#13#10+
   'F11 : Batalkan transaksi'#13#10+
   'F12 : Quantity'#13#10+
   'DEL : Hapus 1 Item'#13#10+
   ' + : Tambah 1 Item'#13#10+
   '  -  : Kurangi 1 Item'#13#10+
   'Panah Atas   : Pindah satu baris ke atas'#13#10+
   'Panah Bawah: Pindah satu baris ke bawah'#13#10+
   'Ctrl A: Input Customer/Member');
end;

procedure TfrmTrsSales.ToolButton13Click(Sender: TObject);
begin
  showInfo;
end;

procedure TfrmTrsSales.tbtReportClick(Sender: TObject);
begin
  frmInfoSales.Execute;
end;

{procedure TfrmTrsSales.ChangeUnits;
var ID: integer; buffer: TMysqlResult;
begin
  ID:= frmSatuanBarang.Execute(txtEntry.Tag);
  if ID <> 0 then begin
    buffer:= OpenSQL(
    'select c.conv_id, u.mst_name, c.conversion, c.sales_price, purchase_price '+
    'from mst_item_conversion c, mst_master u '+
    'where c.unit_id = u.mst_id and c.conv_id = '+FormatSQLNumber(ID)+
    ' order by c.conversion');
    if buffer.RecordCount > 0 then begin

      asgSales.Cells[colUnit,    asgSales.Row]:= BufferToString(buffer.FieldValue(1));;
      asgSales.Cells[colHarga,   asgSales.Row]:= FloatToStrFmt(BufferToFloat(buffer.FieldValue(3)));
      asgSales.Cells[colConv,    asgSales.Row]:= FloatToStrFmt(BufferToFloat(buffer.FieldValue(2)));
      asgSales.Cells[colConvId, asgSales.Row]:= buffer.FieldValue(0);
      asgSales.Floats[colHrgBeli,asgSales.Row]:= BufferToFloat(buffer.FieldValue(4));
      //ResettingHarga(asgSales.Row);
      ApplliedProdukItem(asgSales.Row);
      Calculate(asgSales.Row);

    end;
    buffer.destroy;
  end;
end;}

{procedure TfrmTrsSales.ResettingHarga(xRow: integer);
var new_qty, new_price: double;
  jenis, conv_id: integer;
begin
  new_qty:= (asgSales.Floats[colQty,xRow] * asgSales.Floats[colConv,xRow]);
  conv_id:= asgSales.Ints[colConvId,xRow];

  new_price:= cari_setting_harga_kelipatan(txtEntry.Tag, conv_id, new_qty);
  if new_price <> 0 then
    asgSales.Cells[colHarga, xRow]:= FloatToStrFmt(new_price);

  new_price:= cari_setting_harga_discount(jenis, txtEntry.Tag, new_qty);
  if new_price <> 0 then begin
    if (jenis = FAKTOR_DISCOUNT_PERCNT) then
       asgSales.Cells[colDisc, asgSales.Row]:= FloatToStrFmt(new_price)
     else if (jenis = FAKTOR_DISCOUNT_VALUE) then
       asgSales.Cells[colDiscRp, asgSales.Row]:= FloatToStrFmt(new_price);
  end;
end;}

procedure TfrmTrsSales.tbtOptionClick(Sender: TObject);
begin
  frmOption.Execute;
end;

procedure TfrmTrsSales.asgSalesGetCellBorder(Sender: TObject; ARow,
  ACol: Integer; APen: TPen; var Borders: TCellBorders);
begin
  if ARow = 0 then Borders:= [cbRight]
  else if (ARow > 0) and (ACol <> colQty) then Borders:= [cbRight]
end;

procedure TfrmTrsSales.FormShow(Sender: TObject);
begin
  txtEntry.SetFocus;
end;

procedure TfrmTrsSales.txtEntryKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then key := #0;
end;

procedure TfrmTrsSales.ApplliedProdukItem(xRow: integer);
var new_qty, new_price, new_disc, new_disc_rp: double;
  point, item_id: integer;
begin
  if asgSales.Ints[colDontModif, xRow] = 1 then exit;  
  if asgSales.Ints[colIsPaket, xRow] = 0 then begin
    point:= 0;
    new_qty     := (asgSales.Floats[colQty,xRow] * asgSales.Floats[colConv,xRow]);
    new_price   := asgSales.Floats[colHarga,  xRow];
    new_disc    := asgSales.Floats[colDisc,   xRow];
    new_disc_rp := asgSales.Floats[colDiscRp, xRow];

    CURRENT_POINT:= CURRENT_POINT - asgSales.Ints[colPoint,  xRow];
    item_id:= asgSales.Ints[colItemId, xRow];

    appllied_produk(JENIS_CUSTOMER, item_id, RELASI_ID,
      new_qty, new_price, new_disc, new_disc_rp, point);

    CURRENT_POINT:= CURRENT_POINT + point;
    asgSales.Ints[colPoint,  xRow]:= point;
    asgSales.Cells[colHarga, xRow]:= FloatToStrFmt(new_price);
    asgSales.Cells[colDisc,  xRow]:= FloatToStrFmt(new_disc);
    asgSales.Cells[colDiscRp,xRow]:= FloatToStrFmt(new_disc_rp);
    lblPoint.Caption:= FloatToStrFmt(CURRENT_POINT)+' Point';
  end;
end;

procedure TfrmTrsSales.ApplliedProdukTotal;
var new_amount, new_disc, new_disc_rp: double;
  point: integer;
begin
  point:= 0;
  new_amount := StrFmtToFloatDef(lblSubTotal.Caption,0, True);
  new_disc   := StrFmtToFloatDef(lblDisc.Caption,0);
  new_disc_rp:= StrFmtToFloatDef(lblDiscRp.Caption,0);
  CURRENT_POINT:= CURRENT_POINT - lblPoint.Tag;

  appllied_produk_total(JENIS_CUSTOMER, RELASI_ID,
    new_amount, new_disc, new_disc_rp, point);

  CURRENT_POINT:= CURRENT_POINT + point;
  lblPoint.Tag:= point;

  lblDisc.Caption:= FloatToStrFmt(new_disc, True);
  lblDiscRp.Caption:= FloatToStrFmt(new_disc_rp, True);
  lblPoint.Caption:= FloatToStrFmt(CURRENT_POINT)+' Point';
end;

procedure TfrmTrsSales.ChangeCustomerTipe;
var i: integer;
begin
  if frmInputBoxCustomer.Execute(RELASI_ID, JENIS_CUSTOMER) then begin
    for i:= 1 to asgSales.RowCount-1 do begin
      if JENIS_CUSTOMER = PROD_CUST_CUSTOMER then
        lblMember.Caption:= 'Customer:'+#13#10+TMstRelation.GetName(RELASI_ID)
      else if JENIS_CUSTOMER = PROD_CUST_MEMBER then
        lblMember.Caption:= 'Member:'+#13#10+TMstRelation.GetName(RELASI_ID)
      else if JENIS_CUSTOMER = PROD_CUST_UNREG then
        lblMember.Caption:= 'UnReg:'+#13#10+TMstRelation.GetName(RELASI_ID);
      ApplliedProdukItem2(i);
      Calculate(i);
    end;
  end;  
end;

procedure TfrmTrsSales.asgSalesClickCell(Sender: TObject; ARow,
  ACol: Integer);
begin
  txtEntry.Text:= asgSales.Cells[colBarcode, ARow];
  txtEntry.Tag:= asgSales.Ints[colItemId, ARow];
  txtEntry.SetFocus;
  txtEntry.SelectAll;
end;

function TfrmTrsSales.jumlahkanPoint: integer;
begin
  Result:= lblPoint.Tag + Round(asgSales.ColumnSum(colPoint, 1, asgSales.RowCount-1));
end;

procedure TfrmTrsSales.ChangeHarga;
var ID: integer; newPrice: TMysqlResult;
begin
 // if frmInputBoxHarga.Execute(hargabaru, asgSales.Ints[colConvId, asgSales.Row]) then begin
 //   asgSales.Cells[colHarga, asgSales.Row]:= FloatToStrFmt(hargabaru);
 //   Calculate(asgSales.Row);
 // end;

  if txtEntry.Tag = 0 then Exit;

  ID:= frmInputBoxPilihHarga.Execute(txtEntry.Tag);
  if ID <> 0 then begin

    newPrice:= OpenSQL(
    'select distinct t.conversion, t.sales_price, m.mst_name, i.avg_price '+
    'from mst_item_conversion t, mst_master m, mst_item i '+
    'where t.item_id = i.item_id and t.unit_id = m.mst_id and t.conv_id = '+IntToStr(ID));

    if newPrice.RecordCount > 0 then begin
      asgSales.Ints[colConvId,   asgSales.Row]:= ID;
      asgSales.Cells[colUnit,    asgSales.Row]:= newPrice.FieldValue(2);
      asgSales.Cells[colHarga,   asgSales.Row]:= FloatToStrFmt(BufferToFloat(newPrice.FieldValue(1)));
      asgSales.Cells[colConv,    asgSales.Row]:= FloatToStrFmt(BufferToFloat(newPrice.FieldValue(0)));
      asgSales.Floats[colHrgBeli,asgSales.Row]:= BufferToFloat(newPrice.FieldValue(0)) * BufferToFloat(newPrice.FieldValue(3));

      if (BufferToFloat(newPrice.FieldValue(0)) > 1) then
        asgSales.Ints[colDontModif,asgSales.Row]:= 1
      else asgSales.Ints[colDontModif,asgSales.Row]:= 0;
      ApplliedProdukItem2(asgSales.Row);
      Calculate(asgSales.Row);
    end;
  end;
end;

procedure TfrmTrsSales.lblCasierUserClick(Sender: TObject);
begin
  frmChangePassword.Execute(GlobalSystemUser.UserId);
end;

{procedure TfrmTrsSales.Print2;
var i, x, jmlPoint: integer; data: TMysqlResult;
begin
  if GlobalSystemConfig.localSetting.PrintStruk = 0 then Exit;

  data:= OpenSQL(
  'select (d.quantity / d.conversion) as qty, d.price, '+
  'd.amount, i.struk_name, d.disc, d.disc_val, '+
  't.trans_num, t.trans_date, t.total, t.cash, (t.cash - t.total) as cash_back, '+
  't.subtotal, t.disc_mst, t.disc_val_mst, t.tax, t.points, d.sales_detail_id, '+
  '(select mst_code from mst_master u, mst_item_conversion c '+
   'where c.unit_id = u.mst_id and c.conv_id = d.conv_id) as sat '+
  'from trs_sales_mst t, trs_sales_detail d, mst_item i '+
  'where d.sales_id = t.sales_id and d.item_id = i.item_id and d.item_id is not null '+
  'and t.sales_id = '+ IntToStr(lblTransaksi.Tag)+

  ' union all '+
  'select (d.quantity / d.conversion) as qty, d.price, '+
  'd.amount, i.nama_struk as struk_name, d.disc, d.disc_val, '+
  't.trans_num, t.trans_date, t.total, t.cash, (t.cash - t.total) as cash_back, '+
  't.subtotal, t.disc_mst, t.disc_val_mst, t.tax, t.points, d.sales_detail_id, '+
  '(select mst_code from mst_master u where u.mst_id = i.unit_id) as sat '+

  'from trs_sales_mst t, trs_sales_detail d, mst_paket i '+
  'where d.sales_id = t.sales_id and d.paket_id = i.paket_id and d.paket_id is not null '+
  'and t.sales_id = '+IntToStr(lblTransaksi.Tag)+
   ' order by sales_detail_id)');

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

  if (BufferToFloat(data.FieldValue(12)) > 0) or
     (BufferToFloat(data.FieldValue(13)) > 0) or
     (BufferToFloat(data.FieldValue(14)) > 0) then
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
    if RELASI_ID <> 0 then begin
      case JENIS_CUSTOMER of
        PROD_CUST_CUSTOMER:
          GlobalStringList.Append(
            FixWidth('CUSTOMER', 10, taLeftJustify) +
            FixWidth(':', 2, taLeftJustify) +
            FixWidth(TMstRelation.GetName(RELASI_ID),28, taLeftJustify));

        PROD_CUST_MEMBER:
           GlobalStringList.Append(
            FixWidth('MEMBER', 10, taLeftJustify) +
            FixWidth(':', 2, taLeftJustify) +
            FixWidth(TMstRelation.GetName(RELASI_ID),28, taLeftJustify));
      end;
    end;
    GlobalStringList.Append(
      FixWidth('Jml Point', 10, taLeftJustify) +
      FixWidth(':', 2, taLeftJustify) +
      FixWidth(FloatToStrFmt(jmlPoint),28, taLeftJustify));

    GlobalStringList.Append(FixWidth('**catatan**',40, taCenter));
  end;

  try
  //printing struk...
    if (GlobalSystemConfig.localSetting.CutterCode <> '') and (GlobalSystemConfig.localSetting.AutoCutter = 1) then
      GlobalStringList.Append(GlobalSystemConfig.localSetting.CutterCode);

    RAWPrinter1.DocumentTitle:= 'Struk';
    RAWPrinter1.BeginDoc;
    RAWPrinter1.WriteStr(GlobalStringList.Text);
    RAWPrinter1.EndDoc;
    except raise;
      Inform('Printer tidak terpasang.');
  end;

end;
}
procedure TfrmTrsSales.ApplliedProdukItem2(xRow: integer);
var new_qty, new_price, new_disc, new_disc_rp: double;
  point, id: integer;
begin
  if asgSales.Ints[colDontModif, xRow] = 1 then exit;
  if asgSales.Ints[colIsPaket, xRow] = 0 then begin
    point:= 0;
    new_qty      := (asgSales.Floats[colQty,xRow] * asgSales.Floats[colConv,xRow]);
    new_price    := asgSales.Floats[colHarga,  xRow];
    new_disc     := asgSales.Floats[colDisc,   xRow];
    new_disc_rp  := asgSales.Floats[colDiscRp, xRow];
    CURRENT_POINT:= CURRENT_POINT - asgSales.Ints[colPoint,  xRow];
    id:= asgSales.Ints[colItemId,   xRow];

    appllied_produk(JENIS_CUSTOMER, id, RELASI_ID,
      new_qty, new_price, new_disc, new_disc_rp, point);

    CURRENT_POINT:= CURRENT_POINT + point;
    asgSales.Ints[colPoint,  xRow]:= point;
    asgSales.Cells[colHarga, xRow]:= FloatToStrFmt(new_price);
    asgSales.Cells[colDisc,  xRow]:= FloatToStrFmt(new_disc);
    asgSales.Cells[colDiscRp,xRow]:= FloatToStrFmt(new_disc_rp);
    lblPoint.Caption:= FloatToStrFmt(CURRENT_POINT)+' Point';
  end;
end;

procedure TfrmTrsSales.HoldedTrx;
begin
  if isValid then SaveHolded;
end;

procedure TfrmTrsSales.RecallHolded;
var id: integer;
begin
  id:= frmTrsSalesHoldedList.Execute;
  if id <> 0 then LoadHolded(id)
end;

end.

