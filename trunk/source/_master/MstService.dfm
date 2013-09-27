object frmMstService: TfrmMstService
  Left = 342
  Top = 180
  BorderStyle = bsDialog
  Caption = 'Data Layanan Petshop'
  ClientHeight = 185
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
    Left = 44
    Top = 81
    Width = 63
    Height = 13
    Caption = 'Keterangan :'
  end
  object Label2: TLabel
    Left = 59
    Top = 56
    Width = 47
    Height = 13
    Alignment = taRightJustify
    Caption = 'Kategori :'
  end
  object txtCode: TAdvEdit
    Left = 110
    Top = 8
    Width = 97
    Height = 21
    TabStop = False
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
    TabOrder = 2
    Text = '0'
    Transparent = False
    Visible = True
    OnChange = txtNameChange
    OnKeyPress = txtCodeKeyPress
  end
  object txtName: TAdvEdit
    Left = 110
    Top = 32
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
    LabelAlwaysEnabled = False
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
    TabOrder = 0
    Text = 'txtName'
    Transparent = False
    Visible = True
    OnChange = txtNameChange
    OnKeyDown = txtNameKeyDown
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 145
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
    TabOrder = 3
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
  object txtNotes: TMemo
    Left = 110
    Top = 80
    Width = 355
    Height = 59
    Lines.Strings = (
      'txtNotes')
    TabOrder = 1
    OnChange = txtNotesChange
  end
  object cmbJenis: TComboBox
    Left = 110
    Top = 56
    Width = 145
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 4
    OnChange = cmbJenisChange
  end
  object WinXP1: TWinXP
    Left = 480
    Top = 24
  end
  object PopupMenu1: TPopupMenu
    AutoPopup = False
    Left = 312
    Top = 104
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
