(****************************************************************************
*                                                                           *
* HtmlHelp.h v1.3b                                                          *
*                                                                           *
* Copyright (c) 1996-1997, Microsoft Corp. All rights reserved.             *
*                                                                           *
* HtmlHelp.pas                                                              *
*                                                                           *
* Ufuk Keskinoz,  ufukk@boun.net                                            *
* Last Update : 2002 May, Istanbul                                          *
*                                                                           *
****************************************************************************)

// Basic Usage :
// Application.HelpFile := 'c:\Documents and Settings\Administrator\Desktop\htmlhelp\api.chm';
// HH(HH_DISPLAY_TOPIC, 0) ;
//
// or
//
// HH(0, 'c:\Documents and Settings\Administrator\Desktop\htmlhelp\api.chm',
//    HH_DISPLAY_TOPIC, 0) ;


unit HtmlHlp;

interface

uses
  Types, Graphics, Windows, Forms, SysUtils;

// Commands to pass to HtmlHelp()
const
  HH_DISPLAY_TOPIC        =$0000;
  HH_HELP_FINDER          =$0000;  // WinHelp equivalent
  HH_DISPLAY_TOC          =$0001;
  HH_DISPLAY_INDEX        =$0002;
  HH_DISPLAY_SEARCH       =$0003;
  HH_SET_WIN_TYPE         =$0004;
  HH_GET_WIN_TYPE         =$0005;
  HH_GET_WIN_HANDLE       =$0006;
  HH_ENUM_INFO_TYPE       =$0007;  // Get Info type name, call repeatedly to enumerate, -1 at end
  HH_SET_INFO_TYPE        =$0008;  // Add Info type to filter.
  HH_SYNC                 =$0009;
  HH_RESERVED1            =$000A;
  HH_RESERVED2            =$000B;
  HH_RESERVED3            =$000C;
  HH_KEYWORD_LOOKUP       =$000D;
  HH_DISPLAY_TEXT_POPUP   =$000E;  // display string resource id or text in a popup window
  HH_HELP_CONTEXT         =$000F;  // display mapped numeric value in dwData
  HH_TP_HELP_CONTEXTMENU  =$0010;  // text popup help, same as WinHelp HELP_CONTEXTMENU
  HH_TP_HELP_WM_HELP      =$0011;  // text popup help, same as WinHelp HELP_WM_HELP
  HH_CLOSE_ALL            =$0012;  // close all windows opened directly or indirectly by the caller
  HH_ALINK_LOOKUP         =$0013;  // ALink version of HH_KEYWORD_LOOKUP
  HH_GET_LAST_ERROR       =$0014;  // not currently implemented // See HHERROR.h
  HH_ENUM_CATEGORY        =$0015;  // Get category name, call repeatedly to enumerate, -1 at end
  HH_ENUM_CATEGORY_IT     =$0016;  // Get category info type members, call repeatedly to enumerate, -1 at end
  HH_RESET_IT_FILTER      =$0017;  // Clear the info type filter of all info types.
  HH_SET_INCLUSIVE_FILTER =$0018;  // set inclusive filtering method for untyped topics to be included in display
  HH_SET_EXCLUSIVE_FILTER =$0019;  // set exclusive filtering method for untyped topics to be excluded from display
  HH_INITIALIZE           =$001C;  // Initializes the help system.
  HH_UNINITIALIZE         =$001D;  // Uninitializes the help system.
  HH_PRETRANSLATEMESSAGE  =$00fd;  // Pumps messages. (NULL, NULL, MSG*).
  HH_SET_GLOBAL_PROPERTY  =$00fc;  // Set a global property. (NULL, NULL, HH_GPROP)

  HHWIN_PROP_TAB_AUTOHIDESHOW = (0 shl 1);    // Automatically hide/show tri-pane window
  HHWIN_PROP_ONTOP            = (1 shl 1);     // Top-most window
  HHWIN_PROP_NOTITLEBAR       = (2 shl 1);     // no title bar
  HHWIN_PROP_NODEF_STYLES     = (3 shl 1);     // no default window styles (only HH_WINTYPE.dwStyles)
  HHWIN_PROP_NODEF_EXSTYLES   = (4 shl 1);     // no default extended window styles (only HH_WINTYPE.dwExStyles)
  HHWIN_PROP_TRI_PANE         = (5 shl 1);     // use a tri-pane window
  HHWIN_PROP_NOTB_TEXT        = (6 shl 1);     // no text on toolbar buttons
  HHWIN_PROP_POST_QUIT        = (7 shl 1);     // post WM_QUIT message when window closes
  HHWIN_PROP_AUTO_SYNC        = (8 shl 1);     // automatically ssync contents and index
  HHWIN_PROP_TRACKING         = (9 shl 1);     // send tracking notification messages
  HHWIN_PROP_TAB_SEARCH       = (10 shl 1);    // include search tab in navigation pane
  HHWIN_PROP_TAB_HISTORY      = (11 shl 1);    // include history tab in navigation pane
  HHWIN_PROP_TAB_FAVORITES    = (12 shl 1);    // include favorites tab in navigation pane
  HHWIN_PROP_CHANGE_TITLE     = (13 shl 1);    // Put current HTML title in title bar
  HHWIN_PROP_NAV_ONLY_WIN     = (14 shl 1);    // Only display the navigation window
  HHWIN_PROP_NO_TOOLBAR       = (15 shl 1);    // Don't display a toolbar
  HHWIN_PROP_MENU             = (16 shl 1);    // Menu
  HHWIN_PROP_TAB_ADVSEARCH    = (17 shl 1);    // Advanced FTS UI.
  HHWIN_PROP_USER_POS         = (18 shl 1);    // After initial creation, user controls window size/position
  HHWIN_PROP_TAB_CUSTOM1      = (19 shl 1);    // Use custom tab #1
  HHWIN_PROP_TAB_CUSTOM2      = (20 shl 1);    // Use custom tab #2
  HHWIN_PROP_TAB_CUSTOM3      = (21 shl 1);    // Use custom tab #3
  HHWIN_PROP_TAB_CUSTOM4      = (22 shl 1);    // Use custom tab #4
  HHWIN_PROP_TAB_CUSTOM5      = (23 shl 1);    // Use custom tab #5
  HHWIN_PROP_TAB_CUSTOM6      = (24 shl 1);    // Use custom tab #6
  HHWIN_PROP_TAB_CUSTOM7      = (25 shl 1);    // Use custom tab #7
  HHWIN_PROP_TAB_CUSTOM8      = (26 shl 1);    // Use custom tab #8
  HHWIN_PROP_TAB_CUSTOM9      = (27 shl 1);    // Use custom tab #9
  HHWIN_TB_MARGIN             = (28 shl 1);    // the window type has a margin

  HHWIN_PARAM_PROPERTIES      = (1 shl 1);     // valid fsWinProperties
  HHWIN_PARAM_STYLES          = (2 shl 1);     // valid dwStyles
  HHWIN_PARAM_EXSTYLES        = (3 shl 1);     // valid dwExStyles
  HHWIN_PARAM_RECT            = (4 shl 1);     // valid rcWindowPos
  HHWIN_PARAM_NAV_WIDTH       = (5 shl 1);     // valid iNavWidth
  HHWIN_PARAM_SHOWSTATE       = (6 shl 1);     // valid nShowState
  HHWIN_PARAM_INFOTYPES       = (7 shl 1);     // valid apInfoTypes
  HHWIN_PARAM_TB_FLAGS        = (8 shl 1);     // valid fsToolBarFlags
  HHWIN_PARAM_EXPANSION       = (9 shl 1);     // valid fNotExpanded
  HHWIN_PARAM_TABPOS          = (10 shl 1);    // valid tabpos
  HHWIN_PARAM_TABORDER        = (11 shl 1);    // valid taborder
  HHWIN_PARAM_HISTORY_COUNT   = (12 shl 1);    // valid cHistory
  HHWIN_PARAM_CUR_TAB         = (13 shl 1);    // valid curNavType

  HHWIN_BUTTON_EXPAND         = (1 shl 1);     // Expand/contract button
  HHWIN_BUTTON_BACK           = (2 shl 1);     // Back button
  HHWIN_BUTTON_FORWARD        = (3 shl 1);     // Forward button
  HHWIN_BUTTON_STOP           = (4 shl 1);     // Stop button
  HHWIN_BUTTON_REFRESH        = (5 shl 1);     // Refresh button
  HHWIN_BUTTON_HOME           = (6 shl 1);     // Home button
  HHWIN_BUTTON_BROWSE_FWD     = (7 shl 1);     // not implemented
  HHWIN_BUTTON_BROWSE_BCK     = (8 shl 1);     // not implemented
  HHWIN_BUTTON_NOTES          = (9 shl 1);     // not implemented
  HHWIN_BUTTON_CONTENTS       = (10 shl 1);    // not implemented
  HHWIN_BUTTON_SYNC           = (11 shl 1);    // Sync button
  HHWIN_BUTTON_OPTIONS        = (12 shl 1);    // Options button
  HHWIN_BUTTON_PRINT          = (13 shl 1);    // Print button
  HHWIN_BUTTON_INDEX          = (14 shl 1);    // not implemented
  HHWIN_BUTTON_SEARCH         = (15 shl 1);    // not implemented
  HHWIN_BUTTON_HISTORY        = (16 shl 1);    // not implemented
  HHWIN_BUTTON_FAVORITES      = (17 shl 1);    // not implemented
  HHWIN_BUTTON_JUMP1          = (18 shl 1); 
  HHWIN_BUTTON_JUMP2          = (19 shl 1); 
  HHWIN_BUTTON_ZOOM           = (20 shl 1); 
  HHWIN_BUTTON_TOC_NEXT       = (21 shl 1); 
  HHWIN_BUTTON_TOC_PREV       = (22 shl 1); 

  HHWIN_DEF_BUTTONS  =  (HHWIN_BUTTON_EXPAND OR
                         HHWIN_BUTTON_BACK OR
                         HHWIN_BUTTON_OPTIONS OR
                         HHWIN_BUTTON_PRINT);

// Button IDs

  IDTB_EXPAND             = 200;
  IDTB_CONTRACT           = 201;
  IDTB_STOP               = 202;
  IDTB_REFRESH            = 203;
  IDTB_BACK               = 204;
  IDTB_HOME               = 205;
  IDTB_SYNC               = 206;
  IDTB_PRINT              = 207;
  IDTB_OPTIONS            = 208;
  IDTB_FORWARD            = 209;
  IDTB_NOTES              = 210; // not implemented
  IDTB_BROWSE_FWD         = 211;
  IDTB_BROWSE_BACK        = 212;
  IDTB_CONTENTS           = 213; // not implemented
  IDTB_INDEX              = 214; // not implemented
  IDTB_SEARCH             = 215; // not implemented
  IDTB_HISTORY            = 216; // not implemented
  IDTB_FAVORITES          = 217; // not implemented
  IDTB_JUMP1              = 218;
  IDTB_JUMP2              = 219;
  IDTB_CUSTOMIZE          = 221;
  IDTB_ZOOM               = 222;
  IDTB_TOC_NEXT           = 223;
  IDTB_TOC_PREV           = 224;

// Notification codes

  HHN_FIRST         = Cardinal(0 - 860);
  HHN_LAST          = Cardinal(0 - 879);

  HHN_NAVCOMPLETE   = (HHN_FIRST - 0);
  HHN_TRACK         = (HHN_FIRST - 1);
  HHN_WINDOW_CREATE = (HHN_FIRST - 2);

type
   HWnd = THandle;

   NMHDR = record
    hwndFrom : HWND;
    idFrom   : Integer;
    code     : Integer;
   end;

   HHN_Notify = record
    hdr    : NMHDR;
    pszUrl : PWideChar; // PWideChar
   end;

   HH_Popup = record
    cbStruct      : Integer;  // sizeof this structure
    hinst         : THandle;  // instance handle for string resource
    idString      : Cardinal; // string resource id, or text id if pszFile is specified in HtmlHelp call
    pszText       : PChar;    // used if idString is zero
    pt            : TPoint;   // top center of popup window
    clrForeground : TColor;   // use -1 for default
    clrBackground : TColor;   // use -1 for default
    rcMargins     : TRect;    // amount of space between edges of window and text, -1 for each member to ignore
    pszFont       : PChar;    // facename, point size, char set, BOLD ITALIC UNDERLINE
   end;

   HH_AKLINK = record
    cbStruct     : Integer; // sizeof this structure
    fReserved    : Boolean;    // must be FALSE (really!)
    pszKeywords  : PChar;   // semi-colon separated keywords
    pszUrl       : PChar;   // URL to jump to if no keywords found (may be NULL)
    pszMsgText   : PChar;   // Message text to display in MessageBox if pszUrl is NULL and no keyword match
    pszMsgTitle  : PChar;   // Message text to display in MessageBox if pszUrl is NULL and no keyword match
    pszWindow    : PChar;   // Window to display URL in
    fIndexOnFail : Boolean;    // Displays index if keyword lookup fails.
   end;

   HHWin_NavTypes = (HHWIN_NAVTYPE_TOC,
                     HHWIN_NAVTYPE_INDEX,
                     HHWIN_NAVTYPE_SEARCH,
                     HHWIN_NAVTYPE_FAVORITES,
                     HHWIN_NAVTYPE_HISTORY,   // not implemented
                     HHWIN_NAVTYPE_AUTHOR,
                     HHWIN_NAVTYPE_CUSTOM_FIRST = 11);

   ITTypes = (IT_INCLUSIVE, IT_EXCLUSIVE, IT_HIDDEN);

   PHH_ENUM_IT = ^HH_ENUM_IT;
   HH_ENUM_IT = record
    cbStruct         : Integer; // size of this structure
    iType            : Integer; // the type of the information type ie. Inclusive, Exclusive, or Hidden
    pszCatName       : PChar;   // Set to the name of the Category to enumerate the info types in a category; else NULL
    pszITName        : PChar;   // volitile pointer to the name of the infotype. Allocated by call. Caller responsible for freeing
    pszITDescription : PChar;   // volitile pointer to the description of the infotype.
   end;

   PHH_ENUM_CAT = ^HH_ENUM_CAT;
   HH_ENUM_CAT = record
    cbStruct          : Integer; // size of this structure
    pszCatName        : PChar;   // volitile pointer to the category name
    pszCatDescription : PChar;   // volitile pointer to the category description
   end;

  PHH_SET_INFOTYPE = ^HH_SET_INFOTYPE;
  HH_SET_INFOTYPE = record
   cbStruct        : Integer; // the size of this structure
   pszCatName      : PChar;   // the name of the category, if any, the InfoType is a member of.
   pszInfoTypeName : PChar;   // the name of the info type to add to the filter
  end;

 PHH_INFOTYPE = ^HH_INFOTYPE;
 HH_INFOTYPE = DWORD;

 HHWIN_NAVTABS = (HHWIN_NAVTAB_TOP, HHWIN_NAVTAB_LEFT, HHWIN_NAVTAB_BOTTOM);

CONST
 HH_MAX_TABS = 19;  // maximum number of tabs

type
 HH_TABS = (HH_TAB_CONTENTS, HH_TAB_INDEX, HH_TAB_SEARCH,
            HH_TAB_FAVORITES, HH_TAB_HISTORY, HH_TAB_AUTHOR,
            HH_TAB_CUSTOM_FIRST = 11, HH_TAB_CUSTOM_LAST = HH_MAX_TABS);
const
 HH_MAX_TABS_CUSTOM = HH_MAX_TABS;// (HH_TAB_CUSTOM_LAST - HH_TAB_CUSTOM_FIRST + 1);

// HH_DISPLAY_SEARCH Command Related Structures and Constants

 HH_FTS_DEFAULT_PROXIMITY = (-1);

type

 HH_FTS_QUERY = record
  cbStruct        : Integer; // Sizeof structure in bytes.
  fUniCodeStrings : Boolean; // TRUE if all strings are unicode.
  pszSearchQuery  : PChar;   // String containing the search query.
  iProximity      : LongInt; // Word proximity.
  fStemmedSearch  : Boolean; // TRUE for StemmedSearch only.
  fTitleOnly      : Boolean; // TRUE for Title search only.
  fExecute        : Boolean; // TRUE to initiate the search.
  pszWindow       : PChar;   // Window to display in
 end;

// HH_WINTYPE Structure
 PHH_WINTYPE = ^HH_WINTYPE;
 HH_WINTYPE = record
  cbStruct        : Integer;     // IN: size of this structure including all Information Types
  fUniCodeStrings : Boolean;     // IN/OUT: TRUE if all strings are in UNICODE
  pszType         : PChar;       // IN/OUT: Name of a type of window
  fsValidMembers  : DWord;       // IN: Bit flag of valid members (HHWIN_PARAM_)
  fsWinProperties : DWord;       // IN/OUT: Properties/attributes of the window (HHWIN_)

  pszCaption      : PChar;        // IN/OUT: Window title
  dwStyles        : DWord;        // IN/OUT: Window styles
  dwExStyles      : DWord;        // IN/OUT: Extended Window styles
  rcWindowPos     : TRect;        // IN: Starting position, OUT: current position
  nShowState      : Integer;      // IN: show state (e.g., SW_SHOW)

  hwndHelp        : HWnd;         // OUT: window handle
  hwndCaller      : HWnd;         // OUT: who called this window

  paInfoTypes     : ^HH_INFOTYPE; // IN: Pointer to an array of Information Types

  // The following members are only valid if HHWIN_PROP_TRI_PANE is set

  hwndToolBar    : HWnd;    // OUT: toolbar window in tri-pane window
  hwndNavigation : HWnd;    // OUT: navigation window in tri-pane window
  hwndHTML       : HWnd;    // OUT: window displaying HTML in tri-pane window
  iNavWidth      : Integer; // IN/OUT: width of navigation window
  rcHTML         : TRect;   // OUT: HTML window coordinates

  pszToc         : PChar;   // IN: Location of the table of contents file
  pszIndex       : PChar;   // IN: Location of the index file
  pszFile        : PChar;   // IN: Default location of the html file
  pszHome        : PChar;   // IN/OUT: html file to display when Home button is clicked
  fsToolBarFlags : DWord;   // IN: flags controling the appearance of the toolbar
  fNotExpanded   : Boolean; // IN: TRUE/FALSE to contract or expand, OUT: current state
  curNavType     : Integer; // IN/OUT: UI to display in the navigational pane
  tabpos         : Integer; // IN/OUT: HHWIN_NAVTAB_TOP, HHWIN_NAVTAB_LEFT, or HHWIN_NAVTAB_BOTTOM
  idNotify       : Integer; // IN: ID to use for WM_NOTIFY messages
  tabOrder       : Array [0..HH_MAX_TABS + 1] of Byte; // IN/OUT: tab order: Contents, Index, Search, History, Favorites, Reserved 1-5, Custom tabs
  cHistory       : Integer; // IN/OUT: number of history items to keep (default is 30)
  pszJump1       : PChar;   // Text for HHWIN_BUTTON_JUMP1
  pszJump2       : PChar;   // Text for HHWIN_BUTTON_JUMP2
  pszUrlJump1    : PChar;   // URL for HHWIN_BUTTON_JUMP1
  pszUrlJump2    : PChar;   // URL for HHWIN_BUTTON_JUMP2
  rcMinSize      : TRect;   // Minimum size for window (ignored in version 1)
  cbInfoTypes    : Integer; // size of paInfoTypes;
  pszCustomTabs  : PChar;   // multiple zero-terminated strings
 end;
 HHACT_TABS = (HHACT_TAB_CONTENTS, HHACT_TAB_INDEX, HHACT_TAB_SEARCH, HHACT_TAB_HISTORY,
               HHACT_TAB_FAVORITES, HHACT_EXPAND, HHACT_CONTRACT, HHACT_BACK,
               HHACT_FORWARD, HHACT_STOP, HHACT_REFRESH, HHACT_HOME, HHACT_SYNC,
               HHACT_OPTIONS, HHACT_PRINT, HHACT_HIGHLIGHT, HHACT_CUSTOMIZE,
               HHACT_JUMP1, HHACT_JUMP2, HHACT_ZOOM, HHACT_TOC_NEXT, HHACT_TOC_PREV,
               HHACT_NOTES, HHACT_LAST_ENUM);

 PHHNTRACK = ^HHNTRACK;
 HHNTRACK = record
  hdr        : NMHDR;
  pszCurUrl  : PChar;       // Multi-byte, null-terminated string
  idAction   : Integer;     // HHACT_ value
  phhWinType : ^HH_WINTYPE; // Current window type structure
 end;

type
     THtmlHelpA = function(hwndCaller : THandle; pszFile : PChar; uCommand : cardinal; dwData : longint) : THandle; stdCall;
     THtmlHelpW = function(hwndCaller : THandle; pszFile : PChar; uCommand : cardinal; dwData : longint) : THandle; stdCall;


// Use the following for GetProcAddress to load from hhctrl.ocx
const
 ATOM_HTMLHELP_API_ANSI    = PChar(DWORD(WORD(14)));
 ATOM_HTMLHELP_API_UNICODE = PChar(DWORD(WORD(15)));


///////////////////////////////////////////////////////////////////////////////
//
// Global Control Properties.
//
type
 HH_GPROPID = (HH_GPROPID_SINGLETHREAD=1,      // VARIANT_BOOL: True for single thread
               HH_GPROPID_TOOLBAR_MARGIN=2,    // long: Provides a left/right margin around the toolbar.
               HH_GPROPID_UI_LANGUAGE=3,       // long: LangId of the UI.
               HH_GPROPID_CURRENT_SUBSET=4,    // BSTR: Current subset.
               HH_GPROPID_CONTENT_LANGUAGE=5   // long: LandId for desired content.
               );

///////////////////////////////////////////////////////////////////////////////
//
// Global Property structure
//

 HH_GLOBAL_PROPERTY = record
  id   : HH_GPROPID;
  vvar : Variant;
 end;

function HH(uCommand : Cardinal; dwData : longint) : THandle; overload;
function HH(hwndCaller : THandle; pszFile : PChar; uCommand : Cardinal; dwData : longint) : THandle; overload;
function HtmlHelpInstalled : boolean;
procedure HHDisplayTOC;
procedure HHDisplayIndex(const HelpString: String);
procedure HHDisplayTopic(const Topic: String);
procedure HHDisplayHelpByContext(const ContextID: Integer);
procedure HHCloseAll;

var
  HtmlHelpW : THtmlHelpW;
  HtmlHelpA : THtmlHelpA;

implementation

var
  DllHandle : THandle;

function HtmlHelpInstalled : boolean;
begin
  result := (Assigned(HtmlHelpA));
end;

function HH(uCommand : Cardinal; dwData : longint) : THandle;
begin
  result := 0;
  if (Assigned(HtmlHelpA)) then
    result := HtmlHelpA(GetDesktopWindow, PChar(Application.HelpFile), uCommand, dwData);
end;

function HH(hwndCaller : THandle; pszFile : PChar; uCommand : Cardinal; dwData : longint) : THandle;
begin
  result := 0;
  if (Assigned(HtmlHelpA)) then
    result := HtmlHelpA(hwndCaller, pszFile, uCommand, dwData);
end;

function HelpFile(const Name: String): String;
var
  FileName : String;
begin
  Result := '';
  FileName := Application.HelpFile;

  if Fileexists(Filename) then
    Result := FileName
  else
    Result := '';
end;

procedure HHDisplayTOC;
begin
  if HelpFile('') <> '' then
    HtmlHelpA(GetDesktopWindow, PChar(HelpFile('')), HH_DISPLAY_TOC, 0);
end;

procedure HHDisplayIndex(const HelpString: String);
begin
  if HelpFile('') <> '' then
    HtmlHelpA(GetDesktopWindow, PChar(HelpFile('')), HH_DISPLAY_INDEX, LongInt(Pchar(HelpString)));
end;

procedure HHDisplayTopic(const Topic: String);
begin
  if HelpFile('') <> '' then
    HtmlHelpA(GetDesktopWindow, PChar(HelpFile('')+' ::/'+Topic+'.htm'), HH_DISPLAY_TOPIC, 0);
end;

procedure HHDisplayHelpByContext(const ContextID: Integer);
begin
  if HelpFile('') <> '' then
    HtmlHelpA(GetDesktopWindow, PChar(HelpFile('')), HH_HELP_CONTEXT, ContextID);
end;

procedure HHCloseAll;
begin
  HtmlHelpA(0, nil, HH_CLOSE_ALL,0);
end;

initialization
begin
  HtmlHelpA := NIL;
  HtmlHelpW := NIL;
  DllHandle := LoadLibrary('HHCtrl.OCX');
  if (DllHandle <> 0) then
  begin
    //HtmlHelpA := GetProcAddress(DllHandle, 'HtmlHelpA');
    //HtmlHelpW := GetProcAddress(DllHandle, 'HtmlHelpW');
    HtmlHelpA := GetProcAddress(DllHandle, ATOM_HTMLHELP_API_ANSI);
    HtmlHelpW := GetProcAddress(DllHandle, ATOM_HTMLHELP_API_UNICODE);
  end;
end;

finalization
begin
  if (DllHandle <> 0) then
    FreeLibrary(DllHandle);
end;


end.
