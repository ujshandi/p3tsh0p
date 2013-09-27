object frmInputBoxCashBack: TfrmInputBoxCashBack
  Left = 322
  Top = 322
  BorderStyle = bsSingle
  Caption = 'Kembali'
  ClientHeight = 88
  ClientWidth = 267
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnKeyDown = FormKeyDown
  DesignSize = (
    267
    88)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 64
    Width = 114
    Height = 16
    Caption = 'F9 : Reprint Struk'
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object btnOK: TButton
    Left = 185
    Top = 60
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 0
  end
  object txtCashBack: TAdvEdit
    Left = 5
    Top = 11
    Width = 254
    Height = 21
    TabStop = False
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
    LabelFont.Charset = ANSI_CHARSET
    LabelFont.Color = clWindowText
    LabelFont.Height = -19
    LabelFont.Name = 'Tahoma'
    LabelFont.Style = []
    Persistence.Enable = False
    Persistence.Location = plInifile
    Anchors = [akLeft, akTop, akRight]
    Color = clWindow
    Enabled = True
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Verdana'
    Font.Style = []
    HintShowLargeText = False
    ParentFont = False
    OleDropTarget = False
    OleDropSource = False
    ReadOnly = True
    Signed = False
    TabOrder = 1
    Transparent = False
    Visible = True
  end
end
