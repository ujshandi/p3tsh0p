unit TrsItemShipmentList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, ToolWin, StdCtrls, AdvEdit, UTransaction,StrUtils,
  Grids, BaseGrid, AdvGrid, WinXP, SUIImagePanel, Math, DateUtils,
  frmDockForm;

type
  TfrmTrsItemShipmentList = class(TDockForm)
    ToolBar1: TToolBar;
    tbtNew: TToolButton;
    tbtDetail: TToolButton;
    ToolButton4: TToolButton;
    tbtRefresh: TToolButton;
    ToolButton2: TToolButton;
    tbtPrint: TToolButton;
    WinXP1: TWinXP;
    ToolButton5: TToolButton;
    suiPanel1: TsuiPanel;
    dtpAkhir: TDateTimePicker;
    dtpAwal: TDateTimePicker;
    cmbOpr: TComboBox;
    Label2: TLabel;
    Label1: TLabel;
    txtSpec: TAdvEdit;
    btnSpec: TButton;
    suiPanel2: TsuiPanel;
    grid: TAdvStringGrid;
    cmbTipe: TComboBox;
    lblTipe: TLabel;
    procedure tbtNewClick(Sender: TObject);
    procedure tbtDetailClick(Sender: TObject);
    procedure gridGetAlignment(Sender: TObject; ARow, ACol: Integer;
      var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure gridDblClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tbtRefreshClick(Sender: TObject);
    procedure ToolButton5Click(Sender: TObject);
    procedure btnSpecClick(Sender: TObject);
    procedure cmbOprChange(Sender: TObject);
    procedure tbtPrintClick(Sender: TObject);
  private
    Purpose: integer;
    procedure InitForm;
    procedure SetFilter;
    procedure InitFilter;
    procedure LoadData;
  public
    procedure Execute(id: integer); override;
  end;

var
  frmTrsItemShipmentList: TfrmTrsItemShipmentList;

implementation

uses Subroutines, MainMenu,
  MstCodeList, MySQLConnector, uMysqlClient, UConst, UMaster, UConstTool;

const
  colNo  = 0;
  colID  = 1;

{$R *.dfm}

{ TfrmTrsItemShipmentList }

procedure TfrmTrsItemShipmentList.Execute(id: integer);
begin
  inherited;
  ToolBar1.ParentColor:= false;
  ToolBar1.Color:= clWhite;
  Purpose:= id;
  InitForm;
  Run(Self);
end;

procedure TfrmTrsItemShipmentList.InitFilter;
begin
  GlobalFilter.Reset;
  GlobalPeriode.Reset;
  cmbTipe.ItemHeight:= 0;
  txtSpec.Tag:= 0;
// txtSpec.Text:= 'Semua Jenis Item';
  cmbOpr.ItemIndex:= 3;
  cmbOprChange(nil);
  dtpAwal.Date:= StartOfTheMonth(ServerNow);
  dtpAkhir.Date:= ServerNow;
end;

procedure TfrmTrsItemShipmentList.InitForm;
begin
  InitFilter;
  lblTipe.Visible := Purpose in [ITEM_TYPE_MUTASI_MASUK,ITEM_TYPE_MUTASI_KELUAR];
  cmbTipe.Visible := Purpose in [ITEM_TYPE_MUTASI_MASUK,ITEM_TYPE_MUTASI_KELUAR];
end;

procedure TfrmTrsItemShipmentList.LoadData;
var i,j: integer; header: TMysql_FieldDef; data: TMysqlResult;
begin
  try
    StartProgress;
    SetFilter;
    data:= TTrsShipment.LoadData;
    grid.Clear;
    grid.RowCount:= IfThen(data.RecordCount > 0, data.RecordCount + 1, 2);
    grid.ColCount:= data.FieldsCount+2;
    grid.FixedRows:= 1;
    for i:= 0 to data.FieldsCount-1 do begin
      header:= data.FieldDef(i)^;
      grid.Cells[i+1, 0]:= header.Name;
    end;

    data.First;
    for i:= 1 to data.RecordCount do begin
      grid.Ints[colNo,i] := i;
      for j:= 0 to data.FieldsCount-1 do
        grid.Cells[j+1,i]:= data.FieldValue(j);

      data.MoveNext;
    end;


    grid.AutoSizeColumns(TRUE, 4);
    grid.ColWidths[0]:= 18;
    grid.ColWidths[1]:= 0;
    if Purpose = ITEM_TYPE_OPNAME then
      grid.ColWidths[data.FieldsCount]:= 0;
    data.destroy;
  finally
    EndProgress;
  end;
end;

procedure TfrmTrsItemShipmentList.SetFilter;
begin
  GlobalFilter.Reset;
  GlobalPeriode.Reset;
  GlobalPeriode.setPeriode(cmbOpr.ItemIndex, dtpAwal.Date, dtpAkhir.Date);

  GlobalFilter.TipeId:= IntToStr(Purpose);
  if Purpose <> ITEM_TYPE_OPNAME then
    GlobalFilter.TipeId := IfThen(cmbTipe.ItemIndex=0,'-1',intToStr(cmbTipe.ItemIndex+1));

end;

procedure TfrmTrsItemShipmentList.tbtNewClick(Sender: TObject);
var NewTransaction: TDockForm;
begin
  if not TSystemAccess.isCan(CAN_ADD,AktiveControl.Tag) then exit;
  NewTransaction:= ShowForm(Purpose);
  NewTransaction.Execute(Purpose, 0);
end;

procedure TfrmTrsItemShipmentList.tbtDetailClick(Sender: TObject);
var NewTransaction: TDockForm;
begin
  if not TSystemAccess.isCan(CAN_VIEW,AktiveControl.Tag) then exit;
  NewTransaction:= ShowForm(Purpose);
  NewTransaction.Execute(Purpose, grid.Ints[colId, grid.Row]);
end;

procedure TfrmTrsItemShipmentList.gridGetAlignment(Sender: TObject;
  ARow, ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  if ARow = 0 then HAlign:= taCenter
  else if ACol = colNo then HAlign:= taRightJustify
end;

procedure TfrmTrsItemShipmentList.gridDblClickCell(Sender: TObject;
  ARow, ACol: Integer);
begin
  tbtDetail.Click
end;

procedure TfrmTrsItemShipmentList.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
//  if ShipmentList <> nil then ShipmentList.Free;
//  ShipmentList:= nil;
end;

procedure TfrmTrsItemShipmentList.tbtRefreshClick(Sender: TObject);
begin
  LoadData
end;

procedure TfrmTrsItemShipmentList.ToolButton5Click(Sender: TObject);
begin
  InitFilter
end;

procedure TfrmTrsItemShipmentList.btnSpecClick(Sender: TObject);
var vName: string; ID: integer;
begin
  ID := frmMstCodeList.Execute(1);
  if ID <> 0 then begin
    txtSpec.Tag := ID;
    GlobalFilter.SpecId:= txtSpec.Tag;
    txtSpec.Text:= TMstCode.getName(ID);
  end;
end;

procedure TfrmTrsItemShipmentList.cmbOprChange(Sender: TObject);
begin
  inherited;
  dtpAkhir.Enabled:= cmbOpr.ItemIndex = 3;
end;

procedure TfrmTrsItemShipmentList.tbtPrintClick(Sender: TObject);
begin
  if not TSystemAccess.isCan(CAN_PRINT,AktiveControl.Tag) then exit;
  if MustRegister then exit;
end;

end.
