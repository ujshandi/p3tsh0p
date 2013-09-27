object frmMstRak: TfrmMstRak
  Left = 242
  Top = 161
  Width = 524
  Height = 449
  Caption = 'frmMstRak'
  Color = clWhite
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object suiPanel1: TsuiPanel
    Left = 0
    Top = 40
    Width = 516
    Height = 70
    UIStyle = DeepBlue
    BorderColor = clBlack
    Caption = 'Input/Edit'
    ShowButton = True
    CaptionFontColor = clWhite
    Align = alTop
    TabOrder = 0
    Color = clWhite
    PopupMenu = frmMainMenu.MenuShortCut
    DesignSize = (
      516
      70)
    object txtKode: TAdvEdit
      Left = 8
      Top = 40
      Width = 89
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
      LabelCaption = 'Kode :'
      LabelPosition = lpTopLeft
      LabelMargin = 2
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
      ReadOnly = True
      Signed = False
      TabOrder = 0
      Text = 'txtKode'
      Transparent = False
      Visible = True
      OnChange = txtKodeChange
    end
    object txtNama: TAdvEdit
      Left = 101
      Top = 40
      Width = 239
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
      LabelCaption = 'Nama :'
      LabelPosition = lpTopLeft
      LabelMargin = 2
      LabelTransparent = False
      LabelAlwaysEnabled = False
      LabelFont.Charset = DEFAULT_CHARSET
      LabelFont.Color = clWindowText
      LabelFont.Height = -11
      LabelFont.Name = 'MS Sans Serif'
      LabelFont.Style = []
      Persistence.Enable = False
      Persistence.Location = plInifile
      Anchors = [akLeft, akTop, akRight]
      Color = clWindow
      Enabled = True
      HintShowLargeText = False
      MaxLength = 15
      OleDropTarget = False
      OleDropSource = False
      Signed = False
      TabOrder = 1
      Text = 'TOKUY BIRU MUDA'
      Transparent = False
      Visible = True
      OnChange = txtKodeChange
    end
    object txtParent: TAdvEdit
      Left = 344
      Top = 40
      Width = 165
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
      LabelCaption = 'Parent :'
      LabelPosition = lpTopLeft
      LabelMargin = 2
      LabelTransparent = False
      LabelAlwaysEnabled = False
      LabelFont.Charset = DEFAULT_CHARSET
      LabelFont.Color = clWindowText
      LabelFont.Height = -11
      LabelFont.Name = 'MS Sans Serif'
      LabelFont.Style = []
      Persistence.Enable = False
      Persistence.Location = plInifile
      Anchors = [akTop, akRight]
      Color = clWindow
      Enabled = True
      HintShowLargeText = False
      OleDropTarget = False
      OleDropSource = False
      Signed = False
      TabOrder = 2
      Text = 'txtNama'
      Transparent = False
      Visible = True
      OnChange = txtKodeChange
    end
  end
  object suiPanel2: TsuiPanel
    Left = 0
    Top = 110
    Width = 516
    Height = 305
    UIStyle = DeepBlue
    BorderColor = clBlack
    Caption = 'Daftar Rak'
    ShowButton = False
    CaptionFontColor = clWhite
    Align = alClient
    TabOrder = 1
    Color = clWhite
    PopupMenu = frmMainMenu.MenuShortCut
    object suiTreeView1: TsuiTreeView
      Left = 4
      Top = 24
      Width = 508
      Height = 277
      UIStyle = WinXP
      BorderColor = 6842472
      Align = alClient
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = bsNone
      BorderWidth = 2
      HideSelection = False
      Indent = 18
      RowSelect = True
      TabOrder = 0
      OnClick = suiTreeView1Click
      OnCollapsed = suiTreeView1Collapsed
    end
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 516
    Height = 40
    ButtonHeight = 36
    ButtonWidth = 45
    Caption = 'ToolBar1'
    Customizable = True
    EdgeBorders = [ebBottom]
    Flat = True
    Images = frmMainMenu.SmallImageList
    ParentShowHint = False
    PopupMenu = frmMainMenu.MenuShortCut
    ShowCaptions = True
    ShowHint = True
    TabOrder = 2
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
      Left = 45
      Top = 0
      Hint = 'Save Data [Ctrl+S]'
      Caption = 'Save'
      ImageIndex = 1
      OnClick = tbtSaveClick
    end
    object ToolButton2: TToolButton
      Left = 90
      Top = 0
      Width = 6
      Caption = 'ToolButton2'
      ImageIndex = 8
      Style = tbsSeparator
    end
    object tbtDelete: TToolButton
      Left = 96
      Top = 0
      Caption = 'Delete'
      ImageIndex = 2
      OnClick = tbtDeleteClick
    end
    object ToolButton5: TToolButton
      Left = 141
      Top = 0
      Width = 6
      Caption = 'ToolButton5'
      Style = tbsDivider
    end
    object tbtRefresh: TToolButton
      Tag = -19
      Left = 147
      Top = 0
      Hint = 'Refresh [Ctrl+R]'
      Caption = 'Refresh'
      ImageIndex = 6
      OnClick = tbtRefreshClick
    end
  end
end
