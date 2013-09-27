unit InputBoxSaldoAwal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, AdvEdit;

type
  TfrmInputBoxSaldoAwal = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    txtSaldo: TAdvEdit;
    lblDate: TLabel;
    lblKasir: TLabel;
    lblShip: TLabel;
    Button1: TButton;
    Button2: TButton;
    procedure txtSaldoKeyPress(Sender: TObject; var Key: Char);
    procedure txtSaldoValueValidate(Sender: TObject; value: String;
      var IsValid: Boolean);
    procedure Button2Click(Sender: TObject);
    procedure txtSaldoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    function isSaved: boolean;
  public
    procedure Execute();
  end;

var
  frmInputBoxSaldoAwal: TfrmInputBoxSaldoAwal;

implementation

uses MySQLConnector, Subroutines, UMaster, UTransaction;

{$R *.dfm}

{ TfrmInputBoxSaldoAwal }

procedure TfrmInputBoxSaldoAwal.Execute;
begin
  lblDate.Caption := FormatDateTime('dd, MMMM yyyy', ServerNow);
  lblKasir.Caption:= TMstMaster.getName(GlobalSystemConfig.localSetting.Machine);
  lblShip.Caption := TMstMaster.getName(GlobalSystemUser.FShift);
  txtSaldo.Text   := FloatToStr(TTrsSales.getSaldoAwal);
  ShowModal;
end;

function TfrmInputBoxSaldoAwal.isSaved: boolean;
begin
  Result:= TTrsSales.InsertSaldoAwal(StrFmtToFloatDef(txtSaldo.Text,0));
end;

procedure TfrmInputBoxSaldoAwal.txtSaldoKeyPress(Sender: TObject;
  var Key: Char);
begin
  IgnoreChar(Key)
end;

procedure TfrmInputBoxSaldoAwal.txtSaldoValueValidate(Sender: TObject;
  value: String; var IsValid: Boolean);
begin
  AdvEdtFloatFmt(Sender, value, true)
end;

procedure TfrmInputBoxSaldoAwal.Button2Click(Sender: TObject);
begin
  if isSaved then ModalResult:= mrOk
end;

procedure TfrmInputBoxSaldoAwal.txtSaldoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case key of VK_RETURN: isSaved;
  end;
end;

end.
