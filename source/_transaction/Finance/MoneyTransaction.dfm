object frmMoneyTransaction: TfrmMoneyTransaction
  Left = 230
  Top = 196
  Width = 623
  Height = 368
  Caption = 'frmMoneyTransaction'
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
    Width = 615
    Height = 40
    ButtonHeight = 36
    ButtonWidth = 32
    Caption = 'ToolBar1'
    Color = clWhite
    Customizable = True
    EdgeBorders = [ebBottom]
    Flat = True
    Images = frmMainMenu.SmallImageList
    ParentColor = False
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
      Caption = 'New'
      ImageIndex = 0
      OnClick = tbtNewClick
    end
    object tbtSave: TToolButton
      Tag = -11
      Left = 32
      Top = 0
      Hint = 'Save Data [Ctrl+S]'
      Caption = 'Save'
      ImageIndex = 1
      OnClick = tbtSaveClick
    end
    object ToolButton5: TToolButton
      Left = 64
      Top = 0
      Width = 6
      Caption = 'ToolButton5'
      Style = tbsDivider
    end
    object ToolButton2: TToolButton
      Left = 70
      Top = 0
      Width = 6
      Caption = 'ToolButton2'
      ImageIndex = 4
      Style = tbsSeparator
    end
    object ToolButton1: TToolButton
      Left = 76
      Top = 0
      Caption = 'Print'
      ImageIndex = 3
      Visible = False
    end
  end
  object suiPanel1: TsuiPanel
    Left = 0
    Top = 40
    Width = 615
    Height = 294
    UIStyle = DeepBlue
    BorderColor = clBlack
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Caption = 'Header Transaksi [F3]'
    ShowButton = False
    CaptionFontColor = clWhite
    Align = alClient
    TabOrder = 1
    Color = clWhite
    PopupMenu = frmMainMenu.MenuShortCut
    DesignSize = (
      615
      294)
    object lblTransaksi: TLabel
      Left = 552
      Top = 2
      Width = 60
      Height = 14
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Caption = 'lblTransaksi'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Label1: TLabel
      Left = 477
      Top = 30
      Width = 45
      Height = 13
      Anchors = [akTop, akRight]
      Caption = 'Tanggal :'
    end
    object Label2: TLabel
      Left = 6
      Top = 76
      Width = 82
      Height = 13
      Caption = 'Detail Transaksi :'
    end
    object Label3: TLabel
      Left = 6
      Top = 224
      Width = 63
      Height = 13
      Anchors = [akLeft, akBottom]
      Caption = 'Keterangan :'
    end
    object dtpTransaction: TDateTimePicker
      Left = 522
      Top = 27
      Width = 88
      Height = 21
      Anchors = [akTop, akRight]
      CalAlignment = dtaLeft
      Date = 38825.3586227083
      Time = 38825.3586227083
      DateFormat = dfShort
      DateMode = dmComboBox
      Kind = dtkDate
      ParseInput = False
      TabOrder = 0
      TabStop = False
    end
    object grid: TAdvStringGrid
      Left = 5
      Top = 96
      Width = 605
      Height = 126
      Cursor = crDefault
      Anchors = [akLeft, akTop, akRight, akBottom]
      ColCount = 9
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
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goColSizing, goEditing]
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 1
      OnKeyDown = gridKeyDown
      OnKeyPress = gridKeyPress
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
      OnCanEditCell = gridCanEditCell
      OnCellValidate = gridCellValidate
      OnGetEditorType = gridGetEditorType
      OnComboChange = gridComboChange
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
      Navigation.AllowInsertRow = True
      Navigation.AdvanceOnEnter = True
      Navigation.AdvanceInsert = True
      Navigation.AdvanceDirection = adLeftRight
      Navigation.AllowClipboardRowGrow = True
      Navigation.AllowClipboardColGrow = True
      Navigation.AdvanceAuto = True
      Navigation.InsertPosition = pInsertAfter
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
      FloatFormat = '%.2f'
      IntegralHeight = False
      WordWrap = False
      ColumnHeaders.Strings = (
        ''
        'Akun'
        'Deskripsi'
        '   Jumlah')
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
        7
        6
        205)
    end
    object txtNote: TMemo
      Left = 5
      Top = 244
      Width = 351
      Height = 43
      Anchors = [akLeft, akRight, akBottom]
      BevelInner = bvNone
      BevelKind = bkFlat
      BorderStyle = bsNone
      Lines.Strings = (
        'Memo1')
      TabOrder = 2
    end
    object txtSubtotal: TAdvEdit
      Left = 457
      Top = 227
      Width = 150
      Height = 24
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
      ReturnIsTab = True
      LengthLimit = 0
      TabOnFullLength = False
      Precision = 0
      LabelCaption = 'Total :'
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
      Anchors = [akRight, akBottom]
      Color = clWindow
      Enabled = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      HintShowLargeText = False
      ParentFont = False
      OleDropTarget = False
      OleDropSource = False
      ReadOnly = True
      Signed = False
      TabOrder = 3
      Transparent = False
      Visible = True
    end
    object rgTipe: TRadioGroup
      Left = 8
      Top = 24
      Width = 204
      Height = 43
      Caption = 'Tipe Transaksi'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Penerimaan'
        'Pengeluaran')
      TabOrder = 4
      OnClick = rgTipeClick
    end
  end
end
