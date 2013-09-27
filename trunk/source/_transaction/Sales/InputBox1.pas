unit InputBox1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, AdvEdit, math;

type
  TfrmInputBox1 = class(TForm)
    txtValue: TAdvEdit;
    Button1: TButton;
    Button2: TButton;
    procedure txtValueValueValidate(Sender: TObject; value: String;
      var IsValid: Boolean);
    procedure txtValueKeyPress(Sender: TObject; var Key: Char);
    procedure txtValueKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    function Execute(var value: double; capt: string; validasi: boolean): boolean;
  end;

var
  frmInputBox1: TfrmInputBox1;

implementation

uses Subroutines, MySQLConnector;

{$R *.dfm}

procedure TfrmInputBox1.txtValueValueValidate(Sender: TObject;
  value: String; var IsValid: Boolean);
begin
  AdvEdtFloatFmt(Sender, value);
end;

function TfrmInputBox1.Execute(var value: double; capt: string; validasi: boolean): boolean;
begin
  txtValue.Tag:= IfThen(validasi, -1, 0);
  Self.Caption:= capt;
  txtValue.text:= FloatToStrFmt(value);
  ShowModal;
  Result:= ModalResult = mrOK;
  if Result then value:= StrFmtToFloatDef(txtValue.Text,0);
end;

procedure TfrmInputBox1.txtValueKeyPress(Sender: TObject; var Key: Char);
begin
  Key:= IgnoreChar(Key)
end;

procedure TfrmInputBox1.txtValueKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
   vk_return : ModalResult := mrOK;
   VK_ESCAPE : ModalResult := mrCancel;
  end;
end;

procedure TfrmInputBox1.Button1Click(Sender: TObject);
begin
   if (StrFmtToFloatDef(txtValue.Text,0) < 0) and (txtValue.Tag=-1) then
     Alert('Nilai tidak boleh < 0.')
   else ModalResult:= mrOk;
end;

end.
