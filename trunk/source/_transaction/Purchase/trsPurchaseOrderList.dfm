object frmTrsPurchaseOrderList: TfrmTrsPurchaseOrderList
  Tag = -1
  Left = 176
  Top = 202
  Width = 822
  Height = 404
  Caption = 'frmTrsPurchaseOrderList'
  Color = clWhite
  DragKind = dkDock
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  PopupMenu = frmMainMenu.MenuShortCut
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object ToolBar1: TToolBar
    Tag = -20
    Left = 0
    Top = 0
    Width = 814
    Height = 41
    ButtonHeight = 36
    ButtonWidth = 60
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
      Left = 60
      Top = 0
      Hint = 'Detai [Ctrl+S]'
      Caption = 'Detail'
      ImageIndex = 16
      OnClick = tbtDetailClick
    end
    object ToolButton4: TToolButton
      Left = 120
      Top = 0
      Width = 8
      Caption = 'ToolButton4'
      ImageIndex = 12
      Style = tbsSeparator
    end
    object ToolButton5: TToolButton
      Left = 128
      Top = 0
      Caption = 'Reset Filter'
      ImageIndex = 3
      OnClick = ToolButton5Click
    end
    object tbtRefresh: TToolButton
      Tag = -19
      Left = 188
      Top = 0
      Hint = 'Refresh [Ctrl+L]'
      Caption = 'Load Data'
      ImageIndex = 6
      OnClick = tbtRefreshClick
    end
    object tbtPrint: TToolButton
      Tag = -14
      Left = 248
      Top = 0
      Caption = 'Print'
      ImageIndex = 8
      OnClick = tbtPrintClick
    end
    object ToolButton1: TToolButton
      Left = 308
      Top = 0
      Width = 8
      Caption = 'ToolButton1'
      ImageIndex = 9
      Style = tbsSeparator
    end
    object ttDelete: TToolButton
      Left = 316
      Top = 0
      Caption = 'Delete'
      ImageIndex = 2
      OnClick = ttDeleteClick
    end
  end
  object suiPanel1: TsuiPanel
    Left = 0
    Top = 41
    Width = 814
    Height = 80
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
      Left = 11
      Top = 24
      Width = 38
      Height = 13
      Caption = 'Tgl trx :'
    end
    object Label1: TLabel
      Left = 15
      Top = 48
      Width = 81
      Height = 13
      Caption = 'Sampai Dengan :'
    end
    object Label3: TLabel
      Left = 320
      Top = 64
      Width = 46
      Height = 13
      Alignment = taRightJustify
      Caption = 'Tgl Kirim :'
      Visible = False
    end
    object Label4: TLabel
      Left = 330
      Top = 88
      Width = 81
      Height = 13
      Caption = 'Sampai Dengan :'
      Visible = False
    end
    object Label5: TLabel
      Left = 529
      Top = 32
      Width = 31
      Height = 13
      Caption = 'Jenis :'
      Visible = False
    end
    object Label6: TLabel
      Left = 406
      Top = 48
      Width = 38
      Height = 13
      Caption = 'Status :'
    end
    object Label7: TLabel
      Left = 685
      Top = 24
      Width = 35
      Height = 13
      Caption = 'Bayar :'
      Visible = False
    end
    object Label8: TLabel
      Left = 403
      Top = 24
      Width = 41
      Height = 13
      Caption = 'Format :'
      Visible = False
    end
    object dtpAkhir: TDateTimePicker
      Left = 99
      Top = 48
      Width = 80
      Height = 21
      CalAlignment = dtaLeft
      Date = 39083.7426842477
      Time = 39083.7426842477
      DateFormat = dfShort
      DateMode = dmComboBox
      Kind = dtkDate
      ParseInput = False
      TabOrder = 2
    end
    object dtpAwal: TDateTimePicker
      Left = 99
      Top = 24
      Width = 80
      Height = 21
      CalAlignment = dtaLeft
      Date = 39083.7426506366
      Time = 39083.7426506366
      DateFormat = dfShort
      DateMode = dmComboBox
      Kind = dtkDate
      ParseInput = False
      TabOrder = 1
    end
    object cmbOpr: TComboBox
      Left = 53
      Top = 24
      Width = 43
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 0
      OnChange = cmbOprChange
      Items.Strings = (
        ' '
        '='
        ' >='
        ' <='
        'Dari')
    end
    object txtSpec: TAdvEdit
      Left = 242
      Top = 24
      Width = 150
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
      LabelCaption = 'Jenis Brg :'
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
      TabOrder = 6
      Text = 'txtSpec'
      Transparent = False
      Visible = True
    end
    object btnSpec: TButton
      Left = 374
      Top = 26
      Width = 16
      Height = 17
      Caption = '...'
      TabOrder = 7
      OnClick = btnSpecClick
    end
    object txtVendor: TAdvEdit
      Left = 242
      Top = 48
      Width = 150
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
      HintShowLargeText = False
      OleDropTarget = False
      OleDropSource = False
      Signed = False
      TabOrder = 8
      Text = 'txtSpec'
      Transparent = False
      Visible = True
    end
    object Button1: TButton
      Left = 374
      Top = 50
      Width = 16
      Height = 17
      Caption = '...'
      TabOrder = 9
      OnClick = Button1Click
    end
    object cmbStatus: TComboBox
      Left = 446
      Top = 48
      Width = 65
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 11
      OnChange = cmbStatusChange
      Items.Strings = (
        'Semua'
        'Unpost'
        'Posted')
    end
    object dtpAkhir2: TDateTimePicker
      Left = 414
      Top = 88
      Width = 80
      Height = 21
      CalAlignment = dtaLeft
      Date = 39083.7426842477
      Time = 39083.7426842477
      DateFormat = dfShort
      DateMode = dmComboBox
      Kind = dtkDate
      ParseInput = False
      TabOrder = 5
      Visible = False
    end
    object dtpAwal2: TDateTimePicker
      Left = 414
      Top = 64
      Width = 80
      Height = 21
      CalAlignment = dtaLeft
      Date = 39083.7426506366
      Time = 39083.7426506366
      DateFormat = dfShort
      DateMode = dmComboBox
      Kind = dtkDate
      ParseInput = False
      TabOrder = 4
      Visible = False
    end
    object cmbOpr2: TComboBox
      Left = 368
      Top = 64
      Width = 43
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 3
      Visible = False
      OnChange = cmbOpr2Change
      Items.Strings = (
        ''
        ' ='
        ' >='
        ' <='
        'Dari')
    end
    object cmbJensi: TComboBox
      Left = 562
      Top = 32
      Width = 65
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 2
      TabOrder = 10
      Text = 'Non PKP'
      Visible = False
      OnChange = cmbJensiChange
      Items.Strings = (
        'Semua'
        'PKP'
        'Non PKP')
    end
    object cmbBayar: TComboBox
      Left = 723
      Top = 24
      Width = 85
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 1
      TabOrder = 12
      Text = 'BLM LUNAS'
      Visible = False
      OnChange = cmbBayarChange
      Items.Strings = (
        'Semua'
        'BLM LUNAS'
        'LUNAS')
    end
    object cmbFormat: TComboBox
      Left = 447
      Top = 24
      Width = 85
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 13
      Text = 'STD'
      Visible = False
      OnChange = cmbBayarChange
      Items.Strings = (
        'STD'
        'DETAIL')
    end
  end
  object suiPanel2: TsuiPanel
    Left = 0
    Top = 121
    Width = 814
    Height = 249
    UIStyle = DeepBlue
    BorderColor = clBlack
    Caption = 'Data List'
    ShowButton = False
    CaptionFontColor = clWhite
    Align = alClient
    TabOrder = 2
    Color = clWhite
    object grid: TAdvStringGrid
      Left = 4
      Top = 24
      Width = 806
      Height = 221
      Cursor = crDefault
      Align = alClient
      ColCount = 13
      Ctl3D = False
      DefaultRowHeight = 21
      DefaultDrawing = False
      FixedCols = 1
      RowCount = 3
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
      OnGetAlignment = gridGetAlignment
      OnDblClickCell = gridDblClickCell
      DragDropSettings.OleAcceptFiles = True
      DragDropSettings.OleAcceptText = True
      SortSettings.AutoColumnMerge = False
      SortSettings.Column = 2
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
      FloatingFooter.Visible = True
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
      FixedFooters = 1
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
        'No'
        'Tanggal'
        'No Transaksi'
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
        64
        64
        64
        64
        64
        64
        64
        43
        22
        11
        151)
      RowHeights = (
        21
        21
        21)
    end
  end
  object WinXP1: TWinXP
    Left = 528
    Top = 24
  end
end
