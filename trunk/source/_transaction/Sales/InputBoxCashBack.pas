unit InputBoxCashBack;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, AdvEdit;

type
  TfrmInputBoxCashBack = class(TForm)
    btnOK: TButton;
    txtCashBack: TAdvEdit;
    Label1: TLabel;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    function Execute(vValue: Double): boolean;
  end;

var
  frmInputBoxCashBack: TfrmInputBoxCashBack;

implementation

uses Subroutines, j_idol, MySQLConnector;

{$R *.dfm}

{ TfrmInputBoxCashBack }

function TfrmInputBoxCashBack.Execute(vValue: Double): boolean;
begin
  txtCashBack.Text:= FloatToStrFmt(vValue);
  ShowModal;
  Result:= True;
end;

procedure TfrmInputBoxCashBack.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  //if Key = vk_f9 then
end;

end.
