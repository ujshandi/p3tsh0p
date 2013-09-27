unit MstProdusen;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, Grids, BaseGrid, AdvGrid, WinXP, StdCtrls,
  AdvEdit, ExtCtrls,
  UMaster, SUIImagePanel,
  frmDockForm;

type
  TfrmMstProdusen = class(TDockForm)
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
    txtAlamat: TAdvEdit;
    txtPhone: TAdvEdit;
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
  frmMstProdusen: TfrmMstProdusen;

implementation

uses MainMenu, UConst, Subroutines, AutoStockLine;

const
  colNo    = 0;
  colCode  = 1;
  colValue = 2;
  colAlamat= 3;
  colPhone = 4;
  colId    = 5;

{$R *.dfm}

{ TfrmMstUnit }

procedure TfrmMstProdusen.ArrangeColSize;
begin
  asgMaster.AutoSizeColumns(True, 6);
  asgMaster.ColWidths[colId]:= 0;
end;

procedure TfrmMstProdusen.InitGrid;
begin
  ResetGrid(asgMaster, 2, 7,1,1,asgMaster.ColCount-1);
  ArrangeColSize;
end;

function TfrmMstProdusen.isSaved: boolean;
begin
  MstUnit.MstName:= txtName.Text;
  MstUnit.MstId:= txtName.Tag;
  MstUnit.MstTipe:= PURPOSE;
  MstUnit.MstCode:= txtAlias.Text;
  MstUnit.Alamat:= txtAlamat.Text;
  MstUnit.phone:= txtPhone.Text;

  if txtName.Tag <> 0 then
    Result:= MstUnit.UpdateProdusen
  else Result:= MstUnit.InsertProdusen;

  tbtSave.Enabled:= not Result;
  ReloadGrid;
end;

function TfrmMstProdusen.isValid: boolean;
begin
  if CekInput(Result, txtName.Text <> '', 'Nama belum diisi.', txtName) then
  CekInput(Result,
  ((not MstUnit.isExistInDb(txtAlias.Text, PURPOSE)) and (txtName.Tag = 0)) or (txtName.Tag <> 0), 'Kode Sudah ada.', txtAlias)
end;

procedure TfrmMstProdusen.tbtNewClick(Sender: TObject);
begin
  txtName.Clear;
  txtAlias.Clear;
  txtName.Tag:= 0;
  txtAlias.SetFocus;
  tbtSave.Enabled:= True;
end;

procedure TfrmMstProdusen.asgMasterClickCell(Sender: TObject; ARow,
  ACol: Integer);
begin
  if (ARow > 0) then
  txtName.Tag  := StrToIntDef(asgMaster.Cells[colId, ARow],0);
  txtName.Text := asgMaster.Cells[colValue, ARow];
  txtAlias.Text:= asgMaster.Cells[colCode, ARow];
  txtAlamat.Text:= asgMaster.Cells[colAlamat, ARow];
  txtPhone.Text:= asgMaster.Cells[colPhone, ARow];
  tbtDelete.Enabled:= True;
end;

procedure TfrmMstProdusen.ReloadGrid;
var i: integer;
begin
  MstUnitArr.LoadFromDb(PURPOSE);
  InitGrid;
  for i:= 0 to MstUnitArr.Count-1 do begin
    asgMaster.Ints[colId,    i+1]:= MstUnitArr[i].MstId;
    asgMaster.Cells[colValue,i+1]:= MstUnitArr[i].MstName;
    asgMaster.Cells[colCode, i+1]:= MstUnitArr[i].MstCode;
    asgMaster.Cells[colAlamat, i+1]:= MstUnitArr[i].Alamat;
    asgMaster.Cells[colPhone, i+1]:= MstUnitArr[i].phone;
    asgMaster.AddRow;
  end;
  DeleteRowTerakhir(asgMaster,2,1);
  ArrangeColSize;
end;

procedure TfrmMstProdusen.tbtSaveClick(Sender: TObject);
begin
  if isValid then isSaved
end;

procedure TfrmMstProdusen.tbtRefreshClick(Sender: TObject);
begin
  ReloadGrid
end;

procedure TfrmMstProdusen.asgMasterGetAlignment(Sender: TObject; ARow,
  ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  if ARow = 0 then HAlign:= taCenter
  else if ACol = colNo then HAlign:= taRightJustify
end;

procedure TfrmMstProdusen.Execute(id: integer);
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

procedure TfrmMstProdusen.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if MstUnit <> nil then MstUnit.Free;
  MstUnit:= nil;
  if MstUnitArr <> nil then MstUnitArr.Free;
  MstUnitArr:= nil;
end;

procedure TfrmMstProdusen.tbtDeleteClick(Sender: TObject);
begin
  if Confirmed('Hapus data?') then
  if TMstMaster.deleteMaster(asgMaster.Ints[colId, asgMaster.Row]) then begin
     asgMaster.ClearRows(asgMaster.Row,1);
     if asgMaster.RowCount > 2 then asgMaster.RemoveRows(asgMaster.Row,1);
  end;
end;

procedure TfrmMstProdusen.txtAliasChange(Sender: TObject);
var sudah_enabled: boolean;
begin
  sudah_enabled:= tbtSave.Enabled;
  if not sudah_enabled then
    tbtSave.Enabled:= (Sender as TAdvEdit).Modified;
end;

end.
