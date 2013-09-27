unit trsPembayaranListPrint;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,strUtils,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, AdvGrid;

type
  TqrpPembayaranListPrint = class(TQuickRep)
    TitleBand1: TQRBand;
    ColumnHeaderBand1: TQRBand;
    DetailBand1: TQRBand;
    SummaryBand1: TQRBand;
    PageFooterBand1: TQRBand;
    qrlCompanyName: TQRLabel;
    qrlCompanyAddress: TQRLabel;
    qrlCompanyContact: TQRLabel;
    qrlPeriode: TQRLabel;
    qrlTitle: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    qrlHeadTipe: TQRLabel;
    QRLabel14: TQRLabel;
    QRShape2: TQRShape;
    QRShape3: TQRShape;
    QRShape4: TQRShape;
    QRShape5: TQRShape;
    QRShape9: TQRShape;
    QRShape11: TQRShape;
    QRShape12: TQRShape;
    QRShape16: TQRShape;
    QRShape17: TQRShape;
    QRShape18: TQRShape;
    QRShape19: TQRShape;
    qrlTotal: TQRLabel;
    qrlTgl: TQRLabel;
    qrlTrx: TQRLabel;
    qrlNo: TQRLabel;
    qrlSupplier: TQRLabel;
    qrlKeterangan: TQRLabel;
    QRShape22: TQRShape;
    QRSysData1: TQRSysData;
    QRShape1: TQRShape;
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
  qrpPembayaranListPrint: TqrpPembayaranListPrint;

implementation

uses Subroutines, BaseGrid, UConst;

const
  colNo    = 0;
  colID    = 1; //6

  colCust  = 2;  //transnum
  colTgl   = 3;
  colCode  = 4;
  colNama  = 5;
  colQty   = 6;
  colSat   = 7;
  colHrg   = 8;
  colTotal = 9;
  
{$R *.DFM}

{ TqrpReportJual }

procedure TqrpPembayaranListPrint.Executes(AGrid: TAdvStringGrid);
begin
  Grid:= AGrid;
  qrlCompanyName.Caption   := CompanyProfile.FCompanyName;
  qrlCompanyAddress.Caption:= CompanyProfile.FAddress;
  qrlCompanyContact.Caption:= CompanyProfile.FTelp1;

  qrlPeriode.Caption:= CaptionPeriode(GlobalPeriode.OpPeriodeAwal1, GlobalPeriode.PeriodeAwal1, GlobalPeriode.PeriodeAkhir1);
        Self.ReportTitle := 'Rekap Petty Cash';

  qrlTitle.Caption := Self.ReportTitle;
  i:= 1;
  PreviewModal;
end;

procedure TqrpPembayaranListPrint.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  i:= 1;
end;

procedure TqrpPembayaranListPrint.QuickRepNeedData(Sender: TObject;
  var MoreData: Boolean);
begin
  MoreData:= i < Grid.RowCount;
  if MoreData then begin
    qrlNo.Caption:= '';
    qrlTrx.Caption:= '';
    qrlTgl.Caption:= '';
    qrlSupplier.Caption:= '';
    qrlTotal.Caption:= '';
    qrlKeterangan.Caption:= '';


    qrlNo.Caption := Grid.Cells[0,i];
    qrlTrx.Caption:= Grid.Cells[2,i];
    qrlTgl.Caption:= Grid.Cells[3,i];
      qrlSupplier.Caption:= Grid.Cells[6,i];
      qrlTotal.Caption:= Grid.Cells[4,i];
      qrlKeterangan.Caption:= Grid.Cells[5,i];

    Inc(i);
  end;
end;

end.
