unit MstPasienList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ExtCtrls, Grids, BaseGrid, AdvGrid, StdCtrls,
  AdvEdit, strUtils, Math,
  UMaster, WinXP, Menus, SUIImagePanel,
  frmDockForm, SUIButton;

type
  TfrmMstPasienList = class(TDockForm)
    ToolBar1: TToolBar;
    tbtNew: TToolButton;
    tbtDetail: TToolButton;
    tbtRefresh: TToolButton;
    tbtPrint: TToolButton;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    WinXP1: TWinXP;
    ToolButton5: TToolButton;
    suiPanel1: TsuiPanel;
    suiPanel2: TsuiPanel;
    txtNama: TAdvEdit;
    grid: TAdvStringGrid;
    txtAlamat: TAdvEdit;
    txtKota: TAdvEdit;
    cmbStatus: TComboBox;
    Label1: TLabel;
    txtLimit: TAdvEdit;
    spdFirst: TsuiButton;
    spdPrev: TsuiButton;
    spdNext: TsuiButton;
    spdLast: TsuiButton;
    lblHal: TLabel;
    ToolButton3: TToolButton;
    procedure gridGetAlignment(Sender: TObject; ARow, ACol: Integer;
      var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure tbtNewClick(Sender: TObject);
    procedure tbtDetailClick(Sender: TObject);
    procedure tbtRefreshClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ToolButton3Click(Sender: TObject);
    procedure ToolButton5Click(Sender: TObject);
    procedure tbtPrintClick(Sender: TObject);
    procedure gridRowChanging(Sender: TObject; OldRow, NewRow: Integer;
      var Allow: Boolean);
    procedure gridClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure cmbStatusChange(Sender: TObject);
    procedure gridDblClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure txtLimitChange(Sender: TObject);
    procedure spdFirstClick(Sender: TObject);
    procedure spdPrevClick(Sender: TObject);
    procedure spdNextClick(Sender: TObject);
    procedure spdLastClick(Sender: TObject);
  private

    procedure InitForm;
    procedure SetFilter;
    procedure InitFilter;
    procedure LoadData;

  public
    procedure Execute(ID: integer); override;
  end;

var
  frmMstPasienList: TfrmMstPasienList;

implementation

uses UConstTool, MainMenu, Subroutines,
  uMysqlClient, MySQLConnector,
  UTransaction, UConst, UQueryPackage, MstPasien, PasienListPrint;

const
  colNo     = 0;
  colId     = 1;
  colKode   = 2;
  colNama   = 3;
  colAlamat = 4;
  colKota   = 5;
  colPhone  = 6;
  colKontak = 7;
  colCardID = 8;

{$R *.dfm}

{ TfrmMstRelationList }

procedure TfrmMstPasienList.Execute(ID: integer);
begin
  inherited;
  ToolBar1.ParentColor:= false;
  ToolBar1.Color:= clWhite;

  InitForm;
  SetFilter;

  LoadData;
  spdFirst.Enabled:= False;
  spdPrev.Enabled:= False;
  Run(Self);
end;

procedure TfrmMstPasienList.InitFilter;
begin
  GlobalPeriode.Reset;
  txtNama.Clear;
  txtAlamat.Clear;
  txtKota.Clear;
  cmbStatus.ItemIndex:= 1;
  cmbStatusChange(nil);
  txtLimit.Tag:=0;
  txtLimit.IntValue:= 100;
  txtLimitChange(nil);
end;

procedure TfrmMstPasienList.InitForm;
begin
  InitFilter;
  grid.AutoSizeColumns(True, 5);
  grid.ColWidths[colID]:= 0;
end;

procedure TfrmMstPasienList.LoadData;
var i: integer; relasi: TMysqlResult;
begin
  try
    StartProgress;

    SetFilter;
    relasi:= TMstPasien.LoadFromDB;
    grid.ClearNormalCells;
    grid.RowCount:= IfThen(relasi.RecordCount > 0, relasi.RecordCount + 1, 2);

    //0pasien_id, 1kode, 2nama, 3alamat, 4phone, 5kota, 6sex, 7tgl_lahir, 8card_id

    for i:= 1 to relasi.RecordCount do begin
      ProsesProgress(i, relasi.RecordCount);
      grid.Ints[colNo,     i]:= i+txtLimit.Tag;
      grid.Ints[colId,     i]:= BufferToInteger(relasi.FieldValue(0));
      grid.Cells[colKode,  i]:= relasi.FieldValue(1);
      grid.Cells[colNama,  i]:= relasi.FieldValue(2);
      grid.Cells[colAlamat,i]:= relasi.FieldValue(3);
      grid.Cells[colKota,  i]:= relasi.FieldValue(5);
      grid.Cells[colPhone, i]:= relasi.FieldValue(4);
      grid.Cells[colCardID,i]:= relasi.FieldValue(8);
      relasi.MoveNext;
    end;
    spdNext.Enabled:= relasi.RecordCount >= txtLimit.IntValue;
    spdLast.Enabled:= relasi.RecordCount >= txtLimit.IntValue;
    relasi.destroy;
    grid.AutoSizeColumns(True, 5);
    grid.ColWidths[colID]:= 0;
  finally
    EndProgress;
  end;
end;

procedure TfrmMstPasienList.SetFilter;
begin
  GlobalFilter.StatusID:= cmbStatus.ItemIndex;
  GlobalFilter.Name    := txtNama.Text;
  GlobalFilter.FString1:= txtAlamat.Text;
  GlobalFilter.FString2:= txtKota.Text;
  GlobalFilter.FOffset := txtLimit.IntValue;
  GlobalFilter.FLimit  := txtLimit.Tag;
end;

procedure TfrmMstPasienList.gridGetAlignment(Sender: TObject; ARow,
  ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin

  if (ACol = colNo) then HAlign:= taRightJustify
end;

procedure TfrmMstPasienList.tbtNewClick(Sender: TObject);
begin
  frmMstPasien.Execute(0);

end;

procedure TfrmMstPasienList.tbtDetailClick(Sender: TObject);
begin
  frmMstPasien.Execute(StrToIntDef(grid.Cells[colId, grid.Row],0));
end;

procedure TfrmMstPasienList.tbtRefreshClick(Sender: TObject);
begin
  LoadData
end;

procedure TfrmMstPasienList.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  //if Relation <> nil then Relation.Free;
  //Relation:= nil;
end;

procedure TfrmMstPasienList.ToolButton3Click(Sender: TObject);
begin
  if Confirmed('Hapus Item?') then
  if TMstPasien.deleteDate(grid.Ints[colId, grid.Row]) then begin
     grid.ClearRows(grid.Row,1);
     if grid.RowCount > 2 then grid.RemoveRows(grid.Row,1);
  end;
end;

procedure TfrmMstPasienList.ToolButton5Click(Sender: TObject);
begin
  InitFilter
end;

procedure TfrmMstPasienList.tbtPrintClick(Sender: TObject);
begin
  if MustRegister then exit;
  try
    Application.CreateForm(TqrpPasienList, qrpPasienList);
    //qrpPasienList.Printer.PrinterIndex:= -1;
    qrpPasienList.Executes(grid);
  finally
    qrpPasienList.Destroy;
  end;
end;

procedure TfrmMstPasienList.gridRowChanging(Sender: TObject; OldRow,
  NewRow: Integer; var Allow: Boolean);
begin
  if OldRow <= grid.RowCount-1 then
  grid.RowHeights[OldRow]:= grid.DefaultRowHeight;
  grid.AutoSizeRow(NewRow);
  if grid.RowHeights[NewRow] < grid.DefaultRowHeight then
    grid.RowHeights[NewRow]:= grid.DefaultRowHeight;
end;

procedure TfrmMstPasienList.gridClickCell(Sender: TObject; ARow,
  ACol: Integer);
begin
  grid.AutoSizeRow(grid.Row);
end;


procedure TfrmMstPasienList.cmbStatusChange(Sender: TObject);
begin
  inherited;
//
end;

procedure TfrmMstPasienList.gridDblClickCell(Sender: TObject; ARow,
  ACol: Integer);
begin
  tbtDetail.Click
end;

procedure TfrmMstPasienList.txtLimitChange(Sender: TObject);
begin
  spdFirst.Enabled:= txtLimit.IntValue > 0;
  spdPrev.Enabled:= txtLimit.IntValue > 0;
  spdNext.Enabled:= txtLimit.IntValue > 0;
  spdLast.Enabled:= txtLimit.IntValue > 0;
end;

procedure TfrmMstPasienList.spdFirstClick(Sender: TObject);
begin
  txtLimit.Tag:= 0;
  spdFirst.Enabled:= False;
  spdPrev.Enabled:= False;
  spdNext.Enabled:= True;
  spdLast.Enabled:= True;
  lblHal.Caption:= 'Halaman: 1';
  LoadData;
end;

procedure TfrmMstPasienList.spdPrevClick(Sender: TObject);
begin
  txtLimit.Tag:= txtLimit.Tag - txtLimit.IntValue;
  spdFirst.Enabled:= txtLimit.Tag > 0;
  spdPrev.Enabled:= txtLimit.Tag > 0;
  spdNext.Enabled:= True;
  spdLast.Enabled:= True;
  lblHal.Caption:= 'Halaman: ' + IntToStr((txtLimit.Tag + txtLimit.IntValue) div txtLimit.IntValue);
  LoadData;
end;

procedure TfrmMstPasienList.spdNextClick(Sender: TObject);
var lmt: integer;
begin
  SetFilter;
  lmt:= TMstPasien.countFromDB;
  txtLimit.Tag:= txtLimit.Tag + txtLimit.IntValue;
  spdFirst.Enabled:= True;
  spdPrev.Enabled:= True;
  lblHal.Caption:= 'Halaman: ' + IntToStr((txtLimit.Tag+txtLimit.IntValue) div txtLimit.IntValue);

  spdNext.Enabled:= ((txtLimit.Tag + txtLimit.IntValue)<= lmt);
  spdLast.Enabled:= ((txtLimit.Tag + txtLimit.IntValue)<= lmt);
  LoadData;
end;

procedure TfrmMstPasienList.spdLastClick(Sender: TObject);
begin
  SetFilter;
  txtLimit.Tag:= txtLimit.IntValue * (TMstPasien.countFromDB div txtLimit.IntValue);
  spdFirst.Enabled:= True;
  spdPrev.Enabled:= True;
  spdNext.Enabled:= False;
  spdLast.Enabled:= False;
  lblHal.Caption:= 'Halaman: ' + IntToStr((txtLimit.Tag + txtLimit.IntValue) div txtLimit.IntValue);
  LoadData;

end;

end.
