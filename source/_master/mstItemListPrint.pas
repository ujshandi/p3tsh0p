unit mstItemListPrint;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, AdvGrid, strUtils;

type
  TqrpItemList = class(TQuickRep)
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
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    DetailBand1: TQRBand;
    qrlBarcode: TQRLabel;
    qrlCode: TQRLabel;
    QRShape4: TQRShape;
    QRSysData2: TQRSysData;
    QRSysData1: TQRSysData;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    qrlJenis: TQRLabel;
    qrlMerk: TQRLabel;
    qrlStok: TQRLabel;
    qrlNo: TQRLabel;
    qrlDesc: TQRLabel;
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
  qrpItemList: TqrpItemList;

implementation

uses Subroutines, UMaster, BaseGrid;

const
    colNo      = 0;
  colId      = 1;
  colCode    = 2;
  colBarcode = 3;
  colJenis = 4;
  colName    = 5;
  colMerk = 6;
  colStruk = 7;
  colSatuan = 8;
  colStok    = 9 ;



{$R *.DFM}

{ TqrpItemList }

procedure TqrpItemList.Executes(AGrid: TAdvStringGrid);
var spc, vendor: string;
begin
  Grid:= AGrid;
  qrlCompanyName.Caption   := CompanyProfile.FCompanyName;
  qrlCompanyAddress.Caption:= CompanyProfile.FAddress;
  qrlCompanyContact.Caption:= CompanyProfile.FTelp1;

  spc:= TMstCode.getName(GlobalFilter.SpecID);
  vendor:= TMstRelation.GetName(GlobalFilter.RelasiID);

  qrlPeriode.Caption:= spc + IfThen(vendor<> '', ' - ' + vendor);

  i:= 1;
  Prepare;
  PreviewModal;
end;

procedure TqrpItemList.QuickRepNeedData(Sender: TObject;
  var MoreData: Boolean);
begin
  MoreData:= i < Grid.RowCount;
  if MoreData then begin
     qrlBarcode.Caption:= ''; qrlCode.Caption:= '';   qrlJenis.Caption:= '';
     qrlMerk.Caption:= '';
     qrlStok.Caption:= '';  
     qrlNo.Caption:= '';
   //  QRRichText1.Lines.Clear;
    // QRRichText1.Lines.Text:= Grid.Cells[colName, i];
     qrlBarcode.Caption:= Grid.Cells[colBarcode, i];
     qrlNo.Caption :=  IntToStrFmt(i);
     qrlCode.Caption := Grid.Cells[colCode, i];
     qrlJenis.Caption := Grid.Cells[colJenis, i];
     qrlMerk.Caption := Grid.Cells[colmerk, i];
     qrlStok.Caption := Grid.Cells[colStok,i];

    qrlDesc.Caption := TrimAll(Grid.Cells[colName, i]);
{     qrlBeli.Caption := Grid.Cells[colHBeli, i];
     qrlDasar.Caption:= Grid.Cells[colHDasar, i];
     qrlJual.Caption := Grid.Cells[colHJual1, i];
     qrlJual.Caption := Grid.Cells[colHJual2, i];
     qrlStok.Caption := Grid.Cells[colStok, i];}
     Inc(i);
  end
end;

procedure TqrpItemList.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  i:= 1;
end;

end.
