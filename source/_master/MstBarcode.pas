unit MstBarcode;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, BaseGrid, AdvGrid, ComCtrls, StdCtrls, AdvEdit, ExtCtrls,
  SUIImagePanel, ToolWin, Math, strutils,
  frmDockForm, Buttons;

type
  TfrmMstBarcode = class(TDockForm)
    ToolBar1: TToolBar;
    tbtRefresh: TToolButton;
    ToolButton4: TToolButton;
    tbtPrint: TToolButton;
    suiPanel3: TsuiPanel;
    txtSpec: TAdvEdit;
    Button1: TButton;
    suiPanel2: TsuiPanel;
    grid: TAdvStringGrid;
    asgPrint: TAdvStringGrid;
    cmbFormat: TComboBox;
    Label2: TLabel;
    txtVc: TAdvEdit;
    Button2: TButton;
    txtKemasan: TAdvEdit;
    Button3: TButton;
    txtNama: TAdvEdit;
    txtMerk: TAdvEdit;
    txtProdusen: TAdvEdit;
    CheckBox1: TCheckBox;
    txtCol: TAdvEdit;
    UpDown1: TUpDown;
    ToolButton1: TToolButton;
    gridVar: TAdvStringGrid;
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    procedure tbtRefreshClick(Sender: TObject);
    procedure tbtPrintClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure gridCanEditCell(Sender: TObject; ARow, ACol: Integer;
      var CanEdit: Boolean);
    procedure gridGetAlignment(Sender: TObject; ARow, ACol: Integer;
      var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure gridGetEditorType(Sender: TObject; ACol, ARow: Integer;
      var AEditor: TEditorType);
    procedure gridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure gridVarRowChanging(Sender: TObject; OldRow, NewRow: Integer;
      var Allow: Boolean);
    procedure ToolButton1Click(Sender: TObject);
    procedure txtSpecKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    harga1, harga2: boolean;
    function getKetentuanHarga(ItemID, UnitID, FaktorHarga: integer): string;
    procedure InitGrid;
    procedure InitForm;
    procedure LoadData;
    procedure deleteRow(grid: TAdvStringGrid; row:integer);
    procedure SelectItem(vrow: integer);
    procedure SelectItems;
    procedure RestroreDefault(seder: TAdvEdit);

    procedure RemoveItem(vrow: integer);
    procedure RemoveItems;

    procedure PrepareData;
    procedure PrepareData2;
    procedure SelectHarga;
    procedure SetToFormat1(rowID, col_ke: Integer);
  public
    procedure Execute(id: integer); override;
  end;

var
  frmMstBarcode: TfrmMstBarcode;

implementation

uses uMysqlClient, MySQLConnector, UConst, MainMenu, LookupData,
  UMaster, BarcodePrintiBig, Barcode, UConstTool, Subroutines, MstCodeList,
  BarcodePrintSmall;

const
  colId      = 0;
  colQty     = 1;
  colBarcode = 2;
  colStruk   = 3;
  colSales1  = 4;
  colSales2  = 5;
  
  colIdx      = 0;
  colBarcodex = 1;
  colStrukx   = 2;

{$R *.dfm}

{ TfrmMstBarcode }

procedure TfrmMstBarcode.Execute(id: integer);
begin
  inherited;
  ToolBar1.ParentColor:= False;
  ToolBar1.Color:= clWhite;
  InitForm;
  Run(Self);
end;

procedure TfrmMstBarcode.InitForm;
begin
  InitGrid;
  cmbFormat.ItemIndex:= 0;
  txtSpec.Text:= 'BARANG JADI';
  txtSpec.Tag:= 1;
  txtVc.Text:= 'Semua Supplier';
  txtVc.Tag:= 0;
  txtProdusen.Clear;
  txtProdusen.Tag:= 0;
  txtKemasan.Tag:= 0;
  txtKemasan.Text:= '';
  txtNama.Clear;
  txtMerk.Clear;
  txtCol.IntValue:= 5;
  UpDown1.Position:= 5;
end;

procedure TfrmMstBarcode.InitGrid;
begin
  grid.ClearNormalCells;
  ResetGrid(grid, 2, 6, 1, 0, colStruk);
  grid.AutoSizeColumns(TRUE, 4);
  grid.ColWidths[colID]:= 0;
  grid.AddCheckBox(colSales1, 0, True, False);
  grid.AddCheckBox(colSales2, 0, True, False);
end;

procedure TfrmMstBarcode.LoadData;
var i: integer; item: TMysqlResult;
  sql,filter: string;
begin
  filter:= ' and i.disabled_date is null ';
  if txtSpec.Tag <> 0 then
     filter:= filter + ' and p.root_id ='+FormatSQLNumber(txtSpec.Tag);
  if txtVc.Tag <> 0 then
     filter:= filter + ' and i.vendor_id ='+FormatSQLNumber(txtVc.Tag);
  if txtProdusen.Tag <> 0 then
     filter:= filter + ' and i.produsen_id ='+FormatSQLNumber(txtProdusen.Tag);
  if txtKemasan.Text <> '' then
     filter:= filter + ' and i.barcode ='+FormatSQLString(txtKemasan.Text);
  if txtNama.Text <> '' then
     filter:= filter + ' and i.item_name like '+FormatSQLString('%'+txtNama.Text+'%');
  if txtMerk.Text <> '' then
     filter:= filter + ' and i.item_code like '+FormatSQLString('%'+txtMerk.Text+'%');

  sqL:=
  'select distinct i.item_id, i.barcode, i.struk_name '+
  'from mst_item i, point_maping p '+
  'where i.specification = p.code_id '+ filter;

  try
    StartProgress;
    item:= OpenSQL(sql);

    gridVar.ClearNormalCells;
    gridVar.ColWidths[colIdx     ]:= 0;
    gridVar.ColWidths[colBarcodex]:= 90;
    gridVar.ColWidths[colStrukx  ]:= gridVar.Width - 110;

    gridVar.RowCount:= IfThen(item.RecordCount > 0, item.RecordCount + 1, 2);
    gridVar.Refresh;
    gridVar.Repaint;

    for i:= 1 to item.RecordCount do begin
      ProsesProgress(i,item.RecordCount);
      gridVar.Ints[colIdx,      i]:= BufferToInteger(item.FieldValue(0));
      gridVar.Cells[colBarcodex,i]:= BufferToString(item.FieldValue(1));
      gridVar.Cells[colStrukx,  i]:= BufferToString(item.FieldValue(2));
      item.MoveNext;
    end;
    item.destroy;

  finally
    EndProgress;
  end;
end;

procedure TfrmMstBarcode.PrepareData;
var i,j, qty, col_ke: integer;
begin
  asgPrint.Clear;
  asgPrint.Refresh;
  asgPrint.Repaint;
  col_ke:= 0;
  harga1:= false; harga2:= false;
  case cmbFormat.ItemIndex of
    0:begin
        asgPrint.ColCount:= 15; //5 kolom
        asgPrint.RowCount:= 1;
        grid.GetCheckBoxState(colSales1, 0, harga1);
        grid.GetCheckBoxState(colSales2, 0, harga2);
        for i:= 1 to grid.RowCount-1 do begin
          if (not IsClear(grid, colId, i)) then
          begin
             qty:= grid.Ints[colQty, i];
             for j:= 1 to qty do begin
               SetToFormat1(i, col_ke);
               Inc(col_ke);
               if col_ke >= txtCol.IntValue then col_ke:= 0;
             end;
          end;
        end;
      end;
  end;
  asgPrint.AutoSizeColumns(true, 3);
end;

procedure TfrmMstBarcode.SetToFormat1(rowID, col_ke: Integer);
var row: Integer; harga: string;
begin
  harga:='';
  if col_ke = 0 then asgPrint.AddRow;
  col_ke:= col_ke * 3;
  row:= asgPrint.RowCount-1;

  if harga1 = true then harga:= grid.Cells[colSales1, rowID];
  if harga2 = true then harga:= harga + '/'+ grid.Cells[colSales2, rowID];
  if LeftStr(harga,1) = '/' then Delete(harga, 1, 1);

  asgPrint.Cells[col_ke,   row]:= grid.Cells[colStruk, rowID];
  asgPrint.Cells[col_ke+1, row]:= grid.Cells[colBarcode, rowID];
  asgPrint.Cells[col_ke+2, row]:= harga;
end;

procedure TfrmMstBarcode.tbtRefreshClick(Sender: TObject);
begin
  LoadData;
end;

procedure TfrmMstBarcode.tbtPrintClick(Sender: TObject);
begin
  try
    case cmbFormat.ItemIndex of
    0: begin
         PrepareData;
         if GlobalSystemConfig.localSetting.PrinterBarcode <> '' then begin
           if (getDefaultPrinter <> GlobalSystemConfig.localSetting.PrinterBarcode) then
              setDefaultPrinter(GlobalSystemConfig.localSetting.PrinterBarcode);
         end;

         try
           Application.CreateForm(TqrpBarcodePrintiBig, qrpBarcodePrintiBig);
           qrpBarcodePrintiBig.Executes(asgPrint);
         finally
           qrpBarcodePrintiBig.Destroy;
         end;

       end;
    1: begin
         PrepareData2;
         if GlobalSystemConfig.localSetting.PrinterBarcode <> '' then begin
           if (getDefaultPrinter <> GlobalSystemConfig.localSetting.PrinterBarcode) then
              setDefaultPrinter(GlobalSystemConfig.localSetting.PrinterBarcode);
         end;
         
         try
           Application.CreateForm(TqrpBarcodeSmall, qrpBarcodeSmall);
           qrpBarcodeSmall.Executes(asgPrint);
         finally
           qrpBarcodeSmall.Destroy;
         end;

       end;
    end;
  finally
  end;
end;

procedure TfrmMstBarcode.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
//
end;

procedure TfrmMstBarcode.gridCanEditCell(Sender: TObject; ARow,
  ACol: Integer; var CanEdit: Boolean);
begin
  CanEdit:= (ACol in[colQty]) and (grid.Ints[colID, ARow] > 0)
end;

procedure TfrmMstBarcode.gridGetAlignment(Sender: TObject; ARow,
  ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  if (ACol in[colQty, colSales1, colSales2]) then HAlign:= taRightJustify
end;

procedure TfrmMstBarcode.gridGetEditorType(Sender: TObject; ACol,
  ARow: Integer; var AEditor: TEditorType);
begin
  case ACol of
    colQty: AEditor:= edPositiveNumeric;
  end;
end;

procedure TfrmMstBarcode.gridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_SPACE:
      if (grid.Col in[colSales1, colSales2]) then
         SelectHarga;
    VK_RETURN: GoNextColumn(Sender)     
  end;
end;

procedure TfrmMstBarcode.SelectHarga;
var st: boolean;
begin
  st:= False;
  grid.GetCheckBoxState(grid.Col, 0, st);
  grid.SetCheckBoxState(grid.Col, 0, (not st));
end;

procedure TfrmMstBarcode.Button2Click(Sender: TObject);
var id: integer;
begin
  id:= frmLookup.Execute('SPL');
  if Id > 0 then begin
    txtVc.Text:= TMstRelation.GetName(id);
    txtVc.Tag:= id;
  end;
end;

procedure TfrmMstBarcode.Button3Click(Sender: TObject);
var id: integer;
begin
  id:= frmLookup.Execute('PRODUSEN');
  if Id > 0 then begin
    txtProdusen.Text:= TMstMaster.GetName(id);
    txtProdusen.Tag:= id;
  end;
end;

procedure TfrmMstBarcode.Button1Click(Sender: TObject);
var ID: integer;
begin
  ID:= frmMstCodeList.Execute(1);
  if ID <> 0 then begin
    txtSpec.Tag := ID;
    txtSpec.Text:= TMstCode.getName(ID);
  end;
end;

function TfrmMstBarcode.getKetentuanHarga(ItemID, UnitID,
  FaktorHarga: integer): string;
var bufer: TMysqlResult;
begin
  bufer:= OpenSQL(
  'select concat('';'', round(r.batas_minimal), '' '', '+
  '(select lower(u.mst_code) from mst_master u where u.mst_id = '+IntToStr(UnitID)+' limit 1)) as sat '+
  'from mst_produk p, mst_produk_rule r, mst_produk_item i '+
  'where p.produk_id = r.produk_id and r.rule_id = i.rule_id '+
  'and p.aktif = 1 and p.faktor = '+IntToStr(PROD_HJUAL)+' and r.faktor_id = '+IntToStr(FaktorHarga)+
  ' and i.item_id = '+IntToStr(ItemID));
  if bufer.RecordCount>0 then
    Result:= bufer.FieldValue(0)
  else Result:= '';  
  bufer.destroy;
end;

procedure TfrmMstBarcode.PrepareData2;
var i,j, qty, col_ke: integer;
begin
  asgPrint.Clear;
  asgPrint.Refresh;
  asgPrint.Repaint;
  col_ke:= 0;
  harga1:= True; harga2:= false;
  case cmbFormat.ItemIndex of
    1:begin
        asgPrint.ColCount:= 15; //5 kolom
        asgPrint.RowCount:= 1;
        for i:= 1 to grid.RowCount-1 do begin
          if (not IsClear(grid, colId, i)) then
          begin
             qty:= grid.Ints[colQty, i];
             for j:= 1 to qty do begin
               SetToFormat1(i, col_ke);
               Inc(col_ke);
                if col_ke >= txtCol.IntValue then col_ke:= 0;
             end;
          end;
        end;
      end;
  end;
  asgPrint.AutoSizeColumns(true, 3);
end;

procedure TfrmMstBarcode.SelectItem(vrow: integer);
var item: TMysqlResult; row: integer;
begin
  if gridVar.Ints[colIDX, gridVar.Row] = 0 then exit;

  item:= OpenSQL(
  'select distinct i.item_id, i.barcode, i.struk_name, '+
  'k.sales_price, k.sales_price2, k.unit_id '+
  'from mst_item i, mst_item_conversion k, point_maping p '+
  'where i.item_id = k.item_id and k.conversion = 1 and i.specification = p.code_id '+
  'and i.item_id = '+FormatSQLNumber(gridVar.Ints[colIDx, vrow]));
  if item.RecordCount > 0 then begin
  if (grid.Ints[colId, grid.RowCount-1]<>0) then grid.AddRow;
    row:= grid.RowCount-1;

    grid.Ints[colId,row]:= BufferToInteger(item.FieldValue(0));
    grid.Ints[colQty,row]:= 1;
    grid.Cells[colBarcode,row]:= BufferToString(item.FieldValue(1));
    grid.Cells[colStruk,  row]:= BufferToString(item.FieldValue(2));
    grid.Cells[colSales1, row]:= FloatToStrFmt(BufferToFloat(item.FieldValue(3)));
    grid.Cells[colSales2, row]:= FloatToStrFmt(BufferToFloat(item.FieldValue(4)))+
      getKetentuanHarga(BufferToInteger(item.FieldValue(0)),
      BufferToInteger(item.FieldValue(5)), FAKTOR_HRG2);

    grid.AutoSizeColumns(TRUE, 4);
    grid.ColWidths[colID]:= 0;
    deleteRow(gridVar,vrow);
  end;
  item.destroy;
end;

procedure TfrmMstBarcode.SelectItems;
var i, counter:integer;
begin
  counter:= gridVar.RowCount-1;
  for i:= 1 to counter do SelectItem(1);
end;

procedure TfrmMstBarcode.deleteRow(grid: TAdvStringGrid; row: integer);
begin
  grid.ClearRows(row,1);
  if grid.RowCount > 2 then grid.RemoveRows(row,1);
end;

procedure TfrmMstBarcode.RemoveItem(vrow: integer);
begin
  if grid.Ints[colID, vrow] = 0 then exit;
  if gridVar.Ints[colIDx, gridVar.RowCount-1] <> 0 then gridVar.AddRow;

  gridVar.Ints[colIDx, gridVar.RowCount-1]:= grid.Ints[colID, vrow];
  gridVar.Cells[colStrukx,gridVar.RowCount-1]:= grid.Cells[colStruk, vrow];
  gridVar.Cells[colBarcodex,gridVar.RowCount-1]:= grid.Cells[colBarcode, vrow];
  deleteRow(grid, vrow);
end;

procedure TfrmMstBarcode.RemoveItems;
var i, counter:integer;
begin
  counter:= grid.RowCount-1;
  for i:= 1 to counter do RemoveItem(1);
end;

procedure TfrmMstBarcode.SpeedButton1Click(Sender: TObject);
begin
  SelectItem(gridVar.Row);
end;

procedure TfrmMstBarcode.SpeedButton2Click(Sender: TObject);
begin
  SelectItems
end;

procedure TfrmMstBarcode.SpeedButton3Click(Sender: TObject);
begin
  RemoveItem(grid.Row);
end;

procedure TfrmMstBarcode.SpeedButton4Click(Sender: TObject);
begin
  RemoveItems
end;

procedure TfrmMstBarcode.gridVarRowChanging(Sender: TObject; OldRow,
  NewRow: Integer; var Allow: Boolean);
begin
  if OldRow <= gridVar.RowCount-1 then
    gridVar.RowHeights[OldRow]:= gridVar.DefaultRowHeight;
  gridVar.AutoSizeRow(NewRow);
  if gridVar.RowHeights[NewRow] < gridVar.DefaultRowHeight then
    gridVar.RowHeights[NewRow]:= gridVar.DefaultRowHeight;
end;

procedure TfrmMstBarcode.ToolButton1Click(Sender: TObject);
begin
  inherited;
  InitGrid;
end;

procedure TfrmMstBarcode.RestroreDefault(seder: TAdvEdit);
begin
  (seder as TAdvEdit).Tag:= 0;
  if (seder as TAdvEdit).Name = 'txtSpec' then begin
    txtSpec.Text:= 'BARANG JADI';
    txtSpec.Tag:= 1;
  end
  else if (seder as TAdvEdit).Name = 'txtVc' then
    txtVc.Text:= 'Semua Supplier'
  else if (seder as TAdvEdit).Name = 'txtProdusen' then
    txtProdusen.Text:= 'Semua Produsen'
  else (seder as TAdvEdit).Clear;

end;

procedure TfrmMstBarcode.txtSpecKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    VK_F1: RestroreDefault((Sender as TAdvEdit));
  end;

end;

end.
