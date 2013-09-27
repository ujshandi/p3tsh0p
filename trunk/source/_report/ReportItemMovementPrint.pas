unit ReportItemMovementPrint;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, AdvGrid, strUtils;

type
  TqrpReportItemMovement = class(TQuickRep)
    TitleBand1: TQRBand;
    ColumnHeaderBand1: TQRBand;
    DetailBand1: TQRBand;
    PageFooterBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel7: TQRLabel;
    qrlCust: TQRLabel;
    qrlDisc: TQRLabel;
    qrlJual: TQRLabel;
    qrlTgl: TQRLabel;
    qrlCompanyName: TQRLabel;
    qrlCompanyAddress: TQRLabel;
    qrlCompanyContact: TQRLabel;
    qrlPeriode: TQRLabel;
    QRLabel17: TQRLabel;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    QRSysData1: TQRSysData;
    SummaryBand1: TQRBand;
    QRShape3: TQRShape;
    qrlReportDesc: TQRLabel;
    QRLabel4: TQRLabel;
    qrlUrut: TQRLabel;
    QRSysData2: TQRSysData;
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
  qrpReportItemMovement: TqrpReportItemMovement;

implementation

uses Subroutines;

const
  colNama   = 2;
  colVendor = 3;
  colProd   = 4;
  colQty    = 5;

{$R *.DFM}

{ TqrpReportPenjualan1 }

procedure TqrpReportItemMovement.Executes(AGrid: TAdvStringGrid);
begin
  Grid:= AGrid;
  qrlCompanyName.Caption   := CompanyProfile.FCompanyName;
  qrlCompanyAddress.Caption:= CompanyProfile.FAddress;
  qrlCompanyContact.Caption:= CompanyProfile.FTelp1;
  qrlPeriode.Caption:= CaptionPeriode(GlobalPeriode.OpPeriodeAwal1, GlobalPeriode.PeriodeAwal1, GlobalPeriode.PeriodeAkhir1);

  if GlobalFilter.StatusID = 2 then
    qrlReportDesc.Caption:= 'Barang Iddle'

  else if GlobalFilter.Numeric2 < 0 then
    qrlReportDesc.Caption:= IntToStrFmt(GlobalFilter.Numeric2) + ifthen(
                            GlobalFilter.StatusID = 0, 'Teratas', 'Terbawah')
  else qrlReportDesc.Caption:= '';

  i:= 1;
  PreviewModal;
end;

procedure TqrpReportItemMovement.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  i:= 1;
end;

procedure TqrpReportItemMovement.QuickRepNeedData(Sender: TObject;
  var MoreData: Boolean);
begin
  MoreData:= i < Grid.RowCount;
  if MoreData then begin
    qrlTgl.Caption:= '';
    qrlJual.Caption:= '';
    qrlDisc.Caption:= '';
    qrlCust.Caption:= '';
    qrlUrut.Caption:= '';
    qrlUrut.Caption:= IntToStrFmt(i);
    qrlTgl.Caption:= Grid.Cells[colNama, i];
    qrlJual.Caption:= Grid.Cells[colVendor, i];
    qrlDisc.Caption:= Grid.Cells[colProd, i];
    qrlCust.Caption:= Grid.Cells[colQty, i];
    Inc(i);
  end;
end;

end.
