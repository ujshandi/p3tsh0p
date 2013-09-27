unit MstBranch;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, AdvEdit, ToolWin,strUtils, ADODB,
  Subroutines, WinXP, ExtCtrls, Math,UMaster;

type
  TfrmMstBranch = class(TForm)
    txtCode: TAdvEdit;
    txtName: TAdvEdit;
    txtAddress: TAdvEdit;
    txtCity: TAdvEdit;
    txtPhone: TAdvEdit;
    ToolBar1: TToolBar;
    tbtNew: TToolButton;
    tbtSave: TToolButton;
    WinXP1: TWinXP;
    txtPhone2: TAdvEdit;
    txtPostCode: TAdvEdit;
    txtFax: TAdvEdit;
    procedure tbtNewClick(Sender: TObject);
    procedure tbtSaveClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormPaint(Sender: TObject);
    procedure cmbJenisKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure txtCodeEnter(Sender: TObject);
    procedure txtAddressExit(Sender: TObject);
  private
    oldValue: string;
    Branch: TMstBranch;

    procedure ResetData;
    procedure InitForm;
    function LoadData(ID: integer): boolean;
    function isSaved: boolean;
    function isValid: boolean;
  public
    procedure Execute(ID: integer);
  end;

var
  frmMstBranch: TfrmMstBranch;

implementation

uses UConstTool, MainMenu, UConst, AutoStockLine;

{$R *.dfm}

{ TfrmMstRelation }

procedure TfrmMstBranch.Execute(ID: integer);
begin
  Branch:= TMstBranch.Create();
  InitForm;
  if ID <> 0 then LoadData(ID);
  Run(Self);
end;

procedure TfrmMstBranch.InitForm;
begin
  ResetData;
end;

function TfrmMstBranch.isSaved: boolean;
begin
  Branch.Reset;
  Branch.BranchCode:= txtCode.Text;
  Branch.BranchID:= txtCode.Tag;
  Branch.BranchName:= txtName.Text;
  Branch.Address:= txtAddress.Text;
  Branch.City:= txtCity.Text;
  Branch.PostalCode:= txtPostCode.Text;
  Branch.Phone1:= txtPhone.Text;
  Branch.Fax:= txtFax.Text;
  Branch.Phone2 := txtPhone2.Text;



  Result:= Branch.InsertInDb;
  if Result then LoadData(Branch.BranchID);
  tbtSave.Enabled:= not Result;
end;

function TfrmMstBranch.isValid: boolean;
begin
  if CekInput(Result, txtName.Text <> '', 'Nama belum diisi.', txtName) then
  if CekInput(Result, (not TMstBranch.isExistInDB(txtCode.Text, txtCode.Tag)), 'Kode sudah ada.', txtCode) then
  if CekInput(Result, txtCode.Text <> '', 'Kode belum diisi.', txtCode) then
end;

function TfrmMstBranch.LoadData(ID: integer): boolean;
begin
  Branch.BranchID:= ID;
  Result:= Branch.SelectInDB;
  txtCode.Text:=     Branch.BranchCode;
  txtCode.Tag:=      Branch.BranchID;
  txtName.Text:=     Branch.BranchName;
  txtAddress.Text:=  Branch.Address;
  txtCity.Text:=     Branch.City;
  txtPostCode.Text:= Branch.PostalCode;
  txtPhone.Text:=    Branch.Phone1;
  txtFax.Text:=      Branch.Fax;
  txtPhone2.Text := Branch.Phone2;
  tbtSave.Enabled:= False;
end;

procedure TfrmMstBranch.ResetData;
begin
  txtCode.Text:= 'J';//TMstBranch.getNextCode;
  txtName.Clear;
  txtAddress.Clear;
  txtCity.Clear;
  txtPhone.Clear;
  txtFax.Clear;
  txtPostCode.Clear;
  txtCode.Tag:= 0;
  txtPhone2.Clear;
  tbtSave.Enabled:= False;
end;

procedure TfrmMstBranch.tbtNewClick(Sender: TObject);
begin
// if not GlobalSystemUser.CanAccess(TAG_NEW) then exit;
  ResetData;
  txtCode.SetFocus;
end;

procedure TfrmMstBranch.tbtSaveClick(Sender: TObject);
begin
//    if not GlobalSystemUser.CanAccess(TAG_SAVE_EDIT) then exit;
  if isValid then isSaved
end;

procedure TfrmMstBranch.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Branch.Free;
  reAssignLastControl;
end;

procedure TfrmMstBranch.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose:= True
end;

procedure TfrmMstBranch.FormPaint(Sender: TObject);
begin
  AssigControl(Sender);
end;

procedure TfrmMstBranch.cmbJenisKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = vk_return then GoNextControl(Self, (Sender as TWinControl), true, true, false).SetFocus
end;

procedure TfrmMstBranch.FormShow(Sender: TObject);
begin
  txtCode.SetFocus
end;

procedure TfrmMstBranch.txtCodeEnter(Sender: TObject);
begin
  oldValue:= (Sender as TAdvEdit).Text;
end;

procedure TfrmMstBranch.txtAddressExit(Sender: TObject);
var sudah_enabled: boolean;
begin
  sudah_enabled:= tbtSave.Enabled;
  if (not sudah_enabled) and (oldValue <> (Sender as TAdvEdit).Text) then
     tbtSave.Enabled:= True
end;

end.
