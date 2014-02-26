unit Subroutines;

interface

uses
  UConstTool, ExtCtrls,  Windows, registry,
  SysUtils, Controls, ADODB, Forms, ComCtrls, StdCtrls, Dialogs, Classes, Graphics,
  Messages,StrUtils,
  Variants, Series, Chart, AdvGrid, AdvEdit, DateUtils, RawPrinter, Math,
  IniFiles, RTLConsts, Types, AsgFindDialog, Printers,          
  uMysqlClient, MySQLConnector, WinSock, EpsonUtils;
  {asprev, EpsonSeq, RAWPrinter, DialogRawPrintPreview, }

  function CurrToIndonesianSpeech(nl : string):string;
{new macro routines}

  {function GetResultDef(sql: string; defnull, defnotfound, defmultiplefound: integer): integer; overload;
  function GetResultDef(sql: string; defnull, defnotfound, defmultiplefound: real): real; overload;
  function GetResultDef(sql: string; defnull, defnotfound, defmultiplefound: string): string; overload;
  }
  function generateRandomPassword:string;
  function GetMonthYear(aMonth: Integer; aYear: TDate): string;
  procedure getMonths(var target:TStringList);
  procedure getDayOfWeekList(var target:TStringList);

  function CurrToStrFmt(Input: currency): string;
  function StrToCurrFmt(Input: string):currency;
  function IntToStrFixed(MinLen: integer; Input: integer): string;
  function IsInteger(AString: string): boolean;
  function IsFloat(AString: string): boolean;
  function allColSelected(var grid:TAdvStringGrid):boolean;

  procedure CopyBitmap(const Source: TBitmap; ColWidth, RowWidth, ColIndex, RowIndex: integer; const Dest: TBitmap);
  procedure StringListToStrings(AValueList: TStringList; AList: TStrings);
  procedure NameValueListToNameList(AValueList: TStringList; AList: TStrings);
  procedure NameValueListToValueList(AValueList: TStringList; AList: TStrings);
  procedure NameValueListToValueList2(AValueList: TStringList; AList: TStrings);

  procedure SQLToStringList(var AStringList: TStringList; ASQL: string);
  procedure SQLToNameValueList(var AStringList: TStringList; ASQL: string);
  procedure SQLToNameValueList2(var AStringList: TStringList; ASQL: string);

{unsorted macro routines}
  procedure PrintRawDocument(const DocTitle, TextToPrint: String);
  procedure WriteLog(AFileName: string; ALog: string);
  function IntToStrFmt(Input: integer): string;
  function FormatDuit(Value: Currency): string;
  function DateTimeFormat(Value: string): string;
  procedure DateFormat(ADate: TDateTimePicker);
  function DuitStrToIntStr(Value: string): string;
  function convertStrToFloat(Value: string; Separotor: char): double;

  function TrimAll(Input: string): string;
  procedure InitAllTextBox(var Form: TForm);

  function EkstrakString(Input: string; Limiter: char; Count: integer): string;
  function CekTanggal(Input: string): boolean;
  function ReformatFloat(newsep: char; input: string):string;
  function ReplaceSubStr(Input, Find, ReplaceWith: string): string;
  function ReverseFormatDate(Tanggal:string): TDate;
  function SetStrLen(Input: string; Len: integer; FillChar: char; FillPos: TAlignment): string;
  function HitungChar(Input: string; Karakter: Char): integer;
                                              
{control the TControl}
  procedure GoNextColumn(grid: TObject);
  function GoNextControl(Form: TForm; Sender: TWinControl; GoForward, CheckTabStop, CheckParent: Boolean): TWinControl; overload;
  function GoNextControl(Panel: TPanel; Sender: TWinControl; GoForward, CheckTabStop, CheckParent: Boolean): TWinControl; overload;

{global macro routines}
  function GetAppPath : string;

{check macro routines}
  function CekInteger(Input: string): boolean; overload;
  function CekInteger(Input: string; LBound,UBound: integer): boolean; overload;
  function CekFloat(Input: string): boolean; overload;
  function CekFloat(Input: string; LBound, UBound: integer): boolean; overload;

{format macro routines}
  function qoute(s: string): string;
  function f2s(f : Extended) : string; overload;
  function f2s(f : Extended; decimal: Byte) : string; overload;
  function s2f(s : string) : Extended;
  function fixfs(s : string) : string;
  function FormatMoney(f : Extended) : string;
  function b2s(b: Boolean): string;
  function d2s(d : TDate) : string;
  function s2d(s : string) : TDate;
  function converttanggal( Value: TDate): string; {format tanggal}
  function FormatLCD(input: string): string;

{dialog macro routines}
  function Confirmed(prompt: string): Boolean;
  procedure Alert(AlertMsg : string);
  procedure Inform(Information : string);

{form macro suport}
  procedure ClearForm(frm: tform);
  function cekkosong(frm: tform): boolean;
  procedure TextToEdit(frm: tform; editbox: string; Value: string);

{wincontrol macro routines}
  procedure SetEditReadOnly(TextBox: TAdvEdit; IsReadOnly: Boolean); overload;
  procedure SetEditReadOnly(DateTimePicker: TDateTimePicker; IsReadOnly: Boolean); overload;
  procedure SetComboReadOnly(ComboBox: TComboBox; IsReadOnly: Boolean);
  function SetComboListValue(Combo: TComboBox; NewValue: string) : Integer;

{stringgrid macro routines}
  procedure ResetGrid(Sender: TAdvStringGrid; DefaultRowCount,DefaultColCount,
                      DefaultFixedRows, DefaultFixedCols, DefaultStretchColumn: integer);
  function IsClear(AGrid: TAdvStringGrid; ACol, ARow: integer): boolean;

  procedure EditToGrid(adv: TAdvStringGrid; kolom: integer; baris: integer; editbox: tadvedit);
  procedure TextToGrid(adv: TAdvStringGrid; kolom: integer; baris: integer; Text: string);
  procedure DateToGrid(adv: TAdvStringGrid; kolom: integer; baris: integer; InputDate: TDateTimePicker);
  procedure deleterow(grid: TAdvStringGrid; row: integer; idcol: integer;CekColumn:boolean=True);
  procedure DeleteRows(AGrid: TAdvStringGrid; DefaultRowCount: Integer);
  procedure DeleteLastRow(AGrid: TAdvStringGrid; DefaultRowCount,  ColId: Integer);
  procedure DeleteRowTerakhir(sender : TAdvStringGrid;LimitRow,RowDelete:integer);

  function cekkosonggrid(adv: TAdvStringGrid; row: integer): boolean;
  function AtLeastOneData(Grid: TadvStringGrid): boolean;

{chart macro routines}


{stringlist macro routines}
  function existOTS(T: Tstringlist; search: string): boolean;
  function maxstringlist(b: tstringlist): real;

  function IndexofValue(aList:TStringList;aValue:string):integer;overload;
  function IndexofValue(aList:TStrings;aValue:string):integer;overload;
  function NameFromValue(aList:TStringList;aValue:string):integer;

  function getCurrentSequence(aSequenceName:string):integer;
  function getNextSequence(aSequenceName:string):integer;
  function getPeriode(aDate:TDate):string;
  function getPeriode2(aDate:TDate; YearType: integer=1):string;
  function getPeriode4(aDate:TDate):string;


  function getStringFromSQL(aSql:string):string;
  function getStringFromSQLX(aSql:string):string;
  function getFloatFromSQL(aSql:string):double;
  function getIntegerFromSQL(aSql:string):integer;
  function getBooleanFromSQL(aSql:string):boolean;
  function getTDateFromSQL(aSql:string):TDate;
  function ExecuteSQL(aSql:string):boolean;

  function setAccountView(accNum :integer):string;
  function getAccountView(accNum : string):integer;

  function FindComponentTag(Sender: TForm; const ATag: integer): TComponent;
  function IgnoreChar(Key: Char): Char;
  procedure AdvEdtFloatFmt(Sender: TObject; value: String; ExeclStyle: boolean=false);
  procedure AdvEdtFloatFmt2(Sender: TObject; value: String; ExeclStyle: boolean=false);
  function CekFloatFmt(AString: string): boolean;

  procedure CopyStringToList(SourList, DestList: TStringList);

  function CekInput(var AResult: boolean; vState: boolean; vMsg: string; vControl: TWinControl): boolean;
  function ExecuteAndWait(FileName: string; Visibility: integer): cardinal;
  function getLastId: integer;

  procedure CariData(AGrid: TAdvStringGrid; Sender: TForm);

  function GetActualPeriode(vPeriode: TPeriode; isBegin: boolean=True; vMaxDate: TDate=0): TDate;
  function GetMonthMode(vDate: TDate; vMonth: word): TDate;

  function ExtractYearMonth2(YearMonth: string; LongFormat: boolean=false): string;
  function getYearMonth(YearMonth: string; idx: integer): string;

  function IgnoreNumber(Input: string): string;
  procedure GetShift(list: TStringList; Input: TStrings);

  function cekComPort(Port: PChar): boolean;
  procedure openDirectDrawer(COM: string);
  procedure EnumComPorts(Ports: TStrings);
  procedure SendEscapeCode(ToSend: string);
  function MustRegister(): boolean;

  function ExtractEsccode(ls: TStringList): string;

  procedure getPrinterList(l: TStrings);
  procedure setDefaultPrinter(priterNama: string);
  procedure setDefaultPrinter3(priterNama: string);
  function getDefaultPrinter: string;

  function setDefaultPrinter2(priterNama: string): string;

  function CaptionPeriode(op1: TSQLOperator; Date1:TDate;Date2:TDate):string;
  function CaptionPeriode2(op1:TSQLOperator; Date1:TDate;Date2:TDate):string;
  function CaptPeriodeShort(op1:TSQLOperator; Date1:TDate;Date2:TDate):string;
  function Kuadrat(n: real; Counter: integer): real;
  function deleteThousandSeparator(value: string; sparator: char): string;
  procedure SetButtonsCaption(Sender: TForm; EditMode: boolean);
  function GetHyperText(vHyperText: string): string;
  function PointToComma(Key: Char): Char;
  function ConvertToSaveConvertion(vConverted, vConverter: double): double;
  function ConvertToLoadConvertion(vConverted, vConverter: double): double;

  function bulatKeAtas(value: double): double;
  procedure printBitmap(Source: TBitmap; AText: string;rawPrinter:TRAWPrinter;var ls:TStringList);
  
type
  _SystemConstant_Arr = class;
  _SystemConstant = class;
  _SystemUser_Arr = class;
  _SystemUser = class;
  TSystemUser_Arr = class;
  TSystemUser = class;

  _SystemReversal_Arr = class;
  _SystemReversal = class;
  _SystemMenu_Arr = class;
  _SystemMenu = class;
  TSystemMenu_Arr = class;
  TSystemMenu = class;
  _SystemAccess_Arr = class;
  _SystemAccess = class;
  TSystemAccess_Arr = class;
  TSystemAccess = class;

  _SystemConstant_Arr = class(TObject) {Strong-Container SystemConstant}
  protected
    FSystemConstant_Arr: array of _SystemConstant;
    function Get(Index: integer): _SystemConstant; virtual;
    function New: _SystemConstant; virtual;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear; virtual;
    function Count: integer;
    property SystemConstant_Arr[Index: integer]: _SystemConstant read Get; default;

    function Add(ASeksi: string; ANama: string; ANilai: string): integer; virtual;
    function IndexOf(ASeksi: string; ANama: string): integer; virtual;
    procedure Delete(Index: integer); virtual;
  end;

  _SystemConstant = class(TObject) {Strong-Basic SystemConstant}
  protected
    FSeq: integer;
    FSeksi: string; //[30]
    FNama: string; //[50]
    FNilai: string; //[0]
    FParentSeq: integer;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Reset; virtual;
    procedure InsertOnDB; virtual;
    procedure UpdateOnDB; virtual;
    procedure DeleteOnDB; virtual;
    property Seksi: string  read FSeksi write FSeksi;
    property Nama: string  read FNama write FNama;
    property Nilai: string  read FNilai write FNilai;
    property Seq: integer read FSeq write FSeq;
    property ParentSeq: integer read FParentSeq write FParentSeq;
    function SelectInDB(ASeksi: String='';ANama: String='';ANilai:String=''; ASeq:integer=0; AParentSeq:integer=0): boolean; virtual;
    class function ExistInDB( AItemCategory: string; AItemType: String=''): integer;
    class function ExistCatInDB( AItemCategory: string): integer;
  end;

  _SystemUser_Arr = class(TObject) {Strong-Container SystemUser}
  protected
    FSystemUser_Arr: array of _SystemUser;
    function Get(Index: integer): _SystemUser; virtual;
    function New: _SystemUser; virtual;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear; virtual;
    function Count: integer;
    property SystemUser_Arr[Index: integer]: _SystemUser read Get; default;

    function Add(AUserId: string; AUserName: string; APasswd: string; AAccessLevel: integer; ADisableDate: TDate): integer; virtual;
    function IndexOf(AUserId: string): integer; virtual;
    procedure Delete(Index: integer); virtual;
  end;

  _SystemUser = class(TObject) {Strong-Basic SystemUser}
  protected
    FUserId: string; //[20]
    FUserName: string; //[50]
    FPasswd: string; //[20]
    FAccessLevel: integer; //
    FDisableDate: TDate; //
 //   FDeptID : string;
  public
    constructor Create;
    destructor Destroy;override;
    procedure Reset; virtual;
    procedure InsertOnDB; virtual;
    procedure UpdateOnDB; virtual;
    procedure DeleteOnDB; virtual;
    property UserId: string  read FUserId write FUserId;
    property UserName: string  read FUserName write FUserName;
    property Passwd: string  read FPasswd write FPasswd;
    property AccessLevel: integer  read FAccessLevel write FAccessLevel;
    property DisableDate: TDate  read FDisableDate write FDisableDate;
//    property DeptID : string read FDeptID write FDeptID;
    function SelectInDB(AUserId: string;ADeptId:string=''): boolean; virtual;
    function SelectInDbX(AUserId, APassWd: string): boolean;

    class function ExistInDB(AUserId: string): integer; virtual;
  end;

  _SystemReversal_Arr = class(TObject) {Strong-Container SystemReversal}
  protected
    FSystemReversal_Arr: array of _SystemReversal;
    function Get(Index: integer): _SystemReversal; virtual;
    function New: _SystemReversal; virtual;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear; virtual;
    function Count: integer;
    property SystemReversal_Arr[Index: integer]: _SystemReversal read Get; default;

    function Add(AReversSeq: integer; AReversDate: TDate; ANotes: string; AUserId: string): integer; virtual;
    function IndexOf(AReversSeq: integer): integer; virtual;
    procedure Delete(Index: integer); virtual;
  end;

  _SystemReversal = class(TObject) {Strong-Basic SystemReversal}
  protected
    FReversSeq: integer; //<sequence
    FReversDate: TDate; //
    FNotes: string; //[0]
    FSystemUser: _SystemUser; //UserId: string
  public
    constructor Create;
    destructor Destroy; override;
    procedure Reset; virtual;
    procedure InsertOnDB; virtual;
    procedure UpdateOnDB; virtual;
    procedure DeleteOnDB; virtual;
    property ReversSeq: integer  read FReversSeq write FReversSeq;
    property ReversDate: TDate  read FReversDate write FReversDate;
    property Notes: string  read FNotes write FNotes;
    property SystemUser: _SystemUser  read FSystemUser;

    function SelectInDB(AReversSeq: integer): boolean; virtual;
    class function ExistInDB(AReversSeq: integer): integer; virtual;
  end;

  _SystemMenu_Arr = class(TObject) {Strong-Container SystemMenu}
  protected
    FSystemMenu_Arr: array of _SystemMenu;
    function Get(Index: integer): _SystemMenu; virtual;
    function New: _SystemMenu; virtual;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear; virtual;
    function Count: integer;
    property SystemMenu_Arr[Index: integer]: _SystemMenu read Get; default;

    function FindOnDB(AMenuId: integer = 0; AMenuGroup: string = ''; AMenuName: string = ''; AImageIndex: integer = 0; AFormName: string = ''; AFormType: integer = 0; AShortcut: integer = 0;aDeptID:string=''): integer; virtual;
    function Add(AMenuId: integer; AMenuGroup: string; AMenuName: string; AImageIndex: integer; AFormName: string; AFormType: integer; AShortcut: string;ASubmenuName:string;
    AMenuNameEng:string; AImageDefault:string=''; AImageShort:string=''; AImageActive:string=''): integer; virtual;
    function IndexOf(AMenuId: integer): integer; virtual;
    procedure Delete(Index: integer); virtual;
  end;

  _SystemMenu = class(TObject) {Strong-Basic SystemMenu}
  protected
    FMenuId: integer; //
    FMenuGroup: string; //[20]
    FMenuName: string; //[40]
    FImageIndex: integer; //
    FFormName: string; //[40]
    FFormType: integer; //[1]
    FShortcut: string; //
    FSubMenuName : string;
    FDeptID : string;
    FMenuNameEng : string;
    FImageDefault : string;
    FImageShort : string;
    FImageActive : string;
    FDescription :string;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Reset; virtual;
    procedure InsertOnDB; virtual;
    procedure UpdateOnDB; virtual;
    procedure DeleteOnDB; virtual;
    property MenuId: integer  read FMenuId write FMenuId;
    property MenuGroup: string  read FMenuGroup write FMenuGroup;
    property MenuName: string  read FMenuName write FMenuName;
    property ImageIndex: integer  read FImageIndex write FImageIndex;
    property FormName: string  read FFormName write FFormName;
    property FormType: integer  read FFormType write FFormType;
    property Shortcut: string  read FShortcut write FShortcut;
    property SubMenuName : string read FSubMenuName write FSubMenuName;
    property DeptID : string read FDeptID write FDeptID;
    property MenuNameEng : string read FMenuNameEng write FMenuNameEng;
    property ImageDefault : string read FImageDefault write FImageDefault;
    property ImageShort : string read FImageShort write FImageShort;
    property ImageActive : string read FImageActive write FImageActive;
    property Description : string read FDescription write FDescription;
    function SelectInDB(AMenuId: integer): boolean; virtual;
    class function ExistInDB(AMenuId: integer): integer; virtual;
  end;

  _SystemAccess_Arr = class(TObject) {Weak-Container SystemAccess}
  protected
    FSystemAccess_Arr: array of _SystemAccess;
    function Get(Index: integer): _SystemAccess; virtual;
    function New: _SystemAccess; virtual;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear; virtual;
    function Count: integer;virtual;
    property SystemAccess_Arr[Index: integer]: _SystemAccess read Get; default;

    function Add(AUserId: string; AMenuId: integer; AAccessList: integer; AShortcut: integer; AOutlookPanel: string; AOutlookButton: string; AUsageCount: integer): integer; virtual;
    function IndexOf(AUserId: string; AMenuId: integer): integer; virtual;
    procedure Delete(Index: integer); virtual;
  end;

  _SystemAccess = class(TObject) {Weak-Basic SystemAccess}
  protected
    FSystemUser: _SystemUser; //UserId: string
    FSystemMenu: _SystemMenu; //MenuId: integer
    FAccessList: integer; //
    FOutlookPanel: string; //[20]
    FOutlookButton: string; //[40]
    FUsageCount: integer; //
    FCanAcces : integer;
    FCanAdd : integer;
    FCanEdit : integer;
    FCanDelete:integer;
    FCanView:integer;
    FCanPrint:integer;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Reset; virtual;
    procedure InsertOnDB; virtual;
    procedure UpdateOnDB; virtual;
    procedure DeleteOnDB; virtual;
    property SystemUser: _SystemUser  read FSystemUser;
    property SystemMenu: _SystemMenu  read FSystemMenu;
    property AccessList: integer  read FAccessList write FAccessList;
    property OutlookPanel: string  read FOutlookPanel write FOutlookPanel;
    property OutlookButton: string  read FOutlookButton write FOutlookButton;
    property UsageCount: integer  read FUsageCount write FUsageCount;
    property CanAccess: integer  read FCanAcces write FCanAcces;
    property CanAddd : integer read FCanAdd write FCanAdd;
    property CanEdit : integer read FCanEdit write FCanEdit;
    property CanDelete : integer read FCanDelete write FCanDelete;
    property CanView : integer read FCanView write FCanView;
    property CanPrint : integer read FCanPrint write FCanPrint;
  end;

  TSystemConstant = class(TCustomIniFile)
  public
    destructor Destroy; override;
    function ReadChar(const Section, Name: string; const Default: char): char;
    procedure WriteChar(const Section, Name: string; const Content: char);
    function ReadString(const Section, Name, Default: string): string; override;
    procedure WriteString(const Section, Name, Content: String); override;
    procedure ReadSection(const Section: string; Strings: TStrings); override;
    procedure ReadSections(Strings: TStrings); override;
    procedure ReadSectionValues(const Section: string; Strings: TStrings); override;
    procedure EraseSection(const Section: string); override;
    procedure DeleteKey(const Section, Name: String); override;
    procedure UpdateFile; override;
  end;

  TSystemUser_Arr = class(_SystemUser_Arr)
  protected
    function Get(Index: integer): TSystemUser; reintroduce;overload;
    function New: _SystemUser; override;
  public
    procedure FindOnDB(LoginID:string='';LoginName:string='';AccessLevel:integer=-1;status:boolean=true;Dept:string='');
    property SystemUser_Arr[Index: integer]: TSystemUser read Get; default;
  end;

  TSystemUser = class(_SystemUser)
  protected
    FSystemAccess_Arr: TSystemAccess_Arr;
    function getDisable: boolean;
    procedure setDisable(const Value: boolean);
  public
    FShift: integer;
    property SystemAccess_Arr: TSystemAccess_Arr read FSystemAccess_Arr write FSystemAccess_Arr;
    procedure UpdatePasswordOnDB;
    procedure UpdatePasswordOnDBX;
    property is_disabled:boolean read getDisable write setDisable;
    procedure InsertOnDB; override;
    procedure UpdateOnDB; override;
    procedure InsertOnDBX;
    procedure UpdateOnDBX;
    class procedure AccessLevelList(var ATarget:TStringList);
    class function IsExistInDB(userID:string): boolean;
    class function UserIDAlreadyRegistered(UserID: String): boolean;
    class procedure Activation(AUserId: string; AStatus: integer);
  end;

  TSystemReversal = class(_SystemReversal);
  TSystemReversal_Arr = class(_SystemReversal_Arr);

  TFormType = (ftMaster,ftTransaction,ftReport, ftSetting);
  TSystemMenu = class(_SystemMenu)
  protected
    function GetFormType: TFormType;
    procedure SetFormType(const Value: TFormType);
    function GetShortcut: TShortcut;
    procedure SetShortcut(const Value: TShortcut);

  public
    property FormType: TFormType read GetFormType write SetFormType;
    property Shortcut: TShortcut read GetShortcut write SetShortcut;
    class function getFormName(AMenuID: integer): string;
    class function getMenuName(AMenuID: integer): string;
    class function getMenuNameEng(AMenuID: integer): string;
  end;

  TSystemMenu_Arr = class(_SystemMenu_Arr)
  protected
    function Get(Index: integer): TSystemMenu; reintroduce;
    function New: _SystemMenu; override;
  public
    function GetByMenuID(AMenuID: integer): TSystemMenu;
    property SystemMenu_Arr[Index: integer]: TSystemMenu read Get; default;
    procedure LoadFromDB(AShowHidden:TBooleanOperator=boNone; ADeptId: integer=0);
    procedure getMenuGroup(var menuArr:TSystemMenu_Arr;menu_group:string);
    procedure getMenuGroupList(var aList:TStringList);
    function FindInDB(menu_id:integer=0;menu_group:string='';menu_name:string='';image_index:integer=-1;form_name:string='';form_type:integer=0;shortcut:integer=0):boolean;
    function FindInDB2(aSubMenuName:string=''): boolean;

  end;

  TAccessList = (alInsert,alUpdate,alView,alPrint,alRevers);
  TAccessListSet = set of TAccessList;
  TSystemAccess = class(_SystemAccess)
  protected
    FOwner: TObject; //pointer;
    function GetAccessList: TAccessListSet;
    procedure SetAccessList(const Value: TAccessListSet);
    function GetSystemMenu: TSystemMenu;
    function GetSystemUser: TSystemUser;
  public
    constructor Create(AOwner: TObject);
    destructor Destroy; override;
    procedure Reset; override;
    function SelectInDB(AUserID: string; AMenuID: integer): boolean; overload;
    function SelectInDB: boolean; overload;

    procedure IncUsageCount;
    procedure UpdateUsageCountOnDB;
    procedure UpdateOutlookOnDB;
    property SystemUser: TSystemUser read GetSystemUser;
    property SystemMenu: TSystemMenu read GetSystemMenu;
    property AccessList: TAccessListSet read GetAccessList write SetAccessList;
    property UsageCount: integer read FUsageCount;

    class function IsExisInDB(AUserID: string; AMenuID: integer): boolean;
    class function Can_Access(Sender : TForm;AMenuID:integer=0):boolean;
    class function isCan(CanType:integer;AMenuId:integer):boolean;
  end;

  TSystemAccess_Arr = class(_SystemAccess_Arr)
  protected
    FOwner: TObject; //pointer
    FIndexUsage_Arr  : array of integer;
    function Get(Index: integer): TSystemAccess; reintroduce;
    function New: _SystemAccess; override;
    function GetTopUsage(Position: integer): TSystemAccess;
  public
    constructor Create(AOwner: TObject);
    function LoadFromDB(AUserID: string; AMenuID: integer): integer; overload;
    function LoadFromDB: integer; overload;
    procedure SaveUsageCountOnDB;
    procedure SaveOutlookOnDB;

    function GetByFormName(AFormName: string): TSystemAccess;
    function GetByMenuID(AMenuID: integer): TSystemAccess;
    property SystemAccess_Arr[Index: integer]: TSystemAccess read Get; default;
    function Add(AUserId: string; AMenuId: integer; AAccessList: TAccessListSet; AShortcut: TShortcut; AOutlookPanel: string; AOutlookButton: string; AUsageCount: integer): integer; reintroduce; overload;
    function Add(AUserId: string; AAccessList: TAccessListSet; AShortcut: TShortcut; AOutlookPanel: string; AOutlookButton: string; AUsageCount: integer): integer; reintroduce; overload;
    function Add(AMenuId: integer; AAccessList: TAccessListSet; AShortcut: TShortcut; AOutlookPanel: string; AOutlookButton: string; AUsageCount: integer): integer; reintroduce; overload;
    function AddX(AMenuId: integer; AMenuName: string; ACanAkses: integer): integer;


    function IndexOf(AUserId: string; AMenuId: integer): integer; reintroduce; overload;
    function IndexOf(AUserId: string): integer; reintroduce; overload;
    function IndexOf(AMenuId: integer): integer; reintroduce; overload;

    procedure InsertOnDB;
    procedure DeleteUpdateOnDB;//delete and then re-insert
    procedure RecalculateUsage;
    property TopUsage[Position: integer]: TSystemAccess read GetTopUsage;
    function LoadFromDB2(AUserID: string): integer;
    function FindOnDb(AUserID: string): integer;
  end;

  TMstCompany = class(TObject)
  public
    FCompanyName: string; //[50]
    FAddress: string; //[50]
    FTelp1: string; //[50]
    FTelp2: string; //[50]
    FFax: string; //[50]
    FCity: string; //[50]
    FBranch: string; //[50]
    FPostCode: string; //[50]
    FNpwp: string; //[50]
    FInfo: string; //[500]
    FUserId: string; //[500]
    FSerialNumber: string; //[500]
    FCurrentBranch : integer;
    FJamMasuk : TTime;
    FJamPulang : TTime;
    function InsertInDb:boolean;
    function SelectInDB:boolean;
  end;

  FLocalConfig = record
    Machine,
    MarginTop,
    MarginBottom,
    PrinterID,
    PrintStruk,
    AutoCutter,
    LocalGudang, WriteLogs, UseSerialKeys, Baudrate, JenisDrawer: integer;
    PortName, DrawerCode, CutterCode,
    PrinterStruk, PrinterBarcode, PrinterAdm, SerialPort: string;
  end;

  TLocalConfig = class(TObject) {Strong-Basic SystemUser}
    class procedure LoadLocalSetting(var ALocalConfig: FLocalConfig);
    class procedure Reset(var ALocalConfig: FLocalConfig);
  end;

  TSystemConfig = class(TObject) {Strong-Basic SystemUser}
  protected
    FConfId: integer;
    FConfName: string; //[50]
    FConfValue: string; //[50]
  public
    procedure Reset; virtual;
    procedure UpdateOnDB;
    class function getValue(aConfId:integer):string;
    property ConfId: integer read FConfId write FConfId;
    property ConfName: string read FConfName write FConfName;
    property ConfValue: string read FConfValue write FConfValue;
  end;

  TSystemConfig_Arr = class(TObject) {Strong-Container SystemUser}
  protected
    FSystemConfig_Arr: array of TSystemConfig;
    function Get(Index: integer): TSystemConfig; virtual;
    function New: TSystemConfig; virtual;
  public
    localSetting: FLocalConfig;
    constructor Create;
    destructor Destroy; override;
    procedure Clear; virtual;
    function Count: integer;
    property SystemConfig_Arr[Index: integer]: TSystemConfig read Get; default;
    function Add(): integer; virtual;
    procedure loadFromDB(loadReg: boolean=true);
    procedure UpdateOnDB(id: integer; value: string);
  end;

  TFilters = class
  protected
  public
    SpecID,
    ItemID,
    RelasiID, SeriesID,
    StatusID, Numeric1, Numeric2,Numeric3,Numeric4: integer;      //0: true, false, etc
    TipeID, Name: string;
    ShowDisabled: boolean; //true //false
    FString1, FString2: string;
    FLimit, FOffset: integer;
    procedure Reset;
    procedure setFilters(vSpecId, vItemId, vRelasiId, vStatusId: integer; vTipeId: string);
  end;

  arString = array of string;

  trDataBayar = record
    FCaraBayar: integer;
    FJumlahBayar, FTerbayar,
    FTagihan : double;
    FKeterangan: string;
  end;

  TDataBayar = class(TObject)
    class procedure Reset(var DataBayar :trDataBayar);
  end;

  EComPort = class(Exception)
  private
    FWinCode: Integer;
    FCode: Integer;
  public
    constructor Create(ACode: Integer; AWinCode: Integer);
    constructor CreateNoWinCode(ACode: Integer);
    property WinCode: Integer read FWinCode write FWinCode;
    property Code: Integer read FCode write FCode;
  end;

  TTextRotate = class(TObject)
  protected
    FText: string;
    FFontName: string;
    FFontSize: integer;
    FAngel: integer;
  public
    constructor Create;
    destructor Destroy; override;
    property Text: string read FText write FText;
    property FontName: string read FFontName write FFontName;
    property FontSize: integer read FFontSize write FFontSize;
    property Angel: integer read FAngel write FAngel;
    procedure DrawText(ACanvas: TCanvas);
  end;
  
  TPassData = record
    BuffLength: Word;
    Buffer: array[0..255] of char;
  end;

var
  GlobalSystemUser: TSystemUser;
  GlobalSystemMenu_Arr: TSystemMenu_Arr;
  CompanyProfile: TMstCompany;
  GlobalPeriode : TPeriode;
  GlobalFilter  : TFilters;
  GlobalStringList: TStringList;
  GlobalSystemConfig: TSystemConfig_Arr;
  
  function ExtractDateLama(ABeginDate, AEndDate: TDate; AInterval: word): arString;
  function ExtractDate(ABeginDate, AEndDate: TDate; AInterval: word): arString;

  function getNextIDNum(fieldName:string;tableName:string;condition:String;prefix:string;reversedOrderNum:string='';minlength:integer=5):string;
  function getNextIDNumPeriode(fieldName:string;tableName:string;condition:String;prefix,suffix:string;reversedOrderNum:string='';minlength:integer=5):string;

  function getNextIDNumPeriode2(fieldName, tableName, condition, prefix, suffix:string; reversedOrderNum:string='';minlength:integer=5):string;

  function getNextIDNum2(fieldName:string; tableName:string; condition:String; prefix:string):string;
  function getNextID(current_code, prefix: string; minlength: integer=5):string;

  function getPeriode3(aDate:TDate):string;
  function getWindowsVersion: string;
  function getWindowsDir: string;
  function screenLessThen1024X768: Boolean;

  function MyTCPIPAddress : longint;
  function LocalIP: String;   //127.0.0.0
  function getSecurityLog():string;
  function roundCorrected(v: double): Int64;
  //function IPAddrToName(IPAddr: String): String; //localhost
  //function HostToIP(sHost: string; var sIP: string): Boolean; //127.0.0.0


const
  CError_OpenFailed      = 1;
  CError_WriteFailed     = 2;
  CError_ReadFailed      = 3;
  CError_InvalidAsync    = 4;
  CError_PurgeFailed     = 5;
  CError_AsyncCheck      = 6;
  CError_SetStateFailed  = 7;
  CError_TimeoutsFailed  = 8;
  CError_SetupComFailed  = 9;
  CError_ClearComFailed  = 10;
  CError_ModemStatFailed = 11;
  CError_EscapeComFailed = 12;
  CError_TransmitFailed  = 13;
  CError_ConnChangeProp  = 14;
  CError_EnumPortsFailed = 15;
  CError_StoreFailed     = 16;
  CError_LoadFailed      = 17;
  CError_RegFailed       = 18;
  CError_LedStateFailed  = 19;
  CError_ThreadCreated   = 20;
  CError_WaitFailed      = 21;
  CError_HasLink         = 22;
  CError_RegError        = 23;

implementation

uses UConst;

const
  // error messages
  ComErrorMessages: array[1..23] of string =
    ('Unable to open com port',
     'WriteFile function failed',
     'ReadFile function failed',
     'Invalid Async parameter',
     'PurgeComm function failed',
     'Unable to get async status',
     'SetCommState function failed',
     'SetCommTimeouts failed',
     'SetupComm function failed',
     'ClearCommError function failed',
     'GetCommModemStatus function failed',
     'EscapeCommFunction function failed',
     'TransmitCommChar function failed',
     'Cannot set property while connected',
     'EnumPorts function failed',
     'Failed to store settings',
     'Failed to load settings',
     'Link (un)registration failed',
     'Cannot change led state if ComPort is selected',
     'Cannot wait for event if event thread is created',
     'WaitForEvent method failed',
     'A component is linked to OnRxBuf event',
     'Registry error');


function roundCorrected(v: double): Int64;
var i: Int64;
begin
  i:= trunc(v);
  if Frac(v) >= 0.5 then i:= i+1;
  Result:= i;
end;

     
function getSecurityLog():string;
begin
    Result := GlobalSystemUser.UserId + ';'+formatdatetime('yyyy-mm-dd hh:nn:ss ',ServerCurrDateTime);
end;
     
function getStringFromSQL(aSql:string):string;
  var buffer :TMysqlResult;
 {} begin
    buffer := OpenSQL(aSql);
    Result := '';
    if buffer.RecordCount > 0 then
      Result := BufferToString(buffer.FieldValue(0));
    buffer.Destroy;
  end;

  function getStringFromSQLX(aSql:string):string;
  var buffer :TMysqlResult;
  begin
    buffer := OpenSQL(aSql);
    Result := '';
    if buffer.RecordCount > 0 then
      Result := buffer.FieldValue(0);
    buffer.Destroy;
  end;


function getFloatFromSQL(aSql:string):double;
 var buffer :TMysqlResult;
  begin
    buffer := OpenSQL(aSql);
    Result := 0;
   if buffer.RecordCount > 0 then
     Result := BufferToFloat(buffer.FieldValue(0));
   buffer.Destroy;
  end;

  function getIntegerFromSQL(aSql:string):integer;
  var buffer :TMysqlResult;
  begin
    buffer := OpenSQL(aSql);
    Result := 0;
    if buffer.RecordCount > 0 then
      Result := BufferToInteger(buffer.FieldValue(0));
    buffer.Destroy;
  end;

 function ExecuteSQL(aSql:string):boolean;
 begin
    try BeginSQL;
      ExecSQL(aSql);
      EndSQL;
      Result := True;
    except
      UndoSQL;
      Result := False;
    end;
 end;

 function getBooleanFromSQL(aSql:string):boolean;
 var buffer :TMysqlResult;
  begin
    buffer := OpenSQL(aSql);
    Result := False;
   if buffer.RecordCount > 0 then
     Result := BufferToInteger(buffer.FieldValue(0))>0;
   buffer.Destroy;
  end;

  function getTDateFromSQL(aSql:string):TDate;
  var buffer :TMysqlResult;
  begin
    buffer := OpenSQL(aSql);
    Result := 0;
    if buffer.RecordCount > 0 then
      Result := BufferToDateTime(buffer.FieldValue(0));
    buffer.Destroy;
  end;

function getNextIDNumPeriode(fieldName:string;tableName:string;condition:String;prefix,suffix:string;reversedOrderNum:string='';minlength:integer=5):string;
var sql:string;buffer:TMysqlResult;code:string; codeNum:integer;codeChar:Char; cond: string;
begin
  if reversedOrderNum <> '' then begin
    //get the last character in the number if it is non-number
    codeChar := (copy(reversedOrderNum,length(reversedOrderNum)-1,1))[1];
    if StrToIntDef(codeChar,0) = 0 then begin//if not-number then
      inc(codeChar);
      result := reversedOrderNum + codeChar;
    end else //if number than append 'a'
      result := reversedOrderNum + 'a';
  end else begin
    sql := 'SELECT MAX('+fieldName+') FROM '+tableName;
    cond := '';
    if condition <> '' then
      cond := cond + ' AND ' + copy(condition,5,length(condition));
    if prefix <> '' then
      cond := cond + ' AND ' + fieldname + ' LIKE ' + FormatSQLString(prefix+'%'+suffix);
    if cond <> '' then begin
      delete(cond,1,5);
      sql := sql + ' WHERE ' + cond;
    end;
    buffer := OpenSQL(sql);
    if buffer.RecordCount > 0 then begin
    //'STL/MFG/PPC/POI00001/V/2004'
      code := BufferToString(buffer.FieldValue(0));
      //cut off the prefix the last digit if it is a character
      code := copy(code,length(prefix)+1,length(code)-length(prefix));
      code := EkstrakString(code,'/',1);
      codeNum := StrToIntDef(code,0);
      inc(codeNum);
      result := prefix+IntToStrFixed(minlength,codeNum);
    end else
      result := prefix+IntToStrFixed(minlength,1);
    buffer.Destroy;
  end;
end;

function getPeriode(aDate:TDate):string;
var tmp : string;
begin
   case MonthOf(aDate) of
     1    : tmp:= 'I/';
     2    : tmp:= 'II/';
     3    : tmp:= 'III/';
     4    : tmp:= 'IV/';
     5    : tmp:= 'V/';
     6    : tmp:= 'VI/';
     7    : tmp:= 'VII/';
     8    : tmp:= 'VIII/';
     9    : tmp:= 'IX/';
     10   : tmp:= 'X/';
     11   : tmp:= 'XI/';
     12   : tmp:= 'XII/';
   end;
   Result := '/'+tmp + IntToStr(YearOf(aDate));
end;

function getPeriode2(aDate:TDate; YearType: integer):string;
var tmp : string;
begin
   case MonthOf(aDate) of
     1    : tmp:= '01/';
     2    : tmp:= '02/';
     3    : tmp:= '03/';
     4    : tmp:= '04/';
     5    : tmp:= '05/';
     6    : tmp:= '06/';
     7    : tmp:= '07/';
     8    : tmp:= '08/';
     9    : tmp:= '09/';
     10   : tmp:= '10/';
     11   : tmp:= '11/';
     12   : tmp:= '12/';
   end;
   if YearType= 1then
     Result := '/'+tmp + FormatDateTime('yy',aDate)
   else if YearType= 2 then
     Result := '/'+tmp + IntToStr(YearOf(aDate));
end;


function getCurrentSequence(aSequenceName:string):integer;
var sql:string;buffer:TMysqlResult;
begin
  sql := 'SELECT '+aSequenceName+'.Currval From Dual ';
  try
    buffer := OpenSQL(sql);
    Result := BufferToInteger(buffer.FieldValue(0));
  except
    //Result := -1;
    Raise;
  end;
  buffer.Destroy;
end;

function getNextSequence(aSequenceName:string):integer;
var sql:string;buffer:TMysqlResult;
begin
  sql := 'SELECT '+aSequenceName+'.Nextval From Dual ';
  try
    buffer := OpenSQL(sql);
    Result := BufferToInteger(buffer.FieldValue(0));
  except
    Raise;
  end;
  buffer.Destroy;
end;

function CurrToIndonesianSpeech(nl : string):string;
const vlstep : array [0..4] of string = (' ','ribu ','juta ','milyar ','trilyun ');
var i, j, k, panjang, m  : integer;
    stemp, stemp2, addstr : string;
    nl2, nltemp, qtemp : string;
    good, belas : boolean;
begin
  good := false;
  for i:=1 to Length(nl) do
  begin
    if (nl[i] <> '0') then
       good := true;
    if (good) then
       nl2 := nl2 + nl[i];
  end;
  if (length(nl2) > 15) then
     nltemp:=Copy(nl2,Length(nl2)-15+1,15)
  else nltemp := nl2;
  stemp2 := '';
  for i:=0 to 4 do
  begin
    k := Length(nltemp);
    if (k = 0) then
       break;
    if (k >= 3) then
       qtemp := Copy(nltemp,Length(nltemp)-2,3)
    else qtemp := nltemp;
    nltemp := Copy(nltemp,1,Length(nltemp)-3);
    stemp := '';
    belas := false;
    if (k >= 3) then
       panjang := 3
    else panjang:=k;
    m := 4-panjang;
    for j:=1 to panjang do
    begin
      addstr := '';
      if (qtemp[j] = '9') then
         addstr := 'sembilan ';
      if (qtemp[j] = '8') then
         addstr := 'delapan ';
      if (qtemp[j] = '7') then
         addstr := 'tujuh ';
      if (qtemp[j] = '6') then
         addstr := 'enam ';
      if (qtemp[j] = '5') then
         addstr := 'lima ';
      if (qtemp[j] = '4') then
         addstr := 'empat ';
      if (qtemp[j] = '3') then
         addstr := 'tiga ';
      if (qtemp[j] = '2') then
         addstr := 'dua ';
      if (qtemp[j] = '1') then
      begin
        case m of
        1,2: case m of
              1:addstr := 'se';
              2:belas := true;
             end;
        3: if (not belas) then
           begin
              if (i = 1) then
              begin
                if (stemp = '') then
                   addstr := 'se'
                else addstr := 'satu ' ;
              end else addstr := 'satu ';
           end else addstr := 'se';
        end;
      end;
      if (qtemp[j] = '0') then
         if (belas) then
         begin
           addstr := 'sepuluh ';
           belas := false;
         end;
      if ((addstr <> '') or (belas)) then
      begin
        case m of
        1: addstr := addstr + 'ratus ';
        2: if (not belas) then
              addstr := addstr+ 'puluh ';
        3: if (belas) then
              addstr := addstr+ 'belas ';
        end;
      end;
      stemp := stemp + addstr;
      inc(m);
    end;
    if (stemp <> '') then
       stemp2 := stemp + vlstep[i] + stemp2;
  end;
  result := stemp2+'rupiah';
  if (result <> '') then
     result[1] := upcase(result[1]);
end;


{ new macro routines }

  {function GetResultDef(sql: string; defnull, defnotfound, defmultiplefound: integer): integer; overload;
//  var buffer: TMysqlResult;
  begin
    buffer := OpenSQL(sql);
    if (buffer.RecordCount=0) then
      Result := defnotfound
    else if (buffer.RecordCount>1) then
      Result := defmultiplefound
    else
      Result := BufferToIntegerDef(buffer.FieldValue(0), defnull);
    buffer.Destroy;
  end;             }

{  function GetResultDef(sql: string; defnull, defnotfound, defmultiplefound: real): real; overload;
  var buffer: TMysqlResult;
  begin
    buffer := OpenSQL(sql);
    if (buffer.RecordCount=0) then Result := defnotfound
    else if (buffer.RecordCount>1) then Result := defmultiplefound
    else Result := BufferToFloatDef(buffer.FieldValue(0), defnull);
    buffer.Destroy;
  end;             }

  {function GetResultDef(sql: string; defnull, defnotfound, defmultiplefound: string): string; overload;
  var buffer: TMysqlResult;
  begin
    buffer := OpenSQL(sql);
    if (buffer.RecordCount=0) then Result := defnotfound
    else if (buffer.RecordCount>1) then Result := defmultiplefound
    else Result := BufferToStringDef(buffer.FieldValue(0), defnull);
    buffer.Destroy;
  end;             }

  function generateRandomPassword:string;
  var i,j:integer;pwd:string;MyArray:string[26];
  begin
    MyArray := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    Randomize;
    j:=RandomRange(2,4);
    for i := 1 to j do begin
      pwd := pwd + MyArray[RandomRange(0,25)+1];
    end;
    for i:= 1 to 2 do begin
      pwd := pwd + IntToStr(RandomRange(0,9));
    end;
    j:=RandomRange(1,2);
    for i := 1 to j do begin
      pwd := pwd + MyArray[RandomRange(0,25)+1];
    end;
    result := pwd;
  end;

  function GetMonthYear(aMonth: Integer; aYear: TDate): string;
  var Month: string;
  begin
    if aMonth < 10 then
      Month := '0' + IntToStr(aMonth)
    else Month := IntToStr(aMonth);
    Result:= Month + '/' + Copy(EkstrakString(DateToStr(aYear),'/',3),3,2);
  end;

  procedure getMonths(var target:TStringList);
  begin
    target.Clear;
    target.Add('1=January');
    target.Add('2=February');
    target.Add('3=Maret');
    target.Add('4=April');
    target.Add('5=Mei');
    target.Add('6=Juni');
    target.Add('7=Juli');
    target.Add('8=Agustus');
    target.Add('9=September');
    target.Add('10=Oktober');
    target.Add('11=November');
    target.Add('12=December');
  end;

  procedure getDayOfWeekList(var target:TStringList);
  begin
    target.Clear;
    target.Add('1=Senin');
    target.Add('2=Selasa');
    target.Add('3=Rabu');
    target.Add('4=Kamis');
    target.Add('5=Jumat');
    target.Add('6=Sabtu');
    target.Add('7=Minggu');
  end;

  function IntToStrFixed(MinLen: integer; Input: integer): string;
  var tmpStr: string;
    i: integer;
  begin
    tmpStr := IntToStr(Input);
    for i := 1 to MinLen-length(tmpStr) do
      tmpStr := '0'+tmpStr;
    result := tmpStr;
  end;

  function CurrToStrFmt(Input: currency): string;
  begin
    Result := Format('%m',[Input]);
  end;

  function StrToCurrFmt(Input: string):currency;
  var tempStr:string; index:integer;
  begin
    tempStr := copy(input,pos('p',input)+1,length(input));
    while true do begin
      index := pos('.',tempStr);
      if index <= 0 then
        break;
      delete(tempStr,pos('.',tempStr),1);
    end;
    result := StrToCurr(tempStr);
  end;

  function IsInteger(AString: string): boolean;
  begin
    try
      StrToInt(AString);
      Result :=true
    except
      on EConvertError do
        Result :=false;
    end;
  end;

  function allColSelected(var grid:TAdvStringGrid):boolean;
  var isRowSelected:boolean;i:integer;
  begin
    isRowSelected := true;
    for i := 1 to grid.ColCount-1 do begin
      if Not grid.IsSelected(i,grid.Row) then begin
        isRowSelected := false;
        break;
      end;
    end;
    result:= isRowSelected;
  end;

  function IsFloat(AString: string): boolean;
  begin
    try
      StrToFloat(AString);
      Result :=true
    except
      on EConvertError do
        Result :=false;
    end;
  end;

  procedure StringListToStrings(AValueList: TStringList; AList: TStrings);
  var i: integer;
  begin
    AList.Clear;
    for i :=0 to AValueList.Count-1 do
      AList.Add(AValueList.Strings[i]);
  end;

  procedure NameValueListToNameList(AValueList: TStringList; AList: TStrings);
  var i: integer;
  begin
    AList.Clear;
    for i :=0 to AValueList.Count-1 do
      AList.Add(AValueList.Names[i]);
  end;

  procedure NameValueListToValueList(AValueList: TStringList; AList: TStrings);
  var i: integer;
  begin
    AList.Clear;
    for i :=0 to AValueList.Count-1 do
      AList.Add(AValueList.Values[AValueList.Names[i]]);
  end;

  procedure NameValueListToValueList2(AValueList: TStringList; AList: TStrings);
  var i: integer;
  begin
    AList.Clear;
    AList.Add('Semua');
    for i :=0 to AValueList.Count-1 do
      AList.Add(AValueList.Values[AValueList.Names[i]]);
  end;

  procedure SQLToStringList(var AStringList: TStringList; ASQL: string);
  var buffer: TMysqlResult;
    i: integer;
  begin
    AStringList.Clear;
    buffer := OpenSQL(ASQL);
    for i :=1 to buffer.RecordCount do begin
      AStringList.Add(buffer.FieldValue(0));
      buffer.MoveNext;
    end;
    buffer.Destroy;
  end;

  procedure SQLToNameValueList(var AStringList: TStringList; ASQL: string);
  var buffer: TMysqlResult;
    i: integer;
  begin
    AStringList.Clear;
    buffer := OpenSQL(ASQL);
    for i :=1 to buffer.RecordCount do begin
      AStringList.Add(BufferToString(buffer.FieldValue(0))+'='+BufferToString(buffer.FieldValue(1)));
      buffer.MoveNext;
    end;
    buffer.Destroy;
  end;

  procedure SQLToNameValueList2(var AStringList: TStringList; ASQL: string);
  var buffer: TMysqlResult;
    i: integer;
  begin
    AStringList.Clear;
    buffer := OpenSQL(ASQL);
    for i :=1 to buffer.RecordCount do begin
      AStringList.Add(buffer.FieldValue(0)+'='+buffer.FieldValue(1));
      buffer.MoveNext;
    end;
    AStringList.Insert(0,'0'+'='+'Semua');
    buffer.Destroy;
  end;
{unsorted macro routines}

  procedure CopyBitmap(const Source: TBitmap; ColWidth, RowWidth, ColIndex, RowIndex: integer; const Dest: TBitmap);
  begin
    Dest.TransparentColor := Source.TransparentColor;
    Dest.Width := ColWidth;
    Dest.Height := RowWidth;
    Dest.Canvas.CopyRect(Rect(0,0,ColWidth,RowWidth),Source.Canvas,
      Rect(ColIndex*ColWidth,RowIndex*RowWidth,(ColIndex+1)*ColWidth,(RowIndex+1)*RowWidth));
  end;

  procedure PrintRawDocument(const DocTitle, TextToPrint: String);
  var
    RP: TRawPrinter;
  begin
    RP := TRawPrinter.Create(nil);
    try
      RP.DocumentTitle := DocTitle;
      RP.BeginDoc;
      RP.Write(TextToPrint);
      RP.EndDoc;
    finally
      RP.Free;
    end;
  end;

  function IntToStrFmt(Input: integer): string;
  begin
    Result := FormatCurr('#,##0',Input);
  end;

  function FormatDuit(Value: Currency): string;
  begin
    Result := CurrencyString+' '+FormatCurr('#,##0',Value);
  end;

  procedure DateFormat(ADate: TDateTimePicker);
  begin
    ADate.Format:= 'dddd, dd MMMM yyyy';
  end;

  function DateTimeFormat(Value: string): string;
  begin
    Result:= FormatDateTime('dd MMMM yyyy', StrToDateTime(Value))
  end;


  procedure WriteLog(AFileName: string; ALog: string);
  var FP: Text;
  begin
    AssignFile(FP,AFileName);
    {$I-} Append(FP); {$I+}
    if (IOResult <> 0) then Rewrite(FP);
    Writeln(FP, ALog);
    CloseFile(FP);
  end;

  function DuitStrToIntStr(Value: string): string;
  begin
    while (Pos(ThousandSeparator,Value)<>0) do
      Delete(Value,Pos(ThousandSeparator,Value),1);
    Result := Value;
  end;

  function convertStrToFloat(Value: string; Separotor: char): double;
  begin
    Result:= StrToFloat(ReplaceSubStr(Value,Separotor,''));
  end;

  function TrimAll(Input: string): string;
  { I.S. : Input terdefinisi
    F.S. : menghasilkan string dengan spasi awal dan akhir dihilangkan
           dan spasi antar kata sebanyak satu spasi }
  var i: integer;
      TmpStr: string;
  begin
    Input:=Trim(Input);
    TmpStr:='';
    for i:=1 to Length(Input) do
      if (Input[i]<>' ') or ((Input[i]=' ') and (TmpStr[Length(TmpStr)]<>' ')) then
        TmpStr:=TmpStr+Input[i];

    Result:=TmpStr;
  end;

  procedure InitAllTextBox(var Form: TForm);
  { I.S. : Form terdefinisi, pada pemanggilan harus menggunakan typecasting
           mis: ClearAllTextBox(TForm(frmCoba));
    F.S. : Semua textbox (TEdit atau TAdvEdit) pada form akan diinisialisasi dengan string
           kosong, enabled=true, readonly=false }
  var i: integer;
  begin
    for i:=0 to Form.ComponentCount-1 do
      if (Form.Components[i] is TEdit) then begin
        (Form.Components[i] as TEdit).Text:='';
        (Form.Components[i] as TEdit).Enabled:=true;
        (Form.Components[i] as TEdit).ReadOnly:=false;
      end else if (Form.Components[i] is TAdvEdit) then begin
        (Form.Components[i] as TAdvEdit).Text:='';
        (Form.Components[i] as TAdvEdit).Enabled:=true;
        (Form.Components[i] as TAdvEdit).ReadOnly:=false;
      end;
  end;

  function EkstrakString(Input: string; Limiter: char; Count: integer): string;
  { I.S. : Input = string yang akan di-extract, Limiter = karakter yang
           dipakai sebagai tanda pemisah, Count = bagian ke berapa yang
           akan diambil, paling kiri adalah bagian ke-1
    F.S. : menghasilkan substring ke-Count dari Input dengan batas Limiter }
  var Ctr, Posisi: integer;
      TmpString: string;
  begin
    TmpString:='';
    Ctr:=0;
    while (Ctr<Count) do
    begin
      Posisi:=Pos(Limiter,Input);
      if (Posisi=0) then
        Posisi:=Length(Input)+1;
      TmpString:=Copy(Input,1,Posisi-1);
      Delete(Input,1,Posisi);
      Ctr:=Ctr+1;
    end;

    Result:=TmpString;
  end;


  function CekTanggal(Input: string): boolean;
  { I.S. : Input terdefinisi
    F.S. : menghasilkan true jika Input merupakan format tanggal yang benar
           sesuai dengan ShortDateFormat }
  var TmpString, Tgl, Bln, Thn : string;
      Valid: boolean;
      i: integer;
  begin
    for i:=1 to 3 do begin
      TmpString:=EkstrakString(ShortDateFormat,DateSeparator,i);
      if (Pos('D',UpperCase(TmpString))<>0) then
        Tgl:=EkstrakString(Input,DateSeparator,2)
      else if (Pos('M',UpperCase(TmpString))<>0) then
        Bln:=EkstrakString(Input,DateSeparator,i)
      else if (Pos('Y',UpperCase(TmpString))<>0) then
        Thn:=EkstrakString(Input,DateSeparator,3);
    end;

    if (not CekInteger(Trim(Tgl))) or (not CekInteger(Trim(Bln))) or (not CekInteger(Trim(Thn))) then
      Valid:=false
    else
      Valid:=IsValidDate(StrToInt(Thn),StrToInt(Bln),StrToInt(Tgl));

    Result:=Valid;
  end;

  function ReformatFloat(newsep: char; input: string):string;
  { I.S. : newsep, input terdefinisi, newsep diisi dengan tanda '.' atau ','
    F.S. : menghasilkan string input yang diubah tanda '.' pertama jadi ',' dan
           sebaliknya }
  var oldsep: char;
  begin
    if (newsep=',') then
      oldsep:='.'
    else if (newsep='.') then
      oldsep:=','
    else
      oldsep:=#0;

    if (pos(oldsep,input)>0) then
      input[pos(oldsep,input)]:=newsep;
    result:=input;
  end;

  function ReplaceSubStr(Input, Find, ReplaceWith: string): string;
  { I.S. : Input, Find, dan ReplaceWith terdefinisi
    F.S. : menghasilkan string Input di mana substring Find diganti dengan
           substring ReplaceWith }
  var i: integer;
      Tmp: string;
  begin
    while (Pos(Find,Input)>0) do begin
      i:=Pos(Find,Input);
      Delete(Input,i,Length(Find));
      Tmp:=Copy(Input,i,Length(Input)-i+2);
      Delete(Input,i,Length(Input)-i+2);
      Input:=Input+ReplaceWith+Tmp;
    end;

    Result:=Input;
  end;

  function ReverseFormatDate(Tanggal:string): TDate;
  { I.S. : Tanggal terdefinisi dengan format "d mmm yyyy"
    F.S. : menghasilkan TDate sesuai dengan Tanggal }
  var Hasil: TDate;
      i: integer;
  begin
    Tanggal:=TrimAll(UpperCase(Tanggal));
    for i:=1 to 12 do
    begin
      Hasil:=EncodeDate(1,i,1);
      Tanggal:=ReplaceSubStr(Tanggal,UpperCase(FormatDateTime('mmm',Hasil)),IntToStr(i));
    end;
    Hasil:=EncodeDate(StrToInt(EkstrakString(Tanggal,' ',3)),StrToInt(EkstrakString(Tanggal,' ',2)),StrToInt(EkstrakString(Tanggal,' ',1)));

    Result:=Hasil;
  end;

  function SetStrLen(Input: string; Len: integer; FillChar: char; FillPos: TAlignment): string;
  { I.S. : Input, Len, FillChar, dan FillPos terdefinisi.
           FillPos diisi dengan tpKiri atau tpKanan
    F.S. : jika panjang Input lebih kecil dari Len maka akan menghasilkan
           string Input yang ditambahkan dengan karakter FillChar pada posisi
           kiri atau kanan string (sesuai FillPos) hingga Input memiliki
           panjang=Len, jika panjang Input>=Len maka akan menghasilkan string
           Input tanpa perubahan }
  begin
    if (FillPos=taRightJustify) or (FillPos=taLeftJustify) then
      while (Length(Input)<Len) do begin
        if (FillPos=taRightJustify) then
          Input:=FillChar+Input
        else if (FillPos=taLeftJustify) then
          Input:=Input+FillChar;
      end;

    Result:=Input;
  end;

  function HitungChar(Input: string; Karakter: Char): integer;
  { I.S. : Input dan Karakter terdefinisi
    F.S. : menghasilkan jumlah Karakter yang terdapat pada input }
  var i, Count: integer;
  begin
    Count:=0;
    for i:=1 to Length(Input) do begin
      if (Input[i]=Karakter) then
        Inc(Count);
    end;

    Result:=Count;
  end;

  {take control the TControl}
  procedure GoNextColumn(grid: TObject);
  var vGrid: TAdvStringGrid; CanEdit: boolean;
  begin
    vGrid:= (grid as TAdvStringGrid);
    vGrid.OnCanEditCell(grid, vGrid.Row, vGrid.Col, CanEdit);
    if (not CanEdit) and (vGrid.Col <> vGrid.ColCount-1) then
      vGrid.Col := vGrid.Col + 1;
  end;

function GoNextControl(Form: TForm; Sender: TWinControl; GoForward, CheckTabStop, CheckParent: Boolean): TWinControl;
var
I, StartIndex: Integer;
List: TList;
begin
  Result := nil;
  List := TList.Create;
  try
    Form.GetTabOrderList(List);
    if List.Count > 0 then
    begin
      StartIndex := List.IndexOf(Sender);
      if StartIndex = -1 then
        if GoForward then StartIndex := List.Count - 1 else StartIndex := 0;
      I := StartIndex;
      repeat
        if GoForward then
        begin
          Inc(I);
          if I = List.Count then I := 0;
        end else
        begin
          if I = 0 then I := List.Count;
          Dec(I);
        end;
        Sender := List[I];
        if Sender.CanFocus and
          (not CheckTabStop or Sender.TabStop) and
          (not CheckParent or (Sender.Parent = Sender)) then
          Result := Sender;
      until (Result <> nil) or (I = StartIndex);
    end;
  finally
    List.Free;
  end;
end;

function GoNextControl(Panel: TPanel; Sender: TWinControl; GoForward, CheckTabStop, CheckParent: Boolean): TWinControl;
var
I, StartIndex: Integer;
List: TList;
begin
  Result := nil;
  List := TList.Create;
  try
    Panel.GetTabOrderList(List);
    if List.Count > 0 then
    begin
      StartIndex := List.IndexOf(Sender);
      if StartIndex = -1 then
        if GoForward then StartIndex := List.Count - 1 else StartIndex := 0;
      I := StartIndex;
      repeat
        if GoForward then
        begin
          Inc(I);
          if I = List.Count then I := 0;
        end else
        begin
          if I = 0 then I := List.Count;
          Dec(I);
        end;
        Sender := List[I];
        if Sender.CanFocus and
          (not CheckTabStop or Sender.TabStop) and
          (not CheckParent or (Sender.Parent = Sender)) then
          Result := Sender;
      until (Result <> nil) or (I = StartIndex);
    end;
  finally
    List.Free;
  end;
end;


{global macro routines}

  function GetAppPath: string;
  begin
    Result := ExtractFilePath(ParamStr(0));
    if Result[Length(Result)] <> '\' then Result := Result + '\';
  end;


{check macro routines}

  function CekInteger(Input: string): boolean;
  { I.S. : Input terdefinisi
    F.S. : menghasilkan true jika Input adalah bilangan integer }
  begin
    try
      StrToInt(Input);
      Result:=true
    except
      on EConvertError do
        Result:=false;
    end;
  end;

  function CekInteger(Input: string; LBound,UBound: integer): boolean; overload;
  { I.S. : Input, LBound, UBound terdefinisi
    F.S. : menghasilkan true jika Input merupakan bilangan integer
           yang terletak antara LBound dan UBound (LBound<=Input<=UBound)
           Jika LBound>UBound maka batas tidak akan diperiksa (hanya memeriksa
           integer atau bukan) }
  var TmpInt: integer;
      Status: boolean;
  begin
    TmpInt:=0;
    Status:=true;
    try
      TmpInt:=StrToInt(Input);
    except
      on EConvertError do
        Status:=false;
    end;
    if (Status) and (LBound<UBound) then
      if ((TmpInt<LBound) or (TmpInt>UBound)) then
        Status:=false;

    Result:=Status;
  end;

  function CekFloat(Input: string): boolean; overload;
  { I.S. : Input terdefinisi
    F.S. : menghasilkan true jika Input merupakan bilangan real }
  var Status: boolean;
  begin
    Status:=true;
    try
      StrToFloatDef(Input,0);
    except
      on EConvertError do
        Status:=false;
    end;

    Result:=Status;
  end;

  function CekFloat(Input: string; LBound, UBound: integer): boolean; overload;
  { I.S. : Input, LBound, UBound terdefinisi
    F.S. : menghasilkan true jika Input merupakan bilangan real
           yang terletak antara LBound dan UBound (LBound<=Input<=UBound)
           Jika LBound>UBound maka batas tidak akan diperiksa (hanya memeriksa
           real atau bukan) }
  var TmpReal: real;
      Status: boolean;
  begin
    TmpReal:=0;
    Status:=true;
    try
      TmpReal:=StrToFloat(Input);
    except
      on EConvertError do
        Status:=false;
    end;

    if (Status) and (LBound<UBound) then
      if ((TmpReal<LBound) or (TmpReal>UBound)) then
        Status:=false;

    Result:=Status;
  end;


{format macro routines}

  function qoute(s: string): string;
  begin
    Result := '"'+s+'"';
  end;

  function f2s(f: Extended): string;
  begin
    Result := FormatFloat('#, ##0.##', f);
  end;

  function f2s(f: Extended; decimal: Byte): string;
  begin
    Result := FormatFloat('#, ##0.'+Copy('00000000', 1, decimal), f);
  end;

  function s2f(s: string): Extended;
  var
    p : Integer;
    sorg : string;
  begin
    s := Trim(s);
    sorg := s;
    p := 1;
    while p <= Length(s) do
      if s[p] in ['0'..'9', '.'] then
        inc(p)
      else
        Delete(s, p, 1);
    if s = '' then
      Result := 0
    else begin
      Result := StrToFloat(s);
      if (sorg[1] = '-') or ((sorg[1] = '(') and (sorg[Length(sorg)] = ')')) then
        Result := -Result; //Negate
    end;
  end;

  function fixfs(s: string): string;
  begin
    Result := FloatToStr(s2f(s));
  end;

  function FormatMoney(f: Extended): string;
  begin
    if f >= 0 then
      Result := FormatFloat('Rp #, ##0.00', f)
    else
      Result := FormatFloat('(Rp #, ##0.00)', -f);
  end;

  function b2s(b: Boolean): string;
  begin
    if b then
      Result := '1'
    else
      Result := '0';
  end;

  function d2s(d: TDate): string;
  begin
    Result := FormatDateTime('dd mmm yyyy', d);
  end;

  function s2d(s: string): TDate;
  var
    dt: TDateTime;
    i, j: integer;
    bulan, tahun, tgl: string;
  begin
    if s = '' then begin
      Result := now;
      Exit;
    end;
    //Replace month name
    s:=ReplaceSubStr(s, 'Jan', '01');
    s:=ReplaceSubStr(s, 'Feb', '02');
    s:=ReplaceSubStr(s, 'Mar', '03');
    s:=ReplaceSubStr(s, 'Apr', '04');
    s:=ReplaceSubStr(s, 'May', '05');
    s:=ReplaceSubStr(s, 'Jun', '06');
    s:=ReplaceSubStr(s, 'Jul', '07');
    s:=ReplaceSubStr(s, 'Aug', '08');
    s:=ReplaceSubStr(s, 'Sep', '09');
    s:=ReplaceSubStr(s, 'Oct', '10');
    s:=ReplaceSubStr(s, 'Nov', '11');
    s:=ReplaceSubStr(s, 'Dec', '12');
    s:=ReplaceSubStr(s, ' ', '/');
    tgl := copy(S, 1, 2);
    for i := 1 to 2 do begin
      j := Pos('/', S);
      if i=1 then begin
        //ambil bulan
        bulan := copy(S, j+1, 2);
        delete(S, j, 1);
      end else
        //ambil Tahun
        Tahun := copy(S, j+3, 2);
    end;
    //Discard time information, if any...
    s := bulan+'/'+tgl+'/'+tahun;
    //Showmessage('Data yang mau diformat: '+s);
    if Pos(': ', s) > 0 then begin
      dt := StrToDateTime(s);
      Result := Trunc(dt);
    end else
      Result := StrToDate(s);
  end;

  function converttanggal(Value: TDate): string;
  var a: string;
  begin
    a := DateToStr(Value);
    Result := a;
  end;

  function FormatLCD(input: string): string;
  var s: string;
  begin
    s := input;
    s := '              '+s;
    s := Copy(s, Length(s)-10, 11);
    Result := s;
  end;


{dialog macro routines}

  function Confirmed(prompt: string): Boolean;
  begin
    Result := ( MessageDlg(prompt, mtConfirmation, [mbYes, mbNo], 0) = mrYes );
  end;

  procedure Alert(AlertMsg: string);
  begin
    MessageDlg(AlertMsg, mtWarning, [mbOK], 0);
  end;

  procedure Inform(Information: string);
  begin
    MessageDlg(Information, mtInformation, [mbOK], 0);
  end;


{form macro suport}

  procedure ClearForm(frm: tform);
  var i: integer;
  begin
    for i := 0 to frm.ComponentCount-1  do begin
      if ((frm.components[i] is tadvedit) or (frm.components[i] is tedit)) then begin
        if (frm.components[i] is tadvedit) then begin
          if (frm.components[i] as tadvedit).visible then
            (frm.components[i] as  tadvedit).text := '';
        end else if (frm.components[i] as tedit).visible then
          (frm.components[i] as tedit).text := '';
      end else if (frm.Components[i] is TAdvStringGrid) then
        (frm.Components[i] as TAdvStringGrid).ClearNormalCells
    end;
  end;

  function cekkosong(frm: tform): boolean;
  var i: integer; t: tcomponent; k: TCaption;
  begin
    for i := 0 to (frm.ComponentCount-1) do begin
      t := frm.Components[i];
      if ((t is tadvedit) and ((t as tadvedit).visible)) then begin
        k := (t as tadvedit).text;
        //showmessage('Teks sekarang: '+k);
        if  (trim(k)='') then begin
          Result := true;
          Alert('Input '+(t as tadvedit).Hint+'   tidak boleh kosong!');
          exit;
        end;
        if ((t as tadvedit).tag=1) then begin
          if (not (CekFloat(k))) then begin
            Result := true;
            Alert('Input   '+(t as tadvedit).hint+'  hanya  boleh  angka!');
            exit;
          end;
        end;
      end;
    end;
    Result := false;
  end;

  procedure TextToEdit(frm: tform; editbox: string;
    Value: string);
  var i: integer;
  begin
    for i := 0 to frm.ComponentCount-1 do begin
      if (frm.Components[i] is tadvedit) then
        if (uppercase((frm.Components[i] as tadvedit).name)=uppercase(editbox)) then
          (frm.Components[i] as tadvedit).text := Value;
    end;
  end;


{wincontrol macro routines}

  procedure SetEditReadOnly(TextBox: TAdvEdit;
    IsReadOnly: Boolean);
  begin
    with TextBox do
      if IsReadOnly then begin
        Color := $00AFD2FA;
        Enabled := False;
        TabStop := False;
      end else begin
        Color := clWhite;
        Enabled := True;
        TabStop := True;
      end;
  end;

  procedure SetComboReadOnly(ComboBox: TComboBox;
    IsReadOnly: Boolean);
  begin
    with ComboBox do
      if IsReadOnly then begin
        Color := $00AFD2FA;
        Enabled := False;
        TabStop := False;
      end else begin
        Color := clWhite;
        Enabled := True;
        TabStop := True;
      end;
  end;

  procedure SetEditReadOnly(DateTimePicker: TDateTimePicker;
    IsReadOnly: Boolean);
  begin
    with DateTimePicker do
      if IsReadOnly then begin
        Color := $00AFD2FA;
        Enabled := False;
        TabStop := False;
      end else begin
        Color := clWhite;
        Enabled := True;
        TabStop := True;
      end;
  end;

  function SetComboListValue(Combo: TComboBox;
    NewValue: string): Integer;
  begin
    Result := Combo.Items.IndexOf(NewValue);
    Combo.ItemIndex := Result;
  end;


{stringgrid macro routines}

  procedure TextToGrid(adv: TAdvStringGrid; kolom, baris: integer;
    Text: string);
  begin
    adv.Cells[kolom, baris] := Text;
  end;

  procedure ResetGrid(Sender: TAdvStringGrid; DefaultRowCount,DefaultColCount,
                      DefaultFixedRows, DefaultFixedCols, DefaultStretchColumn: integer);
  begin

    Sender.ExpandAll;
    Sender.ClearNormalCells;
    Sender.RowCount                 := DefaultRowCount;
    Sender.ColCount                 := DefaultColCount;
    Sender.FixedRows                := DefaultFixedRows;
    Sender.FixedFont.Style          := [];
    Sender.FixedCols                := DefaultFixedCols;
    if DefaultStretchColumn <> -1 then begin
      Sender.ColumnSize.StretchColumn := DefaultStretchColumn;
      Sender.ColumnSize.Stretch       := true;
    end;
    Sender.Refresh;
  end;

  function IsClear(AGrid: TAdvStringGrid; ACol, ARow: integer): boolean;
  begin
    Result := false;
    if(AGrid.Cells[ACol, ARow]='')then
      Result := true;
  end;

  procedure edittogrid(adv: TAdvStringGrid; kolom, baris: integer;
    editbox: tadvedit);
  begin
    adv.Cells[kolom, baris] := editbox.Text;
  end;

  procedure DateToGrid(adv: TAdvStringGrid; kolom, baris: integer;
    InputDate: TDateTimePicker);
  begin
    adv.Cells[kolom, baris] := d2s(InputDate.date);
  end;

  function cekkosonggrid(adv: TAdvStringGrid; row: integer): boolean;
  var i: integer;
  begin
    for i := 0 to adv.ColCount-1 do
      if (trim(adv.cells[i, row])='') then begin
        Result := true;
        exit;
      end;
    Result := false;
  end;

  procedure deleterow(grid: TAdvStringGrid; row: integer; idcol: integer;CekColumn:boolean);
  begin
    if CekColumn then begin
      if (grid.Cells[idcol, row]<>'') then begin
        grid.Clearrows(row, 1);
        if (grid.RowCount<>2) then
          grid.RemoveRows(row, 1);
      end;
    end
    else begin
      if grid.RowCount <> 2 then
        grid.RemoveRows(row, 1)
      else
        grid.Clearrows(row, 1);
    end;
    grid.Update;
  end;

  procedure DeleteRows(AGrid: TAdvStringGrid; DefaultRowCount: Integer);
  begin
    if Confirmed('Hapus baris ke '+IntToStr(AGrid.Row)+' ?') then begin
      if(AGrid.RowCount > DefaultRowCount)then begin
        AGrid.ClearRows(AGrid.Row,1);
        AGrid.RemoveRows(AGrid.Row,1);
      end else if (AGrid.RowCount = DefaultRowCount)then
        AGrid.ClearRows(AGrid.Row,1);

      AGrid.AutoNumberCol(0);
    end;
  end;

  procedure DeleteLastRow(AGrid: TAdvStringGrid; DefaultRowCount,  ColId: Integer);
  begin
    if(AGrid.RowCount > DefaultRowCount) and (AGrid.Cells[colId, AGrid.RowCount-2] = '') then begin
      AGrid.ClearRows(AGrid.RowCount-2 ,1);
      AGrid.RemoveRows(AGrid.RowCount-2 ,1);
    end else if (AGrid.RowCount = DefaultRowCount)then
      AGrid.ClearRows(AGrid.RowCount-2,1);
  end;

  procedure DeleteRowTerakhir(sender : TAdvStringGrid;LimitRow,RowDelete:integer);
  begin
    if sender.RowCount > LimitRow then
      sender.RowCount := sender.RowCount - RowDelete;
  end;

  function AtLeastOneData(Grid: TadvStringGrid): boolean;
  var i:integer;
  begin
    result:=false;
    for i:=1 to Grid.RowCount-1 do begin
      if (not CekKosongGrid(Grid,i)) then begin
        result:=true;
        break;
      end;
    end;
  end;


{chart macro routines}



{stringlist macro routines}

  function maxstringlist(b: tstringlist): real;
  var max: real;
      i: integer;
  begin
    max := 0;
    for i := 0 to b.Count-1 do begin
      if i=0 then
        max := strtofloat(b.strings[i])
      else begin
        if (max<strtofloat(b.strings[i])) then
          max := strtofloat(b.strings[i]);
      end;
    end;
    Result := max;
  end;

  function existOTS(T: Tstringlist; search: string): boolean;
  begin
    if t.IndexOf(search)<>-1 then
      Result := true
    else
      Result := false;
  end;

  function IndexofValue(aList:TStringList;aValue:string):integer;
  var i:integer;
  begin
    Result := -1;
    for i:= 0 to aList.Count -1 do begin
      if aValue = aList.Values[aList.Names[i]] then
        Result := i;
    end;
  end;

  function IndexofValue(aList:TStrings;aValue:string):integer;
  //buat set item_index di combo box
  var i:integer;
  begin
    Result := -1;
    for i:= 0 to aList.Count -1 do begin
      if aValue = aList.Strings[i] then
        Result := i;
    end;
  end;

  function NameFromValue(aList:TStringList;aValue:string):integer;
  var i:integer;
  begin
    Result := -1;
    for i:= 0 to aList.Count -1 do begin
      if aValue = aList.Values[aList.Names[i]] then begin
        Result := StrToInt(aList.Names[i]);
        Break;
      end;
    end;
  end;


{ Global Project Class Implementation }
{ _SystemConstant_Arr }

constructor _SystemConstant_Arr.Create;
begin
  inherited Create;
  setLength(FSystemConstant_Arr,0);
end;

destructor _SystemConstant_Arr.Destroy;
begin
  Self.Clear;
  inherited;
end;

procedure _SystemConstant_Arr.Clear;
var i: integer;
begin
  for i:=0 to high(FSystemConstant_Arr) do FSystemConstant_Arr[i].Destroy;
  setLength(FSystemConstant_Arr,0);
end;

function _SystemConstant_Arr.New: _SystemConstant;
begin
  Result := _SystemConstant.Create;
end;

function _SystemConstant_Arr.Add(ASeksi: string; ANama: string; ANilai: string): integer;
begin
  setLength(FSystemConstant_Arr, length(FSystemConstant_Arr)+1);
  Result := high(FSystemConstant_Arr);
  FSystemConstant_Arr[Result] := New;
  FSystemConstant_Arr[Result].Seksi := ASeksi;
  FSystemConstant_Arr[Result].Nama := ANama;
  FSystemConstant_Arr[Result].Nilai := ANilai;
end;

function _SystemConstant_Arr.IndexOf(ASeksi: string; ANama: string): integer;
var i: integer; found: boolean;
begin
  i := 0; found := false;
  while (i<=high(FSystemConstant_Arr)) and (not found) do
    if (FSystemConstant_Arr[i].FSeksi=ASeksi) and
       (FSystemConstant_Arr[i].FNama=ANama) then
      found := true
    else inc(i);
  if (found) then
    Result := i
  else
    Result := -1;
end;

procedure _SystemConstant_Arr.Delete(Index: integer);
var i: integer;
begin
  if (Index<0) or (Index>high(FSystemConstant_Arr)) then Exit;
  FSystemConstant_Arr[Index].Destroy;
  for i:=Index to high(FSystemConstant_Arr)-1 do
    FSystemConstant_Arr[Index] := FSystemConstant_Arr[Index-1];
  setLength(FSystemConstant_Arr,length(FSystemConstant_Arr)-1);
end;

function _SystemConstant_Arr.Count: integer;
begin
  Result := length(FSystemConstant_Arr);
end;

function _SystemConstant_Arr.Get(Index: integer): _SystemConstant;
begin
  if (Index<0) or (Index>high(FSystemConstant_Arr)) then Result := nil
  else Result := FSystemConstant_Arr[Index];
end;


{ _SystemConstant }

constructor _SystemConstant.Create;
begin
  inherited Create;
end;

destructor _SystemConstant.Destroy;
begin
  inherited;
end;

procedure _SystemConstant.Reset;
begin
  FSeksi := '';
  FNama := '';
  FNilai := '';
  FSeq:= 0;
  FParentSeq:= 0;
end;

procedure _SystemConstant.InsertOnDB;
begin
  try ExecSQL(
    'INSERT INTO System_Constant (Seksi,Nama,Nilai)'+
    ' VALUES ('+
      FormatSQLString(FSeksi)+','+
      FormatSQLString(FNama)+','+
      FormatSQLString(FNilai)+')'
  ); except raise; end;
end;

procedure _SystemConstant.UpdateOnDB;
begin
  try ExecSQL(
    'UPDATE System_Constant SET'+
          ' Nilai='+FormatSQLString(FNilai)+
    ' WHERE Seksi='+FormatSQLString(FSeksi)+
      ' AND Nama='+FormatSQLString(FNama)
  ); except raise; end;
end;

procedure _SystemConstant.DeleteOnDB;
begin
  try ExecSQL(
    'DELETE FROM System_Constant'+
    ' WHERE Seksi='+FormatSQLString(FSeksi)+
      ' AND Nama='+FormatSQLString(FNama)
  ); except raise; end;
end;


class function _SystemConstant.ExistInDB(AItemCategory, AItemType: string): integer;
var buffer: TMysqlResult;
   // temp: integer;
begin
  buffer := OpenSQL(
            'SELECT Seq FROM System_Constant '+
            'WHERE Seksi= '+FormatSQLString(AItemCategory)+
            'AND UPPER(Nama)='+uppercase(FormatSQLString(AItemType))
            );
   Result := buffer.RecordCount;

  {temp:= BufferToInteger(buffer.FieldValue(0));
  result:= buffer.RecordCount;
  buffer.Destroy;
  if AItemType<>'' then begin
    buffer := OpenSQL(
      'SELECT COUNT(*) FROM System_Constant'+
      ' WHERE Seq_Parent='+formatSQLNumber(temp)+
      ' AND Nilai='+FormatSQLString(AItemType)
    );
    Result := BufferToInteger(buffer.FieldValue(0));
  end;}
  buffer.Destroy;
end;

function _SystemConstant.SelectInDB(ASeksi: String='';ANama: String='';ANilai:String=''; ASeq: integer=0; AParentSeq: integer=0): boolean;
var sql,filter: String;
    buffer: TMysqlResult;
begin
  sql:= 'SELECT Seksi,Nama,Nilai,Seq,Seq_Parent '+
        'FROM System_Constant ';
  filter:= '';
  if ASeksi<>'' then
    filter := filter+' AND upper(Seksi)='+FormatSQLString(uppercase(ASeksi));
  if ANama<>'' then
    filter := filter+' AND upper(Nama)='+FormatSQLString(uppercase(ANama));
  if ANilai<>'' then
    filter := filter+' AND upper(Nilai)='+FormatSQLString(uppercase(ANilai));
  if ASeq<>0 then
    filter := filter+' AND Seq='+FormatSQLNumber(ASeq);
  if AParentSeq<>0 then
    filter := filter+' AND Seq_Parent='+FormatSQLNumber(AParentSeq);

  sql:= sql+ ' WHERE '+Copy(filter,5,length(filter));
  buffer := OpenSQL(sql);
  if (buffer.RecordCount<>0) then begin
    FSeksi:= BufferToString(buffer.FieldValue(0));
    FNama := BufferToString(buffer.FieldValue(1));
    FNilai:= BufferToString(buffer.FieldValue(2));
    FSeq  := BufferToInteger(Buffer.FieldValue(3));
    FParentSeq:= BufferToInteger(Buffer.FieldValue(4));
  end;
  Result := (buffer.RecordCount<>0);
  buffer.Destroy;
end;

class function _SystemConstant.ExistCatInDB(AItemCategory: string): integer;
var buffer: TMysqlResult;
begin
  buffer := OpenSQL(
            'SELECT Count(*) FROM System_Constant '+
            'WHERE upper(Seksi)=''ITEM CATEGORY'' '+
            'AND Nilai='+FormatSQLString(AItemCategory)
            );
  result:= BufferToInteger(buffer.FieldValue(0));
  buffer.Destroy;
end;

{ _SystemUser_Arr }

constructor _SystemUser_Arr.Create;
begin
  inherited Create;
  setLength(FSystemUser_Arr,0);
end;

destructor _SystemUser_Arr.Destroy;
begin
  Self.Clear;
  inherited;
end;

procedure _SystemUser_Arr.Clear;
var i: integer;
begin
  for i:=0 to high(FSystemUser_Arr) do FSystemUser_Arr[i].Destroy;
  setLength(FSystemUser_Arr,0);
end;

function _SystemUser_Arr.New: _SystemUser;
begin
  Result := _SystemUser.Create;
end;

function _SystemUser_Arr.Add(AUserId: string; AUserName: string; APasswd: string; AAccessLevel: integer; ADisableDate: TDate): integer;
begin
  setLength(FSystemUser_Arr, length(FSystemUser_Arr)+1);
  Result := high(FSystemUser_Arr);
  FSystemUser_Arr[Result] := New;
  FSystemUser_Arr[Result].UserId := AUserId;
  FSystemUser_Arr[Result].UserName := AUserName;
  FSystemUser_Arr[Result].Passwd := APasswd;
  FSystemUser_Arr[Result].AccessLevel := AAccessLevel;
  FSystemUser_Arr[Result].DisableDate := ADisableDate;
//  FSystemUser_Arr[Result].DeptID  := aDeptID;
end;

function _SystemUser_Arr.IndexOf(AUserId: string): integer;
var i: integer; found: boolean;
begin
  i := 0; found := false;
  while (i<=high(FSystemUser_Arr)) and (not found) do
    if (FSystemUser_Arr[i].FUserId=AUserId) then
      found := true
    else inc(i);
  if (found) then
    Result := i
  else
    Result := -1;
end;

procedure _SystemUser_Arr.Delete(Index: integer);
var i: integer;
begin
  if (Index<0) or (Index>high(FSystemUser_Arr)) then Exit;
  FSystemUser_Arr[Index].Destroy;
  for i:=Index to high(FSystemUser_Arr)-1 do
    FSystemUser_Arr[Index] := FSystemUser_Arr[Index-1];
  setLength(FSystemUser_Arr,length(FSystemUser_Arr)-1);
end;

function _SystemUser_Arr.Count: integer;
begin
  Result := length(FSystemUser_Arr);
end;

function _SystemUser_Arr.Get(Index: integer): _SystemUser;
begin
  if (Index<0) or (Index>high(FSystemUser_Arr)) then Result := nil
  else Result := FSystemUser_Arr[Index];
end;


{ _SystemUser }

constructor _SystemUser.Create;
begin
  inherited Create;
end;

destructor _SystemUser.Destroy;
begin
  inherited;
end;

procedure _SystemUser.Reset;
begin
  FUserId := '';
  FUserName := '';
  FPasswd := '';
  FAccessLevel := 0;
  FDisableDate := 0;
end;

procedure _SystemUser.InsertOnDB;
begin
  try ExecSQL(
    'INSERT INTO System_Users (User_Id,User_Name,Passwd,Access_Level,Disabled_Date)'+
    ' VALUES ('+
      FormatSQLString(FUserId)+','+
      FormatSQLString(FUserName)+','+
      FormatSQLString(FPasswd)+','+
      FormatSQLNumber(FAccessLevel)+','+
      FormatSQLDate(FDisableDate)+')'
  ); except raise; end;
end;

procedure _SystemUser.UpdateOnDB;
begin
  try ExecSQL(
    'UPDATE System_Users SET'+
          ' User_Name='+FormatSQLString(FUserName)+','+
          ' Passwd='+FormatSQLString(FPasswd)+','+
          ' Access_Level='+FormatSQLNumber(FAccessLevel)+','+
          ' Disabled_Date='+FormatSQLDate(FDisableDate)+
    ' WHERE User_Id='+FormatSQLString(FUserId)
  ); except raise; end;
end;

procedure _SystemUser.DeleteOnDB;
begin
  try
      ExecSQL('Delete from system_access where user_id = '+FormatSQLString(FUserId));
      ExecSQL(' DELETE FROM System_Users'+
    ' WHERE User_Id='+FormatSQLString(FUserId)
  ); except raise; end;
end;

function _SystemUser.SelectInDB(AUserId,ADeptId: string): boolean;
var buffer: TMysqlResult;
sql : string;
begin
  sql := 'SELECT SU.User_Id, SU.User_Name, SU.Passwd, SU.Access_Level, SU.Disabled_Date '+
     ' FROM System_Users SU'+
    ' WHERE SU.User_Id='+FormatSQLString(AUserId);

  buffer := OpenSQL(sql);
  if (buffer.RecordCount<>0) then begin
    FUserId := BufferToString(buffer.FieldValue(0));
    FUserName := BufferToString(buffer.FieldValue(1));
    FPasswd := BufferToString(buffer.FieldValue(2));
    FAccessLevel := BufferToInteger(buffer.FieldValue(3));
    FDisableDate := BufferToDateTime(buffer.FieldValue(4));
  end;
  Result := (buffer.RecordCount<>0);
  buffer.Destroy;
end;

class function _SystemUser.ExistInDB(AUserId: string): integer;
var buffer: TMysqlResult;
begin
  buffer := OpenSQL(
    'SELECT COUNT(*) FROM System_Users'+
    ' WHERE User_Id='+FormatSQLString(AUserId)
  );
  Result := BufferToInteger(buffer.FieldValue(0));
  buffer.Destroy;
end;

function _SystemUser.SelectInDbX(AUserId, APassWd: string): boolean;
var buffer: TMysqlResult;
sql : string;
begin
  sql := 'SELECT SU.User_Id, SU.User_Name, SU.Passwd, SU.Access_Level, SU.Disabled_Date '+
     ' FROM System_Users SU'+
    ' WHERE SU.User_Id = '+FormatSQLString(AUserId)+
    ' and su.Passwd = password('+FormatSQLString(APassWd)+')';

  buffer := OpenSQL(sql);
  if (buffer.RecordCount<>0) then begin
    FUserId := BufferToString(buffer.FieldValue(0));
    FUserName := BufferToString(buffer.FieldValue(1));
    FPasswd := BufferToString(buffer.FieldValue(2));
    FAccessLevel := BufferToInteger(buffer.FieldValue(3));
    FDisableDate := BufferToDateTime(buffer.FieldValue(4));
  end;
  Result := (buffer.RecordCount<>0);
  buffer.Destroy;

end;

{ _SystemReversal_Arr }

constructor _SystemReversal_Arr.Create;
begin
  inherited Create;
  setLength(FSystemReversal_Arr,0);
end;

destructor _SystemReversal_Arr.Destroy;
begin
  Self.Clear;
  inherited;
end;

procedure _SystemReversal_Arr.Clear;
var i: integer;
begin
  for i:=0 to high(FSystemReversal_Arr) do FSystemReversal_Arr[i].Destroy;
  setLength(FSystemReversal_Arr,0);
end;

function _SystemReversal_Arr.New: _SystemReversal;
begin
  Result := _SystemReversal.Create;
end;

function _SystemReversal_Arr.Add(AReversSeq: integer; AReversDate: TDate; ANotes: string; AUserId: string): integer;
begin
  setLength(FSystemReversal_Arr, length(FSystemReversal_Arr)+1);
  Result := high(FSystemReversal_Arr);
  FSystemReversal_Arr[Result] := New;
  FSystemReversal_Arr[Result].ReversSeq := AReversSeq;
  FSystemReversal_Arr[Result].ReversDate := AReversDate;
  FSystemReversal_Arr[Result].Notes := ANotes;
  FSystemReversal_Arr[Result].SystemUser.UserId := AUserId;
end;

function _SystemReversal_Arr.IndexOf(AReversSeq: integer): integer;
var i: integer; found: boolean;
begin
  i := 0; found := false;
  while (i<=high(FSystemReversal_Arr)) and (not found) do
    if (FSystemReversal_Arr[i].FReversSeq=AReversSeq) then
      found := true
    else inc(i);
  if (found) then
    Result := i
  else
    Result := -1;
end;

procedure _SystemReversal_Arr.Delete(Index: integer);
var i: integer;
begin
  if (Index<0) or (Index>high(FSystemReversal_Arr)) then Exit;
  FSystemReversal_Arr[Index].Destroy;
  for i:=Index to high(FSystemReversal_Arr)-1 do
    FSystemReversal_Arr[Index] := FSystemReversal_Arr[Index-1];
  setLength(FSystemReversal_Arr,length(FSystemReversal_Arr)-1);
end;

function _SystemReversal_Arr.Count: integer;
begin
  Result := length(FSystemReversal_Arr);
end;

function _SystemReversal_Arr.Get(Index: integer): _SystemReversal;
begin
  if (Index<0) or (Index>high(FSystemReversal_Arr)) then Result := nil
  else Result := FSystemReversal_Arr[Index];
end;


{ _SystemReversal }

constructor _SystemReversal.Create;
begin
  inherited Create;
  FSystemUser := _SystemUser.Create;
  //FItemDetail_Arr := _ItemDetail_Arr.Create;
  //FCashierInvoice_Arr := _CashierInvoice_Arr.Create;
  //FSaleDetail_Arr := _SaleDetail_Arr.Create;
  //FDebt_Arr := _Debt_Arr.Create;
  //FIncomeExpense_Arr := _IncomeExpense_Arr.Create;
end;

destructor _SystemReversal.Destroy;
begin
  FSystemUser.Destroy;
  //FItemDetail_Arr.Destroy;
  //FCashierInvoice_Arr.Destroy;
  //FSaleDetail_Arr.Destroy;
  //FDebt_Arr.Destroy;
  //FIncomeExpense_Arr.Destroy;
  inherited;
end;

procedure _SystemReversal.Reset;
begin
  FReversSeq := 0;
  FReversDate := 0;
  FNotes := '';
  FSystemUser.Reset;
  //FItemDetail_Arr.Clear;
  //FCashierInvoice_Arr.Clear;
  //FSaleDetail_Arr.Clear;
  //FDebt_Arr.Clear;
  //FIncomeExpense_Arr.Clear;
end;

procedure _SystemReversal.InsertOnDB;
begin
  try ExecSQL(
    'INSERT INTO System_Reversal (Revers_Date,Notes,User_Id)'+
    ' VALUES ('+
      FormatSQLDate(FReversDate)+','+
      FormatSQLString(FNotes)+','+
      FormatSQLString(FSystemUser.UserId)+')'
  ); except raise; end;
end;

procedure _SystemReversal.UpdateOnDB;
begin
  try ExecSQL(
    'UPDATE System_Reversal SET'+
          ' Revers_Date='+FormatSQLDate(FReversDate)+','+
          ' Notes='+FormatSQLString(FNotes)+','+
          ' User_Id='+FormatSQLString(FSystemUser.UserId)+
    ' WHERE Revers_Seq='+FormatSQLNumber(FReversSeq)
  ); except raise; end;
end;

procedure _SystemReversal.DeleteOnDB;
begin
  try ExecSQL(
    'DELETE FROM System_Reversal'+
    ' WHERE Revers_Seq='+FormatSQLNumber(FReversSeq)
  ); except raise; end;
end;

function _SystemReversal.SelectInDB(AReversSeq: integer): boolean;
var buffer: TMysqlResult;
begin
  buffer := OpenSQL(
    'SELECT SR.Revers_Seq, SR.Revers_Date, SR.Notes'+
     ' FROM System_Reversal SR, System_Users SU'+
    ' WHERE SR.Revers_Seq='+FormatSQLNumber(AReversSeq)
  );
  if (buffer.RecordCount<>0) then begin
    FReversSeq := BufferToInteger(buffer.FieldValue(0));
    FReversDate := BufferToDateTime(buffer.FieldValue(1));
    FNotes := BufferToString(buffer.FieldValue(2));
  end;
  Result := (buffer.RecordCount<>0);
  buffer.Destroy;
end;

class function _SystemReversal.ExistInDB(AReversSeq: integer): integer;
var buffer: TMysqlResult;
begin
  buffer := OpenSQL(
    'SELECT COUNT(*) FROM System_Reversal'+
    ' WHERE Revers_Seq='+FormatSQLNumber(AReversSeq)
  );
  Result := BufferToInteger(buffer.FieldValue(0));
  buffer.Destroy;
end;


{ _SystemMenu_Arr }

constructor _SystemMenu_Arr.Create;
begin
  inherited Create;
  setLength(FSystemMenu_Arr,0);
end;

destructor _SystemMenu_Arr.Destroy;
begin
  Self.Clear;
  inherited;
end;

procedure _SystemMenu_Arr.Clear;
var i: integer;
begin
  for i:=0 to high(FSystemMenu_Arr) do FSystemMenu_Arr[i].Destroy;
  setLength(FSystemMenu_Arr,0);
end;

function _SystemMenu_Arr.New: _SystemMenu;
begin
  Result := _SystemMenu.Create;
end;

function _SystemMenu_Arr.Add(AMenuId: integer; AMenuGroup, AMenuName: string; AImageIndex: integer;
AFormName: string; AFormType: integer; AShortcut, ASubmenuName,
AMenuNameEng, AImageDefault, AImageShort, AImageActive:string): integer;
begin
  setLength(FSystemMenu_Arr, length(FSystemMenu_Arr)+1);
  Result := high(FSystemMenu_Arr);
  FSystemMenu_Arr[Result] := New;
  FSystemMenu_Arr[Result].MenuId := AMenuId;
  FSystemMenu_Arr[Result].MenuGroup := AMenuGroup;
  FSystemMenu_Arr[Result].MenuName := AMenuName;
  FSystemMenu_Arr[Result].ImageIndex := AImageIndex;
  FSystemMenu_Arr[Result].FormName := AFormName;
  FSystemMenu_Arr[Result].FormType := AFormType;
  FSystemMenu_Arr[Result].Shortcut := AShortcut;
  FSystemMenu_Arr[Result].SubMenuName := ASubmenuName;
  FSystemMenu_Arr[Result].MenuNameEng := AMenuNameEng;
  FSystemMenu_Arr[Result].ImageDefault := AImageDefault;
  FSystemMenu_Arr[Result].ImageShort := AImageShort;
  FSystemMenu_Arr[Result].ImageActive := AImageActive;

end;

function _SystemMenu_Arr.IndexOf(AMenuId: integer): integer;
var i: integer; found: boolean;
begin
  i := 0; found := false;
  while (i<=high(FSystemMenu_Arr)) and (not found) do
    if (FSystemMenu_Arr[i].FMenuId=AMenuId)
    then
      found := true
    else inc(i);
  if (found) then
    Result := i
  else
    Result := -1;
end;

procedure _SystemMenu_Arr.Delete(Index: integer);
var i: integer;
begin
  if (Index<0) or (Index>high(FSystemMenu_Arr)) then Exit;
  FSystemMenu_Arr[Index].Destroy;
  for i:=Index to high(FSystemMenu_Arr)-1 do
    FSystemMenu_Arr[Index] := FSystemMenu_Arr[Index-1];
  setLength(FSystemMenu_Arr,length(FSystemMenu_Arr)-1);
end;

function _SystemMenu_Arr.Count: integer;
begin
  Result := length(FSystemMenu_Arr);
end;

function _SystemMenu_Arr.Get(Index: integer): _SystemMenu;
begin
  if (Index<0) or (Index>high(FSystemMenu_Arr)) then Result := nil
  else Result := FSystemMenu_Arr[Index];
end;

function _SystemMenu_Arr.FindOnDB(AMenuId: integer = 0; AMenuGroup: string = ''; AMenuName: string = ''; AImageIndex: integer = 0; AFormName: string = ''; AFormType: integer = 0; AShortcut: integer = 0;aDeptID:string=''): integer;
var sql, filter: string; buffer: TMysqlResult; i: integer;
begin
  Self.Clear;
  sql := 'SELECT ... FROM ... ';
  filter := '';
  if (AMenuId<>0) then filter := filter + ' AND SM.MenuId='+FormatSQLNumber(AMenuId);
  if (AMenuGroup<>'') then filter := filter + ' AND SM.MenuGroup='+FormatSQLString(AMenuGroup);
  if (AMenuName<>'') then filter := filter + ' AND SM.MenuName='+FormatSQLString(AMenuName);
  if (AImageIndex<>0) then filter := filter + ' AND SM.ImageIndex='+FormatSQLNumber(AImageIndex);
  if (AFormName<>'') then filter := filter + ' AND SM.FormName='+FormatSQLString(AFormName);
  if (AFormType<>0) then filter := filter + ' AND SM.FormType='+FormatSQLNumber(AFormType);
  if (AShortcut<>0) then filter := filter + ' AND SM.Shortcut='+FormatSQLNumber(AShortcut);
  if (filter<>'') then filter := copy(filter,6,length(filter)-5) + ' WHERE ';
  buffer := OpenSQL(sql+filter);
  setLength(FSystemMenu_Arr, buffer.RecordCount);
  for i:=0 to buffer.RecordCount-1 do begin
    FSystemMenu_Arr[i] := _SystemMenu.Create;
    Self.Add(BufferToInteger(buffer.FieldValue(0)),BufferToString(buffer.FieldValue(1)),
        BufferToString(buffer.FieldValue(2)),BufferToInteger(buffer.FieldValue(3)),
        BufferToString(buffer.FieldValue(4)),BufferToInteger(buffer.FieldValue(5)),
        BufferToString(buffer.FieldValue(6)),BufferToString(buffer.FieldValue(7)),
        BufferToString(buffer.FieldValue(8)));
    buffer.MoveNext;
  end;
  Result := buffer.RecordCount;
  buffer.Destroy;
end;


{ _SystemMenu }

constructor _SystemMenu.Create;
begin
  inherited Create;
end;

destructor _SystemMenu.Destroy;
begin
  inherited;
end;

procedure _SystemMenu.Reset;
begin
  FMenuId := 0;
  FMenuGroup := '';
  FMenuName := '';
  FImageIndex := 0;
  FFormName := '';
  FFormType := 0;
  FShortcut := '';
  FSubMenuName := '';
  FDeptID := '';
  FMenuNameEng := '';
  FImageDefault := '';
  FImageShort := '';
  FImageActive := '';
end;

procedure _SystemMenu.InsertOnDB;
begin
  try ExecSQL(
    'INSERT INTO System_Menu (Menu_Id,Menu_Group,Menu_Name,Image_Index,Form_Name,Form_Type,Shortcut'+
    ' VALUES ('+
      FormatSQLNumber(FMenuId)+','+
      FormatSQLString(FMenuGroup)+','+
      FormatSQLString(FMenuName)+','+
      FormatSQLNumber(FImageIndex)+','+
      FormatSQLString(FFormName)+','+
      FormatSQLNumber(FFormType)+','+
      FormatSQLString(FShortcut)+')'
  ); except raise; end;
end;

procedure _SystemMenu.UpdateOnDB;
begin
  try ExecSQL(
    'UPDATE System_Menu SET'+
          ' Menu_Group='+FormatSQLString(FMenuGroup)+','+
          ' Menu_Name='+FormatSQLString(FMenuName)+','+
          ' Image_Index='+FormatSQLNumber(FImageIndex)+','+
          ' Form_Name='+FormatSQLString(FFormName)+','+
          ' Form_Type='+FormatSQLNumber(FFormType)+','+
          ' Shortcut='+FormatSQLString(FShortcut)+
    ' WHERE Menu_Id='+FormatSQLNumber(FMenuId)
  ); except raise; end;
end;

procedure _SystemMenu.DeleteOnDB;
begin
  try ExecSQL(
    'DELETE FROM System_Menu'+
    ' WHERE Menu_Id='+FormatSQLNumber(FMenuId)
  ); except raise; end;
end;

function _SystemMenu.SelectInDB(AMenuId: integer): boolean;
var buffer: TMysqlResult;
begin
  buffer := OpenSQL(
    'SELECT SM.Menu_Id, SM.Menu_Group, SM.Menu_Name, SM.Image_Index, SM.Form_Name, SM.Form_Type, SM.Shortcut,SM.Submenu_Name'+
      ',SM.menu_name_eng, image_default, image_sort, image_active '+
     ' FROM System_Menu SM'+
    ' WHERE SM.Menu_Id='+FormatSQLNumber(AMenuId)
  );
  if (buffer.RecordCount<>0) then begin
    FMenuId := BufferToInteger(buffer.FieldValue(0));
    FMenuGroup := BufferToString(buffer.FieldValue(1));
    FMenuName := BufferToString(buffer.FieldValue(2));
    FImageIndex := BufferToInteger(buffer.FieldValue(3));
    FFormName := BufferToString(buffer.FieldValue(4));
    FFormType := BufferToInteger(buffer.FieldValue(5));
    FShortcut := BufferToString(buffer.FieldValue(6));
    FSubMenuName := BufferToString(buffer.FieldValue(7));
    FMenuNameEng := BufferToString(buffer.FieldValue(8));
    FImageDefault := BufferToString(buffer.FieldValue(9));
    FImageShort := BufferToString(buffer.FieldValue(10));
    FImageActive := BufferToString(buffer.FieldValue(11));
  end;
  Result := (buffer.RecordCount<>0);
  buffer.Destroy;
end;

class function _SystemMenu.ExistInDB(AMenuId: integer): integer;
var buffer: TMysqlResult;
begin
  buffer := OpenSQL(
    'SELECT COUNT(*) FROM System_Menu'+
    ' WHERE Menu_Id='+FormatSQLNumber(AMenuId)
  );
  Result := BufferToInteger(buffer.FieldValue(0));
  buffer.Destroy;
end;

{ _SystemAccess_Arr }

constructor _SystemAccess_Arr.Create;
begin
  inherited;
  SetLength(FSystemAccess_Arr,0);
end;

destructor _SystemAccess_Arr.Destroy;
begin
  Self.Clear;
  inherited;
end;

procedure _SystemAccess_Arr.Clear;
var i: integer;
begin
  for i:=0 to high(FSystemAccess_Arr) do FSystemAccess_Arr[i].Destroy;
  setLength(FSystemAccess_Arr,0);
end;

function _SystemAccess_Arr.New: _SystemAccess;
begin
  Result := _SystemAccess.Create;
end;

function _SystemAccess_Arr.Add(AUserId: string; AMenuId, AAccessList, AShortcut: integer; AOutlookPanel, AOutlookButton: string; AUsageCount: integer): integer;
begin
  setLength(FSystemAccess_Arr, length(FSystemAccess_Arr)+1);
  Result := high(FSystemAccess_Arr);
  FSystemAccess_Arr[Result] := New;
  FSystemAccess_Arr[Result].SystemUser.UserId := AUserId;
  FSystemAccess_Arr[Result].SystemMenu.MenuId := AMenuId;
  FSystemAccess_Arr[Result].AccessList := AAccessList;
  FSystemAccess_Arr[Result].OutlookPanel := AOutlookPanel;
  FSystemAccess_Arr[Result].OutlookButton := AOutlookButton;
  FSystemAccess_Arr[Result].UsageCount := AUsageCount;
end;

function _SystemAccess_Arr.IndexOf(AUserId: string; AMenuId: integer): integer;
var i: integer;
begin
  i := 0; Result := -1;
  while (i<=high(FSystemAccess_Arr)) and (Result=-1) do
    if (FSystemAccess_Arr[i].SystemUser.UserId=AUserId) and
      (FSystemAccess_Arr[i].SystemMenu.MenuId=AMenuId) then
      Result := i
    else inc(i);
end;

procedure _SystemAccess_Arr.Delete(Index: integer);
var i: integer;
begin
  if (Index<0) or (Index>high(FSystemAccess_Arr)) then Exit;
  FSystemAccess_Arr[Index].Destroy;
  for i:=Index to high(FSystemAccess_Arr)-1 do
    FSystemAccess_Arr[Index] := FSystemAccess_Arr[Index-1];
  setLength(FSystemAccess_Arr,length(FSystemAccess_Arr)-1);
end;

function _SystemAccess_Arr.Count: integer;
begin
  Result := length(FSystemAccess_Arr);
end;

function _SystemAccess_Arr.Get(Index: integer): _SystemAccess;
begin
  if (Index<0) or (Index>high(FSystemAccess_Arr)) then Result := nil
  else Result := FSystemAccess_Arr[Index];
end;


{ _SystemAccess }

constructor _SystemAccess.Create;
begin
  inherited Create;
  FSystemUser := _SystemUser.Create;
  FSystemMenu := _SystemMenu.Create;
end;

destructor _SystemAccess.Destroy;
begin
  FSystemUser.Destroy;
  FSystemMenu.Destroy;
  inherited;
end;

procedure _SystemAccess.Reset;
begin
  FSystemUser.Reset;
  FSystemMenu.Reset;
  FAccessList := 0;
  FOutlookPanel := '';
  FOutlookButton := '';
  FUsageCount := 0;
  FCanAcces  := 0;
end;

procedure _SystemAccess.InsertOnDB;
begin
  try ExecSQL(
    'INSERT INTO System_Access (User_Id,Menu_Id,Access_List,Outlook_Panel,Outlook_Button,'+
    'Usage_Count, can_acces,can_add,can_edit,can_delete,can_view,can_print)'+
    ' VALUES ('+
      FormatSQLString(FSystemUser.UserId)+','+
      FormatSQLNumber(FSystemMenu.MenuId)+','+
      FormatSQLNumber(FAccessList)+','+
      FormatSQLString(FOutlookPanel)+','+
      FormatSQLString(FOutlookButton)+','+
      FormatSQLNumber(FUsageCount)+','+
      FormatSQLNumber(FCanAcces)+','+
      FormatSQLNumber(FCanAdd)+','+
      FormatSQLNumber(FCanEdit)+','+
      FormatSQLNumber(FCanDelete)+','+
      FormatSQLNumber(FCanView)+','+
      FormatSQLNumber(FCanPrint)+')'
  ); except raise; end;
end;

procedure _SystemAccess.UpdateOnDB;
begin
  try ExecSQL(
    'UPDATE System_Access SET'+
          ' Access_List='+FormatSQLNumber(FAccessList)+','+
          ' Outlook_Panel='+FormatSQLString(FOutlookPanel)+','+
          ' Outlook_Button='+FormatSQLString(FOutlookButton)+','+
          ' Usage_Count='+FormatSQLNumber(FUsageCount)+','+
          ' Can_Acces ='+FormatSQLNumber(FCanAcces)+','+
          ' Can_Add ='+FormatSQLNumber(FCanAdd)+','+
          ' Can_edit ='+FormatSQLNumber(FCanEdit)+','+
          ' Can_delete ='+FormatSQLNumber(FCanDelete)+','+
          ' Can_view ='+FormatSQLNumber(FCanView)+','+
          ' Can_print ='+FormatSQLNumber(FCanPrint)+
    ' WHERE User_Id='+FormatSQLString(FSystemUser.UserId)+
      ' AND Menu_Id='+FormatSQLNumber(FSystemMenu.MenuId)
  ); except raise; end;
end;

procedure _SystemAccess.DeleteOnDB;
begin
  try ExecSQL(
    'DELETE FROM System_Access'+
    ' WHERE User_Id='+FormatSQLString(FSystemUser.UserId)+
      ' AND Menu_Id='+FormatSQLNumber(FSystemMenu.MenuId)
  ); except raise; end;
end;


{ TSystemConstant }
type stringArr = array of string;

function GetPrivateProfileStringFromDB(const Section, Name, Default: PChar; var BufOut: stringArr; TableName: string): integer;
var buffer: TMysqlResult; i: integer;
begin
  if (Section<>nil) then begin
    if (Name<>nil) then begin
      if (Default<>nil) then begin
        //Read String
        buffer := OpenSQL(
          'SELECT Nilai FROM '+TableName+
          ' WHERE Seksi='+FormatSQLString(Section)+' AND Nama='+FormatSQLString(Name)
        );
        setLength(BufOut,1);
        if (buffer.RecordCount=0) then BufOut[0] := Default
        else BufOut[0] := BufferToString(buffer.FieldValue(0));
        Result := Length(BufOut[0]);
        buffer.Destroy;
      end else begin
        //Read Section
        buffer := OpenSQL(
          'SELECT Nama, Nilai FROM '+TableName+
          ' WHERE Seksi='+FormatSQLString(string(Section))
        );
        setLength(BufOut,buffer.RecordCount);
        for i:=1 to buffer.RecordCount do begin
          BufOut[i-1] := BufferToString(buffer.FieldValue(0))+'='+BufferToString(buffer.FieldValue(1));
          buffer.MoveNext;
        end;
        Result := buffer.RecordCount;
        buffer.Destroy;
      end;
    end else begin
      //Read Section
      buffer := OpenSQL(
        'SELECT Nama FROM '+TableName+
        ' WHERE Seksi='+FormatSQLString(string(Section))
      );
      setLength(BufOut,buffer.RecordCount);
      for i:=1 to buffer.RecordCount do begin
        BufOut[i-1] := BufferToString(buffer.FieldValue(0));
        buffer.MoveNext;
      end;
      Result := buffer.RecordCount;
      buffer.Destroy;
    end;
  end else begin
    //Read Sections
    buffer := OpenSQL(
      'SELECT DISTINCT(Seksi) FROM '+TableName
    );
    setLength(BufOut,buffer.RecordCount);
    for i:=1 to buffer.RecordCount do begin
      BufOut[i-1] := BufferToString(buffer.FieldValue(0));
      buffer.MoveNext;
    end;
    Result := buffer.RecordCount;
    buffer.Destroy;
  end;
end;

function WritePrivateProfileStringToDB(const Section, Name, Default: PChar; TableName: string): boolean;
var sql: string; buffer: TMysqlResult;
begin
  if (Section<>nil) then begin
    if (Name<>nil) then begin
      if (Default<>nil) then begin
        buffer := OpenSQL(
          'SELECT Nilai FROM '+TableName+
          ' WHERE Seksi='+FormatSQLString(string(Section))+' AND Nama='+FormatSQLString(string(Name)));
        if (buffer.RecordCount<>0) then
          if (BufferToString(buffer.FieldValue(0))=Default) then begin
            Result := true;
            Exit;
          end else sql := // WriteString
          'UPDATE '+TableName+' SET Nilai='+FormatSQLString(string(Default))+
          ' WHERE Seksi='+FormatSQLString(string(Section))+' AND Nama='+FormatSQLString(string(Name))
        else sql := // WriteString
          'INSERT INTO '+TableName+' (Seksi,Nama,Nilai) VALUES ('+
          FormatSQLString(string(Section))+','+FormatSQLString(string(Name))+','+FormatSQLString(string(Default))+')'
      end else sql := // DeleteKey
        'DELETE FROM '+TableName+
        ' WHERE Seksi='+FormatSQLString(string(Section))+' AND Nama='+FormatSQLString(string(Name));
    end else sql := // EraseSection
      'DELETE FROM '+TableName+
      ' WHERE Seksi='+FormatSQLString(string(Section));
  end else begin //flush
    Result := true;
    Exit;
  end;

  Result := (ExecSQL(sql)>0);
end;

destructor TSystemConstant.Destroy;
begin
  UpdateFile;         // flush changes to disk
  inherited Destroy;
end;

function TSystemConstant.ReadString(const Section, Name, Default: string): string;
var Buffer: stringArr;
begin
  GetPrivateProfileStringFromDB(PChar(Section), PChar(Name), PChar(Default), Buffer, FileName);
  Result := Buffer[0];
  setLength(Buffer,0);
end;

procedure TSystemConstant.WriteString(const Section, Name, Content: string);
begin
  if not WritePrivateProfileStringToDB(PChar(Section), PChar(Name), PChar(Content), FileName) then
    raise EIniFileException.CreateResFmt(@SIniFileWriteError, [FileName]);
end;

procedure TSystemConstant.ReadSections(Strings: TStrings);
var Buffer: stringArr; i: integer;
begin
  Strings.BeginUpdate;
  try
    Strings.Clear;
    if GetPrivateProfileStringFromDB(nil, nil, nil, Buffer, FileName) <> 0 then
    begin
      for i:=0 to high(Buffer) do
        Strings.Append(Buffer[i]);
    end;
  finally
    Strings.EndUpdate;
  end;
end;

procedure TSystemConstant.ReadSection(const Section: string; Strings: TStrings);
var Buffer: stringArr; i: integer;
begin
  Strings.BeginUpdate;
  try
    Strings.Clear;
    if GetPrivateProfileStringFromDB(PChar(Section), nil, nil, Buffer, FileName) <> 0 then
    begin
      for i:=0 to high(Buffer) do
        Strings.Append(Buffer[i]);
    end;
  finally
    Strings.EndUpdate;
  end;
end;

procedure TSystemConstant.ReadSectionValues(const Section: string; Strings: TStrings);
var Buffer: stringArr; i: integer;
begin
  Strings.BeginUpdate;
  try
    Strings.Clear;
    if GetPrivateProfileStringFromDB(PChar(Section), PChar('Name'), nil, Buffer, FileName) <> 0 then
    begin
      for i:=0 to high(Buffer) do
        Strings.Append(Buffer[i]);
    end;
  finally
    Strings.EndUpdate;
  end;
end;

procedure TSystemConstant.EraseSection(const Section: string);
begin
  if not WritePrivateProfileStringToDB(PChar(Section), nil, nil, FileName) then
    raise EIniFileException.CreateResFmt(@SIniFileWriteError, [FileName]);
end;

procedure TSystemConstant.DeleteKey(const Section, Name: String);
begin
  WritePrivateProfileStringToDB(PChar(Section), PChar(Name), nil, FileName);
end;

procedure TSystemConstant.UpdateFile;
begin
  WritePrivateProfileStringToDB(nil, nil, nil, FileName);
end;

function TSystemConstant.ReadChar(const Section, Name: string; const Default: char): char;
var CharStr: string;
begin
  CharStr := ReadString(Section, Name, '');
  Result := Default;
  if CharStr <> '' then
    Result := CharStr[1]
end;

procedure TSystemConstant.WriteChar(const Section, Name: string; const Content: char);
begin
  WriteString(Section, Name, Content);
end;

function getNextIDNum(fieldName:string;tableName:string;condition:String;prefix:string;reversedOrderNum:string='';minlength:integer=5):string;
var sql:string;buffer:TMysqlResult;code:string; codeNum:integer;codeChar:Char; cond: string;
begin
  if reversedOrderNum <> '' then begin
    //get the last character in the number if it is non-number
    codeChar := (copy(reversedOrderNum,length(reversedOrderNum)-1,1))[1];
    if StrToIntDef(codeChar,0) = 0 then begin//if not-number then
      inc(codeChar);
      result := reversedOrderNum + codeChar;
    end else //if number than append 'a'
      result := reversedOrderNum + 'a';
  end else begin
    sql := 'SELECT MAX('+fieldName+') FROM '+tableName;
    cond := '';
    if condition <> '' then
      cond := cond + ' AND ' + copy(condition,5,length(condition));
    if prefix <> '' then
      cond := cond + ' AND ' + fieldname + ' LIKE ' + FormatSQLString(prefix+'%');
    if cond <> '' then begin
      delete(cond,1,5);
      sql := sql + ' WHERE ' + cond;
    end;
    buffer := OpenSQL(sql);
    if buffer.RecordCount > 0 then begin
      code := BufferToString(buffer.FieldValue(0));

      //cut off the prefix the last digit if it is a character
      code := copy(code,length(prefix)+1,length(code)-length(prefix));
      code := EkstrakString(code,'/',1);
      codeNum := StrToIntDef(code,0);
      inc(codeNum);
      result := prefix+IntToStrFixed(minlength,codeNum);
    end else
      result := prefix+IntToStrFixed(minlength,1);
    buffer.Destroy;
  end;
end;


{ TSystemUser }

class procedure TSystemUser.AccessLevelList(var ATarget: TStringList);
begin
  ATarget.Clear;
  ATarget.Add(IntToStr(LEVEL_OPERATOR) + '=Operator' );
  ATarget.Add(IntToStr(LEVEL_SUPERVISOR) + '=Supervisor');
  ATarget.Add(IntToStr(LEVEL_MANAGER) + '=Manager');
  ATarget.Add(IntToStr(LEVEL_ADMIN) + '=Admin');
  ATarget.Add(IntToStr(LEVEL_OWNER) + '=Owner');
  ATarget.Add(IntToStr(LEVEL_DEVELOPER) + '=Developer');
end;

class function TSystemUser.IsExistInDB(userID: string): boolean;
var buffer: TMysqlResult;
begin
  buffer := OpenSQL(
    'SELECT COUNT(*) FROM System_Users'+
    ' WHERE User_ID = ' + FormatSQLString(userID)
  );
  Result := (BufferToInteger(buffer.FieldValue(0))<>0);
  buffer.Destroy;
end;

class function TSystemUser.UserIDAlreadyRegistered(UserID: String): boolean;
var buffer: TMysqlResult;
begin
  buffer := OpenSQL(
    'SELECT COUNT(*) FROM System_Users WHERE User_ID=' + FormatSQLString(UserID)
  );
  Result := (BufferToInteger(buffer.FieldValue(0))<>0);
  buffer.Destroy;
end;

procedure TSystemUser.UpdatePasswordOnDB;
begin
  try ExecSQL(
    'UPDATE System_Users'+
      ' SET Passwd='+FormatSQLString(FPasswd)+
    ' WHERE User_Id='+FormatSQLString(FUserId)
  ); except raise; end;
end;

function TSystemUser.getDisable: boolean;
begin
  result := DisableDate <> 0;
end;

procedure TSystemUser.setDisable(const Value: boolean);
var sql: string;
begin
  sql:= 'UPDATE System_Users Set Disabled_Date = '+IfThen(value,FormatSQLDate(0),FormatSQLDate(ServerNow))+
                       ' WHERE User_ID='+FormatSQLString(FUserId);
  ExecSQL(sql);
//  ExecSQL('UPDATE System_User Set Disabled_Date = '+IfThen(value,FormatSQLDate(now),FormatSQLDate(0))+
  //                     ' WHERE User_ID='+FormatSQLString(FUserId));
end;

procedure TSystemUser.InsertOnDB;
begin
  try ExecSQL(
    'INSERT INTO System_Users (User_Id,User_Name,Passwd,Access_Level) '+//
    ' VALUES ('+
      FormatSQLString(FUserId)+','+
      FormatSQLString(FUserName)+','+
       FormatSQLString(FPasswd)+', '+
      FormatSQLNumber(FAccessLevel)+')'
  ); except raise; end;
end;

procedure TSystemUser.UpdateOnDB;
var sql : string;
begin
  sql := 'UPDATE System_Users SET'+
          ' User_Name='+FormatSQLString(FUserName)+','+
          ' passwd='+FormatSQLString(FPasswd)+','+
          ' Access_Level='+FormatSQLNumber(FAccessLevel)+
    ' WHERE User_Id='+FormatSQLString(FUserId);
  try ExecSQL(sql);
  except raise;
  end;
end;

class procedure TSystemUser.Activation(AUserId: string; AStatus: integer);
var sqL: string;
begin
  sqL:= 'update system_users set '+
  'disabled_date = '+IfThen(AStatus = TRUE_VALUE, 'null ', 'curdate() ')+
  'where user_id = '+FormatSQLString(AUserId);
  ExecSQL(sqL);
end;

procedure TSystemUser.UpdatePasswordOnDBX;
begin
  try ExecSQL(
    'UPDATE System_Users'+
      ' SET Passwd= password('+FormatSQLString(FPasswd)+')'+
    ' WHERE User_Id='+FormatSQLString(FUserId)
  ); except raise; end;
end;

procedure TSystemUser.InsertOnDBX;
begin
  try ExecSQL(
    'INSERT INTO System_Users (User_Id, User_Name, Passwd, Access_Level) '+//
    ' VALUES ('+
      FormatSQLString(FUserId)+','+
      FormatSQLString(FUserName)+','+
      FormatSQLString(FPasswd)+', '+
      FormatSQLNumber(FAccessLevel)+')'
  ); except raise; end;

end;

procedure TSystemUser.UpdateOnDBX;
var sql : string;
begin
  sql := 'UPDATE System_Users SET'+
          ' User_Name='+FormatSQLString(FUserName)+','+
//          ' passwd='+FormatSQLString(FPasswd)+','+
          ' Access_Level='+FormatSQLNumber(FAccessLevel)+
    ' WHERE User_Id='+FormatSQLString(FUserId);
  try ExecSQL(sql);
  except raise;
  end;


end;

{ TSystemUser_Arr }

procedure TSystemUser_Arr.FindOnDB(LoginID, LoginName: string;
  AccessLevel: integer;status:boolean;Dept:string);
var sqlstring,filter:string;buffer:TMysqlResult;i:integer;
begin
  sqlString := 'SELECT User_ID,User_Name,Passwd,Access_Level, Disabled_Date' +
                ' FROM System_Users ';

  filter := '';
  filter := IfThen(status,' AND Disabled_Date IS NULL ','');
  if LoginID <> '' then
    filter := filter + ' AND User_ID = ' + FormatSQLString(LoginID);
  if LoginName <> '' then
    filter := filter + ' AND User_Name LIKE ' + FormatSQLString('%' + LoginName + '%');
  if AccessLevel >= 0 then
    filter := filter + ' AND Access_Level < ' + FormatSQLNumber(AccessLevel);
  if filter <> '' then
    sqlstring := sqlstring +' WHERE '+ copy(filter,5,length(filter));

  buffer := OpenSQL(sqlString);
  if buffer.RecordCount > 0 then begin
    for i := 0 to buffer.RecordCount-1 do begin
      add(bufferToString(buffer.FieldValue(0)),bufferToString(buffer.FieldValue(1)),
                        bufferToString(buffer.FieldValue(2)),
                        bufferToInteger(buffer.FieldValue(3)),
                        BufferToDateTime(buffer.FieldValue(4)));
      buffer.MoveNext;
    end;
  end
end;

function TSystemUser_Arr.Get(Index: integer): TSystemUser;
begin
  result := TSystemUser(inherited get(Index));
end;

function TSystemUser_Arr.New: _SystemUser;
begin
  result := TSystemUser.Create;
end;

{ TSystemMenu }

function TSystemMenu.GetFormType: TFormType;
begin
  Result := TFormType(FFormType);
end;

procedure TSystemMenu.SetFormType(const Value: TFormType);
begin
  FFormType := integer(Value);
end;

function TSystemMenu.GetShortcut: TShortcut;
begin
  //Result := TShortcut(FShortcut);
  Result :=  TShortcut(0);
end;

procedure TSystemMenu.SetShortcut(const Value: TShortcut);
begin
 // FShortcut := Integer(Value);
end;

class function TSystemMenu.getFormName(AMenuID: integer): string;
begin
  Result:= getStringFromSQL('select form_name from system_menu where menu_id =  '+FormatSQLNumber(AMenuID)) ;
end;

class function TSystemMenu.getMenuName(AMenuID: integer): string;
begin
  Result:= getStringFromSQL('select menu_name from system_menu where menu_id =  '+FormatSQLNumber(AMenuID)) ;
end;

class function TSystemMenu.getMenuNameEng(AMenuID: integer): string;
begin
  Result:= getStringFromSQL('select menu_name_eng from system_menu where menu_id =  '+FormatSQLNumber(AMenuID)) ;
end;

{ TSystemMenu_Arr }

function TSystemMenu_Arr.New: _SystemMenu;
begin
  Result := TSystemMenu.Create;
end;

function TSystemMenu_Arr.Get(Index: integer): TSystemMenu;
begin
  Result := TSystemMenu(inherited Get(Index));
end;

procedure TSystemMenu_Arr.LoadFromDB(AShowHidden:TBooleanOperator=boNone; ADeptId: integer=0);
var buffer: TMysqlResult; i: integer; order, sql, filter:string;
begin
  Self.Clear;
  if AShowHidden <> boNone then
    filter := filter + IfThen(AShowHidden=boFalse,' and ((hide <> -1) or (hide is null))');

  filter := filter + ' and ((dept_id = '+FormatSQLNumber(ADeptId)+') or (dept_id is null))';
  if filter <> '' then
    filter:= ' where ' + copy(filter, 5, length(filter));
  sql:=
    'select menu_id, menu_group, menu_name, image_index, form_name, form_type, shortcut, submenu_name '+
    ', menu_name_eng, image_default, image_sort, image_active '+
    'from system_menu ';

  order := ' order by menu_id';
  buffer := OpenSQL(sql + filter + order);
  for i:=0 to buffer.RecordCount-1 do begin
    Self.Add(
      BufferToInteger(buffer.FieldValue(0)),
      BufferToString(buffer.FieldValue(1)),
      BufferToString(buffer.FieldValue(2)),
      BufferToInteger(buffer.FieldValue(3)),
      BufferToString(buffer.FieldValue(4)),
      BufferToInteger(buffer.FieldValue(5)),
      BufferToString(buffer.FieldValue(6)),
      BufferToString(buffer.FieldValue(7)),
      BufferToString(buffer.FieldValue(8)),
      BufferToString(buffer.FieldValue(9)),
      BufferToString(buffer.FieldValue(10)),
      BufferToString(buffer.FieldValue(11)));
    buffer.MoveNext;
  end;
  buffer.Destroy;
end;

function TSystemMenu_Arr.GetByMenuID(AMenuID: integer): TSystemMenu;
var i: integer;
begin
  Result := nil;  i:=0;
  while (i<=high(FSystemMenu_Arr)) and (Result=nil) do begin
    if (FSystemMenu_Arr[i].MenuId=AMenuID) then
      Result := TSystemMenu(FSystemMenu_Arr[i]);
    inc(i);
  end;
end;

function TSystemMenu_Arr.FindInDB(menu_id: integer; menu_group,
  menu_name: string; image_index: integer; form_name: string;
  form_type, shortcut: integer): boolean;
var sql,filter:string;buffer:TMysqlResult;i:integer;
begin
  result := false;
  sql := 'SELECT menu_id,menu_group,menu_name,image_index,form_name,form_type,shortcut,Submenu_name'+
        ',Menu_Name_eng '+
          ' FROM System_Menu';
  filter := '';
  if menu_id > 0 then
    filter := filter + ' AND menu_id = '+FormatSQLNumber(menu_id);
  if menu_group <> '' then
    filter := filter + ' AND menu_group LIKE ' + FormatSQLString('%'+menu_group+'%');
  if menu_name <> '' then
    filter := filter + ' AND menu_name LIKE ' + FormatSQLString('%'+menu_name+'%');
  if image_index <> -1 then
    filter := filter + ' AND image_index = ' + FormatSQLNumber(image_index);
  if form_name <> '' then
    filter := filter + ' AND form_name LIKE ' + FormatSQLString('%'+form_name+'%');
  if form_type > 0 then
    filter := filter + ' AND form_type = ' + FormatSQLNumber(form_type);
  if shortcut > 0 then
    filter := filter + ' AND shortcut = ' + FormatSQLNumber(shortcut);
  if filter <> '' then
    filter := ' WHERE ' + copy(filter,5,length(filter));
  buffer := OpenSQL(sql + filter);
  if buffer.RecordCount > 0 then begin
    for i:=0 to buffer.RecordCount-1 do begin
      Add(BufferToInteger(buffer.FieldValue(0)),
          BufferToString(buffer.FieldValue(1)),
          BufferToString(buffer.FieldValue(2)),
          BufferToInteger(buffer.FieldValue(3)),
          BufferToString(buffer.FieldValue(4)),
          BufferToInteger(buffer.FieldValue(5)),
          BufferToString(buffer.FieldValue(6)),
          BufferToString(buffer.FieldValue(7)),
          BufferToString(buffer.FieldValue(8)));
      buffer.MoveNext;
    end;
  end;
  buffer.Destroy;
end;

procedure TSystemMenu_Arr.getMenuGroup(var menuArr: TSystemMenu_Arr;
  menu_group: string);
var i:integer;
begin
  menuArr.clear;
  for i:=0 to count-1 do begin
    if FSystemMenu_Arr[i].MenuGroup = menu_group then
      menuArr.Add(FSystemMenu_Arr[i].FMenuId,
                  FSystemMenu_Arr[i].FMenuGroup,
                  FSystemMenu_Arr[i].FMenuName,
                  FSystemMenu_Arr[i].FImageIndex,
                  FSystemMenu_Arr[i].FFormName,
                  FSystemMenu_Arr[i].FFormType,
                  FSystemMenu_Arr[i].FShortcut,
                  FSystemMenu_Arr[i].FSubMenuName,
                  FSystemMenu_Arr[i].FMenuNameEng);
  end;
end;

procedure TSystemMenu_Arr.getMenuGroupList(var aList: TStringList);
var buffer:TMysqlResult;i:integer; X:TSystemMenu_Arr;
begin
  aList.Clear;
  buffer := OpenSQL('SELECT Distinct Menu_Group FROM System_Menu');
  if buffer.RecordCount > 0 then begin
    for i:=0 to buffer.RecordCount-1 do begin
      X := TSystemMenu_Arr.Create;
      aList.Objects[aList.Add(BufferToString(Buffer.FieldValue(0)))] := X;
      Buffer.MoveNext;
    end;
  end;
  buffer.Destroy;
end;

function TSystemMenu_Arr.FindInDB2(aSubMenuName:string=''): boolean;
var sqL,filter: string; buffer:TMysqlResult; i,idx: integer;
begin
  result := false;
  filter := ' and hide <> -1 ';
  sqL := 'SELECT menu_id, menu_name,description FROM System_Menu';
  if aSubMenuName <> '' then
    filter := filter + ' AND UPPER(submenu_name) =  '+ FormatSQLString(UpperCase(aSubMenuName));
  if filter <> '' then
    sqL := sqL +' WHERE '+ copy(filter,5,length(filter));
  buffer := OpenSQL(sqL);
  if buffer.RecordCount > 0 then begin
    for i:=0 to buffer.RecordCount-1 do begin
      idx := Add(BufferToInteger(buffer.FieldValue(0)),
          '',
          BufferToString(buffer.FieldValue(1)),
          0,'', 0, '', '','');
      Self[idx].FDescription := BufferToString(buffer.FieldValue(2));
      buffer.MoveNext;
    end;
  end;
  buffer.Destroy;
end;

{ TSystemAccess }

constructor TSystemAccess.Create(AOwner: TObject);
begin
  inherited Create;
  FSystemUser.Destroy;
  FSystemUser := TSystemUser.Create;
  FSystemMenu.Destroy;
  FSystemMenu := TSystemMenu.Create;

  FOwner := AOwner;
  if (FOwner is TSystemUser) then begin
    FSystemUser.Destroy;
    FSystemUser := (FOwner as TSystemUser);
  end else if (FOwner is TSystemMenu) then begin
    FSystemMenu.Destroy;
    FSystemMenu := (FOwner as TSystemMenu);
  end;
end;

destructor TSystemAccess.Destroy;
begin
  if (FOwner is TSystemUser) then
    FSystemUser := TSystemUser.Create
  else if (FOwner is TSystemMenu) then
    FSystemMenu := TSystemMenu.Create;
  inherited;
end;

procedure TSystemAccess.Reset;
begin
  if (FOwner is TSystemUser) then
    FSystemUser := TSystemUser.Create
  else if (FOwner is TSystemMenu) then
    FSystemMenu := TSystemMenu.Create;

  inherited;

  if (FOwner is TSystemUser) then begin
    FSystemUser.Destroy;
    FSystemUser := (FOwner as TSystemUser);
  end else if (FOwner is TSystemMenu) then begin
    FSystemMenu.Destroy;
    FSystemMenu := (FOwner as TSystemMenu);
  end;
end;

procedure TSystemAccess.IncUsageCount;
begin
  inc(FUsageCount);
end;

procedure TSystemAccess.UpdateUsageCountOnDB;
begin
  try ExecSQL(
    'UPDATE System_Access'+
      ' SET Usage_Count='+FormatSQLNumber(FUsageCount)+
    ' WHERE User_ID='+FormatSQLString(SystemUser.UserID)+
      ' AND Menu_ID='+FormatSQLNumber(SystemMenu.MenuID)
  ); except raise; end;
end;

procedure TSystemAccess.UpdateOutlookOnDB;
begin
  try ExecSQL(
    'UPDATE System_Access'+
      ' SET Outlook_Panel='+FormatSQLString(FOutlookPanel)+
         ', Outlook_Button='+FormatSQLString(FOutlookButton)+
    ' WHERE User_ID='+FormatSQLString(SystemUser.UserID)+
      ' AND Menu_ID='+FormatSQLNumber(SystemMenu.MenuID)
  ); except raise; end;
end;

function TSystemAccess.SelectInDB(AUserID: string; AMenuID: integer): boolean;
var buffer: TMysqlResult;
begin
  buffer := OpenSQL(
    'SELECT User_Id,Menu_Id,Access_List,Outlook_Panel,Outlook_Button,Usage_Count'+
     ' FROM System_Access'+
    ' WHERE User_Id='+FormatSQLString(AUserID)+
      ' AND Menu_Id='+FormatSQLNumber(AMenuID));
  Result := (buffer.RecordCount>0);
  if (Result) then begin
    if not (FOwner is TSystemUser) then
      FSystemUser.FUserId := BufferToString(buffer.FieldValue(0));
    if not (FOwner is TSystemMenu) then
      FSystemMenu.FMenuId := BufferToInteger(buffer.FieldValue(1));
    FAccessList := BufferToInteger(buffer.FieldValue(2));
    FOutlookPanel := BufferToString(buffer.FieldValue(3));
    FOutlookButton := BufferToString(buffer.FieldValue(4));
    FUsageCount := BufferToInteger(buffer.FieldValue(5));
  end;
  buffer.Destroy;
end;

function TSystemAccess.SelectInDB: boolean;
begin
  Result := Self.SelectInDB(FSystemUser.UserId,FSystemMenu.MenuId)
end;

function TSystemAccess.GetAccessList: TAccessListSet;
begin
  Result := [];
  if (FAccessList and  1 =  1) then Include(Result,alInsert);
  if (FAccessList and  2 =  2) then Include(Result,alUpdate);
  if (FAccessList and  4 =  4) then Include(Result,alView);
  if (FAccessList and  8 =  8) then Include(Result,alPrint);
  if (FAccessList and 16 = 16) then Include(Result,alRevers);
//  Result := TAccessListSet(FAccessList);
end;

procedure TSystemAccess.SetAccessList(const Value: TAccessListSet);
begin
  FAccessList := 0;
  if (alInsert in Value) then FAccessList := FAccessList or  1;
  if (alUpdate in Value) then FAccessList := FAccessList or  2;
  if (alView   in Value) then FAccessList := FAccessList or  4;
  if (alPrint  in Value) then FAccessList := FAccessList or  8;
  if (alRevers in Value) then FAccessList := FAccessList or 16;
//  FAccessList := Integer(Value);
end;

function TSystemAccess.GetSystemMenu: TSystemMenu;
begin
  Result := TSystemMenu(FSystemMenu);
end;

function TSystemAccess.GetSystemUser: TSystemUser;
begin
  Result := TSystemUser(FSystemUser);
end;

class function TSystemAccess.IsExisInDB(AUserID: string;
  AMenuID: integer): boolean;
begin
  Result:= getIntegerFromSQL(
  'select count(*) from system_access where menu_id ='+FormatSQLNumber(AMenuID)+
  ' and user_id = '+FormatSQLString(AUserID)) > 0;
end;

class function TSystemAccess.Can_Access(Sender : TForm;AMenuID: integer): boolean;
var sql :string;
begin

  if AMenuID > 0 then
    sql := 'SELECT (can_acces or can_add or can_edit or can_delete or can_view) FROM system_access WHERE menu_id ='+FormatSQLNumber(AMenuID)+
              ' and user_id ='+FormatSQLString(GlobalSystemUser.UserId)
  else
    sql := 'SELECT (can_acces or can_add or can_edit or can_delete or can_view) FROM system_access sa INNER JOIN System_Menu sm '+
          ' ON sa.menu_id = sm.menu_id WHERE form_name ='+FormatSQLString(Sender.Name)+
              ' and user_id ='+FormatSQLString(GlobalSystemUser.UserId);
  Result := getIntegerFromSQL(sql)=1;
  if not Result then
    Result := GlobalSystemUser.AccessLevel > LEVEL_OWNER;
end;

class function TSystemAccess.isCan(CanType, AMenuId: integer): boolean;
var sql :string;
begin

    sql := 'select is_can ('+FormatSQLNumber(CanType)+','+FormatSQLString(GlobalSystemUser.UserId)+
    ','+FormatSQLNumber(AMenuId)+')';
  Result := getIntegerFromSQL(sql)=-1;
  if not Result then
    Result := GlobalSystemUser.AccessLevel > LEVEL_OWNER;
    if Not Result then Alert(MSG_UNAUTHORISED_ACCESS); 
 
end;

{ TSystemAccess_Arr }

constructor TSystemAccess_Arr.Create(AOwner: TObject);
begin
  inherited Create;
  FOwner := AOwner;
  setlength(FIndexUsage_Arr,0);
end;

function TSystemAccess_Arr.New: _SystemAccess;
begin
  Result := TSystemAccess.Create(FOwner);
end;

function TSystemAccess_Arr.Get(Index: integer): TSystemAccess;
begin
  Result := TSystemAccess(inherited Get(Index));
end;

function TSystemAccess_Arr.Add(AUserId: string; AAccessList: TAccessListSet;
  AShortcut: TShortcut; AOutlookPanel, AOutlookButton: string; AUsageCount: integer): integer;
begin
  if not (FOwner is TSystemMenu) then
    raise EAbort.Create('Owner is not _SystemMenu')
  else
    Result := Self.Add(AUserId,(FOwner as _SystemMenu).FMenuId,AAccessList,AShortcut,AOutlookPanel,AOutlookButton,AUsageCount);
end;

function TSystemAccess_Arr.Add(AMenuId: integer; AAccessList: TAccessListSet;
  AShortcut: TShortcut; AOutlookPanel, AOutlookButton: string; AUsageCount: integer): integer;
begin
  if not (FOwner is TSystemUser) then
    raise EAbort.Create('Owner is not _SystemUser')
  else
    Result := Self.Add((FOwner as _SystemUser).FUserId,AMenuId,AAccessList,AShortcut,AOutlookPanel,AOutlookButton,AUsageCount);
end;

function TSystemAccess_Arr.Add(AUserId: string; AMenuId: integer; AAccessList: TAccessListSet;
  AShortcut: TShortcut; AOutlookPanel, AOutlookButton: string; AUsageCount: integer): integer;
begin
  setLength(FSystemAccess_Arr, length(FSystemAccess_Arr)+1);
  Result := high(FSystemAccess_Arr);
  FSystemAccess_Arr[Result] := TSystemAccess(Self.New);
  SystemAccess_Arr[Result].SystemUser.UserId := AUserId;
  SystemAccess_Arr[Result].SystemMenu.MenuId := AMenuId;
  SystemAccess_Arr[Result].AccessList := AAccessList;
  SystemAccess_Arr[Result].OutlookPanel := AOutlookPanel;
  SystemAccess_Arr[Result].OutlookButton := AOutlookButton;
  SystemAccess_Arr[Result].FUsageCount := AUsageCount;
end;

function TSystemAccess_Arr.IndexOf(AUserId: string; AMenuId: integer): integer;
begin
  if (FOwner is TSystemUser) then
    Result := Self.IndexOf(AMenuId)
  else if (FOwner is TSystemMenu) then
    Result := Self.IndexOf(AUserId)
  else
    Result := inherited IndexOf(AUserId,(FOwner as _SystemMenu).FMenuId);
end;

function TSystemAccess_Arr.IndexOf(AMenuId: integer): integer;
begin
  if not (FOwner is TSystemUser) then
    raise EAbort.Create('Owner is not _SystemUser')
  else
    Result := inherited IndexOf((FOwner as _SystemUser).FUserId,AMenuId);
end;

function TSystemAccess_Arr.IndexOf(AUserId: string): integer;
begin
  if not (FOwner is TSystemMenu) then
    raise EAbort.Create('Owner is not _SystemMenu')
  else
    Result := inherited IndexOf(AUserId,(FOwner as _SystemMenu).FMenuId);
end;

function TSystemAccess_Arr.LoadFromDB(AUserID: string; AMenuID: integer): integer;
var buffer: TMysqlResult; i, idx: integer;sql, cond: string;
begin
  Self.Clear;

  cond := '';
  if (AUserID<>'') then
    cond := cond + ' WHERE SA.Menu_Id=SM.Menu_Id AND SA.User_Id='+FormatSQLString(AUserID);
  if (AMenuID<>0) then
    cond := cond + ' WHERE SA.User_Id=SM.User_Id AND SA.Menu_Id='+FormatSQLNumber(AMenuID);
 sql := 'SELECT SA.User_Id, SA.Menu_Id, Access_List, Shortcut, Outlook_Panel, Outlook_Button, Usage_Count'+
         ', Menu_Group, Menu_Name, Image_Index, Form_Name, Form_Type'+
     ' FROM System_Access SA, System_Menu SM'+ cond;
  buffer := OpenSQL(sql);
  Result := buffer.RecordCount;
  for i:=0 to buffer.RecordCount-1 do begin
    idx := Self.Add(
      BufferToString(buffer.FieldValue(0)),
      BufferToInteger(buffer.FieldValue(1)),
      BufferToInteger(buffer.FieldValue(2)),
      BufferToInteger(buffer.FieldValue(3)),
      BufferToString(buffer.FieldValue(4)),
      BufferToString(buffer.FieldValue(5)),
      BufferToInteger(buffer.FieldValue(6)));

    if (FOwner is TSystemUser) and Assigned(SystemAccess_Arr[idx].SystemMenu) then begin
      SystemAccess_Arr[idx].SystemMenu.FMenuGroup := BufferToString(buffer.FieldValue(7));
      SystemAccess_Arr[idx].SystemMenu.FMenuName := BufferToString(buffer.FieldValue(8));
      SystemAccess_Arr[idx].SystemMenu.FImageIndex := BufferToInteger(buffer.FieldValue(9));
      SystemAccess_Arr[idx].SystemMenu.FFormName := BufferToString(buffer.FieldValue(10));
      SystemAccess_Arr[idx].SystemMenu.FFormType := BufferToInteger(buffer.FieldValue(11));
    end;

    buffer.MoveNext;
  end;
  buffer.Destroy;
end;

function TSystemAccess_Arr.LoadFromDB: integer;
begin
  if (FOwner is TSystemUser) then
    Result := Self.LoadFromDB((FOwner as TSystemUser).FUserID,0)
  else if (FOwner is TSystemMenu) then
    Result := Self.LoadFromDB('',(FOwner as TSystemMenu).FMenuId)
  else
    raise EAbort.Create('Container has no parent. Use FindOnDB instead of LoadFromDB');
end;

procedure TSystemAccess_Arr.RecalculateUsage;
var i, j, IndexMax, temp : integer;
begin
  setlength(FIndexUsage_Arr,Self.Count);
  for i := 0 to high(FIndexUsage_Arr) do FIndexUsage_Arr[i] := i;

  for i := 0 to high(FIndexUsage_Arr)-1 do begin
    IndexMax := i;
    for j := i + 1 to high(FIndexUsage_Arr) do begin
      if (SystemAccess_Arr[FIndexUsage_Arr[j]].UsageCount > SystemAccess_Arr[FIndexUsage_Arr[IndexMax]].UsageCount) then
        IndexMax := j;
    end;
    if not (IndexMax = i) then begin
      temp                       := FIndexUsage_Arr[i];
      FIndexUsage_Arr[i]         := FIndexUsage_Arr[IndexMax];
      FIndexUsage_Arr[IndexMax]  := temp;
    end;
  end;
end;

function TSystemAccess_Arr.GetTopUsage(Position: integer): TSystemAccess;
begin
  if (Position<0) or (Position>high(FIndexUsage_Arr)) then Result := nil
  else Result := SystemAccess_Arr[FIndexUsage_Arr[Position]];
end;

procedure TSystemAccess_Arr.SaveUsageCountOnDB;
var i: integer;
begin
  for i:=0 to high(FSystemAccess_Arr) do SystemAccess_Arr[i].UpdateUsageCountOnDB;
end;

procedure TSystemAccess_Arr.SaveOutlookOnDB;
var i: integer;
begin
  for i:=0 to high(FSystemAccess_Arr) do SystemAccess_Arr[i].UpdateOutlookOnDB;
end;

function TSystemAccess_Arr.GetByMenuID(AMenuID: integer): TSystemAccess;
var i: integer;
begin
  Result := nil;
  for i:=0 to Self.Count-1 do begin
    if (SystemAccess_Arr[i].SystemMenu.MenuId=AMenuId) then
      Result := SystemAccess_Arr[i];
  end;
end;

function TSystemAccess_Arr.GetByFormName(AFormName: string): TSystemAccess;
var i: integer;
begin
  Result := nil;
  for i:=0 to Self.Count-1 do begin
    if (UpperCase(SystemAccess_Arr[i].SystemMenu.FormName)=UpperCase(AFormName)) then
      Result := SystemAccess_Arr[i];
  end;
end;

procedure TSystemAccess_Arr.InsertOnDB;
var i:integer;
begin
  for i:=0 to Count-1 do FSystemAccess_Arr[i].InsertOnDB;
end;

procedure TSystemAccess_Arr.DeleteUpdateOnDB;
begin
  if (FOwner is TSystemUser) then begin
    ExecSQL(
      'DELETE FROM System_access'+
      ' where user_id='+FormatSQLString(TSystemUser(FOwner).UserId));
    InsertOnDB;
  end;
end;

function setAccountView(accNum :integer):string;
var vtmp : string;
begin
  vtmp := IntToStr(accNum);
  Result := copy(vtmp,1,3)+'.'+copy(vtmp,4,3);
end;

function getAccountView(accNum : string):integer;
var tmp : string;
begin
  tmp := EkstrakString(accNum,'.',1)+EkstrakString(accNum,'.',2);
  Result := StrToInt(tmp);
end;

function FindComponentTag(Sender: TForm; const ATag: integer): TComponent;
var
  I: Integer;
begin
  if (ATag <> 0) and (Sender <> nil) then
    for I := 0 to Sender.ComponentCount - 1 do
    begin
      Result := Sender.Components[I];
      if SameValue(Result.Tag, ATag) then Exit;
    end;
  Result := nil;
end;

function IgnoreChar(Key: Char): Char;
//berfungsi untuk nyortir numeric aja
//event: onKeyPress
//var vNotDecimalSeparator:Char;
begin
  if char('.') = DecimalSeparator then begin
    case Key of
      //#1
      char('A')..char('Z'), char('a')..char('z'): Result:= char(0);
      char(','): Result:= char('.');

      else Result:= key;
    end;
  end
  else begin
    case Key of
      char('A')..char('Z'), char('a')..char('z'): Result:= char(0);
      char('.'): Result:= char(',');
      else Result:= key;
    end;
  end;
end;

procedure AdvEdtFloatFmt(Sender: TObject; value: String; ExeclStyle: boolean);
//berfungsi untuk membuat format angka lebih menarik
//event: onValidate
var IsValid{, vNotDecimalSeparator}: Boolean;
  tmp: double; LastChar: string;
begin
  if value = '0-' then begin
    (Sender as TAdvEdit).Text:= '-';
    exit;
  end
  else
  if char('.') = DecimalSeparator then begin
    if value = '-' then begin
      (Sender as TAdvEdit).SelStart:= 1;
      exit;
    end;
    LastChar:= copy(value, length(value),1);
    IsValid:= (lastChar <> '.');

  //kalo tekan vk_add ignore the format
    if IsValid and (lastChar = '+') then
       value:= copy(value, 1, length(value)-1)
    else if IsValid and (lastChar = '-') then
       value:= '-'+copy(value, 1, length(value)-1);

    if IsValid then begin
      //ganyi titik dengan nul
      //tmp:= StrToFloatDef(ReplaceSubStr(value,',',''),0);
      tmp:= StrFmtToFloatDef(ReplaceSubStr(value,',',''),0, ExeclStyle);

      if (copy(value, length(value)-1,2) <> '.0') then
        //(Sender as TAdvEdit).Text:= FloatToStrFmt('#,##0.##', tmp);
        (Sender as TAdvEdit).Text:= FloatToStrFmt(tmp, ExeclStyle);

      (Sender as TAdvEdit).SelStart:= length((Sender as TAdvEdit).Text);
    end;
  end

  else begin
    if value = '-' then begin
      (Sender as TAdvEdit).SelStart:= 1;
      exit;
    end;
    LastChar:= copy(value, length(value),1);
    IsValid:= (lastChar <> ',');

  //kalo tekan vk_add ignore the format
    if IsValid and (lastChar = '+') then
       value:= copy(value, 1, length(value)-1)
    else if IsValid and (lastChar = '-') then
       value:= '-'+copy(value, 1, length(value)-1);

    if IsValid then begin
      //ganyi titik dengan nul
      //tmp:= StrToFloatDef(ReplaceSubStr(value,'.',''),0);
      tmp:= StrFmtToFloatDef(ReplaceSubStr(value,'.',''),0, ExeclStyle);

      if (copy(value, length(value)-1,2) <> ',0') then
        //(Sender as TAdvEdit).Text:= FormatFloat('#,##0.##', tmp);
        (Sender as TAdvEdit).Text:= FloatToStrFmt(tmp, ExeclStyle);
      (Sender as TAdvEdit).SelStart:= length((Sender as TAdvEdit).Text);
    end;
  end;
end;

procedure AdvEdtFloatFmt2(Sender: TObject; value: String; ExeclStyle: boolean);
//berfungsi untuk membuat format angka lebih menarik
//event: onValidate
var IsValid{, vNotDecimalSeparator}: Boolean;
  tmp: double; LastChar: string;
begin
  if value = '0-' then begin
    (Sender as TAdvEdit).Text:= '-';
    exit;
  end
  else
  if char('.') = DecimalSeparator then begin
    if value = '-' then begin
      (Sender as TAdvEdit).SelStart:= 1;
      exit;
    end;

    LastChar:= copy(value, length(value),1);
    IsValid:= (lastChar <> '.');

  //kalo tekan vk_add ignore the format
    if IsValid and (lastChar = '+') then
       value:= copy(value, 1, length(value)-1);

    if IsValid then begin
      //ganyi titik dengan nul
      //tmp:= StrToFloatDef(ReplaceSubStr(value,',',''),0);
      tmp:= StrFmtToFloatDef(ReplaceSubStr(value,',',''),0, ExeclStyle);

      if (copy(value, length(value)-1,2) <> '.0') then
        //(Sender as TAdvEdit).Text:= FloatToStrFmt('#,##0.##', tmp);
        (Sender as TAdvEdit).Text:= FloatToStrFmt(tmp, ExeclStyle);

      (Sender as TAdvEdit).SelStart:= length((Sender as TAdvEdit).Text);
    end;
  end

  else begin
    if value = '-' then begin
      (Sender as TAdvEdit).SelStart:= 1;
      exit;
    end;
    LastChar:= copy(value, length(value),1);
    IsValid:= (lastChar <> ',');

    //kalo tekan vk_add ignore the format
    if IsValid and (lastChar = '+') then
       value:= copy(value, 1, length(value)-1);

    if IsValid then begin
      //ganyi titik dengan nul
      //tmp:= StrToFloatDef(ReplaceSubStr(value,'.',''),0);
      tmp:= StrFmtToFloatDef(ReplaceSubStr(value,'.',''),0, ExeclStyle);

      if (copy(value, length(value)-1,2) <> ',0') then
        //(Sender as TAdvEdit).Text:= FormatFloat('#,##0.##', tmp);
        (Sender as TAdvEdit).Text:= FloatToStrFmt(tmp, ExeclStyle);
      (Sender as TAdvEdit).SelStart:= length((Sender as TAdvEdit).Text);
    end;
  end;

end;

function CekFloatFmt(AString: string): boolean;
begin
  Result := CekFloat(ReplaceSubStr(AString,ThousandSeparator,''));
end;


function TSystemAccess_Arr.LoadFromDB2(AUserID: string): integer;
var buffer: TMysqlResult; i, idx: integer;sql, cond: string;
begin
  Self.Clear;

  cond := '';
  if (AUserID<>'') then
    cond := cond + ' WHERE  SA.user_id IS NULL OR SA.User_Id='+FormatSQLString(AUserID);
   sql := 'SELECT SM.Menu_Id, Menu_Name, Can_Acces '+
        ' FROM System_Menu SM LEFT OUTER JOIN  System_Access SA'+
        ' ON SA.Menu_Id=SM.Menu_Id '+ cond;
  buffer := OpenSQL(sql);
  Result := buffer.RecordCount;
  for i:=0 to buffer.RecordCount-1 do begin
    idx := Self.Add('',
      BufferToInteger(buffer.FieldValue(0)),
      0, 0, '', '', 0);
      SystemAccess_Arr[idx].SystemMenu.FMenuName := BufferToString(buffer.FieldValue(1));
      SystemAccess_Arr[idx].CanAccess := BufferToInteger(buffer.FieldValue(2));
    buffer.MoveNext;
  end;
  buffer.Destroy;

end;

function TSystemAccess_Arr.FindOnDb(AUserID: string): integer;
var buffer: TMysqlResult; i, idx: integer;sql: string;
begin
  Self.Clear;
  sql :=
   'select sm.menu_id, sm.menu_name,sa.can_acces,sa.can_add, sa.can_edit,sa.can_delete,sa.can_view,sa.can_print '+
///     '(select can_acces from system_access where menu_id = sm.menu_id and user_id = '+FormatSQLString(AUserID)+') as akses '+
   'from system_menu sm left join system_access sa on sm.menu_id = sa.menu_id and sa.user_id = '+FormatSQLString(AUserID)+
   ' where sm.hide <> -1 order by menu_id';
  buffer := OpenSQL(sql);
  Result := buffer.RecordCount;
  for i:=0 to buffer.RecordCount-1 do begin
    idx := Self.AddX(BufferToInteger(buffer.FieldValue(0)),
    BufferToString(buffer.FieldValue(1)),
      BufferToInteger(buffer.FieldValue(2)));
      SystemAccess_Arr[idx].SystemMenu.FMenuName := BufferToString(buffer.FieldValue(1));
      SystemAccess_Arr[idx].CanAccess := BufferToInteger(buffer.FieldValue(2));
      SystemAccess_Arr[idx].CanAddd := BufferToInteger(buffer.FieldValue(3));
      SystemAccess_Arr[idx].CanEdit := BufferToInteger(buffer.FieldValue(4));
      SystemAccess_Arr[idx].CanDelete := BufferToInteger(buffer.FieldValue(5));
      SystemAccess_Arr[idx].CanView := BufferToInteger(buffer.FieldValue(6));
      SystemAccess_Arr[idx].CanPrint := BufferToInteger(buffer.FieldValue(7));
    buffer.MoveNext;
  end;
  buffer.Destroy;
end;

function TSystemAccess_Arr.AddX(AMenuId: integer; AMenuName: string;
  ACanAkses: integer): integer;
begin
  setLength(FSystemAccess_Arr, length(FSystemAccess_Arr)+1);
  Result := high(FSystemAccess_Arr);
  FSystemAccess_Arr[Result] := TSystemAccess(Self.New);
  SystemAccess_Arr[Result].SystemMenu.MenuId := AMenuId;
  SystemAccess_Arr[Result].SystemMenu.MenuName := AMenuName;
  SystemAccess_Arr[Result].FCanAcces := ACanAkses;
end;

function getNextIDNum2(fieldName:string; tableName:string; condition:String; prefix:string):string;
var sql:string;buffer:TMysqlResult;code:string; codeNum:integer;cond: string;
begin
    sql := 
    'SELECT MAX(CAST(SUBSTRING('+fieldName+',2) AS  UNSIGNED )) FROM '+tableName;
    cond := '';
    if condition <> '' then
      cond := cond + ' AND ' + copy(condition,5,length(condition));
    if prefix <> '' then
      cond := cond + ' AND ' + fieldname + ' LIKE ' + FormatSQLString(prefix+'%');
    if cond <> '' then begin
      delete(cond,1,5);
      sql := sql + ' WHERE ' + cond;
    end;
    buffer := OpenSQL(sql);
    if buffer.RecordCount > 0 then begin
      code := BufferToString(buffer.FieldValue(0));
      codeNum := StrToIntDef(code,0);
      inc(codeNum);
      result := prefix+IntToStrFixed(0,codeNum);
    end else
      result := prefix+IntToStrFixed(0,1);
    buffer.Destroy;

end;

{ TFilters }

procedure TFilters.Reset;
begin
  Numeric1:= 0;
  Numeric2:= 0;
  Numeric3:= 0;
  Numeric4:= 0;  
  SpecId  := 0;
  ItemId  := 0;
  RelasiId:= 0;
  StatusId:= 0;//0: true, false, etc
  TipeId  := '';
  SeriesID:= 0;
  Name:= '';
  ShowDisabled:= False;
  FString1:= '';
  FString2:= '';
  FLimit  := 0;
  FOffset := 0;
end;

procedure TFilters.setFilters(vSpecId, vItemId, vRelasiId,
  vStatusId: integer; vTipeId: string);
begin
  SpecId  := vSpecId;
  ItemId  := vItemId;
  RelasiId:= vRelasiId;
  StatusId:= vStatusId;
  TipeId  := vTipeId;
end;

{ TMstCompany }

function TMstCompany.InsertInDb: boolean;
begin
    try
    if getIntegerFromSQL('select count(*) from mst_company') > 0 then

      ExecSQL(
        'update mst_company set '+
        'company_name = '+FormatSQLString(FCompanyName)+', '+
        'address = '+FormatSQLString(FAddress)+', '+
        'telp1 = '+FormatSQLString(FTelp1)+', '+
        'telp2 = '+FormatSQLString(FTelp2)+', '+
        'fax = '+FormatSQLString(FFax)+', '+
        'city = '+FormatSQLString(FCity)+', '+
        'branch = '+FormatSQLString(FBranch)+', '+
        'npwp = '+FormatSQLString(FNpwp)+', '+
        'post_code = '+FormatSQLString(FPostCode)+', '+
        'info = '+FormatSQLString(FInfo)+', '+
        'user_id = '+FormatSQLString(FUserId)+', '+
        ' jam_masuk='+FormatSQLTime2(FJamMasuk)+','+
      ' jam_pulang='+FormatSQLTime2(FJamPulang)+','+
        'current_branch='+FormatSQLNumber(FCurrentBranch)+','+
        'serial_number = '+FormatSQLString(FSerialNumber))

    else
      ExecSQL(
      'insert into mst_company (company_name, address, telp1, telp2, fax, city, '+
        'branch, info, user_id, npwp, post_code,current_branch,jam_masuk, jam_pulang, serial_number) '+
      'values ('+
        FormatSQLString(FCompanyName)+', '+
        FormatSQLString(FAddress)+', '+
        FormatSQLString(FTelp1)+', '+
        FormatSQLString(FTelp2)+', '+
        FormatSQLString(FFax)+', '+
        FormatSQLString(FCity)+', '+
        FormatSQLString(FBranch)+', '+
        FormatSQLString(FInfo)+', '+
        FormatSQLString(FUserId)+', '+
        FormatSQLString(FNpwp)+', '+
        FormatSQLString(FPostCode)+', '+
        FormatSQLNumber(FCurrentBranch)+','+
        FormatSQLTime2(FJamMasuk)+','+
        FormatSQLTime2(FJamPulang)+','+
        FormatSQLString(FSerialNumber)+') ');

    Result:= true;
  except raise;
    Result:= false;
  end;

end;

function TMstCompany.SelectInDB:boolean;
var buffer:TMysqlResult; vsql:string;
begin
  vsql := 'select company_name, address, telp1, telp2, fax, city, branch, info, user_id, serial_number,current_branch '+
    ' ,jam_masuk, jam_pulang from mst_company';
  buffer:= OpenSQL(vsql);
  Result := buffer.RecordCount>0;
  if buffer.RecordCount > 0 then begin
    FCompanyName:= BufferToString(buffer.FieldValue(0));
    FAddress:= BufferToString(buffer.FieldValue(1));
    FTelp1:= BufferToString(buffer.FieldValue(2));
    FTelp2:= BufferToString(buffer.FieldValue(3));
    FFax:= BufferToString(buffer.FieldValue(4));
    FCity:= BufferToString(buffer.FieldValue(5));
    FBranch:= BufferToString(buffer.FieldValue(6));
    FInfo:= BufferToString(buffer.FieldValue(7));
    FUserId:= BufferToString(buffer.FieldValue(8));
    FSerialNumber:= BufferToString(buffer.FieldValue(9));
    FCurrentBranch := BufferToInteger(buffer.FieldValue(10));
    FJamMasuk := BufferToTime(buffer.FieldValue(11));
    FJamPulang := BufferToTime(buffer.FieldValue(12));
  end;
  buffer.Destroy;
end;

procedure CopyStringToList(SourList, DestList: TStringList);
//FBI WARNING ... !!!!
//berlaku hanya dan jika names dari SourList tidak ada yang sama dengan
//names dari DestList yang sudah ada
var i: integer;
begin
  for i:= 0 to SourList.Count-1 do
    DestList.Add(SourList.Strings[i])
end;

{ TDataBayar }

class procedure TDataBayar.Reset(var DataBayar :trDataBayar);
begin
  DataBayar.FCaraBayar:= 0;
  DataBayar.FJumlahBayar:= 0;
  DataBayar.FTagihan := 0;
  DataBayar.FTerbayar:= 0;
  DataBayar.FKeterangan:= '';
end;

function ExecuteAndWait(FileName: string; Visibility: integer): cardinal;
var
  AppName: array [0..512] of char;
  CurDir: array [0..255] of char;
  WorkDir: string;
  StartupInfo: TStartupInfo;
  ProcessInfo: TProcessInformation;

  //Visibility: sw_normal 
begin
  StrPCopy(AppName, FileName);
  GetDir(0, WorkDir);
  StrPCopy(CurDir, WorkDir);

  FillChar(StartupInfo, Sizeof(StartupInfo), #0);
  StartupInfo.cb:= Sizeof(StartupInfo);
  StartupInfo.dwFlags:= STARTF_USESHOWWINDOW;
  StartupInfo.wShowWindow:= Visibility;

  if ( not CreateProcess(nil, AppName, nil, nil, False, CREATE_NEW_CONSOLE or NORMAL_PRIORITY_CLASS,
                         nil, CurDir, StartupInfo, ProcessInfo)) then
  begin
    Result:= $FFFFFFFF;
    MessageBox(Application.Handle, pchar(SysErrorMessage(GetLastError)), 'Kesalahan!', 0);
  end
  else
  begin
    WaitForSingleObject(ProcessInfo.hProcess, INFINITE);
    GetExitCodeProcess(ProcessInfo.hProcess, Result);
    CloseHandle(ProcessInfo.hProcess);
    CloseHandle(ProcessInfo.hThread);
  end;
end;

function CekInput(var AResult: boolean; vState: boolean; vMsg: string; vControl: TWinControl): boolean;
begin
    Result:= vState;
    AResult:= vState;
    if Result = true then Exit;
    Inform(vMsg);
    vControl.SetFocus;
end;

function getLastId: integer;
begin
  Result:= getIntegerFromSQL('select last_insert_id() ');
end;

  procedure CariData(AGrid: TAdvStringGrid; Sender: TForm);
  var AFindDlg: TAdvGridFindDialog;
  begin
    AFindDlg := TAdvGridFindDialog.Create(Sender);
    AFindDlg.HasParent;
    AFindDlg.Grid := AGrid;
    with AFindDlg do begin
      Grid                := AGrid;
      MsgNoMoreFound      := 'Pencarian data selesai.';
      MsgNotFound         := 'Data yang dicari tidak ditemukan.';
      TTxtDirForward1     := 'Dari bawah ke atas';
      TTxtDirForward2     := 'Dari kanan ke kiri';
      TTxtDirBackward1    := 'Dari atas ke bawah';
      TTxtDirForward1     := 'Dari kiri ke kanan';
      TxtCaption          := 'Cari Data';
      TxtDirection        := 'Metode Pencarian';
      TxtOptionsCase      := 'Hurup besar/kecil';
      TxtOptionsFixedCells:= 'Cari di sel baku';
      TxtScope            := 'Cakupan Pencarian';
      TxtScopeAllCells    := 'Cari di semua sel';
      TxtScope            := 'Cakupan Pencarian';
      TxtScope            := 'Cari di kolom yg aktif';
      TxtScope            := 'Cari di baris yg aktif';
      TxtScope            := 'Data yg akan dicari:';
      TxtBtnOk            := 'Cari !';
      TxtBtnCancel        := 'Batal';
      Execute;
    end;
    AFindDlg.FreeOnRelease;
  end;

  function GetActualPeriode(vPeriode: TPeriode; isBegin: boolean=True; vMaxDate: TDate=0): TDate;
  begin
    if isBegin then
      Result:=
        IfThen(vPeriode.OpPeriodeAwal1 <> soLessThanEqualsTo,
        IfThen(vPeriode.PeriodeAwal1 <> 0, vPeriode.PeriodeAwal1, ServerNow), 0)
    else
      Result:=
        IfThen(vPeriode.PeriodeAkhir1 <> 0, vPeriode.PeriodeAkhir1,
          IfThen(vPeriode.OpPeriodeAwal1 = soGreaterThanEqualsTo,
           vMaxDate, vPeriode.PeriodeAwal1));
  end;

  function GetMonthMode(vDate: TDate; vMonth: word): TDate;
  var  Year, Month, Day, MonthTmp, TrueDay: word;
  begin
    DecodeDate(vDate, Year, Month, Day);
    MonthTmp:= Month + vMonth;
    if MonthTmp > 12 then begin
      MonthTmp:= (MonthTmp - 12);
      Year:= Year + 1;
    end;
    TrueDay:= DaysInAMonth(Year, MonthTmp);
    if Day > TrueDay then
      Day:= TrueDay;
      
    Result:= EncodeDate(Year, MonthTmp, Day);
  end;

function getNextID(current_code, prefix: string; minlength: integer=5):string;
var code:string; codeNum:integer;
begin
  code := copy(current_code, length(prefix)+1, length(current_code)-length(prefix));
  codeNum := StrToIntDef(code,0);
  inc(codeNum);
  result := prefix+IntToStrFixed(minlength,codeNum);
end;

function getPeriode4(aDate:TDate):string;
begin

  case MonthOf(aDate) of
   1 : Result:= IntToStr(YearOf(aDate)) + '01'; //copy(IntToStr(YearOf(aDate)), 3,2)
   2 : Result:= IntToStr(YearOf(aDate)) + '02';
   3 : Result:= IntToStr(YearOf(aDate)) + '03';
   4 : Result:= IntToStr(YearOf(aDate)) + '04';
   5 : Result:= IntToStr(YearOf(aDate)) + '05';
   6 : Result:= IntToStr(YearOf(aDate)) + '06';
   7 : Result:= IntToStr(YearOf(aDate)) + '07';
   8 : Result:= IntToStr(YearOf(aDate)) + '08';
   9 : Result:= IntToStr(YearOf(aDate)) + '09';
   10: Result:= IntToStr(YearOf(aDate)) + '10';
   11: Result:= IntToStr(YearOf(aDate)) + '11';
   12: Result:= IntToStr(YearOf(aDate)) + '12';
  end;

end;

function ExtractYearMonth2(YearMonth: string; LongFormat: boolean=false): string;
var month: word; NewValue: string;
begin

  NewValue:= EkstrakString(YearMonth,'-', 1);
  month:= StrToInt(copy(NewValue, 5,2));
  case month of
    1:  Result:= IfThen(LongFormat, 'Januari '+copy(NewValue,   1,4), 'Jan '+copy(NewValue, 3,2));
    2:  Result:= IfThen(LongFormat, 'Februari '+copy(NewValue,  1,4), 'Feb '+copy(NewValue, 3,2));
    3:  Result:= IfThen(LongFormat, 'Maret '+copy(NewValue,     1,4), 'Mar '+copy(NewValue, 3,2));
    4:  Result:= IfThen(LongFormat, 'April '+copy(NewValue,     1,4), 'Apr '+copy(NewValue, 3,2));
    5:  Result:= IfThen(LongFormat, 'Mei '+copy(NewValue,       1,4), 'Mei '+copy(NewValue, 3,2));
    6:  Result:= IfThen(LongFormat, 'Juni '+copy(NewValue,      1,4), 'Jun '+copy(NewValue, 3,2));
    7:  Result:= IfThen(LongFormat, 'Juli '+copy(NewValue,      1,4), 'Jul '+copy(NewValue, 3,2));
    8:  Result:= IfThen(LongFormat, 'Agustus '+copy(NewValue,   1,4), 'Aug '+copy(NewValue, 3,2));
    9:  Result:= IfThen(LongFormat, 'September '+copy(NewValue, 1,4), 'Sep '+copy(NewValue, 3,2));
    10: Result:= IfThen(LongFormat, 'Oktober '+copy(NewValue,   1,4), 'Okt '+copy(NewValue, 3,2));
    11: Result:= IfThen(LongFormat, 'November '+copy(NewValue,  1,4), 'Nov '+copy(NewValue, 3,2));
    12: Result:= IfThen(LongFormat, 'Desember '+copy(NewValue,  1,4), 'Des '+copy(NewValue, 3,2));
  end;

  NewValue:= EkstrakString(YearMonth,'-', 2);
  if NewValue = '' then exit;

  month:= StrToInt(copy(NewValue, 5,2));
  case month of
    1:  Result:= Result + ' - ' + IfThen(LongFormat, 'Januari '+copy(NewValue,   1,4), 'Jan '+copy(NewValue, 3,2));
    2:  Result:= Result + ' - ' + IfThen(LongFormat, 'Februari '+copy(NewValue,  1,4), 'Feb '+copy(NewValue, 3,2));
    3:  Result:= Result + ' - ' + IfThen(LongFormat, 'Maret '+copy(NewValue,     1,4), 'Mar '+copy(NewValue, 3,2));
    4:  Result:= Result + ' - ' + IfThen(LongFormat, 'April '+copy(NewValue,     1,4), 'Apr '+copy(NewValue, 3,2));
    5:  Result:= Result + ' - ' + IfThen(LongFormat, 'Mei '+copy(NewValue,       1,4), 'Mei '+copy(NewValue, 3,2));
    6:  Result:= Result + ' - ' + IfThen(LongFormat, 'Juni '+copy(NewValue,      1,4), 'Jun '+copy(NewValue, 3,2));
    7:  Result:= Result + ' - ' + IfThen(LongFormat, 'Juli '+copy(NewValue,      1,4), 'Jul '+copy(NewValue, 3,2));
    8:  Result:= Result + ' - ' + IfThen(LongFormat, 'Agustus '+copy(NewValue,   1,4), 'Aug '+copy(NewValue, 3,2));
    9:  Result:= Result + ' - ' + IfThen(LongFormat, 'September '+copy(NewValue, 1,4), 'Sep '+copy(NewValue, 3,2));
    10: Result:= Result + ' - ' + IfThen(LongFormat, 'Oktober '+copy(NewValue,   1,4), 'Okt '+copy(NewValue, 3,2));
    11: Result:= Result + ' - ' + IfThen(LongFormat, 'November '+copy(NewValue,  1,4), 'Nov '+copy(NewValue, 3,2));
    12: Result:= Result + ' - ' + IfThen(LongFormat, 'Desember '+copy(NewValue,  1,4), 'Des '+copy(NewValue, 3,2));
  end;
end;

function getYearMonth(YearMonth: string; idx: integer): string;
var i: integer;
begin
  Result:= EkstrakString(YearMonth,'-', idx);
  idx:= idx-1;
  if Result = '' then
    for i:= idx downto 0 do begin
      Result:= EkstrakString(YearMonth,'-', i);
      if Result <> '' then exit;
    end;
end;

function getPeriode3(aDate:TDate):string;
begin
  case MonthOf(aDate) of
   1 : Result:= IntToStr(YearOf(aDate)) + '01';
   2 : Result:= IntToStr(YearOf(aDate)) + '02';
   3 : Result:= IntToStr(YearOf(aDate)) + '03';
   4 : Result:= IntToStr(YearOf(aDate)) + '04';
   5 : Result:= IntToStr(YearOf(aDate)) + '05';
   6 : Result:= IntToStr(YearOf(aDate)) + '06';
   7 : Result:= IntToStr(YearOf(aDate)) + '07';
   8 : Result:= IntToStr(YearOf(aDate)) + '08';
   9 : Result:= IntToStr(YearOf(aDate)) + '09';
   10: Result:= IntToStr(YearOf(aDate)) + '10';
   11: Result:= IntToStr(YearOf(aDate)) + '11';
   12: Result:= IntToStr(YearOf(aDate)) + '12';
  end;

end;

function getWindowsVersion: string;
var winVersion: TOSVersionInfo;
  //winVersionName: string;
  //myNum, mnNum, bldNum: integer;
begin
  winVersion.dwOSVersionInfoSize:= sizeOf(TOSVersionInfo);
  GetVersionEx(winVersion);
  case winVersion.dwMajorVersion of
    3: Result:= WINDOWS_31;
    4:
    begin
      case winVersion.dwPlatformId of
        VER_PLATFORM_WIN32_NT: Result:= WINDOWS_NT;
        VER_PLATFORM_WIN32_WINDOWS:
        case winVersion.dwMinorVersion of
          0 : Result:= WINDOWS_95;
          10: Result:= WINDOWS_98;
          90: Result:= WINDOWS_ME;
        end;

      end;
    end;

    5:
    begin
      case winVersion.dwMinorVersion of
        0 : Result:= WINDOWS_2K;
        1 : Result:= WINDOWS_XP;
      end;
    end;
    else Result:= WINDOWS_XX;
  end

  //myNum := winVersion.dwMajorVersion;
  //mnNum := winVersion.dwMinorVersion;
  //bldNum:= winVersion.dwBuildNumber;

end;

function getWindowsDir: string;
var windDir: array[0..260] of char;
begin
  GetWindowsDirectory(@windDir, 260);
  Result:= windDir;
end;

function IgnoreNumber(Input: string): string;
var i: integer; tmpStr: string;
begin
  tmpStr:= '';
  for i:= 1 to length(Input) do
    if not CekInteger(Input[i]) then
      tmpStr:= tmpStr + Input[i];
  Result:= tmpStr;
end;

{procedure getConfigItemBalace;
var reg: TRegistry;
begin

  reg:= TRegistry.Create;
  try
    try
      reg.OpenKey(GLOBAL_REG_PATH+'\Inventory', false);
      GlobalConfigItemBalace:= reg.ReadInteger('invItemBalance');
    except
    end;
  finally
    reg.DestroyKey;
    reg.Free;
  end;
end;}

{ TSystemConfig }


class function TSystemConfig.getValue(aConfId: integer): string;
begin
  Result := getStringFromSQL('select conf_value from system_config where conf_id='+FormatSQLNumber(aConfId));
end;

procedure TSystemConfig.Reset;
begin
  FConfId:= 0; //
  FConfName:= ''; //[50]
  FConfValue:= ''; //[50]
end;

procedure TSystemConfig.UpdateOnDB;
begin
  ExecSQL(
    'update system_config set conf_value = '+FormatSQLString(FConfValue)+
    'where conf_id = '+formatsqlNumber(ConfId));
end;

{ TSystemConfig_Arr }

function TSystemConfig_Arr.Add: integer;
begin
  setLength(FSystemConfig_Arr, length(FSystemConfig_Arr)+1);
  Result := high(FSystemConfig_Arr);
  FSystemConfig_Arr[Result] := New;
end;

procedure TSystemConfig_Arr.Clear;
var i: integer;
begin
  for i:=0 to high(FSystemConfig_Arr) do FSystemConfig_Arr[i].Destroy;
  setLength(FSystemConfig_Arr,0);
end;

function TSystemConfig_Arr.Count: integer;
begin
  Result := length(FSystemConfig_Arr);
end;

constructor TSystemConfig_Arr.Create;
begin
  inherited Create;
  setLength(FSystemConfig_Arr,0);
  TLocalConfig.Reset(localSetting);
end;

destructor TSystemConfig_Arr.Destroy;
begin
  Self.Clear;
  inherited;
end;

function TSystemConfig_Arr.Get(Index: integer): TSystemConfig;
begin
  if (Index<0) or (Index>high(FSystemConfig_Arr)) then Result := nil
  else Result := FSystemConfig_Arr[Index];
end;

procedure TSystemConfig_Arr.loadFromDB(loadReg: boolean);
var i: integer; buffer:TMysqlResult; 
begin
  Self.Clear;
  buffer:= OpenSQL('select * from system_config');
  for i:= 0 to buffer.RecordCount-1 do begin
    Self.Add;
    Self[i].FConfId:= BufferToInteger(buffer.FieldValue(0));
    Self[i].FConfName:= BufferToString(buffer.FieldValue(1));
    Self[i].FConfValue:= BufferToString(buffer.FieldValue(2));
    buffer.MoveNext;
  end;
  buffer.Destroy;

  if loadReg then TLocalConfig.LoadLocalSetting(localSetting);
end;

function TSystemConfig_Arr.New: TSystemConfig;
begin
  Result:= TSystemConfig.Create;
end;

procedure GetShift(list: TStringList; Input: TStrings);
begin
  SQLToNameValueList(list,
  'select mst_id, mst_name from mst_master where mst_tipe = '+IntToStr(MST_TYPE_SHIFT));
  NameValueListToValueList(list, Input);
end;

procedure TSystemConfig_Arr.UpdateOnDB(id: integer; value: string);
begin
  ExecSQL('update system_config set conf_value = '+FormatSQLString(value)+
  'where conf_id = '+formatsqlNumber(id));
end;

function getNextIDNumPeriode2(fieldName, tableName, condition, prefix,suffix:string; reversedOrderNum:string='';minlength:integer=5):string;
var sql:string;buffer:TMysqlResult;code:string; codeNum:integer;codeChar:Char; cond: string;
begin
  if reversedOrderNum <> '' then begin
    //get the last character in the number if it is non-number
    codeChar := (copy(reversedOrderNum,length(reversedOrderNum)-1,1))[1];
    if StrToIntDef(codeChar,0) = 0 then begin//if not-number then
      inc(codeChar);
      result := reversedOrderNum + codeChar;
    end else //if number than append 'a'
      result := reversedOrderNum + 'a';
  end else begin
    sql := 'SELECT MAX('+fieldName+') FROM '+tableName;
    cond := '';
    if condition <> '' then
      cond := cond + ' AND ' + copy(condition,5,length(condition));
    if prefix <> '' then
      cond := cond + ' AND ' + fieldname + ' LIKE ' + FormatSQLString(prefix+'%'+suffix);
    if cond <> '' then begin
      delete(cond,1,5);
      sql := sql + ' WHERE ' + cond;
    end;
    //'customer20080218A0001'
    buffer := OpenSQL(sql);
    if buffer.RecordCount > 0 then begin
    //'STL/MFG/PPC/POI00001/V/2004'
      code := BufferToString(buffer.FieldValue(0));
      //cut off the prefix the last digit if it is a character
      code := copy(code,length(prefix)+1,length(code)-length(prefix));
      code := EkstrakString(code,'/',1);
      codeNum := StrToIntDef(code,0);
      inc(codeNum);
      result := IntToStrFixed(minlength,codeNum);
    end else
      result := IntToStrFixed(minlength,1);
    buffer.Destroy;
  end;

end;



function cekComPort(Port: PChar): boolean;
var
  deviceName: array[0..80] of Char;
  comFile: THandle;
begin
  StrCopy(deviceName, Port);
  comFile:=
    CreateFile(deviceName, GENERIC_READ or GENERIC_WRITE, 0, nil,
               OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
  Result:= comFile <> INVALID_HANDLE_VALUE;
  CloseHandle(comFile);
end;

procedure openDirectDrawer(COM: string);
var
  port  : file;
  read : integer;
  buffer : string;
begin
  AssignFile(port, COM);
  Rewrite(port,1);
  buffer:= '>'+COM;
  BlockWrite(port,buffer,1,read);
  CloseFile(port);
end;

procedure EnumComPorts(Ports: TStrings);
var
  KeyHandle: HKEY;
  ErrCode, Index: Integer;
  ValueName, Data: string;
  ValueLen, DataLen, ValueType: DWORD;
  TmpPorts: TStringList;
begin
  ErrCode := RegOpenKeyEx(
    HKEY_LOCAL_MACHINE,
    'HARDWARE\DEVICEMAP\SERIALCOMM',
    0,
    KEY_READ,
    KeyHandle);

  if ErrCode <> ERROR_SUCCESS then
    raise EComPort.Create(CError_RegError, ErrCode);

  TmpPorts := TStringList.Create;
  try
    Index := 0;
    repeat
      ValueLen := 256;
      DataLen := 256;
      SetLength(ValueName, ValueLen);
      SetLength(Data, DataLen);
      ErrCode := RegEnumValue(
        KeyHandle,
        Index,
        PChar(ValueName),
{$IFDEF DELPHI_4_OR_HIGHER}
        Cardinal(ValueLen),
{$ELSE}
        ValueLen,
{$ENDIF}
        nil,
        @ValueType,
        PByte(PChar(Data)),
        @DataLen);

      if ErrCode = ERROR_SUCCESS then
      begin
        SetLength(Data, DataLen);
        TmpPorts.Add(Data);
        Inc(Index);
      end
      else
        if ErrCode <> ERROR_NO_MORE_ITEMS then
          raise EComPort.Create(CError_RegError, ErrCode);

    until (ErrCode <> ERROR_SUCCESS) ;

    TmpPorts.Sort;
    Ports.Assign(TmpPorts);
  finally
    RegCloseKey(KeyHandle);
    TmpPorts.Free;
  end;

end;

{ EComPort }

constructor EComPort.Create(ACode, AWinCode: Integer);
begin
  FWinCode := AWinCode;
  FCode := ACode;
  inherited CreateFmt(ComErrorMessages[ACode] + ' (win error code: %d)', [AWinCode]);
end;

constructor EComPort.CreateNoWinCode(ACode: Integer);
begin
  FWinCode := -1;
  FCode := ACode;
  inherited Create(ComErrorMessages[ACode]);
end;

{ TLocalConfig }

class procedure TLocalConfig.LoadLocalSetting(var ALocalConfig: FLocalConfig);
var reg: TRegistry;
begin
  reg:= TRegistry.Create;
  reg.RootKey:= HKEY_CURRENT_USER;
  try
    try
      reg.OpenKey(MODUL_PATH + '\Setting', True);

      try ALocalConfig.Machine:= reg.ReadInteger('localMachine');
      except
      reg.WriteInteger('localMachine', 5); end;

      try ALocalConfig.MarginTop:= reg.ReadInteger('marginTop');
      except reg.WriteInteger('marginTop', 0); end;

      try ALocalConfig.MarginBottom:= reg.ReadInteger('marginBottom');
      except reg.WriteInteger('marginBottom', 0); end;

      try ALocalConfig.PrintStruk:= reg.ReadInteger('printStruk');
      except reg.WriteInteger('printStruk', 0); end;

      try ALocalConfig.PrinterID:= reg.ReadInteger('printerID');
      except reg.WriteInteger('printerID', 0); end;

      try ALocalConfig.AutoCutter:= reg.ReadInteger('autoCut');
      except reg.WriteInteger('autoCut', 0); end;

      try ALocalConfig.PortName:= reg.ReadString('portName');
      except reg.WriteInteger('portName', 0); end;

      try ALocalConfig.LocalGudang:= reg.ReadInteger('localGudang');
      except reg.WriteInteger('localGudang', 1); end;

      try ALocalConfig.PrinterStruk:= reg.ReadString('printerStruk');
      except reg.WriteString('printerStruk', ''); end;

      try ALocalConfig.PrinterBarcode:= reg.ReadString('printerBarcode');
      except reg.WriteString('printerBarcode', ''); end;

      try ALocalConfig.PrinterAdm:= reg.ReadString('printerAdm');
      except reg.WriteString('printerAdm', ''); end;

      try ALocalConfig.DrawerCode:= getStringFromSQLX(
        'select drawer_code from mst_printer where printer_id = '+FormatSQLNumber(ALocalConfig.PrinterID));
      except ALocalConfig.DrawerCode:= ''; end;

      try ALocalConfig.CutterCode:= getStringFromSQLX(
        'select cutter_code from mst_printer where printer_id = '+FormatSQLNumber(ALocalConfig.PrinterID));
      except ALocalConfig.CutterCode:= ''; end;

      try ALocalConfig.WriteLogs:= reg.ReadInteger('writeLog');
      except reg.WriteInteger('writeLog', 1); end;

      try ALocalConfig.UseSerialKeys:= reg.ReadInteger('useSerialKeys');
      except reg.WriteInteger('useSerialKeys', 0); end;

      try ALocalConfig.Baudrate:= reg.ReadInteger('baudRate');
      except reg.WriteInteger('baudRate', 19200); end;

      try ALocalConfig.SerialPort:= reg.ReadString('serialPort');
      except reg.WriteString('serialPort', 'COM1'); end;

      try ALocalConfig.JenisDrawer:= reg.ReadInteger('jenisDrawer');
      except reg.WriteInteger('jenisDrawer', 0); end;

    except
      //on ERegistryException do ShowMessage('gagal.');
    end;
  finally
    reg.CloseKey;
  end;
  reg.Free;
end;

class procedure TLocalConfig.Reset(var ALocalConfig: FLocalConfig);
begin
  ALocalConfig.Machine:= 0;
  ALocalConfig.MarginTop:= 0;
  ALocalConfig.MarginBottom:= 0;
  ALocalConfig.PrinterID:= 0;
  ALocalConfig.PrintStruk:= 0;
  ALocalConfig.AutoCutter:= 0;
  ALocalConfig.PortName:= 'COM1';
  ALocalConfig.DrawerCode:= '';
  ALocalConfig.CutterCode    := '';
  ALocalConfig.LocalGudang   := 0;
  ALocalConfig.PrinterStruk  := '';
  ALocalConfig.PrinterBarcode:= '';
  ALocalConfig.PrinterAdm    := '';
  ALocalConfig.WriteLogs     := 1;
  ALocalConfig.UseSerialKeys:= 0;
  ALocalConfig.Baudrate := 19200;
  ALocalConfig.SerialPort:= 'COM1';
  ALocalConfig.JenisDrawer:= 0;
end;

procedure SendEscapeCode(ToSend: string);

type
  TPassThroughData = record
    BuffLength: Word;
    Buffer: array[0..255] of char;
  end;

var
  PassThroughData: TPassThroughData;
  function checkPrinter: boolean; var testInt: integer;
  begin
    {test to see if the "PASSTHROUGH" escape is supported}
    testInt := PASSTHROUGH;
    try
      Result:= Escape(Printer.Handle, QUERYESCSUPPORT, sizeof(testInt), @testInt, Nil) > 0;
    except raise;
    end;
  end;

begin
   {If Api is unsupported, then exit}
   if not checkPrinter then Exit;

   //StrPCopy(PassThroughData.Buffer,#27+ToSend);
   StrPCopy(PassThroughData.Buffer,ToSend);
   { Set the buffer length }
   PassThroughData.BuffLength := StrLen(PassThroughData.Buffer);

   { Make the escape}
   Printer.BeginDoc;
   Escape(Printer.Handle, PASSTHROUGH, 0, @PassThroughData, nil);
   Printer.EndDoc;
end;

function MustRegister(): boolean;
begin
  Result:= DEMO_VERSION;
  if Result then Inform('Register please.');
end;

{ TTextRotate }

constructor TTextRotate.Create;
begin
  inherited Create;
  FText:= 'Angled Text';
  FFontName:= 'Arial';
  FFontSize:= 8;
  FAngel:= 90;
end;

destructor TTextRotate.Destroy;
begin

  inherited;
end;

procedure TTextRotate.DrawText(ACanvas: TCanvas);
var logFont: TLogFont; vFont: TFont; x: integer;
begin
  with ACanvas do
  begin
    vFont:= TFont.Create;
    try
      Font.Name:= FFontName;
      Font.Size:= FontSize;
      vFont.Assign(Font);
      GetObject(vFont.Handle, SizeOf(logFont), @logFont);
      logFont.lfEscapement  :=  10 * Angel;
      logFont.lfOrientation :=  10 * Angel;
      SetBkMode(Handle, TRANSPARENT);
      vFont.Handle := CreateFontIndirect(logFont);
      Font.Assign(vFont);
    finally
      vFont.Free;
    end;
    x:= TextWidth(Text);
    x:= (ClipRect.Bottom  + x) div 2 ;
    TextOut(ClipRect.Left, x, Text);
  end;
end;

function screenLessThen1024X768: Boolean;
const
  sc_height: real = 768;
  sc_width : real = 1024;
var x, y: Longint;
begin
  x:= GetSystemMetrics(SM_CXSCREEN);
  y:= GetSystemMetrics(SM_CYSCREEN);
  Result:= (y < sc_height) or (x < sc_width);
end;

function MyTCPIPAddress : longint;
var
  buf : array [0..255] of char;
  RemoteHost : PHostEnt;
begin
  Winsock.GetHostName(@buf, 255);
  RemoteHost:=Winsock.GetHostByName(buf);
  if RemoteHost=NIL then
    MyTCPIPAddress := winsock.htonl($07000001) { 127.0.0.1 }
  else
    MyTCPIPAddress := longint(pointer(RemoteHost^.h_addr_list^)^);
  Result := Winsock.ntohl(Result);
end;

function LocalIP: String;
type
  TaPInAddr = Array[0..10] of PInAddr;
  PaPInAddr = ^TaPInAddr;
var
  phe: PHostEnt;
  pptr: PaPInAddr;
  Buffer: Array[0..63] of Char;
  I: Integer;
  GInitData: TWSAData;
begin
  WSAStartup($101, GInitData);
  Result := '';
  GetHostName(Buffer, SizeOf(Buffer));
  phe := GetHostByName(buffer);
  if phe = nil then Exit;
  pPtr := PaPInAddr(phe^.h_addr_list);
  I := 0;
  while pPtr^[I] <> nil do
  begin
    Result := inet_ntoa(pptr^[I]^);
    Inc(I);
  end;
  WSACleanup;
end;


function ExtractEsccode(ls: TStringList): string;
var i: integer; s, code: string;
begin
  s:= '';
  ls.Text:= AnsiReplaceStr(ls.Text, '+', #13#10);
  for i:= 0 to ls.Count-1 do begin
    code:= ls.Strings[i];
    if LeftStr(code,1) = '#' then begin
      delete(code,1,1);
      code:= chr(StrToInt(code));
    end;
    s:= s + code;
  end;
  s:= AnsiReplaceStr(s, '''','');
  Result:= s;
end;

procedure getPrinterList(l: TStrings);
begin
  l.Clear;
  l.AddStrings(Printer.Printers);
end;

procedure setDefaultPrinter(priterNama: string);
var resStr: array[0..255] of char;
begin
  StrPCopy(resStr, priterNama);
  WriteProfileString('windows', 'device', resStr);
  StrCopy(resStr, 'windows');
  SendMessage(HWND_BROADCAST, WM_WININICHANGE, 0, longint(@resStr));
end;

procedure setDefaultPrinter3(priterNama: string);
var
  Device: array [0..255] of Char;
  Driver: array [0..255] of Char;
  Port: array [0..255] of Char;
  hDeviceMode: THandle;

begin
  Printer.PrinterIndex := 1; {select printer to make default}
  Printer.GetPrinter(Device, Driver, Port, hDeviceMode);
  StrCat(Device, ',');
  StrCat(Device, Driver);
  StrCat(Device, ',');
  StrCat(Device, Port);
  WriteProfileString('windows', 'device', Device);
  StrCopy(Device, 'windows');
  SendMessage(HWND_BROADCAST, WM_WININICHANGE, 0, longint(@Device))
end;

function getDefaultPrinter: string;
var resStr: array[0..255] of char;
begin
  GetProfileString('windows', 'device', '', resStr, 255);
  Result:= StrPas(resStr)
end;

function setDefaultPrinter2(priterNama: string): string;
var str: array[0..79]of Char;
  function FetchStr(s:string):string;
  var i: Integer;
  begin
    s:= TrimLeft(s);
    i:= Pos(',',s);
    if i=0
     then Result:= s
     else Result:= Copy(s, 1, i-1);
  end;
begin
  GetProfileString('windows', 'device', '', str, SizeOf(str)-1);
  Result:= FetchStr(str);
  //Result:= (fPrinterName<>'');
end;

function CaptionPeriode(op1:TSQLOperator;Date1:TDate;Date2:TDate):string;
var hasil : string;
begin
   hasil := 'Periode Global';
   if (Date1 <> 0) and (Date2 <> 0) then
     hasil := 'Periode '+FormatDateTime('dd MMMM yyyy',Date1) + ' s/d '+FormatDateTime('dd MMMM yyyy',Date2)
   else if Date1<> 0 then begin
     if op1 = soEquals then
       hasil := 'Per Tanggal '+ FormatDateTime('dd MMMM yyyy',Date1)
     else if (op1 = soGreaterThanEqualsTo) or (op1 = soGreaterThan) then
       hasil := 'Periode Dari '+ FormatDateTime('dd MMMM yyyy',Date1)+' Sampai Sekarang'
     else if (op1 = soLessThanEqualsTo) or (op1=soLessThan) then
       hasil := 'Periode Awal s/d '+ FormatDateTime('dd MMMM yyyy',Date1);
   end;
   Result := hasil;
end;

function CaptionPeriode2(op1:TSQLOperator; Date1:TDate;Date2:TDate):string;
begin
   Result := 'Periode Global';
   if (Date1 <> 0) and (Date2 <> 0) then
     Result := 'Periode '+FormatDateTime('MMMM yyyy',Date1) + ' s/d '+FormatDateTime('MMMM yyyy',Date2)
   else if Date1<> 0 then begin
     if op1 = soEquals then
       Result := 'Per Tanggal '+ FormatDateTime('dd MMMM yyyy',Date1)
     else if (op1 = soGreaterThanEqualsTo) or (op1 = soGreaterThan) then
       Result := 'Periode Dari '+ FormatDateTime('MMMM yyyy',Date1)+' Sampai Sekarang'
     else if (op1 = soLessThanEqualsTo) or (op1=soLessThan) then
       Result := 'Periode Awal s/d '+ FormatDateTime('MMMM yyyy',Date1);
   end;
end;

function CaptPeriodeShort(op1:TSQLOperator; Date1:TDate;Date2:TDate):string;
begin
  Result := 'Periode Global';
  if (Date1 <> 0) and (Date2 <> 0) then
   Result := 'Periode '+FormatDateTime('dd-MM-yy',Date1) + ' s/d '+FormatDateTime('dd-MM-yy',Date2)
  else if Date1<> 0 then begin
   if op1 = soEquals then
     Result := 'Per Tgl '+ FormatDateTime('dd-MM-yy',Date1)
   else if (op1 = soGreaterThanEqualsTo) or (op1 = soGreaterThan) then
     Result := 'Periode Dari '+ FormatDateTime('dd-MM-yy',Date1)+' s/d Sekarang'
   else if (op1 = soLessThanEqualsTo) or (op1=soLessThan) then
     Result := 'Periode Awal s/d '+ FormatDateTime('dd-MM-yy',Date1);
  end;
end;

function Kuadrat(n: real; Counter: integer): real;
var tmp: real; i: integer;
begin
  tmp:= n;
  for i := 1  to Counter-1 do
    tmp:= tmp * n;
  Result:= tmp;
end;

function deleteThousandSeparator(value: string; sparator: char): string;
var i: integer;
begin
  for i:= 0 to length(value) do
    if copy(value,length(value) - (length(value) -i),1) = sparator then
      Delete(value,i,1);
  Result:= value;
end;

function ExtractDateLama(ABeginDate, AEndDate: TDate; AInterval: word): arString;
var Year, Month, Day: word; span: double; current: TDate; str: string;
  idx: integer;

  function convert_to_string(value: word): string;
  begin
    if Month < 10 then
      Result:= '0' + IntToStr(Month)
    else Result:= IntToStr(Month);
  end;

begin
  DecodeDate(ABeginDate, Year, Month, Day);

  span:= round(MonthSpan(ABeginDate, AEndDate));
  idx:= 0;
  while span > 0 do begin
    str:= IntToStr(Year) + convert_to_string(Month) + IfThen(AInterval <> 1, '-');

    Month:= Month + AInterval;
    if (Month) > 12 then begin
      Month:= Month - 12;
      Year:= Year + 1;
    end;

    current:= EncodeDate(Year, Month, 1);
    DecodeDate(current, Year, Month, Day);

    if AInterval = 1 then
    begin
      SetLength(Result, idx+1);
      Result[idx]:= str;
      Inc(idx);
      str:= IntToStr(Year) + convert_to_string(Month);

      if span = 1 then Exit;
    end else
      str:= str + IntToStr(Year) + convert_to_string(Month);

    Inc(Month);
    span:= span - AInterval - 1;

    SetLength(Result, idx+1);
    Result[idx]:= str;
    Inc(idx);
  end;
end;

function ExtractDate(ABeginDate, AEndDate: TDate; AInterval: word): arString;
var Year, Month, Day: word; span: double; current: TDate; str: string;
  idx: integer;

  function convert_to_string(value: word): string;
  begin
    if Month < 10 then
      Result:= '0' + IntToStr(Month)
    else Result:= IntToStr(Month);
  end;

begin
  DecodeDate(ABeginDate, Year, Month, Day);

  span:= round(MonthSpan(ABeginDate, AEndDate));
  idx:= 0;
  while span > 0 do begin
    str:= IntToStr(Year) + convert_to_string(Month) + IfThen(AInterval <> 1, '-');

    if AInterval > 1 then
      Month:= Month + AInterval-1
    else Month:= Month + AInterval;

    if (Month) > 12 then begin
      Month:= Month - 12;
      Year:= Year + 1;
    end;

    current:= EncodeDate(Year, Month, 1);
    DecodeDate(current, Year, Month, Day);

    if AInterval = 1 then
    begin
      SetLength(Result, idx+1);
      Result[idx]:= str;
      Inc(idx);
      str:= IntToStr(Year) + convert_to_string(Month);

      if span = 1 then Exit;
    end else
      str:= str + IntToStr(Year) + convert_to_string(Month);

    Inc(Month);

    if (Month) > 12 then begin
      Month:= Month - 12;
      Year:= Year + 1;
    end;

    if AInterval = 1 then
      span:= span - AInterval-1
    else span:= span - AInterval;

    SetLength(Result, idx+1);
    Result[idx]:= str;
    Inc(idx);
  end;
end;

procedure SetButtonsCaption(Sender: TForm; EditMode: boolean);
var i: integer; Button: TButton;
begin
  for i:= 0 to Sender.ComponentCount-1 do begin
    if Sender.Components[i] is TButton then begin
       Button:= Sender.Components[i] as TButton;
       if Button.Name = 'btnSave' then
         Button.Caption:= IfThen(EditMode, BUTTON_PRINT, BUTTON_SAVE)
       else if Button.Name = 'btnInsert' then
         Button.Caption:= IfThen(EditMode, BUTTON_EDIT, BUTTON_SAVE)
       else if Button.Name = 'btnCancel' then
         Button.Caption:= BUTTON_CANCEL
       else if Button.Name = 'btnDelete' then
         Button.Caption:= BUTTON_DELETE
       else if Button.Name = 'btnLoad' then
         Button.Caption:= BUTTON_LOAD
       else if Button.Name = 'btnReset' then
         Button.Caption:= BUTTON_RESET
       else if Button.Name = 'btnFilter' then
         Button.Caption:= BUTTON_FILTER_SHOW
       else if Button.Name = 'btnAdd' then
         Button.Caption:= BUTTON_ADD
       else if Button.Name = 'btnDetail' then
         Button.Caption:= BUTTON_DETAIL
       else if Button.Name = 'btnFind' then
         Button.Caption:= BUTTON_FIND
       else if Button.Name = 'btnPrint' then
         Button.Caption:= IfThen(EditMode, BUTTON_OK, BUTTON_PRINT)
       else if Button.Name = 'btnCetak' then
         Button.Caption:= BUTTON_PRINT
       else if Button.Name = 'btnOk' then
         Button.Caption:= BUTTON_OK
       else if Button.Name = 'btnEdit' then
         Button.Caption:= BUTTON_EDIT_DETAIL
    end;
  end;
end;

function GetHyperText(vHyperText: string): string;
begin
  Result:= EkstrakString(vHyperText,'>',2);
  Result:= EkstrakString(Result,'<',1);
end;

function PointToComma(Key: Char): Char;
begin
  if key = char('.') then result := char(',')
  else result := char(key)
end;


function ConvertToSaveConvertion(vConverted, vConverter: double): double;
begin
  Result:= vConverted * vConverter;
end;

function ConvertToLoadConvertion(vConverted, vConverter: double): double;
begin
  Result:= vConverted / vConverter;
end;



procedure printBitmap(Source: TBitmap; AText: string;rawPrinter:TRAWPrinter;var ls:TStringList);
var
  x, y: integer;
  v: byte;
  s: string;
  b: TBitmap;
  udahDitambah: boolean;
//  RawPrinter: TRAWPrinter;
begin
  b := TBitmap.Create;
  b.Assign(Source);
  b.Monochrome := true;
//RawPrinter := TRAWPrinter.Create(nil);

  //chan  with rawPrinter do
//chan    begin
//    EjectOnFinish := false;
//    CommandType := rpcEpson;
 //   FontName  := rfnSanserif;
  //  FontPitch := rfpNormal;
 
//chan      BeginDoc;
    // s := #27'@';  //reset setting printer
    s := '';
//    WriteToPrinter(s, length(s));
   // WriteToPrinter(s, length(s));
    y := 0;
    udahDitambah := False;
    while (y < b.Height) do
    begin
      s := #27#42#0 + Chr(LoByte(b.Width)) + Chr(HiByte(b.Width));
      for x := 0 to b.Width do
      begin
        v := 0;
        if (b.Canvas.Pixels[x, y] = clBlack) then v := v + 128;
        if (b.Canvas.Pixels[x, y + 1] = clBlack) then v := v + 64;
        if (b.Canvas.Pixels[x, y + 2] = clBlack) then v := v + 32;
        if (b.Canvas.Pixels[x, y + 3] = clBlack) then v := v + 16;
        if (b.Canvas.Pixels[x, y + 4] = clBlack) then v := v + 8;
        if (b.Canvas.Pixels[x, y + 5] = clBlack) then v := v + 4;
        if (b.Canvas.Pixels[x, y + 6] = clBlack) then v := v + 2;
        if (b.Canvas.Pixels[x, y + 7] = clBlack) then v := v + 1;
        s := s + chr(v);
      end;
      if (((y + 16) > b.Height) and (not udahDitambah)) then
      begin
        s := s + (AText);
        udahDitambah := True;
      end;
      s := s + #27'3'#24;
//chan      s := s + #13#10;
      // showmessage(s);
      //WriteToPrinter(s, length(s));
     ls.Append(FixWidth(' ', 5, taLeftJustify)+s);
      inc(y, 8);
    end;

    //RawPrinter.Free;
  //chan    EndDoc;
  //chan  end;


  FreeAndNil(b);

end;


function bulatKeAtas(value: double): double;
var s: string;
begin
  s:= FloatToStr(value);
  s:= EkstrakString(s, DecimalSeparator, 2);
  if s <> '' then s:= s[1]
  else s:= '9';
  if StrToIntDef(s,0) < 5 then Result:= Round(value)+1
  else Result:= Round(value);
end;

initialization
  GlobalSystemMenu_Arr := TSystemMenu_Arr.Create;
  GlobalStringList:= TStringList.Create;

  GlobalSystemUser := TSystemUser.Create;
  GlobalSystemUser.SystemAccess_Arr := TSystemAccess_Arr.Create(GlobalSystemUser);

  GlobalPeriode  := TPeriode.Create;
  GlobalFilter  := TFilters.Create;
  CompanyProfile:= TMstCompany.Create;

  GlobalSystemConfig:= TSystemConfig_Arr.Create;
  //getConfigItemBalace;

finalization
  GlobalSystemUser.SystemAccess_Arr.Destroy;
  GlobalSystemUser.Destroy;
  GlobalSystemMenu_Arr.Destroy;
  GlobalStringList.Free;
  GlobalPeriode.Free;
  GlobalFilter.Free;
  CompanyProfile.Free;
  GlobalSystemConfig.Free;
end.


