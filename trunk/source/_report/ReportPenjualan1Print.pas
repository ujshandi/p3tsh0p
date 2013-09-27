unit ReportPenjualan1Print;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, AdvGrid;

type
  TqrpReportPenjualan1 = class(TQuickRep)
    TitleBand1: TQRBand;
    ColumnHeaderBand1: TQRBand;
    DetailBand1: TQRBand;
    PageFooterBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    qrlCust: TQRLabel;
    qrlProfit: TQRLabel;
    qrlNet: TQRLabel;
    qrlDisc: TQRLabel;
    qrlBarangPokok: TQRLabel;
    qrlTgl: TQRLabel;
    qrlCompanyName: TQRLabel;
    qrlCompanyAddress: TQRLabel;
    qrlCompanyContact: TQRLabel;
    qrlPeriode: TQRLabel;
    QRLabel17: TQRLabel;
    shpDetail: TQRShape;
    QRSysData1: TQRSysData;
    SummaryBand1: TQRBand;
    QRShape3: TQRShape;
    QRSysData2: TQRSysData;
    qrlBarang: TQRLabel;
    qrlBarangProfit: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    qrlCaraBayar: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel12: TQRLabel;
    Pokok: TQRLabel;
    Jual: TQRLabel;
    QRLabel16: TQRLabel;
    qrlHewanPokok: TQRLabel;
    qrlHewan: TQRLabel;
    qrlHewanProfit: TQRLabel;
    qrlJasa: TQRLabel;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    QRShape4: TQRShape;
    QRShape5: TQRShape;
    QRShape6: TQRShape;
    QRShape7: TQRShape;
    QRShape8: TQRShape;
    QRShape9: TQRShape;
    QRShape10: TQRShape;
    QRShape11: TQRShape;
    QRShape12: TQRShape;
    QRShape13: TQRShape;
    QRShape14: TQRShape;
    QRShape15: TQRShape;
    QRShape16: TQRShape;
    QRShape17: TQRShape;
    QRShape18: TQRShape;
    QRShape19: TQRShape;
    QRShape20: TQRShape;
    QRShape21: TQRShape;
    QRShape22: TQRShape;
    QRShape23: TQRShape;
    QRShape24: TQRShape;
    QRShape25: TQRShape;
    QRShape26: TQRShape;
    QRShape27: TQRShape;
    QRShape28: TQRShape;
    QRShape29: TQRShape;
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QuickRepNeedData(Sender: TObject; var MoreData: Boolean);
  private
    i: integer;
    Grid: TAdvStringGrid;
  public
    procedure Executes(AGrid: TAdvStringGrid);
  end;

var
  qrpReportPenjualan1: TqrpReportPenjualan1;

implementation

uses Subroutines;

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
{$R *.DFM}

{ TqrpReportPenjualan1 }

procedure TqrpReportPenjualan1.Executes(AGrid: TAdvStringGrid);
begin
  Grid:= AGrid;
  qrlCompanyName.Caption   := CompanyProfile.FCompanyName;
  qrlCompanyAddress.Caption:= CompanyProfile.FAddress;
  qrlCompanyContact.Caption:= CompanyProfile.FTelp1;
  qrlPeriode.Caption:= CaptionPeriode(GlobalPeriode.OpPeriodeAwal1, GlobalPeriode.PeriodeAwal1, GlobalPeriode.PeriodeAkhir1);

  i:= 3;
  PreviewModal;
end;

procedure TqrpReportPenjualan1.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  i:= 3;
end;

procedure TqrpReportPenjualan1.QuickRepNeedData(Sender: TObject;
  var MoreData: Boolean);
begin
  MoreData:= i < Grid.RowCount;
  if MoreData then begin
    shpDetail.Enabled:= (i = Grid.RowCount-1);
    qrlTgl.Caption:= '';
    qrlBarangPokok.Caption:= '';
    qrlBarang.Caption:= '';
    qrlBarangProfit.Caption:= '';
    qrlHewanPokok.Caption:= '';
    qrlHewan.Caption:= '';
    qrlHewanProfit.Caption:= '';
    qrlDisc.Caption:= '';
    qrlNet.Caption:= '';
    qrlProfit.Caption:= '';
    qrlCust.Caption:= '';
    qrlJasa.Caption := '';
    qrlHewan.Caption := '';
    qrlCaraBayar.Caption := '';

    qrlTgl.Caption:= Grid.Cells[colTgl, i];
    qrlBarang.Caption:= Grid.Cells[colJualBarang, i];
    qrlBarangPokok.Caption:= Grid.Cells[colJualBarangPokok, i];
    qrlBarangProfit.Caption:= Grid.Cells[colJualBarangProfit, i];
    qrlHewanPokok.Caption:= Grid.Cells[colJualHewanPokok, i];
    qrlHewan.Caption:= Grid.Cells[colJualHewan, i];
    qrlHewanProfit.Caption:= Grid.Cells[colJualHewanProfit, i];
    qrlDisc.Caption:= Grid.Cells[colDisc, i];
    qrlNet.Caption:= Grid.Cells[colNet, i];
    qrlProfit.Caption:= Grid.Cells[colProfit, i];
    qrlCust.Caption:= Grid.Cells[colCust, i];
    qrlCaraBayar.Caption:= Grid.Cells[colCaraBayar, i];
    qrlHewan.Caption:= Grid.Cells[colJualHewan, i];
    qrlJasa.Caption:= Grid.Cells[colJualJasa, i];
    Inc(i);
  end;
end;

end.
