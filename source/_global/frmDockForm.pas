unit frmDockForm;
 {DEFINE TABPAGE}
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs;

type
  TDockForm = class(TForm)
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCanResize(Sender: TObject; var NewWidth,
      NewHeight: Integer; var Resize: Boolean);
    procedure FormDockOver(Sender: TObject; Source: TDragDockObject; X,
      Y: Integer; State: TDragState; var Accept: Boolean);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDeactivate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Execute(id: integer=0); overload; virtual;
    procedure Execute(Purpose, ID: integer); overload; virtual;
  end;

var
  DockForm: TDockForm;

implementation

uses MainMenu;

{$R *.dfm}

procedure TDockForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose:= True;
end;

procedure TDockForm.FormCanResize(Sender: TObject; var NewWidth,
  NewHeight: Integer; var Resize: Boolean);
var control: TForm;
begin

  if NewWidth >= GetSystemMetrics(SM_CXSCREEN) then begin

    NewWidth:= 300;
    NewHeight:= 300;
    control:= (Sender as TForm);
    if (not Assigned(HostDockSite)) then begin
      ActivateMainForm:= 1;
      {$IFDEF TABPAGE}
        control.ManualDock(frmMainMenu.DockHost);
        frmMainMenu.DockHostChange(nil);
      {$ELSE}
        control.ManualDock(frmMainMenu.HostPanel);
      {$ENDIF}
    end;
  end;
end;

procedure TDockForm.Execute(id: integer);
begin
  
end;

procedure TDockForm.FormDockOver(Sender: TObject; Source: TDragDockObject;
  X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept:= False
end;

procedure TDockForm.FormActivate(Sender: TObject);
begin
  AssigControl(Sender);
end;

procedure TDockForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ActivateMainForm:= 0;
  DeleteDockClientList(Self);
end;

procedure TDockForm.FormDeactivate(Sender: TObject);
begin
  ActivateMainForm:= 0;
end;

procedure TDockForm.Execute(Purpose, ID: integer);
begin

end;


procedure TDockForm.FormPaint(Sender: TObject);
begin
AssigControl(Sender);
end;

end.
