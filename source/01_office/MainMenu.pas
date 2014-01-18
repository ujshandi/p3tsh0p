unit MainMenu;

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
    SideMenu: TsuiSideChannel;
    PanelDataHeader: TsuiPanel;
    scbData: TScrollBox;
    PanelTransactionHeader: TsuiPanel;
    scbTransaction: TScrollBox;
    PanelReportHeader: TsuiPanel;
    scbReport: TScrollBox;
    PanelSettingHeader: TsuiPanel;
    scbSetting: TScrollBox;
    StatusBar: TStatusBar;
    Splitter1: TSplitter;
    PrinterSetupDialog1: TPrinterSetupDialog;
    PanelMenu: TPanel;
    lblUserLocation: TLabel;
    lblTanggal: TLabel;
    Image1: TImage;
    imgBanner: TImage;
    ShortcutBarButtonPopupMenu: TPopupMenu;
    Open1: TMenuItem;
    OpeninNewWindow1: TMenuItem;
    N15: TMenuItem;
    RemovefromOutlookBar1: TMenuItem;
    RenameShortcut1: TMenuItem;
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
    sttUser: TStaticText;
    DockHost: TPageControl;
    ScrollBox1: TScrollBox;
    imagePageList: TImageList;
    PanelHome: TsuiPanel;
    scbHome: TScrollBox;
    Bevel1: TBevel;
    Label4: TLabel;
    Label8: TLabel;
    Panel3: TPanel;
    imgLogOff: TImage;
    lblLogOff: TLabel;
    Panel4: TPanel;
    imgExit: TImage;
    Label2: TLabel;
    Panel6: TPanel;
    ImgAbout: TImage;
    lblAbout: TLabel;
    Panel7: TPanel;
    ImgHelp: TImage;
    Label3: TLabel;
    Panel8: TPanel;
    ImgRestore: TImage;
    Label5: TLabel;
    Panel9: TPanel;
    ImgBackup: TImage;
    Label6: TLabel;
    Panel10: TPanel;
    ImgOption: TImage;
    Label7: TLabel;
    suiThemeManager2: TsuiThemeManager;

    //new style by jay...
    procedure ScrollMenu(Sender: TObject);
    procedure Houver(Sender: TObject);
    procedure unHouver(Sender: TObject);
    procedure ClickColor(Sender: TObject);
    procedure unClickColor(Sender: TObject);
    procedure CloseForm(control: TControl);

    procedure UpdateStatusBar(var AMessage: TMessage); message WM_UpdateStatusBarMsg;
    procedure ResizeScrollBox(var AMessage: TMessage); message WM_ResizeScrollBoxMsg;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCanResize(Sender: TObject; var NewWidth,
      NewHeight: Integer; var Resize: Boolean);
    procedure ScrollBox1Resize(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);

  //short cut

    { MainMenu events }
    procedure FilePrintSetup1Click(Sender: TObject);
    procedure FileLogoff1Click(Sender: TObject);
    procedure FileExit1Click(Sender: TObject);
    procedure ViewGoToMenu1Click(Sender: TObject);
    procedure HelpContent1Click(Sender: TObject);
    procedure HelpTopicSearch1Click(Sender: TObject);
    procedure ButtonClick(Sender: TObject);
    procedure MenuItemClick(Sender: TObject);

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure lblUserLocationClick(Sender: TObject);

    procedure lblHomeClick(Sender: TObject);
    procedure imgNavigatorClick(Sender: TObject);
    procedure PanelDataHeaderPop(Sender: TObject);
    procedure SideMenuPop(Sender: TObject);
    procedure SideMenuPush(Sender: TObject);
    procedure Browse1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure mxProtector1InvalidSystemTime(Sender: TObject);
    procedure mxProtector1Expiration(Sender: TObject);
    procedure PanelOtherHeaderPop(Sender: TObject);
    procedure Option1Click(Sender: TObject);
    procedure LogOff1Click(Sender: TObject);
    procedure Backup1Click(Sender: TObject);
    procedure Restore1Click(Sender: TObject);
    procedure PanelMenuResize(Sender: TObject);
    procedure timerProgresBarTimer(Sender: TObject);
    procedure sttUserClick(Sender: TObject);
    procedure DockHostDockDrop(Sender: TObject; Source: TDragDockObject; X,
      Y: Integer);
    procedure DockHostMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DockHostMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DockHostMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormDestroy(Sender: TObject);
    procedure DockHostUnDock(Sender: TObject; Client: TControl;
      NewTarget: TWinControl; var Allow: Boolean);
    procedure DockHostChange(Sender: TObject);
    procedure DockHostDockOver(Sender: TObject; Source: TDragDockObject; X,
      Y: Integer; State: TDragState; var Accept: Boolean);
    procedure E1Click(Sender: TObject);
    procedure lblAboutClick(Sender: TObject);
    procedure Label3Click(Sender: TObject);

  protected
    { Private declarations }

    MAX_SCROLLBAR_HEIGHT, LastPageWidth, LastPageHeight, MenuIdx: integer;
    ActiveMenu, MenuAlignment: string;
    CurrentTopic: string;
    MenuIndex: TMenuLabel;

    ActiveLabel: TLabel;
    LoginOn, ChanelIsPop: boolean;
    dockClientList: TStringList;

    //new style by jay...
    function GetScrollBox(Sender: TPanel): TScrollBox;
    function SetMenuHeight(Sender: TsuiPanel): TScrollBox;

    procedure DestroyMenu;
    procedure AddNewMenu(AParent: TScrollBox; ACaption: string; ATag: integer; AEnabled, AIsHeader: boolean; AImageDefault: string);
    procedure AddMainMenuItem(AMenuItem: TMenuItem; ACaption: string; AImageIndex: integer; AShortcut: TShortcut; ATag: integer; AEnabled, AIsHeader: boolean);

    procedure ArrangeMenuIndex;
    procedure CreateSystemMenu;

    procedure OpenForm(AMenuID: integer; ADocking: boolean = true);
    procedure AppendClientList(tag: integer; clienName: string);
    function CreateDockableForm(tag: integer): TDockForm;
    function FindForm(tag: integer): TDockForm;

    procedure DockedForm(Sender: TDockForm);
    procedure RearrangeNewForms(NewForm: TDockForm);
  end;

var
  frmMainMenu: TfrmMainMenu;
  //Logo1, Logo2: string;
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

implementation

uses About, ChangePassword, HtmlHlp, Login,
  UConstTool, Option, BackupRestore, DatabaseConnection, UConst, KelolaUser,
  MstUnit, MstCode, MstItemList, TrsItemShipmentList,
   MySQLConnector,
  {trsPurchaseOrderList, trsPurchaseOrder, MstRelationList, trsReceipt,
  trsRetur, trsPembayaran, trsPembayaranList, ReportStok, ReportDebt, ReportProfit, trsAkun,}
  //ReportItemQty,
  ReportPenjualan,
  MstRelationList,
  ReportStok, trsPurchaseOrderList, trsPurchaseOrder, trsReceipt, trsRetur,
  MstServiceList, MstAnimalList, MstServicePrice, MstBranchList,
  TrsItemShipment, Bonus, MstItemPriceList, trsPembayaranList, ReportKas,
  MstAkun, TrsItemUsetList, TrsItemUse, ReportProfit, ReportItemMovement,
  MstKaryawanList, trsAbsensiList;

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
    GlobalSystemMenu_Arr.LoadFromDB(boFalse);
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
      if Labels.Tag <> -1 then Labels.Font.Color := clLabel;
    end
    else if (Form.Components[j] is TsuiPanel) then begin
      SuiPanel := (Form.Components[j] as TsuiPanel);
      SuiPanel.UIStyle := frmMainMenu.suiThemeManager2.UIStyle;
      SuiPanel.Color := clFormBackGround;
    end
    else if (Form.Components[j] is TsuiSideChannel) then begin
      SuiChanel := (Form.Components[j] as TsuiSideChannel);
      SuiChanel.Color := clFormBackGround;
      SuiChanel.UIStyle := frmMainMenu.suiThemeManager2.UIStyle;
    end
    else if (Form.Components[j] is TsuiPageControl) then begin
      SuiPageControl := (Form.Components[j] as TsuiPageControl);
      SuiPageControl.Color := clFormBackGround;
      SuiPageControl.UIStyle := BlueGlass;//frmMainMenu.suiMainMenu1.UIStyle;//FromThemeFile;
    end;

  end;
  frmMainMenu.PanelHome.BorderColor:= clWhite;
  frmMainMenu.PanelDataHeader.BorderColor:= clWhite;
  frmMainMenu.PanelTransactionHeader.BorderColor:= clWhite;
  frmMainMenu.PanelSettingHeader.BorderColor:= clWhite;
  frmMainMenu.PanelReportHeader.BorderColor:= clWhite;
end;

procedure InitializeApplication;
begin
  Application.Name     := 'petShop';
  Application.HelpFile := 'petShop.chm';
  Application.Title    := 'Pet Shop Plus '+DATE_VERSION +IfThen(DEMO_VERSION, ' [demo version]');
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
  AssigControl(Sender);

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
  clFixedColum     := $00404080;//$00462300;//$00605155;
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
  StatusBar.Panels[0].Width := 200;
  StatusBar.Panels[1].Width := 100;
  StatusBar.Panels[3].Width := 200;

  StatusBar.Panels[2].Width := ClientWidth - StatusBar.Panels[1].Width - StatusBar.Panels[0].Width - StatusBar.Panels[3].Width;
  suiProgressBar1.SetBounds(StatusBar.Panels[0].Width + StatusBar.Panels[1].Width + StatusBar.Panels[2].Width + 2,
  StatusBar.Top + 5, StatusBar.Panels[3].Width - 6, StatusBar.Height - 2);

  sttUser.SetBounds(
    ClientWidth - StatusBar.Panels[1].Width -
    StatusBar.Panels[2].Width - StatusBar.Panels[3].Width + 2,
    StatusBar.Top + 4, StatusBar.Panels[1].Width-2,
    StatusBar.Height-2);

  LastPageWidth := 0; LastPageHeight := 0;

  frmMainMenu.PanelDataHeader.Push;
  frmMainMenu.PanelTransactionHeader.Push;
  frmMainMenu.PanelReportHeader.Push;
  frmMainMenu.PanelSettingHeader.Push;

  frmMainMenu.lblTanggal.Font.Color      := clFixedColum;
  frmMainMenu.lblUserLocation.Font.Color := clFixedColum;
  frmMainMenu.Splitter1.Color            := clFormBackGround;
end;

procedure TfrmMainMenu.FormActivate(Sender: TObject);
begin
  if not ConnetedToDB then Application.Terminate;
  if (GlobalSystemUser.UserID='') then begin
    FileLogoff1Click(nil);
    imgLogOff.Picture.Bitmap.Handle:= LoadBitmap(ImageDll, 'log_off');
    imgExit.Picture.Bitmap.Handle:= LoadBitmap(ImageDll, 'shut_down');
    ImgOption.Picture.Bitmap.Handle:= LoadBitmap(ImageDll, 'tools');
    ImgBackup.Picture.Bitmap.Handle:= LoadBitmap(ImageDll, 'Backup');
    ImgRestore.Picture.Bitmap.Handle:= LoadBitmap(ImageDll, 'restore');
    ImgAbout.Picture.Bitmap.Handle:= LoadBitmap(ImageDll, 'information');
    ImgHelp.Picture.Bitmap.Handle:= LoadBitmap(ImageDll, 'help');
    imgBanner.Picture.Bitmap.Handle:= LoadBitmap(ImageDll, 'banner_panjang');
    lblAboutClick(nil);
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

{  if (LastPageHeight<=ScrollBox1.Height) and
     (LastPageWidth<=ScrollBox1.Width) then
      DockHost.Align := alClient

  else if (LastPageHeight<=ScrollBox1.Height) and
     (LastPageWidth>ScrollBox1.Width) then begin
      DockHost.Align := alLeft;
      DockHost.Width := LastPageWidth;

  end else if (LastPageHeight>ScrollBox1.Height) and
     (LastPageWidth<=ScrollBox1.Width) then begin
      DockHost.Align := alTop;
      DockHost.Height := LastPageHeight;

  end else if (LastPageHeight>ScrollBox1.Height) and
     (LastPageWidth>ScrollBox1.Width) then begin
      DockHost.Align := alNone;
      DockHost.Width := LastPageWidth;
      DockHost.Height:= LastPageHeight;
  end;
 }
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

procedure TfrmMainMenu.FilePrintSetup1Click(Sender: TObject);
begin
  PrinterSetupDialog1.Execute;
end;

procedure TfrmMainMenu.FileLogoff1Click(Sender: TObject);
begin

  GlobalSystemUser.Reset;
  LoginOn:= frmLogin.LogOn;
  
  lblLogOff.Caption := IfThen(LoginOn,'Log Off','Log In');
  CreateSystemMenu;
end;

procedure TfrmMainMenu.FileExit1Click(Sender: TObject);
begin
  FinalizeApplication;
end;

procedure TfrmMainMenu.ViewGoToMenu1Click(Sender: TObject);
var MenuID: string;tmp:integer;
begin
  if InputQuery('Go To Menu','Menu Number',MenuID) then begin
     if UpperCase(copy(MenuID,1,1))= 'M' then
       tmp := StrToIntDef('6'+copy(MenuID,2,3),0)
     else
       tmp := StrToIntDef(MenuID,0);
    OpenForm(tmp);
  end;
end;

procedure TfrmMainMenu.HelpContent1Click(Sender: TObject);
begin
  //Application.HelpCommand(HELP_FINDER, 0);
  HHDisplayTOC;
end;

procedure TfrmMainMenu.HelpTopicSearch1Click(Sender: TObject);
begin
 // Application.HelpCommand(HELP_FINDER, Integer(PChar('')));
  HHDisplayIndex('');
end;

procedure TfrmMainMenu.lblUserLocationClick(Sender: TObject);
begin
  frmChangePassword.Execute(GlobalSystemUser.UserId);
end;

procedure TfrmMainMenu.ButtonClick(Sender: TObject);
begin
  ClickColor(Sender);
  OpenForm(TComponent(Sender).Tag);
end;

procedure TfrmMainMenu.MenuItemClick(Sender: TObject);
begin
  OpenForm(TComponent(Sender).Tag);
end;

procedure TfrmMainMenu.Houver(Sender: TObject);
begin

  if not ((Sender as TControl).Enabled) then Exit;
  (Sender as TLabel).Font.Style:= [];
  (Sender as TLabel).Font.Size:= 10;

  if (Sender as TLabel).Name <> ActiveMenu then begin
    (Sender as TLabel).Font.Color:= clHouver;
    (Sender as TLabel).Cursor := crHandPoint;
  end;

end;

procedure TfrmMainMenu.unHouver(Sender: TObject);
begin
  (Sender as TLabel).Font.Style:= [];
  (Sender as TLabel).Font.Size:= 8;
  if (Sender as TLabel).Name <> ActiveMenu then begin
    (Sender as TLabel).Font.Color:= IfThen((Sender as TLabel).Tag = -1, clFrame, clUnHouver);
    (Sender as TLabel).Cursor := crDefault;
  end;
end;

procedure TfrmMainMenu.CreateSystemMenu;
var i: integer; LastMenuGroup: string;
  vParent: TScrollBox; isRegistered:boolean;
begin
  if not ConnetedToDB then exit;
  frmMainMenu.Caption := Application.Title+IfThen(not frmOption.ProcessRights,' [UnRegistered]')+
  ' [Demo Versio]';
  isRegistered := frmOption.ProcessRights;
  DestroyMenu;

  sttUser.Caption:= GlobalSystemUser.UserName;;
  tag := 0;
  MenuIdx:= 0;
  MenuIndex:= TMenuLabel.Create;

  for i:=0 to GlobalSystemMenu_Arr.Count-1 do
    with GlobalSystemMenu_Arr[i] do begin
      case FormType of
        ftMaster     : vParent:= scbData;
        ftTransaction: vParent:= scbTransaction;
        ftReport     : vParent:= scbReport;
        ftSetting    : vParent := scbSetting;
        else vParent:= nil;
      end;
      if (vParent = nil) then continue;

      if (MenuGroup<>LastMenuGroup) then begin
        LastMenuGroup:= MenuGroup;
        Self.AddNewMenu(vParent, MenuGroup, 0, LoginOn and isRegistered, True, '');
        Self.AddNewMenu(vParent, MenuName, MenuId, LoginOn and isRegistered, False, ImageDefault);

      end else begin
        Self.AddNewMenu(vParent, MenuName, MenuId, LoginOn and isRegistered, False, ImageDefault);

      end;
    end;

  ArrangeMenuIndex;
end;

procedure TfrmMainMenu.ArrangeMenuIndex;
var idx, ImIdx: integer;

//begin procedure..........................................
  procedure reindex(AScrollBox: TScrollBox);
  var i,j: integer; tmpPanel: TPanel;
  begin
    for i:= AScrollBox.ControlCount-1 downto 0 do begin
      tmpPanel:= (AScrollBox.Controls[i] as TPanel);
      for j:= 0 to tmpPanel.ControlCount-1 do begin
        if (tmpPanel.Controls[j] is TLabel) then begin
          (tmpPanel.Controls[j] as TLabel).Enabled      := MenuIndex.ListLabel[idx].Enabled;
          (tmpPanel.Controls[j] as TLabel).Caption      := MenuIndex.ListLabel[idx].Caption;
          (tmpPanel.Controls[j] as TLabel).Tag          := MenuIndex.ListLabel[idx].Tag;
          (tmpPanel.Controls[j] as TLabel).Align        := MenuIndex.ListLabel[idx].Align;
          (tmpPanel.Controls[j] as TLabel).Constraints  := MenuIndex.ListLabel[idx].Constraints;
          (tmpPanel.Controls[j] as TLabel).AutoSize     := MenuIndex.ListLabel[idx].AutoSize;
          (tmpPanel.Controls[j] as TLabel).ParentFont   := MenuIndex.ListLabel[idx].ParentFont;
          (tmpPanel.Controls[j] as TLabel).Font.Name    := MenuIndex.ListLabel[idx].Font.Name;
          (tmpPanel.Controls[j] as TLabel).Font.Size    := MenuIndex.ListLabel[idx].Font.Size;
          (tmpPanel.Controls[j] as TLabel).Font.Color   := MenuIndex.ListLabel[idx].Font.Color;
          (tmpPanel.Controls[j] as TLabel).Layout       := MenuIndex.ListLabel[idx].Layout;
          (tmpPanel.Controls[j] as TLabel).OnMouseEnter := MenuIndex.ListLabel[idx].OnMouseEnter;
          (tmpPanel.Controls[j] as TLabel).OnMouseLeave := MenuIndex.ListLabel[idx].OnMouseLeave;
          if (MenuIndex.ListLabel[idx].Name <> '') then
            (tmpPanel.Controls[j] as TLabel).Name       := MenuIndex.ListLabel[idx].Name+'Xp'
          else
            tmpPanel.Tag        := -2; //untuk nandain mana yang header

          (tmpPanel.Controls[j] as TLabel).OnClick      := MenuIndex.ListLabel[idx].OnClick;
          Inc(idx);
        end;

        if (tmpPanel.Controls[j] is TImage) then begin
          (tmpPanel.Controls[j] as TImage).Align       := MenuIndex.ListImage[ImIdx].Align;
          (tmpPanel.Controls[j] as TImage).Picture     := MenuIndex.ListImage[ImIdx].Picture;
          (tmpPanel.Controls[j] as TImage).Height      := MenuIndex.ListImage[ImIdx].Height;
          (tmpPanel.Controls[j] as TImage).Transparent := MenuIndex.ListImage[ImIdx].Transparent;
          (tmpPanel.Controls[j] as TImage).Tag         := MenuIndex.ListImage[ImIdx].Tag;
          Inc(ImIdx);
        end;

      end;
    end;

  //buang image menu group
    for i:= AScrollBox.ControlCount-1 downto 0 do begin
      tmpPanel:= (AScrollBox.Controls[i] as TPanel);
      if tmpPanel.Tag = -2 then begin
        for j:= 0 to tmpPanel.ControlCount-1 do
          if (tmpPanel.Controls[j] is TImage) then
            (tmpPanel.Controls[j] as TImage).Width:= 0
          else
            (tmpPanel.Controls[j] as TLabel).Align:= alClient;

        tmpPanel.Height:= 25;
      end;
    end;
  end;
//end procedure..........................................

begin

  idx:=0; ImIdx:=0;
  reindex(scbSetting);
  reindex(scbData);
  reindex(scbTransaction);
  reindex(scbReport);

end;

procedure TfrmMainMenu.DestroyMenu;
var i, j, k: integer;
  ScrollBox: TScrollBox;
  ASuiPanel: TsuiPanel; form: TDockForm;
begin
  ActiveLabel:= nil;

  for i:= 0 to SideMenu.ControlCount-1 do
    if (SideMenu.Controls[i] is TsuiPanel) then begin
      ASuiPanel:= SideMenu.Controls[i] as TsuiPanel;
      for j:= 0 to ASuiPanel.ControlCount-1 do begin
        if (ASuiPanel.Controls[j] is TScrollBox) then begin
          ScrollBox:= ASuiPanel.Controls[j] as TScrollBox;
          for k:= 0 to ScrollBox.ControlCount-1 do
            if ScrollBox.Name <> 'scbHome' then
              ScrollBox.Controls[ScrollBox.ControlCount-1].Destroy;
        end;
      end;
    end;

  for i:= 0 to DockHost.DockClientCount-1 do begin
    form:= (DockHost.DockClients[0] as TDockForm);
    form.Close;
    form.Free;
  end;

  dockClientList.Clear;
end;



procedure TfrmMainMenu.ScrollMenu(Sender: TObject);
var i: integer; ScrollBox: TScrollBox;
  SuiPanel: TsuiPanel;
  const CAPTION_HEIGHT = 20; //20
  const PANEL_HEIGHT = 28;//36; //28

begin
 // ScrollBox:= nil;
  MAX_SCROLLBAR_HEIGHT:=
    frmMainMenu.Height -  PanelMenu.Height - // PanelMenuBottom.Height - PanelMenuTop.Height -
    (MIN_MENU_HEIGHT * 7);

  SuiPanel:= (Sender as TsuiPanel);
  if not Assigned(SuiPanel) then Exit;

  SuiPanel.Tag:= -1;
  ScrollBox:= SetMenuHeight(SuiPanel);
  SuiPanel.Height:= IfThen( ScrollBox.Height <> 0, ScrollBox.Height + PANEL_HEIGHT, CAPTION_HEIGHT);

  if SuiPanel.Height > MAX_SCROLLBAR_HEIGHT then
    SuiPanel.Height:= MAX_SCROLLBAR_HEIGHT;

//biar auto scroll
  ScrollBox.Height:= SuiPanel.Height - CAPTION_HEIGHT+1;

  for i:= 0 to SideMenu.ControlCount-1 do begin
    if SideMenu.Controls[i] is TsuiPanel then begin
      SuiPanel:= SideMenu.Controls[i] as TsuiPanel;

      if SuiPanel.Tag <> -1 then
        SuiPanel.Push
      else SuiPanel.Tag:= 0;
    end;

  end;
end;

procedure TfrmMainMenu.ClickColor(Sender: TObject);
begin
  (Sender as TLabel).Font.Style:= [];
  (Sender as TLabel).Font.Color:= clGreen;
  unClickColor(Sender);
  ActiveLabel:= (Sender as TLabel);
  ActiveMenu := ActiveLabel.Name;
end;

procedure TfrmMainMenu.unClickColor(Sender: TObject);
begin
  if ActiveLabel <> nil then ActiveLabel.Font.Color:= clUnHouver;
end;

procedure TfrmMainMenu.AddNewMenu(AParent: TScrollBox; ACaption: string;
  ATag: integer; AEnabled, AIsHeader: boolean; AImageDefault: string);
var NewLabel: TLabel; ImageMenu: TImage; mPanel: TPanel;
begin

//buat panel untuk nempel menu dan image
  mPanel            := TPanel.Create(nil);
  mPanel.Parent     := AParent;
  mPanel.Height     := 32; //20
  mPanel.BevelOuter := bvNone;
  mPanel.Align      := alTop;
  mPanel.ParentColor:= True;

//buat image untuk menu
  ImageMenu:= TImage.Create(nil);
  ImageMenu.Parent:= mPanel;
  ImageMenu.Align:= alLeft;
  ImageMenu.Transparent:= true;
  ImageMenu.Tag:= ATag;

//buat label untuk menu utama
  NewLabel:= TLabel.Create(nil);
  NewLabel.Enabled     := AEnabled;
  NewLabel.Caption     := ACaption +' ('+ IntToStr(ATag)+')';
  NewLabel.Tag         := ATag;
  NewLabel.Layout      := tlCenter;
  NewLabel.ShowAccelChar := False;

  NewLabel.Height := 32;
  NewLabel.AutoSize    := True;
  NewLabel.ParentFont  := False;
  NewLabel.Font.Name   := 'Tahoma';
  NewLabel.Font.Size   := 8;
  NewLabel.Font.Color  := clUnHouver;
  NewLabel.Parent      := mPanel;
  ImageMenu.Width:= 32;
  ImageMenu.Stretch := True;
  if AIsHeader then begin
    NewLabel.Caption   := '_'+ACaption+'»'; //'[' + ACaption + ']';
    NewLabel.Tag       := 0;
    NewLabel.Enabled   := False;
    NewLabel.Layout    := tlBottom;
  end else
  begin
    ImageMenu.Picture.Bitmap.Handle:= LoadBitmap(ImageDll, PChar(AImageDefault));
    NewLabel.Align       := alClient;
    NewLabel.OnMouseEnter:= Houver;
    NewLabel.OnMouseLeave:= unHouver;
    NewLabel.Name        := 'menu'+IntToStr(ATag);
    NewLabel.OnClick     := ButtonClick;
  end;

//menu label
  MenuIdx:= MenuIndex.add;
  MenuIndex.ListLabel[MenuIdx].Enabled      := NewLabel.Enabled;
  MenuIndex.ListLabel[MenuIdx].Caption      := NewLabel.Caption;
  MenuIndex.ListLabel[MenuIdx].Tag          := NewLabel.Tag;
  MenuIndex.ListLabel[MenuIdx].Align        := NewLabel.Align;
  MenuIndex.ListLabel[MenuIdx].Constraints  := NewLabel.Constraints;
  MenuIndex.ListLabel[MenuIdx].AutoSize     := NewLabel.AutoSize;
  MenuIndex.ListLabel[MenuIdx].ParentFont   := NewLabel.ParentFont;
  MenuIndex.ListLabel[MenuIdx].Font.Name    := NewLabel.Font.Name;
  MenuIndex.ListLabel[MenuIdx].Font.Style   := NewLabel.Font.Style;
  MenuIndex.ListLabel[MenuIdx].Font.Size    := NewLabel.Font.Size;
  MenuIndex.ListLabel[MenuIdx].Font.Color   := NewLabel.Font.Color;
  MenuIndex.ListLabel[MenuIdx].Layout       := NewLabel.Layout;
  MenuIndex.ListLabel[MenuIdx].OnMouseEnter := NewLabel.OnMouseEnter;
  MenuIndex.ListLabel[MenuIdx].OnMouseLeave := NewLabel.OnMouseLeave;
  MenuIndex.ListLabel[MenuIdx].Name         := NewLabel.Name;
  MenuIndex.ListLabel[MenuIdx].OnClick      := NewLabel.OnClick;

//menu image
  MenuIndex.ListImage[MenuIdx].Align        := ImageMenu.Align;
  MenuIndex.ListImage[MenuIdx].Width        := ImageMenu.Width;
  MenuIndex.ListImage[MenuIdx].Tag          := ImageMenu.Tag;
  MenuIndex.ListImage[MenuIdx].Transparent  := ImageMenu.Transparent;
  MenuIndex.ListImage[MenuIdx].Picture      := ImageMenu.Picture;

end;

procedure TfrmMainMenu.AddMainMenuItem(AMenuItem: TMenuItem; ACaption: string;
  AImageIndex: integer; AShortcut: TShortcut; ATag: integer; AEnabled, AIsHeader: boolean);
var NewMenuItem: TMenuItem;
begin
  NewMenuItem            := TMenuItem.Create(AMenuItem);
  NewMenuItem.Caption    := IntToStr(ATag)+' - ' + ACaption;
  NewMenuItem.ImageIndex := AImageIndex;

 // NewMenuItem.ShortCut   := ShortCut(Word('S'), [ssCtrl]);
  NewMenuItem.Tag        := ATag;
  NewMenuItem.Enabled    := AEnabled;
  NewMenuItem.OnClick    := MenuItemClick;

  if AIsHeader then begin
    NewMenuItem.ImageIndex:= -1;
    NewMenuItem.Caption   := '[' + ACaption + ']';
    NewMenuItem.Tag       := 0;
    NewMenuItem.Enabled   := False;
  end;
  AMenuItem.Add(NewMenuItem);
end;

function TfrmMainMenu.SetMenuHeight(Sender: TsuiPanel): TScrollBox;
var i,j: integer; ScrollBox: TScrollBox;
begin
  Result:= nil;
  for i:= 0 to Sender.ControlCount-1 do
    if (Sender.Controls[i] is TScrollBox) then begin
       ScrollBox:= (Sender.Controls[i] as TScrollBox);
       ScrollBox.Height:= IfThen(ScrollBox.ControlCount > 0, 3);
       for j:= 0 to ScrollBox.ControlCount-1 do
         ScrollBox.Height:= ScrollBox.Height + ScrollBox.Controls[j].Height;
       Result:= ScrollBox;
    end;
end;

{ TMenuLabel }

procedure TfrmMainMenu.lblHomeClick(Sender: TObject);
begin
  ScrollMenu(Sender);
end;

function TfrmMainMenu.GetScrollBox(Sender: TPanel): TScrollBox;
var i: integer;
begin
  Result:= nil;
  for i:= 0 to Sender.ControlCount-1 do
    if (Sender.Controls[i] is TScrollBox) then
       Result:= (Sender.Controls[i] as TScrollBox);
end;

procedure TfrmMainMenu.imgNavigatorClick(Sender: TObject);
begin
  if ChanelIsPop = true then SideMenu.Push
  else begin
    SideMenu.Pop;
    SideMenu.StayOn:= True;
  end;
end;

procedure TfrmMainMenu.PanelDataHeaderPop(Sender: TObject);
begin
  ScrollMenu(Sender);
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
    if can_close then begin
      form.Close;
      form.Free;
    end;

    if DockHost.PageCount > 0 then //begin
      DockHostChange(nil)
    else AssigControl(frmMainMenu);
  end;

end;

procedure TfrmMainMenu.SideMenuPop(Sender: TObject);
begin
  ChanelIsPop:= True;
  if ImageDll = 0 then exit;
  //imgNavigator.Picture.Bitmap.Handle:= LoadBitmap(ImageDll, 'nav_left_blue');
  //imgNavigator.Top:= 3;
  //imgNavigator.Left:= 7;
end;

procedure TfrmMainMenu.SideMenuPush(Sender: TObject);
begin
  ChanelIsPop:= False;
  if ImageDll = 0 then exit;
  //imgNavigator.Picture.Bitmap.Handle:= LoadBitmap(ImageDll, 'nav_right_blue');
  //imgNavigator.Top:= 3;
  //imgNavigator.Left:= 7;
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

procedure TfrmMainMenu.PanelOtherHeaderPop(Sender: TObject);
begin
  ScrollMenu(Sender);
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
  frmBackupRestore.ProcessBackup;// Execute(BACKUP_DATABASE)
end;

procedure TfrmMainMenu.Restore1Click(Sender: TObject);
begin
  frmBackupRestore.ProcessRestore; //Execute(RESTORE_DATABASE)
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
  Screen.Cursor:= crHourGlass;
end;

procedure ProsesProgress(idx, data_count: integer);
begin
  frmMainMenu.suiProgressBar1.Position:= round((idx+1)/(data_count)*100);
end;

procedure EndProgress();
begin
  frmMainMenu.suiProgressBar1.Position:= 0;
  frmMainMenu.suiProgressBar1.Hide;
  frmMainMenu.StatusBar.Panels[2].Text:= '';
  frmMainMenu.timerProgresBar.Enabled:= False;
  Screen.Cursor:= crDefault;
end;

procedure TfrmMainMenu.timerProgresBarTimer(Sender: TObject);
var textToDisplay: string; i: integer;
begin
  textToDisplay:= 'Silahkan tunggu beberapa saat, loading data...        ';
  i:= Length(StatusBar.Panels[2].Text);
  if i < Length(textToDisplay) then
    StatusBar.Panels[2].Text:= StatusBar.Panels[2].Text + Copy(textToDisplay, i+1, 1)
  else begin
    StatusBar.Panels[2].Text:= '';
    StatusBar.Panels[2].Text:= StatusBar.Panels[2].Text + Copy(textToDisplay, i+1, 1)
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
    if not (Can_Access(Form, AMenuID)) then  Exit;
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
        1001, 1002,
        101, 102,103,104,
        201, 202,203,204,205, 206, 207,
         211, 212, 213,    216,
        220, 221, 222, 223,224,
         503, 504, 510,
        520, 530, 330: Form.Execute;
        501 : Form.Execute(0); //buat karyawan tanpa profit
        502 : Form.Execute(1); //buat owner
        210 : Form.Execute(0,0); //mst_item;
        214 : Form.Execute(1,0);//harga beli
        215 : Form.Execute(2,0);//harga jua;
        217 : Form.Execute(3,0);//discount;

        300: Form.Execute(TRANS_TYPE_ORDER); //frmTrsItemShipmentList
        301: Form.Execute(TRANS_TYPE_RECEIPT); //frmTrsItemShipmentList
        302: Form.Execute(TRANS_TYPE_RETUR); //frmTrsItemShipmentList

        321: Form.Execute(TRANS_TYPE_PAKAI_STOK); //frmTrsItemShipmentList
        322: Form.Execute(ITEM_TYPE_MUTASI_MASUK); //frmTrsItemShipmentList
        323: Form.Execute(ITEM_TYPE_OPNAME); //frmTrsItemShipmentList
        401: Form.Execute; //TRANS_TYPE_PEMBAYARAN
        402: Form.Execute;

      end;
      Form.Caption := SystemMenu.MenuName + ' - '+ IntToStr( SystemMenu.MenuId);
  end;

end;

procedure TfrmMainMenu.DockHostDockDrop(Sender: TObject;
  Source: TDragDockObject; X, Y: Integer);
begin
  ActivateMainForm:= 0;
  DockHost.ActivePage.ImageIndex:= 0;
  DockHost.ActivePage.Name:= '_'+IntToStr(Source.Control.Tag);
  DockHost.ActivePage.Caption:= (Source.Control as TDockForm).Caption;
  DockHostChange(nil);
end;

procedure TfrmMainMenu.DockHostMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var r: TRect; pos_left, pos_right: Integer;
begin
  //y: atas bawah
  //x: kiri kanan
  r:= DockHost.TabRect(DockHost.ActivePageIndex);
  pos_right:= x-r.Left;
  pos_left:= x-r.Left - 4;

  if ((pos_right <= 16) and (pos_left >= 4)) and
    ((Y < 16) and (Y >= 3)) and (Button = mbRight)then
      DockHost.ActivePage.ImageIndex:= 2;
end;

procedure TfrmMainMenu.DockHostMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var r: TRect; pos_left, pos_right: Integer;
begin
  r:= DockHost.TabRect(DockHost.ActivePageIndex);
  pos_right:= x-r.Left;
  pos_left:= x-r.Left - 4;

  if ((pos_right <= 16) and (pos_left >= 4)) and
    ((Y < 16) and (Y >= 3)) then
    try
      Screen.Cursor:= crHandPoint;
      DockHost.ActivePage.ImageIndex:= 1;
    finally

    end
  else
  begin
    Screen.Cursor:= crDefault;
    DockHost.ActivePage.ImageIndex:= 0;
  end;

end;

procedure TfrmMainMenu.DockHostMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var r: TRect; pos_left, pos_right: Integer;
begin
  r:= DockHost.TabRect(DockHost.ActivePageIndex);
  pos_right:= x-r.Left;
  pos_left:= x-r.Left - 4;

  if ((pos_right <= 16) and (pos_left >= 4)) and
    (Y < 16) and (Button = mbRight) then begin

    CloseForm(DockHost.DockClients[DockHost.ActivePageIndex]);
    Screen.Cursor:= crDefault;
  end

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

procedure reAssignLastControl;
begin
  if (frmMainMenu.DockHost.PageCount > 0) {and (ActivateMainForm = 0)} then
    if frmMainMenu.DockHost.ActivePage.ControlCount > 0 then
       assigControl(frmMainMenu.DockHost.ActivePage.Controls[0])
end;

procedure TfrmMainMenu.DockHostUnDock(Sender: TObject; Client: TControl;
  NewTarget: TWinControl; var Allow: Boolean);
begin
  ActivateMainForm:= 1;
  if DockHost.DockClientCount = 0 then
     AssigControl(frmMainMenu)
  else FormActivate(Client)
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
      if Labels.Tag <> -1 then Labels.Font.Color := clLabel;
    end
    else if (NewForm.Components[i] is TsuiPanel) then begin
      SuiPanel := (NewForm.Components[i] as TsuiPanel);
      SuiPanel.UIStyle := frmMainMenu.suiThemeManager2.UIStyle;
      SuiPanel.Color := clFormBackGround;
    end
    else if (NewForm.Components[i] is TsuiSideChannel) then begin
      SuiChanel := (NewForm.Components[i] as TsuiSideChannel);
      SuiChanel.Color := clFormBackGround;
      SuiChanel.UIStyle := frmMainMenu.suiThemeManager2.UIStyle;
    end
    else if (NewForm.Components[i] is TsuiPageControl) then begin
      SuiPageControl := (NewForm.Components[i] as TsuiPageControl);
      SuiPageControl.Color := clFormBackGround;
      SuiPageControl.UIStyle := BlueGlass;//frmMainMenu.suiMainMenu1.UIStyle;//FromThemeFile;
    end;
  //frmMainMenu.PanelMenu.BorderColor:= clWhite;
  
  frmMainMenu.suiProgressBar1.Hide;
end;

procedure TfrmMainMenu.DockHostChange(Sender: TObject);
begin
  if (DockHost.PageCount > 0) and (ActivateMainForm = 0) then
    if DockHost.ActivePage.ControlCount > 0 then
       assigControl(DockHost.ActivePage.Controls[0])

end;

procedure TfrmMainMenu.DockHostDockOver(Sender: TObject;
  Source: TDragDockObject; X, Y: Integer; State: TDragState;
  var Accept: Boolean);
begin
  Accept := Source.Control is TDockForm;
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
    1001:
    begin
      Application.CreateForm(TfrmAbout, frmAbout);
      temp:= frmAbout;
    end;

    101:
    begin
      Application.CreateForm(TfrmKelolaUser, frmKelolaUser);
      temp:= frmKelolaUser;
    end;

    102:
    begin
      Application.CreateForm(TfrmMstCode, frmMstCode);
      temp:= frmMstCode;
    end;
    103:
    begin
      Application.CreateForm(TfrmBonus, frmBonus);
      temp:= frmBonus;
    end;
    104:
    begin
      Application.CreateForm(TfrmMstAkun, frmMstAkun);
      temp:= frmMstAkun;
    end;


    201,203,204:
    begin
      Application.CreateForm(TfrmMstUnit, frmMstUnit);
      temp:= frmMstUnit;
    end;

    202 :
    begin
      Application.CreateForm(TfrmMstBranchList, frmMstBranchList);
      temp:= frmMstBranchList;
    end;


    210:
    begin
      Application.CreateForm(TfrmMstItemList, frmMstItemList);
      temp:= frmMstItemList;
    end;

    214,215,217:
    begin
      Application.CreateForm(TfrmMstItemPriceList, frmMstItemPriceList);
      temp:= frmMstItemPriceList;
    end;

    212:
    begin
      Application.CreateForm(TfrmMstServiceList, frmMstServiceList);
      temp:= frmMstServiceList;
    end;

    213:
    begin
      Application.CreateForm(TfrmMstAnimalList, frmMstAnimalList);
      temp:= frmMstAnimalList;
    end;

    216:
    begin
      Application.CreateForm(TfrmMstServicePrice, frmMstServicePrice);
      temp:= frmMstServicePrice;
    end;



    220, 223:
    begin
      Application.CreateForm(TfrmMstRelationList, frmMstRelationList);
      temp:= frmMstRelationList;
    end;
    224: begin
      Application.CreateForm(TfrmMstKaryawanList, frmMstKaryawanList);
      temp:= frmMstKaryawanList;
    end;


    322, 323:
    begin
      Application.CreateForm(TfrmTrsItemShipmentList, frmTrsItemShipmentList);
      temp:= frmTrsItemShipmentList;
    end;

    ITEM_TYPE_OPNAME,ITEM_TYPE_MUTASI_MASUK,ITEM_TYPE_MUTASI_KELUAR:
    begin
      Application.CreateForm(TfrmTrsItemShipment, frmTrsItemShipment);
      temp:= frmTrsItemShipment;
    end;
     300,301,302:
   begin
      Application.CreateForm(TfrmTrsPurchaseOrderList, frmTrsPurchaseOrderList);
      temp:= frmTrsPurchaseOrderList;
    end;

    TRANS_TYPE_ORDER :
    begin
      Application.CreateForm(TfrmTrsPurchaseOrder, frmTrsPurchaseOrder);
      temp:= frmTrsPurchaseOrder;
    end;

     TRANS_TYPE_RECEIPT :
    begin
      Application.CreateForm(TfrmTrsReceipt, frmTrsReceipt);
      temp:= frmTrsReceipt;
    end;

     TRANS_TYPE_RETUR :
    begin
      Application.CreateForm(TfrmTrsRetur, frmTrsRetur);
      temp:= frmTrsRetur;
    end;

    TRANS_TYPE_PAKAI_STOK :
    begin
      Application.CreateForm(TfrmTrsItemUse, frmTrsItemUse);
      temp:= frmTrsItemUse;
    end;

     321:
    begin
      Application.CreateForm(TfrmTrsItemUseList, frmTrsItemUseList);
      temp:= frmTrsItemUseList;
    end;
       {

    321, 322, 323:
    begin
      Application.CreateForm(TfrmTrsItemShipmentList, frmTrsItemShipmentList);
      temp:= frmTrsItemShipmentList;
    end;



   }

   401 : begin
      Application.CreateForm(TfrmTrsPembayaranList, frmTrsPembayaranList);
      temp:=frmTrsPembayaranList;
   end;

   402 : begin
      Application.CreateForm(TfrmTrsAbsensiList, frmTrsAbsensiList);
      temp:=frmTrsAbsensiList;
   end;
    501:
    begin
      Application.CreateForm(TfrmReportPenjualan, frmReportPenjualan);
      temp:=frmReportPenjualan;
    end;

    502:
    begin
      Application.CreateForm(TfrmReportPenjualan, frmReportPenjualan);
      temp:=frmReportPenjualan;
    end;

    503:
    begin
      Application.CreateForm(TfrmReportItemMovement, frmReportItemMovement);
      temp:=frmReportItemMovement;
    end;
    
    510:
    begin
      Application.CreateForm(TfrmReportStok, frmReportStok);
      temp:= frmReportStok;
    end;

     520:
    begin
      Application.CreateForm(TfrmReportKas, frmReportKas);
      temp:= frmReportKas;
    end;

    530:
    begin
      Application.CreateForm(TfrmReportProfit, frmReportProfit);
      temp:= frmReportProfit;
    end;


    else temp:= nil;
  end;
             //321, 323:   330, 331:

  if (temp<>nil ) then begin
    temp.Tag:= tag;
    RearrangeNewForms(temp);
    AppendClientList(tag, temp.Name);
  end
  else
    Alert(MSG_UNDER_CONSTRUCTION);
  Result:= temp;
end;

procedure TfrmMainMenu.DockedForm(Sender: TDockForm);
begin
  if not Sender.Showing then
    Sender.Show;

  if Assigned(Sender.HostDockSite) then
     DockHost.ActivePage:= DockHost.FindChildControl('_'+IntToStr(Sender.Tag)) as TTabSheet
  else
    Sender.ManualDock(DockHost);

  LastPageWidth := DockHost.Width;
  LastPageHeight:= DockHost.Height;
  ScrollBox1Resize(nil);
end;

procedure TfrmMainMenu.E1Click(Sender: TObject);
begin
  //frmAdmTrxPending.Execute
  if GlobalSystemUser.AccessLevel>=LEVEL_SUPERVISOR  then
    Restore1Click(Self)
  else
    Alert('ACCESS DENIED');
end;

procedure TfrmMainMenu.lblAboutClick(Sender: TObject);
var form: TDockForm;
begin
  //GlobalSystemUser.CurrentMenu:= 5;
  //if not GlobalSystemUser.CanAccess(0) then Exit;
  //frmAbout.Execute(0);
  form:= ShowForm(1001);
  form.Execute(1001);
end;

procedure TfrmMainMenu.Label3Click(Sender: TObject);
begin
HelpContent1Click(Sender);
end;

end.


