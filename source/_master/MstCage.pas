unit MstCage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, AdvEdit, ComCtrls, ToolWin, Grids, BaseGrid, AdvGrid,
  strUtils, Math, UMaster, WinXP, ExtCtrls, dateutils, Menus,UPetshop;

type
  TfrmMstCage = class(TForm)
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
    MstItem: TMstCage;
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
  frmMstCage: TfrmMstCage;

implementation

uses UConstTool, Subroutines, MainMenu,
  UConst, LookupData, uMysqlClient, MySQLConnector,
  UTransaction, MstCodeList;

{$R *.dfm}

procedure TfrmMstCage.ArrangeColsize;
begin
  
end;

procedure TfrmMstCage.Execute(id: integer);
begin
  MstItem := TMstCage.Create;
  InitForm;
  if (id <> 0) then LoadData(id);
  Run(Self);
end;

procedure TfrmMstCage.InitForm;
begin
  ResetData;
  Self.Caption:= 'Data Barang';
end;

procedure TfrmMstCage.InitGrid;
begin

  ArrangeColsize;
end;

function TfrmMstCage.isSaved: boolean;
var i, idx: integer;
begin
  MstItem.Reset;
  MstItem.CageId:= txtCode.Tag;
  MstItem.CageCode  := txtCode.Text;
  MstItem.Cage  := txtName.Text;
  MstItem.Notes := txtNotes.Lines.Text;


  if txtCode.Tag <> 0 then Result:= MstItem.UpdateOnDB()
  else Result:= MstItem.InsertOnDB;
  tbtSave.Enabled:= not Result;

  if Result then LoadData(MstItem.CageId);

end;

function TfrmMstCage.isValid: boolean;
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

procedure TfrmMstCage.LoadData(id: integer);
var i: integer;
begin
  MstItem.CageId:= id;
  MstItem.SelectInDB;
  txtCode.Tag  := MstItem.CageId;
  txtCode.Text := MstItem.CageCode;
  txtName.Text := MstItem.Cage;
  txtNotes.Lines.Text:= MstItem.Notes;

  ArrangeColsize;
  tbtSave.Enabled:= False;
end;

procedure TfrmMstCage.ResetData;
begin
  InitGrid;
  txtCode.Clear;
  txtCode.Text := MstItem.GetNextCode;
  txtName.Clear;
  txtCode.Tag:= 0;
  txtNotes.Clear;

  tbtSave.Enabled:= True;
  txtName.SetFocus;
end;

procedure TfrmMstCage.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  MstItem.Free;
end;


procedure TfrmMstCage.tbtSaveClick(Sender: TObject);
begin
  if isValid then IsSaved 
end;

procedure TfrmMstCage.tbtNewClick(Sender: TObject);
begin
  ResetData;
  txtCode.SetFocus;
end;

procedure TfrmMstCage.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose:= True
end;

procedure TfrmMstCage.txtBarcodeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = vk_tab then
    if txtCode.Tag = 0 then
      if txtCode.Text = '' then
end;

procedure TfrmMstCage.txtNameChange(Sender: TObject);
var sudah_enabled: boolean;
begin
  sudah_enabled:= tbtSave.Enabled;
  if not sudah_enabled then
    tbtSave.Enabled:= (Sender as TAdvEdit).Modified;
end;

procedure TfrmMstCage.txtNameKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_F2 then begin
    txtName.SelStart:= length(txtName.Text);
  end;
end;


procedure TfrmMstCage.FormShow(Sender: TObject);
begin
  txtCode.SetFocus
end;

procedure TfrmMstCage.txtAvgPriceValueValidate(Sender: TObject;
  value: String; var IsValid: Boolean);
begin

  AdvEdtFloatFmt(Sender, value);
  (Sender as TAdvEdit).Modified:= True;
end;

procedure TfrmMstCage.txtAvgPriceKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #46 then key := #44;
  IgnoreChar(Key)
end;

procedure TfrmMstCage.gridRakCanEditCell(Sender: TObject; ARow,
  ACol: Integer; var CanEdit: Boolean);
begin
  CanEdit:= ACol = 0;
end;


procedure TfrmMstCage.gridRakKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    VK_RETURN : GoNextColumn(Sender);
  end;
end;

procedure TfrmMstCage.txtCodeKeyPress(Sender: TObject; var Key: Char);
begin
  IgnoreChar(Key)
end;

procedure TfrmMstCage.gridHistoriGetAlignment(Sender: TObject; ARow,
  ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  if ACol = 2 then HAlign:= taRightJustify
end;

procedure TfrmMstCage.gridStokGetAlignment(Sender: TObject; ARow,
  ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  if ACol = 1 then HAlign:= taRightJustify
end;


procedure TfrmMstCage.New1Click(Sender: TObject);
begin
  tbtNew.Click
end;

procedure TfrmMstCage.Save1Click(Sender: TObject);
begin
  tbtSave.Click
end;

procedure TfrmMstCage.txtAvgPriceChange(Sender: TObject);
//var sudah_enabled: boolean; valid: boolean;
begin
{  txtAvgPriceValueValidate(Sender, txtAvgPrice.Text, valid);
  sudah_enabled:= tbtSave.Enabled;
  if not sudah_enabled then
    tbtSave.Enabled:= txtAvgPrice.Modified;
 }
end;

procedure TfrmMstCage.txtNotesChange(Sender: TObject);
var sudah_enabled: boolean;
begin
  sudah_enabled:= tbtSave.Enabled;
  if not sudah_enabled then
    tbtSave.Enabled:= (Sender as TMemo).Modified;

end;

end.
