unit MstRelationList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ExtCtrls, Grids, BaseGrid, AdvGrid, StdCtrls,
  AdvEdit, strUtils, Math,
  UMaster, WinXP, Menus, SUIImagePanel,
  frmDockForm;

type
  TfrmMstRelationList = class(TDockForm)
    ToolBar1: TToolBar;
    tbtNew: TToolButton;
    tbtDetail: TToolButton;
    tbtRefresh: TToolButton;
    tbtPrint: TToolButton;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    WinXP1: TWinXP;
    ToolButton5: TToolButton;
    PopupMenu1: TPopupMenu;
    Aktivasi1: TMenuItem;
    suiPanel1: TsuiPanel;
    suiPanel2: TsuiPanel;
    txtNama: TAdvEdit;
    grid: TAdvStringGrid;
    txtAlamat: TAdvEdit;
    txtKota: TAdvEdit;
    cmbStatus: TComboBox;
    Label1: TLabel;
    tbtDelete: TToolButton;
    procedure gridGetAlignment(Sender: TObject; ARow, ACol: Integer;
      var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure tbtNewClick(Sender: TObject);
    procedure tbtDetailClick(Sender: TObject);
    procedure tbtRefreshClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ToolButton3Click(Sender: TObject);
    procedure ToolButton5Click(Sender: TObject);
    procedure Aktivasi1Click(Sender: TObject);
    procedure tbtPrintClick(Sender: TObject);
    procedure gridRowChanging(Sender: TObject; OldRow, NewRow: Integer;
      var Allow: Boolean);
    procedure gridClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure gridCellValidate(Sender: TObject; Col, Row: Integer;
      var Value: String; var Valid: Boolean);
    procedure gridCanEditCell(Sender: TObject; ARow, ACol: Integer;
      var CanEdit: Boolean);
    procedure gridGetEditorType(Sender: TObject; ACol, ARow: Integer;
      var AEditor: TEditorType);
    procedure cmbStatusChange(Sender: TObject);
    procedure gridDblClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure tbtDeleteClick(Sender: TObject);
  private
    Purpose: integer;
    procedure InitForm;
    procedure SetFilter;
    procedure InitFilter;
    procedure LoadData;

    function saveAdjustment(realValue: double; row: integer): boolean;
    function saveAdjustmentPoint(realValue, row: integer): boolean;

  public
    procedure Execute(ID: integer); override;
  end;

var
  frmMstRelationList: TfrmMstRelationList;

implementation

uses UConstTool, MainMenu, Subroutines,
  MstRelation, uMysqlClient, MySQLConnector, SupplierListPrint,
  UTransaction, UConst, UQueryPackage, MstRelationAnimal;

const
  colNo = 0;
  colId = 1;
  colKode   = 2;
  colNama   = 3;
  colAlamat = 4;
  colKota   = 5;
  colPhone  = 6;
  colKontak = 7;
   colJenis = 8;
  colSaldo  = 9;
  colPoint  = 10;

  colOldVal = 11;
  colOldPoint = 12;


{$R *.dfm}

{ TfrmMstRelationList }

procedure TfrmMstRelationList.Execute(ID: integer);
begin
  inherited;
  ToolBar1.ParentColor:= false;
  ToolBar1.Color:= clWhite;

  if Self.Tag = 220 then begin Purpose:= RELASI_TYPE_SUPPLIER; suiPanel2.Caption := 'Daftar Supplier'; end
  else if Self.Tag = 221 then begin Purpose:= RELASI_TYPE_CUSTOMER ; suiPanel2.Caption := 'Daftar Customer'; end
  else if Self.Tag = 222 then begin Purpose:= RELASI_TYPE_SALESMAN; suiPanel2.Caption := 'Daftar Salesman'; end
  else if Self.Tag = 223 then begin Purpose:= RELASI_TYPE_CUSTOMER;; suiPanel2.Caption := 'Daftar Customer'; end;//asalna member

  InitForm;
  SetFilter;
  LoadData;
  Run(Self);
end;

procedure TfrmMstRelationList.InitFilter;
begin
  GlobalPeriode.Reset;
  txtNama.Clear;
  txtAlamat.Clear;
  txtKota.Clear;
  cmbStatus.ItemIndex:= 1;
  cmbStatusChange(nil);
end;

procedure TfrmMstRelationList.InitForm;
begin
  InitFilter;
end;

procedure TfrmMstRelationList.LoadData;
var i,j: integer; header: TMysql_FieldDef; relasi: TMysqlResult;
begin
  try
    Screen.Cursor:= crSQLWait;
    grid.ColWidths[0]:= 30;
    grid.ColWidths[colID]:= 0;


    grid.ColWidths[colKode   ]:= 45;
    grid.ColWidths[colNama   ]:= 160;
    grid.ColWidths[colKota   ]:= 80;
    grid.ColWidths[colPhone  ]:= 90;
    grid.ColWidths[colKontak ]:= 100;
    grid.ColWidths[colSaldo  ]:= 0;
    grid.ColWidths[colPoint   ]:= 0;
    grid.ColWidths[colJenis   ]:= 0;
    grid.ColWidths[colOldPoint]:=0;
    grid.ColWidths[colOldVal  ]:= 0;
    if Purpose = RELASI_TYPE_SUPPLIER
      then grid.ColWidths[colPoint]:= 0;
    if Purpose=RELASI_TYPE_CUSTOMER then grid.ColWidths[colJenis   ]:= 70;
    SetFilter;
    relasi:= TMstRelationArr.LoadFromDB;
    grid.Clear;
    grid.RowCount:= IfThen(relasi.RecordCount > 0, relasi.RecordCount + 1, 2);
    grid.ColCount:= 12;

    grid.FixedRows:= 1;
    for i:= 0 to relasi.FieldsCount-1 do begin
      header:= relasi.FieldDef(i)^;
      grid.Cells[i+1, 0]:= header.Name;
    end;

    //'0relation_id, 1KD, 2Nama, 3alamat, 4Kota, 5Phone

    relasi.First;
    for i:= 1 to relasi.RecordCount do begin
      grid.Ints[0,i]:= i;
      for j:= 0 to relasi.FieldsCount-1 do
        if j > relasi.FieldsCount-3 then begin
           grid.Cells[j+1,i]:= FloatToStrFmt(BufferToFloat(relasi.FieldValue(j)));
           grid.Cells[j+3,i]:= FloatToStrFmt(BufferToFloat(relasi.FieldValue(j)));
        end
        else if (j = 3) or (j = 5) then begin
          grid.Cells[j+1,i]:= AnsiReplaceText(relasi.FieldValue(j), ';', #13#10); 
        end
        else grid.Cells[j+1,i]:= relasi.FieldValue(j);
      relasi.MoveNext;
    end;
    relasi.destroy;

  finally
    Screen.Cursor:= crDefault;
  end;
end;

procedure TfrmMstRelationList.SetFilter;
begin
  GlobalFilter.Reset;
  GlobalFilter.TipeID  := IntToStr(Purpose);
  GlobalFilter.StatusID:= cmbStatus.ItemIndex;
  GlobalFilter.Name    := txtNama.Text;
  GlobalFilter.FString1:= txtAlamat.Text;
  GlobalFilter.FString2:= txtKota.Text;
end;

procedure TfrmMstRelationList.gridGetAlignment(Sender: TObject; ARow,
  ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin

  if (ACol > colJenis) then HAlign:= taRightJustify
end;

procedure TfrmMstRelationList.tbtNewClick(Sender: TObject);
begin
  if not TSystemAccess.isCan(CAN_ADD,AktiveControl.Tag) then exit;
  if  Purpose = RELASI_TYPE_CUSTOMER then
    frmMstRelationAnimal.Execute(0)
  else
    frmMstRelation.Execute(Purpose, 0);

end;

procedure TfrmMstRelationList.tbtDetailClick(Sender: TObject);
begin
 if not TSystemAccess.isCan(CAN_EDIT,AktiveControl.Tag) then exit;
 if  Purpose = RELASI_TYPE_CUSTOMER then
    frmMstRelationAnimal.Execute(StrToIntDef(grid.Cells[colId, grid.Row],0))
  else
  frmMstRelation.Execute(Purpose, StrToIntDef(grid.Cells[colId, grid.Row],0));
end;

procedure TfrmMstRelationList.tbtRefreshClick(Sender: TObject);
begin
  LoadData
end;

procedure TfrmMstRelationList.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  //if Relation <> nil then Relation.Free;
  //Relation:= nil;
end;

procedure TfrmMstRelationList.ToolButton3Click(Sender: TObject);
begin
  CariData(grid, Self);
end;

procedure TfrmMstRelationList.ToolButton5Click(Sender: TObject);
begin
  InitFilter
end;

procedure TfrmMstRelationList.Aktivasi1Click(Sender: TObject);
begin
 if not TSystemAccess.isCan(CAN_DELETE,AktiveControl.Tag) then exit;
  TMstRelation.activasi(grid.Ints[colId, grid.Row])
end;

procedure TfrmMstRelationList.tbtPrintClick(Sender: TObject);
begin
 if not TSystemAccess.isCan(CAN_PRINT,AktiveControl.Tag) then exit;
  if MustRegister then exit;
  try
    Application.CreateForm(TqrpSupplierList, qrpSupplierList);
  //  qrpSupplierList.Printer.PrinterIndex:= -1;
    qrpSupplierList.Executes(grid);
  finally
    qrpSupplierList.Destroy;
  end;
end;

procedure TfrmMstRelationList.gridRowChanging(Sender: TObject; OldRow,
  NewRow: Integer; var Allow: Boolean);
begin
  if OldRow <= grid.RowCount-1 then
  grid.RowHeights[OldRow]:= grid.DefaultRowHeight;
  grid.AutoSizeRow(NewRow);
  if grid.RowHeights[NewRow] < grid.DefaultRowHeight then
    grid.RowHeights[NewRow]:= grid.DefaultRowHeight;
end;

procedure TfrmMstRelationList.gridClickCell(Sender: TObject; ARow,
  ACol: Integer);
begin
  grid.AutoSizeRow(grid.Row);
end;

function TfrmMstRelationList.saveAdjustment(
  realValue: double; row: integer): boolean;
var adj: TTrsDebtAdjustment;
begin
  adj:= TTrsDebtAdjustment.Create(nil);
  adj.TransDate:= ServerNow;
  adj.RelationID:= grid.Ints[colId, row];
  adj.Amount:= realValue - grid.Floats[colOldVal, row];
  adj.UserID:= GlobalSystemUser.UserId;
  Result:= adj.InsertOnDB;
  if Result then grid.Floats[colOldVal, row]:= realValue;
  adj.Destroy;
end;

procedure TfrmMstRelationList.gridCellValidate(Sender: TObject; Col,
  Row: Integer; var Value: String; var Valid: Boolean);
begin
  if Col = colSaldo then begin
    if saveAdjustment(StrFmtToFloatDef(Value,0), Row) then
      Value:= FloatToStrFmt(StrFmtToFloatDef(Value,0));
  end
  else if Col = colPoint then begin
    if saveAdjustmentPoint(round(StrFmtToFloatDef(Value,0)), Row) then
      Value:= FloatToStrFmt(StrFmtToFloatDef(Value,0));
  end;
end;

procedure TfrmMstRelationList.gridCanEditCell(Sender: TObject; ARow,
  ACol: Integer; var CanEdit: Boolean);
begin
//  CanEdit:= (ACol in[colSaldo, colPoint]) and (grid.Ints[colId, ARow]<>0) and (grid.ColWidths[ACol]<>0);
end;

procedure TfrmMstRelationList.gridGetEditorType(Sender: TObject; ACol,
  ARow: Integer; var AEditor: TEditorType);
begin
  if ACol in[colSaldo, colPoint] then AEditor:= edFloat;
end;

function TfrmMstRelationList.saveAdjustmentPoint(realValue,
  row: integer): boolean;
begin
  Result:= True;
  save_to_relation_point(grid.Ints[colId, row], realValue - grid.Ints[colOldPoint, row], DB_CR_TYPE_DEBIT);
  grid.Floats[colOldPoint, row]:= realValue;
end;

procedure TfrmMstRelationList.cmbStatusChange(Sender: TObject);
begin
  inherited;
//
end;

procedure TfrmMstRelationList.gridDblClickCell(Sender: TObject; ARow,
  ACol: Integer);
begin
  tbtDetail.Click
end;

procedure TfrmMstRelationList.tbtDeleteClick(Sender: TObject);
begin
  inherited;
  if not TSystemAccess.isCan(CAN_DELETE,AktiveControl.Tag) then exit;
     if TMstRelation.Delete(grid.Ints[colId, grid.Row]) then begin
        Inform(MSG_SUCCESS_DELETING);
        tbtRefresh.Click;
     end;
end;

end.
