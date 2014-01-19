unit MstKaryawan;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, AdvEdit, ToolWin,strUtils,
  UMaster, WinXP, ExtCtrls,UPetshop;

type
  TfrmMstKaryawan = class(TForm)
    txtCode: TAdvEdit;
    txtName: TAdvEdit;
    txtAddress: TAdvEdit;
    txtPhone: TAdvEdit;
    txtHp: TAdvEdit;
    ToolBar1: TToolBar;
    tbtNew: TToolButton;
    tbtSave: TToolButton;
    WinXP1: TWinXP;
    Label1: TLabel;
    cmbJabatan: TComboBox;
    dtpTglLahir: TDateTimePicker;
    Label2: TLabel;
    procedure tbtNewClick(Sender: TObject);
    procedure tbtSaveClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure txtCodeChange(Sender: TObject);
    procedure FormPaint(Sender: TObject);
  private
    Relation: TMstKaryawan;
    lsJabatan:TStringList;
    procedure ResetData;
    procedure InitForm;
    procedure LoadData;
    function isSaved: boolean;
    function isValid: boolean;
  public
    procedure Execute(vPurpose, vRelasiId: integer);overload;
    procedure Execute(vRelasiId: integer);overload;
  end;

var
  frmMstKaryawan: TfrmMstKaryawan;

implementation

uses UConstTool, Subroutines, MainMenu, UConst;

{$R *.dfm}

{ TfrmMstRelation }

procedure TfrmMstKaryawan.Execute(vPurpose, vRelasiId: integer);
begin
  Relation:= TMstKaryawan.Create();
  Relation.FKaryawanId:= vRelasiId;
//  Relation.RelationType:= vPurpose;

  InitForm;
  if vRelasiId <> 0 then LoadData;
  Run(Self);
end;

procedure TfrmMstKaryawan.InitForm;
begin
  Self.Caption:= 'Data Karyawan';
  
  ResetData;
end;

function TfrmMstKaryawan.isSaved: boolean;
begin
  Relation.KaryawanId:= txtCode.Tag;
  Relation.Nik:= txtCode.Text;
  Relation.Nama:= txtName.Text;
  Relation.Jabatan:= StrToInt(lsJabatan.Names[cmbJabatan.itemIndex]);
//  Relation.TglLahir:= txtAddress2.Text;
  Relation.Telp1:= txtPhone.Text;
  Relation.Telp2:= txtHp.Text;
  Relation.Alamat := txtAddress.Text;
  Relation.TglLahir := dtpTglLahir.Date;
  if txtCode.Tag <> 0 then
    Result:= Relation.UpdateOnDB
  else Result:= Relation.InsertOnDB;

  if (Result) then Inform('Data telah tersimpan')
  else Alert('Data GAGAL disimpan');
  tbtSave.Enabled:= not Result;
  txtCode.Tag:= Relation.KaryawanId;
  txtCode.Text:= Relation.Nik;
end;

function TfrmMstKaryawan.isValid: boolean;
begin
  if CekInput(Result, txtCode.Text <> '', 'Kode belum diisi.', txtCode) then
    if CekInput(Result, txtName.Text <> '', 'Nama belum diisi.', txtName) then
      if CekInput(Result, cmbJabatan.ItemIndex<> -1, 'Jenis Jabatan belum ditentukan.', cmbJabatan) then
       CekInput(Result, ((not Relation.isExistInDb(txtCode.Text)) and (txtCode.Tag = 0)) or (txtCode.Tag <> 0), 'Kode Sudah ada.', txtCode)
end;

procedure TfrmMstKaryawan.LoadData;
begin
  Relation.SelectInDB;
  txtCode.Text:=        Relation.Nik;
  txtCode.Tag:=         Relation.KaryawanId;
  txtName.Text:=        Relation.Nama;
  txtAddress.Text:=     Relation.Alamat;
  txtPhone.Text:=       Relation.Telp1;
  txtHp.Text:=          Relation.Telp2;
  cmbJabatan.ItemIndex := lsJabatan.IndexOfName(IntToStr(Relation.Jabatan));
end;

procedure TfrmMstKaryawan.ResetData;
begin
  txtCode.Clear;
  txtName.Clear;
  txtAddress.Clear;
  txtPhone.Clear;
  txtHp.Clear;
  txtCode.Tag:= 0;
  tbtSave.Enabled:= True;
  txtCode.Text:= Relation.GetNextCode(cmbJabatan.Tag);
end;

procedure TfrmMstKaryawan.tbtNewClick(Sender: TObject);
begin
  if not TSystemAccess.isCan(CAN_ADD,AktiveControl.Tag) then exit;
  ResetData;
  txtName.SetFocus;
end;

procedure TfrmMstKaryawan.tbtSaveClick(Sender: TObject);
begin
  if isValid then isSaved
end;

procedure TfrmMstKaryawan.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Relation.Free;
  reAssignLastControl
end;

procedure TfrmMstKaryawan.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose:= True
end;

procedure TfrmMstKaryawan.txtCodeChange(Sender: TObject);
var sudah_enabled: boolean;
begin
  sudah_enabled:= tbtSave.Enabled;
  if not sudah_enabled then
    tbtSave.Enabled:= (Sender as TAdvEdit).Modified;
end;

procedure TfrmMstKaryawan.FormPaint(Sender: TObject);
begin
  AssigControl(Sender);
end;

procedure TfrmMstKaryawan.Execute(vRelasiId: integer);
begin
//  Purpose:= vPurpose;
  Relation:= TMstKaryawan.Create();
  Relation.KaryawanId:= vRelasiId;
  lsJabatan := TStringList.Create;
  TMstMaster_Arr.GetList(lsJabatan,MST_TYPE_JABATAN);
  NameValueListToValueList(lsJabatan,cmbJabatan.Items);
//  Relation.RelationType:= vPurpose;

  InitForm;
  if vRelasiId <> 0 then LoadData;
  Run(Self);//
end;

end.
