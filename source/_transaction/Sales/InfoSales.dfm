object frmInfoSales: TfrmInfoSales
  Left = 312
  Top = 109
  BorderStyle = bsDialog
  Caption = 'Laporan Penjualan'
  ClientHeight = 349
  ClientWidth = 395
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  PopupMenu = PopupMenu1
  Position = poDesktopCenter
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 16
  object lblUser: TLabel
    Left = 8
    Top = 24
    Width = 43
    Height = 16
    Caption = 'lblUser'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
  end
  object lblDate: TLabel
    Left = 343
    Top = 8
    Width = 45
    Height = 16
    Alignment = taRightJustify
    Caption = 'lblDate'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
  end
  object Bevel1: TBevel
    Left = 8
    Top = 43
    Width = 380
    Height = 248
  end
  object lbls: TLabel
    Left = 40
    Top = 107
    Width = 40
    Height = 19
    Caption = 'Tunai'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lblSales: TLabel
    Left = 350
    Top = 107
    Width = 31
    Height = 19
    Alignment = taRightJustify
    Caption = '0,00'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 16
    Top = 219
    Width = 38
    Height = 19
    Caption = 'Retur'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lblRetur: TLabel
    Left = 350
    Top = 219
    Width = 31
    Height = 19
    Alignment = taRightJustify
    Caption = '0,00'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label5: TLabel
    Left = 16
    Top = 191
    Width = 67
    Height = 19
    Caption = 'Potongan'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lblDisc: TLabel
    Left = 350
    Top = 191
    Width = 31
    Height = 19
    Alignment = taRightJustify
    Caption = '0,00'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Bevel2: TBevel
    Left = 220
    Top = 248
    Width = 161
    Height = 9
    Shape = bsTopLine
    Style = bsRaised
  end
  object Label1: TLabel
    Left = 16
    Top = 258
    Width = 110
    Height = 19
    Caption = 'Jumlah Setoran'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lblJumlah: TLabel
    Left = 350
    Top = 258
    Width = 31
    Height = 19
    Alignment = taRightJustify
    Caption = '0,00'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblMesin: TLabel
    Left = 8
    Top = 8
    Width = 43
    Height = 16
    Caption = 'lblUser'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Tag = 3
    Left = 239
    Top = 300
    Width = 148
    Height = 14
    Cursor = crHandPoint
    Caption = 'Tutup Transaksi  Ctrl+C'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    OnClick = Label4Click
    OnMouseEnter = Label4MouseEnter
    OnMouseLeave = Label4MouseLeave
  end
  object Label4: TLabel
    Tag = 1
    Left = 8
    Top = 300
    Width = 131
    Height = 14
    Cursor = crHandPoint
    Caption = 'Shift Berjalan  Ctrl+S'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    OnClick = Label4Click
    OnMouseEnter = Label4MouseEnter
    OnMouseLeave = Label4MouseLeave
  end
  object Label6: TLabel
    Tag = 2
    Left = 8
    Top = 319
    Width = 126
    Height = 14
    Cursor = crHandPoint
    Caption = 'Keseluruhan  Ctrl+K'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    OnClick = Label4Click
    OnMouseEnter = Label4MouseEnter
    OnMouseLeave = Label4MouseLeave
  end
  object Label7: TLabel
    Tag = 4
    Left = 311
    Top = 319
    Width = 76
    Height = 14
    Cursor = crHandPoint
    Caption = 'Print  Ctrl+P'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    OnClick = Label4Click
    OnMouseEnter = Label4MouseEnter
    OnMouseLeave = Label4MouseLeave
  end
  object Label8: TLabel
    Left = 16
    Top = 55
    Width = 79
    Height = 19
    Caption = 'Saldo Awal'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lblAwal: TLabel
    Left = 350
    Top = 55
    Width = 31
    Height = 19
    Alignment = taRightJustify
    Caption = '0,00'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label9: TLabel
    Tag = -1
    Left = 40
    Top = 131
    Width = 83
    Height = 19
    Caption = 'Kartu Kredit'
    Font.Charset = ANSI_CHARSET
    Font.Color = clMaroon
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lblKredit: TLabel
    Left = 350
    Top = 131
    Width = 31
    Height = 19
    Alignment = taRightJustify
    Caption = '0,00'
    Font.Charset = ANSI_CHARSET
    Font.Color = clMaroon
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label11: TLabel
    Tag = -1
    Left = 40
    Top = 155
    Width = 79
    Height = 19
    Caption = 'Kartu Debit'
    Font.Charset = ANSI_CHARSET
    Font.Color = clMaroon
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lblDebit: TLabel
    Left = 350
    Top = 155
    Width = 31
    Height = 19
    Alignment = taRightJustify
    Caption = '0,00'
    Font.Charset = ANSI_CHARSET
    Font.Color = clMaroon
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label10: TLabel
    Left = 16
    Top = 84
    Width = 114
    Height = 19
    Caption = 'Penjualan Tunai'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object PopupMenu1: TPopupMenu
    AutoPopup = False
    Left = 152
    Top = 8
    object shift1: TMenuItem
      Tag = 1
      Caption = 'shift'
      ShortCut = 16467
      OnClick = shift1Click
    end
    object All1: TMenuItem
      Tag = 2
      Caption = 'All'
      ShortCut = 16459
      OnClick = shift1Click
    end
    object Close1: TMenuItem
      Tag = 3
      Caption = 'Close'
      ShortCut = 16451
      OnClick = shift1Click
    end
    object Print1: TMenuItem
      Tag = 4
      Caption = 'Print'
      ShortCut = 16464
      OnClick = shift1Click
    end
    object exit1: TMenuItem
      Caption = 'exit'
    end
  end
  object RAWPrinter1: TRAWPrinter
    Left = 248
    Top = 8
  end
end
