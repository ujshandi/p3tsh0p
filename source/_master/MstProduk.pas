unit MstProduk;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, BaseGrid, AdvGrid, StdCtrls, AdvEdit, ExtCtrls,
  SUIImagePanel, ComCtrls, ToolWin, Math,
  frmDockForm, WinXP, Buttons,
  UMaster;

type
  TfrmMstProduk = class(TDockForm)
    suiPanel2: TsuiPanel;
    gridSetted: TAdvStringGrid;
    suiPanel4: TsuiPanel;
    suiPanel1: TsuiPanel;
    txtMerk: TAdvEdit;
    txtCode: TAdvEdit;
    txtProdusen: TAdvEdit;
    txtVc: TAdvEdit;
    txtSpec: TAdvEdit;
    Button2: TButton;
    Button1: TButton;
    btnLoad: TButton;
    gridProduk: TAdvStringGrid;
    gridSetting: TAdvStringGrid;
    Label1: TLabel;
    btnSave: TButton;
    btnDelete: TButton;
    WinXP1: TWinXP;
    btnNew: TButton;
    Panel1: TPanel;
    Splitter1: TSplitter;
    Label8: TLabel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    gridUnsetted: TAdvStringGrid;
    procedure gridProdukGetEditorType(Sender: TObject; ACol, ARow: Integer;
      var AEditor: TEditorType);
    procedure gridProdukCellValidate(Sender: TObject; Col, Row: Integer;
      var Value: String; var Valid: Boolean);
    procedure gridProdukGetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: String);
    procedure gridProdukCanEditCell(Sender: TObject; ARow, ACol: Integer;
      var CanEdit: Boolean);
    procedure gridSettingCanEditCell(Sender: TObject; ARow, ACol: Integer;
      var CanEdit: Boolean);
    procedure gridSettingGetAlignment(Sender: TObject; ARow, ACol: Integer;
      var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure gridSettingGetEditorType(Sender: TObject; ACol,
      ARow: Integer; var AEditor: TEditorType);
    procedure gridSettingCellValidate(Sender: TObject; Col, Row: Integer;
      var Value: String; var Valid: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure gridProdukGetAlignment(Sender: TObject; ARow, ACol: Integer;
      var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure gridProdukClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure gridProdukEnter(Sender: TObject);
    procedure gridSettingEnter(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure gridProdukCheckBoxClick(Sender: TObject; ACol, ARow: Integer;
      State: Boolean);
    procedure gridProdukControlClick(Sender: TObject; ARow, ACol: Integer;
      CtrlID, CtrlType, CtrlVal: String);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure btnLoadClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure gridSettingClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure gridProdukGetCellColor(Sender: TObject; ARow, ACol: Integer;
      AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
    procedure gridSettingGetCellColor(Sender: TObject; ARow, ACol: Integer;
      AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
  private
    ls: tstringList;
    state_edit: integer;
    ProdukItem: TMstProdukItem;
    procedure initGridProduk;
    procedure initGridRule;
    procedure getFormatCustomer(row, id: integer);

    procedure addItem(row:integer);
    procedure reMoveItem(row:integer);
    procedure addAllItem;
    procedure reMoveAllItem;
    procedure deleteRow(grid: TAdvStringGrid; row:integer);

    procedure SetFilter;
    procedure LoadItemAvailable;
    procedure loadMasterProduk;
    procedure loadProdukRule;
    procedure LoadProdukItem;

    function saveMasterProduk: boolean;
    function ValidMasterProduk(row: integer): boolean;
    function saveRuleProduk: boolean;

  public
    procedure Execute(id: integer=0); override;
  end;

var
  frmMstProduk: TfrmMstProduk;

implementation

uses MainMenu, uMysqlClient, MySQLConnector, Subroutines,
  MstCodeList, LookupData, UConst;

const
  st_edit_master= 1; st_edit_rule= 2;

  colProduk      = 0;
  colCustomer    = 1;
  colBerlaku     = 2;
  colDari        = 3;
  colSampai      = 4;
  colProdFaktor  = 5;
  colAktv        = 6;

  colProdukID    = 7;
  colCustomerID  = 8;
  colBerlakuID   = 9;
  colProdFaktorID= 10;
  colAktifID     = 11;
  colMasterID    = 12;
  colModID       = 13;

{  --grid setting--  }
  {point - total}
  colLipat = 0;

  {point - peritem}
  colFaktor    = 0;
  colQtyValue  = 1;

  {discount - total - peritem}
  colDisFaktor = 0;
  colMinValue  = 1;
  colDisPrc    = 2;
  colDisValue  = 3;

  {harga jual - total - peritem} {}
  colQtyMin   = 0;
  colHrgUsed  = 1;
              
  colID       = 4;
  colFakID    = 5;
  colRuleModID= 6;

{$R *.dfm}

{ TfrmSetMember }

procedure TfrmMstProduk.initGridRule;
var prodID, faktorID: integer;
begin
  gridSetting.ExpandAll;
  gridSetting.Clear;
  gridSetting.AutoSizeColumns(True, 10);
  gridSetting.RowCount:= 2;
  gridSetting.ColCount:= 7;
  gridSetting.ColWidths[colID       ]:= 0;
  gridSetting.ColWidths[colFakID    ]:= 0;
  gridSetting.ColWidths[colRuleModID]:= 0;

  gridSetting.ColumnSize.Stretch:= False;
  prodID  := gridProduk.Ints[colProdukID, gridProduk.Row];
  faktorID:= gridProduk.Ints[colProdFaktorID, gridProduk.Row];
  case prodID of
    PROD_POINT:
    case faktorID of
      PROD_FAK_TOTAL:
      begin
        gridSetting.Cells[colLipat,0]:= 'Nilai Kelipatan';
        gridSetting.ColWidths[colLipat]:= gridSetting.Width-16;
        gridSetting.ColWidths[1]:= 0;
        gridSetting.ColWidths[2]:= 0;
        gridSetting.ColWidths[3]:= 0;
      end;

      PROD_FAK_ITEM:
      begin
        gridSetting.Cells[colFaktor,0]:= 'Jns Point';
        gridSetting.Cells[colQtyValue,0]:= 'Nilai Kelipatan';
        gridSetting.ColWidths[colFaktor]:= 60;
        gridSetting.ColWidths[colQtyValue ]:= gridSetting.Width - 76;
        gridSetting.ColWidths[2]:= 0;
        gridSetting.ColWidths[3]:= 0;
      end;
    end;

    PROD_DISCOUNT:
    begin
      gridSetting.Cells[colDisFaktor,0]:= 'Jns Discount';
      gridSetting.Cells[colMinValue,0]:= 'N. Min/Klpt';
      gridSetting.Cells[colDisValue,0]:= 'Disc Rp';
      gridSetting.Cells[colDisPrc,0]:= 'Disc %';

      gridSetting.ColWidths[colMinValue ]:= 80;
      gridSetting.ColWidths[colDisValue ]:= 80;
      gridSetting.ColWidths[colDisPrc   ]:= 70;
      gridSetting.ColWidths[colDisFaktor]:= gridSetting.Width - 246;
    end;

    PROD_HJUAL:
    begin
      gridSetting.Cells[colQtyMin,0]:= 'Qty Min';
      gridSetting.Cells[colHrgUsed,0]:= 'Hrg Jual';
      gridSetting.ColWidths[colQtyMin]:= 60;
      gridSetting.ColWidths[colHrgUsed]:= gridSetting.Width - 76;
      gridSetting.ColWidths[2]:= 0;
      gridSetting.ColWidths[3]:= 0;

      //gridSetting.ColWidths[colID]:= 50;

    end;
  end;
end;

procedure TfrmMstProduk.gridProdukGetEditorType(Sender: TObject; ACol,
  ARow: Integer; var AEditor: TEditorType);
begin
  case ACol of
    colProduk:
    begin
      AEditor:= edComboList;
      ls.Clear;
      ls.Append(IntToStr(PROD_HJUAL)+'=HRG JUAL');
      ls.Append(IntToStr(PROD_DISCOUNT)+'=DISCOUNT');
      ls.Append(IntToStr(PROD_POINT)+'=POINT');
      NameValueListToValueList(ls, gridProduk.Combobox.Items);
    end;

    colBerlaku:
    begin
      AEditor:= edComboList;
      ls.Clear;
      ls.Append(IntToStr(PROD_PERIODE_UNLIMITED)+'=TDK BERBATAS');
      ls.Append(IntToStr(PROD_PERIODE_PERIODIK)+'=PERIODIK');
      NameValueListToValueList(ls, gridProduk.Combobox.Items);
    end;

    colProdFaktor:
    begin
      AEditor:= edComboList;
      ls.Clear;
      ls.Append(IntToStr(PROD_FAK_ITEM)+'=PER-ITEM');
      if (gridProduk.Ints[colProdukID, ARow] <> PROD_HJUAL) then
        ls.Append(IntToStr(PROD_FAK_TOTAL)+'=TOTAL');
      NameValueListToValueList(ls, gridProduk.Combobox.Items);
    end;

  end;
end;

procedure TfrmMstProduk.gridProdukCellValidate(Sender: TObject; Col,
  Row: Integer; var Value: String; var Valid: Boolean);
begin
  case Col of
    colProduk:
      gridProduk.Cells[colProdukID, Row]:= ls.Names[gridProduk.Combobox.ItemIndex];

    colBerlaku:
    begin
      gridProduk.Cells[colDari, Row]:= '';
      gridProduk.Cells[colSampai, Row]:= '';
      gridProduk.Cells[colBerlakuID, Row]:= ls.Names[gridProduk.Combobox.ItemIndex];
    end;
    colProdFaktor: begin
      gridProduk.Cells[colProdFaktorID, Row]:= ls.Names[gridProduk.Combobox.ItemIndex];
      btnLoad.Enabled:= gridProduk.Ints[colProdFaktorID, Row] = PROD_FAK_ITEM;
    end;
  end;

  gridProduk.Ints[colModID, Row]:= 1;
end;

procedure TfrmMstProduk.loadMasterProduk;
var i: integer; produk: TMysqlResult;
begin
  initGridProduk;
  produk:= TMstProduk.LoadFromDB;

  //0prod_id, 1jns_produk, 2berlaku, 3periode_awal, '+
  //4periode_akhir, 5faktor, 6aktif, 7v_produk, 8v_periode, 9v_faktor '+

  gridProduk.RowCount:= IfThen(produk.RecordCount > 0, produk.RecordCount+1, 2);
  if produk.RecordCount > 0 then
  for i:= 1 to produk.RecordCount do begin

    gridProduk.AddCheckBox(colAktv, i, BufferToInteger(produk.FieldValue(6)) = 1, false);
    getFormatCustomer(i, BufferToInteger(produk.FieldValue(0)));
    TMstProduk.getListCustomer(ls, BufferToInteger(produk.FieldValue(0)));

    gridProduk.Cells[colProduk,     i]:= produk.FieldValue(7);
    gridProduk.Cells[colProdFaktor, i]:= produk.FieldValue(9);
    gridProduk.Cells[colProdukID,   i]:= produk.FieldValue(1);
    gridProduk.Cells[colCustomerID, i]:= ls.Text;
    gridProduk.Cells[colBerlakuID,  i]:= produk.FieldValue(2);
    gridProduk.Cells[colBerlaku,    i]:= produk.FieldValue(8);
    gridProduk.Cells[colProdFaktorID, i]:= produk.FieldValue(5);
    gridProduk.Cells[colAktifID,    i]:= produk.FieldValue(6);
    gridProduk.Cells[colMasterID,   i]:= produk.FieldValue(0);
    gridProduk.Ints[colModID,       i]:= 0;

    if BufferToInteger(produk.FieldValue(2)) = PROD_PERIODE_PERIODIK then begin
       gridProduk.Dates[colDari,   i]:= BufferToDateTime(produk.FieldValue(3));
       gridProduk.Dates[colSampai, i]:= BufferToDateTime(produk.FieldValue(4));
    end else begin
       gridProduk.Cells[colDari,   i]:= '';
       gridProduk.Cells[colSampai, i]:= '';
    end;

    produk.MoveNext;
  end;
  
  produk.destroy;
end;

procedure TfrmMstProduk.Execute(id: integer);
begin
  inherited;
  ls:= TStringList.Create;
  ProdukItem:= TMstProdukItem.Create;
  loadMasterProduk;
  Run(Self);
end;

procedure TfrmMstProduk.gridProdukGetEditMask(Sender: TObject; ACol,
  ARow: Integer; var Value: String);
begin
  case ACol of
    colDari, colSampai: Value := '!99/99/00;1;_';
  end;
end;

procedure TfrmMstProduk.gridProdukCanEditCell(Sender: TObject; ARow,
  ACol: Integer; var CanEdit: Boolean);
begin
  CanEdit:=
  (ACol in[colProduk, colBerlaku, colProdFaktor])
  or
  ((ACol in[colDari, colSampai]) and (gridProduk.Ints[colBerlakuID, ARow] = PROD_PERIODE_PERIODIK))
  or
  ((ACol = colAktv) and (gridProduk.Ints[colMasterID, ARow] <> 0))
end;

procedure TfrmMstProduk.gridSettingCanEditCell(Sender: TObject; ARow,
  ACol: Integer; var CanEdit: Boolean);
var masterID, prodID, faktorID: integer;
begin
  prodID  := gridProduk.Ints[colProdukID, gridProduk.Row];
  faktorID:= gridProduk.Ints[colProdFaktorID, gridProduk.Row];
  masterID:= gridProduk.Ints[colMasterID, gridProduk.Row];
  CanEdit:= False;
  if (masterID = 0) then exit;

  case prodID of
    PROD_POINT:
      case faktorID of
        PROD_FAK_TOTAL: CanEdit:= ACol = colLipat;
        PROD_FAK_ITEM: CanEdit:= ACol in[colFaktor, colQtyValue];
      end;

    PROD_DISCOUNT:
    CanEdit:=
    (ACol in[colDisFaktor, colMinValue, colDisValue]) or
    ((ACol=colDisPrc) and (
      gridSetting.Ints[colFakID, gridProduk.Row] in[FAKTOR_MINIMAL_QTY, FAKTOR_MINIMAL_NILAI]
    ));
      //case gridSetting.Ints[colFakID, gridProduk.Row] of
      //  FAKTOR_KELIPATAN_QTY, FAKTOR_KELIPATAN_NILAI:
      //    CanEdit:= ACol in[colDisFaktor, colMinValue, colDisValue];

      //  FAKTOR_MINIMAL_QTY, FAKTOR_MINIMAL_NILAI:
      //    CanEdit:= ACol in[colDisFaktor, colMinValue, colDisValue, colDisPrc];
     // end;

    PROD_HJUAL:
      CanEdit:= ACol in[colHrgUsed, colQtyMin];
  end;
end;

procedure TfrmMstProduk.initGridProduk;
begin
  gridProduk.ClearNormalCells;
  gridProduk.ColWidths[colCustomer  ]:= 90;
  gridProduk.ColWidths[colBerlaku   ]:= 85;
  gridProduk.ColWidths[colDari      ]:= 70;
  gridProduk.ColWidths[colSampai    ]:= 70;
  gridProduk.ColWidths[colProdFaktor]:= 70;
  gridProduk.ColWidths[colAktv      ]:= 25;
  gridProduk.ColWidths[colProdukID  ]:= 0;
  gridProduk.ColWidths[colCustomerID]:= 0;
  gridProduk.ColWidths[colBerlakuID ]:= 0;
  gridProduk.ColWidths[colProdFaktorID]:= 0;
  gridProduk.ColWidths[colAktifID   ]:= 0;
  gridProduk.ColWidths[colMasterID  ]:= 0;
  gridProduk.ColWidths[colModID     ]:= 0;
  gridProduk.AddCheckBox(colAktv, 1, True, false);
  gridProduk.Ints[colAktifID,   1]:= 1;

  gridProduk.Cells[colCustomer, 1]:=
  '<p align="left"><font size="8">'+
     '<CONTROL TYPE="CHECK" WIDTH="8" ID="'+FormatSQLNumber(PROD_CUST_UNREG)+'" VALUE="FALSE"> UNREGISTER<BR>'+
     '<CONTROL TYPE="CHECK" WIDTH="8" ID="'+FormatSQLNumber(PROD_CUST_CUSTOMER)+'" VALUE="FALSE"> CUSTOMER<BR>'+
     '<CONTROL TYPE="CHECK" WIDTH="8" ID="'+FormatSQLNumber(PROD_CUST_MEMBER)+'" VALUE="FALSE"> MEMBER'+
  '</font></p>';
end;

procedure TfrmMstProduk.gridSettingGetAlignment(Sender: TObject; ARow,
  ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
var prodID, faktorID: integer;
begin
  prodID  := gridProduk.Ints[colProdukID, gridProduk.Row];
  faktorID:= gridProduk.Ints[colProdFaktorID, gridProduk.Row];

  case prodID of
    PROD_POINT:
    case faktorID of
      PROD_FAK_TOTAL: HAlign:= taRightJustify;
      PROD_FAK_ITEM:
        if ACol = colFaktor then HAlign:= taLeftJustify
        else HAlign:= taRightJustify;
    end;

    PROD_DISCOUNT:
      if ACol = colDisFaktor then HAlign:= taLeftJustify
      else HAlign:= taRightJustify;

    PROD_HJUAL: HAlign:= taRightJustify;

  end;
end;

procedure TfrmMstProduk.gridSettingGetEditorType(Sender: TObject; ACol,
  ARow: Integer; var AEditor: TEditorType);
var prodID, faktorID: integer;
begin
  prodID  := gridProduk.Ints[colProdukID, gridProduk.Row];
  faktorID:= gridProduk.Ints[colProdFaktorID, gridProduk.Row];

  case prodID of
    PROD_POINT:
    case faktorID of
      PROD_FAK_TOTAL:
        if ACol = colLipat then AEditor:= edFloat;

      PROD_FAK_ITEM:
        if ACol = colFaktor then begin
          AEditor:= edComboList;
          ls.Clear;
          ls.Append(IntToStr(FAKTOR_QTY)+'=Qty');
          ls.Append(IntToStr(FAKTOR_VALUE)+'=Nilai');

          NameValueListToValueList(ls, gridSetting.Combobox.Items);
        end
        else if ACol = colQtyValue then AEditor:= edFloat;
    end;

    PROD_DISCOUNT:
      case ACol of
        colDisFaktor:
        begin
          AEditor:= edComboList;
          ls.Clear;
          if faktorID = PROD_FAK_ITEM then begin
            ls.Append(IntToStr(FAKTOR_KELIPATAN_QTY)+'=Klipatan Qty');
            ls.Append(IntToStr(FAKTOR_KELIPATAN_NILAI)+'=Klipatan Rp');
            ls.Append(IntToStr(FAKTOR_MINIMAL_QTY)+'=Minimal Qty');
            ls.Append(IntToStr(FAKTOR_MINIMAL_NILAI)+'=Minimal Rp');
          end
          else if faktorID = PROD_FAK_TOTAL then begin
            ls.Append(IntToStr(FAKTOR_KELIPATAN_NILAI)+'=Klipatan Rp');
            ls.Append(IntToStr(FAKTOR_MINIMAL_NILAI)+'=Minimal Rp');
          end;

          NameValueListToValueList(ls, gridSetting.Combobox.Items);
        end;
        colMinValue, colDisValue, colDisPrc: AEditor:= edFloat;
      end;

    PROD_HJUAL:
      if ACol = colQtyMin then AEditor:= edFloat
      else if ACol = colHrgUsed then begin
        AEditor:= edComboList;
        ls.Clear;
        ls.Append(IntToStr(FAKTOR_HRG1)+'=H.JUAL 1');
        ls.Append(IntToStr(FAKTOR_HRG2)+'=H.JUAL 2');
      //  ls.Append(IntToStr(FAKTOR_HRG3)+'=H.JUAL 3');
        NameValueListToValueList(ls, gridSetting.Combobox.Items);
      end;
  end;
end;

procedure TfrmMstProduk.gridSettingCellValidate(Sender: TObject; Col,
  Row: Integer; var Value: String; var Valid: Boolean);
var prodID, faktorID: integer;
begin
  prodID  := gridProduk.Ints[colProdukID, gridProduk.Row];
  faktorID:= gridProduk.Ints[colProdFaktorID, gridProduk.Row];

  case prodID of
    PROD_POINT:
      case faktorID of
        PROD_FAK_TOTAL:
        begin
          if Col = colLipat then Value:= FloatToStrFmt(StrFmtToFloatDef(Value,0));
          gridSetting.Ints[colFakID, Row]:= FAKTOR_VALUE;

        end;
        PROD_FAK_ITEM:
          if Col = colQtyValue then Value:= FloatToStrFmt(StrFmtToFloatDef(Value,0))
          else if Col = colFaktor then
            gridSetting.Cells[colFakID, Row]:= ls.Names[gridSetting.Combobox.ItemIndex];
      end;

    PROD_DISCOUNT:
      case Col of
        colMinValue, colDisValue, colDisPrc: Value:= FloatToStrFmt(StrFmtToFloatDef(Value,0));
        colDisFaktor: gridSetting.Cells[colFakID, Row]:= ls.Names[gridSetting.Combobox.ItemIndex];
      end;

    PROD_HJUAL:
      if Col = colQtyMin then Value:= FloatToStrFmt(StrFmtToFloatDef(Value,0))
      else if Col = colHrgUsed then
        gridSetting.Cells[colFakID, Row]:= ls.Names[gridSetting.Combobox.ItemIndex];
  end;
  gridSetting.Ints[colRuleModID, Row]:= 1;
end;

procedure TfrmMstProduk.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  if ls <> nil then ls.Free; ls:= nil;
  if ProdukItem <> nil then ProdukItem.Free; ProdukItem:= nil;
end;

procedure TfrmMstProduk.gridProdukGetAlignment(Sender: TObject; ARow,
  ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  if ACol = colAktv then HAlign:= taCenter
end;

procedure TfrmMstProduk.loadProdukRule;
var i,masterID, prodID,faktorID: integer; rule: TMysqlResult;
begin
  initGridRule;
  prodID:= gridProduk.Ints[colProdukID, gridProduk.Row];
  faktorID:= gridProduk.Ints[colProdFaktorID, gridProduk.Row];
  masterID:= gridProduk.Ints[colMasterID, gridProduk.Row];

  if masterID = 0 then exit;

  rule:= TMstProdukRule.LoaddFromDB(masterID);
  gridSetting.RowCount:= IfThen(rule.RecordCount > 0, rule.RecordCount+1, 2);
  if rule.RecordCount > 0 then
  for i:= 1 to rule.RecordCount do begin
     gridSetting.Ints[colID, i]:= BufferToInteger(rule.FieldValue(0));
     gridSetting.Ints[colFakID, i]:= BufferToInteger(rule.FieldValue(1));
     gridSetting.Ints[colRuleModID, i]:= 0;

//====================
    case prodID of
      PROD_POINT:
      case faktorID of
        PROD_FAK_TOTAL:
           gridSetting.Cells[colLipat,i]:= FloatToStrFmt(BufferToFloat(rule.FieldValue(3)));

        PROD_FAK_ITEM:
        begin
          gridSetting.Cells[colQtyValue,i]:= FloatToStrFmt(BufferToFloat(rule.FieldValue(3)));
          if (BufferToInteger(rule.FieldValue(1)) = FAKTOR_VALUE) then
             gridSetting.Cells[colFaktor,i]:= 'Nilai'
          else if (BufferToInteger(rule.FieldValue(1)) = FAKTOR_QTY) then
             gridSetting.Cells[colFaktor,i]:= 'Qty';
        end;
      end;

      PROD_DISCOUNT:
      begin
        gridSetting.Cells[colMinValue,i]:= FloatToStrFmt(BufferToFloat(rule.FieldValue(2)));
        gridSetting.Cells[colDisValue,i]:= FloatToStrFmt(BufferToFloat(rule.FieldValue(3)));
        gridSetting.Cells[colDisPrc,i]:= FloatToStrFmt(BufferToFloat(rule.FieldValue(4)));
        case bufferToInteger(rule.FieldValue(1)) of
          FAKTOR_KELIPATAN_QTY: gridSetting.Cells[colDisFaktor,i]:= 'Klipatan Qty';
          FAKTOR_KELIPATAN_NILAI: gridSetting.Cells[colDisFaktor,i]:= 'Klipatan Rp';
          FAKTOR_MINIMAL_QTY: gridSetting.Cells[colDisFaktor,i]:= 'Minimal Qty';
          FAKTOR_MINIMAL_NILAI: gridSetting.Cells[colDisFaktor,i]:= 'Minimal Rp';
        end;
      end;

      PROD_HJUAL:
      begin
        gridSetting.Cells[colQtyMin,i]:= FloatToStrFmt(BufferToFloat(rule.FieldValue(2)));
        if (BufferToInteger(rule.FieldValue(1)) = FAKTOR_HRG1) then
           gridSetting.Cells[colHrgUsed,i]:= 'H.JUAL 1'
        else if (BufferToInteger(rule.FieldValue(1)) = FAKTOR_HRG2) then
           gridSetting.Cells[colHrgUsed,i]:= 'H.JUAL 2'
        else if (BufferToInteger(rule.FieldValue(1)) = FAKTOR_HRG3) then
           gridSetting.Cells[colHrgUsed,i]:= 'H.JUAL 3';
      end;
    end;
//====================
    rule.MoveNext;
  end;
  rule.Destroy;
//  gridSetting.AutoSizeColumns(true,5);
end;

procedure TfrmMstProduk.gridProdukClickCell(Sender: TObject; ARow,
  ACol: Integer);
begin
  if ACol = colProduk then begin
    loadProdukRule;
    gridSettingClickCell(gridSetting, 1, 0);
  end;
end;

function TfrmMstProduk.saveMasterProduk: boolean;
var i: integer; MstProduk: TMstProduk;
begin
  Result:= False;
  MstProduk:= TMstProduk.Create;
  for i:= 1 to gridProduk.RowCount-1 do begin
    if gridProduk.Ints[colModID, i] <> 0 then begin
       if not ValidMasterProduk(i) then
       Continue;
       MstProduk.Reset;
       MstProduk.ProdukID    := gridProduk.Ints[colMasterID, i];
       MstProduk.JnsProduk   := gridProduk.Ints[colProdukID, i];
       MstProduk.Berlaku     := gridProduk.Ints[colBerlakuID, i];
       MstProduk.PeriodeAwal := StrToDateDef(gridProduk.Cells[colDari,i],0);
       MstProduk.PeriodeAkhir:= StrToDateDef(gridProduk.Cells[colsampai,i],0);
       MstProduk.Faktor      := gridProduk.Ints[colProdFaktorID, i];
       MstProduk.Aktif       := gridProduk.Ints[colAktifID, i];
       ls.Text:= gridProduk.Cells[colCustomerID, i];
       if MstProduk.ProdukID <> 0 then Result:= MstProduk.UpdateOnDB(ls)
       else Result:= MstProduk.InsertOnDB(ls);
    end;
  end;
  loadMasterProduk;
end;

procedure TfrmMstProduk.gridProdukEnter(Sender: TObject);
begin
  state_edit:= st_edit_master;
end;

procedure TfrmMstProduk.gridSettingEnter(Sender: TObject);
begin
  state_edit:= st_edit_rule;
end;

procedure TfrmMstProduk.btnNewClick(Sender: TObject);
begin
  case state_edit of
    st_edit_master:
    begin
      if gridProduk.Ints[colProdukID, gridProduk.RowCount-1] <> 0 then
        gridProduk.AddRow;
      gridProduk.Row:= gridProduk.RowCount-1;
      gridProduk.Col:= colProduk;
      gridProduk.AddCheckBox(colAktv, gridProduk.RowCount-1, True, false);
      gridProduk.Ints[colAktifID, gridProduk.RowCount-1]:= 1;
      getFormatCustomer(gridProduk.RowCount-1, 0);
    end;

    st_edit_rule:
    begin
      if gridSetting.Ints[colFakID, gridSetting.RowCount-1] <> 0 then
        gridSetting.AddRow;
      gridSetting.Row:= gridSetting.RowCount-1;
      gridSetting.Col:= 0;
    end;
  end;
end;

procedure TfrmMstProduk.btnDeleteClick(Sender: TObject);
begin
  case state_edit of
    st_edit_master:
    begin
      if Confirmed('Hapus data?') then
      if TMstProduk.DeleteFromDB(gridProduk.Ints[colMasterID, gridProduk.Row]) then begin
         gridProduk.ClearRows(gridProduk.Row, 1);
         if gridProduk.RowCount > 2 then
            gridProduk.RemoveRows(gridProduk.Row, 1);
      end;
    end;
    st_edit_rule:
    begin
      if Confirmed('Hapus data?') then
      if TMstProdukRule.DeleteFromDB(gridSetting.Ints[colID, gridSetting.Row]) then begin
         gridSetting.ClearRows(gridSetting.Row, 1);
         if gridSetting.RowCount > 2 then
            gridSetting.RemoveRows(gridSetting.Row, 1);
      end;
    end;
  end;
end;

procedure TfrmMstProduk.btnSaveClick(Sender: TObject);
begin
  case state_edit of
    st_edit_master: saveMasterProduk;
    st_edit_rule: saveRuleProduk;
  end;
end;

function TfrmMstProduk.saveRuleProduk: boolean;
var i,prodID, faktorID, masterID: integer; MstProduk: TMstProdukRule;
begin
  prodID  := gridProduk.Ints[colProdukID, gridProduk.Row];
  faktorID:= gridProduk.Ints[colProdFaktorID, gridProduk.Row];
  masterID:= gridProduk.Ints[colMasterID, gridProduk.Row];

  Result:= False;
  MstProduk:= TMstProdukRule.Create;
  for i:= 1 to gridSetting.RowCount-1 do begin
    if gridSetting.Ints[colRuleModID, i] <> 0 then begin
       MstProduk.Reset;
       MstProduk.ProdukID:= masterID;
       MstProduk.RuleID  := gridSetting.Ints[colID, i];
       MstProduk.FaktorID:= gridSetting.Ints[colFakID, i];

       case prodID of
          PROD_POINT:
            case faktorID of
              PROD_FAK_TOTAL: MstProduk.Nilai:= gridSetting.Floats[colLipat, i];
              PROD_FAK_ITEM : MstProduk.Nilai:= gridSetting.Floats[colQtyValue, i];
            end;

          PROD_DISCOUNT:
          begin
            MstProduk.BatasMinimal:= gridSetting.Floats[colMinValue, i];
            MstProduk.Nilai  := gridSetting.Floats[colDisValue, i];
            MstProduk.DiscPrc:= gridSetting.Floats[colDisPrc, i];
          end;

          PROD_HJUAL:
          begin
            MstProduk.BatasMinimal:= gridSetting.Floats[colQtyMin, i];
            MstProduk.Nilai       := gridSetting.Floats[colQtyMin, i];
          end;
        end;

       if MstProduk.RuleID <> 0 then Result:= MstProduk.UpdateOnDB
       else Result:= MstProduk.InsertOnDB;
    end;
  end;
  loadProdukRule;
  gridProduk.Repaint;
end;

procedure TfrmMstProduk.gridProdukCheckBoxClick(Sender: TObject; ACol,
  ARow: Integer; State: Boolean);
begin
  gridProduk.Ints[colAktifID, ARow]:= IfThen(State, 1, 0);
  gridProduk.Ints[colModID,   ARow]:= 1;
end;

procedure TfrmMstProduk.gridProdukControlClick(Sender: TObject; ARow,
  ACol: Integer; CtrlID, CtrlType, CtrlVal: String);
var idx: integer;
begin
  gridProduk.Ints[colModID, ARow]:= 1;
  ls.Text:= gridProduk.Cells[colCustomerID, ARow];
  idx:= ls.IndexOf(CtrlID);
  if (idx <> -1) then ls.Delete(idx)
  else ls.Append(CtrlID);
  gridProduk.Cells[colCustomerID, ARow]:= ls.Text;
end;

procedure TfrmMstProduk.getFormatCustomer(row, id: integer);
begin
  gridProduk.Cells[colCustomer, row]:=
  '<p align="left"><font size="8">'+
     '<CONTROL TYPE="CHECK" WIDTH="8" ID="'+FormatSQLNumber(PROD_CUST_UNREG)+'" '+
       'VALUE="'+TMstProduk.getProdukCustomer(id,PROD_CUST_UNREG)+'"> UNREGISTER<BR>'+
     '<CONTROL TYPE="CHECK" WIDTH="8" ID="'+FormatSQLNumber(PROD_CUST_CUSTOMER)+'" '+
       'VALUE="'+TMstProduk.getProdukCustomer(id,PROD_CUST_CUSTOMER)+'"> CUSTOMER<BR>'+
     '<CONTROL TYPE="CHECK" WIDTH="8" ID="'+FormatSQLNumber(PROD_CUST_MEMBER)+'" '+
       'VALUE="'+TMstProduk.getProdukCustomer(id,PROD_CUST_MEMBER)+'"> MEMBER'+
  '</font></p>';
end;

procedure TfrmMstProduk.Button1Click(Sender: TObject);
var ID: integer;
begin
  ID:= frmMstCodeList.Execute(1);
  if ID <> 0 then begin
    txtSpec.Tag := ID;
    txtSpec.Text:= TMstCode.getName(ID);
  end;
end;

procedure TfrmMstProduk.Button2Click(Sender: TObject);
var id: integer;
begin
  id:= frmLookup.Execute('SPL');
  if Id > 0 then begin
    txtVc.Text:= TMstRelation.GetName(id);
    txtVc.Tag:= id;
  end;
end;

procedure TfrmMstProduk.LoadItemAvailable;
var i,j: integer; item: TMysqlResult;
begin
  try
    StartProgress;
    SetFilter;
    item:= TMstProduk.getItemUnsetted(gridSetting.Ints[colID, gridSetting.Row]);
    gridUnsetted.ColWidths[0]:= 0;
    gridUnsetted.ColWidths[2]:= 1;
    gridUnsetted.ClearNormalCells;
    gridUnsetted.RowCount:= IfThen(item.RecordCount > 0, item.RecordCount, 1);

    for i:= 0 to item.RecordCount-1 do begin
      ProsesProgress(i,item.RecordCount);
      for j:= 0 to item.FieldsCount-1 do
        gridUnsetted.Cells[j, i]:= item.FieldValue(j);
      item.MoveNext;
    end;
    item.destroy;
  finally
    EndProgress;
  end;
end;

procedure TfrmMstProduk.SetFilter;
begin
  GlobalFilter.SpecID  := txtSpec.Tag;
  GlobalFilter.RelasiID:= txtVc.Tag;
  GlobalFilter.SeriesID:= txtProdusen.Tag;
  GlobalFilter.FString1:= txtCode.Text;
  GlobalFilter.Name    := txtProdusen.Text; //ama
  GlobalFilter.FString2:= txtMerk.Text; //kode
end;

procedure TfrmMstProduk.btnLoadClick(Sender: TObject);
begin
  LoadItemAvailable
end;

procedure TfrmMstProduk.addAllItem;
var i, counter:integer;
begin
  counter:= gridUnsetted.RowCount-1;
  for i:= 0 to counter do addItem(0);
end;

procedure TfrmMstProduk.addItem(row: integer);
begin
  if gridSetting.Ints[colID, gridSetting.Row] = 0 then exit;
  if gridUnsetted.Ints[0, row] = 0 then exit;
  ProdukItem.Reset;
  ProdukItem.ItemID:= gridUnsetted.Ints[0, row];
  ProdukItem.RuleID:= gridSetting.Ints[colID, gridSetting.Row];

  if ProdukItem.InsertOnDB then begin
    if gridSetted.Ints[0, gridSetted.RowCount-1] <> 0 then
      gridSetted.AddRow;
    gridSetted.Ints[0, gridSetted.RowCount-1]:= ProdukItem.ItemID;
    gridSetted.Ints[1, gridSetted.RowCount-1]:= ProdukItem.ProdItemID;
    gridSetted.Cells[2,gridSetted.RowCount-1]:= gridUnsetted.Cells[1, row];
    deleteRow(gridUnsetted, row);
  end;
end;

procedure TfrmMstProduk.reMoveAllItem;
var i, counter:integer;
begin
  counter:= gridSetted.RowCount-1;
  for i:= 0 to counter do reMoveItem(0);
end;

procedure TfrmMstProduk.reMoveItem(row: integer);
begin
  if gridSetted.Ints[0, row] = 0 then exit;
  ProdukItem.ProdItemID:= gridSetted.Ints[1, row];
  if ProdukItem.DeleteOnDB() then begin
    if gridUnsetted.Ints[0, gridUnsetted.RowCount-1] <> 0 then
      gridUnsetted.AddRow;
    gridUnsetted.Ints[0, gridUnsetted.RowCount-1]:= gridSetted.Ints[0, row];
    gridUnsetted.Cells[1,gridUnsetted.RowCount-1]:= gridSetted.Cells[2, row];
    deleteRow(gridSetted, row);
  end;
end;

procedure TfrmMstProduk.deleteRow(grid: TAdvStringGrid; row: integer);
begin
  grid.ClearRows(row,1);
  if grid.RowCount > 1 then grid.RemoveRows(row,1);
end;

procedure TfrmMstProduk.SpeedButton1Click(Sender: TObject);
begin
  addItem(gridUnsetted.Row);
end;

procedure TfrmMstProduk.SpeedButton3Click(Sender: TObject);
begin
  reMoveItem(gridSetted.Row);
end;

procedure TfrmMstProduk.SpeedButton2Click(Sender: TObject);
begin
  addAllItem
end;

procedure TfrmMstProduk.SpeedButton4Click(Sender: TObject);
begin
  reMoveAllItem
end;

procedure TfrmMstProduk.LoadProdukItem;
var i,j: integer; item: TMysqlResult;
begin
  gridSetted.ColWidths[0]:= 0;
  gridSetted.ColWidths[1]:= 0;
  gridSetted.ColWidths[3]:= 1;
  gridSetted.ClearNormalCells;
  gridSetted.RowCount:= 1;
  if (gridSetting.Ints[colID, gridSetting.Row] = 0) then exit;
  try
    StartProgress;
    item:= TMstProduk.LoadProdukItem(gridSetting.Ints[colID, gridSetting.Row]);
    gridSetted.RowCount:= IfThen(item.RecordCount > 0, item.RecordCount, 1);
    for i:= 0 to item.RecordCount-1 do begin
      ProsesProgress(i,item.RecordCount);
      for j:= 0 to item.FieldsCount-1 do
        gridSetted.Cells[j, i]:= item.FieldValue(j);
      item.MoveNext;
    end;
    item.destroy;
  finally
    EndProgress;
  end;

end;

procedure TfrmMstProduk.gridSettingClickCell(Sender: TObject; ARow,
  ACol: Integer);
begin
  if ACol = 0 then LoadProdukItem;
   btnLoad.Enabled:= gridProduk.Ints[colProdFaktorID, gridProduk.Row] = PROD_FAK_ITEM;

 //Label2.Caption:= gridSetting.Cells[colID, gridSetting.Row];
 //gridSetting.ColWidths[colID]:= 130;  
end;

function TfrmMstProduk.ValidMasterProduk(row: integer): boolean;
begin
  if CekInput(Result, gridProduk.Ints[colProdukID, row] <> 0, 'Jenis Produk belum diisi.',gridProduk) then
  if CekInput(Result, gridProduk.Ints[colBerlakuID, row] <> 0, 'Berlaku belum diisi.',gridProduk) then
  if CekInput(Result, gridProduk.Cells[colCustomerID, row] <> '', 'Jns Customer belum diisi.',gridProduk) then
  CekInput(Result, gridProduk.Ints[colProdFaktorID, row] <> 0, 'Faktor belum diisi.',gridProduk)
end;

procedure TfrmMstProduk.gridProdukGetCellColor(Sender: TObject; ARow,
  ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin
  if (gridProduk.Ints[colModID, ARow] = 1) and (ARow > 0) then
    AFont.Color:= clRed
  else if (gridProduk.Ints[colModID, ARow] = 0) and (ARow > 0) then
    AFont.Color:= clLabel;
end;

procedure TfrmMstProduk.gridSettingGetCellColor(Sender: TObject; ARow,
  ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin
   if (gridSetting.Ints[colRuleModID, ARow] = 1) and (ARow > 0) then
    AFont.Color:= clRed
  else if (gridSetting.Ints[colRuleModID, ARow] = 0) and (ARow > 0) then
    AFont.Color:= clLabel;
end;

end.
