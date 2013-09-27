unit ReportItemQty;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, ToolWin, StdCtrls, AdvEdit, UTransaction,
  Grids, BaseGrid, AdvGrid, WinXP, SUIImagePanel, Math, DateUtils, strutils,
  frmDockForm;

type
  TfrmReportItemQty = class(TDockForm)
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
    txtShift: TAdvEdit;
    txtKasir: TAdvEdit;
    btnKasir: TButton;
    Button3: TButton;
    txtProdusen: TAdvEdit;
    txtCust: TAdvEdit;
    btnCust: TButton;
    Button5: TButton;
    txtItem: TAdvEdit;
    btnItem: TButton;
    cmbJenis: TComboBox;
    Label4: TLabel;
    txtJenis: TAdvEdit;
    Button1: TButton;
    procedure gridGetAlignment(Sender: TObject; ARow, ACol: Integer;
      var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tbtRefreshClick(Sender: TObject);
    procedure ToolButton5Click(Sender: TObject);
    procedure btnSpecClick(Sender: TObject);
    procedure btnSplClick(Sender: TObject);
    procedure cmbOprChange(Sender: TObject);
    procedure tbtPrintClick(Sender: TObject);
    procedure btnKasirClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure btnCustClick(Sender: TObject);
    procedure btnItemClick(Sender: TObject);
    procedure cmbJenisChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    grid: TAdvStringGrid;
    procedure InitGridMutasi;
    procedure SetFilter;
    procedure InitFilter;
    procedure LoadDataJual;
    procedure LoadDataBeli;
  public
    procedure Execute(id: integer); override;
  end;

var
  frmReportItemQty: TfrmReportItemQty;

implementation

uses Subroutines, MainMenu,
  MstCodeList, MySQLConnector, uMysqlClient, UConst, UMaster,
  LookupData, ReportJualPrint, UConstTool;

const
  colNo = 0;
  colID = 1; //6

  colNama       = 2;
  colUnit       = 3;
  colJual       = 4;
  colNilaiJual  = 5;
  colDiscJual   = 6;
  colTotalJual  = 7;
  colDiscTotal  = 8;
  colRetur      = 9;
  colNilaiRetur = 10;
  colProfit     = 11;

{$R *.dfm}

{ TfrmTrsItemShipmentList }

procedure TfrmReportItemQty.Execute(id: integer);
begin
  inherited;
  ToolBar1.ParentColor:= false;
  ToolBar1.Color:= clWhite;
  txtShift.Visible:= Self.Tag = 502;
  txtKasir.Visible:= Self.Tag = 502;
  txtCust.Visible:= Self.Tag = 502;
  btnKasir.Visible:= Self.Tag = 502;
  Button3.Visible:= Self.Tag = 502;
  btnCust.Visible:= Self.Tag = 502;

  cmbJenis.Visible:= Self.Tag = 502;
  Label4.Visible:= Self.Tag = 502;

  txtVendor.Left:=   IfThen(Self.Tag = 502, 254, 532);
  txtVendor.Top:=    IfThen(Self.Tag = 502,  72, 24);
//  btnSpl.Left:=      IfThen(Self.Tag = 502, 426, 704);
//  btnSpl.Top:=       IfThen(Self.Tag = 502,  74, 26);
//  txtItem.Left:=     IfThen(Self.Tag = 502, 254, 532);
//  txtItem.Top:=      IfThen(Self.Tag = 502,  96, 48);
//  btnItem.Left:=     IfThen(Self.Tag = 502, 426, 704);
//  btnItem.Top:=      IfThen(Self.Tag = 502,  98, 50);
  suiPanel1.Height:= IfThen(Self.Tag = 502, 123, 75);
  InitGridMutasi;
  InitFilter;
  Run(Self);
end;

procedure TfrmReportItemQty.InitFilter;
begin
  GlobalFilter.Reset;
  GlobalPeriode.Reset;
  txtSpec.Clear;
  txtSpec.Tag:= 1;
  txtVendor.Clear;
  txtVendor.Tag:= 0;
  txtKasir.Tag:= 0;
  txtShift.Tag:= 0;
  txtProdusen.Tag:= 0;
  txtCust.Tag:= 0;
  txtItem.Tag:= 0;
  txtSpec.Text:= 'SPEC OBAT';
  txtVendor.Text:= 'Semua Supplier';
  txtShift.Text:= 'Semua Shift';
  txtKasir.Text:= 'Semua Kasir';
  txtProdusen.Text:= 'Semua Produsen';
  txtCust.Text:= 'Semua Pasien';
  txtItem.Text:= 'Semua Item';
  txtJenis.Text:= 'JENIS OBAT';
  txtJenis.Tag:= 0;
  cmbJenis.ItemIndex:= 0;
  cmbJenisChange(nil);
  cmbOpr.ItemIndex:= 3;
  cmbOprChange(nil);
  dtpAwal.Date:= ServerNow;
  dtpAkhir.Date:= ServerNow;
end;

procedure TfrmReportItemQty.SetFilter;
begin
  GlobalFilter.Reset;
  GlobalFilter.RelasiID := txtVendor.Tag;
  GlobalFilter.SpecID   := txtSpec.Tag;
  GlobalFilter.ItemID   := txtItem.Tag;
  GlobalFilter.SeriesID := txtShift.Tag;
  GlobalFilter.StatusID := txtCust.Tag;
  GlobalFilter.Numeric1 := txtProdusen.Tag;
  GlobalFilter.Numeric2 := txtKasir.Tag;
  GlobalFilter.Numeric3 := cmbJenis.Tag;

  GlobalFilter.Numeric4 := txtJenis.Tag;

  GlobalPeriode.setPeriode(cmbOpr.ItemIndex, dtpAwal.Date, dtpAkhir.Date);
end;

procedure TfrmReportItemQty.gridGetAlignment(Sender: TObject;
  ARow, ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  //case Self.Tag of

  //502:
    if ARow < 2 then HAlign:= taCenter
       else if ACol > colUnit then HAlign:= taRightJustify;
  //end;
end;

procedure TfrmReportItemQty.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
//  if lsGudang <> nil then lsGudang.Free;
//  lsGudang:= nil;
end;

procedure TfrmReportItemQty.tbtRefreshClick(Sender: TObject);
begin
  case Self.Tag of
  502: LoadDataJual;
  504: LoadDataBeli;
  end;
end;

procedure TfrmReportItemQty.ToolButton5Click(Sender: TObject);
begin
  InitFilter
end;

procedure TfrmReportItemQty.btnSpecClick(Sender: TObject);
var id: integer;
begin
  ID:= frmMstCodeList.Execute(1);
  if id <> 0 then begin
    txtSpec.Tag := id;
    GlobalFilter.SpecId:= txtSpec.Tag;
    txtSpec.Text:= TMstCode.getName(id);
  end;
end;

procedure TfrmReportItemQty.btnSplClick(Sender: TObject);
var id: integer;
begin
  id:= frmLookup.Execute('SPL');
  if Id > 0 then begin
    txtVendor.Text:= TMstRelation.GetName(id);
    txtVendor.Tag:= id;
  end;
end;

procedure TfrmReportItemQty.LoadDataJual;
var i : integer; item: TMysqlResult;
begin
  try
    StartProgress;
    SetFilter;

    InitGridMutasi;
    item:= TReport.LoadJualItem;
    grid.RowCount:= IfThen(item.RecordCount > 0, item.RecordCount + 3, 4);
    item.First;
    for i:= 2 to item.RecordCount+1 do begin
      ProsesProgress(i, item.RecordCount);
      grid.Cells[colID,          i]:= item.FieldValue(0);
      grid.Cells[colNama,        i]:= item.FieldValue(1);
      grid.Cells[colUnit,        i]:= item.FieldValue(2);
      grid.Cells[colJual,        i]:= FloatToStrFmtNull(BufferToFloat(item.FieldValue(4)));
      grid.Cells[colNilaiJual,   i]:= FloatToStrFmtNull(BufferToFloat(item.FieldValue(6)));
      grid.Cells[colDiscJual,    i]:= FloatToStrFmtNull(BufferToFloat(item.FieldValue(8)));
      grid.Cells[colRetur,       i]:= FloatToStrFmtNull(abs(BufferToFloat(item.FieldValue(5))));
      grid.Cells[colNilaiRetur,  i]:= FloatToStrFmtNull(abs(BufferToFloat(item.FieldValue(7))));
      grid.Cells[colProfit,      i]:= FloatToStrFmtNull(BufferToFloat(item.FieldValue(3)));
      grid.Cells[colTotalJual,   i]:= FloatToStrFmtNull(
        grid.Floats[colNilaiJual,i] - grid.Floats[colDiscJual,i]);

      item.MoveNext;
    end;
    item.destroy;
    grid.FloatingFooter.ColumnCalc[colNilaiJual]:= acSUM;
    grid.FloatingFooter.ColumnCalc[colDiscJual]:= acSUM;
    grid.FloatingFooter.ColumnCalc[colTotalJual]:= acSUM;
    grid.FloatingFooter.ColumnCalc[colNilaiRetur]:= acSUM;
    grid.Cells[colDiscTotal, grid.RowCount-1]:= FloatToStrFmtNull(TReport.LoadJualDiscTotal);
    grid.FloatingFooter.ColumnCalc[colProfit]:= acSUM;
  finally
    EndProgress;
  end;
end;

procedure TfrmReportItemQty.InitGridMutasi;
begin
  try if grid <> nil then grid.Free;
  except end;

  grid:= TAdvStringGrid.Create(Self);

  grid.BeginUpdate;
  grid.Parent  := suiPanel2;
  grid.Top := 24;
  grid.Align   := alClient;
  grid.ColCount:= colProfit + 1;
  grid.RowCount := 4;
  grid.FixedCols:= 4;
  grid.FixedRows:= 2;

  grid.FloatingFooter.Visible:= True;
  grid.SortSettings.Show:= False;
  grid.Options := [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goRowSelect];
  grid.OnGetAlignment := gridGetAlignment;
  grid.ColumnSize.Stretch := True;
  grid.ColumnSize.StretchColumn := 2;

  grid.FixedColor          := clFixedColum;
  grid.FixedFont.Color     := clFixedFont;
  grid.Font.Style          := [];
  grid.SelectionColor      := clSelection;
  grid.Color               := clGrid;
  grid.Bands.PrimaryColor  := clPrimaryBand;
  grid.Bands.SecondaryColor:= clSecondaryBand;
  grid.Font.Color          := clLabel;//clFixedFont;
  grid.SelectionTextColor  := clFixedColum;//clFixedFont;

  grid.MergeCells(0,0,1,2);
  grid.MergeCells(colNama,0,1,2);
  grid.MergeCells(colUnit,0,1,2);
  grid.MergeCells(colJual,0,5,1);
  grid.MergeCells(colRetur,0,2,1);
  if Self.Tag = 502 then grid.MergeCells(colProfit,0,1,2);

  grid.Cells[colNama,      0]:= 'Deskripsi Obat';
  grid.Cells[colUnit,      0]:= 'Sat.';
  grid.Cells[colJual,      0]:= IfThen(Self.Tag = 502, 'Penjualan', 'Pembelian');
  grid.Cells[colJual,      1]:= 'Qty';
  grid.Cells[colNilaiJual, 1]:= 'Nilai RP';
  grid.Cells[colDiscJual,  1]:= 'Disc/Item';
  grid.Cells[colTotalJual, 1]:= 'Jumlah RP';
  grid.Cells[colDiscTotal, 1]:= 'Disc Total';
  grid.Cells[colRetur,     0]:= 'Retur';
  grid.Cells[colRetur,     1]:= 'Qty';
  grid.Cells[colNilaiRetur,1]:= 'Nilai RP';
  grid.Cells[colProfit,    0]:= 'Profit';

  //grid.ColWidths[colNama]:= 150;
  grid.ColWidths[colUnit]:= 30;
  grid.ColWidths[colJual]:= 55;
  grid.ColWidths[colNilaiJual]:= 80;

  grid.ColWidths[colDiscJual ]:= 60;
  grid.ColWidths[colTotalJual]:= 80;
  grid.ColWidths[colDiscTotal]:= 60;
  grid.ColWidths[colRetur    ]:= 60;
  grid.ColWidths[colNilaiRetur]:= 60;
  grid.ColWidths[colProfit   ]:= IfThen(Self.Tag = 502, 80, 0);

  grid.ColWidths[colNo]:= 18;
  grid.ColWidths[colID]:= 0;
  grid.EndUpdate;
end;

procedure TfrmReportItemQty.cmbOprChange(Sender: TObject);
begin
  dtpAkhir.Enabled:= cmbOpr.ItemIndex = 3;
end;

procedure TfrmReportItemQty.LoadDataBeli;
var i,j : integer; item,data: TMysqlResult;
begin
  try
    StartProgress;
    SetFilter;

    InitGridMutasi;
    item:= TReport.LoadBeliItem;
    grid.RowCount:= IfThen(item.RecordCount > 0, item.RecordCount + 3, 4);
    item.First;
    for i:= 2 to item.RecordCount+1 do begin
      ProsesProgress(i, item.RecordCount);
      grid.Cells[colID,  i]:= item.FieldValue(0);
      grid.Cells[colNama,i]:= item.FieldValue(1);
      grid.Cells[colUnit,i]:= item.FieldValue(2);

      data:= TReport.LoadQtyBeli(BufferToInteger(item.FieldValue(0)));
      if data.RecordCount > 0 then
      for j:= 0 to data.FieldsCount-1 do
          grid.Cells[j+colJual,i]:=FloatToStrFmtNull(BufferToFloat(data.FieldValue(j)));
      data.destroy;

      grid.Cells[colTotalJual,i]:= FloatToStrFmtNull(
        grid.Floats[colNilaiJual,i] - grid.Floats[colDiscJual,i]);

      data:= TReport.LoadQtyReturBl(BufferToInteger(item.FieldValue(0)));
      if data.RecordCount > 0 then
      for j:= 0 to data.FieldsCount-1 do
          grid.Cells[j+colRetur,i]:=FloatToStrFmtNull(BufferToFloat(data.FieldValue(j)));
      data.destroy;

      item.MoveNext;
    end;
    item.destroy;
    grid.FloatingFooter.ColumnCalc[colNilaiJual ]:= acSUM;
    grid.FloatingFooter.ColumnCalc[colDiscJual  ]:= acSUM;
    grid.FloatingFooter.ColumnCalc[colTotalJual ]:= acSUM;
    grid.FloatingFooter.ColumnCalc[colNilaiRetur]:= acSUM;
    grid.Cells[colDiscTotal, grid.RowCount-1]:= FloatToStrFmtNull(TReport.LoadBeliDiscTotal);
  finally
    EndProgress;
  end;
end;

procedure TfrmReportItemQty.tbtPrintClick(Sender: TObject);
begin
  if not TSystemAccess.isCan(CAN_PRINT,AktiveControl.Tag) then exit;
  if MustRegister then exit;
 { if GlobalSystemConfig.localSetting.PrinterAdm <> '' then begin
     if (getDefaultPrinter <> GlobalSystemConfig.localSetting.PrinterAdm) then
         setDefaultPrinter(GlobalSystemConfig.localSetting.PrinterAdm);
  end;
  }
  case Self.Tag of
  {502:
    try
      Application.CreateForm(TqrpReportBeli, qrpReportBeli);
      qrpReportBeli.Executes(grid);
    finally
      qrpReportBeli.Destroy;
    end;
   }
  502:
    try
      Application.CreateForm(TqrpReportJual, qrpReportJual);
      qrpReportJual.Executes(grid);
    finally
      qrpReportJual.Destroy;
    end;
  end;
end;

procedure TfrmReportItemQty.btnKasirClick(Sender: TObject);
var id: integer;
begin
  id:= frmLookup.Execute('KASIR');
  if Id > 0 then begin
    txtKasir.Text:= TMstMaster.GetName(id);
    txtKasir.Tag:= id;
  end;
end;

procedure TfrmReportItemQty.Button3Click(Sender: TObject);
var id: integer;
begin
  id:= frmLookup.Execute('SHIFT');
  if Id > 0 then begin
    txtShift.Text:= TMstMaster.GetName(id);
    txtShift.Tag:= id;
  end;
end;

procedure TfrmReportItemQty.Button5Click(Sender: TObject);
var id: integer;
begin
  id:= frmLookup.Execute('PRODUSEN');
  if Id > 0 then begin
    txtProdusen.Text:= TMstMaster.GetName(id);
    txtProdusen.Tag:= id;
  end;
end;

procedure TfrmReportItemQty.btnCustClick(Sender: TObject);
var id: integer;
begin
  id:= frmLookup.Execute('PASIEN');
  if Id > 0 then begin
    txtCust.Tag:= id;
  end;
end;

procedure TfrmReportItemQty.btnItemClick(Sender: TObject);
var id: integer;
begin
  if txtSpec.Tag = 1 then begin
    Inform('Silahkan pilih spec obat dulu.');
    Exit;
  end;
  id:= frmLookup.ExecuteItem(txtSpec.Tag, txtVendor.Tag, txtProdusen.Tag);
  if Id > 0 then begin
    txtItem.Text:= TMstItem.GetName(id);
    txtItem.Tag:= id;
  end;
end;

procedure TfrmReportItemQty.cmbJenisChange(Sender: TObject);
begin
  cmbJenis.Tag:= cmbJenis.ItemIndex-1;
end;

procedure TfrmReportItemQty.Button1Click(Sender: TObject);
var id: integer;
begin
  id:= frmLookup.Execute('JNS_OBAT');
  if Id > 0 then begin
    txtJenis.Tag:= id;
  end;
end;

end.

