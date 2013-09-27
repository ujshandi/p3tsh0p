unit MstCodeList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, treelist,
  UMaster, StdCtrls, WinXP, SUITreeView;

type
  TfrmMstCodeList = class(TForm)
    Button2: TButton;
    WinXP1: TWinXP;
    trlMstCode: TsuiTreeView;
    procedure trlMstCodeDblClick(Sender: TObject);
    procedure trlMstCodeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure suiTreeView1DblClick(Sender: TObject);
    procedure suiTreeView1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    MstCode: TMstCode;
    PURPOSE: Word;
    procedure ReloadGrid;
  public
    function Execute(vParent: integer): integer;
    function ExecuteRak(vParent: integer): integer;
  end;

var
  frmMstCodeList: TfrmMstCodeList;

implementation

uses MainMenu;

{$R *.dfm}

{ TfrmMstCodeList }

function TfrmMstCodeList.Execute(vParent: integer): integer;
begin
  PURPOSE:= 1; //MST_CODE
  Result := 0;
  MstCode:= TMstCode.Create;
  trlMstCode.Items.Clear;
  trlMstCode.Tag:= vParent;
  ReloadGrid;
  Run(Self);

  if (ModalResult = mrOk) and Assigned(trlMstCode.Selected) then
    Result:= trlMstCode.Selected.StateIndex;
  MstCode.Free
end;

procedure TfrmMstCodeList.ReloadGrid;
var treeParent: TTreeNode;

  procedure load_child(Klas: TMstCode; Parent, Idx: integer);
  var child: arMstCode;
    i, x: integer; data_exist: boolean;
  begin
    if ((Parent <> trlMstCode.Tag) and (Idx >= 0)) then
      trlMstCode.Items.AddChild(trlMstCode.Items[Idx], Klas.CodeName)
    else trlMstCode.Items.Add(treeParent,Klas.CodeName);
    trlMstCode.Items.Item[trlMstCode.Items.Count-1].StateIndex:= Klas.CodeID;
    trlMstCode.Items.Item[trlMstCode.Items.Count-1].SelectedIndex:= 1;
    x:= trlMstCode.Items.Count-1;
    Klas.Reset;
    data_exist:= TrMstCode_Arr.LoadFromDb(child, Parent);

    if data_exist then begin
      for i:= 0 to Length(child)-1 do begin
        Klas.CodeID  := child[i].FCodeId;
        Klas.CodeName:= child[i].FCodeName;
        load_child(Klas, Klas.CodeID, x);
      end;
    end;
  end;

begin
  trlMstCode.Items.Clear;
  treeParent:= TTreeNode.Create(trlMstCode.Items);
  MstCode.Reset;
  MstCode.CodeID:= trlMstCode.Tag;

  if PURPOSE = 2 then begin
    if not MstCode.SelectRak then exit;
  end
  else if PURPOSE = 1 then begin
    if not MstCode.SelectInDB then exit;
  end;

  load_child(MstCode, MstCode.CodeID, 0);
  if Assigned(trlMstCode.Items[0]) then begin
    trlMstCode.Items[0].Focused;
    trlMstCode.Items[0].Expand(False);
  end;
end;

procedure TfrmMstCodeList.trlMstCodeDblClick(Sender: TObject);
begin
  ModalResult:= mrOk
end;

procedure TfrmMstCodeList.trlMstCodeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = vk_return then ModalResult:= mrOk
end;
   
procedure TfrmMstCodeList.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose:= True
end;

procedure TfrmMstCodeList.suiTreeView1DblClick(Sender: TObject);
begin
  ModalResult:= mrOk
end;

procedure TfrmMstCodeList.suiTreeView1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = vk_return then ModalResult:= mrOk
end;

function TfrmMstCodeList.ExecuteRak(vParent: integer): integer;
begin
  PURPOSE:= 2; //MST_RAK
  Result := 0;
  MstCode:= TMstCode.Create;
  trlMstCode.Items.Clear;
  trlMstCode.Tag:= vParent;
  ReloadGrid;
  Run(Self);

  if (ModalResult = mrOk) and Assigned(trlMstCode.Selected) then
    Result:= trlMstCode.Selected.StateIndex;
  MstCode.Free
end;

end.
