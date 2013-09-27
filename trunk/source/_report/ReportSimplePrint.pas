unit ReportSimplePrint;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, AdvGrid;

type
  TqrpReportSimple = class(TQuickRep)
    TitleBand1: TQRBand;
    ColumnHeaderBand1: TQRBand;
    DetailBand1: TQRBand;
    SummaryBand1: TQRBand;
    PageFooterBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRShape1: TQRShape;
    qrlDesMst: TQRLabel;
    qrlDesDetail: TQRLabel;
    qrlValueMst: TQRLabel;
    qrlValueDetail: TQRLabel;
    qrlUnit: TQRLabel;
    qrlCompanyName: TQRLabel;
    qrlCompanyAddress: TQRLabel;
    qrlCompanyContact: TQRLabel;
    QRLabel3: TQRLabel;
    qrlPeriode: TQRLabel;
    QRShape3: TQRShape;
    QRSysData2: TQRSysData;
    QRSysData1: TQRSysData;
    QRShape4: TQRShape;
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
  qrpReportSimple: TqrpReportSimple;

implementation

uses Subroutines, j_idol;

const
  colDescMst  = 1;
  colDescDtl  = 2;
  colValueDtl = 3;
  colValueMst = 4;
  colUnit     = 4;

{$R *.DFM}

{ TqrpReportSimple }

procedure TqrpReportSimple.Executes(AGrid: TAdvStringGrid);
begin
  Grid:= AGrid;
  qrlCompanyName.Caption   := CompanyProfile.FCompanyName;
  qrlCompanyAddress.Caption:= CompanyProfile.FAddress;
  qrlCompanyContact.Caption:= CompanyProfile.FTelp1;
  qrlPeriode.Caption:= CaptionPeriode(GlobalPeriode.OpPeriodeAwal1, GlobalPeriode.PeriodeAwal1, GlobalPeriode.PeriodeAkhir1);
  i:= 1;
  PreviewModal;
end;

procedure TqrpReportSimple.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  i:= 1;
end;

procedure TqrpReportSimple.QuickRepNeedData(Sender: TObject;
  var MoreData: Boolean);
begin
  MoreData:= i < Grid.RowCount;
  if MoreData then begin
     qrlDesMst.Caption:= ''; qrlDesDetail.Caption:= ''; qrlValueMst.Caption:= '';
     qrlValueDetail.Caption:= ''; qrlUnit.Caption:= '';

     if (Grid.Cells[colDescMst, i] <> '') and (Grid.IsMergedCell(colDescMst, i)) then
       qrlDesMst.Caption:= Grid.Cells[colDescMst, i]
     else
       qrlDesDetail.Caption:= Grid.Cells[colDescDtl, i];


     if (Grid.Cells[colValueMst, i] <> '') and (Grid.IsMergedCell(colValueMst, i)) then
       qrlValueMst.Caption:= Grid.Cells[colValueMst, i]
     else begin
       qrlValueDetail.Caption:= Grid.Cells[colValueDtl, i];
       qrlUnit.Caption:= Grid.Cells[colValueMst, i];
     end;
    Inc(i);
  end
end;

end.
