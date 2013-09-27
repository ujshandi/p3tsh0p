unit ReportDebt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, ToolWin, StdCtrls, AdvEdit, UTransaction,
  Grids, BaseGrid, AdvGrid, WinXP, SUIImagePanel, Math, DateUtils, strutils,
  frmDockForm;

type
  TfrmReportDebt = class(TDockForm)
    ToolBar1: TToolBar;
    tbtRefresh: TToolButton;
    ToolButton2: TToolButton;
    tbtPrint: TToolButton;
    WinXP1: TWinXP;
    ToolButton5: TToolButton;
    suiPanel1: TsuiPanel;
    suiPanel2: TsuiPanel;
    grid: TAdvStringGrid;
    txtVendor: TAdvEdit;
    Button1: TButton;
    panelDate: TPanel;
    dtpAkhir: TDateTimePicker;
    dtpAwal: TDateTimePicker;
    Label2: TLabel;
    Label1: TLabel;
    cmbOpr: TComboBox;
    cmbJenis: TComboBox;
    Label3: TLabel;
    procedure gridGetAlignment(Sender: TObject; ARow, ACol: Integer;
      var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tbtRefreshClick(Sender: TObject);
    procedure ToolButton5Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure cmbOprChange(Sender: TObject);
    procedure tbtPrintClick(Sender: TObject);
    procedure gridRowChanging(Sender: TObject; OldRow, NewRow: Integer;
      var Allow: Boolean);
    procedure cmbJenisChange(Sender: TObject);
  private
    procedure SetFilter;
    procedure InitFilter;
    procedure LoadData;

  public
    procedure Execute(id: integer); override;
  end;

var
  frmReportDebt: TfrmReportDebt;

implementation

uses Subroutines, MainMenu,
  MstCodeList, MySQLConnector, uMysqlClient, UConst, UMaster,
  LookupData, ReportSupplierSaldoPrint;

const
  colNo    = 0;
  colID    = 1; //6
  colNama  = 2;
  colAwal  = 3;
  colBeli  = 4;
  colRetur = 5;
  colBayar = 6;
  colAdjust= 7;
  colAKhir = 8;
         
{$R *.dfm}

{ TfrmTrsItemShipmentList }

procedure TfrmReportDebt.Execute(id: integer);
begin
  inherited;
  ToolBar1.ParentColor:= false;
  ToolBar1.Color:= clWhite;
  cmbJenis.ItemIndex:= 0;
  cmbJenisChange(nil);
  InitFilter;
  Run(Self);
end;

procedure TfrmReportDebt.InitFilter;
begin
  GlobalFilter.Reset;
  GlobalPeriode.Reset;
  txtVendor.Clear;
  txtVendor.Tag:= 0;
  txtVendor.Text:= 'Semua Supplier';
  cmbOpr.ItemIndex:= 3;
  cmbOprChange(nil);
  dtpAwal.Date:= ServerNow;
  dtpAkhir.Date:= ServerNow;
end;

procedure TfrmReportDebt.SetFilter;
begin
  GlobalFilter.Reset;
  GlobalFilter.RelasiID:= txtVendor.Tag;
  GlobalFilter.Numeric1:= cmbJenis.Tag;
  GlobalPeriode.setPeriode(cmbOpr.ItemIndex, dtpAwal.Date, dtpAkhir.Date);
end;

procedure TfrmReportDebt.gridGetAlignment(Sender: TObject;
  ARow, ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  if ACol > colNama then HAlign:= taRightJustify;
end;

procedure TfrmReportDebt.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
//  if lsGudang <> nil then lsGudang.Free;
//  lsGudang:= nil;
end;

procedure TfrmReportDebt.tbtRefreshClick(Sender: TObject);
begin
  LoadData;
end;

procedure TfrmReportDebt.ToolButton5Click(Sender: TObject);
begin
  InitFilter
end;

procedure TfrmReportDebt.Button1Click(Sender: TObject);
var id: integer;
begin
  if cmbJenis.Tag = TRANS_TYPE_PEMBAYARAN then
    id:= frmLookup.Execute('SPL')
  else id:= frmLookup.Execute('CUST');
  if Id > 0 then begin
    txtVendor.Text:= TMstRelation.GetName(id);
    txtVendor.Tag:= id;
  end;
end;

procedure TfrmReportDebt.cmbOprChange(Sender: TObject);
begin
  dtpAkhir.Enabled:= cmbOpr.ItemIndex = 3;
end;

procedure TfrmReportDebt.LoadData;
var i,j : integer; header: TMysql_FieldDef; data: TMysqlResult;
begin
  try
    StartProgress;
    SetFilter;
    grid.Clear;
    grid.AutoSizeColumns(TRUE, 4);
    grid.ColWidths[0]:= 18;
    grid.ColWidths[colAwal  ]:= 90;
    grid.ColWidths[colBeli  ]:= 90;
    grid.ColWidths[colRetur ]:= 90;
    grid.ColWidths[colBayar ]:= 90;
    grid.ColWidths[colAdjust]:= 90;
    grid.ColWidths[colAKhir ]:= 90;
    grid.ColWidths[1]:= 0;
    grid.RowHeights[1]:= grid.DefaultRowHeight;

    grid.FloatingFooter.Visible:= True;
    if cmbJenis.Tag = TRANS_TYPE_PEMBAYARAN then
      data:= TReport.LoadMutasiUtang
    else data:= TReport.LoadMutasiPiutang;

    grid.RowCount:= IfThen(data.RecordCount > 0, data.RecordCount + 2, 3);
    grid.ColCount:= data.FieldsCount+1;
    grid.FixedRows:= 1;

    for i:= 0 to data.FieldsCount-1 do begin
      header:= data.FieldDef(i)^;
      grid.Cells[i+1, 0]:= header.Name;
    end;

    data.First;
    for i:= 1 to data.RecordCount do begin
      for j:= 0 to data.FieldsCount-1 do

        if j = (colAwal-1) then
          grid.Cells[j+1,i]:= FloatToStrFmt(TMstRelation.GetSaldoAwal(BufferToInteger(data.FieldValue(0)), dtpAwal.Date))

        else if j = (colAkhir-1) then
          grid.Cells[colAKhir,i]:= FloatToStrFmt(
            grid.Floats[colAwal, i] + grid.Floats[colBeli, i] -
            grid.Floats[colRetur, i] - grid.Floats[colBayar, i] + grid.Floats[colAdjust, i])

        else if (j >= colAwal) and (j < colAkhir-1) then
          grid.Cells[j+1,i]:= FloatToStrFmt(BufferToFloat(data.FieldValue(j)))

        else grid.Cells[j+1,i]:= data.FieldValue(j);
      data.MoveNext;
    end;
    data.destroy;

    for i:= colAwal to grid.ColCount-1 do
      grid.FloatingFooter.ColumnCalc[i]:= acSUM;

  finally
    EndProgress;
  end;
end;

procedure TfrmReportDebt.tbtPrintClick(Sender: TObject);
begin
  if MustRegister then exit;
  try
    Application.CreateForm(TqrpReportSupplierSaldo, qrpReportSupplierSaldo);
    qrpReportSupplierSaldo.Executes(grid);
  finally
    qrpReportSupplierSaldo.Destroy;
  end;
end;

procedure TfrmReportDebt.gridRowChanging(Sender: TObject; OldRow,
  NewRow: Integer; var Allow: Boolean);
begin
  if OldRow <= grid.RowCount-1 then
    grid.RowHeights[OldRow]:= grid.DefaultRowHeight;
  grid.AutoSizeRow(NewRow);
  if grid.RowHeights[NewRow] < grid.DefaultRowHeight then
    grid.RowHeights[NewRow]:= grid.DefaultRowHeight;
end;

procedure TfrmReportDebt.cmbJenisChange(Sender: TObject);
begin
  case cmbJenis.ItemIndex of
    0: begin
         cmbJenis.Tag:= TRANS_TYPE_PEMBAYARAN;
         txtVendor.LabelCaption:= 'Supplier :';
       end;
    1: begin
         cmbJenis.Tag:= TRANS_TYPE_PIUTANG;
         txtVendor.LabelCaption:= 'Customer :';
       end;
    2: cmbJenis.Tag:= TRANS_TYPE_DANA_INPUT;
    3: cmbJenis.Tag:= TRANS_TYPE_DANA_OUTPUT;
  end;
end;

end.

