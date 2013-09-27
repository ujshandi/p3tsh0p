unit RepotItemStokPrint;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, AdvGrid, strUtils;

type
  TqrpRepotItemStok = class(TQuickRep)
    TitleBand1: TQRBand;
    ColumnHeaderBand1: TQRBand;
    PageFooterBand1: TQRBand;
    QRLabel3: TQRLabel;
    qrlPeriode: TQRLabel;
    qrlCompanyName: TQRLabel;
    qrlCompanyAddress: TQRLabel;
    qrlCompanyContact: TQRLabel;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel5: TQRLabel;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    DetailBand1: TQRBand;
    qrlBarcode: TQRLabel;
    qrlDesc: TQRLabel;
    QRShape4: TQRShape;
    QRSysData2: TQRSysData;
    QRSysData1: TQRSysData;
    QRSysData3: TQRSysData;
    QRLabel6: TQRLabel;
    qrlOnhand: TQRLabel;
    qrlFilter: TQRLabel;
    QRLabel4: TQRLabel;
    qrlMerk: TQRLabel;
    QRShape3: TQRShape;
    procedure QuickRepNeedData(Sender: TObject; var MoreData: Boolean);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    i: integer;
    Grid: TAdvStringGrid;
  public
    procedure Executes(AGrid: TAdvStringGrid);
  public

  end;

var
  qrpRepotItemStok: TqrpRepotItemStok;

implementation

uses Subroutines, UMaster;

const
 colNo = 0;
  colID = 1; //6
  colCode =2;
  colNama     = 3;
  colUnit     = 4;
  colAwal     = 5;

{$R *.DFM}

{ TqrpItemList }

procedure TqrpRepotItemStok.Executes(AGrid: TAdvStringGrid);
var spc, vendor, gudang: string;
begin
  Grid:= AGrid;
  qrlCompanyName.Caption   := CompanyProfile.FCompanyName;
  qrlCompanyAddress.Caption:= CompanyProfile.FAddress;
  qrlCompanyContact.Caption:= CompanyProfile.FTelp1;

  spc:= TMstCode.getName(GlobalFilter.SpecID);
  vendor:= TMstRelation.GetName(GlobalFilter.RelasiID);
  gudang:= TMstMaster.getName(GlobalFilter.RelasiID);

  qrlFilter.Caption:= spc +
   IfThen(vendor<> '', ' - ' + vendor) + IfThen(gudang <> '', ' - ' + gudang);
  qrlPeriode.Caption:= CaptionPeriode(GlobalPeriode.OpPeriodeAwal1, GlobalPeriode.PeriodeAwal1, GlobalPeriode.PeriodeAkhir1);
  i:= 1;
  PreviewModal;
end;

procedure TqrpRepotItemStok.QuickRepNeedData(Sender: TObject;
  var MoreData: Boolean);
begin
  MoreData:= i < Grid.RowCount;
  if MoreData then begin
     qrlBarcode.Caption:= ''; qrlOnhand.Caption:= ''; qrlDesc.Caption:= '';

     qrlBarcode.Caption:= Grid.Cells[colCode, i];
     qrlDesc.Caption:= Grid.Cells[colNama, i];
     qrlMerk.Caption:= Grid.Cells[colUnit, i];
     qrlOnhand.Caption:= Grid.Cells[colUnit+1, i];
     Inc(i);
  end;
end;

procedure TqrpRepotItemStok.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  i:= 1;
end;

end.
