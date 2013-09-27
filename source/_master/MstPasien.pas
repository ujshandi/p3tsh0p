unit MstPasien;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, AdvEdit, ToolWin,strUtils,
  UMaster, WinXP, ExtCtrls;

type
  TfrmMstPasien = class(TForm)
    txtCode: TAdvEdit;
    txtName: TAdvEdit;
    txtAddress: TAdvEdit;
    txtCity: TAdvEdit;
    txtPhone: TAdvEdit;
    ToolBar1: TToolBar;
    tbtNew: TToolButton;
    tbtSave: TToolButton;
    WinXP1: TWinXP;
    txtCotact: TAdvEdit;
    Label1: TLabel;
    Bevel1: TBevel;
    Label2: TLabel;
    Bevel2: TBevel;
    Label3: TLabel;
    Bevel3: TBevel;
    cmbSex: TComboBox;
    dtpLahir: TDateTimePicker;
    Jsn: TLabel;
    Label6: TLabel;
    procedure tbtNewClick(Sender: TObject);
    procedure tbtSaveClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure txtCodeChange(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure cmbSexChange(Sender: TObject);
    procedure cmbSexKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    Relation: TMstPasien;
    NewMode: boolean;
    procedure ResetData;
    procedure InitForm;
    procedure LoadData;
    function isSaved: boolean;
    function isValid: boolean;
  public
    procedure Execute(vRelasiId: integer);
    function ExecuteNew(var ID: integer): boolean;
  end;

var
  frmMstPasien: TfrmMstPasien;

implementation

uses UConstTool, Subroutines, MainMenu, AutoStockLine;

{$R *.dfm}

{ TfrmMstRelation }

procedure TfrmMstPasien.Execute(vRelasiId: integer);
begin
  NewMode:= False;
  Relation:= TMstPasien.Create();
  Relation.PasienID:= vRelasiId;

  InitForm;
  if vRelasiId <> 0 then LoadData;
  Run(Self);
end;

procedure TfrmMstPasien.InitForm;
begin
  ResetData;
end;

function TfrmMstPasien.isSaved: boolean;
begin
  Relation.Kode:= txtCode.Text;
  Relation.PasienID:= txtCode.Tag;

  Relation.Nama:= txtName.Text;
  Relation.Alamat:= txtAddress.Text;
  Relation.Kota:= txtCity.Text;
  Relation.Phone:= txtPhone.Text;
  Relation.CardID:= txtCotact.Text;
  Relation.TglLahir:= dtpLahir.Date;
  Relation.Sex:= cmbSex.ItemIndex;

  if txtCode.Tag <> 0 then
    Result:= Relation.UpdateOnDB
  else Result:= Relation.InsertOnDB;
  tbtSave.Enabled:= not Result;
  txtCode.Tag:= Relation.PasienID;
  txtCode.Text:= Relation.Kode;
  if Result and NewMode then ModalResult:= mrOk;
end;

function TfrmMstPasien.isValid: boolean;
begin
    if CekInput(Result, txtName.Text <> '', 'Nama belum diisi.', txtName) then
       CekInput(Result, ((not Relation.isExistInDb(txtCode.Text)) and (txtCode.Tag = 0)) or (txtCode.Tag <> 0), 'Kode Sudah ada.', txtCode)
end;

procedure TfrmMstPasien.LoadData;
begin
  Relation.SelectInDB;
  txtCode.Text:=    Relation.Kode;
  txtCode.Tag:=     Relation.PasienID;
  txtName.Text:=    Relation.Nama;
  txtAddress.Text:= Relation.Alamat;
  txtCity.Text:=    Relation.Kota;
  txtPhone.Text:=   Relation.Phone;
  txtCotact.Text:=  Relation.CardID;
  dtpLahir.Date:=   Relation.TglLahir;
  if Relation.Sex = 0 then cmbSex.ItemIndex := 0
  else if Relation.Sex = 1 then cmbSex.ItemIndex := 1
  else cmbSex.ItemIndex := -1;
  cmbSexChange(nil);
end;

procedure TfrmMstPasien.ResetData;
begin
  txtCode.Clear;
  txtName.Clear;
  txtAddress.Clear;
  cmbSex.ItemIndex:= 0;
  cmbSexChange(nil);
  dtpLahir.Date:= Now;
  txtCity.Clear;
  txtPhone.Clear;
  txtCotact.Clear;
  txtCode.Tag:= 0;
  tbtSave.Enabled:= True;
end;

procedure TfrmMstPasien.tbtNewClick(Sender: TObject);
begin
  ResetData;
  txtName.SetFocus;
end;

procedure TfrmMstPasien.tbtSaveClick(Sender: TObject);
begin
  if isValid then isSaved
end;

procedure TfrmMstPasien.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Relation.Free;
  reAssignLastControl
end;

procedure TfrmMstPasien.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose:= True
end;

procedure TfrmMstPasien.txtCodeChange(Sender: TObject);
var sudah_enabled: boolean;
begin
  sudah_enabled:= tbtSave.Enabled;
  if not sudah_enabled then
    tbtSave.Enabled:= (Sender as TAdvEdit).Modified;
end;

procedure TfrmMstPasien.FormPaint(Sender: TObject);
begin
  AssigControl(Sender);
end;

procedure TfrmMstPasien.cmbSexChange(Sender: TObject);
begin
//
end;

function TfrmMstPasien.ExecuteNew(var ID: integer): boolean;
begin
  NewMode:= True;
  Relation:= TMstPasien.Create();
  Relation.PasienID:= ID;

  InitForm;
  if ID <> 0 then LoadData;
  Run(Self);
  Result:= ModalResult = mrOk;
  if result then ID:= txtCode.Tag;
end;

procedure TfrmMstPasien.cmbSexKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = vk_return then
     GoNextControl(Self, (Sender as TWinControl), true, true, false).SetFocus
end;

procedure TfrmMstPasien.FormShow(Sender: TObject);
begin
  txtName.SetFocus;
end;

procedure TfrmMstPasien.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
case key of VK_ESCAPE: ModalResult:= mrCancel; end;
end;

end.
