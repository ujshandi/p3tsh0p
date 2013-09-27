object frmAdmTrxPending: TfrmAdmTrxPending
  Left = 191
  Top = 179
  BorderStyle = bsDialog
  Caption = 'frmAdmTrxPending'
  ClientHeight = 260
  ClientWidth = 464
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 280
    Top = 8
    Width = 159
    Height = 91
    Caption = 
      'Proses sinkronisasi data'#13#10'1. Pilih nama file pada'#13#10'   daftar fil' +
      'e di kiri bawah form'#13#10'2. Klik tombol Execute SQL'#13#10'3. Hapus file ' +
      'yang sudah'#13#10'   dieksekusi   dg mengklik tombol Hapus File'
    WordWrap = True
  end
  object DriveComboBox1: TDriveComboBox
    Left = 8
    Top = 8
    Width = 265
    Height = 19
    DirList = DirectoryListBox1
    TabOrder = 0
  end
  object DirectoryListBox1: TDirectoryListBox
    Left = 8
    Top = 30
    Width = 265
    Height = 69
    FileList = FileListBox1
    ItemHeight = 16
    TabOrder = 1
  end
  object FileListBox1: TFileListBox
    Left = 8
    Top = 102
    Width = 265
    Height = 150
    ItemHeight = 13
    Mask = '*.sql'
    TabOrder = 2
    OnClick = FileListBox1Click
  end
  object Button1: TButton
    Left = 280
    Top = 229
    Width = 75
    Height = 25
    Caption = 'Execute SQL'
    TabOrder = 3
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 360
    Top = 229
    Width = 75
    Height = 25
    Caption = 'Delete File'
    TabOrder = 4
    OnClick = Button2Click
  end
  object WinXP1: TWinXP
    Left = 288
    Top = 8
  end
end
