object FAccounts: TFAccounts
  Left = 791
  Top = 81
  BorderStyle = bsDialog
  Caption = 'Comptes'
  ClientHeight = 254
  ClientWidth = 671
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 213
    Width = 671
    Height = 41
    Align = alBottom
    TabOrder = 0
    object BtnOK: TBitBtn
      Left = 218
      Top = 8
      Width = 75
      Height = 25
      Caption = 'OK'
      ModalResult = 1
      TabOrder = 0
      Glyph.Data = {
        CE070000424DCE07000000000000360000002800000024000000120000000100
        18000000000098070000C40E0000C40E00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFFFFFFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FF800000800000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF808080808080FFFFFF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FF800000008000008000800000FF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        808080FF00FFFF00FF808080FFFFFFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF80000000800000800000800000
        8000800000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FF808080FF00FFFF00FFFF00FFFF00FF808080FFFFFFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF80000000
        8000008000008000008000008000008000800000FF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF808080FF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FF808080FFFFFFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FF80000000800000800000800000FF00008000008000008000008000
        800000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF808080FFFF
        FFFF00FFFF00FF808080FFFFFFFF00FFFF00FFFF00FF808080FFFFFFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FF00800000800000800000FF00FF00FF
        00FF00008000008000008000800000FF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FF808080FFFFFFFF00FF808080FF00FF808080FFFFFFFF00FFFF
        00FF808080FFFFFFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00FF00
        00800000FF00FF00FFFF00FFFF00FF00FF00008000008000008000800000FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF808080FFFFFF808080FF00FFFF
        00FFFF00FF808080FFFFFFFF00FFFF00FF808080FFFFFFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FF00FF00FF00FFFF00FFFF00FFFF00FFFF00FF00FF
        00008000008000008000800000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FF808080FF00FFFF00FFFF00FFFF00FFFF00FF808080FFFFFFFF00FFFF00FF
        808080FFFFFFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FF00FF00008000008000008000800000FF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF808080FFFFFFFF00FFFF00FF808080FFFFFFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00FF0000
        8000008000008000800000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF808080FFFFFFFF00FFFF00FF8080
        80FFFFFFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FF00FF00008000008000008000800000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FF808080FFFFFFFF00FFFF00FF808080FFFFFFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00FF00008000
        008000008000800000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FF808080FFFFFFFF00FFFF00FF808080FF
        FFFFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FF00FF00008000008000800000FF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF80
        8080FFFFFFFF00FF808080FFFFFFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00FF000080000080
        00FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FF808080FFFFFF808080FF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FF00FF00FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF808080
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      NumGlyphs = 2
    end
    object BtnCancel: TBitBtn
      Left = 303
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Annule'
      ModalResult = 2
      TabOrder = 1
      Glyph.Data = {
        CE070000424DCE07000000000000360000002800000024000000120000000100
        18000000000098070000C40E0000C40E00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF808080808080FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFFFFFFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0000FF0000
        80000080808080FF00FFFF00FFFF00FFFF00FFFF00FF0000FF808080FF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF808080808080FFFFFFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFFFFFFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FF0000FF000080000080000080808080FF00FFFF00FFFF00FF00
        00FF000080000080808080FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF808080
        FFFFFFFF00FF808080FFFFFFFF00FFFF00FFFF00FFFFFFFF808080808080FFFF
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0000FF00008000008000008000
        0080808080FF00FF0000FF000080000080000080000080808080FF00FFFF00FF
        FF00FFFF00FFFF00FF808080FFFFFFFF00FFFF00FF808080FFFFFFFF00FFFFFF
        FF808080FF00FFFF00FF808080FFFFFFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FF0000FF000080000080000080000080808080000080000080000080000080
        000080808080FF00FFFF00FFFF00FFFF00FFFF00FF808080FFFFFFFF00FFFF00
        FFFF00FF808080FFFFFF808080FF00FFFF00FFFF00FFFF00FF808080FFFFFFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FF0000FF000080000080000080000080
        000080000080000080000080808080FF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FF808080FFFFFFFF00FFFF00FFFF00FF808080FF00FFFF00FFFF00FFFF
        00FFFFFFFF808080FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        0000FF000080000080000080000080000080000080808080FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF808080FFFFFFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFFFFFF808080FF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FF0000800000800000800000800000808080
        80FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FF808080FFFFFFFF00FFFF00FFFF00FFFF00FFFF00FF808080FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0000FF0000
        80000080000080000080808080FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FF808080FFFFFFFF00FFFF00FFFF00FF
        808080FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FF0000FF000080000080000080000080000080808080FF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF808080
        FF00FFFF00FFFF00FFFF00FF808080FFFFFFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FF0000FF00008000008000008080808000008000
        0080000080808080FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FF808080FF00FFFF00FFFF00FFFF00FFFF00FF808080FFFFFFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0000FF00008000008000
        0080808080FF00FF0000FF000080000080000080808080FF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FF808080FF00FFFF00FFFF00FF808080FFFF
        FFFF00FFFF00FF808080FFFFFFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FF0000FF000080000080808080FF00FFFF00FFFF00FF0000FF000080000080
        000080808080FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF808080FFFFFFFF00
        FFFF00FF808080FF00FF808080FFFFFFFF00FFFF00FF808080FFFFFFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FF0000FF000080FF00FFFF00FFFF00FF
        FF00FFFF00FF0000FF000080000080000080FF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FF808080FFFFFFFFFFFF808080FF00FFFF00FFFF00FF808080FFFFFFFF
        00FFFF00FF808080FFFFFFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0000FF0000800000FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF808080808080FF00FFFF00FFFF
        00FFFF00FFFF00FF808080FFFFFFFFFFFFFFFFFF808080FF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF808080808080808080
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      NumGlyphs = 2
    end
    object BtnAdd: TBitBtn
      Left = 133
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Ajoute'
      ModalResult = 6
      TabOrder = 2
      Glyph.Data = {
        36060000424D3606000000000000360000002800000020000000100000000100
        18000000000000060000130B0000130B00000000000000000000FF00FFFF00FF
        FF00FF000000000000000000000000000000BA4715BA4715BA4715D4AB97FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9A9A9A9A9A9A9A9A9A9A9A9A9A
        9A9A9A9A9A9A9A9A9A9A9A9A9A9AFFFFFFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF00000000FF0000800000FF00000000FD6655FD6655F3654EBA4715E055
        37CE522DCD947AFF00FFFF00FFFF00FFFF00FF9A9A9AFFFFFFFF00FFFF00FF9A
        9A9AFF00FFFF00FFFF00FF9A9A9A9A9A9A9A9A9AFFFFFFFF00FFFF00FFFF00FF
        FF00FF00000000FF0000FF0000FF00000000FD7A62FD8066CD6133DC9E6CEA66
        48FD6856DC5333D09F88FF00FFFF00FFFF00FF9A9A9AFF00FFFF00FFFF00FF9A
        9A9AFFFFFFFF00FFFFFFFFFF00FFFF00FFFF00FF9A9A9AFF00FF000000000000
        00000000000000FF0000FF0000FF00000000000000000000000000FAD7A5D75E
        36FD7A62FB6552CD6B469A9A9A9A9A9A9A9A9A9A9A9AFFFFFFFF00FFFF00FF9A
        9A9A9A9A9A9A9A9A9A9A9AFFFFFFFF00FFFF00FFFF00FF9A9A9A00000000FF00
        00FF0000FF0000FF0000FF0000800000FF0000FF0000FF00000000FFD3A0D26D
        3EFD8268F36A51CD6B469A9A9AFFFFFFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FF9A9A9AFF00FFFF00FFFF00FFFF00FF9A9A9A00000000FF00
        00800000FF0000FF0000FF0000FF0000FF0000800000FF00000000DFA78BD772
        44F48161CA6843FF00FF9A9A9AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FF9A9A9AFFFFFFFF00FFFF00FF9A9A9AFF00FF00000000FF00
        00FF0000FF0000FF0000800000FF0000FF0000FF0000FF00000000040B717834
        3FCD957BFF00FFFF00FF9A9A9AFFFFFFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FF9A9A9A9A9A9AFF00FF9A9A9AFF00FFFF00FF000000000000
        00000000000000FF0000FF0000FF00000000000000000000000000153BA0061C
        7CFF00FFFF00FFFF00FF9A9A9A9A9A9A9A9A9A9A9A9AFFFFFFFF00FFFF00FF9A
        9A9A9A9A9A9A9A9A9A9A9AFF00FF9A9A9AFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF00000000FF0000800000FF000000001B4EB31B4EB31B4EB31B4EB31644
        A76779AAFF00FFFF00FFFF00FFFF00FFFF00FF9A9A9AFF00FFFF00FFFF00FF9A
        9A9AFF00FFFF00FFFF00FF9A9A9AFF00FF9A9A9AFF00FFFF00FFFF00FFFF00FF
        FF00FF00000000FF0000FF0000FF000000002366CB256DD22774D9256DD22161
        C63F5E9FFF00FFFF00FFFF00FFFF00FFFF00FF9A9A9AFFFFFFFF00FFFF00FF9A
        9A9AFF00FFFF00FFFF00FFFF00FF9A9A9A9A9A9AFF00FFFF00FFFF00FFFF00FF
        FF00FF0000000000000000000000000000002774D92A7EE32A7EE3297BE02774
        D90B4496FF00FFFF00FFFF00FFFF00FFFF00FF9A9A9A9A9A9A9A9A9A9A9A9A9A
        9A9AFF00FFFF00FFFF00FFFF00FFFF00FF9A9A9AFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FF484A4A3434343B3B3B131C293294FA3499FF379CFF359AFF3190
        F62862A9FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9A9A9A9A9A9AFF00FF9A
        9A9AFFFFFFFF00FFFF00FFFF00FFFF00FF9A9A9AFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FF7579793636364E4E4E3B3B3B182746153D7F2469D43084EE2F87
        E94A6987FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9A9A9AFFFFFF9A9A9AFF
        00FF9A9A9AFF00FFFF00FFFF00FFFF00FF9A9A9AFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FF2828284B4B4B5E5E5E7E7E7E838383393939181E420E0F
        18949797FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9A9A9AFF00FF9A
        9A9AFF00FFFF00FF9A9A9AFF00FF9A9A9A9A9A9AFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FF2121216F6F6F8A8A8A9898989A9A9A5F5F5F3B3C
        3CFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9A9A9AFF
        FFFFFF00FF9A9A9AFFFFFFFF00FF9A9A9AFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FF4B4C4C4949494646463333335F6160FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9A
        9A9A9A9A9A9A9A9A9A9A9A9A9A9AFF00FFFF00FFFF00FFFF00FF}
      NumGlyphs = 2
    end
    object BtnApply: TBitBtn
      Left = 388
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Applique'
      TabOrder = 3
      OnClick = BtnApplyClick
      Glyph.Data = {
        36060000424D3606000000000000360000002800000020000000100000000100
        18000000000000060000C40E0000C40E00000000000000000000FF00FFFF00FF
        FF00FFFF00FF007F004B4B4BFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9A9A9A9A9A9AFFFFFFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FF007F0000BF2A4B4B4BFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9A9A9AFFFFFF9A9A9AFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FF007F0000DF0000BF2A4B4B4BFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9A9A9AFF00FFFF00FF9A
        9A9AFFFFFFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FF007F0000DF0000DF0000BF2A4B4B4BFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9A9A9AFFFFFFFF00FFFF
        00FF9A9A9AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FF007F0000DF0000DF0000DF0000BF2A4B4B4BFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9A9A9AFF00FFFF00FFFF
        00FFFF00FF9A9A9AFFFFFFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FF007F0000DF0000FF0900DF0000DF0000BF2A4B4B4BFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9A9A9AFFFFFFFF00FFFF
        00FFFF00FFFF00FF9A9A9AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FF007F0000FF2A00DF0000FF0900DF0000DF0000BF2A4B4B4BFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9A9A9AFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FF9A9A9AFFFFFFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FF007F0055FF0000FF2A00DF0000FF0900DF0000DF0000BF2A4B4B
        4BFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9A9A9AFFFFFFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FF9A9A9AFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FF007F0055FFAA00FF0900FF2A00DF0000FF0900DF0000DF00007F
        00FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9A9A9AFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FF9A9A9AFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FF007F0055FFAA00FF0900FF0900FF2A00DF0055FFAA007F00FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9A9A9AFFFFFFFF00FFFF
        00FFFF00FFFF00FFFF00FF9A9A9AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FF007F00AAFF2A00FF0900FF0900FF0900FF2A007F00FF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9A9A9AFF00FFFF00FFFF
        00FFFF00FFFF00FF9A9A9AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FF007F00AAFF2A00FF0900FF09AAFF2A007F00FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9A9A9AFFFFFFFF00FFFF
        00FFFF00FF9A9A9AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FF007F00AAFFAA00FF09AAFF2A007F00FF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9A9A9AFF00FFFF00FFFF
        00FF9A9A9AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FF007F00AAFFAAAAFFAA007F00FF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9A9A9AFFFFFFFF00FF9A
        9A9AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FF007F00AAFFAA007F00FF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9A9A9AFF00FF9A9A9AFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FF007F00007F00FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9A9A9A9A9A9AFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      NumGlyphs = 2
    end
    object BtnDel: TBitBtn
      Left = 473
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Efface'
      ModalResult = 7
      TabOrder = 4
      Glyph.Data = {
        36060000424D3606000000000000360000002800000020000000100000000100
        18000000000000060000130B0000130B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFBA4715BA4715BA4715BA4715BA4715D4AB97FF00
        FFFF00FF0005B70005B7FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9A9A9A9A
        9A9A9A9A9A9A9A9A9A9A9A9A9A9AFFFFFFFF00FF9A9A9A9A9A9AFF00FF0005B7
        0005B7FF00FFD09F88BD4012D54E2BED5D44FD6655FD6655F3654EBA4715E055
        370005B70005B7FF00FFFF00FF9A9A9A9A9A9AFF00FF9A9A9A9A9A9AFF00FFFF
        00FFFF00FFFF00FFFF00FF9A9A9A9A9A9A9A9A9AFF00FFFF00FFFF00FF0005B7
        0005B70005B7CD947AD44D2AF6624DFD6957FD7A62FD8066CD6133DC9E6C0005
        B70005B7DC5333D09F88FF00FF9A9A9AFF00FF9A9A9A9A9A9AFFFFFFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FF9A9A9AFF00FF9A9A9AFF00FFFF00FF0005B7
        0005B60005B70005B7DC5333FD6856FD7D64FE8C6FDC6F45EBB4810005B70005
        B7FD7A62FB6552CD6B46FF00FF9A9A9AFFFFFFFF00FF9A9A9AFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FF9A9A9AFFFFFFFF00FFFF00FF9A9A9AFF00FFFF00FF
        0006D70005BA0005B70005B7F87058FD856AEF8661D37B470005B70005B7D26D
        3EFD8268F36A51CD6B46FF00FFFF00FF9A9A9A9A9A9AFFFFFF9A9A9AFFFFFFFF
        00FFFF00FFFF00FF9A9A9AFF00FFFF00FFFF00FFFF00FF9A9A9AFF00FFFF00FF
        FF00FFFF00FF0005B70005B70005B6E5714D0005B60005B70005B7DFA78BD772
        44F48161CA6843FF00FFFF00FFFF00FFFF00FFFF00FF9A9A9AFFFFFF9A9A9AFF
        00FF9A9A9A9A9A9AFFFFFFFF00FFFF00FFFF00FF9A9A9AFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FF0005B60006C70006C70006CE0005B40A1B81040B717834
        3FCD957BFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9A9A9A9A9A9A9A
        9A9A9A9A9AFFFFFF9A9A9A9A9A9AFF00FF9A9A9AFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FF2D2E2E0006C10005C10006DA143897153BA0153BA0061C
        7CFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9A9A9AFF00FFFF
        00FFFF00FF9A9A9A9A9A9AFF00FF9A9A9AFFFFFFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FF676B6A0005B60006D70006CE0006DA0006E91B4EB31B4EB31644
        A76779AAFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9A9A9AFFFFFFFF00FF9A
        9A9A9A9A9AFFFFFFFF00FF9A9A9AFF00FF9A9A9AFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FF0006E50006DA0006D31336762366CB0006E50006EF256DD22161
        C63F5E9FFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9A9A9AFF00FFFF00FF9A
        9A9AFF00FF9A9A9AFF00FFFF00FF9A9A9A9A9A9AFFFFFFFF00FFFF00FFFF00FF
        FF00FF0006F80006DA0006EF343434143B6E2774D92A7EE30006F80006F62774
        D90B4496FF00FFFF00FFFF00FFFF00FFFF00FF9A9A9AFFFFFFFF00FF9A9A9A9A
        9A9AFF00FFFF00FF9A9A9AFFFFFFFF00FF9A9A9AFF00FFFF00FFFF00FFFF00FF
        0006F60006F60006F83434343B3B3B131C293294FA3499FF379CFF0006F60006
        F62862A9FF00FFFF00FFFF00FFFF00FF9A9A9AFF00FF9A9A9A9A9A9AFF00FF9A
        9A9AFFFFFFFF00FFFF00FF9A9A9A9A9A9A9A9A9AFFFFFFFF00FFFF00FF0006F6
        0006F60006F67579793636364E4E4E3B3B3B182746153D7F2469D43084EE2F87
        E90006F6FF00FFFF00FFFF00FF9A9A9AFFFFFF9A9A9A9A9A9AFFFFFF9A9A9AFF
        00FF9A9A9AFF00FFFF00FFFF00FFFF00FF9A9A9AFF00FFFF00FF0006F60006F6
        0006F6FF00FFFF00FF2828284B4B4B5E5E5E7E7E7E838383393939181E420E0F
        18949797FF00FFFF00FF9A9A9AFF00FF9A9A9AFF00FFFF00FF9A9A9AFF00FF9A
        9A9AFF00FFFF00FF9A9A9AFF00FF9A9A9A9A9A9AFFFFFFFF00FF0006F60006F6
        FF00FFFF00FFFF00FFFF00FF2121216F6F6F8A8A8A9898989A9A9A5F5F5F3B3C
        3CFF00FFFF00FFFF00FF9A9A9A9A9A9AFF00FFFF00FFFF00FFFF00FF9A9A9AFF
        FFFFFF00FF9A9A9AFFFFFFFF00FF9A9A9AFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FF4B4C4C4949494646463333335F6160FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9A
        9A9A9A9A9A9A9A9A9A9A9A9A9A9AFF00FFFF00FFFF00FFFF00FF}
      NumGlyphs = 2
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 671
    Height = 213
    Align = alClient
    TabOrder = 1
    object BtnMailClient: TSpeedButton
      Left = 636
      Top = 160
      Width = 25
      Height = 22
      Glyph.Data = {
        36060000424D3606000000000000360000002800000020000000100000000100
        18000000000000060000C40E0000C40E00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF8F6E1CFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF1DFFFF1DFFFF1DFFFF1DFFFF1DFFFF1DFFFF1DFFFF
        1DFFFF1DFF848484FF1DFFFF1DFFFF1DFFFF1DFFFF1DFFFF1DFFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF816100FF9F2A8F6F1DFF00FFFF00
        FFFF00FFFF00FFFF00FFFF1DFFFF1DFFFF1DFFFF1DFFFF1DFFFF1DFFFF1DFFFF
        1DFF7C7C7C959595848484FF1DFFFF1DFFFF1DFFFF1DFFFF1DFFA8A8A8737373
        553F2A553F2A3D3D3D3D3D3DB4B4B4806100FF9F2AD9A77DFF9F2A8F6F1C7373
        737474743D3D3DA7A7A7A3A3A38F8F8F777777777777787878787878A9A9A97C
        7C7C959595A0A0A09595958484848F8F8F8F8F8F787878A3A3A3919191A9FFFF
        99F8FF99F8FF55DFFF55BFD3806100D9A77DD9A77DD9A77DD9A77DFF9F2A8F6F
        1D55DFFF55C0D43D3D3D9A9A9AC4C4C4C1C1C1C1C1C1B8B8B8AAAAAA7C7C7CA0
        A0A0A0A0A0A0A0A0A0A0A0959595848484B8B8B8ABABAB787878919191A9FFFF
        A9FFFFA9FFFFA9FFFF806100D9A77DFFFFC3FFFFC3D9A77DD9A77DD9A77DFF9F
        2A8F6F1D55DFFF3D3D3D9A9A9AC4C4C4C4C4C4C4C4C4C4C4C47C7C7CA0A0A0C1
        C1C1C1C1C1A0A0A0A0A0A0A0A0A0959595848484B8B8B8787878919191A9FFFF
        A9FFFFA9FFFFE1BE788F6F1C8F6F1C8F6E1CFFFFC3FFFFC4D9A77D8F6F1D8F6F
        1C8F6F1CE1BE787373739A9A9AC4C4C4C4C4C4C4C4C4A6A6A684848484848484
        8484C1C1C1C1C1C1A0A0A0848484848484848484A6A6A68F8F8F909090A9FFFF
        A9FFFFA9FFFFA9FFFFA9FFFFA9FFFF9D7C30FFFFC3FFFFC3FFF1AB9D7C30B4B4
        B499F8FF55DFFF3D3D3D999999C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C48A
        8A8AC1C1C1C1C1C1BABABA8A8A8AA9A9A9C1C1C1B8B8B8787878919191D8E9EC
        A9FFFFA9FFFFA9FFFFA9FFFFA9FFFFAB8A40FFFFC3FFFFC3D9A77DFBD79198F7
        FF55DFFFAADFD53D3D3D9A9A9ABEBEBEC4C4C4C4C4C4C4C4C4C4C4C4C4C4C490
        9090C1C1C1C1C1C1A0A0A0B0B0B0C1C1C1B8B8B8B7B7B7787878919191A9FFFF
        A9FFFFA9FFFFA9FFFFA9FFFFB9974FD9A77DFFF0AAFFFFC3AB8A4099F7FF99F7
        FF99F8FF55DFFF5959599A9A9AC4C4C4C4C4C4C4C4C4C4C4C4C4C4C4959595A0
        A0A0BABABAC1C1C1909090C1C1C1C1C1C1C1C1C1B8B8B8848484A8A8A8D8E9EC
        A9FFFFD8E9ECA9FFFFA8FEFFB9974EFFE49EFFF0AAE1BE77FBD790A9FFFFA9FF
        FFA9FFFFA9FFFF666666A3A3A3BEBEBEC4C4C4BEBEBEC4C4C4C3C3C3959595B5
        B5B5BABABAA5A5A5B0B0B0C4C4C4C4C4C4C4C4C4C4C4C4898989B4B4B4A9FFFF
        D8E9ECA9FFFFA8FEFFAB893FD9A77DFBD790E1BE78A9FFFFA9FFFFA9FFFFA9FF
        FFA9FFFFA9FFFF737373A9A9A9C4C4C4BEBEBEC4C4C4C3C3C3909090A0A0A0B0
        B0B0A6A6A6C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C48F8F8FC1C1C1D8E9EC
        A9FFFFD8E9ECD4B16AD4B26BD4B26BD4B26BEECB84C6C6C6C6C6C6AADFD555BF
        D354BFD355BFD3818181AEAEAEBEBEBEC4C4C4BEBEBEA0A0A0A0A0A0A0A0A0A0
        A0A0ABABABB0B0B0B0B0B0B7B7B7AAAAAAAAAAAAAAAAAA939393CCCCCCB5B5B5
        B4B4B4B4B4B4CBCBCBAADFD5AADFD555DFFF55DFFF55DFFF55DFFF55DFFF55DF
        FF55DFFF54BFD3C1C1C1B2B2B2A9A9A9A9A9A9A9A9A9B2B2B2B7B7B7B7B7B7B8
        B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8AAAAAAAEAEAEFF00FFDADADA
        00F2FF00F2FF00F1FF00F1FF55BFD3E6E6E68D8D8D8D8D8D8D8D8D8D8D8D8D8D
        8D8D8D8D8D8D8DFF00FFFF1DFFB8B8B8B8B8B8B8B8B8B8B8B8B8B8B8AAAAAABE
        BEBE989898989898989898989898989898989898989898FF1DFFFF00FF9B9B9B
        54FFFF67F4FF67F4FF67F4FF00F1FFB4B4B4FF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF1DFF9E9E9EC0C0C0BEBEBEBEBEBEBEBEBEB8B8B8A9
        A9A9FF1DFFFF1DFFFF1DFFFF1DFFFF1DFFFF1DFFFF1DFFFF1DFFFF00FFFF00FF
        9B9B9B8D8D8D8D8D8D8D8D8D9B9B9BFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF1DFFFF1DFF9E9E9E9898989898989898989E9E9EFF
        1DFFFF1DFFFF1DFFFF1DFFFF1DFFFF1DFFFF1DFFFF1DFFFF1DFF}
      Layout = blGlyphRight
      NumGlyphs = 2
      OnClick = BtnMailClientClick
    end
    object SBSound: TSpeedButton
      Left = 636
      Top = 184
      Width = 25
      Height = 22
      Glyph.Data = {
        36060000424D3606000000000000360000002800000020000000100000000100
        18000000000000060000C40E0000C40E00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF8F6E1CFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF1DFFFF1DFFFF1DFFFF1DFFFF1DFFFF1DFFFF1DFFFF
        1DFFFF1DFF848484FF1DFFFF1DFFFF1DFFFF1DFFFF1DFFFF1DFFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF816100FF9F2A8F6F1DFF00FFFF00
        FFFF00FFFF00FFFF00FFFF1DFFFF1DFFFF1DFFFF1DFFFF1DFFFF1DFFFF1DFFFF
        1DFF7C7C7C959595848484FF1DFFFF1DFFFF1DFFFF1DFFFF1DFFA8A8A8737373
        553F2A553F2A3D3D3D3D3D3DB4B4B4806100FF9F2AD9A77DFF9F2A8F6F1C7373
        737474743D3D3DA7A7A7A3A3A38F8F8F777777777777787878787878A9A9A97C
        7C7C959595A0A0A09595958484848F8F8F8F8F8F787878A3A3A3919191A9FFFF
        99F8FF99F8FF55DFFF55BFD3806100D9A77DD9A77DD9A77DD9A77DFF9F2A8F6F
        1D55DFFF55C0D43D3D3D9A9A9AC4C4C4C1C1C1C1C1C1B8B8B8AAAAAA7C7C7CA0
        A0A0A0A0A0A0A0A0A0A0A0959595848484B8B8B8ABABAB787878919191A9FFFF
        A9FFFFA9FFFFA9FFFF806100D9A77DFFFFC3FFFFC3D9A77DD9A77DD9A77DFF9F
        2A8F6F1D55DFFF3D3D3D9A9A9AC4C4C4C4C4C4C4C4C4C4C4C47C7C7CA0A0A0C1
        C1C1C1C1C1A0A0A0A0A0A0A0A0A0959595848484B8B8B8787878919191A9FFFF
        A9FFFFA9FFFFE1BE788F6F1C8F6F1C8F6E1CFFFFC3FFFFC4D9A77D8F6F1D8F6F
        1C8F6F1CE1BE787373739A9A9AC4C4C4C4C4C4C4C4C4A6A6A684848484848484
        8484C1C1C1C1C1C1A0A0A0848484848484848484A6A6A68F8F8F909090A9FFFF
        A9FFFFA9FFFFA9FFFFA9FFFFA9FFFF9D7C30FFFFC3FFFFC3FFF1AB9D7C30B4B4
        B499F8FF55DFFF3D3D3D999999C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C48A
        8A8AC1C1C1C1C1C1BABABA8A8A8AA9A9A9C1C1C1B8B8B8787878919191D8E9EC
        A9FFFFA9FFFFA9FFFFA9FFFFA9FFFFAB8A40FFFFC3FFFFC3D9A77DFBD79198F7
        FF55DFFFAADFD53D3D3D9A9A9ABEBEBEC4C4C4C4C4C4C4C4C4C4C4C4C4C4C490
        9090C1C1C1C1C1C1A0A0A0B0B0B0C1C1C1B8B8B8B7B7B7787878919191A9FFFF
        A9FFFFA9FFFFA9FFFFA9FFFFB9974FD9A77DFFF0AAFFFFC3AB8A4099F7FF99F7
        FF99F8FF55DFFF5959599A9A9AC4C4C4C4C4C4C4C4C4C4C4C4C4C4C4959595A0
        A0A0BABABAC1C1C1909090C1C1C1C1C1C1C1C1C1B8B8B8848484A8A8A8D8E9EC
        A9FFFFD8E9ECA9FFFFA8FEFFB9974EFFE49EFFF0AAE1BE77FBD790A9FFFFA9FF
        FFA9FFFFA9FFFF666666A3A3A3BEBEBEC4C4C4BEBEBEC4C4C4C3C3C3959595B5
        B5B5BABABAA5A5A5B0B0B0C4C4C4C4C4C4C4C4C4C4C4C4898989B4B4B4A9FFFF
        D8E9ECA9FFFFA8FEFFAB893FD9A77DFBD790E1BE78A9FFFFA9FFFFA9FFFFA9FF
        FFA9FFFFA9FFFF737373A9A9A9C4C4C4BEBEBEC4C4C4C3C3C3909090A0A0A0B0
        B0B0A6A6A6C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C4C48F8F8FC1C1C1D8E9EC
        A9FFFFD8E9ECD4B16AD4B26BD4B26BD4B26BEECB84C6C6C6C6C6C6AADFD555BF
        D354BFD355BFD3818181AEAEAEBEBEBEC4C4C4BEBEBEA0A0A0A0A0A0A0A0A0A0
        A0A0ABABABB0B0B0B0B0B0B7B7B7AAAAAAAAAAAAAAAAAA939393CCCCCCB5B5B5
        B4B4B4B4B4B4CBCBCBAADFD5AADFD555DFFF55DFFF55DFFF55DFFF55DFFF55DF
        FF55DFFF54BFD3C1C1C1B2B2B2A9A9A9A9A9A9A9A9A9B2B2B2B7B7B7B7B7B7B8
        B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8B8AAAAAAAEAEAEFF00FFDADADA
        00F2FF00F2FF00F1FF00F1FF55BFD3E6E6E68D8D8D8D8D8D8D8D8D8D8D8D8D8D
        8D8D8D8D8D8D8DFF00FFFF1DFFB8B8B8B8B8B8B8B8B8B8B8B8B8B8B8AAAAAABE
        BEBE989898989898989898989898989898989898989898FF1DFFFF00FF9B9B9B
        54FFFF67F4FF67F4FF67F4FF00F1FFB4B4B4FF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF1DFF9E9E9EC0C0C0BEBEBEBEBEBEBEBEBEB8B8B8A9
        A9A9FF1DFFFF1DFFFF1DFFFF1DFFFF1DFFFF1DFFFF1DFFFF1DFFFF00FFFF00FF
        9B9B9B8D8D8D8D8D8D8D8D8D9B9B9BFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF1DFFFF1DFF9E9E9E9898989898989898989E9E9EFF
        1DFFFF1DFFFF1DFFFF1DFFFF1DFFFF1DFFFF1DFFFF1DFFFF1DFF}
      Layout = blGlyphRight
      NumGlyphs = 2
      OnClick = SBSoundClick
    end
    object LMin: TLabel
      Left = 600
      Top = 142
      Width = 37
      Height = 13
      Caption = 'Minutes'
    end
    object LInterval: TLabel
      Left = 418
      Top = 142
      Width = 43
      Height = 13
      Caption = 'Intervalle'
    end
    object LPass: TLabel
      Left = 418
      Top = 92
      Width = 46
      Height = 13
      Caption = 'Password'
    end
    object LPort: TLabel
      Left = 418
      Top = 44
      Width = 19
      Height = 13
      Caption = 'Port'
    end
    object LAccName: TLabel
      Left = 173
      Top = 20
      Width = 22
      Height = 13
      Caption = 'Nom'
    end
    object LHost: TLabel
      Left = 173
      Top = 44
      Width = 37
      Height = 13
      Caption = 'Serveur'
    end
    object LProt: TLabel
      Left = 173
      Top = 68
      Width = 45
      Height = 13
      Caption = 'Protocole'
    end
    object LUser: TLabel
      Left = 173
      Top = 92
      Width = 67
      Height = 13
      Caption = 'Identifiant mail'
    end
    object LColor: TLabel
      Left = 173
      Top = 142
      Width = 36
      Height = 13
      Caption = 'Couleur'
    end
    object LMailCli: TLabel
      Left = 173
      Top = 166
      Width = 47
      Height = 13
      Caption = 'Client mail'
    end
    object Lsound: TLabel
      Left = 173
      Top = 190
      Width = 19
      Height = 13
      Caption = 'Son'
    end
    object LSSL: TLabel
      Left = 418
      Top = 20
      Width = 20
      Height = 13
      Caption = 'SSL'
    end
    object SBTest: TSpeedButton
      Left = 608
      Top = 184
      Width = 23
      Height = 22
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        33333333333333333333F777777777777773F777777777777773F33333333333
        3373F333333333333373F300333333333373F377333333333373F30000333333
        3373F377773333333373F300000033333373F377777733333373F30000000033
        3373F377777777333373F300000000003373F377777777773373F30000000000
        0373F377777777777373F300000000003373F377777777773373F30000000033
        3373F377777777333373F300000033333373F377777733333373F30000333333
        3373F377773333333373F300333333333373F377333333333373F33333333333
        3373F333333333333373FFFFFFFFFFFFFFF3FFFFFFFFFFFFFFF3}
      NumGlyphs = 2
      OnClick = SBTestClick
    end
    object LEmail: TLabel
      Left = 173
      Top = 116
      Width = 62
      Height = 13
      Caption = 'Adresse mail '
    end
    object LReply: TLabel
      Left = 418
      Top = 116
      Width = 94
      Height = 13
      Caption = 'Adresse de r'#233'ponse'
    end
    object CBActiveAcc: TCheckBox
      Left = 8
      Top = 166
      Width = 92
      Height = 17
      Caption = 'Compte actif'
      TabOrder = 0
      OnClick = AccountsChange
    end
    object EPort: TEdit
      Left = 514
      Top = 40
      Width = 147
      Height = 21
      TabOrder = 1
      OnChange = AccountsChange
    end
    object CBAuth: TCheckBox
      Left = 418
      Top = 64
      Width = 148
      Height = 17
      Alignment = taLeftJustify
      Caption = 'Authentification s'#233'curis'#233'e'
      TabOrder = 2
      OnClick = AccountsChange
    end
    object EPass: TEdit
      Left = 514
      Top = 88
      Width = 147
      Height = 21
      PasswordChar = '*'
      TabOrder = 3
      OnChange = AccountsChange
    end
    object EMailCli: TEdit
      Left = 265
      Top = 160
      Width = 368
      Height = 21
      TabOrder = 4
      OnChange = AccountsChange
    end
    object ESound: TEdit
      Left = 265
      Top = 184
      Width = 344
      Height = 21
      TabOrder = 5
      OnChange = AccountsChange
    end
    object EName: TEdit
      Left = 265
      Top = 16
      Width = 147
      Height = 21
      TabOrder = 6
      OnChange = AccountsChange
    end
    object EServer: TEdit
      Left = 265
      Top = 40
      Width = 147
      Height = 21
      TabOrder = 7
      OnChange = AccountsChange
    end
    object EProt: TEdit
      Left = 265
      Top = 64
      Width = 147
      Height = 21
      TabOrder = 8
    end
    object EUser: TEdit
      Left = 265
      Top = 88
      Width = 147
      Height = 21
      TabOrder = 9
      OnChange = AccountsChange
    end
    object CBColorAcc: TColorBox
      Left = 265
      Top = 136
      Width = 147
      Height = 22
      NoneColorColor = clFuchsia
      Style = [cbStandardColors, cbExtendedColors]
      ItemHeight = 16
      TabOrder = 10
      OnChange = CBColorAccChange
    end
    object LVPrefAccs: TListView
      Left = 8
      Top = 16
      Width = 153
      Height = 145
      Columns = <
        item
          AutoSize = True
        end>
      IconOptions.WrapText = False
      ReadOnly = True
      PopupMenu = PMnuAcc
      ShowColumnHeaders = False
      TabOrder = 11
      ViewStyle = vsReport
      OnClick = LVPrefAccsClick
      OnKeyDown = LVPrefAccsKeyDown
    end
    object CBSSL: TComboBox
      Left = 514
      Top = 16
      Width = 147
      Height = 21
      ItemHeight = 13
      TabOrder = 12
      OnChange = AccountsChange
      Items.Strings = (
        'Aucun'
        'Implicite (Connexion TLS)'
        'Explicite (STLS)')
    end
    object EInterval: TSpinEdit
      Left = 514
      Top = 136
      Width = 73
      Height = 22
      Hint = 'Entrez 0 pour d'#233'sactiver la v'#233'rification automatique'
      MaxValue = 0
      MinValue = 0
      ParentShowHint = False
      ShowHint = True
      TabOrder = 13
      Value = 0
      OnChange = AccountsChange
    end
    object EEmail: TEdit
      Left = 265
      Top = 112
      Width = 147
      Height = 21
      TabOrder = 14
      OnChange = AccountsChange
    end
    object EReplyEmail: TEdit
      Left = 514
      Top = 112
      Width = 147
      Height = 21
      TabOrder = 15
      OnChange = AccountsChange
    end
  end
  object PMnuAcc: TPopupMenu
    OnPopup = PMnuAccPopup
    Left = 72
    Top = 88
    object PMnuAccsH: TMenuItem
      Bitmap.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        04000000000080000000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333000333
        33333333330E033333333333330E033333333333330E033333333333330E0333
        33333333330E033333333330000E000033333330EEEEEEE0333333330EEEEE03
        333333330EEEEE033333333330EEE0333333333330EEE03333333333330E0333
        33333333330E0333333333333330333333333333333033333333}
      Caption = 'D'#233'placer vers le haut'
      OnClick = PMnuAccsClick
    end
    object PMnuAccsB: TMenuItem
      Bitmap.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        04000000000080000000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333303333
        333333333330333333333333330E033333333333330E03333333333330EEE033
        3333333330EEE033333333330EEEEE03333333330EEEEE0333333330EEEEEEE0
        33333330000E000033333333330E033333333333330E033333333333330E0333
        33333333330E033333333333330E033333333333330003333333}
      Caption = 'D'#233'placer vers le bas'
      OnClick = PMnuAccsClick
    end
    object PMnuAccsD: TMenuItem
      Bitmap.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000130B0000130B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFBA4715BA4715BA4715BA4715BA4715D4AB97FF00
        FFFF00FF0005B70005B7FF00FF0005B70005B7FF00FFD09F88BD4012D54E2BED
        5D44FD6655FD6655F3654EBA4715E055370005B70005B7FF00FFFF00FF0005B7
        0005B70005B7CD947AD44D2AF6624DFD6957FD7A62FD8066CD6133DC9E6C0005
        B70005B7DC5333D09F88FF00FF0005B70005B60005B70005B7DC5333FD6856FD
        7D64FE8C6FDC6F45EBB4810005B70005B7FD7A62FB6552CD6B46FF00FFFF00FF
        0006D70005BA0005B70005B7F87058FD856AEF8661D37B470005B70005B7D26D
        3EFD8268F36A51CD6B46FF00FFFF00FFFF00FFFF00FF0005B70005B70005B6E5
        714D0005B60005B70005B7DFA78BD77244F48161CA6843FF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FF0005B60006C70006C70006CE0005B40A1B81040B717834
        3FCD957BFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF2D2E2E0006C100
        05C10006DA143897153BA0153BA0061C7CFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FF676B6A0005B60006D70006CE0006DA0006E91B4EB31B4EB31644
        A76779AAFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0006E50006DA0006D313
        36762366CB0006E50006EF256DD22161C63F5E9FFF00FFFF00FFFF00FFFF00FF
        FF00FF0006F80006DA0006EF343434143B6E2774D92A7EE30006F80006F62774
        D90B4496FF00FFFF00FFFF00FFFF00FF0006F60006F60006F83434343B3B3B13
        1C293294FA3499FF379CFF0006F60006F62862A9FF00FFFF00FFFF00FF0006F6
        0006F60006F67579793636364E4E4E3B3B3B182746153D7F2469D43084EE2F87
        E90006F6FF00FFFF00FF0006F60006F60006F6FF00FFFF00FF2828284B4B4B5E
        5E5E7E7E7E838383393939181E420E0F18949797FF00FFFF00FF0006F60006F6
        FF00FFFF00FFFF00FFFF00FF2121216F6F6F8A8A8A9898989A9A9A5F5F5F3B3C
        3CFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF4B
        4C4C4949494646463333335F6160FF00FFFF00FFFF00FFFF00FF}
      Caption = 'Efface'
      OnClick = PMnuAccsClick
    end
  end
end
