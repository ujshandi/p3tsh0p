unit MstDokter;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, AdvEdit, ToolWin,strUtils,
  UMaster, WinXP, ExtCtrls;

type
  TfrmMstDokter = class(TForm)
    txtCode: TAdvEdit;
    txtName: TAdvEdit;
    txtAddress: TAdvEdit;
    ToolBar1: TToolBar;
    tbtNew: TToolButton;
    tbtSave: TToolButton;
    WinXP1: TWinXP;
    txtCotact: TAdvEdit;
    txtSpec: TAdvEdit;
    btnSpec: TButton;
    txtNamaSpesialis: TEdit;
    Label1: TLabel;
    procedure tbtNewClick(Sender: TObject);
    procedure tbtSaveClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure txtCodeChange(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnSpecClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    Relation: TMstDokter;
    NewMode: boolean;
    procedure ResetData;
    procedure InitForm;
    procedure LoadData;
    function isSaved: boolean;
    function isValid: boolean;
  public
    procedure Execute(vRelasiId: integer);
    function ExecuteNew(var ID: integer): boolean;
  end;

var
  frmMstDokter: TfrmMstDokter;

implementation

uses UConstTool, Subroutines, MainMenu, AutoStockLine, 
  LookupData;

{$R *.dfm}

{ TfrmMstRelation }

procedure TfrmMstDokter.Execute(vRelasiId: integer);
begin
  NewMode:= False;
  Relation:= TMstDokter.Create();
  Relation.DokterID:= vRelasiId;
   
  InitForm;
  if vRelasiId <> 0 then LoadData;
  Run(Self);
end;

procedure TfrmMstDokter.InitForm;
begin
  ResetData;
end;

function TfrmMstDokter.isSaved: boolean;
begin
  Relation.Kode:= txtCode.Text;
  Relation.DokterID:= txtCode.Tag;
  Relation.Nama:= txtName.Text;
  Relation.Alamat:= txtAddress.Text;
  Relation.Kontak:= txtCotact.Text;
  Relation.itemid:= txtSpec.Tag;
  Relation.spesialis:= txtNamaSpesialis.Text;

  if txtCode.Tag <> 0 then
    Result:= Relation.UpdateOnDB
  else Result:= Relation.InsertOnDB;
  tbtSave.Enabled:= not Result;
  txtCode.Tag:= Relation.DokterID;
  txtCode.Text:= Relation.Kode;
  if Result and NewMode then ModalResult:= mrOk;
end;

function TfrmMstDokter.isValid: boolean;
begin
  if CekInput(Result, txtName.Text <> '', 'Nama belum diisi.', txtName) then
     CekInput(Result, ((not Relation.isExistInDb(txtCode.Text)) and (txtCode.Tag = 0)) or (txtCode.Tag <> 0), 'Kode Sudah ada.', txtCode)
end;

procedure TfrmMstDokter.LoadData;
begin
  Relation.SelectInDB;
  txtCode.Text:=    Relation.Kode;
  txtCode.Tag:=     Relation.DokterID;
  txtName.Text:=    Relation.Nama;
  txtAddress.Text:= Relation.Alamat;
  txtCotact.Text:=  Relation.Kontak;
  txtSpec.Tag:= Relation.itemid;
  txtSpec.Text:= TMstItem.GetName(Relation.itemid);
  txtNamaSpesialis.Text:= Relation.spesialis; 
end;

procedure TfrmMstDokter.ResetData;
begin
  txtCode.Clear;
  txtName.Clear;
  txtAddress.Clear;
  txtCotact.Clear;
  txtCode.Tag:= 0;
  tbtSave.Enabled:= True;
  txtSpec.Clear;
  txtSpec.Tag:= 0;
  txtNamaSpesialis.Clear;

end;

procedure TfrmMstDokter.tbtNewClick(Sender: TObject);
begin
  ResetData;
  txtName.SetFocus;
end;

procedure TfrmMstDokter.tbtSaveClick(Sender: TObject);
begin
  if isValid then isSaved
end;

procedure TfrmMstDokter.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Relation.Free;
  reAssignLastControl
end;

procedure TfrmMstDokter.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose:= True
end;

procedure TfrmMstDokter.txtCodeChange(Sender: TObject);
var sudah_enabled: boolean;
begin
  sudah_enabled:= tbtSave.Enabled;
  if not sudah_enabled then
    tbtSave.Enabled:= (Sender as TAdvEdit).Modified;
end;

procedure TfrmMstDokter.FormPaint(Sender: TObject);
begin
  AssigControl(Sender);
end;

procedure TfrmMstDokter.FormShow(Sender: TObject);
begin
  txtName.SetFocus
end;

function TfrmMstDokter.ExecuteNew(var ID: integer): boolean;
begin
  NewMode:= True;
  Relation:= TMstDokter.Create();
  Relation.DokterID:= ID;

  InitForm;
  if ID <> 0 then LoadData;
  Run(Self);
  Result:= ModalResult = mrOk;
  if result then ID:= txtCode.Tag;
end;

procedure TfrmMstDokter.btnSpecClick(Sender: TObject);
var ID: integer;
begin
  id:= frmLookup.Execute('JASA_MEDIK');
  if Id > 0 then BEGIN
    txtSpec.Tag := ID;
    txtSpec.Text:= TMstItem.getName(ID);
    tbtSave.Enabled:= True;
  end;

end;

procedure TfrmMstDokter.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of VK_ESCAPE: ModalResult:= mrCancel; end;
end;

end.
