unit Option;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, AdvEdit,strUtils, ExtCtrls, ComCtrls,IniFiles, Math,
  Grids, ValEdit, mxProtector, BaseGrid, AdvGrid, Registry;

type
  TfrmOption = class(TForm)
    btnSave: TButton;
    btnCancel: TButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Bevel1: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    txtName: TAdvEdit;
    txtAddress: TAdvEdit;
    txtCity: TAdvEdit;
    txtTelp1: TAdvEdit;
    txtTelp2: TAdvEdit;
    txtFax: TAdvEdit;
    txtBranch: TAdvEdit;
    mmInfo: TMemo;
    StaticText1: TStaticText;
    TabSheet2: TTabSheet;
    Bevel2: TBevel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    txtDbName: TAdvEdit;
    txtDbUser: TAdvEdit;
    txtDbPwd: TAdvEdit;
    StaticText2: TStaticText;
    Label9: TLabel;
    txtSerialNumber: TAdvEdit;
    mxProtector1: TmxProtector;
    hide: TButton;
    btnRegister: TButton;
    Image1: TImage;
    btnReset: TButton;
    btnKoneksi: TButton;
    TabSheet4: TTabSheet;
    chkInven: TCheckBox;
    chkPrice: TCheckBox;
    Bevel4: TBevel;
    StaticText6: TStaticText;
    txtFooter1: TAdvEdit;
    txtFooter2: TAdvEdit;
    txtMarginBottom: TAdvEdit;
    txtMarginTop: TAdvEdit;
    UpDown1: TUpDown;
    UpDown2: TUpDown;
    chkCutOff: TCheckBox;
    chkPrint: TCheckBox;
    Bevel7: TBevel;
    StaticText9: TStaticText;
    cmbKasir: TComboBox;
    txtPostCode: TAdvEdit;
    txtTax: TAdvEdit;
    cmbPrinterName: TComboBox;
    Label8: TLabel;
    cmbPort: TComboBox;
    Label10: TLabel;
    Label11: TLabel;
    cmbGudang: TComboBox;
    Label12: TLabel;
    cmbHost: TComboBox;
    cmbPrnStruk: TComboBox;
    cmbPrnAdm: TComboBox;
    cmbPrnBarcode: TComboBox;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Bevel3: TBevel;
    StaticText5: TStaticText;
    chkLog: TCheckBox;
    chkSerialKeys: TCheckBox;
    txtSerialPort: TAdvEdit;
    txtSerialBaud: TAdvEdit;
    btnBranch: TButton;
    btnEmpty: TButton;
    procedure btnCancelClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure mxProtector1GetSerialNumber(Sender: TObject; var UserName,
      SerialNumber: String);
    procedure mxProtector1InvalidSerialNumber(Sender: TObject);
    procedure mxProtector1Register(Sender: TObject; UserName,
      SerialNumber: String);
    procedure btnRegisterClick(Sender: TObject);
    procedure txtSerialNumberChange(Sender: TObject);
    procedure hideClick(Sender: TObject);

    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure txtDbServerChange(Sender: TObject);
    procedure txtDbNameChange(Sender: TObject);
    procedure txtDbUserChange(Sender: TObject);
    procedure asgColorSchemaCellValidate(Sender: TObject; Col,
      Row: Integer; var Value: String; var Valid: Boolean);
    procedure btnResetClick(Sender: TObject);
    procedure txtDiscValueValidate(Sender: TObject; value: String;
      var IsValid: Boolean);
    procedure txtDiscKeyPress(Sender: TObject; var Key: Char);
    procedure cmbKasirChange(Sender: TObject);
    procedure txtFooter2ValueValidate(Sender: TObject; value: String;
      var IsValid: Boolean);
    procedure cmbPrinterNameChange(Sender: TObject);
    procedure mxProtector1Expiration(Sender: TObject);
    procedure cmbGudangChange(Sender: TObject);
    procedure mxProtector1StartTrial(Sender: TObject;
      StartsRemained: Integer);
    procedure btnKoneksiClick(Sender: TObject);
    procedure cmbHostChange(Sender: TObject);
    procedure btnBranchClick(Sender: TObject);
    procedure btnEmptyClick(Sender: TObject);

  private
    RegGlobal: TRegistry;
    STATUS_REGISTERING : boolean;

    function isValid:boolean;
    function SaveCompany:boolean;
    procedure LoadDataCompany;
    procedure RegisterProduct;

  //color schema routines
    procedure RegGetValuesNamesDb;
    procedure RegCreateKeyDb;

    procedure RegSystemConfig(write: boolean);
    function isConntectedToServer: boolean;
    function executeOfflineQuery: boolean;
    function updateLocalDb: boolean;
    procedure getBranch(id:integer);

  public
    function ProcessRights: boolean;
    procedure Execute;
    procedure getScannerSetting;
  end;

var
  frmOption: TfrmOption;

implementation

uses Subroutines, UConstTool, MainMenu,
  UConst, UMaster, MySQLConnector, uMysqlClient, LookupData, AutoStockLine;

const
  copy_left = 'lndo39';

  colDesc  = 0;
  colValue = 1;
  colName  = 2;
           
{$R *.dfm}

{ TfrmCompany }

procedure TfrmOption.Execute;
begin
  LoadDataCompany;
  if MANAGEMENT_VERSION = False then
    PageControl1.ActivePageIndex := 1
  else PageControl1.ActivePageIndex := 0;

  PageControl1.Pages[0].Enabled:= MANAGEMENT_VERSION;
  txtFooter1.Enabled:= MANAGEMENT_VERSION;
  txtFooter2.Enabled:= MANAGEMENT_VERSION;
  btnEmpty.Visible := GlobalSystemUser.AccessLevel > LEVEL_SUPERVISOR;
  PageControl1Change(Self);
  ShowModal;
end;

procedure TfrmOption.btnCancelClick(Sender: TObject);
begin
  Close;
end;

function TfrmOption.isValid: boolean;
begin
  Result := True;
end;

procedure TfrmOption.LoadDataCompany;
begin
  if LowerCase(txtName.Text) <> LowerCase(CompanyProfile.FCompanyName) then
    mxProtector1.Reset;

  txtName.Text    := CompanyProfile.FCompanyName;
  txtAddress.Text := CompanyProfile.FAddress;
  txtCity.Text    := CompanyProfile.FCity;
  txtTelp1.Text   := CompanyProfile.FTelp1;
  txtTelp2.Text   := CompanyProfile.FTelp2;
  txtFax.Text     := CompanyProfile.FFax;
  txtBranch.Text  := CompanyProfile.FBranch;
  txtBranch.Tag := CompanyProfile.FCurrentBranch;
  txtPostCode.Text  := CompanyProfile.FPostCode;
  txtTax.Text  := CompanyProfile.FNpwp;
  mmInfo.Text     := CompanyProfile.FInfo;
  txtSerialNumber.Tag:= StrToInt(BoolToStr(mxProtector1.IsRegistered));
  btnRegister.Enabled:= (txtSerialNumber.Tag = 0) and (txtSerialNumber.Text <> '') and (PageControl1.ActivePageIndex=0);

  //hide.Visible:= GlobalSystemUser.AccessLevel = LEVEL_DEVELOPER;

end;

procedure TfrmOption.btnSaveClick(Sender: TObject);
begin
  case PageControl1.ActivePageIndex of
    0 : if isValid and Confirmed(MSG_SAVE_CONFIRMATION) then
             btnSave.Enabled:= not SaveCompany;
    1 : RegCreateKeyDb;
    2 : RegSystemConfig(True);
  end;
  btnCancel.Caption:= IfThen(btnSave.Enabled, 'Cancel', 'Close');
end;

function TfrmOption.SaveCompany: boolean;
begin
  CompanyProfile.FCompanyName:= txtName.Text;
  CompanyProfile.FAddress:= txtAddress.Text;
  CompanyProfile.FCity:= txtCity.Text;
  CompanyProfile.FTelp1:= txtTelp1.Text;
  CompanyProfile.FTelp2:= txtTelp2.Text;
  CompanyProfile.FFax:= txtFax.Text;
  CompanyProfile.FInfo:= mmInfo.Text;
  CompanyProfile.FBranch:= txtBranch.Text;
  CompanyProfile.FCurrentBranch := txtBranch.Tag;
  CompanyProfile.FNpwp:= txtTax.Text;
  CompanyProfile.FPostCode:= txtPostCode.Text;
  Result:= CompanyProfile.InsertInDb;
  btnRegister.Enabled:= not mxProtector1.IsRegistered;
  btnSave.Enabled := not Result;
end;

procedure TfrmOption.PageControl1Change(Sender: TObject);
begin
  btnSave.Enabled:= False;
  case PageControl1.ActivePageIndex of
    0: LoadDataCompany;
    1: RegGetValuesNamesDb;
    2: RegSystemConfig(False);
  end;
  btnSave.Enabled := True;
end;

procedure TfrmOption.mxProtector1GetSerialNumber(Sender: TObject;
  var UserName, SerialNumber: String);
begin
  UserName:=Application.Name +  CompanyProfile.FCompanyName;
  SerialNumber:= CompanyProfile.FSerialNumber;
end;

procedure TfrmOption.mxProtector1InvalidSerialNumber(Sender: TObject);
begin
  Alert('Serial number salah!');
end;

procedure TfrmOption.mxProtector1Register(Sender: TObject; UserName,
  SerialNumber: String);
begin
  if STATUS_REGISTERING then
    Inform('Terima kasih telah registrasi produk kami.'+#13+'Aplikasi akan ditutup sebagai proses pasca registrasi.'+
    'Jalankan kembali aplikasi untuk menjalankan dalam versi yang telah diregistrasi');
  STATUS_REGISTERING:= False;
end;

procedure TfrmOption.RegisterProduct;
begin
  if (txtName.Text <> '') and (txtSerialNumber.Text <> '') then begin
    mxProtector1.Registration();
    if mxProtector1.IsRegistered then begin
       SaveCompany;
       STATUS_REGISTERING:= False;
     // ModalResult:= mrOk;
    end;
  end else
    Alert('Data belum terisi.');
end;

function TfrmOption.ProcessRights: boolean;
begin
  STATUS_REGISTERING:= False; //BIAR GA MUNCUL PESAN
  CompanyProfile.SelectInDB;
  Result := True;
//  Result:= mxProtector1.GenerateSerialNumber(Application.Name +  CompanyProfile.FCompanyName) = CompanyProfile.FSerialNumber;
end;

procedure TfrmOption.btnRegisterClick(Sender: TObject);
begin
  STATUS_REGISTERING:= TRUE;
  RegisterProduct
end;

procedure TfrmOption.txtSerialNumberChange(Sender: TObject);
begin
  btnRegister.Enabled:= (txtSerialNumber.Text <> '') and (txtSerialNumber.Tag = 0);
  CompanyProfile.FSerialNumber:= txtSerialNumber.Text;
end;

procedure TfrmOption.hideClick(Sender: TObject);
begin
  txtSerialNumber.Text:= mxProtector1.GenerateSerialNumber(Application.Name + txtName.Text);
end;

procedure TfrmOption.RegGetValuesNamesDb;
var dbserver: string;
begin

  RegGlobal.RootKey:= HKEY_CURRENT_USER;
  try
    RegGlobal.OpenKey(MODUL_PATH + '\Database', False);

    try
     dbserver:= RegGlobal.ReadString('serverDb');
     if cmbHost.Items.IndexOf(dbserver) = -1 then
       cmbHost.Items.Append(dbserver);
    except end;
    
    cmbHost.ItemIndex:= cmbHost.Items.IndexOf(RegGlobal.ReadString('dbServer'));
    txtDbName.Text:= RegGlobal.ReadString('dbDatabase');
    txtDbUser.Text:= RegGlobal.ReadString('dbUser');
    txtDbPwd.Text:= RegGlobal.ReadString('dbPassword');
  finally
    RegGlobal.CloseKey;
  end;
end;

procedure TfrmOption.RegCreateKeyDb;
begin
  RegGlobal.RootKey:= HKEY_CURRENT_USER;
  try
    try
      RegGlobal.OpenKey(MODUL_PATH + '\Database', True);
      RegGlobal.WriteString('dbServer', cmbHost.Text);
      RegGlobal.WriteString('dbDatabase', txtDbName.Text);
      RegGlobal.WriteString('dbUser', txtDbUser.Text);
      RegGlobal.WriteString('dbPassword', txtDbPwd.Text);
      btnSave.Enabled:= False;

      if (LowerCase(cmbHost.Text) <> 'localhost') then
        RegGlobal.WriteString('serverDb', cmbHost.Text);

      ConnetToDB;
    except
    end;
  finally
    RegGlobal.CloseKey;
  end;
end;

procedure TfrmOption.FormCreate(Sender: TObject);
begin
  RegGlobal:= TRegistry.Create;
  Image1.Picture.Bitmap.Handle := LoadBitmap(ImageDll,'database');
end;

procedure TfrmOption.FormDestroy(Sender: TObject);
begin
  RegGlobal.Free;
end;

procedure TfrmOption.txtDbServerChange(Sender: TObject);
begin
  btnSave.Enabled:= True;
  CompanyProfile.FCompanyName:= txtName.Text;
  btnKoneksi.Enabled:= LowerCase(cmbHost.Text) <> ('localhost');
end;

procedure TfrmOption.txtDbNameChange(Sender: TObject);
begin
  btnSave.Enabled:= True;
end;

procedure TfrmOption.txtDbUserChange(Sender: TObject);
begin
  btnSave.Enabled:= True;
end;

procedure TfrmOption.asgColorSchemaCellValidate(Sender: TObject; Col,
  Row: Integer; var Value: String; var Valid: Boolean);
begin
  btnSave.Enabled:= True
end;

procedure TfrmOption.btnResetClick(Sender: TObject);
begin
  mxProtector1.Reset;
end;

procedure TfrmOption.RegSystemConfig(write: boolean);
var listPrinter, lsGudang: TStringList; tmpID: integer;
begin

  RegGlobal.RootKey:= HKEY_CURRENT_USER;
  try
    listPrinter:= TStringList.Create;
    lsGudang:= TStringList.Create;

    SQLToNameValueList(listPrinter,
     'select printer_id, concat(printer_vendor, space(1), printer_model) as nama '+
     'from mst_printer order by printer_vendor, printer_model');

   SQLToNameValueList(lsGudang,
     'select mst_id, mst_name '+
     'from mst_master where mst_tipe = '+FormatSQLNumber(MST_TYPE_GUDANG)+
     ' order by mst_name');

    try
      RegGlobal.OpenKey(MODUL_PATH + '\Setting', True);

      if write then begin
         RegGlobal.WriteInteger('marginTop', txtMarginTop.IntValue);
         RegGlobal.WriteInteger('marginBottom', txtMarginBottom.IntValue);
         RegGlobal.WriteInteger('printStruk', IfThen(chkPrint.Checked=true, 1, 0));
         RegGlobal.WriteInteger('autoCut', IfThen(chkCutOff.Checked=true, 1, 0));
         RegGlobal.WriteInteger('printerID', StrToInt(listPrinter.Names[cmbPrinterName.ItemIndex]));
         RegGlobal.WriteString('portName', cmbPort.Text);
         RegGlobal.WriteInteger('localMachine', cmbKasir.Tag);
         RegGlobal.WriteInteger('localGudang', StrToInt(lsGudang.Names[cmbGudang.ItemIndex]));
         RegGlobal.WriteString('printerStruk', cmbPrnStruk.Text);
         RegGlobal.WriteString('printerBarcode', cmbPrnBarcode.Text);
         RegGlobal.WriteString('printerAdm', cmbPrnAdm.Text);
         RegGlobal.WriteInteger('writeLog', IfThen(chkLog.Checked=true, 1, 0));

         GlobalSystemConfig.UpdateOnDB(CONF_INVENTORY, IfThen(chkInven.Checked=true, '-1', '0'));
         GlobalSystemConfig.UpdateOnDB(CONF_UDPATE_PRICE, IfThen(chkPrice.Checked=true, '-1', '0'));
         GlobalSystemConfig.UpdateOnDB(CONF_FOOTER1, txtFooter1.Text);
         GlobalSystemConfig.UpdateOnDB(CONF_FOOTER2, txtFooter2.Text);

         GlobalSystemConfig.loadFromDB(False);
         GlobalSystemConfig.localSetting.Machine := cmbKasir.Tag;
         GlobalSystemConfig.localSetting.LocalGudang := StrToInt(lsGudang.Names[cmbGudang.ItemIndex]);
         GlobalSystemConfig.localSetting.MarginTop   := txtMarginTop.IntValue;
         GlobalSystemConfig.localSetting.MarginBottom:= txtMarginBottom.IntValue;
         GlobalSystemConfig.localSetting.PrintStruk  := IfThen(chkPrint.Checked=true, 1, 0);
         GlobalSystemConfig.localSetting.AutoCutter  := IfThen(chkCutOff.Checked=true, 1, 0);
         GlobalSystemConfig.localSetting.PrinterID   := StrToInt(listPrinter.Names[cmbPrinterName.ItemIndex]);
         GlobalSystemConfig.localSetting.PortName    := cmbPort.Text;

         GlobalSystemConfig.localSetting.PrinterStruk  := cmbPrnStruk.Text;
         GlobalSystemConfig.localSetting.PrinterBarcode:= cmbPrnBarcode.Text;
         GlobalSystemConfig.localSetting.PrinterAdm    := cmbPrnAdm.Text;

         GlobalSystemConfig.localSetting.UseSerialKeys := IfThen(chkSerialKeys.Checked=true, 1, 0);
         GlobalSystemConfig.localSetting.SerialPort    := txtSerialPort.Text;
         GlobalSystemConfig.localSetting.Baudrate      := txtSerialBaud.IntValue;
                                          
         GlobalSystemConfig.localSetting.DrawerCode  := getStringFromSQL(
           'select drawer_code from mst_printer where printer_id = '+FormatSQLNumber(GlobalSystemConfig.localSetting.PrinterID));
         GlobalSystemConfig.localSetting.CutterCode  := getStringFromSQL(
           'select cutter_code from mst_printer where printer_id = '+FormatSQLNumber(GlobalSystemConfig.localSetting.PrinterID));

         RegGlobal.WriteString('printerStruk', cmbPrnStruk.Text);
         RegGlobal.WriteString('printerBarcode', cmbPrnBarcode.Text);
         RegGlobal.WriteString('printerAdm', cmbPrnAdm.Text);

         RegGlobal.WriteInteger('useSerialKeys', IfThen(chkSerialKeys.Checked=true, 1, 0));
         RegGlobal.WriteString('serialPort', txtSerialPort.Text);
         RegGlobal.WriteInteger('baudRate', txtSerialBaud.IntValue);

         getScannerSetting;

      end
      else begin

        NameValueListToValueList(listPrinter,cmbPrinterName.Items);
        NameValueListToValueList(lsGudang,cmbGudang.Items);
        try chkPrint.Checked:= RegGlobal.ReadInteger('printStruk') = 1;
        except end;

        try chkCutOff.Checked:= RegGlobal.ReadInteger('autoCut') = 1;
        except RegGlobal.WriteInteger('autoCut', 0); end;

        try txtMarginTop.IntValue:= RegGlobal.ReadInteger('marginTop');
        except RegGlobal.WriteInteger('marginTop', 0); end;

        try txtMarginBottom.IntValue:= RegGlobal.ReadInteger('marginBottom');
        except RegGlobal.WriteInteger('marginBottom', 0); end;

        try chkLog.Checked:= RegGlobal.ReadInteger('writeLog') = 1;
        except RegGlobal.WriteInteger('writeLog', 1); end;

        try tmpID:= RegGlobal.ReadInteger('printerID');
        except tmpID:= 0 end;

        if tmpID > 0 then
          cmbPrinterName.ItemIndex:= listPrinter.IndexOfName(IntToStr(tmpID))
        else cmbPrinterName.ItemIndex:= 0;

        try tmpID:= RegGlobal.ReadInteger('localGudang');
        except tmpID:= 0 end;

        if tmpID > 0 then
          cmbGudang.ItemIndex:= lsGudang.IndexOfName(IntToStr(tmpID))
        else cmbGudang.ItemIndex:= 0;

        try tmpID:= RegGlobal.ReadInteger('localMachine');
        except tmpID:= 5 end;

        TMstMaster_Arr.GetList(GlobalStringList, MST_TYPE_CASHIER);
        NameValueListToValueList(GlobalStringList, cmbKasir.Items);
        cmbKasir.ItemIndex:= GlobalStringList.IndexOfName(IntToStr(tmpID));
        cmbKasirChange(nil);

        chkInven.Checked := GlobalSystemConfig[CONF_INVENTORY-1].ConfValue = '-1';
        chkPrice.Checked := GlobalSystemConfig[CONF_UDPATE_PRICE-1].ConfValue = '-1';
        txtFooter1.Text  := GlobalSystemConfig[CONF_FOOTER1-1].ConfValue;
        txtFooter2.Text  := GlobalSystemConfig[CONF_FOOTER2-1].ConfValue;

        EnumComPorts(cmbPort.Items);
        cmbPort.Items.Append('LPT1');
        if RegGlobal.ReadString('portName') <> '' then
          cmbPort.ItemIndex:= cmbPort.Items.IndexOfName(RegGlobal.ReadString('portName'))
        else cmbPort.ItemIndex:= cmbPort.Items.IndexOfName(RegGlobal.ReadString('LPT1'));

        getPrinterList(cmbPrnStruk.Items);
        getPrinterList(cmbPrnBarcode.Items);
        getPrinterList(cmbPrnAdm.Items);

        try cmbPrnStruk.Text:= RegGlobal.ReadString('printerStruk');
        except regGlobal.WriteString('printerStruk', ''); end;

        try cmbPrnBarcode.Text:= RegGlobal.ReadString('printerBarcode');
        except regGlobal.WriteString('printerBarcode', ''); end;

        try cmbPrnAdm.Text:= RegGlobal.ReadString('printerAdm');
        except regGlobal.WriteString('printerAdm', ''); end;

        if RegGlobal.ReadInteger('useSerialKeys') = 0 then
          chkSerialKeys.Checked:= False
        else chkSerialKeys.Checked:= True;

        txtSerialPort.Text:= RegGlobal.ReadString('serialPort');
        txtSerialBaud.IntValue:= RegGlobal.ReadInteger('baudRate');

      end;
    except
      on ERegistryException do ShowMessage('gagal.');
    end;
  finally
    RegGlobal.CloseKey;
    listPrinter.Free;
    lsGudang.Free;
  end;
  btnSave.Enabled:= not write;
end;

procedure TfrmOption.txtDiscValueValidate(Sender: TObject; value: String;
  var IsValid: Boolean);
begin
  AdvEdtFloatFmt(Sender, value);
end;

procedure TfrmOption.txtDiscKeyPress(Sender: TObject; var Key: Char);
begin
  key:=IgnoreChar(Key);
end;

procedure TfrmOption.cmbKasirChange(Sender: TObject);
begin
  btnSave.Enabled:= True;
  cmbKasir.Tag:= 0;
  if cmbKasir.ItemIndex >-1 then
    cmbKasir.Tag:= StrToInt(GlobalStringList.Names[cmbKasir.ItemIndex]);
end;

procedure TfrmOption.txtFooter2ValueValidate(Sender: TObject;
  value: String; var IsValid: Boolean);
begin
  btnSave.Enabled:= True;
end;

procedure TfrmOption.cmbPrinterNameChange(Sender: TObject);
begin
  btnSave.Enabled:= True;
end;

procedure TfrmOption.mxProtector1Expiration(Sender: TObject);
begin
  Alert('Masa uji coba sudah habis.'#13#10'Silahkan melakukan registrasi.');
  Application.Terminate;
end;

procedure TfrmOption.cmbGudangChange(Sender: TObject);
begin
  btnSave.Enabled:= True;
end;

procedure TfrmOption.mxProtector1StartTrial(Sender: TObject;
  StartsRemained: Integer);
begin
  Alert('Masa uji coba sudah habis.'#13#10'Silahkan melakukan registrasi.');
  Application.Terminate;
end;

procedure TfrmOption.btnKoneksiClick(Sender: TObject);
begin
  if MustRegister then exit;
  try
    Screen.Cursor:= crHourGlass;
    if isConntectedToServer then begin

    //sincronisasi server dengan local
      executeOfflineQuery;

    //sincronisasi local dengan server
      updateLocalDb;
    end else
    Alert('Tidak bisa koneksi ke server.');
  finally
    Screen.Cursor:= crDefault;
  end;

end;

function TfrmOption.executeOfflineQuery: boolean;
var pathBat, path, vFileName, fileToRun: String; berhasil: boolean;
begin
  try
    path:= GetAppPath;
    pathBat:= path+'database\bin\';
    vFileName:= 'offline_'+LowerCase(GetComputerNetName)+'.sql';
    fileToRun:= pathBat + 'exec_offline.bat '+
      path+vFileName+' '+
      MySQLClient.Host + ' ' +
      MySQLClient.Password+' '+
      pathBat+' '+
      MySQLClient.Db;

    if FileExists(path+vFileName) then
      berhasil:= ExecuteAndWait(fileToRun, SW_NORMAL) <> $FFFFFFFF
    else berhasil:= False;

    if berhasil then begin
    //buat direktori
      if not DirectoryExists(path+'offline') then
        CreateDir(path+'offline');

      if FileExists(path+'offline\'+vFileName) then
        DeleteFile(path+'offline\'+vFileName);

      MoveFile(PChar(path+vFileName), PChar(path+'offline\'+vFileName));
    end;
    Result:= berhasil;
  finally

  end;
end;

function TfrmOption.updateLocalDb: boolean;
var pathBat, path, vFileName, fileToRun: String; berhasil: boolean;
begin
//  Result:= False;
  try
    path:= GetAppPath;
    pathBat:= path+'database\bin\';
    vFileName:= 'server_db.sql';

  //copy last server db master
    fileToRun:= pathBat + 'get_server_db.bat '+
      MySQLClient.Host+' '+
      MySQLClient.Password+' '+
      pathBat+' '+
      MySQLClient.Db;

    ExecuteAndWait(fileToRun, SW_NORMAL);

  //update local db
    fileToRun:= pathBat + 'update_local_db.bat localHost'+' '+
    MySQLClient.Password+' '+
    pathBat+' '+
    MySQLClient.Db;

    if FileExists(pathBat+vFileName) then
      berhasil:= ExecuteAndWait(fileToRun, SW_NORMAL) <> $FFFFFFFF
    else berhasil:= False;

    Result:= berhasil;
  finally
  end;
end;

function TfrmOption.isConntectedToServer: boolean;
begin
  MySQLClient.Host:= cmbHost.Text;
  MySQLClient.User:= txtDbUser.Text;
  MySQLClient.Password:= txtDbPwd.Text;;
  MySQLClient.Db:= txtDbName.Text;
  MySQLClient.ConnectTimeout:= 20;

  Result:= tryToConnetToDB;

  XA_ID:= GetComputerNetName + Application.Name;
  //setLocal(LowerCase(MySQLClient.Host) <> 'localhost');
  setLocal;
end;

procedure TfrmOption.cmbHostChange(Sender: TObject);
begin
//  btnKoneksi.Enabled:= LowerCase(cmbHost.Text) <> ('localhost');
  MySQLClient.Host:= cmbHost.Text;
  btnKoneksi.Enabled:= ConnetionIsOnline;
  btnSave.Enabled:= True;
  CompanyProfile.FCompanyName:= txtName.Text;
end;

procedure TfrmOption.getScannerSetting;
var fileToRun, path: String;
begin
  GlobalSystemConfig.loadFromDB(True);
  if GlobalSystemConfig.localSetting.UseSerialKeys = 0 then Exit;
  path:= GetAppPath+'\';

  try
    fileToRun:= qoute(path + 'startSerialKeys.bat')+ ' ' +
      GlobalSystemConfig.localSetting.SerialPort+' '+
      IntToStr(GlobalSystemConfig.localSetting.Baudrate);
    ExecuteAndWait(fileToRun, SW_NORMAL);
  finally
  end;

end;

procedure TfrmOption.btnBranchClick(Sender: TObject);
var id: integer; kode: string;
begin
  kode:= '';
  id:= frmLookup.Execute('BRANCH');
  if Id > 0 then getBranch(id);
  btnSave.Enabled:= True;

end;

procedure TfrmOption.getBranch(id: integer);
var branch :TMstBranch;
begin
  branch := TMstBranch.Create();
  branch.BranchID := id;
  if branch.SelectLookup then begin
    txtBranch.Text := branch.BranchCode + ' '+branch.BranchName;
    txtBranch.Tag := branch.BranchID;
  end
  else begin
    txtBranch.Tag :=0;
    txtBranch.Clear;
  end;

  branch.Free;
end;

procedure TfrmOption.btnEmptyClick(Sender: TObject);
var sql:string;
begin
   try
    //BeginSQL;
    ExecSQL('truncate table trs_shipment_mst');
           ExecSQL('truncate table trs_sales_mst');
           ExecSQL(' truncate table trs_retur_mst');
           ExecSQL(' truncate table trs_receipt_mst');
           ExecSQL(' truncate table trs_payment_mst');
           ExecSQL(' truncate table trs_order_mst');
           ExecSQL(' truncate table trs_money_trans_mst');
           ExecSQL(' truncate table trs_item_use_mst');
           ExecSQL(' truncate table trs_holded_mst');
           ExecSQL(' truncate table mst_relation_service');
           ExecSQL(' truncate table mst_money_balance');
           ExecSQL(' truncate table inv_relation_balance');
           ExecSQL(' truncate table inv_item_balance');
           ExecSQL(' truncate table inv_cashier_balance');
           ExecSQL(' update mst_item set current_stock = 0');
           ExecSQL(' update mst_relation_service set jumlah = 0, total =0');
   // EndSQL;
    //Result:= True;
    Inform(MSG_SUCCESS_UPDATE);
  except raise;
    Inform(MSG_UNSUCCESS_UPDATE);
   // UndoSQL;
    //Result:= False;
  end;

end;

end.


