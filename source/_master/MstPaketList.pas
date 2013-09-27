unit MstPaketList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, BaseGrid, AdvGrid, StdCtrls, AdvEdit, ComCtrls, ToolWin,
  ExtCtrls, strUtils, Math,
  UMaster, WinXP, Menus, SUIImagePanel, UTransaction,
  frmDockForm;

type
  TfrmMstPaketList = class(TDockForm)
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
    txtVc: TAdvEdit;
    Button2: TButton;
    cmbStatus: TComboBox;
    Label1: TLabel;
    txtProdusen: TAdvEdit;
    Button3: TButton;
    txtKemasan: TAdvEdit;
    Button4: TButton;
    txtNama: TAdvEdit;
    PopupMenu1: TPopupMenu;
    Aktivasi1: TMenuItem;
    ToolButton2: TToolButton;

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
    procedure gridClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure Button2Click(Sender: TObject);
    procedure cmbStatusChange(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure gridRowChanging(Sender: TObject; OldRow, NewRow: Integer;
      var Allow: Boolean);
    procedure gridGetCellColor(Sender: TObject; ARow, ACol: Integer;
      AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
    procedure gridCanEditCell(Sender: TObject; ARow, ACol: Integer;
      var CanEdit: Boolean);
    procedure gridCellValidate(Sender: TObject; Col, Row: Integer;
      var Value: String; var Valid: Boolean);
    procedure gridGetEditorType(Sender: TObject; ACol, ARow: Integer;
      var AEditor: TEditorType);
    procedure gridDblClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure ToolButton2Click(Sender: TObject);

  private
    procedure InitGrid;
    procedure InitForm;
    procedure SetFilter;
    procedure InitFilter;
    procedure LoadData;
    function saveAdjustment(realValue: double; row: integer): boolean;
  public
    procedure Execute(id: integer=0);override;
  end;

var
  frmMstPaketList: TfrmMstPaketList;

implementation

uses UConstTool, MainMenu, Subroutines,
  MstCodeList, UConst,
  LookupData, uMysqlClient, MySQLConnector, MstPaket;

const
  colNo      = 0;
  colId      = 1;
  colCode    = 2;
  colBarcode = 3;
  colName    = 4;
  colHDasar  = 5;
  colHJual   = 6;
  colStok    = 7;
  colStokOld = 8;


{$R *.dfm}

{ TfrmMstItemList }

procedure TfrmMstPaketList.Execute(id: integer);
begin
  inherited;
  ToolBar1.ParentColor:= false;
  ToolBar1.Color:= clWhite;
  InitForm;
  SetFilter;
  Run(Self);
end;

procedure TfrmMstPaketList.InitFilter;
begin
  GlobalPeriode.Reset;
  txtSpec.Text:= 'BARANG JADI';
  txtSpec.Tag:= 0;
  txtVc.Text:= 'Semua Supplier';
  txtVc.Tag:= 0;
  txtProdusen.Text:= 'Semua Produsen';
  txtProdusen.Tag:= 0;
  cmbStatus.ItemIndex:= 1;
  txtKemasan.Tag:= 0;
  txtKemasan.Text:= 'Semua Kemasan';
  txtNama.Clear;
end;

procedure TfrmMstPaketList.InitForm;
begin
  InitGrid;
  InitFilter;
end;

procedure TfrmMstPaketList.InitGrid;
begin
  ResetGrid(grid, 2, 9, 1, 1,-1);
  grid.ColWidths[colId]:= 0;
  
  grid.RowHeights[1]:= grid.DefaultRowHeight;
end;

procedure TfrmMstPaketList.LoadData;
var i: integer; item: TMysqlResult;
begin
  try
    StartProgress;
    InitGrid;
    InitFilter;
    // SetFilter;
    item:= TMstPaket.LoadFromDB;
    grid.RowCount:= IfThen(item.RecordCount > 0, item.RecordCount + 1, 2);
    for i:= 1 to item.RecordCount do begin
      ProsesProgress(i,item.RecordCount);
      grid.Ints[colNo,      i]:= i;
      grid.Cells[colId,     i]:= item.FieldValue(0);
      grid.Cells[colCode,   i]:= item.FieldValue(1);
      grid.Cells[colBarcode,i]:= item.FieldValue(2);
      grid.Cells[colName,   i]:= item.FieldValue(3);
      grid.Cells[colHDasar, i]:= FloatToStrFmtNull(BufferToFloat(item.FieldValue(4)));
      grid.Cells[colHJual,  i]:= FloatToStrFmtNull(BufferToFloat(item.FieldValue(5)));
      grid.Cells[colStok,   i]:= FloatToStrFmtNull(BufferToFloat(item.FieldValue(6)))+ ' ' +
                                 item.FieldValue(7);
      grid.Floats[colStokOld,i]:= BufferToFloat(item.FieldValue(6));
      item.MoveNext;
    end;
    item.destroy;
  finally
    grid.AutoSizeColumns(true, 5);
    grid.ColWidths[colNo]:= 20;
    //grid.ColWidths[colCode   ]:= 90;
    //grid.ColWidths[colBarcode]:= 95;
    grid.ColWidths[colHJual  ]:= 0;
    //grid.ColWidths[colHDasar ]:= 0;
    grid.ColWidths[colStok   ]:= 0;
    grid.ColWidths[colStokOld]:= 0;
    grid.ColWidths[colId]:= 0;

    EndProgress;
  end;
end;

procedure TfrmMstPaketList.SetFilter;
begin
  GlobalFilter.SpecID  := txtSpec.Tag;
  GlobalFilter.RelasiID:= txtVc.Tag;
  GlobalFilter.StatusID:= cmbStatus.ItemIndex;
  GlobalFilter.SeriesID:= txtProdusen.Tag;
  GlobalFilter.Numeric1:= txtKemasan.Tag;
  GlobalFilter.Name:= txtNama.Text;
end;

procedure TfrmMstPaketList.gridGetAlignment(Sender: TObject; ARow,
  ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  if (ACol in[colCode, colBarcode, colName]) then HAlign:= taLeftJustify
  else HAlign:= taRightJustify
end;

procedure TfrmMstPaketList.tbtNewClick(Sender: TObject);
begin
  frmMstPaket.Execute(0);
end;

procedure TfrmMstPaketList.tbtDetailClick(Sender: TObject);
begin
  frmMstPaket.Execute(StrToIntDef(grid.Cells[colId, grid.Row],0));
end;

procedure TfrmMstPaketList.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  //if MstItem <> nil then MstItem.Free;
  //MstItem:= nil;
end;

procedure TfrmMstPaketList.ToolButton5Click(Sender: TObject);
begin
  InitFilter
end;

procedure TfrmMstPaketList.tbtRefreshClick(Sender: TObject);
begin
  LoadData
end;

procedure TfrmMstPaketList.tbtPrintClick(Sender: TObject);
begin
  if MustRegister then exit;

  try
//    Application.CreateForm(TqrpItemList, qrpItemList);
//    qrpItemList.Executes(grid);
  finally
//    qrpItemList.Destroy;
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
procedure TfrmMstPaketList.Aktivasi1Click(Sender: TObject);
begin
  TMstPaket.activasi(grid.Ints[colId, grid.Row])
end;

procedure TfrmMstPaketList.Button1Click(Sender: TObject);
var ID: integer;
begin
  ID:= frmMstCodeList.Execute(1);
  if ID <> 0 then begin
    txtSpec.Tag := ID;
    txtSpec.Text:= TMstCode.getName(ID);
  end;
end;

procedure TfrmMstPaketList.gridClickCell(Sender: TObject; ARow,
  ACol: Integer);
begin

end;

{procedure TfrmMstItemList.SaveAdjustment(vReal: double);
var vDbCrType: string; vSelisih: double;
begin

  Shipment.Clear;
  Shipment.ItemShipmentMst.ShipmentId := asgList.Tag;
  Shipment.ItemShipmentMst.TransType  := ITEM_TYPE_OPNAME;
  Shipment.ItemShipmentMst.TransDate  := ServerNow;
  Shipment.ItemShipmentMst.TransNum   := Shipment.ItemShipmentMst.GetNewNumber;
  Shipment.ItemShipmentMst.Userid     := GlobalSystemUser.UserId;

  Shipment.ClearDetail;
  vSelisih:= vReal - OldValue;
  vDbCrType:= IfThen(vSelisih > 0, DB_CR_TYPE_DEBIT, DB_CR_TYPE_CREDIT);

  Shipment.AddDetail;
  Shipment.ItemShipmentDetail_Arr[0].ItemId := asgList.Ints[colId, asgList.Row];
  Shipment.ItemShipmentDetail_Arr[0].ConvId := TMstItemConversion.GetConversionId(asgList.Ints[colId, asgList.Row]);

  //asgReport.Floats[colCurStok,i]
  Shipment.ItemShipmentDetail_Arr[0].InfoOpname := ConvertToSaveConvertion(vReal, 1);
  Shipment.ItemShipmentDetail_Arr[0].Quantity := abs(ConvertToSaveConvertion(vSelisih , 1));

  Shipment.ItemShipmentDetail_Arr[0].Conversion := 1;
  Shipment.ItemShipmentDetail_Arr[0].DbCrType := vDbCrType;

  Shipment.InsertAutoOpname;
  asgList.Tag:= Shipment.ItemShipmentMst.ShipmentId;

end;
}

procedure TfrmMstPaketList.Button2Click(Sender: TObject);
var id: integer;
begin
  id:= frmLookup.Execute('SPL');
  if Id > 0 then begin
    txtVc.Text:= TMstRelation.GetName(id);
    txtVc.Tag:= id;
  end;
end;

procedure TfrmMstPaketList.cmbStatusChange(Sender: TObject);
begin
//
end;

procedure TfrmMstPaketList.Button3Click(Sender: TObject);
var id: integer;
begin
  id:= frmLookup.Execute('PRODUSEN');
  if Id > 0 then begin
    txtProdusen.Text:= TMstMaster.GetName(id);
    txtProdusen.Tag:= id;
  end;
end;

procedure TfrmMstPaketList.Button4Click(Sender: TObject);
var id: integer;
begin
  id:= frmLookup.Execute('KEMAS');
  if Id > 0 then begin
    txtKemasan.Text:= TMstMaster.GetName(id);
    txtKemasan.Tag:= id;
  end;
end;

{procedure TfrmMstItemList.ToolButton2Click(Sender: TObject);
var tmp: TMysqlResult; i: integer;
begin
try
  Screen.Cursor:= crHourGlass;
  tmp:= OpenSQL(
  'select i.item_id, t.unit1, t.unit2, t.unitq2, t.unit3, t.unitq3, '+
  't.cost1, t.cost2, t.cost3, t.mgn1, t.mgn2, t.mgn3 '+
  'from tmp_item t, mst_item i where i.item_code = t.idx');

  for i:= 0 to tmp.RecordCount-1 do begin

    ExecSQL(
    'insert into mst_item_conversion('+
    'item_id, unit_id, conversion, purchase_price, cost_price) values ('+
      FormatSQLNumber(BufferToInteger(tmp.FieldValue(0)))+','+
      '(select mst_id from mst_master where mst_name = '+FormatSQLString(BufferToString(tmp.FieldValue(1)))+' limit 1), '+
      '1, '+
       FormatSQLNumber(BufferToFloat(tmp.FieldValue(6)))+','+
       FormatSQLNumber(BufferToFloat(tmp.FieldValue(9)))+')');

     if BufferToString(tmp.FieldValue(2)) <> '' then
       ExecSQL(
      'insert into mst_item_conversion('+
      'item_id, unit_id, conversion, purchase_price, cost_price) values ('+
        FormatSQLNumber(BufferToInteger(tmp.FieldValue(0)))+','+
        '(select mst_id from mst_master where mst_name = '+FormatSQLString(BufferToString(tmp.FieldValue(2)))+' limit 1), '+
        FormatSQLNumber(BufferToFloat(tmp.FieldValue(3)))+','+
         FormatSQLNumber(BufferToFloat(tmp.FieldValue(7)))+','+
         FormatSQLNumber(BufferToFloat(tmp.FieldValue(10)))+')');

     if BufferToString(tmp.FieldValue(4)) <> '' then
       ExecSQL(
      'insert into mst_item_conversion('+
      'item_id, unit_id, conversion, purchase_price, cost_price) values ('+
        FormatSQLNumber(BufferToInteger(tmp.FieldValue(0)))+','+
        '(select mst_id from mst_master where mst_name = '+FormatSQLString(BufferToString(tmp.FieldValue(4)))+' limit 1), '+
        FormatSQLNumber(BufferToFloat(tmp.FieldValue(5)))+','+
         FormatSQLNumber(BufferToFloat(tmp.FieldValue(8)))+','+
         FormatSQLNumber(BufferToFloat(tmp.FieldValue(11)))+')');

    tmp.MoveNext;
  end;
  tmp.destroy;
finally
  Screen.Cursor:= crDefault;
end;

end;
}
procedure TfrmMstPaketList.gridRowChanging(Sender: TObject; OldRow,
  NewRow: Integer; var Allow: Boolean);
begin
  if OldRow <= grid.RowCount-1 then
    grid.RowHeights[OldRow]:= grid.DefaultRowHeight;
  grid.AutoSizeRow(NewRow);
  if grid.RowHeights[NewRow] < grid.DefaultRowHeight then
    grid.RowHeights[NewRow]:= grid.DefaultRowHeight;
end;

procedure TfrmMstPaketList.gridGetCellColor(Sender: TObject; ARow,
  ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin
//  if (ACol < colHBeli) and (ARow > 0) then begin
//    ABrush.Color:= clGrid;
//    AFont.Color := clLabel;
//  end;
end;

function TfrmMstPaketList.saveAdjustment(realValue: double; row: integer): boolean;
begin
  if TMstPaket.UpdateStock(grid.Ints[colId, row], realValue - grid.Ints[colStokOld, row], DB_CR_TYPE_DEBIT) then
  grid.Floats[colStokOld, row]:= realValue;
  Result:= True;
end;

procedure TfrmMstPaketList.gridCanEditCell(Sender: TObject; ARow,
  ACol: Integer; var CanEdit: Boolean);
begin
  CanEdit:= (ACol = colStok) and (grid.Ints[colId, ARow]<>0) and (grid.ColWidths[ACol]<>0);
end;

procedure TfrmMstPaketList.gridCellValidate(Sender: TObject; Col,
  Row: Integer; var Value: String; var Valid: Boolean);
begin
  if Col = colStok then begin
    if saveAdjustment(StrFmtToFloatDef(Value,0), Row) then
      Value:= FloatToStrFmt(StrFmtToFloatDef(Value,0));
  end
end;

procedure TfrmMstPaketList.gridGetEditorType(Sender: TObject; ACol,
  ARow: Integer; var AEditor: TEditorType);
begin
  if ACol = colStok then AEditor:= edFloat;
end;

procedure TfrmMstPaketList.gridDblClickCell(Sender: TObject; ARow,
  ACol: Integer);
begin
  tbtDetail.Click
end;

procedure TfrmMstPaketList.ToolButton2Click(Sender: TObject);
begin
  if Confirmed('Hapus Item?') then
  if TMstPaket.DeleteItemPaket(grid.Ints[colId, grid.Row]) then begin
     grid.ClearRows(grid.Row,1);
     if grid.RowCount > 2 then grid.RemoveRows(grid.Row,1);
  end;
end;

end.
