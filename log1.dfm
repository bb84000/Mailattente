object FLog: TFLog
  Left = 463
  Top = 233
  Width = 483
  Height = 640
  Caption = 'Journal'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object RichEdit1: TRichEdit
    Left = 0
    Top = 0
    Width = 467
    Height = 605
    Align = alClient
    Lines.Strings = (
      'RichEdit1')
    PopupMenu = PEdit
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 0
  end
  object PEdit: TPopupMenu
    Left = 128
    Top = 136
    object PMnuCopy: TMenuItem
      Caption = 'Copie'
      OnClick = PMnuCopyClick
    end
    object PMnuCopyAll: TMenuItem
      Caption = 'Copie tout'
      OnClick = PMnuCopyAllClick
    end
  end
end
