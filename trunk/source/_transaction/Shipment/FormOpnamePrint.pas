unit FormOpnamePrint;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, AdvGrid, strUtils;

type
  TqrpFormOpname = class(TQuickRep)
    PageHeaderBand1: TQRBand;
    ColumnHeaderBand1: TQRBand;
    DetailBand1: TQRBand;
    PageFooterBand1: TQRBand;
    qrlCompanyName: TQRLabel;
    qrlCompanyAddress: TQRLabel;
    qrlCompanyContact: TQRLabel;
    QRLabel17: TQRLabel;
    qrlReportDesc: TQRLabel;
    txtUnitOnhand: TQRLabel;
    txtRataAktual: TQRLabel;
    txtQtyAktual: TQRLabel;
    txtOnhand: TQRLabel;
    txtNo: TQRLabel;
    txtNama: TQRLabel;
    txtCode: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel1: TQRLabel;
    QRSysData1: TQRSysData;
    txtBeliAktual: TQRLabel;
    QRLabel9: TQRLabel;
    QRShape1: TQRShape;
    QRSysData2: TQRSysData;
    QRLabel6: TQRLabel;
    qrlJumlah: TQRLabel;
    SummaryBand1: TQRBand;
    qrlGrandTotal: TQRLabel;
    QRLabel10: TQRLabel;
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QuickRepNeedData(Sender: TObject; var MoreData: Boolean);
    procedure qrlGrandTotalPrint(sender: TObject; var Value: String);
  private
    i: integer; grandTotal:double;
    Grid: TAdvStringGrid;
  public
    procedure Executes(AGrid: TAdvStringGrid);

  end;

var
  qrpFormOpname: TqrpFormOpname;

implementation

uses Subroutines, MySQLConnector;

const
  colNo     = 0;
  colCode   = 1;
  colBarcode   = 2;
  colName   = 3;
  colMerk   = 4;
  colUnit   = 5;
  colStok   = 6;
  colQty    = 7; //colReal
  colRange  = 8;  //selisih


  colMarkup = 9;   //harga beli dalam opname
  colSale   =10;
  colRangeHide  = 11;  //selisih
  colAmount = 12;
  colItemId = 13;
  colModId  = 14;
  colId     = 15;


{$R *.DFM}

{ TqrpFormOpname }

procedure TqrpFormOpname.Executes(AGrid: TAdvStringGrid);
begin
  Grid:= AGrid;
  qrlCompanyName.Caption   := CompanyProfile.FCompanyName;
  qrlCompanyAddress.Caption:= CompanyProfile.FAddress + ' ' + CompanyProfile.FCity;
  qrlCompanyContact.Caption:= CompanyProfile.FTelp1;
  qrlReportDesc.Caption:= CaptionPeriode(GlobalPeriode.OpPeriodeAwal1, GlobalPeriode.PeriodeAwal1, GlobalPeriode.PeriodeAkhir1);

  i:= 1;  grandTotal := 0;
  PreviewModal;
end;

procedure TqrpFormOpname.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  i:= 1;  grandTotal := 0;
end;

procedure TqrpFormOpname.QuickRepNeedData(Sender: TObject;
  var MoreData: Boolean);
begin
  MoreData:= i < Grid.RowCount;
  if MoreData then begin
    txtUnitOnhand.Caption:= '';
    txtRataAktual.Caption:= '';
    txtQtyAktual.Caption:= '';
    txtOnhand.Caption:= '';
    txtNo.Caption:= '';
    txtNama.Caption:= '';
    txtCode.Caption:= '';
    qrlJumlah.Caption := '';

    if (Grid.Ints[colItemId, i] <> 0) then begin
     // txtRataAktual.Caption:= '_ _ _ _';
   //   txtQtyAktual.Caption := '_ _ _ _';
    //  txtBeliAktual.Caption:= '_ _ _ _';

      txtRataAktual.Caption:= Grid.Cells[colRange, i];
      txtQtyAktual.Caption :=  Grid.Cells[colQty, i];
      txtBeliAktual.Caption:=  Grid.Cells[colMarkup, i];
      txtUnitOnhand.Caption:= Grid.Cells[colUnit, i];
      txtOnhand.Caption    := Grid.Cells[colMerk, i];
      txtNo.Caption        := Grid.Cells[colNo, i];
      txtNama.Caption      := Grid.Cells[colName, i];
      txtCode.Caption      := Grid.Cells[colBarCode, i];
      qrlJumlah.Caption      := Grid.Cells[colAmount, i];
      grandTotal := grandTotal + StrFmtToFloat(Grid.Cells[colAmount, i]);
      txtCode.Font.Style:= [];
    end
    else begin
      txtCode.Font.Style:= [fsBold];
      txtCode.Caption:= Grid.Cells[colCode, i];
    end;

    Inc(i);
  end;
end;

procedure TqrpFormOpname.qrlGrandTotalPrint(sender: TObject;
  var Value: String);
begin
    Value := FloatToStrFmt(grandTotal);
end;

end.
