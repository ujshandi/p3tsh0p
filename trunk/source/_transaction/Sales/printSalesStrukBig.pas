unit printSalesStrukBig;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, uMysqlClient;

type
  TqrpSalesStrukBig = class(TQuickRep)
    TitleBand1: TQRBand;
    ColumnHeaderBand1: TQRBand;
    DetailBand1: TQRBand;
    SummaryBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    qrlNo: TQRLabel;
    qrlCode: TQRLabel;
    qrlNama: TQRLabel;
    qrlQty: TQRLabel;
    qrlHarga: TQRLabel;
    qrlDisc: TQRLabel;
    qrlDisc2: TQRLabel;
    qrlJumlah: TQRLabel;
    qrlCompanyName: TQRLabel;
    qrlCompanyAddress: TQRLabel;
    qrlCompanyContact: TQRLabel;
    qrlCust: TQRLabel;
    qrlAlamat: TQRLabel;
    qrlStruk: TQRLabel;
    qrlTgl: TQRLabel;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    qrlPot2: TQRLabel;
    qrlPot1: TQRLabel;
    qrlSubtotal: TQRLabel;
    qrlGrandTotal: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    qrlPoint: TQRLabel;
    procedure QuickRepNeedData(Sender: TObject; var MoreData: Boolean);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    sales: TMysqlResult;
    i: integer;
    procedure QuerySales(ID: integer);
    procedure SetHeaderFooter();
  public
    procedure Executes(ID: integer);
  end;

var
  qrpSalesStrukBig: TqrpSalesStrukBig;

implementation

uses MySQLConnector, UMaster, Subroutines;

{$R *.DFM}

{ TqrpSalesStrukBig }

procedure TqrpSalesStrukBig.Executes(ID: integer);
begin
  qrlCompanyName.Caption   := CompanyProfile.FCompanyName;
  qrlCompanyAddress.Caption:= CompanyProfile.FAddress;
  qrlCompanyContact.Caption:= CompanyProfile.FTelp1;
  i:= 1;
  QuerySales(ID);
  SetHeaderFooter;
  //PreviewModal;
  Print;
end;

procedure TqrpSalesStrukBig.QuerySales(ID: integer);
begin
  sales:= OpenSQL(
  'select d.sales_detail_id, (d.quantity/d.conversion) as qty, '+
  'd.price, d.amount, d.disc, d.disc_val, '+
  't.trans_num, t.trans_date, t.total, t.cash, (t.cash - t.total) as cash_back, '+
  't.subtotal, t.disc_mst, t.disc_val_mst, t.tax, t.points, i.struk_name, i.barcode, '+
  '(select mst_code from mst_master u, mst_item_conversion c '+
   'where c.unit_id = u.mst_id and c.conv_id = d.conv_id) as sat, t.pasien_id '+
  'from trs_sales_mst t, trs_sales_detail d, mst_item i '+
  'where d.sales_id = t.sales_id and d.item_id = i.item_id and d.item_id is not null '+
  'and t.sales_id = '+IntToStr(ID)+
  ' union all '+
  'select d.sales_detail_id, (d.quantity/d.conversion) as qty, '+
  'd.price, d.amount, d.disc, d.disc_val, '+
  't.trans_num, t.trans_date, t.total, t.cash, (t.cash - t.total) as cash_back, '+
  't.subtotal, t.disc_mst, t.disc_val_mst, t.tax, t.points, i.nama_struk as struk_name, i.barcode, '+
  '(select mst_code from mst_master u where u.mst_id = i.unit_id) as sat, t.pasien_id '+
  'from trs_sales_mst t, trs_sales_detail d, mst_paket i '+
  'where d.sales_id = t.sales_id and d.paket_id = i.paket_id and d.paket_id is not null '+
  'and t.sales_id = '+IntToStr(ID)+
  ' order by sales_detail_id');
end;

procedure TqrpSalesStrukBig.QuickRepNeedData(Sender: TObject;
  var MoreData: Boolean);
begin
  //1qty, 2price, 3amount, 4disc, 5disc_val, 6trans_num, 7trans_date, 8total, 9cash,
  //10cash_back, 11subtotal, 12disc_mst, 13disc_val_mst, 14tax, 15points,
  //16struk_name, 17barcode, 18sat
  MoreData:= i <= sales.RecordCount;
  if MoreData then begin
    qrlNo.Caption:= '';
    qrlCode.Caption := '';
    qrlNama.Caption := '';
    qrlQty.Caption  := '';
    qrlHarga.Caption:= '';
    qrlDisc.Caption:= '';
    qrlDisc2.Caption:= '';
    qrlJumlah.Caption:= '';

    qrlNo.Caption:= IntToStr(i);
    qrlCode.Caption := sales.FieldValue(17);
    qrlNama.Caption := sales.FieldValue(16);
    qrlQty.Caption  := FloatToStrFmt(BufferToFloat(sales.FieldValue(1))) +' '+ sales.FieldValue(18);
    qrlHarga.Caption:= FloatToStrFmt(BufferToFloat(sales.FieldValue(2)));
    qrlDisc.Caption:= FloatToStrFmt(BufferToFloat(sales.FieldValue(4)));
    qrlDisc2.Caption:= FloatToStrFmt(BufferToFloat(sales.FieldValue(5)));
    qrlJumlah.Caption:= FloatToStrFmt(BufferToFloat(sales.FieldValue(3)));
    Inc(i);
    sales.MoveNext;
  end else sales.destroy;

end;

procedure TqrpSalesStrukBig.SetHeaderFooter;
var cust: TMstRelation;
begin
  //1qty, 2price, 3amount, 4disc, 5disc_val, 6trans_num, 7trans_date, 8total, 9cash,
  //10cash_back, 11subtotal, 12disc_mst, 13disc_val_mst, 14tax, 15points,
  //16struk_name, 17barcode, 18sat

  cust:= TMstRelation.Create();
  qrlStruk.Caption:= '';
  qrlTgl.Caption:= '';
  qrlSubtotal.Caption:= '';
  qrlPot1.Caption:= '';
  qrlPot2.Caption:= '';
  qrlGrandTotal.Caption:= '';
  qrlPoint.Caption:= '';
  qrlCust.Caption:= '';
  qrlAlamat.Caption:='';

  if sales.RecordCount > 0 then begin
    qrlStruk.Caption:= sales.FieldValue(6);
    qrlTgl.Caption:= DateTimeToStr(BufferToDateTime(sales.FieldValue(7)));
    qrlSubtotal.Caption:= FloatToStrFmt(BufferToFloat(sales.FieldValue(11)));
    qrlPot1.Caption:= FloatToStrFmt(BufferToFloat(sales.FieldValue(12)));
    qrlPot2.Caption:= FloatToStrFmt(BufferToFloat(sales.FieldValue(13)));
    qrlGrandTotal.Caption:= FloatToStrFmt(BufferToFloat(sales.FieldValue(8)));
    if BufferToInteger(sales.FieldValue(15)) > 0 then
      qrlPoint.Caption:= 'Jml Point : '+IntToStr(BufferToInteger(sales.FieldValue(15)));
    cust.RelationID:= BufferToInteger(sales.FieldValue(19));
    cust.SelectID;
    qrlCust.Caption:= cust.RelationName + ' ('+cust.RelationCode+')';
    qrlAlamat.Caption:= cust.Address1;
    cust.Destroy;
  end;

end;

procedure TqrpSalesStrukBig.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  i:= 1;
end;

end.
