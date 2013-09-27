unit trsSalesHoldedList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,strUtils,
  Dialogs, Grids, BaseGrid, AdvGrid, Math;

type
  TfrmTrsSalesHoldedList = class(TForm)
    grid: TAdvStringGrid;
    procedure DBAdvStringGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure gridDblClickCell(Sender: TObject; ARow, ACol: Integer);
  private
    procedure LoadResult;
    function getAnimalsName(relationId:integer;animalseq:string):string;
  public
    function Execute: integer;
  end;

var
  frmTrsSalesHoldedList: TfrmTrsSalesHoldedList;

implementation

uses uMysqlClient, MySQLConnector, Subroutines, UMaster;


{$R *.dfm}

{ TfrmTrsSalesHoldedList }

function TfrmTrsSalesHoldedList.Execute: integer;
begin
  LoadResult;
  ShowModal;
  if ModalResult = mrOk then
    Result:= grid.Ints[1, grid.Row]
  else Result:= 0;
end;

procedure TfrmTrsSalesHoldedList.DBAdvStringGrid1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case key of
    VK_RETURN: ModalResult:= mrOk;
    VK_ESCAPE: ModalResult:= mrCancel;
  end
end;

procedure TfrmTrsSalesHoldedList.LoadResult;
var i,j: integer; header: TMysql_FieldDef;
begin

  try
    Screen.Cursor:= crSQLWait;

    MySQLResult:= OpenSQL(
//    'select hold_id, trans_num as customer, '+
//    '(select mst_name from mst_master where mst_id = cashier_id) as Kasir, '+
    'select hold_id, trans_num as ''No.Trans'',trans_date as ''Tgl.Trans'', relation_name as Customer,'+
    ' '''' as ''Nawa Hewan'', '+ // 'animal_name as ''Nama Hewan'', '+
    'total as Jumlah ,r.relation_id,t.animal_seq,'''' from trs_holded_mst t left join mst_relation r on t.pasien_id = r.relation_id '+
    ' left join mst_relation_animal a on r.relation_id = a.relation_id and t.animal_seq = a.seq '+
    ' order by trans_num');

    grid.Clear;
    grid.RowCount:= IfThen(MySQLResult.RecordCount > 0, MySQLResult.RecordCount + 1, 2);
    grid.ColCount:= MySQLResult.FieldsCount+1;
    grid.FixedRows:= 1;
    for i:= 0 to MySQLResult.FieldsCount-1 do begin
      header:= MySQLResult.FieldDef(i)^;
      grid.Cells[i+1, 0]:= header.Name;
    end;

    for i:= 1 to MySQLResult.RecordCount do begin
      for j:= 0 to MySQLResult.FieldsCount-1 do
        if j = MySQLResult.FieldsCount-4 then
          grid.Cells[j+1,i]:= FloatToStrFmt(BufferToFloat(MySQLResult.FieldValue(j)))
        else if j = MySQLResult.FieldsCount-5 then
            grid.Cells[j+1,i]:= getAnimalsName(BufferToInteger(MySQLResult.FieldValue(6)),BufferToString(MySQLResult.FieldValue(7)))
        else
          grid.Cells[j+1,i]:= MySQLResult.FieldValue(j);
      MySQLResult.MoveNext;
    end;
    MySQLResult.destroy;

    grid.AutoSizeColumns(TRUE, 4);
    grid.ColWidths[0]:= 18;
    grid.ColWidths[1]:= 0;
    grid.ColWidths[7]:= 0;
    grid.ColWidths[8]:= 0;
  finally
    Screen.Cursor:= crDefault;
  end;
end;

procedure TfrmTrsSalesHoldedList.gridDblClickCell(Sender: TObject; ARow,
  ACol: Integer);
begin
  ModalResult:= mrOk
end;

function TfrmTrsSalesHoldedList.getAnimalsName(relationId:integer;animalseq: string): string;
var count,i:integer;
begin
  count := HitungChar(animalseq,';');
  Result := '';
  for i:= 1 to count do begin
    Result := Result + TMstRelation.getAnimalName(relationId,StrToInt(EkstrakString(animalseq,';',i)))+IfThen(i<count, ', ','');
  end;
end;

end.
