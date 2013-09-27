unit LHSOPrint;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, AdvGrid, strUtils;

type
  TqrpLHSO = class(TQuickRep)
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
    txtNo: TQRLabel;
    txtNama: TQRLabel;
    txtDiv: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel1: TQRLabel;
    QRSysData1: TQRSysData;
    QRLabel7: TQRLabel;
    QRLabel13: TQRLabel;
    QRShape2: TQRShape;
    QRShape3: TQRShape;
    QRShape4: TQRShape;
    QRShape5: TQRShape;
    QRShape6: TQRShape;
    QRShape10: TQRShape;
    QRShape11: TQRShape;
    QRShape12: TQRShape;
    QRShape13: TQRShape;
    QRShape14: TQRShape;
    QRShape17: TQRShape;
    QRShape18: TQRShape;
    QRShape19: TQRShape;
    QRShape20: TQRShape;
    QRShape21: TQRShape;
    QRShape22: TQRShape;
    vertPLU: TQRShape;
    QRShape28: TQRShape;
    QRShape29: TQRShape;
    vertDiv: TQRShape;
    QRLabel18: TQRLabel;
    QRShape26: TQRShape;
    qrlHarga: TQRLabel;
    QRShape27: TQRShape;
    QRLabel2: TQRLabel;
    QRShape7: TQRShape;
    QRLabel5: TQRLabel;
    QRShape8: TQRShape;
    QRLabel9: TQRLabel;
    QRShape9: TQRShape;
    QRLabel10: TQRLabel;
    QRShape15: TQRShape;
    QRShape16: TQRShape;
    QRLabel11: TQRLabel;
    QRShape23: TQRShape;
    QRLabel14: TQRLabel;
    QRLabel15: TQRLabel;
    QRShape24: TQRShape;
    QRShape25: TQRShape;
    QRShape30: TQRShape;
    QRShape31: TQRShape;
    QRLabel16: TQRLabel;
    QRLabel19: TQRLabel;
    QRLabel20: TQRLabel;
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QuickRepNeedData(Sender: TObject; var MoreData: Boolean);
  private
    i: integer;
    Grid: TAdvStringGrid;
    procedure resetForm;
  public
    procedure Executes(AGrid: TAdvStringGrid);

  end;

var
  qrpLHSO: TqrpLHSO;

implementation

uses Subroutines;

const
 colNo       = 0;
  colCode     = 2;
  colName     = 1;
  colRAK       = 4;
  colLine      = 3;
  colRow       = 5;
  colCell      = 6;

  colUnit     = 7;
  colPrice    = 8;
  colStok     = 9;  //hide nilai before save show after save
  colQty1     =10;
  colQty2     =11;
  colQty3     =12;
  colQty      =13; //colReal
  colDIV      = 24;//buat Info aja
  colDEPT     = 25;//buat Info aja
  colKTEB     = 26;//buat Info aja


{$R *.DFM}

{ TqrpFormOpname }

procedure TqrpLHSO.Executes(AGrid: TAdvStringGrid);
begin
  Grid:= AGrid;
  qrlCompanyName.Caption   := CompanyProfile.FCompanyName;
  qrlCompanyAddress.Caption:= CompanyProfile.FBranch.FAddress;
  qrlCompanyContact.Caption:= CompanyProfile.FBranch.FPhone;
  qrlReportDesc.Caption:= CaptionPeriode(GlobalPeriode.OpPeriodeAwal1, GlobalPeriode.PeriodeAwal1, GlobalPeriode.PeriodeAkhir1);

  i:= 1;
  PreviewModal;
end;

procedure TqrpLHSO.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  i:= 1;
end;

procedure TqrpLHSO.QuickRepNeedData(Sender: TObject;
  var MoreData: Boolean);
begin
  MoreData:= i < Grid.RowCount;
  if MoreData then begin
     resetForm;

    if (not Grid.IsMergedCell(colCode, i) ) then begin

      txtNo.Caption:= Grid.Cells[colNo, i];
      txtPlu.Caption:= Grid.Cells[colCode, i];
      txtNama.Caption:= Grid.Cells[colName, i];
      txtUnit.Caption:= Grid.Cells[colUnit, i];
      txtQtty3.Caption:= Grid.Cells[colQty3, i];
      txtQty1.Caption:= Grid.Cells[colQty1, i];
      txtQty.Caption:= Grid.Cells[colQty, i];
      txtQty2.Caption:= Grid.Cells[colQty2, i];
       txtDiv.Caption:= Grid.Cells[colDIV, i];
    qrlHarga.Caption := Grid.Cells[colPrice,i]
    end
    else begin
      txtDiv.Font.Style:= [fsBold];
      txtDiv.AutoSize:= True;
      txtDiv.Caption:= Grid.Cells[colCode, i];
      vertDiv.Enabled :=False;
      vertPLU.Enabled :=False;
    end;
      
    Inc(i);
  end;
end;

procedure TqrpLHSO.resetForm;
begin
    txtNo.Caption:= '';
    txtDiv.Caption:= '';
    txtPlu.Caption:= '';
    txtNama.Caption:= '';
    txtUnit.Caption:= '';
    txtQtty3.Caption:= '';
    txtQty1.Caption:= '';
    txtQty.Caption:= '';
    txtQty2.Caption:= '';
    qrlHarga.Caption := '';
    vertPLU.Enabled :=True;
     vertDiv.Enabled :=True;


    txtDiv.Font.Style:= [];
    txtDiv.AutoSize:= False;
end;

end.
