unit trsPembayaran;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, StdCtrls, AdvEdit, ExtCtrls, SUIImagePanel,
  Grids, BaseGrid, AdvGrid, WinXP,
  strUtils, Math, UMaster, UTransaction,
  frmDockForm;

type
  TfrmTrsPembayaran = class(TDockForm)
    suiPanel1: TsuiPanel;
    lblTransaksi: TLabel;
    dtpTransaction: TDateTimePicker;
    txtSpec: TAdvEdit;
    btnSpec: TButton;
    txtFaktur: TAdvEdit;
    btnFaktur: TButton;
    ToolBar1: TToolBar;
    tbtNew: TToolButton;
    tbtSave: TToolButton;
    ToolButton5: TToolButton;
    tbtDelete: TToolButton;
    ToolButton2: TToolButton;
    ToolButton1: TToolButton;
    tbtPost: TToolButton;
    Label1: TLabel;
    txtTagihan: TAdvEdit;
    Label2: TLabel;
    grid: TAdvStringGrid;
    txtNote: TMemo;
    Label3: TLabel;
    txtSubtotal: TAdvEdit;
    txtDiscount: TAdvEdit;
    txtBiaya: TAdvEdit;
    txtTotal: TAdvEdit;
    WinXP1: TWinXP;
    Label4: TLabel;
    procedure btnSpecClick(Sender: TObject);
    procedure btnFakturClick(Sender: TObject);
    procedure gridCanEditCell(Sender: TObject; ARow, ACol: Integer;
      var CanEdit: Boolean);
    procedure gridCellValidate(Sender: TObject; Col, Row: Integer;
      var Value: String; var Valid: Boolean);
    procedure gridGetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: String);
    procedure gridGetEditorType(Sender: TObject; ACol, ARow: Integer;
      var AEditor: TEditorType);
    procedure gridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure txtSubtotalValueValidate(Sender: TObject; value: String;
      var IsValid: Boolean);
    procedure txtDiscountKeyPress(Sender: TObject; var Key: Char);
    procedure txtDiscountExit(Sender: TObject);
    procedure tbtPostClick(Sender: TObject);
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
    procedure dtpTransactionChange(Sender: TObject);
    procedure txtSpecChange(Sender: TObject);
    procedure txtNoteChange(Sender: TObject);
  private
    Trx: TTrsPayment;
    status_delete: word;
    purpose: integer;
    procedure InitGrid;
    procedure ArrangeColSize;
    procedure InitForm;
    procedure SetDisableEnable;
    procedure Calculate();
    procedure RemoveRow();
    function GetFaktur(ID: integer): boolean;
    procedure SavePostState(state: boolean);

    procedure SeekVendor;
    procedure getVendor(ACode: string; AID: integer);
    procedure LoadData(ID: integer);

    function isValid: boolean;
    function isSaved: boolean;
    //procedure Print();
  public
    procedure Execute(vPurpose, ID: integer); override;
  end;

var
  frmTrsPembayaran: TfrmTrsPembayaran;

implementation

uses LookupTrx, Subroutines, MySQLConnector, uMysqlClient,
  LookupData, MainMenu, UConst;

const
  colNo      = 0;
  colJenis   = 1;
  colAmount  = 2;
  colBank    = 3;
  colDok     = 4;
  colTgl     = 5;
  colJenisID = 6;
  colID      = 7;

{$R *.dfm}

{ TfrmTrsPembayaran }

procedure TfrmTrsPembayaran.ArrangeColSize;
begin
  grid.AutoSizeColumns(true, 5);
  grid.AutoSizeRows(true, 3);
  grid.ColWidths[colJenisId]:= 0;
  grid.ColWidths[colID]:= 0;
end;

procedure TfrmTrsPembayaran.Calculate;
var total, disc, charges: double;
begin
  total:= grid.ColumnSum(colAmount, 1, grid.RowCount-1);
  txtSubtotal.Text:= FloatToStrFmt(total);
  disc:= StrFmtToFloatDef(txtDiscount.Text,0, True);
  charges:= StrFmtToFloatDef(txtBiaya.Text,0, True);
  txtTotal.Text:= FloatToStrFmt(total-disc + charges);
end;

procedure TfrmTrsPembayaran.Execute(vPurpose, ID: integer);
begin
  inherited;
  purpose:= vPurpose;
  ToolBar1.ParentColor:= false;
  ToolBar1.Color:= clWhite;
  status_delete:= 0;
  Trx := TTrsPayment.Create;
  InitForm;
  LoadData(ID);
  Run(Self);
end;

function TfrmTrsPembayaran.GetFaktur(ID: integer): boolean;
var faktur: TMysqlResult;
begin
  if purpose = TRANS_TYPE_PEMBAYARAN then
    faktur:= Trx.SelectFaktur(ID)
  else faktur:= Trx.SelectStruk(ID);
                               
  Result:= faktur.RecordCount > 0;
  if Result then begin
     txtTagihan.Text:= FloatToStrFmt(BufferToFloat(faktur.FieldValue(2)));
     txtFaktur.Text := faktur.FieldValue(0);
     txtFaktur.Tag  := ID;
     if txtSpec.Tag <> BufferToInteger(faktur.FieldValue(1)) then begin
        txtSpec.Tag:= BufferToInteger(faktur.FieldValue(1));
        txtSpec.Text:= TMstRelation.GetName(BufferToInteger(faktur.FieldValue(1)));
     end;
     SavePostState(True);
  end;
  faktur.destroy;
  Calculate;
end;

procedure TfrmTrsPembayaran.getVendor(ACode: string; AID: integer);
var Data: TMstRelation;
begin
  Data:= TMstRelation.Create();
  Data.Reset;
  Data.RelationCode:= ACode;
  Data.RelationId := AID;

  if Data.SelectInDB then begin
    txtSpec.Tag := Data.RelationId;
    txtSpec.Text:= Data.RelationName;
    SavePostState(True);
  end
  else begin
    if purpose = TRANS_TYPE_PEMBAYARAN then
      Inform('Supplier tidak ditemukan.')
    else Inform('Customer tidak ditemukan.');
    txtSpec.Clear;
    txtSpec.SetFocus;
  end;
  Data.Free;
end;

procedure TfrmTrsPembayaran.InitForm;
begin
  InitGrid;
  lblTransaksi.Caption:= '[Nomor Transaksi]';
  txtSpec.LabelCaption:= IfThen(purpose = TRANS_TYPE_PEMBAYARAN,'Supplier[F2]', 'Customer[F2]');
  txtFaktur.LabelCaption:= IfThen(purpose = TRANS_TYPE_PEMBAYARAN,'No. Faktur', 'No. Struk');
  lblTransaksi.Tag:= 0;
  txtNote.Tag:= 0;
  txtSpec.Tag:= 0;
  txtFaktur.Tag:= 0;

  txtNote.Clear;
  txtSpec.Clear;
  txtFaktur.Clear;
  txtSubtotal.Clear;
  txtTagihan.Clear;
  txtDiscount.Clear;
  txtBiaya.Clear;
  txtTotal.Clear;
  SetDisableEnable;
  dtpTransaction.Date:= ServerNow;
  tbtSave.Enabled:= False;
end;

procedure TfrmTrsPembayaran.InitGrid;
begin
  ResetGrid(grid, 2, 9, 1,1, grid.ColCount-1);
  ArrangeColSize;
end;

function TfrmTrsPembayaran.isSaved: boolean;
var i: integer;
begin
  Trx.Reset;
  Trx.PaymentID  := lblTransaksi.Tag;
  Trx.Tipe       := purpose;
  Trx.TransDate  := dtpTransaction.Date;
  Trx.RelationId := txtSpec.Tag;
  Trx.InvID      := txtFaktur.Tag;
  Trx.Notes      := txtNote.Text;
  Trx.Userid     := GlobalSystemUser.UserId;
  Trx.Subtotal   := StrFmtToFloatDef(txtSubtotal.Text,0);
  Trx.Discount   := StrFmtToFloatDef(txtDiscount.Text,0);
  Trx.Biaya      := StrFmtToFloatDef(txtBiaya.Text,0);
  Trx.Total      := StrFmtToFloatDef(txtTotal.Text,0);

  for i:= 1 to grid.RowCount -1 do
    if (not IsClear(grid, colJenisId, i)) and (grid.Floats[colAmount, i] <> 0) then begin
      Trx.trsDetail.Add(
      grid.Ints[colID, i], lblTransaksi.Tag,
      grid.Ints[colJenisId, i],
      grid.Floats[colAmount, i], grid.Cells[colBank, i], grid.Cells[colDok, i],
      StrToDateDef(grid.Cells[colTgl,i],0));
    end;

  if (lblTransaksi.Tag = 0) then Result:= Trx.InsertOnDB()
  else Result:= Trx.UpdateOnDB();

  if Result then LoadData(Trx.PaymentID);
  tbtSave.Enabled:= not Result;
end;

function TfrmTrsPembayaran.isValid: boolean;
begin
  if CekInput(Result, txtFaktur.Tag <> 0, 'Faktur belum diisi.', txtFaktur) then
  CekInput(Result, txtSubtotal.Text <> '0', 'Pembayaran belum diisi', grid)
end;

procedure TfrmTrsPembayaran.LoadData(ID: integer);
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
  txtFaktur.Tag:= Trx.InvID;
  if purpose = TRANS_TYPE_PEMBAYARAN then
    txtFaktur.Text:= TTrsReceipt.GetID(Trx.InvID)
  else txtFaktur.Text:= TTrsSales.GetID(Trx.InvID);
                        
  dtpTransaction.Date:= Trx.TransDate;

  txtNote.Text:= Trx.Notes;
  txtNote.Tag:= Trx.StatusId;

  txtSubtotal.Text:= FloatToStrFmt(Trx.Subtotal);
  txtDiscount.Text:= FloatToStrFmt(Trx.Discount);
  txtBiaya.Text := FloatToStrFmt(Trx.Biaya);
  txtTotal.Text := FloatToStrFmt(Trx.Total);

  InitGrid;
  detail:= Trx.SelectDetail(ID);
  //0payment_detail_id, 1jenis_bayar, 2amount, 3bank, 4dok_num, 5tgl_cair, 6jns_bayar

  detail.First;
  for i:= 1 to detail.RecordCount do begin
    grid.Cells[colID,      i]:= detail.FieldValue(0);
    grid.Cells[colJenisId, i]:= detail.FieldValue(1);
    grid.Cells[colAmount,  i]:= FloatToStrFmt(BufferToFloat(detail.FieldValue(2)));
    grid.Cells[colBank,    i]:= detail.FieldValue(3);
    grid.Cells[colDok,     i]:= detail.FieldValue(4);
    if BufferToDateTime(detail.FieldValue(5)) <> 0 then
      grid.Dates[colTgl,   i]:= BufferToDateTime(detail.FieldValue(5));
    grid.Cells[colJenis,   i]:= detail.FieldValue(6);
    detail.MoveNext;
    grid.AddRow;
  end;
  detail.destroy;
  Calculate;
  DeleteRowTerakhir(grid, 2, 1);
  ArrangeColSize;
  SetDisableEnable;
end;

procedure TfrmTrsPembayaran.RemoveRow;
begin
  case lblTransaksi.Tag of
    0:begin
        grid.ClearRows(grid.Row, 1);
        if grid.RowCount > 2 then grid.RemoveRows(grid.Row, 1);
        Calculate;
      end
    else
      case status_delete of
        1: if Confirmed('Hapus pembayaran?') then
             if TTrsPayment.DeleteTrans(lblTransaksi.Tag) then
                InitForm;
        2: if Confirmed('Hapus baris?') then
             if TTrsPayment.DeleteDetail(grid.Ints[colId, grid.Row]) then begin
                grid.ClearRows(grid.Row, 1);
                if grid.RowCount > 2 then grid.RemoveRows(grid.Row, 1);
                Calculate;
             end;
      end;
   end;
end;

procedure TfrmTrsPembayaran.SeekVendor;
var id: integer;
begin
  if not btnSpec.Enabled then Exit;

  if purpose = TRANS_TYPE_PEMBAYARAN then
    id:= frmLookup.Execute('SPL')
  else id:= frmLookup.Execute('CUST');

  if Id > 0 then getVendor('', id)
end;

procedure TfrmTrsPembayaran.SetDisableEnable;
begin
  tbtSave.Enabled:= (txtNote.Tag=0) and (lblTransaksi.Tag=0);
  dtpTransaction.Enabled:= (txtNote.Tag=0);

  txtNote.Enabled:= (txtNote.Tag = 0);
  tbtDelete.Enabled:= (txtNote.Tag = 0);
  tbtPost.Enabled:= (txtNote.Tag = 0) and (lblTransaksi.Tag<>0);
  tbtDelete.Enabled:= (txtNote.Tag = 0);
  txtDiscount.ReadOnly:= (txtNote.Tag <> 0);
  txtBiaya.ReadOnly:= (txtNote.Tag <> 0);
  btnSpec.Enabled:= (txtNote.Tag = 0);
  btnFaktur.Enabled:= (txtNote.Tag = 0);
  txtSpec.Enabled:= (lblTransaksi.Tag = 0);
  txtFaktur.Enabled:= (txtNote.Tag = 0);
end;

procedure TfrmTrsPembayaran.btnSpecClick(Sender: TObject);
begin
  SeekVendor
end;

procedure TfrmTrsPembayaran.btnFakturClick(Sender: TObject);
var ID: integer;
begin
  GlobalFilter.Reset;
  GlobalFilter.RelasiID:= txtSpec.Tag;
  if purpose = TRANS_TYPE_PEMBAYARAN then
    ID:= frmLookupTrx.Execute('FAKTUR')
  else ID:= frmLookupTrx.Execute('STRUK');

  if ID <> 0 then GetFaktur(ID)
end;

procedure TfrmTrsPembayaran.gridCanEditCell(Sender: TObject; ARow,
  ACol: Integer; var CanEdit: Boolean);
begin
  CanEdit:=
  (
    (ACol = colJenis) or (
     (ACol = colAmount) or (
     ((ACol in [colDok, colTgl, colBank]) and (grid.Ints[colJenisID, ARow] <> 1)))
    )and
  (grid.Ints[colJenisID, ARow] <> 0)) and
  (txtNote.Tag = 0)
end;

procedure TfrmTrsPembayaran.gridCellValidate(Sender: TObject; Col,
  Row: Integer; var Value: String; var Valid: Boolean);
begin
  case Col of
    colJenis:
    begin
      Valid := (Value = '1') or (Value = '2') or (Value = '3');
      if valid then
        case StrToInt(Value) of
        1: begin Value:= 'TUNAI'; grid.Ints[colJenisID, Row]:= 1; end;
        2: begin Value:= 'GIRO'; grid.Ints[colJenisID, Row]:= 2; end;
        3: begin Value:= 'CEK'; grid.Ints[colJenisID, Row]:= 3; end;
        end

      else
      begin
        Inform('1:TUNAI, 2:GIRO, 3:CEK');
        grid.Col:= colJenis;
        Value:= '';

      end;
      SavePostState(True);
    end;

    colAmount: begin Value:= FloatToStrFmt(StrFmtToFloatDef(Value,0)); Calculate;
    ArrangeColSize; SavePostState(True); end;
  end;
end;

procedure TfrmTrsPembayaran.gridGetEditMask(Sender: TObject; ACol,
  ARow: Integer; var Value: String);
begin
  if ACol = colTgl then Value := '!99/99/00;1;_';
end;

procedure TfrmTrsPembayaran.gridGetEditorType(Sender: TObject; ACol,
  ARow: Integer; var AEditor: TEditorType);
begin
  case ACol of
    colJenis: AEditor:= edPositiveNumeric;
    colAmount: AEditor:= edFloat;
  end;
end;

procedure TfrmTrsPembayaran.gridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    VK_RETURN : GoNextColumn(Sender);
  end;
end;

procedure TfrmTrsPembayaran.txtSubtotalValueValidate(Sender: TObject;
  value: String; var IsValid: Boolean);
begin
  AdvEdtFloatFmt(Sender, value, True);
end;

procedure TfrmTrsPembayaran.txtDiscountKeyPress(Sender: TObject;
  var Key: Char);
begin
  if key = #46 then key := #44;
  IgnoreChar(Key);
end;

procedure TfrmTrsPembayaran.txtDiscountExit(Sender: TObject);
begin
  Calculate
end;

procedure TfrmTrsPembayaran.tbtPostClick(Sender: TObject);
begin
  if TTrsPayment.PostTrans(lblTransaksi.Tag, purpose) then
    txtNote.Tag:= 1;
  SetDisableEnable;
end;

procedure TfrmTrsPembayaran.tbtDeleteClick(Sender: TObject);
begin
  RemoveRow
end;

procedure TfrmTrsPembayaran.tbtSaveClick(Sender: TObject);
begin
  if isValid then isSaved
end;

procedure TfrmTrsPembayaran.tbtNewClick(Sender: TObject);
begin
  InitForm;
  SetDisableEnable;
  txtSpec.SetFocus
end;

procedure TfrmTrsPembayaran.txtSpecEnter(Sender: TObject);
begin
  status_delete:= 1;
end;

procedure TfrmTrsPembayaran.txtSpecKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    VK_F2 : SeekVendor;
    VK_TAB:
      if txtSpec.Modified then
        getVendor(txtSpec.Text,0);
  end;
end;

procedure TfrmTrsPembayaran.txtSpecKeyPress(Sender: TObject;
  var Key: Char);
begin
//  if key <> #13 then txtSpec.Tag:= 0;
end;

procedure TfrmTrsPembayaran.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  if Trx <> nil then Trx.Free; Trx:= nil;
end;

procedure TfrmTrsPembayaran.gridGetAlignment(Sender: TObject; ARow,
  ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  if ACol = colAmount then HAlign:= taRightJustify
end;

procedure TfrmTrsPembayaran.dtpTransactionChange(Sender: TObject);
begin
  SavePostState(True);
end;

procedure TfrmTrsPembayaran.txtSpecChange(Sender: TObject);
var asalna_true: boolean;
begin
  asalna_true:= tbtSave.Enabled;
  if not asalna_true then
  SavePostState((Sender as TAdvEdit).Modified);
end;

procedure TfrmTrsPembayaran.txtNoteChange(Sender: TObject);
var asalna_true: boolean;
begin
  asalna_true:= tbtSave.Enabled;
  if not asalna_true then
  SavePostState(txtNote.Modified);
end;

procedure TfrmTrsPembayaran.SavePostState(state: boolean);
begin
  tbtSave.Enabled:= state;
  if state then tbtPost.Enabled:= False; //ngahaja
end;

end.
