object frmMstBranchList: TfrmMstBranchList
  Left = 95
  Top = 188
  Width = 725
  Height = 480
  Caption = 'frmMstBranchList'
  Color = clWhite
  DragKind = dkDock
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 717
    Height = 41
    ButtonHeight = 36
    ButtonWidth = 62
    Caption = 'ToolBar1'
    EdgeBorders = [ebBottom]
    Flat = True
    Images = frmMainMenu.SmallImageList
    ParentShowHint = False
    ShowCaptions = True
    ShowHint = True
    TabOrder = 0
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
    object tbtDetail: TToolButton
      Tag = -11
      Left = 62
      Top = 0
      Hint = 'Detai [Ctrl+S]'
      Caption = 'Edit'
      ImageIndex = 1
      OnClick = tbtDetailClick
    end
    object ToolButton1: TToolButton
      Left = 124
      Top = 0
      Width = 6
      Caption = 'ToolButton1'
      ImageIndex = 12
      Style = tbsSeparator
    end
    object tbtRefresh: TToolButton
      Tag = -19
      Left = 130
      Top = 0
      Hint = 'Refresh [Ctrl+L]'
      Caption = 'Load Data'
      ImageIndex = 6
      OnClick = tbtRefreshClick
    end
    object ToolButton5: TToolButton
      Tag = -20
      Left = 192
      Top = 0
      Caption = 'Reset Filter'
      ImageIndex = 3
      OnClick = ToolButton5Click
    end
    object ToolButton2: TToolButton
      Left = 254
      Top = 0
      Width = 6
      Caption = 'ToolButton2'
      ImageIndex = 12
      Style = tbsSeparator
    end
    object tbtPrint: TToolButton
      Tag = -14
      Left = 260
      Top = 0
      Hint = 'Print Data [Ctrl+P]'
      Caption = 'Print'
      ImageIndex = 8
      OnClick = tbtPrintClick
    end
  end
  object suiPanel2: TsuiPanel
    Left = 0
    Top = 96
    Width = 717
    Height = 350
    UIStyle = DeepBlue
    BorderColor = clBlack
    Caption = 'Data Toko'
    ShowButton = False
    CaptionFontColor = clWhite
    Align = alClient
    TabOrder = 1
    Color = clWhite
    object grid: TAdvStringGrid
      Left = 4
      Top = 24
      Width = 709
      Height = 322
      Cursor = crDefault
      Align = alClient
      BorderStyle = bsNone
      ColCount = 12
      Ctl3D = False
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
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goColSizing]
      ParentCtl3D = False
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
      EnhTextSize = False
      EnhRowColMove = False
      SizeWithForm = False
      Multilinecells = False
      OnRowChanging = gridRowChanging
      OnDblClickCell = gridDblClickCell
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
      FloatFormat = '%.0n'
      IntegralHeight = False
      WordWrap = True
      ColumnHeaders.Strings = (
        'NO'
        'KODE'
        'NAMA'
        'ALAMAT'
        'KOTA'
        'PHONE'
        'PHONE 2')
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
        112
        119
        208
        64
        64
        64
        64
        64
        64
        64)
    end
  end
  object suiPanel1: TsuiPanel
    Left = 0
    Top = 41
    Width = 717
    Height = 55
    UIStyle = DeepBlue
    BorderColor = clBlack
    Caption = 'Filter'
    ShowButton = True
    CaptionFontColor = clWhite
    Align = alTop
    TabOrder = 2
    Color = clSilver
    object txtNama: TAdvEdit
      Left = 59
      Top = 27
      Width = 170
      Height = 21
      AutoFocus = False
      EditAlign = eaLeft
      EditType = etString
      EmptyText = 'Nama member'
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
      TabOrder = 0
      Text = 'txtNama'
      Transparent = False
      Visible = True
      OnKeyDown = txtKodeKeyDown
    end
    object txtKota: TAdvEdit
      Left = 275
      Top = 27
      Width = 170
      Height = 21
      AutoFocus = False
      EditAlign = eaLeft
      EditType = etString
      EmptyText = 'Kota member'
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
      TabOrder = 1
      Transparent = False
      Visible = False
      OnKeyDown = txtKodeKeyDown
    end
  end
  object WinXP1: TWinXP
    Left = 448
    Top = 16
  end
  object PopupMenu1: TPopupMenu
    Left = 544
    Top = 32
    object Aktivasi1: TMenuItem
      Caption = 'Aktivasi'
      OnClick = Aktivasi1Click
    end
  end
end
