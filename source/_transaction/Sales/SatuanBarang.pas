unit SatuanBarang;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, BaseGrid, AdvGrid;

type
  TfrmSatuanBarang = class(TForm)
    grid: TAdvStringGrid;
    procedure gridGetAlignment(Sender: TObject; ARow, ACol: Integer;
      var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure gridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    procedure LoadData(ID: integer);
  public
    function Execute(ID: integer): integer;
  end;

var
  frmSatuanBarang: TfrmSatuanBarang;

implementation

uses UMaster, uMysqlClient, MySQLConnector;

const
  colName   = 1;
  colConv   = 2;
  colSales  = 3;
  colConvId = 4;

{$R *.dfm}

{ TfrmSatuanBarang }

procedure TfrmSatuanBarang.LoadData(ID: integer);
var i: integer; buffer: TMysqlResult;
begin
  grid.RowCount:= 2;
  grid.ClearNormalCells;

  buffer:= OpenSQL(
  'select c.conv_id, u.mst_name, c.conversion, c.sales_price '+
  'from mst_item_conversion c, mst_master u '+
  'where c.unit_id = u.mst_id and c.item_id = '+FormatSQLNumber(ID)+
  ' order by c.conversion');

  for i:= 1 to buffer.RecordCount do begin
    grid.Ints[colConvId,  i]:= BufferToInteger(buffer.FieldValue(0));
    grid.Cells[colName,   i]:= BufferToString(buffer.FieldValue(1));
    grid.Ints[colConv,    i]:= BufferToInteger(buffer.FieldValue(2));
    grid.Floats[colSales, i]:= BufferToFloat(buffer.FieldValue(3));
    grid.AddRow;
    buffer.MoveNext;
  end;
  buffer.destroy;

  grid.AutoSizeColumns(True, 4);
  grid.ColWidths[0]:= 18;
  grid.ColWidths[colConvId]:= 0;
end;

procedure TfrmSatuanBarang.gridGetAlignment(Sender: TObject; ARow,
  ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
 if ACol > colName then HAlign:= taRightJustify
end;

procedure TfrmSatuanBarang.gridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    VK_RETURN: ModalResult:= mrOk;
    VK_ESCAPE: ModalResult:= mrCancel;
  end;
end;

function TfrmSatuanBarang.Execute(ID: integer): integer;
begin
  LoadData(ID);
  ShowModal;
  if ModalResult = mrOK then
    Result:= grid.Ints[colConvId, grid.Row]
  else Result:= 0;
end;

end.
