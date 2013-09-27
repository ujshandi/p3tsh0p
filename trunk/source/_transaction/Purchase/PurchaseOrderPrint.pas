unit PurchaseOrderPrint;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, AdvGrid, strUtils;

type
  TqrpPurchaseOrder = class(TQuickRep)
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
    QRLabel6: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
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
    txtDisc2: TQRLabel;
    txtTotal: TQRLabel;
    txtTax: TQRLabel;
    qrlTrxNumber: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel16: TQRLabel;
    qrlExprDate: TQRLabel;
    QRLabel21: TQRLabel;
    QRShape2: TQRShape;
    QRLabel22: TQRLabel;
    QRLabel23: TQRLabel;
    QRLabel24: TQRLabel;
    QRLabel25: TQRLabel;
    QRLabel26: TQRLabel;
    QRLabel27: TQRLabel;
    QRLabel28: TQRLabel;
    QRLabel29: TQRLabel;
    QRLabel30: TQRLabel;
    QRLabel31: TQRLabel;
    QRLabel32: TQRLabel;
    QRLabel33: TQRLabel;
    qrlTrxDate: TQRLabel;
    QRShape3: TQRShape;
    QRLabel2: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel15: TQRLabel;
    QRLabel17: TQRLabel;
    QRLabel18: TQRLabel;
    QRLabel19: TQRLabel;
    QRLabel20: TQRLabel;
    QRLabel34: TQRLabel;
    PageFooterBand1: TQRBand;
    QRSysData1: TQRSysData;
    txtPajak: TQRLabel;
    QRLabel35: TQRLabel;
    QRLabel36: TQRLabel;
    txtTermin: TQRLabel;
    QRLabel37: TQRLabel;
    qrlDeryDate: TQRLabel;
    QRSysData2: TQRSysData;
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
  qrpPurchaseOrder: TqrpPurchaseOrder;

implementation

uses Subroutines, uMysqlClient, MySQLConnector;

{$R *.DFM}

{ TqrpPurchaseOrder }

procedure TqrpPurchaseOrder.ClearLabels;
begin
  txtNo.Caption:= '';
  txtBarcode.Caption:= '';
  txtDesc.Caption   := '';
  txtQty.Caption    := '';
  txtHrg.Caption    := '';
  txtDisc.Caption   := '';
  txtJumlah.Caption := '';
  txtPajak.Caption  := '';
end;

procedure TqrpPurchaseOrder.Execute(ID: integer; grd: TAdvStringGrid);
begin
  grid:= grd;
  qrlCompanyName.Caption   := CompanyProfile.FCompanyName;
  qrlCompanyAddress.Caption:= CompanyProfile.FAddress;
  qrlCompanyPhone.Caption  := 'Phone/Fax '+CompanyProfile.FTelp1 + IfThen(CompanyProfile.FFax <> '', '/'+CompanyProfile.FFax);
  qrlCompanyCity.Caption   := IfThen(CompanyProfile.FBranch <> '', ''+CompanyProfile.FBranch + ' - ' +CompanyProfile.FCity);
  ClearLabels;
  i:= 1;
  SetHeaderFooter(ID);
  //Self.Print;
  qrpPurchaseOrder.PreviewModal;
end;

procedure TqrpPurchaseOrder.SetHeaderFooter(ID: integer);
var trx: TMysqlResult;
begin

  qrlTrxNumber.Caption:= '';
  qrlExprDate.Caption:= '';
  qrlTrxDate.Caption  := CompanyProfile.FCity + ', .... ';

  txtSubtotal.Caption:= '';
  txtDisc1.Caption   := '';
  txtDisc2.Caption   := '';
  txtTax.Caption     := '';
  txtTotal.Caption   := '';
  qrlVcName.Caption  := '';
  qrlVcAddress.Caption:= '';

  trx:= OpenSQL(
  'select t.trans_num, t.trans_date, t.expr_date, t.subtotal, t.disc_detail, '+
  't.disc_mst, t.tax, t.total, r.relation_name, r.address1, r.city, t.pay_term, delivery_date '+
  'from trs_order_mst t left join mst_relation r on t.relation_id =  r.relation_id '+
  'where order_id = '+IntToStr(ID));
  if trx.RecordCount > 0 then begin
    qrlTrxNumber.Caption:= trx.FieldValue(0);
    qrlExprDate.Caption := DateToStr(BufferToDateTime(trx.FieldValue(2)));
    qrlDeryDate.Caption := DateToStr(BufferToDateTime(trx.FieldValue(12)));
    qrlTrxDate.Caption  := CompanyProfile.FCity + ', '+FormatDateTime('dd MMMM yyyy', BufferToDateTime(trx.FieldValue(1)));

    txtSubtotal.Caption := FloatToStrFmt(BufferToFloat(trx.FieldValue(3)));
    txtDisc1.Caption    := FloatToStrFmt(BufferToFloat(trx.FieldValue(4)));
    txtDisc2.Caption    := FloatToStrFmt(BufferToFloat(trx.FieldValue(5)));
    txtTax.Caption      := FloatToStrFmt(BufferToFloat(trx.FieldValue(6)));
    txtTotal.Caption    := FloatToStrFmt(BufferToFloat(trx.FieldValue(7)));
    qrlVcName.Caption   := trx.FieldValue(8);
    if BufferToString(trx.FieldValue(9)) <> '' then
      qrlVcAddress.Caption:= trx.FieldValue(9) + #13#10 + trx.FieldValue(10)
    else
    qrlVcAddress.Caption:= trx.FieldValue(10);

    txtTermin.Caption   := IfThen(
      BufferToInteger(trx.FieldValue(11)) > 0, trx.FieldValue(11)+' Hari Kredit');
  end;
  trx.destroy;
end;

procedure TqrpPurchaseOrder.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  i:= 1;
end;

procedure TqrpPurchaseOrder.QuickRepNeedData(Sender: TObject;
  var MoreData: Boolean);
begin
  MoreData:= i < grid.RowCount;
  if MoreData then begin
    ClearLabels;
    txtNo.Caption:= IntToStr(i);
    txtBarcode.Caption:= grid.Cells[1,i];
    txtDesc.Caption   := grid.Cells[2,i];
    txtQty.Caption    := grid.Cells[4,i] + ' ' + grid.Cells[5,i];
    txtHrg.Caption    := grid.Cells[6,i];
    txtJumlah.Caption := grid.Cells[7,i];
    txtDisc.Caption   := grid.Cells[8,i];
    txtPajak.Caption  := grid.Cells[9,i];
    Inc(i);
  end;
end;

end.
