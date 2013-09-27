unit InfoPrice;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, AdvEdit, ExtCtrls, StrUtils;

type
  TfrmInfoPrice = class(TForm)
    AdvEdit1: TAdvEdit;
    lblNama: TLabel;
    lblPrice: TLabel;
    lblOnhand: TLabel;
    Label1: TLabel;
    lblPriceCapt: TLabel;
    Label4: TLabel;
    Bevel1: TBevel;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure AdvEdit1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    procedure loadData;
  public
    procedure Execute;
  end;

var
  frmInfoPrice: TfrmInfoPrice;

implementation

uses UMaster, MySQLConnector, Subroutines;

{$R *.dfm}

{ TfrmInfoPrice }

procedure TfrmInfoPrice.loadData;
var item: TMstItem;
begin
  item:= TMstItem.Create;
  item.ItemId:= 0;
  item.Barcode:= AdvEdit1.Text;
  if item.SelectInDB then begin
     lblNama.Caption  := item.ItemName;
     lblPrice.Caption := FloatToStrFmt(item.SellingPrice);//TMstItemConversion.GetSalesPriceDesc(item.ItemID);
     lblOnhand.Caption:=FloatToStrFmt(item.CurrentStock);
//     AnsiReplaceStr(
  //   TMstItemConversion.GetStockDescription(item.ItemId, round(item.CurrentStock)), #$20, #13#10);
  end else
    Inform('Item tidak ditemukan.');

end;

procedure TfrmInfoPrice.Button1Click(Sender: TObject);
begin
  ModalResult:= mrOk
end;

procedure TfrmInfoPrice.AdvEdit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    vk_return, VK_CONTROL: loadData;
    VK_ESCAPE: ModalResult:= mrOk;
  end;
end;

procedure TfrmInfoPrice.Execute;
begin
  AdvEdit1.Clear;
  lblNama.Caption:= '...';
  lblPrice.Caption:= '...';
  lblOnhand.Caption:= '...';
  ShowModal;
end;

end.
