unit MstItem;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, AdvEdit, ComCtrls, ToolWin, Grids, BaseGrid, AdvGrid,
  strUtils, Math, UMaster, WinXP, ExtCtrls, dateutils, Menus;

type
  TfrmMstItem = class(TForm)
    txtCode: TAdvEdit;
    txtName: TAdvEdit;
    txtSpec: TAdvEdit;
    WinXP1: TWinXP;
    btnSpec: TButton;
    txtStruk: TAdvEdit;
    txtBarcode: TAdvEdit;
    txtMerk: TAdvEdit;
    dtpExpire: TDateTimePicker;
    Label1: TLabel;
    txtJenis: TAdvEdit;
    btnJenis: TButton;
    PopupMenu1: TPopupMenu;
    New1: TMenuItem;
    Save1: TMenuItem;
    txtUnit: TAdvEdit;
    btnKemasan: TButton;
    txtHarga: TAdvEdit;
    ToolBar1: TToolBar;
    tbtNew: TToolButton;
    tbtSave: TToolButton;
    ToolButton2: TToolButton;
    rbKategori: TRadioGroup;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure asgConversionCanEditCell(Sender: TObject; ARow,
      ACol: Integer; var CanEdit: Boolean);
    procedure tbtNewClick(Sender: TObject);
    procedure txtCodeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnSpecClick(Sender: TObject);
    procedure txtBarcodeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure txtStrukKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnVendorClick(Sender: TObject);
    procedure txtNameChange(Sender: TObject);
    procedure txtBarcodeEnter(Sender: TObject);
    procedure txtSpecEnter(Sender: TObject);
    procedure txtVendorEnter(Sender: TObject);
    procedure txtProdusenEnter(Sender: TObject);
    procedure txtSpecKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure txtNameKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure txtKemasanEnter(Sender: TObject);
    procedure btnKemasClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure txtAvgPriceValueValidate(Sender: TObject; value: String;
      var IsValid: Boolean);
    procedure txtAvgPriceKeyPress(Sender: TObject; var Key: Char);
    procedure gridRakCanEditCell(Sender: TObject; ARow, ACol: Integer;
      var CanEdit: Boolean);
    procedure gridRakCellValidate(Sender: TObject; Col, Row: Integer;
      var Value: String; var Valid: Boolean);
    procedure gridRakEnter(Sender: TObject);
    procedure gridRakKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure txtCodeKeyPress(Sender: TObject; var Key: Char);
    procedure gridHistoriGetAlignment(Sender: TObject; ARow, ACol: Integer;
      var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure gridStokGetAlignment(Sender: TObject; ARow,
      ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure btnNewClick(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure btnJenisClick(Sender: TObject);
    procedure txtJenisEnter(Sender: TObject);
    procedure dtpExpireKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure New1Click(Sender: TObject);
    procedure Save1Click(Sender: TObject);
    procedure txtAvgPriceChange(Sender: TObject);
    procedure txtUnitEnter(Sender: TObject);
    procedure btnKemasanClick(Sender: TObject);
    procedure tbtSaveClick(Sender: TObject);
  private
    MstItem: TMstItem;
    MstUnit: TMstMaster;
    lsFaktor: TStringList;
    lookup_state: integer;
    //histori_showed: boolean;
    Purpose : integer;
    procedure InitGrid;
    procedure ArrangeColsize;
    procedure setEnableDisabled;
    procedure getUnit(AUnitId:integer; kode: string);
    procedure getRak(ARakId,ARow: integer; var kode: string);

    function  getVendor(ACode: string; AID: integer): boolean;
//    function  getKemasan(ACode: string; AID: integer): boolean;
    function  getJenis(ACode: string; AID: integer): boolean;
    procedure ShowHistories;
    procedure getSpec();
    procedure lookupHeader();
    procedure lookupUnit();//kemasan
    procedure lookupRak();
    procedure ResetData;
    procedure InitForm;
    procedure LoadData(id: integer);
    procedure CalculatePrice;
    function isSaved: boolean;
    function isValid: boolean;

  public
    procedure Execute(APurpose:integer;id: integer);
  end;

var
  frmMstItem: TfrmMstItem;

implementation

uses UConstTool, Subroutines, MainMenu,
  UConst, LookupData, uMysqlClient, MySQLConnector,
  UTransaction, MstCodeList;

const
  colName     = 1;
  colPurchase = 2;
  colDisc     = 3;
  colTax      = 4;
  colNet      = 5;
  colCost     = 6; //margin I
  colSales    = 7;
  colCost2    = 8; //margin II
  colSales2   = 9;
  colConv     = 10;
  colConvId   = 11;
  colUnitId   = 12;
  colDiscTmp  = 13;
  colDiscTipe = 14;

  look_spec = 1;
  look_spl  = 2;
  look_prod = 3;
  look_kemasan = 4;
  look_rak = 5;
  look_jenis = 6;


 { colBawah     = 1;
  colAtas      = 2;
  colSat       = 3;
  colValue     = 4;
  colFaktor    = 5;
  colFaktorID  = 6;
  colSettID    = 7;
  colSetConvID = 8;        }

{$R *.dfm}

procedure TfrmMstItem.ArrangeColsize;
begin
  
end;

procedure TfrmMstItem.Execute(APurpose:integer;id: integer);
begin
  Purpose := APurpose;
  lsFaktor:= TStringList.Create;
  MstItem := TMstItem.Create;
  MstUnit := TMstMaster.Create;
  InitForm;
  //histori_showed:= False;
  if (id <> 0) then LoadData(id);
  Run(Self);
  lsFaktor.Destroy;
end;

procedure TfrmMstItem.InitForm;
begin
  ResetData;
  Self.Caption:= 'Data Barang';
end;

procedure TfrmMstItem.InitGrid;
begin

  ArrangeColsize;
end;

function TfrmMstItem.isSaved: boolean;
var i, idx: integer;
begin
  MstItem.Clear;
  MstItem.ItemId:= txtCode.Tag;
  MstItem.MstCode.CodeId:= txtSpec.Tag;
  MstItem.ItemCode  := txtCode.Text;
  MstItem.Barcode   := txtBarcode.Text;
  MstItem.ItemName  := txtName.Text;
  MstItem.StrukName := txtStruk.Text;
  MstItem.Merk      := txtMerk.Text;
  MstItem.ExpireDate := dtpExpire.Date;
  MstItem.Kategori   := rbKategori.ItemIndex;// txtJenis.Tag;
  MstItem.KemasanID := txtUnit.Tag;
  if purpose = 1 then
    MstItem.BuyingPrice := StrFmtToFloatDef(txtHarga.Text,0);
  if purpose = 2 then
    MstItem.SellingPrice := StrFmtToFloatDef(txtHarga.Text,0);  
   {
  for i:= 0 to gridRak.RowCount-1 do
    if (not IsClear(gridRak, 1, i)) then
      MstItem.FRak.Add(gridRak.Ints[1,i], 0);
    }
  if txtCode.Tag <> 0 then Result:= MstItem.UpdateOnDB()
  else Result:= MstItem.InsertOnDB;
  tbtSave.Enabled:= not Result;

  if Result then LoadData(MstItem.ItemID);

end;

function TfrmMstItem.isValid: boolean;
  {
  function cek_nilai: boolean;
  var i: integer;
  begin
    Result:= False;
    for i:= 1 to asgConversion.RowCount-1 do
      if (not IsClear(asgConversion, colUnitId, i))then begin
        Result:= asgConversion.Floats[colConv, i] > 0;
        if not Result then begin
          asgConversion.Row:= i;
          asgConversion.Col:= colConv;
          Exit;
        end;
      end;
  end;

  function cek_hrg_dasar: boolean;
  var hrg_dasar: double;
  begin
    hrg_dasar:= asgConversion.Floats[colNet, 1];
    Result:=
      (hrg_dasar <= asgConversion.Floats[colSales, 1]) and
      ((hrg_dasar <= asgConversion.Floats[colSales2,1]) or (asgConversion.Floats[colSales2,1] = 0))
  end;
         }
begin
//  if CekInput(Result, txtBarcode.Text <> '', 'Barcode belum diisi.', txtBarcode) then
  if CekInput(Result, txtName.Text <> '', 'Nama belum diisi.', txtName) then
  if CekInput(Result, txtSpec.Tag <> 0, 'Spesifikasi belum diisi.', txtSpec) then
  if CekInput(Result, ((not MstItem.isExistInDb(txtCode.Text)) and (txtCode.Tag = 0)) or (txtCode.Tag <> 0), 'Kode Sudah ada.', txtCode) then
  //if CekInput(Result, ((not MstItem.isExistBarcode(txtBarcode.Text)) and (txtCode.Tag = 0)) or (txtCode.Tag <> 0), 'Barcode Sudah ada.', txtBarcode) then
  if CekInput(Result, ((not MstItem.isExistName(txtName.Text)) and (txtCode.Tag = 0)) or (txtCode.Tag <> 0), 'Nama Item Sudah ada.', txtBarcode) then
//  if CekInput(Result, cek_nilai, 'Nilai konversi tidak boleh 0.', asgConversion) then
  //   CekInput(Result, cek_hrg_dasar, 'Hrg Bersih < Hrg Beli.', asgConversion)
end;

procedure TfrmMstItem.LoadData(id: integer);
var i: integer;
begin
  MstItem.ItemID:= id;
  MstItem.SelectInDB2;
  txtSpec.Tag  := MstItem.MstCode.CodeId;
  txtCode.Tag  := MstItem.ItemId;
  txtSpec.Text := MstItem.MstCode.CodeName;
  txtCode.Text := MstItem.ItemCode;
  txtName.Text := MstItem.ItemName;
  txtStruk.Text:= MstItem.StrukName;
  txtMerk.Text := MstItem.Merk;
  txtBarcode.Text := MstItem.Barcode;
  dtpExpire.Date:= dtpExpire.Date;
  rbKategori.ItemIndex := MstItem.Kategori;
  txtJenis.Tag:= MstItem.Kategori;
  txtJenis.Text:= TMstMaster.getJenis(MstItem.Kategori);
  txtUnit.Text := TMstMaster.getKode(MstItem.KemasanID);
  txtUnit.Tag := MstItem.KemasanID;
  txtHarga.Text := FloatToStrFmt(IfThen(Purpose=1,MstItem.BuyingPrice, MstItem.SellingPrice));
  setEnableDisabled;
  ArrangeColsize;
{  gridRak.RowCount:= IfThen(MstItem.FRak.Count=0, 1, MstItem.FRak.Count);
  for i:= 0 to MstItem.FRak.Count -1 do begin
    gridRak.Ints[1, i]:= MstItem.FRak[i].RakID;
    gridRak.Cells[0, i]:= TMstCode.getRakName(MstItem.FRak[i].RakID);
  end;
 }

  tbtSave.Enabled:= False;
end;

procedure TfrmMstItem.ResetData;
begin
  InitGrid;
  txtCode.Clear;
  txtSpec.Clear;
  txtName.Clear;
  txtStruk.Clear;
  txtMerk.Clear;
  txtUnit.Clear;
  txtUnit.Tag :=0;
  txtBarcode.Clear;
  txtCode.Tag:= 0;
  txtSpec.Tag:= 0;
  txtJenis.Clear;
  txtJenis.Tag:= 0;
  rbKategori.ItemIndex := 0;
  dtpExpire.Date:= ServerNow;
  txtCode.Text := MstItem.GetNextCode(0);
  tbtSave.Enabled:= True;
  txtHarga.Visible := (Purpose in [1,2]);
  txtHarga.LabelCaption := IfThen(Purpose=1,'H.Beli','H.Jual');
  setEnableDisabled;
end;

procedure TfrmMstItem.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  MstItem.Free;
  MstUnit.Free;
  //Action := caFree;
  reAssignLastControl
end;

procedure TfrmMstItem.asgConversionCanEditCell(Sender: TObject; ARow,
  ACol: Integer; var CanEdit: Boolean);
begin
//"NOT" bisa nyababkn asldjflk
  CanEdit:=
  (ACol in[colName, colPurchase, colDisc, colSales, {colSales2, colCost2,} colCost, colTax])
  or ((ACol=colConv) and (ARow > 1));
end;

procedure TfrmMstItem.getUnit(AUnitId:integer; kode: string);
begin
  MstUnit.Reset;
  MstUnit.MstId  := AUnitId;
  MstUnit.MstCode:= kode;
  MstUnit.MstTipe:= MST_TYPE_UNIT;

  if MstUnit.SelectInDB then begin
   // kode:= UpperCase(MstUnit.MstCode);
     txtUnit.Text := MstUnit.MstCode;
     txtUnit.Tag := MstUnit.MstID;
  end
  else begin
    txtUnit.Clear;
    txtUnit.Tag := 0;
    Inform('Satuan tidak ditemukan.');
  end;
  ArrangeColSize;
end;

procedure TfrmMstItem.tbtNewClick(Sender: TObject);
var tag : integer;
begin
  tag := 210;
 if not TSystemAccess.isCan(CAN_ADD,AktiveControl.Tag) then exit;
  ResetData;
//  if txtCode.Visible then
  //  txtCode.SetFocus;
end;

procedure TfrmMstItem.txtCodeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = vk_return then btnSpec.Click
end;

procedure TfrmMstItem.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose:= True;
  
end;

procedure TfrmMstItem.btnSpecClick(Sender: TObject);
begin
  getSpec
end;

procedure TfrmMstItem.txtBarcodeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = vk_tab then begin
    if txtCode.Tag = 0 then
      if txtCode.Text = '' then
        txtCode.Text:= txtBarcode.Text;
  end;
  if key = VK_F2 then begin
    txtBarcode.Text:= txtCode.Text;
    txtBarcode.SelStart:= length(txtCode.Text);
  end;
end;

procedure TfrmMstItem.lookupUnit;
var id: integer; kode: string;
begin
  kode:= '';
  id:= frmLookup.Execute('SAT');
  if Id > 0 then getUnit(id,'');
  tbtSave.Enabled:= True;
end;

procedure TfrmMstItem.txtStrukKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_F2 then begin
    txtStruk.Text:= txtName.Text;
    txtStruk.SelStart:= length(txtStruk.Text);
  end;
end;

procedure TfrmMstItem.btnVendorClick(Sender: TObject);
var id: integer;
begin
  id:= frmLookup.Execute('SPL');
  if Id > 0 then getVendor('', id);
  tbtSave.Enabled:= True;
end;

function TfrmMstItem.getVendor(ACode: string; AID: integer): boolean;
begin
end;

procedure TfrmMstItem.txtNameChange(Sender: TObject);
var sudah_enabled: boolean;
begin
  sudah_enabled:= tbtSave.Enabled;
  if not sudah_enabled then
    tbtSave.Enabled:= (Sender as TAdvEdit).Modified;
end;

procedure TfrmMstItem.getSpec;
var ID: integer;
begin
  ID:= frmMstCodeList.Execute(1);
  if ID <> 0 then begin
    txtSpec.Tag := ID;
    txtSpec.Text:= TMstCode.getName(ID);
    txtMerk.SetFocus;
//    txtCode.Text:= TMstItem.GetNextCode(ID);
  //  txtBarcode.Text:= txtCode.Text; 
    tbtSave.Enabled:= True;
  end;
end;

procedure TfrmMstItem.txtBarcodeEnter(Sender: TObject);
begin
  lookup_state:= 0;
end;

procedure TfrmMstItem.txtSpecEnter(Sender: TObject);
begin
  lookup_state:= look_spec;
end;

procedure TfrmMstItem.txtVendorEnter(Sender: TObject);
begin
  lookup_state:= look_spl;
end;

procedure TfrmMstItem.txtProdusenEnter(Sender: TObject);
begin
  lookup_state:= look_prod;
end;

procedure TfrmMstItem.txtSpecKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var berhasil: boolean;
begin
  if (Purpose<>0) then exit;
  case key of
    VK_F2: lookupHeader;
    VK_RETURN:
    begin
      berhasil:= True;
      case lookup_state of

        look_jenis:
          if (Sender as TAdvEdit).Modified then
            berhasil:= getJenis(txtJenis.Text,0);
        look_kemasan:
          if (Sender as TAdvEdit).Modified then
             getUnit(0,txtUnit.Text);

      end;
      if (not (Sender as TAdvEdit).Modified) or berhasil then
        GoNextControl(Self, (Sender as TWinControl), true, true, false).SetFocus;
    end;
  end;
end;

procedure TfrmMstItem.lookupHeader;
begin
  case lookup_state of
    look_spec: getSpec;
    look_jenis: btnJenis.Click;
    look_kemasan : lookupUnit ;//getUnit(0,'');
  end;
end;

procedure TfrmMstItem.txtNameKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_F2 then begin
    txtName.Text:= txtMerk.Text;
    txtName.SelStart:= length(txtName.Text);
  end;
end;

{function TfrmMstItem.getKemasan(ACode: string; AID: integer): boolean;
var Data: TMstMaster;
begin
  Data:= TMstMaster.Create();
  Data.Reset;
  Data.MstCode:= ACode;
  Data.MstID := AID;
  Result:= Data.SelectInDB;
  if Result then begin
   // bMerk.SetFocus;

    tbtSave.Enabled:= True;
  end
  else begin
    Inform('Kemasan tidak ditemukan.');
  end;
  Data.Free;
end;
 }
procedure TfrmMstItem.txtKemasanEnter(Sender: TObject);
begin
  lookup_state:= look_kemasan;
end;

procedure TfrmMstItem.btnKemasClick(Sender: TObject);
//var id: integer;
begin
 // id:= frmLookup.Execute('KEMAS');
  //if Id > 0 then getKemasan('', id);
  //tbtSave.Enabled:= True;
end;

procedure TfrmMstItem.FormShow(Sender: TObject);
begin
  {if ( Purpose in [1,2]) then
    txtHarga.SetFocus
  else
    txtCode.SetFocus}
end;

procedure TfrmMstItem.txtAvgPriceValueValidate(Sender: TObject;
  value: String; var IsValid: Boolean);
begin

  AdvEdtFloatFmt(Sender, value);
  (Sender as TAdvEdit).Modified:= True;
end;

procedure TfrmMstItem.txtAvgPriceKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #46 then key := #44;
  IgnoreChar(Key)
end;

procedure TfrmMstItem.gridRakCanEditCell(Sender: TObject; ARow,
  ACol: Integer; var CanEdit: Boolean);
begin
  CanEdit:= ACol = 0;
end;

procedure TfrmMstItem.gridRakCellValidate(Sender: TObject; Col,
  Row: Integer; var Value: String; var Valid: Boolean);
begin
  case Col of
    0: getRak(0, Row, Value);
  end;
  tbtSave.Enabled:= True;
end;

procedure TfrmMstItem.lookupRak;
var id: integer; kode: string;
begin
  kode:= '';
  id:= frmMstCodeList.ExecuteRak(1);
//  if id <> 0 then getKemasan(kode,id);
end;

procedure TfrmMstItem.getRak(ARakId, ARow: integer; var kode: string);
var Rak: TMstCode;
begin
  Rak:= TMstCode.Create();
  Rak.CodeID:= ARakId;
  Rak.Kode  := kode;
  if Rak.SelectRak2 then begin
    kode:= Rak.CodeName;
//    gridRak.Cells[0, ARow]:= kode;
 //   gridRak.Ints[1, ARow]:= Rak.CodeID;
    tbtSave.Enabled:= True;
  end;
  Rak.destroy;
end;

procedure TfrmMstItem.gridRakEnter(Sender: TObject);
begin
  lookup_state:= look_rak;
end;

procedure TfrmMstItem.gridRakKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    VK_RETURN : GoNextColumn(Sender);
    VK_F2: lookupRak;
  end;
end;

procedure TfrmMstItem.txtCodeKeyPress(Sender: TObject; var Key: Char);
begin
  IgnoreChar(Key)
end;

procedure TfrmMstItem.gridHistoriGetAlignment(Sender: TObject; ARow,
  ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  if ACol = 2 then HAlign:= taRightJustify
end;

procedure TfrmMstItem.gridStokGetAlignment(Sender: TObject; ARow,
  ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  if ACol = 1 then HAlign:= taRightJustify
end;

procedure TfrmMstItem.ShowHistories;
var i: integer; ls: TStringList; histori: TMysqlResult;
begin
  //if histori_showed = True then Exit;
  {
//show stock
  ls:= TStringList.Create;
  TMstMaster_Arr.GetList(ls, MST_TYPE_GUDANG);
  for i:= 0 to ls.Count-1 do begin
    gridStok.Cells[0, i]:= ls.Values[ls.Names[i]];
    gridStok.Cells[1, i]:= FloatToStrFmt(
      TMstItem.GetSaldoAkhir(txtCode.Tag, StrToInt(ls.Names[i]), ServerNow));
  end;
  gridStok.AutoSizeColumns(True, 1);

  GlobalPeriode.setPeriode(cmbOpr.ItemIndex, dtpAwal.Date, dtpAkhir.Date);
  histori:= TReport.LoadKartuStock(txtCode.Tag);

  gridHistori.ClearNormalCells;
  gridHistori.RowCount:= IfThen(histori.RecordCount>0, histori.RecordCount+1, 2);
  gridHistori.Refresh;
  gridHistori.Repaint;

  for i:= 1 to histori.RecordCount do begin
    gridHistori.Dates[1, i]:= BufferToDateTime(histori.FieldValue(0));
    gridHistori.Cells[2, i]:= FloatToStrFmt(BufferToFloat(histori.FieldValue(2)));
    gridHistori.Cells[3, i]:= BufferToString(histori.FieldValue(1));
    histori.MoveNext;
  end;
  histori.destroy;
  gridHistori.AutoSizeColumns(True, 2);
  gridHistori.ColWidths[0]:= 18;
  ls.Destroy;
  //histori_showed:= True;    }
end;

procedure TfrmMstItem.btnNewClick(Sender: TObject);
begin
  if not TSystemAccess.isCan(CAN_ADD,AktiveControl.Tag) then exit;
  ResetData;
end;

procedure TfrmMstItem.PageControl1Change(Sender: TObject);
begin
//  if PageControl1.ActivePageIndex =  2 then ShowHistories
end;

procedure TfrmMstItem.CalculatePrice;
var disc, tax, beli, net, mgn1, mgn2: double;
begin

  tax := (beli - disc) * tax;
  net := beli - disc + tax;

end;

function TfrmMstItem.getJenis(ACode: string; AID: integer): boolean;
var Data: TMstMaster;
begin
  Data:= TMstMaster.Create();
  Data.Reset;
  Data.MstCode:= ACode;
  Data.MstID := AID;
  Result:= Data.SelectJenis;
  if Result then begin
    txtJenis.Tag := Data.MstID;
    txtJenis.Text:= Data.MstName;
    tbtSave.Enabled:= True;
  end
  else begin
    Inform('Jenis tidak ditemukan.');
    txtJenis.Clear;
    txtJenis.SetFocus;
  end;
  Data.Free;

end;

procedure TfrmMstItem.btnJenisClick(Sender: TObject);
var id: integer;
begin
  id:= frmLookup.Execute('JNS_OBAT');
  if Id > 0 then getJenis('', id);
  tbtSave.Enabled:= True;
end;

procedure TfrmMstItem.txtJenisEnter(Sender: TObject);
begin
lookup_state:= look_jenis;
end;

procedure TfrmMstItem.dtpExpireKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    VK_RETURN :
    begin

    end;
    
  end;
end;

procedure TfrmMstItem.New1Click(Sender: TObject);
begin
  tbtNew.Click
end;

procedure TfrmMstItem.Save1Click(Sender: TObject);
begin
  tbtSave.Click
end;

procedure TfrmMstItem.txtAvgPriceChange(Sender: TObject);
//var sudah_enabled: boolean; valid: boolean;
begin
{  txtAvgPriceValueValidate(Sender, txtAvgPrice.Text, valid);
  sudah_enabled:= tbtSave.Enabled;
  if not sudah_enabled then
    tbtSave.Enabled:= txtAvgPrice.Modified;
 }
end;

procedure TfrmMstItem.txtUnitEnter(Sender: TObject);
begin
  lookup_state:= look_kemasan;
end;

procedure TfrmMstItem.btnKemasanClick(Sender: TObject);
begin
  lookupUnit;
end;

procedure TfrmMstItem.setEnableDisabled;
begin
  txtCode.ReadOnly := (Purpose<>0);
  txtName.ReadOnly := (Purpose<>0);
  txtSpec.ReadOnly := (Purpose<>0);
  txtStruk.ReadOnly := (Purpose<>0);
  txtBarcode.ReadOnly := (Purpose<>0);
  txtMerk.ReadOnly := (Purpose<>0);
  txtJenis.ReadOnly := (Purpose<>0);
  txtUnit.ReadOnly := (Purpose<>0);

  btnSpec.Enabled := (Purpose=0);
  btnKemasan.Enabled := (Purpose=0);
  txtHarga.Enabled := (Purpose<>0);
  tbtNew.Enabled := (Purpose=0);

end;

procedure TfrmMstItem.tbtSaveClick(Sender: TObject);
begin
     if isValid then IsSaved
end;

end.
