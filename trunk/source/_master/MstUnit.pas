unit MstUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, Grids, BaseGrid, AdvGrid, WinXP, StdCtrls,
  AdvEdit, ExtCtrls,
  UMaster, SUIImagePanel,
  frmDockForm;

type
  TfrmMstUnit = class(TDockForm)
    WinXP1: TWinXP;
    ToolBar1: TToolBar;
    tbtNew: TToolButton;
    tbtSave: TToolButton;
    tbtDelete: TToolButton;
    ToolButton5: TToolButton;
    tbtRefresh: TToolButton;
    suiPanel1: TsuiPanel;
    suiPanel2: TsuiPanel;
    txtName: TAdvEdit;
    asgMaster: TAdvStringGrid;
    txtAlias: TAdvEdit;
    procedure tbtNewClick(Sender: TObject);
    procedure asgMasterClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure tbtSaveClick(Sender: TObject);
    procedure tbtRefreshClick(Sender: TObject);
    procedure asgMasterGetAlignment(Sender: TObject; ARow, ACol: Integer;
      var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tbtDeleteClick(Sender: TObject);
    procedure txtAliasChange(Sender: TObject);
  private
    MstUnit: TMstMaster;
    MstUnitArr: TMstMaster_Arr;
    PURPOSE: INTEGER;
    procedure InitGrid;
    procedure ArrangeColSize;
    procedure ReloadGrid;
    function isSaved:boolean;
    function isValid:boolean;
  public
    procedure Execute(id: integer); override;
  end;

var
  frmMstUnit: TfrmMstUnit;

implementation

uses MainMenu, UConst, Subroutines;

const
  colNo    = 0;
  colCode  = 1;
  colValue = 2;
  colId    = 3;

{$R *.dfm}

{ TfrmMstUnit }

procedure TfrmMstUnit.ArrangeColSize;
begin
  asgMaster.AutoSizeColumns(True, 6);
  asgMaster.ColWidths[colId]:= 0;
end;

procedure TfrmMstUnit.InitGrid;
begin
  ResetGrid(asgMaster, 2, 5,1,1,asgMaster.ColCount-1);
  ArrangeColSize;
end;

function TfrmMstUnit.isSaved: boolean;
begin
  MstUnit.MstName:= txtName.Text;
  MstUnit.MstId:= txtName.Tag;
  MstUnit.MstTipe:= PURPOSE;
  MstUnit.MstCode:= txtAlias.Text;
  
  if txtName.Tag <> 0 then
    Result:= MstUnit.UpdateOnDB
  else Result:= MstUnit.InsertOnDB;

  tbtSave.Enabled:= not Result;
  ReloadGrid;
end;

function TfrmMstUnit.isValid: boolean;
begin
  if CekInput(Result, txtName.Text <> '', 'Nama belum diisi.', txtName) then
  CekInput(Result,
  ((not MstUnit.isExistInDb(txtAlias.Text, PURPOSE)) and (txtName.Tag = 0)) or (txtName.Tag <> 0), 'Kode Sudah ada.', txtAlias)
end;

procedure TfrmMstUnit.tbtNewClick(Sender: TObject);
begin
  txtName.Clear;
  txtAlias.Clear;
  txtName.Tag:= 0;
  txtAlias.SetFocus;
  tbtSave.Enabled:= True;
end;

procedure TfrmMstUnit.asgMasterClickCell(Sender: TObject; ARow,
  ACol: Integer);
begin
  if (ARow > 0) then
  txtName.Tag  := StrToIntDef(asgMaster.Cells[colId, ARow],0);
  txtName.Text := asgMaster.Cells[colValue, ARow];
  txtAlias.Text:= asgMaster.Cells[colCode, ARow];
  tbtDelete.Enabled:= True;
end;

procedure TfrmMstUnit.ReloadGrid;
var i: integer;
begin
  MstUnitArr.LoadFromDb(PURPOSE);
  InitGrid;
  for i:= 0 to MstUnitArr.Count-1 do begin
    asgMaster.Ints[colId,    i+1]:= MstUnitArr[i].MstId;
    asgMaster.Cells[colValue,i+1]:= MstUnitArr[i].MstName;
    asgMaster.Cells[colCode, i+1]:= MstUnitArr[i].MstCode;
    asgMaster.AddRow;
  end;
  DeleteRowTerakhir(asgMaster,2,1);
  ArrangeColSize;
end;

procedure TfrmMstUnit.tbtSaveClick(Sender: TObject);
begin
  if isValid then isSaved
end;

procedure TfrmMstUnit.tbtRefreshClick(Sender: TObject);
begin
  ReloadGrid
end;

procedure TfrmMstUnit.asgMasterGetAlignment(Sender: TObject; ARow,
  ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  if ARow = 0 then HAlign:= taCenter
  else if ACol = colNo then HAlign:= taRightJustify
end;

procedure TfrmMstUnit.Execute(id: integer);
begin
  inherited;
  ToolBar1.ParentColor:= false;
  ToolBar1.Color:= clWhite;
  txtName.Clear;
  txtName.Tag:= 0;
  txtAlias.Tag:= 0;
  txtAlias.Clear;
  CASE Self.Tag OF
    201: PURPOSE:= MST_TYPE_GUDANG;
    203: PURPOSE:= MST_TYPE_CASHIER;
    204: PURPOSE:= MST_TYPE_SHIFT;
    205: PURPOSE:= MST_TYPE_UNIT;
    206: PURPOSE:= MST_TYPE_PRODUSEN;
    207: PURPOSE:= MST_TYPE_KEMASAN;
  END;

  MstUnit:= TMstMaster.Create();
  MstUnitArr:= TMstMaster_Arr.Create();
  ReloadGrid;
  Run(Self);
end;

procedure TfrmMstUnit.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if MstUnit <> nil then MstUnit.Free;
  MstUnit:= nil;
  if MstUnitArr <> nil then MstUnitArr.Free;
  MstUnitArr:= nil;
end;

procedure TfrmMstUnit.tbtDeleteClick(Sender: TObject);
begin
  if Confirmed('Hapus data?') then
  if TMstMaster.deleteMaster(asgMaster.Ints[colId, asgMaster.Row]) then begin
     asgMaster.ClearRows(asgMaster.Row,1);
     if asgMaster.RowCount > 2 then asgMaster.RemoveRows(asgMaster.Row,1);
  end;
end;

procedure TfrmMstUnit.txtAliasChange(Sender: TObject);
var sudah_enabled: boolean;
begin
  sudah_enabled:= tbtSave.Enabled;
  if not sudah_enabled then
    tbtSave.Enabled:= (Sender as TAdvEdit).Modified;
end;

end.
