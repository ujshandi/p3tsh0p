object frmReportKas: TfrmReportKas
  Tag = -1
  Left = 151
  Top = 227
  Width = 805
  Height = 404
  Caption = 'frmReportKas'
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
    Width = 797
    Height = 41
    ButtonHeight = 36
    ButtonWidth = 60
    Caption = 'ToolBar1'
    EdgeBorders = [ebBottom]
    Flat = True
    Images = frmMainMenu.SmallImageList
    ParentShowHint = False
    ShowCaptions = True
    ShowHint = True
    TabOrder = 0
    Transparent = True
    object ToolButton5: TToolButton
      Left = 0
      Top = 0
      Caption = 'Reset Filter'
      ImageIndex = 3
      OnClick = ToolButton5Click
    end
    object tbtRefresh: TToolButton
      Tag = -19
      Left = 60
      Top = 0
      Hint = 'Refresh [Ctrl+L]'
      Caption = 'Load Data'
      ImageIndex = 6
      OnClick = tbtRefreshClick
    end
    object ToolButton2: TToolButton
      Left = 120
      Top = 0
      Width = 6
      Caption = 'ToolButton2'
      ImageIndex = 12
      Style = tbsSeparator
    end
    object tbtPrint: TToolButton
      Tag = -14
      Left = 126
      Top = 0
      Hint = 'Print Data [Ctrl+P]'
      Caption = 'Print'
      ImageIndex = 8
      OnClick = tbtPrintClick
    end
  end
  object suiPanel1: TsuiPanel
    Left = 0
    Top = 41
    Width = 797
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
    object Label3: TLabel
      Left = 199
      Top = 24
      Width = 40
      Height = 13
      Alignment = taRightJustify
      Caption = 'Report :'
      Visible = False
    end
    object cmbReport: TComboBox
      Left = 241
      Top = 24
      Width = 146
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 0
      Visible = False
      Items.Strings = (
        'On-Hand'
        'Mutasi Stok')
    end
    object panelDate: TPanel
      Left = 2
      Top = 22
      Width = 177
      Height = 54
      BevelOuter = bvNone
      Color = clWhite
      TabOrder = 1
      object Label2: TLabel
        Left = 41
        Top = 4
        Width = 43
        Height = 13
        Caption = 'Dari Tgl :'
      end
      object Label1: TLabel
        Left = 4
        Top = 28
        Width = 81
        Height = 13
        Caption = 'Sampai Dengan :'
      end
      object dtpAkhir: TDateTimePicker
        Left = 88
        Top = 26
        Width = 85
        Height = 21
        CalAlignment = dtaLeft
        Date = 39083.7426842477
        Time = 39083.7426842477
        DateFormat = dfShort
        DateMode = dmComboBox
        Kind = dtkDate
        ParseInput = False
        TabOrder = 0
      end
      object dtpAwal: TDateTimePicker
        Left = 88
        Top = 2
        Width = 85
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
    end
  end
  object suiPanel2: TsuiPanel
    Left = 0
    Top = 121
    Width = 797
    Height = 249
    UIStyle = DeepBlue
    BorderColor = clBlack
    Caption = 'Data List'
    ShowButton = False
    CaptionFontColor = clWhite
    Align = alClient
    TabOrder = 2
    Color = clWhite
  end
  object WinXP1: TWinXP
    Left = 528
    Top = 24
  end
end
