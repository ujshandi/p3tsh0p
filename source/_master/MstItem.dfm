object frmMstItem: TfrmMstItem
  Left = 329
  Top = 126
  BorderStyle = bsDialog
  Caption = 'Data Barang'
  ClientHeight = 257
  ClientWidth = 499
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  PopupMenu = PopupMenu1
  Position = poDesktopCenter
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 43
    Top = 193
    Width = 63
    Height = 13
    Alignment = taRightJustify
    Caption = 'Expire Date :'
    Visible = False
  end
  object txtCode: TAdvEdit
    Left = 110
    Top = 8
    Width = 97
    Height = 21
    AutoFocus = False
    EditAlign = eaLeft
    EditType = etUppercase
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
    LabelCaption = 'Kode :'
    LabelPosition = lpLeftTop
    LabelMargin = 4
    LabelTransparent = False
    LabelAlwaysEnabled = True
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
    Signed = False
    TabOrder = 0
    Text = '0'
    Transparent = False
    Visible = True
    OnChange = txtNameChange
    OnEnter = txtBarcodeEnter
    OnKeyDown = txtCodeKeyDown
    OnKeyPress = txtCodeKeyPress
  end
  object txtName: TAdvEdit
    Left = 110
    Top = 104
    Width = 355
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
    ShowError = True
    URLColor = clBlue
    ReturnIsTab = True
    LengthLimit = 0
    TabOnFullLength = False
    Precision = 0
    LabelCaption = 'Nama :'
    LabelPosition = lpLeftTop
    LabelMargin = 4
    LabelTransparent = False
    LabelAlwaysEnabled = True
    LabelFont.Charset = ANSI_CHARSET
    LabelFont.Color = clWindowText
    LabelFont.Height = -11
    LabelFont.Name = 'Tahoma'
    LabelFont.Style = []
    Persistence.Enable = False
    Persistence.Location = plInifile
    AutoSelect = False
    Color = clWindow
    Enabled = True
    HintShowLargeText = False
    OleDropTarget = False
    OleDropSource = False
    Signed = False
    TabOrder = 5
    Text = 'txtName'
    Transparent = False
    Visible = True
    OnChange = txtNameChange
    OnEnter = txtBarcodeEnter
    OnKeyDown = txtNameKeyDown
  end
  object txtSpec: TAdvEdit
    Left = 110
    Top = 56
    Width = 220
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
    LabelCaption = 'Spesifikasi :'
    LabelPosition = lpLeftTop
    LabelMargin = 4
    LabelTransparent = False
    LabelAlwaysEnabled = True
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
    TabOrder = 2
    Text = 'txtSpec'
    Transparent = False
    Visible = True
    OnChange = txtNameChange
    OnEnter = txtSpecEnter
    OnKeyDown = txtSpecKeyDown
  end
  object btnSpec: TButton
    Left = 312
    Top = 59
    Width = 16
    Height = 16
    Caption = '...'
    TabOrder = 8
    TabStop = False
    OnClick = btnSpecClick
  end
  object txtStruk: TAdvEdit
    Left = 110
    Top = 128
    Width = 355
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
    LabelCaption = 'Nama Struk :'
    LabelPosition = lpLeftTop
    LabelMargin = 4
    LabelTransparent = False
    LabelAlwaysEnabled = True
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
    Signed = False
    TabOrder = 6
    Text = 'txtStruk'
    Transparent = False
    Visible = True
    OnChange = txtNameChange
    OnEnter = txtBarcodeEnter
    OnKeyDown = txtStrukKeyDown
  end
  object txtBarcode: TAdvEdit
    Left = 110
    Top = 32
    Width = 97
    Height = 21
    AutoFocus = False
    EditAlign = eaLeft
    EditType = etUppercase
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
    LabelCaption = 'Barcode :'
    LabelPosition = lpLeftTop
    LabelMargin = 4
    LabelTransparent = False
    LabelAlwaysEnabled = True
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
    Signed = False
    TabOrder = 1
    Text = '8999909028234'
    Transparent = False
    Visible = True
    OnChange = txtNameChange
    OnEnter = txtBarcodeEnter
    OnKeyDown = txtBarcodeKeyDown
    OnKeyPress = txtCodeKeyPress
  end
  object txtMerk: TAdvEdit
    Left = 110
    Top = 80
    Width = 220
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
    LabelCaption = 'Merk :'
    LabelPosition = lpLeftTop
    LabelMargin = 4
    LabelTransparent = False
    LabelAlwaysEnabled = True
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
    Signed = False
    TabOrder = 4
    Text = 'txtStruk'
    Transparent = False
    Visible = True
    OnChange = txtNameChange
    OnEnter = txtBarcodeEnter
  end
  object dtpExpire: TDateTimePicker
    Left = 110
    Top = 193
    Width = 100
    Height = 21
    CalAlignment = dtaLeft
    Date = 39991.5979379977
    Time = 39991.5979379977
    DateFormat = dfShort
    DateMode = dmComboBox
    Kind = dtkDate
    ParseInput = False
    TabOrder = 7
    Visible = False
    OnKeyDown = dtpExpireKeyDown
  end
  object txtJenis: TAdvEdit
    Left = 238
    Top = 16
    Width = 220
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
    LabelCaption = 'Jenis :'
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
    TabOrder = 3
    Text = 'txtSpec'
    Transparent = False
    Visible = False
    OnChange = txtNameChange
    OnEnter = txtJenisEnter
    OnKeyDown = txtSpecKeyDown
  end
  object btnJenis: TButton
    Left = 440
    Top = 18
    Width = 16
    Height = 16
    Caption = '...'
    TabOrder = 9
    TabStop = False
    Visible = False
    OnClick = btnJenisClick
  end
  object txtUnit: TAdvEdit
    Left = 110
    Top = 152
    Width = 69
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
    LabelCaption = 'Satuan :'
    LabelPosition = lpLeftTop
    LabelMargin = 4
    LabelTransparent = False
    LabelAlwaysEnabled = True
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
    TabOrder = 10
    Text = 'txtSpec'
    Transparent = False
    Visible = True
    OnChange = txtNameChange
    OnEnter = txtUnitEnter
    OnKeyDown = txtSpecKeyDown
  end
  object btnKemasan: TButton
    Left = 161
    Top = 155
    Width = 16
    Height = 16
    Caption = '...'
    TabOrder = 12
    TabStop = False
    OnClick = btnKemasanClick
  end
  object txtHarga: TAdvEdit
    Left = 110
    Top = 178
    Width = 97
    Height = 21
    AutoFocus = False
    EditAlign = eaLeft
    EditType = etUppercase
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
    LabelCaption = 'Barcode :'
    LabelPosition = lpLeftTop
    LabelMargin = 4
    LabelTransparent = False
    LabelAlwaysEnabled = True
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
    Signed = False
    TabOrder = 11
    Text = '8999909028234'
    Transparent = False
    Visible = True
    OnChange = txtNameChange
    OnEnter = txtBarcodeEnter
    OnKeyDown = txtBarcodeKeyDown
    OnKeyPress = txtCodeKeyPress
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 217
    Width = 499
    Height = 40
    Align = alBottom
    ButtonHeight = 36
    ButtonWidth = 31
    Caption = 'ToolBar1'
    Customizable = True
    Flat = True
    Images = frmMainMenu.SmallImageList
    ParentShowHint = False
    PopupMenu = PopupMenu1
    ShowCaptions = True
    ShowHint = True
    TabOrder = 13
    Transparent = True
    object tbtNew: TToolButton
      Tag = -10
      Left = 0
      Top = 0
      Hint = 'New Data [Ctrl+N]'
      Caption = 'New'
      ImageIndex = 0
      OnClick = tbtNewClick
    end
    object tbtSave: TToolButton
      Tag = -11
      Left = 31
      Top = 0
      Hint = 'Save Data [Ctrl+S]'
      Caption = 'Save'
      ImageIndex = 1
      OnClick = tbtSaveClick
    end
    object ToolButton2: TToolButton
      Left = 62
      Top = 0
      Width = 6
      Caption = 'ToolButton2'
      ImageIndex = 3
      Style = tbsSeparator
    end
  end
  object rbKategori: TRadioGroup
    Left = 266
    Top = 150
    Width = 201
    Height = 41
    Caption = 'Kategori'
    Columns = 2
    ItemIndex = 0
    Items.Strings = (
      'Barang'
      'Hewan')
    TabOrder = 14
  end
  object WinXP1: TWinXP
    Left = 480
    Top = 24
  end
  object PopupMenu1: TPopupMenu
    AutoPopup = False
    Left = 312
    Top = 208
    object New1: TMenuItem
      Caption = 'New'
      ShortCut = 16462
      OnClick = New1Click
    end
    object Save1: TMenuItem
      Caption = 'Save'
      ShortCut = 16467
      OnClick = Save1Click
    end
  end
end
