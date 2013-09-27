unit trsPurchaseOrderList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, ToolWin, StdCtrls, AdvEdit, UTransaction,
  Grids, BaseGrid, AdvGrid, WinXP, SUIImagePanel, Math, DateUtils, strutils,
  frmDockForm;

type
  TfrmTrsPurchaseOrderList = class(TDockForm)
    ToolBar1: TToolBar;
    tbtNew: TToolButton;
    tbtDetail: TToolButton;
    ToolButton4: TToolButton;
    tbtRefresh: TToolButton;
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
    txtVendor: TAdvEdit;
    Button1: TButton;
    cmbStatus: TComboBox;
    dtpAkhir2: TDateTimePicker;
    dtpAwal2: TDateTimePicker;
    cmbOpr2: TComboBox;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    cmbJensi: TComboBox;
    ttDelete: TToolButton;
    cmbBayar: TComboBox;
    Label7: TLabel;
    cmbFormat: TComboBox;
    Label8: TLabel;
    tbtPrint: TToolButton;
    ToolButton1: TToolButton;
    procedure tbtNewClick(Sender: TObject);
    procedure tbtDetailClick(Sender: TObject);
    procedure gridGetAlignment(Sender: TObject; ARow, ACol: Integer;
      var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure gridDblClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tbtRefreshClick(Sender: TObject);
    procedure ToolButton5Click(Sender: TObject);
    procedure btnSpecClick(Sender: TObject);
    procedure cmbJensiChange(Sender: TObject);
    procedure cmbStatusChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure cmbOprChange(Sender: TObject);
    procedure cmbOpr2Change(Sender: TObject);
    procedure tbtPrintClick(Sender: TObject);
    procedure ttDeleteClick(Sender: TObject);
    procedure cmbBayarChange(Sender: TObject);
  private
    purpose: integer;
    procedure InitForm;
    procedure SetFilter;
    procedure InitFilter;
    procedure LoadData;
    procedure LoadDetailReceipt;
  public
    procedure Execute(id: integer); override;
  end;

var
  frmTrsPurchaseOrderList: TfrmTrsPurchaseOrderList;

implementation

uses Subroutines, MainMenu,
  MstCodeList, MySQLConnector, uMysqlClient, UConst, UMaster,
  LookupData, UConstTool, trsPurchaseOrderListPrint;

const
  colNo    = 0;
  colID    = 1; //6

  colCust  = 2;
  colTgl   = 3;
  colCode  = 4;
  colNama  = 5;
  colQty   = 6;
  colSat   = 7;
  colHrg   = 8;
  colTotal = 9;

{$R *.dfm}

{ TfrmTrsItemShipmentList }


procedure TfrmTrsPurchaseOrderList.Execute(id: integer);
begin
  inherited;
  ToolBar1.ParentColor:= false;
  ToolBar1.Color:= clWhite;
  purpose:= ID;
  InitForm;
  Run(Self);
end;

procedure TfrmTrsPurchaseOrderList.InitFilter;
begin
  GlobalFilter.Reset;
  GlobalPeriode.Reset;
  txtSpec.Clear;
  txtSpec.Tag:= 0;
  txtVendor.Clear;
  txtVendor.Tag:= 0;
  txtSpec.Text:= 'Semua Jenis';
  txtVendor.Text:= 'Semua Supplier';
  cmbOpr.ItemIndex:= 4;
  cmbOprChange(nil);
  dtpAwal.Date:= StartOfTheMonth(ServerNow);
  dtpAkhir.Date:= ServerNow;
  dtpAkhir.Enabled:= cmbOpr.ItemIndex = 4;

  cmbOpr2.ItemIndex:= 0;
  cmbOpr2Change(nil);
  dtpAwal2.Date:= StartOfTheMonth(ServerNow);
  dtpAkhir2.Date:= EndOfTheMonth(ServerNow);
  dtpAkhir2.Enabled:= cmbOpr2.ItemIndex = 4;
  cmbStatus.ItemIndex:= 0;
  cmbJensi.ItemIndex:= 0;
  cmbStatusChange(nil);
  cmbJensiChange(nil);

  cmbBayar.ItemIndex:= 0;
  cmbBayarChange(nil);

end;

procedure TfrmTrsPurchaseOrderList.InitForm;
begin
  InitFilter;
  Label3.Caption:= IfThen(purpose = TRANS_TYPE_ORDER, 'Tgl Kirim :', 'Tgl Expr :');

 // cmbOpr2.Enabled  := (purpose <> TRANS_TYPE_RETUR);
//  dtpAwal2.Enabled := (purpose <> TRANS_TYPE_RETUR);
//  dtpAkhir2.Enabled:= (purpose <> TRANS_TYPE_RETUR);

 // cmbBayar.Visible:= (purpose = TRANS_TYPE_RECEIPT);
  //Label7.Visible:= (purpose = TRANS_TYPE_RECEIPT);

  ttDelete.Visible:= (purpose = TRANS_TYPE_RECEIPT);
  cmbFormat.ItemIndex:= 0;
  cmbFormat.Visible:= (purpose = TRANS_TYPE_RECEIPT);
  Label8.Visible:= (purpose = TRANS_TYPE_RECEIPT);
end;

procedure TfrmTrsPurchaseOrderList.LoadData;
var i,j, col_idx, col_date1: integer; header: TMysql_FieldDef; data: TMysqlResult;
begin
  try
    StartProgress;
    SetFilter;
    grid.Clear;
    grid.Options := [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goRowSelect];
    {0order_id, 1trans_num as ''No Trx'', 2''Tgl Order'', 3''Tgl Expr'', 4.delivery_date
      '5Supplier,6status,7Nots, 8.Subtotal, 9Discount, 10.Pajak, 11.Total}

    if purpose = TRANS_TYPE_ORDER then data:= TTrsOrder.LoadRekap

    {0t.receipt_id, 1t.trans_num as ''No Trx'', 2t.trans_date as ''Tgl Terima'', 3t.expr_date as ''Jth Tempo'', '+
      '4Supplier,5TIPE,6Status, 7t.Subtotal, 8(t.disc_mst + t.disc_detail) as Discount, 9t.tax as Pajak, 10t.Materai, 11t. Biaya, 12t.Total}

    else if purpose = TRANS_TYPE_RECEIPT then data:= TTrsReceipt.LoadRekap
    {'0t.retur_id, 1t.trans_num as ''No Trx'', 2t.trans_date as ''Tgl Retur'', '+
      3Supplier, 4Status,5Subtotal, 6t.Discount, 7t.tax as Pajak, 8t.Materai, 9t.Biaya, 10t.Total}

    else if purpose = TRANS_TYPE_RETUR then data:= TTrsRetur.LoadRekap
    else Exit;

    grid.RowCount:= IfThen(data.RecordCount > 0, data.RecordCount + 2, 3);
    grid.ColCount:= data.FieldsCount+2;
    grid.FixedRows:= 1;
    grid.FloatingFooter.Visible:= True;
    for i:= 0 to data.FieldsCount-1 do begin
      header:= data.FieldDef(i)^;
      grid.Cells[i+1, 0]:= header.Name;
    end;

    if purpose = TRANS_TYPE_ORDER then col_idx:= 9
    else if purpose = TRANS_TYPE_RECEIPT then col_idx:= 8
    else if purpose = TRANS_TYPE_RETUR then col_idx:= 7
    else col_idx:= 7;

    if purpose = TRANS_TYPE_ORDER then col_date1:= 4
    else if purpose = TRANS_TYPE_RECEIPT then col_date1:= 3
    else if purpose = TRANS_TYPE_RETUR then col_date1:= 2
    else col_date1:= 4;

    data.First;
    for i:= 1 to data.RecordCount do begin
      grid.Ints[colNo,i] := i;
      for j:= 0 to data.FieldsCount-1 do
        if (j >= (col_idx-1)) then
          grid.Cells[j+1,i]:= FloatToStrFmt(BufferToFloat(data.FieldValue(j)))
        else if (j >= 2) and (j <= col_date1) then
          grid.Dates[j+1,i]:= BufferToDateTime(data.FieldValue(j))

        else grid.Cells[j+1,i]:= data.FieldValue(j);
      data.MoveNext;
    end;
    data.destroy;

    for i:= col_idx to grid.ColCount-2 do
      grid.Cells[i, grid.RowCount-1]:= FloatToStrFmt(grid.ColumnSum(i, 1, grid.RowCount-2));

    grid.AutoSizeColumns(TRUE, 4);


    if purpose = TRANS_TYPE_RECEIPT then  begin
       grid.ColWidths[0]:= 18;
        grid.ColWidths[1]:= 0;
        grid.ColWidths[4]:= 0;
      //  grid.ColWidths[10]:= 0;
        grid.ColWidths[11]:= 0;
        grid.ColWidths[12]:= 0;
    end
    else   if purpose = TRANS_TYPE_RETUR then  begin
       grid.ColWidths[0]:= 18;
        grid.ColWidths[1]:= 0;
        grid.ColWidths[7]:= 0;
        grid.ColWidths[8]:= 0;
        grid.ColWidths[9]:= 0;
        grid.ColWidths[10]:= 0;
        grid.ColWidths[11]:= 0;

    end
    else begin
      grid.ColWidths[0]:= 18;
      grid.ColWidths[1]:= 0;
      grid.ColWidths[4]:= 0;
      grid.ColWidths[5]:= 0;
     //grid.ColWidths[6]:= 0;
     // grid.ColWidths[11]:= 0;
    end;


  finally
    EndProgress;
  end;
end;

procedure TfrmTrsPurchaseOrderList.SetFilter;
begin
  GlobalPeriode.Reset;
  GlobalPeriode.setPeriode(cmbOpr.ItemIndex-1, dtpAwal.Date, dtpAkhir.Date);
//  GlobalPeriode.setPeriode2(cmbOpr.ItemIndex-1, cmbOpr2.ItemIndex-1, dtpAwal.Date, dtpAkhir.Date, dtpAwal2.Date, dtpAkhir2.Date);
  GlobalFilter.Reset;
  GlobalFilter.RelasiID:= txtVendor.Tag;
  GlobalFilter.SpecID  := txtSpec.Tag;
  GlobalFilter.StatusID:= cmbStatus.Tag;
  GlobalFilter.TipeID  := IntToStr(cmbJensi.Tag);
  GlobalFilter.Numeric1:= cmbBayar.ItemIndex;
end;

procedure TfrmTrsPurchaseOrderList.tbtNewClick(Sender: TObject);
var NewTransaction: TDockForm;
begin
 if not TSystemAccess.isCan(CAN_ADD,AktiveControl.Tag) then exit;
  NewTransaction:= ShowForm(Purpose);
  NewTransaction.Execute(Purpose, 0);
end;

procedure TfrmTrsPurchaseOrderList.tbtDetailClick(Sender: TObject);
var NewTransaction: TDockForm;
begin
  if not TSystemAccess.isCan(CAN_EDIT,AktiveControl.Tag) then exit;
  if grid.Ints[colId, grid.Row] = 0 then exit;
  NewTransaction:= ShowForm(Purpose);
  NewTransaction.Execute(Purpose, grid.Ints[colId, grid.Row]);
end;

procedure TfrmTrsPurchaseOrderList.gridGetAlignment(Sender: TObject;
  ARow, ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  case purpose of
    TRANS_TYPE_ORDER  : if (ACol = 0) or (ACol > 8) then HAlign:= taRightJustify;
    TRANS_TYPE_RECEIPT: if (ACol = 0) or (ACol > 7) then HAlign:= taRightJustify;
    TRANS_TYPE_RETUR  : if (ACol = 0) or (ACol > 5) then HAlign:= taRightJustify;
  end;
end;

procedure TfrmTrsPurchaseOrderList.gridDblClickCell(Sender: TObject;
  ARow, ACol: Integer);
begin
  tbtDetail.Click
end;

procedure TfrmTrsPurchaseOrderList.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  //if ShipmentList <> nil then ShipmentList.Free;
  //ShipmentList:= nil;
end;

procedure TfrmTrsPurchaseOrderList.tbtRefreshClick(Sender: TObject);
begin
  if cmbFormat.ItemIndex = 0 then
    LoadData
  else LoadDetailReceipt;  
end;

procedure TfrmTrsPurchaseOrderList.ToolButton5Click(Sender: TObject);
begin
  InitFilter
end;

procedure TfrmTrsPurchaseOrderList.btnSpecClick(Sender: TObject);
var ID: integer;
begin
  ID:= frmMstCodeList.Execute(1);
  if ID <> 0 then begin
    txtSpec.Tag := ID;
    GlobalFilter.SpecId:= txtSpec.Tag;
    txtSpec.Text:= TMstCode.getName(ID);
  end;
end;

procedure TfrmTrsPurchaseOrderList.cmbJensiChange(Sender: TObject);
begin
  cmbJensi.Tag:= cmbJensi.ItemIndex;
end;

procedure TfrmTrsPurchaseOrderList.cmbStatusChange(Sender: TObject);
begin
  case cmbStatus.ItemIndex of
    0: cmbStatus.Tag:= -1;
    1: cmbStatus.Tag:= 0;
    2: cmbStatus.Tag:= 1;
  end;  

end;

procedure TfrmTrsPurchaseOrderList.Button1Click(Sender: TObject);
var id: integer;
begin
  id:= frmLookup.Execute('SPL');
  if Id > 0 then begin
    txtVendor.Text:= TMstRelation.GetName(id);
    txtVendor.Tag:= id;
  end;
end;

procedure TfrmTrsPurchaseOrderList.cmbOprChange(Sender: TObject);
begin
  dtpAkhir.Enabled:= cmbOpr.ItemIndex = 4;
end;

procedure TfrmTrsPurchaseOrderList.cmbOpr2Change(Sender: TObject);
begin
  dtpAkhir2.Enabled:= cmbOpr2.ItemIndex = 4;
end;

procedure TfrmTrsPurchaseOrderList.tbtPrintClick(Sender: TObject);
begin
   if MustRegister then exit;
   if TSystemAccess.isCan(CAN_PRINT,AktiveControl.Tag) then
  if GlobalSystemConfig.localSetting.PrinterAdm <> '' then begin
     if (getDefaultPrinter <> GlobalSystemConfig.localSetting.PrinterAdm) then
         setDefaultPrinter(GlobalSystemConfig.localSetting.PrinterAdm);
  end;

  try
    Application.CreateForm(TqrpPurchaseOrderListPrint, qrpPurchaseOrderListPrint);
    qrpPurchaseOrderListPrint.Executes(grid,purpose);
  finally
    qrpPurchaseOrderListPrint.Destroy;
  end;
end;

procedure TfrmTrsPurchaseOrderList.ttDeleteClick(Sender: TObject);
begin
  inherited;
 if not TSystemAccess.isCan(CAN_DELETE,AktiveControl.Tag) then exit;
  if Confirmed('Hapus data ?') then begin
    if TTrsReceipt.DeletePostTrans(grid.Ints[colID, grid.Row]) then begin
      grid.ClearRows(grid.Row, 1);
      if grid.RowCount > 2 then grid.RemoveRows(grid.Row, 1);
    end;
  end;
end;

procedure TfrmTrsPurchaseOrderList.cmbBayarChange(Sender: TObject);
begin
//

end;

procedure TfrmTrsPurchaseOrderList.LoadDetailReceipt;
var data: TMysqlResult;
  i, spl_ID, row: integer;
  tgl: TDate;
  new_spl, new_date: boolean;
begin
  try
    StartProgress;

    grid.Clear;
    grid.Options := [goRangeSelect, goDrawFocusSelected, goRowSelect];

    grid.RowCount:= 3;
    grid.ColCount:= 11;
    grid.Cells[colCode, 0]:= 'Barcode';
    grid.Cells[colNama, 0]:= 'Nama Barang';
    grid.Cells[colQty,  0]:= 'QTY';
    grid.Cells[colSat,  0]:= 'Sat';
    grid.Cells[colHrg,  0]:= 'Harga';
    grid.Cells[colTotal,0]:= 'Jumlah';

    SetFilter;
    data:= TTrsReceipt.LoadRekapDetail;
    tgl:= 0;
    spl_ID:= -1;
    for i:= 1 to data.RecordCount do begin

    //0relation_id, 1trans_date, 2receipt_id, 3barcode, 4item_name, 5quantity, 6price, 7amount, '+
    //8satuan, 9suplier

      ProsesProgress(i, data.RecordCount);
      new_spl:= spl_ID <> BufferToInteger(data.FieldValue(0));
      if new_spl then begin
        if i <> 1 then grid.AddRow;
        row:= grid.RowCount-2;
        tgl:= 0;
        grid.MergeCells(colCust, row, 4, 1);
        grid.Cells[colCust,  row]:= data.FieldValue(9);
        grid.AddRow;
      end;

      new_date:= tgl <> BufferToDateTime(data.FieldValue(1));
      if new_date then begin
        row:= grid.RowCount-2;
        grid.MergeCells(colTgl, row, 2, 1);
        grid.Dates[colTgl,  row]:= BufferToDateTime(data.FieldValue(1));
        grid.AddRow;
      end;
      row:= grid.RowCount-2;

      grid.Ints[colID, row]:= BufferToInteger(data.FieldValue(2));

      grid.Cells[colCode,  row]:= data.FieldValue(3);
      grid.Cells[colNama,  row]:= data.FieldValue(4);
      grid.Cells[colQty,   row]:= FloatToStrFmtNull(BufferToFloat(data.FieldValue(5)));
      grid.Cells[colSat,   row]:= data.FieldValue(8);
      grid.Cells[colHrg,   row]:= FloatToStrFmtNull(BufferToFloat(data.FieldValue(6)));
      grid.Cells[colTotal, row]:= FloatToStrFmtNull(BufferToFloat(data.FieldValue(7)));
      grid.AddRow;
      spl_ID := BufferToInteger(data.FieldValue(0));
      tgl    := BufferToDateTime(data.FieldValue(1));
      data.MoveNext;
    end;
    data.destroy;

  finally
    grid.AutoSizeColumns(true, 5);
    grid.ColWidths[colID]:=0;
    EndProgress;
  end;
end;

end.
