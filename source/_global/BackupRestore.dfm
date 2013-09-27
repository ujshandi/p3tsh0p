object frmBackupRestore: TfrmBackupRestore
  Left = 288
  Top = 205
  BorderStyle = bsDialog
  Caption = 'frmBackupRestore'
  ClientHeight = 91
  ClientWidth = 362
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 80
    Height = 13
    Caption = 'Nama File (*.sql)'
  end
  object btnOpen: TButton
    Left = 199
    Top = 56
    Width = 75
    Height = 25
    Caption = '&Open'
    TabOrder = 0
    OnClick = btnOpenClick
  end
  object btnClose: TButton
    Left = 279
    Top = 56
    Width = 75
    Height = 25
    Caption = '&Close'
    TabOrder = 1
    OnClick = btnCloseClick
  end
  object txtFileName: TAdvEdit
    Left = 8
    Top = 24
    Width = 345
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
    ReturnIsTab = False
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
    Color = clWindow
    Enabled = True
    HintShowLargeText = False
    OleDropTarget = False
    OleDropSource = False
    Signed = False
    TabOrder = 2
    Text = 'txtFileName'
    Transparent = False
    Visible = True
  end
  object SaveDialog1: TSaveDialog
    Ctl3D = False
    DefaultExt = '*.sql'
    FileName = 'x_mart'
    Filter = '*.sql|*.sql'
    Title = 'Backup database ke ...'
    Left = 88
    Top = 56
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = '*.sql'
    FileName = 'x_mart'
    Filter = '*.sql|*.sql'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofCreatePrompt, ofEnableSizing]
    Title = 'Buka database dari ...'
    Left = 56
    Top = 56
  end
  object WinXP1: TWinXP
    Left = 8
    Top = 48
  end
end
