unit ListOfKlas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, SUITreeView,
  UMaster;

type
  TfrmListOfKlas = class(TForm)
    suiTreeView1: TsuiTreeView;
    Button1: TButton;
    Button2: TButton;
    procedure suiTreeView1DblClick(Sender: TObject);
    procedure suiTreeView1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    MstKlas: TMstCode;
    PURPOSE: integer;
    procedure reViewList;
  public
    function Execute(ID: integer): integer;
  end;

var
  frmListOfKlas: TfrmListOfKlas;

implementation

uses UConst, Subroutines;

{$R *.dfm}

{ TfrmListOfKlas }

function TfrmListOfKlas.Execute(ID: integer): integer;
begin
  MstKlas:= TMstCode.Create;
  PURPOSE:= ID;
  Result:= 0;
  reViewList;
  ShowModal;
  if ModalResult = mrOK then
    Result:= suiTreeView1.Selected.StateIndex;
  MstKlas.Free;
end;

procedure TfrmListOfKlas.reViewList;
var treeParent: TTreeNode; //tmp:integer;

  procedure load_child(Klas: TMstCode; Parent, Idx: integer);
  var child: arMstCode;
    i, x: integer;
  begin
    if ((Parent <> PURPOSE) and (Idx >= 0)) then
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
  MstKlas.Reset;
  Self.Caption:= 'Daftar Rak';
  MstKlas.CodeID:= PURPOSE;
  if not MstKlas.SelectRak then exit;

  load_child(MstKlas, MstKlas.CodeID, 0);
  if Assigned(suiTreeView1.Items[0]) then begin
    suiTreeView1.Items[0].Focused;
    suiTreeView1.Items[0].Expand(False);
  end;
end;

procedure TfrmListOfKlas.suiTreeView1DblClick(Sender: TObject);
begin
  ModalResult:= mrOk
end;

procedure TfrmListOfKlas.suiTreeView1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case key of
    VK_RETURN: ModalResult:= mrOk;
    VK_ESCAPE: ModalResult:= mrCancel;
  end;
end;

end.
