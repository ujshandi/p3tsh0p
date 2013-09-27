unit LookupFreeService;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, BaseGrid, AdvGrid, Math, StdCtrls, AdvEdit, strutils;

type
  TfrmLookupFreeService = class(TForm)
    grid: TAdvStringGrid;
    Button1: TButton;
    Button2: TButton;
    procedure DBAdvStringGrid1DblClick(Sender: TObject);
    procedure DBAdvStringGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure AdvEdit1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure gridCanEditCell(Sender: TObject; ARow, ACol: Integer;
      var CanEdit: Boolean);
    procedure gridGetEditorType(Sender: TObject; ACol, ARow: Integer;
      var AEditor: TEditorType);
    procedure gridCheckBoxClick(Sender: TObject; ACol, ARow: Integer;
      State: Boolean);
  private
    FVendorID: integer;
    Rules : TStringList;
///    grid: TAdvStringGrid;
    function itsOk():boolean;
    procedure requeryData();
    procedure initGrid();
  public
    function Execute(aRelationId:integer;var resultList:TStringList;ARules:TStringList): boolean;
  end;

var
  frmLookupFreeService: TfrmLookupFreeService;

implementation

uses UConst, MySQLConnector, uMysqlClient, UConstTool, MainMenu, trsSales,
  Subroutines;

{$R *.dfm}

{ TfrmLookup }

function TfrmLookupFreeService.Execute(aRelationId:integer;var resultList:TStringList;ARules:TStringList): boolean;
var state : Boolean;
    i:integer;
begin
  Result := False;
  initGrid;
  Rules := ARules;
  resultList.Clear;
  FVendorID := aRelationId;
 // if (aTableName <> 'PASIEN') AND (aTableName <> 'DOKTER') then
    requeryData();
  Self.ShowModal;
  if ModalResult = mrOk then begin
    Result:= true;
    for i:= 1 to grid.RowCount-1 do begin

       grid.GetCheckBoxState(2,i,state);
       if state then
          resultList.Add(grid.Cells[1,i]+';'+grid.Cells[5,i]+';'+grid.Cells[6,i]);
    end;

  end;
end;

procedure TfrmLookupFreeService.requeryData();
var i,j: integer; header: TMysql_FieldDef;
  filter: string;
begin

  try
    Screen.Cursor:= crSQLWait;
      MySQLResult:= OpenSQL(
      'select bonus_service,false as ''v'',concat(service_name,'' ('',animal,'')'') as Deskripsi,price,a.animal_id,bonus_jml '+
      ' from mst_relation_service r inner join mst_service_bonus b on b.service_type=r.service_type '+
      ' left join mst_service_price p on p.service_id=b.bonus_service '+
      ' inner join mst_animal a on a.animal_id = p.animal_id and a.animal_id in (select animal_id from mst_relation_animal where relation_id=r.relation_id) '+
      ' left join mst_service s on s.service_id = b.bonus_service '+
      ' where relation_id = '+FormatSQLNumber(FVendorID)+' and r.jumlah >= b.jml_service ');

    grid.Clear;
    grid.RowCount:= IfThen(MySQLResult.RecordCount > 0, MySQLResult.RecordCount + 1, 2);
    grid.ColCount:= MySQLResult.FieldsCount+2;
    grid.FixedRows:= 1;
    for i:= 0 to MySQLResult.FieldsCount-1 do begin
      header:= MySQLResult.FieldDef(i)^;
      grid.Cells[i+1, 0]:= header.Name;
    end;

    MySQLResult.First;
    for i:= 1 to MySQLResult.RecordCount do begin
      for j:= 0 to MySQLResult.FieldsCount-1 do begin
        if (j=1) then begin
           grid.AddCheckBox(2,i,false,false);
        end
        else
          grid.Cells[j+1,i]:= MySQLResult.FieldValue(j);
      end;
      MySQLResult.MoveNext;
    end;
    MySQLResult.destroy;

    grid.AutoSizeColumns(TRUE, 4);
    grid.ColWidths[0]:= 18;
    grid.ColWidths[1]:= 0;

  finally
    Screen.Cursor:= crDefault;
  end;
end;

procedure TfrmLookupFreeService.DBAdvStringGrid1DblClick(Sender: TObject);
begin
  ModalResult:= mrOk
end;

procedure TfrmLookupFreeService.DBAdvStringGrid1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    vk_return: ModalResult := mrOk;
    vk_Escape: ModalResult := mrCancel;
  end;
end;

procedure TfrmLookupFreeService.AdvEdit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    vk_return: requeryData();
    vk_Escape: ModalResult := mrCancel;
  end;
end;

procedure TfrmLookupFreeService.initGrid;
begin
 // grid:= TAdvStringGrid.Create(Self);
 // grid.Parent:= Self;
 // grid.BeginUpdate;

  
  grid.ColCount:= 5;
  grid.RowCount := 2;
  grid.FixedCols:= 1;
  grid.FixedRows:= 1;
  grid.BorderStyle:= bsNone;
  grid.Options := [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goRowSelect];
  grid.TabOrder := 1;
  grid.OnDblClick := DBAdvStringGrid1DblClick;
  grid.OnKeyDown := DBAdvStringGrid1KeyDown;
  grid.Flat := True;
  grid.ColumnSize.Stretch := True;

  grid.FixedColor          := clFixedColum;
  grid.FixedFont.Color     := clFixedFont;
  grid.Font.Style          := [];
  grid.SelectionColor      := clSelection;
  grid.Color               := clGrid;
  grid.Bands.PrimaryColor  := clPrimaryBand;
  grid.Bands.SecondaryColor:= clSecondaryBand;
  grid.Font.Color          := clLabel;//clFixedFont;
  grid.SelectionTextColor  := clFixedColum;//clFixedFont;

  grid.Cells[3, 0]:= 'v';
  grid.Cells[3, 0]:= 'KODE';
  grid.Cells[4, 0]:= 'NAMA';
  grid.AutoSizeColumns(True,2);
  grid.ColWidths[0]:= 18;
  grid.ColWidths[1]:= 0;
 // grid.EndUpdate;
end;

procedure TfrmLookupFreeService.gridCanEditCell(Sender: TObject; ARow,
  ACol: Integer; var CanEdit: Boolean);
begin
  CanEdit := ACol in [2];
end;

procedure TfrmLookupFreeService.gridGetEditorType(Sender: TObject; ACol,
  ARow: Integer; var AEditor: TEditorType);
begin
  if ACol = 2 then
    AEditor := edCheckBox;
end;

function TfrmLookupFreeService.itsOk: boolean;
var i,x,serviceID,maxBonus,bonus:integer;
    state:boolean;
begin
  Result := True;
  for x:= 0 to Rules.Count-1 do begin
    serviceID := StrToInt(Rules.Names[x]);
    maxBonus := StrToInt(Rules.Values[Rules.Names[x]]);
    bonus := 0;
    for i:= 1 to grid.RowCount-1 do begin
       if serviceID <> grid.Ints[1,i] then Continue;
       grid.GetCheckBoxState(2,i,state);
       if state then bonus := bonus + grid.Ints[6,i];
       if bonus > maxBonus then begin
          Result := False;break;
       end;
    end;
    if not Result then Break;
  end;
end;

procedure TfrmLookupFreeService.gridCheckBoxClick(Sender: TObject; ACol,
  ARow: Integer; State: Boolean);
begin
  State := itsOk;
  if not State then begin
     Alert('Bonus yang diambil melebihi ketentuan');
     grid.SetCheckBoxState(ACol,ARow,State);
  end;

end;

end.
