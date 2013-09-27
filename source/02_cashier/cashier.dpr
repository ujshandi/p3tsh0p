program cashier;

uses
  Forms,
  MainMenu in 'MainMenu.pas' {frmMainMenu},
  DatabaseConnection in '..\_connection_\DatabaseConnection.pas' {frmDatabaseConnection},
  MySQLConnector in '..\_connection_\MySQLConnector.pas',
  uMysqlClient in '..\_connection_\uMysqlClient.pas',
  uMysqlCT in '..\_connection_\uMysqlCT.pas',
  uMysqlErrors in '..\_connection_\uMysqlErrors.pas',
  uMysqlHelpers in '..\_connection_\uMysqlHelpers.pas',
  uMysqlNet in '..\_connection_\uMysqlNet.pas',
  uMysqlNewPassword in '..\_connection_\uMysqlNewPassword.pas',
  umysqlsha1 in '..\_connection_\umysqlsha1.pas',
  uMysqlSSL in '..\_connection_\uMysqlSSL.pas',
  uMysqlVio in '..\_connection_\uMysqlVio.pas',
  LOVFlat in '..\_global\LOVFlat.pas' {frmLovFlat},
  Option in '..\_global\Option.pas' {frmOption},
  Subroutines in '..\_global\Subroutines.pas',
  UConst in '..\_global\UConst.pas',
  UConstTool in '..\_global\UConstTool.pas',
  UMaster in '..\_global\UMaster.pas',
  UQueryPackage in '..\_global\UQueryPackage.pas',
  UTransaction in '..\_global\UTransaction.pas',
  ChangePassword in '..\_global\ChangePassword.pas' {frmChangePassword},
  EpsonUtils in '..\_global\EpsonUtils.pas',
  frmDockForm in '..\_global\frmDockForm.pas' {DockForm},
  HtmlHlp in '..\_global\HtmlHlp.pas',
  Login in '..\_global\Login.pas' {frmLogin},
  InfoPrice in '..\_transaction\Sales\InfoPrice.pas' {frmInfoPrice},
  InfoSales in '..\_transaction\Sales\InfoSales.pas' {frmInfoSales},
  InputBox1 in '..\_transaction\Sales\InputBox1.pas' {frmInputBox1},
  InputBoxCustomer in '..\_transaction\Sales\InputBoxCustomer.pas' {frmInputBoxCustomer},
  InputBoxTax in '..\_transaction\Sales\InputBoxTax.pas' {frmInputBoxTax},
  InputBoxTotal in '..\_transaction\Sales\InputBoxTotal.pas' {frmInputBoxTotal},
  trsSales in '..\_transaction\Sales\trsSales.pas' {frmTrsSales},
  trsSalesHoldedList in '..\_transaction\Sales\trsSalesHoldedList.pas' {frmTrsSalesHoldedList},
  AutoStockLine in '..\_global\StockLine\AutoStockLine.pas',
  InputBoxPilihHarga in '..\_transaction\Sales\InputBoxPilihHarga.pas' {frmInputBoxPilihHarga},
  InputBoxSaldoAwal in '..\_transaction\Sales\InputBoxSaldoAwal.pas' {frmInputBoxSaldoAwal},
  MstPasien in '..\_master\MstPasien.pas' {frmMstPasien},
  MstDokter in '..\_master\MstDokter.pas' {frmMstDokter},
  LookupFreeService in '..\_global\LookupFreeService.pas' {frmLookupFreeService},
  MstCodeList in '..\_master\MstCodeList.pas' {frmMstCodeList},
  UPetshop in '..\_global\UPetshop.pas',
  MstRelationAnimal in '..\_master\MstRelationAnimal.pas' {frmMstRelationAnimal},
  MoneyTransaction in '..\_transaction\Finance\MoneyTransaction.pas' {frmMoneyTransaction},
  RawPrintPrev in '..\_global\RawPrintPrev.pas' {RawPrintPreview},
  RAWPrinter in '..\_global\RawPrinter.pas',
  LookupData in '..\_global\LookupData.pas' {frmLookup};

{$R *.res}

begin
  Application.Initialize;
  InitializeApplication;

  Application.CreateForm(TfrmMainMenu, frmMainMenu);
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.CreateForm(TfrmMstRelationAnimal, frmMstRelationAnimal);
  Application.CreateForm(TfrmMoneyTransaction, frmMoneyTransaction);
  Application.CreateForm(TfrmLookup, frmLookup);
  Application.CreateForm(TfrmLookupFreeService, frmLookupFreeService);
  frmLogin.Status('Louncing Application...');
  frmLogin.Status('Connecting database...');
  Application.CreateForm(TfrmDatabaseConnection, frmDatabaseConnection);
  ConnetToDB;

  frmLogin.Status('Loading system setting...');
  Application.CreateForm(TDockForm, DockForm);
  Application.CreateForm(TfrmChangePassword, frmChangePassword);
  Application.CreateForm(TfrmLovFlat, frmLovFlat);
  Application.CreateForm(TfrmOption, frmOption);
  Application.CreateForm(TfrmMstCodeList, frmMstCodeList);
  frmLogin.Status('Loading master module(s)...');

  frmLogin.Status('Loading sales module(s)...');
  Application.CreateForm(TfrmInputBox1, frmInputBox1);
  Application.CreateForm(TfrmInputBoxTotal, frmInputBoxTotal);
  Application.CreateForm(TfrmInputBoxTax, frmInputBoxTax);
  Application.CreateForm(TfrmInputBoxCustomer, frmInputBoxCustomer);
  Application.CreateForm(TfrmTrsSalesHoldedList, frmTrsSalesHoldedList);
  Application.CreateForm(TfrmInputBoxPilihHarga, frmInputBoxPilihHarga);

  Application.CreateForm(TfrmInfoPrice, frmInfoPrice);
  Application.CreateForm(TfrmInfoSales, frmInfoSales);

  Application.CreateForm(TfrmInputBoxSaldoAwal, frmInputBoxSaldoAwal);
  Application.CreateForm(TfrmMstPasien, frmMstPasien);
  Application.CreateForm(TfrmMstDokter, frmMstDokter);
  Application.CreateForm(TfrmLookup, frmLookup);


  frmOption.getScannerSetting;

  frmLogin.Status('Louncing Application...');
  frmLogin.Status;
  RearrangeForms;
  Application.Run;
end.
