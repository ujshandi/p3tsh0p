unit MoneyTransaction;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, StdCtrls, AdvEdit, Grids, BaseGrid, AdvGrid,StrUtils,Math,
  ExtCtrls, SUIImagePanel,UPetshop,UTransaction;

type
  TfrmMoneyTransaction = class(TForm)
    ToolBar1: TToolBar;
    tbtNew: TToolButton;
    tbtSave: TToolButton;
    ToolButton5: TToolButton;
    ToolButton2: TToolButton;
    ToolButton1: TToolButton;
    suiPanel1: TsuiPanel;
    lblTransaksi: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    dtpTransaction: TDateTimePicker;
    grid: TAdvStringGrid;
    txtNote: TMemo;
    txtSubtotal: TAdvEdit;
    rgTipe: TRadioGroup;
    procedure tbtNewClick(Sender: TObject);
    procedure rgTipeClick(Sender: TObject);
    procedure gridCanEditCell(Sender: TObject; ARow, ACol: Integer;
      var CanEdit: Boolean);
    procedure gridCellValidate(Sender: TObject; Col, Row: Integer;
      var Value: String; var Valid: Boolean);
    procedure gridGetAlignment(Sender: TObject; ARow, ACol: Integer;
      var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure gridGetEditorType(Sender: TObject; ACol, ARow: Integer;
      var AEditor: TEditorType);
    procedure gridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure gridKeyPress(Sender: TObject; var Key: Char);
    procedure tbtSaveClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure gridComboChange(Sender: TObject; ACol, ARow,
      AItemIndex: Integer; ASelection: String);
  private
    { Private declarations }
    Trx : TTrsMoneyTransaction;
    purpose : integer;
    ls: TStringList;
     procedure InitGrid;
    procedure ArrangeColSize;
    procedure InitForm;
    procedure SetDisableEnable;
    procedure Calculate();
    function isValid: boolean;
    function isSaved: boolean;
    procedure LoadData;
  public
    { Public declarations }

    procedure Execute(ID: integer); 

  end;

var
  frmMoneyTransaction: TfrmMoneyTransaction;

implementation

uses MainMenu, Subroutines, UConst, DatabaseConnection, MySQLConnector,
  UConstTool, AutoStockLine, uMysqlClient, UMaster;

const
  colNo      = 0;
  colAkun = 1;
  colDesc   = 2;
  colAmount  = 3;
  colAkunId = 4;
  colModId = 5;
  colID      = 6;

{$R *.dfm}

{ TfrmMoneyTransaction }

procedure TfrmMoneyTransaction.ArrangeColSize;
begin
  grid.AutoSizeColumns(True,2);
  grid.ColWidths[colDesc] :=300;
  grid.ColWidths[colAkun] :=100;
  grid.ColWidths[colAmount] :=100;
  grid.ColWidths[colAkunId] :=0;
  grid.ColWidths[colId] :=0;
  grid.ColWidths[colModId] :=0;
end;

procedure TfrmMoneyTransaction.Calculate;
var
  total: double;
  i: integer;
begin
  total := 0;
  for i:= 1 to grid.RowCount-1 do
    total:= total + StrFmtToFloatDef(grid.Cells[colAmount, i],0);


  txtSubtotal.Text:= FloatToStrFmt(total);

end;

procedure TfrmMoneyTransaction.Execute(ID: integer);
begin
  inherited;
  Trx := TTrsMoneyTransaction.Create();
  ls := TStringList.Create;
  
  
  InitForm;
  lblTransaksi.Tag :=ID;
  if id > 0 then LoadData;
  Run(Self);
end;

procedure TfrmMoneyTransaction.InitForm;
begin

   Trx.Reset;
   lblTransaksi.Caption := Trx.GetNewNumber;
   lblTransaksi.Tag := 0;
   rgTipe.ItemIndex := 0;
   txtSubtotal.Text := '0';
   rgTipeClick(nil);
   txtNote.Clear;
   dtpTransaction.Date:= ServerNow;
      
   Self.Caption := IfThen(purpose=1,'Penerimaan Kas','Pengeluaran Kas');
   InitGrid;

end;

procedure TfrmMoneyTransaction.InitGrid;
begin
   ResetGrid(grid,2,colID+2,1,1,-1);
   ArrangeColSize;
end;

function TfrmMoneyTransaction.isSaved: boolean;
var i:integer;
begin
   Trx.Reset;
   Trx.TransDate := dtpTransaction.Date;
   Trx.TransType := purpose;
   Trx.Notes := txtNote.Text;
   Trx.Total := StrFmtToFloatDef(txtSubtotal.Text,0);
   for i:= 1 to grid.RowCount-1 do begin
      if (not IsClear(grid, colDesc, i)) and (grid.Ints[colModID, i] <> 0) and (grid.Floats[colAmount, i] <> 0) then begin
        Trx.trsDetail.Add(0,lblTransaksi.Tag,MONEY_TYPE_KAS,grid.Cells[colDesc,i],grid.Floats[colAmount,i],grid.Ints[colAkunId,i]);
      end;
   end;
   if lblTransaksi.Tag=0 then
     Result := Trx.InsertOnDB
   else
     Result := Trx.UpdateOnDB;
end;

function TfrmMoneyTransaction.isValid: boolean;
 function cek_data: boolean;
 var i: integer;
 begin
  Result:= False;
  for i:= 1 to grid.RowCount-1 do begin
    result:= not IsClear(grid, colDesc, i);
    if Result then
       Exit;
  end;

end;

begin
//  if CekInput(Result, dtpDely.Date >= dtpTransaction.Date, 'Tgl kirim < tgl PO.', dtpDely) then
  //  if CekInput(Result, trunc(dtpExpr.Date) >= trunc(dtpTransaction.Date), 'Tgl jth tempo < tgl PO.', dtpExpr) then
       //  CekInput(Result, cek_data, 'Tidak ada detail transaksi untuk disimpan.', grid);
       Result := True;


end;

procedure TfrmMoneyTransaction.SetDisableEnable;
begin

end;

procedure TfrmMoneyTransaction.tbtNewClick(Sender: TObject);
var tag : integer;
begin
  tag := 401;
//  Alert(IntToStr(AktiveControl.Tag));
if not TSystemAccess.isCan(CAN_ADD,tag) then exit;
  InitForm;
end;

procedure TfrmMoneyTransaction.rgTipeClick(Sender: TObject);
begin
  purpose:=rgTipe.ItemIndex+1;
  TMstAkun.getList(ls,purpose);
end;

procedure TfrmMoneyTransaction.gridCanEditCell(Sender: TObject; ARow,
  ACol: Integer; var CanEdit: Boolean);
begin
  CanEdit := ACol in [colAKun,colDesc,colAmount];
end;

procedure TfrmMoneyTransaction.gridCellValidate(Sender: TObject; Col,
  Row: Integer; var Value: String; var Valid: Boolean);
var tmp: string; tmp_nilai: double;  
begin
case Col of
    colAkun: begin
      grid.Cells[colAkunId, Row]:= ls.Names[grid.Combobox.ItemIndex];
      grid.Ints[colModID, Row]:= 1;
    end;
    colDesc:
    begin
      grid.Ints[colModID, Row]:= 1;
    end;

    colAmount:
    begin
      Valid:= True; //Value <> '';
      if not Valid then begin
        Inform('Inputan belum diisi.');
        grid.Col:= Col;
        grid.Row:= Row;
        exit;
      end else
      begin
       
        tmp_nilai:= StrFmtToFloatDef(Value,0);
        tmp:= FloatToStrFmt(tmp_nilai);
        Value:= tmp;


        Calculate;
        grid.Ints[colModID, Row]:= 1;
      end;
    end;
   end;
end;

procedure TfrmMoneyTransaction.gridGetAlignment(Sender: TObject; ARow,
  ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  if (ACol in[colNo, colAmount]) then
    HAlign:= taRightJustify
end;

procedure TfrmMoneyTransaction.gridGetEditorType(Sender: TObject; ACol,
  ARow: Integer; var AEditor: TEditorType);
begin
  case ACol of
    colAmount: AEditor:= edPositiveNumeric;
    colAkun : begin AEditor := edComboList;
        NameValueListToValueList(ls,grid.Combobox.Items);
       grid.Combobox.ItemIndex := -1;
    end;
  end;
end;

procedure TfrmMoneyTransaction.gridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var value: string; jumlah: double; valid: boolean;
begin
  case key of
    VK_F4:
    begin
      grid.SetFocus;
      grid.Row:= 1;
      grid.Col:= colDesc;
    end;

  end;

end;

procedure TfrmMoneyTransaction.gridKeyPress(Sender: TObject;
  var Key: Char);
begin
  case grid.Col of
    colAmount: if key = #46 then key := #44;
  end;
end;

procedure TfrmMoneyTransaction.tbtSaveClick(Sender: TObject);
begin
  if isValid then
    if isSaved then begin
      Inform(MSG_SUCCESS_SAVING);
      Self.Close;
    end
   // else
   //   Alert(MSG_UNSUCCESS_SAVING);
end;

procedure TfrmMoneyTransaction.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Trx.Free;
  ls.Free;
  //Action := caFree;
end;

procedure TfrmMoneyTransaction.LoadData;
var data :TMysqlResult;i:integer;
begin
  if lblTransaksi.Tag = 0 then exit;
  Trx.MoneyTransID := lblTransaksi.Tag;
  InitGrid;
  if Trx.SelectInDB then begin
      lblTransaksi.Caption := Trx.TransNum;
      dtpTransaction.Date := Trx.TransDate;
      rgTipe.ItemIndex := Trx.TransType-1;
      rgTipeClick(nil);
      txtNote.Lines.Text := Trx.Notes;
      txtSubtotal.Text := FloatToStrFmtNull(Trx.Total);
      data:= Trx.SelectDetail(Trx.MoneyTransID);
      for i:= 0 to data.RecordCount-1 do begin
        grid.Ints[colNo,i+1] := i+1;
        grid.Cells[colDesc,i+1] := BufferToString(data.FieldValue(0));

        grid.Cells[colAmount,i+1]:=FloatToStrFmtNull( BufferToFloat(data.FieldValue(1)));
        grid.Ints[colId,i+1] := BufferToInteger(data.FieldValue(2));
        grid.Cells[colAkun,i+1]:= ls.Values[BufferToString(data.FieldValue(4))];
        grid.Ints[colAkunId,i+1] := BufferToInteger(data.FieldValue(4));

        grid.AddRow;
        data.MoveNext;
      end;
      data.destroy;
      DeleteRowTerakhir(grid,2,1);
      ArrangeColSize;
  end;
end;

procedure TfrmMoneyTransaction.gridComboChange(Sender: TObject; ACol, ARow,
  AItemIndex: Integer; ASelection: String);
begin
    if AItemIndex <> -1 then
          grid.Cells[colAkunId,ARow] := ls.Names[AItemIndex];
end;

end.
