unit BarcodePrint;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, advGrid, Barcode, Subroutines;

type
  TqrpBarcodePrint = class(TQuickRep)
    DetailBand1: TQRBand;
    qrlStruk: TQRLabel;
    qrlCode: TQRLabel;
    qrlPrice: TQRLabel;
    qrlPrice2: TQRLabel;
    qrlCode2: TQRLabel;
    qrlStruk2: TQRLabel;
    qrlBarcode: TQRImage;
    qrlBarcode2: TQRImage;
    procedure QuickRepNeedData(Sender: TObject; var MoreData: Boolean);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QuickRepAfterPreview(Sender: TObject);
  private
    i: integer;
    FBarcode: TBarcode;
    grid: TAdvStringGrid;
    RotatedText: TTextRotate;
  public
    procedure Executes(AGrid: TAdvStringGrid);
  end;

var
  qrpBarcodePrint: TqrpBarcodePrint;

implementation

{$R *.DFM}

procedure TqrpBarcodePrint.QuickRepNeedData(Sender: TObject;
  var MoreData: Boolean);
begin
  MoreData:= i < grid.RowCount;
  if MoreData then begin
    qrlStruk.Caption:= '';
    qrlCode.Caption:= '';
    qrlPrice.Caption:= '';
    qrlStruk2.Caption:= '';
    qrlCode2.Caption:= '';
    qrlPrice2.Caption:= '';

    qrlStruk.Caption := grid.Cells[0, i];
    qrlCode.Caption  := grid.Cells[1, i];
    qrlPrice.Caption := grid.Cells[2, i];
    FBarcode.Text:= grid.Cells[1, i];
    //FBarcode.ShowText:= bcoBoth;
    FBarcode.DrawBarcode(qrlBarcode.Canvas);

    if grid.Cells[3, i] <> '' then begin
      qrlStruk2.Caption:= grid.Cells[3, i];
      qrlCode2.Caption := grid.Cells[4, i];
      qrlPrice2.Caption:= grid.Cells[5, i];
      FBarcode.Text:= grid.Cells[4, i];

      FBarcode.DrawBarcode(qrlBarcode2.Canvas);
    end;
    Inc(i);
  end;
end;

procedure TqrpBarcodePrint.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  i:= 1;
end;

procedure TqrpBarcodePrint.Executes(AGrid: TAdvStringGrid);
begin
  Grid:= AGrid;
  RotatedText:= TTextRotate.Create;
  FBarcode:= TBarcode.Create(Self);
  FBarcode.Typ:= bcCodeEAN13;
  FBarcode.Height:= 22;
  FBarcode.CheckSumMethod:= csmNone;
  i:= 1;
  PreviewModal;
end;

procedure TqrpBarcodePrint.QuickRepAfterPreview(Sender: TObject);
begin
  FBarcode.Free;
  RotatedText.Free;
end;

end.
