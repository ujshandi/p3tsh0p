object frmInputBoxTotal: TfrmInputBoxTotal
  Left = 204
  Top = 205
  ActiveControl = txtCash
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Total'
  ClientHeight = 355
  ClientWidth = 471
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  DesignSize = (
    471
    355)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 204
    Top = 309
    Width = 97
    Height = 14
    Caption = 'F9 : Reprint Struk'
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsItalic]
    ParentFont = False
    Visible = False
  end
  object Label2: TLabel
    Left = 7
    Top = 92
    Width = 98
    Height = 21
    Caption = 'Cara Bayar:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Edit1: TEdit
    Left = 164
    Top = 201
    Width = 57
    Height = 21
    ReadOnly = True
    TabOrder = 4
    Text = 'Edit1'
    OnKeyDown = Edit1KeyDown
  end
  object txtGrandTotal: TAdvEdit
    Left = 108
    Top = 23
    Width = 350
    Height = 21
    TabStop = False
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
    LabelCaption = 'Total:'
    LabelPosition = lpLeftTop
    LabelMargin = 1
    LabelTransparent = False
    LabelAlwaysEnabled = False
    LabelFont.Charset = ANSI_CHARSET
    LabelFont.Color = clWindowText
    LabelFont.Height = -21
    LabelFont.Name = 'Tahoma'
    LabelFont.Style = [fsBold]
    Persistence.Enable = False
    Persistence.Location = plInifile
    Anchors = [akLeft, akTop, akRight]
    Color = clWindow
    Enabled = True
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -48
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    HintShowLargeText = False
    ParentFont = False
    OleDropTarget = False
    OleDropSource = False
    ReadOnly = True
    Signed = False
    TabOrder = 7
    Text = '1.000.000.00'
    Transparent = False
    Visible = True
  end
  object txtCash: TAdvEdit
    Left = 108
    Top = 193
    Width = 350
    Height = 21
    OnValueValidate = txtCashValueValidate
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
    LabelCaption = 'Bayar:'
    LabelPosition = lpLeftTop
    LabelMargin = 1
    LabelTransparent = False
    LabelAlwaysEnabled = True
    LabelFont.Charset = ANSI_CHARSET
    LabelFont.Color = clWindowText
    LabelFont.Height = -21
    LabelFont.Name = 'Tahoma'
    LabelFont.Style = [fsBold]
    Persistence.Enable = False
    Persistence.Location = plInifile
    Anchors = [akLeft, akTop, akRight]
    AutoSelect = False
    Color = clWindow
    Enabled = True
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -48
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    HintShowLargeText = False
    ParentFont = False
    OleDropTarget = False
    OleDropSource = False
    Signed = False
    TabOrder = 3
    Text = '1.000.000.00'
    Transparent = False
    Visible = True
    OnEnter = txtCashEnter
    OnKeyDown = txtCashKeyDown
    OnKeyPress = txtCashKeyPress
  end
  object txtCashBack: TAdvEdit
    Left = 108
    Top = 245
    Width = 350
    Height = 21
    TabStop = False
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
    LabelCaption = 'Kembali:'
    LabelPosition = lpLeftTop
    LabelMargin = 1
    LabelTransparent = False
    LabelAlwaysEnabled = False
    LabelFont.Charset = ANSI_CHARSET
    LabelFont.Color = clWindowText
    LabelFont.Height = -21
    LabelFont.Name = 'Tahoma'
    LabelFont.Style = [fsBold]
    Persistence.Enable = False
    Persistence.Location = plInifile
    Anchors = [akLeft, akTop, akRight]
    Color = clWindow
    Enabled = True
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -48
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    HintShowLargeText = False
    ParentFont = False
    OleDropTarget = False
    OleDropSource = False
    ReadOnly = True
    Signed = False
    TabOrder = 8
    Text = '1.000.000.00'
    Transparent = False
    Visible = True
  end
  object btnOK: TButton
    Left = 306
    Top = 320
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 5
  end
  object Button2: TButton
    Left = 386
    Top = 320
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 6
  end
  object cmbJenisBayar: TComboBox
    Left = 108
    Top = 88
    Width = 350
    Height = 33
    Style = csDropDownList
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ItemHeight = 25
    ParentFont = False
    TabOrder = 0
    OnChange = cmbJenisBayarChange
    OnKeyDown = cmbJenisBayarKeyDown
    Items.Strings = (
      'TUNAI'
      'NON TUNAI')
  end
  object txtCard: TAdvEdit
    Left = 108
    Top = 124
    Width = 350
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
    LabelCaption = 'ID Card :'
    LabelPosition = lpLeftTop
    LabelMargin = 4
    LabelTransparent = False
    LabelAlwaysEnabled = True
    LabelFont.Charset = ANSI_CHARSET
    LabelFont.Color = clWindowText
    LabelFont.Height = -13
    LabelFont.Name = 'Tahoma'
    LabelFont.Style = [fsBold]
    Persistence.Enable = False
    Persistence.Location = plInifile
    Color = clWindow
    Enabled = True
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    HintShowLargeText = False
    ParentFont = False
    OleDropTarget = False
    OleDropSource = False
    Signed = False
    TabOrder = 1
    Text = 'txtCard'
    Transparent = False
    Visible = True
  end
  object txtBank: TAdvEdit
    Left = 108
    Top = 158
    Width = 350
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
    LabelCaption = 'Bank :'
    LabelPosition = lpLeftTop
    LabelMargin = 4
    LabelTransparent = False
    LabelAlwaysEnabled = True
    LabelFont.Charset = ANSI_CHARSET
    LabelFont.Color = clWindowText
    LabelFont.Height = -13
    LabelFont.Name = 'Tahoma'
    LabelFont.Style = [fsBold]
    Persistence.Enable = False
    Persistence.Location = plInifile
    Color = clWindow
    Enabled = True
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    HintShowLargeText = False
    ParentFont = False
    OleDropTarget = False
    OleDropSource = False
    Signed = False
    TabOrder = 2
    Text = 'txtBank'
    Transparent = False
    Visible = True
  end
end
