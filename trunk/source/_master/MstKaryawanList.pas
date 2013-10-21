unit MstKaryawanList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, BaseGrid, AdvGrid, StdCtrls, AdvEdit, ComCtrls, ToolWin,
  ExtCtrls, strUtils, Math,UPetshop,
  UMaster, WinXP, Menus, SUIImagePanel, UTransaction,
  frmDockForm, Buttons, SUIButton;

type
  TfrmMstKaryawanList = class(TDockForm)
    ToolBar1: TToolBar;
    tbtNew: TToolButton;
    tbtDetail: TToolButton;
    ToolButton1: TToolButton;
    ToolButton4: TToolButton;
    tbtRefresh: TToolButton;
    tbtPrint: TToolButton;
    WinXP1: TWinXP;
    ToolButton5: TToolButton;
    suiPanel1: TsuiPanel;
    suiPanel2: TsuiPanel;
    suiPanel3: TsuiPanel;
    txtSpec: TAdvEdit;
    Button1: TButton;
    grid: TAdvStringGrid;
    asgvc: TAdvStringGrid;
    cmbStatus: TComboBox;
    Label1: TLabel;
    txtNama: TAdvEdit;
    PopupMenu1: TPopupMenu;
    Aktivasi1: TMenuItem;
    ToolButton3: TToolButton;

    procedure gridGetAlignment(Sender: TObject; ARow, ACol: Integer;
      var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure tbtNewClick(Sender: TObject);
    procedure tbtDetailClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ToolButton5Click(Sender: TObject);
    procedure tbtRefreshClick(Sender: TObject);
    procedure tbtPrintClick(Sender: TObject);
    procedure Aktivasi1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure gridRowChanging(Sender: TObject; OldRow, NewRow: Integer;
      var Allow: Boolean);
    procedure gridGetCellColor(Sender: TObject; ARow, ACol: Integer;
      AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
    procedure gridDblClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure ToolButton3Click(Sender: TObject);

  private
    procedure InitGrid;
    procedure InitForm;
    procedure SetFilter;
    procedure InitFilter;
    procedure LoadData;
  public
    procedure Execute(id: integer=0);override;
  end;

var
  frmMstKaryawanList: TfrmMstKaryawanList;

implementation

uses UConstTool, MainMenu, Subroutines,
  MstCodeList, MstItem, UConst,
  mstItemListPrint, LookupData, uMysqlClient, MySQLConnector, MstService,
  MstKaryawan;

const
  colNo      = 0;
  colNik = 1;
  colName    = 2;
  colAlamat = 3;
  colJabatan = 4;
  colTglLahir = 5;
  colTelp1 = 6;
  colTelp2 = 7;
  colDisabled   = 8;
  colId      = 9;


{$R *.dfm}

{ TfrmMstItemList }

procedure TfrmMstKaryawanList.Execute(id: integer);
begin
  inherited;
  
  ToolBar1.ParentColor:= false;
  ToolBar1.Color:= clWhite;
  InitForm;
  SetFilter;
  LoadData;
  Run(Self);
end;

procedure TfrmMstKaryawanList.InitFilter;
begin
  GlobalPeriode.Reset;

  txtSpec.Tag:= 1;
  cmbStatus.ItemIndex:= 1;
  txtNama.Clear;
end;

procedure TfrmMstKaryawanList.InitForm;
begin
  InitGrid;
  InitFilter;
end;

procedure TfrmMstKaryawanList.InitGrid;
begin
  ResetGrid(grid, 2, colId+2, 1, 1,-1);
  grid.AutoSizeColumns(True, 4);
  grid.ColWidths[colId]:= 0;
  grid.RowHeights[1]:= grid.DefaultRowHeight;
end;

procedure TfrmMstKaryawanList.LoadData;
var i: integer; item: TMysqlResult;
begin
  try
    StartProgress;
    InitGrid;
    SetFilter;
    item:= TMstKaryawan.LoadFromDB;
    grid.RowCount:= IfThen(item.RecordCount > 0, item.RecordCount + 1, 2);

    for i:= 1 to item.RecordCount do begin
      ProsesProgress(i,item.RecordCount);
      grid.Ints[colNo, i]:= i;//+txtLimit.Tag;


      grid.Ints[colId, i]:= BufferToInteger(item.FieldValue(0));
      grid.Cells[colNik,   i]:= BufferToString(item.FieldValue(1));
      grid.Cells[colName,   i]:= BufferToString(item.FieldValue(2));
      grid.Cells[colAlamat,i]:= BufferToString(item.FieldValue(3));
//      grid.Cells[colJabatan,i]:= BufferTo(item.FieldValue(3));
      grid.Cells[colTglLahir,i]:= BufferToString(item.FieldValue(5));
      grid.Cells[colTelp1,i]:= BufferToString(item.FieldValue(6));
      grid.Cells[colTelp2,i]:= BufferToString(item.FieldValue(7));
      grid.Cells[colDisabled,i]:= IfThen(BufferToString(item.FieldValue(7))='','Aktif','Tidak Aktif');
      grid.Cells[colJabatan,i]:= BufferToString(item.FieldValue(9));

      item.MoveNext;
    end;

    item.destroy;
    grid.AutoSizeColumns(true, 2);
    grid.ColWidths[colID]:= 0;

  finally
    EndProgress;
  end;
end;

procedure TfrmMstKaryawanList.SetFilter;
begin
  GlobalFilter.SpecID  := txtSpec.Tag;
  GlobalFilter.StatusID:= cmbStatus.ItemIndex;
  GlobalFilter.Name:= txtNama.Text;

end;

procedure TfrmMstKaryawanList.gridGetAlignment(Sender: TObject; ARow,
  ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
//  if (ACol in[colName]) then HAlign:= taLeftJustify
  //else HAlign:= taRightJustify
end;

procedure TfrmMstKaryawanList.tbtNewClick(Sender: TObject);
begin
  if not TSystemAccess.isCan(CAN_ADD,AktiveControl.Tag) then exit;
  frmMstKaryawan.Execute(0);
end;

procedure TfrmMstKaryawanList.tbtDetailClick(Sender: TObject);
begin
  if not TSystemAccess.isCan(CAN_EDIT,AktiveControl.Tag) then exit;
  frmMstKaryawan.Execute(StrToIntDef(grid.Cells[colId, grid.Row],0));
end;

procedure TfrmMstKaryawanList.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  //if MstItem <> nil then MstItem.Free;
  //MstItem:= nil;
end;

procedure TfrmMstKaryawanList.ToolButton5Click(Sender: TObject);
begin
  InitFilter
end;

procedure TfrmMstKaryawanList.tbtRefreshClick(Sender: TObject);
begin
  LoadData;
end;

procedure TfrmMstKaryawanList.tbtPrintClick(Sender: TObject);
begin
  if not TSystemAccess.isCan(CAN_PRINT,AktiveControl.Tag) then exit;
  if MustRegister then exit;
  try
    Application.CreateForm(TqrpItemList, qrpItemList);
    qrpItemList.Executes(grid);
  finally
    qrpItemList.Destroy;
  end;
end;

{procedure TfrmMstItemList.tes;
var i,j,k, row: integer; listMaster, listChild: TStringList;
  item: _Recordset; header: string;
  plan_b: boolean;
begin

  listMaster:= TStringList.Create();
  listChild:= TStringList.Create();
  GlobalStringList.Clear;

  SQLToNameValueList(listMaster,
  'select code_id, code_name from mst_code '+
  'where parent_id = '+FormatSQLNumber(txtSpec.Tag) + ' order by urut');

  plan_b:= listMaster.Count = 0;
  if plan_b then
    SQLToNameValueList(listMaster,
    'select code_id, code_name from mst_code '+
    'where code_id = '+FormatSQLNumber(txtSpec.Tag));

  for i:= 0 to listMaster.Count-1 do begin

    if plan_b then
      SQLToNameValueList(listChild,
      'select m.code_id, m.code_name from mst_code m, point_maping p '+
      'where m.code_id = p.code_id and p.root_id = '+FormatSQLNumber(StrToInt(listMaster.Names[i]))+
      ' order by m.urut ')

    else
      SQLToNameValueList(listChild,
      'select m.code_id, m.code_name from mst_code m, point_maping p '+
      'where m.code_id = p.code_id and p.root_id = '+FormatSQLNumber(StrToInt(listMaster.Names[i]))+
      ' and m.code_ID <> '+FormatSQLNumber(StrToInt(listMaster.Names[i]))+
      ' order by m.urut ');


    header:= getStringFromSQL(
    'select c.code_name from point_maping p, mst_code c '+
    'where c.code_id = p.root_id and p.code_id = '+FormatSQLNumber(StrToInt(listMaster.Names[i]))+
    ' and level = 2 ');

    for j:= 0 to listChild.Count-1 do begin

      row:= asgList.RowCount-1;

      asgList.Cells[colCode, row]:=
          '['+ header +' - '+ listChild.Values[listChild.Names[j]] +']';

      item:= MyConnection.OpenSQL(
      'select i.item_code, i.item_name, c.sales_price '+
      'from mst_item i, mst_item_conversion c, point_maping p '+
      'where c.item_id = i.item_id and c.conv_type = 0 '+
      'and i.specification = p.code_id and p.root_id = '+FormatSQLNumber(StrToInt(listChild.Names[j]))+
      ' order by convert(i.item_code, SIGNED)');

      if item.RecordCount > 0 then
      for k:= 0 to item.RecordCount-1 do begin
        asgList.AddRow;
        row:= asgList.RowCount-1;
        asgList.Cells[colCode, row]:= BufferToString(item.Fields[0].Value);
        asgList.Cells[colName, row]:= BufferToString(item.Fields[1].Value);
        item.MoveNext;
      end;
      item.Close;
      asgList.AddRow;
     end;

     asgList.AutoNumberCol(colNo);
     asgList.AutoSizeColumns(TRUE, 5);
  end;
  listMaster.Free;
  listChild.Free;
end;
}
procedure TfrmMstKaryawanList.Aktivasi1Click(Sender: TObject);
begin
  if not TSystemAccess.isCan(CAN_DELETE,AktiveControl.Tag) then exit;
  TMstItem.activasi(grid.Ints[colId, grid.Row])
end;

procedure TfrmMstKaryawanList.Button1Click(Sender: TObject);
var ID: integer;
begin
  ID:= frmMstCodeList.Execute(1);
  if ID <> 0 then begin
    txtSpec.Tag := ID;
    txtSpec.Text:= TMstCode.getName(ID);
  end;
end;

procedure TfrmMstKaryawanList.gridRowChanging(Sender: TObject; OldRow,
  NewRow: Integer; var Allow: Boolean);
begin
  if OldRow <= grid.RowCount-1 then
    grid.RowHeights[OldRow]:= grid.DefaultRowHeight;
  grid.AutoSizeRow(NewRow);
  if grid.RowHeights[NewRow] < grid.DefaultRowHeight then
    grid.RowHeights[NewRow]:= grid.DefaultRowHeight;
end;

procedure TfrmMstKaryawanList.gridGetCellColor(Sender: TObject; ARow,
  ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin
//  if (ACol < colHBeli) and (ARow > 0) then begin
//    ABrush.Color:= clGrid;
//    AFont.Color := clLabel;
//  end;
end;

procedure TfrmMstKaryawanList.gridDblClickCell(Sender: TObject; ARow,
  ACol: Integer);
begin
  tbtDetail.Click
end;

procedure TfrmMstKaryawanList.ToolButton3Click(Sender: TObject);
begin
  if not TSystemAccess.isCan(CAN_DELETE,AktiveControl.Tag) then exit;
  if Confirmed('Hapus Hewan ?') then
  if TMstAnimal.deleteOnDb(grid.Ints[colId, grid.Row]) then begin
     grid.ClearRows(grid.Row,1);
     if grid.RowCount > 2 then grid.RemoveRows(grid.Row,1);
  end;

end;

end.
