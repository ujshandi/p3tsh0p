unit LookupTrx;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, BaseGrid, AdvGrid, StdCtrls, AdvEdit, ComCtrls, ExtCtrls,
  SUIImagePanel, math, dateutils, strutils;

type
  TfrmLookupTrx = class(TForm)
    suiPanel1: TsuiPanel;
    suiPanel2: TsuiPanel;
    dtpAkhir: TDateTimePicker;
    dtpAwal: TDateTimePicker;
    cmbOpr: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    txtVendor: TAdvEdit;
    Button1: TButton;
    cmbStatus: TComboBox;
    Label6: TLabel;
    Button2: TButton;
    grid: TAdvStringGrid;
    procedure gridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure gridDblClickCell(Sender: TObject; ARow,
      ACol: Integer);
    procedure cmbStatusChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure cmbOprChange(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure gridGetAlignment(Sender: TObject; ARow, ACol: Integer;
      var HAlign: TAlignment; var VAlign: TVAlignment);
  private
    NamaTable: string;
    procedure requeryData();
  public
    function Execute(aTableName: string): integer;
    function ExecuteReceipt(aTableName: string): integer;
  end;

var
  frmLookupTrx: TfrmLookupTrx;

implementation

uses uMysqlClient, MySQLConnector, UConst, UConstTool, Subroutines,
  LookupData, UMaster;

{$R *.dfm}

procedure TfrmLookupTrx.gridKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case key  of
    VK_RETURN: ModalResult:= mrOK;
    VK_ESCAPE: ModalResult:= mrCancel;
  end
end;

procedure TfrmLookupTrx.gridDblClickCell(Sender: TObject; ARow,
  ACol: Integer);
begin
  ModalResult:= mrOK;
end;

function TfrmLookupTrx.Execute(aTableName: string): integer;
begin
  cmbStatus.Enabled:= True;
  Result := 0;
  NamaTable:= aTableName;
  cmbOpr.ItemIndex:= 3;
  dtpAwal.Date:= StartOfTheMonth(ServerNow);
  dtpAkhir.Date:= EndOfTheMonth(ServerNow);
  cmbOprChange(nil);

  txtVendor.Text:= TMstRelation.GetName(GlobalFilter.RelasiID);
  txtVendor.Tag:= GlobalFilter.RelasiID;

  cmbStatus.ItemIndex:= 1;
  cmbStatusChange(nil);
  requeryData();
  Self.ShowModal;
  if ModalResult = mrOk then
    Result:= grid.Ints[1, grid.Row];
end;

procedure TfrmLookupTrx.requeryData();
var i,j: integer; header: TMysql_FieldDef;
  sqL,filter: string;
begin
  GlobalPeriode.setPeriode(cmbOpr.ItemIndex, dtpAwal.Date, dtpAkhir.Date);
  if GlobalPeriode.PeriodeAwal1 <> 0 then
    filter:= filter + ' and O.trans_date '+FormatSQLOperator(GlobalPeriode.OpPeriodeAwal1)+FormatSQLDate(GlobalPeriode.PeriodeAwal1);
  if GlobalPeriode.PeriodeAkhir1 <> 0 then
    filter:= filter + ' and O.trans_date '+FormatSQLOperator(GlobalPeriode.OpPeriodeAkhir1)+FormatSQLDate(GlobalPeriode.PeriodeAkhir1);
  if txtVendor.Tag <> 0 then
    filter:= filter + ' and O.relation_id = '+FormatSQLNumber(txtVendor.Tag);
  if (cmbStatus.Tag <> -1) and (NamaTable = 'ORDER') then
    filter:= filter + ' and O.sudah_diterima = '+FormatSQLNumber(cmbStatus.Tag);
  if NamaTable = 'FAKTUR' then filter:= filter + ' and O.sisa > 0 ';
  if NamaTable = 'STRUK' then filter:= filter + ' and O.sisa > 0 ';

  if NamaTable = 'ORDER' then
    sqL:=
    'select distinct '+
      'O.order_id, O.trans_num as ''No Trx'', O.trans_date as ''Tgl Order'', O.expr_date as ''Tgl Expr'', O.delivery_date as ''Tgl Kirim'', '+
      '(select relation_name from mst_relation r where r.relation_id= O.relation_id) as Supplier, '+
      'O.Subtotal, (O.disc_mst + O.disc_detail) as Discount, O.tax as Pajak, O.Total '+
    'from trs_order_mst O where O.status_id = 1 '+filter+
    ' order by O.trans_date, O.trans_num'

  else if NamaTable = 'RECEIPT' then
  {  sqL:=
    'select distinct '+
      'O.receipt_id, O.trans_num as ''No Trx'', O.trans_date as ''Tgl Terima'', O.expr_date as ''Tgl Expr'', '+
      '(select relation_name from mst_relation r where r.relation_id= O.relation_id) as Supplier, '+
      'O.Subtotal, (O.disc_mst + O.disc_detail) as Discount, O.tax as Pajak, O.Biaya, O.Materai, O.Total '+
    'from trs_receipt_mst O where O.status_id = 1'+filter+
    ' order by O.trans_date, O.trans_num'}
    sqL:=
    'select distinct '+
      'O.receipt_id, O.trans_num as ''No Trx'', O.trans_date as ''Tgl Terima'',  '+
      '(select relation_name from mst_relation r where r.relation_id= O.relation_id) as Supplier, '+
      'O.Subtotal, (O.disc_mst + O.disc_detail) as Discount, O.Total '+
    'from trs_receipt_mst O where O.status_id = 1'+filter+
    ' order by O.trans_date, O.trans_num'

  else if NamaTable = 'FAKTUR' then
  {sqL:=
    'select distinct '+
      'O.receipt_id, O.trans_num as ''No Trx'', O.trans_date as ''Tgl Terima'', O.expr_date as ''Tgl Expr'', '+
      '(select relation_name from mst_relation r where r.relation_id= O.relation_id) as Supplier, '+
      'O.Subtotal, (O.disc_mst + O.disc_detail) as Discount, O.tax as Pajak, O.Biaya, O.Materai, O.Total, O.sisa '+
    'from trs_receipt_mst O where O.status_id = 1 '+filter+
    ' order by O.trans_date, O.trans_num'}
    sqL:=
    'select distinct '+
      'O.receipt_id, O.trans_num as ''No Trx'', O.trans_date as ''Tgl Terima'', '+
      '(select relation_name from mst_relation r where r.relation_id= O.relation_id) as Supplier, '+
      'O.Subtotal, (O.disc_mst + O.disc_detail) as Discount, O.Total, O.sisa '+
    'from trs_receipt_mst O where O.status_id = 1 '+filter+
    ' order by O.trans_date, O.trans_num'

  else if NamaTable = 'STRUK' then
    sqL:=
    'select distinct '+
      'O.sales_id, O.trans_num as ''No Trx'', O.trans_date as ''Tgl Struk'', '+
      '(select nama from mst_pasien r where r.pasien_id= O.pasien_id) as Pasien, '+
      '(O.Subtotal + O.disc_detail) as Subtotal, '+
      '((O.Subtotal + O.disc_detail) * (disc_mst/100) + disc_val_mst) as Discount, '+
      'O.tax as Pajak, O.Total, O.sisa '+
    'from trs_sales_mst O '+
    ifthen(filter<>'', ' where ' +copy(filter, 5, length(filter)))+
    ' order by O.trans_date, O.trans_num';

  try
    Screen.Cursor:= crSQLWait;
    MySQLResult:= OpenSQL(sqL);
    grid.Clear;
    grid.RowCount:= IfThen(MySQLResult.RecordCount > 0, MySQLResult.RecordCount + 1, 2);
    grid.ColCount:= MySQLResult.FieldsCount+2;
    grid.FixedRows:= 1;
    for i:= 0 to MySQLResult.FieldsCount-1 do begin
      header:= MySQLResult.FieldDef(i)^;
      grid.Cells[i+1, 0]:= header.Name;
    end;

    if (NamaTable = 'ORDER') then begin
      for i:= 1 to MySQLResult.RecordCount do begin
        //0-order_id, 1-trans_num, 2-trans_date, 3-expr_date, 4-delivery_date, 5-Supplier,
        for j:= 0 to MySQLResult.FieldsCount-1 do
          if (j >= 2) and (j <= 4) then
            grid.Dates[j+1,i]:= BufferToDateTime(MySQLResult.FieldValue(j))
          else if (j > 5) then
            grid.Cells[j+1,i]:= FloatToStrFmt(BufferToFloat(MySQLResult.FieldValue(j)))
          else grid.Cells[j+1,i]:= MySQLResult.FieldValue(j);
        MySQLResult.MoveNext;
      end;
    end

    else if (NamaTable = 'RECEIPT') or (NamaTable = 'FAKTUR') then begin
      //0-receipt_id, 1-trans_num, 2-trans_date, 3-expr_date, 4-Supplier,
      for i:= 1 to MySQLResult.RecordCount do begin
        for j:= 0 to MySQLResult.FieldsCount-1 do
          if (j = 2) then//and (j <= 3) then
            grid.Dates[j+1,i]:= BufferToDateTime(MySQLResult.FieldValue(j))
          else if (j > 4) then
            grid.Cells[j+1,i]:= FloatToStrFmt(BufferToFloat(MySQLResult.FieldValue(j)))
          else grid.Cells[j+1,i]:= MySQLResult.FieldValue(j);
        MySQLResult.MoveNext;
      end;
    end

    else if (NamaTable = 'STRUK') then begin
      //0-sales_id, 1-trans_num, 2-trans_date, 3-Customer
      for i:= 1 to MySQLResult.RecordCount do begin
        for j:= 0 to MySQLResult.FieldsCount-1 do
          if (j = 2) then
            grid.Dates[j+1,i]:= BufferToDateTime(MySQLResult.FieldValue(j))
          else if (j > 3) then
            grid.Cells[j+1,i]:= FloatToStrFmt(BufferToFloat(MySQLResult.FieldValue(j)))
          else grid.Cells[j+1,i]:= MySQLResult.FieldValue(j);
        MySQLResult.MoveNext;
      end;
    end;

    MySQLResult.destroy;
    grid.AutoSizeColumns(TRUE, 4);
    grid.ColWidths[0]:= 18;
    grid.ColWidths[1]:= 0;
  finally
    Screen.Cursor:= crDefault;
  end;
end;

procedure TfrmLookupTrx.cmbStatusChange(Sender: TObject);
begin
  case cmbStatus.ItemIndex of
    0: cmbStatus.Tag:= -1;
    1: cmbStatus.Tag:= 0;
    2: cmbStatus.Tag:= 1;
  end;
end;

procedure TfrmLookupTrx.Button1Click(Sender: TObject);
var id: integer;
begin
  id:= frmLookup.Execute('SPL');
  if Id > 0 then begin
    txtVendor.Text:= TMstRelation.GetName(id);
    txtVendor.Tag:= id;
  end;
end;

procedure TfrmLookupTrx.cmbOprChange(Sender: TObject);
begin
  dtpAkhir.Enabled:= cmbOpr.ItemIndex = 3;
end;

procedure TfrmLookupTrx.Button2Click(Sender: TObject);
begin
  requeryData();
end;

function TfrmLookupTrx.ExecuteReceipt(aTableName: string): integer;
begin
  cmbStatus.Enabled:= False;
  Result := 0;
  NamaTable:= aTableName;
  cmbOpr.ItemIndex:= 3;
  dtpAwal.Date:= StartOfTheMonth(ServerNow);
  dtpAkhir.Date:= EndOfTheMonth(ServerNow);
  cmbOprChange(nil);

  txtVendor.Text:= TMstRelation.GetName(GlobalFilter.RelasiID);
  txtVendor.Tag:= GlobalFilter.RelasiID;

  cmbStatus.ItemIndex:= 0;
  cmbStatusChange(nil);
  requeryData();
  Self.ShowModal;
  if ModalResult = mrOk then
    Result:= grid.Ints[1, grid.Row];
end;

procedure TfrmLookupTrx.gridGetAlignment(Sender: TObject; ARow,
  ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  if (NamaTable = 'ORDER') and (ACol > 6) then HAlign:= taRightJustify
  else if ((NamaTable = 'RECEIPT') or (NamaTable = 'FAKTUR'))and (ACol > 5) then HAlign:= taRightJustify
  else if (NamaTable = 'STRUK') and (ACol > 4) then HAlign:= taRightJustify
end;

end.
