unit Bonus;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, AdvEdit, Grids, BaseGrid, AdvGrid,UMaster,frmDockForm,Math,
  SUIImagePanel,UPetshop, ExtCtrls;

type
  TfrmBonus = class(TDockForm)
    txtDisc: TAdvEdit;
    suiPanel1: TsuiPanel;
    suiPanel2: TsuiPanel;
    grid: TAdvStringGrid;
    btnSave: TButton;
    procedure btnSaveClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure gridGetEditorType(Sender: TObject; ACol, ARow: Integer;
      var AEditor: TEditorType);
    procedure gridCanEditCell(Sender: TObject; ARow, ACol: Integer;
      var CanEdit: Boolean);
    procedure gridGetAlignment(Sender: TObject; ARow, ACol: Integer;
      var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure gridCellValidate(Sender: TObject; Col, Row: Integer;
      var Value: String; var Valid: Boolean);
  private
    { Private declarations }
    mst : TMstMaster;
    bonus : TMstServiceBonus;
     lsJenis:TStringList;
    procedure init;
    function isValid:boolean;
    function isSaved:boolean;
  public
    { Public declarations }
    procedure Execute(id: integer=0);override;
  end;

var
  frmBonus: TfrmBonus;

implementation

uses Subroutines, UConst,  uMysqlClient, MySQLConnector,MainMenu,
  UConstTool;
const
  colServiceType = 0;
  colServiceJml =1;
  colBonusService = 2;
  colBonusJml =3;
  colKumulatif = 4;
  colBonusServiceId = 5;
  colId = 6;



{$R *.dfm}

{ TfrmBonus }

procedure TfrmBonus.init;
var data : TMysqlResult ;i:integer;
begin
  txtDisc.Text:= TSystemConfig.getValue(CONF_DISC_VAL_PROMO);
  ResetGrid(grid,2,colId+2,1,1,-1);
  data:= bonus.load;
  for i:= 0 to data.RecordCount-1 do begin
      grid.Cells[colServiceType,i+1] := BufferToString(data.FieldValue(0));
      grid.Cells[colServiceJml,i+1] := FloatToStrFmt(BufferToInteger(data.FieldValue(1)));

      //grid.Combobox.ItemIndex := BufferToInteger(data.FieldValue(2));
      grid.Cells[colBonusService,i+1] := TMstService.GetName(BufferToInteger(data.FieldValue(2))) ;//TMstMaster.getName(BufferToInteger(data.FieldValue(2)));
      grid.Cells[colBonusJml,i+1] := FloatToStrFmt(BufferToInteger(data.FieldValue(3)));
      grid.Ints[colBonusServiceId,i+1]:= BufferToInteger(data.FieldValue(2));
      grid.AddCheckBox(colKumulatif,i+1,(BufferToInteger(data.FieldValue(5))=1),true);
      grid.SetCheckBoxState(colKumulatif,i+1,(BufferToInteger(data.FieldValue(5))=1));
     // grid.Ints[colKumulatif,i+1]:= BufferToInteger(data.FieldValue(5));
      grid.Ints[colId,i+1] := BufferToInteger(data.FieldValue(4));
      data.MoveNext;
      grid.AddRow;
  end;

  DeleteRowTerakhir(grid,2,1);
  grid.AutoSizeColumns(True,2);
  grid.ColWidths[colId] := 0;
  grid.ColWidths[colBonusService] := 200;
  grid.ColWidths[colBonusServiceId] := 0;

end;

function TfrmBonus.isSaved: boolean;
var conf : TSystemConfig;    i:integer;
   check :boolean;
begin
  conf := TSystemConfig.Create;
  try
    BeginSQL;
    conf.ConfId := CONF_DISC_VAL_PROMO;
    conf.ConfValue := txtDisc.Text;
    conf.UpdateOnDB;
    for i:= 1 to grid.RowCount-1 do begin
       bonus.reset;
       bonus.FServiceType := grid.Ints[colID,i];
       bonus.FJmlService := grid.Ints[colServiceJml,i];
       grid.GetCheckBoxState(colKumulatif,i,check);
       bonus.FIsKumulatif := IfThen(check,1,0);
       bonus.FBonusService:=  grid.Ints[colBonusServiceId,i]; //StrToIntDef(lsJenis.Names[grid.Combobox.itemindex],-1);
       bonus.FBonusJml := grid.Ints[colBonusJml,i];
       bonus.UpdateOnDb;
    end;
    Inform(MSG_SUCCESS_UPDATE);
    EndSQL;
  except
    UndoSQL;
    Alert(MSG_UNSUCCESS_UPDATE);
  end;
  
end;

function TfrmBonus.isValid: boolean;
begin
  Result := True;
end;

procedure TfrmBonus.btnSaveClick(Sender: TObject);
begin
   if not TSystemAccess.isCan(CAN_EDIT,AktiveControl.Tag) then exit;
     if isValid then isSaved;
end;

procedure TfrmBonus.execute(id:integer=0);
begin
  inherited;
  bonus := TMstServiceBonus.Create;
  lsJenis := TStringList.Create;
 // TMstMaster_Arr.GetList(lsJenis,MST_TYPE_SERVICE);
  TMstService.GetList(lsJenis);
  //NameValueListToValueList(lsJenis,cmbJenis.Items);
  init;
  Run(Self);
end;

procedure TfrmBonus.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  bonus.Free;
  lsJenis.Free;
end;

procedure TfrmBonus.gridGetEditorType(Sender: TObject; ACol, ARow: Integer;
  var AEditor: TEditorType);
begin
  inherited;
  case ACol of
    colBonusService :begin
    AEditor := edComboList;
    NameValueListToValueList(lsJenis,grid.Combobox.Items);
    end;
    colServiceJml,colBonusJml : AEditor := edPositiveNumeric;
    colKumulatif :AEditor := edCheckBox;
  end;
end;

procedure TfrmBonus.gridCanEditCell(Sender: TObject; ARow, ACol: Integer;
  var CanEdit: Boolean);
begin
  inherited;
   CanEdit := ACol in [colBonusService,colBonusJml,colServiceJml,colKumulatif];
end;

procedure TfrmBonus.gridGetAlignment(Sender: TObject; ARow, ACol: Integer;
  var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  inherited;
  if ACol in [colServiceJml,colBonusJml] then HAlign := taRightJustify
  else if acol in [colKumulatif] then HAlign := taCenter;
end;

procedure TfrmBonus.gridCellValidate(Sender: TObject; Col, Row: Integer;
  var Value: String; var Valid: Boolean);
begin
  inherited;
   case Col of
     colBonusService : begin
       grid.Cells[colBonusServiceId, Row]:= lsJenis.Names[grid.Combobox.ItemIndex];
     end;
   end;
end;

end.
