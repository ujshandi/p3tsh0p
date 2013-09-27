unit RawPrintPrev;
{
  TdlgRawPrintPreview v1.00
  (c) Copyright 2001
  Authorized by Miaw Chiu

  Use this dialog to allow preview of epson-formatted document (raw text
  with epson's escape sequence formatter - usually used to directly
  print to dot-matrix printer without use of GDI)

  This unit also encapsulates TRawPrinter component from RawPrinter unit,
  a fine freeware VCL (c)2000 by Przemyslaw Jankowski (e-mail: pjank@home.pl).
  Therefore, user can print the previewed document directly to printer by
  pressing the Print button.
  You can also print any string to the printer without using the preview
  dialog by calling the PrintRawDocument procedure. This procedure
  automatically create TRawPrinter instance, execute BeginDoc, send the
  string to printer buffer, call EndDoc, and finally destroy the just-created
  component. Thanks to Mr. Jankowski for his easy to use component!

  TdlgRawPrintPreview is freeware. You can use and modify this unit as
  you like. Human knowledge is belong to the world! Happy computing...

  Methods provided:
  procedure Execute(DocTitle, TextToPrint : String);
  procedure PreviewOnly(DocTitle, TextToPrint : String);
  procedure PreviewToImage(TextToPrint : String; Image: TImage);

  Global procedure provided:
  procedure PrintRawDocument(DocTitle, TextToPrint : String);
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons;

type
  TRawPrintPreview = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    btnPrint: TBitBtn;
    btnPrintSetup: TBitBtn;
    ScrollBox1: TScrollBox;
    Image1: TImage;
    chkFitToDisplay: TCheckBox;
    psPrinterSetup: TPrinterSetupDialog;
    btnPrev: TBitBtn;
    btnNext: TBitBtn;
    Shape1: TShape;
    btnClose: TBitBtn;
    procedure chkFitToDisplayClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure btnPrintSetupClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure btnPrevClick(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
  private
    { Private declarations }
    Buffer: String;
    PosPage:array of integer;
    CurPage:integer;
    Keluar:boolean;
  public
    { Public declarations }
    procedure Execute(const DocTitle, TextToPrint: String);
    procedure PreviewOnly(const DocTitle, TextToPrint: String);
    procedure PreviewToImage(const TextToPrint: String; Image: TImage;FromOfs:integer;First:boolean);
    procedure PrintRawDocument(const DocTitle, TextToPrint: String);
  end;

function RAWPrintPreview: TRAWPrintPreview;

implementation

uses RawPrinter;
{$R *.DFM}
var
  fRAWPrintPreview: TRAWPrintPreview = nil;

procedure TRawPrintPreview.PrintRawDocument(const DocTitle, TextToPrint: String);
var
  RP: TRawPrinter;
begin
  RP := TRawPrinter.Create(nil);
  try
    RP.DocumentTitle := DocTitle;
    RP.BeginDoc;
    //RP.WriteStr(TextToPrint);
    RP.Write(TextToPrint);
    RP.EndDoc;
  finally
    RP.Free;
  end;
end;

procedure TRawPrintPreview.Execute(const DocTitle, TextToPrint: String);
begin
  //Init vars
  Caption := DocTitle;
  Buffer := TextToPrint;
  //Create preview
  SetLength(PosPage,1);
  PosPage[0]:=1;
  CurPage:=0;
  Keluar:=false;
  PreviewToImage(TextToPrint, Image1,1,true);
  //Show dialog
  ShowModal;
end;

procedure TRawPrintPreview.chkFitToDisplayClick(Sender: TObject);
begin
  if chkFitToDisplay.Checked then begin
    Image1.Width := ScrollBox1.Width-4;
    Image1.Height := Trunc((Image1.Width / Image1.Picture.Bitmap.Width) * Image1.Picture.Bitmap.Height);
    Image1.Left := 0;
    Image1.Top := 0;
    //Shape1.Visible := False;
  end else begin
    Image1.Width := Image1.Picture.Bitmap.Width;
    Image1.Height := Image1.Picture.Bitmap.Height;
    Image1.Left := 8;
    Image1.Top := 8;
    Shape1.Visible := True;
    Shape1.Width := Image1.Width;
    Shape1.Height := Image1.Height;
  end;
end;

procedure TRawPrintPreview.btnPrintClick(Sender: TObject);
begin
  PrintRawDocument(Caption, Buffer);
end;

procedure TRawPrintPreview.btnPrintSetupClick(Sender: TObject);
begin
  psPrinterSetup.Execute;
end;

procedure TRawPrintPreview.PreviewToImage(const TextToPrint: String; Image: TImage;FromOfs:integer;First:boolean);
const
  CanvasWidth = 80*9+8+8; //80 chars @ 9 pixel + 2x8 for margin
var
  Ofs, Len: Integer;
  {CanvasHeight, }PageLen, Row, Col, Y, PosY, i, j, LeftMargin, RightMargin: Integer;
  RowHeight, ColWidth, FontSize, VKern, RowFeed: Byte;
  c: Char;
  {parse: Byte;}
  DoubleWidth, DoubleHeight: Boolean;
  Dot: TColor;

  //Internal routine...
  procedure SetCompressedPrinting;
  begin
    if ColWidth = 7 then begin //12 cpi
      //set to 20 cpi
      ColWidth := 4;
      FontSize := 5;
      Font.Size := 5;
    end else begin //17 cpi
      ColWidth := 5;
      FontSize := 6;
      Font.Size := 6;
    end;
  end {proc SetCompressedPrinting};

  procedure NewPage;
  begin
    if First then begin
      Row := 0;
      Col := LeftMargin;
      DoubleWidth := False;
      Keluar:=false;
      DoubleHeight := False;
      // draw page separator on canvas
      inc(Y,RowHeight*2);
      inc(Y,RowHeight);
      // write position new page
      Setlength(PosPage,Length(PosPage)+1);
      PosPage[Length(PosPage)-1]:=Ofs;
    end else begin
      Keluar:=true;
      Exit;
    end;
  end {proc NewPage};

  procedure NewLine;
  begin
    inc(Row, RowHeight+RowFeed+2);
    inc(Y, RowHeight+RowFeed+2);
    DoubleWidth := False;
    DoubleHeight := False;
    if Row > PageLen then NewPage;
  end {proc NewLine};

//begin proc RawPrintPreview
begin
  //Initialize vars
  try
    Len := Length(TextToPrint);
    Y := 8;  //top display margin
    //Default: Normal Printing (10 pica)
    RowHeight := 8; //9
    ColWidth := 8;  //9
    VKern := 0;
    FontSize := 8; //10
    RowFeed := 1;
    LeftMargin := 0;
    RightMargin := CanvasWidth-ColWidth-8;  //8 is right-display-margin
    Ofs:=FromOfs;
    PageLen :=71*(Rowheight+Rowfeed);// MaxInt; 71 baris
    //Start from top of page
    Row := 0;
    Col := 0;
    Y := 0;
    //Draw to canvas
    with Image1.Canvas do begin
      // Inisialisasi
      Image1.Picture.Bitmap.Width := CanvasWidth;
      Image1.Picture.Bitmap.Height := PageLen;//2000;
      Brush.Style := bsSolid;
      Brush.Color := clWhite;
      FillRect(Bounds(0,0,CanvasWidth,2000)); //clear First
      Font.Name := 'Tahoma';//'Courier New';
      Font.Size := FontSize;
      Font.Style := [];
      Font.Color := clBlack;
      Brush.Style := bsClear;

      //Default font
      //Ofs := 1;
      while Ofs <= Len do begin
        if keluar then exit;
        //Get once char
        c := TextToPrint[Ofs];
        inc(Ofs);
        //Check for special code
        case c of
          #0: begin // Null [IGNORED]
          end;
          #8:  // Backspace
            if Col >= ColWidth then dec(Col, ColWidth);
          #9: begin //Execute Horizontal tab
          end;
          #10: // Line feed
            NewLine;
          #11: begin // Execute Vertical tab  [IGNORED]
          end;
          #12: // New Page  (used only if not the last char)
            if Ofs < Len then
               NewPage;
          #13: //Carriage Return
            Col := LeftMargin;
          #14: //Set single-line double-width printing
            DoubleWidth := True;
          #15: //Set compressed printing (equal to ESC+15)
            SetCompressedPrinting;
          #17,#19: begin //Remote Printer Select/Deselect [IGNORED]
          end;
          #18: //Release compressed printing
            if ColWidth <= 6 then begin //in compressed printing?
              //return to normal mode
              if ColWidth = 4 then  //20 cpi...
                ColWidth := 7   //back to 12 cpi
              else                 //17 cpi...
                ColWidth := 9; //back to 10 cpi
              FontSize := ColWidth;
              Font.Size := ColWidth;
            end;
          #20: //Release single-line double-width printing
            DoubleWidth := False;
          #24, //Cancel  [IGNORED]
          #127: begin //DEL [IGNORED]
          end;

          #27: begin //Escape character: control special character
            //Get next character
            c := TextToPrint[Ofs];
            inc(Ofs);
            case c of

              //FONT SELECTION
              '4': //Select italic printing
                 Font.Style := Font.Style + [fsItalic];
              '5': //Release italic printing
                 Font.Style := Font.Style - [fsItalic];
              'S': begin //Select sub/super-script printing
                c := TextToPrint[Ofs];
                inc(Ofs);
                Font.Size := Trunc(FontSize * 0.75);
                if c = #0 then
                  VKern := -Trunc(FontSize * 0.8)
                else
                  VKern := Trunc(FontSize * 0.8);
              end;
              'T': begin //Release sub/superscript
                VKern := 0;
                Font.Size := FontSize;
              end;
              'k', //Selects Print font style [IGNORED]
              'x': inc(Ofs);

              //CHARACTER PITCH SELECTION
              'P': begin //Sets 10 cpi (pica pitch) printing
                 ColWidth := 9;
                 FontSize := 10;
                 Font.Size := 10;
              end;
              'M': begin //Sets 12 cpi (elite pitch) printing
                 ColWidth := 7;
                 FontSize := 8;
                 Font.Size := 8;
              end;
              'g': begin //Sets 15 cpi (micron) printing
                 ColWidth := 7;
                 FontSize := 7;
                 Font.Size := 7;
              end;
              #15: //Sets compressed printing
                SetCompressedPrinting;
              'p', //Set/release proportional spacing [IGNORED]
              #32, //Set character dot spacing [IGNORED]
              '!': //Programmable pitch/highlighting
                inc(Ofs);

              //CHARACTER HIGHLIGHT SELECTION
              'E', //Set emphasized printing
              'G': //Sets double printing
                 Font.Style := Font.Style + [fsBold];
              'F', //Releaase emphasized printing
              'H': //Release double printing
                 Font.Style := Font.Style - [fsBold];
              #14: //Set single-line double-width printing
                 DoubleWidth := True;
              'W': begin //set/release double-width printing
                 c := TextToPrint[Ofs];
                 inc(Ofs);
                 DoubleWidth := (c = #1);
              end;
              'w': begin //set/release double-height printing
                 c := TextToPrint[Ofs];
                 inc(Ofs);
                 DoubleHeight := (c = #1);
              end;
              '-': begin //set/release underlining printing
                 c := TextToPrint[Ofs];
                 inc(Ofs);
                 if c = #1 then
                   Font.Style := Font.Style + [fsUnderline]
                 else
                   Font.Style := Font.Style - [fsUnderline]
              end;

              //CHARACTER FONT SELECTION
              'R', //Sets international character set [IGNORE]
              't': //Select alternate char set  [IGNORE]
                 inc(Ofs);
              '6','7': begin //Select IBM Vhar set II / I [IGNORE]
              end;

              //BIT IMAGE (GRAPHIC) MODE SELECTION [ALL IGNORED]
              'K','L','Y','Z','?': inc(Ofs);
              '*','^': inc(Ofs,3);

              //PAPER FEED SELECTION - AMOUNT
              '0': //Sets paper feed to 3.2 mm
                 RowFeed := 3;
              '1': //Sets paper feed to 2.47 mm
                 RowFeed := 2;
              '2': //Sets paper feed to 4.2 mm
                 RowFeed := 4;
              'A': begin //Sets paper feed to n/72 inch
                c := TextToPrint[Ofs];
                inc(Ofs);
                RowFeed := 8 div (Ord(c) div 3);
              end;
              '3': begin //Sets paper feed to n/216 inch
                c := TextToPrint[Ofs];
                inc(Ofs);
                RowFeed := 8 div (Ord(c) div 9);
              end;

              //PAGE FORMAT CONTROL
              'C': begin //Sets page length
                c := TextToPrint[Ofs];
                inc(Ofs);
                if c = #0 then begin //Set page length in inch
                  c := TextToPrint[Ofs];
                  inc(Ofs);
                  PageLen := (Ord(c) * 100);
                end else  //Set page length in lines
                  PageLen := (Ord(c) * 10);
              end;
              'Q': begin //Sets right margin
                c := TextToPrint[Ofs];
                inc(Ofs);
                RightMargin := Ord(c) * ColWidth;
              end;
              'I': begin //Sets right margin
                c := TextToPrint[Ofs];
                inc(Ofs);
                LeftMargin := Ord(c) * ColWidth;
              end;
              'a': //Alignment (Left, center, right, auto) [IGNORED]
                inc(Ofs);
              'N': //Set skip perforation [IGNORED]
                inc(Ofs);
              'O': begin //Release skip perforation [IGNORED]
              end;

              //TABULATION
              'D','B','b': //Sets horizontal/vertical/VFU tab [IGNORED]
                while TextToPrint[ofs-1] <> #0 do
                  inc(Ofs);
              '/': //Sets VFU channel
                inc(Ofs);

              //CARRIAGE CONTROL
              '<': begin //Sets single direction printing [IGNORED]
              end;
              'U', //Set/release single direction printing [IGNORED]
              's': //Set/release half-speed printing
                inc(Ofs);
              '\','$': begin //Moves printhead to a relative/absolute hor. position
              end;

              //MISCELLANEOUS [IGNORED]
              '@', //Initializes the printer
              '9','8': begin//Enable/disable paper-out detection
              end;
              #25: //Selects Cut Sheet Feeder
                inc(Ofs);
            end{case};

          end; {option #27}
          else begin //Printable characters

            //out of horizontal margin?
            if Col > RightMargin then begin
              NewLine;
              Col := LeftMargin;
            end;
            //Need new page?
            if Row > PageLen then
              NewPage;
            //Draw to canvas on second parse
            //if dodraw then begin
              PosY := Y + VKern + (10-FontSize);
              TextOut(Col+8,PosY,c);  //8 is left display margin
              //on double-width, stretch character to double width
              if DoubleWidth then begin
                for i := 0 to TextHeight(c)-1 do
                  for j := ColWidth-1 downto 0 do begin
                    Dot := Pixels[Col+j+8,PosY+i];
                    Pixels[Col+8+(j*2),PosY+i] := Dot;
                    Pixels[Col+8+(j*2)+1,PosY+i] := Dot;
                  end;
                inc(Col, ColWidth);
              end;
            //end;
            //Advance hor. position
            inc(Col, ColWidth);
          end;
        end{case};
      end{while};
    end{with};
    {set Real Canvas to image}
  finally
    //CanvasHeight := Y+RowHeight*2+8; //8 for display bottom margin
    Image1.Picture.Bitmap.Width := CanvasWidth;
    Image1.Picture.Bitmap.Height := Pagelen;//CanvasHeight;
    Image1.Width := CanvasWidth;
    Image1.Height := PageLen;//CanvasHeight;
    Shape1.Width := CanvasWidth;
    Shape1.Height := Pagelen;
    //Showmessage('Satu Halaman Beres Karakter ke-'+inttostr(Ofs));
  end;
  if first then
    PreviewtoImage(buffer,Image1,PosPage[CurPage],false);
end;

procedure TRawPrintPreview.PreviewOnly(const DocTitle, TextToPrint: String);
begin
  //Disable printing feature
//  btnPrint.Enabled := False;
//  btnPrintSetup.Enabled := False;
  //Call execute method
  Execute(DocTitle, TextToPrint);
  //Reenable printing feature for later use
  btnPrint.Enabled := True;
  btnPrintSetup.Enabled := True;
end;

procedure TRawPrintPreview.FormResize(Sender: TObject);
begin
  if chkFitToDisplay.Checked then chkFitToDisplayClick(self);
end;

procedure TRawPrintPreview.btnPrevClick(Sender: TObject);
begin
  if CurPage<>0 then begin
    CurPage:=CurPage-1;
    Keluar:=false;
    PreviewtoImage(buffer,Image1,PosPage[CurPage],false);
  end;
end;

procedure TRawPrintPreview.btnNextClick(Sender: TObject);
begin
  if CurPage<Length(PosPage) then begin
    CurPage:=CurPage+1;
    keluar:=false;
    PreviewtoImage(buffer,Image1,PosPage[CurPage],false);
  end;
end;

procedure TRawPrintPreview.btnCloseClick(Sender: TObject);
begin
  Close;
end;

function RAWPrintPreview: TRAWPrintPreview;
begin
  if fRAWPrintPreview = nil then
    fRAWPrintPreview := TRAWPrintPreview.Create(nil);
  Result := fRAWPrintPreview;
end;

initialization

finalization
  fRAWPrintPreview.Free;
end.
