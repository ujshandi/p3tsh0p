unit DatabaseConnection;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, AdvEdit, Registry, WinXP, IniFiles, StrUtils;

type
  TfrmDatabaseConnection = class(TForm)
    Label3: TLabel;
    txtDbPwd: TAdvEdit;
    txtDbUser: TAdvEdit;
    txtDbName: TAdvEdit;
    Image1: TImage;
    Button1: TButton;
    Button2: TButton;
    WinXP1: TWinXP;
    btnCopyDemo: TButton;
    cmbServer: TComboBox;

    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure btnCopyDemoClick(Sender: TObject);
  private

    FUserID : string;
    FPasswordID : string;
    FDbID : string;

    RegDatabase: TRegistry;
    function GetUserID: string;
    procedure SetUserID(const Value: string);
  public
    function Execute: string;
  published
    property HostID: string read GetUserID write SetUserID;
    property UserID: string read FUserID write FUserID;
    property PasswordID: string read FPasswordID write FPasswordID;
    property DbID: string read FDbID write FDbID;
  end;

var
  frmDatabaseConnection: TfrmDatabaseConnection;

const
  DB_PWD = 'sukasuka';

implementation

uses UConstTool, UConst, Subroutines, MySQLConnector, MainMenu;

{$R *.dfm}

{ TfrmDatabaseConnection }

function TfrmDatabaseConnection.Execute: string;
var dbserver: string;
begin
  Image1.Picture.Bitmap.Handle :=  LoadBitmap(ImageDll,'database');
  btnCopyDemo.Visible := DEMO_VERSION = True;
  cmbServer.Enabled   := not DEMO_VERSION;
  txtDbName.ReadOnly  := DEMO_VERSION;

  RegDatabase:= TRegistry.Create;
  RegDatabase.RootKey := HKEY_CURRENT_USER;

  try
    RegDatabase.OpenKey(MODUL_PATH+'\Database', True);

    try
      dbserver:= RegDatabase.ReadString('serverDb');
      cmbServer.Items.Append(dbserver);
    except
      RegDatabase.WriteString('serverDb', '');
    end;

    try dbserver:= RegDatabase.ReadString('dbServer');
    except
      RegDatabase.WriteString('dbServer', '');
      dbserver:= 'localHost';
    end;
  finally
    RegDatabase.CloseKey;
  end;

  cmbServer.ItemIndex:= cmbServer.Items.IndexOf(dbserver);
  txtDbName.Text  := 'petshop';
  txtDbUser.Text  := 'root';
  txtDbPwd.Text   := DB_PWD;
  ShowModal;
  RegDatabase.Free;
end;

procedure TfrmDatabaseConnection.Button1Click(Sender: TObject);
begin
  HostID:= cmbServer.Text;
end;

procedure TfrmDatabaseConnection.Button2Click(Sender: TObject);
begin
  Application.Terminate;
end;

function TfrmDatabaseConnection.GetUserID: string;
var RegDb: TRegistry;
begin
  RegDb:= TRegistry.Create;
  RegDb.RootKey:= HKEY_CURRENT_USER;
  try
    RegDb.OpenKey(MODUL_PATH+'\Database', False);
    Result:= RegDb.ReadString('dbServer');
    FUserID:= RegDb.ReadString('dbUser');
    FPasswordID:= RegDb.ReadString('dbPassword');
    FDbID:= RegDb.ReadString('dbDatabase');
  finally
    RegDb.CloseKey;
    RegDb.Free;
  end;
end;

procedure TfrmDatabaseConnection.SetUserID(const Value: string);
begin
  RegDatabase:= TRegistry.Create;
  RegDatabase.RootKey:= HKEY_CURRENT_USER;
  try
    try
      RegDatabase.OpenKey(MODUL_PATH+'\Database', True);
      RegDatabase.WriteString('dbServer', Value);
      RegDatabase.WriteString('dbDatabase', txtDbName.Text);
      RegDatabase.WriteString('dbUser', txtDbUser.Text);
      RegDatabase.WriteString('dbPassword', txtDbPwd.Text);
      RegDatabase.WriteInteger('connectionStatus', 1);
      if (LowerCase(Value) <>'localhost') then
     //if ConnetionIsOnline then
        RegDatabase.WriteString('serverDb', Value);
    except
    end;
  finally
    RegDatabase.CloseKey;
  end;
end;

procedure TfrmDatabaseConnection.btnCopyDemoClick(Sender: TObject);
var pathMyIni, fileToRun: String; berhasil: boolean;
  myini: TIniFile;
begin
  try
    Screen.Cursor:= crHourGlass;

  //configurasi my.ini
    myini:= TIniFile.Create(GetAppPath+'database\my.ini');
    pathMyIni:= '"'+AnsiReplaceText(GetAppPath, '\', '/') + 'Database/'+'"';
    myini.WriteString('mysqld', 'basedir', pathMyIni);

    pathMyIni:= '"'+AnsiReplaceStr(GetAppPath, '\', '/') + 'Database/Data/'+'"';
    myini.WriteString('mysqld', 'datadir', pathMyIni);
    myini.Free;

  //installasi database
    pathMyIni:= GetAppPath + 'database\my.ini';
    fileToRun:= GetAppPath + 'database\bin\copy_db.bat '+pathMyIni+ ' '+GetAppPath+'database\bin\';

    berhasil:= ExecuteAndWait(fileToRun, SW_NORMAL) <> $FFFFFFFF;
    if berhasil then Inform('Proses installasi database berhasil.')
    else Inform('Proses installasi database TIDAK berhasil.');
  finally
    Screen.Cursor:= crDefault;
  end;
end;

end.
