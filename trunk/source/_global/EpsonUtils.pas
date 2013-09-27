unit EpsonUtils;

interface

uses
  Classes;

const
  escCRLF           = #13#10;
  escNewPage        = #12;
  escBold           = #27 + 'E';
  escUnBold         = #27 + 'F';
  escItalic         = #27 + '4';
  escUnItalic       = #27 + '5';
  escUnderline      = #27 + '-' + #1;
  escNoUnderline    = #27 + '-' + #0;
  escStrong         = #27 + 'G';
  escUnStrong       = #27 + 'H';
  escSubScript      = #27 + 'S' + #1;
  escSuperScript    = #27 + 'S' + #0;
  escNormalScript   = #27 + 'T';
  escDoubleWidth    = #27 + 'W' + #1;
  escSingleWidth    = #27 + 'W' + #0;
  escDoubleHeight   = #27 + 'w' + #1;
  escSingleHeight   = #27 + 'w' + #0;
  escMicronPrinting = #27 + 'g';      //Micron printing (15 cpi) = 120 chars/row
  escElitePrinting  = #27 + 'M';      //Elite printing (12 cpi) = 96 chars/row
  escNormalPrinting = #27 + 'P';      //Normal (pica) printing 10 cpi = 80 c/r
  escCompressed     = #15;            //Compressed printing 17/20 cpi = 137/160 c/r
  escUnCompressed   = #18;            //Disable compressed printing

  escKickTMU220     = #27 + 'p' + #0 + #20 + #20;
  escCutter         = #27 + 'i';
  
  function Bold(s : string) : string;
  function Italic(s : string) : string;
  function Underline(s : string) : string;
  function Strike(s : string) : string;
  function DoubleWidth(s : string) : string;
  function SubScript(s : string) : string;
  function SuperScript(s : string) : string;
  function Strong(s : string) : string;
  //function SetRowsPerPage(RowCount: Byte): string;
  function MultiChar(count : Integer; ascii : Byte) : string;
  //function Spaces(count : Integer) : string;
  function OverWrite(AOld, ANew: string; Alignment: TAlignment): string;
  function FixWidth(s : string;  Len : Integer; Alignment : TAlignment) : string;

  function FixNormal(s : string;  Len : Integer; Alignment : TAlignment) : string;

  function WrapText(s : string;  Len : Integer; Alignment : TAlignment) : string;
  //function MarkUp(s : string) : string;


implementation

function Bold(s: string): string;
begin
  Result := escBold + s + escUnBold;
end;

function Italic(s: string): string;
begin
  Result := escItalic + s + escUnItalic;
end;

function Underline(s: string): string;
begin
  Result := escUnderline + s + escNoUnderline;
end;

function Strike(s: string): string;
begin
  Result := s;  //############ UNIMPLEMENTED
end;

function DoubleWidth(s: string): string;
begin
  Result := escDoubleWidth+s+escSingleWidth;
end;

function SubScript(s: string): string;
begin
  Result := escSubScript + s + escNormalScript;
end;

function SuperScript(s: string): string;
begin
  Result := escSuperScript + s + escNormalScript;
end;

function Strong(s: string): string;
begin
  Result := escStrong + s + escUnStrong;
end;
{
function SetRowsPerPage(RowCount: Byte): string;
begin
  Result := Chr(27) + Chr(67) + Chr(RowCount);
end;
}
function MultiChar(count: Integer; ascii: Byte): string;
var s : string;
begin
  if count <= 0 then
     Result := ''
  else begin
    SetLength(s, count);
    FillChar(s[1], count, ascii);
    Result := s;
  end;
end;
{
function Spaces(count: Integer): string;
begin
  Result := MultiChar(count, 32);
end;
}
function OverWrite(AOld, ANew: string; Alignment: TAlignment): string;
var tmpstr, newstr: string;
  oldlen, newlen, tmplen: integer;
begin
  oldlen := length(AOld);
  newstr := Copy(ANew,1,oldlen);
  newlen := length(newstr);
  tmplen := oldlen - newlen;
  case Alignment of
    taLeftJustify: tmpstr := newstr + Copy(AOld,newlen+1,tmplen);
    taRightJustify: tmpstr := Copy(AOld,1,tmplen) + newstr;
    taCenter: begin
      tmpstr := Copy(AOld,1,tmplen div 2) + newstr;
      if Odd(tmplen) then tmpstr := tmpstr + Copy(AOld,length(tmpstr)+1,tmplen div 2+1)
      else tmpstr := tmpstr + Copy(AOld,length(tmpstr)+1,tmplen div 2)
    end;
  end;
  Result := tmpstr;
end;

function FixWidth(s: string; Len : Integer; Alignment: TAlignment): string;
var MustAdd : Integer;
begin
  MustAdd := Len-Length(s);
  if MustAdd > 0 then
    case Alignment of
      taLeftJustify:   s := s + MultiChar(MustAdd, 32);
      taRightJustify:  s := MultiChar(MustAdd, 32) + s;
      taCenter: begin
        s := MultiChar(MustAdd Shr 1, 32) + s + MultiChar(MustAdd Shr 1, 32);
        if Odd(MustAdd) then s := s + #15;
      end;
    end
  else
    if MustAdd < 0 then   //text too long, must be truncated
      s := Copy(s,1,Len);
  Result := s + escCompressed;
end;


function FixNormal(s: string; Len : Integer; Alignment: TAlignment): string;
var MustAdd : Integer;
begin
  MustAdd := Len-Length(s);
  if MustAdd > 0 then
    case Alignment of
      taLeftJustify:   s := s + MultiChar(MustAdd, 32);
      taRightJustify:  s := MultiChar(MustAdd, 32) + s;
      taCenter: begin
        s := MultiChar(MustAdd Shr 1, 32) + s + MultiChar(MustAdd Shr 1, 32);
        if Odd(MustAdd) then s := s + #15;
      end;
    end
  else
    if MustAdd < 0 then   //text too long, must be truncated
      s := Copy(s,1,Len);
  Result := s + escNormalPrinting;
end;



function WrapText(s: string; Len: Integer; Alignment: TAlignment): string;
var i, j: Integer;
  temp: string;
begin
  i := 0;
  temp := '';
  Result := '';
  while i <= Length(s) do begin
    inc(i);
    temp := temp + s[i];
    if i > Len then begin
      j:= Length(temp);
      while (j > 0) and (temp[j] <> #32) do
        Dec(j);
      if j = 0 then j := Len;
      if Result > '' then Result := Result + escCRLF;
      Result := Result + FixWidth(Copy(temp,1,j), Len, Alignment);
      Delete(temp,1,j);
    end;
  end;
  if temp > '' then begin
    if Result > '' then Result := Result + escCRLF;
    Result := Result + FixWidth(temp, Len, Alignment);
  end;
  Result := Result + escCRLF;
end;

{
function MarkUp(s: string): string;
const
  TagsCount = 16;
  Tags : Array[1..TagsCount,1..2] of string = (
    ('<', '<'),
    ('B', escBold),
    ('/B', escUnBold),
    ('I', escItalic),
    ('/I', escUnItalic),
    ('U', escUnderline),
    ('/U', escNoUnderline),
    ('BR', CRLF),
    ('P', CRLF+CRLF),
    ('NEWPAGE', escNewPage),
    ('STRONG', escStrong),
    ('/STRONG', escUnStrong),
    ('SUB', escSubScript),
    ('SUPER', escSuperScript),
    ('NORMAL', escNormalScript),

  );
var
  i,j : Integer;
  k,t : string;
begin
  k := '';
  i := 1;
  while (i <= length(s)) do
    begin
      if s[i] = '<' then
        begin
          t := '';
          Inc(i);
          while (i <= length(s)) do //obtain tag content
            if s[i] = '>' then
               begin
                 if (t > '') then
                   begin
                    if t[1] = '#' then
                        k := k + Chr(StrToIntDef(Copy(s,2,255),0))
                      else
                        for j := 1 to TagsCount do
                          if UpperCase(t) = Tags[j,1] then
                             begin
                               k := k + Tags[j,2];
                             break {for}
{                                   ;
                             end;
                   end;
                 //Quit from obtaining tag

                 break {while}
 {                ;
 {              end
             else
               begin
                 t := t + s[i];
                 Inc(i);
               end;
        end {s[i] = '<'}
 {      else
        k := k + s[i];
      //Next char
      Inc(i);
    end;
  Result := k;
end;
}

end.
