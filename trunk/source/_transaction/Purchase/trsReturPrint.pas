unit trsReturPrint;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, AdvGrid, strUtils;

type
  TqrpRetur = class(TQuickRep)
    TitleBand1: TQRBand;
    ColumnHeaderBand1: TQRBand;
    DetailBand1: TQRBand;
    SummaryBand1: TQRBand;
    QRLabel1: TQRLabel;
    qrlCompanyName: TQRLabel;
    qrlCompanyCity: TQRLabel;
    qrlCompanyPhone: TQRLabel;
    qrlCompanyAddress: TQRLabel;
    QRLabel3: TQRLabel;
    qrlVcName: TQRLabel;
    qrlVcAddress: TQRLabel;
    QRShape1: TQRShape;
    txtNo: TQRLabel;
    txtBarcode: TQRLabel;
    txtDesc: TQRLabel;
    txtQty: TQRLabel;
    txtHrg: TQRLabel;
    txtDisc: TQRLabel;
    txtJumlah: TQRLabel;
    txtSubtotal: TQRLabel;
    txtDisc1: TQRLabel;
    txtTotal: TQRLabel;
    txtTax: TQRLabel;
    qrlTrxNumber: TQRLabel;
    QRShape2: TQRShape;
    QRLabel24: TQRLabel;
    QRLabel25: TQRLabel;
    QRLabel28: TQRLabel;
    QRLabel29: TQRLabel;
    QRLabel30: TQRLabel;
    QRLabel33: TQRLabel;
    qrlTrxDate: TQRLabel;
    QRShape3: TQRShape;
    QRLabel2: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel15: TQRLabel;
    QRLabel17: TQRLabel;
    QRLabel18: TQRLabel;
    QRLabel20: TQRLabel;
    QRLabel34: TQRLabel;
    PageFooterBand1: TQRBand;
    QRSysData1: TQRSysData;
    qrlFaktur: TQRLabel;
    QRLabel35: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel5: TQRLabel;
    txtPPN: TQRLabel;
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QuickRepNeedData(Sender: TObject; var MoreData: Boolean);
  private
    i: integer;
    grid: TAdvStringGrid;
    procedure ClearLabels;
    procedure SetHeaderFooter(ID: integer);
  public
    procedure Execute(ID: integer; grd: TAdvStringGrid); reintroduce;
  end;

var
  qrpRetur: TqrpRetur;

implementation

uses Subroutines, uMysqlClient, MySQLConnector;

{$R *.DFM}

{ TqrpPurchaseOrder }

procedure TqrpRetur.ClearLabels;
begin
  txtNo.Caption:= '';
  txtBarcode.Caption:= '';
  txtDesc.Caption   := '';
  txtQty.Caption    := '';
  txtHrg.Caption    := '';
  txtDisc.Caption   := '';
  txtJumlah.Caption := '';
  qrlFaktur.Caption := '';
  txtPPN.Caption := '';
end;

procedure TqrpRetur.Execute(ID: integer; grd: TAdvStringGrid);
begin
  grid:= grd;
  qrlCompanyName.Caption   := CompanyProfile.FCompanyName;
  qrlCompanyAddress.Caption:= CompanyProfile.FAddress;
  qrlCompanyPhone.Caption  := CompanyProfile.FTelp1 + IfThen(CompanyProfile.FFax <> '', '/'+CompanyProfile.FFax);
  qrlCompanyCity.Caption   := IfThen(CompanyProfile.FBranch <> '', ''+CompanyProfile.FBranch + ' - ' +CompanyProfile.FCity);
  ClearLabels;
  SetHeaderFooter(ID);
  Self.Print;
end;

procedure TqrpRetur.SetHeaderFooter(ID: integer);
var trx: TMysqlResult;
begin

  qrlTrxNumber.Caption:= '';
  qrlTrxDate.Caption  := CompanyProfile.FCity + ', .... ';

  txtSubtotal.Caption:= '';
  txtDisc1.Caption   := '';
  txtTax.Caption     := '';
  txtTotal.Caption   := '';
  qrlVcName.Caption  := '';
  qrlVcAddress.Caption:= '';

  trx:= OpenSQL(
  'select t.trans_num, t.trans_date, t.subtotal, t.discount, '+
  't.tax, t.total, r.relation_name, r.address1, r.city '+
  'from trs_retur_mst t left join mst_relation r on t.relation_id =  r.relation_id '+
  'where retur_id = '+IntToStr(ID));
  if trx.RecordCount > 0 then begin
    qrlTrxNumber.Caption:= trx.FieldValue(0);
    qrlTrxDate.Caption  := CompanyProfile.FCity + ', '+FormatDateTime('dd, MMMM yyyy', BufferToDateTime(trx.FieldValue(1)));

    txtSubtotal.Caption:= FloatToStrFmt(BufferToFloat(trx.FieldValue(2)));
    txtDisc1.Caption   := FloatToStrFmt(BufferToFloat(trx.FieldValue(3)));
    txtTax.Caption     := FloatToStrFmt(BufferToFloat(trx.FieldValue(4)));
    txtTotal.Caption   := FloatToStrFmt(BufferToFloat(trx.FieldValue(5)));
    qrlVcName.Caption  := trx.FieldValue(6);
    if BufferToString(trx.FieldValue(7)) <> '' then
      qrlVcAddress.Caption:= trx.FieldValue(7) + #13#10 + trx.FieldValue(8)
    else
    qrlVcAddress.Caption:= trx.FieldValue(8);

  end;
  trx.destroy;
end;

procedure TqrpRetur.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  i:= 1;
end;

procedure TqrpRetur.QuickRepNeedData(Sender: TObject;
  var MoreData: Boolean);
begin
  MoreData:= i < grid.RowCount;
  if MoreData then begin
    ClearLabels;
    txtNo.Caption:= IntToStr(i);
    qrlFaktur.Caption := grid.Cells[1,i];
    txtBarcode.Caption:= grid.Cells[2,i];
    txtDesc.Caption   := grid.Cells[3,i];
    txtQty.Caption    := grid.Cells[4,i] + ' ' + grid.Cells[5,i];
    txtHrg.Caption    := grid.Cells[6,i];
    txtJumlah.Caption := grid.Cells[7,i];
    txtDisc.Caption   := grid.Cells[8,i];
    txtPPN.Caption    := grid.Cells[9,i];

    Inc(i);
  end;
end;

end.
