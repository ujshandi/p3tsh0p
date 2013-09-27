object frmMstBarcode: TfrmMstBarcode
  Left = 52
  Top = 175
  Width = 696
  Height = 480
  Caption = 'frmMstBarcode'
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 688
    Height = 41
    ButtonHeight = 36
    ButtonWidth = 57
    Caption = 'ToolBar1'
    EdgeBorders = [ebBottom]
    Flat = True
    Images = frmMainMenu.SmallImageList
    ParentShowHint = False
    PopupMenu = frmMainMenu.MenuShortCut
    ShowCaptions = True
    ShowHint = True
    TabOrder = 0
    Transparent = True
    object tbtRefresh: TToolButton
      Tag = -19
      Left = 0
      Top = 0
      Hint = 'Refresh [Ctrl+L]'
      Caption = 'Load Data'
      ImageIndex = 6
      OnClick = tbtRefreshClick
    end
    object ToolButton4: TToolButton
      Left = 57
      Top = 0
      Width = 6
      Caption = 'ToolButton4'
      ImageIndex = 12
      Style = tbsSeparator
    end
    object tbtPrint: TToolButton
      Tag = -14
      Left = 63
      Top = 0
      Hint = 'Print Data [Ctrl+P]'
      Caption = 'Print'
      ImageIndex = 11
      OnClick = tbtPrintClick
    end
    object ToolButton1: TToolButton
      Left = 120
      Top = 0
      Caption = 'Reset'
      ImageIndex = 6
      OnClick = ToolButton1Click
    end
  end
  object suiPanel3: TsuiPanel
    Left = 0
    Top = 41
    Width = 688
    Height = 98
    UIStyle = DeepBlue
    BorderColor = clBlack
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Caption = 'Filter'
    ShowButton = True
    CaptionFontColor = clWhite
    Align = alTop
    TabOrder = 1
    Color = clWhite
    object Label2: TLabel
      Left = 256
      Top = 48
      Width = 41
      Height = 13
      Caption = 'Format :'
    end
    object txtProdusen: TAdvEdit
      Left = 69
      Top = 71
      Width = 170
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
      LabelCaption = 'Produsen :'
      LabelPosition = lpLeftTop
      LabelMargin = 2
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
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      HintShowLargeText = False
      ParentFont = False
      OleDropTarget = False
      OleDropSource = False
      Signed = False
      TabOrder = 9
      Text = 'BRITISH AMERICAN TOBACCO'
      Transparent = False
      Visible = True
      OnKeyDown = txtSpecKeyDown
    end
    object txtSpec: TAdvEdit
      Left = 70
      Top = 26
      Width = 170
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
      LabelCaption = 'Jns Barang :'
      LabelPosition = lpLeftTop
      LabelMargin = 2
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
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      HintShowLargeText = False
      ParentFont = False
      OleDropTarget = False
      OleDropSource = False
      Signed = False
      TabOrder = 0
      Text = 'txtSpec'
      Transparent = False
      Visible = True
      OnKeyDown = txtSpecKeyDown
    end
    object Button1: TButton
      Left = 222
      Top = 28
      Width = 16
      Height = 17
      Caption = '...'
      TabOrder = 1
      OnClick = Button1Click
    end
    object cmbFormat: TComboBox
      Left = 300
      Top = 48
      Width = 169
      Height = 21
      ItemHeight = 13
      TabOrder = 2
      Text = 'Format #2 [13 x 38mm]'
      Items.Strings = (
        'Format #1 [A4 Landscape]'
        'Format #2 [13 x 38mm]')
    end
    object txtVc: TAdvEdit
      Left = 70
      Top = 48
      Width = 170
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
      LabelCaption = 'Supplier :'
      LabelPosition = lpLeftTop
      LabelMargin = 2
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
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      HintShowLargeText = False
      ParentFont = False
      OleDropTarget = False
      OleDropSource = False
      Signed = False
      TabOrder = 3
      Text = 'txtSpec'
      Transparent = False
      Visible = True
      OnKeyDown = txtSpecKeyDown
    end
    object Button2: TButton
      Left = 222
      Top = 50
      Width = 16
      Height = 17
      Caption = '...'
      TabOrder = 4
      OnClick = Button2Click
    end
    object txtKemasan: TAdvEdit
      Left = 300
      Top = 26
      Width = 170
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
      LabelCaption = 'Barcode :'
      LabelPosition = lpLeftTop
      LabelMargin = 2
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
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      HintShowLargeText = False
      ParentFont = False
      OleDropTarget = False
      OleDropSource = False
      Signed = False
      TabOrder = 5
      Text = 'txtSpec'
      Transparent = False
      Visible = True
      OnKeyDown = txtSpecKeyDown
    end
    object Button3: TButton
      Left = 221
      Top = 73
      Width = 16
      Height = 17
      Caption = '...'
      TabOrder = 6
      OnClick = Button3Click
    end
    object txtNama: TAdvEdit
      Left = 517
      Top = 26
      Width = 170
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
      LabelPosition = lpLeftTop
      LabelMargin = 2
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
      Text = 'txtNama'
      Transparent = False
      Visible = True
      OnKeyDown = txtSpecKeyDown
    end
    object txtMerk: TAdvEdit
      Left = 517
      Top = 50
      Width = 170
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
      LabelCaption = 'Kode :'
      LabelPosition = lpLeftTop
      LabelMargin = 2
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
      TabOrder = 8
      Text = 'txtMerk'
      Transparent = False
      Visible = True
      OnKeyDown = txtSpecKeyDown
    end
    object CheckBox1: TCheckBox
      Left = 517
      Top = 72
      Width = 97
      Height = 17
      Caption = 'Include Harga 2'
      Checked = True
      State = cbChecked
      TabOrder = 10
    end
    object txtCol: TAdvEdit
      Left = 300
      Top = 72
      Width = 152
      Height = 21
      AutoFocus = False
      EditAlign = eaRight
      EditType = etNumeric
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
      LabelCaption = 'Jml Kolom :'
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
      TabOrder = 11
      Text = '1'
      Transparent = False
      Visible = True
      OnKeyDown = txtSpecKeyDown
    end
    object UpDown1: TUpDown
      Left = 452
      Top = 72
      Width = 16
      Height = 21
      Associate = txtCol
      Min = 1
      Max = 5
      Position = 1
      TabOrder = 12
      Wrap = False
    end
  end
  object suiPanel2: TsuiPanel
    Left = 0
    Top = 139
    Width = 688
    Height = 307
    UIStyle = DeepBlue
    BorderColor = clBlack
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Caption = 'Data Barang'
    ShowButton = False
    CaptionFontColor = clWhite
    Align = alClient
    TabOrder = 2
    Color = clWhite
    DesignSize = (
      688
      307)
    object asgPrint: TAdvStringGrid
      Left = 64
      Top = 192
      Width = 569
      Height = 87
      Cursor = crDefault
      Hint = 'TAdvStringGrid with graphics'
      Anchors = [akRight, akBottom]
      ColCount = 1
      DefaultColWidth = 21
      DefaultRowHeight = 21
      DefaultDrawing = False
      FixedCols = 0
      RowCount = 1
      FixedRows = 0
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      GridLineWidth = 1
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goColSizing]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
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
      EnhTextSize = False
      EnhRowColMove = False
      SizeWithForm = False
      Multilinecells = False
      DragDropSettings.OleAcceptFiles = True
      DragDropSettings.OleAcceptText = True
      SortSettings.AutoColumnMerge = False
      SortSettings.Column = 0
      SortSettings.Show = False
      SortSettings.IndexShow = False
      SortSettings.Full = True
      SortSettings.SingleColumn = False
      SortSettings.IgnoreBlanks = False
      SortSettings.BlankPos = blFirst
      SortSettings.AutoFormat = True
      SortSettings.Direction = sdAscending
      SortSettings.FixedCols = False
      SortSettings.NormalCellsOnly = False
      SortSettings.Row = 0
      FloatingFooter.Color = clBtnFace
      FloatingFooter.Column = 0
      FloatingFooter.FooterStyle = fsFixedLastRow
      FloatingFooter.Visible = False
      ControlLook.Color = clBlack
      ControlLook.CheckSize = 15
      ControlLook.RadioSize = 10
      ControlLook.ControlStyle = csClassic
      ControlLook.FlatButton = False
      EnableBlink = False
      EnableHTML = True
      EnableWheel = True
      Flat = False
      HintColor = clYellow
      SelectionColor = clHighlight
      SelectionTextColor = clWhite
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
      PrintSettings.Font.Charset = ANSI_CHARSET
      PrintSettings.Font.Color = clWindowText
      PrintSettings.Font.Height = -11
      PrintSettings.Font.Name = 'Arial'
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
      PrintSettings.Borders = pbSingle
      PrintSettings.BorderStyle = psSolid
      PrintSettings.Centered = True
      PrintSettings.RepeatFixedRows = False
      PrintSettings.RepeatFixedCols = False
      PrintSettings.LeftSize = 0
      PrintSettings.RightSize = 0
      PrintSettings.ColumnSpacing = 0
      PrintSettings.RowSpacing = 0
      PrintSettings.TitleSpacing = 0
      PrintSettings.Orientation = poPortrait
      PrintSettings.PagePrefix = 'page'
      PrintSettings.PageNumberOffset = 0
      PrintSettings.MaxPagesOffset = 0
      PrintSettings.FixedWidth = 0
      PrintSettings.FixedHeight = 0
      PrintSettings.UseFixedHeight = False
      PrintSettings.UseFixedWidth = False
      PrintSettings.FitToPage = fpAlways
      PrintSettings.PageNumSep = '/'
      PrintSettings.NoAutoSize = True
      PrintSettings.NoAutoSizeRow = True
      PrintSettings.PrintGraphics = True
      HTMLSettings.Width = 100
      HTMLSettings.XHTML = False
      Navigation.AllowInsertRow = True
      Navigation.AllowDeleteRow = True
      Navigation.AdvanceOnEnter = True
      Navigation.AdvanceInsert = True
      Navigation.AdvanceDirection = adLeftRight
      Navigation.AllowClipboardShortCuts = True
      Navigation.AllowClipboardRowGrow = True
      Navigation.AllowClipboardColGrow = True
      Navigation.InsertPosition = pInsertBefore
      Navigation.CopyHTMLTagsToClipboard = True
      Navigation.HomeEndKey = heFirstLastColumn
      ColumnSize.Location = clRegistry
      CellNode.Color = clSilver
      CellNode.NodeColor = clBlack
      CellNode.ShowTree = False
      MaxEditLength = 0
      MouseActions.AllSelect = True
      MouseActions.ColSelect = True
      MouseActions.RowSelect = True
      IntelliPan = ipVertical
      URLColor = clBlue
      URLShow = False
      URLFull = False
      URLEdit = False
      ScrollType = ssNormal
      ScrollColor = clNone
      ScrollWidth = 16
      ScrollSynch = False
      ScrollProportional = False
      ScrollHints = shNone
      OemConvert = False
      FixedFooters = 0
      FixedRightCols = 0
      FixedColWidth = 21
      FixedRowHeight = 21
      FixedFont.Charset = DEFAULT_CHARSET
      FixedFont.Color = clWindowText
      FixedFont.Height = -11
      FixedFont.Name = 'Arial'
      FixedFont.Style = []
      FixedAsButtons = False
      FloatFormat = '%.2f'
      IntegralHeight = False
      WordWrap = False
      Lookup = False
      LookupCaseSensitive = False
      LookupHistory = False
      ShowSelection = False
      BackGround.Top = 0
      BackGround.Left = 0
      BackGround.Display = bdTile
      BackGround.Cells = bcNormal
      Filter = <>
    end
    object gridVar: TAdvStringGrid
      Left = 4
      Top = 24
      Width = 269
      Height = 279
      Cursor = crDefault
      Align = alLeft
      BorderStyle = bsNone
      ColCount = 3
      Ctl3D = False
      DefaultRowHeight = 21
      DefaultDrawing = False
      FixedCols = 0
      RowCount = 2
      FixedRows = 1
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      GridLineWidth = 1
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goRowSelect]
      ParentCtl3D = False
      ParentFont = False
      ScrollBars = ssVertical
      TabOrder = 2
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
      EnhTextSize = False
      EnhRowColMove = False
      SizeWithForm = False
      Multilinecells = False
      OnRowChanging = gridVarRowChanging
      DragDropSettings.OleAcceptFiles = True
      DragDropSettings.OleAcceptText = True
      SortSettings.AutoColumnMerge = False
      SortSettings.Column = 0
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
      ControlLook.ControlStyle = csClassic
      ControlLook.FlatButton = False
      EnableBlink = False
      EnableHTML = True
      EnableWheel = True
      Flat = True
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
      ScrollType = ssEncarta
      ScrollColor = clNone
      ScrollWidth = 17
      ScrollSynch = False
      ScrollProportional = False
      ScrollHints = shNone
      OemConvert = False
      FixedFooters = 0
      FixedRightCols = 0
      FixedColWidth = 64
      FixedRowHeight = 21
      FixedFont.Charset = DEFAULT_CHARSET
      FixedFont.Color = clWindowText
      FixedFont.Height = -11
      FixedFont.Name = 'Tahoma'
      FixedFont.Style = []
      FixedAsButtons = False
      FloatFormat = '%.2f'
      IntegralHeight = False
      WordWrap = True
      ColumnHeaders.Strings = (
        'ID'
        'Barcode'
        'Nama')
      Lookup = False
      LookupCaseSensitive = False
      LookupHistory = False
      BackGround.Top = 0
      BackGround.Left = 0
      BackGround.Display = bdTile
      BackGround.Cells = bcNormal
      Filter = <>
      ColWidths = (
        64
        64
        152)
    end
    object Panel1: TPanel
      Left = 273
      Top = 24
      Width = 25
      Height = 279
      Align = alLeft
      TabOrder = 3
      object SpeedButton1: TSpeedButton
        Left = 3
        Top = 44
        Width = 20
        Height = 22
        Flat = True
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000EF0A0000EF0A00000000000000000000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE5BD9FCD7826CE7F3CF6DECBFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          C36B1EFFCB71FBB246D57513E1A06DFDF7F1FFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC06316F7B75BF2A235F99D1CEB8503CB
          6C1AF3C9A9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          BD5D15F3AD52EB972BEB8B0FF08900F79100DC7401D78748FBEADDFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB85B16ECA64EE58F27E48309E68000EA
          8400F08A00EE8800CA670AE4AB84FEFBF9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          B55816E7A24EDF8927DE7D09DF7900E27C00E57F00EB8500F18B00DD7700C66E
          29F4DECFFFFFFFFFFFFFFFFFFFFFFFFFB15517E39F52DB862CD9790FD97300DB
          7500DE7800E17B00E57F00EB8500F08A00C16C2BFFFFFFFFFFFFFFFFFFFFFFFF
          AF5116E09F5BD78634D4791AD36D01D56F00D87200DA7400DD7700E37D00E983
          00BE6829FFFFFFFFFFFFFFFFFFFFFFFFAB4E16DEA267D48841D17C28CF7010CE
          6800D16B00D67000DC7600CE6800BC6628F2DBCDFFFFFFFFFFFFFFFFFFFFFFFF
          A84D19DEA778D38E51D0813ACD7624CB6C11CE6904CD6700B35208DAA181FDF9
          F8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA74B1EDFB18AD49563D0894ED0813ED1
          7D2FBC590EC47144F7E3DAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          A74D20E3BCA0D7A37BD79F70C87E46AB4E1CE5B8A3FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA85124EFDBCADFB69AB35B2DC98165F9
          F0EDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          D1A391AF5B32AE5B33EACEC4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
        OnClick = SpeedButton1Click
      end
      object SpeedButton2: TSpeedButton
        Left = 3
        Top = 68
        Width = 20
        Height = 22
        Flat = True
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000EF0A0000EF0A00000000000000000000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFE8C2A3D4802BD47E24D78126EEB989FFFFFFFF
          FFFFE9B180D57E23EEC19BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD0761F
          FFAC12FFA102FFA400DD7703FFFFFFFFFFFFDA7E1CFFB628D97409F9E0CDFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFCB6C13FF9900FD9600FF9E00D87300FFFFFFFF
          FFFFD37512FB9909FD9700CE7725FDF6F1FFFFFFFFFFFFFFFFFFFFFFFFC56713
          F79100F58F00FE9800D46F00FFFFFFFFFFFFCD6A0AF18C01F48E00EF8A00DC92
          58FFFFFFFFFFFFFFFFFFFFFFFFC16213F08A00ED8700F79100CE6900FFFFFFFF
          FFFFC76305EA8300E98300F18B00DF7801EFBD99FFFFFFFFFFFFFFFFFFBC5F13
          E78100E57F00EE8800C86300FFFFFFFFFFFFC15D05E17B00E27C00E68000EF89
          00C96509F4DFD0FFFFFFFFFFFFB95B13DE7900DD7700E68000C35E00FFFFFFFF
          FFFFBD5A09DA7501DA7400DE7800E27C00EA8400C5773EFFFFFFFFFFFFB45513
          D67000D67000DD7700BD5800FFFFFFFFFFFFB95A12D47208D36D00D67000DB75
          00E68000BF6B2DFFFFFFFFFFFFAF5317CF6C07CE6600D46E00B95300FFFFFFFF
          FFFFB75D1CD27A20CD6804CF6800D66F00C45D01E6BEA6FFFFFFFFFFFFAD5119
          D17D2ECC6F17D07213B45104FFFFFFFFFFFFB56026D2853ECC7422CD6F12C562
          05D2916BFFFFFFFFFFFFFFFFFFAA4F1DD59157CF8341D48840B15110FFFFFFFF
          FFFFB46332D5955DCF8645CE7D36B56536FEFAF9FFFFFFFFFFFFFFFFFFA84E1F
          DBA981D49868DBA06DAE5319FFFFFFFFFFFFB66B42DBA980D79F6FAE511CF6E7
          E0FFFFFFFFFFFFFFFFFFFFFFFFAD592FEDD4BFE4BFA4EAC9ABB25D2BFFFFFFFF
          FFFFBF7750EDD3BCB66233E8C3B5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD0A38F
          B1643BAA572BAF5C32CF9071FFFFFFFFFFFFCD8B6AB05C32D39A83FFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
        OnClick = SpeedButton2Click
      end
      object SpeedButton3: TSpeedButton
        Left = 3
        Top = 100
        Width = 20
        Height = 22
        Flat = True
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000EF0A0000EF0A00000000000000000000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFEACEC4AE5B33AF5B32D1A391FFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9F0EDC98165B35B2DDFB69AEFDB
          CAA85124FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE5
          B8A3AB4E1CC87E46D79F70D7A37BE3BCA0A74D20FFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFF7E3DAC47144BC590ED17D2FD0813ED0894ED49563DFB1
          8AA74B1EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDF9F8DAA181B35208CD6700CE
          6904CB6C11CD7624D0813AD38E51DEA778A84D19FFFFFFFFFFFFFFFFFFFFFFFF
          F2DBCDBC6628CE6800DC7600D67000D16B00CE6800CF7010D17C28D48841DEA2
          67AB4E16FFFFFFFFFFFFFFFFFFFFFFFFBE6829E98300E37D00DD7700DA7400D8
          7200D56F00D36D01D4791AD78634E09F5BAF5116FFFFFFFFFFFFFFFFFFFFFFFF
          C16C2BF08A00EB8500E57F00E17B00DE7800DB7500D97300D9790FDB862CE39F
          52B15517FFFFFFFFFFFFFFFFFFFFFFFFF4DECFC66E29DD7700F18B00EB8500E5
          7F00E27C00DF7900DE7D09DF8927E7A24EB55816FFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFEFBF9E4AB84CA670AEE8800F08A00EA8400E68000E48309E58F27ECA6
          4EB85B16FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBEADDD78748DC
          7401F79100F08900EB8B0FEB972BF3AD52BD5D15FFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF3C9A9CB6C1AEB8503F99D1CF2A235F7B7
          5BC06316FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFDF7F1E1A06DD57513FBB246FFCB71C36B1EFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6DECBCE7F3CCD78
          26E5BD9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
        OnClick = SpeedButton3Click
      end
      object SpeedButton4: TSpeedButton
        Left = 3
        Top = 124
        Width = 20
        Height = 22
        Flat = True
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000EF0A0000EF0A00000000000000000000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF2C8A5D98127ED
          AC71FFFFFFFFFFFFEEB887D78126D47E24D4802BE8C3A5FFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFBE5D4D97B16FFBD38E48414FFFFFFFFFFFFDE7602FFA400FFA1
          02FFAC12CF7621FFFFFFFFFFFFFFFFFFFFFFFFFDF8F3CE762AFFA414FFA104E2
          7B00FFFFFFFFFFFFD97300FF9E00FD9600FF9900CA6D15FFFFFFFFFFFFFFFFFF
          FFFFFFDC915BED8C0DF89200FE9700DE7900FFFFFFFFFFFFD56F00FE9800F58F
          00F79100C46715FFFFFFFFFFFFFFFFFFECB998D87913F08903EE8800F69000D7
          7200FFFFFFFAF3EECF6900F58F00ED8700EE8800C16315FFFFFFFFFFFFF2DBCE
          C46718EA9224E37E00E78100EF8900D26B00FFFFFFFFFFFFCA6400EF8900E57F
          00E88200BD5E15FFFFFFFFFFFFC0723DE7A356DD8521DD7600E07A00E88200CC
          6500FFFFFFFFFFFFC45E00E68000DD7700DF7900B75B15FFFFFFFFFFFFBA6932
          E8AB68DA882FD77407D97200E17A00C76100FFFFFFFFFFFFBF5900DD7700D56F
          00D67000B45615FFFFFFFFFFFFE2B8A4C67335DE974ED57D23D47006DA7300C0
          5B00FFFFFFFFFFFFB95300D56E00CE6700CF6C07B05418FFFFFFFFFFFFFFFFFF
          CC8969CE874BDA9048D4802BD87D1CBD5C0CFFFFFFFFFFFFB55005D07213CB70
          17D17D2EAE511BFFFFFFFFFFFFFFFFFFFEFAF9B26237DA9C65D99555DB9248BC
          6421FFFFFFFFFFFFB1520FD48840CE8241D59257A94E1DFFFFFFFFFFFFFFFFFF
          FFFFFFF6E7E2AD5321E4B488E2AC78BC6D36FFFFFFFFFFFFB1541BD9A06DD498
          68DBA982A84F21FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEBC8BBB96635F5DCC1C3
          7A4EFFFFFFFFFFFFB25F2CE9C8ABE4BFA4ECD2BFAE5B2FFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFD6A08CB15E33C87F5BFFFFFFFFFFFFCF8F6FAE5B31AA57
          2BB1633CD2A591FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
        OnClick = SpeedButton4Click
      end
    end
    object grid: TAdvStringGrid
      Left = 298
      Top = 24
      Width = 386
      Height = 279
      Cursor = crDefault
      Align = alClient
      BorderStyle = bsNone
      ColCount = 7
      Ctl3D = False
      DefaultRowHeight = 21
      DefaultDrawing = False
      FixedCols = 0
      RowCount = 6
      FixedRows = 1
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      GridLineWidth = 1
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected]
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 0
      OnKeyDown = gridKeyDown
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
      VAlignment = vtaCenter
      EnhTextSize = False
      EnhRowColMove = False
      SizeWithForm = False
      Multilinecells = False
      OnGetAlignment = gridGetAlignment
      OnCanEditCell = gridCanEditCell
      OnGetEditorType = gridGetEditorType
      DragDropSettings.OleAcceptFiles = True
      DragDropSettings.OleAcceptText = True
      SortSettings.AutoColumnMerge = False
      SortSettings.Column = 5
      SortSettings.Show = True
      SortSettings.IndexShow = False
      SortSettings.Full = True
      SortSettings.SingleColumn = False
      SortSettings.IgnoreBlanks = False
      SortSettings.BlankPos = blFirst
      SortSettings.AutoFormat = True
      SortSettings.Direction = sdAscending
      SortSettings.FixedCols = False
      SortSettings.NormalCellsOnly = False
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
      Flat = True
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
      ColumnSize.StretchColumn = 3
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
      FixedColWidth = 64
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
        ''
        'Qty'
        'Barcode'
        'Nama Struk'
        'H Jual 1'
        'H Jual 2'
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
        64
        64
        33
        129
        56
        29
        10)
      RowHeights = (
        21
        21
        21
        21
        19
        29)
    end
  end
end
