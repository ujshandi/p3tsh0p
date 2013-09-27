unit trsSalesList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, ToolWin, StdCtrls, AdvEdit, UTransaction,
  Grids, BaseGrid, AdvGrid, WinXP, SUIImagePanel, Math, DateUtils, strutils,
  frmDockForm;

type
  TfrmTrsSalesList = class(TDockForm)
    ToolBar1: TToolBar;
    tbtRefresh: TToolButton;
    ToolButton2: TToolButton;
    tbtPrint: TToolButton;
    WinXP1: TWinXP;
    suiPanel1: TsuiPanel;
    suiPanel2: TsuiPanel;
    grid: TAdvStringGrid;
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
    txtCust: TAdvEdit;
    btnCust: TButton;
    cmbJenis: TComboBox;
    Label3: TLabel;
    tbtDetail: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    procedure gridGetAlignment(Sender: TObject; ARow, ACol: Integer;
      var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tbtRefreshClick(Sender: TObject);
    procedure cmbOprChange(Sender: TObject);
    procedure tbtPrintClick(Sender: TObject);
    procedure btnKasirClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure btnCustClick(Sender: TObject);
    procedure cmbJenisChange(Sender: TObject);
    procedure tbtDetailClick(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure gridDblClickCell(Sender: TObject; ARow, ACol: Integer);
  private
    procedure SetFilter;
    procedure InitFilter;
    procedure LoadDataJual;
  public
    procedure Execute(id: integer); override;
  end;

var
  frmTrsSalesList: TfrmTrsSalesList;

implementation

uses Subroutines, MainMenu,
  ADOInt, MstCodeList, MySQLConnector, uMysqlClient, UConst, UMaster,
  LookupData;

const
  colNo = 0;
  colID = 1; //6

{$R *.dfm}

{ TfrmTrsItemShipmentList }

procedure TfrmTrsSalesList.Execute(id: integer);
begin
  inherited;
  ToolBar1.ParentColor:= false;
  ToolBar1.Color:= clWhite;
  InitFilter;
  Run(Self);
end;

procedure TfrmTrsSalesList.InitFilter;
begin
  GlobalFilter.Reset;
  GlobalPeriode.Reset;
  txtKasir.Tag:= 0;
  txtShift.Tag:= 0;

  txtCust.Tag:= 0;
  txtShift.Text:= 'Semua Shift';
  txtKasir.Text:= 'Semua Kasir';
  txtCust.Text:= 'Semua Pasien';
  cmbJenis.ItemIndex:= 0;
  cmbOpr.ItemIndex:= 3;
  cmbOprChange(nil);
  cmbJenisChange(nil);
  dtpAwal.Date:= ServerNow;
  dtpAkhir.Date:= ServerNow;
end;

procedure TfrmTrsSalesList.SetFilter;
begin
  GlobalFilter.Reset;
  GlobalFilter.SeriesID := txtShift.Tag;
  GlobalFilter.StatusID := txtCust.Tag;
  GlobalFilter.Numeric2 := txtKasir.Tag;

  GlobalFilter.Numeric1 := cmbJenis.Tag;

  GlobalPeriode.setPeriode(cmbOpr.ItemIndex, dtpAwal.Date, dtpAkhir.Date);
end;

procedure TfrmTrsSalesList.gridGetAlignment(Sender: TObject;
  ARow, ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  if (ACol > 1) and (ACol < 5) then HAlign:= taLeftJustify
  else HAlign:= taRightJustify;
end;

procedure TfrmTrsSalesList.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
//  if lsGudang <> nil then lsGudang.Free;
//  lsGudang:= nil;
end;

procedure TfrmTrsSalesList.tbtRefreshClick(Sender: TObject);
begin
  LoadDataJual;
end;

procedure TfrmTrsSalesList.LoadDataJual;
var i,j: integer; header: TMysql_FieldDef; data: TMysqlResult;
begin
  try
    StartProgress;
    SetFilter;
    grid.Clear;
    data:= TReport.LoadSalesRekap;

    grid.RowCount:= IfThen(data.RecordCount > 0, data.RecordCount + 2, 3);
    grid.ColCount:= data.FieldsCount+1;

    for i:= 0 to data.FieldsCount-1 do begin
      header:= data.FieldDef(i)^;
      grid.Cells[i+1, 0]:= header.Name;
    end;

//    0sales_id, 1trans_date, 2trans_num, 3Customer,
//    4Subtotal, 5disc_mst, 6disc_val_mst, 7tax, 8Total, 9Profit

    for i:= 1 to data.RecordCount do begin
      grid.Ints[0, i]:= i;
      for j:= 0 to data.FieldsCount-1 do
        if (j > 3) then
          grid.Cells[colID+j,i]:= FloatToStrFmt(BufferToFloat(data.FieldValue(j)))
        else if (j = 1) then
          grid.Dates[colID+j,i]:= BufferToDateTime(data.FieldValue(j))
        else grid.Cells[colID+j,i]:= data.FieldValue(j);
      data.MoveNext;
    end;
    data.destroy;

    for i:= 5 to grid.ColCount-1 do
      grid.Cells[i, grid.RowCount-1]:= FloatToStrFmt(grid.ColumnSum(i, 1, grid.RowCount-2));

    grid.AutoSizeColumns(TRUE, 4);
    grid.ColWidths[1]:= 0;

  finally
    EndProgress;
  end;
end;

procedure TfrmTrsSalesList.cmbOprChange(Sender: TObject);
begin
  dtpAkhir.Enabled:= cmbOpr.ItemIndex = 3;
end;

procedure TfrmTrsSalesList.tbtPrintClick(Sender: TObject);
begin
  if MustRegister then exit;
  //case Self.Tag of
  //502: qrpReportBeli.Executes(grid);
  //504: qrpReportJual.Executes(grid);
  //end;
end;

procedure TfrmTrsSalesList.btnKasirClick(Sender: TObject);
var id: integer;
begin
  id:= frmLookup.Execute('KASIR');
  if Id > 0 then begin
    txtKasir.Text:= TMstMaster.GetName(id);
    txtKasir.Tag:= id;
  end;
end;

procedure TfrmTrsSalesList.Button3Click(Sender: TObject);
var id: integer;
begin
  id:= frmLookup.Execute('SHIFT');
  if Id > 0 then begin
    txtShift.Text:= TMstMaster.GetName(id);
    txtShift.Tag:= id;
  end;
end;

procedure TfrmTrsSalesList.btnCustClick(Sender: TObject);
var id: integer;
begin
  id:= frmLookup.Execute('PASIEN');
  if Id > 0 then begin
    txtCust.Text:= TMstPasien.GetName(id);
    txtCust.Tag:= id;
  end;
end;

procedure TfrmTrsSalesList.cmbJenisChange(Sender: TObject);
begin
  cmbJenis.Tag:= cmbJenis.ItemIndex-1;
end;

procedure TfrmTrsSalesList.tbtDetailClick(Sender: TObject);
var NewTransaction: TDockForm;
begin
  NewTransaction:= ShowForm(SALES_TYPE_BOS);
  NewTransaction.Execute(SALES_TYPE_BOS, grid.Ints[colId, grid.Row]);
end;

procedure TfrmTrsSalesList.ToolButton3Click(Sender: TObject);
begin
  InitFilter
end;

procedure TfrmTrsSalesList.gridDblClickCell(Sender: TObject; ARow,
  ACol: Integer);
begin
  tbtDetail.Click
end;

end.

