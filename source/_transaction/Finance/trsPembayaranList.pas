unit trsPembayaranList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, ToolWin, StdCtrls, AdvEdit, UTransaction,
  Grids, BaseGrid, AdvGrid, WinXP, SUIImagePanel, Math, DateUtils, strutils,
  frmDockForm;

type
  TfrmTrsPembayaranList = class(TDockForm)
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
    suiPanel2: TsuiPanel;
    grid: TAdvStringGrid;
    Label3: TLabel;
    cmbJenis: TComboBox;
    procedure tbtNewClick(Sender: TObject);
    procedure tbtDetailClick(Sender: TObject);
    procedure gridGetAlignment(Sender: TObject; ARow, ACol: Integer;
      var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure gridDblClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tbtRefreshClick(Sender: TObject);
    procedure ToolButton5Click(Sender: TObject);
    procedure cmbOprChange(Sender: TObject);
    procedure tbtPrintClick(Sender: TObject);
  private
    procedure InitForm;
    procedure SetFilter;
    procedure InitFilter;
    procedure LoadData;
  public
    procedure Execute(id: integer); override;
  end;

var
  frmTrsPembayaranList: TfrmTrsPembayaranList;

implementation

uses Subroutines, MainMenu,
  MstCodeList, MySQLConnector, uMysqlClient, UConst, UMaster,
  LookupData, MoneyTransaction, UConstTool, trsPembayaranListPrint;

const
  colNo    = 0;
  colID    = 1; //6

{$R *.dfm}

{ TfrmTrsItemShipmentList }


procedure TfrmTrsPembayaranList.Execute(id: integer);
begin
  inherited;
  ToolBar1.ParentColor:= false;
  ToolBar1.Color:= clWhite;
  cmbJenis.ItemIndex:= 0;
  InitForm;
  Run(Self);
end;

procedure TfrmTrsPembayaranList.InitFilter;
begin
  GlobalFilter.Reset;
  GlobalPeriode.Reset;
  cmbJenis.ItemIndex := 0;
  cmbOpr.ItemIndex:= 3;
  cmbOprChange(nil);
  dtpAwal.Date:= StartOfTheMonth(ServerNow);
  dtpAkhir.Date:= ServerNow;

end;

procedure TfrmTrsPembayaranList.InitForm;
begin
  InitFilter;
//  Label3.Caption:= IfThen(purpose = TRANS_TYPE_ORDER, 'Tgl Kirim :', 'Tgl Expr :');

end;


procedure TfrmTrsPembayaranList.LoadData;
var i,j, col_idx: integer; header: TMysql_FieldDef; data: TMysqlResult;
begin
  try
    StartProgress;
    SetFilter;
    grid.Clear;
    data:= TTrsMoneyTransaction.LoadRekap;

    grid.RowCount:= IfThen(data.RecordCount > 0, data.RecordCount + 2, 3);
    grid.ColCount:= data.FieldsCount+2;
    grid.FixedRows:= 1;
    grid.FloatingFooter.Visible:= True;
    for i:= 0 to data.FieldsCount-1 do begin
      header:= data.FieldDef(i)^;
      grid.Cells[i+1, 0]:= header.Name;
    end;

    col_idx:= 5;
    data.First;
    for i:= 1 to data.RecordCount do begin
    //0money_trans_id, 1t.trans_num , 2t.trans_date , 3t.Total,4t.notes 
      for j:= 0 to data.FieldsCount-1 do
        if (j = 3) then
          grid.Cells[j+1,i]:= FloatToStrFmt(BufferToFloat(data.FieldValue(j)))
        else if (j = 2) then grid.Dates[j+1,i]:= BufferToDateTime(data.FieldValue(j))
        else grid.Cells[j+1,i]:= data.FieldValue(j);
      data.MoveNext;
    end;
    data.destroy;

  //  for i:= col_idx to grid.ColCount-2 do
     grid.Cells[4, grid.RowCount-1]:= FloatToStrFmt(grid.ColumnSum(4, 1, grid.RowCount-2));

    grid.AutoNumberCol(colNo);  
    grid.AutoSizeColumns(TRUE, 4);
    grid.ColWidths[0]:= 18;
    grid.ColWidths[1]:= 0;

  finally
    EndProgress;
  end;
end;

procedure TfrmTrsPembayaranList.SetFilter;
begin
  GlobalPeriode.Reset;
  GlobalPeriode.setPeriode(cmbOpr.ItemIndex, dtpAwal.Date, dtpAkhir.Date);
  GlobalFilter.Reset;
  GlobalFilter.SeriesID:= cmbJenis.ItemIndex;
//  GlobalFilter.TipeID  := IntToStr(cmbJensi.Tag);
end;

procedure TfrmTrsPembayaranList.tbtNewClick(Sender: TObject);
///var NewTransaction: TDockForm;
begin
//  NewTransaction:= ShowForm(cmbJenis.Tag);
 // NewTransaction.Execute(cmbJenis.Tag, 0);
  if TSystemAccess.isCan(CAN_ADD,AktiveControl.Tag) then
     frmMoneyTransaction.Execute(0);
end;

procedure TfrmTrsPembayaranList.tbtDetailClick(Sender: TObject);
begin
  if not TSystemAccess.isCan(CAN_VIEW,AktiveControl.Tag) then exit;
  frmMoneyTransaction.Execute(StrToIntDef(grid.Cells[colId, grid.Row],0));
end;

procedure TfrmTrsPembayaranList.gridGetAlignment(Sender: TObject;
  ARow, ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  if ACol in[4] then HAlign:= taRightJustify
end;

procedure TfrmTrsPembayaranList.gridDblClickCell(Sender: TObject;
  ARow, ACol: Integer);
begin
  tbtDetail.Click
end;

procedure TfrmTrsPembayaranList.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  //if ShipmentList <> nil then ShipmentList.Free;
  //ShipmentList:= nil;
end;

procedure TfrmTrsPembayaranList.tbtRefreshClick(Sender: TObject);
begin
  LoadData
end;

procedure TfrmTrsPembayaranList.ToolButton5Click(Sender: TObject);
begin
  InitFilter
end;

procedure TfrmTrsPembayaranList.cmbOprChange(Sender: TObject);
begin
  dtpAkhir.Enabled:= cmbOpr.ItemIndex = 3;
end;

procedure TfrmTrsPembayaranList.tbtPrintClick(Sender: TObject);
begin
  if MustRegister then exit;
  if TSystemAccess.isCan(CAN_PRINT,AktiveControl.Tag) then
    if GlobalSystemConfig.localSetting.PrinterAdm <> '' then begin
     if (getDefaultPrinter <> GlobalSystemConfig.localSetting.PrinterAdm) then
         setDefaultPrinter(GlobalSystemConfig.localSetting.PrinterAdm);
  end;

  try
    Application.CreateForm(TqrpPembayaranListPrint, qrpPembayaranListPrint);
    qrpPembayaranListPrint.Executes(grid);
  finally
    qrpPembayaranListPrint.Destroy;
  end;

end;

end.
