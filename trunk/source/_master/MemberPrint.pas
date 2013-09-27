unit MemberPrint;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls;

type
  TqrpMember = class(TQuickRep)
    TitleBand1: TQRBand;
    QRLabel2: TQRLabel;
    QRLabel1: TQRLabel;
    lblCompanyAddress: TQRLabel;
    lblCompanyCity: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    txtAlamat: TQRRichText;
    txtID: TQRLabel;
    QRShape1: TQRShape;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    txtNama: TQRLabel;
    txtType: TQRLabel;
  private

  public
    procedure Executes(ID: integer);
  end;

var
  qrpMember: TqrpMember;

implementation

uses UMaster, UConstTool, Subroutines;

{$R *.DFM}

{ TqrpMember }

procedure TqrpMember.Executes(ID: integer);
var Relasi: TMstRelation;
begin

  lblCompanyAddress.Caption:= CompanyProfile.FAddress;
  lblCompanyCity.Caption:= CompanyProfile.FCity;

  txtType.Caption:= '';
  txtID.Caption:= '';
  txtNama.Caption:= '';
  txtAlamat.Lines.Clear;

  Relasi:= TMstRelation.Create();
  Relasi.RelationID:= ID;
  if Relasi.SelectInDB then begin
    case Relasi.RelationType of
      RELASI_TYPE_MEMBER: txtType.Caption:= '[MEMBER ID]';
      RELASI_TYPE_SALESMAN: txtType.Caption:= '[SALESMAN ID]';
    end;
    txtID.Caption:= Relasi.RelationCode;
    txtNama.Caption:= Relasi.RelationName;
    txtAlamat.Lines.Text:= Relasi.Address1;
  end;
  Relasi.Destroy;
  qrpMember.Print
  //qrpMember.Preview
end;

end.
