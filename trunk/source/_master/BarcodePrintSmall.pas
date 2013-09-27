unit BarcodePrintSmall;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls,
  advGrid, Barcode, strutils, Subroutines;

type
  TqrpBarcodeSmall = class(TQuickRep)
    DetailBand1: TQRBand;
    QRShape1: TQRShape;
    txtNama1: TQRLabel;
    imageBarcode1: TQRImage;
    txtCode1: TQRLabel;
    txtRp1: TQRLabel;
    txtPrice1: TQRLabel;
    QRShape2: TQRShape;
    QRShape3: TQRShape;
    QRShape4: TQRShape;
    QRShape5: TQRShape;
    txtCode2: TQRLabel;
    txtPrice2: TQRLabel;
    txtRp2: TQRLabel;
    imageBarcode2: TQRImage;
    txtNama2: TQRLabel;
    txtCode3: TQRLabel;
    txtPrice3: TQRLabel;
    imageBarcode3: TQRImage;
    txtRp3: TQRLabel;
    txtNama3: TQRLabel;
    txtCode4: TQRLabel;
    txtPrice4: TQRLabel;
    txtRp4: TQRLabel;
    imageBarcode4: TQRImage;
    txtNama4: TQRLabel;
    txtCode5: TQRLabel;
    txtPrice5: TQRLabel;
    txtRp5: TQRLabel;
    imageBarcode5: TQRImage;
    txtNama5: TQRLabel;
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QuickRepAfterPreview(Sender: TObject);
    procedure QuickRepNeedData(Sender: TObject; var MoreData: Boolean);
  private
    i: integer;
    FBarcode: TBarcode;
    FDefaultImage: TQRImage;
    grid: TAdvStringGrid;

  public
    procedure Executes(AGrid: TAdvStringGrid);
  end;

var
  qrpBarcodeSmall: TqrpBarcodeSmall;

implementation

{$R *.DFM}

{ TqrpBarcodeSmall }

procedure TqrpBarcodeSmall.Executes(AGrid: TAdvStringGrid);
begin
  Grid:= AGrid;
  FBarcode:= TBarcode.Create(Self);
  FDefaultImage:= TQRImage.Create(Self);
  FDefaultImage.Width := imageBarcode1.Width;
  FDefaultImage.Height:= imageBarcode1.Height;

  FBarcode.Typ:= bcCode_2_5_interleaved;
  FBarcode.Height:= 20;
  i:= 1;
  qrpBarcodeSmall.Prepare;
  Preview;
  FDefaultImage.Free;
end;

procedure TqrpBarcodeSmall.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  i:= 1;
end;

procedure TqrpBarcodeSmall.QuickRepAfterPreview(Sender: TObject);
begin
  FBarcode.Free;
end;

procedure TqrpBarcodeSmall.QuickRepNeedData(Sender: TObject;
  var MoreData: Boolean);
begin
  MoreData:= i < grid.RowCount;
  if MoreData then begin
    txtNama1.Caption:= ''; txtCode1.Caption:= ''; txtPrice1.Caption:= ''; txtRp1.Caption:= 'Rp.';
    txtNama2.Caption:= ''; txtCode2.Caption:= ''; txtPrice2.Caption:= ''; txtRp2.Caption:= '';
    txtNama3.Caption:= ''; txtCode3.Caption:= ''; txtPrice3.Caption:= ''; txtRp3.Caption:= '';
    txtNama4.Caption:= ''; txtCode4.Caption:= ''; txtPrice4.Caption:= ''; txtRp4.Caption:= '';
    txtNama5.Caption:= ''; txtCode5.Caption:= ''; txtPrice5.Caption:= ''; txtRp5.Caption:= '';
    imageBarcode1.Canvas.FillRect(FDefaultImage.Canvas.ClipRect);
    imageBarcode2.Canvas.FillRect(FDefaultImage.Canvas.ClipRect);
    imageBarcode3.Canvas.FillRect(FDefaultImage.Canvas.ClipRect);
    imageBarcode4.Canvas.FillRect(FDefaultImage.Canvas.ClipRect);
    imageBarcode5.Canvas.FillRect(FDefaultImage.Canvas.ClipRect);

    txtNama1.Caption := grid.Cells[0, i];
    txtCode1.Caption := grid.Cells[1, i];
    txtPrice1.Caption:= grid.Cells[2, i];
    FBarcode.Text    := txtCode1.Caption;
    FBarcode.DrawBarcode(imageBarcode1.Canvas);

    if grid.Cells[3, i] <> '' then begin
      txtRp2.Caption:= 'Rp.';
      txtNama2.Caption := grid.Cells[3, i];
      txtCode2.Caption := grid.Cells[4, i];
      txtPrice2.Caption:= grid.Cells[5, i];
      FBarcode.Text    := txtCode2.Caption;
      FBarcode.DrawBarcode(imageBarcode2.Canvas);
    end;

    if grid.Cells[6, i] <> '' then begin
      txtRp3.Caption:= 'Rp.';
      txtNama3.Caption := grid.Cells[6, i];
      txtCode3.Caption := grid.Cells[7, i];
      txtPrice3.Caption:= grid.Cells[8, i];
      FBarcode.Text    := txtCode3.Caption;
      FBarcode.DrawBarcode(imageBarcode3.Canvas);
    end;

    if grid.Cells[9, i] <> '' then begin
      txtRp4.Caption:= 'Rp.';
      txtNama4.Caption := grid.Cells[9, i];
      txtCode4.Caption := grid.Cells[10, i];
      txtPrice4.Caption:= grid.Cells[11, i];
      FBarcode.Text    := txtCode4.Caption;
      FBarcode.DrawBarcode(imageBarcode4.Canvas);
    end;

    if grid.Cells[12, i] <> '' then begin
      txtRp5.Caption:= 'Rp.';
      txtNama5.Caption := grid.Cells[12, i];
      txtCode5.Caption := grid.Cells[13, i];
      txtPrice5.Caption:= grid.Cells[14, i];
      FBarcode.Text    := txtCode5.Caption;
      FBarcode.DrawBarcode(imageBarcode5.Canvas);
    end;

    if (i mod 11 = 1) and (i > 10) then begin
      qrpBarcodeSmall.NewPage;
    end;
    Inc(i);
  end;
end;

end.
