object frmMstPasien: TfrmMstPasien
  Left = 277
  Top = 179
  ActiveControl = txtName
  BorderStyle = bsDialog
  Caption = 'Input Pasien'
  ClientHeight = 393
  ClientWidth = 375
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
  OnKeyDown = FormKeyDown
  OnPaint = FormPaint
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 43
    Height = 14
    Caption = 'Identity'
    Font.Charset = ANSI_CHARSET
    Font.Color = clMaroon
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsItalic]
    ParentFont = False
  end
  object Bevel1: TBevel
    Left = 56
    Top = 16
    Width = 309
    Height = 6
    Shape = bsTopLine
  end
  object Label2: TLabel
    Left = 8
    Top = 152
    Width = 43
    Height = 14
    Caption = 'Address'
    Font.Charset = ANSI_CHARSET
    Font.Color = clMaroon
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsItalic]
    ParentFont = False
  end
  object Bevel2: TBevel
    Left = 56
    Top = 160
    Width = 309
    Height = 6
    Shape = bsTopLine
  end
  object Label3: TLabel
    Left = 8
    Top = 248
    Width = 69
    Height = 14
    Caption = 'Contact Info'
    Font.Charset = ANSI_CHARSET
    Font.Color = clMaroon
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = [fsItalic]
    ParentFont = False
  end
  object Bevel3: TBevel
    Left = 85
    Top = 256
    Width = 280
    Height = 6
    Shape = bsTopLine
  end
  object Jsn: TLabel
    Left = 10
    Top = 80
    Width = 66
    Height = 13
    Caption = 'Jns. Kelamin :'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label6: TLabel
    Left = 29
    Top = 104
    Width = 47
    Height = 13
    Caption = 'Tgl Lahir :'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object txtCode: TAdvEdit
    Left = 80
    Top = 31
    Width = 73
    Height = 22
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
    ReturnIsTab = True
    LengthLimit = 0
    TabOnFullLength = False
    Precision = 0
    LabelCaption = 'Kode :'
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
    Text = 'txtCode'
    Transparent = False
    Visible = True
    OnChange = txtCodeChange
  end
  object txtName: TAdvEdit
    Left = 80
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
    Signed = False
    TabOrder = 1
    Text = 'txtName'
    Transparent = False
    Visible = True
    OnChange = txtCodeChange
  end
  object txtAddress: TAdvEdit
    Left = 80
    Top = 176
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
    LabelCaption = 'Alamat :'
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
    Signed = False
    TabOrder = 4
    Text = 'txtAddress'
    Transparent = False
    Visible = True
    OnChange = txtCodeChange
  end
  object txtCity: TAdvEdit
    Left = 80
    Top = 201
    Width = 192
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
    LabelCaption = 'Kota :'
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
    Signed = False
    TabOrder = 5
    Text = 'Surabaya'
    Transparent = False
    Visible = True
    OnChange = txtCodeChange
  end
  object txtPhone: TAdvEdit
    Left = 80
    Top = 272
    Width = 281
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
    LabelCaption = 'Phone :'
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
    Signed = False
    TabOrder = 6
    Text = '085 220 097 850'
    Transparent = False
    Visible = True
    OnChange = txtCodeChange
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 353
    Width = 375
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
    TabOrder = 8
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
  object txtCotact: TAdvEdit
    Left = 80
    Top = 296
    Width = 281
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
    LabelCaption = 'No Kartu :'
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
    Signed = False
    TabOrder = 7
    Text = 'txtCotact'
    Transparent = False
    Visible = True
    OnChange = txtCodeChange
  end
  object cmbSex: TComboBox
    Left = 80
    Top = 80
    Width = 145
    Height = 22
    ItemHeight = 14
    TabOrder = 2
    Text = 'cmbSex'
    OnChange = cmbSexChange
    OnKeyDown = cmbSexKeyDown
    Items.Strings = (
      'LAKI-LAKI'
      'PEREMPUAN')
  end
  object dtpLahir: TDateTimePicker
    Left = 80
    Top = 104
    Width = 145
    Height = 22
    CalAlignment = dtaLeft
    Date = 39988.8097437847
    Time = 39988.8097437847
    DateFormat = dfShort
    DateMode = dmComboBox
    Kind = dtkDate
    ParseInput = False
    TabOrder = 3
    OnKeyDown = cmbSexKeyDown
  end
  object WinXP1: TWinXP
    Left = 344
    Top = 32
  end
end
