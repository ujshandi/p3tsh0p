unit trsSales;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, BaseGrid, AdvGrid, SUIImagePanel, ComCtrls, ToolWin,
  ExtCtrls, StdCtrls, AdvEdit,
  strUtils, Math, UMaster, UTransaction, WinXP, Menus,
  frmDockForm, RAWPrinter, uMysqlClient, jpeg, CheckLst;

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
    Label3: TLabel;
    lblUangMuka: TLabel;
    Label7: TLabel;
    Bevel3: TBevel;
    Bevel5: TBevel;
    lblGrangTotal: TLabel;
    Label9: TLabel;
    lblPasien: TLabel;
    RAWPrinter1: TRAWPrinter;
    txtPasien: TAdvEdit;
    txtDokter: TAdvEdit;
    lblDokter: TLabel;
    Bevel7: TBevel;
    asgService: TAdvStringGrid;
    lblGridActive: TLabel;
    lblJasa: TLabel;
    lblJenisHewan: TLabel;
    Label5: TLabel;
    lblDiscountRp: TLabel;
    Panel3: TPanel;
    Label2: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    Label10: TLabel;
    Label11: TLabel;          
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    lblDiscCust: TLabel;
    chkWajib: TCheckBox;
    Button1: TButton;
    Edit1: TEdit;
    imgLogo: TImage;
    tbtNew: TToolButton;
    gridService: TAdvStringGrid;
    Label4: TLabel;
    lblFreeInfo: TLabel;
    chkAnimal: TCheckListBox;
    Label22: TLabel;
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
    procedure txtPasienKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure txtDokterKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure txtDiscountKeyPress(Sender: TObject; var Key: Char);
    procedure asgSalesEnter(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure asgServiceGetCellColor(Sender: TObject; ARow, ACol: Integer;
      AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
    procedure asgServiceGetEditorType(Sender: TObject; ACol, ARow: Integer;
      var AEditor: TEditorType);
    procedure asgServiceCanEditCell(Sender: TObject; ARow, ACol: Integer;
      var CanEdit: Boolean);
  private
    MstItem: TMstItem;
    Sales  : TTrsSales;
    lsEscapeCode,lsAnimal,lsAnimalAll,lsFree: TStringList;
    registered  : boolean;
    ResepBuffer : TMysqlResult;
    TransType : integer;

//    procedure RequeryTaxDisc;
    procedure Calculate(xrow: integer;isService:boolean=false);
    procedure CalculateDiscCustomer(xrow: integer;isService:boolean=false);
    procedure ChangeQty();
    procedure ChangeHarga();
    procedure RemoveRow();
    procedure IncreaseQty();
    procedure DecreaseQty();
    procedure RowMoveUp(var Key: Word; Shift: TShiftState);
    procedure RowMoveDown(var Key: Word; Shift: TShiftState);



    //jang ngitung bonus
    procedure IncreaseQtyCustService(aServiceType:integer);
    procedure LoadDataService(ArelationId:integer);
    function getCustService(aServiceType:integer):integer;
    procedure showFreeInfo;
    procedure checkQtyServiceKumulatif();
    procedure setGratis();
    procedure addFreeList(aServiceId,aAnimalId,aQty:integer;aReplaceQty:boolean);

    procedure EndTransaction;
    procedure DiscountPercent;
    procedure DiscountRupiah;
    procedure Rupiah;

    procedure DiscountPercentFooter;
    procedure DiscountRupiahFooter;
    procedure UangMukaFooter;

    procedure InsertSaldo;
    procedure InsertService(trxID, paketID: integer);

    function  getPasien(ID: integer; Kode: string;forHolded:boolean=false;animalSeqsHold:string=''): boolean;
    function  getDokter(ID: integer; Kode: string): boolean;
    procedure getAnimal(ID:integer;checkHolded:boolean=true);
    function getAnimalsID():string;
    procedure setAnimals(AnimalSeq:string);
    function getListAnimalCust():string;

    procedure NewPasien;
    procedure LookPasien;
    procedure NewDokter;
    procedure LookDokter;

    procedure InitGrid;
    procedure InitForm; reintroduce;
    procedure SetDisableEnable;
    procedure SeekItem;
    procedure getItem(AItemCode: string; AItemID, isPaket: integer; AQty: double; animalId:integer;AIsFree:boolean=false;animalIdList:string='');


    function ekstraksEntry(input: string): string;
    function isValid: boolean;
    function SaveHolded(): boolean;
    function LoadHolded(id:integer): boolean;

    procedure ReadRegLocalMachine();
    procedure RePrintLastTrans();
    procedure PrintResep(ID: integer);
    procedure PrintResepDetail(ID: integer;untukPasien: boolean);
    procedure showInfo;

    procedure HoldedTrx;
    procedure RecallHolded;
    procedure returTrans();

    procedure pettyCash();

    procedure printOrder(ID: integer;forHolded:boolean=false);
    function  printHeader(value: TStringList; _buffer: TMysqlResult; hal: integer;onlyColumnHeader:boolean=false): integer;
    function  printFooter(value: TStringList; idx, insIdx: integer): integer;

  public
    function isSaved(): boolean;
//    procedure Print();
    procedure Execute(id: integer=0); override;
  end;

var
  frmTrsSales: TfrmTrsSales;

implementation

uses Subroutines, UConst, UConstTool, LOVFlat,
  InputBox1, InputBoxTotal, InputBoxTax, MainMenu, trsSalesHoldedList,
  EpsonUtils, InfoSales, InfoPrice,
  MySQLConnector, Option, InputBoxCustomer,
  ChangePassword, InputBoxPilihHarga, UQueryPackage, InputBoxSaldoAwal,
  AutoStockLine, MstPasien, MstDokter, LookupData, MstRelationAnimal,
  MoneyTransaction, RawPrintPrev, UPetshop, HtmlHlp, LookupFreeService;



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

  colNo          = 0;
  colBarcode     = 1;
  colDesc        = 2;
  colQty         = 3;
  colUnit        = 4;
  colHrgDisplay  = 5;
  colDisc        = 6;
  colDiscRp      = 7;
  colTotalDisplay= 8;
  colItemId      =9 ;
  colHRata       = 10; //hrg Rata
  colProfit      = 11;
  colIsPaket     = 12;
  colDontModif   = 13;
  colHBeli       = 14;  //hrg beli
  colHarga       = 15;
  colTotal       = 16;
  colStok       = 17;
  colIsFree     = 18;
  colAnimalId   = 19;
  colServiceType = 20;
  colLast       = 21;


  colServiceJenis =1;//text jenis service
  colServiceCustJml =2;//jumlah kumulatif history yg pernah customer lakukan -->terupdate jika tipe service bonus kumulatif
  colServiceCustTotal=3;//total kumulatif history yg pernah customer lakukan
  colServiceID = 4;//ID service type
  colServiceKumulatif =5;//apakah kumulatif atau bukan
  colServiceBatas=6;//batas mendapatkan bonus
  colServiceBonus=7;//service id yg didapatkan
  colServiceBonusJml=8;//jml service yg didapatkan yg didapatkan
  colServiceCurrent=9;//jumlah transaksi service saat ini;

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
  if lblGridActive.Tag = 1 then
      getItem(barcode, 0, -1, qty,asgService.Ints[colAnimalId,asgService.Row],False)
  else
    getItem(barcode, 0, -1, qty,lblJenisHewan.Tag,False,'');//getAnimalsID
end;

procedure TfrmTrsSales.getItem(AItemCode: string; AItemID, isPaket: integer; AQty: double; animalId:integer;AIsFree:boolean=false;animalIdList:string='');
var vRow, sameID: integer;
   isFree:boolean;

  function search_same_item(existID, isPaket,pAnimalID: integer): integer;
  var i: integer;
  begin
    Result:= 0;
    if isPaket = 1 then begin
       for i:= 1 to asgService.RowCount-1 do
        if (asgService.Ints[colItemID, i] = existID) and (asgService.Ints[colIsPaket, i] = isPaket)
          and (asgService.Ints[colAnimalId, i] = pAnimalID) then begin
          Result:= i;
          exit;
        end;
    end
    else begin
      for i:= 1 to asgSales.RowCount-1 do
        if (asgSales.Ints[colItemID, i] = existID) and (asgSales.Ints[colIsPaket, i] = isPaket) then begin
          Result:= i;
          exit;
        end;
    end;
  end;

  function search_free(ExistId:integer):boolean;
  var i:integer;
  begin
     Result := True;
     for i:= 1 to asgService.RowCount-1 do
        if (asgService.Ints[colItemId, i] <> existID) and (asgService.Cells[colIsFree, i] = 'Ya') then begin
          Result:= false;
          exit;
        end;
  end;

begin

  MstItem.Reset;
  MstItem.Barcode:= AItemCode;
  MstItem.ItemId := AItemID;
  MstItem.Konsinyasi := isPaket;
  MstItem.VendorID := animalId;//lblJenisHewan.Tag;//nitip ah
  MstItem.Merk := IfThen(animalIdList='', getListAnimalCust,animalIdList);

  if MstItem.SelectPOS then begin
      //validasi utk jenis jasa harus ada jenis hewan dulu
      if (MstItem.Konsinyasi=1) and (animalId=-1) then begin // (lblJenisHewan.Tag=0) then begin
          Alert('Jenis Hewan belum ditentukan');
//          cmbAnimal.SetFocus;
          Exit;
      end;

  //  if MstItem.Konsinyasi <> 1 then begin
      sameID:= search_same_item(MstItem.ItemId, MstItem.Konsinyasi,animalId);
      if sameID <> 0 then begin

         if MstItem.Konsinyasi = 0 then begin//jika barang
           asgSales.Row:= sameID;
           vRow:= sameID;
           asgSales.Cells[colQty, vRow]:= FloatToStrFmt(asgSales.Floats[colQty, vRow] + AQty)
         end
         else begin //jasa
            asgService.Row:= sameID;
             vRow:= sameID;
            asgService.Cells[colQty, vRow]:= FloatToStrFmt(asgService.Floats[colQty, vRow] + AQty);
            if not AIsFree then
            checkQtyServiceKumulatif();
         end;
         CalculateDiscCustomer(vRow,(MstItem.Konsinyasi=1));
         Calculate(vRow,(MstItem.Konsinyasi=1));
      end else begin

        if MstItem.Konsinyasi = 0 then begin//jika barang
          if asgSales.Ints[colItemID, asgSales.RowCount-1] <> 0 then
            asgSales.AddRow;
          asgSalesEnter(asgSales);
          vRow:= asgSales.RowCount-1;
          // 0item_id, 1item_name, 2barcode, 3struk_name, 4avg_price, 5paket,6selling_price,7add_price
          asgSales.Cells[colDesc,    vRow]:= MstItem.StrukName;
          asgSales.Cells[colBarcode, vRow]:= MstItem.Barcode;
          asgSales.Ints[colItemId,   vRow]:= MstItem.ItemId;
          asgSales.Ints[colIsPaket,  vRow]:= MstItem.Konsinyasi;
          asgSales.Cells[colUnit,    vRow]:= MstItem.FItemConversion[0].MstMaster.MstCode;
          asgSales.Cells[colHarga,   vRow]:= FloatToStrFmt(MstItem.SellingPrice);
          asgSales.Cells[colHrgDisplay,   vRow]:= FloatToStrFmt(MstItem.SellingPrice);
          asgSales.Cells[colDisc,   vRow]:= FloatToStrFmt(MstItem.Discount);
          asgSales.Cells[colDiscRp,   vRow]:= FloatToStrFmt(0);//MstItem.SellingPrice);
          asgSales.Cells[colQty,     vRow]:= FloatToStrFmt(AQty);
          asgSales.Cells[colStok,     vRow]:= FloatToStrFmt(MstItem.CurrentStock);
          asgSales.Cells[colIsFree,  vRow] :='';//0;
          asgSales.Floats[colHRata,vRow]:= MstItem.AvgPrice; //harga dasar
          asgSales.Floats[colHBeli,vRow]:= MstItem.BuyingPrice;
         
          asgSales.Row:= vRow;
        end
        else begin //jasa BLOK HERE.................................
           if asgService.Ints[colItemID, asgService.RowCount-1] <> 0 then
            asgService.AddRow;
//          isFree := 0;//TMstRelation.isFreeService(txtPasien.Tag,TMstService.getServiceType(MstItem.ItemId));
          isFree := AIsFree;// isFree and search_free(MstItem.ItemId);
          asgSalesEnter(asgService);
          vRow:= asgService.RowCount-1;
          // 0item_id, 1item_name, 2barcode, 3struk_name, 4avg_price, 5paket,6selling_price,7add_price
          asgService.Cells[colDesc,    vRow]:= MstItem.StrukName;//+IfThen( isFree,' (GRATIS)','');
          asgService.Cells[colBarcode, vRow]:= MstItem.Barcode;
          asgService.Ints[colItemId,   vRow]:= MstItem.ItemId;
          asgService.Ints[colIsPaket,  vRow]:= MstItem.Konsinyasi;
          asgService.Ints[colAnimalId,  vRow]:= MstItem.VendorID;//titipan utk animalId
          asgService.Ints[colServiceType,  vRow]:= TMstService.getServiceType(MstItem.ItemId); 
          asgService.Cells[colUnit,    vRow]:= MstItem.FItemConversion[0].MstMaster.MstCode;
          asgService.Cells[colHarga,   vRow]:= FloatToStrFmt(MstItem.SellingPrice);
          asgService.Cells[colHrgDisplay,   vRow]:= FloatToStrFmt(MstItem.SellingPrice);
          asgService.Cells[colDisc,   vRow]:= FloatToStrFmt(MstItem.Discount);
          asgService.Cells[colDiscRp,   vRow]:= IfThen(isFree, FloatToStrFmt(MstItem.SellingPrice * AQty),'0');//FloatToStrFmt(0);//MstItem.SellingPrice);
          asgService.Cells[colQty,     vRow]:= FloatToStrFmt(AQty);
          asgService.Cells[colIsFree,vRow] := IfThen(isFree,'Ya','Tidak');
          asgService.Floats[colHRata,vRow]:= MstItem.AvgPrice; //harga dasar
          asgService.Floats[colHBeli,vRow]:= 0;//MstItem.FItemConversion[0].PurchasePrice;
          if not AIsFree then
            checkQtyServiceKumulatif();
          //if isFree then
           // asgService.Color
          asgService.Row:= vRow;
        end;

        txtEntry.Tag:= MstItem.ItemId;
        Calculate(vRow,(MstItem.Konsinyasi = 1));
        CalculateDiscCustomer(vRow,(MstItem.Konsinyasi=1));

      if AItemID <> 0 then txtEntry.Text:= MstItem.Barcode;
      txtEntry.SelectAll;
    end;



  end else begin
    txtEntry.SelectAll;
    if isPaket = 1 then
      Inform('Untuk transaksi Jasa/Service jenis hewan dari customer harus ditentukan terlebih dahulu.')
    else
      Inform('Data tidak ditemukan.');
  end;

end;

procedure TfrmTrsSales.InitForm;
begin
  NILAI_UANG:= 0;
  TransType := SALES_TYPE_POS;
  InitGrid;
  lblFreeInfo.Visible := False;
  lblTransaksi.Caption:= '[Nomor Transaksi]';
  lblJenisHewan.Caption := '';
  lblCustomer.Caption:= Sales.GetCustomer(lblCasierUser.Tag);
  lblTransaksi.Tag:= 0;
  lblCustomer.Tag := 0;
  lblDiscCust.Caption := '0';
  chkWajib.Checked := False;
  lblDiscCust.Visible := False;
  chkWajib.Visible := False;
  lblSubTotal.Caption:= '0';
  lblGrangTotal.Caption:= '0';
  //RequeryTaxDisc;
  txtEntry.Clear;
  txtEntry.Tag:= 0;
  lblTotal.Caption:= '0';
  lblDiscountRp.Caption:= '0';
  lblUangMuka.Caption:= '0';

  txtPasien.Clear;
  txtPasien.Tag:= 0;
  lblPasien.Caption:='';
  txtDokter.Clear;
  txtDokter.Tag:= 0;
  lblDokter.Caption:= '';
  txtPasien.Enabled := True;
  chkAnimal.Enabled := True;
  chkAnimal.Items.Clear;

  lsFree.Clear;
  gridService.ExpandAll;
   gridService.Clear;
   ResetGrid(gridService,2,6,1,1,-1);
   gridService.Cells[1,0] := 'Jenis Jasa';
   gridService.Cells[2,0] := 'Jumlah';
   gridService.Cells[3,0] := 'Total';
gridService.ContractAll;
   gridService.AutoSizeColumns(True,2);
   gridService.ColWidths[4] := 0;
   gridService.ColWidths[5] := 0;
//   gridService.ColWidths[6] := 0;
   DeleteRowTerakhir(gridService,2,1);
  
end;

procedure TfrmTrsSales.InitGrid;
begin                  //22
  ResetGrid(asgSales, 2,colLast+1 , 1,1, 2);

  asgSales.MergeCells(colQty, 0,2,1);
  asgSales.AutoSizeColumns(true, 5);

  asgSales.ColWidths[colItemId]:= 0;
  asgSales.ColWidths[colHRata]:= 0;
  asgSales.ColWidths[colProfit]:= 0;
  asgSales.ColWidths[colLast]:= 0;
  asgSales.ColWidths[colIsPaket]:= 0;
  asgSales.ColWidths[colDontModif]:= 0;
  asgSales.ColWidths[colIsFree] := 0;
  asgSales.ColWidths[colServiceType] := 0;
  asgSales.ColWidths[colAnimalId] := 0;


  asgSales.ColWidths[colHBeli]:= 0;
  asgSales.ColWidths[colHarga]:= 0;
//  asgSales.ColWidths[colBTambahan ]:= 0;
  asgSales.ColWidths[colDisc ]:= 0;
  asgSales.ColWidths[colStok ]:= 0;
//  asgSales.ColWidths[colDiscRp ]:= 0;
  asgSales.ColWidths[colTotal ]:= 0;


  asgSales.ColWidths[colBarcode]:= 115;
  asgSales.ColWidths[colQty   ]:= 50;
  asgSales.ColWidths[colUnit  ]:= 50;
  asgSales.ColWidths[colHrgDisplay ]:= 75;
  asgSales.ColWidths[colDiscRp ]:= 100;

  asgSales.ColWidths[colTotalDisplay ]:= 100;
  asgSales.RowHeights[1]:= asgSales.DefaultRowHeight;





  ///JASA                       //23
   ResetGrid(asgService, 2, colLast+1, 1,1, 2);

  asgService.MergeCells(colQty, 0,2,1);
  asgService.AutoSizeColumns(true, 5);

  asgService.ColWidths[colItemId]:= 0;
  asgService.ColWidths[colHRata]:= 0;
  asgService.ColWidths[colProfit]:= 0;
  asgService.ColWidths[colLast]:= 0;
  asgService.ColWidths[colIsPaket]:= 0;
  asgService.ColWidths[colDontModif]:= 0;
  asgService.ColWidths[colHBeli]:= 0;
  asgService.ColWidths[colHarga]:= 0;
  asgService.ColWidths[colDisc ]:= 0;
  asgService.ColWidths[colStok ]:= 0;
//  asgService.ColWidths[colBTambahan ]:= 0;//75;//0
  asgService.ColWidths[colTotal ]:= 0;
//  asgService.ColWidths[colIsFree] := 0;
  asgService.ColWidths[colServiceType] := 0;
  asgService.ColWidths[colAnimalId] := 0;

//  asgService.ColWidths[colBTambahan]:= 0;
  asgService.ColWidths[colBarcode]:= 115;
  asgService.ColWidths[colQty   ]:= 50;
  asgService.ColWidths[colUnit  ]:= 50;
  asgService.ColWidths[colHrgDisplay ]:= 75;
  asgService.ColWidths[colDiscRp ]:= 100;
//  asgSales.ColWidths[colCheck] := 0;
  asgService.ColWidths[colTotalDisplay ]:= 100;
  asgService.RowHeights[1]:= asgService.DefaultRowHeight;
   
  {if not screenLessThen1024X768 then begin
    //asgSales.ColWidths[colLast]:= 20;
    asgSales.ColWidths[colQty   ]:= 50;
    //asgSales.ColWidths[colHarga ]:= 75;
    asgSales.ColWidths[colDisc  ]:= 70;
    asgSales.ColWidths[colDiscRp]:= 75;
    asgSales.ColWidths[colTotal ]:= 100;
  end;
   }

end;

function TfrmTrsSales.isSaved(): boolean;
var i: integer; DiscDetail: double;
begin
  Sales.Clear;
  Sales.SalesMst.SalesId   := lblTransaksi.Tag;
  Sales.SalesMst.TransDate := ServerNow;
  Sales.SalesMst.TransType := TransType;//SALES_TYPE_POS;
  Sales.SalesMst.Subtotal  := StrFmtToFloatDef(lblSubTotal.Caption,0, True) ;
//  Sales.SalesMst.DiscMst   := StrFmtToFloatDef(lblTambahan.Caption,0);
    Sales.SalesMst.Dp   := StrFmtToFloatDef(lblUangMuka.Caption,0);

  Sales.SalesMst.DiscValMst:= StrFmtToFloatDef(lblDiscountRp.Caption,0);
  Sales.SalesMst.Tax       := 0;
  Sales.SalesMst.Total     := StrFmtToFloatDef(lblGrangTotal.Caption,0, True);
  Sales.SalesMst.RealAmount:= Sales.SalesMst.Total+Sales.SalesMst.Dp;
  //Sales.SalesMst.Embalase:= StrFmtToFloatDef(lblTax.Caption,0);
  Sales.SalesMst.CaraBayar:= JENIS_BAYAR;
  Sales.SalesMst.CardID:= CARD_ID;
  Sales.SalesMst.Bank:= BANK_NAME;
  Sales.SalesMst.GudangID:= GlobalSystemConfig.localSetting.LocalGudang;
   Sales.SalesMst.AnimalSeq := getAnimalsID();

 //-1000 900
  //RealAmount: jumlah pendapatan
  if (Sales.SalesMst.Total >= NILAI_UANG) then
      Sales.SalesMst.RealAmount:= NILAI_UANG
  else Sales.SalesMst.RealAmount:= Sales.SalesMst.Total;

  //untuk kasus retur
  if (Sales.SalesMst.Total < 0) then begin
    if (Sales.SalesMst.Total + NILAI_UANG) > 0 then
       NILAI_UANG:= Sales.SalesMst.Total
    else NILAI_UANG:= 0;
  end;

  Sales.SalesMst.CashierId := lblCasierUser.Tag;
  Sales.SalesMst.Cash      := NILAI_UANG;
  Sales.SalesMst.UserId    := GlobalSystemUser.UserId;
  Sales.SalesMst.Points    := 0;
  Sales.SalesMst.PasienID  := txtPasien.Tag;
  Sales.SalesMst.DokterID  := txtDokter.Tag;
  Sales.SalesMst.profit    := asgSales.ColumnSum(colProfit, 1, asgSales.RowCount-1);
  Sales.SalesMst.profit    :=
  (Sales.SalesMst.profit - Sales.SalesMst.DiscValMst) -
  (Sales.SalesMst.Subtotal * (Sales.SalesMst.DiscMst /100));

  DiscDetail:= 0;
  for i:= 1 to asgSales.RowCount - 1 do
    if not IsClear(asgSales, colItemId, i) then begin
      Sales.SalesDetail_Arr.Add(0, //nebeng id racikan

      lblTransaksi.Tag,
      IfThen(asgSales.Ints[colIsPaket,i]=0, asgSales.Ints[colItemId, i], 0),
      0,
      asgSales.Floats[colQty,i],
      asgSales.Floats[colHarga,i],
      asgSales.Floats[colDisc,i],asgSales.Floats[colDiscRp,i],
      asgSales.Floats[colTotal,i], // - asgSales.Floats[colEmbalase,i],
      1,
      asgSales.Floats[colHRata, i],
      asgSales.Floats[colProfit, i],0,
      IfThen(asgSales.Ints[colIsPaket,i]=1, asgSales.Ints[colItemId, i], 0),0,0,0,
      asgSales.Floats[colHBeli,i],0,0,0);
      DiscDetail:= DiscDetail + 0 +0;
//      ((asgSales.Floats[colDisc, i] /100) * (asgSales.Floats[colQty,i]*asgSales.Floats[colHarga,i]));
    end;

    for i:= 1 to asgService.RowCount - 1 do
    if not IsClear(asgService, colItemId, i) then begin
      Sales.SalesDetail_Arr.Add(0, //nebeng id racikan

      lblTransaksi.Tag,
      IfThen(asgService.Ints[colIsPaket,i]=0, asgService.Ints[colItemId, i], 0),
      0,
      asgService.Floats[colQty,i],
      asgService.Floats[colHarga,i],
      0,0,
      asgService.Floats[colTotal,i], // - asgSales.Floats[colEmbalase,i],
      1,
      asgService.Floats[colHRata, i],
      asgService.Floats[colProfit, i],0,
      IfThen(asgService.Ints[colIsPaket,i]=1, asgService.Ints[colItemId, i], 0),0,0,0,
      asgService.Floats[colHBeli,i],asgService.Ints[colServiceType,i],IfThen(asgService.Cells[colIsFree,i]='Ya',1,0),asgService.Ints[colAnimalId,i]);
      DiscDetail:= DiscDetail + 0 +0;
//      ((asgSales.Floats[colDisc, i] /100) * (asgSales.Floats[colQty,i]*asgSales.Floats[colHarga,i]));
    end;

  Sales.SalesMst.DiscDetail:= DiscDetail;

 // if (lblTransaksi.Tag = 0) then
    Result:= Sales.InsertCashOnDB(lblCustomer.Tag);//
 // else Result:= false;
 //
  lblTransaksi.Caption:= Sales.SalesMst.TransNum;
  lblTransaksi.Tag := Sales.SalesMst.SalesId;

  if Result then begin

    if GlobalSystemConfig.localSetting.PrintStruk = 0 then Exit;
    try
    //kicking cash drawer...
 //     SendEscapeCode(GlobalSystemConfig.localSetting.DrawerCode);

   //priting cash drawer...
     // Self.Print;
     if Confirmed('Cetak Struk?')then
       Self.printOrder(Sales.SalesMst.SalesId);
    except raise;
      Inform('Printer tidak terpasang.');
    end;
  end;
end;

function TfrmTrsSales.isValid: boolean;
var i: integer;  msg:string;
   rsItem,rsService : boolean;

begin
  Result:= False;
  rsItem:=False;
  rsService:=False;
{  grandTotal := StrFmtToFloatDef(lblSubTotal.Caption,0, True);
  disc := StrFmtToFloatDef(lblDiscountRp.Caption,0, True);
  //ambil discount cust dulu
  discMax := TMstRelation.GetDiscount(txtPasien.Tag);

  if discMax = 0 then
    discMax := StrToFloatDef(TSystemConfig.getValue(CONF_DISC_VAL_PROMO),0);

  discMax := grandTotal * discMax / 100;}
  for i:= 1 to asgSales.RowCount-1 do begin
    rsItem:= not IsClear(asgSales, colItemId, i);
    msg :=  'Tidak ada item untuk disimpan.';

  end;

  for i:= 1 to asgService.RowCount-1 do begin
      rsService:= not IsClear(asgService, colItemId, i);
      msg :=  'Tidak ada service untuk disimpan.';
  end;
  Result := (rsItem or rsService);

{   if Result then begin
        if (disc>0) then Result := (disc<=discMax);
        msg:='Nilai discount melebihi ketentuan manajemen!';
    end;}

    
    
  if not Result then
      Alert(msg);
end;

{procedure TfrmTrsSales.Print;
var i: integer;
  racikan_mode: boolean;
begin

  if GlobalSystemConfig.localSetting.PrintStruk = 0 then Exit;
//  racikan_mode:= getEm() > 0;
  GlobalStringList.Clear;
  RAWPrinter1.PrinterName:= GlobalSystemConfig.localSetting.PrinterStruk;

//open drawer first
  if (GlobalSystemConfig.localSetting.DrawerCode <> '') then
    GlobalStringList.Append(GlobalSystemConfig.localSetting.DrawerCode)
  else if (GlobalSystemConfig.localSetting.JenisDrawer = 1) then
    openDirectDrawer(GlobalSystemConfig.localSetting.PortName);
            //R20090200006 20/02/2009 12:45
  GlobalStringList.Append(
    FixWidth(lblTransaksi.Caption, 14, taLeftJustify) +
    FixWidth(FormatDateTime('dd/MM/yyyy hh:mm', ServerCurrDateTime), 16, taRightJustify));

  GlobalStringList.Append(
    FixWidth('Kasir : '+GlobalSystemUser.UserId, 30, taLeftJustify));

  GlobalStringList.Append(FixWidth('-----------------------------------------',40, taLeftJustify));
  for i := 1 to asgSales.RowCount-1 do
  if not IsClear(asgSales, colItemId, i) then
    with GlobalStringList do begin
      Append(FixWidth(asgSales.Cells[colDesc, i],40, taLeftJustify));

    //kasus normal
      if (asgSales.Floats[colDisc, i] = 0) and (asgSales.Floats[colDiscRp, i] = 0) then
        Append(
          FixWidth(asgSales.Cells[colQty, i]+' '+asgSales.Cells[colUnit, i], 12, taRightJustify) +
          FixWidth(' X ', 3, taLeftJustify) +
          FixWidth(asgSales.Cells[colHrgDisplay, i], 12, taRightJustify)+
          FixWidth(asgSales.Cells[colTotal, i], 13, taRightJustify))

    //kasus ada 1 discont
      else if (asgSales.Floats[colDisc, i] <> 0) or (asgSales.Floats[colDiscRp, i] <> 0) then
        Append(
          FixWidth(asgSales.Cells[colQty, i]+' '+asgSales.Cells[colUnit, i], 9, taRightJustify) +
          FixWidth(' X', 2, taLeftJustify) +
          FixWidth(asgSales.Cells[colHrgDisplay, i], 9, taRightJustify)+
          IfThen(asgSales.Cells[colDisc, i]<> '0',
          FixWidth(' -'+asgSales.Cells[colDisc, i]+'%', 9, taRightJustify))+
          IfThen(asgSales.Cells[colDiscRp, i]<> '0',
          FixWidth(' -'+asgSales.Cells[colDiscRp, i], 9, taRightJustify))+
          FixWidth(asgSales.Cells[colTotal, i], 11, taRightJustify))

    //kasus ada 2 discont
      else if (asgSales.Floats[colDisc, i] <> 0) and (asgSales.Floats[colDiscRp, i] <> 0) then begin
        Append(
          FixWidth(asgSales.Cells[colQty, i]+' '+asgSales.Cells[colUnit, i], 10, taRightJustify) +
          FixWidth(' X ', 3, taLeftJustify) +
          FixWidth(asgSales.Cells[colHrgDisplay, i], 9, taRightJustify)+
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

  {if (StrFmtToFloatDef(lblTax.Caption,0) > 0) then
  GlobalStringList.Append(
    FixWidth('Embalase', 14, taLeftJustify) +
    FixWidth(':', 2, taLeftJustify) +
    FixWidth(lblTax.Caption ,24, taRightJustify));}

{  if (StrFmtToFloatDef(lblTax.Caption,0) > 0) or
     (StrFmtToFloatDef(lblDiscRp.Caption,0) > 0) or
     (StrFmtToFloatDef(lblDisc.Caption,0) > 0) then
  GlobalStringList.Append(
    FixWidth('Grand Total', 14, taLeftJustify) +
    FixWidth(':', 2, taLeftJustify) +
    FixWidth(lblGrangTotal.Caption ,24, taRightJustify));

  case JENIS_BAYAR of
   0:begin
       GlobalStringList.Append(
        FixWidth('Tunai', 14, taLeftJustify) +
        FixWidth(':', 2, taLeftJustify) +
        FixWidth(FloatToStrFmt(NILAI_UANG) ,24, taRightJustify));

       GlobalStringList.Append(
        FixWidth('Kembali', 14, taLeftJustify) +
        FixWidth(':', 2, taLeftJustify) +
        FixWidth(FloatToStrFmt(NILAI_UANG - StrFmtToFloatDef(lblGrangTotal.Caption,0)),24, taRightJustify));
     end;

     1,2:begin
       GlobalStringList.Append(
        FixWidth(IfThen(JENIS_BAYAR=1, 'Kartu Debet', 'Kartu Kredit'), 14, taLeftJustify) +
        FixWidth(':', 2, taLeftJustify) +
        FixWidth(FloatToStrFmt(NILAI_UANG) ,24, taRightJustify));
     end;
  end;

  GlobalStringList.Append('');
  if txtPasien.Tag <> 0 then begin
     GlobalStringList.Append(
     FixWidth('PASIEN', 10, taLeftJustify) +
            FixWidth(':', 2, taLeftJustify) +
            FixWidth(TMstPasien.GetName(txtPasien.Tag),28, taLeftJustify));
  end;
  if racikan_mode then begin
    GlobalStringList.Append(FixWidth('-----------------------------------------',40, taLeftJustify));
    GlobalStringList.Append(
      FixWidth('|',1, taLeftJustify)+
      FixWidth('HARGA', 12, taCenter)+
      FixWidth('|',1, taCenter)+
      FixWidth('KEMAS', 12, taCenter)+
      FixWidth('|',1, taCenter)+
      FixWidth('SERAH', 12, taRightJustify)+
      FixWidth('|',1, taRightJustify));
    GlobalStringList.Append(FixWidth('-----------------------------------------',40, taLeftJustify));
    GlobalStringList.Append(
      FixWidth('|',13, taLeftJustify)+
      FixWidth('|',13, taLeftJustify)+
      FixWidth('|',13, taLeftJustify)+
      FixWidth('|',1, taRightJustify));
    GlobalStringList.Append(
      FixWidth('|',13, taLeftJustify)+
      FixWidth('|',13, taLeftJustify)+
      FixWidth('|',13, taLeftJustify)+
      FixWidth('|',1, taRightJustify));
    GlobalStringList.Append(FixWidth('-----------------------------------------',40, taLeftJustify));
    GlobalStringList.Append(
      FixWidth('|',1, taLeftJustify)+
      FixWidth('ETIKET LKP', 12, taCenter)+
      FixWidth('|',1, taLeftJustify)+
      FixWidth('BARANG LKP', 12, taCenter)+
      FixWidth('|',1, taLeftJustify)+
      FixWidth('TANDA TERIMA', 12, taRightJustify)+
      FixWidth('|',1, taRightJustify));
    GlobalStringList.Append(FixWidth('-----------------------------------------',40, taLeftJustify));
    GlobalStringList.Append(
      FixWidth('|',13, taLeftJustify)+
      FixWidth('|',13, taLeftJustify)+
      FixWidth('|',13, taLeftJustify)+
      FixWidth('|',1, taRightJustify));
    GlobalStringList.Append(
      FixWidth('|',13, taLeftJustify)+
      FixWidth('|',13, taLeftJustify)+
      FixWidth('|',13, taLeftJustify)+
      FixWidth('|',1, taRightJustify));
    GlobalStringList.Append(FixWidth('-----------------------------------------',40, taLeftJustify));
  end;

  GlobalStringList.Append('');

  if GlobalSystemConfig[CONF_FOOTER1-1].ConfValue <> '' then
    GlobalStringList.Append(FixWidth(GlobalSystemConfig[CONF_FOOTER1-1].ConfValue, 40, taCenter));

  if GlobalSystemConfig[CONF_FOOTER2-1].ConfValue <> '' then
    GlobalStringList.Append(FixWidth(GlobalSystemConfig[CONF_FOOTER2-1].ConfValue, 40, taCenter));

  try
  //printing struk...
    //x:= GlobalSystemConfig.localSetting.MarginBottom;
    //for i:= 1 to x do GlobalStringList.Append(' ');

    GlobalStringList.Append('');
    GlobalStringList.Append('');
    GlobalStringList.Append('');
    GlobalStringList.Append('');
    GlobalStringList.Append('');

//    GlobalStringList.Append(FixWidth(CompanyProfile.FCompanyName, 40, taCenter));
    GlobalStringList.Append(FixWidth(CompanyProfile.FAddress, 40, taCenter));
    GlobalStringList.Append(FixWidth(CompanyProfile.FTelp1, 40, taCenter));
    GlobalStringList.Append(FixWidth(CompanyProfile.FCity, 40, taCenter));
   // If CompanyProfile.FNpwp <> '' then
     // GlobalStringList.Append(FixWidth('NPWP : ' + CompanyProfile.FNpwp, 40, taCenter));
    GlobalStringList.Append(' ');

    if (GlobalSystemConfig.localSetting.CutterCode <> '') and (GlobalSystemConfig.localSetting.AutoCutter = 1) then
      GlobalStringList.Append(GlobalSystemConfig.localSetting.CutterCode);

    RAWPrinter1.DocumentTitle:= 'Struk';
    RAWPrinter1.BeginDoc;
    RAWPrinter1.WriteStr(GlobalStringList.Text);
    RAWPrinter1.EndDoc;

    except raise;
      Inform('Printer tidak terpasang.');
  end;

end;  }

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
  lblJenisHewan.Tag := 0;
  if lblGridActive.Tag =  1 then Sender := asgService else Sender := asgSales;
  case Key of
    VK_UP:
    begin
      if ((Sender as TAdvStringGrid).Row = 1) and (Sender <> nil) then begin
        txtEntry.Text:= (Sender as TAdvStringGrid).Cells[colBarcode, (Sender as TAdvStringGrid).Row];
        txtEntry.Tag:= (Sender as TAdvStringGrid).Ints[colItemId, (Sender as TAdvStringGrid).Row];
        lblJenisHewan.Tag := StrToIntDef( (Sender as TAdvStringGrid).Cells[colAnimalId, (Sender as TAdvStringGrid).Row],0)
      end

      else if ((Sender as TAdvStringGrid).Row > 1) and (Sender <> nil) then begin
        txtEntry.Text:= (Sender as TAdvStringGrid).Cells[colBarcode, (Sender as TAdvStringGrid).Row-1];
        txtEntry.Tag:= (Sender as TAdvStringGrid).Ints[colItemId, (Sender as TAdvStringGrid).Row-1];
        lblJenisHewan.Tag := StrToIntDef( (Sender as TAdvStringGrid).Cells[colAnimalId, (Sender as TAdvStringGrid).Row-1],0)
      end
      else if ((Sender as TAdvStringGrid).Row = 1) and (Sender = nil) then begin
        txtEntry.Text:= (Sender as TAdvStringGrid).Cells[colBarcode, 1];
        txtEntry.Tag:= (Sender as TAdvStringGrid).Ints[colItemId, 1];
        lblJenisHewan.Tag := StrToIntDef( (Sender as TAdvStringGrid).Cells[colAnimalId, 1],0)
      end
      else if ((Sender as TAdvStringGrid).Row > 1) and (Sender = nil) then begin
        txtEntry.Text:= (Sender as TAdvStringGrid).Cells[colBarcode, (Sender as TAdvStringGrid).Row];
        txtEntry.Tag:= (Sender as TAdvStringGrid).Ints[colItemId, (Sender as TAdvStringGrid).Row];
        lblJenisHewan.Tag := StrToIntDef( (Sender as TAdvStringGrid).Cells[colAnimalId, (Sender as TAdvStringGrid).Row],0)
      end;
      txtEntry.SelectAll;
    end;

    VK_DOWN:
    begin
      if ((Sender as TAdvStringGrid).Row = (Sender as TAdvStringGrid).RowCount-1) and (Sender <> nil) then begin
        txtEntry.Text:= (Sender as TAdvStringGrid).Cells[colBarcode, (Sender as TAdvStringGrid).RowCount-1];
        txtEntry.Tag:= (Sender as TAdvStringGrid).Ints[colItemId, (Sender as TAdvStringGrid).RowCount-1];
        lblJenisHewan.Tag := StrToIntDef( (Sender as TAdvStringGrid).Cells[colAnimalId, (Sender as TAdvStringGrid).Row],0)
      end
      else if ((Sender as TAdvStringGrid).Row < (Sender as TAdvStringGrid).RowCount-1) and (Sender <> nil) then begin
        txtEntry.Text:= (Sender as TAdvStringGrid).Cells[colBarcode, (Sender as TAdvStringGrid).Row+1];
        txtEntry.Tag:= (Sender as TAdvStringGrid).Ints[colItemId, (Sender as TAdvStringGrid).Row+1];
        lblJenisHewan.Tag := StrToIntDef( (Sender as TAdvStringGrid).Cells[colAnimalId, (Sender as TAdvStringGrid).Row+1],0)
      end
      else if ((Sender as TAdvStringGrid).Row = (Sender as TAdvStringGrid).RowCount-1) and (Sender = nil) then begin
        txtEntry.Text:= (Sender as TAdvStringGrid).Cells[colBarcode, (Sender as TAdvStringGrid).RowCount+1];
        txtEntry.Tag:= (Sender as TAdvStringGrid).Ints[colItemId, (Sender as TAdvStringGrid).RowCount+1];
        lblJenisHewan.Tag := StrToIntDef( (Sender as TAdvStringGrid).Cells[colAnimalId, (Sender as TAdvStringGrid).Rowcount+1],0)
      end
      else if ((Sender as TAdvStringGrid).Row < (Sender as TAdvStringGrid).RowCount-1) and (Sender = nil) then begin
        txtEntry.Text:= (Sender as TAdvStringGrid).Cells[colBarcode, (Sender as TAdvStringGrid).RowCount-1];
        txtEntry.Tag:= (Sender as TAdvStringGrid).Ints[colItemId, (Sender as TAdvStringGrid).RowCount-1];
        lblJenisHewan.Tag := StrToIntDef( (Sender as TAdvStringGrid).Cells[colAnimalId, (Sender as TAdvStringGrid).Rowcount-1],0)
      end;
      txtEntry.SelectAll;
    end
    else txtEntry.SetFocus;
  end;
end;

procedure TfrmTrsSales.Calculate(xrow: integer;isService:boolean=false);
var total, totalDisplay, disDetRp, disDetPrc, 
  disTotal, disTotalVal,dp: double;
begin
  total := 0;

  if isService then begin
    total := asgService.Floats[colQty,  xRow] * asgService.Floats[colHarga, xRow];
    disDetRp := asgService.Floats[colDiscRp, xrow];
    disDetPrc:= 0;//asgSales.Floats[colDisc, xrow];
    disDetPrc:= total * (disDetPrc/100);

    total:= total - disDetRp - disDetPrc;
    asgService.Cells[colTotal, xrow]:= FloatToStrFmt(total);
      asgService.Floats[colProfit, xRow]:= total -
        (asgService.Floats[colQty, xRow] * asgService.Floats[colHBeli, xRow]);
  end
  else begin
    total := asgSales.Floats[colQty,  xRow] * asgSales.Floats[colHarga, xRow];
    disDetRp := asgSales.Floats[colDiscRp, xrow];
    disDetPrc:= 0;//asgSales.Floats[colDisc, xrow];
    disDetPrc:= total * (disDetPrc/100);

    total:= total - disDetRp - disDetPrc;
    asgSales.Cells[colTotal, xrow]:= FloatToStrFmt(total);

    if GlobalSystemConfig[CONF_HARGA-1].ConfValue = IntToStr(HARGA_RATA) then
      asgSales.Floats[colProfit, xRow]:= total -
        (asgSales.Floats[colQty, xRow] * asgSales.Floats[colHRata, xRow])
    else
      asgSales.Floats[colProfit, xRow]:= total -
        (asgSales.Floats[colQty, xRow] * asgSales.Floats[colHBeli, xRow]);


  end;



  totalDisplay:= total;

//langsung dikaIikan



//header
    total:= asgSales.ColumnSum(colTotal, 1, asgSales.RowCount-1)+asgService.ColumnSum(colTotal, 1, asgService.RowCount-1);

//header

  lblSubTotal.Caption:= FloatToStrFmt(total, True);

//recalculate after ApplliedProdukTotal

  total:= StrFmtToFloatDef(lblSubTotal.Caption,0, True); //%
  lblSubTotal.Caption:= FloatToStrFmt(total, True);
  disTotalVal:= StrFmtToFloatDef(lblDiscountRp.Caption,0); //rp
  dp := StrFmtToFloatDef(lblUangMuka.Caption,0);
  disTotal:= 0;//StrFmtToFloatDef(lblDisc.Caption,0); //%
  disTotal:= (disTotal/100) * (total);

  total:= (total) - disTotal - disTotalVal - dp ;

  lblGrangTotal.Caption:= FloatToStrFmt(total, true);
  lblTotal.Caption:= lblGrangTotal.Caption;

 if isService then
    asgService.Floats[colTotalDisplay,  xRow]:= totalDisplay //asgSales.Floats[colEmbalase,  xRow];
 else
    asgSales.Floats[colTotalDisplay,  xRow]:= totalDisplay + 0;//asgSales.Floats[colEmbalase,  xRow];

end;

procedure TfrmTrsSales.ChangeQty();
var Qty: double;
begin

  if (lblGridActive.tag=0) then begin
    Qty:= asgSales.Floats[colQty, asgSales.Row];
    if frmInputBox1.Execute(Qty, 'Quantity', false) then
       asgSales.Cells[colQty, asgSales.Row]:= IfThen(Qty<0,asgSales.Cells[colQty, asgSales.Row], FloatToStrFmt(Qty));
    Calculate(asgSales.Row);
  end
  else if (lblGridActive.tag=1) then begin
    Qty:= asgService.Floats[colQty, asgService.Row];
    if frmInputBox1.Execute(Qty, 'Quantity', false) then
       asgService.Cells[colQty, asgService.Row]:= IfThen(Qty<0,asgService.Cells[colQty, asgService.Row], FloatToStrFmt(Qty));
      checkQtyServiceKumulatif(); 
    Calculate(asgService.Row,true);
  end;
end;

{procedure TfrmTrsSales.RequeryTaxDisc;
begin
  lblDisc.Caption  := FloatToStrFmt(StrFmtToFloatDef(GlobalSystemConfig[CONF_DISC_PROMO-1].ConfValue,0));
  lblDiscRp.Caption:= FloatToStrFmt(StrFmtToFloatDef(GlobalSystemConfig[CONF_DISC_VAL_PROMO-1].ConfValue,0));
  lblTax.Caption   := FloatToStrFmt(StrFmtToFloatDef(GlobalSystemConfig[CONF_PPn-1].ConfValue,0));
end;
}
procedure TfrmTrsSales.Execute(id: integer);
begin
  inherited;
  MstItem := TMstItem.Create;
  Sales   := TTrsSales.Create;
  lsEscapeCode:= TStringList.Create;
  lsAnimal := TStringList.Create;
  lsAnimalAll := TStringList.Create;
  lsFree := TStringList.Create;

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
//  imgCashierRight.Picture.Bitmap.Handle:= LoadBitmap(ImageDll, 'cashier_big');
  Run(Self);
end;

procedure TfrmTrsSales.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if MstItem <> nil then MstItem.Free;
  MstItem:= nil;
  if Sales <> nil then Sales.Free;
  Sales:= nil;
  lsAnimal.Free;
  lsAnimalAll.Free;
  lsFree.Free;
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

  //if (Shift = [ssAlt]) and (key = Ord('M')) then ChangeCustomerTipe
  if (Shift = [ssAlt]) and (key = Ord('H')) then HoldedTrx
  else if (Shift = [ssAlt]) and (key = Ord('C')) then RecallHolded
  else if (Shift = [ssAlt]) and (key = Ord('R')) then tbtReport.Click
  else if (Shift = [ssAlt]) and (key = Ord('T')) then tbtOption.Click
//  else if (Shift = [ssAlt]) and (key = Ord('O')) then tbtOpen.Click
  else if (Shift = [ssAlt]) and (key = Ord('N')) then tbtNew.Click
  else if (Shift = [ssAlt]) and (key = Ord('L')) then tbtLogOff.Click
  else if (Shift = [ssAlt]) and (key = Ord('X')) then tbtExit.Click
  else if (Shift = [ssAlt]) and (key = Ord('P')) then tbtOpen.Click
  else if (Shift = [ssAlt]) and (key = Ord('G')) then setGratis

  //resep
 // else if (Shift = [ssAlt]) and (key = Ord('S')) then InsertResep
//  else if (Shift = [ssAlt]) and (key = Ord('P')) then txtPasien.SetFocus
//  else if (Shift = [ssAlt]) and (key = Ord('A')) then InsertSaldo
//  else if (Shift = [ssAlt]) and (key = Ord('M')) then Rupiah
//  else if (Shift = [ssAlt]) and (key = Ord('E')) then InsertEmabalase

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
//    vk_F1  : showInfo;
    vk_F2  : SeekItem;

    vk_F3  : if txtEntry.Tag <> 0 then EndTransaction;
 //
  //  vk_F5  : if txtEntry.Tag <> 0 then DiscountPercent;
    VK_F4  : if txtEntry.Tag <> 0 then UangMukaFooter;
    vk_F5  : if txtEntry.Tag <> 0 then DiscountRupiah;
    vk_F6  : if txtEntry.Tag <> 0 then DiscountRupiahFooter;

  //  vk_F7  : if txtEntry.Tag <> 0 then DiscountPercentFooter;

    vk_F7  : frmInfoPrice.Execute;
    vk_F8 :
    begin
       if Confirmed('Transaksi Holded akan dihapus?') then begin
         Sales.DelHolded(lblCustomer.Tag);
         InitForm;
       end;
    end;
  //  vk_F9  : RePrintLastTrans;

    vk_F9 : returTrans;


    vk_F10 : if txtEntry.Tag <> 0 then ChangeQty;
    vk_F11 : NewPasien;
   // vk_F12 : pettyCash;

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
  Sales.SalesMst.Subtotal  := StrFmtToFloatDef(lblSubTotal.Caption,0, true) ;
  Sales.SalesMst.profit    := asgSales.ColumnSum(colProfit, 1, asgSales.RowCount-1);
//  Sales.SalesMst.DiscValMst   := StrFmtToFloatDef(lblDiscountRp.Caption,0, true);
  Sales.SalesMst.Dp   := StrFmtToFloatDef(lblUangMuka.Caption,0, true);
  Sales.SalesMst.DiscValMst:= StrFmtToFloatDef(lblDiscountRp.Caption,0, true);
  Sales.SalesMst.Tax:= 0;
  
  Sales.SalesMst.Total     := StrFmtToFloatDef(lblGrangTotal.Caption,0, true);
  Sales.SalesMst.CashierId := lblCasierUser.Tag;
  Sales.SalesMst.UserId    := GlobalSystemUser.UserId;
  Sales.SalesMst.Points    := 0;
  Sales.SalesMst.PasienID  := txtPasien.Tag;
  Sales.SalesMst.GudangID  := GlobalSystemConfig.localSetting.LocalGudang;
  Sales.SalesMst.DokterID  := txtDokter.Tag;
//  Sales.SalesMst.AnimalID  := getAnimalsID();// //lblJenisHewan.Tag;
  //if cmbAnimal.ItemIndex <> -1 then
    Sales.SalesMst.AnimalSeq := getAnimalsID();// StrToInt(lsAnimal.Names[cmbAnimal.itemIndex]);
//  Sales.SalesMst.Embalase:= StrFmtToFloatDef(lblTax.Caption,0);


  for i:= 1 to asgSales.RowCount - 1 do
    if not IsClear(asgSales, colItemId, i) then begin
      Sales.SalesDetail_Arr.Add(0, //nebeng id racikan
      lblCustomer.Tag,
      IfThen(asgSales.Ints[colIsPaket,i]=0, asgSales.Ints[colItemId, i], 0),
      0,//IfThen(asgSales.Ints[colIsPaket,i]=0, asgSales.Ints[colConvId, i], 0),
      asgSales.Floats[colQty,i],//ConvertToSaveConvertion(asgSales.Floats[colQty,i], asgSales.Floats[colConv,i]),
      asgSales.Floats[colHarga,i],
      asgSales.Floats[colDisc,i], asgSales.Floats[colDiscRp,i],
      asgSales.Floats[colTotal,i], 1,
      asgSales.Floats[colHRata, i], asgSales.Floats[colProfit, i],0,
      IfThen(asgSales.Ints[colIsPaket,i]=1, asgSales.Ints[colItemId, i],0),0,0,0,
      asgSales.Floats[colHBeli,i],0,0,0);
    end;

  for i:= 1 to asgService.RowCount - 1 do
    if not IsClear(asgService, colItemId, i) then begin
      Sales.SalesDetail_Arr.Add(0, //nebeng id racikan
      lblCustomer.Tag,
      IfThen(asgService.Ints[colIsPaket,i]=0, asgService.Ints[colItemId, i], 0),
      0,//IfThen(asgSales.Ints[colIsPaket,i]=0, asgSales.Ints[colConvId, i], 0),
      asgService.Floats[colQty,i],//ConvertToSaveConvertion(asgSales.Floats[colQty,i], asgSales.Floats[colConv,i]),
      asgService.Floats[colHarga,i],
      asgService.Floats[colDisc,i], asgService.Floats[colDiscRp,i],
      asgService.Floats[colTotal,i], 1,
      asgService.Floats[colHRata, i], asgService.Floats[colProfit, i],0,
      IfThen(asgService.Ints[colIsPaket,i]=1, asgService.Ints[colItemId, i],0),0,0,0,
      asgService.Floats[colHBeli,i],asgService.Ints[colServiceType,i],IfThen( asgService.Cells[colIsFree,i]='Ya',1,0),asgService.Ints[colAnimalId,i]);
    end;  

  Result:= Sales.InsertHolded;
  if Result then begin
        if Sales.SalesMst.Dp > 0 then begin
          try

          if Confirmed('Cetak Struk?')then
             Self.printOrder(Sales.SalesMst.SalesId,True);
          except raise;
            Inform('Printer tidak terpasang.');
          end;
        end;
      InitForm;
  end;
end;

function TfrmTrsSales.LoadHolded(id: integer): boolean;
var i,rowSales,rowService,totalServiceHotel,totalServiceGrooming,totalServiceLain,total: integer; cust: string;
begin
  InitForm;
  Sales.Clear;
  Sales.SalesMst.SalesId:= id;
  Result:= Sales.SelectHolded;
  lblCustomer.Tag:= Sales.SalesMst.SalesId;
  lblUangMuka.Caption := FloatToStrFmt(Sales.SalesMst.Dp);
  lblDiscountRp.Caption := FloatToStrFmt(Sales.SalesMst.DiscValMst);
  rowSales:= 0;rowService := 0;

  txtPasien.Tag:= Sales.SalesMst.PasienID;
  txtPasien.Text:= TMstRelation.GetName(Sales.SalesMst.PasienID);
  txtPasien.Enabled :=  False;

  getPasien(Sales.SalesMst.PasienID,'',True,Sales.SalesMst.AnimalSeq);
  


  for i:= 0 to Sales.SalesDetail_Arr.Count-1 do begin
    if (Sales.SalesDetail_Arr[i].PaketID = 0) then begin
      asgSales.Ints[colNo, rowSales+1]:= rowSales+1;
      asgSales.Cells[colBarcode,  rowSales+1]:= Sales.SalesDetail_Arr[i].MstItem.Barcode;
      asgSales.Cells[colDesc,     rowSales+1]:= Sales.SalesDetail_Arr[i].MstItem.ItemName;
      asgSales.Cells[colUnit,     rowSales+1]:= Sales.SalesDetail_Arr[i].MstItemConversion.MstMaster.MstCode;
      asgSales.Cells[colQty,      rowSales+1]:= FloatToStrFmt(Sales.SalesDetail_Arr[i].Quantity);
      asgSales.Cells[colHarga,    rowSales+1]:= FloatToStrFmt(Sales.SalesDetail_Arr[i].Price);
      asgSales.Cells[colHrgDisplay,rowSales+1]:= FloatToStrFmt(Sales.SalesDetail_Arr[i].Price + Sales.SalesDetail_Arr[i].ConvBonus);
       asgSales.Cells[colDisc,     rowSales+1]:= FloatToStrFmt(Sales.SalesDetail_Arr[i].Disc);
      asgSales.Cells[colDiscRp,   rowSales+1]:= FloatToStrFmt(Sales.SalesDetail_Arr[i].DiscVal);
      asgSales.Cells[colTotal,    rowSales+1]:= FloatToStrFmt(Sales.SalesDetail_Arr[i].Amount);
      asgSales.Cells[colTotaldISPLAY,    rowSales+1]:= FloatToStrFmt(Sales.SalesDetail_Arr[i].Amount + Sales.SalesDetail_Arr[i].ConvBonus);
      asgSales.Floats[colHRata, rowSales+1]:= Sales.SalesDetail_Arr[i].PricePurchase;
      asgSales.Floats[colProfit,  rowSales+1]:= Sales.SalesDetail_Arr[i].AmountProfit;
      asgSales.Ints[colItemID,    rowSales+1]:= Sales.SalesDetail_Arr[i].MstItem.ItemId;
      asgSales.Ints[colIsPaket,   rowSales+1]:= Sales.SalesDetail_Arr[i].PaketID; //numpang is paket
      asgSales.Floats[colHBeli,   rowSales+1]:= Sales.SalesDetail_Arr[i].HrgBeli; //numpang is paket
      Calculate(rowSales+1);
      Inc(rowSales);
      asgSales.AddRow;
    end
    else begin ///tipe jasa
        asgService.Ints[colNo, rowService+1]:= rowService+1;
        asgService.Cells[colBarcode,  rowService+1]:= Sales.SalesDetail_Arr[i].MstItem.Barcode;
        asgService.Cells[colDesc,     rowService+1]:= Sales.SalesDetail_Arr[i].MstItem.ItemName;
        asgService.Cells[colUnit,     rowService+1]:= Sales.SalesDetail_Arr[i].MstItemConversion.MstMaster.MstCode;
        asgService.Cells[colQty,      rowService+1]:= FloatToStrFmt(Sales.SalesDetail_Arr[i].Quantity);
        asgService.Cells[colHarga,    rowService+1]:= FloatToStrFmt(Sales.SalesDetail_Arr[i].Price);
        asgService.Cells[colHrgDisplay,rowService+1]:= FloatToStrFmt(Sales.SalesDetail_Arr[i].Price + Sales.SalesDetail_Arr[i].ConvBonus);
        asgService.Cells[colDisc,     rowService+1]:= FloatToStrFmt(Sales.SalesDetail_Arr[i].Disc);
        asgService.Cells[colDiscRp,   rowService+1]:= FloatToStrFmt(Sales.SalesDetail_Arr[i].DiscVal);
        asgService.Cells[colTotal,    rowService+1]:= FloatToStrFmt(Sales.SalesDetail_Arr[i].Amount);
        asgService.Cells[colTotaldISPLAY,    rowService+1]:= FloatToStrFmt(Sales.SalesDetail_Arr[i].Amount + Sales.SalesDetail_Arr[i].ConvBonus);
        asgService.Floats[colHRata, rowService+1]:= Sales.SalesDetail_Arr[i].PricePurchase;
        asgService.Floats[colProfit,  rowService+1]:= Sales.SalesDetail_Arr[i].AmountProfit;
        asgService.Ints[colItemID,    rowService+1]:= Sales.SalesDetail_Arr[i].MstItem.ItemId;
        asgService.Ints[colIsPaket,   rowService+1]:= Sales.SalesDetail_Arr[i].PaketID; //numpang is paket
        asgService.Floats[colHBeli,   rowService+1]:= Sales.SalesDetail_Arr[i].HrgBeli; //numpang is paket
        asgService.Ints[colAnimalId,  rowService+1]:= Sales.SalesDetail_Arr[i].AnimalID;//titipan utk animalId
        asgService.Ints[colServiceType,  rowService+1]:= Sales.SalesDetail_Arr[i].ServiceType;
        asgService.Cells[colIsFree,rowService+1] := IfThen(Sales.SalesDetail_Arr[i].IsFree=1,'Ya','Tidak');
        Calculate(rowService+1,True);
        asgService.Row := rowService+1;
        checkQtyServiceKumulatif();
//        addFreeList(Sales.SalesDetail_Arr[i].MstItem.ItemID,Sales.SalesDetail_Arr[i].AnimalID,);
        Inc(rowService);
        asgService.AddRow;
    end;
  end;
  DeleteRowTerakhir(asgSales, 2, 1);
   DeleteRowTerakhir(asgService, 2, 1);


{  if (Sales.SalesMst.AnimalSeq > 0) then begin
    cmbAnimal.ItemIndex := lsAnimal.IndexOfName(IntToStr(Sales.SalesMst.AnimalSeq));
    cmbAnimalChange(nil);
  end;
  }
 // txtDokter.Tag:= Sales.SalesMst.DokterID;
//  txtDokter.Text:= TMstDokter.GetName(Sales.SalesMst.DokterID);


  if not Result then Exit;
  //hasil : customer-A #3 dari customerA001
  cust:= copy(Sales.SalesMst.TransNum, 1, 8);
    lblCustomer.Caption:= cust;

  cust:= copy(Sales.SalesMst.TransNum,
    9, length(Sales.SalesMst.TransNum) - 11);

  lblCustomer.Caption:= lblCustomer.Caption + '-' +cust+ ' #';

  cust:= copy(Sales.SalesMst.TransNum, length(Sales.SalesMst.TransNum)-2, 3);

  lblCustomer.Caption:= lblCustomer.Caption + IntToStr(StrToIntDef(cust, 1));

  {lblPasien.Caption:= 'PASIEN : '+TMstRelation.GetName(lblPasien.Tag);
  lblDokter.Tag:= Sales.SalesMst.DokterID;
  lblDokter.Caption:= 'DOKTER : ' + TMstDokter.GetName(Sales.SalesMst.DokterID);}
  asgSalesClickCell(asgSales, 1, 1);
end;

procedure TfrmTrsSales.tbtRecallClick(Sender: TObject);
begin
  RecallHolded
end;

procedure TfrmTrsSales.asgSalesGetAlignment(Sender: TObject; ARow,
  ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  if ACol in[colNo, colQty, colHrgDisplay,colDisc,colDiscRp, colTotaldISPLAY] then HAlign:= taRightJustify;
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

  if OldRow <= (Sender as TAdvStringGrid).RowCount-1 then
  (Sender as TAdvStringGrid).RowHeights[OldRow]:= (Sender as TAdvStringGrid).DefaultRowHeight;
  (Sender as TAdvStringGrid).AutoSizeRow(NewRow);
  if (Sender as TAdvStringGrid).RowHeights[NewRow] < (Sender as TAdvStringGrid).DefaultRowHeight then
    (Sender as TAdvStringGrid).RowHeights[NewRow]:= (Sender as TAdvStringGrid).DefaultRowHeight;
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
var racik: integer;
begin
  if Confirmed('Hapus item entry?') then begin
     if (lblGridActive.tag=0) then begin
       asgSales.ClearRows(asgSales.Row, 1);
       if asgSales.RowCount > 2 then
          asgSales.RemoveRows(asgSales.Row, 1);
       Calculate(asgSales.Row);
     end
     else if (lblGridActive.tag=1) then begin
        asgService.ClearRows(asgService.Row, 1);
       if asgService.RowCount > 2 then
          asgService.RemoveRows(asgService.Row, 1);
       Calculate(asgService.Row,True);
     end;
     txtEntry.Clear;
  end;
end;

procedure TfrmTrsSales.DecreaseQty;
begin
  txtEntry.ReadOnly:= true;
  if (lblGridActive.tag=0) then begin
    asgSales.Cells[colQty, asgSales.Row]:= IfThen((asgSales.Floats[colQty, asgSales.Row] - 1)<0,asgSales.Cells[colQty, asgSales.Row] ,FloatToStrFmt(asgSales.Floats[colQty, asgSales.Row] - 1));
    //ResettingHarga(asgSales.Row);
    //ApplliedProdukItem(asgSales.Row);
    Calculate(asgSales.Row);
   end
  else if (lblGridActive.tag=1) then begin
    asgService.Cells[colQty, asgService.Row]:= IfThen((asgService.Floats[colQty, asgService.Row] - 1)<0,asgService.Cells[colQty, asgService.Row], FloatToStrFmt(asgService.Floats[colQty, asgService.Row] - 1));
    //ResettingHarga(asgSales.Row);
    //ApplliedProdukItem(asgSales.Row);
    checkQtyServiceKumulatif();
    Calculate(asgService.Row,True);
  end;
  exit;
end;

procedure TfrmTrsSales.IncreaseQty;
begin
  txtEntry.ReadOnly:= true;
//  alert(ActiveControl.Name);
  if (lblGridActive.tag=0) then begin
    asgSales.Cells[colQty, asgSales.Row]:= FloatToStrFmt(asgSales.Floats[colQty, asgSales.Row] + 1);
    //ApplliedProdukItem(asgSales.Row);
    Calculate(asgSales.Row);
  end
  else if (lblGridActive.tag=1) then begin
      asgService.Cells[colQty, asgService.Row]:= FloatToStrFmt(asgService.Floats[colQty, asgService.Row] + 1);
    //ApplliedProdukItem(asgSales.Row);
    checkQtyServiceKumulatif();
    Calculate(asgService.Row,True);
  end;

  exit;
end;

procedure TfrmTrsSales.RowMoveDown(var Key: Word; Shift: TShiftState);
begin
  if lblGridActive.Tag = 1 then begin
    if asgService.Row < asgService.RowCount-1 then
       asgService.Row:= asgService.Row+1;
    asgService.SetFocus;
    asgSalesKeyDown(asgService, Key, Shift);
  end
  else begin
    if asgSales.Row < asgSales.RowCount-1 then
       asgSales.Row:= asgSales.Row+1;
    asgSales.SetFocus;
    asgSalesKeyDown(asgSales, Key, Shift);
  end;
end;

procedure TfrmTrsSales.RowMoveUp(var Key: Word; Shift: TShiftState);
begin
  if lblGridActive.Tag = 1 then begin
    asgService.Row:= asgService.Row-1;
    asgService.SetFocus;
    asgSalesKeyDown(asgService, Key, Shift);
  end
  else begin
    asgSales.Row:= asgSales.Row-1;
    asgSales.SetFocus;
    asgSalesKeyDown(asgSales, Key, Shift);
  end;
end;

procedure TfrmTrsSales.SeekItem;
var id, isPaket,animalId: integer;
barcode: string; AQty: double;
begin
  barcode:= txtEntry.Text;
  AQty:= 1;
  if Pos('*', txtEntry.Text) <> 0 then begin
    barcode:= EkstrakString(txtEntry.Text,'*',2);
    AQty   := StrToFloatDef(EkstrakString(txtEntry.Text,'*',1),1);
  end;

  isPaket:= -1; //
  //id:= frmLovFlat.Execute(isPaket,an, barcode, 'BARANG',lblJenisHewan.Tag);
  id:= frmLovFlat.Execute2(isPaket,animalId, barcode, 'BARANG',getListAnimalCust );//lblJenisHewan.Tag);
  lblJenisHewan.Tag := animalId;
  //udah tau paket/bukan: paket=1; bukan=0
  if Id > 0 then getItem('', id, isPaket, AQty,animalId,False,IntToStr(animalId))
end;

procedure TfrmTrsSales.EndTransaction;
var input: Double;
begin
  input:= StrFmtToFloatDef(lblGrangTotal.Caption,0, true);
  if isValid then
    if frmInputBoxTotal.Execute(input, txtPasien.Tag) then InitForm;
end;

procedure TfrmTrsSales.DiscountPercent;
var input: Double;
begin
{  if asgSales.Floats[colDiscRp, asgSales.Row] <> 0 then begin
     Inform('Item sudah didiscount.');
     Exit;
  end;

  input:= asgSales.Floats[colDiscRp, asgSales.Row];
  if frmInputBox1.Execute(input, 'Discount Persen', false) then begin
     asgSales.Cells[colDisc, asgSales.Row]:= FloatToStrFmt(input);
     Calculate(asgSales.Row);
  end;}
end;

procedure TfrmTrsSales.DiscountRupiah;
var input,discMax,harga: Double;
begin
//  if asgSales.Floats[colDisc, asgSales.Row] <> 0 then begin
  //   Inform('Item sudah didiscount.');
 //    Exit;
//  end;
  if (lblGridActive.tag=0) then begin
    input:= asgSales.Floats[colDiscRp, asgSales.Row];
    if frmInputBox1.Execute(input, 'Disc.Item(Rp)', false) then begin
       discMax := asgSales.Floats[colDisc, asgSales.Row];
       harga := asgSales.Floats[colHarga, asgSales.Row];
       discMax := harga * discMax / 100;
       if (input>discMax) then begin
          Alert('Discount yang diberikan melebihi ketentuan manajemen');
          exit;
       end;
       if Confirmed('Kalikan dengan item') then
          input := input * asgSales.Ints[colQty, asgSales.Row];
       asgSales.Cells[colDiscRp, asgSales.Row]:= FloatToStrFmt(input);
       Calculate(asgSales.Row);
    end;
  end
  else if (lblGridActive.tag=1) then begin
    input:= asgService.Floats[colDiscRp, asgService.Row];
    if frmInputBox1.Execute(input,'Disc.Jasa(Rp)', false) then begin
       discMax := asgService.Floats[colDisc, asgService.Row];
       harga := asgService.Floats[colHarga, asgService.Row];
       discMax := harga * discMax / 100;
       if (input>discMax) then begin
          Alert('Discount Jasa yang diberikan melebihi ketentuan manajemen');
          exit;
       end;
       if Confirmed('Kalikan dengan item') then
          input := input * asgService.Ints[colQty, asgService.Row];
       asgService.Cells[colDiscRp, asgService.Row]:= FloatToStrFmt(input);
       Calculate(asgService.Row,True);
    end;
  end;
end;

procedure TfrmTrsSales.tbtOpenClick(Sender: TObject);
begin
  {try
    if (GlobalSystemConfig.localSetting.DrawerCode <> '') then begin
      RAWPrinter1.PrinterName:= GlobalSystemConfig.localSetting.PrinterStruk;
      RAWPrinter1.DocumentTitle:= '';
      RAWPrinter1.BeginDoc;
      RAWPrinter1.WriteStr(GlobalSystemConfig.localSetting.DrawerCode);
      RAWPrinter1.EndDoc;
    end
    else if (GlobalSystemConfig.localSetting.JenisDrawer = 1) then
      openDirectDrawer(GlobalSystemConfig.localSetting.PortName);

  except raise;
  end;}
  pettyCash;
end;

procedure TfrmTrsSales.RePrintLastTrans;
var iD: integer;
begin
  ID:= getIntegerFromSQL(
  'select max(sales_id) from trs_sales_mst where cashier_id = '+formatsqlnumber(lblCasierUser.Tag));
  PrintResep(iD);
end;

procedure TfrmTrsSales.showInfo;
begin
  Inform(
   'F1  : Tampilkan batuan'#13#10+
   'F2  : Cari item berdasarkan nama'#13#10+
   'F3  : Total transaksi'#13#10+
   'F4  : Uang Muka'#13#10+
   'F5  : Discount (Rp) item dengan rupiah'#13#10+
 //  'F5  : Discount (%) item dengan persentasi'#13#10+
   'F6  : Total Discount (Rp) item dengan rupiah'#13#10+
 //  'F7  : Total Discount (%) item dengan persentasi'#13#10+

   'F7  : Cek Harga'#13#10+
//   'F9  : Reprint'#13#10+

   //'F10 : Ganti satuan beli'#13#10+
   'F8 : Batalkan transaksi'#13#10+
   'F9 : Retur '#13#10+

   'F10 : Quantity'#13#10+
   'DEL : Hapus 1 Item'#13#10+
   ' + : Tambah 1 Item'#13#10+
   '  -  : Kurangi 1 Item'#13#10+
   'Panah Atas   : Pindah satu baris ke atas'#13#10+
   'Panah Bawah: Pindah satu baris ke bawah'#13#10
//   'Alt + A: Input Pasien'#13#10+
   //'Alt + H: Hold'#13#10+
   //'Alt + C: Call Hold'#13#10+
  // 'Alt + A: Input Saldo Awal'#13#10+
//   'Alt + P: Input Resep'#13#10
  // 'Alt + S: Input Racikan'#13#10+
 //  'Alt + M: Jasa Medis'#13#10   
 //  'Alt + E: Input Embalase'#13#10+
);
end;

procedure TfrmTrsSales.ToolButton13Click(Sender: TObject);
begin
//  showInfo;
  HHDisplayTOC
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
      asgSales.Floats[colHRata,asgSales.Row]:= BufferToFloat(buffer.FieldValue(4));
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
  if key = #13 then key := #0
  else if key = #46 then key := #44;
end;

procedure TfrmTrsSales.asgSalesClickCell(Sender: TObject; ARow,
  ACol: Integer);
begin
  if ARow = 0 then exit;

  txtEntry.Text:= (Sender as TAdvStringGrid).Cells[colBarcode, ARow];
  txtEntry.Tag:= (Sender as TAdvStringGrid).Ints[colItemId, ARow];
  txtEntry.SetFocus;
  txtEntry.SelectAll;
end;

procedure TfrmTrsSales.ChangeHarga;
var ID: integer; newPrice: TMysqlResult;
begin

  if txtEntry.Tag = 0 then Exit;

  ID:= frmInputBoxPilihHarga.Execute(txtEntry.Tag);
  if ID <> 0 then begin

    newPrice:= OpenSQL(
    'select distinct t.conversion, t.sales_price, m.mst_name, i.avg_price, t.purchase_price '+
    'from mst_item_conversion t, mst_master m, mst_item i '+
    'where t.item_id = i.item_id and t.unit_id = m.mst_id and t.conv_id = '+IntToStr(ID));

    if newPrice.RecordCount > 0 then begin
     // asgSales.Ints[colConvId,      asgSales.Row]:= ID;
      asgSales.Cells[colUnit,       asgSales.Row]:= newPrice.FieldValue(2);
      asgSales.Cells[colHarga,      asgSales.Row]:= FloatToStrFmt(BufferToFloat(newPrice.FieldValue(1)));
      asgSales.Cells[colHrgDisplay, asgSales.Row]:= FloatToStrFmt(BufferToFloat(newPrice.FieldValue(1)));
//      asgSales.Cells[colConv,       asgSales.Row]:= FloatToStrFmt(BufferToFloat(newPrice.FieldValue(0)));
      asgSales.Floats[colHRata,     asgSales.Row]:= BufferToFloat(newPrice.FieldValue(3));
      asgSales.Floats[colHBeli,     asgSales.Row]:= BufferToFloat(newPrice.FieldValue(4));

      Calculate(asgSales.Row);
    end;
  end;
end;

procedure TfrmTrsSales.lblCasierUserClick(Sender: TObject);
begin
  frmChangePassword.Execute(GlobalSystemUser.UserId);
end;

procedure TfrmTrsSales.HoldedTrx;
begin
  if TransType = SALES_TYPE_RETUR then begin
      Alert('Transaksi Retur tidak bisa di HOLD');
      exit;
  end;
  if isValid then SaveHolded;
end;

procedure TfrmTrsSales.RecallHolded;
var id: integer;
begin
  id:= frmTrsSalesHoldedList.Execute;
  if id <> 0 then LoadHolded(id)
end;

procedure TfrmTrsSales.InsertSaldo;
begin
  frmInputBoxSaldoAwal.Execute;
end;

procedure TfrmTrsSales.LookDokter;
var ID: integer;
begin
  ID:= frmLookup.Execute('DOKTER');
  if ID <> 0 then getDokter(ID, '')
end;

procedure TfrmTrsSales.LookPasien;
var ID: integer;
begin
  ID:= frmLookup.Execute('CUST');
  if ID <> 0 then begin
    if (Sales.isRealExistHoldedCustomer(ID)) then begin
        Alert('Customer ini sedang dalam antrian transaksi (Holded)!');
        exit;
    end;
    InitForm;
    getPasien(ID, '')
  end;
end;

procedure TfrmTrsSales.NewDokter;
var ID: integer;
begin
  ID:= txtDokter.Tag;
  if frmMstDokter.ExecuteNew(ID) then getDokter(ID, '')
end;

procedure TfrmTrsSales.NewPasien;
var ID: integer;
begin
  ID:= txtPasien.Tag;
  if frmMstRelationAnimal.ExecuteNew(ID) then getPasien(ID, '')
end;

procedure TfrmTrsSales.txtPasienKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    VK_F2: LookPasien;
    VK_F3: begin NewPasien;
              getAnimal(txtPasien.Tag);
          end;
    vk_F11 : NewPasien;
    VK_TAB:
    begin
      if txtPasien.Modified then
        if not getPasien(0, txtPasien.Text) then LookPasien;

    end;
  end;
end;

function TfrmTrsSales.getPasien(ID: integer; Kode: string;forHolded:boolean=false;animalSeqsHold:string=''): boolean;
var buffer: TMstRelation;
begin
  buffer:= TMstRelation.Create();
  buffer.RelationID:= ID;
  buffer.RelationCode:= Kode;
  lblPasien.Caption:= '';
  lblDiscCust.Caption := '0';
  lblFreeInfo.Caption := '';
  lblFreeInfo.Visible := False;
  chkWajib.Checked := False;
  if not forHolded then begin
    txtPasien.Clear;
    txtPasien.Tag:= 0;

  end;

  Result:= buffer.SelectInDB;
  if Result then begin
     Result:= Sales.isExistHoldedCustomer(buffer.RelationID);
     if (Result) and (not forHolded) then begin
        Result := False;
        Alert('Transaksi utk customer ini sudah ada pada antrian (holded).');
       { If Confirmed('Transaksi utk customer ini sudah ada pada antrian (holded).'+#13+
          ' Apakah akan input data hewan baru untuk customer ini ?') then begin
           txtPasien.Tag := buffer.RelationID;
           NewPasien;
       end
        else}
          txtPasien.SetFocus;
     end
     else begin

        txtPasien.Text:= buffer.RelationCode;
        txtPasien.Tag:= buffer.RelationID;
        lblPasien.Caption:= buffer.RelationName + #31#10 + buffer.Address1;
        lblDiscCust.Caption := FloatToStrFmt(buffer.Discount);
        chkWajib.Checked := buffer.WajibDiscount=1;
        LoadDataService(buffer.RelationID);

         // getAnimal(buffer.RelationID);

          getAnimal(buffer.RelationID,forHolded);
          setAnimals(animalSeqsHold);
          showFreeInfo;
          //cmbAnimal.SetFocus;
          chkAnimal.SetFocus;

     end;
  end;
 // else Alert(MSG_NO_DATA_FOUND);
  buffer.Destroy;
end;

function TfrmTrsSales.getDokter(ID: integer; Kode: string): boolean;
var buffer: TMstDokter;
begin
  buffer:= TMstDokter.Create();
  buffer.DokterID:= ID;
  buffer.Kode:= Kode;

  txtDokter.Clear;
  txtDokter.Tag:= 0;
  lblDokter.Caption:= '';
  Result:= buffer.SelectInDB;
  if Result then begin
    txtDokter.Text:= buffer.Kode;
    txtDokter.Tag:= buffer.DokterID;
    lblDokter.Caption:= buffer.Nama + #31#10 + buffer.Alamat;
    getItem('', buffer.itemid, 0, 1, -1);
  end;
  buffer.Destroy;
end;

procedure TfrmTrsSales.txtDokterKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    VK_F2: LookDokter;
    VK_F3: NewDokter;
    VK_TAB:
    begin
      if txtDokter.Modified then
        if not getDokter(0, txtDokter.Text) then LookDokter;

    end;
  end;

end;



procedure TfrmTrsSales.DiscountPercentFooter;
var input: Double;
begin
{  input:= StrFmtToFloatDef(lblDisc.Caption,0);
  if frmInputBox1.Execute(input, 'Total Discount Persen', false) then begin
     lblDisc.Caption:= FloatToStrFmt(input);
     Calculate(asgSales.Row);
  end;}
end;

procedure TfrmTrsSales.DiscountRupiahFooter;
var input: Double;
  discMax,grandTotal,disc : double;
begin
  input:= StrFmtToFloatDef(lblDiscountRp.Caption,0);
  grandTotal := StrFmtToFloatDef(lblSubTotal.Caption,0, True);
  disc := StrFmtToFloatDef(lblDiscountRp.Caption,0, True);
  //ambil discount cust dulu
  discMax := TMstRelation.GetDiscount(txtPasien.Tag);

  if discMax = 0 then
    discMax := StrToFloatDef(TSystemConfig.getValue(CONF_DISC_VAL_PROMO),0);

  discMax := grandTotal * discMax / 100;

  if frmInputBox1.Execute(input, 'Total Disc.Faktur (Rp)', false) then begin
      if (input>=0) then begin
          if (input>discMax) then
               Alert('Nilai discount melebihi ketentuan manajemen!')
          else begin
             lblDiscountRp.Caption:= FloatToStrFmt(input);
             Calculate(asgSales.Row);
          end;
     end;
  end;
end;



procedure TfrmTrsSales.Rupiah;
var input: Double;
begin
  input:= asgSales.Floats[colHarga, asgSales.Row];
  if frmInputBox1.Execute(input, 'Ganti Tarif Jasa', false) then begin
     asgSales.Cells[colHarga, asgSales.Row]:= FloatToStrFmt(input);
     asgSales.Cells[colHrgDisplay, asgSales.Row]:= FloatToStrFmt(input);
     Calculate(asgSales.Row);
  end;
end;

procedure TfrmTrsSales.PrintResep(ID: integer);
begin
  if GlobalSystemConfig.localSetting.PrintStruk = 0 then Exit;

  ResepBuffer:= OpenSQL(
  'select (d.quantity) as qty, d.price, d.amount, i.struk_name, '+
  't.trans_num, t.trans_date, t.total, t.cash, (t.cash - t.total) as cash_back, '+
  't.subtotal, t.disc_mst, t.disc_val_mst, t.embalase, d.sales_detail_id, '+
  't.pasien_id, t.dokter_id, 0 as tipe_racikan, 0 as id_paket, t.no_resep, now() '+
  'from trs_sales_mst t, trs_sales_detail d, mst_item i '+
  'where d.sales_id = t.sales_id and d.item_id = i.item_id and d.item_id is not null '+
  'and t.sales_id = '+IntToStr(ID)+
  ' union all '+
  'select (d.quantity ) as qty, d.price, d.amount, i.service_name as struk_name,  '+
  't.trans_num, t.trans_date, t.total, t.cash, '+
  '(t.cash - t.total) as cash_back, t.subtotal, t.disc_mst, t.disc_val_mst, t.embalase, d.sales_detail_id, '+
  't.pasien_id, t.dokter_id, 1 as tipe_racikan, d.paket_id as id_paket, t.no_resep, now() '+
  'from trs_sales_mst t, trs_sales_detail d, mst_service i '+
  'where d.sales_id = t.sales_id and d.paket_id = i.service_id and d.paket_id is not null '+
  'and t.sales_id = '+IntToStr(ID)+
  ' order by sales_detail_id ');

  printOrder(ID);
 // PrintResepDetail(ID, True);
  //if BufferToString(ResepBuffer.FieldValue(18)) <> '' then
  ///
     // PrintResepDetail(ID, False);
  ResepBuffer.destroy;
end;


procedure TfrmTrsSales.PrintResepDetail(ID: integer; untukPasien: boolean);
var i,j,ke: integer; detail: TMysqlResult;
  pasien: TMstRelation;
  nilai_embalase: double;
  count_embalase: double;
  row_racik: boolean;
begin

  //0qty, 1price, 2amount, 3struk_name, '+
  //4trans_num, 5trans_date, 6total, 7cash, 8cash_back, '+
  //9subtotal, 10disc_mst, 11disc_val_mst, 12embalase, 13sales_detail_id, '+
  //14pasien_id, 15dokter_id, 16tipe_racikan, 17paket_id '+

  ke:= 0;
  ResepBuffer.First;
  count_embalase:= TTrsSales.countResepRacik(ID);
  nilai_embalase:= BufferToFloat(ResepBuffer.FieldValue(12));

  if count_embalase <> 0 then nilai_embalase:= nilai_embalase / count_embalase;

  GlobalStringList.Clear;

  GlobalStringList.Append(
    FixWidth(BufferToString(ResepBuffer.FieldValue(4)) , 24, taLeftJustify) +
    FixWidth(FormatDateTime('dd/MM/yyyy', BufferToDateTime(ResepBuffer.FieldValue(5))), 11, taLeftJustify)+
    FixWidth(FormatDateTime('hh:mm', BufferToDateTime(ResepBuffer.FieldValue(19))), 5, taRightJustify));

  pasien:= TMstRelation.Create;
  pasien.RelationID:= BufferToInteger(ResepBuffer.FieldValue(14));
  if pasien.SelectInDB then begin
    GlobalStringList.Append(
      FixWidth('Pasien',7, taLeftJustify)+
      FixWidth(': ',2, taLeftJustify)+
      FixWidth(pasien.RelationName,31, taLeftJustify));

     GlobalStringList.Append(
      FixWidth('Alamat',7, taLeftJustify)+
      FixWidth(': ',2, taLeftJustify)+
      FixWidth(pasien.Address1,31, taLeftJustify));

    GlobalStringList.Append(
      FixWidth('Dokter',7, taLeftJustify)+
      FixWidth(': ',2, taLeftJustify)+
      FixWidth(TMstDokter.GetName(BufferToInteger(ResepBuffer.FieldValue(15))),31, taLeftJustify));
  end;
  pasien.Destroy;

  GlobalStringList.Append(
    FixWidth('Operator: '+GlobalSystemUser.UserId, 40, taLeftJustify));
  GlobalStringList.Append(FixWidth('-----------------------------------------',40, taLeftJustify));

  for i := 0 to ResepBuffer.RecordCount-1 do begin
    row_racik:= BufferToInteger(ResepBuffer.FieldValue(16)) = 1;
    with GlobalStringList do begin

      if row_racik then Inc(ke);

      Append(
        FixWidth(BufferToString(ResepBuffer.FieldValue(3)) + IfThen(row_racik, IntToStr(ke)), 15, taLeftJustify)+

      IfThen(
        (not row_racik) or (untukPasien), //kalo bukan racikan dan untuk pasien

        FixWidth(FormatFloat('#,##0.##', BufferToFloat(ResepBuffer.FieldValue(0))), 10, taRightJustify)+
        FixWidth(FormatFloat('#,##0.##',
          BufferToFloat(ResepBuffer.FieldValue(2)) + IfThen(row_racik, nilai_embalase)), 15, taRightJustify)));

       if (row_racik) and (not untukPasien) then begin
         detail:= OpenSQL(
         'select d.quantity, (d.quantity * d.price), concat(''- '',i.item_name) '+
         'from trs_sales_paket d, mst_item i '+
         'where d.item_id = i.item_id '+
         'and d.sales_id = '+IntToStr(ID)+
         ' and d.paket_id = '+IntToStr(BufferToInteger(ResepBuffer.FieldValue(17))));

         for j:= 0 to detail.RecordCount-1 do begin
            Append(
             FixWidth(BufferToString(detail.FieldValue(2)), 15, taLeftJustify)+
             FixWidth(
                FormatFloat('#,##0.##', BufferToFloat(detail.FieldValue(0))), 10, taRightJustify)+
             FixWidth(
                FormatFloat('#,##0.##', BufferToFloat(detail.FieldValue(1)) + IfThen(j=detail.RecordCount-1,nilai_embalase)),
                15, taRightJustify));
           detail.MoveNext;
         end;
         detail.destroy;
       end;

    end;
    ResepBuffer.MoveNext;
  end;

  //0qty, 1price, 2amount, 3struk_name, '+
  //4trans_num, 5trans_date, 6total, 7cash, 8cash_back, '+
  //9subtotal, 10disc_mst, 11disc_val_mst, 12embalase, 13sales_detail_id, '+
  //14pasien_id, 15dokter_id, 16tipe_racikan '+

  GlobalStringList.Append(FixWidth('---------------',15, taRightJustify));
  GlobalStringList.Append(
    FixWidth('TOTAL' ,15, taLeftJustify)+
    FixWidth(FormatFloat('#,##0.##', BufferToFloat(ResepBuffer.FieldValue(9)) + BufferToFloat(ResepBuffer.FieldValue(12))), 25, taRightJustify));

  if BufferToFloat(ResepBuffer.FieldValue(11)) <> 0 then
  GlobalStringList.Append(
    FixWidth('DISC (Rp)' ,15, taLeftJustify)+
    FixWidth(FormatFloat('#,##0.##', BufferToFloat(ResepBuffer.FieldValue(11))), 25, taRightJustify));

  if BufferToFloat(ResepBuffer.FieldValue(10)) <> 0 then
  GlobalStringList.Append(
    FixWidth('DISC (%)' ,15, taLeftJustify)+
    FixWidth(FormatFloat('#,##0.##', BufferToFloat(ResepBuffer.FieldValue(10))), 25, taRightJustify));
  if (BufferToFloat(ResepBuffer.FieldValue(10)) <> 0) or (BufferToFloat(ResepBuffer.FieldValue(11)) <> 0) then begin
    GlobalStringList.Append(FixWidth('---------------',15, taRightJustify));
    GlobalStringList.Append(
      FixWidth('JUMLAH' ,15, taLeftJustify)+
      FixWidth(FormatFloat('#,##0.##', BufferToFloat(ResepBuffer.FieldValue(6))), 25, taRightJustify));
  end;

  GlobalStringList.Append(
    FixWidth('BAYAR' ,15, taLeftJustify)+
    FixWidth(FormatFloat('#,##0.##', BufferToFloat(ResepBuffer.FieldValue(7))), 25, taRightJustify));
  GlobalStringList.Append(FixWidth('---------------',15, taRightJustify));
  
  if BufferToFloat(ResepBuffer.FieldValue(8)) <> 0 then
  GlobalStringList.Append(
    FixWidth('KEMBALIAN' ,15, taLeftJustify)+
    FixWidth(FormatFloat('#,##0.##', BufferToFloat(ResepBuffer.FieldValue(8))), 25, taRightJustify));

  GlobalStringList.Append('');

  if GlobalSystemConfig[CONF_FOOTER1-1].ConfValue <> '' then
    GlobalStringList.Append(FixWidth(GlobalSystemConfig[CONF_FOOTER1-1].ConfValue, 40, taCenter));
  if GlobalSystemConfig[CONF_FOOTER2-1].ConfValue <> '' then
    GlobalStringList.Append(FixWidth(GlobalSystemConfig[CONF_FOOTER2-1].ConfValue, 40, taCenter));

  if BufferToString(ResepBuffer.FieldValue(18)) <> '' then   begin
    GlobalStringList.Append(FixWidth('-----------------------------------------',40, taLeftJustify));
    GlobalStringList.Append(
      FixWidth('|',1, taLeftJustify)+
      FixWidth('HARGA', 12, taCenter)+
      FixWidth('|',2, taRightJustify)+
      FixWidth('KEMAS', 12, taCenter)+
      FixWidth('|',2, taRightJustify)+
      FixWidth('SERAH', 12, taCenter)+
      FixWidth('|',2, taRightJustify));
    GlobalStringList.Append(FixWidth('-----------------------------------------',40, taLeftJustify));
    GlobalStringList.Append(
      FixWidth('|',13, taLeftJustify)+
      FixWidth('|',13, taLeftJustify)+
      FixWidth('|',13, taLeftJustify)+
      FixWidth('|',1, taRightJustify));
    GlobalStringList.Append(FixWidth('-----------------------------------------',40, taLeftJustify));
    GlobalStringList.Append(
      FixWidth('|',1, taLeftJustify)+
      FixWidth('ETIKET LKP', 12, taCenter)+
      FixWidth('|',1, taLeftJustify)+
      FixWidth('BARANG LKP', 12, taCenter)+
      FixWidth('|',1, taLeftJustify)+
      FixWidth('TANDA TERIMA', 12, taCenter)+
      FixWidth('|',1, taRightJustify));
    GlobalStringList.Append(FixWidth('-----------------------------------------',40, taLeftJustify));
    GlobalStringList.Append(
      FixWidth('|',13, taLeftJustify)+
      FixWidth('|',13, taLeftJustify)+
      FixWidth('|',13, taLeftJustify)+
      FixWidth('|',1, taRightJustify));
    GlobalStringList.Append(FixWidth('-----------------------------------------',40, taLeftJustify));
    GlobalStringList.Append(' ');
  end;
       
  try
  //printing struk...
   // x:= GlobalSystemConfig.localSetting.MarginBottom;
   // for i:= 1 to x do GlobalStringList.Append(' ');
    GlobalStringList.Append('');
    GlobalStringList.Append('');
    GlobalStringList.Append('');
    GlobalStringList.Append('');
    GlobalStringList.Append('');

    //GlobalStringList.Append(FixWidth(CompanyProfile.FCompanyName, 40, taCenter));
    GlobalStringList.Append(FixWidth(CompanyProfile.FAddress, 40, taCenter));
    GlobalStringList.Append(FixWidth(CompanyProfile.FTelp1, 40, taCenter));
    GlobalStringList.Append(FixWidth(CompanyProfile.FCity, 40, taCenter));
    If CompanyProfile.FNpwp <> '' then
      GlobalStringList.Append(FixWidth('NPWP : ' + CompanyProfile.FNpwp, 40, taCenter));
    GlobalStringList.Append(' ');

    if (GlobalSystemConfig.localSetting.CutterCode <> '') and (GlobalSystemConfig.localSetting.AutoCutter = 1) then
      GlobalStringList.Append(GlobalSystemConfig.localSetting.CutterCode);

    RAWPrinter1.DocumentTitle:= 'Struk';
    RAWPrinter1.BeginDoc;
    RAWPrinter1.Write(GlobalStringList.Text);

    RAWPrinter1.EndDoc;
    except raise;
      Inform('Printer tidak terpasang.');
  end;

end;

procedure TfrmTrsSales.InsertService(trxID, paketID: integer);
var row: integer; var racikan: TMysqlResult;
begin
  //if frmMstRacikan.Execute(trxID, paketID) then begin

    MstItem.Reset;
    MstItem.ItemId := paketID;
    MstItem.Konsinyasi := 1;
    if MstItem.SelectPOS then begin

      racikan:= OpenSQL(
      'select r.qty, r.harga, r.embalase, r.harga_beli, harga_rata, '+
      '(select r.paket_id from mst_paket where paket_id = r.paket_id) '+
      'from setup_racik r where racik_id = '+FormatSQLNumber(trxID));
      if racikan.RecordCount > 0 then begin

        if asgSales.Ints[colItemID, asgSales.RowCount-1] <> 0 then
           asgSales.AddRow;

        row:= asgSales.RowCount-1;
        asgSales.Cells[colDesc,      row]:= '';//'Racikan '+IntToStr(getEm+1);

        asgSales.Cells[colBarcode,   row]:= MstItem.Barcode;
        asgSales.Ints[colItemId,     row]:= MstItem.ItemId;
        asgSales.Ints[colIsPaket,    row]:= MstItem.Konsinyasi;
        asgSales.Cells[colUnit,      row]:= MstItem.FItemConversion[0].MstMaster.MstCode;
        asgSales.Cells[colHarga,     row]:= FloatToStrFmt(BufferToFloat(racikan.FieldValue(1)));
        asgSales.Cells[colQty,       row]:= FloatToStrFmt(1);
        asgSales.Cells[colHrgDisplay,row]:= FloatToStrFmt(BufferToFloat(racikan.FieldValue(1)) + BufferToFloat(racikan.FieldValue(2)));
        asgSales.Floats[colHBeli,    row]:= BufferToFloat(racikan.FieldValue(3));
        asgSales.Floats[colHRata,    row]:= BufferToFloat(racikan.FieldValue(4));

        asgSales.Row:= row;
        txtEntry.Tag:= MstItem.ItemId;
        Calculate(row);
      end;
    end;

    if MstItem.ItemID <> 0 then txtEntry.Text:= MstItem.Barcode;
    txtEntry.SelectAll;

//  end;

end;

procedure TfrmTrsSales.getAnimal(ID: integer;checkHolded:boolean=true);
begin

   TMstRelation.getListAnimal2(ID,lsAnimalAll,false);
   NameValueListToValueList(lsAnimalAll,chkAnimal.Items);
end;

procedure TfrmTrsSales.txtDiscountKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
 IgnoreChar(Key)
end;

procedure TfrmTrsSales.returTrans;
var num,cust:string;ret : TMysqlResult;
  rowSales,rowService,i:integer;

begin
  //Alert(MSG_UNDER_CONSTRUCTION); exit;
   
   num:= InputBox('Retur', 'NO Transaksi : ', '');
  if num <> '' then begin

      InitForm;
      TransType := SALES_TYPE_RETUR;
      Sales.SalesMst.TransNum := num;
      Sales.SelectInDB;
      if (Sales.SalesMst.TransType = SALES_TYPE_RETUR) then begin
          Alert('Transaksi Retur Sales tidak bisa diretur lagi');
      end;
      lblCustomer.Tag:= Sales.SalesMst.SalesId;
      txtPasien.Tag:= Sales.SalesMst.PasienID;
  txtPasien.Text:= TMstRelation.GetName(Sales.SalesMst.PasienID);
  txtPasien.Enabled :=  False;

  getPasien(Sales.SalesMst.PasienID,'',True,Sales.SalesMst.AnimalSeq);
  
      rowSales:= 0;rowService := 0;
      for i:= 0 to Sales.SalesDetail_Arr.Count-1 do begin
        if (Sales.SalesDetail_Arr[i].PaketID = 0) then begin
          asgSales.Ints[colNo, rowSales+1]:= rowSales+1;
          asgSales.Cells[colBarcode,  rowSales+1]:= Sales.SalesDetail_Arr[i].MstItem.Barcode;
          asgSales.Cells[colDesc,     rowSales+1]:= Sales.SalesDetail_Arr[i].MstItem.ItemName;
          asgSales.Cells[colUnit,     rowSales+1]:= Sales.SalesDetail_Arr[i].MstItemConversion.MstMaster.MstCode;
          asgSales.Cells[colQty,      rowSales+1]:= FloatToStrFmt(Sales.SalesDetail_Arr[i].Quantity);
          asgSales.Cells[colHarga,    rowSales+1]:= FloatToStrFmt(Sales.SalesDetail_Arr[i].Price);
          asgSales.Cells[colHrgDisplay,rowSales+1]:= FloatToStrFmt(Sales.SalesDetail_Arr[i].Price);// + Sales.SalesDetail_Arr[i].ConvBonus);
//          asgSales.Cells[colBTambahan,     rowSales+1]:= FloatToStrFmt(Sales.SalesDetail_Arr[i].Disc);
          asgSales.Cells[colDisc,     i+1]:= FloatToStrFmt(Sales.SalesDetail_Arr[i].Disc);
          asgSales.Cells[colDiscRp,   i+1]:= FloatToStrFmt(Sales.SalesDetail_Arr[i].DiscVal);
          asgSales.Cells[colTotal,    rowSales+1]:= FloatToStrFmt(Sales.SalesDetail_Arr[i].Amount);
          asgSales.Cells[colTotaldISPLAY,    rowSales+1]:= FloatToStrFmt(Sales.SalesDetail_Arr[i].Amount + Sales.SalesDetail_Arr[i].ConvBonus);
      //    asgSales.Floats[colConv,    i+1]:= Sales.SalesDetail_Arr[i].Conversion;
          asgSales.Floats[colHRata, rowSales+1]:= Sales.SalesDetail_Arr[i].PricePurchase;
          asgSales.Floats[colProfit,  rowSales+1]:= Sales.SalesDetail_Arr[i].AmountProfit;
        //  asgSales.Ints[colConvID,    i+1]:= Sales.SalesDetail_Arr[i].MstItemConversion.ConvId;
          asgSales.Ints[colItemID,    rowSales+1]:= Sales.SalesDetail_Arr[i].MstItem.ItemId;
          asgSales.Ints[colIsPaket,   rowSales+1]:= Sales.SalesDetail_Arr[i].PaketID; //numpang is paket
//          asgSales.Ints[colPoint,     rowSales+1]:= Sales.SalesDetail_Arr[i].Points; //numpang is paket
          asgSales.Floats[colHBeli,   rowSales+1]:= Sales.SalesDetail_Arr[i].HrgBeli; //numpang is paket
          //asgSales.Floats[colEmbalase,i+1]:= Sales.SalesDetail_Arr[i].ConvBonus; //numpang is paket
          //asgSales.Floats[colTrxRacikID,i+1]:= Sales.SalesDetail_Arr[i].SalesID; //numpang is paket
          Calculate(rowSales+1);
          Inc(rowSales);
          asgSales.AddRow;
        end
        else begin ///tipe jasa
            asgService.Ints[colNo, rowService+1]:= rowService+1;
            asgService.Cells[colBarcode,  rowService+1]:= Sales.SalesDetail_Arr[i].MstItem.Barcode;
            asgService.Cells[colDesc,     rowService+1]:= Sales.SalesDetail_Arr[i].MstItem.ItemName;
            asgService.Cells[colUnit,     rowService+1]:= Sales.SalesDetail_Arr[i].MstItemConversion.MstMaster.MstCode;
            asgService.Cells[colQty,      rowService+1]:= FloatToStrFmt(Sales.SalesDetail_Arr[i].Quantity);
            asgService.Cells[colHarga,    rowService+1]:= FloatToStrFmt(Sales.SalesDetail_Arr[i].Price);
            asgService.Cells[colHrgDisplay,rowService+1]:= FloatToStrFmt(Sales.SalesDetail_Arr[i].Price + Sales.SalesDetail_Arr[i].ConvBonus);
            //asgService.Cells[colBTambahan,     rowService+1]:= FloatToStrFmt(Sales.SalesDetail_Arr[i].Disc);
            asgSales.Cells[colDisc,     i+1]:= FloatToStrFmt(Sales.SalesDetail_Arr[i].Disc);
            asgSales.Cells[colDiscRp,   i+1]:= FloatToStrFmt(Sales.SalesDetail_Arr[i].DiscVal);
            asgService.Cells[colTotal,    rowService+1]:= FloatToStrFmt(Sales.SalesDetail_Arr[i].Amount);
            asgService.Cells[colTotaldISPLAY,    rowService+1]:= FloatToStrFmt(Sales.SalesDetail_Arr[i].Amount + Sales.SalesDetail_Arr[i].ConvBonus);
        //    asgSales.Floats[colConv,    i+1]:= Sales.SalesDetail_Arr[i].Conversion;
            asgService.Floats[colHRata, rowService+1]:= Sales.SalesDetail_Arr[i].PricePurchase;
            asgService.Floats[colProfit,  rowService+1]:= Sales.SalesDetail_Arr[i].AmountProfit;
          //  asgSales.Ints[colConvID,    i+1]:= Sales.SalesDetail_Arr[i].MstItemConversion.ConvId;
            asgService.Ints[colItemID,    rowService+1]:= Sales.SalesDetail_Arr[i].MstItem.ItemId;
            asgService.Ints[colIsPaket,   rowService+1]:= Sales.SalesDetail_Arr[i].PaketID; //numpang is paket
//            asgService.Ints[colPoint,     rowService+1]:= Sales.SalesDetail_Arr[i].Points; //numpang is paket
            asgService.Floats[colHBeli,   rowService+1]:= Sales.SalesDetail_Arr[i].HrgBeli; //numpang is paket
            //asgSales.Floats[colEmbalase,i+1]:= Sales.SalesDetail_Arr[i].ConvBonus; //numpang is paket
            //asgSales.Floats[colTrxRacikID,i+1]:= Sales.SalesDetail_Arr[i].SalesID; //numpang is paket

            Calculate(rowService+1,True);
            Inc(rowService);
            asgService.AddRow;
        end;
      end;
      DeleteRowTerakhir(asgSales, 2, 1);
       DeleteRowTerakhir(asgService, 2, 1);

   {   txtPasien.Tag:= Sales.SalesMst.PasienID;
      txtPasien.Text:= TMstRelation.GetName(Sales.SalesMst.PasienID);
      getAnimal(Sales.SalesMst.PasienID);
      setAnimals(Sales.SalesMst.AnimalSeq);}
//      if (Sales.SalesMst.AnimalSeq > 0) then
  //      cmbAnimal.ItemIndex := lsAnimal.IndexOfName(IntToStr(Sales.SalesMst.AnimalSeq));
    //  cmbAnimalChange(nil);
     // txtDokter.Tag:= Sales.SalesMst.DokterID;
    //  txtDokter.Text:= TMstDokter.GetName(Sales.SalesMst.DokterID);


    //  if not Result then Exit;
      //hasil : customer-A #3 dari customerA001
      cust:= copy(Sales.SalesMst.TransNum, 1, 8);
        lblCustomer.Caption:= cust;

      cust:= copy(Sales.SalesMst.TransNum,
        9, length(Sales.SalesMst.TransNum) - 11);

      lblCustomer.Caption:= lblCustomer.Caption + '-' +cust+ ' #';

      cust:= copy(Sales.SalesMst.TransNum, length(Sales.SalesMst.TransNum)-2, 3);

      lblCustomer.Caption:= lblCustomer.Caption + IntToStr(StrToIntDef(cust, 1));

      {lblPasien.Caption:= 'PASIEN : '+TMstRelation.GetName(lblPasien.Tag);
      lblDokter.Tag:= Sales.SalesMst.DokterID;
      lblDokter.Caption:= 'DOKTER : ' + TMstDokter.GetName(Sales.SalesMst.DokterID);}
      asgSalesClickCell(asgSales, 1, 1);
  end;
end;

procedure TfrmTrsSales.asgSalesEnter(Sender: TObject);
var n : string;
begin
  inherited;
  n := (Sender as TAdvStringGrid).Name;
  lblGridActive.tag := IfThen(n='asgService',1,0);
  lblGridActive.Color := clWhite;
  lblJasa.Color := clWhite;
  if lblGridActive.Tag=0 then
    lblGridActive.Color := clLime
  else
    lblJasa.Color := clLime

end;

procedure TfrmTrsSales.UangMukaFooter;
var input: Double;
begin
  input:= StrFmtToFloatDef(lblUangMuka.Caption,0);
  if frmInputBox1.Execute(input, 'Uang Muka', false) then begin
     lblUangMuka.Caption:= FloatToStrFmt(input);
     Calculate(asgSales.Row);
  end

end;

procedure TfrmTrsSales.pettyCash;
begin
  frmMoneyTransaction.Execute(0);
end;

function TfrmTrsSales.printFooter(value: TStringList; idx,
  insIdx: integer): integer;
var ket : string;
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

    ket := GlobalSystemConfig[CONF_FOOTER1-1].ConfValue;
    ket := IfThen(ket<>'',ket+', ','')+GlobalSystemConfig[CONF_FOOTER2-1].ConfValue;
    value.Strings[insIdx+2]:= FixWidth(' ', 5, taLeftJustify) +
                FixWidth(ket,PAPER_WIDTH-5, taLeftJustify);

  

end;

function TfrmTrsSales.printHeader(value: TStringList;
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

   {0d.quantity, 1d.price, 2d.amount, 3i.struk_name, '+
  '4t.trans_num, 5t.trans_date, 6t.total, 7t.cash, 8(t.cash - t.total) as cash_back, '+
  '9t.subtotal, 10t.disc_mst, 11t.disc_val_mst, 12d.sales_detail_id, '+
  '13t.pasien_id, 14t.dokter_id, 15tipe_racikan,16 id_paket, 17now()}

  //header;
   printBitmap(imgLogo.Picture.Bitmap,
      Bold('    FAKTUR PENJUALAN & JASA'),RAWPrinter1,value);
 { value.Append(
    FixWidth(' ', 5, taLeftJustify)+
    FixWidth(CompanyProfile.FCompanyName, PAPER_WIDTH-5, taLeftJustify));}

if not onlyColumnHeader then begin
{    value.Append(
      FixWidth(' ', 5, taLeftJustify)+
      FixWidth(Bold('FAKTUR PENJUALAN & JASA'), PAPER_WIDTH , taCenter));
 }
      adaCustomer := BufferToInteger(_buffer.FieldValue(13))>0;
      relation := TMstRelation.Create;
      if adaCustomer then begin

        relation.RelationID :=BufferToInteger(_buffer.FieldValue(13));
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
          FixWidth( 'Kasir ', 10, taLeftJustify) +
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

procedure TfrmTrsSales.printOrder(ID: integer;forHolded:boolean=false);
var i,  summery_count: integer; ls: TStringList;
   buffer: TMysqlResult;

   insertedIdx, rowCount, range,
   halaman, footer_printed: integer;
  cabang : TMysqlResult;

const
  max_row       =38;//;40;//28;
  title_count   = 8;
//  summery_count = 6;
  footer_count  = 2;

begin
  ls:= TStringList.Create;
  if forHolded then
    buffer:=  TTrsSales.PrintHolder(ID)
  else
    buffer := TTrsSales.PrintSales(ID);
    
    cabang:= TMstBranch.loadFromDB;
    summery_count := cabang.RecordCount+7;
  {0d.quantity, 1d.price, 2d.amount, 3i.struk_name, '+
  '4t.trans_num, 5t.trans_date, 6t.total, 7t.cash, 8(t.cash - t.total) as cash_back, '+
  '9t.subtotal, 10t.disc_mst, 11t.disc_val_mst, 12d.sales_detail_id, '+
  '13t.pasien_id, 14t.dokter_id, 15tipe_racikan,16 id_paket, 17now(),18item_code,19d.disc_val,20t.dp,21caraBayar}
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
        FixWidth(BufferToString(buffer.FieldValue(18)), 6, taLeftJustify) + //kode
        FixWidth(BufferToString(buffer.FieldValue(3)), PAPER_WIDTH - 77, taLeftJustify)+ //nama
        FixWidth(
        FormatFloat('#,##0', BufferToFloat(buffer.FieldValue(0))), 15, taRightJustify) +  //quantity
//         FixWidth(BufferToString(buffer.FieldValue(9)), 10, taRightJustify) +
        FixWidth(FormatFloat('#,##0.#0', BufferToFloat(buffer.FieldValue(1))), 15, taRightJustify) +//harga
        FixWidth(FormatFloat('#,##0.#0', BufferToFloat(buffer.FieldValue(19))), 15, taRightJustify) +//discount
        FixWidth(FormatFloat('#,##0.#0', BufferToFloat(buffer.FieldValue(2))), 15, taRightJustify));//amount
//         FixWidth(BufferToString(buffer.Fields[9].Value), 15, taLeftJustify) );

      buffer.MoveNext;
    end;

    buffer.First;

    ls.Append(
      FixWidth(' ', 5, taLeftJustify) +
      FixWidth(GARIS, PAPER_WIDTH-5, taCenter));

      {    if GlobalSystemConfig[CONF_FOOTER1-1].ConfValue <> '' then
    value.Append(FixWidth(GlobalSystemConfig[CONF_FOOTER1-1].ConfValue, 40, taCenter));
  if GlobalSystemConfig[CONF_FOOTER2-1].ConfValue <> '' then
    value.Append(FixWidth(GlobalSystemConfig[CONF_FOOTER2-1].ConfValue, 40, taCenter));}
    ls.Append(
      FixWidth(' ', 5, taLeftJustify) +
      FixWidth('CARA BAYAR ', 12, taRightJustify)+
      FixWidth(' :', 2, taLeftJustify) +
            FixWidth(IfThen( BufferToInteger(buffer.FieldValue(21))=0,'TUNAI','NON TUNAI (ID.Card='+BufferToString(buffer.FieldValue(22))+' Bank:'+BufferToString(buffer.FieldValue(23))+')'), 62, taLeftJustify)+
    //  FixWidth('DISERAHKAN', 20, taCenter) +
//      FixWidth('DISETUJUI', 20, taCenter) +
  //    FixWidth('DICETAK :', 20, taCenter)}


      FixWidth('SUBTOTAL', 30, taRightJustify) +
      FixWidth(' :', 2, taLeftJustify) +                          //17
      FixWidth(FormatFloat('#,##0.#0', BufferToFloat(buffer.FieldValue(9))), 20, taRightJustify));

    ls.Append(
     FixWidth(' ', 5, taLeftJustify) +
      FixWidth('BAYAR', 12, taRightJustify)+
      FixWidth(' :', 2, taLeftJustify) +                          //17
      FixWidth(FormatFloat('#,##0.#0', BufferToFloat(buffer.FieldValue(7))), 20, taRightJustify)+                          //17
      FixWidth(' ', 42, taLeftJustify) +
      FixWidth('DISC.FAKTUR(Rp.)', 30, taRightJustify) +
      FixWidth(' :', 2, taLeftJustify) +
      FixWidth(FormatFloat('#,##0.#0', BufferToFloat(buffer.FieldValue(11))), 20, taRightJustify));


   ls.Append(
     FixWidth(' ', 5, taLeftJustify) +
      FixWidth('KEMBALIAN', 12, taRightJustify)+
      FixWidth(' :', 2, taLeftJustify) +
      FixWidth(FormatFloat('#,##0.#0', BufferToFloat(buffer.FieldValue(8))), 20, taRightJustify)+
       FixWidth(' ', 42, taLeftJustify) +
      FixWidth('UANG MUKA', 30, taRightJustify) +
      FixWidth(' :', 2, taLeftJustify) +
      FixWidth(FormatFloat('#,##0.#0', BufferToFloat(buffer.FieldValue(20))), 20, taRightJustify));   

    
    
    ls.Append(
      FixWidth(' ', 5, taLeftJustify) +
      FixWidth(' ', 76, taLeftJustify)+ {+
      FixWidth('(---------------)', 20, taCenter) +
      FixWidth('(---------------)', 20, taCenter) +
      FixWidth('(---------------)', 20, taCenter)}

      FixWidth('TOTAL', 30, taRightJustify) +
      FixWidth(' :', 2, taLeftJustify) +
      FixWidth(FormatFloat('#,##0.#0', BufferToFloat(buffer.FieldValue(6))), 20, taRightJustify));

      ls.Append(
      FixWidth(' ', 5, taLeftJustify) +
      FixWidth(GARIS2, PAPER_WIDTH-5, taCenter));
      for i:= 0 to cabang.RecordCount-1 do begin
  {0branch_id, 1branch_name, 2address,  3phone1, 4phone2, 5fax, 6city, '+
  '7postal_code, 8branch_code}
      ls.Append(
      FixWidth(' ', 5, taLeftJustify) +
      FixWidth(BufferToString(cabang.FieldValue(1))+' : '+
               BufferToString(cabang.FieldValue(2))+' '+
               BufferToString(cabang.FieldValue(6))+' Telp. '+
               BufferToString(cabang.FieldValue(3))+' - '+
               BufferToString(cabang.FieldValue(7))
               ,PAPER_WIDTH-5, taLeftJustify));
      cabang.MoveNext;
  end;
  cabang.destroy;



    if ((insertedIdx = 0) or (halaman-1 > footer_printed)) then
    begin
      ls.Append(' ');
      ls.Append(' ');
    //  ls.Append(' ');
      
      insertedIdx:= ls.Count-3;
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
    RAWPrinter1.BeginDoc;
    RAWPrinter1.WriteList(ls, True);
    RAWPrinter1.EndDoc;

  finally
    //RAWPrinter1.Free;
    ls.Free;
  end;

end;

procedure TfrmTrsSales.Button1Click(Sender: TObject);
begin
  inherited;
  printOrder(StrToIntDef(Edit1.Text,0));
end;

procedure TfrmTrsSales.asgServiceGetCellColor(Sender: TObject; ARow,
  ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin
  inherited;
  if ARow = 0 then exit;
 { if asgService.Ints[colIsFree,ARow] = 1 then
    ABrush.Color := $000080FF
 else
   ABrush.Color := clWindow;}
end;

procedure TfrmTrsSales.CalculateDiscCustomer(xrow: integer;
  isService: boolean);
var i:integer;harga,discPct,disc :double;  
begin
  if isService then begin
  end
  else begin
     if txtPasien.Tag = 0 then exit;

     if chkWajib.Checked then begin
        harga := StrFmtToFloatDef(asgSales.Cells[colHarga,xRow],0);
        discPct := StrFmtToFloatDef(lblDiscCust.Caption,0);
        disc := (harga * discPct / 100);
        asgSales.Cells[colDiscRp,xrow] := FloatToStrFmt(roundCorrected(disc));
        Calculate(xrow,false); 
     end;

  end;
end;

procedure TfrmTrsSales.LoadDataService(ArelationId:integer);
var i,j,row:integer; service,detail: TMysqlResult;
  Relation : TMstRelation;
begin
           {

            colServiceJenis =1;//text jenis service
  colServiceCustJml =2;//jumlah kumulatif history yg pernah customer lakukan -->terupdate jika tipe service bonus kumulatif
  colServiceCustTotal=3;//total kumulatif history yg pernah customer lakukan
  colServiceID = 4;//ID service type
  colServiceKumulatif =5;//apakah kumulatif atau bukan
  colServiceBatas=6;//batas mendapatkan bonus
  colServiceBonus=7;//service id yg didapatkan
  colServiceCurrent=8;//jumlah transaksi service saat ini;
}
   Relation := TMstRelation.Create;
   Relation.RelationID := ArelationId;
   service := Relation.loadService;
   gridService.ExpandAll;
   gridService.Clear;
   ResetGrid(gridService,2,colServiceCurrent+2,1,1,-1);
   gridService.Cells[colServiceJenis,0] := 'Jenis Jasa';
   gridService.Cells[colServiceCustJml,0] := 'Jumlah';
   gridService.Cells[colServiceCustTotal,0] := 'Total';
   gridService.Cells[colServiceID,0] := 'ID ServiceType';
   gridService.Cells[colServiceKumulatif,0] := 'Kumulatif';
   gridService.Cells[colServiceBatas,0] := 'Batas Bonus';
   gridService.Cells[colServiceBonus,0] := 'ServiceID bonus';
   gridService.Cells[colServiceBonusJml,0] := 'Jml bonus yg didapat';
   gridService.Cells[colServiceCurrent,0] := 'Current Service';

   //0m.mst_id,1mst_name,2r.jumlah,3r.total
   //,4b.is_kumulatif,5b.jml_service,6b.bonus_service,7b.bonus_jml
   for i:= 0 to service.RecordCount-1 do begin
      row :=  gridService.RowCount-1;

      gridService.Cells[colServiceJenis,row]:= BufferToString(service.FieldValue(1));
      gridService.ints[colServiceCustJml,row]:= BufferToInteger(service.FieldValue(2));
      gridService.ints[colServiceCustTotal,row]:= BufferToInteger(service.FieldValue(3));
      gridService.ints[colServiceID,row]:= BufferToInteger(service.FieldValue(0));
      gridService.ints[colServiceKumulatif,row]:= BufferToInteger(service.FieldValue(4));
      gridService.ints[colServiceBatas,row]:= BufferToInteger(service.FieldValue(5));
      gridService.ints[colServiceBonus,row]:= BufferToInteger(service.FieldValue(6));
      gridService.ints[colServiceBonusJml,row]:= BufferToInteger(service.FieldValue(7));
      gridService.Ints[colServiceCurrent,row] := 0;

      detail := Relation.loadServiceDetail(BufferToInteger(service.FieldValue(0)));
      for j:= 0 to detail.RecordCount-1 do begin
          gridService.AddRow;
          row := gridService.RowCount-1;

          gridService.Cells[colServiceJenis,row] := FormatDateTime(ShortDateFormat,BufferToDateTime(detail.FieldValue(0)));
          gridService.Cells[colServiceCustJml,row]:= FloatToStrFmt(BufferToFloat(detail.FieldValue(1)));
          detail.MoveNext;
      end;

      if detail.RecordCount>0 then
        gridService.AddNode(row-detail.RecordCount,detail.RecordCount+1);


      service.MoveNext;
      gridService.AddRow;
   end;
   service.destroy;
   gridService.ContractAll;
   gridService.AutoSizeColumns(True,2);
   gridService.ColWidths[colServiceID] := 0;
   gridService.ColWidths[colServiceKumulatif] := 0;
   gridService.ColWidths[colServiceBatas] := 0;
   gridService.ColWidths[colServiceBonusJml] := 0;
   gridService.ColWidths[colServiceCurrent] := 0;
   gridService.ColWidths[colServiceBonus] := 0;
   DeleteRowTerakhir(gridService,2,1);
   Relation.Free;
end;

procedure TfrmTrsSales.showFreeInfo;
var adaBonus:boolean;
   lsFree,lsRules:TStringList;
   i:integer;
   tmp : string;
begin

  tmp:=  TMstRelation.isFreeServiceText(txtPasien.Tag);

  adaBonus := (Trim(tmp)<>'');
//  lblFreeInfo.Visible := adaBonus;
  if adaBonus then begin
    lsFree := TStringList.Create;
    TMstRelation.getListFreeService(txtPasien.Tag,lsFree);
    for i := 0 to lsFree.Count-1 do begin
        addFreeList(StrToInt(lsFree.Names[i]),-1,StrToInt(lsFree.Values[lsFree.Names[i]]),false);
    end;
    lsFree.Free;

  end;

{  if adaBonus then
  //  if Confirmed('Apakah bonus akan diambil sekarang') then begin
    //   lsFree := TStringList.Create;
     //  lsRules := TStringList.Create;
      // TMstRelation.getListFreeService(txtPasien.Tag,lsRules);
      // if frmLookupFreeService.Execute(txtPasien.Tag,lsFree,lsRules) then begin
       //TMstRelation.getListFreeService(txtPasien.Tag,lsFree);
         for i := 0 to lsFree.Count-1 do begin
           // getItem('',StrToInt(lsFree.Names[i]),1,StrToFloat(lsFree.Values[lsFree.Names[i]]),-1);
           tmp := lsFree.Strings[i];
            getItem('',StrToInt(EkstrakString(tmp,';',1)),1,StrToFloat(EkstrakString(tmp,';',3)),StrToInt(EkstrakString(tmp,';',2)),true);
         end;
       end;
       lsFree.Free;
    end;
}

end;

function TfrmTrsSales.getCustService(aServiceType: integer): integer;
var i:integer;

begin
  Result := 0;
  for i:=1 to gridService.RowCount-1 do begin
      if gridService.Ints[colServiceID,i] = aServiceType then begin
          Result := gridService.Ints[colServiceCustJml,i];
          Break;          
      end;
  end;
end;

procedure TfrmTrsSales.IncreaseQtyCustService(aServiceType:integer);
var i:integer;
begin
  for i:= 1 to gridService.RowCount-1 do begin
//    if ()
    gridService.Ints[colServiceCurrent, i]:= (asgSales.Ints[colServiceCurrent, i] + 1);
  end;
end;

function TfrmTrsSales.getAnimalsID: string;
var i:integer;
begin
   Result := '';
   for i:= 0 to chkAnimal.Items.Count-1 do begin
      if chkAnimal.Checked[i] then
        Result := Result + EkstrakString(lsAnimalAll.Names[i],';',1)+';';
   end;


end;

procedure TfrmTrsSales.setAnimals(AnimalSeq:string);
var i,count,j:integer;
    tmp:string;
begin
  count := HitungChar(AnimalSeq,';');
  if count > 0 then begin
      for i:= 1 to count do begin
         tmp := EkstrakString(AnimalSeq,';',i);
         for j:= 0 to chkAnimal.Items.Count -1 do begin
            if (EkstrakString(lsAnimalAll.Names[j],';',1)=tmp) then
              chkAnimal.Checked[j] := True;
         end;
      end;
  end

    
end;

function TfrmTrsSales.getListAnimalCust: string;
var i:integer;tmp:string;
begin
   tmp := '';
   for i:= 0 to chkAnimal.Items.Count-1 do begin
      if chkAnimal.Checked[i] then
        tmp := tmp+EkstrakString(lsAnimalAll.Names[i],';',2)+',';
   end;
   if tmp <> '' then
      tmp := copy(tmp,0,length(tmp)-1);
   Result := IfThen(tmp='','-1',tmp);
end;

procedure TfrmTrsSales.checkQtyServiceKumulatif;
var servicetype,batas,bonus,jmlHewan:integer;
 mstBonus:TMstServiceBonus;

   function getJmlHewan(aNimalId:integer):integer;
    var i:integer;
   begin
      Result := 0;
      for i:= 0 to chkAnimal.Items.Count-1 do
        if (chkAnimal.Checked[i]) and (aNimalId=StrToIntDef(EkstrakString(lsAnimalAll.Names[i],';',2),0)) then
           inc(Result);
   end;

begin
  {RULES : cek hewan customer beserta dengan tipe hewannya}
  servicetype := asgService.Ints[colServiceType,asgService.Row];
  mstBonus := TMstServiceBonus.Create;
  jmlHewan := getJmlHewan(asgService.Ints[colAnimalId,asgService.Row]);
  if jmlHewan <= 0 then exit;
  if mstBonus.SelectInDb(servicetype) then
    if mstBonus.FIsKumulatif = 0 then  begin           //
      if mstBonus.FJmlService > 0 then begin
        bonus := ((asgService.Ints[colQty,asgService.row]div jmlHewan) div (mstBonus.FJmlService ));
      //if (bonus >  0) then begin
          addFreeList(mstBonus.FBonusService,asgService.Ints[colAnimalId,asgService.Row],bonus*jmlHewan,False);
      end;
//        showFreeInfo;
{if trim(lblFreeInfo.Caption) <> '' then begin
          lblFreeInfo.Caption := ' Gratis '+ IntToStr(bonus)+' '+TMstService.GetName(mstBonus.FBonusService)+' '+TMstAnimal.GetName(asgService.Ints[colAnimalId,asgService.Row])+',';
        end
        else begin
          lblFreeInfo.Caption := ' Gratis '+IntToStr(bonus)+' '+TMstService.GetName(mstBonus.FBonusService)+' '+TMstAnimal.GetName(asgService.Ints[colAnimalId,asgService.Row]);
          lblFreeInfo.Visible :=  true;
        end;}
        //lblFreeInfo.Caption := IfThen(lblFreeInfo.Caption<>'',)
        //if Confirmed('Anda mendapatkan bonus untuk jenis jasa ini. Diambil sekarang?') then begin
          // getItem('',mstBonus.FBonusService,1,mstBonus.FBonusJml,asgService.Ints[colAnimalId,asgService.Row],true,asgService.Cells[colAnimalId,asgService.Row]);
      //end;
    end// end not kumulatif
    else begin//start kumulatif
      
    end;

  mstBonus.Free;
end;

procedure TfrmTrsSales.asgServiceGetEditorType(Sender: TObject; ACol,
  ARow: Integer; var AEditor: TEditorType);
begin
  inherited;
//  If ACol = colIsFree then AEditor := edCheckBox;
end;

procedure TfrmTrsSales.asgServiceCanEditCell(Sender: TObject; ARow,
  ACol: Integer; var CanEdit: Boolean);
begin
  inherited;
//  CanEdit := ACol in [colIsFree];
end;

procedure TfrmTrsSales.setGratis;
var isGretong : boolean;
begin
  isGretong := asgService.Cells[colIsFree,asgService.Row] = 'Ya';
  if isGretong then begin
     asgService.Cells[colIsFree,asgService.Row] := 'Tidak';
     asgService.Floats[colDiscRp,asgService.Row]:=0;
  end
  else begin
    asgService.Cells[colIsFree,asgService.Row] := 'Ya';
    asgService.Floats[colDiscRp,asgService.Row]:=asgService.Floats[colHarga,asgService.Row]*asgService.Floats[colQty,asgService.Row];
  end;
  Calculate(asgService.Row,True);
end;

procedure TfrmTrsSales.addFreeList(aServiceId, aAnimalId, aQty: integer;aReplaceQty:boolean);
var i:integer;
   key,tmp : string;
   found:boolean;
begin
   key := IntToStr(aServiceId)+';'+IntToStr(aAnimalId)+';';
   found := False;
   for i:= 0 to lsFree.Count-1 do begin
      if lsFree.Names[i] = key then begin
         if aQty = 0 then begin //hapus free
            lsFree.Delete(i);
         end
         else begin
           lsFree.Values[key] := IntToStr(aQty);// IfThen(aReplaceQty,IntToStr(aQty), IntToStr(StrToInt(lsFree.Values[key])+aQty));
         end;
         found := True;
         Break;
      end;
   end;

   if (not found) and (aQty>0) then begin
      lsFree.Add(key+'='+IntToStr(aQty));
   end;

   lblFreeInfo.Visible := lsFree.Count>0;
   for i:= 0 to lsFree.Count-1 do begin
      if i=0 then tmp := 'Gratis : ';
      tmp := tmp + lsFree.Values[lsFree.Names[i]] + ' '+TMstService.GetName(StrToInt(EkstrakString(lsFree.Names[i],';',1)))
            + ' '+TMstAnimal.GetName(StrToInt(EkstrakString(lsFree.Names[i],';',2)))+', ';
   end;
   lblFreeInfo.Caption := tmp;
end;

end.

