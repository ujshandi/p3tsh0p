unit MstDokterList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ExtCtrls, Grids, BaseGrid, AdvGrid, StdCtrls,
  AdvEdit, strUtils, Math,
  UMaster, WinXP, Menus, SUIImagePanel,
  frmDockForm;

type
  TfrmMstDokterList = class(TDockForm)
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
    txtAlamat: TAdvEdit;
    cmbStatus: TComboBox;
    Label1: TLabel;
    ToolButton3: TToolButton;
    procedure gridGetAlignment(Sender: TObject; ARow, ACol: Integer;
      var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure tbtNewClick(Sender: TObject);
    procedure tbtDetailClick(Sender: TObject);
    procedure tbtRefreshClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ToolButton3Click(Sender: TObject);
    procedure ToolButton5Click(Sender: TObject);
    procedure Aktivasi1Click(Sender: TObject);
    procedure tbtPrintClick(Sender: TObject);
    procedure gridRowChanging(Sender: TObject; OldRow, NewRow: Integer;
      var Allow: Boolean);
    procedure gridClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure cmbStatusChange(Sender: TObject);
    procedure gridDblClickCell(Sender: TObject; ARow, ACol: Integer);
  private
    procedure InitForm;
    procedure SetFilter;
    procedure InitFilter;
    procedure LoadData;

  public
    procedure Execute(ID: integer); override;
  end;

var
  frmMstDokterList: TfrmMstDokterList;

implementation

uses UConstTool, MainMenu, Subroutines,
  uMysqlClient, MySQLConnector, 
  UTransaction, UConst, MstDokter, DokterListPrint;

const
  colNo = 0;
  colId = 1;
  colKode   = 2;
  colNama   = 3;
  colAlamat = 4;
  colPhone  = 5;

{$R *.dfm}

{ TfrmMstRelationList }

procedure TfrmMstDokterList.Execute(ID: integer);
begin
  inherited;
  ToolBar1.ParentColor:= false;
  ToolBar1.Color:= clWhite;

  InitForm;
  SetFilter;
  LoadData;
  Run(Self);
end;

procedure TfrmMstDokterList.InitFilter;
begin
  GlobalPeriode.Reset;
  txtNama.Clear;
  txtAlamat.Clear;
  cmbStatus.ItemIndex:= 1;
  cmbStatusChange(nil);
end;

procedure TfrmMstDokterList.InitForm;
begin
  InitFilter;
end;

procedure TfrmMstDokterList.LoadData;
var i,j: integer; header: TMysql_FieldDef; relasi: TMysqlResult;
begin
  try
    Screen.Cursor:= crSQLWait;

    SetFilter;
    relasi:= TMstDokter.LoadFromDB;
    grid.Clear;
    grid.RowCount:= IfThen(relasi.RecordCount > 0, relasi.RecordCount + 1, 2);
    grid.ColCount:= 7;

    grid.FixedRows:= 1;
    for i:= 0 to relasi.FieldsCount-1 do begin
      header:= relasi.FieldDef(i)^;
      grid.Cells[i+1, 0]:= header.Name;
    end;

    //'0relation_id, 1KD, 2Nama, 3alamat, 4Kota, 5Phone
    for i:= 1 to relasi.RecordCount do begin
      grid.Ints[0,i]:= i;
      for j:= 0 to relasi.FieldsCount-1 do
          grid.Cells[j+1,i]:= relasi.FieldValue(j);
      relasi.MoveNext;
    end;
    relasi.destroy;

  finally
    grid.AutoSizeColumns(True, 5);
    grid.ColWidths[colID]:= 0;

    Screen.Cursor:= crDefault;
  end;
end;

procedure TfrmMstDokterList.SetFilter;
begin
  GlobalFilter.StatusID:= cmbStatus.ItemIndex;
  GlobalFilter.Name    := txtNama.Text;
  GlobalFilter.FString1:= txtAlamat.Text;
end;

procedure TfrmMstDokterList.gridGetAlignment(Sender: TObject; ARow,
  ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  if (ACol = 0) then HAlign:= taRightJustify
end;

procedure TfrmMstDokterList.tbtNewClick(Sender: TObject);
begin
  frmMstDokter.Execute(0);
end;

procedure TfrmMstDokterList.tbtDetailClick(Sender: TObject);
begin
  frmMstDokter.Execute(StrToIntDef(grid.Cells[colId, grid.Row],0));
end;

procedure TfrmMstDokterList.tbtRefreshClick(Sender: TObject);
begin
  LoadData
end;

procedure TfrmMstDokterList.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  //if Relation <> nil then Relation.Free;
  //Relation:= nil;
end;

procedure TfrmMstDokterList.ToolButton3Click(Sender: TObject);
begin
  if Confirmed('Hapus Item?') then
  if TMstDokter.deleteDate(grid.Ints[colId, grid.Row]) then begin
     grid.ClearRows(grid.Row,1);
     if grid.RowCount > 2 then grid.RemoveRows(grid.Row,1);
  end;
end;

procedure TfrmMstDokterList.ToolButton5Click(Sender: TObject);
begin
  InitFilter
end;

procedure TfrmMstDokterList.Aktivasi1Click(Sender: TObject);
begin
  TMstRelation.activasi(grid.Ints[colId, grid.Row])
end;

procedure TfrmMstDokterList.tbtPrintClick(Sender: TObject);
begin
  if MustRegister then exit;
  try
    Application.CreateForm(TqrpDokterList, qrpDokterList);
    //qrpDokterList.Printer.PrinterIndex:= -1;
    qrpDokterList.Executes(grid);
  finally
    qrpDokterList.Destroy;
  end;
end;

procedure TfrmMstDokterList.gridRowChanging(Sender: TObject; OldRow,
  NewRow: Integer; var Allow: Boolean);
begin
  if OldRow <= grid.RowCount-1 then
  grid.RowHeights[OldRow]:= grid.DefaultRowHeight;
  grid.AutoSizeRow(NewRow);
  if grid.RowHeights[NewRow] < grid.DefaultRowHeight then
    grid.RowHeights[NewRow]:= grid.DefaultRowHeight;
end;

procedure TfrmMstDokterList.gridClickCell(Sender: TObject; ARow,
  ACol: Integer);
begin
  grid.AutoSizeRow(grid.Row);
end;

procedure TfrmMstDokterList.cmbStatusChange(Sender: TObject);
begin
  inherited;
//
end;

procedure TfrmMstDokterList.gridDblClickCell(Sender: TObject; ARow,
  ACol: Integer);
begin
  tbtDetail.Click
end;

end.
