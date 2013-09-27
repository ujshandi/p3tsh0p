object frmTrsSales: TfrmTrsSales
  Tag = 3100001
  Left = 58
  Top = 99
  Width = 771
  Height = 538
  Caption = 'frmTrsSales'
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 763
    Height = 46
    ButtonHeight = 44
    ButtonWidth = 75
    Caption = 'ToolBar1'
    Customizable = True
    EdgeBorders = [ebBottom]
    Flat = True
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Images = frmMainMenu.ImageList1
    ParentFont = False
    ParentShowHint = False
    ShowCaptions = True
    ShowHint = True
    TabOrder = 0
    Transparent = True
    object ToolButton13: TToolButton
      Left = 0
      Top = 0
      Caption = 'Help [F1]'
      ImageIndex = 8
      OnClick = ToolButton13Click
    end
    object ToolButton6: TToolButton
      Left = 75
      Top = 0
      Width = 4
      Caption = 'ToolButton6'
      ImageIndex = 7
      Style = tbsSeparator
    end
    object tbtHold: TToolButton
      Left = 79
      Top = 0
      Caption = 'Hold [Alt+H]'
      ImageIndex = 3
      OnClick = tbtHoldClick
    end
    object tbtRecall: TToolButton
      Left = 154
      Top = 0
      Caption = 'Recall [Alt+C]'
      ImageIndex = 4
      OnClick = tbtRecallClick
    end
    object ToolButton9: TToolButton
      Left = 229
      Top = 0
      Width = 4
      Caption = 'ToolButton9'
      ImageIndex = 11
      Style = tbsSeparator
    end
    object tbtReport: TToolButton
      Left = 233
      Top = 0
      Caption = 'Report [Alt+R]'
      ImageIndex = 0
      OnClick = tbtReportClick
    end
    object ToolButton10: TToolButton
      Left = 308
      Top = 0
      Width = 4
      Caption = 'ToolButton10'
      ImageIndex = 11
      Style = tbsSeparator
    end
    object tbtOption: TToolButton
      Left = 312
      Top = 0
      Caption = 'Option [Alt+T]'
      ImageIndex = 5
      OnClick = tbtOptionClick
    end
    object tbtOpen: TToolButton
      Left = 387
      Top = 0
      Caption = 'Open [Alt+O]'
      ImageIndex = 9
      OnClick = tbtOpenClick
    end
    object ToolButton11: TToolButton
      Left = 462
      Top = 0
      Width = 4
      Caption = 'ToolButton11'
      ImageIndex = 12
      Style = tbsSeparator
    end
    object tbtLogOff: TToolButton
      Left = 466
      Top = 0
      Caption = 'Log Off [Alt+L]'
      ImageIndex = 7
      OnClick = tbtLogOffClick
    end
    object tbtExit: TToolButton
      Left = 541
      Top = 0
      Caption = 'Exit [Alt+X]'
      ImageIndex = 6
      OnClick = tbtExitClick
    end
  end
  object suiPanel3: TsuiPanel
    Left = 583
    Top = 46
    Width = 180
    Height = 458
    UIStyle = DeepBlue
    BorderColor = clWhite
    ShowButton = False
    CaptionFontColor = clWhite
    Align = alRight
    TabOrder = 1
    Color = clWhite
    DesignSize = (
      180
      458)
    object imgCashierRight: TImage
      Left = 4
      Top = 24
      Width = 172
      Height = 430
      Align = alClient
      Stretch = True
    end
    object Bevel1: TBevel
      Left = 10
      Top = 211
      Width = 160
      Height = 25
      Anchors = [akRight, akBottom]
    end
    object Bevel2: TBevel
      Left = 10
      Top = 259
      Width = 160
      Height = 25
      Anchors = [akRight, akBottom]
    end
    object Bevel3: TBevel
      Left = 10
      Top = 307
      Width = 160
      Height = 25
      Anchors = [akRight, akBottom]
    end
    object Bevel4: TBevel
      Left = 10
      Top = 355
      Width = 160
      Height = 25
      Anchors = [akRight, akBottom]
    end
    object lblTransaksi: TLabel
      Left = 78
      Top = 2
      Width = 99
      Height = 14
      Alignment = taRightJustify
      Caption = '[Nomor Transaksi]'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object lblQty: TLabel
      Left = 113
      Top = 44
      Width = 63
      Height = 16
      Alignment = taRightJustify
      Caption = '10 - Item'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object lblCustomer: TLabel
      Left = 91
      Top = 27
      Width = 85
      Height = 16
      Alignment = taRightJustify
      Caption = 'Customer #1'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object lblTotal: TLabel
      Left = 37
      Top = 157
      Width = 135
      Height = 33
      Alignment = taRightJustify
      Anchors = [akRight, akBottom]
      Caption = '3.000.000'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -27
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object lblCasierUser: TLabel
      Left = 133
      Top = 432
      Width = 38
      Height = 16
      Alignment = taRightJustify
      Anchors = [akRight, akBottom]
      Caption = '[Kasir]'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Transparent = True
      OnClick = lblCasierUserClick
    end
    object lblSubTotal: TLabel
      Left = 77
      Top = 216
      Width = 90
      Height = 18
      Alignment = taRightJustify
      Anchors = [akRight, akBottom]
      Caption = '3.000.000'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Courier New'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label1: TLabel
      Left = 11
      Top = 195
      Width = 64
      Height = 16
      Anchors = [akRight, akBottom]
      Caption = 'Subtotal :'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object lblDiscRp: TLabel
      Left = 77
      Top = 264
      Width = 90
      Height = 18
      Alignment = taRightJustify
      Anchors = [akRight, akBottom]
      Caption = '3.000.000'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Courier New'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label3: TLabel
      Left = 11
      Top = 243
      Width = 68
      Height = 16
      Anchors = [akRight, akBottom]
      Caption = 'Disc (Rp) :'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object lblDisc: TLabel
      Left = 77
      Top = 312
      Width = 90
      Height = 18
      Alignment = taRightJustify
      Anchors = [akRight, akBottom]
      Caption = '3.000.000'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Courier New'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object lblTax: TLabel
      Left = 77
      Top = 360
      Width = 90
      Height = 18
      Alignment = taRightJustify
      Anchors = [akRight, akBottom]
      Caption = '3.000.000'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Courier New'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label6: TLabel
      Left = 11
      Top = 339
      Width = 33
      Height = 16
      Anchors = [akRight, akBottom]
      Caption = 'PPN :'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label7: TLabel
      Left = 11
      Top = 291
      Width = 65
      Height = 16
      Anchors = [akRight, akBottom]
      Caption = 'Disc (%) :'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Bevel5: TBevel
      Left = 10
      Top = 403
      Width = 160
      Height = 25
      Anchors = [akRight, akBottom]
    end
    object lblGrangTotal: TLabel
      Left = 77
      Top = 408
      Width = 90
      Height = 18
      Alignment = taRightJustify
      Anchors = [akRight, akBottom]
      Caption = '3.000.000'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Courier New'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label9: TLabel
      Left = 11
      Top = 387
      Width = 41
      Height = 16
      Anchors = [akRight, akBottom]
      Caption = 'Total :'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object lblPoint: TLabel
      Left = 106
      Top = 61
      Width = 70
      Height = 16
      Alignment = taRightJustify
      Caption = '12 - Point'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object lblMember: TLabel
      Left = 6
      Top = 80
      Width = 170
      Height = 35
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Member'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 46
    Width = 583
    Height = 458
    Align = alClient
    BevelOuter = bvNone
    Color = clWhite
    TabOrder = 2
    object suiPanel2: TsuiPanel
      Left = 0
      Top = 0
      Width = 583
      Height = 458
      UIStyle = DeepBlue
      BorderColor = clWhite
      Caption = 'Item List'
      ShowButton = False
      CaptionFontColor = clWhite
      Align = alClient
      TabOrder = 0
      Color = clWhite
      object asgSales: TAdvStringGrid
        Left = 4
        Top = 75
        Width = 575
        Height = 379
        Cursor = crDefault
        TabStop = False
        Align = alClient
        ColCount = 18
        DefaultRowHeight = 26
        DefaultDrawing = False
        FixedCols = 1
        RowCount = 2
        FixedRows = 1
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Arial'
        Font.Style = []
        GridLineWidth = 1
        Options = [goRangeSelect, goDrawFocusSelected, goRowSelect]
        ParentFont = False
        TabOrder = 0
        OnKeyDown = asgSalesKeyDown
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
        AutoSize = True
        VAlignment = vtaCenter
        EnhTextSize = False
        EnhRowColMove = False
        SizeWithForm = False
        Multilinecells = False
        OnGetCellBorder = asgSalesGetCellBorder
        OnGetAlignment = asgSalesGetAlignment
        OnRowChanging = asgSalesRowChanging
        OnClickCell = asgSalesClickCell
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
        ColumnSize.StretchColumn = 2
        ColumnSize.SynchWithGrid = True
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
        FixedColWidth = 82
        FixedRowHeight = 26
        FixedFont.Charset = ANSI_CHARSET
        FixedFont.Color = clWindowText
        FixedFont.Height = -15
        FixedFont.Name = 'Tahoma'
        FixedFont.Style = []
        FixedAsButtons = False
        FloatFormat = '%.0n'
        IntegralHeight = False
        WordWrap = True
        ColumnHeaders.Strings = (
          ''
          'Barcode'
          'Deskripsi'
          'Qty'
          'Qty'
          'Harga'
          'Disc%'
          'DiscRp'
          'Total'
          'Conv'
          'ItemId'
          'ConvId'
          'Dasar'
          'Pofit'
          'Printed')
        Lookup = False
        LookupCaseSensitive = False
        LookupHistory = False
        BackGround.Top = 0
        BackGround.Left = 0
        BackGround.Display = bdTile
        BackGround.Cells = bcNormal
        Filter = <>
        ColWidths = (
          82
          100
          80
          59
          69
          81
          72
          73
          80
          12
          12
          13
          13
          14
          82
          82
          82
          82)
      end
      object Panel2: TPanel
        Left = 4
        Top = 24
        Width = 575
        Height = 51
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        DesignSize = (
          575
          51)
        object Image1: TImage
          Left = 0
          Top = 0
          Width = 55
          Height = 51
          Align = alLeft
          Picture.Data = {
            07544269746D6170F6210000424DF62100000000000036000000280000003C00
            0000300000000100180000000000C0210000120B0000120B0000000000000000
            0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFE
            FEFAFAFAF6F6F6FCFCFCFFFFFFFFFFFFFFFFFFFEFEFEFAFAFAF6F6F6FCFCFCFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFBFBE6E6E6CDCDCDE7E7E7FCFC
            FCFFFFFFFFFFFFFBFBFBE6E6E6CDCDCDE7E7E7FCFCFCFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFDEEDDE92BA92919191B0B0B0E6E6E6FCFCFCFFFFFFDEEDDE92BA
            92919191B0B0B0E6E6E6FCFCFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD9E9D9058005
            6988696F6F6FAFAFAFE5E5E5FBFBFBD9E9D90580056988696F6F6FAFAFAFE5E5
            E5FBFBFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFD9E9D9007D00057F055B775B6E6E6EAEAEAE
            E5E5E5D6E5D6007D00057F055B775B6E6E6EAEAEAEE5E5E5FBFBFBFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFD8E8D8007C0021AB3F057F055B775B6D6D6DAEAEAEC2D0C2007A0021AB3F
            057F055B775B6D6D6DAEAEAEE5E5E5FBFBFBFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD8E8D8007A003AC46920
            A33B0480045A775A6D6D6D939D93006E0039C16720A33B0480045A775A6D6D6D
            ADADADE5E5E5FBFBFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFD8E8D8007B0038C46638B96523A7400482045A785A5B
            625B00520032AE5B37B66323A7400482045A785A6C6C6CABABABE3E3E3FBFBFB
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD8E8
            D8007B0038C46735B86239BA6525AA430582054B734B0034002583452FA45738
            B76325AA43058205597C596B6B6BAAAAAAE3E3E3FBFBFBFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD8E8D8007B0039C56836B96236B9
            6239BC6726AC44038303004E0018522B247B4130A55738B96526AC4403830358
            7C586A6A6AAAAAAAE3E3E3FBFBFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFE
            FEFEFEFEFEFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFD
            FDFDFDFDFDFDD6E8D6007C003BC76937BA6337BA6338BA653CBD6828AD450087
            00146924174E2A247B4232A65A3BBA6628AD45028802587C586B6B6BA9A9A9E3
            E3E3FBFBFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFF9F9F9E5E5E5DBDBDBDBDBDBDBDBDBDBDBDBDCDCDCD7D7D7C6C6C6BDBDBDBD
            BDBDBCBCBCBCBCBCBDBDBDBDBDBDBDBDBDBCBCBCBBBBBBBABABAA1B1A1007B00
            3CC56938B86439BC6539BB6439BB663DBD6929AE46018701136523184E2A267C
            4233A65B3CBA6729AE46038703587D586A6A6AA9A9A9E3E3E3FBFBFBFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE5E6E5A1A2A17C7C7C7878
            787979797979797979796E6F6E4E4F4E3C3C3C3939393A3A3A3939393939393A
            3A3A393A39393A39383938383938364036007C0041D67343D97544DF783FCB6E
            3ABB663ABB653EBE6A29AF480188011774291A542E267B4334A65A3DBB6829AF
            48038803587F586A6A6AA8A8A8E3E3E3FBFBFBFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFF3F8D3F1170111674161875181876181877181D791D086D
            08026B02026F02027002027102027102036F0302720202730202740202750201
            770101770100780044DD7745DE7845DF7946E07940CC6F3BBB663DBC663FBE6B
            2AB149018B0118752A1A542E277B4336A75B3EBB692AB149028B02587F586969
            69A8A8A8E3E3E3FBFBFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFE348434
            17932D22A34421A24122A34224A54422A34022A24022A34125A84526A74625A7
            4625A74626A8472AAC4C2AAD4B2BAD4B2BAE4B2DB0502FB2512DB04E42D47346
            E07946DF7948E17B48E27B41CE703CBC663EBD6740BF6B2EB54E018E0119762A
            1B552E277B4337A85B3FBC692EB54E028E02578057696969A7A7A7E2E2E2FBFB
            FBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFE34843421A8402FB25D2FB15A30B25C
            31B35D31B35D32B35E33B35E33B35F34B35F34B35F35B36035B36035B25F36B2
            6136B36037B16037B16037B16037B16138B06045DA7648E17B48E17B48E17B4A
            E47E43D0723EBC673EBD6840BF6C30B65001900119772A1C562F297B4337A85C
            3FBC6A30B650029002568056696969A7A7A7E2E2E2FBFBFBFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFEFEFE34843421AA413AC4692EB15A30B35C31B35C31B35D32B35C33B45D
            34B45F34B45E35B35E35B36035B35F36B36137B56037B36038B36238B66139B5
            6339B56239B5623BB86448DF7B49E27C49E27C4AE47D4BE57E45D1743FBB683F
            BD6942BF6D31B75101910119782A1C5630297A4438A75D41BC6B31B751029102
            568156696969A7A7A7E1E1E1FBFBFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFE34833420A9404A
            D77A3BD36E3AD36D3BD46E3CD56F3DD6703ED9713FDA733FD97240DA7341DB74
            42DC7543DD7644DE7745DF7846E17A46E07947E17A48E37B49E47D49E37C49E2
            7C4AE37D4AE37D4BE47E4DE6804DE78046D4753FBB6841BD6B42BF6E32B85201
            93011A7A2B1D573029794339A65E41BC6C32B852029302568256696969A5A5A5
            E0E0E0FBFBFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFEFEFE2C802C22AD434BD77946D47639D26C3AD36D3B
            D46E3CD56F3DD6703ED7713FD87240D97341DA7442DB7543DC7644DD7745DE78
            46DF7946DF7947E07A48E17B49E27C49E27C4AE37D4BE47E4CE57F4CE57F4DE6
            804DE6804FE98348D57841BC6A41BE6B43C06F33B9530195011A7F2C1D56302A
            784439A65E42BD6D33B953029502558655676767A3A3A3DFDFDFFBFBFBFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFE
            FE2A7E2A23AE454AD87A52D87F39D36C47D7776DE0937AE39D6EE19557DD8440
            D97341DA7442DB7543DC7667E39174E69A80E9A374E79B47E07A48E17B54E484
            83ECA677EA9E56E68679EC9F7AECA063E9904EE7817BEEA17BEEA167EE9449D6
            784EC17471CE9073CF9341BE5F0094011A812B1D56302A79443AA65E43BC6D34
            BA54019401538853676767A3A3A3DFDFDFFBFBFBFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFE2A7E2A24AF454DD87C5EDB
            875FDC88FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFACEFC242DB754FDE7FB9F2CCFF
            FFFFFFFFFFFFFFFFFFFFFFC6F6D677E99DF4FDF7FFFFFFFFFFFFF4FDF7FFFFFF
            FFFFFFA7F3C04FE882FFFFFFFFFFFFA8F5C252EC8678E09BFFFFFFFFFFFF74D0
            9435BB550096011B822C1E56312B79443BA75E44BC6E35BB5501960153885367
            6767A3A3A3DFDFDFFAFAFAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFEFEFE2A7E2A24B0464DDA7C6BDE926BE092FFFFFFDBF8E59FEC
            B9D0F6DCFFFFFFFFFFFF7EE7A1AEF0C4FFFFFFFFFFFFF4FDF7BAF3CDE9FBEFD2
            F8DFC7F6D7FFFFFFFFFFFFBDF6D0E9FCF0FFFFFFFFFFFFA8F4C150E983FFFFFF
            FFFFFFA9F5C254ED877FF3A6FFFFFFFFFFFF73CE9246BF7139BE5B0098011B84
            2C1F58322B78453CA76045BC6F39BE5B019801538A53676767A2A2A2E0E0E0FB
            FBFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFE2A7E2A
            25B0464CD97D77E19B53DA7F6EE09456DC8387E7A7C4F3D4FFFFFFFFFFFFA1EE
            BBFFFFFFFFFFFFF4FDF747E07A48E17B54E48483ECA6DEFAE7FFFFFFF5FEF84E
            E7817AEDA1FFFFFFFFFFFFA8F5C251EA84FFFFFFFFFFFFA9F6C354ED877FF2A5
            FFFFFFFFFFFF74CE9245BF6F46BF703ABF5D0099011C862C215D3531864D41B4
            6846BF703ABF5D019901528B526C6C6CB5B5B5F0F0F0FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFE227C2226B34A4DDA7C7EE4A13ED771
            93E9AFF4FDF7FFFFFFFFFFFFFFFFFFFFFFFF7FE8A2FFFFFFFFFFFFBAF3CD48E1
            7B49E27C4AE37D4BE47EA6F2BFFFFFFFFFFFFFEAFCF0DFFBE8FFFFFFFFFFFFA9
            F5C252EB85FFFFFFFFFFFFAAF6C355EE8880F2A6FFFFFFFFFFFF7DE69F45BE6D
            45BF6E49C0713DC160019A031F92323A9F5C41B46745BF6E49C0713DC160029A
            035B975BB8B8B8F1F1F1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFEFEFE217B2129B54C4DDA7E80E3A049D979FFFFFFFFFFFFFFFFFFE8FBEE
            C5F4D567E39145DE78FFFFFFFFFFFFDDF9E749E27C4AE37D4BE47E4CE57F4DE6
            809CF2B8D4F9E0FFFFFFFFFFFFFFFFFFFFFFFFA9F6C354ED87FFFFFFFFFFFFAB
            F7C456EF898CF5AFFFFFFFFFFFFF83F7AA4DD37946BF6F49C17336C056019902
            2AA84250DA7E4CD07746BF6F49C17336C05603990378AF78E4E4E4FBFBFBFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFE217C2128B54C4E
            DB7D80E4A176E39AFFFFFFFFFFFFD0F6DD43DC7667E391BAF3CD69E592DDF9E6
            FFFFFFFFFFFFA5F1BE6DE996A6F2BFD3F9E064EA919CF2B971ED9A66EC93B3F6
            C9FFFFFFFFFFFF94F4B455EE88FFFFFFFFFFFFEBFDF1ABF8C5E0FCEAFFFFFFFF
            FFFF79F6A24DD07949C07236C1550197022AAA424FD77D59F08B4DD07949C072
            36C15503970379B179E3E3E3FBFBFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFEFEFE217C2128B64D4FDC7E80E5A163DF8BDCF8E5FF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFF74E79B6AE693FFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFD3F9E07BEEA1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEAFDF055EE8856EF
            89FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEBFEF15DF7904DCA7836C05301
            97022BAC4450D97E59EF8B5DF7904DCA7836C0530397037BB27BE4E4E4FBFBFB
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFE
            FE217C2129B64D50DC7F80E5A26FE3954ADB7AA1EDBAD1F6DDD1F7DDD1F7DEAE
            F1C553E28248E17B60E68CBCF5CFD3F8DFD3F9DFC8F7D886EFA965EB92C9F8D9
            D4FAE1D4FAE1D5FAE1CAF9DA75F19E56EF8957F08AD5FBE2D6FCE2A2F8BFB7FA
            CDD6FCE3C2FBD57AF6A361FA9633BD4F0198022CAD4550D97E5AF08C5BF48E61
            FA9633BD4F0499047CB27CE4E4E4FBFBFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFE217D2129B84E53DD8282E6
            A27CE59F3EDA7141DB7442DC7543DD7643DE7746E07946E17A47E27B48E37C49
            E47D4AE57E4BE67F4CE7804DE8814EE9824FEA8350EB8451EC8552ED8655EE88
            56EF8957F08A58F18B59F28C59F28C5AF38D5BF48E5BF48E5DF69060F9963BD5
            5D0196022CAD4552DB805AF08C5DF69060F9963BD55D0497047DB37DE5E5E5FB
            FBFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFEFEFE217C2129B74E54DD8282E6A383E7A460E18B61E18C62E2
            8D63E38E65E48F68E6926AE7936BE7946CE9966DEA976FEB9870EB9971EC9A72
            ED9B76EE9D78EFA078F0A07BF1A17DF3A462F09157F08A58F18B59F28C5AF38D
            5AF38D5BF48E5CF58F5CF58F61FB973DD55D0294032DAC4752DB805BF18D5CF5
            8F61FB973DD55D05940580B280E5E5E5FBFBFBFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFE217C21
            29B74E54DE8483E7A483E8A487E7A788E9A889EAA98BEBAA8CECAC8EEDAD8FEE
            AE91EDB092EEB193EFB295F1B396F0B498F1B699F2B79AF4B89BF3B99DF4BA9D
            F6BBA3F6BE62F19158F18B59F28C5AF38D5BF48E5BF48E5CF58F5DF69163FC98
            3BD35B0292032FAE4A52DC805BF28D5DF69163FC983BD35B05920584B384E6E6
            E6FCFCFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFE29812928B44955DF8481E7A281E7A3
            81E7A484E9A484EAA787EAA887EBA988ECA98BEDAC8AECAB8AEDAB8DEEAC8DF0
            AF8EF1AF91F0B091F1B192F2B295F3B395F4B49CF6BA9FF5BC55F18A59F28C5A
            F38D5BF48E5CF58F5CF58F5DF69162FC983BD25B0293032FAC4A53DD815BF28D
            5DF69162FC983BD25B06940684B184E6E6E6FCFCFCFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFF2A832A2AB74C41DD7740DC7540DD7541DE7642DF7745E07846E17B
            46E37B47E47C48E57D49E67E4AE77F4BE8804EEA834FEB8350EC8451ED8552EE
            8652EF874FEE858EF4B191F6B456F28A5AF38D5BF48E5BF48E5CF58F5DF69163
            FD993BD25A0292032FAD4A52DD815BF28D5DF69163FD993BD25A06930685B385
            E7E7E7FCFCFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF2F872F189A2C29
            B44A29B54929B6492AB74A2BB74B2BB84C2CB94C2DBC4D31C05331C15332C255
            34C45433C55535C65636C75837C85737C95838CB5A37CA5853F08792F6B483F4
            A857F28B5AF38D5BF48E5CF58F5DF69163FD993AD159028F0330AC4B52DD815B
            F28D5DF69163FD993AD159058F0587B287E7E7E7FCFCFCFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFF56A4562A8C2A2A8B2A2A8B2A2A8C2A2A8D2A2A
            8E2A0E800E077D07077E07067F06058005058105058205058305058405058605
            048604048604048204007F0050EC8294F6B473F49E59F38C5BF48E5CF58F5DF6
            9164FD9936CC530390042FAC4A52DD815BF28D5DF69164FD9936CC5306910687
            B287E7E7E7FCFCFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFEFDFDFDFDFDFDFD
            FDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDD7EAD7008200
            50ED8397F7B763F3945BF48E5CF58F5DF69164FD9935CB5204900535AD4F52DD
            815BF28D5DF69164FD9935CB5207900788B388E7E7E7FCFCFCFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFD8EAD800840052ED8493F7B55AF38C5BF48E
            5CF59064FC9835CA52028F044FAF6152DD7F5AF18C5CF59064FC9835CA52078F
            0789B389E8E8E8FCFCFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFD8EAD800830052EE8585F6AC59F48D5CF59063FC9834C951008B002CAA48
            79E09C58F18B5CF59063FC9834C951068E068AB38AE8E8E8FCFCFCFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD8EAD800830055EE8675
            F6A05BF48E62FB9733C84E078E07006F004DD97A74F39E5BF48E62FB9733C84E
            088F088AB28AE8E8E8FCFCFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFD8EAD800850055EF8663F59561FB9732C74E0A8D0A77
            A87700790054EC8463F59561FB9732C74E0A8D0A8CB48CE8E8E8FCFCFCFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD8EA
            D800840057EF8961FB962FC44A0A8D0A91B491C5D6C500820057EF8961FB962F
            C44A0A8D0A91B491E9E9E9FCFCFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD9EBD90085005CF5912CC1460A8C
            0A92B492E9E9E9D6E8D60085005CF5912CC1460A8C0A92B492E9E9E9FCFCFCFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFD9EBD900890027BA3F0B8B0B93B493EAEAEAFCFCFCD9EBD90089
            0027BA3F0B8B0B93B493EAEAEAFCFCFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDAECDA008B00
            0C8E0C94B694EAEAEAFCFCFCFFFFFFDAECDA008B000C8E0C94B694EAEAEAFCFC
            FCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFDAEDDA0B920BA4C8A4EBEBEBFDFDFDFFFFFF
            FFFFFFDAEDDA0B920BA4C8A4EBEBEBFDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFE4F3E4BAE0BAF8F8F8FDFDFDFFFFFFFFFFFFFFFFFFE4F3E4BAE0BAF8F8F8
            FDFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFF}
          Transparent = True
        end
        object txtEntry: TEdit
          Left = 56
          Top = 3
          Width = 517
          Height = 45
          Anchors = [akLeft, akRight, akBottom]
          Ctl3D = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -32
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 0
          OnKeyDown = txtEntryKeyDown
          OnKeyPress = txtEntryKeyPress
        end
      end
    end
  end
  object RAWPrinter1: TRAWPrinter
    Left = 24
    Top = 40
  end
end
