unit InputBoxPilihHarga;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, BaseGrid, AdvGrid, Math;

type
  TfrmInputBoxPilihHarga = class(TForm)
    grid: TAdvStringGrid;
    procedure gridGetAlignment(Sender: TObject; ARow, ACol: Integer;
      var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure gridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    procedure reloadHarga(ItemID: integer);
  public
    function Execute(ItemID: integer): integer;
  end;

var
  frmInputBoxPilihHarga: TfrmInputBoxPilihHarga;

implementation

uses uMysqlClient, MySQLConnector;

const
colID    = 2;
colUnit  = 0;
colHarga = 1;

{$R *.dfm}

{ TfrmInputBoxPilihHarga }

procedure TfrmInputBoxPilihHarga.reloadHarga(ItemID: integer);
var i: integer; hargaList: TMysqlResult;
begin

  hargaList:= OpenSQL(
  'select t.conv_id, t.sales_price, m.mst_name from mst_item_conversion t, mst_master m '+
  'where t.unit_id = m.mst_id and t.item_id = '+IntToStr(ItemID)+
  ' order by t.conversion ');

  grid.RowCount:= IfThen(hargaList.RecordCount>0, hargaList.RecordCount + 1, 2);
  for i:= 1 to hargaList.RecordCount do begin
    grid.Ints[colID,     i]:= BufferToInteger(hargaList.FieldValue(0));
    grid.Cells[colUnit,  i]:= hargaList.FieldValue(2);
    grid.Cells[colHarga, i]:= FloatToStrFmt(BufferToFloat(hargaList.FieldValue(1)));
    hargaList.MoveNext;
  end;
  grid.AutoSizeColumns(true, 5);
  grid.ColWidths[colID]:= 0;
  hargaList.destroy;
end;

procedure TfrmInputBoxPilihHarga.gridGetAlignment(Sender: TObject; ARow,
  ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  if ACol = colHarga then HAlign:= taRightJustify
end;

procedure TfrmInputBoxPilihHarga.gridKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_RETURN: ModalResult:= mrOk;
    VK_ESCAPE: ModalResult:= mrCancel;
  end;  

end;

function TfrmInputBoxPilihHarga.Execute(ItemID: integer): integer;
begin
  Result:= 0;
  reloadHarga(ItemID);
  ShowModal;
  if ModalResult = mrOK then
    Result:= grid.Ints[colID, grid.Row];
end;

end.
