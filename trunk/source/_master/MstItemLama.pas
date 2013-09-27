unit MstItemLama;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, BaseGrid, AdvGrid, StdCtrls, AdvEdit, ComCtrls, ToolWin,
  ExtCtrls, strUtils, Math,
  UMaster, WinXP, Menus, SUIImagePanel, UTransaction,
  frmDockForm, Buttons, SUIButton;

type
  TfrmMstItemLama = class(TDockForm)
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    tbtRefresh: TToolButton;
    WinXP1: TWinXP;
    ToolButton5: TToolButton;
    suiPanel1: TsuiPanel;
    suiPanel2: TsuiPanel;
    suiPanel3: TsuiPanel;
    grid: TAdvStringGrid;
    asgvc: TAdvStringGrid;
    txtNama: TAdvEdit;
    PopupMenu1: TPopupMenu;
    Aktivasi1: TMenuItem;
    txtCode: TAdvEdit;
    txtBarcode: TAdvEdit;
    txtLimit: TAdvEdit;
    spdFirst: TsuiButton;
    spdPrev: TsuiButton;
    spdNext: TsuiButton;
    spdLast: TsuiButton;
    lblHal: TLabel;
    MainMenu1: TMainMenu;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ToolButton5Click(Sender: TObject);
    procedure tbtRefreshClick(Sender: TObject);
    procedure Aktivasi1Click(Sender: TObject);
    procedure gridRowChanging(Sender: TObject; OldRow, NewRow: Integer;
      var Allow: Boolean);
    procedure txtLimitChange(Sender: TObject);
    procedure spdFirstClick(Sender: TObject);
    procedure spdPrevClick(Sender: TObject);
    procedure spdNextClick(Sender: TObject);
    procedure spdLastClick(Sender: TObject);
    procedure Button6Click(Sender: TObject);

  private
    procedure InitGrid;
    procedure InitForm;
    procedure SetFilter;
    procedure InitFilter;
    procedure LoadData;
  public
    procedure Execute(id: integer=0);override;
  end;

var
  frmMstItemLama: TfrmMstItemLama;

implementation

uses UConstTool, MainMenu, Subroutines, UConst,
  uMysqlClient, MySQLConnector;

const
  colNo      = 0;
  colId      = 1;
  colCode    = 2;
  colBarcode = 3;
  colName    = 4;
  colDosis   = 5;
  colExpire  = 6;
  colHBeli   = 7;
  colHDasar  = 8;
  colHRata   = 9;
  colHJual1  = 10;
  colStok    = 11;
  colRak     = 12;


{$R *.dfm}

{ TfrmMstItemList }

procedure TfrmMstItemLama.Execute(id: integer);
begin
  inherited;
  
  ToolBar1.ParentColor:= false;
  ToolBar1.Color:= clWhite;
  InitForm;
  SetFilter;
  LoadData;
  spdFirst.Enabled:= False;
  spdPrev.Enabled:= False;
  Run(Self);
end;

procedure TfrmMstItemLama.InitFilter;
begin
  lblHal.Caption:= 'Halaman : 1';
  GlobalPeriode.Reset;
  txtNama.Clear;
  txtCode.Clear;
  txtBarcode.Clear;
  txtLimit.Tag:=0;
  txtLimit.IntValue:= 100;
  txtLimitChange(nil);
end;

procedure TfrmMstItemLama.InitForm;
begin
  InitGrid;
  InitFilter;
end;

procedure TfrmMstItemLama.InitGrid;
begin
  grid.Clear;
  grid.RowCount:= 2;
end;

procedure TfrmMstItemLama.LoadData;
var i,j: integer; item: TMysqlResult;
header: TMysql_FieldDef;
begin
  try
    StartProgress;
    InitGrid;
    SetFilter;
    item:= TMstItemArr.LoadObatKF;

    grid.RowCount:= IfThen(item.RecordCount > 0, item.RecordCount + 1, 2);
    grid.ColCount:= item.FieldsCount+2;

    grid.FixedRows:= 1;
    for i:= 0 to item.FieldsCount-1 do begin
      header:= item.FieldDef(i)^;
      grid.Cells[i+1, 0]:= header.Name;
    end;
    
    for i:= 1 to item.RecordCount do begin
      for j:= 0 to item.FieldsCount-1 do
        grid.Cells[j+1,i]:= item.FieldValue(j);
      item.MoveNext;
    end;

    grid.AutoSizeColumns(TRUE, 4);

    spdNext.Enabled:= item.RecordCount >= txtLimit.IntValue;
    spdLast.Enabled:= item.RecordCount >= txtLimit.IntValue;
    item.destroy;

  finally
    EndProgress;
  end;
end;

procedure TfrmMstItemLama.SetFilter;
begin
  GlobalFilter.Name:= txtNama.Text;
  GlobalFilter.FString1:= txtCode.Text;
  GlobalFilter.FString2:= txtBarcode.Text;
  GlobalFilter.FOffset := txtLimit.IntValue;
  GlobalFilter.FLimit  := txtLimit.Tag;
end;

procedure TfrmMstItemLama.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  //if MstItem <> nil then MstItem.Free;
  //MstItem:= nil;
end;

procedure TfrmMstItemLama.ToolButton5Click(Sender: TObject);
begin
  InitFilter
end;

procedure TfrmMstItemLama.tbtRefreshClick(Sender: TObject);
begin
  txtLimit.Tag:= 0;
  lblHal.Caption:= 'Halaman: 1';
  spdFirst.Enabled:= False;
  spdPrev.Enabled:= False;
  LoadData;
end;

procedure TfrmMstItemLama.Aktivasi1Click(Sender: TObject);
begin
  TMstItem.activasi(grid.Ints[colId, grid.Row])
end;



procedure TfrmMstItemLama.gridRowChanging(Sender: TObject; OldRow,
  NewRow: Integer; var Allow: Boolean);
begin
  if OldRow <= grid.RowCount-1 then
    grid.RowHeights[OldRow]:= grid.DefaultRowHeight;
  grid.AutoSizeRow(NewRow);
  if grid.RowHeights[NewRow] < grid.DefaultRowHeight then
    grid.RowHeights[NewRow]:= grid.DefaultRowHeight;
end;

procedure TfrmMstItemLama.txtLimitChange(Sender: TObject);
begin
  spdFirst.Enabled:= txtLimit.IntValue > 0;
  spdPrev.Enabled:= txtLimit.IntValue > 0;
  spdNext.Enabled:= txtLimit.IntValue > 0;
  spdLast.Enabled:= txtLimit.IntValue > 0;
end;

procedure TfrmMstItemLama.spdFirstClick(Sender: TObject);
begin
  txtLimit.Tag:= 0;
  spdFirst.Enabled:= False;
  spdPrev.Enabled:= False;
  spdNext.Enabled:= True;
  spdLast.Enabled:= True;
  lblHal.Caption:= 'Halaman: 1';
  LoadData;
end;

procedure TfrmMstItemLama.spdPrevClick(Sender: TObject);
begin
  txtLimit.Tag:= txtLimit.Tag - txtLimit.IntValue;
  spdFirst.Enabled:= txtLimit.Tag > 0;
  spdPrev.Enabled:= txtLimit.Tag > 0;
  spdNext.Enabled:= True;
  spdLast.Enabled:= True;
  lblHal.Caption:= 'Halaman: ' + IntToStr((txtLimit.Tag + txtLimit.IntValue) div txtLimit.IntValue);
  LoadData;
end;

procedure TfrmMstItemLama.spdNextClick(Sender: TObject);
var lmt: integer;
begin
  SetFilter;
  lmt:= TMstItemArr.countKF;
  txtLimit.Tag:= txtLimit.Tag + txtLimit.IntValue;
  spdFirst.Enabled:= True;
  spdPrev.Enabled:= True;
  lblHal.Caption:= 'Halaman: ' + IntToStr((txtLimit.Tag+txtLimit.IntValue) div txtLimit.IntValue);

  //count 26;
  //limit 5
  //txtlimt.tag = 25

  spdNext.Enabled:= ((txtLimit.Tag + txtLimit.IntValue)<= lmt);
  spdLast.Enabled:= ((txtLimit.Tag + txtLimit.IntValue)<= lmt);
  LoadData;
end;

procedure TfrmMstItemLama.spdLastClick(Sender: TObject);
begin
  SetFilter;
  txtLimit.Tag:= txtLimit.IntValue * (TMstItemArr.countKF div txtLimit.IntValue);
  spdFirst.Enabled:= True;
  spdPrev.Enabled:= True;
  spdNext.Enabled:= False;
  spdLast.Enabled:= False;
  lblHal.Caption:= 'Halaman: ' + IntToStr((txtLimit.Tag + txtLimit.IntValue) div txtLimit.IntValue);
  LoadData;
end;


procedure TfrmMstItemLama.Button6Click(Sender: TObject);

begin

end;
    {TfrmMstItemList.spdNextClick
    spdLastClick}
end.
