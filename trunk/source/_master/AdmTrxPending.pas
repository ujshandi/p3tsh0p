unit AdmTrxPending;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, WinXP, FileCtrl;

type
  TfrmAdmTrxPending = class(TForm)
    DriveComboBox1: TDriveComboBox;
    DirectoryListBox1: TDirectoryListBox;
    FileListBox1: TFileListBox;
    WinXP1: TWinXP;
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FileListBox1Click(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Execute;
  end;

var
  frmAdmTrxPending: TfrmAdmTrxPending;

implementation

uses Subroutines, MySQLConnector, uMysqlClient;

{$R *.dfm}

procedure TfrmAdmTrxPending.Button1Click(Sender: TObject);
var vFileName, vCommand: String;
begin
  if MustRegister then exit;
  try
    Screen.Cursor:= crHourGlass;
    vFileName:= FileListBox1.FileName;
    vCommand := GetAppPath+'restore.bat '+vFileName +' '+MySQLClient.Host + ' ' +MySQLClient.Password;
    WinExec(pchar(vCommand),SHOW_OPENWINDOW);
  finally
    Screen.Cursor:= crDefault;
  end;
   // 'Proses sinkronisasi data'#13#10'1. Pilih nama file pada daftar file di kiri bawah form'#13#10'2. Klik tombol Execute SQL'#13#10'3. Hapus file yang sudah dieksekusi dg mengklik tombol Hapus File'#13#10
end;

procedure TfrmAdmTrxPending.Execute;
begin
  Button1.Enabled:= False;
  Button2.Enabled:= False;
  
  Self.ShowModal;
end;

procedure TfrmAdmTrxPending.Button2Click(Sender: TObject);
begin
  if Confirmed('Hapus File?') then
  if DeleteFile(FileListBox1.FileName) then FileListBox1.Refresh;
end;

procedure TfrmAdmTrxPending.FileListBox1Click(Sender: TObject);
begin
  Button1.Enabled:= (FileListBox1.FileName <> '');
  Button2.Enabled:= (FileListBox1.FileName <> '')
end;

end.
