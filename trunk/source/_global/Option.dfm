object frmOption: TfrmOption
  Left = 269
  Top = 191
  BorderStyle = bsDialog
  Caption = 'Option'
  ClientHeight = 416
  ClientWidth = 455
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object btnSave: TButton
    Left = 297
    Top = 380
    Width = 75
    Height = 25
    Caption = '&Apply'
    TabOrder = 0
    OnClick = btnSaveClick
  end
  object btnCancel: TButton
    Left = 377
    Top = 380
    Width = 75
    Height = 25
    Caption = '&Cancel'
    TabOrder = 1
    OnClick = btnCancelClick
  end
  object PageControl1: TPageControl
    Left = 3
    Top = 8
    Width = 450
    Height = 361
    ActivePage = TabSheet1
    TabIndex = 0
    TabOrder = 2
    OnChange = PageControl1Change
    object TabSheet1: TTabSheet
      Caption = 'Perusahaan'
      object Bevel1: TBevel
        Left = 1
        Top = 8
        Width = 438
        Height = 265
      end
      object Label1: TLabel
        Left = 10
        Top = 29
        Width = 34
        Height = 13
        Caption = 'Nama :'
      end
      object TLabel
        Left = 10
        Top = 53
        Width = 40
        Height = 13
        Caption = 'Alamat :'
      end
      object TLabel
        Left = 10
        Top = 78
        Width = 29
        Height = 13
        Caption = 'Kota :'
      end
      object TLabel
        Left = 10
        Top = 101
        Width = 46
        Height = 13
        Caption = 'Phone 1 :'
      end
      object TLabel
        Left = 237
        Top = 101
        Width = 46
        Height = 13
        Caption = 'Phone 2 :'
      end
      object TLabel
        Left = 10
        Top = 125
        Width = 25
        Height = 13
        Caption = 'Fax :'
      end
      object TLabel
        Left = 10
        Top = 150
        Width = 44
        Height = 13
        Caption = 'Cabang :'
      end
      object Label2: TLabel
        Left = 10
        Top = 171
        Width = 52
        Height = 13
        Caption = 'Informasi :'
      end
      object Label9: TLabel
        Left = 8
        Top = 208
        Width = 73
        Height = 13
        Caption = 'Serial Number :'
      end
      object TLabel
        Left = 237
        Top = 77
        Width = 51
        Height = 13
        Caption = 'Kode Pos :'
      end
      object TLabel
        Left = 237
        Top = 125
        Width = 36
        Height = 13
        Caption = 'NPWP :'
      end
      object Bevel5: TBevel
        Left = 3
        Top = 291
        Width = 250
        Height = 37
      end
      object Label7: TLabel
        Left = 14
        Top = 310
        Width = 37
        Height = 13
        Caption = 'Masuk :'
      end
      object Label16: TLabel
        Left = 132
        Top = 310
        Width = 39
        Height = 13
        Caption = 'Pulang :'
      end
      object txtName: TAdvEdit
        Left = 94
        Top = 27
        Width = 217
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
        LabelPosition = lpLeftTop
        LabelMargin = 4
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
        Text = 'txtName'
        Transparent = False
        Visible = True
        OnChange = txtDbServerChange
      end
      object txtAddress: TAdvEdit
        Left = 94
        Top = 51
        Width = 337
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
        LabelPosition = lpLeftTop
        LabelMargin = 4
        LabelTransparent = False
        LabelAlwaysEnabled = False
        LabelFont.Charset = DEFAULT_CHARSET
        LabelFont.Color = clWindowText
        LabelFont.Height = -11
        LabelFont.Name = 'MS Sans Serif'
        LabelFont.Style = []
        Persistence.Enable = False
        Persistence.Location = plInifile
        AutoSize = False
        Color = clWindow
        Enabled = True
        HintShowLargeText = False
        OleDropTarget = False
        OleDropSource = False
        Signed = False
        TabOrder = 1
        Text = 'txtAddress'
        Transparent = False
        Visible = True
        OnChange = txtDbServerChange
      end
      object txtCity: TAdvEdit
        Left = 94
        Top = 75
        Width = 129
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
        LabelPosition = lpLeftTop
        LabelMargin = 4
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
        TabOrder = 2
        Text = 'txtCity'
        Transparent = False
        Visible = True
        OnChange = txtDbServerChange
      end
      object txtTelp1: TAdvEdit
        Left = 94
        Top = 99
        Width = 129
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
        LabelPosition = lpLeftTop
        LabelMargin = 4
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
        TabOrder = 3
        Text = 'txtTelp1'
        Transparent = False
        Visible = True
        OnChange = txtDbServerChange
      end
      object txtTelp2: TAdvEdit
        Left = 302
        Top = 99
        Width = 129
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
        LabelPosition = lpLeftTop
        LabelMargin = 4
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
        TabOrder = 6
        Text = 'txtTelp2'
        Transparent = False
        Visible = True
        OnChange = txtDbServerChange
      end
      object txtFax: TAdvEdit
        Left = 94
        Top = 123
        Width = 129
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
        LabelPosition = lpLeftTop
        LabelMargin = 4
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
        TabOrder = 4
        Text = 'txtFax'
        Transparent = False
        Visible = True
        OnChange = txtDbServerChange
      end
      object txtBranch: TAdvEdit
        Left = 94
        Top = 147
        Width = 335
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
        LabelPosition = lpLeftTop
        LabelMargin = 4
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
        TabOrder = 8
        Text = 'txtBranch'
        Transparent = False
        Visible = True
        OnChange = txtDbServerChange
      end
      object mmInfo: TMemo
        Left = 94
        Top = 171
        Width = 337
        Height = 34
        Lines.Strings = (
          'mmInfo')
        TabOrder = 9
        OnChange = txtDbServerChange
      end
      object StaticText1: TStaticText
        Left = 6
        Top = 2
        Width = 115
        Height = 17
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = ' Informasi Perusahaan'
        TabOrder = 10
      end
      object txtSerialNumber: TAdvEdit
        Left = 94
        Top = 208
        Width = 337
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
        ReturnIsTab = True
        LengthLimit = 0
        TabOnFullLength = False
        Precision = 0
        LabelPosition = lpLeftTop
        LabelMargin = 4
        LabelTransparent = False
        LabelAlwaysEnabled = False
        LabelFont.Charset = DEFAULT_CHARSET
        LabelFont.Color = clWindowText
        LabelFont.Height = -11
        LabelFont.Name = 'MS Sans Serif'
        LabelFont.Style = []
        Persistence.Enable = False
        Persistence.Location = plInifile
        Color = cl3DLight
        Enabled = True
        HintShowLargeText = False
        OleDropTarget = False
        OleDropSource = False
        Signed = False
        TabOrder = 11
        Transparent = False
        Visible = True
        OnChange = txtSerialNumberChange
      end
      object hide: TButton
        Left = 56
        Top = 248
        Width = 75
        Height = 25
        Caption = 'hide button'
        TabOrder = 12
        Visible = False
        OnClick = hideClick
      end
      object btnRegister: TButton
        Left = 359
        Top = 235
        Width = 75
        Height = 25
        Caption = '&Register'
        TabOrder = 13
        OnClick = btnRegisterClick
      end
      object btnReset: TButton
        Left = 280
        Top = 235
        Width = 75
        Height = 25
        Caption = 'Reset'
        Enabled = False
        TabOrder = 14
        Visible = False
        OnClick = btnResetClick
      end
      object txtPostCode: TAdvEdit
        Left = 302
        Top = 75
        Width = 129
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
        LabelPosition = lpLeftTop
        LabelMargin = 4
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
        TabOrder = 5
        Text = 'txtCity'
        Transparent = False
        Visible = True
        OnChange = txtDbServerChange
      end
      object txtTax: TAdvEdit
        Left = 302
        Top = 123
        Width = 129
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
        LabelPosition = lpLeftTop
        LabelMargin = 4
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
        TabOrder = 7
        Text = '121212.22323.23232.9'
        Transparent = False
        Visible = True
        OnChange = txtDbServerChange
      end
      object btnBranch: TButton
        Left = 407
        Top = 148
        Width = 19
        Height = 18
        Caption = '...'
        TabOrder = 15
        OnClick = btnBranchClick
      end
      object StaticText3: TStaticText
        Left = 8
        Top = 284
        Width = 115
        Height = 17
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = 'Jam Kerja'
        TabOrder = 16
      end
      object dtpMasuk: TDateTimePicker
        Left = 53
        Top = 306
        Width = 75
        Height = 22
        CalAlignment = dtaLeft
        Date = 41551.6693185764
        Format = 'HH:MM'
        Time = 41551.6693185764
        DateFormat = dfShort
        DateMode = dmUpDown
        Kind = dtkTime
        ParseInput = False
        TabOrder = 17
      end
      object dtpPulang: TDateTimePicker
        Left = 174
        Top = 306
        Width = 75
        Height = 22
        CalAlignment = dtaLeft
        Date = 41551.6693185764
        Format = 'HH:mm'
        Time = 41551.6693185764
        DateFormat = dfShort
        DateMode = dmComboBox
        Kind = dtkTime
        ParseInput = False
        TabOrder = 18
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Database'
      ImageIndex = 1
      object Bevel2: TBevel
        Left = 1
        Top = 8
        Width = 439
        Height = 273
      end
      object Label3: TLabel
        Left = 172
        Top = 86
        Width = 62
        Height = 13
        Caption = 'Nama Server'
      end
      object Label4: TLabel
        Left = 172
        Top = 111
        Width = 46
        Height = 13
        Caption = 'Database'
      end
      object Label5: TLabel
        Left = 172
        Top = 134
        Width = 22
        Height = 13
        Caption = 'User'
      end
      object Label6: TLabel
        Left = 172
        Top = 156
        Width = 46
        Height = 13
        Caption = 'Password'
      end
      object Image1: TImage
        Left = 49
        Top = 76
        Width = 100
        Height = 109
        Stretch = True
        Transparent = True
      end
      object txtDbName: TAdvEdit
        Left = 253
        Top = 108
        Width = 121
        Height = 21
        AutoFocus = False
        EditAlign = eaLeft
        EditType = etPassword
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
        LabelPosition = lpLeftTop
        LabelMargin = 4
        LabelTransparent = False
        LabelAlwaysEnabled = False
        LabelFont.Charset = DEFAULT_CHARSET
        LabelFont.Color = clWindowText
        LabelFont.Height = -11
        LabelFont.Name = 'MS Sans Serif'
        LabelFont.Style = []
        Persistence.Enable = False
        Persistence.Location = plInifile
        CanUndo = False
        Color = clSilver
        Enabled = False
        HintShowLargeText = False
        PasswordChar = '*'
        OleDropTarget = False
        OleDropSource = False
        Signed = False
        TabOrder = 0
        Text = 'bengkel'
        Transparent = False
        Visible = True
        OnChange = txtDbServerChange
      end
      object txtDbUser: TAdvEdit
        Left = 253
        Top = 132
        Width = 121
        Height = 21
        AutoFocus = False
        EditAlign = eaLeft
        EditType = etPassword
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
        LabelPosition = lpLeftTop
        LabelMargin = 4
        LabelTransparent = False
        LabelAlwaysEnabled = False
        LabelFont.Charset = DEFAULT_CHARSET
        LabelFont.Color = clWindowText
        LabelFont.Height = -11
        LabelFont.Name = 'MS Sans Serif'
        LabelFont.Style = []
        Persistence.Enable = False
        Persistence.Location = plInifile
        CanUndo = False
        Color = clSilver
        Enabled = False
        HintShowLargeText = False
        PasswordChar = '*'
        OleDropTarget = False
        OleDropSource = False
        Signed = False
        TabOrder = 1
        Text = 'root'
        Transparent = False
        Visible = True
        OnChange = txtDbServerChange
      end
      object txtDbPwd: TAdvEdit
        Left = 253
        Top = 156
        Width = 121
        Height = 21
        AutoFocus = False
        EditAlign = eaLeft
        EditType = etPassword
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
        LabelPosition = lpLeftTop
        LabelMargin = 4
        LabelTransparent = False
        LabelAlwaysEnabled = False
        LabelFont.Charset = DEFAULT_CHARSET
        LabelFont.Color = clWindowText
        LabelFont.Height = -11
        LabelFont.Name = 'MS Sans Serif'
        LabelFont.Style = []
        Persistence.Enable = False
        Persistence.Location = plInifile
        CanUndo = False
        Color = clWhite
        Enabled = True
        HintShowLargeText = False
        PasswordChar = '*'
        OleDropTarget = False
        OleDropSource = False
        Signed = False
        TabOrder = 2
        Text = 'admin'
        Transparent = False
        Visible = True
        OnChange = txtDbServerChange
      end
      object StaticText2: TStaticText
        Left = 6
        Top = 2
        Width = 115
        Height = 17
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = ' Konfigurasi Database'
        TabOrder = 3
      end
      object btnKoneksi: TButton
        Left = 254
        Top = 184
        Width = 121
        Height = 25
        Caption = 'Koneksi Ke Server'
        TabOrder = 4
        OnClick = btnKoneksiClick
      end
      object cmbHost: TComboBox
        Left = 253
        Top = 80
        Width = 121
        Height = 21
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 5
        Text = 'localHost'
        OnChange = cmbHostChange
        Items.Strings = (
          'localHost')
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'System Configuration'
      ImageIndex = 4
      DesignSize = (
        442
        333)
      object Bevel4: TBevel
        Left = 3
        Top = 14
        Width = 248
        Height = 265
      end
      object Bevel7: TBevel
        Left = 253
        Top = 13
        Width = 185
        Height = 115
      end
      object Label8: TLabel
        Left = 15
        Top = 104
        Width = 58
        Height = 13
        Caption = 'Jns Printer :'
      end
      object Label10: TLabel
        Left = 46
        Top = 129
        Width = 27
        Height = 13
        Caption = 'Port :'
      end
      object Label11: TLabel
        Left = 259
        Top = 31
        Width = 60
        Height = 13
        Caption = 'Nama Kasir :'
      end
      object Label12: TLabel
        Left = 275
        Top = 55
        Width = 44
        Height = 13
        Caption = 'Gudang :'
      end
      object Label13: TLabel
        Left = 22
        Top = 80
        Width = 51
        Height = 13
        Caption = 'Prin Kasir :'
      end
      object Label14: TLabel
        Left = 26
        Top = 152
        Width = 47
        Height = 13
        Caption = 'Prn Adm :'
      end
      object Label15: TLabel
        Left = 8
        Top = 176
        Width = 65
        Height = 13
        Caption = 'Prn Barcode :'
      end
      object Bevel3: TBevel
        Left = 253
        Top = 166
        Width = 185
        Height = 112
      end
      object chkInven: TCheckBox
        Left = 320
        Top = 102
        Width = 116
        Height = 14
        Caption = 'Update Histori Stok'
        Enabled = False
        TabOrder = 14
      end
      object chkPrice: TCheckBox
        Left = 320
        Top = 78
        Width = 85
        Height = 17
        Caption = 'Update Price'
        TabOrder = 13
      end
      object StaticText6: TStaticText
        Left = 8
        Top = 5
        Width = 115
        Height = 17
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = ' Printer Struk'
        TabOrder = 15
      end
      object txtFooter1: TAdvEdit
        Left = 75
        Top = 30
        Width = 170
        Height = 21
        OnValueValidate = txtFooter2ValueValidate
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
        LabelCaption = 'Footer 1 :'
        LabelPosition = lpLeftTop
        LabelMargin = 2
        LabelTransparent = False
        LabelAlwaysEnabled = True
        LabelFont.Charset = ANSI_CHARSET
        LabelFont.Color = clWindowText
        LabelFont.Height = -11
        LabelFont.Name = 'Tahoma'
        LabelFont.Style = []
        Persistence.Enable = False
        Persistence.Location = plInifile
        Anchors = [akLeft, akTop, akRight]
        Color = clWindow
        Enabled = True
        HintShowLargeText = False
        MaxLength = 40
        OleDropTarget = False
        OleDropSource = False
        Signed = False
        TabOrder = 0
        Text = '**Harga Sudah termasuk PPn**'
        Transparent = False
        Visible = True
      end
      object txtFooter2: TAdvEdit
        Left = 75
        Top = 54
        Width = 170
        Height = 21
        OnValueValidate = txtFooter2ValueValidate
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
        LabelCaption = 'Footer 2 :'
        LabelPosition = lpLeftTop
        LabelMargin = 2
        LabelTransparent = False
        LabelAlwaysEnabled = True
        LabelFont.Charset = ANSI_CHARSET
        LabelFont.Color = clWindowText
        LabelFont.Height = -11
        LabelFont.Name = 'Tahoma'
        LabelFont.Style = []
        Persistence.Enable = False
        Persistence.Location = plInifile
        Anchors = [akLeft, akTop, akRight]
        Color = clWindow
        Enabled = True
        HintShowLargeText = False
        MaxLength = 40
        OleDropTarget = False
        OleDropSource = False
        Signed = False
        TabOrder = 1
        Text = '**Terimakasih Atas Kunjungnnya**'
        Transparent = False
        Visible = True
      end
      object txtMarginBottom: TAdvEdit
        Left = 195
        Top = 253
        Width = 30
        Height = 21
        OnValueValidate = txtFooter2ValueValidate
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
        LabelCaption = 'Margin Bawah :'
        LabelPosition = lpLeftTop
        LabelMargin = 4
        LabelTransparent = False
        LabelAlwaysEnabled = True
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
        MaxLength = 1
        OleDropTarget = False
        OleDropSource = False
        ReadOnly = True
        Signed = False
        TabOrder = 10
        Text = '0'
        Transparent = False
        Visible = True
      end
      object txtMarginTop: TAdvEdit
        Left = 195
        Top = 229
        Width = 30
        Height = 21
        OnValueValidate = txtFooter2ValueValidate
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
        LabelCaption = 'Margin Atas :'
        LabelPosition = lpLeftTop
        LabelMargin = 4
        LabelTransparent = False
        LabelAlwaysEnabled = True
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
        MaxLength = 1
        OleDropTarget = False
        OleDropSource = False
        ReadOnly = True
        Signed = False
        TabOrder = 9
        Text = '0'
        Transparent = False
        Visible = True
      end
      object UpDown1: TUpDown
        Left = 225
        Top = 229
        Width = 16
        Height = 21
        Anchors = [akTop, akRight]
        Associate = txtMarginTop
        Min = 0
        Max = 10
        Position = 0
        TabOrder = 16
        Thousands = False
        Wrap = False
      end
      object UpDown2: TUpDown
        Left = 225
        Top = 253
        Width = 16
        Height = 21
        Anchors = [akTop, akRight]
        Associate = txtMarginBottom
        Min = 0
        Max = 10
        Position = 0
        TabOrder = 18
        Thousands = False
        Wrap = False
      end
      object chkCutOff: TCheckBox
        Left = 14
        Top = 234
        Width = 82
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Auto Cutter :'
        TabOrder = 7
      end
      object chkPrint: TCheckBox
        Left = 21
        Top = 250
        Width = 75
        Height = 21
        Alignment = taLeftJustify
        Caption = 'Print Struk : '
        TabOrder = 8
      end
      object StaticText9: TStaticText
        Left = 258
        Top = 5
        Width = 115
        Height = 17
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = ' Mesin Kasir'
        TabOrder = 17
      end
      object cmbKasir: TComboBox
        Left = 321
        Top = 28
        Width = 110
        Height = 21
        ItemHeight = 13
        TabOrder = 11
        OnChange = cmbKasirChange
      end
      object cmbPrinterName: TComboBox
        Left = 75
        Top = 102
        Width = 170
        Height = 21
        ItemHeight = 13
        TabOrder = 3
        OnChange = cmbPrinterNameChange
      end
      object cmbPort: TComboBox
        Left = 75
        Top = 126
        Width = 170
        Height = 21
        ItemHeight = 13
        TabOrder = 4
        Text = 'COM1'
        OnChange = cmbPrinterNameChange
      end
      object cmbGudang: TComboBox
        Left = 321
        Top = 52
        Width = 110
        Height = 21
        ItemHeight = 13
        TabOrder = 12
        OnChange = cmbGudangChange
      end
      object cmbPrnStruk: TComboBox
        Left = 75
        Top = 78
        Width = 170
        Height = 21
        ItemHeight = 13
        TabOrder = 2
        OnChange = cmbKasirChange
      end
      object cmbPrnAdm: TComboBox
        Left = 75
        Top = 150
        Width = 170
        Height = 21
        ItemHeight = 13
        TabOrder = 5
        OnChange = cmbKasirChange
      end
      object cmbPrnBarcode: TComboBox
        Left = 75
        Top = 174
        Width = 170
        Height = 21
        ItemHeight = 13
        TabOrder = 6
        OnChange = cmbKasirChange
      end
      object StaticText5: TStaticText
        Left = 260
        Top = 157
        Width = 115
        Height = 17
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = ' Serial Key'
        TabOrder = 19
      end
      object chkLog: TCheckBox
        Left = 320
        Top = 120
        Width = 97
        Height = 17
        Caption = 'Catatat log file'
        TabOrder = 20
      end
      object chkSerialKeys: TCheckBox
        Left = 331
        Top = 194
        Width = 97
        Height = 17
        Caption = 'Use Serial Keys'
        TabOrder = 21
      end
      object txtSerialPort: TAdvEdit
        Left = 331
        Top = 214
        Width = 100
        Height = 21
        OnValueValidate = txtFooter2ValueValidate
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
        ReturnIsTab = False
        LengthLimit = 0
        TabOnFullLength = False
        Precision = 0
        LabelCaption = 'Serial Port :'
        LabelPosition = lpLeftTop
        LabelMargin = 4
        LabelTransparent = False
        LabelAlwaysEnabled = True
        LabelFont.Charset = ANSI_CHARSET
        LabelFont.Color = clWindowText
        LabelFont.Height = -11
        LabelFont.Name = 'Tahoma'
        LabelFont.Style = []
        Persistence.Enable = False
        Persistence.Location = plInifile
        Anchors = [akLeft, akTop, akRight]
        Color = clWindow
        Enabled = True
        HintShowLargeText = False
        MaxLength = 40
        OleDropTarget = False
        OleDropSource = False
        Signed = False
        TabOrder = 22
        Text = '**Harga Sudah termasuk PPn**'
        Transparent = False
        Visible = True
      end
      object txtSerialBaud: TAdvEdit
        Left = 331
        Top = 238
        Width = 100
        Height = 21
        OnValueValidate = txtFooter2ValueValidate
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
        LabelCaption = 'Baud Rate :'
        LabelPosition = lpLeftTop
        LabelMargin = 4
        LabelTransparent = False
        LabelAlwaysEnabled = True
        LabelFont.Charset = ANSI_CHARSET
        LabelFont.Color = clWindowText
        LabelFont.Height = -11
        LabelFont.Name = 'Tahoma'
        LabelFont.Style = []
        Persistence.Enable = False
        Persistence.Location = plInifile
        Anchors = [akLeft, akTop, akRight]
        Color = clWindow
        Enabled = True
        HintShowLargeText = False
        MaxLength = 40
        OleDropTarget = False
        OleDropSource = False
        Signed = False
        TabOrder = 23
        Text = '0'
        Transparent = False
        Visible = True
      end
    end
  end
  object btnEmpty: TButton
    Left = 10
    Top = 377
    Width = 127
    Height = 25
    Caption = 'Kosongkan Transaksi'
    TabOrder = 3
    OnClick = btnEmptyClick
  end
  object mxProtector1: TmxProtector
    CodeKey = 'Ignore'
    ProtectionTypes = [stRegister]
    Options = [poAutoInit, poCheckSytemTime, poPasswordOnce]
    Expiration = 39772.4907638889
    MaxStartNumber = 99
    MaxDayNumber = 0
    Version = '1.23'
    OnRegister = mxProtector1Register
    OnExpiration = mxProtector1Expiration
    OnStartTrial = mxProtector1StartTrial
    OnInvalidSerialNumber = mxProtector1InvalidSerialNumber
    OnGetSerialNumber = mxProtector1GetSerialNumber
    Left = 416
    Top = 8
    UniqueCodeID = 
      '7A403B373040374A3F273D483C3C2224555626392C26252C342B232B592A2918' +
      '64101661615B'
    UniqueID = 
      '210D21756B0464660472701E09216B1A0413646E640468734E091D741315026B' +
      '046A09277224'
  end
end
