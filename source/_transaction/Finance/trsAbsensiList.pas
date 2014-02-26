unit trsAbsensiList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, BaseGrid, AdvGrid, StdCtrls, AdvEdit, ComCtrls, ToolWin,
  ExtCtrls, strUtils, Math,UPetshop,DateUtils,
      UMaster, WinXP, Menus, SUIImagePanel, UTransaction,
  frmDockForm, Buttons, SUIButton;

type
  TfrmTrsAbsensiList = class(TDockForm)
    ToolBar1: TToolBar;
    tbtNew: TToolButton;
    tbtDetail: TToolButton;
    ToolButton1: TToolButton;
    ToolButton4: TToolButton;
    tbtRefresh: TToolButton;
    tbtPrint: TToolButton;
    WinXP1: TWinXP;
    ToolButton5: TToolButton;
    suiPanel1: TsuiPanel;
    suiPanel2: TsuiPanel;
    suiPanel3: TsuiPanel;
    grid: TAdvStringGrid;
    asgvc: TAdvStringGrid;
    txtNama: TAdvEdit;
    PopupMenu1: TPopupMenu;
    Aktivasi1: TMenuItem;
    ToolButton3: TToolButton;
    Label2: TLabel;
    cmbJabatan: TComboBox;
    dtpAwal: TDateTimePicker;
    dtpAkhir: TDateTimePicker;
    Label1: TLabel;
    Label3: TLabel;
    cmbOpr: TComboBox;

    procedure gridGetAlignment(Sender: TObject; ARow, ACol: Integer;
      var HAlign: TAlignment; var VAlign: TVAlignment);
    procedure tbtNewClick(Sender: TObject);
    procedure tbtDetailClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ToolButton5Click(Sender: TObject);
    procedure tbtRefreshClick(Sender: TObject);
    procedure tbtPrintClick(Sender: TObject);
    procedure Aktivasi1Click(Sender: TObject);
    procedure gridRowChanging(Sender: TObject; OldRow, NewRow: Integer;
      var Allow: Boolean);
    procedure gridGetCellColor(Sender: TObject; ARow, ACol: Integer;
      AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
    procedure gridDblClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure ToolButton3Click(Sender: TObject);

  private
    lsStatusAbsen:TStringList;
    procedure InitGrid;
    procedure InitForm;
    procedure SetFilter;
    procedure InitFilter;
    procedure LoadData;
  public
    procedure Execute(id: integer=0);override;
  end;

var
  frmTrsAbsensiList: TfrmTrsAbsensiList;

implementation

uses UConstTool, MainMenu, Subroutines,
  MstCodeList, MstItem, UConst,
  mstItemListPrint, LookupData, uMysqlClient, MySQLConnector, MstService,
  MstKaryawan, TrsAbsensi, trsAbsensiListPrint;

const
  colNo      = 0;
  colNik     = 1;
  colName    = 2;
  colJabatan = 3;
  colTgl = 4;
  colStatus = 5;
  colMasuk = 6;
  colPulang = 7;
  colKeterangan = 8;
  colId   = 9;


{$R *.dfm}

{ TfrmMstItemList }

procedure TfrmTrsAbsensiList.Execute(id: integer);
begin
  inherited;

  ToolBar1.ParentColor:= false;
  ToolBar1.Color:= clWhite;
  lsStatusAbsen := TStringList.Create;
  TMstMaster_Arr.GetList(lsStatusAbsen,MST_TYPE_ABSEN,True);
  NameValueListToValueList(lsStatusAbsen,cmbJabatan.Items);
  InitForm;
//  SetFilter;
  LoadData;
  Run(Self);
end;

procedure TfrmTrsAbsensiList.InitFilter;
begin
  dtpAwal.Date := StartOfTheMonth(ServerNow);
  dtpAkhir.Date := ServerNow;
  GlobalPeriode.Reset;
  GlobalFilter.Reset;
  cmbJabatan.ItemIndex:=0;
  cmbOpr.ItemIndex := 4;
  txtNama.Clear;
end;

procedure TfrmTrsAbsensiList.InitForm;
begin
  InitGrid;
  InitFilter;
end;

procedure TfrmTrsAbsensiList.InitGrid;
begin
  grid.ExpandAll;
  grid.Clear;
  ResetGrid(grid, 2, colId+2, 1, 1,-1);
  grid.Cells[colNo,0] :='No';
  grid.Cells[colNik,0] :='NIK';
  grid.Cells[colName,0] :='Nama Karyawan';
  grid.Cells[colJabatan,0] :='Jabatan';
  grid.Cells[colTgl,0] :='Summary';
  grid.MergeCells(colTgl,0,5,1 );
  grid.AutoSizeColumns(True, 4);
  grid.ColWidths[colId]:= 0;

  grid.RowHeights[1]:= grid.DefaultRowHeight;
end;

procedure TfrmTrsAbsensiList.LoadData;
var i,j,row,tmp,idx: integer; item: TMysqlResult;
  absen : TMysqlResult;tmpStr: string;
   summary : TStringList;

   procedure resetListValue(var aList : TStringList);
   var z : integer;
   begin
      for z:=0 to aList.Count-1 do
         aList.Values[aList.Names[z]]:= '0';
   end;
begin
  try
    StartProgress;
    InitGrid;

    //InitFilter;
    SetFilter;
    item:= TMstKaryawan.LoadFromDB;
   // grid.RowCount:= IfThen(item.RecordCount > 0, item.RecordCount + 1, 2);
    summary := TStringList.Create;
    TMstMaster_Arr.GetList(summary,MST_TYPE_ABSEN,false);
    //ganti value list dengan 0;

    for i:= 1 to item.RecordCount do begin
      ProsesProgress(i,item.RecordCount);
      row := grid.RowCount-1;
      grid.Ints[colNo, row]:= i;//+txtLimit.Tag;

   //   grid.Ints[colId, i]:= BufferToInteger(item.FieldValue(0));
      grid.Cells[colNik,   row]:= BufferToString(item.FieldValue(1));
      grid.Cells[colName,   row]:= BufferToString(item.FieldValue(2));
      grid.Cells[colJabatan,row]:= BufferToString(item.FieldValue(9));

   //0a.absen_id,1a.karyawan_id,2a.tanggal,3a.status_absen,4a.keterangan,5k.nama ,6m.mst_name  , 7masuk,8pulang
      GlobalFilter.RelasiID := BufferToInteger(item.FieldValue(0));
      GlobalFilter.StatusID  := StrToInt(lsStatusAbsen.Names[cmbJabatan.itemIndex]);
      absen := TTrsAbsensi.LoadFromDB;
      resetListValue(summary);
      for j:= 0 to absen.RecordCount-1 do begin


            grid.AddRow;
            row := grid.RowCount-1;
        //    summary.Clear;
            tmp := 0;
            if j=0 then begin
               grid.Cells[colTgl,row] := 'Tanggal';
               grid.Cells[colStatus,row] := 'Status';
               grid.Cells[colKeterangan,row] := 'Keterangan';
               grid.Cells[colMasuk,row] := 'Jam Masuk';
               grid.Cells[colPulang,row] := 'Jam Pulang';
               grid.Cells[colId,row] := '';
               grid.Colors[colTgl,row]:= clSkyBlue;
               grid.Colors[colStatus,row]:= clSkyBlue;
               grid.Colors[colKeterangan,row]:= clSkyBlue;
               grid.Colors[colMasuk,row]:= clSkyBlue;
               grid.Colors[colPulang,row]:= clSkyBlue;

               grid.AddRow;
               row := grid.RowCount-1;
            end;

              grid.Cells[colTgl,row] := FormatDateTime(ShortDateFormat,BufferToDateTime(absen.FieldValue(2)));
              grid.Cells[colMasuk,row] := FormatDateTime(ShortTimeFormat,BufferToTime(absen.FieldValue(7)));
              grid.Cells[colPulang,row] := FormatDateTime(ShortTimeFormat,BufferToTime(absen.FieldValue(8)));
              grid.Cells[colStatus,row] :=BufferToString(absen.FieldValue(6));
              if (grid.Cells[colStatus,row]='Hadir') then begin
                if (BufferToTime(absen.FieldValue(7))>CompanyProfile.FJamMasuk) then begin
                    grid.Cells[colStatus,row] := grid.Cells[colStatus,row]+' [TELAT]';
                end;
              end;
              grid.Cells[colKeterangan,row] :=BufferToString(absen.FieldValue(4));
              grid.Cells[colId,row] := IntToStr(BufferToInt64(absen.FieldValue(0)));
              idx := summary.IndexOfName(BufferToString(absen.FieldValue(3)));
              tmp := StrToIntDef(summary.Values[summary.Names[idx]],0)+1;
              summary.Values[summary.Names[idx]] := IntToStr(tmp);
              {if (summary.IndexOfName(IntToStr(grid.Cells[colStatus,row]))=0)then begin
                summary.Add(grid.Cells[colStatus,row]+'=1');
              end
              else begin
                tmp := summary[]. summary.IndexOfName(grid.Cells[colStatus,row]);
              end;
               }

            grid.Colors[colTgl,row]:= clSilver;
            grid.Colors[colStatus,row]:= clSilver;
            grid.Colors[colKeterangan,row]:= clSilver;
            grid.Colors[colMasuk,row]:= clSilver;
            grid.Colors[colPulang,row]:= clSilver;
            absen.MoveNext;
         end;
        tmpStr := 'Total : ';
        for j:=0 to summary.Count-1 do begin
          tmpStr := tmpStr+ lsStatusAbsen.Values[lsStatusAbsen.Names[j+1]]+'='+summary.Values[summary.Names[j]]+';  ';
        end;

        tmp := IfThen(absen.RecordCount>0, absen.RecordCount+1,0);
        grid.MergeCells(colTgl,row-tmp,5,1);
        grid.Cells[colTgl,row-tmp] := tmpStr;
        if absen.RecordCount>0 then
           grid.AddNode(row-absen.RecordCount-1,absen.RecordCount+2);



      grid.AddRow;
      item.MoveNext;
    end;
    grid.RemoveRows(grid.RowCount-1,1);
    item.destroy;
    grid.AutoSizeColumns(true, 2);
    grid.ColWidths[colID]:= 0;
    grid.ColWidths[colNo]:= 50;
     grid.ColWidths[colKeterangan]:= 300;

  finally
    EndProgress;
  end;
end;

procedure TfrmTrsAbsensiList.SetFilter;
begin
 
  GlobalFilter.Name:= txtNama.Text;
   GlobalPeriode.setPeriode(cmbOpr.ItemIndex-1, dtpAwal.Date, dtpAkhir.Date);
end;

procedure TfrmTrsAbsensiList.gridGetAlignment(Sender: TObject; ARow,
  ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
//  if (ACol in[colName]) then HAlign:= taLeftJustify
  //else HAlign:= taRightJustify
end;

procedure TfrmTrsAbsensiList.tbtNewClick(Sender: TObject);
begin
  if not TSystemAccess.isCan(CAN_ADD,AktiveControl.Tag) then exit;
  frmTrsAbsensi.Execute(0);
end;

procedure TfrmTrsAbsensiList.tbtDetailClick(Sender: TObject);
begin
  if not TSystemAccess.isCan(CAN_EDIT,AktiveControl.Tag) then exit;
  if (grid.Cells[colId, grid.Row]='') then begin
      Alert('Data Absen belum dipilih');
      exit;
  end;
  frmTrsAbsensi.Execute(StrToInt64Def(grid.Cells[colId, grid.Row],0));
end;

procedure TfrmTrsAbsensiList.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  //if MstItem <> nil then MstItem.Free;
  //MstItem:= nil;
end;

procedure TfrmTrsAbsensiList.ToolButton5Click(Sender: TObject);
begin
  InitFilter
end;

procedure TfrmTrsAbsensiList.tbtRefreshClick(Sender: TObject);
begin
  LoadData;
end;

procedure TfrmTrsAbsensiList.tbtPrintClick(Sender: TObject);
begin
  if not TSystemAccess.isCan(CAN_PRINT,AktiveControl.Tag) then exit;
  if MustRegister then exit;
  try
    Application.CreateForm(TqrpAbsensiList, qrpAbsensiList);
    qrpAbsensiList.Executes(grid);
  finally
    qrpAbsensiList.Destroy;
  end;
end;

{procedure TfrmMstItemList.tes;
var i,j,k, row: integer; listMaster, listChild: TStringList;
  item: _Recordset; header: string;
  plan_b: boolean;
begin

  listMaster:= TStringList.Create();
  listChild:= TStringList.Create();
  GlobalStringList.Clear;

  SQLToNameValueList(listMaster,
  'select code_id, code_name from mst_code '+
  'where parent_id = '+FormatSQLNumber(txtSpec.Tag) + ' order by urut');

  plan_b:= listMaster.Count = 0;
  if plan_b then
    SQLToNameValueList(listMaster,
    'select code_id, code_name from mst_code '+
    'where code_id = '+FormatSQLNumber(txtSpec.Tag));

  for i:= 0 to listMaster.Count-1 do begin

    if plan_b then
      SQLToNameValueList(listChild,
      'select m.code_id, m.code_name from mst_code m, point_maping p '+
      'where m.code_id = p.code_id and p.root_id = '+FormatSQLNumber(StrToInt(listMaster.Names[i]))+
      ' order by m.urut ')

    else
      SQLToNameValueList(listChild,
      'select m.code_id, m.code_name from mst_code m, point_maping p '+
      'where m.code_id = p.code_id and p.root_id = '+FormatSQLNumber(StrToInt(listMaster.Names[i]))+
      ' and m.code_ID <> '+FormatSQLNumber(StrToInt(listMaster.Names[i]))+
      ' order by m.urut ');


    header:= getStringFromSQL(
    'select c.code_name from point_maping p, mst_code c '+
    'where c.code_id = p.root_id and p.code_id = '+FormatSQLNumber(StrToInt(listMaster.Names[i]))+
    ' and level = 2 ');

    for j:= 0 to listChild.Count-1 do begin

      row:= asgList.RowCount-1;

      asgList.Cells[colCode, row]:=
          '['+ header +' - '+ listChild.Values[listChild.Names[j]] +']';

      item:= MyConnection.OpenSQL(
      'select i.item_code, i.item_name, c.sales_price '+
      'from mst_item i, mst_item_conversion c, point_maping p '+
      'where c.item_id = i.item_id and c.conv_type = 0 '+
      'and i.specification = p.code_id and p.root_id = '+FormatSQLNumber(StrToInt(listChild.Names[j]))+
      ' order by convert(i.item_code, SIGNED)');

      if item.RecordCount > 0 then
      for k:= 0 to item.RecordCount-1 do begin
        asgList.AddRow;
        row:= asgList.RowCount-1;
        asgList.Cells[colCode, row]:= BufferToString(item.Fields[0].Value);
        asgList.Cells[colName, row]:= BufferToString(item.Fields[1].Value);
        item.MoveNext;
      end;
      item.Close;
      asgList.AddRow;
     end;

     asgList.AutoNumberCol(colNo);
     asgList.AutoSizeColumns(TRUE, 5);
  end;
  listMaster.Free;
  listChild.Free;
end;
}
procedure TfrmTrsAbsensiList.Aktivasi1Click(Sender: TObject);
begin
  if not TSystemAccess.isCan(CAN_DELETE,AktiveControl.Tag) then exit;
  TMstKaryawan.activasi(grid.Ints[colId, grid.Row])
end;

procedure TfrmTrsAbsensiList.gridRowChanging(Sender: TObject; OldRow,
  NewRow: Integer; var Allow: Boolean);
begin
  if OldRow <= grid.RowCount-1 then
    grid.RowHeights[OldRow]:= grid.DefaultRowHeight;
  grid.AutoSizeRow(NewRow);
  if grid.RowHeights[NewRow] < grid.DefaultRowHeight then
    grid.RowHeights[NewRow]:= grid.DefaultRowHeight;
end;

procedure TfrmTrsAbsensiList.gridGetCellColor(Sender: TObject; ARow,
  ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin
//  if (ACol < colHBeli) and (ARow > 0) then begin
//    ABrush.Color:= clGrid;
//    AFont.Color := clLabel;
//  end;
end;

procedure TfrmTrsAbsensiList.gridDblClickCell(Sender: TObject; ARow,
  ACol: Integer);
begin
  tbtDetail.Click
end;

procedure TfrmTrsAbsensiList.ToolButton3Click(Sender: TObject);
begin
  if not TSystemAccess.isCan(CAN_DELETE,AktiveControl.Tag) then exit;
  if Confirmed('Hapus Data Absen ?') then
  if TTrsAbsensi.deleteOnDb(StrToInt64Def(grid.Cells[colId, grid.Row],0)) then begin
     grid.ClearRows(grid.Row,1);
     if grid.RowCount > 2 then grid.RemoveRows(grid.Row,1);
  end;

end;

end.
