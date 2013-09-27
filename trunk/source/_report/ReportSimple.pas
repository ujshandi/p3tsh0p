unit ReportSimple;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, BaseGrid, AdvGrid, StdCtrls, AdvEdit, ComCtrls, strUtils, math,
  SUIImagePanel, ToolWin, ExtCtrls, frmDockForm;

type
  TfrmReportSimple = class(TDockForm)
    ToolBar1: TToolBar;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    tbtRefresh: TToolButton;
    ToolButton2: TToolButton;
    tbtPrint: TToolButton;
    suiPanel1: TsuiPanel;
    Label2: TLabel;
    Label1: TLabel;
    dtpAkhir: TDateTimePicker;
    dtpAwal: TDateTimePicker;
    cmbOpr: TComboBox;
    txtSpec: TAdvEdit;
    btnSpec: TButton;
    suiPanel2: TsuiPanel;
    asgList: TAdvStringGrid;
    cmbPaperSize: TComboBox;
    Label3: TLabel;
    procedure asgListGetAlignment(Sender: TObject; ARow, ACol: Integer;
      var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure btnSpecClick(Sender: TObject);
    procedure cmbOprChange(Sender: TObject);
    procedure ToolButton5Click(Sender: TObject);
    procedure tbtRefreshClick(Sender: TObject);
    procedure tbtPrintClick(Sender: TObject);
  private
    procedure ArrangColSize;
    procedure InitGrid;
    procedure InitForm;
    procedure SetFilter;
    procedure InitFilter;
    procedure LoadData;
    procedure PrintStrukSize;
  public
    procedure Execute(id: integer=0); override;
  end;

var
  frmReportSimple: TfrmReportSimple;

implementation

uses Subroutines, UConst, j_idol, UConstTool,
  MstCodeList, MainMenu, ReportSimplePrint, EpsonUtils, MySQLConnector,
  uMysqlClient;

const

  colDescMst  = 1;
  colDescDtl  = 2;
  colValueDtl = 3;
  colValueMst = 4;
  colUnit     = 4;


{$R *.dfm}

{ TfrmReportSimple }

procedure TfrmReportSimple.ArrangColSize;
begin
  asgList.AutoSizeColumns(true, 4);

  asgList.ColWidths[colDescMst ]:= 15;
  asgList.ColWidths[colDescDtl ]:= 200;
  asgList.ColWidths[colValueDtl]:= 150;
  //asgList.ColWidths[colValueMst]:= 30;
  asgList.ColWidths[colUnit    ]:= 30;

  //des master                      200
  // - item terjual             300 pcs

end;

procedure TfrmReportSimple.InitFilter;
begin
  GlobalFilter.Reset;
  GlobalPeriode.Reset;
  txtSpec.Clear;
  txtSpec.Tag:= 1;
  txtSpec.Text:= 'BARANG JADI';
  cmbOpr.ItemIndex:= 0;
  dtpAwal.Date:= ServerNow;
  dtpAkhir.Date:= ServerNow;
  dtpAkhir.Enabled:= cmbOpr.ItemIndex = 3;
end;

procedure TfrmReportSimple.InitForm;
begin
  InitGrid;
  InitFilter;
end;

procedure TfrmReportSimple.InitGrid;
begin
  asgList.Clear;
  ResetGrid(asgList, 2, 6, 1,1, asgList.ColCount-1);
  asgList.MergeCells(colDescMst, 1, 2, 1);
  asgList.Cells[colDescMst, 0]:= 'Description';
  asgList.MergeCells(colValueDtl, 1, 2, 1);
  asgList.Cells[colValueDtl, 0]:= 'Value';
  ArrangColSize;
end;

procedure TfrmReportSimple.LoadData;
var i, row: integer; report_value:
  Double; data: TMysqlResult; filter: string;

  function addRow: integer;
  begin
    asgList.AddRow;
    Result:= asgList.RowCount-1;
  end;

begin

  InitGrid;
  SetFilter;

  if GlobalPeriode.PeriodeAwal1 <> 0 then
    filter:= filter + ' and t.trans_date '+FormatSQLOperator(GlobalPeriode.OpPeriodeAwal1)+FormatSQLDate(GlobalPeriode.PeriodeAwal1);
  if GlobalPeriode.PeriodeAkhir1 <> 0 then
    filter:= filter + ' and t.trans_date '+FormatSQLOperator(GlobalPeriode.OpPeriodeAkhir1)+FormatSQLDate(GlobalPeriode.PeriodeAkhir1);

  report_value:= getFloatFromSQL(
    'select ifnull(sum(total),0) from trs_sales_mst t where total > 0 '+filter);

  row:= asgList.RowCount-1;
  asgList.MergeCells(colDescMst, row, 2, 1);
  asgList.MergeCells(colValueDtl, row, 2, 1);
  asgList.Cells[colDescMst,  row]:= 'Nilai Penjualan';
  asgList.Cells[colValueMst, row]:= FloatToStrFmt(report_value);

  row:= addRow;
  asgList.MergeCells(colDescMst, row, 2, 1);
  asgList.MergeCells(colValueDtl, row, 2, 1);
  asgList.Cells[colDescMst,  row]:= 'Item Terjual :';

  data:= OpenSQL(
    'select distinct i.struk_name, ifnull(sum(quantity),0) as nilai, '+

      '(select mst_code from mst_item_conversion c, mst_master m '+
       'where c.unit_id = m.mst_id and c.item_id = i.item_id '+
       'and c.conversion = 1) as satuan '+

    'from trs_sales_mst t, trs_sales_detail d, mst_item i '+
    'where d.sales_id = t.sales_id and d.item_id = i.item_id and d.quantity > 0 '+

    filter +
    ' group by i.struk_name, satuan '+
    ' order by item_name');

  for i:= 0 to data.RecordCount-1 do begin
    row:= addRow;
    asgList.Cells[colDescDtl,  row]:= '- '+BufferToString(data.FieldValue(0));
    asgList.Cells[colValueDtl, row]:= FloatToStrFmt(BufferToFloat(data.FieldValue(1)));
    asgList.Cells[colUnit,     row]:= BufferToString(data.FieldValue(2));
    data.MoveNext;
  end;
  data.destroy;
  addRow;

  report_value:= getFloatFromSQL(
    'select ifnull(sum(total),0) from trs_sales_mst t where total < 0 '+filter);

  row:= addRow;
  asgList.MergeCells(colDescMst, row, 2, 1);
  asgList.MergeCells(colValueDtl, row, 2, 1);
  asgList.Cells[colDescMst,  row]:= 'Nilai Retur';
  asgList.Cells[colValueMst, row]:= FloatToStrFmt(abs(report_value));

  row:= addRow;
  asgList.MergeCells(colDescMst, row, 2, 1);
  asgList.MergeCells(colValueDtl, row, 2, 1);
  asgList.Cells[colDescMst,  row]:= 'Item Diretur :';


  data:= OpenSQL(
    'select distinct i.struk_name, ifnull(sum(quantity),0) as nilai, '+

      '(select mst_code from mst_item_conversion c, mst_master m '+
       'where c.unit_id = m.mst_id and c.item_id = i.item_id '+
       'and c.conversion = 1) as satuan '+

    'from trs_sales_mst t, trs_sales_detail d, mst_item i '+
    'where d.sales_id = t.sales_id and d.item_id = i.item_id and d.quantity < 0 '+filter+
    ' group by i.struk_name, satuan '+
    ' order by item_name');

  for i:= 0 to data.RecordCount-1 do begin
    row:= addRow;
    asgList.Cells[colDescDtl,  row]:= '- '+BufferToString(data.FieldValue(0));
    asgList.Cells[colValueDtl, row]:= FloatToStrFmt(abs(BufferToFloat(data.FieldValue(1))));
    asgList.Cells[colUnit,     row]:= BufferToString(data.FieldValue(2));
    data.MoveNext;
  end;
  data.destroy;
  addRow;
  if filter <> '' then filter:= ' where ' + Copy(filter, 5, length(filter)); 
  report_value:= getFloatFromSQL(
    'select ifnull(sum(profit),0) from trs_sales_mst t '+filter);

  row:= addRow;
  asgList.MergeCells(colDescMst, row, 2, 1);
  asgList.MergeCells(colValueDtl, row, 2, 1);
  asgList.Cells[colDescMst,  row]:= 'Nilai Profit';
  asgList.Cells[colValueMst, row]:= FloatToStrFmt(report_value);

end;

procedure TfrmReportSimple.SetFilter;
begin
  GlobalPeriode.setPeriode(cmbOpr.ItemIndex, dtpAwal.Date, dtpAkhir.Date);
end;

procedure TfrmReportSimple.asgListGetAlignment(Sender: TObject; ARow,
  ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  if (ACol = colValueDtl) or ((ACol = colValueMst) and (asgList.IsMergedCell(ACol, ARow)))
  then HAlign:= taRightJustify
end;

procedure TfrmReportSimple.btnSpecClick(Sender: TObject);
var vName: string;
begin
  txtSpec.Tag := frmMstCodeList.Execute(vName, 0);
  GlobalFilter.SpecId:= txtSpec.Tag;
  txtSpec.Text:= vName;
  txtSpec.SetFocus;
end;

procedure TfrmReportSimple.cmbOprChange(Sender: TObject);
begin
  dtpAkhir.Enabled:= cmbOpr.ItemIndex = 3;
end;

procedure TfrmReportSimple.Execute(id: integer);
begin
  inherited;
  ToolBar1.ParentColor:= false;
  ToolBar1.Color:= clWhite;
  InitForm;
  cmbPaperSize.ItemIndex:= 0;
  cmbPaperSize.Text:= 'A4';
  Run(Self);
end;

procedure TfrmReportSimple.ToolButton5Click(Sender: TObject);
begin
  InitFilter
end;

procedure TfrmReportSimple.tbtRefreshClick(Sender: TObject);
begin
  LoadData
end;

procedure TfrmReportSimple.tbtPrintClick(Sender: TObject);
begin
  if MustRegister then exit;
  if GlobalSystemConfig.localSetting.PrinterAdm <> '' then begin
     if (getDefaultPrinter <> GlobalSystemConfig.localSetting.PrinterAdm) then
         setDefaultPrinter(GlobalSystemConfig.localSetting.PrinterAdm);
  end;
  case cmbPaperSize.ItemIndex of
  0: try
    Application.CreateForm(TqrpReportSimple, qrpReportSimple);
    qrpReportSimple.Executes(asgList);
  finally
    qrpReportSimple.Destroy;
  end;

  1: PrintStrukSize;
  end;
end;

procedure TfrmReportSimple.PrintStrukSize;
var i: integer;
begin

  GlobalStringList.Clear;
  GlobalStringList.Append(FixWidth('Laporan Transaksi Harian', 40, taRightJustify));
  GlobalStringList.Append(
    FixWidth(CaptionPeriode(GlobalPeriode.OpPeriodeAwal1, GlobalPeriode.PeriodeAwal1,
             GlobalPeriode.PeriodeAkhir1), 40, taRightJustify));
  GlobalStringList.Append(FixWidth('-----------------------------------------',40, taLeftJustify));
  for i:= 1 to asgList.RowCount-1 do begin
    GlobalStringList.Append
    (
      FixWidth
      (
        IfThen
        (
          (asgList.Cells[colDescMst,  i] <> '') and (asgList.IsMergedCell(colDescMst, i)),
           asgList.Cells[colDescMst, i],
           asgList.Cells[colDescDtl, i]
         ),
         23,taLeftJustify
      )+
        IfThen
        (
          (asgList.Cells[colValueMst,  i] <> '') and (asgList.IsMergedCell(colValueMst, i)),
          FixWidth(asgList.Cells[colValueMst, i], 23, taRightJustify),

          FixWidth(asgList.Cells[colValueDtl, i], 13, taRightJustify) +
          FixWidth(' ' + asgList.Cells[colUnit, i], 4, taLeftJustify)
        )
    );
  end;

  GlobalStringList.Append(escCRLF);
  GlobalStringList.Append(escCRLF);
  GlobalStringList.Append(escCRLF);
  GlobalStringList.Append(escCRLF);
  RAWPrintPreview.PreviewOnly('dailly report', GlobalStringList.Text);
end;

end.
