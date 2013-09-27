unit MstBranchListPrint;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, AdvGrid;

type
  TqrpMstBranchList = class(TQuickRep)
    ColumnHeaderBand1: TQRBand;
    DetailBand1: TQRBand;
    PageFooterBand1: TQRBand;
    QRSysData4: TQRSysData;
    QRSysData3: TQRSysData;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    txtKode: TQRLabel;
    txtNama: TQRLabel;
    txtKota: TQRLabel;
    txtPhone: TQRLabel;
    QRRichText1: TQRRichText;
    QRLabel17: TQRLabel;
    txtNo: TQRLabel;
    PageHeaderBand1: TQRBand;
    qrlCompanyName: TQRLabel;
    qrlCompanyAddress: TQRLabel;
    qrlCompanyContact: TQRLabel;
    QRLabel3: TQRLabel;
    txtAlamat: TQRLabel;
    qrlTipeRak: TQRLabel;
    QRLabel7: TQRLabel;
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QuickRepNeedData(Sender: TObject; var MoreData: Boolean);
  private
    i: integer;
    Grid: TAdvStringGrid;
  public
    procedure Executes(AGrid: TAdvStringGrid);
  public

  end;

var
  qrpMstBranchList: TqrpMstBranchList;

implementation

uses Subroutines;

const
  colNo     = 0;
  colKode   = 1;
  colNama   = 2;
  colAlamat = 3;
  colKota   = 4;
  colPhone  = 5;
  colTipeRak = 6;
//  colPoint  = 6;
{$R *.DFM}

{ TqrpMemberList }

procedure TqrpMstBranchList.Executes(AGrid: TAdvStringGrid);
begin
  Grid:= AGrid;
  qrlCompanyName.Caption   := CompanyProfile.FCompanyName;
//  qrlCompanyAddress.Caption:= CompanyProfile.FBranch.Address + ' ' + CompanyProfile.FBranch.FCity;
//  qrlCompanyContact.Caption:= CompanyProfile.FBranch.Phone;
  i:= 1;
  Self.Prepare;
  PreviewModal;
end;

procedure TqrpMstBranchList.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  i:= 1;
end;

procedure TqrpMstBranchList.QuickRepNeedData(Sender: TObject;
  var MoreData: Boolean);
begin
  MoreData:= i < Grid.RowCount;
  if MoreData then begin
     txtNo.Caption:= ''; txtKode.Caption:= ''; txtNama.Caption:= '';
     txtAlamat.Caption:= '';
     txtKota.Caption:= '';
     txtPhone.Caption:= '';
     qrlTipeRak.Caption := '';
     QRRichText1.Lines.Text:= '';
     txtAlamat.Height:= 14;

     txtNo.Caption:= Grid.Cells[colNo, i];
     txtKode.Caption:= Grid.Cells[colKode, i];
     txtNama.Caption:= Grid.Cells[colNama, i];
     txtAlamat.Caption:= Grid.Cells[colAlamat, i];
     txtKota.Caption:= Grid.Cells[colKota, i];
     txtPhone.Caption:= Grid.Cells[colPhone, i];
     qrlTipeRak.Caption:= Grid.Cells[colTipeRak, i];
     QRRichText1.Lines.Text:= Grid.Cells[colAlamat, i];
     Inc(i);
  end
end;

end.
