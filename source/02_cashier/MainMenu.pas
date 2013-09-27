unit MainMenu;
  {DEFINE DEBUG}
interface

uses
  Subroutines, IniFiles,  BaseGrid, Gauges,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ImgList, Menus, ExtCtrls, ComCtrls,
  ToolWin, AdvGrid, AdvEdit,  WinXP, strUtils, Math, jpeg, Grids,
  SUITitleBar, SUIImagePanel, SUISideChannel, SUIMgr, SUIMainMenu, SUIForm,SUIThemes,
  SuiPageControl, SUIProgressBar, Registry,
  frmDockForm;

{Personalized Windows Message for StatusBar}
const
  WM_UpdateStatusBarMsg = WM_User + 8;
  WM_ResizeScrollBoxMsg = WM_User + 16;

type
  //Table Name: System_Menu
  //* Menu_ID
  //- Menu_Group
  //- Menu_Name
  //- Image_Index
  //- Form_Name
  //- Form_Type
  //    ftDetail[i/u/v]  ex: frmDataBarang     FEditMode
  //    ftLookup[v/p]    ex: frmKelolaBarang   FLookupMode
  //    ftReview[i/r/v]  ex: frmPembelian      FReviewMode
  //    ftBrowse[v/p]    ex: frmRekapPembelian FBrowseMode
  //    ftReport[p]      ex: frmLaporanMutasi
  //    ftSetting[u]     ex: frmSettingPayroll
  //  CanAdd, CanEdit, CanLookup, CanBrowse, CanReview, CanRevers, CanPrint
  //  Run

  //Table Name: System_Access
  //* User_ID
  //* Menu_ID
  //- Access_List: integer (I/U/V/P/R) Number (ex: 1 1 1 1 1 = 31)
  //- Shortcut
  //- OutlookBar_Panel
  //- OutlookBar_Button
  //- Usage_Count

  TMenuLabel = class(TObject)
    ListLabel: array of Tlabel;
    ListImage: array of TImage;
    function add: integer;
    destructor destroy; override;
  end;

  TfrmMainMenu = class(TForm)
    suiForm1: TsuiForm;
    Timer1: TTimer;
    suiThemeManager1: TsuiThemeManager;
    StatusBar: TStatusBar;
    PrinterSetupDialog1: TPrinterSetupDialog;
    PanelMenu: TPanel;
    lblUserLocation: TLabel;
    lblTanggal: TLabel;
    Image1: TImage;
    imgBanner: TImage;
    MenuShortCut: TPopupMenu;
    New1: TMenuItem;
    Save1: TMenuItem;
    Edit1: TMenuItem;
    Undo1: TMenuItem;
    Print1: TMenuItem;
    Close1: TMenuItem;
    Find1: TMenuItem;
    Filter1: TMenuItem;
    Detail1: TMenuItem;
    Load1: TMenuItem;
    Reset1: TMenuItem;
    Browse1: TMenuItem;
    SmallImageList: TImageList;
    suiFileTheme1: TsuiFileTheme;
    suiProgressBar1: TsuiProgressBar;
    timerProgresBar: TTimer;
    ImageList1: TImageList;
    Open2: TMenuItem;
    LogOff2: TMenuItem;
    ScrollBox1: TScrollBox;
    imagePageList: TImageList;
    HostPanel: TPanel;
    sttUser: TStaticText;

    //new style by jay...
    procedure CloseForm(control: TControl);

    procedure UpdateStatusBar(var AMessage: TMessage); message WM_UpdateStatusBarMsg;
    procedure ResizeScrollBox(var AMessage: TMessage); message WM_ResizeScrollBoxMsg;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCanResize(Sender: TObject; var NewWidth,
      NewHeight: Integer; var Resize: Boolean);
    procedure ScrollBox1Resize(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FileLogoff1Click(Sender: TObject);
    procedure FileExit1Click(Sender: TObject);

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure lblUserLocationClick(Sender: TObject);

    procedure Browse1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure mxProtector1InvalidSystemTime(Sender: TObject);
    procedure mxProtector1Expiration(Sender: TObject);
    procedure Option1Click(Sender: TObject);
    procedure LogOff1Click(Sender: TObject);
    procedure Backup1Click(Sender: TObject);
    procedure Restore1Click(Sender: TObject);
    procedure PanelMenuResize(Sender: TObject);
    procedure timerProgresBarTimer(Sender: TObject);
    procedure sttUserClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure HostPanelDockDrop(Sender: TObject; Source: TDragDockObject;
      X, Y: Integer);
    procedure HostPanelDockOver(Sender: TObject; Source: TDragDockObject;
      X, Y: Integer; State: TDragState; var Accept: Boolean);
    procedure HostPanelUnDock(Sender: TObject; Client: TControl;
      NewTarget: TWinControl; var Allow: Boolean);
    procedure StatusBarDrawPanel(StatusBar: TStatusBar;
      Panel: TStatusPanel; const Rect: TRect);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);

  protected
    { Private declarations }

    MAX_SCROLLBAR_HEIGHT, LastPageWidth, LastPageHeight, MenuIdx: integer;
    ActiveMenu, MenuAlignment: string;
    CurrentTopic: string;
    MenuIndex: TMenuLabel;

    LoginOn: boolean;
    dockClientList: TStringList;

    procedure DestroyMenu;
    procedure OpenForm(AMenuID: integer; ADocking: boolean = true);
    procedure AppendClientList(tag: integer; clienName: string);
    function  CreateDockableForm(tag: integer): TDockForm;
    function  FindForm(tag: integer): TDockForm;
    procedure DockedForm(Sender: TDockForm);
    procedure RearrangeNewForms(NewForm: TDockForm);
  end;

var
  frmMainMenu: TfrmMainMenu;
  clFormBackGround, clTitle,
  clFixedColum, clFixedFont, clPrimaryBand, clSecondaryBand,
  clSelection, clSelectionText, clGrid, clFontColor, clLabel, clFrame,
  clHouver, clHouverMenu, clUnHouver, clUnHouverMenu,
  clHeaderMenu : TColor;

//kumpulan icon/image
  ImageDll: THandle;

  ActivateMainForm: word;
  AktiveControl: TForm;

const
  clFinish   = $00000000;
  clUnFinish = $00006C00;
  clExpired  = $00000097;
  clProceed  = $00137375;
  clReadOnly = $00626262;

procedure RearrangeForms;
procedure InitializeApplication;
procedure FinalizeApplication;

function ShowForm(ID: integer): TDockForm;
procedure Run(Sender: TForm);
procedure AssigControl(Sender: TObject);
procedure reAssignLastControl;

procedure DeleteDockClientList(control: TDockForm);

function Can_Access(Sender: TForm; MenuID: integer=0): boolean;
procedure ScrollBox(Width, Height: integer);
procedure ShortCutClick(Sender: TObject);
procedure StatusBar(Text: string); overload;
procedure StatusBar(Position: integer); overload; // set Position=-1 to hide
procedure StartProgress();
procedure ProsesProgress(idx, data_count: integer);
procedure EndProgress();

function GetNumLockOn: boolean;

implementation

uses ChangePassword, HtmlHlp, Login,
  UConstTool, Option, DatabaseConnection, UConst, trsSales,
  MySQLConnector;

const
  MIN_MENU_HEIGHT = 23;

{$R *.dfm}


procedure RearrangeForms;
var i,j: integer; Form: TForm;
  Panel: TPanel;
  AdvStringGrid: TAdvStringGrid; AdvEdit: TAdvEdit; DateTimePicker: TDateTimePicker;
  SuiPanel : TsuiPanel; SuiChanel : TsuiSideChannel; SuiPageControl : TsuiPageControl;
  Labels: TLabel;
begin

  if ConnetedToDB then begin
    frmMainMenu.Caption := Application.Title+IfThen(not frmOption.ProcessRights,' [UnRegistered]');
    CompanyProfile.SelectInDB;
    GlobalSystemMenu_Arr.Clear;
    GlobalSystemMenu_Arr.LoadFromDB(boFalse, DEPT_ID_CASHIER);
    GlobalSystemConfig.loadFromDB;
  end
  else begin
    Application.Terminate;
    exit;
  end;

  for i:=0 to Application.ComponentCount-1 do
  if (Application.Components[i] is TForm) then begin
    Form := (Application.Components[i] as TForm);
    if (Form.Name='frmMainMenu') or (Form.Name='frmLogin')then continue;

    for j:=0 to Form.ComponentCount-1 do
    if (Form.Components[j] is TAdvStringGrid) then begin
      AdvStringGrid := (Form.Components[j] as TAdvStringGrid);
      AdvStringGrid.FixedColor          := clFixedColum;
      AdvStringGrid.FixedFont.Color     := clFixedFont;
      AdvStringGrid.Font.Style          := [];
      AdvStringGrid.SelectionColor      := clSelection;
      AdvStringGrid.Color               := clGrid;
      AdvStringGrid.Bands.PrimaryColor  := clPrimaryBand;
      AdvStringGrid.Bands.SecondaryColor:= clSecondaryBand;
      AdvStringGrid.Font.Color          := clLabel;//clFixedFont;
      AdvStringGrid.SelectionTextColor  := clFixedColum;//clFixedFont;
    //  if (Form.Name <> 'frmSetItemProses') then
      //  AdvStringGrid.Flat              := True;

    end else if (Form.Components[j] is TAdvEdit) then begin
      AdvEdit := (Form.Components[j] as TAdvEdit);
      AdvEdit.DisabledColor := AdvEdit.Color;
      if AdvEdit.Tag = -1 then begin
        AdvEdit.Color := clReadOnly;
        AdvEdit.Font.Color := clWhite;
      end;
    end else if (Form.Components[j] is TDateTimePicker) then begin
      DateTimePicker := (Form.Components[j] as TDateTimePicker);
      DateTimePicker.Format := '';
      if DateTimePicker.Kind=dtkDate then begin
        DateTimePicker.DateMode := dmComboBox;
        DateTimePicker.DateFormat := dfShort;
      end;

    end else if (Form.Components[j] is TPanel) then begin
      Panel := (Form.Components[j] as TPanel);
      Panel.Color := clFormBackGround;
      if (UpperCase(Panel.Name)='MAINPANEL') and (Panel.Name<>'MainPanel') then
        Panel.Name := 'MainPanel';
    end
    else if (Form.Components[j] is TLabel) then begin
      Labels := (Form.Components[j] as TLabel);
      Labels.Font.Color := clLabel;
    end
    else if (Form.Components[j] is TsuiPanel) then begin
      SuiPanel := (Form.Components[j] as TsuiPanel);
      SuiPanel.UIStyle := frmMainMenu.suiThemeManager1.UIStyle;// //FromThemeFile;
      SuiPanel.Color := clFormBackGround;
    end
    else if (Form.Components[j] is TsuiSideChannel) then begin
      SuiChanel := (Form.Components[j] as TsuiSideChannel);
      SuiChanel.Color := clFormBackGround;
      SuiChanel.UIStyle := frmMainMenu.suiThemeManager1.UIStyle;//FromThemeFile;
    end
    else if (Form.Components[j] is TsuiPageControl) then begin
      SuiPageControl := (Form.Components[j] as TsuiPageControl);
      SuiPageControl.Color := clFormBackGround;
      SuiPageControl.UIStyle := BlueGlass;//frmMainMenu.suiMainMenu1.UIStyle;//FromThemeFile;
    end;
  end;
end;

procedure InitializeApplication;
begin
  Application.Name     := 'cashier';
  Application.HelpFile := 'petshopCashier.chm';
  Application.Title    := 'Cashier '+DATE_VERSION;
end;

procedure FinalizeApplication;
begin
  GlobalSystemUser.SystemAccess_Arr.Clear;
  Application.Terminate;
end;

procedure Run(Sender: TForm);
var temp: TDockForm;
begin
  ActivateMainForm:= 1;

//form-form master ex frmMstItem...etc
  if Sender.Tag = 0 then
    Sender.ShowModal

//form-form trasaksi dan relkap ex frmTrsSales...etc
  else begin
    temp:= frmMainMenu.FindForm(Sender.Tag);
    frmMainMenu.DockedForm(temp);
  end;
end;

function ShowForm(ID: integer): TDockForm;
var temp: TDockForm;
begin
  temp:= frmMainMenu.FindForm(ID);
  if not Assigned(temp) then
    temp:= frmMainMenu.CreateDockableForm(ID);
  Result:= temp;
end;

procedure AssigControl(Sender: TObject);
begin
  AktiveControl:= (Sender as TForm);
end;

procedure reAssignLastControl;
begin
end;

procedure ScrollBox;
begin
  PostMessage(Application.MainForm.Handle,WM_ResizeScrollBoxMsg,Width,Height);
  Application.ProcessMessages;
end;

procedure StatusBar(Text: string);
begin
  PostMessage(Application.MainForm.Handle,wm_UpdateStatusBarMsg,0,0);
  Application.ProcessMessages;
end;

procedure StatusBar(Position: integer);
begin
  if (Position=-1) then
    PostMessage(Application.MainForm.Handle,wm_UpdateStatusBarMsg,2,0)
  else
    PostMessage(Application.MainForm.Handle,wm_UpdateStatusBarMsg,1,Position);
  Application.ProcessMessages;
end;

function Can_Access(Sender: TForm; MenuID: integer): boolean;
begin
  Result := TSystemAccess.Can_Access(Sender,MenuID);
  if not Result then begin
    Alert(MSG_UNAUTHORISED_ACCESS);
    exit;
  end;
end;

procedure TfrmMainMenu.FormCreate(Sender: TObject);
begin

  dockClientList:= TStringList.Create;

//load image
  ImageDll:= LoadLibrary('ImageList.dll');

//kasih warna default
  clHouverMenu  := clBlue;
  clUnHouverMenu:= clGreen;
  clFormBackGround := $00F3F3F3;
  clFixedColum     := $00462300;//$00605155;
  clFixedFont      := $00FCFCFC;
  clPrimaryBand    := $00D3FAE7;//$00F3F3F3;
  clSecondaryBand  := $00FEFFFF;
  clSelection      := $00C9F8E0;//$00DADCFE;//$00E4E4E4;
  clGrid           := $00FAF8F9;
  clFontColor      := $00643200;
  clTitle          := $00F9F9F9;
  clLabel          := $004F0000;
  clHeaderMenu     := $00F9F9F9;
  clFrame          := $00F9F9F9;
  clHouver         := $00006F00;//$000000B3;
  clUnHouver       := $00000000;

  Self.DoubleBuffered := true;
  StatusBar.Panels[0].Width := 200;     //tgl
  StatusBar.Panels[1].Width := 60;     //user
  StatusBar.Panels[2].Width := 60 ;     //num
  StatusBar.Panels[3].Width := 60;     //offline/online

  //StatusBar.Panels[2].Width := ClientWidth - StatusBar.Panels[1].Width - StatusBar.Panels[0].Width - StatusBar.Panels[3].Width;
  suiProgressBar1.SetBounds(
    StatusBar.Panels[0].Width + StatusBar.Panels[1].Width +
    StatusBar.Panels[2].Width + StatusBar.Panels[3].Width + 2,
    StatusBar.Top + 5, StatusBar.Panels[4].Width - 6, StatusBar.Height - 2);

   sttUser.SetBounds(
    StatusBar.Panels[0].Width ,
    StatusBar.Top+305 , StatusBar.Panels[1].Width-2,
    StatusBar.Height-2); 
  LastPageWidth := 0; LastPageHeight := 0;

  frmMainMenu.lblTanggal.Font.Color      := clFixedColum;
  frmMainMenu.lblUserLocation.Font.Color := clFixedColum;
end;

procedure TfrmMainMenu.FormActivate(Sender: TObject);
begin
  if not ConnetedToDB then Application.Terminate;
  if (GlobalSystemUser.UserID='') then begin
    FileLogoff1Click(nil);
    imgBanner.Picture.Bitmap.Handle:= LoadBitmap(ImageDll, 'banner_panjang');
  end;
end;

procedure TfrmMainMenu.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeLibrary(ImageDll);

  HHCloseAll;
  DestroyMenu;
  FinalizeApplication;
end;

procedure TfrmMainMenu.FormCanResize(Sender: TObject;
  var NewWidth, NewHeight: Integer; var Resize: Boolean);
begin
  Resize := (NewWidth>400) and (NewHeight>300);
end;

procedure TfrmMainMenu.Timer1Timer(Sender: TObject);
begin
  StatusBar.Panels[0].Text := FormatDateTime(LongDateFormat+' '+LongTimeFormat,Now);
end;

procedure TfrmMainMenu.ScrollBox1Resize(Sender: TObject);
begin // 552 x 362

  if (LastPageHeight<=ScrollBox1.Height) and
     (LastPageWidth<=ScrollBox1.Width) then
      HostPanel.Align := alClient

  else if (LastPageHeight<=ScrollBox1.Height) and
     (LastPageWidth>ScrollBox1.Width) then begin
      HostPanel.Align := alLeft;
      HostPanel.Width := LastPageWidth;

  end else if (LastPageHeight>ScrollBox1.Height) and
     (LastPageWidth<=ScrollBox1.Width) then begin
      HostPanel.Align := alTop;
      HostPanel.Height := LastPageHeight;

  end else if (LastPageHeight>ScrollBox1.Height) and
     (LastPageWidth>ScrollBox1.Width) then begin
      HostPanel.Align := alNone;
      HostPanel.Width := LastPageWidth;
      HostPanel.Height:= LastPageHeight;
  end;

end;

procedure TfrmMainMenu.UpdateStatusBar(var AMessage: TMessage);
begin
{  case AMessage.WParam of
    0: StatusBar.Panels[0].Text := StatusBarText;
    1: begin
      if (AMessage.LParam <> ProgressBar.Position) then
        ProgressBar.Position := AMessage.LParam ;
      ProgressBar.Show;
    end;
    2: ProgressBar.Hide;
  end;
}
end;

procedure TfrmMainMenu.ResizeScrollBox(var AMessage: TMessage);
begin
  if (AMessage.WParam>=0) then LastPageWidth := AMessage.WParam;
  if (AMessage.LParam>=0) then LastPageHeight := AMessage.LParam;
  ScrollBox1Resize(nil);
end;

procedure TfrmMainMenu.FileLogoff1Click(Sender: TObject);
begin

  GlobalSystemUser.Reset;
  LoginOn:= frmLogin.LogOn;
  if LoginOn then OpenForm(331);
  StatusBar.Panels[1].Text:= 'Opr : '+GlobalSystemUser.UserName;
  sttUser.Caption:= GlobalSystemUser.UserName;;
  if ConnetionIsOnline then
    StatusBar.Panels[3].Text:= 'ONLINE'
  else StatusBar.Panels[3].Text:= 'OFFLINE';
end;

procedure TfrmMainMenu.FileExit1Click(Sender: TObject);
begin
  FinalizeApplication;
end;

procedure TfrmMainMenu.lblUserLocationClick(Sender: TObject);
begin
  frmChangePassword.Execute(GlobalSystemUser.UserId);
end;

procedure TfrmMainMenu.DestroyMenu;
begin
  
end;


procedure TfrmMainMenu.CloseForm(control: TControl);
var can_close: boolean; ARect: TRect; form: TDockForm;
begin
  can_close:= true;
  form:= (control as TDockForm);
  with control do
  begin
    ARect.TopLeft := ClientToScreen(Point(0, 0));
    ARect.BottomRight := ClientToScreen(Point(UndockWidth, UndockHeight));
    ManualFloat(ARect);

    ActivateMainForm:= 1;
    form.OnCloseQuery(form, can_close);
    if can_close then
      form.Close;

    //if DockHost.PageCount > 0 then //begin
    //  DockHostChange(nil)
    //else AssigControl(frmMainMenu);
  end;

end;


{ TMenuLabel }

function TMenuLabel.add: integer;
begin
  setLength(ListLabel, length(ListLabel)+1);
  setLength(ListImage, length(ListImage)+1);
  Result := high(ListLabel);
  ListLabel[Result] := TLabel.Create(nil);
  ListImage[Result] := TImage.Create(nil);
end;

destructor TMenuLabel.destroy;
var i: integer;
begin
  for i:= 0 to length(ListLabel)-1 do begin
    ListLabel[i].Free;
    ListImage[i].Free;
  end;
  inherited;
end;

procedure ShortCutClick(Sender: TObject);
var AComponent : TComponent;
begin
  if (Assigned(AktiveControl )) then
    AComponent:= FindComponentTag(AktiveControl, (Sender as TMenuItem).Tag) as TComponent
  else exit;

  if Assigned(AComponent) then begin
     if ((Sender as TMenuItem).Tag > -30) then
       if (AComponent is TToolButton) then
         if (AComponent as TToolButton).Enabled then
           (AComponent as TToolButton).Click;
  end;
end;

procedure TfrmMainMenu.Browse1Click(Sender: TObject);
begin
  ShortCutClick(Sender);
end;

procedure TfrmMainMenu.FormShow(Sender: TObject);
begin
  suiForm1.Caption := Self.Caption;
end;

procedure TfrmMainMenu.mxProtector1InvalidSystemTime(Sender: TObject);
begin
  Inform( 'Your system time is invalid.' + #13 + #10 +
           'Please set the correct date and time to continue.');
end;

procedure TfrmMainMenu.mxProtector1Expiration(Sender: TObject);
begin
  Inform('This licence has expired');
  Application.Terminate;
  while Application.Terminated do
  Application.ProcessMessages;
end;

procedure TfrmMainMenu.Option1Click(Sender: TObject);
begin
  frmOption.Execute;
end;

procedure TfrmMainMenu.LogOff1Click(Sender: TObject);
begin
  FileLogoff1Click(Self);
end;

procedure TfrmMainMenu.Backup1Click(Sender: TObject);
begin
 // frmBackupRestore.Execute(BACKUP_DATABASE)
end;

procedure TfrmMainMenu.Restore1Click(Sender: TObject);
begin
 // frmBackupRestore.Execute(RESTORE_DATABASE)
end;

procedure TfrmMainMenu.PanelMenuResize(Sender: TObject);
begin
  Image1.Left:= PanelMenu.Width - Image1.Width - 5;
  lblUserLocation.Left:= Image1.Left - lblUserLocation.Width - 5;
  lblTanggal.Left:= Image1.Left - lblTanggal.Width - 5;
end;

procedure StartProgress();
begin
  frmMainMenu.suiProgressBar1.Position:= 0;
  frmMainMenu.suiProgressBar1.Show;
  frmMainMenu.timerProgresBar.Enabled:= True;
end;

procedure ProsesProgress(idx, data_count: integer);
begin
  frmMainMenu.suiProgressBar1.Position:= round((idx+1)/(data_count)*100);
end;

procedure EndProgress();
begin
  frmMainMenu.suiProgressBar1.Position:= 0;
  frmMainMenu.suiProgressBar1.Hide;
  frmMainMenu.StatusBar.Panels[4].Text:= '';
  frmMainMenu.timerProgresBar.Enabled:= False;
end;

function GetNumLockOn: boolean;
var KeyState: TKeyBoardState;
begin
  GetKeyboardState(KeyState);
  Result:= (GetKeyState(VK_NUMLOCK) = -127) or (GetKeyState(VK_NUMLOCK) = 1);
end;

procedure TfrmMainMenu.timerProgresBarTimer(Sender: TObject);
var textToDisplay: string; i: integer;
begin
  textToDisplay:= 'Silahkan tunggu beberapa saat, loading data...        ';
  i:= Length(StatusBar.Panels[4].Text);
  if i < Length(textToDisplay) then
    StatusBar.Panels[4].Text:= StatusBar.Panels[4].Text + Copy(textToDisplay, i+1, 1)
  else begin
    StatusBar.Panels[4].Text:= '';
    StatusBar.Panels[4].Text:= StatusBar.Panels[4].Text + Copy(textToDisplay, i+1, 1)
  end;
end;

procedure TfrmMainMenu.sttUserClick(Sender: TObject);
begin
  frmChangePassword.Execute(GlobalSystemUser.UserId);
end;

procedure TfrmMainMenu.OpenForm(AMenuID: integer; ADocking: boolean);
var Form: TDockForm; SystemMenu: TSystemMenu;
begin

  SystemMenu := GlobalSystemMenu_Arr.GetByMenuID(AMenuId);
  if (SystemMenu=nil) then
    raise EAbort.Create('SystemMenu not found.')
  else begin
    //jika form ud ada exit aja langsung di dokig
    Form := FindForm(AMenuID);
    if Assigned(Form) then
    begin
      DockedForm(Form);
      Exit;
    end;

    Form:= CreateDockableForm(AMenuID);
  end;

  if (SystemMenu.FormType in [ftMaster,ftTransaction, ftReport,ftSetting])
    and (ADocking) and (Form<>nil) then begin
    if not (Can_Access(Form, AMenuID)) then  Exit;

      //AMenuID length must be greather then "3 digit"
      case AMenuID of
        {SETTING}
        331: Form.Execute;
      end;
      Form.Caption := SystemMenu.MenuName;
  end;

end;

procedure TfrmMainMenu.FormDestroy(Sender: TObject);
begin
  dockClientList.Destroy
end;



procedure DeleteDockClientList(control: TDockForm);
var i, idx: integer;
begin
  idx:= -1;
  for i:= 0 to frmMainMenu.dockClientList.Count-1 do
    if (frmMainMenu.dockClientList.Names[i] = IntToStr(control.Tag)) then begin
        idx:= i;
        break;
    end;
  frmMainMenu.dockClientList.Delete(idx);
end;

procedure TfrmMainMenu.AppendClientList(tag: integer; clienName: string);
var i,x: integer;
begin
  x:= 0;
  for i:= 0 to dockClientList.Count-1 do
    if (dockClientList.Names[i] = IntToStr(tag)) then
      Inc(x);

  if x = 0 then
    dockClientList.Append(IntToStr(tag)+'='+clienName);
end;

procedure TfrmMainMenu.RearrangeNewForms(NewForm: TDockForm);
var i: integer;
  Panel: TPanel;
  AdvStringGrid: TAdvStringGrid; AdvEdit: TAdvEdit; DateTimePicker: TDateTimePicker;
  SuiPanel: TsuiPanel; SuiChanel: TsuiSideChannel; SuiPageControl: TsuiPageControl;
  Labels: TLabel;
begin
  for i:=0 to NewForm.ComponentCount-1 do
    if (NewForm.Components[i] is TAdvStringGrid) then begin
      AdvStringGrid := (NewForm.Components[i] as TAdvStringGrid);
      AdvStringGrid.FixedColor          := clFixedColum;
      AdvStringGrid.FixedFont.Color     := clFixedFont;
      AdvStringGrid.Font.Style          := [];
      AdvStringGrid.SelectionColor      := clSelection;
      AdvStringGrid.Color               := clGrid;
      AdvStringGrid.Bands.PrimaryColor  := clPrimaryBand;
      AdvStringGrid.Bands.SecondaryColor:= clSecondaryBand;
      AdvStringGrid.Font.Color          := clLabel;//clFixedFont;
      AdvStringGrid.SelectionTextColor  := clFixedColum;//clFixedFont;

    end else if (NewForm.Components[i] is TAdvEdit) then begin
      AdvEdit := (NewForm.Components[i] as TAdvEdit);
      AdvEdit.DisabledColor := AdvEdit.Color;
      if AdvEdit.Tag = -1 then begin
        AdvEdit.Color := clReadOnly;
        AdvEdit.Font.Color := clWhite;
      end;

    end else if (NewForm.Components[i] is TDateTimePicker) then begin
      DateTimePicker := (NewForm.Components[i] as TDateTimePicker);
      DateTimePicker.Format := '';
      if DateTimePicker.Kind=dtkDate then begin
        DateTimePicker.DateMode := dmComboBox;
        DateTimePicker.DateFormat := dfShort;
      end;

    end else if (NewForm.Components[i] is TPanel) then begin
      Panel := (NewForm.Components[i] as TPanel);
      Panel.Color := clFormBackGround;
      if (UpperCase(Panel.Name)='MAINPANEL') and (Panel.Name<>'MainPanel') then
        Panel.Name := 'MainPanel';
    end
    else if (NewForm.Components[i] is TLabel) then begin
      Labels := (NewForm.Components[i] as TLabel);
      Labels.Font.Color := clLabel;
    end
    else if (NewForm.Components[i] is TsuiPanel) then begin
      SuiPanel := (NewForm.Components[i] as TsuiPanel);
      SuiPanel.UIStyle := frmMainMenu.suiThemeManager1.UIStyle;// //FromThemeFile;
      SuiPanel.Color := clFormBackGround;
    end
    else if (NewForm.Components[i] is TsuiSideChannel) then begin
      SuiChanel := (NewForm.Components[i] as TsuiSideChannel);
      SuiChanel.Color := clFormBackGround;
      SuiChanel.UIStyle := frmMainMenu.suiThemeManager1.UIStyle;//FromThemeFile;
    end
    else if (NewForm.Components[i] is TsuiPageControl) then begin
      SuiPageControl := (NewForm.Components[i] as TsuiPageControl);
      SuiPageControl.Color := clFormBackGround;
      SuiPageControl.UIStyle := BlueGlass;//frmMainMenu.suiMainMenu1.UIStyle;//FromThemeFile;
    end;
 
end;

function TfrmMainMenu.FindForm(tag: integer): TDockForm;
var idx: integer; temp: TDockForm;
begin
  idx:= dockClientList.IndexOfName(IntToStr(tag));
  if (idx >= 0) and (idx < dockClientList.Count) then
    temp:= TDockForm(Application.FindComponent(dockClientList.Values[dockClientList.Names[idx]]))
  else temp:= nil;

  Result:= temp;
end;

function TfrmMainMenu.CreateDockableForm(tag: integer): TDockForm;
var temp: TDockForm;
begin

  case tag of
    331:
    begin
      Application.CreateForm(TfrmTrsSales, frmTrsSales);
      temp:= frmTrsSales;
    end;
    else temp:= nil;
  end;

  temp.Tag:= tag;
  RearrangeNewForms(temp);
  AppendClientList(tag, temp.Name);
  Result:= temp;

end;

procedure TfrmMainMenu.DockedForm(Sender: TDockForm);
begin
  if not Sender.Showing then
    Sender.Show;

  Sender.ManualDock(HostPanel);

  LastPageWidth := HostPanel.Width;
  LastPageHeight:= HostPanel.Height;
  ScrollBox1Resize(nil);
end;

procedure TfrmMainMenu.HostPanelDockDrop(Sender: TObject;
  Source: TDragDockObject; X, Y: Integer);
begin
  ActivateMainForm:= 0;
  assigControl(Source.Control)
end;

procedure TfrmMainMenu.HostPanelDockOver(Sender: TObject;
  Source: TDragDockObject; X, Y: Integer; State: TDragState;
  var Accept: Boolean);
begin
  Accept := Source.Control is TDockForm;
end;

procedure TfrmMainMenu.HostPanelUnDock(Sender: TObject; Client: TControl;
  NewTarget: TWinControl; var Allow: Boolean);
begin
  ActivateMainForm:= 1;
  if HostPanel.DockClientCount = 0 then
     AssigControl(frmMainMenu)
  else FormActivate(Client)
end;

procedure TfrmMainMenu.StatusBarDrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
begin
  if Panel = StatusBar.Panels[2] then
  begin
    With StatusBar.Canvas do begin
      Brush.Color := StatusBar.Color;
      FillRect(Rect);
      Font.Name := 'Tahoma';
      if GetNumLockOn then
        Font.Color := clBlack
      else Font.Color := clGray; 
      Font.Style := [];
      TextRect(Rect, Rect.Left + 2, Rect.Top+2, 'NUMLOCK');
    end;
  end;
end;

procedure TfrmMainMenu.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    vk_F1: HHDisplayTOC; 
  end;
end;

end.


