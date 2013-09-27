unit About;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, jpeg, frmDockForm;

type
  TfrmAbout = class(TDockForm)
    MainPanel: TPanel;
    ProductName: TLabel;
    Version: TLabel;
    Copyright: TLabel;
    Memo1: TMemo;
    Label1: TLabel;
    Image1: TImage;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Execute(ID: integer); override;
  end;

var
  frmAbout: TfrmAbout;

implementation

uses MainMenu, UConst;

{$R *.dfm}

procedure TfrmAbout.Execute(ID: integer);
begin
  inherited;
  Run(Self);
end;

procedure TfrmAbout.FormCreate(Sender: TObject);
{const
  //InfoNum = 10;
  InfoStr: array[1..InfoNum] of string = ('CompanyName', 'FileDescription', 'FileVersion', 'InternalName', 'LegalCopyright', 'LegalTradeMarks', 'OriginalFileName', 'ProductName', 'ProductVersion', 'Comments');
var
  S: string;
  n, Len, i: DWORD;
  Buf: PChar;
  Value: PChar;}
begin
  {S := Application.ExeName;
  n := GetFileVersionInfoSize(PChar(S), n);
  Memo1.Lines.Clear;
  if n > 0 then begin
    Buf := AllocMem(n);
    Memo1.Lines.Add('VersionInfoSize = ' + IntToStr(n));
    GetFileVersionInfo(PChar(S), 0, n, Buf);
    for i := 1 to InfoNum do
      if VerQueryValue(Buf, PChar('StringFileInfo\040904E4\' + InfoStr[i]), Pointer(Value), Len) then
        Memo1.Lines.Add(InfoStr[i] + ' = ' + Value);
    FreeMem(Buf, n);
  end else begin
    Memo1.Lines.Add('');
  end;
  }
  ProductName.Caption := Application.Name;
  Version.Caption     := DATE_VERSION;//'Version 1.0';

end;

end.

