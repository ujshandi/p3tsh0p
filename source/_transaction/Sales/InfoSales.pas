unit InfoSales;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, AdvEdit, ComCtrls, ExtCtrls, strUtils, Menus,
  RAWPrinter;

type
  TfrmInfoSales = class(TForm)
    lblUser: TLabel;
    lblDate: TLabel;
    Bevel1: TBevel;
    lbls: TLabel;
    lblSales: TLabel;
    Label3: TLabel;
    lblRetur: TLabel;
    Label5: TLabel;
    lblDisc: TLabel;
    Bevel2: TBevel;
    Label1: TLabel;
    lblJumlah: TLabel;
    lblMesin: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    PopupMenu1: TPopupMenu;
    shift1: TMenuItem;
    All1: TMenuItem;
    Close1: TMenuItem;
    Print1: TMenuItem;
    exit1: TMenuItem;
    RAWPrinter1: TRAWPrinter;
    Label8: TLabel;
    lblAwal: TLabel;
    Label9: TLabel;
    lblKredit: TLabel;
    Label11: TLabel;
    lblDebit: TLabel;
    Label10: TLabel;
    procedure houver(Sender: TObject);
    procedure unHouver(Sender: TObject);
    procedure Label4MouseEnter(Sender: TObject);
    procedure Label4MouseLeave(Sender: TObject);
    procedure Label4Click(Sender: TObject);
    procedure shift1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    procedure loadData(AllData: boolean);
    procedure printData;
    procedure closePeriode;
  public
    procedure Execute;
  end;

var
  frmInfoSales: TfrmInfoSales;

implementation

uses Subroutines, UMaster, UQueryPackage, EpsonUtils,
  uMysqlClient, MySQLConnector;

{$R *.dfm}

procedure TfrmInfoSales.Execute;
begin
  lblMesin.Caption := TMstMaster.getName(GlobalSystemConfig.localSetting.Machine);
  lblDate.Caption  := FormatDateTime('dddd, MMMM yyyy', ServerNow);
  lblUser.Caption  := GlobalSystemUser.UserId + ' ('+TMstMaster.getName(GlobalSystemUser.FShift)+')';
  lblSales.Caption := '0';
  lblDebit.Caption := '0';
  lblKredit.Caption:= '0';
  lblDisc.Caption  := '0';
  lblRetur.Caption := '0';
  lblJumlah.Caption:= '0';
//  lblEmbalase.Caption := '0';
  ShowModal;
end;

procedure TfrmInfoSales.houver(Sender: TObject);
begin
  (Sender as TLabel).Font.Color:= clBlue;
end;

procedure TfrmInfoSales.loadData(AllData: boolean);
var rept: TMysqlResult; awal, kredit, debit: double;
begin
  try
    Screen.Cursor:= crHourGlass;

    awal:= getFloatFromSQL(
    'select sum(so_awal) '+
    'from inv_cashier_balance q '+
    'where q.cashier_id = '+FormatSQLNumber(GlobalSystemConfig.localSetting.Machine)+
    ' and q.shift_id = '+FormatSQLNumber(GlobalSystemUser.FShift)+
    ' and q.closed is null '+
    ' and q.balance_date = '+
      '(select max(sq.balance_date) from inv_cashier_balance sq '+
       'where sq.balance_date <= curdate() and sq.closed is null '+
       'and sq.cashier_id = q.cashier_id '+
       'and sq.shift_id = q.shift_id)');

    kredit:= getFloatFromSQL(
    'select sum(ifnull(sales_value - disc_value - retur_value,0)) '+
    'from inv_cashier_balance q '+
    'where q.cashier_id = '+FormatSQLNumber(GlobalSystemConfig.localSetting.Machine)+
    ' and q.jenis_bayar = 1 '+//kredit only
     IfThen(not AllData,
      //remove param
      ' and q.shift_id = '+FormatSQLNumber(GlobalSystemUser.FShift)+
      ' and q.user_id = '+FormatSQLString(GlobalSystemUser.UserId))+
    ' and q.closed is null '+
    ' and q.balance_date = '+
      '(select max(sq.balance_date) from inv_cashier_balance sq '+
       'where sq.balance_date <= curdate() and sq.closed is null '+
       'and sq.cashier_id = q.cashier_id '+
       'and sq.shift_id = q.shift_id '+
       'and sq.jenis_bayar = 1 '+
       'and sq.user_id = q.user_id)');

    debit:= getFloatFromSQL(
    'select sum(ifnull(sales_value - disc_value - retur_value,0)) '+
    'from inv_cashier_balance q '+
    'where q.cashier_id = '+FormatSQLNumber(GlobalSystemConfig.localSetting.Machine)+
    ' and q.jenis_bayar = 2 '+//debeit only
     IfThen(not AllData,
      //remove param
      ' and q.shift_id = '+FormatSQLNumber(GlobalSystemUser.FShift)+
      ' and q.user_id = '+FormatSQLString(GlobalSystemUser.UserId))+
    ' and q.closed is null '+
    ' and q.balance_date = '+
      '(select max(sq.balance_date) from inv_cashier_balance sq '+
       'where sq.balance_date <= curdate() and sq.closed is null '+
       'and sq.cashier_id = q.cashier_id '+
       'and sq.jenis_bayar = 2 '+
       'and sq.shift_id = q.shift_id '+
       'and sq.user_id = q.user_id)');

    rept:= OpenSQL(
    'select sum(ifnull(sales_value,0)), sum(ifnull(disc_value,0)), '+
    'sum(ifnull(retur_value,0)), sum(ifnull(embalase,0)) '+
    'from inv_cashier_balance q '+
    'where q.cashier_id = '+FormatSQLNumber(GlobalSystemConfig.localSetting.Machine)+
    ' and q.jenis_bayar = 0 '+//cash only
     IfThen(not AllData,
      //remove param
      ' and q.shift_id = '+FormatSQLNumber(GlobalSystemUser.FShift)+
      ' and q.user_id = '+FormatSQLString(GlobalSystemUser.UserId))+
    ' and q.closed is null '+
    ' and q.balance_date = '+
      '(select max(sq.balance_date) from inv_cashier_balance sq '+
       'where sq.balance_date <= curdate() and sq.closed is null '+
       'and sq.cashier_id = q.cashier_id '+
       'and sq.shift_id = q.shift_id '+
       'and sq.jenis_bayar = q.jenis_bayar '+
       'and sq.user_id = q.user_id)');

    if rept.RecordCount > 0 then begin
      lblAwal.Caption := FloatToStrFmt(awal, True);
      lblKredit.Caption := FloatToStrFmt(kredit, True);
      lblSales.Caption := FloatToStrFmt(debit, True);

      lblSales.Caption := FloatToStrFmt(BufferToFloat(rept.FieldValue(0)), True);
      lblDisc.Caption  := FloatToStrFmt(-BufferToFloat(rept.FieldValue(1)), True);
      lblRetur.Caption := FloatToStrFmt(-BufferToFloat(rept.FieldValue(2)), True);
//      lblEmbalase.Caption := FloatToStrFmt(BufferToFloat(rept.FieldValue(3)), True);
      lblJumlah.Caption:= FloatToStrFmt(
        awal +
        BufferToFloat(rept.FieldValue(0)) +
        BufferToFloat(rept.FieldValue(3)) -
        BufferToFloat(rept.FieldValue(1)) -
        BufferToFloat(rept.FieldValue(2)), True);
    end
    else begin
      lblSales.Caption := '0';
      lblKredit.Caption := '0';
      lblDebit.Caption := '0';
      lblDisc.Caption  := '0';
      lblRetur.Caption := '0';
//      lblEmbalase.Caption := '0';
      lblJumlah.Caption:= '0';

    end;

    if AllData then
      lblUser.Caption := 'Dicetak oleh : '+GlobalSystemUser.UserId
    else
      lblUser.Caption := GlobalSystemUser.UserId + ' ('+TMstMaster.getName(GlobalSystemUser.FShift)+')';
  finally
    Screen.Cursor:= crDefault;
  end;
{
select sum(sales_value) from cashier m
where cashier_id = 5
 -- and shift_id = 1
 -- and user_id = 'adm'
 and closed is null
and balance_date =
 (select max(balance_date) from cashier s
  where s.balance_date <= curdate()
  and s.cashier_id = 5
  and s.shift_id = m.shift_id
  and s.user_id = m.user_id)
}
end;

procedure TfrmInfoSales.unHouver(Sender: TObject);
begin
  (Sender as TLabel).Font.Color:= clBlack;
end;

procedure TfrmInfoSales.Label4MouseEnter(Sender: TObject);
begin
  houver(Sender);
end;

procedure TfrmInfoSales.Label4MouseLeave(Sender: TObject);
begin
  unHouver(Sender);
end;

procedure TfrmInfoSales.Label4Click(Sender: TObject);
begin
  case (Sender as TLabel).Tag of
    1: loadData(False);
    2: loadData(True);
    3: closePeriode;
    4: printData;
  end;
end;

procedure TfrmInfoSales.closePeriode;
begin
  if not Confirmed('Tutup transaksi hari ini?') then
    exit;

  if not close_cashier_balance then
    Alert('Tidak berhasil menutup transaksi hari ini.');
end;

procedure TfrmInfoSales.printData;
var i, x: integer;
begin

  GlobalStringList.Clear;

  GlobalStringList.Append(
    FixWidth(lblMesin.Caption, 15, taLeftJustify) +
    FixWidth(lblDate.Caption, 25, taRightJustify));

  GlobalStringList.Append(
    FixWidth(lblUser.Caption, 40, taLeftJustify));

  GlobalStringList.Append(FixWidth('-----------------------------------------',40, taLeftJustify));

  GlobalStringList.Append(
    FixWidth('Saldo Awal:', 25, taLeftJustify) +
    FixWidth(lblAwal.Caption, 15, taRightJustify));

  GlobalStringList.Append(
    FixWidth('Penjualan:', 40, taLeftJustify));

    GlobalStringList.Append(
    FixWidth('   Tunai:', 25, taLeftJustify) +
    FixWidth(lblSales.Caption, 15, taRightJustify));

    GlobalStringList.Append(
    FixWidth('   Kartu Kredit:', 25, taLeftJustify) +
    FixWidth(lblKredit.Caption, 15, taRightJustify));

    GlobalStringList.Append(
    FixWidth('   Kartu Debit:', 25, taLeftJustify) +
    FixWidth(lblDebit.Caption, 15, taRightJustify));

  GlobalStringList.Append(
    FixWidth('Potongan:', 25, taLeftJustify) +
    FixWidth(lblDisc.Caption, 15, taRightJustify));

  GlobalStringList.Append(
    FixWidth('Retur:', 25, taLeftJustify) +
    FixWidth(lblRetur.Caption, 15, taRightJustify));

{  GlobalStringList.Append(
    FixWidth('Embalase:', 25, taLeftJustify) +
    FixWidth(lblEmbalase.Caption, 15, taRightJustify));
 }
  GlobalStringList.Append(FixWidth('-------------------------',40, taRightJustify));

  GlobalStringList.Append(
    FixWidth('Jumlah:', 25, taLeftJustify) +
    FixWidth(lblJumlah.Caption, 15, taRightJustify));

  try

    //printing struk...
    x:= GlobalSystemConfig.localSetting.MarginBottom;

    for i:= 1 to x do GlobalStringList.Append(' ');
    GlobalStringList.Append(FixWidth(CompanyProfile.FCompanyName, 40, taCenter));
    GlobalStringList.Append(FixWidth(CompanyProfile.FAddress, 40, taCenter));
    GlobalStringList.Append(FixWidth(CompanyProfile.FTelp1, 40, taCenter));
    GlobalStringList.Append(FixWidth(CompanyProfile.FCity, 40, taCenter));
    if (GlobalSystemConfig.localSetting.CutterCode <> '') and (GlobalSystemConfig.localSetting.AutoCutter = 1) then
      GlobalStringList.Append(GlobalSystemConfig.localSetting.CutterCode);

    RAWPrinter1.PrinterName:= GlobalSystemConfig.localSetting.PrinterStruk;
    RAWPrinter1.DocumentTitle:= 'Report';
    RAWPrinter1.BeginDoc;
    RAWPrinter1.Write(GlobalStringList.Text);
    RAWPrinter1.EndDoc;

    except raise;
      Inform('Priter tidak terpasang.');
  end;

end;

procedure TfrmInfoSales.shift1Click(Sender: TObject);
begin
  case (Sender as TMenuItem).Tag of
    1: loadData(False);
    2: loadData(True);
    3: closePeriode;
    4: printData;
  end;
end;

procedure TfrmInfoSales.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = vk_escape then ModalResult:= mrOK
end;

end.
