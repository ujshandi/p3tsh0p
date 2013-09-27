unit ReportProfit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, Grids, BaseGrid, AdvGrid,
  SUIImagePanel, ToolWin,
  Math, DateUtils, strutils,
  frmDockForm;

type
  TfrmReportProfit = class(TDockForm)
    ToolBar1: TToolBar;
    ToolButton4: TToolButton;
    tbtReset: TToolButton;
    tbtRefresh: TToolButton;
    ToolButton2: TToolButton;
    tbtPrint: TToolButton;
    suiPanel2: TsuiPanel;
    grid: TAdvStringGrid;
    Panel1: TPanel;
    cmbOpr: TComboBox;
    Label2: TLabel;
    dtpAwal: TDateTimePicker;
    dtpAkhir: TDateTimePicker;
    Label1: TLabel;
    procedure tbtRefreshClick(Sender: TObject);
    procedure tbtResetClick(Sender: TObject);
    procedure cmbOprChange(Sender: TObject);
    procedure gridGetAlignment(Sender: TObject; ARow, ACol: Integer;
      var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure gridGetCellBorder(Sender: TObject; ARow, ACol: Integer;
      APen: TPen; var Borders: TCellBorders);
    procedure gridGetCellColor(Sender: TObject; ARow, ACol: Integer;
      AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
    procedure gridResize(Sender: TObject);
    procedure tbtPrintClick(Sender: TObject);
  private
    procedure InitGrid;
    procedure LoadData;
    function InsertReportLabel(HeaderValue: string=''; FooterValue: string=''): integer;
  public
    procedure Execute(id: integer); override;
  end;

var
  frmReportProfit: TfrmReportProfit;

implementation

uses Subroutines, UTransaction, uMysqlClient, MySQLConnector,
  MainMenu, ReportProfitPrint, UConst;


const

  csTop    = 'T';
  csBottom = 'B';
  csTopBottom = 'TB';
  clReds      = 'M';

  RUGI_LABA = 'R';
  CASH_FLOW = 'C';

//column fixed index
  colLeft      = 0;
  colHeader    = 1;
  colFooter    = 2;
  colValue1    = 3;
  colValue2    = 4;
  colValue3    = 5;
  colRight     = 6;
  colBorder    = 7;
  colColor     = 8;

  rowCompanyID = 1;
  rowReptID    = 2;
  rowPeriode   = 3;
  rowBevel     = 4;

 // rowSales     = 5;
 // rowRevenue   = 5;

{$R *.dfm}

{ TfrmReportProfit }

procedure TfrmReportProfit.InitGrid;
begin
  grid.Clear;
  ResetGrid(grid, 5, 9,0,0,-1);

  grid.ColWidths[colLeft]:= 95;
  grid.ColWidths[colHeader]:= 18;
  grid.ColWidths[colValue1  ]:= 95;
  grid.ColWidths[colValue2  ]:= 95;
  grid.ColWidths[colValue3  ]:= 95;
  grid.ColWidths[colRight   ]:= 95;
  grid.ColWidths[colBorder  ]:= 0;
  grid.ColWidths[colColor   ]:= 0;
  grid.ColWidths[colFooter]:= grid.Width - (95*5) - 40;

  grid.MergeCells(colHeader,rowCompanyID, 6,1);
  grid.MergeCells(colHeader,rowReptID, 6,1);
  grid.MergeCells(colHeader,rowPeriode, 6,1);

  grid.Cells[colHeader,rowCompanyID]:= CompanyProfile.FCompanyName;
  grid.Cells[colHeader,rowReptID   ]:= 'Laporan Keuangan';
  grid.Cells[colHeader,rowPeriode  ]:= CaptionPeriode(GlobalPeriode.OpPeriodeAwal1, GlobalPeriode.PeriodeAwal1, GlobalPeriode.PeriodeAkhir1);

  grid.RowHeights[0]:= 5;
  grid.RowHeights[rowCompanyID]:= 30;
  grid.RowHeights[rowReptID]:= 20;
  grid.RowHeights[rowPeriode]:= 18;
  grid.RowHeights[rowBevel]:= 5;
end;

function TfrmReportProfit.InsertReportLabel(HeaderValue,
  FooterValue: string): integer;
var row: integer;
begin
  grid.AddRow;
  row:= grid.RowCount-1;
  if HeaderValue <> '' then begin
    grid.MergeCells(colHeader, row, 2, 1);
    grid.Cells[colHeader, row]:= HeaderValue;
  end else if FooterValue <> '' then
    grid.Cells[colFooter, row]:= FooterValue;
  Result:= row;
end;

procedure TfrmReportProfit.LoadData;
var row, i: integer;
  tmp, pendapatan, hpp,mutasi,pemakaian, biaya: double;
  akun_biaya: TMysqlResult;

begin
  try
    StartProgress;
    InitGrid;

    GlobalPeriode.setPeriode(cmbOpr.ItemIndex, dtpAwal.Date, dtpAkhir.Date);

    InsertReportLabel('PENDAPATAN');

    row:= InsertReportLabel('','Penerimaan Kas');//Pendapatan Sewa
    ProsesProgress(1,100);
    tmp:= TReport.getPendapatanSewa;
    pendapatan:= tmp;
    grid.Floats[colValue2, row]:= tmp;

    InsertReportLabel('','Penjualan');
    row:= InsertReportLabel('','- Penjualan Barang');
    ProsesProgress(20,100);
    tmp:= TReport.getPenjualan(0);
    pendapatan:= pendapatan + tmp;
    grid.Floats[colValue2, row]:= tmp;

    row:= InsertReportLabel('','- Penjualan Hewan');
    ProsesProgress(20,100);
    tmp:= TReport.getPenjualan(1);
    pendapatan:= pendapatan + tmp;
    grid.Floats[colValue2, row]:= tmp;

    row:= InsertReportLabel('','- Penjualan Jasa');
    ProsesProgress(20,100);
    tmp:= TReport.getPenjualan(2);
    pendapatan:= pendapatan + tmp;
    grid.Floats[colValue2, row]:= tmp;


    row:= InsertReportLabel('','- Retur Penjualan');
    ProsesProgress(30,100);
    tmp:= abs(TReport.getPenjualanRetur);
    pendapatan:= pendapatan - tmp;
    grid.Floats[colValue1, row]:= tmp;

    row:= InsertReportLabel('','- Potongan Penjualan');
    ProsesProgress(40,100);
    tmp:= TReport.getPenjualanDisc;
    pendapatan:= pendapatan - tmp;
    grid.Floats[colValue1, row]:= tmp;

    row:= InsertReportLabel('TOTAL PENDAPATAN');

    grid.Floats[colValue3, row]:= pendapatan;
    grid.Cells[colBorder, row]:= 'T';

    row:= InsertReportLabel();
    grid.RowHeights[row]:= 10;

    InsertReportLabel('HARGA POKOK PENJUALAN');
    row:= InsertReportLabel('','Pembelian');
    ProsesProgress(50,100);
    tmp:= TReport.getPembelian;
    hpp:= tmp;
    grid.Floats[colValue2, row]:= tmp;

    row:= InsertReportLabel('','Retur Pembelian');
    ProsesProgress(60,100);
    tmp:= TReport.getPembelianRetur;
    hpp:= hpp - tmp;
    grid.Floats[colValue1, row]:= tmp;

    row:= InsertReportLabel('','Potongan Pembelian');
    ProsesProgress(70,100);
    tmp:= TReport.getPembelianDisc;
    hpp:= hpp - tmp;
    grid.Floats[colValue1, row]:= tmp;

    row:= InsertReportLabel('','Pemakaian Barang');
    ProsesProgress(70,100);
    tmp:= TReport.getPemakaian;
    hpp:= hpp - tmp;
    grid.Floats[colValue1, row]:= tmp;

    row:= InsertReportLabel('','Mutasi Barang');
    ProsesProgress(70,100);
    tmp:=  TReport.getMutasi;
    hpp:= hpp + tmp;
    grid.Floats[colValue2, row]:= tmp;

    row:= InsertReportLabel(IfThen(pendapatan - hpp < 0, 'GROSS LOSS', 'GROSS PROFIT'));
    grid.Cells[colValue3, row]:= FloatToStrFmt(pendapatan - hpp, True);
    grid.Cells[colBorder, row]:= 'T';

    row:= InsertReportLabel();
    grid.RowHeights[row]:= 10;
    biaya:= 0;
    InsertReportLabel('BIAYA');

    ProsesProgress(90,100);
    akun_biaya:= TReport.getAkunBiaya;
    if akun_biaya.RecordCount > 0 then
    for i:= 1 to akun_biaya.RecordCount do begin
      row:= InsertReportLabel('', BufferToString(akun_biaya.FieldValue(1)));
      tmp:= TReport.getBiaya(BufferToInteger(akun_biaya.FieldValue(0)));
      biaya:= biaya + tmp;
      grid.Floats[colValue1, row]:= tmp;
      akun_biaya.MoveNext;
    end;
    akun_biaya.destroy;

    row:= InsertReportLabel('TOTAL BIAYA');
    grid.Cells[colBorder, row]:= 'T';
    grid.Floats[colValue3, row]:= biaya;

    row:= InsertReportLabel(IfThen(pendapatan - hpp - biaya < 0, 'OPERATING LOSS', 'OPERATING PROFIT'));
    grid.Cells[colValue3, row]:= FloatToStrFmt(pendapatan - hpp - biaya, True);
    grid.Cells[colBorder, row]:= 'TB';
    ProsesProgress(100,100);
  finally
    EndProgress;
  end;
end;

procedure TfrmReportProfit.tbtRefreshClick(Sender: TObject);
begin
  LoadData
end;

procedure TfrmReportProfit.tbtResetClick(Sender: TObject);
begin
  cmbOpr.ItemIndex:= 3;
  cmbOprChange(nil);
  dtpAwal.Date:= StartOfTheMonth(ServerNow);
  dtpAkhir.Date:= ServerNow;
end;

procedure TfrmReportProfit.cmbOprChange(Sender: TObject);
begin
  dtpAkhir.Enabled:= cmbOpr.ItemIndex=3;
end;

procedure TfrmReportProfit.Execute(id: integer);
begin
  inherited;
  ToolBar1.ParentColor:= false;
  ToolBar1.Color:= clWhite;
  Panel1.Color:= clFixedColum;

  InitGrid;
  tbtReset.Click;
  Run(Self);
end;

procedure TfrmReportProfit.gridGetAlignment(Sender: TObject; ARow,
  ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  if ARow < rowBevel then HAlign:= taCenter
  else if ACol > colFooter then HAlign:= taRightJustify
end;

procedure TfrmReportProfit.gridGetCellBorder(Sender: TObject; ARow,
  ACol: Integer; APen: TPen; var Borders: TCellBorders);
begin
  if (ACol > colLeft) and (ACol < colRight) then begin
    if ARow = rowBevel then Borders:= [cbTop];

    if (ACol > colFooter) and (grid.Cells[ACol, ARow] <> '') then begin
      if grid.Cells[colBorder, ARow] = csTop then
        Borders:= [cbTop]
      else if grid.Cells[colBorder, ARow] = csBottom then
        Borders:= [cbBottom]
      else if grid.Cells[colBorder, ARow] = csTopBottom then
        Borders:= [cbBottom, cbTop]
    end;
  end;

end;

procedure TfrmReportProfit.gridGetCellColor(Sender: TObject; ARow,
  ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin
  case ARow of
    rowCompanyID:
    begin
      AFont.Size:= 12;
      AFont.Style:= [fsBold];
    end;

    rowReptID, rowPeriode:
    begin
      AFont.Size:= 10;
      AFont.Style:= [fsBold];
    end;
  end;
end;

procedure TfrmReportProfit.gridResize(Sender: TObject);
begin
  grid.ColWidths[colFooter]:= grid.Width - (95*5) - 40;
end;

procedure TfrmReportProfit.tbtPrintClick(Sender: TObject);
begin
  if MustRegister then exit;
  {if GlobalSystemConfig.localSetting.PrinterAdm <> '' then begin
     if (getDefaultPrinter <> GlobalSystemConfig.localSetting.PrinterAdm) then
         setDefaultPrinter(GlobalSystemConfig.localSetting.PrinterAdm);
  end;
   }
  try
    Application.CreateForm(TqrpReportProfit, qrpReportProfit);
    qrpReportProfit.Executes(grid);
  finally
    qrpReportProfit.Destroy;
  end;
  
end;

end.
