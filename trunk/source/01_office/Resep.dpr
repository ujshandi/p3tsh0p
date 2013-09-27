program Resep;

uses
  Forms,
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
  AutoStockLine in '..\_global\StockLine\AutoStockLine.pas',
  About in '..\_global\About.pas' {frmAbout},
  AddUser in '..\_global\AddUser.pas' {frmAddUser},
  bcchksum in '..\_global\bcchksum.pas',
  ChangePassword in '..\_global\ChangePassword.pas' {frmChangePassword},
  EpsonUtils in '..\_global\EpsonUtils.pas',
  frmDockForm in '..\_global\frmDockForm.pas' {DockForm},
  HtmlHlp in '..\_global\HtmlHlp.pas',
  KelolaUser in '..\_global\KelolaUser.pas' {frmKelolaUser},
  Login in '..\_global\Login.pas' {frmLogin},
  LookupData in '..\_global\LookupData.pas' {frmLookup},
  MainMenu in 'MainMenu.pas' {frmMainMenu},
  Option in '..\_global\Option.pas' {frmOption},
  Subroutines in '..\_global\Subroutines.pas',
  UConst in '..\_global\UConst.pas',
  UConstTool in '..\_global\UConstTool.pas',
  UMaster in '..\_global\UMaster.pas',
  UQueryPackage in '..\_global\UQueryPackage.pas',
  UTransaction in '..\_global\UTransaction.pas',
  MstCode in '..\_master\MstCode.pas' {frmMstCode},
  MstCodeList in '..\_master\MstCodeList.pas' {frmMstCodeList},
  MstItem in '..\_master\MstItem.pas' {frmMstItem},
  MstItemList in '..\_master\MstItemList.pas' {frmMstItemList},
  mstItemListPrint in '..\_master\mstItemListPrint.pas' {qrpItemList: TQuickRep},
  MstRak in '..\_master\MstRak.pas' {frmMstRak},
  MstUnit in '..\_master\MstUnit.pas' {frmMstUnit},
  ReportItemMovement in '..\_report\ReportItemMovement.pas' {frmReportItemMovement},
  ReportItemMovementPrint in '..\_report\ReportItemMovementPrint.pas' {qrpReportItemMovement: TQuickRep},
  ReportItemMutasiPrint in '..\_report\ReportItemMutasiPrint.pas' {qrpReportItemMutasi: TQuickRep},
  ReportItemQty in '..\_report\ReportItemQty.pas' {frmReportItemQty},
  ReportJualPrint in '..\_report\ReportJualPrint.pas' {qrpReportJual: TQuickRep},
  ReportPenjualan in '..\_report\ReportPenjualan.pas' {frmReportPenjualan},
  ReportPenjualan1Print in '..\_report\ReportPenjualan1Print.pas' {qrpReportPenjualan1: TQuickRep},
  ReportStok in '..\_report\ReportStok.pas' {frmReportStok},
  RepotItemStokPrint in '..\_report\RepotItemStokPrint.pas' {qrpRepotItemStok: TQuickRep},
  trsSales2 in '..\_transaction\Sales\trsSales2.pas' {frmTrsSales2},
  trsSalesList in '..\_transaction\Sales\trsSalesList.pas' {frmTrsSalesList},
  TrsItemShipment in '..\_transaction\Shipment\TrsItemShipment.pas' {frmTrsItemShipment},
  TrsItemShipmentList in '..\_transaction\Shipment\TrsItemShipmentList.pas' {frmTrsItemShipmentList},
  BackupRestore in '..\_global\BackupRestore.pas' {frmBackupRestore},
  FormOpnamePrint in '..\_transaction\Shipment\FormOpnamePrint.pas' {qrpFormOpname: TQuickRep},
  MstDokter in '..\_master\MstDokter.pas' {frmMstDokter},
  MstDokterList in '..\_master\MstDokterList.pas' {frmMstDokterList},
  MstPaketList in '..\_master\MstPaketList.pas' {frmMstPaketList},
  MstPaket in '..\_master\MstPaket.pas' {frmMstPaket},
  MstPasien in '..\_master\MstPasien.pas' {frmMstPasien},
  MstPasienList in '..\_master\MstPasienList.pas' {frmMstPasienList},
  PasienListPrint in '..\_master\PasienListPrint.pas' {qrpPasienList: TQuickRep},
  DokterListPrint in '..\_master\DokterListPrint.pas' {qrpDokterList: TQuickRep},
  MstItemLama in '..\_master\MstItemLama.pas' {frmMstItemLama},
  MstProdusen in '..\_master\MstProdusen.pas' {frmMstProdusen};

{$R *.res}

begin
  Application.Initialize;
  InitializeApplication;

  Application.CreateForm(TfrmMainMenu, frmMainMenu);
  Application.CreateForm(TfrmLogin, frmLogin);

  frmLogin.Status('Louncing Application...');
  frmLogin.Status('Connecting database...');
  Application.CreateForm(TfrmBackupRestore, frmBackupRestore);
  Application.CreateForm(TfrmDatabaseConnection, frmDatabaseConnection);
  ConnetToDB;

  frmLogin.Status('Loading system setting...');
  Application.CreateForm(TDockForm, DockForm);
  Application.CreateForm(TfrmAbout, frmAbout);
  Application.CreateForm(TfrmAddUser, frmAddUser);
  Application.CreateForm(TfrmChangePassword, frmChangePassword);
  Application.CreateForm(TfrmOption, frmOption);

  frmLogin.Status('Loading master module(s)...');
  //Application.CreateForm(TfrmLookupTrx, frmLookupTrx);
  Application.CreateForm(TfrmMstCodeList, frmMstCodeList);
  Application.CreateForm(TfrmMstItem, frmMstItem);

  frmLogin.Status('dumping dockable module(s)...');
  frmLogin.Status('Loading sales module(s)...');
  //Application.CreateForm(TfrmMstRelation, frmMstRelation);
  Application.CreateForm(TfrmLookup, frmLookup);

  Application.CreateForm(TfrmMstDokter, frmMstDokter);
  Application.CreateForm(TfrmMstPaket, frmMstPaket);
  Application.CreateForm(TfrmMstPasien, frmMstPasien);
  Application.CreateForm(TfrmMstProdusen, frmMstProdusen);

  frmLogin.Status('Louncing Application...');
  frmLogin.Status;
  RearrangeForms;
  Application.Run;
end.
