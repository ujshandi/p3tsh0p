unit MstRelation;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, AdvEdit, ToolWin,strUtils,
  UMaster, WinXP, ExtCtrls;

type
  TfrmMstRelation = class(TForm)
    txtCode: TAdvEdit;
    txtName: TAdvEdit;
    txtAddress: TAdvEdit;
    txtCity: TAdvEdit;
    txtPhone: TAdvEdit;
    txtHp: TAdvEdit;
    txtDueDate: TAdvEdit;
    UpDown1: TUpDown;
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
    Bevel4: TBevel;
    Label4: TLabel;
    txtTax: TAdvEdit;
    procedure tbtNewClick(Sender: TObject);
    procedure tbtSaveClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure txtCodeChange(Sender: TObject);
    procedure FormPaint(Sender: TObject);
  private
    Relation: TMstRelation;
    Purpose: integer;
    procedure ResetData;
    procedure InitForm;
    procedure LoadData;
    function isSaved: boolean;
    function isValid: boolean;
  public
    procedure Execute(vPurpose, vRelasiId: integer);
  end;

var
  frmMstRelation: TfrmMstRelation;

implementation

uses UConstTool, Subroutines, MainMenu;

{$R *.dfm}

{ TfrmMstRelation }

procedure TfrmMstRelation.Execute(vPurpose, vRelasiId: integer);
begin
  Purpose:= vPurpose;
  Relation:= TMstRelation.Create();
  Relation.RelationId:= vRelasiId;
  Relation.RelationType:= vPurpose;
  
  InitForm;
  if vRelasiId <> 0 then LoadData;
  Run(Self);
end;

procedure TfrmMstRelation.InitForm;
begin
  case Purpose of
    RELASI_TYPE_SUPPLIER: Self.Caption:= 'Data Supplier';
    RELASI_TYPE_CUSTOMER: Self.Caption:= 'Data Customer';
    RELASI_TYPE_SALESMAN: Self.Caption:= 'Data Salesman';
    RELASI_TYPE_MEMBER  : Self.Caption:= 'Data Member';
  end;
  ResetData;
end;

function TfrmMstRelation.isSaved: boolean;
begin
  Relation.RelationCode:= txtCode.Text;
  Relation.RelationId:= txtCode.Tag;
  Relation.RelationType:= Purpose;
  Relation.RelationName:= txtName.Text;
  Relation.Address1:= txtAddress.Text;
  Relation.Address2:= txtAddress2.Text;
  Relation.PostCode:= txtPostCode.Text;
  Relation.City:= txtCity.Text;
  Relation.NPWP:= txtTax.Text;
  Relation.Phone1:= txtPhone.Text;
  Relation.Phone2:= txtHp.Text;
  Relation.ContactPerson:= txtCotact.Text;
  Relation.DueDate:= txtDueDate.IntValue;

  if txtCode.Tag <> 0 then
    Result:= Relation.UpdateOnDB
  else Result:= Relation.InsertOnDB;
  tbtSave.Enabled:= not Result;
  txtCode.Tag:= Relation.RelationID;
  txtCode.Text:= Relation.RelationCode;
end;

function TfrmMstRelation.isValid: boolean;
begin
  if CekInput(Result, txtCode.Text <> '', 'Kode belum diisi.', txtCode) then
    if CekInput(Result, txtName.Text <> '', 'Nama belum diisi.', txtName) then
     CekInput(Result, ((not Relation.isExistInDb(txtCode.Text, Purpose)) and (txtCode.Tag = 0)) or (txtCode.Tag <> 0), 'Kode Sudah ada.', txtCode)
end;

procedure TfrmMstRelation.LoadData;
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
  txtTax.Text:=         Relation.NPWP;
  txtDueDate.IntValue:= Relation.DueDate;
end;

procedure TfrmMstRelation.ResetData;
begin
  txtCode.Clear;
  txtName.Clear;
  txtAddress.Clear;
  txtTax.Clear;
  txtAddress2.Clear;
  txtPostCode.Clear;
  txtCity.Clear;
  txtPhone.Clear;
  txtHp.Clear;
  txtCotact.Clear;
  txtDueDate.Clear;
  txtCode.Tag:= 0;
  tbtSave.Enabled:= True;
  txtCode.Text:= Relation.GetNextCode(Purpose);
end;

procedure TfrmMstRelation.tbtNewClick(Sender: TObject);
begin
  if not TSystemAccess.isCan(CAN_ADD,AktiveControl.Tag) then exit;
  ResetData;
  txtName.SetFocus;
end;

procedure TfrmMstRelation.tbtSaveClick(Sender: TObject);
begin
  if isValid then isSaved
end;

procedure TfrmMstRelation.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Relation.Free;
  reAssignLastControl
end;

procedure TfrmMstRelation.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose:= True
end;

procedure TfrmMstRelation.txtCodeChange(Sender: TObject);
var sudah_enabled: boolean;
begin
  sudah_enabled:= tbtSave.Enabled;
  if not sudah_enabled then
    tbtSave.Enabled:= (Sender as TAdvEdit).Modified;
end;

procedure TfrmMstRelation.FormPaint(Sender: TObject);
begin
  AssigControl(Sender);
end;

end.
