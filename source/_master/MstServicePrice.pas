unit MstServicePrice;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, BaseGrid, AdvGrid, StdCtrls, AdvEdit, ComCtrls, ToolWin,
  ExtCtrls, strUtils, Math,UPetshop,
  UMaster, WinXP, Menus, SUIImagePanel, UTransaction,
  frmDockForm, Buttons, SUIButton;

type
  TfrmMstServicePrice = class(TDockForm)
    WinXP1: TWinXP;
    suiPanel1: TsuiPanel;
    suiPanel2: TsuiPanel;
    pnlTarif: TsuiPanel;
    grid: TAdvStringGrid;
    asgvc: TAdvStringGrid;
    ToolBar1: TToolBar;
    tbtSave: TToolButton;
    ToolButton1: TToolButton;
    tbtRefresh: TToolButton;
    ToolButton4: TToolButton;
    tbtPrint: TToolButton;
    tbtEdit: TToolButton;
    gridTarif: TAdvStringGrid;
    Splitter1: TSplitter;
    ToolBar2: TToolBar;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton2: TToolButton;
    gridExcel: TAdvStringGrid;
    SaveDialog1: TSaveDialog;

    procedure gridGetAlignment(Sender: TObject; ARow, ACol: Integer;
      var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure tbtEditClick(Sender: TObject);
    procedure tbtSaveClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ToolButton5Click(Sender: TObject);
    procedure tbtRefreshClick(Sender: TObject);
    procedure tbtPrintClick(Sender: TObject);
    procedure Aktivasi1Click(Sender: TObject);
    procedure gridRowChanging(Sender: TObject; OldRow, NewRow: Integer;
      var Allow: Boolean);
    procedure gridGetCellColor(Sender: TObject; ARow, ACol: Integer;
      AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
    procedure ToolButton3Click(Sender: TObject);
    procedure gridClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure gridTarifCanEditCell(Sender: TObject; ARow, ACol: Integer;
      var CanEdit: Boolean);
    procedure gridTarifGetEditorType(Sender: TObject; ACol, ARow: Integer;
      var AEditor: TEditorType);
    procedure gridTarifCellValidate(Sender: TObject; Col, Row: Integer;
      var Value: String; var Valid: Boolean);
    procedure gridTarifGetAlignment(Sender: TObject; ARow, ACol: Integer;
      var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure ToolButton2Click(Sender: TObject);

  private
    EditMode : boolean;
    MstItem : TMstServicePrice;
    procedure InitGrid;
    procedure InitGridExcel;
    procedure InitGridService;
    procedure setEnableDisabled;
    procedure InitForm;
    procedure SetFilter;
    procedure InitFilter;
    procedure LoadData;
    procedure LoadService;
    procedure loadDataExcel;
    function isSaved: boolean;
    function isValid: boolean;
  public
    procedure Execute(id: integer=0);override;
  end;

var
  frmMstServicePrice: TfrmMstServicePrice;

implementation

uses UConstTool, MainMenu, Subroutines,
  MstCodeList, MstItem, UConst,
  mstItemListPrint, LookupData, uMysqlClient, MySQLConnector, MstService,
  MstAnimal;

const
  colNo      = 0;
  colCode    = 1;
  colName    = 2;
  colNotes   = 3;
  colId      = 4;

  colPPrice = 3;
  colPAdd = 4;
  colPDisc =5;
  colPAnimalId = 6;
  colPModId = 7;
  colPId = 8;


{$R *.dfm}

{ TfrmMstItemList }

procedure TfrmMstServicePrice.Execute(id: integer);
begin
  inherited;
  MstItem := TMstServicePrice.Create;
  ToolBar1.ParentColor:= false;
  ToolBar1.Color:= clWhite;
  InitForm;
  InitGrid;
  EditMode := False;
  setEnableDisabled;
  SetFilter;
  LoadService;
  Run(Self);
end;

procedure TfrmMstServicePrice.InitFilter;
begin
  GlobalPeriode.Reset;
end;

procedure TfrmMstServicePrice.InitForm;
begin
  InitGrid;
  InitFilter;
end;

procedure TfrmMstServicePrice.InitGrid;
begin
  ResetGrid(gridTarif, 2, colPId+2, 1, 1,-1);
  gridTarif.AutoSizeColumns(True, 4);
  gridTarif.ColWidths[colPId]:= 0;
  gridTarif.ColWidths[colPAnimalId]:= 0;
  gridTarif.ColWidths[colPModId]:= 0;
  gridTarif.ColWidths[colPAdd]:= 0;

  gridTarif.RowHeights[1]:= gridTarif.DefaultRowHeight;
end;

procedure TfrmMstServicePrice.LoadData;
var i: integer; item: TMysqlResult;
begin
  if pnlTarif.Tag = 0 then begin
    Alert('Jenis jasa belum dipilih');
    exit;
  end;
  try
    StartProgress;
    InitGrid;
    SetFilter;
    //0a.animal_code,1a.animal,2p.service_price_id, 3p.service_id, 4p.animal_id,5p.price,6p.additional_price
    item:= TMstServicePrice.LoadFromDB;
    gridTarif.RowCount:= IfThen(item.RecordCount > 0, item.RecordCount + 1, 2);
    for i:= 1 to item.RecordCount do begin
      ProsesProgress(i,item.RecordCount);
      gridTarif.Ints[colNo, i]:= i;//+txtLimit.Tag;
      gridTarif.Ints[colPId, i]:= BufferToInteger(item.FieldValue(2));
      gridTarif.Ints[colPAnimalId, i]:= BufferToInteger(item.FieldValue(4));
      gridTarif.Cells[colCode,   i]:= BufferToString(item.FieldValue(0));
      gridTarif.Cells[colName,   i]:= BufferToString(item.FieldValue(1));
      gridTarif.Cells[colPPrice,i] :=FloatToStrFmt(BufferToFloat(item.FieldValue(5)));
      gridTarif.Cells[colPAdd,i] :=FloatToStrFmt(BufferToFloat(item.FieldValue(6)));
      gridTarif.Cells[colPDisc,i] :=FloatToStrFmt(BufferToFloat(item.FieldValue(7)));
      item.MoveNext;
    end;

    item.destroy;
    gridTarif.AutoSizeColumns(true, 4);
    gridTarif.ColWidths[colPID]:= 0;
    gridTarif.ColWidths[colPModID]:= 0;
    gridTarif.ColWidths[colPAdd]:= 0;
    gridTarif.ColWidths[colPAnimalID]:= 0;

  finally
    EndProgress;
  end;
end;

procedure TfrmMstServicePrice.SetFilter;
begin
  GlobalFilter.Reset;
  GlobalFilter.Numeric1 := pnlTarif.Tag;
end;

procedure TfrmMstServicePrice.gridGetAlignment(Sender: TObject; ARow,
  ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  if (ACol in[colCode, colName,colnotes]) then HAlign:= taLeftJustify
  else HAlign:= taRightJustify
end;

procedure TfrmMstServicePrice.tbtEditClick(Sender: TObject);
begin
  if not TSystemAccess.isCan(CAN_EDIT,AktiveControl.Tag) then exit;
  editMode := True;
   setEnableDisabled;
end;

procedure TfrmMstServicePrice.tbtSaveClick(Sender: TObject);
begin
//    if not GlobalSystemUser.CanAccess(TAG_SAVE_EDIT) then exit;
  if isValid then IsSaved
end;

procedure TfrmMstServicePrice.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  if MstItem <> nil then MstItem.Free;
  MstItem:= nil;
end;

procedure TfrmMstServicePrice.ToolButton5Click(Sender: TObject);
begin
  InitFilter
end;

procedure TfrmMstServicePrice.tbtRefreshClick(Sender: TObject);
begin
  LoadData;
end;

procedure TfrmMstServicePrice.tbtPrintClick(Sender: TObject);
begin
{ if not TSystemAccess.isCan(CAN_PRINT,AktiveControl.Tag) then exit;
  if MustRegister then exit;
  try
    Application.CreateForm(TqrpItemList, qrpItemList);
    qrpItemList.Executes(grid);
  finally
    qrpItemList.Destroy;
  end;}
  loadDataExcel;
  if SaveDialog1.Execute then
     gridExcel.SaveToXLS(SaveDialog1.FileName);
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
procedure TfrmMstServicePrice.Aktivasi1Click(Sender: TObject);
begin
  TMstItem.activasi(grid.Ints[colId, grid.Row])
end;

procedure TfrmMstServicePrice.gridRowChanging(Sender: TObject; OldRow,
  NewRow: Integer; var Allow: Boolean);
begin
  if OldRow <= grid.RowCount-1 then
    grid.RowHeights[OldRow]:= grid.DefaultRowHeight;
  grid.AutoSizeRow(NewRow);
  if grid.RowHeights[NewRow] < grid.DefaultRowHeight then
    grid.RowHeights[NewRow]:= grid.DefaultRowHeight;
end;

procedure TfrmMstServicePrice.gridGetCellColor(Sender: TObject; ARow,
  ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin
//  if (ACol < colHBeli) and (ARow > 0) then begin
//    ABrush.Color:= clGrid;
//    AFont.Color := clLabel;
//  end;
end;

procedure TfrmMstServicePrice.ToolButton3Click(Sender: TObject);
begin
  if Confirmed('Hapus Item?') then
  if TMstService.deleteOnDb(grid.Ints[colId, grid.Row]) then begin
     grid.ClearRows(grid.Row,1);
     if grid.RowCount > 2 then grid.RemoveRows(grid.Row,1);
  end;

end;

procedure TfrmMstServicePrice.LoadService;
var i: integer; item: TMysqlResult;
begin
  try
    StartProgress;
    InitGridService;
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

procedure TfrmMstServicePrice.gridClickCell(Sender: TObject; ARow,
  ACol: Integer);
begin
  inherited;
  if ARow = 0 then exit;
  pnlTarif.Caption := 'Tarif '+grid.Cells[colName,arow];
  pnlTarif.Tag := grid.Ints[colId,arow];
  EditMode := False;
  setEnableDisabled;
  LoadData;
end;

procedure TfrmMstServicePrice.InitGridService;
begin
  ResetGrid(grid, 2, colId+2, 1, 1,-1);
  grid.AutoSizeColumns(True, 4);
  grid.ColWidths[colId]:= 0;
  grid.RowHeights[1]:= grid.DefaultRowHeight;
end;

procedure TfrmMstServicePrice.gridTarifCanEditCell(Sender: TObject; ARow,
  ACol: Integer; var CanEdit: Boolean);
begin
  inherited;
  CanEdit := (ACol in[colPPrice,colPDisc]) and EditMode;//,colPAdd
end;

procedure TfrmMstServicePrice.gridTarifGetEditorType(Sender: TObject; ACol,
  ARow: Integer; var AEditor: TEditorType);
begin
  inherited;
  if (ACol in[ColPPrice,colPAdd,colPDisc]) then
    AEditor := edPositiveNumeric;
end;

procedure TfrmMstServicePrice.gridTarifCellValidate(Sender: TObject; Col,
  Row: Integer; var Value: String; var Valid: Boolean);
begin
  inherited;
    case Col of
   {colSGdg:
    begin
      gridRak.Cells[colSGdg, Row]:= lsStorage.Names[gridRak.Combobox.ItemIndex];
      gridRak.Ints[colSModID, Row]:= 1;
      tbtSave.Enabled:= True;
    end;
    }
    colPPrice,colPAdd,colPDisc: //, colSDisp
    begin
      Value:= FloatToStrFmt(StrToFloatDef(Value,0));
      gridTarif.Ints[colPModID, Row]:= 1;
      tbtSave.Enabled:= True;
    end;

 {   colPStart,colPEnd,colPUpdate:
    begin
      gridMinor.Ints[colPModID, Row]:= 1;
      tbtSave.Enabled:= True;
    end;}
  end;

  tbtSave.Enabled:= True;

end;

procedure TfrmMstServicePrice.setEnableDisabled;
begin
  tbtSave.Enabled := editMode;
  tbtEdit.Enabled := not editMode;
end;

function TfrmMstServicePrice.isSaved: boolean;
var i: integer;
begin
  Result:= False;

  MstItem.reset;
  for i:= 1 to gridTarif.RowCount-1 do
    if  (gridTarif.Ints[colPModID, i] <>0) then
       MstItem.FServiceArr.Add(gridTarif.Ints[colPID, i],pnlTarif.Tag,
      roundCorrected(StrFmtToFloatDef(gridTarif.Cells[colPAnimalId, i],0)),
      roundCorrected(StrFmtToFloatDef(gridTarif.Cells[colPPrice, i],0)),
      roundCorrected(StrFmtToFloatDef(gridTarif.Cells[colPAdd, i],0)),
      '','',roundCorrected(StrFmtToFloatDef(gridTarif.Cells[colPDisc, i],0)));
              
  Result:= MstItem.saveToDb();
 // else Result:= MstItem.InsertOnDB;
  tbtSave.Enabled:= not Result;

  if Result then LoadData;


end;

function TfrmMstServicePrice.isValid: boolean;
begin
   if CekInput(Result, pnlTarif.Tag <> 0, 'Jenis Jasa belum ditentukan.', grid) then
end;

procedure TfrmMstServicePrice.gridTarifGetAlignment(Sender: TObject; ARow,
  ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  inherited;
  if (ACol in[colPPrice,colPAdd,colPDisc]) then  HAlign:= taRightJustify
end;

procedure TfrmMstServicePrice.InitGridExcel;
begin
  ResetGrid(gridExcel, 2, colId+2, 1, 1,-1);
  gridExcel.AutoSizeColumns(True, 4);
  gridExcel.ColWidths[colId]:= 0;
end;

procedure TfrmMstServicePrice.loadDataExcel;
var i: integer; item: TMysqlResult;
begin
  try
    StartProgress;
    InitGridExcel;
//    SetFilter;
    //0s.service_name,1a.animal_code,2a.animal,3p.price,4p.discount
    item:= TMstServicePrice.LoadExcel;
    gridExcel.RowCount:= IfThen(item.RecordCount > 0, item.RecordCount + 1, 2);
    for i:= 1 to item.RecordCount do begin
      ProsesProgress(i,item.RecordCount);
      gridExcel.Ints[0, i]:= i;//+txtLimit.Tag;
      gridExcel.Cells[1,   i]:= BufferToString(item.FieldValue(0));
      gridExcel.Cells[2,   i]:= BufferToString(item.FieldValue(1));
      gridExcel.Cells[3,   i]:= BufferToString(item.FieldValue(2));
      gridExcel.Floats[4,i] :=BufferToFloat(item.FieldValue(3));
      gridExcel.Floats[5,i] :=BufferToFloat(item.FieldValue(4));
      item.MoveNext;
    end;

    item.destroy;
    gridExcel.AutoSizeColumns(true, 4);

  finally
    EndProgress;
  end;
  {No
Jenis Jasa
Kode Kategori
Nama Kategori Hewan
Harga
Max.Disc (%)}

end;

procedure TfrmMstServicePrice.ToolButton2Click(Sender: TObject);
begin
  inherited;
   LoadService;
end;

end.
