unit MstAkun;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, SUIImagePanel, ComCtrls, SUITreeView, StdCtrls,
  AdvEdit, ToolWin,
  UMaster, frmDockForm, Grids, BaseGrid, AdvGrid;

type
  TfrmMstAkun = class(TDockForm)
    suiPanel1: TsuiPanel;
    suiPanel2: TsuiPanel;
    ToolBar1: TToolBar;
    tbtNew: TToolButton;
    tbtSave: TToolButton;
    ToolButton2: TToolButton;
    tbtDelete: TToolButton;
    ToolButton5: TToolButton;
    tbtRefresh: TToolButton;
    txtKode: TAdvEdit;
    txtNama: TAdvEdit;
    grid: TAdvStringGrid;
    rgType: TRadioGroup;
    procedure txtKodeChange(Sender: TObject);
    procedure tbtNewClick(Sender: TObject);
    procedure tbtSaveClick(Sender: TObject);
    procedure tbtDeleteClick(Sender: TObject);
    procedure tbtRefreshClick(Sender: TObject);
    procedure gridClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure rgTypeClick(Sender: TObject);
  private
    MstCode: TMstAkun;
    PointMaping: TPointMaping;
    procedure ResetData;
    procedure InitGrid;
    procedure ReloadGrid;
    procedure ReloadData(id: integer);
    function isSaved:boolean;
    function isValid:boolean;
  public
    procedure Execute(id: integer=0); override;
  end;

var
  frmMstAkun: TfrmMstAkun;

implementation

uses MySQLConnector, Subroutines, UConst, UConstTool,
  MainMenu, uMysqlClient, AutoStockLine;

const
  colNo = 0;
  colKode =1;
  colNama = 2;
  colTipe = 3;
  colId = 4;
    

{$R *.dfm}

{ TfrmMstRak }

procedure TfrmMstAkun.Execute(id: integer);
begin
  inherited;
  ToolBar1.ParentColor:= false;
  ToolBar1.Color:= clWhite;
  ResetData;
  MstCode:= TMstAkun.Create;
  PointMaping:= TPointMaping.Create();
  ReloadGrid;
  Run(Self);
end;

function TfrmMstAkun.isSaved: boolean;
begin
  MstCode.Reset;
  MstCode.Nama:= txtNama.Text;
  MstCode.AkunID  := txtNama.Tag;
  MstCode.Kode    := txtKode.Text;
  MstCode.Tipe   := rgType.ItemIndex+1;//suiTreeView1.Selected.Level + 2;

  if txtNama.Tag <> 0 then
    Result:= MstCode.UpdateOnDB
  else begin
     Result:= MstCode.InsertOnDB;
  end;

  tbtSave.Enabled:= not Result;
  if Result then  begin
    ResetData;
    tbtRefresh.Click;
  end;
end;


function TfrmMstAkun.isValid: boolean;
begin
  if CekInput(Result, txtKode.Text <> '', 'Kode belum diisi.', txtKode) then
  if CekInput(Result, txtNama.Text <> '', 'Nama belum diisi.', txtNama) then
   // CekInput(Result,MstCode.isExistInDb(txtKode.Text) and (txtNama.Tag<>0),'Kode Sudah ada',txtNama) 
end;

procedure TfrmMstAkun.ReloadData(id: integer);
begin
  ResetData;
  MstCode.Reset;
  MstCode.AkunID:= id;
  if not MstCode.SelectInDB then exit;
  txtNama.Text  := MstCode.Nama;
  txtNama.Tag   := MstCode.AkunID;
  txtKode.Text  := MstCode.Kode;
  rgType.ItemIndex := MstCode.Tipe-1;
//  txtParent.Text:= MstCode.ParentName;
 // txtParent.Tag := MstCode.ParentId;
  tbtSave.Enabled:= False;
end;

procedure TfrmMstAkun.ReloadGrid;
var i:integer; data : TMysqlResult;
begin
  data:=TMstAkun.LoadFromDB;
  InitGrid;
  for i:= 1 to data.RecordCount do begin
      grid.Ints[colNo,i] := i;
      grid.Cells[colKode,i] := BufferToString(data.FieldValue(1));
      grid.Cells[colNama,i] := BufferToString(data.FieldValue(2));
      grid.Ints[colId,i] := BufferToInteger(data.FieldValue(0));
      grid.Cells[colTipe,i] := BufferToString(data.FieldValue(3));
      grid.AddRow;
      data.MoveNext;
  end;
  data.destroy;
  DeleteRowTerakhir(grid,2,1);
  grid.AutoSizeColumns(true,2);
  grid.ColWidths[colId] := 0;
end;

procedure TfrmMstAkun.ResetData;
begin
  txtKode.Text:= MstCode.GetNextCode;
  txtNama.Clear;
  txtNama.Tag:= 0;
end;

procedure TfrmMstAkun.txtKodeChange(Sender: TObject);
var sudah_enabled: boolean;
begin
  sudah_enabled:= tbtSave.Enabled;
  if not sudah_enabled then
    tbtSave.Enabled:= (Sender as TAdvEdit).Modified;
end;

procedure TfrmMstAkun.tbtNewClick(Sender: TObject);
begin
  ResetData;
  txtNama.SetFocus;

end;

procedure TfrmMstAkun.tbtSaveClick(Sender: TObject);
begin
  if isValid then isSaved
end;

procedure TfrmMstAkun.tbtDeleteClick(Sender: TObject);
begin
if not TSystemAccess.isCan(CAN_DELETE,AktiveControl.Tag) then exit;
  if Confirmed('Hapus data ?') then
  if TMstAkun.DeleteFromDb(grid.Ints[colId, grid.Row]) then begin
     grid.ClearRows(grid.Row,1);
     if grid.RowCount > 2 then grid.RemoveRows(grid.Row,1);

      //ReloadGrid;
  end;
end;

procedure TfrmMstAkun.tbtRefreshClick(Sender: TObject);
begin
  ReloadGrid
end;

procedure TfrmMstAkun.InitGrid;
begin
ResetGrid(grid, 2, colId+2, 1, 1,-1);
  grid.AutoSizeColumns(True, 4);
  grid.ColWidths[colId]:= 0;
  grid.RowHeights[1]:= grid.DefaultRowHeight;
end;

procedure TfrmMstAkun.gridClickCell(Sender: TObject; ARow, ACol: Integer);
begin
  inherited;
  if ARow > 0 then
    ReloadData(grid.Ints[colId,grid.Row]);
end;

procedure TfrmMstAkun.rgTypeClick(Sender: TObject);
begin
  inherited;
  tbtSave.Enabled:= true;
end;

end.
