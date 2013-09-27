unit BarcodePrintiBig;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls, QRPrntr, 
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, advGrid, Barcode, strutils;

//  Variants, Forms,
//  Dialogs, QRPrntr, StdCtrls, ;

type
  TqrpBarcodePrintiBig = class(TQuickRep)
    DetailBand1: TQRBand;
    kotak4: TQRShape;
    kotak3: TQRShape;
    kotak2: TQRShape;
    kotak1: TQRShape;
    qrBarcode2: TQRImage;
    qrlCode2: TQRLabel;
    qrlNama2: TQRLabel;
    qrBarcode3: TQRImage;
    qrlCode3: TQRLabel;
    qrBarcode4: TQRImage;
    qrBarcode: TQRImage;
    qrlCode4: TQRLabel;
    qrlNama3: TQRLabel;
    qrlNama4: TQRLabel;
    qrlCode: TQRLabel;
    qrlPrice: TQRLabel;
    qrlPrice2: TQRLabel;
    qrlPrice3: TQRLabel;
    qrlPrice4: TQRLabel;
    lblQty1: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    lblQty2: TQRLabel;
    QRLabel2: TQRLabel;
    lblQty3: TQRLabel;
    QRLabel1: TQRLabel;
    lblQty4: TQRLabel;
    qrlNama: TQRLabel;
    qrlNama5: TQRLabel;
    qrlPrice5: TQRLabel;
    QRLabel5: TQRLabel;
    lblQty5: TQRLabel;
    qrBarcode5: TQRImage;
    qrlCode5: TQRLabel;
    kotak5: TQRShape;
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QuickRepNeedData(Sender: TObject; var MoreData: Boolean);
    procedure QuickRepAfterPreview(Sender: TObject);
    procedure qrlPricePrint(sender: TObject; var Value: String);
    procedure qrlPrice2Print(sender: TObject; var Value: String);
    procedure qrlPrice3Print(sender: TObject; var Value: String);
    procedure qrlPrice4Print(sender: TObject; var Value: String);
    procedure qrlPrice5Print(sender: TObject; var Value: String);
  private
    i: integer;
    FBarcode: TBarcode;
    FDefaultImage: TQRImage;
    grid: TAdvStringGrid;
    tmp: string;
  public
    procedure Executes(AGrid: TAdvStringGrid);
  end;

var
  qrpBarcodePrintiBig: TqrpBarcodePrintiBig;

implementation

uses Subroutines;

{$R *.DFM}

{ TqrpBarcodePrintiBig }

procedure TqrpBarcodePrintiBig.Executes(AGrid: TAdvStringGrid);
begin
  Grid:= AGrid;
  FBarcode:= TBarcode.Create(Self);
  FDefaultImage:= TQRImage.Create(Self);
  FDefaultImage.Width := qrBarcode.Width;
  FDefaultImage.Height:= qrBarcode.Height;

  FBarcode.Typ:= bcCode_2_5_interleaved;
  FBarcode.Height:= 50;

  i:= 1;
  qrpBarcodePrintiBig.Prepare;
  PreviewModal;
  FDefaultImage.Free;
end;

procedure TqrpBarcodePrintiBig.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  i:= 1;
end;

procedure TqrpBarcodePrintiBig.QuickRepNeedData(Sender: TObject;
  var MoreData: Boolean);
begin
  MoreData:= i < grid.RowCount;
  if MoreData then begin
    qrlNama.Caption := ''; qrlCode.Caption:= ''; qrlPrice.Caption:= '';
    qrlNama2.Caption:= ''; qrlCode2.Caption:= ''; qrlPrice2.Caption:= '';
    qrlNama3.Caption:= ''; qrlCode3.Caption:= ''; qrlPrice3.Caption:= '';
    qrlNama4.Caption:= ''; qrlCode4.Caption:= ''; qrlPrice4.Caption:= '';
    qrlNama5.Caption:= ''; qrlCode5.Caption:= ''; qrlPrice5.Caption:= '';
    lblQty1.Caption:= '';  lblQty2.Caption:= '';lblQty3.Caption:= ''; lblQty4.Caption:= ''; lblQty5.Caption:= '';
    QRLabel1.Caption:= ''; QRLabel2.Caption:= ''; QRLabel3.Caption:= ''; QRLabel4.Caption:= ''; QRLabel5.Caption:= '';
    kotak1.Enabled:= True; kotak2.Enabled:= False; kotak3.Enabled:= False;
    kotak4.Enabled:= False; kotak5.Enabled:= False;
    qrBarcode.Canvas.FillRect(FDefaultImage.Canvas.ClipRect);
    qrBarcode2.Canvas.FillRect(FDefaultImage.Canvas.ClipRect);
    qrBarcode3.Canvas.FillRect(FDefaultImage.Canvas.ClipRect);
    qrBarcode4.Canvas.FillRect(FDefaultImage.Canvas.ClipRect);
    qrBarcode5.Canvas.FillRect(FDefaultImage.Canvas.ClipRect);

    QRLabel3.Caption:= 'Rp.';
    qrlNama.Caption  := grid.Cells[0, i];
    qrlCode.Caption  := grid.Cells[1, i];
    qrlPrice.Caption := EkstrakString(grid.Cells[2, i],';',1);
    tmp:= EkstrakString(grid.Cells[2, i],';',2);
    if tmp <> '' then lblQty1.Caption := '/ '+tmp;

    FBarcode.Text:= qrlCode.Caption;
    FBarcode.DrawBarcode(qrBarcode.Canvas);
    if grid.Cells[3, i] <> '' then begin
      QRLabel4.Caption:= 'Rp.';
      qrlNama2.Caption  := grid.Cells[3, i];
      qrlCode2.Caption  := grid.Cells[4, i];
      qrlPrice2.Caption := EkstrakString(grid.Cells[5, i],';',1);
      tmp:= EkstrakString(grid.Cells[5, i],';',2);
      if tmp <> '' then lblQty2.Caption := '/ '+tmp;
      FBarcode.Text:= qrlCode2.Caption;
      FBarcode.DrawBarcode(qrBarcode2.Canvas);
      kotak2.Enabled:= True;
    end;

    if grid.Cells[6, i] <> '' then begin
      QRLabel2.Caption:= 'Rp.';
      qrlNama3.Caption  := grid.Cells[6, i];
      qrlCode3.Caption  := grid.Cells[7, i];

      qrlPrice3.Caption := EkstrakString(grid.Cells[8, i],';',1);
      tmp:= EkstrakString(grid.Cells[8, i],';',2);
      if tmp <> '' then lblQty3.Caption := '/ '+tmp;
      FBarcode.Text:= qrlCode3.Caption;
      FBarcode.DrawBarcode(qrBarcode3.Canvas);
      kotak3.Enabled:= True;
    end;

    if grid.Cells[9, i] <> '' then begin
      QRLabel1.Caption:= 'Rp.';
      qrlNama4.Caption  := grid.Cells[9, i];
      qrlCode4.Caption  := grid.Cells[10, i];
      qrlPrice4.Caption := EkstrakString(grid.Cells[11, i],';',1);
      tmp:= EkstrakString(grid.Cells[11, i],';',2);
      if tmp <> '' then lblQty4.Caption := '/ '+tmp;
      FBarcode.Text:= qrlCode4.Caption;
      FBarcode.DrawBarcode(qrBarcode4.Canvas);
      kotak4.Enabled:= True;
    end;

    if grid.Cells[12, i] <> '' then begin
      QRLabel5.Caption:= 'Rp.';
      qrlNama5.Caption  := grid.Cells[12, i];
      qrlCode5.Caption  := grid.Cells[13, i];
      qrlPrice5.Caption := EkstrakString(grid.Cells[14, i],';',1);
      tmp:= EkstrakString(grid.Cells[14, i],';',2);
      if tmp <> '' then lblQty5.Caption := '/ '+tmp;
      FBarcode.Text:= qrlCode5.Caption;
      FBarcode.DrawBarcode(qrBarcode5.Canvas);
      kotak5.Enabled:= True;
    end;

    Inc(i);
  end;
end;

procedure TqrpBarcodePrintiBig.QuickRepAfterPreview(Sender: TObject);
begin
  FBarcode.Free;
end;

procedure TqrpBarcodePrintiBig.qrlPricePrint(sender: TObject;
  var Value: String);
begin
  lblQty1.Left:= (qrlPrice.Left+qrlPrice.Width)+1;// - lblQty1.Width;
end;

procedure TqrpBarcodePrintiBig.qrlPrice2Print(sender: TObject;
  var Value: String);
begin
  lblQty2.Left:= (qrlPrice2.Left+qrlPrice2.Width)+1;// - lblQty2.Width;
end;

procedure TqrpBarcodePrintiBig.qrlPrice3Print(sender: TObject;
  var Value: String);
begin
  lblQty3.Left:= (qrlPrice3.Left+qrlPrice3.Width)+1;// - lblQty3.Width;
end;

procedure TqrpBarcodePrintiBig.qrlPrice4Print(sender: TObject;
  var Value: String);
begin
  lblQty4.Left:= (qrlPrice4.Left+qrlPrice4.Width)+1;// - lblQty4.Width;
end;

procedure TqrpBarcodePrintiBig.qrlPrice5Print(sender: TObject;
  var Value: String);
begin
  lblQty5.Left:= (qrlPrice4.Left+qrlPrice5.Width)+1;// - lblQty5.Width;
end;

end.
