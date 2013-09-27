unit Unit1;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls,
  advGrid, Barcode;

type
  TQuickReport1 = class(TQuickRep)
    DetailBand1: TQRBand;
    qrlBarcode: TQRImage;
    QRImage1: TQRImage;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QuickRepAfterPreview(Sender: TObject);
    procedure QuickRepNeedData(Sender: TObject; var MoreData: Boolean);
  private
    tipe: TBarcodeType;
    i: integer;
    FBarcode: TBarcode;
    grid: TAdvStringGrid;
  public
    procedure Executes(AGrid: TAdvStringGrid; IDX:  BYTE);

  end;

var
  QuickReport1: TQuickReport1;

implementation

{$R *.DFM}

{ TQuickReport1 }

procedure TQuickReport1.Executes(AGrid: TAdvStringGrid; IDX: BYTE);
begin
  Grid:= AGrid;
  FBarcode:= TBarcode.Create(Self);
  CASE IDX of
    0: tipe:= bcCode_2_5_interleaved;
    1: tipe:= bcCode_2_5_industrial;
    2: tipe:= bcCode_2_5_matrix;
    3: tipe:= bcCode39;
    4: tipe:= bcCode39Extended;
    5: tipe:= bcCode128A;
    6: tipe:= bcCode128B;
    7: tipe:= bcCode128C;
    8: tipe:= bcCode93;
    9: tipe:= bcCode93Extended;
    10: tipe:= bcCodeMSI;
    11: tipe:= bcCodePostNet;
    12: tipe:= bcCodeCodabar;
    13: tipe:= bcCodeEAN8;
    14: tipe:= bcCodeEAN13;
    15: tipe:= bcCodeUPC_A;
    16: tipe:= bcCodeUPC_E0;
    17: tipe:= bcCodeUPC_E1;
    18: tipe:= bcCodeUPC_Supp2;
    19: tipe:= bcCodeUPC_Supp5;
    20: tipe:= bcCodeEAN128A;
    21: tipe:= bcCodeEAN128B;
    22: tipe:= bcCodeEAN128C;
  end;
  //FBarcode.Typ:= tipe;
  FBarcode.Typ:= bcCode_2_5_interleaved;


  //bcCodeUPC_A;


  FBarcode.ShowText:= bcoCode;
  FBarcode.Height:= 29;
  i:= 1;
  PreviewModal;
end;

procedure TQuickReport1.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  i:= 1;
end;

procedure TQuickReport1.QuickRepAfterPreview(Sender: TObject);
begin
  FBarcode.Free;
end;

procedure TQuickReport1.QuickRepNeedData(Sender: TObject;
  var MoreData: Boolean);
begin
 MoreData:= i < grid.RowCount;
  if MoreData then begin

    FBarcode.Text:= grid.Cells[1, i];

   // if Length(FBarcode.Text) > 13 then
     //  FBarcode.Typ:= bcCode128B
    //else
    //FBarcode.Typ:= tipe;
    try
      FBarcode.DrawBarcode(qrlBarcode.Canvas);
    except raise;
    end;  

    Inc(i);
  end;
end;

end.
