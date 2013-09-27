unit ReportSupplierSaldoPrint;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, AdvGrid, strUtils;

type
  TqrpReportSupplierSaldo = class(TQuickRep)
    TitleBand1: TQRBand;
    ColumnHeaderBand1: TQRBand;
    DetailBand1: TQRBand;
    SummaryBand1: TQRBand;
    PageFooterBand1: TQRBand;
    QRLabel5: TQRLabel;
    qrlHdrBeli: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel1: TQRLabel;
    qrlAkhir: TQRLabel;
    qrlAdjust: TQRLabel;
    qrlBayar: TQRLabel;
    qrlRetur: TQRLabel;
    qrlBeli: TQRLabel;
    qrlAwal: TQRLabel;
    qrlNama: TQRLabel;
    qrlNo: TQRLabel;
    QRShape1: TQRShape;
    lineFooter: TQRShape;
    QRShape2: TQRShape;
    QRSysData1: TQRSysData;
    qrlPeriode: TQRLabel;
    QRLabel17: TQRLabel;
    qrlCompanyContact: TQRLabel;
    qrlCompanyAddress: TQRLabel;
    qrlCompanyName: TQRLabel;
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
  qrpReportSupplierSaldo: TqrpReportSupplierSaldo;

implementation

uses Subroutines;

const
  colNo    = 0;
  colID    = 1; //6
  colNama  = 2;
  colAwal  = 3;
  colBeli  = 4;
  colRetur = 5;
  colBayar = 6;
  colAdjust= 7;
  colAKhir = 8;

{$R *.DFM}

{ TqrpReportSupplierSaldo }

procedure TqrpReportSupplierSaldo.Executes(AGrid: TAdvStringGrid);
begin
  Grid:= AGrid;
  qrlCompanyName.Caption   := CompanyProfile.FCompanyName;
  qrlCompanyAddress.Caption:= CompanyProfile.FAddress;
  qrlCompanyContact.Caption:= CompanyProfile.FTelp1;
  qrlPeriode.Caption:= CaptionPeriode(GlobalPeriode.OpPeriodeAwal1, GlobalPeriode.PeriodeAwal1, GlobalPeriode.PeriodeAkhir1);

  qrlHdrBeli.Caption:= Grid.Cells[colBeli, 0];
  i:= 1;
  PreviewModal;
end;

procedure TqrpReportSupplierSaldo.QuickRepBeforePrint(
  Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
  i:= 1;
end;

procedure TqrpReportSupplierSaldo.QuickRepNeedData(Sender: TObject;
  var MoreData: Boolean);
begin
  MoreData:= i < Grid.RowCount;
  if MoreData then begin
     qrlNo.Caption:= '';
     qrlNama.Caption:= '';
     qrlAwal.Caption:= '';
     qrlBeli.Caption:= '';
     qrlRetur.Caption:= '';
     qrlBayar.Caption:= '';
     qrlAdjust.Caption:= '';
     qrlAkhir.Caption:= '';

     qrlNama.Caption:= Grid.Cells[colNama, i];
     qrlAwal.Caption:= Grid.Cells[colAwal, i];
     qrlBeli.Caption:= Grid.Cells[colBeli, i];
     qrlRetur.Caption:= Grid.Cells[colRetur, i];
     qrlBayar.Caption:= Grid.Cells[colBayar, i];
     qrlAdjust.Caption:= Grid.Cells[colAdjust, i];
     qrlAkhir.Caption:= Grid.Cells[colAKhir, i];

     lineFooter.Enabled:= i = Grid.RowCount-1;

     Inc(i);
  end;
end;

end.
