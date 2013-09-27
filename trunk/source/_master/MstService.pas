unit MstService;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, AdvEdit, ComCtrls, ToolWin, Grids, BaseGrid, AdvGrid,
  strUtils, Math, UMaster, WinXP, ExtCtrls, dateutils, Menus,UPetshop;

type
  TfrmMstService = class(TForm)
    txtCode: TAdvEdit;
    txtName: TAdvEdit;
    ToolBar1: TToolBar;
    tbtNew: TToolButton;
    tbtSave: TToolButton;
    WinXP1: TWinXP;
    ToolButton2: TToolButton;
    PopupMenu1: TPopupMenu;
    New1: TMenuItem;
    Save1: TMenuItem;
    txtNotes: TMemo;
    Label1: TLabel;
    Label2: TLabel;
    cmbJenis: TComboBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tbtSaveClick(Sender: TObject);
    procedure tbtNewClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure txtBarcodeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure txtNameChange(Sender: TObject);
    procedure txtNameKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure txtAvgPriceValueValidate(Sender: TObject; value: String;
      var IsValid: Boolean);
    procedure txtAvgPriceKeyPress(Sender: TObject; var Key: Char);
    procedure gridRakCanEditCell(Sender: TObject; ARow, ACol: Integer;
      var CanEdit: Boolean);
    procedure gridRakKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure txtCodeKeyPress(Sender: TObject; var Key: Char);
    procedure gridHistoriGetAlignment(Sender: TObject; ARow, ACol: Integer;
      var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure gridStokGetAlignment(Sender: TObject; ARow,
      ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure New1Click(Sender: TObject);
    procedure Save1Click(Sender: TObject);
    procedure txtAvgPriceChange(Sender: TObject);
    procedure txtNotesChange(Sender: TObject);
    procedure cmbJenisChange(Sender: TObject);
  private
    MstItem: TMstService;
    lookup_state: integer;
    lsJenis:TStringList;
    procedure InitGrid;
    procedure ArrangeColsize;

    procedure ResetData;
    procedure InitForm;
    procedure LoadData(id: integer);
    function isSaved: boolean;
    function isValid: boolean;

  public
    procedure Execute(id: integer);
  end;

var
  frmMstService: TfrmMstService;

implementation

uses UConstTool, Subroutines, MainMenu,
  UConst, LookupData, uMysqlClient, MySQLConnector,
  UTransaction, MstCodeList;

{$R *.dfm}

procedure TfrmMstService.ArrangeColsize;
begin
  
end;

procedure TfrmMstService.Execute(id: integer);
begin
  MstItem := TMstService.Create;
  lsJenis := TStringList.Create;
  TMstMaster_Arr.GetList(lsJenis,MST_TYPE_SERVICE);
  NameValueListToValueList(lsJenis,cmbJenis.Items);
  InitForm;
  //histori_showed:= False;
  if (id <> 0) then LoadData(id);
  Run(Self);
end;

procedure TfrmMstService.InitForm;
begin
  ResetData;
  Self.Caption:= 'Data Jenis Grooming & Hotel';
end;

procedure TfrmMstService.InitGrid;
begin

  ArrangeColsize;
end;

function TfrmMstService.isSaved: boolean;
var i, idx: integer;
begin
  MstItem.Reset;
  MstItem.ServiceId:= txtCode.Tag;
  MstItem.ServiceCode  := txtCode.Text;
  MstItem.ServiceName  := txtName.Text;
  MstItem.Notes := txtNotes.Lines.Text;
  MstItem.ServiceType := StrToInt(lsJenis.Names[cmbJenis.itemIndex]);

  if txtCode.Tag <> 0 then Result:= MstItem.UpdateOnDB()
  else Result:= MstItem.InsertOnDB;
  tbtSave.Enabled:= not Result;

  if Result then LoadData(MstItem.ServiceId);

end;

function TfrmMstService.isValid: boolean;
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
    Result:=
      (hrg_dasar <= asgConversion.Floats[colSales, 1]) and
      ((hrg_dasar <= asgConversion.Floats[colSales2,1]) or (asgConversion.Floats[colSales2,1] = 0))
  end;
         }
begin
  if CekInput(Result, txtName.Text <> '', 'Nama belum diisi.', txtName) then
  if CekInput(Result, ((not MstItem.isExistInDb(txtCode.Text)) and (txtCode.Tag = 0)) or (txtCode.Tag <> 0), 'Kode Sudah ada.', txtCode) then
  if CekInput(Result, cmbJenis.ItemIndex<> -1, 'Jenis Jasa belum ditentukan.', cmbJenis) then
  //   CekInput(Result, cek_hrg_dasar, 'Hrg Bersih < Hrg Beli.', asgConversion)
end;

procedure TfrmMstService.LoadData(id: integer);
var i: integer;
begin
  MstItem.ServiceId:= id;
  MstItem.SelectInDB;
  txtCode.Tag  := MstItem.ServiceId;
  txtCode.Text := MstItem.ServiceCode;
  txtName.Text := MstItem.ServiceName;
  txtNotes.Lines.Text:= MstItem.Notes;
  cmbJenis.ItemIndex := lsJenis.IndexOfName(IntToStr(MstItem.ServiceType));
  ArrangeColsize;
  tbtSave.Enabled:= False;
end;

procedure TfrmMstService.ResetData;
begin
  InitGrid;
  txtCode.Clear;
  txtCode.Text := MstItem.GetNextCode;
  txtName.Clear;
  txtCode.Tag:= 0;
  txtNotes.Clear;

  tbtSave.Enabled:= True;
//  txtName.SetFocus;
end;

procedure TfrmMstService.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  MstItem.Free;
  reAssignLastControl;
end;


procedure TfrmMstService.tbtSaveClick(Sender: TObject);
begin
  if isValid then IsSaved 
end;

procedure TfrmMstService.tbtNewClick(Sender: TObject);
begin
  if not TSystemAccess.isCan(CAN_ADD,AktiveControl.Tag) then exit;
  ResetData;
  txtCode.SetFocus;
end;

procedure TfrmMstService.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose:= True
end;

procedure TfrmMstService.txtBarcodeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = vk_tab then
    if txtCode.Tag = 0 then
      if txtCode.Text = '' then
end;

procedure TfrmMstService.txtNameChange(Sender: TObject);
var sudah_enabled: boolean;
begin
  sudah_enabled:= tbtSave.Enabled;
  if not sudah_enabled then
    tbtSave.Enabled:= (Sender as TAdvEdit).Modified;
end;

procedure TfrmMstService.txtNameKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_F2 then begin
    txtName.SelStart:= length(txtName.Text);
  end;
end;


procedure TfrmMstService.FormShow(Sender: TObject);
begin
  txtCode.SetFocus
end;

procedure TfrmMstService.txtAvgPriceValueValidate(Sender: TObject;
  value: String; var IsValid: Boolean);
begin

  AdvEdtFloatFmt(Sender, value);
  (Sender as TAdvEdit).Modified:= True;
end;

procedure TfrmMstService.txtAvgPriceKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #46 then key := #44;
  IgnoreChar(Key)
end;

procedure TfrmMstService.gridRakCanEditCell(Sender: TObject; ARow,
  ACol: Integer; var CanEdit: Boolean);
begin
  CanEdit:= ACol = 0;
end;


procedure TfrmMstService.gridRakKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    VK_RETURN : GoNextColumn(Sender);
  end;
end;

procedure TfrmMstService.txtCodeKeyPress(Sender: TObject; var Key: Char);
begin
  IgnoreChar(Key)
end;

procedure TfrmMstService.gridHistoriGetAlignment(Sender: TObject; ARow,
  ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  if ACol = 2 then HAlign:= taRightJustify
end;

procedure TfrmMstService.gridStokGetAlignment(Sender: TObject; ARow,
  ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  if ACol = 1 then HAlign:= taRightJustify
end;


procedure TfrmMstService.New1Click(Sender: TObject);
begin
  tbtNew.Click
end;

procedure TfrmMstService.Save1Click(Sender: TObject);
begin
  tbtSave.Click
end;

procedure TfrmMstService.txtAvgPriceChange(Sender: TObject);
//var sudah_enabled: boolean; valid: boolean;
begin
{  txtAvgPriceValueValidate(Sender, txtAvgPrice.Text, valid);
  sudah_enabled:= tbtSave.Enabled;
  if not sudah_enabled then
    tbtSave.Enabled:= txtAvgPrice.Modified;
 }
end;

procedure TfrmMstService.txtNotesChange(Sender: TObject);
var sudah_enabled: boolean;
begin
  sudah_enabled:= tbtSave.Enabled;
  if not sudah_enabled then
    tbtSave.Enabled:= (Sender as TMemo).Modified;

end;

procedure TfrmMstService.cmbJenisChange(Sender: TObject);
begin

    tbtSave.Enabled:= true;

end;

end.
