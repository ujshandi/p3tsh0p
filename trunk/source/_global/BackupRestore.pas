unit BackupRestore;

interface

uses
  strUtils,Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, AdvEdit, WinXP;

type
  TfrmBackupRestore = class(TForm)
    SaveDialog1: TSaveDialog;
    OpenDialog1: TOpenDialog;
    btnOpen: TButton;
    btnClose: TButton;
    txtFileName: TAdvEdit;
    Label1: TLabel;
    WinXP1: TWinXP;
    procedure btnCloseClick(Sender: TObject);
    procedure btnOpenClick(Sender: TObject);
  private
    MasterPurpose:integer;
    procedure ResetForm;

  public
    procedure ProcessBackup;
    procedure ProcessRestore;
    procedure Execute(APurpose:integer);
  end;

var
  frmBackupRestore: TfrmBackupRestore;

implementation

uses UConstTool, MainMenu, Subroutines, MySQLConnector, UConst,
  uMysqlClient;

{$R *.dfm}

{ TfrmBackupRestore }

procedure TfrmBackupRestore.Execute(APurpose: integer);
begin
  MasterPurpose := APurpose;
  ResetForm;
  if MasterPurpose = BACKUP_DATABASE then
    ProcessBackup;
  Run(Self);
end;

procedure TfrmBackupRestore.ResetForm;
begin
  Self.Caption := IfThen(MasterPurpose=BACKUP_DATABASE,'Backup Database','Restore Database');
  btnOpen.Caption := IfThen(MasterPurpose=BACKUP_DATABASE,'&Save','&Open');
  txtFileName.Clear;
end;

procedure TfrmBackupRestore.btnCloseClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfrmBackupRestore.ProcessBackup;
var fileToSave, fileToRun, pathBat, path: String; berhasil: boolean;
begin
  if DEMO_VERSION then exit;
  if SaveDialog1.Execute then
    fileToSave := qoute(SaveDialog1.FileName)
  else exit;

  path:= GetAppPath;
  pathBat:= path;//+'database\bin\';

  try
    Screen.Cursor:= crHourGlass;
    fileToRun:= qoute(pathBat + 'backup.bat')+ ' ' +
      MySQLClient.Host+' '+
      fileToSave+' '+
      MySQLClient.Password+' '+
      MySQLClient.Db;

    berhasil:= ExecuteAndWait(fileToRun, SW_NORMAL) <> $FFFFFFFF;

    if berhasil then Inform('Backup data berhasil.')
    else Inform('Backup data tidak berhasil.');
  finally
    Screen.Cursor:= crDefault;
  end;
  if berhasil then Self.Close;

  {
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
      pathBat;

    ExecuteAndWait(fileToRun, SW_NORMAL);

  //update local db
    fileToRun:= pathBat + 'update_local_db.bat localHost'+' '+MySQLClient.Password+' '+pathBat;
    if FileExists(pathBat+vFileName) then
      berhasil:= ExecuteAndWait(fileToRun, SW_NORMAL) <> $FFFFFFFF
    else berhasil:= False;

    Result:= berhasil;
  finally
  end;
  }
end;

{procedure TfrmBackupRestore.ProcessBackup;
var vFileName, vCommand, winDir: String;
    vWindow: HWND;
begin
  if SaveDialog1.Execute then begin
    SaveDialog1.FileName := SaveDialog1.FileName;
    vFileName := SaveDialog1.FileName;
  end
  else exit;

  winDir:= getWindowsVersion;
  if ((winDir = WINDOWS_95) or (winDir = WINDOWS_98) or (winDir = WINDOWS_ME)) then
    winDir:= 'MS-DOS Promt'
  else winDir:= getWindowsDir+'\SYSTEM32\cmd.exe';

  txtFileName.Text := vFileName;
  vCommand := GetAppPath+'backup.bat '+vFileName +' '+ServerName;

  if WinExec(pchar(vCommand),SHOW_OPENWINDOW) > 31 then begin
    repeat
      vWindow := FindWindow(nil, PChar(winDir));
    until vWindow = 0;
    if vWindow = 0 then begin
      ShowMessage('Data telah di backup');
      Close;
    end;
 end;

end;  }

{procedure TfrmBackupRestore.ProcessRestore;
var vFileName : string;vCommand:String;
  vWindow : HWND; Path : string;
begin
  if OpenDialog1.Execute then
    vFileName := OpenDialog1.FileName
  else
    exit;

  txtFileName.Text := vFileName;
  Path := GetAppPath;

  //set path to current dir
  vCommand := 'SET PATH=%PATH%;'+Path;
  WinExec(PChar(vCommand),SHOW_OPENWINDOW);

  vCommand := Path+'restore.bat '+vFileName+' '+ServerName;

  Path:= getWindowsVersion;
  if ((Path = WINDOWS_95) or (Path = WINDOWS_98) or (Path = WINDOWS_ME)) then
    Path:= 'MS-DOS Promt'
  else Path:= getWindowsDir+'\SYSTEM32\cmd.exe';

  if WinExec(pchar(vCommand),SHOW_OPENWINDOW) > 31 then begin
    repeat
      vWindow := FindWindow(nil,PChar(Path));
    until vWindow = 0;
    Inform('Database telah berhasil di restore');
    Self.Close;
  end;

end;
}
procedure TfrmBackupRestore.btnOpenClick(Sender: TObject);
begin
  
  if MustRegister then exit;

  if MasterPurpose = BACKUP_DATABASE then
    ProcessBackup
  else
    ProcessRestore;
end;

procedure TfrmBackupRestore.ProcessRestore;
var fileToRestore, fileToRun: String; berhasil: boolean;
begin
  if DEMO_VERSION then exit;

  if OpenDialog1.Execute then
    fileToRestore := qoute(OpenDialog1.FileName)
  else exit;

  try
    Screen.Cursor:= crHourGlass;
    fileToRun:= qoute(GetAppPath + {database\bin\}'restore.bat')+' '+fileToRestore+' '+ServerName;

    berhasil:= ExecuteAndWait(fileToRun, SW_NORMAL) <> $FFFFFFFF;
    if berhasil then Inform('Restore data berhasil.')
    else Inform('restore tidak berhasil.');
  finally
    Screen.Cursor:= crDefault;
  end;
  if berhasil then Self.Close;
end;

end.
