unit MstItemList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, BaseGrid, AdvGrid, StdCtrls, AdvEdit, ComCtrls, ToolWin,
  ExtCtrls, strUtils, Math,
  UMaster, WinXP, Menus, SUIImagePanel, UTransaction,
  frmDockForm, Buttons, SUIButton;

type
  TfrmMstItemList = class(TDockForm)
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
    Label2: TLabel;
    cmbKategori: TComboBox;

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
    procedure gridDblClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure ToolButton3Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);

  private
    purpose : integer;
    procedure ArrangeColWIdth;
    procedure InitGrid;
    procedure InitForm;
    procedure SetFilter;
    procedure InitFilter;
    procedure LoadData;
//    procedure tes;
  public
    procedure Execute(aPurpose:integer;id: integer=0);override;
  end;

var
  frmMstItemList: TfrmMstItemList;

implementation

uses UConstTool, MainMenu, Subroutines,
  MstCodeList, MstItem, UConst,
  mstItemListPrint, LookupData, uMysqlClient, MySQLConnector;

const
  colNo      = 0;
  colId      = 1;
  colCode    = 2;
  colBarcode = 3;
  colJenis = 4;
  colName    = 5;
  colMerk = 6;
  colStruk = 7;
  colSatuan = 8;
  colStok    = 9 ;
  colHarga = 10;
  colLast = 11;

{$R *.dfm}

{ TfrmMstItemList }

procedure TfrmMstItemList.Execute(aPurpose:integer;id: integer);
begin
  inherited;
  purpose := aPurpose;
  ToolBar1.ParentColor:= false;
  ToolBar1.Color:= clWhite;
  InitForm;
  SetFilter;
  LoadData;
  Run(Self);
end;

procedure TfrmMstItemList.InitFilter;
begin
  GlobalPeriode.Reset;
  txtSpec.Text:= '';
  txtSpec.Tag:= 1;
  txtKategori.Text:= '';
  txtKategori.Tag:= 0;
  cmbStatus.ItemIndex:= 1;
  cmbKategori.ItemIndex := 1;
  txtNama.Clear;
  txtMerk.Clear;
  txtCode.Clear;
  txtBarcode.Clear;
end;

procedure TfrmMstItemList.InitForm;
begin
  tbtNew.Enabled := (purpose  = 0);
  InitGrid;
  InitFilter;
end;

procedure TfrmMstItemList.InitGrid;
begin
  ResetGrid(grid, 2, colLast+1, 1, 1,-1);
  grid.AutoSizeColumns(True,2);
  grid.Cells[colHarga,0] := IfThen(purpose=1,'Harga Beli','Harga Jual');
  ArrangeColWIdth;
  grid.RowHeights[1]:= grid.DefaultRowHeight;
end;

procedure TfrmMstItemList.LoadData;
var i: integer; item: TMysqlResult;
begin
  try
    StartProgress;
    InitGrid;
    SetFilter;
    item:= TMstItemArr.LoadFromDB2;
    grid.RowCount:= IfThen(item.RecordCount > 0, item.RecordCount + 1, 2);

    for i:= 1 to item.RecordCount do begin
      ProsesProgress(i,item.RecordCount);
      grid.Ints[colNo, i]:= i;//+txtLimit.Tag;

      //0i.item_id, 1i.item_code, 2i.barcode, 3i.item_name, '+
//  ', 4merk,5struk_name,6round(i.current_stock), '+
  ///7sat,


      grid.Ints[colId, i]:= BufferToInteger(item.FieldValue(0));
      grid.Cells[colCode,   i]:= BufferToString(item.FieldValue(1));
      grid.Cells[colBarcode,i]:= BufferToString(item.FieldValue(2));
      grid.Cells[colName,   i]:= BufferToString(item.FieldValue(3));
      grid.Cells[colMerk,   i]:= BufferToString(item.FieldValue(4));
      grid.Cells[colStruk,   i]:= BufferToString(item.FieldValue(5));
      grid.Cells[colJenis,   i]:= BufferToString(item.FieldValue(8));
       grid.Cells[colSatuan,   i]:= BufferToString(item.FieldValue(7));
//      grid.Cells[colHBeli,  i]:= FloatToStrFmtNull(BufferToFloat(item.FieldValue(4)));

{      if BufferToFloat(item.FieldValue(14)) = 1 then
         grid.Cells[colHDisc,  i]:= FloatToStrFmtNull((BufferToFloat(item.FieldValue(5)) * 100) / BufferToFloat(item.FieldValue(4)))+'%'
      else grid.Cells[colHDisc,i]:= FloatToStrFmtNull(BufferToFloat(item.FieldValue(5)));
}
//      grid.Cells[colHTax,   i]:= FloatToStrFmtNull(BufferToFloat(item.FieldValue(6)));
//      grid.Cells[colHDasar, i]:= FloatToStrFmtNull(BufferToFloat(item.FieldValue(7)));
//      grid.Cells[colHRata,  i]:= FloatToStrFmtNull(BufferToFloat(item.FieldValue(8)));
//      grid.Cells[colMargin, i]:= FloatToStrFmtNull(BufferToFloat(item.FieldValue(9)));
//      grid.Cells[colHJual1, i]:= FloatToStrFmtNull(BufferToFloat(item.FieldValue(10)));
//      grid.Cells[colHJual2, i]:= FloatToStrFmtNull(BufferToFloat(item.FieldValue(11)));

      if (BufferToFloat(item.FieldValue(6)) <> 0) then

        grid.Cells[colStok,i]:= FloatToStrFmtNull(BufferToFloat(item.FieldValue(6))) +' '+item.FieldValue(7);

        if purpose = 1 then
            grid.Cells[colHarga,i]:= FloatToStrFmtNull(BufferToFloat(item.FieldValue(9)));
        if purpose = 2 then
            grid.Cells[colHarga,i]:= FloatToStrFmtNull(BufferToFloat(item.FieldValue(10)));
//      if CheckBox2.Checked = True then
  //       grid.Cells[colRak,i]:= TMstItem.GetRakDesc(BufferToInteger(item.FieldValue(0)));

//      grid.Cells[colDosis,  i]:= FloatToStrFmtNull(BufferToFloat(item.FieldValue(15)));
  //    grid.Dates[colExpire, i]:= BufferToDateTime(item.FieldValue(16));

      item.MoveNext;
    end;

    item.destroy;
  ArrangeColWIdth;

  finally
    EndProgress;
  end;
end;

procedure TfrmMstItemList.SetFilter;
begin
  GlobalFilter.Reset;
  GlobalFilter.SpecID  := txtSpec.Tag;
  GlobalFilter.StatusID:= cmbStatus.ItemIndex;
  GlobalFilter.Name:= txtNama.Text;
  GlobalFilter.TipeID:= txtMerk.Text;
  GlobalFilter.FString1:= txtCode.Text;
  GlobalFilter.FString2:= txtBarcode.Text;

  GlobalFilter.Numeric3:= cmbKategori.ItemIndex-1; //txtKategori.Tag;
end;

procedure TfrmMstItemList.gridGetAlignment(Sender: TObject; ARow,
  ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  if (ACol >= colStok) then HAlign:= taRightJustify
end;

procedure TfrmMstItemList.tbtNewClick(Sender: TObject);
begin
//Alert(IntToStr(AktiveControl.Tag));
  if TSystemAccess.isCan(CAN_ADD,AktiveControl.Tag) then
    frmMstItem.Execute(purpose,0);
end;

procedure TfrmMstItemList.tbtDetailClick(Sender: TObject);
begin
  if not TSystemAccess.isCan(CAN_EDIT,AktiveControl.Tag) then exit;
  frmMstItem.Execute(purpose,StrToIntDef(grid.Cells[colId, grid.Row],0));
end;

procedure TfrmMstItemList.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  //if MstItem <> nil then MstItem.Free;
  //MstItem:= nil;
end;

procedure TfrmMstItemList.ToolButton5Click(Sender: TObject);
begin
  InitFilter
end;

procedure TfrmMstItemList.tbtRefreshClick(Sender: TObject);
begin
  LoadData;
end;

procedure TfrmMstItemList.tbtPrintClick(Sender: TObject);
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
procedure TfrmMstItemList.Aktivasi1Click(Sender: TObject);
begin
  TMstItem.activasi(grid.Ints[colId, grid.Row])
end;

procedure TfrmMstItemList.Button1Click(Sender: TObject);
var ID: integer;
begin
  ID:= frmMstCodeList.Execute(1);
  if ID <> 0 then begin
    txtSpec.Tag := ID;
    txtSpec.Text:= TMstCode.getName(ID);
  end;
end;

procedure TfrmMstItemList.gridRowChanging(Sender: TObject; OldRow,
  NewRow: Integer; var Allow: Boolean);
begin
  if OldRow <= grid.RowCount-1 then
    grid.RowHeights[OldRow]:= grid.DefaultRowHeight;
  grid.AutoSizeRow(NewRow);
  if grid.RowHeights[NewRow] < grid.DefaultRowHeight then
    grid.RowHeights[NewRow]:= grid.DefaultRowHeight;
end;

procedure TfrmMstItemList.gridDblClickCell(Sender: TObject; ARow,
  ACol: Integer);
begin
  tbtDetail.Click
end;

procedure TfrmMstItemList.ToolButton3Click(Sender: TObject);
begin
  if not TSystemAccess.isCan(CAN_DELETE,AktiveControl.Tag) then exit;
  if Confirmed('Hapus Item?') then
  if TMstItem.DeleteItem(grid.Ints[colId, grid.Row]) then begin
     grid.ClearRows(grid.Row,1);
     if grid.RowCount > 2 then grid.RemoveRows(grid.Row,1);
  end;

end;

procedure TfrmMstItemList.Button6Click(Sender: TObject);
var id: integer;
begin
  id:= frmLookup.Execute('JNS_OBAT');
  if Id > 0 then begin
    txtKategori.Text:= TMstMaster.getJenis(id);
    txtKategori.Tag:= id;
  end;
end;

procedure TfrmMstItemList.ArrangeColWIdth;
begin
   grid.AutoSizeColumns(True,2);
   grid.ColWidths[colId] :=0;
   if purpose = 0 then
      grid.ColWidths[colHarga] :=0
   else
    grid.ColWidths[colStok] :=0;
end;

end.
