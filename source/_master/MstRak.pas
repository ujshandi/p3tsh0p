unit MstRak;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, SUIImagePanel, ComCtrls, SUITreeView, StdCtrls,
  AdvEdit, ToolWin,
  UMaster, frmDockForm;

type
  TfrmMstRak = class(TDockForm)
    suiPanel1: TsuiPanel;
    suiPanel2: TsuiPanel;
    ToolBar1: TToolBar;
    tbtNew: TToolButton;
    tbtSave: TToolButton;
    ToolButton2: TToolButton;
    tbtDelete: TToolButton;
    ToolButton5: TToolButton;
    tbtRefresh: TToolButton;
    txtKode: TAdvEdit;
    txtNama: TAdvEdit;
    suiTreeView1: TsuiTreeView;
    txtParent: TAdvEdit;
    procedure txtKodeChange(Sender: TObject);
    procedure tbtNewClick(Sender: TObject);
    procedure tbtSaveClick(Sender: TObject);
    procedure tbtDeleteClick(Sender: TObject);
    procedure tbtRefreshClick(Sender: TObject);
    procedure suiTreeView1Click(Sender: TObject);
    procedure suiTreeView1Collapsed(Sender: TObject; Node: TTreeNode);
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
  frmMstRak: TfrmMstRak;

implementation

uses MySQLConnector, Subroutines, UConst, UConstTool,
  MainMenu, uMysqlClient;

{$R *.dfm}

{ TfrmMstRak }

procedure TfrmMstRak.Execute(id: integer);
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

function TfrmMstRak.isSaved: boolean;
begin
  MstCode.Reset;
  MstCode.CodeName:= txtNama.Text;
  MstCode.CodeId  := txtNama.Tag;
  MstCode.ParentId:= txtParent.Tag;
  MstCode.Kode    := txtKode.Text;
  MstCode.Level   := suiTreeView1.Selected.Level + 2;

  if txtNama.Tag <> 0 then
    Result:= MstCode.UpdateRak
  else begin
    try
      BeginSQL;
      MstCode.InsertRak;
      isSavedPoint(MstCode.CodeID);
      Inform(MSG_SUCCESS_SAVING);
      EndSQL;
      Result:= True;
    except
      Inform(MSG_UNSUCCESS_SAVING);
      UndoSQL;
      Result:= False;
    end;
  end;

  tbtSave.Enabled:= not Result;
end;

procedure TfrmMstRak.isSavedPoint(ID: integer);
var point: TMysqlResult; KlasMaping: TPointMaping;
begin
  KlasMaping:= TPointMaping.Create();
  KlasMaping.Reset;
  KlasMaping.CodeID:= ID;
  KlasMaping.RootID:= ID;
  KlasMaping.InsertRak;

  while (ID <> 0) do begin
    point:= OpenSQL(
    'select parent_id from mst_rak where rak_id = '+FormatSQLNumber(ID));
    if (point.RecordCount>0) then begin
      KlasMaping.RootID:= BufferToInteger(point.FieldValue(0));
      if KlasMaping.RootID <> 0 then
         KlasMaping.InsertRak;
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

  PointMaping.InsertRak;
  PointMaping.CodeId:= MstCode.CodeId;
  vPoint:= suiTreeView1.Selected;
  while Assigned(vPoint) do begin
    if vPoint.StateIndex = 0 then
      PointMaping.RootId:= MstCode.CodeId
    else PointMaping.RootId:= vPoint.StateIndex;

    PointMaping.InsertRak;
    vPoint:= vPoint.Parent;
  end;}
end;

function TfrmMstRak.isValid: boolean;
begin
  if CekInput(Result, txtKode.Text <> '', 'Kode belum diisi.', txtKode) then
  CekInput(Result, txtNama.Text <> '', 'Nama belum diisi.', txtNama)
end;

procedure TfrmMstRak.ReloadData(id: integer);
begin
  ResetData;
  MstCode.Reset;
  MstCode.CodeId:= id;
  if not MstCode.SelectRak then exit;
  txtNama.Text  := MstCode.CodeName;
  txtNama.Tag   := MstCode.CodeId;
  txtKode.Text  := MstCode.Kode;

  txtParent.Text:= MstCode.ParentName;
  txtParent.Tag := MstCode.ParentId;
  tbtSave.Enabled:= False;
end;

procedure TfrmMstRak.ReloadGrid;
var treeParent: TTreeNode;

  procedure load_child(Klas: TMstCode; Parent, Idx: integer);
  var child: arMstCode;
    i, x: integer;
  begin                                          //(Idx >= -1))
    if ((Parent <> 1) and (Parent <> 0) and (Idx >= 0)) then
      suiTreeView1.Items.AddChild(suiTreeView1.Items[Idx], Klas.CodeName)
    else suiTreeView1.Items.Add(treeParent,Klas.CodeName);
    suiTreeView1.Items.Item[suiTreeView1.Items.Count-1].StateIndex:= Klas.CodeID;
    suiTreeView1.Items.Item[suiTreeView1.Items.Count-1].SelectedIndex:= 1;
    x:= suiTreeView1.Items.Count-1;
    Klas.Reset;

    if TrMstCode_Arr.LoadFromRak(child, Parent) then begin
      for i:= 0 to Length(child)-1 do begin
        Klas.CodeID  := child[i].FCodeId;
        Klas.CodeName:= child[i].FCodeName;
        load_child(Klas, Klas.CodeID, x);
      end;
    end;
  end;

begin

  suiTreeView1.Items.Clear;
  treeParent:= TTreeNode.Create(suiTreeView1.Items);

  MstCode.Reset;
  MstCode.CodeID:= 1;
  MstCode.SelectRak;

  load_child(MstCode, MstCode.CodeID, 0);
  if Assigned(suiTreeView1.Items[0]) then begin
    suiTreeView1.Items[0].Focused;
    suiTreeView1.Items[0].Expand(False);
  end;
end;

procedure TfrmMstRak.ResetData;
begin
  txtKode.Text:= MstCode.GetNextCode;
  txtNama.Clear;
  txtParent.Clear;
  txtNama.Tag:= 0;
  txtParent.Tag:= 0;
end;

procedure TfrmMstRak.txtKodeChange(Sender: TObject);
var sudah_enabled: boolean;
begin
  sudah_enabled:= tbtSave.Enabled;
  if not sudah_enabled then
    tbtSave.Enabled:= (Sender as TAdvEdit).Modified;
end;

procedure TfrmMstRak.tbtNewClick(Sender: TObject);
begin
  ResetData;
  txtNama.SetFocus;
  if Assigned(suiTreeView1.Selected) then begin
    txtParent.Tag := suiTreeView1.Selected.StateIndex;
    txtParent.Text:= suiTreeView1.Selected.Text;
  end else Inform('Induk kode belum ditentukan.')

end;

procedure TfrmMstRak.tbtSaveClick(Sender: TObject);
begin
  if isValid then isSaved
end;

procedure TfrmMstRak.tbtDeleteClick(Sender: TObject);
begin
  if Confirmed('Hapus data?') then
    if TMstCode.DeleteRak(suiTreeView1.Selected.StateIndex) then
      ReloadGrid;
end;

procedure TfrmMstRak.tbtRefreshClick(Sender: TObject);
begin
  ReloadGrid
end;

procedure TfrmMstRak.suiTreeView1Click(Sender: TObject);
begin
  tbtDelete.Enabled:= False;
  tbtSave.Enabled:= False;
  if not Assigned(suiTreeView1.Selected) then exit;
  tbtDelete.Enabled:= suiTreeView1.Selected.StateIndex <> 0;
  ReloadData(suiTreeView1.Selected.StateIndex)
end;

procedure TfrmMstRak.suiTreeView1Collapsed(Sender: TObject;
  Node: TTreeNode);
begin
  if Assigned(suiTreeView1.Items[0]) then begin
    suiTreeView1.Items[0].Focused;
    suiTreeView1.Items[0].Expand(False);
  end;
end;

end.
