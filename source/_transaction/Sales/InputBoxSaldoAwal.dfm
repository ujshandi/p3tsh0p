object frmInputBoxSaldoAwal: TfrmInputBoxSaldoAwal
  Left = 300
  Top = 265
  BorderStyle = bsDialog
  Caption = 'Input Saldo Awal'
  ClientHeight = 195
  ClientWidth = 315
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 16
  object Label1: TLabel
    Left = 40
    Top = 24
    Width = 55
    Height = 16
    Caption = 'Tanggal :'
  end
  object Label2: TLabel
    Left = 58
    Top = 56
    Width = 37
    Height = 16
    Caption = 'Kasir :'
  end
  object Label3: TLabel
    Left = 61
    Top = 88
    Width = 34
    Height = 16
    Caption = 'Ship :'
  end
  object lblDate: TLabel
    Left = 99
    Top = 24
    Width = 55
    Height = 16
    Caption = 'Tanggal :'
  end
  object lblKasir: TLabel
    Left = 99
    Top = 56
    Width = 37
    Height = 16
    Caption = 'Kasir :'
  end
  object lblShip: TLabel
    Left = 99
    Top = 88
    Width = 34
    Height = 16
    Caption = 'Ship :'
  end
  object txtSaldo: TAdvEdit
    Left = 99
    Top = 112
    Width = 201
    Height = 24
    OnValueValidate = txtSaldoValueValidate
    AutoFocus = False
    EditAlign = eaRight
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
    LabelCaption = 'Saldo Awal :'
    LabelPosition = lpLeftTop
    LabelMargin = 4
    LabelTransparent = False
    LabelAlwaysEnabled = False
    LabelFont.Charset = ANSI_CHARSET
    LabelFont.Color = clWindowText
    LabelFont.Height = -13
    LabelFont.Name = 'Tahoma'
    LabelFont.Style = []
    Persistence.Enable = False
    Persistence.Location = plInifile
    Color = clWindow
    Enabled = True
    HintShowLargeText = False
    OleDropTarget = False
    OleDropSource = False
    Signed = False
    TabOrder = 0
    Text = 'txtSaldo'
    Transparent = False
    Visible = True
    OnKeyDown = txtSaldoKeyDown
    OnKeyPress = txtSaldoKeyPress
  end
  object Button1: TButton
    Left = 148
    Top = 160
    Width = 75
    Height = 25
    Caption = '&Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object Button2: TButton
    Left = 228
    Top = 160
    Width = 75
    Height = 25
    Caption = '&OK'
    TabOrder = 2
    OnClick = Button2Click
  end
end
