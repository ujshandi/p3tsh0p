unit MstItemPriceList;
            {
               PURPOSE :
                1 : harga beli
                2 : harga jual
                3 : discount

            }
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, BaseGrid, AdvGrid, StdCtrls, AdvEdit, ComCtrls, ToolWin,
  ExtCtrls, strUtils, Math,
  UMaster, WinXP, Menus, SUIImagePanel, UTransaction,
  frmDockForm, Buttons, SUIButton;

type
  TfrmMstItemPriceList = class(TDockForm)
    ToolBar1: TToolBar;
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
    txtKategori: TAdvEdit;
    Button6: TButton;
    rgModel: TRadioGroup;
    pnlMarkup: TPanel;
    txtMarkup: TAdvEdit;
    Proses: TButton;
    Label2: TLabel;
    cmbKategori: TComboBox;

    procedure gridGetAlignment(Sender: TObject; ARow, ACol: Integer;
      var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ToolButton5Click(Sender: TObject);
    procedure tbtRefreshClick(Sender: TObject);
    procedure tbtPrintClick(Sender: TObject);
    procedure Aktivasi1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure gridRowChanging(Sender: TObject; OldRow, NewRow: Integer;
      var Allow: Boolean);
    procedure ToolButton3Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure tbtDetailClick(Sender: TObject);
    procedure gridCanEditCell(Sender: TObject; ARow, ACol: Integer;
      var CanEdit: Boolean);
    procedure gridGetEditorType(Sender: TObject; ACol, ARow: Integer;
      var AEditor: TEditorType);
    procedure gridGetCellColor(Sender: TObject; ARow, ACol: Integer;
      AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
    procedure gridCellValidate(Sender: TObject; Col, Row: Integer;
      var Value: String; var Valid: Boolean);
    procedure rgModelClick(Sender: TObject);
    procedure ProsesClick(Sender: TObject);
    procedure txtMarkupKeyPress(Sender: TObject; var Key: Char);

  private
    Purpose :integer;
    EditMode:boolean;
    
    procedure setEnableDisable;
    procedure InitGrid;
    procedure InitForm;
    procedure SetFilter;
    procedure InitFilter;
    procedure LoadData;
    function isSaved:boolean;
//    procedure tes;
  public
    procedure Execute(APurpose:integer;id: integer=0);override;
  end;

var
  frmMstItemPriceList: TfrmMstItemPriceList;

implementation

uses UConstTool, MainMenu, Subroutines,
  MstCodeList, MstItem, UConst,
  mstItemListPrint, LookupData, uMysqlClient, MySQLConnector,
  MstItemPriceListPrint;

const
  colNo      = 0;
  colId      = 1;
  colCode    = 2;
  colBarcode = 3;
  colJenis = 4;
  colName    = 5;
  colMerk = 6;
  colStruk = 7;
  colHargaBeli = 8; //show wne input h.jual & discount
  colHargaJual = 9; //show when input disc
  colHarga    = 10;//utk input
  colHargaPetshop = 11; //utk hjual sesama petshop
  colHargaBreeder = 12; //utk hjual breeder
  colModId = 13;


{$R *.dfm}

{ TfrmMstItemList }

procedure TfrmMstItemPriceList.Execute(APurpose:integer;id: integer);
begin
  inherited;
  Purpose := APurpose;
  
  pnlMarkup.Visible := false;//Purpose in[2,3];
  txtMarkup.LabelCaption := IfThen(Purpose=3,'Discount :','Markup Harga :');
  suiPanel2.Caption := 'Daftar '+IfThen(Purpose=1,'Harga Beli',IfThen(Purpose=2, 'Harga Jual','Discount Barang'));
  ToolBar1.ParentColor:= false;
  ToolBar1.Color:= clWhite;
  InitForm;
  SetFilter;
  LoadData;
  Run(Self);
end;

procedure TfrmMstItemPriceList.InitFilter;
begin
  GlobalPeriode.Reset;
  txtSpec.Clear;//:= 'SEMUA SPEC';
  txtSpec.Tag:= 1;
  txtKategori.Clear;//:= 'SEMUA JENIS';
  txtKategori.Tag:= 0;
  cmbStatus.ItemIndex:= 1;
  cmbKategori.ItemIndex := 1;
  txtNama.Clear;
  txtMerk.Clear;
  txtCode.Clear;
  txtBarcode.Clear;
end;

procedure TfrmMstItemPriceList.InitForm;
begin
  txtMarkup.Text := '0';
  rgModel.ItemIndex:=0;
  rgModelClick(nil);
  rgModel.Visible := Purpose <> 3;
  InitGrid;
  InitFilter;
end;

procedure TfrmMstItemPriceList.InitGrid;
begin
  grid.ExpandAll;
  grid.Clear;
  ResetGrid(grid, 2, colModId+2, 1, 1,-1);
  grid.Cells[colNo,0] :='No';
  grid.Cells[colCode,0] :='Kode';
  grid.Cells[colBarcode,0] :='Barcode';
  grid.Cells[colJenis,0] :='Jenis';
  grid.Cells[colName,0] :='Nama';
  grid.Cells[colMerk,0] :='Merk';
  grid.Cells[colStruk,0] :='Nama Struk';
  grid.Cells[colHargaBeli,0] := 'Harga Beli';
  grid.Cells[colHargaJual,0] := 'Harga Jual';



  grid.AutoSizeColumns(True, 4);
  grid.Cells[colHarga,0] := IfThen(Purpose=1,'Harga Beli',IfThen(Purpose=2, 'Harga Jual','Max.Disc(%)'));
  grid.Cells[colHargaPetshop,0] := 'H.Petshop';
  grid.Cells[colHargaBreeder,0] := 'H.Breeder';
  grid.ColWidths[colId]:= 0;
  grid.ColWidths[colModId]:= 0;
  if purpose = 1 then begin
    grid.ColWidths[colHargaBeli]:=0;
    grid.ColWidths[colHargaJual]:=0;
    grid.ColWidths[colHargaPetshop]:=0;
    grid.ColWidths[colHargaBreeder]:=0;
  end;
   if purpose = 3 then begin  //discount
     grid.ColWidths[colHargaPetshop]:=0;
    grid.ColWidths[colHargaBreeder]:=0;
  end;
  if purpose = 2 then begin
    grid.ColWidths[colHargaJual]:=0;
  end;


  grid.RowHeights[1]:= grid.DefaultRowHeight;
end;

procedure TfrmMstItemPriceList.LoadData;
var i,j,row: integer; item,detail: TMysqlResult;
begin
  try
    StartProgress;
    InitGrid;
    SetFilter;
    item:= TMstItemArr.LoadFromDB2;
    ///grid.RowCount:= IfThen(item.RecordCount > 0, item.RecordCount + 1, 2);

    for i:= 1 to item.RecordCount do begin
      ProsesProgress(i,item.RecordCount);
      row := grid.RowCount-1;
      grid.Ints[colNo, row]:= i;//+txtLimit.Tag;
        grid.Ints[colModId, row]:= 0;
      //0i.item_id, 1i.item_code, 2i.barcode, 3i.item_name, '+
//  ', 4merk,5struk_name,6round(i.current_stock), '+
  ///7sat,8Jenis,9buying_price,10selling_pric


      grid.Ints[colId, row]:= BufferToInteger(item.FieldValue(0));
      grid.Cells[colCode,   row]:= BufferToString(item.FieldValue(1));
      grid.Cells[colBarcode,row]:= BufferToString(item.FieldValue(2));
      grid.Cells[colName,   row]:= BufferToString(item.FieldValue(3));
      grid.Cells[colMerk,   row]:= BufferToString(item.FieldValue(4));
      grid.Cells[colStruk,   row]:= BufferToString(item.FieldValue(5));
      grid.Cells[colJenis,   row]:= BufferToString(item.FieldValue(8));
      case Purpose of
        1 : grid.Cells[colHarga,row]:= FloatToStrFmt(BufferToFloat(item.FieldValue(9))) ;
        2 : begin
           grid.Cells[colHargaBeli,row]:= FloatToStrFmt(BufferToFloat(item.FieldValue(9))) ;
          grid.Cells[colHarga,row]:= FloatToStrFmt(BufferToFloat(item.FieldValue(10))) ;
            grid.Cells[colHargaPetshop,row]:= FloatToStrFmt(BufferToFloat(item.FieldValue(12))) ;
              grid.Cells[colHargaBreeder,row]:= FloatToStrFmt(BufferToFloat(item.FieldValue(13))) ;
        end;
        3 : begin
           grid.Cells[colHargaBeli,row]:= FloatToStrFmt(BufferToFloat(item.FieldValue(9))) ;
          grid.Cells[colHargaJual,row]:= FloatToStrFmt(BufferToFloat(item.FieldValue(10))) ;
          grid.Cells[colHarga,row]:= FloatToStrFmt(BufferToFloat(item.FieldValue(11))) ;
        end;
      end;


      if (rgModel.ItemIndex = 1) and (Purpose in [1,2]) then begin
         detail := TMstItemArr.loadPriceHistory(BufferToInteger(item.FieldValue(0)),Purpose);
         for j:= 0 to detail.RecordCount-1 do begin
            grid.AddRow;
            row := grid.RowCount-1;
            if j=0 then begin
               grid.Cells[colMerk,row] := IfThen(Purpose=1,'Per Tanggal','');
               grid.Cells[colStruk,row] := IfThen(Purpose=1,'Supplier', 'Per Tanggal');
               grid.Cells[colHarga,row] := 'Harga';
                grid.Cells[colHargaPetshop,row] := 'H.Petshop';
                 grid.Cells[colHargaBreeder,row] := 'H.Breeder';
               if Purpose=1 then
                  grid.Colors[colMerk,row]:= clSkyBlue;
               grid.Colors[colStruk,row]:= clSkyBlue;
               grid.Colors[colHarga,row]:= clSkyBlue;
               grid.Colors[colHargaPetshop,row]:= clSkyBlue;
               grid.Colors[colHargaBreeder,row]:= clSkyBlue;
               grid.AddRow;
               row := grid.RowCount-1;
            end;
            if Purpose = 1 then begin

              grid.Cells[colMerk,row] := FormatDateTime(ShortDateFormat,BufferToDateTime(detail.FieldValue(0)));
              grid.Cells[colStruk,row] :=BufferToString(detail.FieldValue(2));
            end
           else
             grid.Cells[colStruk,row] := FormatDateTime(ShortDateFormat,BufferToDateTime(detail.FieldValue(0)));
            grid.Cells[colHarga,row] := FloatToStrFmt(BufferToFloat(detail.FieldValue(1)));
            grid.Cells[colHargaPetshop,row] := FloatToStrFmt(BufferToFloat(detail.FieldValue(2)));
            grid.Cells[colHargaBreeder,row] := FloatToStrFmt(BufferToFloat(detail.FieldValue(3)));
            if Purpose=1 then
                  grid.Colors[colMerk,row]:= clSilver;
            grid.Colors[colStruk,row]:= clSilver;
            grid.Colors[colHarga,row]:= clSilver;
            grid.Colors[colHargaPetshop,row]:= clSilver;
            grid.Colors[colHargaBreeder,row]:= clSilver;
            detail.MoveNext;
         end;

        if detail.RecordCount>0 then
           grid.AddNode(row-detail.RecordCount-1,detail.RecordCount+2);

      end;



      grid.AddRow;
      item.MoveNext;
    end;

    item.destroy;
    DeleteRowTerakhir(grid,2,1);
    grid.AutoSizeColumns(true, 4);
    grid.ColWidths[colID]:= 0;
    grid.ColWidths[colModId]:= 0;
    if Purpose=1 then begin
       grid.ColWidths[colHargaBeli]:= 0;
       grid.ColWidths[colHargaJual]:=0;
       grid.ColWidths[colHargaPetshop]:=0;
      grid.ColWidths[colHargaBreeder]:=0;
    end;
    if purpose = 2 then begin
      grid.ColWidths[colHargaJual]:=0;
    end;
    if purpose = 3 then begin  //discount
     grid.ColWidths[colHargaPetshop]:=0;
    grid.ColWidths[colHargaBreeder]:=0;
  end;

  finally
    EndProgress;
  end;
end;

procedure TfrmMstItemPriceList.SetFilter;
begin
  GlobalFilter.Reset;
  GlobalFilter.SpecID  := txtSpec.Tag;
  GlobalFilter.StatusID:= cmbStatus.ItemIndex;
  GlobalFilter.Name:= txtNama.Text;
  GlobalFilter.TipeID:= txtMerk.Text;
  GlobalFilter.FString1:= txtCode.Text;
  GlobalFilter.FString2:= txtBarcode.Text;

  GlobalFilter.Numeric3:= cmbKategori.ItemIndex-1;//txtKategori.Tag;
end;

procedure TfrmMstItemPriceList.gridGetAlignment(Sender: TObject; ARow,
  ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  if (ACol in [colHarga,colHargaBeli,colHargaJual,colHargaPetshop,colHargaBreeder]) then HAlign:= taRightJustify
end;

procedure TfrmMstItemPriceList.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  //if MstItem <> nil then MstItem.Free;
  //MstItem:= nil;
end;

procedure TfrmMstItemPriceList.ToolButton5Click(Sender: TObject);
begin
  InitFilter
end;

procedure TfrmMstItemPriceList.tbtRefreshClick(Sender: TObject);
begin
  LoadData;
end;

procedure TfrmMstItemPriceList.tbtPrintClick(Sender: TObject);
begin
  if not TSystemAccess.isCan(CAN_PRINT,AktiveControl.Tag) then exit;
  if MustRegister then exit;
  try
    Application.CreateForm(TqrpItemPriceList, qrpItemPriceList);
    qrpItemPriceList.Executes(Purpose,(rgModel.ItemIndex=1),grid);
  finally
    qrpItemPriceList.Destroy;
  end;
end;
procedure TfrmMstItemPriceList.Aktivasi1Click(Sender: TObject);
begin
  TMstItem.activasi(grid.Ints[colId, grid.Row])
end;

procedure TfrmMstItemPriceList.Button1Click(Sender: TObject);
var ID: integer;
begin
  ID:= frmMstCodeList.Execute(1);
  if ID <> 0 then begin
    txtSpec.Tag := ID;
    txtSpec.Text:= TMstCode.getName(ID);
  end;
end;

procedure TfrmMstItemPriceList.gridRowChanging(Sender: TObject; OldRow,
  NewRow: Integer; var Allow: Boolean);
begin
  if OldRow <= grid.RowCount-1 then
    grid.RowHeights[OldRow]:= grid.DefaultRowHeight;
  grid.AutoSizeRow(NewRow);
  if grid.RowHeights[NewRow] < grid.DefaultRowHeight then
    grid.RowHeights[NewRow]:= grid.DefaultRowHeight;
end;

procedure TfrmMstItemPriceList.ToolButton3Click(Sender: TObject);
begin
  if Confirmed('Hapus Item?') then
  if TMstItem.DeleteItem(grid.Ints[colId, grid.Row]) then begin
     grid.ClearRows(grid.Row,1);
     if grid.RowCount > 2 then grid.RemoveRows(grid.Row,1);
  end;

end;

procedure TfrmMstItemPriceList.Button6Click(Sender: TObject);
var id: integer;
begin
  id:= frmLookup.Execute('JNS_OBAT');
  if Id > 0 then begin
    txtKategori.Text:= TMstMaster.getJenis(id);
    txtKategori.Tag:= id;
  end;
end;

procedure TfrmMstItemPriceList.setEnableDisable;
begin
  tbtDetail.Enabled := rgModel.ItemIndex=0;
end;

procedure TfrmMstItemPriceList.tbtDetailClick(Sender: TObject);
begin
  if not TSystemAccess.isCan(CAN_EDIT,AktiveControl.Tag) then exit;
  inherited;
  EditMode := (tbtDetail.Caption = 'Edit');
  pnlMarkup.Visible := EditMode and (Purpose in [2,3]);
  if EditMode then begin
    tbtDetail.Caption := 'Save';
  end
  else begin
     if isSaved then
       tbtDetail.Caption := 'Edit';
  end;

end;

procedure TfrmMstItemPriceList.gridCanEditCell(Sender: TObject; ARow,
  ACol: Integer; var CanEdit: Boolean);
begin
  inherited;
  CanEdit :=  (EditMode) and (ACol in [colHarga,colHargaPetshop,colHargaBreeder]);
end;

procedure TfrmMstItemPriceList.gridGetEditorType(Sender: TObject; ACol,
  ARow: Integer; var AEditor: TEditorType);
begin
  inherited;

  if (ARow>0) and (ACol in[colHarga,colHargaPetshop,colHargaBreeder]) then
    AEditor := edPositiveNumeric;
end;

procedure TfrmMstItemPriceList.gridGetCellColor(Sender: TObject; ARow,
  ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin
  inherited;
   if (ARow>0) and (ACol in[colHarga,colHargaPetshop,colHargaBreeder]) and (rgModel.ItemIndex=0) then
      ABrush.Color := clLime;
end;

function TfrmMstItemPriceList.isSaved: boolean;
var i,idx:integer;
  item : TMstItemArr;
begin
   item := TMstItemArr.Create();
    for i:= 1 to grid.RowCount-1 do begin
        if (not IsClear(grid,colId,i)) and (grid.Ints[colModId,i]=0) then Continue;
        idx := item.Add;
        item[idx].ItemID := grid.Ints[colId,i];
        
        if Purpose = 1 then
            item[idx].BuyingPrice := StrFmtToFloatDef(grid.Cells[colHarga,i],0)
         else begin
           item[idx].SellingPrice := StrFmtToFloatDef(grid.Cells[colHarga,i],0);
           item[idx].PricePetshop := StrFmtToFloatDef(grid.Cells[colHargaPetshop,i],0);
           item[idx].PriceBreeder := StrFmtToFloatDef(grid.Cells[colHargaBreeder,i],0);
         end;

    end;
   Result := item.updatePrice(Purpose);
   item.Free;

end;

procedure TfrmMstItemPriceList.gridCellValidate(Sender: TObject; Col,
  Row: Integer; var Value: String; var Valid: Boolean);
begin
  inherited;
 case Col of
      colHarga,colHargaPetshop,colHargaBreeder: //, colSDisp
    begin
      Value:= FloatToStrFmt(StrToFloatDef(Value,0));
      grid.Ints[colModID, Row]:= 1;
      //tbtSave.Enabled:= True;
    end;
 end;
end;

procedure TfrmMstItemPriceList.rgModelClick(Sender: TObject);
begin
  inherited;
  setEnableDisable;
  if rgModel.ItemIndex=0 then tbtRefresh.Click;
end;

procedure TfrmMstItemPriceList.ProsesClick(Sender: TObject);
var i:integer;markup : Real;hJual,hBeli:Double;
begin
  if not TSystemAccess.isCan(CAN_EDIT,AktiveControl.Tag) then exit;
   markup := StrFmtToFloatDef(txtMarkup.Text,0);
   for i:= 1 to grid.RowCount-1 do begin
      if Purpose=2 then begin //harga jual
        hBeli := StrFmtToFloatDef(grid.Cells[colHargaBeli,i],0);
        hJual := ((markup / 100) * hBeli) + hBeli;
        grid.cells[colHarga,i] := FloatToStrFmt(hJual);

      end
      else grid.cells[colHarga,i] := FloatToStrFmt(markup);

        grid.Ints[colModId,i] := 1;
   end;

end;

procedure TfrmMstItemPriceList.txtMarkupKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
 IgnoreChar(Key)
end;

end.
