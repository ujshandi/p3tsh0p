unit MstCageList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, BaseGrid, AdvGrid, StdCtrls, AdvEdit, ComCtrls, ToolWin,
  ExtCtrls, strUtils, Math,UPetshop,
  UMaster, WinXP, Menus, SUIImagePanel, UTransaction,
  frmDockForm, Buttons, SUIButton;

type
  TfrmMstCageList = class(TDockForm)
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
    txtMerk: TAdvEdit;
    PopupMenu1: TPopupMenu;
    Aktivasi1: TMenuItem;
    txtCode: TAdvEdit;
    txtBarcode: TAdvEdit;
    ToolButton3: TToolButton;
    txtKategori: TAdvEdit;
    Button6: TButton;

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
  frmMstCageList: TfrmMstCageList;

implementation

uses UConstTool, MainMenu, Subroutines,
  MstCodeList, MstItem, UConst,
  mstItemListPrint, LookupData, uMysqlClient, MySQLConnector, MstService;

const
  colNo      = 0;
  colCode    = 1;
  colName    = 2;
  colNotes   = 3;
  colId      = 4;


{$R *.dfm}

{ TfrmMstItemList }

procedure TfrmMstCageList.Execute(id: integer);
begin
  inherited;
  
  ToolBar1.ParentColor:= false;
  ToolBar1.Color:= clWhite;
  InitForm;
  SetFilter;
  LoadData;
  Run(Self);
end;

procedure TfrmMstCageList.InitFilter;
begin
  GlobalPeriode.Reset;
  txtSpec.Text:= 'SEMUA SPEC';
  txtSpec.Tag:= 1;
  txtKategori.Text:= 'SEMUA JENIS';
  txtKategori.Tag:= 0;
  cmbStatus.ItemIndex:= 1;
  txtNama.Clear;
  txtMerk.Clear;
  txtCode.Clear;
  txtBarcode.Clear;
end;

procedure TfrmMstCageList.InitForm;
begin
  InitGrid;
  InitFilter;
end;

procedure TfrmMstCageList.InitGrid;
begin
  ResetGrid(grid, 2, colId+2, 1, 1,-1);
  grid.AutoSizeColumns(True, 4);
  grid.ColWidths[colId]:= 0;
  grid.RowHeights[1]:= grid.DefaultRowHeight;
end;

procedure TfrmMstCageList.LoadData;
var i: integer; item: TMysqlResult;
begin
  try
    StartProgress;
    InitGrid;
    SetFilter;
    item:= TMstService.LoadFromDB;
    grid.RowCount:= IfThen(item.RecordCount > 0, item.RecordCount + 1, 2);

    for i:= 1 to item.RecordCount do begin
      ProsesProgress(i,item.RecordCount);
      grid.Ints[colNo, i]:= i;//+txtLimit.Tag;

      //0item_id, 1item_code, 2barcode, 3item_name, 4purchase_price, 5item_discount, 6item_tax, 7net_price,
          //8avg_price, 9cost_price, 10sales_price, 11sales_price2, 12current_stock, 13sat, 14disc_tipe

      grid.Ints[colId, i]:= BufferToInteger(item.FieldValue(0));
      grid.Cells[colCode,   i]:= BufferToString(item.FieldValue(1));

      grid.Cells[colName,   i]:= BufferToString(item.FieldValue(2));
      grid.Cells[colNotes,i]:= BufferToString(item.FieldValue(3));


      item.MoveNext;
    end;

    item.destroy;
    grid.AutoSizeColumns(true, 4);
    grid.ColWidths[colID]:= 0;

  finally
    EndProgress;
  end;
end;

procedure TfrmMstCageList.SetFilter;
begin
  GlobalFilter.SpecID  := txtSpec.Tag;
  GlobalFilter.StatusID:= cmbStatus.ItemIndex;
  GlobalFilter.Name:= txtNama.Text;
  GlobalFilter.TipeID:= txtMerk.Text;
  GlobalFilter.FString1:= txtCode.Text;
  GlobalFilter.FString2:= txtBarcode.Text;

  GlobalFilter.Numeric3:= txtKategori.Tag;
end;

procedure TfrmMstCageList.gridGetAlignment(Sender: TObject; ARow,
  ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  if (ACol in[colCode, colName,colnotes]) then HAlign:= taLeftJustify
  else HAlign:= taRightJustify
end;

procedure TfrmMstCageList.tbtNewClick(Sender: TObject);
begin
  frmMstService.Execute(0);
end;

procedure TfrmMstCageList.tbtDetailClick(Sender: TObject);
begin
  frmMstService.Execute(StrToIntDef(grid.Cells[colId, grid.Row],0));
end;

procedure TfrmMstCageList.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  //if MstItem <> nil then MstItem.Free;
  //MstItem:= nil;
end;

procedure TfrmMstCageList.ToolButton5Click(Sender: TObject);
begin
  InitFilter
end;

procedure TfrmMstCageList.tbtRefreshClick(Sender: TObject);
begin
  LoadData;
end;

procedure TfrmMstCageList.tbtPrintClick(Sender: TObject);
begin
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
procedure TfrmMstCageList.Aktivasi1Click(Sender: TObject);
begin
  TMstItem.activasi(grid.Ints[colId, grid.Row])
end;

procedure TfrmMstCageList.Button1Click(Sender: TObject);
var ID: integer;
begin
  ID:= frmMstCodeList.Execute(1);
  if ID <> 0 then begin
    txtSpec.Tag := ID;
    txtSpec.Text:= TMstCode.getName(ID);
  end;
end;

procedure TfrmMstCageList.gridRowChanging(Sender: TObject; OldRow,
  NewRow: Integer; var Allow: Boolean);
begin
  if OldRow <= grid.RowCount-1 then
    grid.RowHeights[OldRow]:= grid.DefaultRowHeight;
  grid.AutoSizeRow(NewRow);
  if grid.RowHeights[NewRow] < grid.DefaultRowHeight then
    grid.RowHeights[NewRow]:= grid.DefaultRowHeight;
end;

procedure TfrmMstCageList.gridGetCellColor(Sender: TObject; ARow,
  ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin
//  if (ACol < colHBeli) and (ARow > 0) then begin
//    ABrush.Color:= clGrid;
//    AFont.Color := clLabel;
//  end;
end;

procedure TfrmMstCageList.gridDblClickCell(Sender: TObject; ARow,
  ACol: Integer);
begin
  tbtDetail.Click
end;

procedure TfrmMstCageList.ToolButton3Click(Sender: TObject);
begin
  if Confirmed('Hapus Item?') then
  if TMstService.deleteOnDb(grid.Ints[colId, grid.Row]) then begin
     grid.ClearRows(grid.Row,1);
     if grid.RowCount > 2 then grid.RemoveRows(grid.Row,1);
  end;

end;

end.
