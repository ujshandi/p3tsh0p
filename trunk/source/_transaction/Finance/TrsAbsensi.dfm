object frmTrsAbsensi: TfrmTrsAbsensi
  Left = 277
  Top = 179
  ActiveControl = txtName
  BorderStyle = bsDialog
  Caption = 'Input Supplier'
  ClientHeight = 243
  ClientWidth = 466
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  PopupMenu = frmMainMenu.MenuShortCut
  Position = poDesktopCenter
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnPaint = FormPaint
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel
    Left = 37
    Top = 84
    Width = 43
    Height = 14
    Alignment = taRightJustify
    Caption = 'Status :'
  end
  object Label2: TLabel
    Left = 30
    Top = 32
    Width = 51
    Height = 14
    Caption = 'Tanggal :'
  end
  object Label3: TLabel
    Left = 9
    Top = 108
    Width = 71
    Height = 14
    Alignment = taRightJustify
    Caption = 'Keterangan :'
  end
  object txtName: TAdvEdit
    Left = 85
    Top = 55
    Width = 280
    Height = 22
    AutoFocus = False
    EditAlign = eaLeft
    EditType = etString
    ErrorColor = clRed
    ErrorFontColor = clWhite
    ExcelStyleDecimalSeparator = False
    Flat = False
    FlatLineColor = clBlack
    FlatParentColor = True
    FocusAlign = eaDefault
    FocusBorder = False
    FocusColor = clWindow
    FocusFontColor = clWindowText
    FocusLabel = False
    FocusWidthInc = 0
    ModifiedColor = clHighlight
    DisabledColor = clSilver
    URLColor = clBlue
    ReturnIsTab = True
    LengthLimit = 0
    TabOnFullLength = False
    Precision = 0
    LabelCaption = 'Nama :'
    LabelPosition = lpLeftTop
    LabelMargin = 4
    LabelTransparent = False
    LabelAlwaysEnabled = False
    LabelFont.Charset = ANSI_CHARSET
    LabelFont.Color = clWindowText
    LabelFont.Height = -11
    LabelFont.Name = 'Tahoma'
    LabelFont.Style = []
    Persistence.Enable = False
    Persistence.Location = plInifile
    Color = clWindow
    Enabled = True
    HintShowLargeText = False
    OleDropTarget = False
    OleDropSource = False
    ReadOnly = True
    Signed = False
    TabOrder = 0
    Text = 'txtName'
    Transparent = False
    Visible = True
    OnChange = txtCodeChange
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 203
    Width = 466
    Height = 40
    Align = alBottom
    ButtonHeight = 37
    ButtonWidth = 49
    Caption = 'ToolBar1'
    Customizable = True
    Flat = True
    Images = frmMainMenu.SmallImageList
    ParentShowHint = False
    PopupMenu = frmMainMenu.MenuShortCut
    ShowCaptions = True
    ShowHint = True
    TabOrder = 1
    Transparent = True
    object tbtNew: TToolButton
      Tag = -10
      Left = 0
      Top = 0
      Hint = 'New Data [Ctrl+N]'
      Caption = '&New'
      ImageIndex = 0
      OnClick = tbtNewClick
    end
    object tbtSave: TToolButton
      Tag = -11
      Left = 49
      Top = 0
      Hint = 'Save Data [Ctrl+S]'
      Caption = ' &Save '
      ImageIndex = 1
      OnClick = tbtSaveClick
    end
  end
  object cmbStatusAbsen: TComboBox
    Left = 85
    Top = 81
    Width = 217
    Height = 22
    Style = csDropDownList
    ItemHeight = 14
    TabOrder = 2
  end
  object dtpTglAbsen: TDateTimePicker
    Left = 85
    Top = 28
    Width = 186
    Height = 22
    CalAlignment = dtaLeft
    Date = 41551.6693185764
    Time = 41551.6693185764
    DateFormat = dfShort
    DateMode = dmComboBox
    Kind = dtkDate
    ParseInput = False
    TabOrder = 3
  end
  object mmKeterangan: TMemo
    Left = 86
    Top = 110
    Width = 283
    Height = 75
    Lines.Strings = (
      'mmKeterangan')
    TabOrder = 4
  end
  object Button1: TButton
    Left = 332
    Top = 57
    Width = 31
    Height = 18
    Caption = '...'
    TabOrder = 5
    OnClick = Button1Click
  end
  object WinXP1: TWinXP
    Left = 360
  end
end
