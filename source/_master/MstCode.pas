unit MstCode;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, ToolWin, StdCtrls, AdvEdit, treelist,
  UMaster, SUIImagePanel,
  frmDockForm, SUITreeView;

type
  TfrmMstCode = class(TDockForm)
    ToolBar1: TToolBar;
    tbtNew: TToolButton;
    tbtSave: TToolButton;
    ToolButton5: TToolButton;
    tbtRefresh: TToolButton;
    suiPanel1: TsuiPanel;
    txtName: TAdvEdit;
    txtParent: TAdvEdit;
    txtUrut: TAdvEdit;
    suiPanel2: TsuiPanel;
    tbtDelete: TToolButton;
    ToolButton2: TToolButton;
    suiTreeView1: TsuiTreeView;
    txtKode: TAdvEdit;
    procedure tbtNewClick(Sender: TObject);
    procedure tbtSaveClick(Sender: TObject);
    procedure tbtRefreshClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tbtDeleteClick(Sender: TObject);
    procedure txtNameChange(Sender: TObject);
    procedure suiTreeView1Click(Sender: TObject);
    procedure suiTreeView1Collapsed(Sender: TObject; Node: TTreeNode);
    procedure txtKodeChange(Sender: TObject);
  private
    MstCode: TMstCode;
    PointMaping: TPointMaping;
    procedure ResetData;
    procedure ReloadGrid;
    procedure ReloadData(id: integer);
    procedure isSavedPoint(ID: integer);
    function isSaved:boolean;
    function isValid:boolean;
  public
    procedure Execute(id: integer=0); override;
  end;

var
  frmMstCode: TfrmMstCode;

implementation

uses Subroutines, MainMenu, UConstTool, MySQLConnector,
  uMysqlClient;

{$R *.dfm}

{ TfrmMstCode }

procedure TfrmMstCode.Execute(id: integer);
begin
  inherited;
  ToolBar1.ParentColor:= false;
  ToolBar1.Color:= clWhite;
  ResetData;
  MstCode:= TMstCode.Create();
  PointMaping:= TPointMaping.Create();
  ReloadGrid;
  Run(Self);
end;

function TfrmMstCode.isSaved: boolean;
begin
  MstCode.Reset;
  MstCode.CodeName:= txtName.Text;
  MstCode.Kode       := txtKode.Text;
  MstCode.CodeId  := txtName.Tag;
  MstCode.ParentId:= txtParent.Tag;
  MstCode.Level   := suiTreeView1.Selected.Level + 2;
  MstCode.Urut    := txtUrut.IntValue;

  if txtName.Tag <> 0 then
    Result:= MstCode.UpdateOnDB
  else begin
    try
      BeginSQL;
      MstCode.InsertOnDB;
      isSavedPoint(MstCode.CodeID);
      EndSQL;
      Result:= True;
    except
      Inform(MSG_UNSUCCESS_SAVING);
      UndoSQL;
      Result:= False;
    end;
  end;
  if Result then begin
    ReloadGrid;
    suiTreeView1.Items[0].Expand(True);
  end;
  tbtSave.Enabled:= not Result;
end;

function TfrmMstCode.isValid: boolean;
var vMsg: string;
begin
  Result:= txtName.Text <> '';
  vMsg:= 'Nama belum diisi.';
//  if Result then
 //   Result := not MstCode.isExistInDb(txtName.Text, txtParent.Tag);
  //vMsg:= 'Nama sudah ada.';

  if not Result then begin
    Inform(vMsg);
    txtName.SetFocus;
  end;
end;

procedure TfrmMstCode.ReloadData(id: integer);
begin
  ResetData;
  MstCode.Reset;
  MstCode.CodeId:= id;
  if not MstCode.SelectInDB then exit;
  txtName.Text  := MstCode.CodeName;
  txtKode.Text  := MstCode.Kode;
  txtName.Tag   := MstCode.CodeId;
  txtParent.Text:= MstCode.ParentName;
  txtParent.Tag := MstCode.ParentId;
  txtUrut.IntValue:= MstCode.Urut;
  tbtSave.Enabled:= False;
end;

procedure TfrmMstCode.ReloadGrid;
var treeParent: TTreeNode;

  procedure load_child(Klas: TMstCode; Parent, Idx: integer);
  var child: arMstCode;
    i, x: integer;
  begin                                          //(Idx >= -1))
    if ((Parent <> 1) and (Parent <> 0) and (Idx >= 0)) then
      suiTreeView1.Items.AddChild(suiTreeView1.Items[Idx], Klas.CodeName+'('+Klas.Kode+')')
    else suiTreeView1.Items.Add(treeParent,Klas.CodeName);
    suiTreeView1.Items.Item[suiTreeView1.Items.Count-1].StateIndex:= Klas.CodeID;
    suiTreeView1.Items.Item[suiTreeView1.Items.Count-1].SelectedIndex:= 1;
    x:= suiTreeView1.Items.Count-1;
    Klas.Reset;

    if TrMstCode_Arr.LoadFromDb(child, Parent) then begin
      for i:= 0 to Length(child)-1 do begin
        Klas.CodeID  := child[i].FCodeId;
        Klas.CodeName:= child[i].FCodeName;
        Klas.Kode      := child[i].FKode; 
        load_child(Klas, Klas.CodeID, x);
      end;
    end;
  end;

begin

  suiTreeView1.Items.Clear;
  treeParent:= TTreeNode.Create(suiTreeView1.Items);

  MstCode.Reset;
  MstCode.CodeID:= 1;
  MstCode.SelectInDB;
  load_child(MstCode, MstCode.CodeID, 0);
  if Assigned(suiTreeView1.Items[0]) then begin
    suiTreeView1.Items[0].Focused;
    suiTreeView1.Items[0].Expand(False);
  end;
end;

procedure TfrmMstCode.ResetData;
begin
  txtKode.Clear;
  txtName.Clear;
  txtParent.Clear;
  txtName.Tag:= 0;
  txtParent.Tag:= 0;
  //tbtSave.Enabled:= True;
end;

procedure TfrmMstCode.tbtNewClick(Sender: TObject);
begin
 if not TSystemAccess.isCan(CAN_ADD,AktiveControl.Tag) then exit;
  ResetData;
  txtName.SetFocus;
  if Assigned(suiTreeView1.Selected) then begin
    txtParent.Tag := suiTreeView1.Selected.StateIndex;
    txtParent.Text:= suiTreeView1.Selected.Text;
  end else Inform('Induk kode belum ditentukan.')
end;

procedure TfrmMstCode.tbtSaveClick(Sender: TObject);
begin
  if not TSystemAccess.isCan(CAN_EDIT,AktiveControl.Tag) then exit;
  if isValid then isSaved
end;

procedure TfrmMstCode.tbtRefreshClick(Sender: TObject);
begin
  ReloadGrid
end;

procedure TfrmMstCode.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if MstCode <> nil then MstCode.Free;
  MstCode:= nil;
  if PointMaping <> nil then PointMaping.Free;
  PointMaping:= nil;
end;

procedure TfrmMstCode.isSavedPoint(ID: integer);
var point: TMysqlResult; KlasMaping: TPointMaping;
begin
  KlasMaping:= TPointMaping.Create();
  KlasMaping.Reset;
  KlasMaping.CodeID:= ID;
  KlasMaping.RootID:= ID;
  KlasMaping.InsertOnDB;

  while (ID <> 0) do begin
    point:= OpenSQL(
    'select parent_id from mst_code where code_id = '+FormatSQLNumber(ID));
    if (point.RecordCount>0) then begin
      KlasMaping.RootID:= BufferToInteger(point.FieldValue(0));
      if KlasMaping.RootID <> 0 then
         KlasMaping.InsertOnDB;
    end;
    ID:= KlasMaping.RootId;
    point.Destroy;
  end;
  KlasMaping.Free;

{var vPoint: TTreeNode;
begin
  PointMaping.Reset;

  //mencatat yang terseleksi
  vPoint:= suiTreeView1.Selected;
  if vPoint.StateIndex <> 0 then begin
    PointMaping.CodeId:= vPoint.StateIndex;
    PointMaping.RootId:= vPoint.StateIndex;
  end
  else begin
    PointMaping.RootId:= MstCode.CodeId;
    PointMaping.CodeId:= MstCode.CodeId;
  end;

  PointMaping.InsertOnDB;
  PointMaping.CodeId:= MstCode.CodeId;
  vPoint:= suiTreeView1.Selected;
  while Assigned(vPoint) do begin
    if vPoint.StateIndex = 0 then
      PointMaping.RootId:= MstCode.CodeId
    else PointMaping.RootId:= vPoint.StateIndex;

    PointMaping.InsertOnDB;
    vPoint:= vPoint.Parent;
  end;
  }
end;

procedure TfrmMstCode.tbtDeleteClick(Sender: TObject);
begin
 if not TSystemAccess.isCan(CAN_DELETE,AktiveControl.Tag) then exit;
  if txtParent.Tag = 0 then begin
    Alert('Maaf tidak bisa dihapus yaa');exit;
  end;

  if Confirmed('Hapus data?') then
    if TMstCode.DeleteFromDb(suiTreeView1.Selected.StateIndex) then
      ReloadGrid;
end;

procedure TfrmMstCode.txtNameChange(Sender: TObject);
var sudah_enabled: boolean;
begin
  sudah_enabled:= tbtSave.Enabled;
  if not sudah_enabled then
    tbtSave.Enabled:= (Sender as TAdvEdit).Modified;
end;

procedure TfrmMstCode.suiTreeView1Click(Sender: TObject);
begin
  tbtDelete.Enabled:= False;
  tbtSave.Enabled:= False;
  if not Assigned(suiTreeView1.Selected) then exit;
  tbtDelete.Enabled:= suiTreeView1.Selected.StateIndex <> 0;
  //tbtSave.Enabled  := suiTreeView1.Selected.StateIndex <> 0;
  ReloadData(suiTreeView1.Selected.StateIndex)
end;

procedure TfrmMstCode.suiTreeView1Collapsed(Sender: TObject;
  Node: TTreeNode);
begin
  if Assigned(suiTreeView1.Items[0]) then begin
    suiTreeView1.Items[0].Focused;
    suiTreeView1.Items[0].Expand(False);
  end;
end;

procedure TfrmMstCode.txtKodeChange(Sender: TObject);
var sudah_enabled: boolean;
begin
  sudah_enabled:= tbtSave.Enabled;
  if not sudah_enabled then
    tbtSave.Enabled:= (Sender as TAdvEdit).Modified;

end;

end.
