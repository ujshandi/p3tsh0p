object frmListOfKlas: TfrmListOfKlas
  Left = 287
  Top = 198
  BorderStyle = bsDialog
  Caption = 'List Of ...'
  ClientHeight = 352
  ClientWidth = 303
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  DesignSize = (
    303
    352)
  PixelsPerInch = 96
  TextHeight = 13
  object suiTreeView1: TsuiTreeView
    Left = 1
    Top = 2
    Width = 300
    Height = 318
    UIStyle = MacOS
    BorderColor = 8355711
    Anchors = [akLeft, akTop, akRight, akBottom]
    BorderStyle = bsNone
    BorderWidth = 2
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    HideSelection = False
    Indent = 19
    ParentFont = False
    ReadOnly = True
    RowSelect = True
    TabOrder = 0
    OnDblClick = suiTreeView1DblClick
    OnKeyDown = suiTreeView1KeyDown
  end
  object Button1: TButton
    Left = 146
    Top = 324
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 1
  end
  object Button2: TButton
    Left = 225
    Top = 324
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
end
