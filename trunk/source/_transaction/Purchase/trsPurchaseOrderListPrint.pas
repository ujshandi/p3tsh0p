unit trsPurchaseOrderListPrint;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,strUtils,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, AdvGrid;

type
  TqrpPurchaseOrderListPrint = class(TQuickRep)
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
    QRLabel8: TQRLabel;
    qrlHeadTipe: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel15: TQRLabel;
    QRShape2: TQRShape;
    QRShape3: TQRShape;
    QRShape4: TQRShape;
    QRShape5: TQRShape;
    QRShape7: TQRShape;
    QRShape8: TQRShape;
    QRShape9: TQRShape;
    QRShape11: TQRShape;
    QRShape12: TQRShape;
    QRShape13: TQRShape;
    QRShape14: TQRShape;
    QRShape16: TQRShape;
    QRShape17: TQRShape;
    QRShape18: TQRShape;
    QRShape19: TQRShape;
    qrlDisc: TQRLabel;
    qrlTotal: TQRLabel;
    qrlTgl: TQRLabel;
    qrlTrx: TQRLabel;
    qrlNo: TQRLabel;
    qrlSubtotal: TQRLabel;
    qrlSupplier: TQRLabel;
    qrlKeterangan: TQRLabel;
    QRShape22: TQRShape;
    QRSysData1: TQRSysData;
    QRShape1: TQRShape;
    qrlPajak: TQRLabel;
    QRShape6: TQRShape;
    QRShape10: TQRShape;
    QRLabel3: TQRLabel;
    QRSysData2: TQRSysData;
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QuickRepNeedData(Sender: TObject; var MoreData: Boolean);
  private
    i,Purpose: integer;
    Grid: TAdvStringGrid;
  public
    procedure Executes(AGrid: TAdvStringGrid;aPurpose:integer);

  end;

var
  qrpPurchaseOrderListPrint: TqrpPurchaseOrderListPrint;

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

procedure TqrpPurchaseOrderListPrint.Executes(AGrid: TAdvStringGrid;aPurpose:integer);
begin
  Grid:= AGrid;
  Purpose := aPurpose;
  qrlCompanyName.Caption   := CompanyProfile.FCompanyName;
  qrlCompanyAddress.Caption:= CompanyProfile.FAddress;
  qrlCompanyContact.Caption:= CompanyProfile.FTelp1;

  qrlPeriode.Caption:= CaptionPeriode(GlobalPeriode.OpPeriodeAwal1, GlobalPeriode.PeriodeAwal1, GlobalPeriode.PeriodeAkhir1);
  case Purpose of
    TRANS_TYPE_ORDER : begin
        Self.ReportTitle := 'Rekap PO';
        qrlHeadTipe.Caption := 'Keterangan';
        end;
    TRANS_TYPE_RECEIPT : begin
        Self.ReportTitle := 'Rekap Penerimaan/Pembelian';
        qrlHeadTipe.Caption := 'Tipe';
    end;
     TRANS_TYPE_RETUR : begin
        Self.ReportTitle := 'Rekap Retur Pembelian';
        qrlHeadTipe.Caption := 'Keterangan';
    end;
  end;

  qrlTitle.Caption := Self.ReportTitle;
  i:= 1;
  PreviewModal;
end;

procedure TqrpPurchaseOrderListPrint.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  i:= 1;
end;

procedure TqrpPurchaseOrderListPrint.QuickRepNeedData(Sender: TObject;
  var MoreData: Boolean);
begin
  MoreData:= i < Grid.RowCount;
  if MoreData then begin
    qrlNo.Caption:= '';
    qrlTrx.Caption:= '';
    qrlTgl.Caption:= '';
    qrlSupplier.Caption:= '';
    qrlSubtotal.Caption:= '';
    qrlTotal.Caption:= '';
    qrlDisc.Caption:= '';
    qrlPajak.Caption := '';
    qrlKeterangan.Caption:= '';


    qrlNo.Caption := Grid.Cells[0,i];
    qrlTrx.Caption:= Grid.Cells[2,i];
    qrlTgl.Caption:= Grid.Cells[3,i];
    if Purpose = TRANS_TYPE_ORDER then begin
      qrlSupplier.Caption:= Grid.Cells[6,i];
      qrlSubtotal.Caption:= Grid.Cells[9,i];
      qrlDisc.Caption:= Grid.Cells[10,i];
      qrlPajak.Caption := Grid.Cells[11,i];
      qrlTotal.Caption:= Grid.Cells[12,i];
      qrlKeterangan.Caption:= Grid.Cells[8,i];
    end
    else if Purpose =  TRANS_TYPE_RECEIPT then begin
        qrlSupplier.Caption:= Grid.Cells[5,i];
        qrlSubtotal.Caption:= Grid.Cells[8,i];
        qrlDisc.Caption:= Grid.Cells[9,i];
        qrlPajak.Caption := Grid.Cells[11,i];
        qrlTotal.Caption:= Grid.Cells[13,i];
        qrlKeterangan.Caption:= Grid.Cells[6,i];
    end
    else if Purpose = TRANS_TYPE_RETUR then begin
      qrlSupplier.Caption:= Grid.Cells[4,i];
      qrlSubtotal.Caption:= Grid.Cells[7,i];
      qrlDisc.Caption:= Grid.Cells[8,i];
      qrlTotal.Caption:= Grid.Cells[12,i];
      qrlKeterangan.Caption:= Grid.Cells[6,i];
    end;

    Inc(i);
  end;
end;

end.
