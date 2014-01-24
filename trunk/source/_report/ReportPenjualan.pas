unit ReportPenjualan;
{
Per Bulan
Per 2 Bulan
Per 3 Bulan
Per 4 Bulan}
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, ToolWin, StdCtrls, AdvEdit, UTransaction,
  Grids, BaseGrid, AdvGrid, WinXP, SUIImagePanel, Math, DateUtils, strutils,
  frmDockForm;

type
  TfrmReportPenjualan = class(TDockForm)
    ToolBar1: TToolBar;
    tbtRefresh: TToolButton;
    ToolButton2: TToolButton;
    tbtPrint: TToolButton;
    WinXP1: TWinXP;
    ToolButton5: TToolButton;
    suiPanel1: TsuiPanel;
    suiPanel2: TsuiPanel;
    grid: TAdvStringGrid;
    panelDate: TPanel;
    dtpAkhir: TDateTimePicker;
    dtpAwal: TDateTimePicker;
    Label2: TLabel;
    Label1: TLabel;
    cmbOpr: TComboBox;
    txtShift: TAdvEdit;
    txtKasir: TAdvEdit;
    btnKasir: TButton;
    Button3: TButton;
    txtCust: TAdvEdit;
    btnCust: TButton;
    cmbJenisReport: TComboBox;
    Label3: TLabel;
    txtStruk: TAdvEdit;
    Label4: TLabel;
    cmbJenis: TComboBox;
    txtDokter: TAdvEdit;
    Button1: TButton;
    procedure gridGetAlignment(Sender: TObject; ARow, ACol: Integer;
      var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tbtRefreshClick(Sender: TObject);
    procedure ToolButton5Click(Sender: TObject);
    procedure cmbOprChange(Sender: TObject);
    procedure tbtPrintClick(Sender: TObject);
    procedure btnKasirClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure btnCustClick(Sender: TObject);
    procedure cmbJenisReportChange(Sender: TObject);
    procedure gridGetCellBorder(Sender: TObject; ARow, ACol: Integer;
      APen: TPen; var Borders: TCellBorders);
    procedure gridGetCellColor(Sender: TObject; ARow, ACol: Integer;
      AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
    procedure cmbJenisChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);

  private
    private purpose :integer;
    procedure InitGridTgl;

    procedure InitGridHistori;
    procedure SetFilter;
    procedure InitFilter;
    procedure LoadDataJualTgl;//rekap
    procedure LoadDataJualBulanan;
    procedure LoadDataHistori;
  public
    procedure Execute(id: integer); override;
  end;

var
  frmReportPenjualan: TfrmReportPenjualan;

implementation

uses Subroutines, MainMenu,
  MstCodeList, MySQLConnector, uMysqlClient, UConst, UMaster,
  LookupData, ReportPenjualan1Print, UConstTool, ReportJualPrint,
  ReportPenjualan2Print;

const
  colNo     = 0;
  colTgl    = 1;
  colCaraBayar = 2;
  colJualBarangPokok = 3;
  colJualBarang   = 4;
  colJualBarangProfit   = 5;

  colJualHewanPokok  = 6;
  colJualHewan  = 7;
  colJualHewanProfit  = 8;
  colJualJasa   = 9;
  colDisc   = 10;
  colNetPokok    = 11;
  colNet    = 12;
  //colDuit   = 5;
  colProfit = 13;
  colCust   = 14;
  colDate1  =15;
  colDate2  = 16;

  colCode    = 1;
  colStuk    = 2;
  colHargaPokok = 3;
  colHarga   = 4;
  colQty     = 5;
  colDiscPrc = 6;
  colDiscRp  = 7;
  colSubtotalPokok= 8;
  colSubtotal= 9;
  colRowID   = 10;


{$R *.dfm}

{ TfrmTrsItemShipmentList }

procedure TfrmReportPenjualan.Execute(id: integer);
begin
  inherited;
  ToolBar1.ParentColor:= false;
  ToolBar1.Color:= clWhite;
  purpose := id;//0:kyw; 1=owner
  InitFilter;
  Run(Self);
end;

procedure TfrmReportPenjualan.InitFilter;
begin
  GlobalFilter.Reset;
  GlobalPeriode.Reset;
  cmbJenisReport.ItemIndex:= 0;
  cmbJenisReportChange(nil);

  txtKasir.Tag:= 0;
  txtShift.Tag:= 0;
  txtCust.Tag:= 0;
  txtDokter.Tag:= 0;
 // txtShift.Text:= 'Semua Shift';
  txtKasir.Clear;//:= 'Semua Kasir';
  txtCust.Text:='';// 'Semua Pasien';
 // txtDokter.Text:= 'Semua Dokter';
  txtStruk.Clear;
  cmbOpr.ItemIndex:= 3;
  cmbOprChange(nil);
  cmbJenis.ItemIndex:= 0;
  cmbJenisChange(nil);
  dtpAwal.Date:= ServerNow;
  dtpAkhir.Date:= ServerNow;
end;

procedure TfrmReportPenjualan.SetFilter;
begin
  GlobalFilter.Reset;
  GlobalFilter.SeriesID := txtShift.Tag;
  GlobalFilter.StatusID := txtCust.Tag;
  GlobalFilter.FString1 := txtKasir.Text;
  GlobalFilter.Numeric1 := cmbJenis.Tag;
  GlobalFilter.Numeric3 := txtDokter.Tag;  
  GlobalFilter.Name     := txtStruk.Text;
  GlobalPeriode.setPeriode(cmbOpr.ItemIndex, dtpAwal.Date, dtpAkhir.Date);
end;

procedure TfrmReportPenjualan.gridGetAlignment(Sender: TObject;
  ARow, ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  case cmbJenisReport.Tag of
    //5
    1: if ACol in[colStuk, colCode] then HAlign:= taLeftJustify
       else HAlign:= taRightJustify;
    else if ACol > colTgl then HAlign:= taRightJustify;
  end;
end;

procedure TfrmReportPenjualan.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
//  if lsGudang <> nil then lsGudang.Free;
//  lsGudang:= nil;
end;

procedure TfrmReportPenjualan.tbtRefreshClick(Sender: TObject);
begin
  case cmbJenisReport.Tag of
    0: LoadDataJualTgl;
    //5
    1: LoadDataHistori;
    //else LoadDataJualBulanan;
  end;
end;

procedure TfrmReportPenjualan.ToolButton5Click(Sender: TObject);
begin
  InitFilter
end;

procedure TfrmReportPenjualan.LoadDataJualTgl;
var i,j : integer; tgl, item: TMysqlResult;
begin
  try
    StartProgress;
    SetFilter;
    InitGridTgl;
    tgl:= TReport.LoadTglJual;
    if (purpose=1) then
      grid.RowCount:= IfThen(tgl.RecordCount > 0, tgl.RecordCount + 4, 5)
    else
      grid.RowCount:= IfThen(tgl.RecordCount > 0, tgl.RecordCount + 3, 4);
    tgl.First;
    for i:= 1 to tgl.RecordCount do begin
      ProsesProgress(i, tgl.RecordCount);

      GlobalPeriode.PeriodeAwal1:= BufferToDateTime(tgl.FieldValue(0));
      GlobalPeriode.OpPeriodeAwal1:= soEquals;
      GlobalFilter.Numeric1 := BufferToInteger(tgl.FieldValue(1));

      item := TReport.LoadTglJualApotek;
      //'0net, 1embalase, 2amount_profit, 3count(*) '+
      if (purpose=1) then begin
        grid.Dates[colTgl, i+2]:= BufferToDateTime(tgl.FieldValue(0));
        grid.Cells[colCaraBayar, i+2]:= IfThen(BufferToInteger(tgl.FieldValue(1))=0,'TUNAI','NON TUNAI');
        grid.Cells[colJualBarang,   i+2]:= FloatToStrFmtNull(BufferToFloat(item.FieldValue(4)));
        grid.Cells[colJualBarangPokok,   i+2]:= FloatToStrFmtNull(BufferToFloat(item.FieldValue(7)));
        grid.Cells[colJualBarangProfit,   i+2]:= FloatToStrFmtNull(BufferToFloat(item.FieldValue(4))-BufferToFloat(item.FieldValue(7)));
        grid.Cells[colJualHewan,   i+2]:= FloatToStrFmtNull(BufferToFloat(item.FieldValue(5)));
        grid.Cells[colJualHewanPokok,   i+2]:= FloatToStrFmtNull(BufferToFloat(item.FieldValue(8)));
        grid.Cells[colJualHewanProfit,   i+2]:= FloatToStrFmtNull(BufferToFloat(item.FieldValue(5))-BufferToFloat(item.FieldValue(8)));

        grid.Cells[colJualJasa,   i+2]:= FloatToStrFmtNull(BufferToFloat(item.FieldValue(6)));

        grid.Cells[colDisc,   i+2]:= FloatToStrFmtNull(BufferToFloat(item.FieldValue(1)));
  //      grid.Cells[colNet,    i+1]:= FloatToStrFmtNull(BufferToFloat(item.FieldValue(0)) + BufferToFloat(item.FieldValue(1)));
        grid.Cells[colNet,    i+2]:= FloatToStrFmtNull(BufferToFloat(item.FieldValue(4)) + BufferToFloat(item.FieldValue(5))+ BufferToFloat(item.FieldValue(6))
                  -BufferToFloat(item.FieldValue(1)));
        grid.Cells[colProfit, i+2]:= FloatToStrFmtNull(BufferToFloat(item.FieldValue(2)));
        grid.Cells[colCust,   i+2]:= FloatToStrFmtNull(BufferToFloat(item.FieldValue(3)));
      end else begin
          grid.Dates[colTgl, i+1]:= BufferToDateTime(tgl.FieldValue(0));
          grid.Cells[colCaraBayar, i+1]:= IfThen(BufferToInteger(tgl.FieldValue(1))=0,'TUNAI','NON TUNAI');
          grid.Cells[colJualBarangPokok,   i+1]:= FloatToStrFmtNull(BufferToFloat(item.FieldValue(4)));
//          grid.Cells[colJualBarangPokok,   i+2]:= FloatToStrFmtNull(BufferToFloat(item.FieldValue(7)));
  //        grid.Cells[colJualBarangProfit,   i+2]:= FloatToStrFmtNull(BufferToFloat(item.FieldValue(4))-BufferToFloat(item.FieldValue(7)));
         // grid.Cells[colJualHewan,   i+2]:= FloatToStrFmtNull(BufferToFloat(item.FieldValue(5)));
          grid.Cells[colJualHewanPokok-2,   i+1]:= FloatToStrFmtNull(BufferToFloat(item.FieldValue(5)));
    //      grid.Cells[colJualHewanProfit,   i+2]:= FloatToStrFmtNull(BufferToFloat(item.FieldValue(5))-BufferToFloat(item.FieldValue(8)));

          grid.Cells[colJualJasa-4,   i+1]:= FloatToStrFmtNull(BufferToFloat(item.FieldValue(6)));

          grid.Cells[colDisc-4,   i+1]:= FloatToStrFmtNull(BufferToFloat(item.FieldValue(1)));
    //      grid.Cells[colNet,    i+1]:= FloatToStrFmtNull(BufferToFloat(item.FieldValue(0)) + BufferToFloat(item.FieldValue(1)));
          grid.Cells[colNet-4,    i+1]:= FloatToStrFmtNull(BufferToFloat(item.FieldValue(4)) + BufferToFloat(item.FieldValue(5))+ BufferToFloat(item.FieldValue(6))
                    -BufferToFloat(item.FieldValue(1)));
//          grid.Cells[colProfit, i+2]:= FloatToStrFmtNull(BufferToFloat(item.FieldValue(2)));
          grid.Cells[colCust-4,   i+1]:= FloatToStrFmtNull(BufferToFloat(item.FieldValue(3)));
      end;

      item.destroy;
      tgl.MoveNext;
    end;
    tgl.destroy;

    for j:= colJualBarangPokok to colCust do
      grid.Cells[j,grid.RowCount-1]:= FloatToStrFmtNull(grid.ColumnSum(j, 2, grid.RowCount-2));
  finally
    EndProgress;
  end;
end;

procedure TfrmReportPenjualan.InitGridTgl;
begin
  if (purpose = 1) then begin
    grid.ExpandAll;
    grid.Clear;
    grid.ColCount:= colDate2 + 1;

    grid.RowCount :=5;
    grid.FixedCols:= 2;
    grid.FixedRows:= 3;

    grid.FloatingFooter.Visible:= True;
    grid.SortSettings.Show:= False;
    grid.ColumnSize.StretchColumn := -1;
    grid.ColumnSize.Stretch:= False;
    grid.AutoSizeColumns(True,2);
    grid.Options := [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goRowSelect];

    grid.MergeCells(colTgl,0,1,3);
    grid.Cells[colTgl,   0]:= 'Tanggal';
    grid.MergeCells(colCaraBayar,0,1,3);
    grid.Cells[colCaraBayar,   0]:= 'Cara Bayar';
    grid.MergeCells(colJualBarangPokok,0,7,1);
    grid.Cells[colJualBarangPokok,  0]:= 'Penjualan';
    grid.MergeCells(colJualBarangPokok,1,3,1);
    grid.Cells[colJualBarangPokok,  1]:= 'Barang';
    grid.Cells[colJualBarangPokok,  2]:= 'Pokok';
    grid.Cells[colJualBarang,  2]:= 'Jual';
    grid.Cells[colJualBarangProfit,  2]:= 'Profit';
    grid.MergeCells(colJualHewanPokok,1,3,1);
    grid.Cells[colJualHewanPokok,  1]:= 'Hewan';
    grid.Cells[colJualHewanPokok,  2]:= 'Pokok';
    grid.Cells[colJualHewan,  2]:= 'Jual';
    grid.Cells[colJualHewanProfit,  2]:= 'Profit';
    grid.MergeCells(colJualJasa,1,1,2);
    grid.Cells[colJualJasa,  1]:= 'Jasa';
    grid.MergeCells(colDisc,0,1,3);
    grid.Cells[colDisc,  0]:= 'Discount Faktur';
    grid.MergeCells(colNet,0,1,3);
    grid.Cells[colNet,   0]:= 'Jumlah';
    grid.MergeCells(colProfit,0,1,3);
    grid.Cells[colProfit,0]:= 'Profit';
    grid.MergeCells(colCust,0,1,3);
    grid.Cells[colCust,  0]:= 'Cust';

    grid.ColWidths[colTgl   ]:= 100;
    grid.ColWidths[colCaraBayar   ]:= 100;
    grid.ColWidths[colJualBarangPokok  ]:=  100;
    grid.ColWidths[colJualBarang  ]:= 100;
    grid.ColWidths[colJualBarangProfit  ]:= 90;
    grid.ColWidths[colJualHewanPokok  ]:=  100;
    grid.ColWidths[colJualHewan  ]:= 100;
    grid.ColWidths[colJualHewanProfit  ]:= 90;
    grid.ColWidths[colJualJasa  ]:= 100;
    grid.ColWidths[colDisc  ]:= 100;
    grid.ColWidths[colNet   ]:= 100;
    grid.ColWidths[colNetPokok   ]:= 0;
    grid.ColWidths[colProfit]:= 0;//100;
    grid.ColWidths[colCust  ]:= 60;
    grid.ColWidths[colNo]:= 20;
    grid.ColWidths[colDate1]:= 0;
    grid.ColWidths[colDate2]:= 0;
  end
  else begin //kyw version
      grid.ExpandAll;
    grid.Clear;
    grid.ColCount:= colDate2 + 1-4;

    grid.RowCount :=4;
    grid.FixedCols:= 2;
    grid.FixedRows:= 2;

    grid.FloatingFooter.Visible:= True;
    grid.SortSettings.Show:= False;
    grid.ColumnSize.StretchColumn := -1;
    grid.ColumnSize.Stretch:= False;
    grid.AutoSizeColumns(True,2);
    grid.Options := [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goRowSelect];

    grid.MergeCells(colTgl,0,1,2);
    grid.Cells[colTgl,   0]:= 'Tanggal';
    grid.MergeCells(colCaraBayar,0,1,2);
    grid.Cells[colCaraBayar,   0]:= 'Cara Bayar';
    grid.MergeCells(colJualBarangPokok,0,3,1);
    grid.Cells[colJualBarangPokok,  0]:= 'Penjualan';
    grid.Cells[colJualBarangPokok,  1]:= 'Barang';
    grid.Cells[colJualHewanPokok-2,  1]:= 'Hewan';
    grid.Cells[colJualJasa-4,  1]:= 'Jasa';
    grid.MergeCells(colDisc-4,0,1,2);
    grid.Cells[colDisc-4,  0]:= 'Discount Faktur';
    grid.MergeCells(colNet-4,0,1,2);
    grid.Cells[colNet-4,   0]:= 'Jumlah';
    grid.MergeCells(colProfit-4,0,1,2);
    grid.Cells[colProfit-4,0]:= 'Profit';
    grid.MergeCells(colCust-4,0,1,2);
    grid.Cells[colCust-4,  0]:= 'Cust';

    grid.ColWidths[colTgl   ]:= 100;
    grid.ColWidths[colCaraBayar   ]:= 100;
    grid.ColWidths[colJualBarangPokok  ]:=  100;
    grid.ColWidths[colJualHewanPokok-2  ]:=  100;
    grid.ColWidths[colJualJasa-4  ]:= 100;
    grid.ColWidths[colDisc-4  ]:= 100;
    grid.ColWidths[colNet-4   ]:= 100;
    grid.ColWidths[colNetPokok-4   ]:= 0;
    grid.ColWidths[colProfit-4]:= 0;//100;
    grid.ColWidths[colCust-4  ]:= 60;
    grid.ColWidths[colNo]:= 20;
    grid.ColWidths[colDate1-4]:= 0;
    grid.ColWidths[colDate2-4]:= 0;
  end
end;

procedure TfrmReportPenjualan.cmbOprChange(Sender: TObject);
begin
  dtpAkhir.Enabled:= cmbOpr.ItemIndex = 3;
end;

procedure TfrmReportPenjualan.LoadDataHistori;
var i,j, row: integer; item: TMysqlResult;
  struk: string; last_trx: boolean;
  grandTotal,grandTotalPokok,grandTunai,grandNonTunai,subtotalPokok,TotalPokok :double;
begin
  try
    StartProgress;
    SetFilter;
    InitGridHistori;
    grandTotal := 0;grandTunai :=0; grandNonTunai :=0;TotalPokok := 0;grandTotalPokok:=0;
    item:= TReport.LoadTglJualHistori;
   {0trans_num, 1barcode,2item_name,  3price, 4quantity, 5mst_code,
    6disc, 7disc_val, 8amount, 9trans_date, 10subtotal, 11disc_mst,
    12disc_val_mst, 13tax, 14total..... 18transtype,19cara_bayar,20d.price_purchase }
    for i:= 1 to item.RecordCount do begin
      ProsesProgress(i, item.RecordCount);
      row:= grid.RowCount-1;
      if struk <> item.FieldValue(0) then begin
         grid.MergeCells(colCode, row, 2, 1);
         grid.Ints[colRowID, row]:= 1;
         grid.Cells[colCode, row]:= item.FieldValue(0)+ IfThen(BufferToInteger(item.FieldValue(19))=0,' (TUNAI)',' (NON TUNAI)');
         grid.Dates[colSubtotal,row]:= BufferToDateTime(item.FieldValue(9));
         grid.AddRow;
      end;
      struk:= item.FieldValue(0);
      row:= grid.RowCount-1;
      {colCode    = 1;
  colStuk    = 2;
  colHargaPokok = 3;
  colHarga   = 4;
  colQty     = 5;
  colDiscPrc = 6;
  colDiscRp  = 7;
  colSubtotalPokok= 8;
  colSubtotal= 9;
  colRowID   = 10;}
      grid.Cells[colCode,row]:= item.FieldValue(1) ;
      grid.Cells[colStuk,row]:=  item.FieldValue(2);

      grid.Cells[colQty,row]:=
            FloatToStrFmtNull(BufferToFloat(item.FieldValue(4))) + ' '+item.FieldValue(5);
        grid.Cells[colHarga,row]:= FloatToStrFmtNull(BufferToFloat(item.FieldValue(3)));
        grid.Cells[colHargaPokok,row]:= FloatToStrFmtNull(BufferToFloat(item.FieldValue(20)));
        grid.Cells[colDiscRp,row]:= FloatToStrFmtNull(BufferToFloat(item.FieldValue(7)));
        grid.Cells[colSubtotal,row]:= FloatToStrFmtNull(IfThen(BufferToInteger(item.FieldValue(18))=SALES_TYPE_RETUR,-1,1)* BufferToFloat(item.FieldValue(8)));
        subtotalPokok := (BufferToFloat(item.FieldValue(4)) * BufferToFloat(item.FieldValue(20))) - BufferToFloat(item.FieldValue(7)) ;
        TotalPokok := TotalPokok + subtotalPokok;
        grid.Cells[colSubtotalPokok,row]:= FloatToStrFmtNull(IfThen(BufferToInteger(item.FieldValue(18))=SALES_TYPE_RETUR,-1,1)* subtotalPokok);
    { // for j:= 1 to colSubtotal do begin
        grid.Cells[j,row]:= item.FieldValue(j);
      //  case j of
          colCode, colStuk:
            grid.Cells[j,row]:= item.FieldValue(j);

          colQty:
            grid.Cells[j,row]:=
            FloatToStrFmtNull(BufferToFloat(item.FieldValue(j))) + ' '+item.FieldValue(j+1);

          colHarga:
            grid.Cells[j,row]:= FloatToStrFmtNull(BufferToFloat(item.FieldValue(j)));
          colHarga,colHargaPokok:
            grid.Cells[j,row]:= FloatToStrFmtNull(BufferToFloat(item.FieldValue(j)));

          colDiscPrc, colDiscRp:
            grid.Cells[j,row]:= FloatToStrFmtNull(BufferToFloat(item.FieldValue(j+1)));
           colSubtotal:
            grid.Cells[j,row]:= FloatToStrFmtNull(IfThen(BufferToInteger(item.FieldValue(18))=SALES_TYPE_RETUR,-1,1)* BufferToFloat(item.FieldValue(j+1)));
           colSubtotalPokok:
            grid.Cells[j,row]:= FloatToStrFmtNull(IfThen(BufferToInteger(item.FieldValue(18))=SALES_TYPE_RETUR,-1,1)* BufferToFloat(item.FieldValue(j+1)));
       // end;
     // end;     }
      last_trx:= False;
      if (i < item.RecordCount) and (i>=1) then begin
        item.MoveNext;
        last_trx:= item.FieldValue(0) <> struk;
        item.Prior;
      end;

      if (i = item.RecordCount) or last_trx then begin
        grid.AddRow; //row:= grid.RowCount-1;
        grid.Ints[colRowID,     grid.RowCount-1]:= 2;
        {grid.Cells[colDiscRp,   grid.RowCount-1]:= 'Subtotal:';
        grid.Cells[colSubtotal, grid.RowCount-1]:= FloatToStrFmtNull(BufferToFloat(item.FieldValue(10)));}
        {grid.Cells[colCode, grid.RowCount-1]:= 'Operator: ';
        grid.Cells[colStuk, grid.RowCount-1]:= item.FieldValue(17);
        grid.AddRow;
        {grid.Cells[colDiscRp,grid.RowCount-1]:= 'Disc(%):';
        grid.Cells[colSubtotal,grid.RowCount-1]:= FloatToStrFmtNull(BufferToFloat(item.FieldValue(11)));
        grid.AddRow;
        grid.Cells[colDiscRp,grid.RowCount-1]:= 'Disc(Rp):';
        grid.Cells[colSubtotal,grid.RowCount-1]:= FloatToStrFmtNull(BufferToFloat(item.FieldValue(12)));
        grid.AddRow;
        grid.Cells[colDiscRp,grid.RowCount-1]:= 'PPN:';
        grid.Cells[colSubtotal,grid.RowCount-1]:= FloatToStrFmtNull(BufferToFloat(item.FieldValue(13)));
        grid.AddRow;
        }
        grid.Cells[colDiscRp,grid.RowCount-1]:= 'Discount:';
        grid.Cells[colSubtotal,grid.RowCount-1]:= FloatToStrFmtNull(BufferToFloat(item.FieldValue(12)));
        grid.AddRow;
        grid.Cells[colCode, grid.RowCount-1]:= 'Opr.: ';
        grid.Cells[colStuk, grid.RowCount-1]:= item.FieldValue(17);
        grid.Cells[colDiscRp,grid.RowCount-1]:= 'Total:';
        grid.Cells[colSubtotal,grid.RowCount-1]:= FloatToStrFmtNull(IfThen(BufferToInteger(item.FieldValue(18))=SALES_TYPE_RETUR,-1,1)* BufferToFloat(item.FieldValue(14)));
        if (purpose=1) then begin
           grid.AddRow;
        //  grid.Cells[colCode, grid.RowCount-1]:= 'Opr.: ';
        //  grid.Cells[colStuk, grid.RowCount-1]:= item.FieldValue(17);
          grid.Cells[colDiscRp,grid.RowCount-1]:= 'Total Pokok:';
          grid.Cells[colSubtotal,grid.RowCount-1]:= FloatToStrFmtNull(IfThen(BufferToInteger(item.FieldValue(18))=SALES_TYPE_RETUR,-1,1)* TotalPokok);
        end;
        grid.AddRow;
        grandTotal :=grandTotal + IfThen(BufferToInteger(item.FieldValue(18))=SALES_TYPE_RETUR,-1,1)*BufferToFloat(item.FieldValue(14));
        grandTotalPokok := grandTotalPokok + TotalPokok;
        TotalPokok := 0;
        if (BufferToInteger(item.FieldValue(19))=0) then
          grandTunai := grandTunai +  IfThen(BufferToInteger(item.FieldValue(18))=SALES_TYPE_RETUR,-1,1)*BufferToFloat(item.FieldValue(14));
        if (BufferToInteger(item.FieldValue(19))=1) then
          grandNonTunai := grandNonTunai +  IfThen(BufferToInteger(item.FieldValue(18))=SALES_TYPE_RETUR,-1,1)*BufferToFloat(item.FieldValue(14));
      {  grid.Cells[colDiscRp,grid.RowCount-1]:= 'TUNAI:';
        grid.Cells[colSubtotal,grid.RowCount-1]:= FloatToStrFmtNull(BufferToFloat(item.FieldValue(16)));
        grid.AddRow;}
      end;
      grid.AddRow;

      item.MoveNext;
    end;
    grid.Cells[colDiscRp,grid.RowCount-1]:= 'TUNAI :';
    grid.Cells[colSubtotal,grid.RowCount-1]:= FloatToStrFmtNull(grandTunai);
     grid.AddRow;
     grid.Cells[colDiscRp,grid.RowCount-1]:= 'NON TUNAI :';
     grid.Cells[colSubtotal,grid.RowCount-1]:= FloatToStrFmtNull(grandNonTunai);
     grid.AddRow;
    grid.Cells[colDiscRp,grid.RowCount-1]:= 'Grand Total:';
    grid.Cells[colSubtotal,grid.RowCount-1]:= FloatToStrFmtNull(grandTotal);
    if (purpose=1) then begin
      grid.AddRow;
      grid.Cells[colDiscRp,grid.RowCount-1]:= 'Grand Total Pokok:';
      grid.Cells[colSubtotal,grid.RowCount-1]:= FloatToStrFmtNull(grandTotalPokok);

      grid.AddRow;
      grid.Cells[colDiscRp,grid.RowCount-1]:= 'Profit:';
      grid.Cells[colSubtotal,grid.RowCount-1]:= FloatToStrFmtNull(grandTotal-grandTotalPokok);
      grid.ColWidths[colDiscPrc] := 0;
    end;
    item.destroy;
  finally
    EndProgress;
  end;
end;

procedure TfrmReportPenjualan.InitGridHistori;
begin
  grid.Clear;
  grid.ColCount:= colRowID + 1;
  grid.RowCount := 2;
  grid.FixedCols:= 1;
  grid.FixedRows:= 1;
  grid.ColumnSize.StretchColumn:= colStuk;
  grid.ColumnSize.Stretch:= True;
  grid.FloatingFooter.Visible:= False;
  grid.SortSettings.Show:= False;
  grid.Options := [goRangeSelect, goDrawFocusSelected, goRowSelect];

  grid.Cells[colStuk,    0]:= 'Deskripsi Barang';
  grid.Cells[colCode,    0]:= 'Barcode';
  grid.Cells[colHargaPokok,   0]:= 'H.Pokok';
  grid.Cells[colHarga,   0]:= 'H.Jual';
  grid.Cells[colQty,     0]:= 'Qty';
  grid.Cells[colDiscPrc, 0]:= 'Disc(%)';
  grid.Cells[colDiscRp,  0]:= 'Disc Rp';
  grid.Cells[colSubtotalPokok,0]:= 'Subtotal (Pokok)';
  grid.Cells[colSubtotal,0]:= 'Subtotal';

  grid.ColWidths[colStuk]:= 150;
  grid.ColWidths[colCode]:= 95;
  grid.ColWidths[colHargaPokok]:=  IfThen(purpose=1,70,0);
  grid.ColWidths[colHarga]:= 70;
  grid.ColWidths[colQty]:= 90;
  grid.ColWidths[colDiscPrc]:= 80;
  grid.ColWidths[colDiscRp]:= 80;
  grid.ColWidths[colSubtotalPokok]:= IfThen(purpose=1,90,0);
  grid.ColWidths[colSubtotal]:= 90;
  grid.ColWidths[colNo]:= 18;
  grid.ColWidths[colRowID]:= 0;
end;

procedure TfrmReportPenjualan.tbtPrintClick(Sender: TObject);
begin
  if not TSystemAccess.isCan(CAN_PRINT,AktiveControl.Tag) then exit;
  if MustRegister then exit;
 // if GlobalSystemConfig.localSetting.PrinterAdm <> '' then begin
   //  if (getDefaultPrinter <> GlobalSystemConfig.localSetting.PrinterAdm) then
    //     setDefaultPrinter(GlobalSystemConfig.localSetting.PrinterAdm);
  //end;
   SetFilter;
  if cmbJenisReport.ItemIndex = 0 then begin //harian

    try
      Application.CreateForm(TqrpReportPenjualan1, qrpReportPenjualan1);
      qrpReportPenjualan1.Executes(grid,purpose);
    finally
      qrpReportPenjualan1.Destroy;
    end;

 end else begin
    try
      Application.CreateForm(TqrpReportPenjualan2, qrpReportPenjualan2);
      qrpReportPenjualan2.Executes(grid,purpose);
    finally
      qrpReportPenjualan2.Destroy;
    end;
 end;

end;

procedure TfrmReportPenjualan.btnKasirClick(Sender: TObject);
var id: string;
begin
  id:= frmLookup.ExecuteUser('USER');
  if Id <> '' then begin
    txtKasir.Text:=  id;//TMstMaster.GetName(id);
//    txtKasir.Tag:= id;
  end;
end;

procedure TfrmReportPenjualan.Button3Click(Sender: TObject);
var id: integer;
begin
  id:= frmLookup.Execute('SHIFT');
  if Id > 0 then begin
    txtShift.Text:= TMstMaster.GetName(id);
    txtShift.Tag:= id;
  end;
end;

procedure TfrmReportPenjualan.btnCustClick(Sender: TObject);
var id: integer;
begin
  id:= frmLookup.Execute('CUST');
  if Id > 0 then begin
    txtCust.Text:= TMstRelation.GetName(id);
    txtCust.Tag:= id;
  end;
end;

procedure TfrmReportPenjualan.LoadDataJualBulanan;
var i,j : integer; item: TMysqlResult;
  ls: arString;
begin
  try
    StartProgress;
    SetFilter;
    InitGridTgl;
    grid.Cells[colTgl, 0]:= 'Periode';
    ls:= ExtractDate(dtpAwal.Date, dtpAkhir.Date, cmbJenisReport.Tag);
    for i:= 0 to length(ls)-1 do begin
      grid.Cells[colTgl,   i+1]:= ExtractYearMonth2(ls[i]);
      grid.Cells[colDate1, i+1]:= getYearMonth(ls[i], 1);
      grid.Cells[colDate2, i+1]:= getYearMonth(ls[i], 2);
      grid.AddRow;
    end;
    DeleteRowTerakhir(grid, 4,1);

    for i:= 1 to length(ls) do begin
      ProsesProgress(i, length(ls));
      GlobalPeriode.setPeriode(cmbOpr.ItemIndex, dtpAwal.Date, dtpAkhir.Date, True,
        grid.Cells[colDate1, i], grid.Cells[colDate2, i]);

      item:= TReport.LoadTglJualNilaiBulanApotek;
      //total:= TReport.LoadTglJualBulanKunjungan;
      {for j:= 0 to item.FieldsCount-1 do
        grid.Cells[colJual+j,i]:= FloatToStrFmtNull(BufferToFloat(item.FieldValue(j)));}

      grid.Cells[colJualBarang,   i]:= FloatToStrFmtNull(BufferToFloat(item.FieldValue(0)));
      grid.Cells[colJualHewan,   i]:= FloatToStrFmtNull(BufferToFloat(item.FieldValue(0)));
      grid.Cells[colJualJasa,   i]:= FloatToStrFmtNull(BufferToFloat(item.FieldValue(0)));
      grid.Cells[colDisc,   i]:= FloatToStrFmtNull(BufferToFloat(item.FieldValue(1)));
      grid.Cells[colNet,    i]:= FloatToStrFmtNull(BufferToFloat(item.FieldValue(0)) + BufferToFloat(item.FieldValue(1)));
      grid.Cells[colProfit, i]:= FloatToStrFmtNull(BufferToFloat(item.FieldValue(2)));
      grid.Cells[colCust,   i]:= FloatToStrFmtNull(BufferToFloat(item.FieldValue(3)));

      item.destroy;
    end;

    for j:= colJualBarang to colCust do
      grid.Cells[j,grid.RowCount-1]:= FloatToStrFmtNull(
        grid.ColumnSum(j, 1, grid.RowCount-2));
  finally
    EndProgress;
  end;

end;

procedure TfrmReportPenjualan.cmbJenisReportChange(Sender: TObject);
begin
  case cmbJenisReport.ItemIndex of
    0: cmbJenisReport.Tag:= 0;
  {  1: cmbJenisReport.Tag:= 1;
    2: cmbJenisReport.Tag:= 2;
    3: cmbJenisReport.Tag:= 3;
    4: cmbJenisReport.Tag:= 4;
    5: cmbJenisReport.Tag:= 5;}
    else cmbJenisReport.Tag:= 1;
  end;
  txtStruk.Enabled:= cmbJenisReport.Tag = 1;//5;
end;

procedure TfrmReportPenjualan.gridGetCellBorder(Sender: TObject; ARow,
  ACol: Integer; APen: TPen; var Borders: TCellBorders);
begin
  case cmbJenisReport.Tag of
    //5
    1: case grid.Ints[colRowID, ARow] of
         1: if ACol > 0 then Borders:= [cbBottom];
         2: if ACol > 0 then Borders:= [cbTop];
       end;
  end;
end;

procedure TfrmReportPenjualan.gridGetCellColor(Sender: TObject; ARow,
  ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin
  case cmbJenisReport.Tag of
    //5
    1: case grid.Ints[colRowID, ARow] of
         1: AFont.Style:= [fsBold];
       end;
  end;
end;

procedure TfrmReportPenjualan.cmbJenisChange(Sender: TObject);
begin
  cmbJenis.Tag:= cmbJenis.ItemIndex-1;
end;

procedure TfrmReportPenjualan.Button1Click(Sender: TObject);
var id: integer;
begin
  id:= frmLookup.Execute('DOKTER');
  if Id > 0 then begin
    txtDokter.Tag:= id;
  end;
end;

end.




