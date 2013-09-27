unit ReportItemMovement;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, ToolWin, StdCtrls, AdvEdit, UTransaction,
  Grids, BaseGrid, AdvGrid, WinXP, SUIImagePanel, Math, DateUtils, strutils,
  frmDockForm;

type
  TfrmReportItemMovement = class(TDockForm)
    ToolBar1: TToolBar;
    tbtRefresh: TToolButton;
    ToolButton2: TToolButton;
    tbtPrint: TToolButton;
    WinXP1: TWinXP;
    ToolButton5: TToolButton;
    suiPanel1: TsuiPanel;
    txtSpec: TAdvEdit;
    btnSpec: TButton;
    suiPanel2: TsuiPanel;
    txtVendor: TAdvEdit;
    btnSpl: TButton;
    panelDate: TPanel;
    dtpAkhir: TDateTimePicker;
    dtpAwal: TDateTimePicker;
    Label2: TLabel;
    Label1: TLabel;
    cmbOpr: TComboBox;
    txtProdusen: TAdvEdit;
    Button5: TButton;
    cmbRange: TComboBox;
    txtRangeDari: TAdvEdit;
    txtRangeSampai: TAdvEdit;
    Label3: TLabel;
    Label4: TLabel;
    txtLimit: TAdvEdit;
    cmbLimit: TComboBox;
    txtNama: TAdvEdit;
    txtBarcode: TAdvEdit;
    txtCode: TAdvEdit;
    txtJenis: TAdvEdit;
    Button1: TButton;
    procedure gridGetAlignment(Sender: TObject; ARow, ACol: Integer;
      var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ToolButton5Click(Sender: TObject);
    procedure btnSpecClick(Sender: TObject);
    procedure btnSplClick(Sender: TObject);
    procedure cmbOprChange(Sender: TObject);
    procedure tbtPrintClick(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure cmbRangeChange(Sender: TObject);
    procedure tbtRefreshClick(Sender: TObject);
    procedure cmbLimitChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    grid: TAdvStringGrid;
    procedure InitGridBeli;
    procedure SetFilter;
    procedure InitFilter;
    procedure LoadData;
  public
    procedure Execute(id: integer); override;
  end;

var
  frmReportItemMovement: TfrmReportItemMovement;

implementation

uses Subroutines, MainMenu,
  MstCodeList, MySQLConnector, uMysqlClient, UConst, UMaster,
  LookupData, ReportItemMovementPrint;

const
  colNo = 0;
  colID = 1; //6
  colNama   = 2;
  colVendor = 3;
  colProd   = 4;
  colQty    = 5;
  colStok   = 6;


{$R *.dfm}

{ TfrmTrsItemShipmentList }

procedure TfrmReportItemMovement.Execute(id: integer);
begin
  inherited;
  ToolBar1.ParentColor:= false;
  ToolBar1.Color:= clWhite;
  InitGridBeli;
  InitFilter;
  Run(Self);
end;

procedure TfrmReportItemMovement.InitFilter;
begin
  GlobalFilter.Reset;
  GlobalPeriode.Reset;
  txtSpec.Clear;

  txtSpec.Tag:= 1;
  txtVendor.Clear;
  txtVendor.Tag:= 0;
  txtProdusen.Tag:= 0;
  txtSpec.EmptyText:= 'Semua Jenis Brg';
  txtJenis.Clear;
  txtJenis.EmptyText:= 'Semua Merk';
  txtJenis.Tag:= 0;
  txtVendor.Text:= 'Semua Supplier';
  txtProdusen.Text:= 'Semua Produsen';

  cmbOpr.ItemIndex:= 3;
  cmbOprChange(nil);
  dtpAwal.Date:= ServerNow;
  dtpAkhir.Date:= ServerNow;

  txtRangeDari.IntValue := -1;
  txtRangeSampai.IntValue:= 0;
  cmbRange.ItemIndex:= 0;
  cmbRangeChange(nil);
  txtLimit.IntValue:= 10;
  cmbLimit.ItemIndex:= 0;
  cmbLimitChange(nil);

  txtBarcode.Clear;
  txtCode.Clear;
  txtNama.Clear;

end;

procedure TfrmReportItemMovement.SetFilter;
begin
  GlobalFilter.Reset;
  GlobalFilter.RelasiID := txtVendor.Tag;
  GlobalFilter.SpecID   := txtSpec.Tag;
  GlobalFilter.Numeric1 := txtProdusen.Tag;
  GlobalFilter.Numeric2 := txtLimit.IntValue;
  GlobalFilter.StatusID := cmbLimit.ItemIndex;
//  GlobalFilter.Numeric4 := txtJenis.Tag;
  GlobalFilter.TipeID:= txtJenis.Text;  //merk
  GlobalFilter.FString1:= txtBarcode.Text;
  GlobalFilter.FString2:= txtCode.Text;
  GlobalFilter.Name    := txtNama.Text;

  globalPeriode.setPeriode(cmbOpr.ItemIndex, dtpAwal.Date, dtpAkhir.Date);
  GlobalPeriode.RangeAwal:= -1;
  GlobalPeriode.setRanges(cmbRange.ItemIndex-1, txtRangeDari.IntValue, txtRangeSampai.IntValue);
end;

procedure TfrmReportItemMovement.gridGetAlignment(Sender: TObject;
  ARow, ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  if ACol in[colNo, colQty, colStok] then HAlign:= taRightJustify;
end;

procedure TfrmReportItemMovement.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
//  if lsGudang <> nil then lsGudang.Free;
//  lsGudang:= nil;
end;

procedure TfrmReportItemMovement.ToolButton5Click(Sender: TObject);
begin
  InitFilter
end;

procedure TfrmReportItemMovement.btnSpecClick(Sender: TObject);
var ID: integer;
begin
  ID:= frmMstCodeList.Execute(1);
  if ID <> 0 then begin
    txtSpec.Tag := ID;
    GlobalFilter.SpecId:= txtSpec.Tag;
    txtSpec.Text:= TMstCode.getName(ID);
  end;
end;

procedure TfrmReportItemMovement.btnSplClick(Sender: TObject);
var id: integer;
begin
  id:= frmLookup.Execute('SPL');
  if Id > 0 then begin
    txtVendor.Text:= TMstRelation.GetName(id);
    txtVendor.Tag:= id;
  end;
end;


procedure TfrmReportItemMovement.cmbOprChange(Sender: TObject);
begin
  dtpAkhir.Enabled:= cmbOpr.ItemIndex = 3;
end;

procedure TfrmReportItemMovement.LoadData;
var i: integer; item: TMysqlResult;
begin
  try
    StartProgress;
    SetFilter;
    InitGridBeli;
    grid.BeginUpdate;
    //0item_id, 1item_name, 2spl, 3produsen, 4sum_qty
    if cmbLimit.ItemIndex = 2 then
      item:= TReport.LoadItemIddle
    else item:= TReport.LoadItemMovement;

    grid.RowCount:= IfThen(item.RecordCount > 0, item.RecordCount + 1, 2);
    for i:= 1 to item.RecordCount do begin
      ProsesProgress(i, item.RecordCount);

      grid.Ints[0,  i]:= i;
      grid.Cells[colID,  i]:= item.FieldValue(0);
      grid.Cells[colNama,i]:= item.FieldValue(1);
      grid.Cells[colVendor,i]:= item.FieldValue(2);
      grid.Cells[colProd,i]:= item.FieldValue(3);
      grid.Cells[colQty,i]:= FloatToStrFmtNull(BufferToFloat(item.FieldValue(4)))+'';
//      TMstMaster.getKode(BufferToInteger(item.FieldValue(5)));

      grid.Cells[colStok,i]:= FloatToStrFmtNull(
      TMstItem.GetSaldoAkhir(BufferToInteger(item.FieldValue(0)), 0, GetActualPeriode(GlobalPeriode, False)));

      item.MoveNext;
    end;
    item.destroy;
    grid.EndUpdate;
  finally
    EndProgress;
  end;
end;

procedure TfrmReportItemMovement.InitGridBeli;
begin
  try if grid <> nil then grid.Free;
  except end;

  grid:= TAdvStringGrid.Create(Self);
  grid.BeginUpdate;
  grid.Parent  := suiPanel2;
  grid.Top := 24;
  grid.Align   := alClient;
  grid.ColCount:= colStok + 1;
  grid.RowCount:= 2;

  grid.Options := [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goRowSelect];
  grid.OnGetAlignment := gridGetAlignment;
  grid.SortSettings.Column := 2;
  grid.SortSettings.Show:= True;
  grid.ColumnSize.Stretch := True;
  grid.ColumnSize.StretchColumn := 2;
  grid.FixedCols:= 1;
  grid.FixedRows:= 1;

  grid.FixedColor          := clFixedColum;
  grid.FixedFont.Color     := clFixedFont;
  grid.Font.Style          := [];
  grid.SelectionColor      := clSelection;
  grid.Color               := clGrid;
  grid.Bands.PrimaryColor  := clPrimaryBand;
  grid.Bands.SecondaryColor:= clSecondaryBand;
  grid.Font.Color          := clLabel;//clFixedFont;
  grid.SelectionTextColor  := clFixedColum;//clFixedFont;

  grid.Cells[colNama,   0]:= 'Deskripsi Barang';
  grid.Cells[colVendor, 0]:= 'Jenis Barang';
  grid.Cells[colProd,   0]:= 'Merk';
  grid.Cells[colQty,    0]:= 'Qty';
  grid.Cells[colStok,   0]:= 'Stok';

  grid.ColWidths[colVendor]:= 240;
  grid.ColWidths[colProd]:= 130;
  grid.ColWidths[colQty]:= 80;
  grid.ColWidths[colStok]:= 60;
  grid.ColWidths[colNo]:= 40;
  grid.ColWidths[colID]:= 0;
  grid.EndUpdate;
end;

procedure TfrmReportItemMovement.tbtPrintClick(Sender: TObject);
begin
  if MustRegister then exit;
  if GlobalSystemConfig.localSetting.PrinterAdm <> '' then begin
     if (getDefaultPrinter <> GlobalSystemConfig.localSetting.PrinterAdm) then
         setDefaultPrinter(GlobalSystemConfig.localSetting.PrinterAdm);
  end;

  try
    Application.CreateForm(TqrpReportItemMovement, qrpReportItemMovement);
    qrpReportItemMovement.Executes(grid);
  finally
    qrpReportItemMovement.Destroy;
  end;
end;

procedure TfrmReportItemMovement.Button5Click(Sender: TObject);
var id: integer;
begin
  id:= frmLookup.Execute('PRODUSEN');
  if Id > 0 then begin
    txtProdusen.Text:= TMstMaster.GetName(id);
    txtProdusen.Tag:= id;
  end;
end;

procedure TfrmReportItemMovement.cmbRangeChange(Sender: TObject);
begin
  txtRangeDari.Enabled := cmbRange.ItemIndex <> 0;
  txtRangeSampai.Enabled:= cmbRange.ItemIndex = 4;
end;

procedure TfrmReportItemMovement.tbtRefreshClick(Sender: TObject);
begin
  LoadData;
end;

procedure TfrmReportItemMovement.cmbLimitChange(Sender: TObject);
begin
  if cmbLimit.ItemIndex = 2 then begin
    txtRangeDari.IntValue := -1;
    txtRangeSampai.IntValue:= 0;
    cmbRange.ItemIndex:= 0;
    cmbRangeChange(nil);
    txtLimit.IntValue:= 0;
  end;
  txtLimit.Enabled:= cmbLimit.ItemIndex <> 2;
  txtRangeDari.Enabled:= cmbLimit.ItemIndex <> 2;
  txtRangeSampai.Enabled:= cmbLimit.ItemIndex <> 2;
  cmbRange.Enabled:= cmbLimit.ItemIndex <> 2;
end;

procedure TfrmReportItemMovement.Button1Click(Sender: TObject);
var id: integer;
begin
  id:= frmLookup.Execute('JNS_OBAT');
  if Id > 0 then begin
    txtJenis.Text:= TMstMaster.getJenis(id);
    txtJenis.Tag:= id;
  end;
end;

end.

