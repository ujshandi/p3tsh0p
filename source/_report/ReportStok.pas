unit ReportStok;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, ToolWin, StdCtrls, AdvEdit, UTransaction,
  Grids, BaseGrid, AdvGrid, WinXP, SUIImagePanel, Math, DateUtils, strutils,
  frmDockForm;

type
  TfrmReportStok = class(TDockForm)
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
    Button1: TButton;
    Label5: TLabel;
    cmbGudang: TComboBox;
    cmbReport: TComboBox;
    Label3: TLabel;
    panelDate: TPanel;
    dtpAkhir: TDateTimePicker;
    dtpAwal: TDateTimePicker;
    Label2: TLabel;
    Label1: TLabel;
    panelStok: TPanel;
    Label4: TLabel;
    Label6: TLabel;
    txtAwal: TAdvEdit;
    txtAkhir: TAdvEdit;
    cmbOpr: TComboBox;
    txtNama: TAdvEdit;
    txtBarcode: TAdvEdit;
    txtMerk: TAdvEdit;
    procedure gridGetAlignment(Sender: TObject; ARow, ACol: Integer;
      var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tbtRefreshClick(Sender: TObject);
    procedure ToolButton5Click(Sender: TObject);
    procedure btnSpecClick(Sender: TObject);
    procedure cmbGudangChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure cmbReportChange(Sender: TObject);
    procedure cmbOprChange(Sender: TObject);
    procedure tbtPrintClick(Sender: TObject);
  private
    lsGudang: TStringList;
    grid: TAdvStringGrid;
    procedure InitGridMutasi;
    procedure InitGrid;
    procedure SetFilter;
    procedure InitFilter;
    procedure LoadData;
    procedure LoadDataMutasi;
  public
    procedure Execute(id: integer); override;
  end;

var
  frmReportStok: TfrmReportStok;

implementation

uses Subroutines, MainMenu,
  MstCodeList, MySQLConnector, uMysqlClient, UConst, UMaster,
  LookupData, RepotItemStokPrint, ReportItemMutasiPrint, UConstTool;

const
  colNo = 0;
  colID = 1; //6
  colCode =2;
  colNama     = 3;
  colUnit     = 4;
  colAwal     = 5;
  colBeli     = 6;
  colReturDr  = 7;
  colMutasiDr = 8;
  colPakai    = 9;
  colJual     =10;
  colReturCr  = 11;
  colMutasiCr = 12;
  colOpname   = 13;
  colAkhir    = 14;

{$R *.dfm}

{ TfrmTrsItemShipmentList }

procedure TfrmReportStok.Execute(id: integer);
begin
  inherited;

  ToolBar1.ParentColor:= false;
  ToolBar1.Color:= clWhite;
  lsGudang:= TStringList.Create;
 // TMstMaster_Arr.GetList(lsGudang, MST_TYPE_GUDANG);
  //TMstBranch.getList(lsGudang,);
 // lsGudang.Insert(0, '0=Semua Gudang');
  //NameValueListToValueList(lsGudang, cmbGudang.Items);
  cmbReport.ItemIndex:= 0;
  cmbReportChange(nil);
  InitGrid;
  InitFilter;

  Run(Self);
end;

procedure TfrmReportStok.InitFilter;
begin
  GlobalFilter.Reset;
  GlobalPeriode.Reset;
  txtSpec.Clear;
  txtSpec.Tag:= 1;
  txtVendor.Clear;
  txtNama.Clear;
  txtBarcode.Clear;
  txtVendor.Tag:= 0;
  txtSpec.Text:= '';
  txtVendor.Text:= '';
  txtMerk.Clear;
  dtpAwal.Date:= StartOfTheMonth(ServerNow);
  dtpAkhir.Date:= ServerNow;
  cmbOpr.ItemIndex := 0;
  txtAwal.IntValue := -1;
  txtAkhir.IntValue:= 0;
  cmbOprChange(nil);

  cmbGudang.ItemIndex:= 0;
  cmbGudangChange(nil);
end;

procedure TfrmReportStok.LoadData;
var i,j : integer; header: TMysql_FieldDef; data: TMysqlResult;
grandTotal,total :Double;
begin

  try
    StartProgress;
    SetFilter;
    InitGrid;
    data:= TReport.LoadRekapStock;

    grid.RowCount := IfThen(data.RecordCount > 0, data.RecordCount + 2, 3);
    grid.ColCount := data.FieldsCount+2;

    for i:= 0 to data.FieldsCount-1 do begin
      header:= data.FieldDef(i)^;
      grid.Cells[i+1, 0]:= header.Name;

    end;

    data.First;    grandTotal:=0;total:=0;
    for i:= 1 to data.RecordCount do begin
      ProsesProgress(i, data.RecordCount);
         grid.Ints[0,i] := i;
    //  for j:= 0 to data.FieldsCount-1 do   begin
         grid.Cells[colCode,i]:= data.FieldValue(1);
          grid.Cells[colNama,i]:= data.FieldValue(2);
          grid.Cells[colUnit,i]:= data.FieldValue(3);
          grid.Cells[colUnit+1,  i]:= FloatToStrFmtNull(BufferToFloat(data.FieldValue(4)));
          grid.Cells[colUnit+2,  i]:= FloatToStrFmtNull(BufferToFloat(data.FieldValue(5)));//harga beli
          total := BufferToFloat(data.FieldValue(4))*BufferToFloat(data.FieldValue(5));
          grandTotal := grandTotal + total;
          grid.Cells[colUnit+3,  i]:= FloatToStrFmtNull(total);
          data.MoveNext;
     // end;
    end;
    data.destroy;
    grid.Cells[colUnit+3,  grid.RowCount-1]:= FloatToStrFmtNull(grandTotal);
    grid.AutoSizeColumns(TRUE, 4);
   // grid.ColWidths[0]:= 18;
    grid.ColWidths[1]:= 0;
  finally
    EndProgress;
  end;
end;

procedure TfrmReportStok.SetFilter;
begin
  GlobalFilter.Reset;
  GlobalFilter.RelasiID:= txtVendor.Tag;
  GlobalFilter.SpecID  := txtSpec.Tag;
  GlobalFilter.SeriesID:= cmbGudang.Tag;
  GlobalFilter.FString1:= txtBarcode.Text;
  GlobalFilter.FString2:= txtMerk.Text;
  GlobalFilter.Name    := txtNama.Text;
  
  GlobalPeriode.setPeriode(3, dtpAwal.Date, dtpAkhir.Date);
  GlobalPeriode.RangeAwal:= -1;
  GlobalPeriode.setRanges(cmbOpr.ItemIndex-1, txtAwal.IntValue, txtAkhir.IntValue);
end;

procedure TfrmReportStok.gridGetAlignment(Sender: TObject;
  ARow, ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  case cmbReport.ItemIndex of
  0: if (ACol in [5,6,7]) then HAlign:= taRightJustify;
  1: if ARow < 2 then HAlign:= taCenter
     else if ACol > colUnit then HAlign:= taRightJustify;
  end;
end;

procedure TfrmReportStok.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  if lsGudang <> nil then lsGudang.Free;
  lsGudang:= nil;
end;

procedure TfrmReportStok.tbtRefreshClick(Sender: TObject);
begin
  case cmbReport.ItemIndex of
  0: LoadData;
  1: LoadDataMutasi;
  end;
end;

procedure TfrmReportStok.ToolButton5Click(Sender: TObject);
begin
  InitFilter
end;

procedure TfrmReportStok.btnSpecClick(Sender: TObject);
var ID: integer;
begin
  ID:= frmMstCodeList.Execute(1);
  if ID <> 0 then begin
    txtSpec.Tag := ID;
    GlobalFilter.SpecId:= txtSpec.Tag;
    txtSpec.Text:= TMstCode.getName(ID);
  end;
end;

procedure TfrmReportStok.cmbGudangChange(Sender: TObject);
begin
  cmbGudang.Tag:= 0;
  if cmbGudang.ItemIndex > 0 then
    cmbGudang.Tag:= StrToInt(lsGudang.Names[cmbGudang.ItemIndex])
end;

procedure TfrmReportStok.Button1Click(Sender: TObject);
var id: integer;
begin
  id:= frmLookup.Execute('JNS_OBAT');
  if Id > 0 then begin
    txtVendor.Tag:= id;
  end;
end;

procedure TfrmReportStok.cmbReportChange(Sender: TObject);
begin
  panelDate.Visible:= cmbReport.ItemIndex = 1;
  panelStok.Visible:= cmbReport.ItemIndex = 0;
end;

procedure TfrmReportStok.cmbOprChange(Sender: TObject);
begin
  txtAwal.Enabled := cmbOpr.ItemIndex <> 0;
  txtAkhir.Enabled:= cmbOpr.ItemIndex = 4;
end;

procedure TfrmReportStok.LoadDataMutasi;
var i: integer; item: TMysqlResult;
begin
  try
    StartProgress;
    SetFilter;

    InitGridMutasi;
    item:= TReport.LoadRekapItemSpeed;
    grid.RowCount:= IfThen(item.RecordCount > 0, item.RecordCount + 3, 4);
    item.First;
    for i:= 2 to item.RecordCount+1 do begin
      ProsesProgress(i, item.RecordCount);
      grid.Ints[colNo,i] := i-1;
      grid.Cells[colReturCr, i]:= '';
      grid.Cells[colMutasiDr,i]:= '';

      grid.Cells[colID,  i]:= item.FieldValue(0);
      grid.Cells[colNama,i]:= item.FieldValue(1);
      grid.Cells[colUnit,i]:= item.FieldValue(2);
      grid.Cells[colCode,i]:= item.FieldValue(12);
//    grid.Cells[colAwal,i]:=
  //  FloatToStrFmt(TMstItem.GetSaldoAwal(BufferToInteger(item.FieldValue(0)), cmbGudang.Tag, dtpAwal.Date));
    //0item_id, 1item_name, 2satuan, 3sum(beli), 4sum(retur_beli),5sum(mutasi_masuk),6sum(mutasi_keluar),
    //7sum(pakai),8sum(jual),9sum(retur_jual),10sum(opname)

      grid.Cells[colAwal,    i]:= FloatToStrFmtNull(BufferToFloat(item.FieldValue(3)));
      grid.Cells[colBeli,    i]:= FloatToStrFmtNull(BufferToFloat(item.FieldValue(4)));
      grid.Cells[colReturCr, i]:= FloatToStrFmtNull(BufferToFloat(item.FieldValue(5)));




//      if cmbGudang.Tag <> 0 then begin
        //grid.Cells[colReturCr, i]:= FloatToStrFmtNull(BufferToFloat(item.FieldValue(6)));
        grid.Cells[colMutasiDr,i]:= FloatToStrFmtNull(BufferToFloat(item.FieldValue(6)));
        grid.Cells[colMutasiCr,i]:= FloatToStrFmtNull(BufferToFloat(item.FieldValue(7)));
  //    end;

      grid.Cells[colPakai,    i]:= FloatToStrFmtNull(BufferToFloat(item.FieldValue(8)));
      grid.Cells[colJual,    i]:= FloatToStrFmtNull(BufferToFloat(item.FieldValue(9)));
      grid.Cells[colReturDr, i]:= FloatToStrFmtNull(abs(BufferToFloat(item.FieldValue(10))));

      grid.Cells[colOpname,  i]:= FloatToStrFmtNull(BufferToFloat(item.FieldValue(11)));

      grid.Cells[colAkhir,i]:= FloatToStrFmt(
        grid.Floats[colAwal, i] + grid.Floats[colBeli, i] + grid.Floats[colReturDr, i] + grid.Floats[colMutasiDr, i] -
        grid.Floats[colPakai, i] - grid.Floats[colJual, i] - grid.Floats[colReturCr, i] - grid.Floats[colMutasiCr, i] +
        grid.Floats[colOpname, i]);
      item.MoveNext;
    end;
    item.destroy;

  finally
      grid.AutoSizeColumns(True,2);
      grid.ColWidths[colID]:= 0;

    EndProgress;
  end;

end;

procedure TfrmReportStok.InitGridMutasi;
begin

  try if grid <> nil then grid.Free;
  except end;

  grid:= TAdvStringGrid.Create(Self);
  grid.BeginUpdate;
  grid.Parent  := suiPanel2;
  grid.Top     := 24;
  grid.Align   := alClient;

  grid.ColCount:= colAkhir + 2;
  grid.RowCount := 4;
  grid.FixedCols:= 4;
  grid.FixedRows:= 2;
  grid.FloatingFooter.Visible:= True;
  grid.SortSettings.Show:= False;
  grid.ColumnSize.Stretch:= True;
  grid.Options := [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goRowSelect];
  grid.OnGetAlignment := gridGetAlignment;

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
  grid.MergeCells(colCode,0,1,2);
  grid.MergeCells(colNama,0,1,2);
  grid.MergeCells(colUnit,0,1,2);
  grid.MergeCells(colOpname,0,1,2);
  grid.MergeCells(colAwal,0,1,2);
  grid.MergeCells(colAkhir,0,1,2);
  grid.MergeCells(colBeli,0,3,1);
  grid.MergeCells(colPakai,0,4,1);

  grid.Cells[colCode,    0]:= 'Kode';
  grid.Cells[colNama,    0]:= 'Deskripsi Barang';
  grid.Cells[colUnit,    0]:= 'Merk';
  grid.Cells[colAwal,    0]:= 'So. Awal';
  grid.Cells[colBeli,    0]:= 'Debet';
  grid.Cells[colBeli,    1]:= 'Pembelian';
  grid.Cells[colReturDr, 1]:= 'Ret. Jual';
  grid.Cells[colMutasiDr,1]:= 'Mutasi';
  grid.Cells[colPakai,   0]:= 'Credit';
  grid.Cells[colPakai,   1]:= 'Pakai';
  grid.Cells[colJual,    1]:= 'Penjualan';
  grid.Cells[colReturCr, 1]:= 'Ret. Beli';
  grid.Cells[colMutasiCr,1]:= 'Mutasi';
  grid.Cells[colOpname,  0]:= 'Opname';
  grid.Cells[colAkhir,   0]:= 'So. Akhir';

  grid.ColWidths[colNama]:= 250;
  grid.ColWidths[colUnit]:= 35;
  grid.ColWidths[colAwal]:= 60;
  grid.ColWidths[colBeli]:= 60;

  grid.ColWidths[colReturDr ]:= 60;
  grid.ColWidths[colMutasiDr]:= 60;
  grid.ColWidths[colPakai   ]:= 60;
  grid.ColWidths[colJual    ]:= 60;
  grid.ColWidths[colReturCr ]:= 60;
  grid.ColWidths[colMutasiCr]:= 60;
  grid.ColWidths[colOpname  ]:= 60;
  grid.ColWidths[colAkhir   ]:= 60;

  grid.ColWidths[colNo]:= 18;
  grid.ColWidths[colID]:= 0;
  grid.EndUpdate;
end;

procedure TfrmReportStok.tbtPrintClick(Sender: TObject);
begin
  if not TSystemAccess.isCan(CAN_PRINT,AktiveControl.Tag) then exit;
  if MustRegister then exit;

  {if GlobalSystemConfig.localSetting.PrinterAdm <> '' then begin
     if (getDefaultPrinter <> GlobalSystemConfig.localSetting.PrinterAdm) then
         setDefaultPrinter(GlobalSystemConfig.localSetting.PrinterAdm);
  end;
   }
  case cmbReport.ItemIndex of
  0:try
      Application.CreateForm(TqrpRepotItemStok, qrpRepotItemStok);
      qrpRepotItemStok.Executes(grid);
    finally
      qrpRepotItemStok.Destroy;
    end;

  1:try
      Application.CreateForm(TqrpReportItemMutasi, qrpReportItemMutasi);
      qrpReportItemMutasi.Executes(grid);
    finally
      qrpReportItemMutasi.Destroy;
    end;

  end;
end;

procedure TfrmReportStok.InitGrid;
begin

  try if grid <> nil then grid.Free;
  except end;

  grid:= TAdvStringGrid.Create(Self);
  grid.BeginUpdate;
  grid.Parent  := suiPanel2;
  grid.Top     := 24;
  grid.Align   := alClient;

  grid.ColCount:= 11;
  grid.RowCount := 3;
  grid.FixedCols:= 1;
  grid.FixedRows:= 1;

  grid.FloatingFooter.Visible:= True;
  grid.SortSettings.Show:= False;
  grid.ColumnSize.Stretch:= True;
  grid.Options := [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goRowSelect];
  grid.OnGetAlignment := gridGetAlignment;

  grid.FixedColor          := clFixedColum;
  grid.FixedFont.Color     := clFixedFont;
  grid.Font.Style          := [];
  grid.SelectionColor      := clSelection;
  grid.Color               := clGrid;
  grid.Bands.PrimaryColor  := clPrimaryBand;
  grid.Bands.SecondaryColor:= clSecondaryBand;
  grid.Font.Color          := clLabel;//clFixedFont;
  grid.SelectionTextColor  := clFixedColum;//clFixedFont;
  grid.EndUpdate;

end;

end.

