unit InputBoxTax;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, AdvEdit;

type
  TfrmInputBoxTax = class(TForm)
    txtDisc: TAdvEdit;
    txtDiscPrc: TAdvEdit;
    txtTax: TAdvEdit;
    btnOK: TButton;
    Button2: TButton;
    procedure txtTaxKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnOKClick(Sender: TObject);
  private
    function isValid: boolean;
  public
    function Execute(): boolean;
  end;

var
  frmInputBoxTax: TfrmInputBoxTax;

implementation

uses Subroutines, UConst, MySQLConnector;

{$R *.dfm}

{ TfrmInputBoxTax }

function TfrmInputBoxTax.Execute(): boolean;
begin
  txtDisc.Text   := FloatToStrFmt(StrToFloatDef(GlobalSystemConfig[CONF_DISC_VAL_PROMO-1].ConfValue,0));
  txtDiscPrc.Text:= FloatToStrFmt(StrToFloatDef(GlobalSystemConfig[CONF_DISC_PROMO-1].ConfValue,0));
  txtTax.Text    := FloatToStrFmt(StrToFloatDef(GlobalSystemConfig[CONF_PPn-1].ConfValue,0));
  ShowModal;
  Result:= ModalResult = mrOk;
  if Result then begin
    GlobalSystemConfig.UpdateOnDB(CONF_DISC_PROMO, FormatSQLNumber(StrFmtToFloatDef(txtDiscPrc.Text,0)));
    GlobalSystemConfig.UpdateOnDB(CONF_DISC_VAL_PROMO, FormatSQLNumber(StrFmtToFloatDef(txtDisc.Text,0)));
    GlobalSystemConfig.UpdateOnDB(CONF_PPn, FormatSQLNumber(StrFmtToFloatDef(txtTax.Text,0)));
    GlobalSystemConfig.loadFromDB;
  end;

end;

procedure TfrmInputBoxTax.txtTaxKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = vk_return then ModalResult := mrOK;
end;

procedure TfrmInputBoxTax.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
   //vk_return : ModalResult := mrOK;
   VK_ESCAPE : ModalResult := mrCancel;
  end;
end;

procedure TfrmInputBoxTax.btnOKClick(Sender: TObject);
begin
  if isValid then ModalResult:= mrOK;
end;

function TfrmInputBoxTax.isValid: boolean;
begin
  if CekInput(Result, StrFmtToFloatDef(txtDisc.Text, 0) >= 0, 'Nilai tidak boleh < 0.', txtDisc) then
    if CekInput(Result, StrFmtToFloatDef(txtDiscPrc.Text, 0) >= 0, 'Nilai tidak boleh < 0.', txtDiscPrc) then
      CekInput(Result, StrFmtToFloatDef(txtTax.Text, 0) >= 0, 'Nilai tidak boleh < 0.', txtTax);
end;

end.
