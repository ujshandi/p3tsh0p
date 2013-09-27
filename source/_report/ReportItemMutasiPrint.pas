unit ReportItemMutasiPrint;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, AdvGrid;

type
  TqrpReportItemMutasi = class(TQuickRep)
    TitleBand1: TQRBand;
    ColumnHeaderBand1: TQRBand;
    DetailBand1: TQRBand;
    SummaryBand1: TQRBand;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel15: TQRLabel;
    QRLabel16: TQRLabel;
    QRLabel17: TQRLabel;
    QRLabel18: TQRLabel;
    QRLabel19: TQRLabel;
    QRLabel20: TQRLabel;
    QRLabel21: TQRLabel;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    QRShape3: TQRShape;
    QRShape4: TQRShape;
    QRShape5: TQRShape;
    QRShape6: TQRShape;
    QRShape7: TQRShape;
    QRShape8: TQRShape;
    QRShape9: TQRShape;
    QRShape10: TQRShape;
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
    qrlNo: TQRLabel;
    qrlMutasi: TQRLabel;
    qrlRet: TQRLabel;
    qrlAkhir: TQRLabel;
    qrlSaldo: TQRLabel;
    qrlOpname: TQRLabel;
    qrlMutasiCr: TQRLabel;
    qrlRetCr: TQRLabel;
    qrlJual: TQRLabel;
    qrlBeli: TQRLabel;
    qrlDesc: TQRLabel;
    qrlCode: TQRLabel;
    QRShape26: TQRShape;
    QRShape28: TQRShape;
    PageFooterBand1: TQRBand;
    QRSysData1: TQRSysData;
    qrlPeriode: TQRLabel;
    QRLabel29: TQRLabel;
    qrlCompanyContact: TQRLabel;
    qrlCompanyAddress: TQRLabel;
    qrlCompanyName: TQRLabel;
    QRLabel1: TQRLabel;
    qrlPakai: TQRLabel;
    QRShape11: TQRShape;
    QRShape27: TQRShape;
    QRShape29: TQRShape;
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
  qrpReportItemMutasi: TqrpReportItemMutasi;

implementation

uses Subroutines;

const
 colNo = 0;
  colID = 1; //6
  colCode =2;
  colNama     = 3;
  colUnit     = 4;
  colAwal     = 5;
  colBeli     = 6;
  colReturDr  = 7;
  colMutasiDr = 8;
  colPakai    = 9;
  colJual     =10;
  colReturCr  = 12;
  colMutasiCr = 13;
  colOpname   = 14;
  colAkhir    = 15;
  
{$R *.DFM}

{ TqrpReportItemMutasi }

procedure TqrpReportItemMutasi.Executes(AGrid: TAdvStringGrid);
begin
  Grid:= AGrid;
  qrlCompanyName.Caption   := CompanyProfile.FCompanyName;
  qrlCompanyAddress.Caption:= CompanyProfile.FAddress;
  qrlCompanyContact.Caption:= CompanyProfile.FTelp1;

  qrlPeriode.Caption:= CaptionPeriode(GlobalPeriode.OpPeriodeAwal1, GlobalPeriode.PeriodeAwal1, GlobalPeriode.PeriodeAkhir1);

  i:= 2;
  PreviewModal;
end;

procedure TqrpReportItemMutasi.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  I:= 2;
end;

procedure TqrpReportItemMutasi.QuickRepNeedData(Sender: TObject;
  var MoreData: Boolean);
begin
  MoreData:= i<Grid.RowCount;
  if MoreData then begin
    qrlNo.Caption:= '';
    qrlCode.Caption:= '';
    qrlDesc.Caption:= '';
    qrlSaldo.Caption:= '';
    qrlBeli.Caption:= '';
    qrlRet.Caption:= '';
    qrlMutasi.Caption:= '';
    qrlPakai.Caption:= '';
    qrlJual.Caption:= '';
    qrlRetCr.Caption:= '';
    qrlMutasiCr.Caption:= '';
    qrlOpname.Caption:= '';
    qrlAkhir.Caption:= '';
                                    
    qrlNo.Caption:= Grid.Cells[colNo,i];
    qrlCode.Caption:= Grid.Cells[colCode,i];
    qrlDesc.Caption:= Grid.Cells[colNama,i];
    qrlSaldo.Caption:= Grid.Cells[colAwal,i];
    qrlBeli.Caption:= Grid.Cells[colBeli,i];
    qrlRet.Caption:= Grid.Cells[colReturDr,i];
    qrlMutasi.Caption:= Grid.Cells[colMutasiDr,i];
    qrlPakai.Caption:= Grid.Cells[colPakai,i];
    qrlJual.Caption:= Grid.Cells[colJual,i];
    qrlRetCr.Caption:= Grid.Cells[colReturCr,i];
    qrlMutasiCr.Caption:= Grid.Cells[colMutasiCr,i];
    qrlOpname.Caption:= Grid.Cells[colOpname,i];
    qrlAkhir.Caption:= Grid.Cells[colAkhir,i];

    Inc(i);
  end;
end;

end.
