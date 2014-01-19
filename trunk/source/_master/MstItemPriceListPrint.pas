unit MstItemPriceListPrint;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, AdvGrid, strUtils;

type
  TqrpItemPriceList = class(TQuickRep)
    TitleBand1: TQRBand;
    ColumnHeaderBand1: TQRBand;
    PageFooterBand1: TQRBand;
    qrlTitle: TQRLabel;
    qrlPeriode: TQRLabel;
    qrlCompanyName: TQRLabel;
    qrlCompanyAddress: TQRLabel;
    qrlCompanyContact: TQRLabel;
    QRLabel1: TQRLabel;
    QRLabel4: TQRLabel;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    DetailBand1: TQRBand;
    qrlCode: TQRLabel;
    QRShape4: TQRShape;
    QRSysData2: TQRSysData;
    QRSysData1: TQRSysData;
    QRLabel7: TQRLabel;
    qrlHeadHBeli: TQRLabel;
    QRLabel9: TQRLabel;
    qrlMerk: TQRLabel;
    qrlHBeli: TQRLabel;
    qrlNo: TQRLabel;
    qrlDesc: TQRLabel;
    qrlHeadHJual: TQRLabel;
    qrlHeadHarga: TQRLabel;
    qrlHJual: TQRLabel;
    qrlDisc: TQRLabel;
    QRShape3: TQRShape;
    QRLabel2: TQRLabel;
    qrlHeadPetshop: TQRLabel;
    qrlJenis: TQRLabel;
    qrlHeadBreeder: TQRLabel;
    qrlHPetshop: TQRLabel;
    qrlHBreeder: TQRLabel;
    procedure QuickRepNeedData(Sender: TObject; var MoreData: Boolean);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    HistoryMode:boolean;
    i,Purpose: integer;
    Grid: TAdvStringGrid;
  public
    procedure Executes(APurpose:integer;aHistoryMode:boolean;AGrid: TAdvStringGrid);
  public

  end;

var
  qrpItemPriceList: TqrpItemPriceList;

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
  colHargaBeli = 8; //show wne input h.jual & discount
  colHargaJual = 9; //show when input disc
  colHarga    = 10;//utk input
  colHargaPetshop = 11; //utk hjual sesama petshop
  colHargaBreeder = 12; 


{$R *.DFM}

{ TqrpItemList }

procedure TqrpItemPriceList.Executes(APurpose:integer;aHistoryMode:boolean;AGrid: TAdvStringGrid);
var spc, vendor: string;
begin
  HistoryMode := aHistoryMode;
  Purpose := APurpose;
  Grid:= AGrid;
  qrlTitle.Caption := 'Daftar '+IfThen(Purpose=1,'Harga Beli',IfThen(Purpose=2, 'Harga Jual','Discount Barang'));
  qrlHeadHarga.Caption := IfThen(Purpose=1,'H.Beli',IfThen(Purpose=2, 'H.Jual','Disc.'));
  qrlCompanyName.Caption   := CompanyProfile.FCompanyName;
  qrlCompanyAddress.Caption:= CompanyProfile.FAddress;
  qrlCompanyContact.Caption:= CompanyProfile.FTelp1;
  qrlHeadHBeli.Enabled := (Purpose in [2,3]);
  qrlHeadHJual.Enabled := (Purpose in [3]);
  qrlHeadPetshop.Enabled := (Purpose in [2]);
  qrlHeadBreeder.Enabled := (Purpose in [2]);
  spc:= TMstCode.getName(GlobalFilter.SpecID);
  vendor:= TMstRelation.GetName(GlobalFilter.RelasiID);

  qrlPeriode.Caption:= spc + IfThen(vendor<> '', ' - ' + vendor);

  i:= 1;
  Prepare;
  PreviewModal;
end;

procedure TqrpItemPriceList.QuickRepNeedData(Sender: TObject;
  var MoreData: Boolean);
begin
  MoreData:= i < Grid.RowCount;
  if MoreData then begin
      qrlCode.Caption:= '';
     qrlMerk.Caption:= '';
     qrlHBeli.Caption:= '';
     qrlHJual.Caption:= '';
     qrlDisc.Caption:= '';
     qrlNo.Caption:= '';
     qrlJenis.Caption := '';
     qrlHPetshop.Caption := '';
     qrlHBreeder.Caption := '';

   //  QRRichText1.Lines.Clear;
    // QRRichText1.Lines.Text:= Grid.Cells[colName, i];
     qrlNo.Caption :=  grid.Cells[colNo,i]; //IntToStrFmt(i);
     qrlCode.Caption := Grid.Cells[colCode, i];
     qrlJenis.Caption := Grid.Cells[colJenis,i];
     qrlMerk.Caption := Grid.Cells[colmerk, i];
     qrlHBeli.Enabled := false;//(Purpose in [2,3]);
     qrlHPetshop.Enabled := false;
     qrlHBreeder.Enabled := false;
//     qrlHJual.Enabled := (Purpose in [3]);
     case Purpose of
     1 : begin //harga beli
        // qrlHBeli.Caption := Grid.Cells[colHargaBeli, i];
        // qrlHJual.Caption := Grid.Cells[colHargaJual, i];
         qrlDisc.Caption := Grid.Cells[colHarga, i];
         qrlHBeli.Enabled := HistoryMode;
         qrlHJual.Enabled  := False;
         qrlHBeli.Caption := IfThen(HistoryMode and (not Grid.IsNode(i)),Grid.Cells[colStruk,i],'');
     end;
     2 : begin //harga jual
         qrlHBeli.Caption := Grid.Cells[colHargaBeli, i];
       //  qrlHJual.Caption := Grid.Cells[colHargaJual, i];
         qrlDisc.Caption := Grid.Cells[colHarga, i];
         qrlHBeli.Enabled := True;
         qrlHJual.Enabled  := HistoryMode;
         qrlHPetshop.Enabled := true;
         qrlHBreeder.Enabled := true;
         qrlHJual.Caption := IfThen(HistoryMode and (not Grid.IsNode(i)),Grid.Cells[colStruk,i],'');
         qrlHPetshop.Caption :=  Grid.Cells[colHargaPetshop, i];
         qrlHBreeder.Caption :=  Grid.Cells[colHargaBreeder, i];
     end;
     3 : begin //discount
         qrlHBeli.Caption := Grid.Cells[colHargaBeli, i];
         qrlHJual.Caption := Grid.Cells[colHargaJual, i];
         qrlDisc.Caption := Grid.Cells[colHarga, i];
         qrlHBeli.Enabled := True;
         qrlHJual.Enabled  := True;
     end;
     end;

    qrlDesc.Caption := TrimAll(Grid.Cells[colName, i]);
{     qrlBeli.Caption := Grid.Cells[colHBeli, i];
     qrlDasar.Caption:= Grid.Cells[colHDasar, i];
     qrlJual.Caption := Grid.Cells[colHJual1, i];
     qrlJual.Caption := Grid.Cells[colHJual2, i];
     qrlStok.Caption := Grid.Cells[colStok, i];}
     Inc(i);
  end
end;

procedure TqrpItemPriceList.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  i:= 1;
end;

end.
