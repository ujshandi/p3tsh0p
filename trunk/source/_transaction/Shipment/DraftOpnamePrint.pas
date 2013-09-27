unit DraftOpnamePrint;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, AdvGrid, strUtils;

type
  TqrpDraftOpname = class(TQuickRep)
    PageHeaderBand1: TQRBand;
    ColumnHeaderBand1: TQRBand;
    DetailBand1: TQRBand;
    PageFooterBand1: TQRBand;
    qrlCompanyName: TQRLabel;
    qrlCompanyAddress: TQRLabel;
    qrlCompanyContact: TQRLabel;
    QRLabel17: TQRLabel;
    qrlReportDesc: TQRLabel;
    QRShape1: TQRShape;
    txtUnit: TQRLabel;
    txtQtty3: TQRLabel;
    txtQty1: TQRLabel;
    txtQty: TQRLabel;
    txtQty2: TQRLabel;
    txtPlu: TQRLabel;
    txtNama2: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel1: TQRLabel;
    QRSysData1: TQRSysData;
    QRLabel13: TQRLabel;
    QRShape2: TQRShape;
    QRShape3: TQRShape;
    QRShape4: TQRShape;
    QRShape5: TQRShape;
    QRShape6: TQRShape;
    QRShape11: TQRShape;
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
    vertNama: TQRShape;
    QRShape28: TQRShape;
    QRShape29: TQRShape;
    vertKode: TQRShape;
    txtNo: TQRLabel;
    QRShape24: TQRShape;
    txtLine: TQRLabel;
    QRLabel2: TQRLabel;
    QRShape7: TQRShape;
    txtMerk: TQRLabel;
    QRSysData2: TQRSysData;
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QuickRepNeedData(Sender: TObject; var MoreData: Boolean);
  private
    i,addRow: integer;
    isAdditional : boolean;
    Grid: TAdvStringGrid;
    procedure resetForm;
  public
    procedure Executes(AGrid: TAdvStringGrid);

  end;

var
  qrpDraftOpname: TqrpDraftOpname;

implementation

uses Subroutines;

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
  colItemId = 12;
  colModId  = 13;
  colId     = 14;


{$R *.DFM}

{ TqrpFormOpname }

procedure TqrpDraftOpname.Executes(AGrid: TAdvStringGrid);
begin
  Grid:= AGrid;
  qrlCompanyName.Caption   := CompanyProfile.FCompanyName;
  qrlCompanyAddress.Caption:= CompanyProfile.FAddress;
  qrlCompanyContact.Caption:= CompanyProfile.FTelp1;
  qrlReportDesc.Caption:= CaptionPeriode(GlobalPeriode.OpPeriodeAwal1, GlobalPeriode.PeriodeAwal1, GlobalPeriode.PeriodeAkhir1);
  addRow := 5; //tambahan row kosong


  i:= 1;
  isAdditional := False;
  PreviewModal;
end;

procedure TqrpDraftOpname.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  i:= 1;isAdditional := False; addRow := 5;
end;

procedure TqrpDraftOpname.QuickRepNeedData(Sender: TObject;
  var MoreData: Boolean);
begin
  MoreData:= i < Grid.RowCount;
  {if not MoreData then begin
     MoreData := addRow > 0;
     isAdditional := MoreData;
  end;}
  if MoreData then begin
     resetForm;

    //if not isAdditional then begin
      if (not Grid.IsMergedCell(colCode, i) ) then begin

        txtNo.Caption:= Grid.Cells[colNo, i];
        txtPlu.Caption:= Grid.Cells[colCode, i];
        txtNama2.Caption:= Grid.Cells[colName, i];
        txtUnit.Caption:= Grid.Cells[colUnit, i];
        txtMerk.Caption:= Grid.Cells[colMerk, i];
        txtQtty3.Caption:= '';//Grid.Cells[colQty3, i];
        txtQty1.Caption:='';// Grid.Cells[colQty1, i];
        txtQty.Caption:= '';//Grid.Cells[colQty, i];
        txtQty2.Caption:= '';//Grid.Cells[colQty2, i];
      end
      else begin
        txtPlu.Font.Style := [fsBold];
        txtPlu.Caption:= Grid.Cells[colCode, i];
        vertNama.Enabled :=False;
        vertKode.Enabled :=False;
//        vertLine.Enabled :=False;
      end;

      Inc(i);
   // end
   // else begin
    //   Dec(addRow);
  //  end;
  end;
end;

procedure TqrpDraftOpname.resetForm;
begin
    txtNo.Caption:= '';
    txtNama2.Caption := '';

{    txtLine.Caption:= '';
    txtRak.Caption:= '';
    txtBar.Caption:= '';
    txtCell.Caption:= '';}
    txtPlu.Caption:= '';
//    txtNama.Caption:= '';
    txtUnit.Caption:= '';
    txtQtty3.Caption:= '';
    txtQty1.Caption:= '';
    txtQty.Caption:= '';
    txtQty2.Caption:= '';
    txtMerk.Caption:='';
    vertKode.Enabled :=True;
    vertNama.Enabled :=True;
   // vertRak.Enabled :=True;
  //  vertLine.Enabled :=True;
//      vertDept.Enabled :=True;
    txtPlu.Font.Style :=[];


end;

end.
