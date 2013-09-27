unit MstRelationAnimal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, AdvEdit, ToolWin,strUtils,Math,
  UMaster, WinXP, ExtCtrls, Grids, BaseGrid, AdvGrid,UPetshop;

type
  TfrmMstRelationAnimal = class(TForm)
    txtCode: TAdvEdit;
    txtName: TAdvEdit;
    txtAddress: TAdvEdit;
    txtCity: TAdvEdit;
    txtPhone: TAdvEdit;
    txtHp: TAdvEdit;
    ToolBar1: TToolBar;
    tbtNew: TToolButton;
    tbtSave: TToolButton;
    WinXP1: TWinXP;
    txtAddress2: TAdvEdit;
    txtPostCode: TAdvEdit;
    txtCotact: TAdvEdit;
    Label1: TLabel;
    Bevel1: TBevel;
    Label2: TLabel;
    Bevel2: TBevel;
    Label3: TLabel;
    Bevel3: TBevel;
    Panel1: TPanel;
    ToolBarAnimal: TToolBar;
    ToolButton1: TToolButton;
    tbtDetail: TToolButton;
    ToolButton3: TToolButton;
    ToolButton2: TToolButton;
    tbtRefresh: TToolButton;
    grid: TAdvStringGrid;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    gridService: TAdvStringGrid;
    txtDiscount: TAdvEdit;
    chkWajibDisc: TCheckBox;
    procedure tbtNewClick(Sender: TObject);
    procedure tbtSaveClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure txtCodeChange(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure gridGetEditorType(Sender: TObject; ACol, ARow: Integer;
      var AEditor: TEditorType);
    procedure gridCanEditCell(Sender: TObject; ARow, ACol: Integer;
      var CanEdit: Boolean);
    procedure gridComboChange(Sender: TObject; ACol, ARow,
      AItemIndex: Integer; ASelection: String);
    procedure tbtDetailClick(Sender: TObject);
    procedure gridCellValidate(Sender: TObject; Col, Row: Integer;
      var Value: String; var Valid: Boolean);
    procedure gridComboObjectChange(Sender: TObject; ACol, ARow,
      AItemIndex: Integer; ASelection: String; AObject: TObject);
    procedure gridServiceGetAlignment(Sender: TObject; ARow, ACol: Integer;
      var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure ToolButton3Click(Sender: TObject);
    procedure tbtRefreshClick(Sender: TObject);
    procedure chkWajibDiscClick(Sender: TObject);
  private
    Relation: TMstRelation;
    Purpose: integer;
    lsSex,lsJenisHewan : TStringList;

    procedure ResetData;
    procedure setEnableDisabled;
    procedure InitForm;
    procedure initGrid;
    procedure LoadData;
    procedure LoadDataAnimal;
    procedure LoadDataService;
    function isSaved: boolean;
    function isValid: boolean;
    function isSavedAnimal: boolean;
    function isValidAnimal: boolean;
  public
    procedure Execute( vRelasiId: integer);
    function ExecuteNew(var ID: integer): boolean;
  end;

var
  frmMstRelationAnimal: TfrmMstRelationAnimal;

implementation

uses UConstTool, Subroutines, MainMenu,uMysqlClient, MySQLConnector;
const
  colNo = 0;
  colNama = 1;
  colJenis = 2;
  colSex = 3;
  colRas = 4;
  colMakanan =5;
  colUsia = 6;

  colSexId =7;
  colAnimalId =8;


{$R *.dfm}

{ TfrmMstRelation }

procedure TfrmMstRelationAnimal.Execute( vRelasiId: integer);
begin
  Purpose:= RELASI_TYPE_CUSTOMER;
  Relation:= TMstRelation.Create();
  Relation.RelationId:= vRelasiId;
  Relation.RelationType:= Purpose;
  lsSex := TStringList.Create;
  lsJenisHewan := TStringList.Create;
  lsSex.Add('0=Betina');
  lsSex.Add('1=Jantan');
  InitForm;
  if vRelasiId <> 0 then LoadData;
  Run(Self);
end;

procedure TfrmMstRelationAnimal.InitForm;
begin
  case Purpose of
    RELASI_TYPE_SUPPLIER: Self.Caption:= 'Data Supplier';
    RELASI_TYPE_CUSTOMER: Self.Caption:= 'Data Customer';
    RELASI_TYPE_SALESMAN: Self.Caption:= 'Data Salesman';
    RELASI_TYPE_MEMBER  : Self.Caption:= 'Data Member';
  end;
  ResetData;
end;

function TfrmMstRelationAnimal.isSaved: boolean;
begin
  Relation.RelationCode:= txtCode.Text;
  Relation.RelationId:= txtCode.Tag;
  Relation.RelationType:= Purpose;
  Relation.RelationName:= txtName.Text;
  Relation.Address1:= txtAddress.Text;
  Relation.Address2:= txtAddress2.Text;
  Relation.PostCode:= txtPostCode.Text;
  Relation.City:= txtCity.Text;
  Relation.Phone1:= txtPhone.Text;
  Relation.Phone2:= txtHp.Text;
  Relation.ContactPerson:= txtCotact.Text;
  Relation.Discount := StrFmtToFloatDef(txtDiscount.Text,0);
  Relation.WajibDiscount := IfThen(chkWajibDisc.Checked,1,0);

  if txtCode.Tag <> 0 then
    Result:= Relation.UpdateOnDB
  else Result:= Relation.InsertOnDB;
  tbtSave.Enabled:= not Result;
  txtCode.Tag:= Relation.RelationID;
  txtCode.Text:= Relation.RelationCode;
  setEnableDisabled;
end;

function TfrmMstRelationAnimal.isValid: boolean;
begin
  if CekInput(Result, txtCode.Text <> '', 'Kode belum diisi.', txtCode) then
    if CekInput(Result, txtName.Text <> '', 'Nama belum diisi.', txtName) then
     if CekInput(Result, ((not Relation.isExistInDb(txtCode.Text, Purpose)) and (txtCode.Tag = 0)) or (txtCode.Tag <> 0), 'Kode Sudah ada.', txtCode) then
       CekInput(Result,((chkWajibDisc.Checked) and (StrToFloatDef(txtDiscount.Text,0)>0)) or (not chkWajibDisc.Checked),'Nilai Discount harus diisi',txtDiscount)

end;

procedure TfrmMstRelationAnimal.LoadData;
begin
  Relation.SelectInDB;
  txtCode.Text:=        Relation.RelationCode;
  txtCode.Tag:=         Relation.RelationId;
  txtName.Text:=        Relation.RelationName;
  txtAddress.Text:=     Relation.Address1;
  txtAddress2.Text:=    Relation.Address2;
  txtPostCode.Text:=    Relation.PostCode;
  txtCity.Text:=        Relation.City;
  txtPhone.Text:=       Relation.Phone1;
  txtHp.Text:=          Relation.Phone2;
  txtCotact.Text:=      Relation.ContactPerson;
  chkWajibDisc.Checked := Relation.WajibDiscount = 1;
  txtDiscount.Text := FloatToStrFmt(Relation.Discount);
  LoadDataAnimal;
  LoadDataService;
  setEnableDisabled;
end;

procedure TfrmMstRelationAnimal.ResetData;
begin
  TMstAnimal.getListCombo(lsJenisHewan);
  PageControl1.ActivePageIndex := 0;
  txtCode.Clear;
  txtName.Clear;
  txtAddress.Clear;
  txtAddress2.Clear;
  txtPostCode.Clear;
  txtCity.Clear;
  txtPhone.Clear;
  txtHp.Clear;
  txtCotact.Clear;
  txtCode.Tag:= 0;
  txtDiscount.Text:= '0';
  tbtSave.Enabled:= True;
  chkWajibDisc.Checked := False;

  txtDiscount.Visible := GlobalSystemUser.AccessLevel > LEVEL_OPERATOR;
  chkWajibDisc.Visible := GlobalSystemUser.AccessLevel > LEVEL_OPERATOR;
 // ToolBarAnimal.Enabled := False;
 setEnableDisabled;
  initGrid;
  txtCode.Text:= Relation.GetNextCode(Purpose);
end;

procedure TfrmMstRelationAnimal.tbtNewClick(Sender: TObject);
begin
  if not TSystemAccess.isCan(CAN_ADD,AktiveControl.Tag) then exit;
  ResetData;
  txtName.SetFocus;
end;

procedure TfrmMstRelationAnimal.tbtSaveClick(Sender: TObject);
begin
  if isValid then isSaved
end;

procedure TfrmMstRelationAnimal.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Relation.Free;
  lsJenisHewan.Free;
  lsSex.Free;
  reAssignLastControl
end;

procedure TfrmMstRelationAnimal.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose:= True
end;

procedure TfrmMstRelationAnimal.txtCodeChange(Sender: TObject);
var sudah_enabled: boolean;
begin
  sudah_enabled:= tbtSave.Enabled;
  if not sudah_enabled then
    tbtSave.Enabled:= (Sender as TAdvEdit).Modified;
end;

procedure TfrmMstRelationAnimal.FormPaint(Sender: TObject);
begin
  AssigControl(Sender);
end;

procedure TfrmMstRelationAnimal.ToolButton1Click(Sender: TObject);
begin
  grid.AddRow;
  grid.Row := grid.RowCount-1;
  grid.Col := colNama;
end;

procedure TfrmMstRelationAnimal.initGrid;
begin
  ResetGrid(grid,2,colAnimalId+2,1,1,-1);
  grid.Cells[colNo,0] := 'No.';
  grid.Cells[colNama,0] := 'Nama Hewan';
  grid.Cells[colJenis,0] := 'Jenis Hewan';
  grid.Cells[colRas,0] := 'Ras';
  grid.Cells[colMakanan,0] := 'Makanan';
  grid.Cells[colUsia,0] := 'Usia';
  grid.Cells[colSex,0] := 'Sex';
  grid.Cells[colAnimalID,0] := 'AnimalID';
   grid.Cells[colSexID,0] := 'Sex';
  grid.AutoSizeColumns(True,2);
  grid.ColWidths[colSex] := 60;
  grid.ColWidths[colJenis] := 120;

  grid.ColWidths[colSexId] := 0;
  grid.ColWidths[colAnimalId] := 0;


end;

procedure TfrmMstRelationAnimal.setEnableDisabled;
begin
   ToolBarAnimal.Enabled := txtCode.Tag <> 0;
   grid.Enabled := txtCode.Tag <> 0;

end;

procedure TfrmMstRelationAnimal.gridGetEditorType(Sender: TObject; ACol,
  ARow: Integer; var AEditor: TEditorType);
begin
  case ACol of
      colSex : begin
          AEditor := edComboList;
          NameValueListToValueList(lsSex, grid.Combobox.Items);
      end;
      colJenis : begin
          AEditor := edComboList;
          NameValueListToValueList(lsJenisHewan, grid.Combobox.Items);
      end;
    //  colUsia : AEditor := edFloat;
      
  end;
end;

procedure TfrmMstRelationAnimal.gridCanEditCell(Sender: TObject; ARow,
  ACol: Integer; var CanEdit: Boolean);
begin
  CanEdit := (ACol in [colNama,colJenis,colSex,colRas,colMakanan,colUsia]);
end;

procedure TfrmMstRelationAnimal.gridComboChange(Sender: TObject; ACol,
  ARow, AItemIndex: Integer; ASelection: String);
begin
  case ACol of
    colJenis : begin
        if AItemIndex <> -1 then
          grid.Cells[colanimalId,ARow] := lsJenisHewan.Names[AItemIndex];
    end;
        colSex : begin
        if AItemIndex <> -1 then
          grid.Cells[colSexId,ARow] := lsSex.Names[AItemIndex];
    end;
  end;
end;

function TfrmMstRelationAnimal.isSavedAnimal: boolean;
var i : integer;
begin
  Relation.FRelationAnimal.Clear;
  for i:= 1 to grid.RowCount-1 do begin
    if grid.Cells[colNama,i] = '' then begin
        Alert('Nama hewan belum diisi');exit;
    end;
    if grid.Cells[colAnimalId,i] = '' then Continue;
    Relation.FRelationAnimal.Add(txtCode.Tag,i,grid.Cells[colNama,i],
        grid.Ints[colAnimalId,i],grid.Cells[colRas,i],grid.Cells[colMakanan,i],
        grid.Cells[colUsia,i],grid.Ints[colSexID,i],-1);
        //StrToInt(lsSex.Names[lsSex. grid.Cells[colSex,i])
  end;

  Result := Relation.saveAnimal;
  if Result then begin
    Inform('Data Hewan berhasil disimpan');
    LoadDataAnimal;
  end;
end;

function TfrmMstRelationAnimal.isValidAnimal: boolean;
  function cek_data: boolean;
 var i: integer;
 begin
  Result:= False;
  for i:= 1 to grid.RowCount-1 do begin



    result:= not IsClear(grid, colAnimalId, i);

{    if IsClear(grid, colNama, i) then begin
        Break;
    end;}

    if not Result then
       Exit;
  end;
  end;

begin
  Result := True; //CekInput(Result, cek_data, 'Tidak ada item untuk disimpan.', grid);
end;

procedure TfrmMstRelationAnimal.tbtDetailClick(Sender: TObject);
begin
  if isValidAnimal then isSavedAnimal;
end;

procedure TfrmMstRelationAnimal.LoadDataAnimal;
var i:integer; animal: TMysqlResult;
begin
   animal := Relation.loadAnimal;
   initGrid;
   //0a.relation_id,1a.seq,2a.animal_name, 3a.animal_id, 4a.race, 5a.eat, 6a.age, 7a.sex, 8a.disabled
   for i:= 0 to animal.RecordCount-1 do begin
     grid.Ints[colNo,i+1] := BufferToInteger(animal.FieldValue(1));
      grid.Cells[colNama,i+1]:= BufferToString(animal.FieldValue(2));
      grid.Cells[colRas,i+1]:= BufferToString(animal.FieldValue(4));
      grid.Cells[colMakanan,i+1]:= BufferToString(animal.FieldValue(5));
      grid.Cells[colUsia,i+1]:= BufferToString(animal.FieldValue(6));
      grid.Cells[colJenis,i+1]:= lsJenisHewan.Values[BufferToString(animal.FieldValue(3))];
      grid.Cells[colSex,i+1]:= lsSex.Values[BufferToString(animal.FieldValue(7))];
      grid.Ints[colAnimalId,i+1]:= BufferToInteger(animal.FieldValue((3)));
      grid.Ints[colSexId,i+1]:= BufferToInteger(animal.FieldValue((7)));
      animal.MoveNext;
      grid.AddRow;
   end;
   animal.destroy;
   grid.ColWidths[colSexId] := 0;
  grid.ColWidths[colAnimalId] := 0;
   DeleteRowTerakhir(grid,2,1);
end;

procedure TfrmMstRelationAnimal.gridCellValidate(Sender: TObject; Col,
  Row: Integer; var Value: String; var Valid: Boolean);
begin
    case Col of
    colNama: begin
      Valid := Value <> '';
      if not Valid then begin
          Alert('Nama belum diisi');
          grid.Col := colNama;
          grid.Row := Row;
      end;

    end;
    colSex:
    begin
      grid.Cells[colsexId, Row]:= lsSex.Names[grid.Combobox.ItemIndex];
      tbtSave.Enabled:= True;
    end;
     colJenis:
    begin
      grid.Cells[colAnimalId, Row]:= lsJenisHewan.Names[grid.Combobox.ItemIndex];
      tbtSave.Enabled:= True;
    end;

   { colUsia:
    begin
      Valid:= True; //Value <> '';
      if not Valid then begin
        Inform('Inputan belum diisi.');
        grid.Col:= Col;
        grid.Row:= Row;
        exit;
      end else
      begin
        Value:= FloatToStrFmt(StrFmtToFloatDef(Value,0));

      end;
    end;}
  end;
end;

procedure TfrmMstRelationAnimal.gridComboObjectChange(Sender: TObject;
  ACol, ARow, AItemIndex: Integer; ASelection: String; AObject: TObject);
begin
case ACol of
    colJenis : begin
        if AItemIndex <> -1 then
          grid.Cells[colanimalId,ARow] := lsJenisHewan.Names[AItemIndex];
    end;
     colSex : begin
        if AItemIndex <> -1 then
          grid.Cells[colSexId,ARow] := lsSex.Names[AItemIndex];
    end;
  end;
end;

function TfrmMstRelationAnimal.ExecuteNew(var ID: integer): boolean;
begin
//     NewMode:= True;
  Purpose:= RELASI_TYPE_CUSTOMER;
  lsSex := TStringList.Create;
  lsJenisHewan := TStringList.Create;
  lsSex.Add('0=Betina');
  lsSex.Add('1=Jantan');
  Relation:= TMstRelation.Create();
  Relation.RelationID:= ID;

  InitForm;
  if ID <> 0 then LoadData;
  Run(Self);
  Result:= ModalResult = mrOk;
  if result then ID:= txtCode.Tag;
end;

procedure TfrmMstRelationAnimal.LoadDataService;
var i,j,row:integer; service,detail: TMysqlResult;
begin
   service := Relation.loadService;
   gridService.ExpandAll;
   gridService.Clear;
   ResetGrid(gridService,2,6,1,1,-1);
   gridService.Cells[1,0] := 'Jenis Jasa';
   gridService.Cells[2,0] := 'Jumlah';
   gridService.Cells[3,0] := 'Total';

   //0a.mst_id,mst_name,jumlah
   for i:= 0 to service.RecordCount-1 do begin
      row :=  gridService.RowCount-1;

      gridService.Cells[1,row]:= BufferToString(service.FieldValue(1));
      gridService.ints[2,row]:= BufferToInteger(service.FieldValue(2));
      gridService.ints[3,row]:= BufferToInteger(service.FieldValue(3));
      gridService.ints[4,row]:= BufferToInteger(service.FieldValue(0));
      detail := Relation.loadServiceDetail(BufferToInteger(service.FieldValue(0)));
      for j:= 0 to detail.RecordCount-1 do begin
          gridService.AddRow;
          row := gridService.RowCount-1;

          gridService.Cells[1,row] := FormatDateTime(ShortDateFormat,BufferToDateTime(detail.FieldValue(0)));
          gridService.Cells[2,row]:= FloatToStrFmt(BufferToFloat(detail.FieldValue(1)));
          detail.MoveNext;
      end;

      if detail.RecordCount>0 then
        gridService.AddNode(row-detail.RecordCount,detail.RecordCount+1);


      service.MoveNext;
      gridService.AddRow;
   end;
   service.destroy;
   gridService.ContractAll;
   gridService.AutoSizeColumns(True,2);
   gridService.ColWidths[4] := 0;
   DeleteRowTerakhir(gridService,2,1);


end;

procedure TfrmMstRelationAnimal.gridServiceGetAlignment(Sender: TObject;
  ARow, ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  if ACol in [2,3] then HAlign := taRightJustify;
end;

procedure TfrmMstRelationAnimal.ToolButton3Click(Sender: TObject);
begin
  //if not TSystemAccess.isCan(CAN_DELETE,AktiveControl.Tag) then exit;
  if Confirmed('Hapus Hewan ?') then
  if TMstRelation.deleteAnimal(txtCode.Tag, grid.Ints[colNo, grid.Row]) then begin
     grid.ClearRows(grid.Row,1);
     if grid.RowCount > 2 then grid.RemoveRows(grid.Row,1);
  end;
end;

procedure TfrmMstRelationAnimal.tbtRefreshClick(Sender: TObject);
begin
  LoadDataAnimal;
end;

procedure TfrmMstRelationAnimal.chkWajibDiscClick(Sender: TObject);
begin
   tbtSave.Enabled:= True;
end;

end.
