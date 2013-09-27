unit ReportProfitPrint;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, AdvGrid;

type
  TqrpReportProfit = class(TQuickRep)
    TitleBand1: TQRBand;
    DetailBand1: TQRBand;
    PageFooterBand1: TQRBand;
    qrlHeader: TQRLabel;
    qrlFooter: TQRLabel;
    qrlValue2: TQRLabel;
    qrlValue3: TQRLabel;
    qrlValue1: TQRLabel;
    qrlCompanyName: TQRLabel;
    qrlPeriode: TQRLabel;
    QRLabel29: TQRLabel;
    QRSysData1: TQRSysData;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    garis: TQRShape;
    QRSysData2: TQRSysData;
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QuickRepNeedData(Sender: TObject; var MoreData: Boolean);
  private
    i: integer;
    Grid: TAdvStringGrid;
    procedure clearLabel;
  public
    procedure Executes(AGrid: TAdvStringGrid);

  end;

var
  qrpReportProfit: TqrpReportProfit;

implementation

uses Subroutines, BaseGrid;

const

  colHeader    = 1;
  colFooter    = 2;
  colValue1    = 3;
  colValue2    = 4;
  colValue3    = 5;
  colBorder    = 7;

{$R *.DFM}

{ TqrpReportProfit }

procedure TqrpReportProfit.clearLabel;
begin
  qrlHeader.Caption:= '';
  qrlFooter.Caption:= '';
  qrlValue2.Caption:= '';
  qrlValue3.Caption:= '';
  qrlValue1.Caption:= '';
  qrlValue3.Frame.DrawTop:= False;
  qrlValue3.Frame.DrawTop:= False;
  qrlValue3.Frame.DrawTop:= False;
end;

procedure TqrpReportProfit.Executes(AGrid: TAdvStringGrid);
begin
  Grid:= AGrid;
  qrlCompanyName.Caption   := CompanyProfile.FCompanyName;
  //qrlCompanyAddress.Caption:= CompanyProfile.FAddress;
  //qrlCompanyContact.Caption:= CompanyProfile.FTelp1;

  qrlPeriode.Caption:= CaptionPeriode(GlobalPeriode.OpPeriodeAwal1, GlobalPeriode.PeriodeAwal1, GlobalPeriode.PeriodeAkhir1);

  i:= 5;
  PreviewModal;
end;

procedure TqrpReportProfit.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  i:= 5;
   qrlValue3.Frame.DrawTop:= False;
    qrlValue3.Frame.DrawTop:= False;
    qrlValue3.Frame.DrawTop:= False;
end;

procedure TqrpReportProfit.QuickRepNeedData(Sender: TObject;
  var MoreData: Boolean);
begin
  MoreData:= i < Grid.RowCount;
  if MoreData then begin
    clearLabel;
    if Grid.IsMergedCell(colHeader, i) then
      qrlHeader.Caption:= Grid.Cells[colHeader, i]
    else qrlFooter.Caption:= Grid.Cells[colFooter, i];

    qrlValue1.Caption:= Grid.Cells[colValue1, i];
    qrlValue2.Caption:= Grid.Cells[colValue2, i];
    qrlValue3.Caption:= Grid.Cells[colValue3, i];

    qrlValue3.Frame.DrawTop:= False;
    qrlValue3.Frame.DrawTop:= False;
    qrlValue3.Frame.DrawTop:= False;

    if (Grid.Cells[colBorder, i] = 'T') and (trim(qrlValue3.Caption) <> '') then
      garis.Enabled := True
       //qrlValue3.Frame.DrawTop:= True
    else if (Grid.Cells[colBorder, i] = 'TB') and (trim(qrlValue3.Caption) <> '') then begin
      //qrlValue3.Frame.DrawTop:= True;
     // qrlValue3.Frame.DrawBottom:= True;
     garis.Enabled := True;
    end
    else garis.Enabled := False;

    Inc(i);
  end;
end;

end.
