unit trsAbsensiListPrint;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, AdvGrid, strUtils;

type
  TqrpAbsensiList = class(TQuickRep)
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
    qrlNik: TQRLabel;
    QRShape4: TQRShape;
    QRSysData2: TQRSysData;
    QRSysData1: TQRSysData;
    QRLabel7: TQRLabel;
    QRLabel9: TQRLabel;
    qrlTgl: TQRLabel;
    qrlStatus: TQRLabel;
    qrlNo: TQRLabel;
    qrlNama: TQRLabel;
    qrlKeterangan: TQRLabel;
    QRShape3: TQRShape;
    QRLabel2: TQRLabel;
    qrlJabatan: TQRLabel;
    procedure QuickRepNeedData(Sender: TObject; var MoreData: Boolean);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    HistoryMode:boolean;
    i,Purpose: integer;
    Grid: TAdvStringGrid;
    procedure emptyText;
  public
    procedure Executes(AGrid: TAdvStringGrid);
  public

  end;

var
  qrpAbsensiList: TqrpAbsensiList;

implementation

uses Subroutines, UMaster, BaseGrid, UPetshop;

const
 colNo      = 0;
  colNik     = 1;
  colName    = 2;
  colJabatan = 3;
  colTgl = 4;
  colStatus = 5;
  colKeterangan = 6;
  colId   = 7;



{$R *.DFM}

{ TqrpItemList }

procedure TqrpAbsensiList.Executes(AGrid: TAdvStringGrid);
var spc, vendor: string;
begin
  Grid:= AGrid;
  qrlTitle.Caption := 'Daftar Absensi ';
//  qrlHeadHarga.Caption := IfThen(Purpose=1,'H.Beli',IfThen(Purpose=2, 'H.Jual','Disc.'));
  qrlCompanyName.Caption   := CompanyProfile.FCompanyName;
  qrlCompanyAddress.Caption:= CompanyProfile.FAddress;
  qrlCompanyContact.Caption:= CompanyProfile.FTelp1;
  spc:= TMstCode.getName(GlobalFilter.SpecID);
  vendor:='';//TMstKaryawan.GetName(GlobalFilter.RelasiID);

  qrlPeriode.Caption:= spc + IfThen(vendor<> '', ' - ' + vendor);

  i:= 1;
  Prepare;
  PreviewModal;
end;

procedure TqrpAbsensiList.QuickRepNeedData(Sender: TObject;
  var MoreData: Boolean);
begin
  MoreData:= i < Grid.RowCount;
  if MoreData then begin
    emptyText;
     if (Grid.Cells[colId,i]='') then begin
       qrlTgl.Width := 320;
       qrlNo.Caption :=  grid.Cells[colNo,i]; //IntToStrFmt(i);
       qrlNik.Caption := Grid.Cells[colNik, i];
       qrlJabatan.Caption := grid.Cells[colJabatan,i];
       qrlNama.Caption := Grid.Cells[colName, i];
       qrlTgl.Caption := Grid.Cells[colTgl, i];

     end
     else if (Grid.Cells[colId,i]='-1') then begin
      qrlTgl.Width := 72;
       qrlTgl.Caption := Grid.Cells[colTgl, i];
       qrlStatus.Caption := Grid.Cells[colStatus,i];
       qrlKeterangan.Caption := Grid.Cells[colKeterangan,i];
     end
     else begin
      qrlTgl.Width := 72;
      qrlTgl.Caption := Grid.Cells[colTgl, i];
       qrlStatus.Caption := Grid.Cells[colStatus,i];
       qrlKeterangan.Caption := Grid.Cells[colKeterangan,i];
     end;


     Inc(i);
  end
end;

procedure TqrpAbsensiList.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  i:= 1;
end;

procedure TqrpAbsensiList.emptyText;
begin
  qrlNo.Caption := '';
  qrlNik.Caption := '';
  qrlNama.Caption := '';
  qrlJabatan.Caption := '';
  qrlStatus.Caption := '';
  qrlTgl.Caption := '';
  qrlKeterangan.Caption := '';
end;

end.
