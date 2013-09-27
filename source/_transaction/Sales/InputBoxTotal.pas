unit InputBoxTotal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, AdvEdit;

type
  TfrmInputBoxTotal = class(TForm)
    txtGrandTotal: TAdvEdit;
    txtCash: TAdvEdit;
    txtCashBack: TAdvEdit;
    btnOK: TButton;
    Button2: TButton;
    Label1: TLabel;
    Edit1: TEdit;
    cmbJenisBayar: TComboBox;
    txtCard: TAdvEdit;
    txtBank: TAdvEdit;
    Label2: TLabel;
    procedure txtCashKeyPress(Sender: TObject; var Key: Char);
    procedure txtCashKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure txtCashValueValidate(Sender: TObject; value: String;
      var IsValid: Boolean);
    procedure FormShow(Sender: TObject);
    procedure txtCashEnter(Sender: TObject);
    procedure cmbJenisBayarChange(Sender: TObject);
    procedure cmbJenisBayarKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    vPasienID: integer;
    procedure calculate;
  public
    function Execute(vGrandTotal: Double; PasienID: integer): boolean;
  end;

var
  frmInputBoxTotal: TfrmInputBoxTotal;

  JENIS_BAYAR: INTEGER;
  CARD_ID, BANK_NAME: STRING;
  NILAI_UANG : DOUBLE;

implementation

uses Subroutines, trsSales, UConst, MySQLConnector, UMaster;

{$R *.dfm}

procedure TfrmInputBoxTotal.txtCashKeyPress(Sender: TObject;
  var Key: Char);
begin
  Key:= IgnoreChar(Key);
end;

procedure TfrmInputBoxTotal.txtCashKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var tmp: string;
begin
  case Key of
    VK_RETURN :
    begin
      if StrFmtToFloatDef(txtCash.Text,0, True) > 99999999 then begin
        ShowMessage('Nilai terlalu besar tunai.');
        txtCash.SetFocus;
        txtCash.SelectAll;
      end
      else if StrFmtToFloatDef(txtCash.Text,0, True) <  StrFmtToFloatDef(txtGrandTotal.Text,0, True) then begin
        Alert(
          'Pembayaran kurang dari nilai penjualan.');
//          'Kembali ke nilai tunai ?'); //then calculate
//        else begin
          txtCash.SetFocus;
          txtCash.SelectAll;
       // end;
      end
      else calculate;
     end;
    VK_ADD:
    begin
      tmp:= FloatToStr(StrFmtToFloatDef(txtCash.Text,0, True)) + '000';
      txtCash.Text:= tmp;
   //txtCash.SelStart:= length(txtCash.Text);
    end;

    VK_ESCAPE: ModalResult:= mrCancel;

  end;
end;

procedure TfrmInputBoxTotal.calculate;
var total: Double; issaved: boolean;
begin
  total:= StrFmtToFloatDef(txtGrandTotal.Text,0, true);
  NILAI_UANG:= StrFmtToFloatDef(txtCash.Text,0, true);
//  if tunai = 0 then tunai:= total;
  txtCash.Text:= FloatToStrFmt(NILAI_UANG,true);
  if total >= 0 then
    txtCashBack.Text:= FloatToStrFmt(NILAI_UANG-total, true)
  else txtCashBack.Text:= FloatToStrFmt(NILAI_UANG + total, true);

  JENIS_BAYAR:= cmbJenisBayar.ItemIndex;
  CARD_ID:= txtCard.Text;
  BANK_NAME:= txtBank.Text;
  issaved:= frmTrsSales.isSaved();
  Button2.Enabled:= not issaved;
  btnOK.Enabled:= issaved;
  txtCash.Enabled:= not issaved;
  cmbJenisBayar.Enabled:= not issaved;
  txtCard.Enabled:= not issaved;
  txtBank.Enabled:= not issaved;
 // if issaved then TMstPasien.UpdateCardID(vPasienID, txtCard.Text);

  Edit1.SetFocus;
end;

function TfrmInputBoxTotal.Execute(vGrandTotal: Double; PasienID: integer): boolean;
begin
  vPasienID:= PasienID;
  txtCash.Enabled:= True;
  txtGrandTotal.Text:= FloatToStrFmt(vGrandTotal, true);
  txtCash.Clear;
  txtCashBack.Clear;
  btnOK.Enabled:= False;
  Button2.Enabled := True;
  cmbJenisBayar.Enabled:= True;
  cmbJenisBayar.ItemIndex:= 0;
  cmbJenisBayarChange(nil);
  txtCard.Clear;
  txtBank.Clear;
  ShowModal;
  Result:= ModalResult = mrOk;
end;

procedure TfrmInputBoxTotal.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_F9: frmTrsSales.Print;
    VK_ESCAPE: if Button2.Enabled then ModalResult:= mrCancel;
  end;
end;

procedure TfrmInputBoxTotal.Edit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
case Key of
    VK_RETURN: begin
      txtCash.Enabled:= True;
      ModalResult:= mrOk;
    end;
    //VK_DECIMAL:
    //begin
   //   txtCash.Text:= txtCash.Text + '000';
    //  txtCash.SelStart:= length(txtCash.Text);
   //   txtCash.SetFocus;
   // end;
    VK_ESCAPE:
    if Button2.Enabled then begin
      txtCash.Enabled:= True;
      ModalResult:= mrCancel;
    end;
   // else  txtCash.SetFocus;
  end;
end;

procedure TfrmInputBoxTotal.txtCashValueValidate(Sender: TObject;
  value: String; var IsValid: Boolean);
begin
  AdvEdtFloatFmt(Sender, value, true)
end;

procedure TfrmInputBoxTotal.FormShow(Sender: TObject);
begin
  cmbJenisBayar.SetFocus;
  //txtCash.SetFocus;
  txtCash.SelStart:= 1;
end;

procedure TfrmInputBoxTotal.txtCashEnter(Sender: TObject);
begin
  txtCash.SelStart:= length(txtCash.Text);
end;

procedure TfrmInputBoxTotal.cmbJenisBayarChange(Sender: TObject);
begin
  txtCard.Clear;
  txtBank.Clear;
  txtCard.Enabled:= cmbJenisBayar.ItemIndex <> 0;
  txtBank.Enabled:= cmbJenisBayar.ItemIndex <> 0;
  if cmbJenisBayar.ItemIndex > 0 then txtCash.Text:= txtGrandTotal.Text
  else txtCash.Clear;
 // if (cmbJenisBayar.ItemIndex > 0) and (vPasienID <> 0) then
 //   txtCard.Text:= TMstPasien.GetCardID(vPasienID)
 // else txtCard.Clear;
end;

procedure TfrmInputBoxTotal.cmbJenisBayarKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = vk_return then
    GoNextControl(Self, (Sender AS TWinControl), true, true, false).SetFocus
end;

end.
