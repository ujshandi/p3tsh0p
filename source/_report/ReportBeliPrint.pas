unit ReportBeliPrint;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, AdvGrid;

type
  TqrpReportBeli = class(TQuickRep)
    TitleBand1: TQRBand;
    ColumnHeaderBand1: TQRBand;
    DetailBand1: TQRBand;
    SummaryBand1: TQRBand;
    PageFooterBand1: TQRBand;
    qrlCompanyName: TQRLabel;
    qrlCompanyAddress: TQRLabel;
    qrlCompanyContact: TQRLabel;
    qrlPeriode: TQRLabel;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel15: TQRLabel;
    QRShape2: TQRShape;
    QRShape3: TQRShape;
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
    qrlDisc: TQRLabel;
    qrlJumlah: TQRLabel;
    qrlSat: TQRLabel;
    qrlDesc: TQRLabel;
    qrlNo: TQRLabel;
    qrlNilai: TQRLabel;
    qrlQty: TQRLabel;
    qrlQtyRetur: TQRLabel;
    qrlNilaiRetur: TQRLabel;
    QRShape20: TQRShape;
    QRShape22: TQRShape;
    QRSysData1: TQRSysData;
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
  qrpReportBeli: TqrpReportBeli;

implementation

uses Subroutines;

{$R *.DFM}

{ TqrpReportJual }

procedure TqrpReportBeli.Executes(AGrid: TAdvStringGrid);
begin
  Grid:= AGrid;
  qrlCompanyName.Caption   := CompanyProfile.FCompanyName;
  qrlCompanyAddress.Caption:= CompanyProfile.FAddress;
  qrlCompanyContact.Caption:= CompanyProfile.FTelp1;

  qrlPeriode.Caption:= CaptionPeriode(GlobalPeriode.OpPeriodeAwal1, GlobalPeriode.PeriodeAwal1, GlobalPeriode.PeriodeAkhir1);

  i:= 2;
  PreviewModal;
end;

procedure TqrpReportBeli.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  i:= 2;
end;

procedure TqrpReportBeli.QuickRepNeedData(Sender: TObject;
  var MoreData: Boolean);
begin
  MoreData:= i < Grid.RowCount;
  if MoreData then begin
    qrlNo.Caption:= '';
    qrlDesc.Caption:= '';
    qrlSat.Caption:= '';
    qrlQty.Caption:= '';
    qrlNilai.Caption:= '';
    qrlJumlah.Caption:= '';
    qrlDisc.Caption:= '';
    qrlQtyRetur.Caption:= '';
    qrlNilaiRetur.Caption:= '';

    qrlDesc.Caption:= Grid.Cells[2,i];
    qrlSat.Caption:= Grid.Cells[3,i];
    qrlQty.Caption:= Grid.Cells[4,i];
    qrlNilai.Caption:= Grid.Cells[5,i];
    qrlDisc.Caption:= Grid.Cells[6,i];
    qrlJumlah.Caption:= Grid.Cells[7,i];

    qrlQtyRetur.Caption:= Grid.Cells[8,i];
    qrlNilaiRetur.Caption:= Grid.Cells[9,i];
    
    Inc(i);
  end;
end;

end.
