unit DokterListPrint;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, AdvGrid, strUtils;

type
  TqrpDokterList = class(TQuickRep)
    TitleBand1: TQRBand;
    ColumnHeaderBand1: TQRBand;
    DetailBand1: TQRBand;
    PageFooterBand1: TQRBand;
    qrlCompanyName: TQRLabel;
    qrlCompanyAddress: TQRLabel;
    qrlCompanyContact: TQRLabel;
    QRLabel3: TQRLabel;
    QRShape1: TQRShape;
    QRLabel1: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel6: TQRLabel;
    QRShape2: TQRShape;
    qrlNo: TQRLabel;
    qrlCode: TQRLabel;
    qrlNama: TQRLabel;
    qrlAlamat: TQRLabel;
    qrlPhone: TQRLabel;
    QRSysData3: TQRSysData;
    QRShape3: TQRShape;
    QRSysData4: TQRSysData;
    rchAlamat: TQRRichText;
    rchPhone: TQRRichText;
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QuickRepNeedData(Sender: TObject; var MoreData: Boolean);
  private
    i: integer;
    Grid: TAdvStringGrid;
    alamat: string;
  public
    procedure Executes(AGrid: TAdvStringGrid);
  end;

var
  qrpDokterList: TqrpDokterList;

implementation

uses Subroutines;

const
  colKode   = 2;
  colNama   = 3;
  colAlamat = 4;
  colKota   = 5;
  colPhone  = 6;
  colKontak = 7;
  colSaldo  = 8;
  colPoint  = 9;

{$R *.DFM}

{ TqrpSupplierList }

procedure TqrpDokterList.Executes(AGrid: TAdvStringGrid);
begin
  Grid:= AGrid;
  qrlCompanyName.Caption   := CompanyProfile.FCompanyName;
  qrlCompanyAddress.Caption:= CompanyProfile.FAddress +' '+ CompanyProfile.FCity;
  qrlCompanyContact.Caption:= CompanyProfile.FTelp1;
  i:= 1;
  qrpDokterList.Prepare;
  PreviewModal;
end;

procedure TqrpDokterList.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  i:= 1;
end;

procedure TqrpDokterList.QuickRepNeedData(Sender: TObject;
  var MoreData: Boolean);
begin
  MoreData:= i < Grid.RowCount;
  if MoreData then begin
     qrlNo.Caption:= ''; qrlCode.Caption:= ''; qrlNama.Caption:= '';
     qrlPhone.Caption:= '';
     qrlAlamat.Caption:= '';

     rchAlamat.Lines.Text:= '';

     rchPhone.Lines.Text:= '';
     rchAlamat.Lines.Clear;
     rchPhone.Lines.Clear;
     qrlAlamat.Height:= 14;
     qrlPhone.Height:= 14;
     alamat:= '';

     qrlAlamat.AutoStretch:= False;
     qrlPhone.AutoStretch:= False;
     Trim(Grid.Cells[colKota, i]);
     Trim(Grid.Cells[colAlamat, i]);
     
     if (Grid.Cells[colAlamat, i] <> '') and (Grid.Cells[colKota, i] <> '') then
       alamat:= Grid.Cells[colAlamat, i] +' '+ Grid.Cells[colKota, i]
     else if (Grid.Cells[colAlamat, i] = '') and (Grid.Cells[colKota, i] <> '') then
       alamat:= Grid.Cells[colKota, i]
     else alamat:= Grid.Cells[colAlamat, i];

     qrlNama.Caption := Grid.Cells[colNama, i];
     rchPhone.Lines.Text:= Grid.Cells[colPhone, i];
     rchAlamat.Lines.Text:= alamat;
   //alamatLah
      if (rchAlamat.Lines.Count >= rchPhone.Lines.Count)
      then begin
        qrlPhone.Height:= 14 * rchAlamat.Lines.Count;
        qrlAlamat.AutoStretch:= True;
      end

      //phoneLah
      else if (rchAlamat.Lines.Count < rchPhone.Lines.Count)
      then begin
        qrlAlamat.Height:= 14 * rchPhone.Lines.Count;
        qrlPhone.AutoStretch:= True;
      end;

     qrlNo.Caption   := IntToStr(i);
     qrlCode.Caption := Grid.Cells[colKode, i];
     qrlAlamat.Caption := alamat;
     qrlPhone.Caption:= Grid.Cells[colPhone, i];
     
     Inc(i);
  end
end;

end.
