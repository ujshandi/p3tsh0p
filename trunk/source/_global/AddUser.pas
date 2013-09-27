unit AddUser;


interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, AdvEdit,StrUtils,Math,Menus,
  Subroutines, Grids,
  BaseGrid, AdvGrid, ImgList, ComCtrls, ToolWin, SUIToolBar;

type
  TfrmAddUser = class(TForm)
    txtLoginName1: TAdvEdit;
    btnSave: TButton;
    cancelBtn: TButton;
    cbAccessLevel: TComboBox;
    Label5: TLabel;
    txtLoginID: TAdvEdit;
    asgPermission: TAdvStringGrid;
    SmallImageList: TImageList;
    procedure cancelBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure asgPermissionCanEditCell(Sender: TObject; ARow,
      ACol: Integer; var CanEdit: Boolean);
    procedure asgPermissionGetAlignment(Sender: TObject; ARow,
      ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure SaveClick(Sender: TObject);
    procedure cbAccessLevelSelect(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
    accessList : TStringList;
    aUser:TSystemUser;
    EditMode: boolean;
    procedure clearForm;
    procedure loadUserPermission;
    procedure ViewUserPermission;
    procedure initForm;
    function isValid: boolean;
    function isSave: boolean;
  public
    function NewExecute(AUserID: string): boolean;

  end;

var
  frmAddUser: TfrmAddUser;

implementation

uses UConstTool, MySQLConnector;

{$R *.dfm}

procedure TfrmAddUser.clearForm;
var i,j,k:integer;
begin
  txtLoginID.Text := '';
  cbAccessLevel.ItemIndex := 0;
  cbAccessLevel.Clear;
  accessList.Clear;
  TSystemUser.AccessLevelList(accessList);
  for i := 0 to accessList.Count-1 do begin
    if GlobalSystemUser.AccessLevel <= StrToInt(accessList.Names[i]) then
      break;
  end;
  j := accessList.Count-i;
  for k:=1 to j do accessList.Delete(i);
  asgPermission.ColumnSize.StretchColumn:= 1;
  asgPermission.ClearNormalCells;
  asgPermission.RowCount := 1;

  NameValueListToValueList(accessList,cbAccessLevel.Items);
  cbAccessLevel.ItemIndex := -1;
  cbAccessLevel.Enabled := true;
end;

procedure TfrmAddUser.cancelBtnClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfrmAddUser.FormCreate(Sender: TObject);
begin
//  accessList := TStringList.Create;
//  aUser:=TSystemUser.Create;
end;

procedure TfrmAddUser.FormDestroy(Sender: TObject);
begin
//  accessList.Destroy;
//  aUser.Destroy;
end;

procedure TfrmAddUser.FormShow(Sender: TObject);
begin
  if txtLoginID.Enabled then txtLoginId.SetFocus else cbAccessLevel.SetFocus;
end;

procedure TfrmAddUser.asgPermissionCanEditCell(Sender: TObject; ARow,
  ACol: Integer; var CanEdit: Boolean);
begin
  CanEdit:= ACol in[2,3,4,5,6];
end;

procedure TfrmAddUser.asgPermissionGetAlignment(Sender: TObject; ARow,
  ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  if ARow = 0 then HAlign:= taCenter
  else if ACol in [2,3,4,5,6] then HAlign := taCenter;
end;

procedure TfrmAddUser.loadUserPermission;
var i:integer; SystemMenu:TSystemMenu_Arr;
begin
  asgPermission.ClearNormalCells;
  SystemMenu:= TSystemMenu_Arr.Create;
  SystemMenu.Clear;
  SystemMenu.FindInDB2;
  asgPermission.RowCount:= SystemMenu.Count+1;
  for i:= 0 to SystemMenu.Count-1 do begin
    asgPermission.AddCheckBox(2,i+1, False,false);
    asgPermission.AddCheckBox(3,i+1, False,false);
    asgPermission.AddCheckBox(4,i+1, False,false);
    asgPermission.AddCheckBox(5,i+1, False,false);
    asgPermission.AddCheckBox(6,i+1, False,false);
    asgPermission.Cells[1, i+1]:= SystemMenu[i].MenuName;
    asgPermission.Ints[7,  i+1]:= SystemMenu[i].MenuId;
  end;

  asgPermission.AutoNumberCol(0);
  asgPermission.AutoSizeColumns(True, 4);
  asgPermission.ColWidths[7]:= 0;
  SystemMenu.Free;
end;

function TfrmAddUser.isSave: boolean;
var state:boolean; i:integer;
  SystemAccsess:TSystemAccess;
  SystemUser:TSystemUser;
begin
  state:= False;
  SystemUser:= TSystemUser.Create;
  SystemAccsess:= TSystemAccess.Create(SystemUser);

  SystemUser.UserId:= txtLoginID.Text;
  SystemUser.UserName:= txtLoginID.Text;
  SystemUser.AccessLevel:= StrToInt(accessList.Names[cbAccessLevel.ItemIndex]);

  try
    BeginSQL;
    if EditMode then
      SystemUser.UpdateOnDBX
    else
      SystemUser.InsertOnDBX;

    SystemAccsess.SystemUser.UserId:= SystemUser.UserId;
    for i:= 0 to asgPermission.RowCount-1 do begin
      if asgPermission.Ints[7,i+1] > 0 then begin
        asgPermission.GetCheckBoxState(2,i+1,state);
        SystemAccsess.CanAddd:= IfThen(state, -1, 0);
        asgPermission.GetCheckBoxState(3,i+1,state);
        SystemAccsess.CanEdit:= IfThen(state, -1, 0);
        asgPermission.GetCheckBoxState(4,i+1,state);
        SystemAccsess.CanDelete:= IfThen(state, -1, 0);
        asgPermission.GetCheckBoxState(5,i+1,state);
        SystemAccsess.CanView:= IfThen(state, -1, 0);
        asgPermission.GetCheckBoxState(6,i+1,state);
        SystemAccsess.CanPrint:= IfThen(state, -1, 0);
        SystemAccsess.SystemUser.UserId:= SystemUser.UserId;
        SystemAccsess.SystemMenu.MenuId:= asgPermission.Ints[7, i+1];

        if TSystemAccess.IsExisInDB(SystemUser.UserId, SystemAccsess.SystemMenu.MenuId) then
          SystemAccsess.UpdateOnDB
        else
          SystemAccsess.InsertOnDB;
      end;
    end;

    EndSQL;
    Result:= True;
    if EditMode then
      Inform(MSG_SUCCESS_UPDATE)
    else Inform(MSG_SUCCESS_SAVING);
  except
    UndoSQL;
    Result:= False;
    if EditMode then
      Inform(MSG_UNSUCCESS_UPDATE)
    else Inform(MSG_UNSUCCESS_SAVING);

  end;
  SystemAccsess.Free;
  SystemUser.Free;
end;

procedure TfrmAddUser.ViewUserPermission;
var i: integer; SystemAccess:TSystemAccess_Arr;
begin
  asgPermission.ClearNormalCells;
  SystemAccess:= TSystemAccess_Arr.Create(aUser);
  SystemAccess.Clear;

  SystemAccess.FindOnDb(aUser.UserId);
  asgPermission.RowCount:= SystemAccess.Count+1;

  for i:= 0 to SystemAccess.Count-1 do begin
    asgPermission.AddCheckBox(2,i+1, (SystemAccess[i].CanAddd = -1),false);
    asgPermission.AddCheckBox(3,i+1, (SystemAccess[i].CanEdit = -1),false);
    asgPermission.AddCheckBox(4,i+1, (SystemAccess[i].CanDelete = -1),false);
    asgPermission.AddCheckBox(5,i+1, (SystemAccess[i].CanView = -1),false);
    asgPermission.AddCheckBox(6,i+1, (SystemAccess[i].CanPrint = -1),false);
    asgPermission.Cells[1, i+1]:= SystemAccess[i].SystemMenu.MenuName;
    asgPermission.Ints[7,  i+1]:= SystemAccess[i].SystemMenu.MenuId;
  end;
  asgPermission.AutoNumberCol(0);
  asgPermission.AutoSizeColumns(True, 4);
  asgPermission.ColWidths[7]:= 0;
  SystemAccess.Free;
end;

function TfrmAddUser.NewExecute(AUserID: string): boolean;
begin
  accessList:=TStringList.Create;
  aUser:=TSystemUser.Create;
  EditMode:= AUserID <> '';
  initForm;
  clearForm;
  aUser.Reset;
  txtLoginID.Enabled := not EditMode;
  if EditMode then begin
    aUser.SelectInDB(AUserID);
    txtLoginID.Text := aUser.UserId;
    cbAccessLevel.ItemIndex:= accessList.IndexOfName(IntToStr(aUser.AccessLevel));
  end;

  if EditMode then ViewUserPermission
  else loadUserPermission;
  Result := (ShowModal=mrOK);
end;

procedure TfrmAddUser.SaveClick(Sender: TObject);
begin
  if isValid and Confirmed(MSG_SAVE_CONFIRMATION) then
    if isSave then
      if EditMode then ModalResult:= mrOk
      else
        if Confirmed(MSG_ADD_DATA) then begin
          initForm;
          loadUserPermission;
        end
        else
          ModalResult:= mrOk;
end;

function TfrmAddUser.isValid: boolean;
begin
  Result:= False;
  if txtLoginID.Text = '' then
    Inform('Login Id belum diisi.')
  else
  if cbAccessLevel.ItemIndex = -1 then
    Inform('Access Level belum diisi.')
  else Result:= True;

end;

procedure TfrmAddUser.initForm;
begin

  ResetGrid(asgPermission, 2, 9,1,1,-1);
  txtLoginID.Text := '';

  TSystemUser.AccessLevelList(accessList);
  asgPermission.ClearNormalCells;
  asgPermission.RowCount := 1;

  NameValueListToValueList(accessList,cbAccessLevel.Items);
  cbAccessLevel.ItemIndex := -1;
  cbAccessLevel.Enabled := true;

  btnSave.Caption:= IfThen(EditMode, '&Update', '&Simpan');
end;

procedure TfrmAddUser.cbAccessLevelSelect(Sender: TObject);
var i: integer;
   vStatus : boolean;
begin
  if cbAccessLevel.ItemIndex=-1 then exit;
  vStatus := StrToInt(accessList.Names[cbAccessLevel.itemIndex])>LEVEL_OPERATOR;
     for i:= 1 to asgPermission.RowCount -1 do  begin
        asgPermission.SetCheckBoxState(2,i,vStatus);
        asgPermission.SetCheckBoxState(3,i,vStatus);
        asgPermission.SetCheckBoxState(4,i,vStatus);
        asgPermission.SetCheckBoxState(5,i,vStatus);
        asgPermission.SetCheckBoxState(6,i,vStatus);
     end;
end;

procedure TfrmAddUser.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if accessList <> nil then accessList.Free;
  accessList:= nil;

  if aUser <> nil then aUser.Free;
  aUser:= nil;

end;

procedure TfrmAddUser.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose:= True;
end;

end.
