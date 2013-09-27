object frmInputBoxHarga: TfrmInputBoxHarga
  Left = 541
  Top = 342
  BorderStyle = bsDialog
  Caption = 'Pilih Harga'
  ClientHeight = 126
  ClientWidth = 217
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 145
    Top = 16
    Width = 64
    Height = 16
    Alignment = taRightJustify
    Caption = '2.500.000'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 145
    Top = 56
    Width = 64
    Height = 16
    Alignment = taRightJustify
    Caption = '2.500.000'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object RadioButton1: TRadioButton
    Left = 16
    Top = 16
    Width = 83
    Height = 17
    Caption = 'Harga Jual 1'
    TabOrder = 0
    OnKeyDown = RadioButton1KeyDown
  end
  object RadioButton2: TRadioButton
    Left = 16
    Top = 56
    Width = 83
    Height = 17
    Caption = 'Harga Jual 2'
    TabOrder = 1
    OnKeyDown = RadioButton1KeyDown
  end
  object Button1: TButton
    Left = 55
    Top = 92
    Width = 75
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 2
  end
  object Button2: TButton
    Left = 135
    Top = 92
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 3
  end
end
