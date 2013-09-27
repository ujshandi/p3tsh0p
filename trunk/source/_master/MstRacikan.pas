unit MstRacikan;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, AdvEdit, Grids, BaseGrid, AdvGrid, math;

type
  TfrmMstRacikan = class(TForm)
    grid: TAdvStringGrid;
    txtRacik: TAdvEdit;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    txtHarga: TAdvEdit;
    txtJasa: TAdvEdit;
    txtQty: TAdvEdit;
    Label1: TLabel;
    procedure gridCellValidate(Sender: TObject; Col, Row: Integer;
      var Value: String; var Valid: Boolean);
    procedure gridGetAlignment(Sender: TObject; ARow, ACol: Integer;
      var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure gridGetEditorType(Sender: TObject; ACol, ARow: Integer;
      var AEditor: TEditorType);
    procedure gridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure gridKeyPress(Sender: TObject; var Key: Char);
    procedure gridSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure txtRacikKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure gridCanEditCell(Sender: TObject; ARow, ACol: Integer;
      var CanEdit: Boolean);
    procedure Button3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure txtQtyExit(Sender: TObject);
    procedure txtQtyValueValidate(Sender: TObject; value: String;
      var IsValid: Boolean);
    procedure txtQtyKeyPress(Sender: TObject; var Key: Char);
    procedure txtJasaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    OldValue: string;
    vRacikID: integer;
    hbeli, hrata: double;
    procedure InitGrid;
    procedure AutoSizeCol;
    procedure InitForm;
    procedure Calculate();
    procedure RemoveRow();
    procedure LoadData(ID: integer);

    procedure SeekRacik();
    procedure getRacik(AItemCode: string; AItemID: integer);

    procedure SeekItem(ASearch: string);
    procedure getItem(var AItemCode: string; AItemID: integer; AQty: double);
    function isValid: boolean;
    function isSaved: boolean;
  public
    function Execute(var ID, PaketID: integer): boolean;
  end;

var
  frmMstRacikan: TfrmMstRacikan;

implementation

uses LookupData, UMaster, Subroutines, MySQLConnector, AutoStockLine,
  UConstTool, uMysqlClient;

const
  colKode   = 0;
  colNama   = 1;
  colDosis  = 2;
  colDosReq = 3;
  colQty    = 4;
  colHarga  = 5;
  colTotal  = 6;
  colID     = 7;
  colHBeli  = 8;
  colHRata  = 9;
  colModID  = 10;
  colUnitID   = 11;
  colDetailID = 12;

{$R *.dfm}

{ TfrmMstRacikan }

procedure TfrmMstRacikan.getItem(var AItemCode: string; AItemID: integer;
  AQty: double);
var
  row:integer;
  qty: string; valid: boolean;
  MstItem: TMstItem;
begin
  MstItem:= TMstItem.Create;
  MstItem.Reset;
  MstItem.Barcode:= AItemCode;
  MstItem.ItemId := AItemID;

  row:= grid.Row;
  if MstItem.SelectInDB3 then begin
     AItemCode:= MstItem.Barcode;
     grid.Cells[colNama, row]:= MstItem.ItemName;
     grid.Cells[colKode, row]:= AItemCode;
     grid.Ints[colId,    row]:= MstItem.ItemId;
     grid.Ints[colUnitId,row]:= MstItem.FItemConversion[0].ConvID;
     grid.Ints[colModId, row]:= 1;

     grid.Floats[colHRata,row]:= MstItem.AvgPrice;
     grid.Floats[colHBeli,row]:= MstItem.FItemConversion[0].PurchasePrice;
     grid.Cells[colHarga,row]:= FloatToStrFmt(MstItem.FItemConversion[0].SalesPrice);
     grid.Cells[colDosis,row]:= FloatToStrFmt(MstItem.Dosis);
     grid.Cells[colQty,  row]:= FloatToStrFmt(AQty);
     grid.Cells[colTotal,row]:= FloatToStrFmt(MstItem.FItemConversion[0].PurchasePrice * AQty);

     grid.Row:= row;
     grid.Col:= colDosis;
     qty:= FloatToStrFmt(grid.Floats[colQty, row]);
     gridCellValidate(grid, colQty, row, qty, valid);
     Calculate;
     AutoSizeCol;
  end
  else begin
    Inform('Obat tidak ditemukan.');
    grid.Col:= colKode;
    grid.Row:= row;
  end;
  MstItem.Free;
end;

procedure TfrmMstRacikan.SeekItem(ASearch: string);
var id: integer; code: string;
begin
  id:= frmLookup.ExecuteItem(0, 0, 0);
  if Id > 0 then getItem(code, id, 1)
end;

procedure TfrmMstRacikan.gridCellValidate(Sender: TObject; Col,
  Row: Integer; var Value: String; var Valid: Boolean);
var tmp: string; tmp_nilai,tmp_nilai2: double;
begin
  case Col of
    colKode:
    begin
      grid.Ints[colModID, Row]:= 1;
      //SavePostState(True);
    end;

    colQty, colHarga:
    begin
      Valid:= True;//Value <> '';

      grid.Cells[colTotal, Row]:=
        FloatToStrFmt(
        StrFmtToFloatDef(grid.Cells[colQty, Row], 0) *
        StrFmtToFloatDef(grid.Cells[colHarga,Row], 0));

        tmp_nilai:= StrFmtToFloatDef(Value,0);
        tmp:= FloatToStrFmt(tmp_nilai);
        Value:= tmp;
        Calculate;
        grid.Ints[colModID, Row]:= 1;
        //SavePostState(True);
    end;

    colDosReq:
    begin
   {contoh: R/ Salbutamol 0.2mg  <=> dosis yg diminta dokter, dosis asli 4mg
               Ambroxol 10mg     <=> dosis yg diminta dokter,dosis asli 30mg
               mf.pulv.dtd.no.xx   <=> minta diracik 20 puyer
               S.3 dd 1 pc

    jadi= 0.2 x 20 : 4 = 1
       10 x 20 : 30 = 6.7    }
      Valid:= True;//Value <> '';
      tmp_nilai:= StrFmtToFloatDef(Value,0);

      tmp_nilai2:= bulatKeAtas(
        (tmp_nilai * StrFmtToFloatDef(txtQty.Text,1)) / grid.Floats[colDosis, Row]);


      grid.Cells[colQty, Row]:= FloatToStrFmt(tmp_nilai2);
        //(tmp_nilai * StrFmtToFloatDef(txtQty.Text,1)) / grid.Floats[colDosis, Row]);


      tmp:= FloatToStrFmt(tmp_nilai);
      Value:= tmp;
      grid.Ints[colModID, Row]:= 1;

      grid.Cells[colTotal, Row]:=
        FloatToStrFmt(
        StrFmtToFloatDef(grid.Cells[colQty, Row], 0) *
        StrFmtToFloatDef(grid.Cells[colHarga,Row], 0));
    end;

    colDosis:
    begin

      Valid:= True;//Value <> '';
      tmp_nilai:= StrFmtToFloatDef(Value,0);
      tmp_nilai2:= bulatKeAtas(
        (grid.Floats[colDosReq, Row] * StrFmtToFloatDef(txtQty.Text,1)) / tmp_nilai);

      grid.Cells[colQty, Row]:= FloatToStrFmt(tmp_nilai2);
      //  (grid.Floats[colDosReq, Row] * StrFmtToFloatDef(txtQty.Text,1)) / tmp_nilai);

      tmp:= FloatToStrFmt(tmp_nilai);
      Value:= tmp;
      grid.Ints[colModID, Row]:= 1;

      grid.Cells[colTotal, Row]:=
        FloatToStrFmt(
        StrFmtToFloatDef(grid.Cells[colQty, Row], 0) *
        StrFmtToFloatDef(grid.Cells[colHarga,Row], 0));
    end;

  end;
  AutoSizeCol;
end;

procedure TfrmMstRacikan.gridGetAlignment(Sender: TObject; ARow,
  ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
//RoundTo()
  if (ACol  > colNama) then
    HAlign:= taRightJustify
end;

procedure TfrmMstRacikan.gridGetEditorType(Sender: TObject; ACol,
  ARow: Integer; var AEditor: TEditorType);
begin
  case ACol of
    colQty, colHarga: AEditor:= edFloat;
  end;
end;

procedure TfrmMstRacikan.gridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var value: string; 
begin
  case key of

    VK_F2  : SeekItem(grid.Cells[colKode, grid.Row]);

    VK_RETURN:
    begin
      if (grid.Col = colKode) and (grid.Ints[colModID, grid.Row] = 1) then begin
         value:= grid.Cells[colKode, grid.Row];
         if oldValue <> value then
           getItem(value, 0, 1);
      end;
      GoNextColumn(Sender);
    end;

    VK_F12: if isValid then if isSaved then ModalResult:= mrOk;
    VK_F11: ModalResult:= mrCancel;
    VK_F10: RemoveRow;
            
  end;
end;

procedure TfrmMstRacikan.gridKeyPress(Sender: TObject; var Key: Char);
begin
  case grid.Col of
    colQty, colHarga: if key = #46 then key := #44;
  end;
end;

procedure TfrmMstRacikan.gridSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if (ACol = colKode) then OldValue:= grid.Cells[ACol, ARow];
end;

function TfrmMstRacikan.Execute(var ID, PaketID: integer): boolean;
begin
  InitForm;
  vRacikID:= ID;
  LoadData(PaketID);
  ShowModal;
  Result:= ModalResult = mrOK;
  if Result then begin
    PaketID:= txtRacik.Tag;
    ID:= vRacikID;
  end;
end;

procedure TfrmMstRacikan.Calculate;
var i: integer;
begin
  txtHarga.Text:= FloatToStr(grid.ColumnSum(colTotal, 1, grid.RowCount-1));
  hbeli:= 0;
  hrata:= 0;
  for i:= 1 to grid.RowCount-1 do
    hbeli:= hbeli + (grid.Floats[colHBeli, i] * grid.Floats[colQty, i]);

  for i:= 1 to grid.RowCount-1 do
    hrata:= hrata + (grid.Floats[colHRata, i] * grid.Floats[colQty, i]);
end;

procedure TfrmMstRacikan.InitForm;
begin
  InitGrid;
  txtRacik.Clear;
  txtHarga.Clear;
  txtJasa.Clear;
  txtQty.Clear;
end;

procedure TfrmMstRacikan.InitGrid;
begin
  ResetGrid(grid, 2, 13, 1, 0,-1);
  AutoSizeCol;
end;

function TfrmMstRacikan.isSaved: boolean;
var i: integer;
begin
  try
    BeginSQL;
    Calculate;
    if vRacikID = 0 then begin
      ExecSQL('insert into setup_racik (paket_id, qty, harga, harga_beli, harga_rata, embalase) values ('+
      FormatSQLNumber(txtRacik.Tag)+','+
      FormatSQLNumber(StrFmtToFloatDef(txtQty.Text,0))+','+
      FormatSQLNumber(StrFmtToFloatDef(txtHarga.Text,0))+','+
      FormatSQLNumber(hbeli)+','+
      FormatSQLNumber(hrata)+','+
      FormatSQLNumber(StrFmtToFloatDef(txtJasa.Text,0))+')');
      vRacikID:= getLastId;

      for i:= 1 to grid.RowCount-1 do
        if (grid.Ints[colID, i] <> 0) and (grid.Ints[colModID, i] <> 0) then
          ExecSQL(
          'insert into setup_racik_detail (racik_id, item_id, harga, hrg_rata, hrg_beli, conv_id, dosis_obat, qty, total) '+
          'values('+
          FormatSQLNumber(vRacikID)+','+
          FormatSQLNumber(grid.Ints[colID, i])+','+
          FormatSQLNumber(grid.Floats[colHarga, i])+','+
          FormatSQLNumber(grid.Floats[colHRata, i])+','+
          FormatSQLNumber(grid.Floats[colHBeli, i])+','+
          FormatSQLNumber(grid.Ints[colUnitID,  i])+','+
          FormatSQLNumber(grid.Floats[colDosis, i])+','+
          FormatSQLNumber(grid.Floats[colQty,   i])+','+
          FormatSQLNumber(grid.Floats[colTotal, i])+')');
    end
    else begin

      ExecSQL('update setup_racik set '+
      'paket_id = '+FormatSQLNumber(txtRacik.Tag)+','+
      'qty = '+FormatSQLNumber(StrFmtToFloatDef(txtQty.Text,0))+','+
      'harga = '+FormatSQLNumber(StrFmtToFloatDef(txtHarga.Text,0))+','+
      'harga_rata = '+FormatSQLNumber(hrata)+','+
      'harga_beli = '+FormatSQLNumber(hbeli)+','+
      'embalase = '+FormatSQLNumber(StrFmtToFloatDef(txtJasa.Text,0))+
      ' where racik_id = '+FormatSQLNumber(vRacikID));

      for i:= 1 to grid.RowCount-1 do
        if (grid.Ints[colID, i] <> 0) and (grid.Ints[colModID, i] <> 0) and (grid.Ints[colDetailID, i] = 0) then
          ExecSQL(
          'insert into setup_racik_detail (racik_id, item_id, harga, hrg_rata, hrg_beli, conv_id, dosis_obat, qty, total) '+
          'values('+
          FormatSQLNumber(vRacikID)+','+
          FormatSQLNumber(grid.Ints[colID, i])+','+
          FormatSQLNumber(grid.Floats[colHarga, i])+','+
          FormatSQLNumber(grid.Floats[colHRata, i])+','+
          FormatSQLNumber(grid.Floats[colHBeli, i])+','+
          FormatSQLNumber(grid.Ints[colUnitID,  i])+','+
          FormatSQLNumber(grid.Floats[colDosis, i])+','+
          FormatSQLNumber(grid.Floats[colQty,   i])+','+
          FormatSQLNumber(grid.Floats[colTotal, i])+')')

        else if (grid.Ints[colID, i] <> 0) and (grid.Ints[colModID, i] <> 0) and (grid.Ints[colDetailID, i] <> 0) then
          ExecSQL(
          'update setup_racik_detail set '+
          'item_id = '+FormatSQLNumber(grid.Ints[colID, i])+','+
          'harga = '+FormatSQLNumber(grid.Floats[colHarga, i])+','+
          'hrg_rata = '+FormatSQLNumber(grid.Floats[colHRata, i])+','+
          'hrg_beli = '+FormatSQLNumber(grid.Floats[colHBeli, i])+','+
          'conv_id = '+FormatSQLNumber(grid.Ints[colUnitID,  i])+','+
          'dosis_obat = '+FormatSQLNumber(grid.Floats[colDosis, i])+','+
          'qty = '+FormatSQLNumber(grid.Floats[colQty,   i])+','+
          'total = '+FormatSQLNumber(grid.Floats[colTotal, i])+
          ' where detail_id = '+FormatSQLNumber(grid.Ints[colDetailID, i])+')');

    end;

    EndSQL;
    Result:= True;
  except;
    Result:= False;
    UndoSQL;
    Alert(MSG_UNSUCCESS_SAVING);
  end;
end;

function TfrmMstRacikan.isValid: boolean;

  function cek_data: boolean;
  var i: integer;
  begin
   Result:= False;
   for i:= 1 to grid.RowCount-1 do begin
     result:= (not IsClear(grid, colId, i)) and (grid.Floats[colDosis, i] > 0) and (grid.Floats[colDosReq, i] > 0);

     if Result then Exit;
   end;
  end;

begin
  if CekInput(Result, txtRacik.Tag <> 0, 'Nama Racikan belum diisi.', txtRacik) then
  if CekInput(Result, StrFmtToFloatDef(txtHarga.Text,0) <> 0, 'Harga Racikan belum diisi.', txtHarga) then
  if CekInput(Result, StrFmtToFloatDef(txtJasa.Text,0) <> 0, 'Embalase belum diisi.', txtJasa) then
  if CekInput(Result, StrFmtToFloatDef(txtQty.Text,0) <> 0, 'Qty Racikan belum diisi.', txtQty) then
     CekInput(Result, cek_data, 'Tidak ada obat yang diracik.', grid);
end;

procedure TfrmMstRacikan.LoadData(ID: integer);
var i: integer; paket, item: TMysqlResult;
begin
  InitGrid;
  if vRacikID <> 0 then begin
    paket:= OpenSQL(
    'select r.racik_id, r.paket_id, r.qty, r.harga, r.embalase, '+
    '(select r.paket_id from mst_paket where paket_id = r.paket_id) '+
    'from setup_racik r where racik_id = '+FormatSQLNumber(vRacikID));
    if paket.RecordCount > 0 then begin
      txtRacik.Text:= paket.FieldValue(5);
      txtRacik.Tag := BufferToInteger(paket.FieldValue(1));
      txtQty.Text  := FloatToStr(BufferToFloat(paket.FieldValue(2)));
      txtHarga.Text:= FloatToStr(BufferToFloat(paket.FieldValue(3)));
      txtJasa.Text := FloatToStr(BufferToFloat(paket.FieldValue(4)));

      item:= OpenSQL(
      'select d.item_id, d.harga, d.hrg_rata, d.hrg_beli, d.conv_id, d.dosis, d.qty, d.total, '+
      'i.item_name, i.item_kode, i.dosis, d.detail_id '+
      'from setup_racik_detail d, mst_item i '+
      'where racik_id = '+FormatSQLNumber(vRacikID)+ ' and d.item_id = i.item_id and i.item_id = c.item_id and c.conversion = 1');

      grid.RowCount:= IfThen(item.RecordCount > 0, item.RecordCount+1, 2);
      for i:= 1 to item.RecordCount do begin
        grid.Ints[colModID,   i]:= 0;
        grid.Ints[colDetailID,i]:= BufferToInteger(item.FieldValue(11));
        grid.Ints[colID,      i]:= BufferToInteger(item.FieldValue(0));
        grid.Ints[colUnitID,  i]:= BufferToInteger(item.FieldValue(4));
        grid.Floats[colHRata, i]:= BufferToFloat(item.FieldValue(2));
        grid.Floats[colHBeli, i]:= BufferToFloat(item.FieldValue(3));
        grid.Cells[colKode,   i]:= item.FieldValue(8);
        grid.Cells[colNama,   i]:= item.FieldValue(9);
        grid.Cells[colDosis,  i]:= FloatToStrFmtNull(BufferToFloat(item.FieldValue(10)));
        grid.Cells[colDosReq, i]:= FloatToStrFmtNull(BufferToFloat(item.FieldValue(5)));
        grid.Cells[colQty,    i]:= FloatToStrFmtNull(BufferToFloat(item.FieldValue(6)));
        grid.Cells[colHarga,  i]:= FloatToStrFmtNull(BufferToFloat(item.FieldValue(1)));
        grid.Cells[colTotal,  i]:= FloatToStrFmtNull(BufferToFloat(item.FieldValue(7)));
        item.MoveNext;
      end;
      item.destroy;

    end;
    paket.destroy;
    AutoSizeCol;
  end else begin
    paket:= OpenSQL(
    'select paket_id, nama, harga_dasar '+
    'from mst_paket where paket_id = '+FormatSQLNumber(ID));
    if paket.RecordCount > 0 then begin
      txtRacik.Text:= paket.FieldValue(1);
      txtRacik.Tag := BufferToInteger(paket.FieldValue(0));
      txtQty.Text  := '0';
      txtHarga.Text:= '0';
      txtJasa.Text := FloatToStr(BufferToFloat(paket.FieldValue(2)));
    end;
    paket.destroy;
  end;
end;

procedure TfrmMstRacikan.RemoveRow;
begin
  if Confirmed('Hapus Obat?') then begin
    ExecSQL('delete from setup_racik_detail where detail_id = '+FormatSQLNumber(grid.ints[colDetailID, grid.Row]));

    grid.ClearRows(grid.Row, 1);
    if grid.RowCount > 2 then grid.RemoveRows(grid.Row, 1);
    Calculate;
  end;
end;

procedure TfrmMstRacikan.getRacik(AItemCode: string; AItemID: integer);
var MstItem: TMstPaket;
begin
  MstItem:= TMstPaket.Create;
  MstItem.Reset;
  MstItem.Barcode:= AItemCode;
  MstItem.PaketID := AItemID;

  if MstItem.SelectInDB then begin
     txtRacik.Text:= MstItem.Nama;
     txtRacik.Tag := MstItem.PaketID;
     txtJasa.Text := FloatToStr(MstItem.HargaDasar);
     txtQty.Text := '0';

  end
  else begin
    Inform('Racikan tidak ditemukan.');
    txtRacik.SetFocus;
  end;
  MstItem.Free;

end;

procedure TfrmMstRacikan.SeekRacik();
var id: integer;
begin
  id:= frmLookup.Execute('RACIK');
  if Id > 0 then getRacik('', id)
end;

procedure TfrmMstRacikan.txtRacikKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    VK_F2: SeekRacik;
    VK_TAB: IF (txtRacik.Modified) AND (txtRacik.Text <> '') THEN getRacik(txtRacik.Text,0); 
  end;
end;

procedure TfrmMstRacikan.AutoSizeCol;
begin
  grid.AutoSizeColumns(true, 5);
  grid.ColWidths[colID]:= 0;
  grid.ColWidths[colModID ]:= 0;
  grid.ColWidths[colHBeli ]:= 0;
  grid.ColWidths[colHRata ]:= 0;
  grid.ColWidths[colUnitID]:= 0;
end;

procedure TfrmMstRacikan.gridCanEditCell(Sender: TObject; ARow,
  ACol: Integer; var CanEdit: Boolean);
begin
  CanEdit:= ACol in[colKode, colDosis, colDosReq, colQty, colHarga]
end;

procedure TfrmMstRacikan.Button3Click(Sender: TObject);
begin
  if isValid then if isSaved then ModalResult:= mrOk;
end;

procedure TfrmMstRacikan.FormShow(Sender: TObject);
begin
  txtRacik.SetFocus
end;

procedure TfrmMstRacikan.Button1Click(Sender: TObject);
begin
  RemoveRow
end;

procedure TfrmMstRacikan.txtQtyExit(Sender: TObject);
var i: integer; value: string; valid : boolean;
begin
  if txtQty.Modified then begin
    for i:= 1 to grid.RowCount-1 do begin
      value:= FloatToStr(
      ((StrFmtToFloatDef(grid.Cells[colDosReq, i],0) * StrFmtToFloatDef(txtQty.Text,1)) /
      StrFmtToFloatDef(grid.Cells[colDosis, i],1)));

      gridCellValidate(grid, colQty, i, value, valid);

    end;


    Calculate;
  end;
end;

procedure TfrmMstRacikan.txtQtyValueValidate(Sender: TObject;
  value: String; var IsValid: Boolean);
begin
  AdvEdtFloatFmt(Sender, value);
end;

procedure TfrmMstRacikan.txtQtyKeyPress(Sender: TObject; var Key: Char);
begin
  IgnoreChar(Key)
end;

procedure TfrmMstRacikan.txtJasaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  CASE KEY OF
    VK_RETURN:
    BEGIN
      grid.Col:= colKode;
      grid.Row:= grid.RowCount-1;
      grid.SetFocus;
    END;
  END;
end;

end.
