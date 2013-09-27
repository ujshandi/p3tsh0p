unit KelolaUser;

interface

uses
  Subroutines, AddUser,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,Math,
  Dialogs, Grids, BaseGrid, AdvGrid, StdCtrls, ExtCtrls, ComCtrls, ToolWin,
  frmDockForm;

type
  TfrmKelolaUser = class(TDockForm)
    asgSystUsers: TAdvStringGrid;
    ToolBar1: TToolBar;
    tbtNew: TToolButton;
    tbtEdit: TToolButton;
    tbtDelete: TToolButton;
    procedure asgSystUsersButtonClick(Sender: TObject; ACol,
      ARow: Integer);
    procedure asgSystUsersGetAlignment(Sender: TObject; ARow,
      ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure btnRemoveClick(Sender: TObject);
    procedure asgSystUsersDblClick(Sender: TObject);
    procedure asgSystUsersCheckBoxClick(Sender: TObject; ACol,
      ARow: Integer; State: Boolean);
    procedure asgSystUsersCanEditCell(Sender: TObject; ARow, ACol: Integer;
      var CanEdit: Boolean);
    procedure tbtNewClick(Sender: TObject);
    procedure tbtEditClick(Sender: TObject);
    procedure tbtDeleteClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    systUsers : TSystemUser_Arr;
    accessList : TStringList;
    procedure loadData;
  public
    procedure Execute(id: integer); override;
  end;

var
  frmKelolaUser: TfrmKelolaUser;

implementation

uses ChangePassword, UConst, MainMenu, UConstTool;

{$R *.dfm}

{ TkelolaSystUserFrm }

procedure TfrmKelolaUser.Execute(id: integer);
begin
  inherited;
  accessList := TStringList.Create;
  systUsers := TSystemUser_Arr.Create;

  loadData;
  Run(Self);
end;

procedure TfrmKelolaUser.loadData;
var i:integer;
begin
  TSystemUser.AccessLevelList(accessList);
  systUsers.Clear;
  systUsers.FindOnDB('','',GlobalSystemUser.AccessLevel,False);
  asgSystUsers.RowCount := systUsers.Count + 1;
  asgSystUsers.Cells[1,0] := 'Login ID';
  asgSystUsers.Cells[2,0] := 'Login Name';
  asgSystUsers.Cells[3,0] := 'Access Level';
  asgSystUsers.Cells[4,0] := 'Status';
  asgSystUsers.Cells[5,0] := 'Action';
  asgSystUsers.Cells[6,0] := 'Reset Pwd';

  for i := 0 to systUsers.Count-1 do begin
    asgSystUsers.Cells[1,i+1] := systUsers[i].UserId;
    asgSystUsers.Cells[2,i+1] := systUsers[i].UserName;
    asgSystUsers.Cells[3,i+1] := accessList.Values[IntToStr(systUsers[i].AccessLevel)];
    asgSystUsers.AddCheckBox(4,i+1, systUsers[i].DisableDate = 0, false);
    asgSystUsers.AddButton(5,i+1,60,18,'Set Password',haCenter,vaCenter);
    asgSystUsers.AddButton(6,i+1,60,18,'Reset Password',haCenter,vaCenter);
  end;
  asgSystUsers.AutoNumberCol(0);

end;

procedure TfrmKelolaUser.asgSystUsersButtonClick(Sender: TObject; ACol, ARow: Integer);
begin
  if ACol = 5 then
      frmChangePassword.Execute(asgSystUsers.Cells[1,asgSystUsers.Row])
  else if ACol = 6 then begin
   if (MessageDlg('Password di-reset kosong',mtConfirmation,[mbYes,mbNo],0)) = mrYes then begin
///    systUsers[ARow-1].LoginPwd := '';
    systUsers[ARow-1].Passwd := '';
    systUsers[ARow-1].UpdatePasswordOnDB;
    ShowMessage('Sukses');
  end;
  end;
end;

procedure TfrmKelolaUser.asgSystUsersGetAlignment(Sender: TObject;
  ARow, ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  if ACol in [0,4,5] then
    HAlign := taCenter;
end;

procedure TfrmKelolaUser.btnRemoveClick(Sender: TObject);
var aUser :TSystemUser; i:integer; state:boolean;
begin
  aUser := TSystemUser.Create;
  aUser.UserId := asgSystUsers.Cells[1, asgSystUsers.row];
  aUser.DeleteOnDB;
  aUser.Destroy;
  Alert('Sukses');
  if asgSystUsers.Row <> asgSystUsers.RowCount - 1 then begin
    for i := asgSystUsers.Row +1 to asgSystUsers.RowCount -1 do begin
      asgSystUsers.Cells[1,i-1] := asgSystUsers.Cells[1,i];
      asgSystUsers.Cells[2,i-1] := asgSystUsers.Cells[2,i];
      asgSystUsers.Cells[3,i-1] := asgSystUsers.Cells[3,i];
      asgSystUsers.GetCheckBoxState(4,i,state);
      asgSystUsers.SetCheckBoxState(4,i-i,state);
    end;
  end;
  asgSystUsers.RowCount := asgSystUsers.RowCount - 1;
end;

procedure TfrmKelolaUser.asgSystUsersDblClick(Sender: TObject);
begin
  tbtEditClick(nil);
end;

procedure TfrmKelolaUser.asgSystUsersCheckBoxClick(Sender: TObject;
  ACol, ARow: Integer; State: Boolean);
begin

  systUsers[ARow-1].is_disabled := state;
  TSystemUser.Activation(asgSystUsers.Cells[1, asgSystUsers.Row], IfThen(State,-1, 0));
  if state = false then begin
    Alert('User ' + asgSystUsers.Cells[1,Arow] + ' sudah di-NonAktifkan');
  end
  else begin
    Alert('User ' + asgSystUsers.Cells[1,Arow] + ' sudah di-Aktifkan');
  end;

end;

procedure TfrmKelolaUser.asgSystUsersCanEditCell(Sender: TObject; ARow,
  ACol: Integer; var CanEdit: Boolean);
begin
  CanEdit := ACol in [4];
end;

procedure TfrmKelolaUser.tbtNewClick(Sender: TObject);
begin
  {if not Can_Access(Self) then begin
    Alert(MSG_UNAUTHORISED_ACCESS);
    exit;
  end;}
  if not TSystemAccess.isCan(CAN_ADD,AktiveControl.Tag) then exit;
  frmAddUser.NewExecute('');
  loadData;
end;

procedure TfrmKelolaUser.tbtEditClick(Sender: TObject);
begin
 if not TSystemAccess.isCan(CAN_EDIT,AktiveControl.Tag) then exit;
     if (asgSystUsers.Row>0) and (asgSystUsers.Row<asgSystUsers.RowCount) then begin
    frmAddUser.NewExecute(asgSystUsers.Cells[1,asgSystUsers.Row]);
    LoadData;
  end;
end;

procedure TfrmKelolaUser.tbtDeleteClick(Sender: TObject);
   var aUser :TSystemUser; i:integer; state:boolean;
begin
 if not TSystemAccess.isCan(CAN_DELETE,AktiveControl.Tag) then exit;
 if (asgSystUsers.Row=0) then exit;
  aUser := TSystemUser.Create;
  aUser.UserId := asgSystUsers.Cells[1, asgSystUsers.row];
  aUser.DeleteOnDB;
  aUser.Destroy;
  Alert('Sukses');
  if asgSystUsers.Row <> asgSystUsers.RowCount - 1 then begin
    for i := asgSystUsers.Row +1 to asgSystUsers.RowCount -1 do begin
      asgSystUsers.Cells[1,i-1] := asgSystUsers.Cells[1,i];
      asgSystUsers.Cells[2,i-1] := asgSystUsers.Cells[2,i];
      asgSystUsers.Cells[3,i-1] := asgSystUsers.Cells[3,i];
      asgSystUsers.GetCheckBoxState(4,i,state);
      asgSystUsers.SetCheckBoxState(4,i-i,state);
    end;
  end;
  asgSystUsers.RowCount := asgSystUsers.RowCount - 1;
end;

procedure TfrmKelolaUser.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  if systUsers <> nil then systUsers.Free;
  systUsers:= nil;

  if accessList <> nil then accessList.Free;
  accessList:= nil;
end;

end.
