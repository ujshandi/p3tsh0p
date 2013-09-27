object frmMstCodeList: TfrmMstCodeList
  Left = 510
  Top = 239
  Width = 337
  Height = 434
  Caption = 'Daftar Master Kode Barang'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCloseQuery = FormCloseQuery
  DesignSize = (
    329
    400)
  PixelsPerInch = 96
  TextHeight = 13
  object Button2: TButton
    Left = 250
    Top = 372
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Ok'
    ModalResult = 1
    TabOrder = 0
  end
  object trlMstCode: TsuiTreeView
    Left = 0
    Top = 0
    Width = 329
    Height = 369
    UIStyle = DeepBlue
    BorderColor = clBlack
    Align = alTop
    BorderStyle = bsNone
    BorderWidth = 2
    Indent = 19
    TabOrder = 1
    OnDblClick = suiTreeView1DblClick
    OnKeyDown = suiTreeView1KeyDown
  end
  object WinXP1: TWinXP
    Top = 368
  end
end
