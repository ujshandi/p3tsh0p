object frmMstAkun: TfrmMstAkun
  Left = 242
  Top = 161
  Width = 524
  Height = 449
  Caption = 'frmMstAkun'
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
      Width = 255
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
      Color = clWindow
      Enabled = True
      HintShowLargeText = False
      MaxLength = 50
      OleDropTarget = False
      OleDropSource = False
      Signed = False
      TabOrder = 1
      Text = 'TOKUY BIRU MUDA'
      Transparent = False
      Visible = True
      OnChange = txtKodeChange
    end
    object rgType: TRadioGroup
      Left = 362
      Top = 25
      Width = 146
      Height = 38
      Caption = 'Tipe Akun'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Debit'
        'Credit')
      TabOrder = 2
      OnClick = rgTypeClick
    end
  end
  object suiPanel2: TsuiPanel
    Left = 0
    Top = 110
    Width = 516
    Height = 305
    UIStyle = DeepBlue
    BorderColor = clBlack
    Caption = 'Daftar Akun'
    ShowButton = False
    CaptionFontColor = clWhite
    Align = alClient
    TabOrder = 1
    Color = clWhite
    PopupMenu = frmMainMenu.MenuShortCut
    object grid: TAdvStringGrid
      Left = 4
      Top = 24
      Width = 508
      Height = 277
      Cursor = crDefault
      Align = alClient
      BorderStyle = bsNone
      ColCount = 14
      DefaultColWidth = 100
      DefaultRowHeight = 21
      DefaultDrawing = False
      FixedCols = 1
      RowCount = 5
      FixedRows = 1
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      GridLineWidth = 1
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goColSizing, goRowSelect]
      ParentFont = False
      TabOrder = 0
      GridLineColor = clSilver
      ActiveCellShow = False
      ActiveCellFont.Charset = DEFAULT_CHARSET
      ActiveCellFont.Color = clWindowText
      ActiveCellFont.Height = -11
      ActiveCellFont.Name = 'MS Sans Serif'
      ActiveCellFont.Style = [fsBold]
      ActiveCellColor = clGray
      Bands.PrimaryColor = clInfoBk
      Bands.PrimaryLength = 1
      Bands.SecondaryColor = clWindow
      Bands.SecondaryLength = 1
      Bands.Print = False
      AutoNumAlign = False
      AutoSize = False
      VAlignment = vtaTop
      EnhTextSize = True
      EnhRowColMove = False
      SizeWithForm = False
      Multilinecells = False
      OnClickCell = gridClickCell
      DragDropSettings.OleAcceptFiles = True
      DragDropSettings.OleAcceptText = True
      SortSettings.AutoColumnMerge = False
      SortSettings.Column = 1
      SortSettings.Show = True
      SortSettings.IndexShow = False
      SortSettings.Full = True
      SortSettings.SingleColumn = False
      SortSettings.IgnoreBlanks = True
      SortSettings.BlankPos = blFirst
      SortSettings.AutoFormat = True
      SortSettings.Direction = sdAscending
      SortSettings.FixedCols = False
      SortSettings.NormalCellsOnly = True
      SortSettings.Row = 0
      FloatingFooter.Color = clBtnFace
      FloatingFooter.Column = 0
      FloatingFooter.FooterStyle = fsFixedLastRow
      FloatingFooter.Visible = False
      ControlLook.Color = clBlack
      ControlLook.CheckSize = 15
      ControlLook.RadioSize = 10
      ControlLook.ControlStyle = csWinXP
      ControlLook.FlatButton = False
      EnableBlink = False
      EnableHTML = True
      EnableWheel = True
      Flat = False
      HintColor = clInfoBk
      SelectionColor = clHighlight
      SelectionTextColor = clHighlightText
      SelectionRectangle = False
      SelectionResizer = False
      SelectionRTFKeep = False
      HintShowCells = False
      HintShowLargeText = False
      HintShowSizing = False
      PrintSettings.FooterSize = 0
      PrintSettings.HeaderSize = 0
      PrintSettings.Time = ppNone
      PrintSettings.Date = ppNone
      PrintSettings.DateFormat = 'dd/mm/yyyy'
      PrintSettings.PageNr = ppNone
      PrintSettings.Title = ppNone
      PrintSettings.Font.Charset = DEFAULT_CHARSET
      PrintSettings.Font.Color = clWindowText
      PrintSettings.Font.Height = -11
      PrintSettings.Font.Name = 'MS Sans Serif'
      PrintSettings.Font.Style = []
      PrintSettings.HeaderFont.Charset = DEFAULT_CHARSET
      PrintSettings.HeaderFont.Color = clWindowText
      PrintSettings.HeaderFont.Height = -11
      PrintSettings.HeaderFont.Name = 'MS Sans Serif'
      PrintSettings.HeaderFont.Style = []
      PrintSettings.FooterFont.Charset = DEFAULT_CHARSET
      PrintSettings.FooterFont.Color = clWindowText
      PrintSettings.FooterFont.Height = -11
      PrintSettings.FooterFont.Name = 'MS Sans Serif'
      PrintSettings.FooterFont.Style = []
      PrintSettings.Borders = pbNoborder
      PrintSettings.BorderStyle = psSolid
      PrintSettings.Centered = False
      PrintSettings.RepeatFixedRows = False
      PrintSettings.RepeatFixedCols = False
      PrintSettings.LeftSize = 0
      PrintSettings.RightSize = 0
      PrintSettings.ColumnSpacing = 0
      PrintSettings.RowSpacing = 0
      PrintSettings.TitleSpacing = 0
      PrintSettings.Orientation = poPortrait
      PrintSettings.PageNumberOffset = 0
      PrintSettings.MaxPagesOffset = 0
      PrintSettings.FixedWidth = 0
      PrintSettings.FixedHeight = 0
      PrintSettings.UseFixedHeight = False
      PrintSettings.UseFixedWidth = False
      PrintSettings.FitToPage = fpNever
      PrintSettings.PageNumSep = '/'
      PrintSettings.NoAutoSize = False
      PrintSettings.NoAutoSizeRow = False
      PrintSettings.PrintGraphics = False
      HTMLSettings.Width = 100
      HTMLSettings.XHTML = False
      Navigation.AdvanceDirection = adLeftRight
      Navigation.AllowClipboardRowGrow = True
      Navigation.AllowClipboardColGrow = True
      Navigation.InsertPosition = pInsertBefore
      Navigation.CopyHTMLTagsToClipboard = True
      Navigation.HomeEndKey = heFirstLastColumn
      ColumnSize.Stretch = True
      ColumnSize.Location = clRegistry
      CellNode.Color = clSilver
      CellNode.NodeColor = clBlack
      CellNode.ShowTree = False
      MaxEditLength = 0
      IntelliPan = ipVertical
      URLColor = clBlue
      URLShow = False
      URLFull = False
      URLEdit = False
      ScrollType = ssNormal
      ScrollColor = clNone
      ScrollWidth = 17
      ScrollSynch = False
      ScrollProportional = False
      ScrollHints = shNone
      OemConvert = False
      FixedFooters = 0
      FixedRightCols = 0
      FixedColWidth = 100
      FixedRowHeight = 21
      FixedFont.Charset = DEFAULT_CHARSET
      FixedFont.Color = clWindowText
      FixedFont.Height = -11
      FixedFont.Name = 'Tahoma'
      FixedFont.Style = []
      FixedAsButtons = False
      FloatFormat = '%.2f'
      IntegralHeight = False
      WordWrap = False
      ColumnHeaders.Strings = (
        'No'
        'Kode'
        'Nama'
        '')
      Lookup = False
      LookupCaseSensitive = False
      LookupHistory = False
      BackGround.Top = 0
      BackGround.Left = 0
      BackGround.Display = bdTile
      BackGround.Cells = bcNormal
      Filter = <>
      ColWidths = (
        100
        100
        100
        100
        100
        100
        100
        100
        49
        30
        40
        100
        100
        100)
      RowHeights = (
        21
        21
        21
        21
        15)
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
