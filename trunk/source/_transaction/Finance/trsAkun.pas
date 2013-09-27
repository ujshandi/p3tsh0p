unit trsAkun;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, StdCtrls, AdvEdit, ExtCtrls, SUIImagePanel,
  Grids, BaseGrid, AdvGrid, WinXP,
  strUtils, Math, UMaster, UTransaction,
  frmDockForm;

type
  TfrmTrsAkun = class(TDockForm)
    suiPanel1: TsuiPanel;
    lblTransaksi: TLabel;
    dtpTransaction: TDateTimePicker;
    txtSpec: TAdvEdit;
    btnSpec: TButton;
    ToolBar1: TToolBar;
    tbtNew: TToolButton;
    tbtSave: TToolButton;
    ToolButton5: TToolButton;
    tbtDelete: TToolButton;
    ToolButton2: TToolButton;
    Label1: TLabel;
    Label2: TLabel;
    grid: TAdvStringGrid;
    txtSubtotal: TAdvEdit;
    WinXP1: TWinXP;
    txtKet: TAdvEdit;
    procedure btnSpecClick(Sender: TObject);
    procedure gridCanEditCell(Sender: TObject; ARow, ACol: Integer;
      var CanEdit: Boolean);
    procedure gridCellValidate(Sender: TObject; Col, Row: Integer;
      var Value: String; var Valid: Boolean);
    procedure gridGetEditorType(Sender: TObject; ACol, ARow: Integer;
      var AEditor: TEditorType);
    procedure gridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure txtSubtotalValueValidate(Sender: TObject; value: String;
      var IsValid: Boolean);
    procedure txtDiscountKeyPress(Sender: TObject; var Key: Char);
    procedure txtDiscountExit(Sender: TObject);
    procedure tbtDeleteClick(Sender: TObject);
    procedure tbtSaveClick(Sender: TObject);
    procedure tbtNewClick(Sender: TObject);
    procedure txtSpecEnter(Sender: TObject);
    procedure txtSpecKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure txtSpecKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure gridGetAlignment(Sender: TObject; ARow, ACol: Integer;
      var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure txtSpecChange(Sender: TObject);
    procedure dtpTransactionChange(Sender: TObject);
  private
    Trx: TTrsPayment;
    status_delete: word;
    PURPOSE: integer;
    procedure InitGrid;
    procedure InitForm;

    procedure Calculate();
    procedure RemoveRow();

    procedure SeekVendor;
    procedure getVendor(ACode: string; AID: integer);
    procedure getAkun(var ACode: string; AID: integer);
    procedure SeekAkun(ASearch: string);
    procedure LoadData(ID: integer);

    function isValid: boolean;
    function isSaved: boolean;
    //procedure Print();
  public
    procedure Execute(vPurpose, ID: integer); override;
  end;

var
  frmTrsAkun: TfrmTrsAkun;

implementation

uses LookupTrx, Subroutines, MySQLConnector, uMysqlClient,
  MainMenu, LookupData, UConst;

const
  colNo      = 0;
  colKd      = 1;
  colNama    = 2;
  colAmount  = 3;
  colAkunID  = 4;
  colID      = 5;
  colModID   = 6;

{$R *.dfm}

{ TfrmTrsPembayaran }

procedure TfrmTrsAkun.Calculate;
begin
  txtSubtotal.Text:= FormatSQLNumber(grid.ColumnSum(colAmount, 1, grid.RowCount-1));
end;

procedure TfrmTrsAkun.Execute(vPurpose, ID: integer);
begin
  inherited;
  ToolBar1.ParentColor:= false;
  ToolBar1.Color:= clWhite;
  PURPOSE:= vPurpose;
  status_delete:= 0;
  Trx := TTrsPayment.Create;
  InitForm;
  LoadData(ID);
  Run(Self);
end;

procedure TfrmTrsAkun.getVendor(ACode: string; AID: integer);
var Data: TMstRelation;
begin
  Data:= TMstRelation.Create();
  Data.Reset;
  Data.RelationCode:= ACode;
  Data.RelationId := AID;

  if Data.SelectInDB then begin
    txtSpec.Tag := Data.RelationId;
    txtSpec.Text:= Data.RelationName +' ('+Data.RelationCode+')';
    tbtSave.Enabled:= True;
  end
  else begin
    Inform('Supplier tidak ditemukan.');
    txtSpec.Clear;
    txtSpec.SetFocus;
  end;
  Data.Free;
end;

procedure TfrmTrsAkun.InitForm;
begin
  InitGrid;
  lblTransaksi.Caption:= '[Nomor Transaksi]';
  lblTransaksi.Tag:= 0;
  txtKet.Tag:= 0;
  txtSpec.Tag:= 0;
  Self.Caption:=
    IfThen(PURPOSE = TRANS_TYPE_DANA_INPUT, 'Penerimaan Dana', 'Pengeluaran Dana');
  txtKet.Clear;
  txtSpec.Clear;
  txtSubtotal.Clear;

  dtpTransaction.Date:= ServerNow;
  tbtSave.Enabled:= False;
end;

procedure TfrmTrsAkun.InitGrid;
begin
  ResetGrid(grid, 2, 6, 1,1,-1);
  grid.ColWidths[0]:= 18;
  grid.ColWidths[colKd]:= 90;
  grid.ColWidths[colAmount]:= 100;
  grid.ColWidths[colAkunId]:= 0;
  grid.ColWidths[colID]:= 0;
end;

function TfrmTrsAkun.isSaved: boolean;
var i: integer;
begin
  Trx.Reset;
  Trx.PaymentID  := lblTransaksi.Tag;
  Trx.Tipe       := PURPOSE;
  Trx.TransDate  := dtpTransaction.Date;
  Trx.RelationId := txtSpec.Tag;
  Trx.Notes      := txtKet.Text;
  Trx.Userid     := GlobalSystemUser.UserId;
  Trx.Subtotal   := StrFmtToFloatDef(txtSubtotal.Text,0);
  Trx.Total      := Trx.Subtotal;

  for i:= 1 to grid.RowCount -1 do
    if (not IsClear(grid, colAkunID, i)) and (grid.Floats[colAmount, i] <> 0) then begin
      Trx.akunDetail.Add(
      grid.Ints[colID, i], lblTransaksi.Tag,
      grid.Ints[colAkunId, i],
      grid.Floats[colAmount, i]);
    end;

  if (lblTransaksi.Tag = 0) then Result:= Trx.InsertCharges()
  else Result:= Trx.UpdateCharges();

  if Result then LoadData(Trx.PaymentID);
  tbtSave.Enabled:= not Result;
end;

function TfrmTrsAkun.isValid: boolean;
begin
  CekInput(Result, txtSubtotal.Text <> '0', 'Pembayaran belum diisi', grid)
end;

procedure TfrmTrsAkun.LoadData(ID: integer);
var i: integer; detail: TMysqlResult;
begin
  if ID = 0 then exit;
  Trx.Reset;
  Trx.PaymentID:= ID;
  Trx.SelectInDB;
  lblTransaksi.Caption:= Trx.TransNum;
  lblTransaksi.Tag:= Trx.PaymentID;
  txtSpec.Tag:= Trx.RelationId;
  txtSpec.Text:= TMstRelation.GetName(Trx.RelationId);

  dtpTransaction.Date:= Trx.TransDate;

  txtKet.Text:= Trx.Notes;
  txtKet.Tag:= Trx.StatusId;

  txtSubtotal.Text:= FloatToStrFmt(Trx.Subtotal);

  InitGrid;
  detail:= Trx.SelectDetailAkun(ID);
  //0pay_akun_id, 1amount, 2akun_id, 3kode, 4nama

  detail.First;
  for i:= 1 to detail.RecordCount do begin
    grid.Cells[colID,      i]:= detail.FieldValue(0);
    grid.Cells[colAkunId,  i]:= detail.FieldValue(2);
    grid.Cells[colAmount,  i]:= FloatToStrFmt(BufferToFloat(detail.FieldValue(1)));
    grid.Cells[colKd,      i]:= detail.FieldValue(3);
    grid.Cells[colNama,    i]:= detail.FieldValue(4);
    detail.MoveNext;
    grid.AddRow;
  end;
  detail.destroy;
  Calculate;
  DeleteRowTerakhir(grid, 2, 1);
end;

procedure TfrmTrsAkun.RemoveRow;
begin
  case lblTransaksi.Tag of
    0:begin
        grid.ClearRows(grid.Row, 1);
        if grid.RowCount > 2 then
        grid.RemoveRows(grid.Row, 1);
      end
    else
      case status_delete of
        1: if Confirmed('Hapus pembayaran?') then
             if TTrsPayment.DeleteTrans(lblTransaksi.Tag) then
                InitForm;
        2: if Confirmed('Hapus baris?') then
             if TTrsPayment.DeleteDetail(grid.Ints[colId, grid.Row]) then begin
                grid.ClearRows(grid.Row, 1);
                if grid.RowCount > 2 then
                   grid.RemoveRows(grid.Row, 1);
             end;
      end;
   end;
end;

procedure TfrmTrsAkun.SeekVendor;
var id: integer;
begin
  if not btnSpec.Enabled then Exit;
  id:= frmLookup.Execute('SPL');
  if Id > 0 then getVendor('', id)
end;

procedure TfrmTrsAkun.btnSpecClick(Sender: TObject);
begin
  SeekVendor
end;

procedure TfrmTrsAkun.gridCanEditCell(Sender: TObject; ARow,
  ACol: Integer; var CanEdit: Boolean);
begin
  CanEdit:=
  (ACol = colKd) or
  (((ACol = colAmount) and (grid.Ints[colAkunID, ARow] <> 0)))
end;

procedure TfrmTrsAkun.gridCellValidate(Sender: TObject; Col,
  Row: Integer; var Value: String; var Valid: Boolean);
begin
  case Col of
    colKd:
    begin
      grid.Ints[colModID, Row]:= 1;
      tbtSave.Enabled:= True;
    end;

    colAmount: begin Value:= FloatToStrFmt(StrFmtToFloatDef(Value,0)); Calculate;
    tbtSave.Enabled:= True; end;
  end;
end;

procedure TfrmTrsAkun.gridGetEditorType(Sender: TObject; ACol,
  ARow: Integer; var AEditor: TEditorType);
begin
  case ACol of
    colKD, colAmount: AEditor:= edFloat;
  end;
end;

procedure TfrmTrsAkun.gridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  var value: string;
begin
  case key of
    VK_RETURN : begin
      if (grid.Col = colKD) and (grid.Ints[colModID, grid.Row] = 1) then begin
         value:= grid.Cells[colKd, grid.Row];
         getAkun(value, grid.Row);
      end;
      GoNextColumn(Sender);
    end;
    vk_F2 : SeekAkun(grid.Cells[colKD, grid.Row]);
  end;
end;

procedure TfrmTrsAkun.txtSubtotalValueValidate(Sender: TObject;
  value: String; var IsValid: Boolean);
begin
  AdvEdtFloatFmt(Sender, value, True);
end;

procedure TfrmTrsAkun.txtDiscountKeyPress(Sender: TObject;
  var Key: Char);
begin
  IgnoreChar(Key);
  tbtSave.Enabled:= (Sender as TAdvEdit).Modified;
end;

procedure TfrmTrsAkun.txtDiscountExit(Sender: TObject);
begin
  Calculate
end;

procedure TfrmTrsAkun.tbtDeleteClick(Sender: TObject);
begin
  RemoveRow
end;

procedure TfrmTrsAkun.tbtSaveClick(Sender: TObject);
begin
  if isValid then isSaved
end;

procedure TfrmTrsAkun.tbtNewClick(Sender: TObject);
begin
  InitForm;
  txtSpec.SetFocus
end;

procedure TfrmTrsAkun.txtSpecEnter(Sender: TObject);
begin
  status_delete:= 1;
end;

procedure TfrmTrsAkun.txtSpecKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    VK_F2 : SeekVendor;
    VK_TAB:
      if txtSpec.Modified then
        getVendor(txtSpec.Text,0);
  end;
end;

procedure TfrmTrsAkun.txtSpecKeyPress(Sender: TObject;
  var Key: Char);
begin
//  if key <> #13 then txtSpec.Tag:= 0;
end;

procedure TfrmTrsAkun.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  if Trx <> nil then Trx.Free; Trx:= nil;
end;

procedure TfrmTrsAkun.gridGetAlignment(Sender: TObject; ARow,
  ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  if ACol = colAmount then HAlign:= taRightJustify
end;

procedure TfrmTrsAkun.txtSpecChange(Sender: TObject);
var asalna_true: boolean;
begin
  asalna_true:= tbtSave.Enabled;
  if not asalna_true then
  tbtSave.Enabled:= (Sender as TAdvEdit).Modified;
end;

procedure TfrmTrsAkun.dtpTransactionChange(Sender: TObject);
var asalna_true: boolean;
begin
  asalna_true:= tbtSave.Enabled;
  if not asalna_true then
  tbtSave.Enabled:= True;
end;

procedure TfrmTrsAkun.getAkun(var ACode: string; AID: integer);
var row:integer; akun: TMysqlResult;
begin
  akun:= OpenSQL(
  'select akun_id, kode, nama from mst_akun '+
  IfThen(ACode<>'', 'where kode = '+FormatSQLString(ACode))+
  IfThen(AID<>0, 'where akun_id = '+FormatSQLNumber(AID)));

  row:= grid.Row;
  if akun.RecordCount > 0 then begin
     ACode:= akun.FieldValue(1);
     grid.Cells[colNama, row]:= akun.FieldValue(2);
     grid.Cells[colKd,   row]:= ACode;
     grid.Ints[colAkunId,row]:= BufferToInteger(akun.FieldValue(0));
     grid.Row:= row;
     grid.Col:= colAmount;
     Calculate;
  end
  else begin
    //Inform('Item tidak ditemukan.');
    grid.Col:= colKD;
    grid.Row:= row;
  end;
  akun.destroy;
end;

procedure TfrmTrsAkun.SeekAkun(ASearch: string);
var id: integer; code: string;
begin
  code:= '';
  id:= frmLookup.Execute(IfThen(PURPOSE = TRANS_TYPE_DANA_INPUT, 'AKUN_DB', 'AKUN_CR'));
  if Id > 0 then getAkun(code, id)
end;

end.
