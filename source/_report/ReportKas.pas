unit ReportKas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, ToolWin, StdCtrls, AdvEdit, UTransaction,
  Grids, BaseGrid, AdvGrid, WinXP, SUIImagePanel, Math, DateUtils, strutils,
  frmDockForm;

type
  TfrmReportKas = class(TDockForm)
    ToolBar1: TToolBar;
    tbtRefresh: TToolButton;
    ToolButton2: TToolButton;
    tbtPrint: TToolButton;
    WinXP1: TWinXP;
    ToolButton5: TToolButton;
    suiPanel1: TsuiPanel;
    suiPanel2: TsuiPanel;
    cmbReport: TComboBox;
    Label3: TLabel;
    panelDate: TPanel;
    dtpAkhir: TDateTimePicker;
    dtpAwal: TDateTimePicker;
    Label2: TLabel;
    Label1: TLabel;
    procedure gridGetAlignment(Sender: TObject; ARow, ACol: Integer;
      var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure tbtRefreshClick(Sender: TObject);
    procedure ToolButton5Click(Sender: TObject);
    procedure tbtPrintClick(Sender: TObject);
  private
    grid: TAdvStringGrid;
    procedure InitGrid;
    procedure SetFilter;
    procedure InitFilter;
    procedure LoadData;
  public
    procedure Execute(id: integer); override;
  end;

var
  frmReportKas: TfrmReportKas;

implementation

uses Subroutines, MainMenu,
  MstCodeList, MySQLConnector, uMysqlClient, UConst, UMaster,
  LookupData, RepotItemStokPrint, ReportItemMutasiPrint, UConstTool;

const
  colNo = 0;
  colTanggal = 1;
  colNama     = 2;
  colMasuk   = 3;
  colKeluar    = 4;
  colSaldo = 5;

{$R *.dfm}

{ TfrmTrsItemShipmentList }

procedure TfrmReportKas.Execute(id: integer);
begin
  inherited;

  ToolBar1.ParentColor:= false;
  ToolBar1.Color:= clWhite;
  cmbReport.ItemIndex:= 0;
  InitGrid;
  InitFilter;

  Run(Self);
end;

procedure TfrmReportKas.InitFilter;
begin
  GlobalFilter.Reset;
  GlobalPeriode.Reset;
  dtpAwal.Date:= StartOfTheMonth(ServerNow);
  dtpAkhir.Date:= ServerNow;

end;

procedure TfrmReportKas.LoadData;
var i,row : integer; data: TMysqlResult;
  sAwal,masuk,keluar : double;
begin

  try
    StartProgress;
    SetFilter;
    InitGrid;
    data:= TReport.LoadKartuKas(MONEY_TYPE_KAS);
    row := grid.RowCount-1;
    grid.Cells[colTanggal,row] := FormatDateTime(ShortDateFormat,dtpAwal.Date);
    grid.Cells[colNama,row] := 'Saldo Awal';
    sAwal := TTrsMoneyTransaction.getSaldoAwal(dtpAwal.Date-1,MONEY_TYPE_KAS);
    grid.Cells[colSaldo,row] := FloatToStrFmt(sAwal);
    data.First;
    for i:= 1 to data.RecordCount do begin
          grid.AddRow;
          row := grid.RowCount-1;
      ProsesProgress(i, data.RecordCount);
         grid.Ints[0,row] := i;
    //  for j:= 0 to data.FieldsCount-1 do   begin

          grid.Cells[colTanggal,row] := FormatDateTime(ShortDateFormat,BufferToDateTime(data.FieldValue(0)));
          grid.Cells[colNama,row]:= BufferToString(data.FieldValue(1));
          masuk := BufferToFloat(data.FieldValue(2));
          keluar := BufferToFloat(data.FieldValue(3));
          sAwal := sAwal + masuk - keluar;
          grid.Cells[colMasuk,  row]:= FloatToStrFmt(masuk);
          grid.Cells[colkeluar,  row]:= FloatToStrFmt(keluar);
          grid.Cells[colSaldo,row] := FloatToStrFmt(sAwal);
          data.MoveNext;
     // end;
    end;
    data.destroy;

    grid.AutoSizeColumns(TRUE, 4);
    //grid.ColWidths[0]:= 18;
   // grid.ColWidths[1]:= 0;
  finally
    EndProgress;
  end;
end;

procedure TfrmReportKas.SetFilter;
begin
  GlobalFilter.Reset;

  GlobalPeriode.setPeriode(3, dtpAwal.Date, dtpAkhir.Date);
  GlobalPeriode.RangeAwal:= -1;
end;

procedure TfrmReportKas.gridGetAlignment(Sender: TObject;
  ARow, ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
     if ACol > colNama then HAlign:= taRightJustify;
end;

procedure TfrmReportKas.tbtRefreshClick(Sender: TObject);
begin
 LoadData;
end;

procedure TfrmReportKas.ToolButton5Click(Sender: TObject);
begin
  InitFilter
end;

procedure TfrmReportKas.tbtPrintClick(Sender: TObject);
begin
Alert(MSG_UNDER_CONSTRUCTION);exit;
  if not TSystemAccess.isCan(CAN_PRINT,AktiveControl.Tag) then exit;
  if MustRegister then exit;

  if GlobalSystemConfig.localSetting.PrinterAdm <> '' then begin
     if (getDefaultPrinter <> GlobalSystemConfig.localSetting.PrinterAdm) then
         setDefaultPrinter(GlobalSystemConfig.localSetting.PrinterAdm);
  end;

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

procedure TfrmReportKas.InitGrid;
begin

  try if grid <> nil then grid.Free;
  except end;

  grid:= TAdvStringGrid.Create(Self);
  grid.BeginUpdate;
  grid.Parent  := suiPanel2;
  grid.Top     := 24;
  grid.Align   := alClient;

  grid.ColCount:= colSaldo+2;
  grid.RowCount := 2;
  grid.FixedCols:= 1;
  grid.FixedRows:= 1;

  grid.Cells[colNo,0] := 'No.';
  grid.Cells[colTanggal,0] := 'Tanggal';
  grid.Cells[colNama,0] := 'Deskripsi';
  grid.Cells[colMasuk,0] := 'Masuk';
  grid.Cells[colKeluar,0] := 'Keluar';
  grid.Cells[colSaldo,0] := 'Saldo';


  grid.FloatingFooter.Visible:= False;
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

