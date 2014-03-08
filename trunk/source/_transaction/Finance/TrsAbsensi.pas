unit TrsAbsensi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, AdvEdit, ToolWin,strUtils,
  UMaster, WinXP, ExtCtrls,UPetshop;

type
  TfrmTrsAbsensi = class(TForm)
    txtName: TAdvEdit;
    ToolBar1: TToolBar;
    tbtNew: TToolButton;
    tbtSave: TToolButton;
    WinXP1: TWinXP;
    Label1: TLabel;
    cmbStatusAbsen: TComboBox;
    dtpTglAbsen: TDateTimePicker;
    Label2: TLabel;
    Label3: TLabel;
    mmKeterangan: TMemo;
    Button1: TButton;
    Label4: TLabel;
    dtpMasuk: TDateTimePicker;
    Label5: TLabel;
    dtpPulang: TDateTimePicker;
    procedure tbtNewClick(Sender: TObject);
    procedure tbtSaveClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure txtCodeChange(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure cmbStatusAbsenChange(Sender: TObject);
  private
    Absensi: TTrsAbsensi;
    lsStatusAbsen:TStringList;
    V_ID : Int64;
    procedure ResetData;
    procedure InitForm;
    procedure LoadData;
    function isSaved: boolean;
    function isValid: boolean;
  public
    procedure Execute(vRelasiId: int64);
  end;

var
  frmTrsAbsensi: TfrmTrsAbsensi;

implementation

uses UConstTool, Subroutines, MainMenu, UConst, LookupData;

{$R *.dfm}

{ TfrmMstRelation }


procedure TfrmTrsAbsensi.InitForm;
begin
  Self.Caption:= 'Data Absensi Karyawan';
  
  ResetData;
end;

function TfrmTrsAbsensi.isSaved: boolean;
begin
  Absensi.FAbsenId:= V_ID;

  Absensi.FKaryawan.KaryawanId:= txtName.Tag;
  Absensi.StatusAbsen:= StrToInt(lsStatusAbsen.Names[cmbStatusAbsen.itemIndex]);
  Absensi.Tanggal:= dtpTglAbsen.Date;
  Absensi.Keterangan:= mmKeterangan.Text;
  Absensi.JamMasuk :=  dtpMasuk.Time;
  Absensi.JamKeluar :=  dtpPulang.Time;
  if V_ID <> 0 then
    Result:= Absensi.UpdateOnDB
  else Result:= Absensi.InsertOnDB;
  tbtSave.Enabled:= not Result;
  if (Result) then Inform('Data telah disimpan')
  else Inform('Data GAGAL disimpan');
  V_ID:= Absensi.AbsenId;
end;

function TfrmTrsAbsensi.isValid: boolean;
begin
  if CekInput(Result, txtName.Tag <>0, 'Karyawan belum diisi.', txtName) then
      if CekInput(Result, cmbStatusAbsen.ItemIndex<> -1, 'Status Absen belum ditentukan.', cmbStatusAbsen) then
        CekInput(Result, ((not Absensi.isExistInDb(txtName.Tag,dtpTglAbsen.Date)) and ( V_ID= 0)) or (V_ID <> 0), txtName.Text +' untuk tanggal '+DateTimeToStr(dtpTglAbsen.Date)+' suda ada data absensi ', txtName)
end;

procedure TfrmTrsAbsensi.LoadData;
begin
  Absensi.SelectInDB;
  txtName.Text:=        Absensi.FKaryawan.Nama;
  txtName.Tag := Absensi.FKaryawan.KaryawanId;
  mmKeterangan.Text:=     Absensi.Keterangan;
  dtpTglAbsen.DateTime:=       Absensi.Tanggal;
  cmbStatusAbsen.ItemIndex := lsStatusAbsen.IndexOfName(IntToStr(Absensi.StatusAbsen));
  cmbStatusAbsenChange(self);
  dtpMasuk.Time := Absensi.JamMasuk;
  dtpPulang.Time := Absensi.JamKeluar;
  Button1.Enabled := False;
  dtpTglAbsen.Enabled := False;
end;

procedure TfrmTrsAbsensi.ResetData;
begin
  txtName.Clear;
  mmKeterangan.Clear;
  V_ID := 0;
  txtName.Tag:= 0;
  tbtSave.Enabled:= True;
  dtpTglAbsen.Date := Now;
  cmbStatusAbsen.ItemIndex := -1;
  dtpPulang.Time := 0;
  dtpMasuk.DateTime := now;
  dtpMasuk.Enabled := False;
  dtpPulang.Enabled := False;
  Button1.Enabled := True;
   dtpTglAbsen.Enabled := True;
end;

procedure TfrmTrsAbsensi.tbtNewClick(Sender: TObject);
begin
  if not TSystemAccess.isCan(CAN_ADD,AktiveControl.Tag) then exit;
  ResetData;
  txtName.SetFocus;
end;

procedure TfrmTrsAbsensi.tbtSaveClick(Sender: TObject);
begin
  if isValid then isSaved
end;

procedure TfrmTrsAbsensi.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Absensi.Free;
  reAssignLastControl
end;

procedure TfrmTrsAbsensi.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose:= True
end;

procedure TfrmTrsAbsensi.txtCodeChange(Sender: TObject);
var sudah_enabled: boolean;
begin
  sudah_enabled:= tbtSave.Enabled;
  if not sudah_enabled then
    tbtSave.Enabled:= (Sender as TAdvEdit).Modified;
end;

procedure TfrmTrsAbsensi.FormPaint(Sender: TObject);
begin
  AssigControl(Sender);
end;


procedure TfrmTrsAbsensi.Execute(vRelasiId: int64);
begin
  Absensi:= TTrsAbsensi.Create();
  Absensi.FAbsenId:= vRelasiId;
  lsStatusAbsen := TStringList.Create;
  TMstMaster_Arr.GetList(lsStatusAbsen,MST_TYPE_ABSEN);
  NameValueListToValueList(lsStatusAbsen,cmbStatusAbsen.Items);
//  Absensi.AbsensiType:= vPurpose;

  InitForm;
  V_ID := vRelasiId;
  if V_ID <> 0 then LoadData;
  Run(Self);//

end;

procedure TfrmTrsAbsensi.Button1Click(Sender: TObject);
var ID: integer;
begin
  ID:= frmlookup.Execute('KARYAWAN');
  if ID <> 0 then begin
    txtName.Tag := ID;
    txtName.Text:= TMstKaryawan.getName(ID);
  end;

end;




procedure TfrmTrsAbsensi.cmbStatusAbsenChange(Sender: TObject);
begin
  //dtpMasuk.Enabled := cmbStatusAbsen.Text = 'Hadir';
  //dtpPulang.Enabled := cmbStatusAbsen.Text = 'Hadir';
  


end;

end.
