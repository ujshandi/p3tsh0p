unit InputBoxHarga;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, math;

type
  TfrmInputBoxHarga = class(TForm)
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    Label1: TLabel;
    Label2: TLabel;
    Button1: TButton;
    Button2: TButton;
    procedure RadioButton1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    procedure selectHarga(ID: integer);
  public
    function Execute(var hargaBaru: double; id: integer): boolean;
  end;

var
  frmInputBoxHarga: TfrmInputBoxHarga;

implementation

uses uMysqlClient, MySQLConnector, Subroutines;

{$R *.dfm}

{ TfrmInputBoxHarga }

function TfrmInputBoxHarga.Execute(var hargaBaru: double;
  id: integer): boolean;
begin
  selectHarga(id);
  ShowModal;
  Result:= ModalResult = mrOk;
  if Result then
    hargaBaru:= IfThen(RadioButton1.Checked=true,
      StrFmtToFloatDef(Label1.Caption,0),
      StrFmtToFloatDef(Label2.Caption,0));
end;

procedure TfrmInputBoxHarga.selectHarga(ID: integer);
var sqL: string; buffer: TMysqlResult;
begin
  Label1.Caption:= '0';
  Label2.Caption:= '0';
  sqL:=
  'select sales_price, sales_price2 from mst_item_conversion '+
  'where conv_id = '+FormatSQLNumber(ID);
  buffer:= OpenSQL(sqL);
  if buffer.RecordCount > 0 then
  with buffer do begin
    Label1.Caption:= FloatToStrFmt(BufferToFloat(FieldValue(0)));
    Label2.Caption:= FloatToStrFmt(BufferToFloat(FieldValue(1)));
  end;
  buffer.Destroy;
end;

procedure TfrmInputBoxHarga.RadioButton1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_RETURN: ModalResult:= mrOk;
    VK_ESCAPE: ModalResult:= mrCancel;
  end;
end;

procedure TfrmInputBoxHarga.FormShow(Sender: TObject);
begin
  RadioButton1.SetFocus;
end;

end.
