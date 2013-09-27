unit ChangePassword;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, AdvEdit, ExtCtrls;

type
  TfrmChangePassword = class(TForm)
    txtOldPwd: TAdvEdit;
    txtNewPwd: TAdvEdit;
    txtConfNewPwd: TAdvEdit;
    btnOK: TButton;
    btnCancel: TButton;
    txtID: TAdvEdit;
    procedure FormShow(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
  private
    { Private declarations }
    FLoginID: string;
  public
    { Public declarations }
    procedure Execute(ALoginID: string ='');
  end;

var
  frmChangePassword: TfrmChangePassword;

implementation

uses Subroutines;
{$R *.dfm}

procedure TfrmChangePassword.Execute(ALoginID: string ='');
var myUser: TSystemUser;
begin
  FLoginID := ALoginID;
  txtOldPwd.Clear;
  if (FLoginID='') then begin
    txtID.Text := GlobalSystemUser.UserId;
    txtID.ReadOnly := false;
    txtOldPwd.Clear;
    txtOldPwd.Visible := true;
  end else begin
    txtID.Text := FLoginID;
    txtID.ReadOnly := true;
    myUser := TSystemUser.create;
    myUser.SelectInDB(FLoginID);
    //txtOldPwd.Text := myUser.Passwd;
    myUser.Destroy;
    //txtOldPwd.Visible := false;
  end;
  txtNewPwd.Clear;
  txtConfNewPwd.Clear;
  ShowModal;
end;

procedure TfrmChangePassword.FormShow(Sender: TObject);
begin
  //if (FLoginID='') then txtOldPwd.SetFocus else txtNewPwd.SetFocus;
  txtOldPwd.SetFocus 
end;

procedure TfrmChangePassword.btnOKClick(Sender: TObject);
var myUser: TSystemUser;
begin
  myUser := TSystemUser.create;
  try
    if (not myUser.SelectInDbX(txtID.Text,txtOldPwd.Text)) {or (myUser.Passwd<>txtOldPwd.Text)} then begin
      MessageDlg('Login atau Password Lama belum benar.',mtWarning,[mbOK],0);
      if (FLoginID='') then txtOldPwd.Clear;
      txtNewPwd.Clear;
      txtConfNewPwd.Clear;
      if (FLoginID='') then txtOldPwd.SetFocus else txtNewPwd.SetFocus;
    end else if (txtNewPwd.Text<>txtConfNewPwd.Text) then begin
      MessageDlg('Password Baru dan konfirmasinya tidak sama.',mtWarning,[mbOK],0);
      if (FLoginID='') then txtOldPwd.Clear;
      txtNewPwd.Clear;
      txtConfNewPwd.Clear;
      if (FLoginID='') then txtOldPwd.SetFocus else txtNewPwd.SetFocus;
    end else begin
      myUser.Passwd := txtNewPwd.Text;
      myUser.UpdatePasswordOnDBX;
      if (FLoginID='') then
        MessageDlg('Password anda sudah berubah.',mtInformation,[mbOK],0)
      else
        MessageDlg('Password telah diubah.',mtInformation,[mbOK],0);
      ModalResult := mrOK;
    end;
  finally
    myUser.Destroy;
  end;
end;

end.
