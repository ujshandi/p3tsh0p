object frmTrsItemShipment: TfrmTrsItemShipment
  Left = 321
  Top = -8
  Width = 769
  Height = 419
  Caption = 'frmTrsItemShipment'
  Color = clWhite
  DragKind = dkDock
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PopupMenu = frmMainMenu.MenuShortCut
  OnClose = FormClose
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object suiPanel1: TsuiPanel
    Left = 0
    Top = 40
    Width = 761
    Height = 156
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
    Align = alTop
    TabOrder = 0
    Color = clWhite
    PopupMenu = frmMainMenu.MenuShortCut
    DesignSize = (
      761
      156)
    object lblTransaksi: TLabel
      Left = 698
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
    object lblGudang: TLabel
      Left = 29
      Top = 51
      Width = 44
      Height = 13
      Alignment = taRightJustify
      Caption = 'Gudang :'
    end
    object Label2: TLabel
      Left = 177
      Top = 171
      Width = 80
      Height = 13
      Alignment = taRightJustify
      Caption = 'Gudang Tujuan :'
      Visible = False
    end
    object Label3: TLabel
      Left = 33
      Top = 30
      Width = 40
      Height = 13
      Caption = 'Tgl Trx :'
    end
    object Bevel1: TBevel
      Left = 480
      Top = 27
      Width = 9
      Height = 120
      Anchors = [akTop, akRight]
      Shape = bsLeftLine
    end
    object Label4: TLabel
      Left = 10
      Top = 75
      Width = 63
      Height = 13
      Alignment = taRightJustify
      Caption = 'Keterangan :'
    end
    object imgLogo: TImage
      Left = 16
      Top = 110
      Width = 146
      Height = 46
      AutoSize = True
      Picture.Data = {
        07544269746D61701E0E0000424D1E0E00000000000076000000280000009200
        00002E0000000100040000000000A80D0000C40E0000C40E0000100000000000
        0000000000000000800000800000008080008000000080008000808000008080
        8000C0C0C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFF
        FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FF87777777777777777777777777
        7777777777777777777777777777777777777777777777777777777777777777
        77777777777777777777777777777777777888FFFFFFFFFFFFFFFF000000FF88
        8888888888888888888888888888888888888888888888888888888888888888
        8888888888888888888888888888888888888888888888888888887777770007
        78FFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFF8770078FFFFFFFFF000000FFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFF8778FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFF8FFFFFFFFFFFFFFFFFFFF87078FFFFFFF00
        0000FFFFF7777FFF7FFFF778FFF777FFF7F888FFF88FF7F88FF8777FFFFFFF87
        77FFFFFFFF7778FF88FF88FFF7F7FFF7FFF877FFFFFFFFFFFFFF800778FFFFFF
        FFFFFFFFFFFFF707FFFFFF000000FFFF87F87FFF7FFF87F78F87F78FF7F8878F
        F78FF7F87FF7887FFFFFFF7877FFFFFFF87F88FF87FF87FF87F7FFF7FF87F8FF
        FFFFFFFFFFFFFF88707FFFFFFFFFFFFFFFFFFFF77FFFFF000000FFFF78F77FFF
        78FF8787FFF7878FF787778FF78FF7878FF7877FFFFFFF8078FFFFFFF78FFFFF
        87FF87FF8787FFF7FFF788FFFFFFFFFFF87FFFFFFF708FFFFFFFFFFFFFFFFFFF
        08FFFF000000FFFF87FF8FFF88FFF878FFF878FFF87888FFF88FF878FFFF878F
        FFFFFF877FFFFFFFF87F88FF87FFF8FFF778FFF8FFF878FFFFFFFFFFFF08F8FF
        FFF88FFFFFFF7FFFFFFF78FF77FFFF000000FFFFF7778FFFFFFFFFFFFFFFFFFF
        FFFFFFFFF88FFFFFFFFFFFFFFFFFFF877FFFFFFFFF7778FF88FFF8FFFFFFFFF7
        FFFFFFFFFFFFFFFFFF77F78FFFFFFFFFFFFF77FFFFF808FF78FFFF000000FFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF87F78FFFFFFFFFFFFFF08F
        87707FF77FFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFF8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FF87878FFFFFFFFFFFFFF77F888FF877FFFFFF000000FFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFF78FFFFFFFFFFFFFFFF87878FFFFFFFFFFFFFFF087077007FFFFFFF00
        0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF78FFFFFFFFFFFFFFF877878FFFFFFFFF
        FFFFFF77F8888FFFFFFFFF000000FFFF878F877FFFF8878FFFFFFFFFFF8778FF
        FFF8FFFF8FFF8FFFFF80F878FFFF778FF88FFF878FF8FFF8FF877FFF78878FFF
        FFFFFFFF7777F77FFFFFFFFFFFFFFF80FFFFFFFFFFFFFF000000FFF7077F7008
        FFF0878FFFFF77FFF778807FFFF7FFF708F80FFFFF8070708F807708F77FF77F
        08F7FFF7F70777FF070707FFFFFFFFF80877F80FFFFFFFFFFFFFFFF78FFFFFFF
        FFFFFF000000FFF88F788008FF80F78FFFF807FF70FFF708FF87FF808FF80FFF
        FF707FF80F77FF88F77FF8FF08F7FF87808FF77F07FF808FFFFFFFF77F77FF77
        FFFFFFFFFFFFFFF77FFFFFFFFFFFFF000000FFFFFF78F0088877F78FFF8007F8
        07FFFF07FF87F807FFF70FFFFF708FFF08077788F77FFFF77F87FF8777FFF878
        08FFF77FFFFFFF87FFFFFFF078FF87FFFFFFFFF77FFFFFFFFFFFFF000000FFFF
        FF08F0077708F78FFF7007F707FFFF70FF87F77FFFF70FFFFF708FF808778877
        F77FFF77FF80FF87808FF77808FFF77FFFFFFF77FFFFFFFF707707FFFFFFFFF7
        7FFFFFFFFFFFFF000000FFFFFF08F77FFF0FF77FF70707F007FF7700FF7077FF
        FFF70FFFFF0078877F77F808F07FF70F88807877F00770870078708FFFFFFF0F
        FFFFFFFFFF88FFFFFFFFFFF77FFFFFFFFFFFFF000000FFFFF808F70FF87FF77F
        807F77F007FF8888FF707FFFFFF70FFFFF0070078FF777787078F87778777008
        F87007F7070008FFFFFFF87FFFFFFFFFFFFFFFFFFFFFFFF77FFFFFFFFFFFFF00
        0000FFFFF808F808F77FF78800FF77F007FFFFFFFF707FFFFFF00FFFFF8FFFFF
        FFFFFFFF807FFFF8FF77F88FFFFFFFF88FFFFFFFFFFFF77FFFFFFFFFFFFFFFFF
        FFFFFFF08FFFFFFFFFFFFF000000FFFFF708FF77F78FF7700FFF77F707FFFFFF
        FF7077FFFFF00FFFFFFFFFFFFFFFFFFF807FFFFFFF77FFFFFFFFFFFFFFFFFFFF
        FFFFF77FFFFFFFFFFFFFFFFFFFFFFF80FFFFFFFFFFFFFF000000FFFFF708FF80
        87FFF700FFFF77F807FFFF8FFF70F77FFF800FFFFFFFFFFFFFFFFFFF707FFFFF
        FF77FFFFFFFFFFFFFFFFFFFFFFFFF77FFFFFFFFFFFFFFFFFFFFFFF77FFFFFFFF
        FFFFFF000000FFFFF708FFF008FFF70FFFFF77FF708FF808FF00FF07FF800FFF
        FFFFFFFFFFFFFFFF88FFFFFFFF07FFFFFFFFFFFFFFFFFFFFFFFFF77FFFFFFFFF
        FFFFFFFFFFFFF70FFFFFFFFFFFFFFF000000FFFFF008FFF80FFFF78FFFFF77FF
        F7077078FF00FFF07F800FFFFFFFFFFFFFFFFFFFFFFFFFFFFF07FFFFFFFFFFFF
        FFFFFFFFFFFFF77FFFFFFFFFFFFFFFFFFFFF808FFFFFFFFFFFFFFF000000FFFF
        F78FFFFF8FFFFFFFFFFFF8FFFFF888FFFF88FFFF8F878FFFFFFFFFFFFFFFFFFF
        FFFFFFFFFF8FFFFFFFFFFFFFFFFFFFFFFFFFF77FFFFFFFFFFFFFFFFFFFFF77FF
        FFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF778
        78FFFF87FFFFFFFFFF807FFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFF80F707F7707FFFFFFFFF807FFFFFFFFFFFFFFFFFF00
        0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF08700870078FFFFFF8
        708FFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFF77877F8778FFFFF8707FFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF88FFFFFFFF8077077FFFFFFFFFFFFFFFFF
        FFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF88FFFFFFF
        F888FFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFF778FFFFF78FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8780FFFF877FFFFFFFFFFFFFFF
        FFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF87
        77FFFF7778FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFF77FFFFF8008FFFFFFFFFFFFFFFFFFFFFFFFFFFF00
        0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8FFFFFFF
        FFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFF000000}
      Visible = False
    end
    object dtpTransaction: TDateTimePicker
      Left = 77
      Top = 26
      Width = 88
      Height = 21
      CalAlignment = dtaLeft
      Date = 38825.3586227083
      Time = 38825.3586227083
      DateFormat = dfShort
      DateMode = dmComboBox
      Kind = dtkDate
      ParseInput = False
      TabOrder = 0
      OnChange = dtpTransactionChange
      OnKeyDown = dtpTransactionKeyDown
    end
    object cmbAsal: TComboBox
      Left = 77
      Top = 51
      Width = 188
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 1
      OnChange = cmbAsalChange
      OnKeyDown = dtpTransactionKeyDown
    end
    object txtSpec: TAdvEdit
      Left = 553
      Top = 27
      Width = 200
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
      LabelCaption = 'Jenis :'
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
      Anchors = [akTop, akRight]
      Color = clWindow
      Enabled = True
      HintShowLargeText = False
      OleDropTarget = False
      OleDropSource = False
      ReadOnly = True
      Signed = False
      TabOrder = 3
      Transparent = False
      Visible = True
      OnKeyDown = txtSpecKeyDown
    end
    object txtNama: TAdvEdit
      Left = 553
      Top = 50
      Width = 200
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
      Anchors = [akTop, akRight]
      Color = clWindow
      Enabled = True
      HintShowLargeText = False
      OleDropTarget = False
      OleDropSource = False
      Signed = False
      TabOrder = 4
      Text = 'txtNama'
      Transparent = False
      Visible = True
    end
    object txtMerk: TAdvEdit
      Left = 553
      Top = 98
      Width = 200
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
      Anchors = [akTop, akRight]
      Color = clWindow
      Enabled = True
      HintShowLargeText = False
      OleDropTarget = False
      OleDropSource = False
      Signed = False
      TabOrder = 6
      Text = 'txtMerk'
      Transparent = False
      Visible = True
    end
    object txtCode: TAdvEdit
      Left = 553
      Top = 74
      Width = 200
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
      Anchors = [akTop, akRight]
      Color = clWindow
      Enabled = True
      HintShowLargeText = False
      OleDropTarget = False
      OleDropSource = False
      Signed = False
      TabOrder = 5
      Text = 'txtNama'
      Transparent = False
      Visible = True
    end
    object btnLoad: TButton
      Left = 678
      Top = 124
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Load'
      TabOrder = 7
      OnClick = btnLoadClick
    end
    object btnSpec: TButton
      Left = 735
      Top = 30
      Width = 16
      Height = 16
      Anchors = [akTop, akRight]
      Caption = '...'
      TabOrder = 8
      TabStop = False
      OnClick = btnSpecClick
    end
    object txtNote: TMemo
      Left = 77
      Top = 76
      Width = 396
      Height = 72
      Anchors = [akLeft, akTop, akRight]
      Lines.Strings = (
        'txtNote')
      TabOrder = 2
      WantReturns = False
      OnKeyDown = dtpTransactionKeyDown
    end
    object rgbJenis: TRadioGroup
      Left = 277
      Top = 39
      Width = 196
      Height = 33
      Caption = 'Jenis Mutasi '
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Masuk'
        'Keluar')
      TabOrder = 9
      OnClick = rgbJenisClick
    end
  end
  object suiPanel3: TsuiPanel
    Left = 0
    Top = 196
    Width = 761
    Height = 189
    UIStyle = DeepBlue
    BorderColor = clBlack
    Caption = 'Detail Entry Barang [F4]'
    ShowButton = False
    CaptionFontColor = clWhite
    Align = alClient
    TabOrder = 1
    Color = clSilver
    PopupMenu = frmMainMenu.MenuShortCut
    DesignSize = (
      761
      189)
    object Button2: TButton
      Left = 710
      Top = 52
      Width = 16
      Height = 17
      Caption = '...'
      TabOrder = 2
      Visible = False
      OnClick = Button2Click
    end
    object txtVc: TAdvEdit
      Left = 617
      Top = 50
      Width = 56
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
      TabOrder = 1
      Text = 'txtSpec'
      Transparent = False
      Visible = False
    end
    object grid: TAdvStringGrid
      Left = 4
      Top = 24
      Width = 753
      Height = 132
      Cursor = crDefault
      Anchors = [akLeft, akTop, akRight, akBottom]
      ColCount = 15
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
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goRangeSelect, goDrawFocusSelected, goColSizing, goEditing]
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 0
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
      Bands.Active = True
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
      OnGetCellColor = gridGetCellColor
      OnGetAlignment = gridGetAlignment
      OnCanEditCell = gridCanEditCell
      OnCellValidate = gridCellValidate
      OnGetEditorType = gridGetEditorType
      DragDropSettings.OleAcceptFiles = True
      DragDropSettings.OleAcceptText = True
      SortSettings.AutoColumnMerge = False
      SortSettings.Column = 1
      SortSettings.Show = False
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
      ControlLook.ControlStyle = csClassic
      ControlLook.FlatButton = False
      EnableBlink = False
      EnableHTML = True
      EnableWheel = True
      ExcelStyleDecimalSeparator = True
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
      Navigation.AdvanceOnEnter = True
      Navigation.AdvanceInsert = True
      Navigation.AdvanceDirection = adLeftRight
      Navigation.AllowClipboardRowGrow = True
      Navigation.AllowClipboardColGrow = True
      Navigation.AdvanceAuto = True
      Navigation.InsertPosition = pInsertBefore
      Navigation.CopyHTMLTagsToClipboard = True
      Navigation.HomeEndKey = heFirstLastColumn
      ColumnSize.Stretch = True
      ColumnSize.Location = clRegistry
      CellNode.Color = clSilver
      CellNode.NodeColor = clBlack
      CellNode.ShowTree = False
      SizeWhileTyping.Width = True
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
        '#'
        'Kode'
        'Barcode'
        'Desc'
        'Merk'
        'Unit'
        'On Hand'
        'Qty'
        'Selisih'
        'Hrg Beli'
        'Hrg Jual'
        'Markup(%)'
        'Slisih Hide'
        'Jumlah')
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
        69
        53
        68
        70
        64
        52
        64
        64
        64
        64
        525
        64)
    end
    object txtTotal: TAdvEdit
      Left = 604
      Top = 159
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
      LabelFont.Height = -13
      LabelFont.Name = 'Tahoma'
      LabelFont.Style = []
      Persistence.Enable = False
      Persistence.Location = plInifile
      Anchors = [akRight, akBottom]
      Color = clWindow
      Enabled = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
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
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 761
    Height = 40
    ButtonHeight = 36
    ButtonWidth = 38
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
      Caption = '&New'
      ImageIndex = 0
      OnClick = tbtNewClick
    end
    object tbtSave: TToolButton
      Tag = -11
      Left = 38
      Top = 0
      Hint = 'Save Data [Ctrl+S]'
      Caption = '&Save'
      ImageIndex = 1
      OnClick = tbtSaveClick
    end
    object ToolButton5: TToolButton
      Left = 76
      Top = 0
      Width = 7
      Caption = 'ToolButton5'
      Style = tbsDivider
    end
    object tbtDelete: TToolButton
      Tag = -12
      Left = 83
      Top = 0
      Caption = 'Delete'
      ImageIndex = 2
      OnClick = tbtDeleteClick
    end
    object tbtPrint: TToolButton
      Left = 121
      Top = 0
      Caption = 'Print'
      ImageIndex = 8
      OnClick = tbtPrintClick
    end
  end
  object WinXP1: TWinXP
    Left = 480
  end
  object PopupMenu1: TPopupMenu
    Left = 424
    Top = 8
    object f1: TMenuItem
      Caption = 'Draft Stok Opname'
      OnClick = f1Click
    end
    object f2: TMenuItem
      Caption = 'Hasil Stok Opname'
      OnClick = f2Click
    end
  end
  object RAWPrinter1: TRAWPrinter
    Left = 536
  end
end
