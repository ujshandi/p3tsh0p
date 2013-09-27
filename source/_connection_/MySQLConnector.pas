unit MySQLConnector;

{$DEFINE DEBUG}
{$IFDEF DEBUG}
 {$DEFINE SQL_DEBUG}
{$ENDIF}

{$DEFINE DB_USED}

interface

uses
  Classes, Controls, SysUtils, Math, strUtils, Variants,
  Dialogs, Forms,
  windows,Messages,
  ActiveX, ComObj, Graphics,
  uMysqlClient, WinSock, Registry;

  procedure setConnectionValue;
  function tryToConnetToDB: boolean;

  function  ConnetedToDB: boolean;
  function  ConnetToDB: boolean;
  function  ExecSQL(ASQL: string; isEqualWithASQL: boolean=true; ADump:string=''): integer;
  function  ExecTransaction(ASQL: string; IsInsert: boolean=true): boolean;
  function  ExecTransaction2(ASQL: string): boolean;
  function  LogSQL(ASQL: string): integer;
  function  OpenSQL(ASQL: string): TMysqlResult;
  function  BeginSQL: integer;
  procedure EndSQL;
  procedure UndoSQL;

  procedure ShowErrorss;
  function GetComputerNetName: string;

type
  TSQLOperator = (soGreaterThan, soGreaterThanEqualsTo,soEquals,soLessThan, soLessThanEqualsTo);
  TBooleanOperator = (boTrue,boFalse,boNone);

  TPeriode = class
  protected
  public
    OpPeriodeAwal1 : TSQLOperator;
    OpPeriodeAwal2 : TSQLOperator;
    OpPeriodeAkhir1: TSQLOperator;
    OpPeriodeAkhir2: TSQLOperator;
    PeriodeAwal1   : TDate;
    PeriodeAwal2   : TDate;
    PeriodeAkhir1  : TDate;
    PeriodeAkhir2  : TDate;
    OpRangeAwal    : TSQLOperator;
    OpRangeAkhir   : TSQLOperator;
    RangeAwal      : double;
    RangeAkhir     : double;
    YearMonth, YearMonth2: string;
    Triwulan, Bulan: integer;

    procedure Reset;
    procedure setPeriode(AItemIndex:integer;ADate1,ADate2:TDate;FirstPeriode:boolean=True;
      AYearMonth: string=''; AYearMonth2: string=''; atriwulan: integer=0; abulan: integer=0);
    procedure setRanges(AItemIndex:integer;ARange1,ARange2:double);
    procedure setPeriode2(AItemIndex1, AItemIndex2:integer;ADate1,ADate2, ADate3,ADate4:TDate);
  end;

var
  MySQLClient: TMysqlClient;
  MySQLResult: TMysqlResult;
  QUERY_EXECUTED: BOOLEAN;

  CONN_CLIENT_STAT: INTEGER;
  XA_ID: STRING;

  ErrorFile: string = 'error.sql';  {.log}
  DMLFile: string;
  ServerName: string;

const
  TRUE_STRING = 'T';
  FALSE_STRING = 'F';
  TRUE_VALUE = -1;
  FALSE_VALUE = 0;

  CONN_CLIENT_STAT_INTRANS = 1;
  CONN_CLIENT_STAT_NOT_INTRANS = 0;


  ORACLE    = 0;
  MYSQL     = 1;
  SQLSERVER = 2;
  ACCESS    = 3;

  DB_IDX   = MYSQL;

  function getStringFromSQL(aSql:string): string;
  function getStringNullFromSQL(ASQL: string): string;

  function getFloatFromSQL(aSql:string): double;
  function getIntegerFromSQL(aSql:string): integer;
  function getBooleanFromSQL(aSql:string): boolean;
  function getTDateFromSQL(aSql:string): TDate;

  function FormatSQLDateNow: string;
  function ServerNow:TDate;
  function ServerCurrDateTime: TDateTime;
  function FormatSQLDateTimeNow: string;

  function FormatSQLRound2(Value: Double): Double;

  function FormatSQLBoolean(ABoolean: boolean): string;
  function FormatSQLDateTime(ADateTime: TDateTime): string;
  function FormatSQLDate(ADate: TDate): string;
  function FormatSQLTime(ATime: TTime): string;
  function FormatSQLTime2(ATime: TTime): string;

  function FormatSQLString(AString: string): string;
  //function FormatSQLString(AChar: char): string; overload;
  function FormatSQLWildCard(AString: string): string;
  function FormatSQLWildCard2(AString: string): string;
  function FormatSQLNumber(AInteger: integer): string; overload;
  function FormatSQLNumber(AFloat: real): string; overload;
  function FormatSQLNULL: string;
  function FormatSQLYearNow:string;
  function FormatSQLOperator(operator:TSQLOperator):string;
  function FormatSQLNumberRound(AFloat: real): string; overload;
  function StrFmtToFloat(AString: string): real;
  function StrFmtToFloatDef(AString: string; ADefault: real; ExelStyle: Boolean=false): double;
  function FloatToStrFmt(AFloat: real; ExelStyle: boolean=false; digit: integer=2): string;
  function FloatToStrFmtNull(AFloat: real; ExelStyle: boolean=false; digit: integer=2): string;

//conversi query result

  function BufferToBoolean(ABuffer: PChar; ADefault: Boolean=false): boolean;
  function BufferToString(ABuffer: PChar; ADefault: string=''): string;
  function BufferToInteger(ABuffer: PChar; ADefault: integer=0): integer;
  function BufferToFloat(ABuffer: PChar; ADefault: double=0): real;
  function BufferToDateTime(ABuffer: PChar; ADefault: Tdatetime=0): TDateTime;
  function BufferToTime(ABuffer: PChar; ADefault: TTime=0): TTime;

  procedure setLocal();

  function ConnetionIsOnline: boolean;


implementation

uses uMysqlCT, DatabaseConnection, UConstTool, UConst;

  procedure WriteLog(AFilename, AString: string);
  var FP: Text;
  begin
    if (AFileName='') then Exit;

    AssignFile(FP, AFilename);
    {$I-} Append(FP); {$I+}
    if (IOResult<>0) then Rewrite(FP);
    Writeln(FP, AString);
    CloseFile(FP);
  end;

  procedure setConnectionValue;
  begin
    frmDatabaseConnection.Execute;
    MySQLClient:= TMysqlClient.create;
    MySQLClient.Host:= frmDatabaseConnection.HostID;
    MySQLClient.User:= frmDatabaseConnection.UserID;
    MySQLClient.Password:= frmDatabaseConnection.PasswordID;
    MySQLClient.Db:= frmDatabaseConnection.DbID;
    MySQLClient.ConnectTimeout:= 20;
  end;

  function tryToConnetToDB: boolean;
  begin
    try
      Result:= MySQLClient.connect(MySQLClient.Host, MySQLClient.User, MySQLClient.Password, MySQLClient.Db);
    except raise;
      ShowMessage(MySQLClient.LastError);
      Result:= False;
    end;
  end;

  function ConnetToDB: boolean;
  var berhasil: boolean;  repeat_time: word;
  begin
    if Assigned(MySQLClient) then MySQLClient.destroy;
    MySQLClient:= TMysqlClient.create;
    MySQLClient.Host:= frmDatabaseConnection.HostID;
    MySQLClient.User:= frmDatabaseConnection.UserID;
    MySQLClient.Password:= frmDatabaseConnection.PasswordID;
    MySQLClient.Db:= frmDatabaseConnection.DbID;
    repeat_time:= 0;
    MySQLClient.ConnectTimeout:= 10;
    ServerName:= MySQLClient.Host;
    if (MySQLClient.Host <> '') and
       (MySQLClient.User <> '') and
       (MySQLClient.Password <> '') and
       (MySQLClient.Db <> '') then
    begin

      berhasil:= tryToConnetToDB;
      if not berhasil then  begin
        repeat
          Application.ProcessMessages;
          setConnectionValue;
          berhasil:= tryToConnetToDB;
          Inc(repeat_time);

        until ((berhasil = true) or (repeat_time > 4));
      end;
    end
    else begin
      repeat
        Application.ProcessMessages;
        setConnectionValue;
        berhasil:= tryToConnetToDB;
        Inc(repeat_time);
      until ((berhasil = true) or (repeat_time > 4));
    end;

    Result := berhasil;

    XA_ID:= GetComputerNetName + Application.Name;
    //setLocal(LowerCase(MySQLClient.Host) <> 'localhost');
    setLocal;

    if not Result then Application.Terminate;

  end;

  function ExecSQL(ASQL: string; isEqualWithASQL: boolean=true; ADump:string=''): integer;
  begin
    Result:= 0;
    MySQLClient.Query(ASQL, TRUE, QUERY_EXECUTED);

    if (DMLFile<>'') then begin
      if isEqualWithASQL then writeLog(DMLFile,ASQL+';')
      else if (isEqualWithASQL = false) and (ADump<>'') then writeLog(DMLFile,ADump+';')
    end;

    if (not QUERY_EXECUTED) then begin
      WriteLog(ErrorFile,sLineBreak+FormatDateTime('yy/mm/dd hh:nn:ss',Now)+' - '+Application.Name+
        sLineBreak+'>Message: '+MySQLClient.LastError+sLineBreak+'>Dump: '+ASQL);
      raise Exception.Create(MySQLClient.LastError);

    end;
  end;

  function ExecTransaction(ASQL: string; IsInsert: boolean): boolean;
  begin
    try
      BeginSQL;
      ExecSQL(ASQL);
      EndSQL;
      //ShowMessage(IfThen(IsInsert,MSG_SUCCESS_SAVING,MSG_SUCCESS_UPDATE));
      Result:= true;
    except
      UndoSQL;
      ShowMessage(ifThen(IsInsert,MSG_UNSUCCESS_SAVING,MSG_UNSUCCESS_UPDATE));
      Result:= False;
    end;
  end;

  function ExecTransaction2(ASQL: string): boolean;
  begin
    try
      ExecSQL(ASQL);
      Result:= true;
    except raise;
    end;
  end;

  function LogSQL(ASQL: string): integer;
  begin
    Result:= 0;
    if (DMLFile<>'') then writeLog(DMLFile,ASQL+';')
  end;

  function OpenSQL(ASQL: string): TMysqlResult;
  begin
    Result:= MySQLClient.Query(ASQL, TRUE, QUERY_EXECUTED);
    if Assigned(Result) then Result.First;
    if (not QUERY_EXECUTED) then begin
      WriteLog(ErrorFile,sLineBreak+FormatDateTime('yy/mm/dd hh:nn:ss',Now)+' - '+Application.Name+
        sLineBreak+'>Message: '+MySQLClient.LastError+sLineBreak+'>Dump: '+ASQL);
      raise Exception.Create(MySQLClient.LastError);
    end;
  end;

  function BeginSQL: integer;
  begin
    Result:= 1;
    CONN_CLIENT_STAT:= CONN_CLIENT_STAT_INTRANS;
    MySQLClient.Query('XA START '+QuotedStr(XA_ID), False, QUERY_EXECUTED);

    if (DMLFile<>'') then BEGIN
      WriteLog(DMLFile,sLineBreak+'-- Begin on '+FormatDateTime('yy/mm/dd hh:nn:ss',Now)+' - '+Application.Name);
      writeLog(DMLFile,'XA START '+QuotedStr(XA_ID)+';');
    END;

    if (not QUERY_EXECUTED) then begin
      WriteLog(ErrorFile,sLineBreak+FormatDateTime('yy/mm/dd hh:nn:ss',Now)+' - '+Application.Name+
        sLineBreak+'>Message: '+MySQLClient.LastError+sLineBreak);
      raise Exception.Create('['+IntToStr(MySQLClient.LastErrorNo)+']'+ MySQLClient.LastError);
    end;
  end;

  procedure EndSQL;
  begin
    MySQLClient.Query('XA END '+QuotedStr(XA_ID), False, QUERY_EXECUTED);
    MySQLClient.Query('XA PREPARE '+QuotedStr(XA_ID), False, QUERY_EXECUTED);
    MySQLClient.Query('XA COMMIT '+QuotedStr(XA_ID), False, QUERY_EXECUTED);

    CONN_CLIENT_STAT:= CONN_CLIENT_STAT_NOT_INTRANS;

    if (DMLFile<>'') then begin
      writeLog(DMLFile, 'XA END '+QuotedStr(XA_ID)+';');
      writeLog(DMLFile, 'XA PREPARE '+QuotedStr(XA_ID)+';');
      writeLog(DMLFile, 'XA COMMIT '+QuotedStr(XA_ID)+';');
    end;

    if (not QUERY_EXECUTED) then begin
      WriteLog(ErrorFile,sLineBreak+FormatDateTime('yy/mm/dd hh:nn:ss',Now)+' - '+Application.Name+
        sLineBreak+'>Message: '+MySQLClient.LastError+sLineBreak);
      raise Exception.Create(MySQLClient.LastError);
    end;
  end;

  procedure UndoSQL;
  begin
    MySQLClient.Query('XA END '+QuotedStr(XA_ID), False, QUERY_EXECUTED);
    MySQLClient.Query('XA PREPARE '+QuotedStr(XA_ID), False, QUERY_EXECUTED);
    MySQLClient.Query('XA ROLLBACK '+QuotedStr(XA_ID), False, QUERY_EXECUTED);
                                    
    if (DMLFile<>'') then begin
      writeLog(DMLFile, 'XA END '+QuotedStr(XA_ID)+';');
      writeLog(DMLFile, 'XA PREPARE '+QuotedStr(XA_ID)+';');
      writeLog(DMLFile, 'XA ROLLBACK '+QuotedStr(XA_ID)+';');
    end;

    CONN_CLIENT_STAT:= CONN_CLIENT_STAT_NOT_INTRANS;

    if (not QUERY_EXECUTED) then begin
      WriteLog(ErrorFile,sLineBreak+FormatDateTime('yy/mm/dd hh:nn:ss',Now)+' - '+Application.Name+
        sLineBreak+'>Message: '+MySQLClient.LastError+sLineBreak);
      raise Exception.Create(MySQLClient.LastError);
    end;
  end;

  function getStringFromSQL(aSql:string): string;
  var buffer : TMysqlResult;
  begin
    buffer:= OpenSQL(aSql);
    if assigned(buffer) then begin
      if buffer.RecordCount > 0 then
        Result := BufferToString(buffer.FieldValue(0));
      FreeAndNil(buffer);
    end;
  end;

  function getStringNullFromSQL(ASQL: string): string;
  var buffer: TMysqlResult;
  begin
    buffer:= OpenSQL(ASQL);
    if buffer.RecordCount > 0 then
      Result:= FloatToStrFmt(BufferToFloat(buffer.FieldValue(0)));
    buffer.destroy;
    if Result = '0' then Result:= ''
    
  end;

  function getFloatFromSQL(aSql:string): double;
  var buffer : TMysqlResult;
  begin
    buffer:= OpenSQL(aSql);
    Result:= 0;
    if assigned(buffer) then begin
      if buffer.RecordCount > 0 then
        Result := BufferToFloat(buffer.FieldValue(0));
      FreeAndNil(buffer);
    end;
  end;

  function getIntegerFromSQL(aSql:string): integer;
  var buffer : TMysqlResult;
  begin
    buffer:= OpenSQL(aSql);
    Result:= 0;
    if assigned(buffer) then begin
      if buffer.RecordCount > 0 then
        Result := BufferToInteger(buffer.FieldValue(0));
      FreeAndNil(buffer);
    end;
  end;

  function getBooleanFromSQL(aSql:string): boolean;
  var buffer : TMysqlResult;
  begin
    buffer:= OpenSQL(aSql);
    Result:= False;
    if assigned(buffer) then begin
      if buffer.RecordCount > 0 then
        Result := BufferToBoolean(buffer.FieldValue(0));
      FreeAndNil(buffer);
    end;
  end;

  function getTDateFromSQL(aSql:string): TDate;
  var buffer : TMysqlResult;
  begin
    buffer:= OpenSQL(aSql);
    Result:= 0;
    if assigned(buffer) then begin
      if buffer.RecordCount > 0 then
        Result := BufferToDateTime(buffer.FieldValue(0));
      FreeAndNil(buffer);
    end;
  end;
  
  function ExecuteSQL(aSql:string): boolean;
  begin
    try
      BeginSQL;
      ExecSQL(aSql);
      EndSQL;
      Result := True;
    except
      UndoSQL;
      Result := False;
    end;
  end;

  function FormatSQLDateNow: string;
  begin
     Result := 'date(curdate())';
  end;

  function ServerNow:TDate;
  begin
    Result := getTDateFromSQL('SELECT curdate() ');
  end;

  function ServerCurrDateTime: TDateTime;
  begin
    Result := getTDateFromSQL('SELECT now() ');
  end;

  function FormatSQLDateTimeNow: string;
  begin
  end;

  function FormatSQLBoolean(ABoolean: boolean): string;
  begin
    if (ABoolean) then Result := FormatSQLNumber(TRUE_VALUE) else Result := FormatSQLNumber(FALSE_VALUE);
  end;

  function FormatSQLRound2(Value: Double): Double;
  begin
    Result:= getFloatFromSQL('select round('+formatsqlNumber(Value)+',2)')
  end;

  function FormatSQLDateTime(ADateTime: TDateTime): string;
  begin
    Result := 'cast('+QuotedStr(FormatDateTime('yyyy-mm-dd hh:nn:ss',ADateTime))+'as datetime)';
  end;

  function FormatSQLDate(ADate: TDate): string;
  begin
    Result := 'cast('+QuotedStr(FormatDateTime('yyyy-mm-dd ',ADate))+'as date)';
  end;

  function FormatSQLTime(ATime: TTime): string;
  begin
    Result := FormatDateTime(LongTimeFormat,ATime);
  end;

  function FormatSQLTime2(ATime: TTime): string;
  begin
    Result := 'time_format('+QuotedStr(TimeToStr(ATime))+', '+QuotedStr('%H:%i:%s')+')';
  end;

  function FormatSQLString(AString: string): string; 
  begin
    Result := QuotedStr(AString);
  end;

  {function FormatSQLString(AChar: char): string; overload;
  begin
    Result := QuotedStr(AChar);
  end;}

  function FormatSQLWildCard(AString: string): string;
  begin
    Result := QuotedStr(AnsiReplaceStr(AString,'*','_'));// AString);
    //ReplaceSubStr
  end;

  function FormatSQLWildCard2(AString: string): string;
  begin
    Result := QuotedStr(AnsiReplaceStr(AString,'.','%'));
  end;

  function FormatSQLNumber(AInteger: integer): string;
  begin
    Result := IntToStr(AInteger);
  end;

  function FormatSQLNumber(AFloat: real): string;
  begin
    Result := AnsiReplaceStr(FloatToStr(AFloat),DecimalSeparator,'.');
  end;

  function FormatSQLNULL: string;
  begin
    Result := 'NULL';
  end;

  function FormatSQLYearNow:string;
  begin
    Result := FormatDateTime('yyyy',ServerNow);
  end;

  function FormatSQLOperator(operator:TSQLOperator):string;
  begin
    case operator of
      soGreaterThan : result := '> ';
      soGreaterThanEqualsTo : result:= '>= ';
      soEquals : result := '= ';
      soLessThan : result:= '< ';
      soLessThanEqualsTo : result:= '<=';
      else result := '= ';
    end;
  end;

  function FormatSQLNumberRound(AFloat: real): string; overload;
  begin
    Result := 'round('+AnsiReplaceStr(FloatToStr(AFloat),DecimalSeparator,'.')+')';
  end;

  function StrFmtToFloat(AString: string): real;
  begin
    Result := StrFmtToFloatDef(AString,0.00);
  end;

  function StrFmtToFloatDef(AString: string; ADefault: real; ExelStyle: Boolean=false): double;
  begin
    if ExelStyle then
      if Copy(AString,1,1) = '(' then begin
        AString:= copy(AString, 2, length(AString)-2);
        AString:= '-' + AString;
      end;
    Result := StrToFloatDef(AnsiReplaceStr(AString,ThousandSeparator,''),0);
  end;

  function FloatToStrFmt(AFloat: real; ExelStyle: boolean; digit: integer): string;
  var buntut: string;
  begin
    buntut:= '##';
    if digit = 3 then buntut:= '###';

    if (ExelStyle) and (AFloat < 0) then
      Result := '('+FormatFloat('#,##0.'+buntut, abs(AFloat))+')'
    else
      Result := FormatFloat('#,##0.'+buntut, AFloat);
  end;

  function FloatToStrFmtNull(AFloat: real; ExelStyle: boolean=false; digit: integer=2):string;
  var buntut: string;
  begin
    buntut:= '##';
    if digit = 3 then buntut:= '###';

    if (ExelStyle) and (AFloat < 0) then
      Result := '('+FormatFloat('#,##0.'+buntut, abs(AFloat))+')'
    else
      Result := FormatFloat('#,##0.'+buntut, AFloat);
    if AFloat = 0 then Result:= '';
  end;

  function BufferToBoolean(ABuffer: PChar; ADefault: Boolean): boolean;
  var tmp: variant;
  begin
    tmp:= StrPas(ABuffer);
    if VarIsNull(tmp) then
       Result := ADefault else Result := tmp;
  end;

  function BufferToString(ABuffer: PChar; ADefault: string): string;
  var tmp: variant;
  begin
    tmp:= StrPas(ABuffer);
    if VarIsNull(tmp) then
      Result := ADefault else Result := Trim(ABuffer);
  end;

  function BufferToInteger(ABuffer: PChar; ADefault: integer): integer;
 // var tmp: variant;
  var s: string;
  begin
    {tmp:= StrPas(ABuffer);
    if VarIsNull(tmp) then
       Result := ADefault else Result := tmp
     }
    s:= StrPas(ABuffer);
    Result:= StrToIntDef(s, ADefault);
  end;

  function BufferToFloat(ABuffer: PChar; ADefault: double): real;
  var s: string;
  begin
    s:= AnsiReplaceStr(StrPas(ABuffer),ThousandSeparator,DecimalSeparator);
    Result:= StrToFloatDef(s, ADefault);
  end;

  function BufferToDateTime(ABuffer: PChar; ADefault: Tdatetime): TDateTime;
  var tmp: variant;
  begin
    tmp:= AnsiReplaceStr(strpas(ABuffer),'-','/');
    if (tmp = '0') or (tmp = '') or (tmp = '0000/00/00')then
      tmp:= FloatToDateTime(0);
    if VarIsNull(tmp) then
       Result := ADefault else Result := VarToDateTime(tmp)
  end;

  function BufferToTime(ABuffer: PChar; ADefault: TTime): TTime;
  var tmp: variant;
  begin
    tmp:= AnsiReplaceStr(strpas(ABuffer),'-','/');
    if (tmp = '0') or (tmp = '') then
      tmp:= FloatToDateTime(0);
    if VarIsNull(tmp) then
       Result := ADefault else Result := VarToDateTime(tmp)
  end;


  procedure setLocal();
  var reg: TRegistry; writeLogs: integer; value: boolean;
  begin
    writeLogs:= 1;
    reg:= TRegistry.Create;
    reg.RootKey:= HKEY_CURRENT_USER;
    try
      try
        reg.OpenKey(MODUL_PATH + '\Setting', True);
        try writeLogs:= reg.ReadInteger('writeLog');
        except writeLogs:= 1; end;
      except end;
    finally
      reg.CloseKey;
    end;
    reg.Free;

    value:= (not ConnetionIsOnline) and (writeLogs = 1);
    DMLFile:= IfThen(value, 'offline_'+LowerCase(GetComputerNetName)+'.sql', '');
  end;

  function IPAddrToName(IPAddr : String): String;
  var
    SockAddrIn: TSockAddrIn;
    HostEnt: PHostEnt;
    WSAData: TWSAData;
  begin
    WSAStartup($101, WSAData);
    SockAddrIn.sin_addr.s_addr:= inet_addr(PChar(IPAddr));
    HostEnt:= gethostbyaddr(@SockAddrIn.sin_addr.S_addr, 4, AF_INET);
    if HostEnt<>nil then
    begin
      result:=StrPas(Hostent^.h_name)
    end
    else
    begin
      result:='';
    end;
  end;

  function HostToIP(sHost: string; var sIP: string): Boolean;
  var
    aHostName: array[0..255] of Char;
    pcAddr   : PChar;
    HostEnt  : PHostEnt;
    wsData   : TWSAData;
  begin
    WSAStartup($0101, wsData);
    try
      GetHostName(aHostName, SizeOf(aHostName));
      StrPCopy(aHostName, sHost);
      hostEnt := GetHostByName(aHostName);
      if Assigned(HostEnt) then
        if Assigned(HostEnt^.H_Addr_List) then begin
          pcAddr := HostEnt^.H_Addr_List^;
          if Assigned(pcAddr) then begin
            sIP := Format('%d.%d.%d.%d', [Byte(pcAddr[0]), Byte(pcAddr[1]),
              Byte(pcAddr[2]), Byte(pcAddr[3])]);
            Result := True;
          end else
            Result := False;
        end else
          Result := False
      else begin
        Result := False;
      end;
    finally
      WSACleanup;
    end;
  end;

  function ConnetionIsOnline: boolean;
  var hostDB, computerName: string;
  begin
    computerName:= GetComputerNetName;

    if AnsiContainsStr(MySQLClient.Host,'.') then
      hostDB:= IPAddrToName(MySQLClient.Host) //= localHost
    else begin
      HostToIP(MySQLClient.Host, hostDB);
      hostDB:= IPAddrToName(hostDB);
    end;

    Result:= (LowerCase(hostDB) <> LowerCase('localHost')) and (LowerCase(hostDB) <> LowerCase(computerName));
  end;

  procedure ShowErrorss;
  begin
    ShowMessage(
    'LastError ' + MySQLClient.LastError + #13#10+
    'Stat ' +  MySQLClient.Stat+ #13#10+
    'Info ' +  MySQLClient.Info+ #13#10+
    'ThreadId ' + IntToStr(MySQLClient.ThreadId));
  end;

  function GetComputerNetName: string;
  var
    buffer: array[0..255] of char;
    size: dword;
  begin
    size := 256;
    if GetComputerName(buffer, size) then
       Result := buffer
    else Result := ''

  end;

  function ConnetedToDB: boolean;
  begin
    Result:= MySQLClient.ping;
  end;
{ TPeriode }

procedure TPeriode.Reset;
begin
  OpPeriodeAwal1 := soEquals;
  OpPeriodeAkhir1:= soEquals;
  OpPeriodeAwal2 := soEquals;
  OpPeriodeAkhir2:= soEquals;
  OpRangeAwal     := soEquals;
  OpRangeAkhir    := soEquals;
  PeriodeAwal1   := 0;
  PeriodeAkhir1  := 0;
  PeriodeAwal2   := 0;
  PeriodeAkhir2  := 0;
  RangeAwal       := 0;
  RangeAkhir      := 0;
  YearMonth:= '';
  YearMonth2:= '';
  Triwulan:= 0;
  Bulan:= 0;
end;

procedure TPeriode.setPeriode(AItemIndex: integer; ADate1, ADate2: TDate;
  FirstPeriode: boolean; AYearMonth, AYearMonth2: string; atriwulan,
  abulan: integer);
begin
  Reset;
  YearMonth:= AYearMonth;
  YearMonth2:= AYearMonth2;
  Triwulan:= atriwulan;
  Bulan:= abulan;

  if FirstPeriode then begin
    case AItemIndex of
          0:begin
              Self.OpPeriodeAwal1 := soEquals;
              Self.PeriodeAwal1   := ADate1;
              Self.OpPeriodeAkhir1:= soEquals;
              Self.PeriodeAkhir1  := 0;
            end;
          1:begin
              Self.OpPeriodeAwal1 := soGreaterThanEqualsTo;
              Self.PeriodeAwal1   := ADate1;
              Self.OpPeriodeAkhir1:= soEquals;
              Self.PeriodeAkhir1  := 0;
            end;

          2:begin
              Self.OpPeriodeAwal1 := soLessThanEqualsTo;
              Self.PeriodeAwal1   := ADate1;
              Self.OpPeriodeAkhir1:= soEquals;
              Self.PeriodeAkhir1  := 0;
            end;
          3:begin
              Self.OpPeriodeAwal1 := soGreaterThanEqualsTo;
              Self.PeriodeAwal1   := ADate1;
              Self.OpPeriodeAkhir1:= soLessThanEqualsTo;
              Self.PeriodeAkhir1  := ADate2;
           end;
          end;
  end
  else begin  //periode 2
       case AItemIndex of
          0:begin
              Self.OpPeriodeAwal2 := soEquals;
              Self.PeriodeAwal2   := ADate1;
              Self.OpPeriodeAkhir2:= soEquals;
              Self.PeriodeAkhir2  := 0;
            end;
          1:begin
              Self.OpPeriodeAwal2 := soGreaterThanEqualsTo;
              Self.PeriodeAwal2   := ADate1;
              Self.OpPeriodeAkhir2:= soEquals;
              Self.PeriodeAkhir2  := 0;
            end;

          2:begin
              Self.OpPeriodeAwal2 := soLessThanEqualsTo;
              Self.PeriodeAwal2   := ADate1;
              Self.OpPeriodeAkhir2:= soEquals;
              Self.PeriodeAkhir2  := 0;
            end;
          3:begin
              Self.OpPeriodeAwal2 := soGreaterThanEqualsTo;
              Self.PeriodeAwal2   := ADate1;
              Self.OpPeriodeAkhir2:= soLessThanEqualsTo;
              Self.PeriodeAkhir2  := ADate2;
           end;
          end;
  end;
end;

procedure TPeriode.setPeriode2(AItemIndex1, AItemIndex2: integer; ADate1,
  ADate2, ADate3, ADate4: TDate);
begin
  Reset;
  case AItemIndex1 of
    0:begin
        Self.OpPeriodeAwal1 := soEquals;
        Self.PeriodeAwal1   := ADate1;
        Self.OpPeriodeAkhir1:= soEquals;
        Self.PeriodeAkhir1  := 0;
      end;
    1:begin
        Self.OpPeriodeAwal1 := soGreaterThanEqualsTo;
        Self.PeriodeAwal1   := ADate1;
        Self.OpPeriodeAkhir1:= soEquals;
        Self.PeriodeAkhir1  := 0;
      end;

    2:begin
        Self.OpPeriodeAwal1 := soLessThanEqualsTo;
        Self.PeriodeAwal1   := ADate1;
        Self.OpPeriodeAkhir1:= soEquals;
        Self.PeriodeAkhir1  := 0;
      end;
    3:begin
        Self.OpPeriodeAwal1 := soGreaterThanEqualsTo;
        Self.PeriodeAwal1   := ADate1;
        Self.OpPeriodeAkhir1:= soLessThanEqualsTo;
        Self.PeriodeAkhir1  := ADate2;
     end;
  end;


  case AItemIndex2 of
    0:begin
        Self.OpPeriodeAwal2 := soEquals;
        Self.PeriodeAwal2   := ADate3;
        Self.OpPeriodeAkhir2:= soEquals;
        Self.PeriodeAkhir2  := 0;
      end;
    1:begin
        Self.OpPeriodeAwal2 := soGreaterThanEqualsTo;
        Self.PeriodeAwal2   := ADate3;
        Self.OpPeriodeAkhir2:= soEquals;
        Self.PeriodeAkhir2  := 0;
      end;

    2:begin
        Self.OpPeriodeAwal2 := soLessThanEqualsTo;
        Self.PeriodeAwal2   := ADate3;
        Self.OpPeriodeAkhir2:= soEquals;
        Self.PeriodeAkhir2  := 0;
      end;
    3:begin
        Self.OpPeriodeAwal2 := soGreaterThanEqualsTo;
        Self.PeriodeAwal2   := ADate3;
        Self.OpPeriodeAkhir2:= soLessThanEqualsTo;
        Self.PeriodeAkhir2  := ADate4;
     end;
  end;

end;

procedure TPeriode.setRanges(AItemIndex: integer; ARange1,
  ARange2: double);
begin
  case AItemIndex of
    0:begin
        Self.OpRangeAwal := soEquals;
        Self.RangeAwal   := ARange1;
        Self.OpRangeAkhir:= soEquals;
        Self.RangeAkhir  := 0;
      end;
    1:begin
        Self.OpRangeAwal := soGreaterThanEqualsTo;
        Self.RangeAwal   := ARange1;
        Self.OpRangeAkhir:= soEquals;
        Self.RangeAkhir  := 0;
      end;

    2:begin
        Self.OpRangeAwal := soLessThanEqualsTo;
        Self.RangeAwal   := ARange1;
        Self.OpRangeAkhir:= soEquals;
        Self.RangeAkhir  := 0;
      end;
    3:begin
        Self.OpRangeAwal := soGreaterThanEqualsTo;
        Self.RangeAwal   := ARange1;
        Self.OpRangeAkhir:= soLessThanEqualsTo;
        Self.RangeAkhir  := ARange2;
     end;
  end;
end;

end.
