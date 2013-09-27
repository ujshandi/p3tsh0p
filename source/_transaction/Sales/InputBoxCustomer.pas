unit InputBoxCustomer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, AdvEdit, StrUtils;

type
  TfrmInputBoxCustomer = class(TForm)
    AdvEdit1: TAdvEdit;
    lblNamaCapt: TLabel;
    lblAlamatCapt: TLabel;
    lblPointCapt: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    lblNama: TLabel;
    lblAlamat: TLabel;
    lblPoint: TLabel;
    Button1: TButton;
    btnOK: TButton;
    procedure AdvEdit1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    procedure getCustomer;
  public
    function Execute(var CustID, JnsCust: integer): boolean;
  end;

var
  frmInputBoxCustomer: TfrmInputBoxCustomer;

implementation

uses uMysqlClient, MySQLConnector, UConst, UConstTool;

{$R *.dfm}

{ TfrmInputBoxCustomer }

procedure TfrmInputBoxCustomer.getCustomer;
var cust: TMysqlResult;
begin
  lblNama.Caption  := '';
  lblAlamat.Caption:= '';
  lblPoint.Caption := '0';
  lblNama.Tag:= 0;
  AdvEdit1.Tag:= 0;

  cust:= OpenSQL(
  'select relation_id, relation_type, relation_name, address1, current_point '+
  'from mst_relation '+
  'where relation_code = '+FormatSQLString(AdvEdit1.Text));
  btnOK.Enabled := cust.RecordCount>0;
  if cust.RecordCount > 0 then begin
    case BufferToInteger(cust.FieldValue(1)) of
      RELASI_TYPE_CUSTOMER: begin
        lblNamaCapt.Caption:= 'Customer';
        lblNama.Tag:= PROD_CUST_CUSTOMER;
      end;
      RELASI_TYPE_MEMBER: begin
        lblNamaCapt.Caption:= 'Member';
        lblNama.Tag:= PROD_CUST_MEMBER;
      end;
      else begin
        lblNamaCapt.Caption:= 'Undefined';
        lblNama.Tag:= PROD_CUST_UNREG;
      end;
    end;

    AdvEdit1.Tag:= BufferToInteger(cust.FieldValue(0));
    lblNama.Caption:= cust.FieldValue(2);
    lblAlamat.Caption:= cust.FieldValue(3);
    lblPoint.Caption:= FloatToStrFmt(BufferToInteger(cust.FieldValue(3)));
    AdvEdit1.Modified:= False;
    //Edit1.SetFocus;

  end
  else begin
    ShowMessage('Customer/Member tidak terdaftar.');
    AdvEdit1.SetFocus;
  end;
  cust.destroy;

end;

procedure TfrmInputBoxCustomer.AdvEdit1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (ssCtrl in Shift) and (Chr(Key) in['O', 'o']) then
    ModalResult:= mrOk
  else
  case Key of
    VK_RETURN:
    begin
      if (not AdvEdit1.Modified) and (AdvEdit1.Tag <> 0) then ModalResult:= mrOk
      else begin
        getCustomer;
        AdvEdit1.SelectAll;
      end;  

    end;
    VK_ESCAPE: ModalResult:= mrCancel;
  end;
end;

function TfrmInputBoxCustomer.Execute(var CustID,
  JnsCust: integer): boolean;
begin
  lblNama.Caption  := '';
  lblAlamat.Caption:= '';
  lblPoint.Caption := '0';
  lblNama.Tag:= 0;
  AdvEdit1.Tag:= 0;
  AdvEdit1.Clear;
  btnOK.Enabled:= False;
  ShowModal;
  Result:= ModalResult = mrOk;
  if Result then begin
    CustID:= AdvEdit1.Tag;
    JnsCust:= lblNama.Tag;
  end;
end;

procedure TfrmInputBoxCustomer.FormShow(Sender: TObject);
begin
  AdvEdit1.SetFocus
end;

procedure TfrmInputBoxCustomer.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_ESCAPE: ModalResult:= mrCancel;
  end;
end;

end.
