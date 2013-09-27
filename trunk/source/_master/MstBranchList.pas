unit MstBranchList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ExtCtrls, Grids, BaseGrid, AdvGrid, StdCtrls,
  AdvEdit, strUtils, Math, ADODB, uMysqlClient,MySQLConnector,
  UMaster, WinXP, Menus, SUIImagePanel,
  frmDockForm;

type
  TfrmMstBranchList = class(TDockForm)
    ToolBar1: TToolBar;
    tbtNew: TToolButton;
    tbtDetail: TToolButton;
    tbtRefresh: TToolButton;
    tbtPrint: TToolButton;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    WinXP1: TWinXP;
    ToolButton5: TToolButton;
    PopupMenu1: TPopupMenu;
    Aktivasi1: TMenuItem;
    suiPanel1: TsuiPanel;
    suiPanel2: TsuiPanel;
    txtNama: TAdvEdit;
    grid: TAdvStringGrid;
    txtKota: TAdvEdit;
    procedure tbtNewClick(Sender: TObject);
    procedure tbtDetailClick(Sender: TObject);
    procedure tbtRefreshClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ToolButton5Click(Sender: TObject);
    procedure Aktivasi1Click(Sender: TObject);
    procedure tbtPrintClick(Sender: TObject);
    procedure gridRowChanging(Sender: TObject; OldRow, NewRow: Integer;
      var Allow: Boolean);

    procedure cmbStatusChange(Sender: TObject);
    procedure gridDblClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure txtKodeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    procedure InitForm;
    procedure SetFilter;
    procedure InitFilter;
    procedure LoadData;

    procedure restoreDefault(Sender: TWinControl);

  public
    procedure Execute(ID: integer); override;
  end;

var
  frmMstBranchList: TfrmMstBranchList;

implementation

uses UConstTool, MainMenu, Subroutines,

  UTransaction, UConst, UQueryPackage, MstBranch,
  MstBranchListPrint;

const
  colNo     = 0;
  colKode   = 1;
  colNama   = 2;
  colAlamat = 3;
  colKota   = 4;
  colPhone  = 5;
  colPhone2 = 6;
  colID     = 7;


{$R *.dfm}

{ TfrmMstRelationList }

procedure TfrmMstBranchList.Execute(ID: integer);
begin
  inherited;
  ToolBar1.ParentColor:= false;
  ToolBar1.Color:= clWhite;
  InitForm;
  SetFilter;
  LoadData;
  Run(Self);
end;

procedure TfrmMstBranchList.InitFilter;
begin
  GlobalPeriode.Reset;
  txtNama.Text:= '';
end;

procedure TfrmMstBranchList.InitForm;
begin
  InitFilter;
end;

procedure TfrmMstBranchList.LoadData;
var i: integer; relasi: tmysqlResult;
begin
  try
    Screen.Cursor:= crSQLWait;

    SetFilter;
    relasi:= TMstBranch.loadFromDB;

    grid.ClearNormalCells;
    grid.RemoveRows(2, grid.RowCount-2);
    grid.RowCount:= IfThen(relasi.RecordCount > 0, relasi.RecordCount +1, 2);
    grid.ColCount:= colID+2;
    grid.FixedRows:= 1;

   //0branch_id, 1branch_name, 2address,  3phone1, 4phone2, 5fax, 6city, 7postal_code, 8branch_code
    for i:= 1 to relasi.RecordCount do begin
      grid.Ints[0,i]:= i;

      grid.Cells[colKode,  i]:= BufferToString(relasi.FieldValue(8));
      grid.Cells[colNama,  i]:= BufferToString(relasi.FieldValue(1));
      grid.Cells[colAlamat,i]:= BufferToString(relasi.FieldValue(2));
      grid.Cells[colKota,  i]:= BufferToString(relasi.FieldValue(6));
      grid.Cells[colPhone, i]:= BufferToString(relasi.FieldValue(3));
      grid.Cells[colPhone2, i]:= BufferToString(relasi.FieldValue(4));

      grid.Ints[colID,     i]:= BufferToInteger(relasi.FieldValue(0));
      relasi.MoveNext;
    end;
    relasi.destroy;
    grid.AutoSizeColumns(True, 3);
    grid.ColWidths[colID]:= 0;

  finally
    Screen.Cursor:= crDefault;
  end;
end;

procedure TfrmMstBranchList.SetFilter;
begin
  GlobalFilter.Name    := txtNama.Text;
//  GlobalFilter.FString2:= txtKota.Text;
end;

procedure TfrmMstBranchList.tbtNewClick(Sender: TObject);
begin
//    if not GlobalSystemUser.CanAccess(TAG_NEW) then exit;
if not TSystemAccess.isCan(CAN_ADD,AktiveControl.Tag) then exit;
  frmMstBranch.Execute(0);
end;

procedure TfrmMstBranchList.tbtDetailClick(Sender: TObject);
begin
//    if not GlobalSystemUser.CanAccess(TAG_DETAIL) then exit;
if not TSystemAccess.isCan(CAN_EDIT,AktiveControl.Tag) then exit;
  frmMstBranch.Execute(grid.Ints[colID, grid.Row]);
end;

procedure TfrmMstBranchList.tbtRefreshClick(Sender: TObject);
begin
//    if not GlobalSystemUser.CanAccess(TAG_LOAD) then exit;
  LoadData
end;

procedure TfrmMstBranchList.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  //if Relation <> nil then Relation.Free;
  //Relation:= nil;
end;

procedure TfrmMstBranchList.ToolButton5Click(Sender: TObject);
begin
//    if not GlobalSystemUser.CanAccess(TAG_RESET) then exit;
  InitFilter
end;

procedure TfrmMstBranchList.Aktivasi1Click(Sender: TObject);
begin
  TMstBranch.activasi(grid.Ints[colId, grid.Row])
end;

procedure TfrmMstBranchList.tbtPrintClick(Sender: TObject);
begin
if not TSystemAccess.isCan(CAN_PRINT,AktiveControl.Tag) then exit;
//    if not GlobalSystemUser.CanAccess(TAG_PRINT) then exit;
  if MustRegister then exit;
  try
    Application.CreateForm(TqrpMstBranchList, qrpMstBranchList);

    qrpMstBranchList.Executes(grid);
  finally
    qrpMstBranchList.Destroy;
  end;
end;

procedure TfrmMstBranchList.gridRowChanging(Sender: TObject; OldRow,
  NewRow: Integer; var Allow: Boolean);
begin
  if OldRow <= grid.RowCount-1 then
  grid.RowHeights[OldRow]:= grid.DefaultRowHeight;
  grid.AutoSizeRow(NewRow);
  if grid.RowHeights[NewRow] < grid.DefaultRowHeight then
    grid.RowHeights[NewRow]:= grid.DefaultRowHeight;
end;

procedure TfrmMstBranchList.cmbStatusChange(Sender: TObject);
begin
  inherited;
//
end;

procedure TfrmMstBranchList.gridDblClickCell(Sender: TObject; ARow,
  ACol: Integer);
begin
  tbtDetail.Click
end;

procedure TfrmMstBranchList.restoreDefault(Sender: TWinControl);
begin
  if Sender.Name = 'txtNama' then txtNama.Text:= ''
  else if Sender.Name = 'txtKota' then txtKota.Text:= ''
end;

procedure TfrmMstBranchList.txtKodeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_RETURN: tbtRefresh.Click;
    VK_F1: restoreDefault((Sender as TWinControl));
  end;
end;

end.
