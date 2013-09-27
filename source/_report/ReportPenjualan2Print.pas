unit ReportPenjualan2Print;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, AdvGrid;

type
  TqrpReportPenjualan2 = class(TQuickRep)
    TitleBand1: TQRBand;
    ColumnHeaderBand1: TQRBand;
    DetailBand1: TQRBand;
    PageFooterBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel6: TQRLabel;
    qrlSubtotal: TQRLabel;
    qrlDisc: TQRLabel;
    qrlQty: TQRLabel;
    qrlHarga: TQRLabel;
    qrlNama: TQRLabel;
    qrlKode: TQRLabel;
    qrlCompanyName: TQRLabel;
    qrlCompanyAddress: TQRLabel;
    qrlCompanyContact: TQRLabel;
    qrlPeriode: TQRLabel;
    QRLabel17: TQRLabel;
    shpDetail: TQRShape;
    QRSysData1: TQRSysData;
    SummaryBand1: TQRBand;
    QRShape3: TQRShape;
    QRLabel5: TQRLabel;
    QRLabel8: TQRLabel;
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
  qrpReportPenjualan2: TqrpReportPenjualan2;

implementation

uses Subroutines;

const
  colCode    = 1;
  colStuk    = 2;
  colHarga   = 3;
  colQty     = 4;
  colDiscPrc = 5;
  colDiscRp  = 6;
  colSubtotal= 7;
  colRowID   = 8;
{$R *.DFM}

{ TqrpReportPenjualan1 }

procedure TqrpReportPenjualan2.Executes(AGrid: TAdvStringGrid);
begin
  Grid:= AGrid;
  qrlCompanyName.Caption   := CompanyProfile.FCompanyName;
  qrlCompanyAddress.Caption:= CompanyProfile.FAddress;
  qrlCompanyContact.Caption:= CompanyProfile.FTelp1;
  qrlPeriode.Caption:= CaptionPeriode(GlobalPeriode.OpPeriodeAwal1, GlobalPeriode.PeriodeAwal1, GlobalPeriode.PeriodeAkhir1);

  i:= 1;
  PreviewModal;
end;

procedure TqrpReportPenjualan2.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  i:= 1;
end;

procedure TqrpReportPenjualan2.QuickRepNeedData(Sender: TObject;
  var MoreData: Boolean);
begin
  MoreData:= i < Grid.RowCount;
  if MoreData then begin
    shpDetail.Enabled:= (i = Grid.RowCount-1);
    qrlKode.Caption:= '';
    qrlNama.Caption:= '';
    qrlHarga.Caption:= '';
    qrlQty.Caption:= '';
    qrlDisc.Caption:= '';
    qrlSubtotal.Caption:= '';

    qrlKode.Caption:= Grid.Cells[colCode, i];

    if not Grid.IsMergedCell(colCode,i) then begin
      qrlNama.Caption:= Grid.Cells[colStuk, i];
      qrlKode.font.Style := [];
      qrlSubtotal.font.Style := [];
    end
    else begin
        qrlKode.font.Style := [fsBold];
        qrlSubtotal.font.Style := [fsBold];
    end;
    qrlHarga.Caption:= Grid.Cells[colHarga, i];
    qrlQty.Caption:= Grid.Cells[colQty, i];
    qrlDisc.Caption:= Grid.Cells[colDiscRp, i];
    qrlSubtotal.Caption:= Grid.Cells[colSubtotal, i];
    Inc(i);
  end;
end;

end.
