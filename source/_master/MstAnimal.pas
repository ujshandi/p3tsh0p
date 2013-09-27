unit MstAnimal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, AdvEdit, ComCtrls, ToolWin, Grids, BaseGrid, AdvGrid,
  strUtils, Math, UMaster, WinXP, ExtCtrls, dateutils, Menus,UPetshop;

type
  TfrmMstAnimal = class(TForm)
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
  private
    MstItem: TMstAnimal;
    lookup_state: integer;
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
  frmMstAnimal: TfrmMstAnimal;

implementation

uses UConstTool, Subroutines, MainMenu,
  UConst, LookupData, uMysqlClient, MySQLConnector,
  UTransaction, MstAnimalList;

{$R *.dfm}

procedure TfrmMstAnimal.ArrangeColsize;
begin
  
end;

procedure TfrmMstAnimal.Execute(id: integer);
begin
  MstItem := TMstAnimal.Create;
  InitForm;
  if (id <> 0) then LoadData(id);
  Run(Self);
end;

procedure TfrmMstAnimal.InitForm;
begin
  ResetData;
  Self.Caption:= 'Data Hewan';
end;

procedure TfrmMstAnimal.InitGrid;
begin

  ArrangeColsize;
end;

function TfrmMstAnimal.isSaved: boolean;
var i, idx: integer;
begin
  MstItem.Reset;
  MstItem.AnimalId:= txtCode.Tag;
  MstItem.AnimalCode  := txtCode.Text;
  MstItem.Animal  := txtName.Text;
  MstItem.Notes := txtNotes.Lines.Text;


  if txtCode.Tag <> 0 then Result:= MstItem.UpdateOnDB()
  else Result:= MstItem.InsertOnDB;
  tbtSave.Enabled:= not Result;

  if Result then LoadData(MstItem.AnimalId);

end;

function TfrmMstAnimal.isValid: boolean;
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
//  if CekInput(Result, cek_nilai, 'Nilai konversi tidak boleh 0.', asgConversion) then
  //   CekInput(Result, cek_hrg_dasar, 'Hrg Bersih < Hrg Beli.', asgConversion)
end;

procedure TfrmMstAnimal.LoadData(id: integer);
var i: integer;
begin
  MstItem.AnimalId:= id;
  MstItem.SelectInDB;
  txtCode.Tag  := MstItem.AnimalId;
  txtCode.Text := MstItem.AnimalCode;
  txtName.Text := MstItem.Animal;
  txtNotes.Lines.Text:= MstItem.Notes;

  ArrangeColsize;
  tbtSave.Enabled:= False;
end;

procedure TfrmMstAnimal.ResetData;
begin
  InitGrid;
  txtCode.Clear;
  txtCode.Text := MstItem.GetNextCode;
  txtName.Clear;
  txtCode.Tag:= 0;
  txtNotes.Clear;

  tbtSave.Enabled:= True;
 // txtName.SetFocus;
end;

procedure TfrmMstAnimal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  MstItem.Free;
  reAssignLastControl;
end;


procedure TfrmMstAnimal.tbtSaveClick(Sender: TObject);
begin
  if isValid then IsSaved 
end;

procedure TfrmMstAnimal.tbtNewClick(Sender: TObject);
begin
 if not TSystemAccess.isCan(CAN_ADD,AktiveControl.Tag) then exit;
  ResetData;
  if txtCode.Enabled then
      txtCode.SetFocus;
end;

procedure TfrmMstAnimal.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose:= True
end;

procedure TfrmMstAnimal.txtBarcodeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = vk_tab then
    if txtCode.Tag = 0 then
      if txtCode.Text = '' then
end;

procedure TfrmMstAnimal.txtNameChange(Sender: TObject);
var sudah_enabled: boolean;
begin
  sudah_enabled:= tbtSave.Enabled;
  if not sudah_enabled then
    tbtSave.Enabled:= (Sender as TAdvEdit).Modified;
end;

procedure TfrmMstAnimal.txtNameKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_F2 then begin
    txtName.SelStart:= length(txtName.Text);
  end;
end;


procedure TfrmMstAnimal.FormShow(Sender: TObject);
begin
  txtCode.SetFocus
end;

procedure TfrmMstAnimal.txtAvgPriceValueValidate(Sender: TObject;
  value: String; var IsValid: Boolean);
begin

  AdvEdtFloatFmt(Sender, value);
  (Sender as TAdvEdit).Modified:= True;
end;

procedure TfrmMstAnimal.txtAvgPriceKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #46 then key := #44;
  IgnoreChar(Key)
end;

procedure TfrmMstAnimal.gridRakCanEditCell(Sender: TObject; ARow,
  ACol: Integer; var CanEdit: Boolean);
begin
  CanEdit:= ACol = 0;
end;


procedure TfrmMstAnimal.gridRakKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    VK_RETURN : GoNextColumn(Sender);
  end;
end;

procedure TfrmMstAnimal.txtCodeKeyPress(Sender: TObject; var Key: Char);
begin
  IgnoreChar(Key)
end;

procedure TfrmMstAnimal.gridHistoriGetAlignment(Sender: TObject; ARow,
  ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  if ACol = 2 then HAlign:= taRightJustify
end;

procedure TfrmMstAnimal.gridStokGetAlignment(Sender: TObject; ARow,
  ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  if ACol = 1 then HAlign:= taRightJustify
end;


procedure TfrmMstAnimal.New1Click(Sender: TObject);
begin
  tbtNew.Click
end;

procedure TfrmMstAnimal.Save1Click(Sender: TObject);
begin
  tbtSave.Click
end;

procedure TfrmMstAnimal.txtAvgPriceChange(Sender: TObject);
//var sudah_enabled: boolean; valid: boolean;
begin
{  txtAvgPriceValueValidate(Sender, txtAvgPrice.Text, valid);
  sudah_enabled:= tbtSave.Enabled;
  if not sudah_enabled then
    tbtSave.Enabled:= txtAvgPrice.Modified;
 }
end;

procedure TfrmMstAnimal.txtNotesChange(Sender: TObject);
var sudah_enabled: boolean;
begin
  sudah_enabled:= tbtSave.Enabled;
  if not sudah_enabled then
    tbtSave.Enabled:= (Sender as TMemo).Modified;

end;

end.
