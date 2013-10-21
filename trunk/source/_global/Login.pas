unit Login;
  {DEFINE DEBUG}
    {DeFINE SHIFT_ENABLED}
interface

uses
  UConstTool,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, AdvEdit, ExtCtrls, Buttons, WinXP,
  SUIForm, SUIDlg, jpeg, Registry;

type
  TfrmLogin = class(TForm)
    suiForm1: TsuiForm;
    pnlInput: TPanel;
    lblCopyright: TLabel;
    lblPassword: TLabel;
    lblLogin: TLabel;
    txtLoginID: TAdvEdit;
    txtLoginPwd: TAdvEdit;
    btnOk: TButton;
    btnCancel: TButton;
    pnlLogo: TPanel;
    imgLogo: TImage;
    lblStatus: TLabel;
    Label2: TLabel;
    lblName: TLabel;
    lblSlogan: TLabel;
    lblModul: TLabel;
    procedure btnOKClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure cmbShiftChange(Sender: TObject);
    procedure cmbShiftKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    LoginMode: boolean;
    LocalLoginID, LocalLoginName: string;
    tryCounter, LocalAccessLevel, LocalNeedAccessLevel: integer;
  public
    { Public declarations }
    function LogOn: boolean;
    function Authorize(var ALoginID: string; ANeedAccessLevel: integer): boolean;
    procedure Status(const MessageStatus: string = '');
  end;

var
  frmLogin: TfrmLogin;
  NeedAccessLevel: integer = 0;
  myMainForm: TForm = nil;

implementation

uses UConst, Subroutines, MySQLConnector;

//uses MainMenu;
//{$I PROFILE.INC}
{$R *.dfm}

procedure TfrmLogin.btnOKClick(Sender: TObject);
begin

  btnOK.Enabled := tryCounter < 4;// false;

  if (GlobalSystemUser.SelectInDbX(txtLoginID.Text, txtLoginPwd.Text) = false) then begin
    ShowMessage('Invalid login/password.');
    GlobalSystemUser.Reset;
    txtLoginID.SetFocus;
    Inc(tryCounter);
  end
{  else if (cmbShift.ItemIndex  < 0) then begin
    Alert('Shift belum dipilih.');
    cmbShift.SetFocus;

  end}
  else if (GlobalSystemUser.DisableDate<>0) then begin
    ShowMessage('Login disabled.');
    GlobalSystemUser.Reset;
    txtLoginID.SetFocus;
    Inc(tryCounter);
  end else begin
    LocalLoginID    := txtLoginID.Text;
    LocalLoginName  := GlobalSystemUser.UserName;
    LocalAccessLevel:= GlobalSystemUser.AccessLevel;

    if (LocalAccessLevel<LocalNeedAccessLevel) then begin
      if (LoginMode) then begin
        ShowMessage('Logon need access level '+IntToStr(LocalNeedAccessLevel)+'.');
        Inc(tryCounter);
      end else begin
        ShowMessage('Authentication need access level '+IntToStr(LocalNeedAccessLevel)+'.');
        Inc(tryCounter);
      end;
      txtLoginID.SetFocus;
    end else begin
      ModalResult := mrOK;
    end;

  end;
  //btnOK.Enabled := true;
end;

procedure TfrmLogin.btnCancelClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmLogin.FormActivate(Sender: TObject);
begin
  pnlLogo.Visible := (LoginMode);
  lblCopyRight.Visible := (LoginMode);
  if (LoginMode) then Self.ClientHeight := pnlLogo.Height + pnlInput.Height
  else Self.ClientHeight := pnlInput.Height;
  txtLoginID.Clear;
  txtLoginPwd.Clear;
  txtLoginID.SetFocus;

{$IFDEF DEBUG}
  txtLoginID.Text := 'adm';
  txtLoginPwd.Text := 'invisi00';
//  cmbShift.ItemIndex:= 0;
  //cmbShiftChange(NIL);

  btnOK.SetFocus;
{$ENDIF}
end;

function TfrmLogin.LogOn: boolean;
begin
  Result:= False;
  tryCounter:= 1;
//  cmbShift.Visible := false;
//  lblShift.Visible := false;
{$IFDEF SHIFT_ENABLED}
  cmbShift.Visible := TRUE;
  lblShift.Visible := TRUE;
{$ENDIF}

  if not ConnetedToDB then
    Exit;
  frmLogin.suiForm1.Height:= 300;

  if MANAGEMENT_VERSION then
    lblModul.Caption:= 'Management Center'
  else lblModul.Caption:= 'Point of Sales';

  lblName.Caption:= 'Jangki Petshop';
  lblSlogan.Caption:= 'Grooming & Clinic';

//  cmbShift.Clear;
//  GetShift(GlobalStringList, cmbShift.Items);
  Self.Caption := 'Log on to '+Application.Title;
  LoginMode := true;
  LocalNeedAccessLevel := NeedAccessLevel;

  if Assigned(myMainForm) then myMainForm.Hide;
  Result := (ShowModal=mrOK);
  if (Result) then begin
    GlobalSystemUser.UserId := LocalLoginID;
    GlobalSystemUser.UserName := LocalLoginName;
    GlobalSystemUser.AccessLevel := LocalAccessLevel;
//     GlobalSystemUser.FShift:= cmbShift.Tag;
    if Assigned(myMainForm) then myMainForm.Show;
  end else begin
    //if Assigned(myMainForm) then myMainForm.Close;
  end;

end;

function TfrmLogin.Authorize(var ALoginID: string; ANeedAccessLevel: integer): boolean;
var LastBorderStyle: TFormBorderStyle; LastCaption: string;
begin
  Self.Caption := Application.Title+' - Authorization';
  LastBorderStyle := BorderStyle; BorderStyle := bsToolWindow;
  LastCaption := Caption; Caption := Application.Title+' - Otorisasi';
  LoginMode := false;
  LocalNeedAccessLevel := ANeedAccessLevel;

  if (ShowModal=mrOK) then ALoginID := LocalLoginID;
  Result := (ModalResult = mrOK);
  BorderStyle := LastBorderStyle;
  Caption := LastCaption;
end;

procedure TfrmLogin.Status(const MessageStatus: string);
begin
  Self.Caption := 'Log on to '+ Application.Title;
  lblLogin.Visible := (MessageStatus='');
  lblPassword.Visible := (MessageStatus='');
  txtLoginID.Visible := (MessageStatus='');
  txtLoginPwd.Visible := (MessageStatus='');
  btnOK.Visible := (MessageStatus='');
  btnCancel.Visible := (MessageStatus='');
  lblStatus.Caption := MessageStatus;

  try
    if (MessageStatus<>'') then begin
      if (not Self.Visible) then Self.Show;
      //if (not Self.Visible) then Self.Visible := true;
    end else begin
      if (Self.Visible) then Self.Hide;
      //if (Self.Visible) then Self.Visible := false;
    end;
  except
  end;
  Application.ProcessMessages;
end;

procedure TfrmLogin.cmbShiftChange(Sender: TObject);
begin
{  cmbShift.Tag:= 0;
  if cmbShift.ItemIndex > -1 then
    cmbShift.Tag:= StrToInt(GlobalStringList.Names[cmbShift.ItemIndex])
    }
end;

procedure TfrmLogin.cmbShiftKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = vk_return then
    if btnOk.Enabled then btnOk.SetFocus;
end;

end.
