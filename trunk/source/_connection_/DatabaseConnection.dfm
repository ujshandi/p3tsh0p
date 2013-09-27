object frmDatabaseConnection: TfrmDatabaseConnection
  Left = 250
  Top = 235
  BorderStyle = bsDialog
  Caption = 'Database Connection'
  ClientHeight = 150
  ClientWidth = 318
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label3: TLabel
    Left = 108
    Top = 14
    Width = 62
    Height = 13
    Caption = 'Nama Server'
  end
  object TLabel
    Left = 108
    Top = 39
    Width = 46
    Height = 13
    Caption = 'Database'
  end
  object TLabel
    Left = 108
    Top = 70
    Width = 22
    Height = 13
    Caption = 'User'
  end
  object TLabel
    Left = 108
    Top = 92
    Width = 46
    Height = 13
    Caption = 'Password'
  end
  object Image1: TImage
    Left = 1
    Top = 4
    Width = 104
    Height = 109
    Stretch = True
    Transparent = True
  end
  object txtDbPwd: TAdvEdit
    Left = 182
    Top = 92
    Width = 129
    Height = 21
    AutoFocus = False
    EditAlign = eaLeft
    EditType = etPassword
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
    LabelPosition = lpLeftTop
    LabelMargin = 4
    LabelTransparent = False
    LabelAlwaysEnabled = False
    LabelFont.Charset = DEFAULT_CHARSET
    LabelFont.Color = clWindowText
    LabelFont.Height = -11
    LabelFont.Name = 'MS Sans Serif'
    LabelFont.Style = []
    Persistence.Enable = False
    Persistence.Location = plInifile
    CanUndo = False
    Color = clWindow
    Enabled = True
    HintShowLargeText = False
    PasswordChar = '*'
    OleDropTarget = False
    OleDropSource = False
    Signed = False
    TabOrder = 2
    Transparent = False
    Visible = True
  end
  object txtDbUser: TAdvEdit
    Left = 182
    Top = 68
    Width = 129
    Height = 21
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
    LabelPosition = lpLeftTop
    LabelMargin = 4
    LabelTransparent = False
    LabelAlwaysEnabled = False
    LabelFont.Charset = DEFAULT_CHARSET
    LabelFont.Color = clWindowText
    LabelFont.Height = -11
    LabelFont.Name = 'MS Sans Serif'
    LabelFont.Style = []
    Persistence.Enable = False
    Persistence.Location = plInifile
    CanUndo = False
    Color = clWindow
    Enabled = True
    HintShowLargeText = False
    OleDropTarget = False
    OleDropSource = False
    Signed = False
    TabOrder = 1
    Text = 'root'
    Transparent = False
    Visible = True
  end
  object txtDbName: TAdvEdit
    Left = 182
    Top = 36
    Width = 129
    Height = 21
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
    LabelPosition = lpLeftTop
    LabelMargin = 4
    LabelTransparent = False
    LabelAlwaysEnabled = False
    LabelFont.Charset = DEFAULT_CHARSET
    LabelFont.Color = clWindowText
    LabelFont.Height = -11
    LabelFont.Name = 'MS Sans Serif'
    LabelFont.Style = []
    Persistence.Enable = False
    Persistence.Location = plInifile
    CanUndo = False
    Color = clWindow
    Enabled = True
    HintShowLargeText = False
    OleDropTarget = False
    OleDropSource = False
    Signed = False
    TabOrder = 0
    Transparent = False
    Visible = True
  end
  object Button1: TButton
    Left = 157
    Top = 120
    Width = 75
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 3
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 236
    Top = 120
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 4
    OnClick = Button2Click
  end
  object btnCopyDemo: TButton
    Left = 5
    Top = 120
    Width = 97
    Height = 25
    Caption = 'Copy database'
    TabOrder = 5
    Visible = False
    OnClick = btnCopyDemoClick
  end
  object cmbServer: TComboBox
    Left = 182
    Top = 8
    Width = 129
    Height = 21
    ItemHeight = 13
    TabOrder = 6
    Items.Strings = (
      'localHost')
  end
  object WinXP1: TWinXP
    Left = 136
    Top = 64
  end
end
